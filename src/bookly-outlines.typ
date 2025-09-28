#import "bookly-helper.typ": *

// Table of contents
#let tableofcontents = {
  // set page(margin: auto)
  set outline.entry(fill: box(width: 1fr, repeat(gap: 0.25em)[.]))
  show outline.entry: it => context {
    let dxl = 0%
    let dxr = 0%
    if states.layout.get().contains("tufte") {
      dxl = 8.17%
      dxr = -17%
    }
    show: move.with(dx: dxl)
    fullwidth(dx: dxr, it)
  }
  outline(title: context states.localization.get().toc, indent: 1em)
}

// List of figures
#let listoffigures = {
  set outline.entry(fill: box(width: 1fr, repeat(gap: 0.25em)[.]))
  show outline.entry: it => context {
    let dxl = 0%
    let dxr = 0%
    if states.layout.get().contains("tufte") {
      dxl = 8.17%
      dxr = -17%
    }
    show: move.with(dx: dxl)
    fullwidth(dx: dxr, it)
  }
  outline(title: context states.localization.get().lof, target: figure.where(kind: image))
}

// List of tables
#let listoftables = {
  set outline.entry(fill: box(width: 1fr, repeat(gap: 0.25em)[.]))
  show outline.entry: it => context {
    let dxl = 0%
    let dxr = 0%
    if states.layout.get().contains("tufte") {
      dxl = 8.17%
      dxr = -17%
    }
    show: move.with(dx: dxl)
    fullwidth(dx: dxr, it)
  }
  outline(title: context states.localization.get().lot, target: figure.where(kind: table))
}