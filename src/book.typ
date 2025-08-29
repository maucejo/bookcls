// Exported packages
#import "@preview/equate:0.3.2": *
// Internals
#import "book-environments.typ": *
#import "book-outlines.typ": *
#import "book-components.typ": *
#import "book-utils.typ": *
#import "book-theming.typ": *

// Template
#let book(
  title: "Titre du document",
  author: "Nom de l'auteur",
  type: "thesis",
  lang: "fr",
  logo: image("resources/images/logo_cnam.png"),
  body-font: "Lato",
  math-font: "Lete Sans Math",
  config-title: (:),
  config-colors: (:),
  theme: "fancy",
  body
) = context {
  // Document's properties
  set document(author: author, title: title)

  let book-title = (:)
  if type.contains("thesis") {
    book-title = default-config-thesis + config-title
  } else {
    book-title = default-config-book + config-title
  }

  let book-colors = default-config-colors + config-colors

  // Fonts
  let body-fonts = (body-font, "New Computer Modern")
  set text(font: body-fonts, lang: lang, size: text-size)

  // Math font
  let math-fonts = (math-font, "New Computer Modern Math")
  show math.equation: set text(font: math-fonts, stylistic-set: 1)

  // Equations
  show: equate.with(breakable: true, sub-numbering: true)

  // Paragraphs
  set par(justify: true)

  // Localization
  let localization = json("resources/i18n/fr.json")
  if lang.contains("en") {
    localization = json("resources/i18n/en.json")
  }
  states.localization.update(localization)

  // Headings
  show: heading-level1
  show: heading-level2
  show: heading-level3
  show: headings-on-odd-page

  // References
  set ref(supplement: it => none)

  // Outline entries
  set outline(depth: 3)
  show: outline-entry

  // Figures
  let numbering-fig = n => {
      let h1 = counter(heading).get().first()
      numbering(states.num-pattern-fig.get(), h1, n)
  }

  show figure.where(kind: image): set figure(
      supplement: fig-supplement,
      numbering: numbering-fig,
      gap: 1.5em
    )

  show figure: set figure.caption(separator: [ -- ])

  // Equations
  let numbering-eq = (..n) => {
    let h1 = counter(heading).get().first()
    numbering(states.num-pattern-eq.get(), h1, ..n)
  }

  set math.equation(numbering: numbering-eq)

  // Table customizations
  show: show-if(theme.contains("fancy"), it => {
    show table.cell.where(y: 0): set text(weight: "bold", fill: white)
    set table(
    fill: (_, y) => if y == 0 {book-colors.primary} else if calc.odd(y) { book-colors.secondary.lighten(60%)},
    stroke: (x, y) => (
      left: if x == 0 or y > 0 { (thickness: 1pt, paint: book-colors.secondary) } else { (thickness: 1pt, paint: book-colors.primary) },
      right: (thickness: 1pt, paint: book-colors.secondary),
      top: if y <= 1 { (thickness: 1pt, paint: book-colors.secondary) } else { 0pt },
      bottom: (thickness: 1pt, paint: book-colors.secondary),
    )
  ); it})


  // Tables
  show figure.where(kind: table): set figure(
    numbering: numbering-fig,
    gap: 1.5em
  )
  show figure.where(kind: table): it => {
    set figure.caption(position: top)
    it
  }

  // Lists
  set list(marker: [#text(fill:book-colors.primary, size: 1.75em)[#sym.bullet]])
  set enum(numbering: n => text(fill:book-colors.primary)[#n.])

  if book-title.custom-title-page != none {
    book-title.custom-title-page
  } else {
    if type.contains("thesis") {
      title-page-thesis(
        title: title,
        author: author,
        logo: logo,
        book-title,
        book-colors,
        paper-size
      )
    } else {
      title-page-book(
        title: title,
        author: author,
        logo: logo,
        book-title,
        book-colors,
        paper-size
      )
    }
  }

  // Page layout
  set page(
    paper: paper-size,
    header: page-header,
    footer: page-footer
  ) if theme.contains("modern")

  set page(
    paper: paper-size,
    header: page-header,
  ) if theme.contains("fancy") or theme.contains("classic")

  states.author.update(author)
  states.title.update(title)
  states.theme.update(theme)
  states.colors.update(book-colors)

  body
}
