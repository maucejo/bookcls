#import "@preview/minitoc:0.1.0": *
#import "_global-param.typ" : *

// Chapter
#let chapter(title, abstract: none, toc: true, numbered: true, body) = {
  counter(math.equation).update(0)
  counter(figure.where(kind: image)).update(0)
  counter(figure.where(kind: table)).update(0)

  context{
    let numbering-heading = states.num-pattern.get()
    let numbering-fig = n => {
      let h1 = counter(heading).get().first()
      numbering(numbering-heading, h1, n)
    }

    let num-pattern-eq = "(1.1)"
    if states.isappendix.get() {
      num-pattern-eq = "(A.1)"
    }
    let numbering-eq = n => {
      let h1 = counter(heading).get().first()
      numbering(num-pattern-eq, h1, n)
    }

    // Is the chapter numbered?
    if not numbered {
      numbering-heading = none
      numbering-eq = "(1)"
      numbering-fig = "1"
    }

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

    let toc-header = states.localization.get().toc
    if toc {
      set align(horizon)
      heading(title)

      if abstract != none {
        abstract
      }


      block(above: 3.5em)[
          // #if slang.get() == "fr" {
            #text([*#toc-header*])
            #v(-0.25em)
          // } else {
          //   text([*Table of contents*])
          //   v(-0.25em)
          // }
      ]

      line(stroke: 2pt + colors.gray, length: 100%)
      minitoc(target: heading.where(outlined: true, level: 2))
      line(stroke: 2pt + colors.gray, length: 100%)
      pagebreak()

    } else {
      heading(title)
    }

    body
  }
}

// Quatrième de couverture
#let back-cover(resume: none, abstract: none) = {
  set page(numbering: none)

  pagebreak(to: "even", weak: true)
  set align(horizon)
  grid(columns : 2,
    column-gutter: 1fr,
    [#align(left)[#image("resources/images/devise_cnam.svg", width: 45%)]],   [#align(right)[#image("resources/images/logo_cnam.png", width: 50%)]],
  )

  context{
    v(2em)
    align(center)[
      #text([*#states.author.get()*], size: 1.5em, fill: colors.red)

      #text([*#states.title.get()*], size: 1.25em)

      #v(1em)
    ]
  }
  if resume != none {
    block(
      width: 100%,
      stroke: 1pt + colors.red,
      inset: 1em,
      radius: 0.5em,
      below: 2em
    )[
      #text([*Résumé : * #resume], size: 0.9em)
    ]
  }

  if abstract != none {
    block(
      width: 100%,
      stroke: 1pt + colors.red,
      inset: 1em,
      radius: 0.5em,
      )[
      #text([*Abstract : * #abstract], size: 0.9em)
    ]
  }
}