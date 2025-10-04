#import "@preview/bookly:1.0.0": *
// #import "../../src/bookly.typ": *

// #show: chapter.with(
//   title: "Algorithms",
//   toc: false
// )

= Algorithms

#lorem(100)

Figure @fig:A is a beautiful typst logo.

#figure(
image("../images/typst-logo.svg", width: 75%),
caption: [#lorem(10)],
) <fig:A>

#lorem(20)

#sidefigure(dy: -4em)[
  #figure(
    table(
      columns: 2,
      [A], [B],
      [1], [2],
      [3], [4],
    ),
    caption: [#lorem(2)],
  )
]

== Test

#lorem(100)
