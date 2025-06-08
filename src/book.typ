// Exported packages
#import "@preview/equate:0.3.2": *
// Internals
#import "book-environments.typ": *
#import "book-outlines.typ": *
#import "book-components.typ": *
#import "book-utils.typ": *
#import "book-boxes.typ": *

// Template
#let book(
  title: "Titre du document",
  author: "Nom de l'auteur",
  type: "thesis",
  lang: "fr",
  logo: image("resources/images/logo_cnam.png"),
  body-font: "Lato",
  math-font: "Lete Sans Math",
  config-titre: (:),
  config-colors: (:),
  body
) = {
  // Document's properties
  set document(author: author, title: title)

  let book-title = (:)
  if type == "thesis" {
    book-title = default-config-thesis + config-titre
  } else {
    book-title = default-config-book + config-titre
  }

  let book-colors = default-config-colors + config-colors

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
    set underline(stroke: 2pt + book-colors.secondary, offset: 8pt)
    if it.numbering != none {
      v(5em)
      block[
        #text(counter(heading).display(states.num-heading.get()), size: 4em, fill: book-colors.primary)
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
      text(counter(heading).display(), fill: book-colors.primary)
      h(0.25em)
    }
    text(it.body)
    v(-0.5em)
    line(stroke: 1.5pt + book-colors.secondary, length: 100%)
    v(1em)
  }

  show heading.where(level: 3): it => {
    if it.numbering != none {
      text(counter(heading).display(), fill: book-colors.primary)
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
      let number = it.prefix()
      let section = it.element.body
      let item = none
      if it.level == 1 {
      block(above: 1.5em, below: 0em)
        item = [#text([*#number*], fill: book-colors.primary) *#it.inner()*]
      } else {
        block(above: 1em, below: 0em)
        item = [#h(1em) #text([#number], fill: book-colors.primary) #it.inner()]
      }
      link(it.element.location(), item)
    } else if it.element.func() == figure {
      block(above: 1.25em, below: 0em)
      link(it.element.location(), [#text([#it.prefix().], fill: book-colors.primary) #h(0.2em) #it.inner()])
    } else {
      it
    }
  }

  // Figures
  show figure: set figure.caption(separator: [ -- ])

  // Table customizations
  show table.cell.where(y: 0): set text(weight: "bold", fill: white)
    set table(
    fill: (_, y) => if y == 0 {book-colors.primary} else if calc.odd(y) { book-colors.secondary.lighten(60%)},
    stroke: (x, y) => (
      left: if x == 0 or y > 0 { (thickness: 1pt, paint: book-colors.secondary) } else { (thickness: 1pt, paint: book-colors.primary) },
      right: (thickness: 1pt, paint: book-colors.secondary),
      top: if y <= 1 { (thickness: 1pt, paint: book-colors.secondary) } else { 0pt },
      bottom: (thickness: 1pt, paint: book-colors.secondary),
    )
  )

  // Tables
  show figure.where(kind: table): it => {
    set figure.caption(position: top)
    it
  }

  // Lists
  set list(marker: [#text(fill:book-colors.primary, size: 1.75em)[#sym.bullet]])
  set enum(numbering: n => text(fill:book-colors.primary)[#n.])

  // Page layout
  set page(
    paper: paper-size,
    header: page-header,
    // footer: page-footer
  )

  if book-title.custom-title-page != none {
    book-title.custom-title-page()
  } else {
    if type == "thesis" {
    title-page-thesis(
      title: title,
      author: author,
      logo: logo,
      book-title,
      book-colors,
    )
    } else {
      title-page-book(
        title: title,
        author: author,
        logo: logo,
        book-title,
        book-colors,
      )
    }
  }

  states.author.update(author)
  states.title.update(title)
  states.colors.update(book-colors)

  body
}
