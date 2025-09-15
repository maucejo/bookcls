#import "@preview/hydra:0.6.2": hydra
#import "bookly-defaults.typ": *
#import "bookly-helper.typ": *

// Chapter
#let chapter(title: none, abstract: none, toc: true, numbered: true, body) = context {
    // Is the chapter numbered?
    if not numbered {
      numbering-heading = none
      numbering-eq = "(1a)"
      numbering-fig = "1"

      // Heading numbering
      set heading(numbering: numbering-heading)

      // Equation numbering
      set math.equation(numbering: numbering-eq)

      // Figure numbering
      show figure.where(kind: image): set figure(
        supplement: fig-supplement,
        numbering: numbering-fig,
        gap: 1.5em
      )

      // Table numbering
      show figure.where(kind: table): set figure(
        numbering: numbering-fig,
        gap: 1.5em
      )
    }

    let toc-header = states.localization.get().toc
    if toc {
      set page(header: none)
      set align(horizon)
      heading(title)

      if abstract != none {
        abstract
      }

      minitoc
      pagebreak()
    } else {
      heading(title)
    }

    body
  }
}

#let chapter-nonum(body) = {
  let numbering-heading = none
  let numbering-eq = "(1a)"
  let numbering-fig = "1"

  // Figure numbering
    show figure.where(kind: image): set figure(
      supplement: fig-supplement,
      numbering: numbering-fig,
      gap: 1.5em
    )

    // Table numbering
    show figure.where(kind: table): set figure(
      numbering: numbering-fig,
      gap: 1.5em
    )

    // Heading numbering
    set heading(numbering: numbering-heading)

    // Equation numbering
    set math.equation(numbering: numbering-eq)

    // Figure numbering
    show figure.where(kind: image): set figure(
      supplement: fig-supplement,
      numbering: numbering-fig,
      gap: 1.5em
    )

    // Table numbering
    show figure.where(kind: table): set figure(
      numbering: numbering-fig,
      gap: 1.5em
    )

    body
}

// Part
#let part(title) = {
  states.counter-part.update(i => i + 1)
  set page(
    header: none,
    footer: none,
    numbering: none
  )

  set align(center + horizon)

  pagebreak(weak: true, to:"odd")

  context{
    if states.theme.get().contains("fancy") {
      let dxl = 0%
      let dxr = 0%
      if states.layout.get().contains("tufte") {
        dxl = 21.68%
        dxr = 3.1%
      }
      show: move.with(dx: dxl)
      fullwidth(dx: dxr)[
        #line(stroke: 1.75pt + states.colors.get().primary, length: 104%)
        #text(size: 2.5em)[#states.localization.get().part #states.counter-part.get()]
        #line(stroke: 1.75pt + states.colors.get().primary, length: 35%)
        #text(size: 3em)[*#title*]
        #line(stroke: 1.75pt + states.colors.get().primary, length: 104%)
      ]
    } else if states.theme.get().contains("classic") {
      let dx = 0%
      if states.layout.get().contains("tufte") {
        dx = 21.68%
      }
      show: move.with(dx: dx)
      text(size: 2.5em)[#states.localization.get().part #states.counter-part.get()]
      v(1em)
      text(size: 3em)[*#title*]
    } else if states.theme.get().contains("modern") {

      let dxr = 0%
      if states.layout.get().contains("tufte") {
        dxr = 21.68%
      }

      let dxb = 0%
      if states.layout.get().contains("tufte") {
        dxb = 36%
      }

      place(top + center, dx: dxr, dy: -11%)[
        #fullwidth[#rect(fill: gradient.linear(states.colors.get().primary, states.colors.get().primary.transparentize(55%), dir: ttb), height: 61%, width: 135% + dxr)[
          #set align(center + horizon)

          #text(size: 5em, fill: white)[*#states.localization.get().part #states.counter-part.get()*]
        ]]
      ]

      place(center + horizon, dx: dxr)[
        #box(outset: 1.25em, stroke: none, radius: 5em, fill: states.colors.get().primary)[
          #set text(fill: white, weight: "bold", size: 3em)
          #title
        ]
      ]
    }

    show heading: none
    if states.theme.get().contains("fancy") {
      heading(numbering: none)[#box[#text(fill:states.colors.get().primary)[#states.localization.get().part #states.counter-part.get() -- #title]]]
    } else {
      heading(numbering: none)[#box[#states.localization.get().part #states.counter-part.get() -- #title]]
    }
  }

  pagebreak(weak: true, to:"odd")
}