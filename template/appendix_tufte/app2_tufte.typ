#import "@preview/bookly:1.0.0": *
// #import "../../src/bookly.typ": *

// #show: chapter.with(
//   title: "Foundations",
//   toc: false
// )

= Foundations

#lorem(100)

$
  #boxeq($bold(y)_(k + 1) = bold(C) space.thin bold(x)_(k + 1)$)
$

#nonumeq($
y(x) = f(x)
$)

Figure @fig:B #lorem(10)

#figure(
image("../images/typst-logo.svg", width: 75%),
caption: [#lorem(10)],
) <fig:B>

Figure @b3 #lorem(50)

#subfigure(
figure(image("../images/typst-logo.svg"), caption: []),
figure(image("../images/typst-logo.svg"), caption: []), <b3>,
columns: (1fr, 1fr),
caption: [(a) Left image and (b) Right image],
label: <fig:subfig3>,
)