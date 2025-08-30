#import "../../src/book.typ": *

// #show: chapter.with(title: "Premier chapitre")

= Premier chapitre
#lorem(100)
#minitoc
#pagebreak()

== Objectifs
#lorem(100)

Les équations @eq:1 et @eq:2 sont des équations très importantes.
$
integral_0^1 f(x) dif x = F(1) - F(0) "et voilà"
$ <eq:1>

$
integral_0^1 f(x) dif x = F(1) - F(0) "et voilà"
$ <eq:2>

#lorem(20)
== Code

La Figure @fig:1 illustre le cas d'industriels utilisant des absorbants.

#figure(
image("../images/chapitre1/cas_indus_absorbants.png", width: 75%),
caption: [#ls-caption([#lorem(10)], [#lorem(2)])],
) <fig:1>

La Figure @fig:subfig présente la carte du Cnam. La Figure @b illustre la région du Cnam @Smi21.

#subfigure(
figure(image("../images/chapitre1/cnam_region.png"), caption: []),
figure(image("../images/chapitre1/cnam_region.png"), caption: []), <b>,
columns: (1fr, 1fr),
caption: [(a) Left image and (b) Right image],
label: <fig:subfig>,
)

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
  ), caption: [#lorem(4)]
)

== Boxes

#lorem(10)

=== Informations

#info-box[
  #lorem(10)
]

#tip-box[
  #lorem(10)
]

#warning-box[
  #lorem(10)
]

#important-box[
  #lorem(10)
]

#proof-box[
  #lorem(10)
]

#question-box[
  #lorem(10)
]

#lorem(1000)