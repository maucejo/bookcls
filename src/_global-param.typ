#let colors = (
  red: rgb("#c1002a"),
  gray: rgb("#dddddd").darken(15%)
)

#let states = (
  localization: state("localization"),
  in-outline: state("in-outline", false),
  num-pattern: state("num-pattern", "1.1"),
  num-pattern-fig: state("num-pattern-fig", "1.1"),
  isappendix: state("isappendix", false),
  author: state("author", none),
  title: state("title", none),
)

#let fig-supplement = [Figure]
#let text-size = 12pt
#let paper-size = "a4"