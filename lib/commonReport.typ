#import "common.typ": linkColor, course, university, authors, academicYear, projectTitle, mainColor, date

#let firstPage(title) = {
  
  set page(margin: 0pt)
  set document(
    title: [#title - #course - #university],
    author: (
            authors.ajsm.name+" "+authors.ajsm.surname+" - Student Id "+authors.ajsm.stid,
            authors.ap.name+" "+authors.ap.surname+" - Student Id "+authors.ap.stid,
            authors.mt.name+" "+authors.mt.surname+" - Student Id "+authors.mt.stid
            ),
    description: [Project report for the #course course at #university]
  )

  align(top+center)[

    #place(dx: 0pt, dy: 0pt)[
      #rect(width: 110%, height: 6em, fill: mainColor.lighten(40%))
    ]

    #polygon(
      fill: mainColor,
      (0%,0%),
      (100%,0%),
      (50%,6em)
    )
    
    #v(3em)

    #grid(
      columns: (80%),
      gutter: 0.5em,
      [
        #text(size: 2.1em, weight: "extrabold")[Project Report for #course Course]
      ],
      [
        #v(1.5em)
        #text(size: 1.2em)[Academic Year: #academicYear]
      ],
      [
        #v(3em)
        #text(size: 2em, weight: "bold")[#title]
      ],
    )
    
  ]

  v(4.5em)
  align(center)[#line(length: 35%, stroke: 2pt+mainColor)]
  v(4.5em)

  align(center)[
    #text(size: 1.5em, weight: "bold")[Authors:]
    #grid(
      columns: (40%,40%),
      align: center+horizon,
      gutter: 3em,
      [
        #authors.ap.name #authors.ap.surname \
        #link("mailto:"+authors.ap.email)[#authors.ap.email] \
        Student ID: #authors.ap.stid
      ],
      [
        #authors.mt.name #authors.mt.surname \
        #link("mailto:"+authors.mt.email)[#authors.mt.email] \
        Student ID: #authors.mt.stid
      ],
      grid.cell(colspan: 2)[
        #authors.ajsm.name #authors.ajsm.surname \
        #link("mailto:"+authors.ajsm.email)[#authors.ajsm.email] \
        Student ID: #authors.ajsm.stid
      ]
    )
  ]

  place(dx: 90pt, dy:-170pt)[
    #polygon(
      fill: mainColor.lighten(40%),
      (100%,0%),
      (100%,100%),
      (100%,100%),
      (0%,100%),
    )
  ]

  place(dx: 100pt, dy: -70pt)[
    #polygon(
      fill: mainColor,
      (100%,0%),
      (100%,0%),
      (100%,100%),
      (0%,100%),
    )
  ]

  show link: set text(fill: linkColor)

  set page(
    margin: auto,
    footer: [
      #align(center)[#context[#counter(page).display("1 of 1", both: true,)]] \
      #place(dx: -71pt, dy: -2pt)[#rect(height: 50%, width: 135%, stroke: none, fill: mainColor)]
    ]
  )
}

#let abstract(text) = {

  set page(
    margin: auto,
    footer: [
      #align(center)[#context[#counter(page).display("1 of 1", both: true,)]] \
      #place(dx: -71pt, dy: -2pt)[#rect(height: 50%, width: 135%, stroke: none, fill: mainColor)]
    ]
  )

  title("Abstract")
  
  text
  
}

#let indexPage(imageList: true, tableList: true) = {
  set page(
    margin: auto,
    footer: [
      #align(center)[#context[#counter(page).display("1 of 1", both: true,)]] \
      #place(dx: -71pt, dy: -2pt)[#rect(height: 50%, width: 135%, stroke: none, fill: mainColor)]
    ]
  )

  show outline.entry.where(level: 1): it => {
    v(12pt, weak: true)
    text(size: 1.2em)[*#it*]
  }

  outline(depth: 4, title: text(size: 2em)[#v(0em) Index #v(0.5em)], indent: 1em)

  if(imageList==true) {
    text(size: 2em)[#v(0.5em) *Images* #v(-0.5em)]

    show outline: set text(weight: "thin")
    outline(
      title: [],
      target: figure.where(kind: image),
    )
  }

  if(tableList==true) {
    text(size: 2em)[#v(0.5em) *Tables* #v(-0.5em)]
    
    show outline: set text(weight: "thin")
    outline(
      title: [],
      target: figure.where(kind: table),
    )
  }

}

#let docBody(body, title) = {

  show figure: set block(breakable: true)
  show link: it => underline(text(fill: linkColor)[#it])
  show ref: rf => underline(text(fill: mainColor)[#rf])

  set heading(numbering: "1.")

  show heading.where(level: 1): h => {
    set text(size: 1.5em)
    pagebreak()
    h
    v(0.25em)
  }

  set page(
    margin: auto,
    header: [

      #grid(
        columns: (33%, 33%, 33%),
        align: (x, y) => {
          if x == 0 {
            left + horizon
          } else if x == 1 {
            center + horizon
          } else {
            right + horizon
          }
        },
        [#course], [#title - Project report], [#date],
      )

      #line(length: 100%)
      

    ],
    footer: [
      #align(center)[#context[#counter(page).display("1 of 1", both: true,)]] \
      #place(dx: -71pt, dy: -2pt)[#rect(height: 50%, width: 135%, stroke: none, fill: mainColor)]
    ]
  )

  body

}