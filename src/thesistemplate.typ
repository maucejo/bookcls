// Exported packages
// Internals
#import "@preview/minitoc:0.1.0": *
#import "@preview/subpar:0.1.1"

// Global parameters
#let primary-color = rgb("#c1002a")
#let secondary-color = rgb("#dddddd").darken(15%)
#let slang = state("slang", "fr")
#let in-outline = state("in-outline", false)
#let num-pattern = state("num-pattern", "1.1")
#let isappendix = state("isappendix", false)
#let thesis-author = state("thesis-author", none)
#let thesis-title = state("thesis-title", none)
#let fig-supplement = [Figure]
#let text-size = 11pt
#let paper-size = "a4"

// Environnements
// Front matter
#let front-matter(body) = {
  set heading(numbering: none)
  set page(numbering: "i")
  num-pattern.update(none)
  counter(page).update(1)

  body
}

// Main matter
#let main-matter(body) = {
  set page(numbering: "1/1")
  num-pattern.update("1.1")
  counter(page).update(1)

  body
}

// Main matter
#let back-matter(body) = {
  set page(numbering: none)

  body
}

// Appendix
#let appendix(body) = {
  set page(numbering: "1/1")
  set heading(numbering: "A")
  // Reset heading counter
  counter(heading.where(level: 1)).update(0)
  // Reset heading counter for the table of contents
  counter(heading).update(0)
  num-pattern.update("A.1")
  isappendix.update(true)

  body
}

// Outlines
// Table of contents
#let tableofcontents() = {
  context{
    if slang.get() == "fr" {
      outline(title: "Table des matières", indent: 1em)
    } else {
      outline(title: "Table of contents", indent: 1em)
    }
  }
}

// List of figures
#let listoffigures() = {
  context{
    if slang.get() == "fr" {
      outline(title: "Table des figures", target: figure.where(kind: image))
    } else {
      outline(title: "List of figures", target: figure.where(kind: image))
    }
  }
}

// List of tables
#let listoftables() = {
  context{
    if slang.get() == "fr" {
      outline(title: "Table des tableaux", target: figure.where(kind: table))
    } else {
      outline(title: "List of tables", target: figure.where(kind: table))
    }
  }
}

// Equations
#let boxeq(body) = {
  set align(center)
  box(
    stroke: 1pt + secondary-color,
    radius: 5pt,
    inset: 0.5em,
    fill: secondary-color.lighten(60%),
  )[#body]
}

#let nonumeq(x) = {
   set math.equation(numbering: none)
   x
}

// Subfigure
#let subfigure = {
  subpar.grid.with(
    numbering: n => if isappendix.get() {numbering("A.1", counter(heading).get().first(), n)
      } else {
        numbering("1.1", counter(heading).get().first() , n)
      },
    numbering-sub-ref: (m, n) => if isappendix.get() {numbering("A.1a", counter(heading).get().first(), m, n)
      } else {
        numbering("1.1a", counter(heading).get().first(), m, n)
      },
    supplement: fig-supplement
  )
}

// Long and short captions for figures or tables
#let ls-caption(long, short) = context { if in-outline.get() { short } else {
long }}

// Chapter
#let chapter(title, abstract: none, toc: true, numbered: true, body) = {
  counter(math.equation).update(0)
  counter(figure.where(kind: image)).update(0)
  counter(figure.where(kind: table)).update(0)

  context{
    let numbering-heading = num-pattern.get()
    let numbering-fig = n => {
      let h1 = counter(heading).get().first()
      numbering(numbering-heading, h1, n)
    }

    let num-pattern-eq = "(1.1)"
    if isappendix.get() {
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

    if toc {
      set align(horizon)
      heading(title)

      if abstract != none {
        abstract
      }

      block(above: 3.5em)[
          #if slang.get() == "fr" {
            text([*Table des matières*])
            v(-0.25em)
          } else {
            text([*Table of contents*])
            v(-0.25em)
          }
      ]

      line(stroke: 2pt + secondary-color, length: 100%)
      minitoc(target: heading.where(outlined: true, level: 2))
      line(stroke: 2pt + secondary-color, length: 100%)
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
    [#align(left)[#image("assets/devise_cnam.svg", width: 45%)]],   [#align(right)[#image("assets/logo_cnam.png", width: 50%)]],
  )

  context{
    v(2em)
    align(center)[
      #text([*#thesis-author.get()*], size: 1.5em, fill: primary-color)

      #text([*#thesis-title.get()*], size: 1.25em)

      #v(1em)
    ]
  }
  if resume != none {
    block(
      width: 100%,
      stroke: 1pt + primary-color,
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
      stroke: 1pt + primary-color,
      inset: 1em,
      radius: 0.5em,
      )[
      #text([*Abstract : * #abstract], size: 0.9em)
    ]
  }
}

// Font exists ?
#let checkfont(font) = context {
		let res = true
    let size = measure(text(font: font, fallback: false)[
        Test
    ])

    if size.width == 0pt {
        res = false
    }

		return res
}

