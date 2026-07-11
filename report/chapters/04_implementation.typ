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

Every interactable object present in the Interactables object is equipped with two scripts `NetworkInteractable` and `NetworkMovement`. The first one detects when the object is interacted with and set the second script to start sending messages containing information about the position of the object. When transmitting, two variables are set by the sender and all receiving party, these being `AmIOwner` and `AmISender`. When the transmission start, both variables are set at true in the sender and false in the receiving party (that being the replica of the same object in the other players application instance). When the object is owned by another party, this means that object is currently being interacted by another party and others should not interfere: therefore, the `XRBaseInteractable` is deactivated in the receiving parties. When released, two situation can happen:
- the object is not stationary, meaning it is not in a fixed position: in this case, the sender set `AmIOwner` to false but keeps `AmISender` to true. This causes the sender to keep sending information about object position to the other peers, while allowing the other instances to re-activate the `XRBaseInteractable`, therefore allowing other players to becoming the "owner" of such object. Becoming the new owner automatically makes the previous owner to not be the sender anymore;
- the object is stationary, meaning it is always in the same position: an example could be a button for example, which movement has to be transmitted only when a player is interacting with it, but not after it finished the interaction. In such case, interrupting the interaction cause both variables, `AmIOwner` and `AmISender`, to became false.