#import "../../src/book.typ": *

#chapter("Algorithmes", toc: false)[

  #lorem(100)

  La Figure @fig:A illustre le cas d'industriels utilisant des absorbants.

  #figure(
  image("../images/chapitre1/cnam_region.png", width: 75%),
  caption: [#lorem(10)],
  ) <fig:A>

  #figure(
  table(
    columns: 3,
    table.header(
      [Substance],
      [Subcritical °C],
      [Supercritical °C],
    ),
    [Hydrochloric Acid],
    [12.0], [92.1],
    [Sodium Myreth Sulfate],
    [16.6], [104],
    [Potassium Hydroxide],
    table.cell(colspan: 2)[24.7],
  ), caption: [#lorem(2)]
  )

]