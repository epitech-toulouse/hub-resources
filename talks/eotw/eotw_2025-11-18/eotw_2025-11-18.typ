#import "@preview/deckz:0.3.1"

// #set text(size: 25pt)

= Mon titre

Un peu de #emph("contenue")

Autre chose

// #box(image("Tux.svg", height: 300pt), fill: gray, radius: 10%, inset: 10pt, stroke: red)

#let img-box(path, height) = box(image(path, height: height), fill: gray, radius: 10%, inset: 10pt, stroke: red)

#grid(
  columns: (1fr, auto, 1fr, auto, 1fr),
  align: (center, horizon),
  [], img-box("assets/tux.svg", 150pt), [], img-box("assets/windows.svg", 150pt), [],
)

#stack(
  dir: ltr,
  spacing: 1fr,
  deckz.deck("8S"),
  deckz.deck("8S", angle: 90deg, height: 2.5cm),
  deckz.deck("8S", angle: 180deg, height: 8pt, format: "small"),
  deckz.deck("8S", angle: 80deg, height: 18mm, noise: 0.5),
)
