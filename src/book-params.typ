#let default-config-colors = (
  primary: rgb("#c1002a"),
  secondary: rgb("#dddddd").darken(15%),
  boxeq: rgb("#dddddd"),
  header: rgb("#dddddd").darken(25%)
)

#let default-config-thesis = (
  type: "these",
  school: "Conservatoire National des Arts et Métiers",
  doctoral-school: "Sciences des Métiers de l'Ingénieur",
  supervisor: ("Nom du directeur de thèse",),
  cosupervisor: none,
  laboratory: "Nom du laboratoire",
  defense-date: "01 janvier 1970",
  discipline: "Mécanique, Génie Mécanique, Génie Civil",
  speciality: "Mécanique",
  commity: (),
)

#let states = (
  localization: state("localization"),
  in-outline: state("in-outline", false),
  num-pattern: state("num-pattern", "1.1."),
  num-pattern-fig: state("num-pattern-fig", "1.1"),
  num-heading: state("num-heading", "1"),
  page-numbering: state("page-numbering", "1/1"),
  isappendix: state("isappendix", false),
  isbackcover: state("isbackcover", false),
  author: state("author", none),
  title: state("title", none),
  counter-part: state("counter-part", 0),
  colors: state("theme-colors"),
)

#let fig-supplement = [Figure]
#let text-size = 12pt
#let paper-size = "a4"