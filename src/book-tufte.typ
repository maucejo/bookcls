#import "@preview/drafting:0.2.2": *
#import "book-defaults.typ": *
#import "book-helper.typ": *

#let sidefigure(dy: -1.5em, body) = margin-note(dy: dy)[
  #show figure.caption: it => {
    set align(left)
    set text(0.9em)
    it
  }
  #body
]

#let fullfigure(body) = {
  show figure.caption: it => context move(dx: 37.6%)[
    #set text(0.9em)
    #set align(left)
    #block(width: 4.5cm)[#it]
  ]

  fullwidth(body)
}

//  Code from tufte-memo - thanks @nogula
#let sidenote(dy: -1.75em, numbered: true, content) = {
  if numbered {
    states.sidenotecounter.step()
    [ #super(context states.sidenotecounter.display())]
  }
  text(size: 0.9em, margin-note(
    if numbered {
    [#super(context states.sidenotecounter.display()) #content]
  } else {
    content
  }, dy: dy)
  )
}

#let sidecite(dy: -1.75em, supplement:none, key) = context {
  let elems = query(bibliography)
  if elems.len() > 0 {
    cite(key, supplement:supplement)
    margin-note(
      cite(key, form: "full", style: "resources/short_ref.csl"),
      dy: dy
    )
  }
}