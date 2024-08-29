#import "../../src/book.typ": *

#chapter("Deuxième chapitre")[

  == Objectifs
  #lorem(100)

  $
  arrow(V)(M slash R_0) = lr((d arrow(O M))/(d t)|)_(R_0) + theta
  $

  La Figure @b2 présente la carte du Cnam @Jon22.

  #subfigure(
  figure(image("../images/chapitre1/cnam_region.png"), caption: []),
  figure(image("../images/chapitre1/cnam_region.png"), caption: []), <b2>,
  columns: (1fr, 1fr),
  caption: [(a) Left image and (b) Right image],
  label: <fig:subfig2>,
  )
]