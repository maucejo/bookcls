#import "book-params.typ": *

// Table of contents
#let tableofcontents() = {
  context{
    let localization = states.localization.get()
    set outline.entry(fill: box(width: 1fr, repeat(gap: 0.25em)[.]))
    outline(title: localization.toc, indent: 1em)
  }
}

// List of figures
#let listoffigures() = {
  context{
    let localization = states.localization.get()
    set outline.entry(fill: box(width: 1fr, repeat(gap: 0.25em)[.]))
    outline(title: localization.tof, target: figure.where(kind: image))
  }
}

// List of tables
#let listoftables() = {
  context{
    let localization = states.localization.get()
    set outline.entry(fill: box(width: 1fr, repeat(gap: 0.25em)[.]))
    outline(title: localization.tot, target: figure.where(kind: table))
  }
}