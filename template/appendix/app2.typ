#import "../../src/book.typ": *

#chapter("Fondements mathématiques", toc: false)[

#lorem(100)

$
  #boxeq($bold(y)_(k + 1) = bold(C) space.thin bold(x)_(k + 1)$)
$

#nonumeq($
y(x) = f(x)
$)

La @fig:B

#figure(
image("../images/chapitre1/cnam_region.png", width: 75%),
caption: [#lorem(10)],
) <fig:B>

La @b3 présente la carte du Cnam.

#subfigure(
figure(image("../images/chapitre1/cnam_region.png"), caption: []),
figure(image("../images/chapitre1/cnam_region.png"), caption: []), <b3>,
columns: (1fr, 1fr),
caption: [(a) Left image and (b) Right image],
label: <fig:subfig3>,
)

]