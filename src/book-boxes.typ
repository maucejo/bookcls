#import "@preview/showybox:2.0.3": *

// Utility
#let box-title(a, b) = {
  grid(columns: 2, column-gutter: 0.5em, align: (horizon),
    a,
    b
  )
}

#let colorize(svg, color) = {
  let blk = black.to-hex();
  if svg.contains(blk) {
    svg.replace(blk, color.to-hex())
  } else {
    svg.replace("<svg ", "<svg fill=\""+ color.to-hex() + "\" ")
  }
}

#let color-svg(
  path,
  color,
  ..args,
) = {
  let data = colorize(read(path), color)
  return image(bytes(data), ..args)
}

// Boxes
#let custom-box(title: none, icon: "info", color: rgb(29, 144, 208), body) = {
   showybox(
    title: box-title(color-svg("resources/images/icons/" + icon + ".svg", color, width: 1em), [*#title*]),
    title-style: (
      color: color,
      sep-thickness: 0pt,
    ),
    frame: (
      title-color: color.lighten(85%),
      border-color: color,
      body-color: none,
      thickness: (left: 1pt),
      radius: 0pt,
    ),
    breakable: true
  )[#body]
}

// Information box
#let info-box = custom-box.with(title: "Remarque")

// Tip box
#let tip-box = custom-box.with(title: "Astuce", icon: "tip", color: rgb(0, 166, 81))

// Warning box
#let warning-box = custom-box.with(title: "Attention", icon: "alert", color: orange)

// Important box
#let important-box = custom-box.with(title: "Important", icon: "stop", color: rgb("#f74242"))

// Proof box
#let proof-box = custom-box.with(title: "Démonstration", icon: "report", color: eastern)

// Question box
#let question-box = custom-box.with(title: "Question", icon: "question", color: purple)