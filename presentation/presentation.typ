#import "../lib/common.typ": course, projectTitle
#import "../lib/commonPresentation.typ": cover, slide


#cover([#projectTitle])

#slide("Introduction",[

  #show grid: set text(size: 1.7em)

  #grid(
    columns: (50%,50%),

    [
      Steal It, a simple game:
      - Collect items
      - Stun the Monster
      - Escape the labyrinth
    
    With a lot of interactions:
      - Pull levers
      - Press buttons
      - Social interactions

    Test if:
      - Immersion could be obtained with less realism \ but more emotions and interactions
      - See whether people tend to team up under stress
    ],
    [
      #place(dx: -5em)[
        #image("../assets/presentations/1.png", width: 90%)
      ]
      
      #place(dx: 2em, dy: 9em)[
        #image("../assets/presentations/2.png", width: 80%)
      ]
      
    ]
  )  
])

#slide("XR-Rig",[

#show grid: set text(size: 1.7em)

  #grid(
    columns: (50%,50%),
    align: (x,y) => {
      if(x==0) {
        horizon
      } else {
        center
      }
    },
    [

     To achieve our desired player behaviour we modified the default Unity XR Rig:

      - FollowPlayerHead
      - Disabled Jumping
      - RSOD (Canvas)
      - BlockVision
      - SeeThrough
      - GoggleSocket
    ],
    [
      #image("../assets/presentations/3.png")
    ]
  )

])

#slide("XR-Rig: Custom Hands (1/2)",[

#show grid: set text(size: 1.7em)

  #grid(
    columns: (50%,50%),
    align: (x,y) => {
      if(x==0) {
        horizon
      } else {
        center
      }
    },
    [

     Also to make our own animation to each hand we decided to build custom head for each avatar:

      - Hand Controller => Colliders + Active interactions
      - Torch
        - AttachPoint
        - Socket
        - Light logic
        - ShakeDetector (Not used)

    ],
    [
      #v(10em)
      #place(dx: 1em, dy: -9em)[
        #image("../assets/presentations/4.png")
      ]
      
      #place(dx: 10em,)[
        #image("../assets/presentations/4.png")
      ]
      #v(10em)
    ]
  )

])

#slide("XR-Rig: Custom Hands (2/2)",[

#show grid: set text(size: 1.7em)

  #grid(
    columns: (50%,50%),
    align: (x,y) => {
      if(x==0) {
        horizon
      } else {
        center
      }
    },
    [

      This meant that we also needed to modify the default avatar of UBIQ:

      - We build a model of the hand and a lantern

      - We program and assign the animation logic to each hand in order to allow the player to switch hand at runtime
        - Pokeing
        - Grabbing
        - Lantern-In-Pocket
        - Lantern-In-Hand

    ],
    [
      #image("../assets/presentations/6.png")
    ]
  )

])

#slide("Interactables",[

#show grid: set text(size: 1.7em)

  #text(size: 1.5em)[
    We designed a a few key interactables to make the finding of the treasure more interesting and challenging.
  - Boxes
  - Drawers
  - Keys + Locks
  - Levers
  - Goggles
  - Ladders
  - Doors
  ]

  #grid(
    columns: (50%,50%),
    [
      And made some models to make the experience more immersive
      - Scaffolders
      - Old TVs
      - Stairs
      - Shelves
      - Posters
      - And more

    ],
    [
      #image("../assets/presentations/7.png", width: 90%)
    ]
  )


])

#slide("The Monster",[

#show grid: set text(size: 1.7em)

  #text(size: 1.5em)[
   A terrifying ghost that guards its treasure
    - Wander: roam around the map, ignoring everything but the players
    - Chase: target the closest player in its FOV
    - Stunned: move away from the players, ignoring everything (passive to every external event)
        - Murder: killed a player
        - Flashed: flashed by a lantern of a player while chasing

    #v(2em)
    Hosted by one client, the others only move the visuals
  ]

  #place(dx: 63%, dy: -20%)[
    #image("../assets/presentations/8.jpeg", width: 30%)
  ]

])

#slide("Game setup",[

#show grid: set text(size: 1.7em)

  #text(size: 1.5em)[
   *Local lobby*
    - Personal room, select or create a lobby to play
    *Room lobby*
    - Public Ubiq room where players join to play
    - “Ready” for playing, “exit” for returning to local lobby
    *Game*
    - Players spawn in an entry room opened to the maze, while the ghost is already wandering

    Every player spawn is handled by a custom logic, where a random point, according to its UUID, over the perimeter of a circle is taken (avoid spawn collisions)

  ]
])

#slide("Networking",[

  #show grid: set text(size: 1.7em)

  #grid(
    columns: (50%,50%),

    [
      Ubiq handles automatically most of the networking, however:
      - Logic to manage objects movement had to be developed
      - No out-of-the-box matchmaking: a ready system was necessary
      - Ubiq does not work well with scene changes

      This led the team to develop custom solutions:
      - Owner / Sender system
      - Ready counter and counter recovery
      - System to create different levels with the same map, avoiding scene changes

    ],
    [
      #image("../assets/presentations/9.png", width: 80%)
      
      #move(dx: 5em)[
        #image("../assets/presentations/10.png", width: 80%)
      ]
      
    ]
  )
])