// Template
#let thesistemplate(
  title: "Titre de la thèse",
  author: "Nom du candidat",
  type: "these",
  school: "Conservatoire National des Arts et Métiers",
  doctoral-school: "Sciences des Métiers de l'Ingénieur",
  supervisor: ("Nom du directeur de thèse",),
  cosupervisor: none,
  laboratory: "Nom du laboratoire",
  defense-date: "01 janvier 1970",
  discipline: "Mécanique, Génie Mécanique, Génie Civil",
  specialty: "Mécanique",
  commity: (),
  lang: "fr",
  logo: "assets/logo_cnam.png",
  body-font: "Lato",
  math-font: "Lete Sans Math",
  body
) = {
  // Document's properties
  set document(author: author, title: title)

  // Fonts
  set text(font: body-font, lang: lang, size: text-size)

  // Math font

  let math-fonts = (math-font, "New Computer Modern Math")
  show math.equation: set text(font: math-fonts, stylistic-set: 1)

  // Page layout
  set page(paper: paper-size)

  // Paragraphs
  set par(justify: true)

  // Headings
  set heading(numbering: "1.1")

  show heading.where(level: 1): it => {
    // Clear page if necessary
    pagebreak(to: "odd")
    // Title body
    set align(right)
    set underline(stroke: 2pt + secondary-color, offset: 8pt)
    if it.numbering != none {
      v(5em)
      block[
        #text(counter(heading).display(it.numbering), size: 4em, fill: primary-color)

        #text(underline(it.body), size: 1.5em)
      ]
      v(5em)
    } else {
      v(1em)
      text(underline(it.body), size: 1.5em)
      v(2em)
    }
  }

  show heading.where(level: 2): it => {
    if it.numbering != none {
      block[
        #text(counter(heading).display(it.numbering), fill: primary-color)
        #text(it.body)
        #v(-0.5em)
        #line(stroke: 2pt + secondary-color, length: 100%)
      ]
    } else {
      block[
        #text(it.body)
        #v(-0.5em)
        #line(stroke: 2pt + secondary-color, length: 100%)
      ]
    }
    v(1em)
  }

  show heading.where(level: 3): it => {
    if it.numbering != none {
      block[
        #text(counter(heading).display(it.numbering), fill: primary-color)
        #text(it.body)
      ]
    } else {
      block[
        #text(it.body)
      ]
    }
    v(1em)
  }

  // Outline
  show outline: it => {
    in-outline.update(true)
    // Show table of contents, list of figures, list of tables, etc. in the table of contents
    set heading(outlined: true)
    it
    in-outline.update(false)
  }

  // Outline entries
  show outline.entry: it => {
    if it.element.func() == heading {
      if it.body.has("children") {
        let (number, .., body) = it.body.children
        let item = none
        let item-number = box(width: 1fr, it.fill) + h(0.25em) + it.page
        if it.level == 1 {
          block(above: 1.5em, below: 0em)
          item = [#text([*#number*], fill: primary-color) #h(0.15em) #strong(body) #h(0.15em)]
        } else {
          item = [#text([#number], fill: primary-color) #h(0.15em) #body #h(0.15em)]
        }
        link(it.element.location(), item + item-number)

      } else {
        let item = none
        if it.level == 1 {
          block(above: 1.25em, below: 0em)
          item = strong(it.body) + h(0.15em) + box(width: 1fr, it.fill) + h(0.25em) + it.page
        } else {
          item = it.body + h(0.15em) + box(width: 1fr, it.fill) + h(0.25em) + it.page
        }
        link(it.element.location(), item)
      }
    } else if it.element.func() == figure {
        block(above: 1.25em, below: 0em)
        let (type, _, counter, ..body) = it.body.children
        link(it.element.location(), [#type #text(counter, fill: primary-color) #body.join()])
    } else {
      it
    }
  }

  // Figures
  show figure: set figure.caption(separator: [ -- ])

  // Table customizations
  show table.cell.where(y: 0): set text(weight: "bold", fill: white)
    set table(
    fill: (_, y) => if y == 0 {primary-color} else if calc.odd(y) { secondary-color.lighten(60%)},
    stroke: (x, y) => (
      left: if x == 0 or y > 0 { (thickness: 1pt, paint: secondary-color) } else { (thickness: 1pt, paint: primary-color) },
      right: (thickness: 1pt, paint: secondary-color),
      top: if y <= 1 { (thickness: 1pt, paint: secondary-color) } else { 0pt },
      bottom: (thickness: 1pt, paint: secondary-color),
    )
  )

  // Tables
  show figure.where(kind: table): it => {
    set figure.caption(position: top)
    it
  }

  // Lists
  set list(marker: [#text(fill:primary-color, size: 1.75em)[#sym.bullet]])
  set enum(numbering: n => text(fill:primary-color)[#n.])

  // Title page
  place(top + left, dx: -16%, dy: -10%,
      rect(fill: primary-color, height: 121%, width: 20%)
  )

  let title-page = {
    if logo != none {
    set image(width: 35%)
    place(top + right, dx: 0%, dy: -15%, image(logo))
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
    line(stroke: 1.75pt + primary-color, length: 104%)
    align(center)[#text(strong(title), size: 2em)]
    line(stroke: 1.75pt + primary-color, length: 104%)
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
      {title-page}
    )
  )

  thesis-author.update(author)
  thesis-title.update(title)

  body
}
