#import "@preview/subpar:0.2.2"
#import "@preview/hydra:0.6.2": hydra
#import "@preview/suboutline:0.3.0": *
#import "book-params.typ": *

// Equations
#let boxeq(body) = {
  set align(center)
  context{
    box(
      stroke: 1pt + states.colors.get().boxeq.darken(35%),
      radius: 5pt,
      inset: 0.6em,
      fill: states.colors.get().boxeq,
    )[#body]
  }
}

#let nonumeq(x) = {
   set math.equation(numbering: none)
   x
}

// Subfigure
#let subfigure = subpar.grid.with(
  gap: 1em,
  numbering: n => {numbering(states.num-pattern-fig.get(), counter(heading).get().first() , n)},
  numbering-sub-ref: (m, n) => {numbering(states.num-pattern-subfig.get(), counter(heading).get().first(), m, n)},
  supplement: fig-supplement
)

// Long and short captions for figures or tables
#let ls-caption(long, short) = context if states.in-outline.get() { short } else { long }

// Page header and footer - add empty page if necessary
#let page-header = context if states.theme.get().contains("fancy") {
  set text(style: "italic", fill: states.colors.get().header)
  if calc.odd(here().page()) {
    align(right, hydra(2))
  } else {
    align(left, hydra(1))
  }
} else if states.theme.get().contains("classic") {
  if calc.odd(here().page()) {
    align(left, hydra(2, display: (_, it) => [
    #let head = none
    #if it.numbering != none {
      head = numbering(it.numbering, ..counter(heading).at(it.location())) + " " + it.body
    } else {
      head = it.body
    }
    #head
    #place(dx: 0%, dy: 12%)[#line(length: 100%, stroke: 0.75pt)]
  ]))
  } else {
    align(left, hydra(1, display: (_, it) => [
    #let head = counter(heading.where(level:1)).display() + " " + it.body
    #if it.numbering == none {
      head = it.body
    }
    #head
    #place(dx: 0%, dy: 12%)[#line(length: 100%, stroke: 0.75pt)]
  ]))
  }
} else if states.theme.get().contains("modern") {
    set text(style: "italic")
    if calc.odd(here().page()) {
      align(right)[
        #hydra(2, display: (_, it) => [
          #let head = none
          #if it.numbering != none {
            head = numbering(it.numbering, ..counter(heading).at(it.location())) + " " + it.body
          } else {
            head = it.body
          }
          #let size = measure(head)
          #head
          #place(dx: -16%, dy: -6.5%)[#line(length: 115% - size.width, stroke: 0.5pt + states.colors.get().primary)]
          #place(dx: 98.5% - size.width, dy: -12%)[#circle(fill: states.colors.get().primary, stroke: none, radius: 0.25em)]
        ])
      ]
    } else {
    align(left)[
      #hydra(1, display: (_, it) => [
        #let head = counter(heading.where(level:1)).display() + " " + it.body
        #if it.numbering == none {
          head = it.body
        }
        #let size = measure(head)
        #head
        #place(dx: size.width, dy: -12%)[#circle(fill: states.colors.get().primary, stroke: none, radius: 0.25em)]
        #place(dx: size.width + 1%, dy: -6.5%)[#line(length: 100%, stroke: 0.5pt + states.colors.get().primary)]
        ]
      )
    ]
  }
}

#let page-footer = context {
    let cp = counter(page).get().first()
    let current-page = counter(page).display()
    set text(fill: white, weight: "bold")
    v(1.5em)
    if calc.odd(cp) {
      set align(right)
      box(outset: 6pt, fill: states.colors.get().primary, width: 1.5em, height: 100%)[
        #set align(center)
        #current-page
        ]
    } else {
      set align(left)
      box(outset: 6pt, fill: states.colors.get().primary, width: 1.5em, height: 100%)[
        #set align(center)
        #current-page
      ]
      }
  }

// Minitoc
#let minitoc = context {
  let toc-header = states.localization.get().toc
  block(above: 3.5em)[
    #text([*#toc-header*])
    #v(-0.5em)
  ]

  let miniline = line(stroke: 1.5pt + states.colors.get().secondary, length: 100%)
  if states.theme.get().contains("classic"){
    miniline = line(stroke: 0.75pt, length: 100%)
  }

  miniline
  v(0.5em)
  suboutline(target: heading.where(outlined: true, level: 2))
  miniline
}

// Conditional set-show
#let show-if(cond, func) = body => if cond { func(body) } else { body }