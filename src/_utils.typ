#import "@preview/subpar:0.1.1"
#import "_global-param.typ": *

// Equations
#let boxeq(body) = {
  set align(center)
  box(
    stroke: 1pt + colors.gray,
    radius: 5pt,
    inset: 0.5em,
    fill: colors.gray.lighten(60%),
  )[#body]
}

#let nonumeq(x) = {
   set math.equation(numbering: none)
   x
}

// Subfigure
#let subfigure = {
  subpar.grid.with(
    numbering: n => if states.isappendix.get() {numbering("A.1", counter(heading).get().first(), n)
      } else {
        numbering("1.1", counter(heading).get().first() , n)
      },
    numbering-sub-ref: (m, n) => if states.isappendix.get() {numbering("A.1a", counter(heading).get().first(), m, n)
      } else {
        numbering("1.1a", counter(heading).get().first(), m, n)
      },
    supplement: fig-supplement
  )
}

// Long and short captions for figures or tables
#let ls-caption(long, short) = context { if states.in-outline.get() { short } else {
long }}

// Font exists ?
#let checkfont(font) = context {
		let res = true
    let size = measure(text(font: font, fallback: false)[
        Test
    ])

    if size.width == 0pt {
        res = false
    }

		return res
}

#let pagebreak-to-odd = context {
  let n = here().page()
  if calc.odd(n) {
    page(header: [], footer: [])[]
  } else if calc.even(n) {
    v(100%, weak: true)
  }
}