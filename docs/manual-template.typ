#import "@preview/showybox:2.0.1": *
#import "@preview/hydra:0.4.0": hydra
#import "@preview/mantys:0.1.3": *
#import "@preview/cheq:0.1.0": *

#let vskip = 1em
#let typst-color = rgb(35,157,173)

#let typst = text("Typst", fill: typst-color)
#let TeX = {
  set text(font: "New Computer Modern", weight: "regular")
  box(width: 1.7em, {
    [T]
    place(top, dx: 0.56em, dy: 0.22em)[E]
    place(top, dx: 1.1em)[X]
  })
}

#let LaTeX = {
  set text(font: "New Computer Modern", weight: "regular")
  box(width: 2.55em, {
    [L]
    place(top, dx: 0.3em, text(size: 0.7em)[A])
    place(top, dx: 0.7em)[#TeX]
  })
}

#let example-box(body) = {
  showybox(
  title: [*Exemple*],
  title-style: (
    color: typst-color,
    sep-thickness: 2pt,
    boxed-style: (
      anchor: (x: center, y: horizon),
      radius: 5pt
    )
  ),
  frame: (
    title-color: white,
    border-color: typst-color,
    thickness: 1pt,
    body-inset: 1em
  ),
  align: center,
  breakable: true
  )[
    #body
  ]
}

#let manual-template(
  title: "Modèle de thèse ou de HDR",
  subtitle: "Rédaction de mémoire en Typst",
  version: "Template 0.1.0",
  typst-version: "Typst 0.11.0",
  date: datetime.today().display("[day]-[month]-[year]"),
  abstract : none,
  body
) = {

  let header = context hydra(1, display: (_, it) => {
    set align(center)
    emph(it)
  })
  set page(paper: "a4", numbering: "1/1", header: header)
  set par(justify: true)
  set text(lang: "fr", font: "Lato", size: 11pt)

  set heading(numbering: "1.1.")

  set list(indent: 2em)

  show raw: set text(font: "Liberation Mono", size: 11pt)

  // Figures
  show figure.where(kind: image): set figure(numbering: "1", supplement: "Figure", gap: 1.5em)
  show figure.where(kind: image): set figure.caption(separator: [ -- ])

  // Subfigures
  // Updates subfigure counter properly
  show figure.where(kind:image): it => {
    counter(figure.where(kind:"subfigure")).update(0)
    it
  }
  show figure.where(kind: "subfigure"): set figure.caption(separator: [ ])

  show heading.where(level: 1): it => {
    if it.numbering != none {
      [#counter(heading).display(it.numbering) #it.body]
    } else {
      it.body
    }
    v(vskip/2)
  }

  show heading.where(level: 2): it => {
    [#counter(heading).display(it.numbering) #it.body]
    v(vskip/2)
  }

  show heading.where(level: 3): it => {
    [#counter(heading).display(it.numbering) #it.body]
    v(vskip/2)
  }

  show: checklist.with(fill: typst-color.lighten(95%), stroke: typst-color, radius: .2em)

  align(center)[
	  #text(title, fill: typst-color, size: 2em) \

	  #text(subtitle)
	  #v(vskip/2)
    #block(width: 80%)[
      #date #h(1fr) #version #h(1fr) #typst-version
    ]
	  #v(vskip/2)
	  Mathieu AUCEJO
	  #v(vskip)

    #block(width: 80%)[
      #set align(left)
      #abstract
      ]
  ]
  v(vskip)
  align(center)[
      #block(width: 50%)[
      #outline(indent: 1em)
      #v(vskip)
    ]
  ]
  body
}