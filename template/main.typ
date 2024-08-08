#import "@preview/thesistemplate:0.2.1": *

#show: thesistemplate.with(
  author: "Mathieu Aucejo",
  commity: (
    (
      name: "Hari Seldon",
      position: "Professeur des Universités",
      affiliation: "Streeling university",
      role: "Rapporteur",
    ),
    (
      name: "Gal Dornick",
      position: "Maître de conférences - HDR",
      affiliation: "Synnax University",
      role: "Rapporteur"
    ),
    (
      name: "Ford Prefect",
      position: "Maître de conférences",
      affiliation: "Beltegeuse University",
      role: "Examinateur"
    ),
    (
      name: "Paul Atreides",
      position: "Maître de conférences",
      affiliation: "Caladan University",
      role: "Examinateur"
    ),
  )
)

#show: front-matter

#include "front_matter/front_main.typ"

#show: main-matter

#tableofcontents()

#listoffigures()

#listoftables()

#include "chapters/ch_main.typ"

#bibliography("bibliography/sample.yml")
// #bibliography("bibliographie/sample.bib")

#show: appendix

#include "appendix/app_main.typ"

#back-cover(resume: lorem(100), abstract: lorem(100))