#import "../../src/book.typ": *

// #show: chapter.with(
//   title: "Introduction",
//   abstract: [#lorem(50)],
//   numbered: false
// )

#show: chapter-nonum.with()
= Introduction

== Objectifs

#lorem(100)

#lorem(25)

$
y = f(x) \
g = h(x)
$

#v(1.25em)
=== Sous-objectifs

#figure(
image("../images/chapitre1/cas_indus_absorbants.png", width: 75%),
caption: [#ls-caption([#lorem(10)], [#lorem(2)])],
) <fig:intro>

#lorem(50)

#pagebreak()
== Méthodologie

#lorem(1000)