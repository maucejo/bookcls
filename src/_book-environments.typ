#import "_book-params.typ": *

#let front-matter(body) = {
  set heading(numbering: none)
  set page(numbering: "i")
  states.page-numbering.update("i")
  states.num-pattern.update(none)
  counter(page).update(0)

  body
}

// Main matter
#let main-matter(body) = {
  set page(numbering: "1/1")
  states.page-numbering.update("1/1")
  states.num-heading.update("1")
  states.num-pattern.update("1.1.")
  counter(page).update(1)

  body
}

// Main matter
#let back-matter(body) = {
  set page(numbering: none)

  body
}

// Appendix
#let appendix(body) = {
  set page(numbering: "1/1")
  // Reset heading counter
  counter(heading.where(level: 1)).update(0)
  // Reset heading counter for the table of contents
  counter(heading).update(0)
  states.num-heading.update("A")
  states.num-pattern.update("A.1.")
  states.isappendix.update(true)

  body
}