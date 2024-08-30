// Exported packages
// Internals
#import "_environments.typ": *
#import "_outlines.typ": *
#import "_chapter.typ": *
#import "_utils.typ": *

// Template
#let book(
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
  logo: image("resources/images/logo_cnam.png"),
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

  // Localization
  let localization = json("resources/i18n/fr.json")
  if lang == "en" {
    localization = json("resources/i18n/en.json")
  }
  states.localization.update(localization)

  // Headings
  set heading(numbering: "1.1")

  show heading.where(level: 1): it => {
    // Clear page if necessary
    pagebreak(to: "odd")
    // Title body
    set align(right)
    set underline(stroke: 2pt + colors.gray, offset: 8pt)
    if it.numbering != none {
      v(5em)
      block[
        #text(counter(heading).display(it.numbering), size: 4em, fill: colors.red)

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
        #text(counter(heading).display(it.numbering), fill: colors.red)
        #text(it.body)
        #v(-0.5em)
        #line(stroke: 1.5pt + colors.gray, length: 100%)
      ]
    } else {
      block[
        #text(it.body)
        #v(-0.5em)
        #line(stroke: 2pt + colors.gray, length: 100%)
      ]
    }
    v(1em)
  }

  show heading.where(level: 3): it => {
    if it.numbering != none {
      block[
        #text(counter(heading).display(it.numbering), fill: red-color)
        #text(it.body)
      ]
    } else {
      block[
        #text(it.body)
      ]
    }
    v(1em)
  }

  // References
  set ref(supplement: it => none)

  // Outline entries
  show outline.entry: it => {
    if it.element.func() == heading {
      if it.body.has("children") {
        let (number, .., body) = it.body.children
        let item = none
        let item-number = box(width: 1fr, it.fill) + h(0.25em) + it.page
        if it.level == 1 {
          block(above: 1.5em, below: 0em)
          item = [#text([*#number*], fill: colors.red) #h(0.15em) #strong(body) #h(0.15em)]
        } else {
          item = [#text([#number], fill: colors.red) #h(0.15em) #body #h(0.15em)]
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
        link(it.element.location(), [#type #text(counter, fill: colors.red) #body.join()])
    } else {
      it
    }
  }

  // Figures
  show figure: set figure.caption(separator: [ -- ])

  // Table customizations
  show table.cell.where(y: 0): set text(weight: "bold", fill: white)
    set table(
    fill: (_, y) => if y == 0 {colors.red} else if calc.odd(y) { colors.gray.lighten(60%)},
    stroke: (x, y) => (
      left: if x == 0 or y > 0 { (thickness: 1pt, paint: colors.gray) } else { (thickness: 1pt, paint: colors.red) },
      right: (thickness: 1pt, paint: colors.gray),
      top: if y <= 1 { (thickness: 1pt, paint: colors.gray) } else { 0pt },
      bottom: (thickness: 1pt, paint: colors.gray),
    )
  )

  // Tables
  show figure.where(kind: table): it => {
    set figure.caption(position: top)
    it
  }

  // Lists
  set list(marker: [#text(fill:colors.red, size: 1.75em)[#sym.bullet]])
  set enum(numbering: n => text(fill:red-color)[#n.])

  // Title page
  place(top + left, dx: -16%, dy: -10%,
      rect(fill: colors.red, height: 121%, width: 20%)
  )

  let title-page = {
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
      {title-page}
    )
  )

  states.author.update(author)
  states.title.update(title)

  body
}
