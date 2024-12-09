#import "book-params.typ": *

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

// Part
#let part(title) = {
  states.counter-part.update(i => i + 1)
  set page(
    header: none,
    footer: none,
    numbering: none
  )

    set align(center + horizon)

  state("content.switch").update(false)
  pagebreak(weak: true, to:"odd")

  line(stroke: 1.75pt + colors.red, length: 104%)
  context[
    #text(size: 2.5em)[Partie #states.counter-part.get()]
    #line(stroke: 1.75pt + colors.red, length: 35%)
    #text(size: 3em)[*#title*]
   ]
  line(stroke: 1.75pt + colors.red, length: 104%)

  context{
    show heading: none
    heading[Partie #box[#text(fill:colors.red)[#states.counter-part.get() -- #title] ]]
  }

  pagebreak(weak: true, to:"odd")
  state("content.switch").update(true)
}