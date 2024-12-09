#let colors = (
  red: rgb("#c1002a"),
  gray: rgb("#dddddd").darken(15%)
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
)

#let fig-supplement = [Figure]
#let text-size = 12pt
#let paper-size = "a4"