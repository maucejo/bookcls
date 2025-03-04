// #import "@preview/minitoc:0.1.0": *
#import "@preview/suboutline:0.2.0": *
#import "@preview/hydra:0.5.1": hydra
#import "book-params.typ" : *

// Title pages
#let title-page-thesis(
  title: none,
  author: none,
  logo: none,
  config-titre,
  config-colors,
) = {
  place(top + left, dx: -16%, dy: -10%,
      rect(fill: config-colors.primary, height: 121%, width: 20%)
  )

  let tpage = {
    if logo != none {
    set image(width: 35%)
    place(top + right, dx: 0%, dy: -15%, logo)
    }
    text([ÉCOLE DOCTORALE #h(0.25em) #config-titre.doctoral-school], size: 1.25em)
    v(0.25em)
    text(config-titre.laboratory, size: 1.25em)
    v(2em)
    if config-titre.type == "phd" {
      text([*Thèse de doctorat*], size: 1.5em)
    } else {
      text([*Habilitation à diriger des recherches*], size: 1.5em)
    }
    v(0.25em)
    text([_présentée par_ *#author*], size: 1.15em)
    v(0.25em)
    text([_soutenue le_ *#config-titre.defense-date*], size: 1.15em)
    v(0.25em)
    text([_préparée au_ *#config-titre.school*], size: 1.15em)
    v(0.25em)
    text([_Discipline_ : *#config-titre.discipline*], size: 1.1em)
    v(0.15em)
    text([_Spécialité_ : *#config-titre.speciality*], size: 1.1em)
    v(2em)
    line(stroke: 1.75pt + config-colors.primary, length: 104%)
    align(center)[#text(strong(title), size: 2em)]
    line(stroke: 1.75pt + config-colors.primary, length: 104%)
    v(1em)
    let n = 0
    for director in config-titre.supervisor {
      if n == 0 {
        if config-titre.type == "phd" {
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

    if config-titre.cosupervisor != none {
      for codirector in config-titre.cosupervisor {
        text([Co-encadrant : *codirector*], size: 1.15em)
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
        ..for (name, position, affiliation, role) in config-titre.commity {
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

#let title-page-book(
  title: none,
  author: none,
  logo: none,
  config-titre,
  config-colors
) = {
  let header = context {
    box(fill: config-colors.primary, width: 100%, inset: 1em)[
      #set align(center + horizon)
      #text(fill: white, size: 1.5em)[#strong(delta: 400)[Collection #config-titre.collection]]
    ]
  }

  let footer = context {
    box(fill: config-colors.primary, width: 100%, inset: 1em)[
      #set align(center + horizon)
      #text(fill: white, size: 1.5em)[#strong(delta: 400)[#config-titre.school]]
    ]
  }

  set page(
    header: header,
    footer: footer,
    margin: (left: 0em, right:0em, top: 4em, bottom: 4em)
  )

  let book-title = {
    align(horizon)[
      #move(dx: 2em)[
        #line(stroke: 1.5pt + config-colors.primary, length: 90%)
        #v(1em)
      ]

      #move(dx: 4em)[
        #text(size: 3em)[*#title*]
        #linebreak()

        #if config-titre.subtitle != none {
          v(0.5em)
          text(size: 1.75em)[#config-titre.subtitle]
          linebreak()
          v(0.5em)
        }

        #if config-titre.edition != none {
          v(0.5em)
          text(size: 1.25em)[_ #config-titre.edition _]
          linebreak()
          v(0.5em)
        }

        #v(0.5em)
        #text(size: 1.5em)[#author]
      ]

      #move(dx: 2em)[
        #v(1em)
        #line(stroke: 1.5pt + config-colors.primary, length: 90%)
      ]

      #if config-titre.cover-image != none {
        v(1.5em)
        align(center)[#config-titre.cover-image]
      }
    ]

    set page(header: none, footer: none, margin: auto)
    pagebreak(to: "odd")

    align(center + horizon)[
      #text(size: 3em)[*#title*]

      #if config-titre.subtitle != none {
          v(-1.5em)
          text(size: 1.75em)[#config-titre.subtitle]
          linebreak()
          v(0.5em)
        }

        #if config-titre.edition != none {
          v(0.5em)
          text(size: 1.25em)[_ #config-titre.edition _]
          linebreak()
          v(0.5em)
        }
    ]

    if logo != none {
      set image(width: 35%)
      place(bottom + center, dy: -4em, logo)
    }

    place(bottom)[
      #text(size: 0.85em)[Cette version de  peut être consultée et téléchargée gratuitement pour un usage personnel uniquement. Elle ne doit pas être redistribuée, vendue ou utilisée dans des travaux dérivés. \ #sym.copyright #author, #config-titre.year.]
    ]
  }

  book-title
}

// Chapter
#let chapter(title: none, abstract: none, toc: true, numbered: true, body) = {
  counter(math.equation).update(0)
  counter(figure.where(kind: image)).update(0)
  counter(figure.where(kind: table)).update(0)

  context{
    let numbering-heading = states.num-pattern.get()
    let num-pattern-fig = "1.1"
    let num-pattern-eq = "(1.1a)"
    if states.isappendix.get() {
      num-pattern-fig = "A.1"
      num-pattern-eq = "(A.1)"
    }

    let numbering-fig = n => {
      let h1 = counter(heading).get().first()
      numbering(num-pattern-fig, h1, n)
    }

    let numbering-eq = (..n) => {
      let h1 = counter(heading).get().first()
      numbering(num-pattern-eq, h1, ..n)
    }

    // Is the chapter numbered?
    if not numbered {
      numbering-heading = none
      numbering-eq = "(1a)"
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
      set page(header: none)
      set align(horizon)
      heading(title)

      if abstract != none {
        abstract
      }

      block(above: 3.5em)[
        #text([*#toc-header*])
        #v(-0.25em)
      ]

      line(stroke: 1.5pt + states.colors.get().secondary, length: 100%)
      v(0.25em)
      suboutline(target: heading.where(outlined: true, level: 2))
      line(stroke: 1.5pt + states.colors.get().secondary, length: 100%)
      pagebreak()

    } else {
      heading(title)
    }

    body
  }
}

// Quatrième de couverture
#let back-cover(resume: none, abstract: none) = {
  set page(header: none, footer: none)

  pagebreak(to: "even", weak: true)
  set align(horizon)
  grid(columns : 2,
    column-gutter: 1fr,
    [#align(left)[#image("resources/images/devise_cnam.svg", width: 45%)]],   [#align(right)[#image("resources/images/logo_cnam.png", width: 50%)]],
  )

  context{
    v(2em)
    align(center)[
      #text([*#states.author.get()*], size: 1.5em, fill: states.colors.get().primary)

      #text([*#states.title.get()*], size: 1.25em)

      #v(1em)
    ]
  }
  if resume != none {
    context{
      block(
        width: 100%,
        stroke: 1pt + states.colors.get().primary,
        inset: 1em,
        radius: 0.5em,
        below: 2em
      )[
        #text([*Résumé : * #resume], size: 0.9em)
      ]
    }
  }

  if abstract != none {
    context{
      block(
        width: 100%,
        stroke: 1pt + states.colors.get().primary,
        inset: 1em,
        radius: 0.5em,
        )[
        #text([*Abstract : * #abstract], size: 0.9em)
      ]
    }
  }
}