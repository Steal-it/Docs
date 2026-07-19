#import "@preview/treet:1.0.0": *

= Design
/*
Present your system design in detail by addressing the following:
• What key assumptions do you make about your system, its users, and the environment in which users will operate it?
• What evidence supports these assumptions as reasonable?
• What components make up your architecture, how do they connect, and how do they communicate with one another?
• What tools (beyond Unity and Ubiq) do you employ?
• Did you modify or extend any Ubiq components? If so, describe your modifications.
*/

== General information

Regarding the design of _Steal It_, a key assumption of the system is the underling network infrastructure: Ubiq utilize, except for the room discovery, an almost server-free infrastructure that is considered reliable by our project. As seen during the lectures, an unreliable infrastructure that brings latency and inconsistent framerate can easily break the immersion.

In order to validate the original assumption, the game needs to be played by at least two players at the same time.

As for the main game, the main components of our architecture are the following:

- *Scene* -  the prefab that contains all GameObjects, useful for avoiding missing references and for future development such as #link("https://unity.com/how-to/simplify-your-content-management-addressables#addressables-overview")[Addressables]\;

  - *Level Manager* - the component responsible for teleporting players from the connection and settings room to the room lobby first, and from the room lobby to the main map after;

  - *Local Lobby* and *Room Lobby* - the first contains the starting point of all players. Here players can choose in what hand keep the torch and if they want to create a new room or join an existing one. The second prefab is the actual room lobby, where people can select to return to the first room or notify the others that they are ready to start the game;

  - *XR Origin (XR Rig)* - as the name says, it is the rig for the player. It has been modified to only allow specific type of interactions. Additionally, the component adds a vignette to reduce sickness caused by movement, and implements the block vision layer to signal the player that has moved its head inside an object, and the Red Screen Of Death (RSOD) that appears upon being killed by the monster. Lastly, it also allow the see-through effect of the goggles;

  - *Game Over* - components with the game over logic and canvas;

  - *Network* - the main component that hosts all objects that somewhat access the Ubiq network. The most relevant are mentioned below;

    - *Avatar Manager* - the component is inherited directly from the Ubiq test scene and it is responsible of spawning and synchronizing all avatars connected under the same room. Additionally, it is also responsible to activate and deactivate the spectator mode, a special player game mode in which the player can freely move around the map since it lost the game;

    - *Name Manager*, *Voip Manager* and *Ubiq Avatar Input* - three components inherited directly by the Ubiq test scene and responsible for the player name assignment, voice transmission and input management respectively;

    // TODO: huh?
    - *Spawner* - component that manages player spawn in such a way that two players cannot spawn in the same position;

    - *Message Handler* - component that handles the majority of messages exchange under the same room. Some examples are the message that signals other peers a player is ready, the one that signals that all players are ready, the messages responsible for electing the client that will manage the ghost, the message that signals that a player escaped the maze and the message that activate the spectator mode for a player;

    - *Map* - made of several components that together creates the playable level. Between them, the most important are the following;

      - *Configuration Manager* - contains the possible positions of keys in the map, as well as the player and ghost spawn points;

      - *Monster Pack* - the complete logic of the ghost, from movement to state management;

      - *Interactables* and *Visuals* - list of interactable objects, wall and props of the map.

Every interactable object present in the Interactables object is equipped with two scripts `NetworkInteractable` and `NetworkMovement`: the way they work will be explained in @ch4.

In general, no further libraries except for Ubiq and Unity native libraries have been used for creating _Steal It_ and no official Ubiq component has been modified: if a non-native component was needed, this has been created using functionality of main Ubiq components. Eventual 3D models have also been created from scratch.

== Application Walk-through

/*
Describe the user experience with your system. Treat this section as a user manual: explain the system from the user’s perspective and guide readers through typical usage scenarios.
*/

Upon opening the application, players are automatically positioned in the Local Lobby: here they cannot move, but they are presented with two main sections. The first one is a panel present on their left describing some of the main aspect of the game, including but not limited to core mechanics.
/*At the center player find the main menu and the hand settings menu: the first one allows players to create a new room or join an existing one from a panel that will open on their right if such option is chosen. In order to limit the number of necessary interaction required by the player, all room are public and freely accessible.*/
At the center player finds the main menu that allows to create a new room or join an existing one from a panel that will open on their right if such option is chosen.

Upon creating a room or joining an existing one, players are teleported to the actual room lobby where also other players spawn upon joining the same room. Here players can return to the first lobby or pressing the "Ready" button, that signals other players they are ready to start the game. Notice that the button is grayed out and not interactable if there is only one person in the room.

After all players currently connected to the same room pressed the "Ready" button, all of them are teleported inside the map, where they can start collecting keys, discover secret rooms and collect useful objects to win the game. Specifically, some areas of the labyrinth are accessible only after pressing a particular button, interacting with a specific lever or by unlocking a door using the right key. In these areas, the player can find the so called "helpers", objects that assist the player in game. Those implemented are special goggles that allow to temporarily see through walls, discovering secret areas or ghost current position, and particual energy spheres needed to charge the lantern.

The goal of the game is to team up and escape the maze, but the ghost can, while roaming across the map, go through walls and start chasing a player. When chasing, the ghost will no longer go through walls (with the exception of doors) and the only way for a player not to lose the game is by stunning the monster using its lantern with a still active battery.

Finally, charged lanterns can make the player see better in the dark, but they are not infinite: they will discharge over time, until they will no longer have a charge and the battery eventually will explode.
