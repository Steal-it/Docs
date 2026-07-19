#import "../lib/common.typ": course, projectTitle
#import "../lib/commonReport.typ": abstract, docBody, firstPage, indexPage, referencePage

#firstPage(projectTitle)

#abstract([
  // MAX 250 words
  /*
  Summarize your project briefly by addressing the following points:
  • Define the problem you aim to solve.
  • Describe your proposed solution.
  • Explain why your solution works well and why users would want to adopt it.
  • Identify the key features that distinguish your work from existing solutions.
  • Present your main evaluation findings.
  */

  The #course course required the development of a project to pass the class. In this context, the members of this group decided to create an Extended Reality experience to make people have the possibility to experience an horror game in a virtualized but immersive context.

  Specifically, the group, taking inspiration from the game #link("https://store.steampowered.com/app/1349060/It_Steals")[It Steals], created "_Steal It_", a multiplayer game written with Unity and the #link("https://docs.unity3d.com/Packages/com.unity.xr.interaction.toolkit@3.0/manual/index.html")[Unity XRI Toolkit] that was extensively tested on the Meta Quest 3.

  The game put the various players inside a labyrinth inhabited by "The Monster", a mysterious bloodthirsty ghost that will chase the various players until each one of them will no longer be on this planet. Players need to team up, also using help objects like the see-through goggles, to collect all keys and escape the sad destiny that the ghost chose for them.

  Thanks to the huge number of interactable objects and the recreated horror-like environment and experience, people can really feel immerse in a legitimate horror experience, despite certainly not having the same level of realism of other games like #link("https://store.steampowered.com/app/739630/Phasmophobia/")[Phasmophobia].

  Finally, the chosen end users and the various game mechanics, as well as the recreated environment, significantly distinguish "_Steal It_" from its source of inspiration.

])

#indexPage()

#show: docBody.with()

/*
Max 12 pages, 12pt, NOT COUNTING: Abstract, References, Group Contribution Statement, Code appendix

REPOSITORY MUST HAVE README WITH:
- project title
- group contribution statement
- the abstract of this report
- setup/usage instruction
*/

#include "chapters/01_Introduction.typ"
#include "chapters/02_Related-Work.typ"
#include "chapters/03_Design.typ"
#include "chapters/04_implementation.typ"
#include "chapters/05_Evaluation.typ"
#include "chapters/06_Discussion-and-conclusions.typ"
#include "chapters/07_Group-contribution-statement.typ"
#include "chapters/08_Code-Appendix.typ"

#referencePage(projectTitle, "References", "../report/references/ref.yml")
