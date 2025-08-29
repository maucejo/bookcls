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
    align(right, hydra(2, book: true))
  } else {
    align(left, hydra(1))
  }
} else if states.theme.get().contains("classic") {
  align(left, hydra(2, book: true))
  v(-0.75em)
  line(stroke: 0.75pt + black, length: 100%)
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