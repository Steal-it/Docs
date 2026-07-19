= Implementation <ch4>

/*
Describe your implementation by addressing the following:
• Which parts of your system have you implemented?
• How did you implement each component?
• What tools did you use?
• Which libraries, assets, or external code did you incorporate?
• What aspects of your design proved particularly interesting from an implementation standpoint?
• What optimizations did you perform?
You may reference code snippets from the Appendix throughout this section.
*/

== Game startup process

When a player connects to a room, it is prompted with two buttons. A particular behavior that needs to be described is the "Ready" button.

Firstly, when the player joins a new room, `MessageHandler` is notified since it is subscribed to a particular event of Ubiq that is fired when the user connects to a new room. After a 100 ms delay that allows Ubiq to update the internal peer list, `MessageHandler` checks if the room is empty, if not, it sends a message to recover how many people in the room already pressed the button, which is memorized in a counter into each message handler. The function snippet has been reported in @onjoinedroomhandler. Every peer already in the room proceeds to answer with the internal counter and the requester updates its current ready counter with the higher value.

With the initial process finished, the user can signal other users when it is ready by pressing the ready button, which causes all currently connected peers under the same room to increment the ready counter by one. When the ready counter matches the number of peers in the room an event, listened to by `LevelManager`, is fired, and this causes all players currently in the room to be moved to the actual level map.

== Avatar spawning

== Map Configuration

In the context of a demo application, the lobbies and the actual game live in the same scene, avoiding issues that derive from a scene switch. For this reason, since the map remains the same in each gameplay, we implemented different configurations not to let the players memorize the obstacles and targets. In each `MapConfiguration`, the position and rotation of the following assets are specified.

- *players spawn point* - for now, an entry room is set up, so the spawn point must always be there, but in the future it will be possible to let the players spawn in different parts of the map;

- *monster spawn point* - where the monster initially spawns;

- *keys* - the position of the keys used to unlock the final door and escape the maze.

When all players are ready to play, a random configuration is selected and loaded. To avoid that one client chooses the setup and notifies it, every client locally computes the seed of the `System.Random` class according to the UUIDs of all players: the list of peers is ordered by UUID, the first one is selected, and the hashed UUID is used as the seed to select a random configuration.

== RIG optimizations and possible interactions

=== Out Of Bounds (OOB) management

=== Red Screen Of Death (RSOD)

The red screen of death is a visual component that allows the player to remember that it is unfortunately no longer actively participating in the game. The screen is a simple red overlay that is placed over the native camera view along with an appropriate vignette to mitigate sickness during movement. For additional information about the spectator mode see @sm.

== Object interaction and synchronization

Every interactable object present in the Interactables object is equipped with two scripts `NetworkInteractable` and `NetworkMovement`. The first one detects when the object is interacted with and set the second script to start sending messages containing information about the position of the object. When transmitting, two variables are set by the sender and all receiving party, these being `AmIOwner` and `AmISender`. When the transmission starts, both variables are set at true in the sender and false in the receiving party (that being the replica of the same object in the other player's application instance). When the object is owned by another party, this means that the object is currently being interacted with by another party and others should not interfere: therefore, the `XRBaseInteractable` is deactivated in the receiving parties. When released, two situations can happen:
- the object is not stationary, meaning it is not in a fixed position: in this case, the sender set `AmIOwner` to false but keeps `AmISender` to true. This causes the sender to keep sending information about object position to the other peers, while allowing the other instances to re-activate the `XRBaseInteractable`, therefore allowing other players to become the "owner" of such object. Becoming the new owner automatically makes the previous owner not be the sender anymore;
- the object is stationary, meaning it is always in the same position: an example could be a button for example, which movement has to be transmitted only when a player is interacting with it, but not after it has finished the interaction. In such case, interrupting the interaction causes both variables, `AmIOwner` and `AmISender`, to become false.
The handling function has been reported in @processmessage.

Similarly to the situation just described, it is important to also dedicate a few words regarding the animations and particles: appropriate scripts have been created to send specific messages across the Ubiq network to reproduce audio, effects and other elements in a synchronized manner.

== Spectator mode <sm>

When a player loses because of the ghost, it enters a special mode called "Spectator Mode". This game modality disables the ability of the player to interact with interactable objects and disables the avatar in both the local and all remote instances of the game. Collisions are also disabled, therefore, the player is free to roam all the map, including out of bounds areas since the collision detection has been disabled as well.

The way the functionality works starts from the ghost: this has a reference to Avatar Manager, specifically its script called `SpectatorModeManager`, which has a public method, `ChangeSpectatorModeByPlayerUUID(playerUUID,sendToOtherPeers)` that is in charge of disabling the spectator mode on the Local Avatar and notifying remote peers. To send messages, the `MessageHandler` component is used. Additionally, `SpectatorModeManager` subscribes to an event of `Message Handler` to be notified when a spectator mode needs to be activated. In this particular situation, the manager invokes another event to notify every avatar spawned under the avatar manager.

In fact, every avatar is equipped with another script, `SpectatorMode`, that subscribes to the spectator mode manager, check for the avatar UUID (which can be recovered from the object name) and, if a match is found between the event UUID and the avatar UUID, the modality is activated after playing a special sound.

Similarly, the Red Screen Of Death (the red screen characteristic of the spectator mode, abbreviated in RSOD), also subscribes to the same event of the spectator mode manager to activate the red screen on the Local Avatar if the player that lost the game is the one of the particular device that received the message.

Since disabling the avatar too early would cause the audio to not play, a routine is used, see @handlespectatorchange for more information, which contains the function called when the event of spectator mode activation is fired from the spectator mode manager.

Finally, `SpectatorModeManager` also enables the game over final screen, both in case of win or lost.

== The monster

#let caas = box["client-as-a-server"]

The ghost is another essential component of the game. Specifically, it is controlled only by one client, the player that created the room, and such decision is propagated to the other clients upon game start. In case such client disconnected from its own room, it elects the new #caas if any, and just before leaving the room it broadcasts the decision.

The *NavMesh* package is adopted to let the monster move by itself. The #caas activates a NavMesh agent with the logic of the ghost, and uses two NavMesh surfaces (needed for different states, explained in the following section). Other clients, instead, simply run the "common" part of the ghost, namely the 3D model, the sound effects, the animations, etc.

=== State machine

The monster is implemented via the state machine design pattern. Indeed, it behaves in many different ways depending on the circumstances, hence the following states are defined:

- *wander* - the ghost sets a random destination, follows a path to reach it, selects a new random destination and repeats. In the meanwhile, it constantly checks if it sees any player within its field of view, and if so, it targets such player and changes state;

- *chase* - the targeted player is the unique destination of the ghost. The monster starts at a slow speed and constantly increase it until a maximum velocity, that is higher than the one of the players;

- *stunned* - the monster sets a random destination far away from the players, and during the path it does not target anyone. This is used to let the players have a bit of space to play, and it is implemented in two different substates that behave in the same way, but they are logically separated:

  - *murder* - the monster reached the targeted player and killed it;

  - *flashed* - the monster is flashed by the players with the lanterns.

#figure(
  image(
    "../../assets/MonsterStateMachine.png",
    width: 60%,
  ),
  caption: [Monster state machine diagram],
)

During the wander and stunned states, the ghost can pass through walls, while in the chase state it cannot. The team thought that if the monster always ignored the walls, escaping or flashing it would become much more difficult. Therefore, two NavMesh surfaces alternate according to the current state of the monster.
