#import "@preview/showybox:2.0.4": *
#import "@preview/hydra:0.6.2": hydra, anchor
#import "../bookly-helper.typ": *
#import "../bookly-defaults.typ": *

#let pretty(colors: default-colors, it) = {
  states.theme.update("pretty")

  // Headings
  show heading.where(level: 1): it => {
    // Reset counters
    reset-counters

    show: fullwidth

    // Heading style
    place(top, dy: -2.5em)[
      #rect(fill: white, width: 102%, height: 4%)
    ]
    set align(left)
    let type-chapter = if states.isappendix.get() {states.localization.get().appendix} else {states.localization.get().chapter}
    if it.numbering != none {
      v(2em)
      block[
        #text(size: 1.25em)[#type-chapter]
        #v(-1em)
        #box(stroke: (top: 1.5pt + colors.primary))[
          #set text(1.6em)
          #grid(
            columns: (auto, 1fr),
            align: (center, left),
            inset: (0em, 0.5em),
            [#box(fill: colors.primary, width: 1em, radius: (bottom: 0.4em), inset: 0.5em)[#text(fill: white)[#counter(heading).display(states.num-heading.get())]]],
            [#it.body]
          )
        ]
      ]
      v(3em)
    } else {
      set text(1.6em)
      box(stroke: (top: 1.5pt + states.colors.get().primary))[
        #grid(
          columns: (1em, 1fr),
          align: (center, left),
          inset: (0em, 0.5em),
          [#box(fill: colors.primary, width: 1em, radius: (bottom: 0.4em), inset: 0.5em)[#text(fill: white)[#counter(heading).display(states.num-heading.get())]]],
          [#it.body]
        )
      ]
      v(1em)
    }
  }

  // Tables
  show table.cell.where(y: 0): set text(weight: "bold", fill: white)
  set table(
    fill: (_, y) => if y == 0 {colors.primary} ,
    stroke: (_, y) => if y == 0 {(bottom: 0pt)} else {(bottom: 01pt + colors.secondary)}
  )
  show table: it => block(
    stroke: 01pt + colors.primary,
    radius: 1em,
    clip: true
  )[#it]

  // Outline
  show outline.entry: it => {
    show linebreak: none
    if it.element.func() == heading {
      let number = it.prefix()
      let section = it.element.body
      let item = none
      if it.level == 1 {
        block(above: 1.25em, below: 0em)
        v(0.5em)
        item = [#text([*#number*], fill: colors.primary) *#it.inner()*]
      } else if it.level == 2{
        block(above: 1em, below: 0em)
        item = [#h(1em) #text([#number], fill: colors.primary) #it.inner()]
      } else {
        block(above: 1em, below: 0em)
        item = [#h(2em) #text([#number], fill: colors.primary) #it.inner()]
      }
      link(it.element.location(), item)
    } else if it.element.func() == figure {
      block(above: 1.25em, below: 0em)
      v(0.25em)
      link(it.element.location(), [#text([#it.prefix().], fill: colors.primary) #h(0.2em) #it.inner()])
    } else {
      it
    }
  }

  // Page style
  let page-header = context {
    show linebreak: none
    show: fullwidth
    set text(style: "italic", fill: white)
    if calc.odd(here().page()) {
      set align(right)
      box(fill: states.colors.get().primary, inset: 0.5em, radius: (top-left: 2em, bottom-right: 2em))[#hydra(2)]
    } else {
      set align(left)
      box(fill: states.colors.get().primary, inset: 0.5em, radius: (bottom-left: 2em, top-right: 2em))[#hydra(1)]
    }
  }

  let page-footer = context {
    let cp = counter(page).get().first()
    let current-page = counter(page).display()
    let dx = 0%
    if states.tufte.get() {
      dx = 15.04%
    }
    set align(center)
    show: fullwidth
    move(dx: dx)[
      #grid(
        columns: (1fr, auto, 1fr),
        align: center + horizon,
        [#line(length: 100%, stroke: 0.75pt + states.colors.get().primary)],
        [#box(stroke: 1pt + states.colors.get().primary, inset: 0.3em, radius: 0.25em)[#current-page]],
        [#line(length: 100%, stroke: 0.75pt + states.colors.get().primary)]
      )
    ]
  }

  set page(
    paper: paper-size,
    header: page-header,
    footer: page-footer
  )

  it
}

// Part
#let part-pretty(title) = context {
  states.counter-part.update(i => i + 1)
  set page(
    header: none,
    footer: none,
    numbering: none
  )

  set align(center + horizon)

  pagebreak(weak: true, to:"odd")

  let dxl = 0%
  let dxr = 0%
  if states.tufte.get() {
    dxl = 21.68%
    dxr = 17%
  }
  move(dx: dxl)[
    #stack(
      dir: ttb,
      box(fill: states.colors.get().primary, inset: 1em, radius: (top: 2em))[
        #set text(size: 4.5em, fill: white, weight: "bold")
        #states.localization.get().part #states.counter-part.display(states.part-numbering.get())
      ],
      fullwidth(dx: -dxr, box(width: 90%, inset: 5em, stroke: 2pt + states.colors.get().primary, radius: (bottom: 2em))[
      #set text(size: 3em)

      *#title*
    ])
    )
  ]

  show heading: none
  heading(numbering: none)[
    #v(1em)
    #box[#text(fill:states.colors.get().primary)[#states.localization.get().part #states.counter-part.display(states.part-numbering.get()) -- #title]]
  ]

  pagebreak(weak: true, to:"odd")
}

// Minitoc
#let minitoc-pretty = context {
  let toc-header = states.localization.get().toc
  block(above: 3.5em, below: 0.5em)[
    #set text(fill: white)
    #box(fill: states.colors.get().primary, inset: 0.5em, radius: (top: 0.25em))[*#toc-header*]
    #v(-0.5em)
  ]

  let miniline = line(stroke: 1pt + states.colors.get().primary, length: 100%)

  miniline
  v(0.5em)
  suboutline(target: heading.where(outlined: true, level: 2))
  miniline
}