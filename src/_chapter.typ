#import "@preview/minitoc:0.1.0": *
#import "@preview/hydra:0.5.1": hydra
#import "_global-param.typ" : *

// Title page
#let title-page(
  title: none,
  author: none,
  type: "these",
  school: none,
  doctoral-school: none,
  supervisor: (),
  cosupervisor: none,
  laboratory: none,
  defense-date: none,
  discipline: none,
  specialty: none,
  commity: (),
  logo: none
) = {place(top + left, dx: -16%, dy: -10%,
      rect(fill: colors.red, height: 121%, width: 20%)
  )

  let tpage = {
    if logo != none {
    set image(width: 35%)
    place(top + right, dx: 0%, dy: -15%, logo)
    }
    text([ÉCOLE DOCTORALE #h(0.25em) #doctoral-school], size: 1.25em)
    v(0.25em)
    text(laboratory, size: 1.25em)
    v(2em)
    if type == "these" {
      text([*Thèse de doctorat*], size: 1.5em)
    } else {
      text([*Habilitation à diriger des recherches*], size: 1.5em)
    }
    v(0.25em)
    text([_présentée par_ *#author*], size: 1.15em)
    v(0.25em)
    text([_soutenue le_ *#defense-date*], size: 1.15em)
    v(0.25em)
    text([_préparée au_ *#school*], size: 1.15em)
    v(0.25em)
    text([_Discipline_ : *#discipline*], size: 1.1em)
    v(0.15em)
    text([_Spécialité_ : *#specialty*], size: 1.1em)
    v(2em)
    line(stroke: 1.75pt + colors.red, length: 104%)
    align(center)[#text(strong(title), size: 2em)]
    line(stroke: 1.75pt + colors.red, length: 104%)
    v(1em)
    let n = 0
    for director in supervisor {
      if n == 0 {
        if type == "these" {
          text([Directeur de thèse : *#director*], size: 1.15em)
        } else {
          text([Garant : *#director*], size: 1.15em)
          break
        }
        v(0.05em)
        n += 1
      } else {
        text([Co-directeur de thèse : *#director*], size: 1.15em)
        v(0.05em)
      }
    }
    if cosupervisor != none {
      for codirector in cosupervisor {
        text([Co-encadrant : *#codirector*], size: 1.15em)
        v(0.05em)
      }
    }
    v(1fr)
    align(center)[
      #text([*Composition du jury*])
      #v(0.5em)
      #set text(size: 0.9em)
      #grid(
        columns: 4,
        column-gutter: 1.5em,
        row-gutter: 1em,
        align: left,
        stroke: none,
        ..for (name, position, affiliation, role) in commity {
          ([*#name*], position, affiliation, role)
        },
      )
    ]

    v(1fr)
  }

  place(dx: 8%, dy: 11%,
    block(
      height: 100%,
      width: 100%,
      breakable: false,
      tpage
    )
  )
}

// Chapter
#let chapter(title, abstract: none, toc: true, numbered: true, body) = {
  counter(math.equation).update(0)
  counter(figure.where(kind: image)).update(0)
  counter(figure.where(kind: table)).update(0)

  // Header
  set page(header: context {
  set text(style: "italic", fill: colors.gray)
  if calc.odd(here().page()) {
    align(right, hydra(2))
  } else {
    align(left, hydra(1, book: false))
  }
})

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
        #text([*#toc-header*])
        #v(-0.25em)
      ]

      line(stroke: 1.5pt + colors.gray, length: 100%)
      minitoc(target: heading.where(outlined: true, level: 2))
      line(stroke: 1.5pt + colors.gray, length: 100%)
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