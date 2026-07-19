#set heading(numbering: none)
#import "../../lib/common.typ": authors

= Group Contribution Statement

/*
Describe each team member’s specific contributions to the project.
*/
While all members contributed in equal manner to level and game design choices, every member gave its unique contributions on the project as described in the following table.

#figure(
  caption: "Group contributions",
  table(
    columns: (45%,55%),
    align: (x,y) => {
      if(y==0) {
        center+horizon
      } else {
        left+horizon
      }
    },

    table.header([*Member*],[*Contributions*]),
    [*#authors.ap.name #authors.ap.surname (#authors.ap.stid)*],
    [
      - Initial RIG changes
      - Initial torch design and usage logic development
      - Initial battery design and usage logic development
      - Map customization management on scene to create various levels using the same map
      - Game end management
      - Contribution to final map developing
      - Monster:
        - Monster design
        - Monster logic (wander, chase, stun)
      - Networking
        - Monster networking (client as server election, movement and event synchronization)
        - Refactoring of existing scripts and functionality abstraction
        - Player spawning system
    ],
    [*#authors.ajsm.name #authors.ajsm.surname (#authors.ajsm.stid)*],
    [
      - Player vision blocker when intersection with objects occur
      - Final map design and graphic improvements
      - Complete design and logic development of interactable objects
        - Buttons (classic and with counter)
        - Levers (angular and linear)
        - Ladder
        - Goggles
        - Final torch and battery design
        - Doors, keys and locks
      - Creation of the final map
      - Refactoring of avatar and RIG system for hand change management
      - Goggles transparent vision
      - Monster:
        - Help with stun logic
        - RIG
      - Networking:
        - Hand change selection logic and synchronization

    ],
    [*#authors.mt.name #authors.mt.surname (#authors.mt.stid)*],
    [
      - Initial UI interface for game join menu
      - Hand selection UI interface 
      - Creation of testing map
      - Spectator mode Red Screen Of Death
      - Networking:
        - Interactable object management and synchronization between players (position sending/receiving, owner/sender system)
        - Room creation and management (public room creation upon button pressing)
        - Game "Ready" system (start the game only when all people in the room are ready, including ready counter recovery upon room join)
        - Level managing (initial study for avatar transposition when joining a level or a different room)
        - Spectator mode activation/deactivation
        - Increased reliability of avatar movement/animation interaction and transmission
    ],
  )
)