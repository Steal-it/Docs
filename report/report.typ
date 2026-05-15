#import "../lib/common.typ": projectTitle
#import "../lib/commonReport.typ": abstract, docBody, firstPage, indexPage

#firstPage(projectTitle)

#abstract([#lorem(150)])

#indexPage()

#docBody(
  [
    = WIP

    == Me

    - torch charge logic, with batteries placed randomly in the map

    == Teo

    == Cuba

    - Main interactables
    - Enviroinment and lighting
    - 3D Modelling
    - Blocked player vision on wall intersection
    - Simple crouch system (To be tested)

    = Ideas

    == Player

    - shake torch to recharge a bit before running out
    - Flash tech to stun the monster

    == Lobby

    - the monster walk around you, waiting to play (invisible walls block any interactin between players and the monster)

    == Game

    - avoid player to enter in the walls with the head

    //   = test
    //   == test2
    //   #figure(
    //     grid(
    //       columns: (50%,50%),
    //       [test]
    //     ),
    //     kind: image,
    //     caption: "test",
    //   )

    //   A simple test@moodle

    // = test2

    // #figure(
    //     grid(
    //       columns: (50%,50%),
    //       [test]
    //     ),
    //     kind: table,
    //     caption: "test",
    //   )

  ],
  projectTitle,
)

#bibliography("references/ref.yml", title: "References")
