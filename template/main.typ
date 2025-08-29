#import "../src/book.typ": *

// #let config-titre = (
//   commity: (
//     (
//       name: "Hari Seldon",
//       position: "Professeur des Universités",
//       affiliation: "Streeling university",
//       role: "Rapporteur",
//     ),
//     (
//       name: "Gal Dornick",
//       position: "Maître de conférences - HDR",
//       affiliation: "Synnax University",
//       role: "Rapporteur"
//     ),
//     (
//       name: "Ford Prefect",
//       position: "Maître de conférences",
//       affiliation: "Beltegeuse University",
//       role: "Examinateur"
//     ),
//     (
//       name: "Paul Atreides",
//       position: "Maître de conférences",
//       affiliation: "Caladan University",
//       role: "Examinateur"
//     ),
//   ),
// )

#let config-title = (
  cover-image: image("images/book-cover.jpg", width: 45%),
)

#let config-colors = (
  primary: blue,
  secondary: blue.lighten(70%),
  header: blue.lighten(50%),
)

#show: book.with(
  author: "Mathieu Aucejo",
  type: "textbook",
  config-title: config-title,
  // config-colors: config-colors,
  lang: "fr",
  // theme: "modern"
)

#show: front-matter

#include "front_matter/front_main.typ"

#show: main-matter

#tableofcontents()

#listoffigures()

#listoftables()

#part("Première partie")

#include "chapters/ch_main.typ"

// #bibliography("bibliography/sample.yml")
#bibliography("bibliography/sample.bib")

#part("Deuxième partie")

#show: appendix

#include "appendix/app_main.typ"

#back-cover(resume: lorem(100), abstract: lorem(100))