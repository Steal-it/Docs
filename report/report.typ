#import "../lib/common.typ": projectTitle
#import "../lib/commonReport.typ": firstPage, abstract, indexPage, docBody

#firstPage(projectTitle)

#abstract([#lorem(150)])

#indexPage()

#docBody([
  = test
  == test2
  #figure(
    grid(
      columns: (50%,50%),
      [test]
    ),
    kind: image,
    caption: "test",
  )

  A simple test@moodle

= test2

#figure(
    grid(
      columns: (50%,50%),
      [test]
    ),
    kind: table,
    caption: "test",
  )

],projectTitle)

#bibliography("references/ref.yml", title: "References")