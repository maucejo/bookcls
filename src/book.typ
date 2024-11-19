// Exported packages
#import "@preview/equate:0.2.1": *
// Internals
#import "_book-environments.typ": *
#import "_book-outlines.typ": *
#import "_book-components.typ": *
#import "_book-utils.typ": *

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
  speciality: "Mécanique",
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

  // Equations
  show: equate.with(breakable: true, sub-numbering: true)

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
    state("content.switch").update(false)
    pagebreak(weak: true, to:"odd")
    state("content.switch").update(true)

    // Title body
    set align(right)
    set underline(stroke: 2pt + colors.gray, offset: 8pt)
    if it.numbering != none {
      v(5em)
      block[
        #text(counter(heading).display(states.num-heading.get()), size: 4em, fill: colors.red)
        #v(-3em)
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
      text(counter(heading).display(), fill: colors.red)
      h(0.25em)
    }
    text(it.body)
    v(-0.5em)
    line(stroke: 1.5pt + colors.gray, length: 100%)
    v(1em)
  }

  show heading.where(level: 3): it => {
    if it.numbering != none {
      text(counter(heading).display(), fill: colors.red)
      h(0.25em)
    }
    text(it.body)
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

  // Page layout
  set page(
    paper: paper-size,
    header: page-header,
    footer: page-footer
  )

  title-page(
    title: title,
    author: author,
    type: type,
    defense-date: defense-date,
    school: school,
    discipline: discipline,
    speciality: speciality,
    supervisor: supervisor,
    cosupervisor: cosupervisor,
    commity: commity,
    logo: logo
  )

  states.author.update(author)
  states.title.update(title)

  body
}
