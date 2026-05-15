#import "../lib/common.typ": projectTitle
#import "../lib/commonReport.typ": abstract, docBody, firstPage, indexPage, referencePage

#firstPage(projectTitle)

#abstract([#lorem(150)]) //TODO: ABSOLUTELY CHANGE THIS!!!

#indexPage()

#docBody(
  [
    = WIP

    == Ap

    - torch charge logic, with batteries placed randomly in the map

    == Teo

    - Analyzing and adapting networking (room creation/join)
    - UI development (create/join room panel, option panel, in-game UI (?))
    - Avatar with audio
    - Creating main Lobby
    - Game start system (scene change, loading screen)

    == Cuba

    - Main interactables
    - Enviroinment and lighting
    - 3D Modelling
    - Blocked player vision on wall intersection

    = Ideas

    == Player

    - shake torch to recharge a bit before running out
    - Flash tech to stun the monster
    - Simple crouch system

    == Lobby

    - the monster walk around you, waiting to play (invisible walls block any interaction between players and the monster)
    - point shop (see @game)
    

    == Game <game>

    - avoid player to enter in the walls with the head
    - introducing fake orbs/object to win without the other(s) player(s)
    - point system: if more games are played in the same room, this could make player buy some advantages for the next game

  ],
  projectTitle,
)

#referencePage(projectTitle, "References","../report/references/ref.yml")
