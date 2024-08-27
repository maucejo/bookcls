#import "_global-param.typ": *

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