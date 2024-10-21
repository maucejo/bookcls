#import "_global-param.typ": *

// Table of contents
#let tableofcontents() = {
  context{
    let localization = states.localization.get()
      outline(title: localization.toc, indent: 1em)
  }
}

// List of figures
#let listoffigures() = {
  context{
    let localization = states.localization.get()
    outline(title: localization.tof, target: figure.where(kind: image))
  }
}

// List of tables
#let listoftables() = {
  context{
    let localization = states.localization.get()
    outline(title: localization.tot, target: figure.where(kind: table))
  }
}