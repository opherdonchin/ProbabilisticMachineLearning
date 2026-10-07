// Constrained slide-design document language.
//
// This is intentionally more opinionated than course.typ. It renders a
// document-oriented design specification rather than a slide deck. Semantic
// object names stay close to production names; spatial and reveal choices
// remain abstract and are rendered as sketches.

#set page(
  paper: "a4",
  margin: (x: 18mm, y: 16mm),
)
#set text(size: 10.5pt)
#set par(leading: 0.65em)

#let design-accent = rgb("#315c7d")
#let design-muted = rgb("#666666")
#let design-rule = rgb("#c8ced3")
#let design-warn = rgb("#fff3cf")

#let _require(value, message) = {
  assert(value != none, message: message)
  value
}

#let _object(
  kind,
  body,
  label: none,
  title: none,
  from: none,
  caption: none,
  unresolved: false,
) = {
  let label = _require(label, "design object requires label: [...]")
  (
    kind: kind,
    label: label,
    body: body,
    title: title,
    from: from,
    caption: caption,
    unresolved: unresolved,
  )
}

#let card(body, label: none, title: none) =
  _object("card", body, label: label, title: title)

#let bordered-card(body, label: none, title: none) =
  _object("bordered-card", body, label: label, title: title)

#let recall-card(
  body,
  label: none,
  from: none,
  title: none,
  heading: [Carried forward],
) = {
  let from = _require(from, "recall-card requires from: [...]")
  _object(
    "recall-card",
    body,
    label: label,
    title: if title == none { heading } else { title },
    from: from,
  )
}

#let figure-card(
  body,
  label: none,
  from: none,
  caption: none,
  title: none,
) = _object(
  "figure-card",
  body,
  label: label,
  title: title,
  from: from,
  caption: caption,
)

#let schema-card(
  body,
  label: none,
  from: none,
  caption: none,
  title: none,
) = _object(
  "schema-card",
  body,
  label: label,
  title: title,
  from: from,
  caption: caption,
)

#let key-points(body, label: none, title: [Key points]) =
  _object("key-points", body, label: label, title: title)

#let section-summary-visual(body, label: none, title: [Summary visual]) =
  _object("section-summary-visual", body, label: label, title: title)

#let section-summary-takeaways(body, label: none, title: [Summary takeaways]) =
  _object("section-summary-takeaways", body, label: label, title: title)

#let design-card(body, label: none, title: [Unresolved card]) =
  _object(
    "design-card",
    body,
    label: label,
    title: title,
    unresolved: true,
  )

#let design-content(body, label: none, title: [Unresolved content]) =
  _object(
    "design-content",
    body,
    label: label,
    title: title,
    unresolved: true,
  )

#let layout-cell(label, colspan: 1, rowspan: 1) = (
  label: label,
  colspan: colspan,
  rowspan: rowspan,
)

#let layout-grid(
  columns: none,
  cells: none,
  dominant: none,
) = {
  let columns = _require(columns, "layout-grid requires columns:")
  let cells = _require(cells, "layout-grid requires cells:")
  (
    kind: "grid",
    columns: columns,
    cells: cells,
    dominant: dominant,
  )
}

#let layout-stack(
  items: none,
  key-points: none,
  dominant: none,
) = {
  let items = _require(items, "layout-stack requires items:")
  (
    kind: "stack",
    items: items,
    key-points: key-points,
    dominant: dominant,
  )
}

#let layout-side(
  left: none,
  right: none,
  key-points: none,
  dominant: none,
) = {
  let left = _require(left, "layout-side requires left:")
  let right = _require(right, "layout-side requires right:")
  (
    kind: "side",
    left: left,
    right: right,
    key-points: key-points,
    dominant: dominant,
  )
}

#let layout-summary(
  visual: none,
  takeaways: none,
) = {
  let visual = _require(visual, "layout-summary requires visual:")
  let takeaways = _require(takeaways, "layout-summary requires takeaways:")
  (
    kind: "summary",
    visual: visual,
    takeaways: takeaways,
    dominant: visual,
  )
}

#let design-layout(body) = (
  kind: "free",
  body: body,
)

#let reveal-step(labels, purpose: none) = (
  labels: labels,
  purpose: purpose,
)

#let reveal-cumulative(
  initial: (),
  then: (),
) = (
  kind: "cumulative",
  initial: initial,
  then: then,
)

#let reveal-static(labels) = (
  kind: "static",
  labels: labels,
)

#let design-reveal(body) = (
  kind: "free",
  body: body,
)

#let summary-map(..pairs) = {
  let pairs = pairs.pos()
  let cells = ()
  for pair in pairs {
    cells.push(strong(pair.at(0)))
    cells.push(pair.at(1))
  }
  grid(
    columns: (auto, 1fr),
    column-gutter: 1em,
    row-gutter: 0.35em,
    align: left + horizon,
    ..cells,
  )
}

#let _layout-labels(layout) = {
  if layout.kind == "grid" {
    layout.cells.map(cell => cell.label)
  } else if layout.kind == "stack" {
    let labels = layout.items
    if layout.key-points != none {
      labels += (layout.key-points,)
    }
    labels
  } else if layout.kind == "side" {
    let labels = (layout.left, layout.right)
    if layout.key-points != none {
      labels += (layout.key-points,)
    }
    labels
  } else if layout.kind == "summary" {
    (layout.visual, layout.takeaways)
  } else {
    ()
  }
}

#let _reveal-labels(reveal) = {
  if reveal.kind == "static" {
    reveal.labels
  } else if reveal.kind == "cumulative" {
    let labels = reveal.initial
    for step in reveal.then {
      labels += step.labels
    }
    labels
  } else {
    ()
  }
}

#let _validate(objects, layout, reveal) = {
  let labels = objects.map(obj => obj.label)
  let seen = ()

  for label in labels {
    assert(
      not (label in seen),
      message: "duplicate slide-design object label: " + label,
    )
    seen.push(label)
  }

  let layout-labels = _layout-labels(layout)
  for label in layout-labels {
    assert(
      label in labels,
      message: "layout references unknown object label: " + label,
    )
  }

  if layout.kind != "free" {
    for label in labels {
      assert(
        label in layout-labels,
        message: "object is defined but not placed in layout: " + label,
      )
    }
  }

  let reveal-labels = _reveal-labels(reveal)
  for label in reveal-labels {
    assert(
      label in labels,
      message: "reveal references unknown object label: " + label,
    )
  }
}

#let _label-box(
  label,
  dominant: false,
  colspan: 1,
  rowspan: 1,
) = {
  let stroke = if dominant {
    1.5pt + design-accent
  } else {
    0.7pt + design-rule
  }
  let fill = if dominant { rgb("#edf4f8") } else { white }

  grid.cell(
    colspan: colspan,
    rowspan: rowspan,
  )[
    #block(
      width: 100%,
      height: 17mm,
      inset: 6pt,
      stroke: stroke,
      radius: 3pt,
      fill: fill,
    )[
      #align(center + horizon)[
        #text(
          size: 9pt,
          weight: if dominant { "bold" } else { "medium" },
          fill: if dominant { design-accent } else { black },
        )[#label]
      ]
    ]
  ]
}

#let _render-layout(layout) = {
  if layout.kind == "grid" {
    let cells = layout.cells.map(cell => _label-box(
      cell.label,
      dominant: cell.label == layout.dominant,
      colspan: cell.colspan,
      rowspan: cell.rowspan,
    ))
    grid(
      columns: layout.columns,
      gutter: 5pt,
      ..cells,
    )
  } else if layout.kind == "stack" {
    let boxes = layout.items.map(label => _label-box(
      label,
      dominant: label == layout.dominant,
    ))
    if layout.key-points != none {
      boxes.push(_label-box(
        layout.key-points,
        dominant: layout.key-points == layout.dominant,
      ))
    }
    stack(spacing: 5pt, ..boxes)
  } else if layout.kind == "side" {
    let cells = (
      _label-box(layout.left, dominant: layout.left == layout.dominant),
      _label-box(layout.right, dominant: layout.right == layout.dominant),
    )
    if layout.key-points != none {
      cells.push(_label-box(
        layout.key-points,
        dominant: layout.key-points == layout.dominant,
        colspan: 2,
      ))
    }
    grid(
      columns: (1fr, 1fr),
      gutter: 5pt,
      ..cells,
    )
  } else if layout.kind == "summary" {
    stack(
      spacing: 5pt,
      _label-box(layout.visual, dominant: true),
      _label-box(layout.takeaways),
    )
  } else {
    block(
      width: 100%,
      inset: 8pt,
      stroke: 1pt + design-accent,
      fill: design-warn,
      radius: 3pt,
    )[
      #text(weight: "bold", fill: design-accent)[DESIGN LAYOUT]
      #parbreak()
      #layout.body
    ]
  }
}

#let _render-object(obj) = {
  let stroke = if obj.unresolved {
    1.2pt + design-accent
  } else {
    0.7pt + design-rule
  }
  let fill = if obj.unresolved { design-warn } else { white }

  block(
    width: 100%,
    breakable: true,
    inset: 8pt,
    stroke: stroke,
    radius: 3pt,
    fill: fill,
  )[
    #grid(
      columns: (1fr, auto),
      gutter: 0.8em,
      align: (left + horizon, right + horizon),
      [
        #text(size: 8.5pt, weight: "bold", fill: design-accent)[#obj.label]
        #if obj.title != none {
          [ #text(size: 8.5pt, fill: design-muted)[— #obj.title]]
        }
      ],
      text(size: 8pt, fill: design-muted)[#obj.kind],
    )
    #v(5pt)
    #obj.body
    #if obj.caption != none {
      v(4pt)
      text(size: 8.5pt, fill: design-muted, obj.caption)
    }
    #if obj.from != none {
      v(3pt)
      text(size: 8pt, fill: design-muted)[From: #obj.from]
    }
  ]
}

#let _labels-text(labels) = {
  if labels.len() == 0 {
    [—]
  } else {
    labels.join(", ")
  }
}

#let _render-reveal(reveal) = {
  if reveal.kind == "static" {
    block(
      width: 100%,
      inset: 7pt,
      stroke: 0.7pt + design-rule,
      radius: 3pt,
    )[
      *Static:* #_labels-text(reveal.labels)
    ]
  } else if reveal.kind == "cumulative" {
    let cells = (
      [*State*], [*Change*], [*Teaching purpose*],
      [OPEN], _labels-text(reveal.initial), [Initial meaningful context],
    )

    let n = 2
    for step in reveal.then {
      cells.push([STATE #n])
      cells.push([+ #_labels-text(step.labels)])
      cells.push(if step.purpose == none { [] } else { step.purpose })
      n += 1
    }

    grid(
      columns: (auto, auto, 1fr),
      column-gutter: 0.9em,
      row-gutter: 0.4em,
      align: left + top,
      ..cells,
    )
  } else {
    block(
      width: 100%,
      inset: 8pt,
      stroke: 1.2pt + design-accent,
      fill: design-warn,
      radius: 3pt,
    )[
      #text(weight: "bold", fill: design-accent)[DESIGN REVEAL — structured lowering unresolved]
      #v(4pt)
      #reveal.body
    ]
  }
}

#let slide-design(
  title: none,
  teaching-move: none,
  layout: none,
  cards: (),
  key-points: (),
  reveal: none,
  rationale: none,
  constraints: none,
  backpressure: none,
) = {
  let title = _require(title, "slide-design requires title:")
  let teaching-move = _require(
    teaching-move,
    "slide-design requires teaching-move:",
  )
  let layout = _require(layout, "slide-design requires layout:")
  let reveal = _require(reveal, "slide-design requires reveal:")
  let objects = cards + key-points

  _validate(objects, layout, reveal)

  pagebreak(weak: true)
  heading(title, level: 2)

  text(size: 9pt, fill: design-muted)[Teaching move]
  parbreak()
  teaching-move

  v(8pt)
  heading([Layout sketch], level: 3)
  _render-layout(layout)

  v(8pt)
  heading([Content objects], level: 3)
  stack(
    spacing: 6pt,
    ..objects.map(_render-object),
  )

  v(8pt)
  heading([Reveal sketch], level: 3)
  _render-reveal(reveal)

  if rationale != none {
    v(8pt)
    heading([Rationale], level: 3)
    rationale
  }

  if constraints != none {
    v(8pt)
    heading([Design constraints], level: 3)
    constraints
  }

  if backpressure != none {
    v(8pt)
    heading([Backpressure], level: 3)
    block(
      width: 100%,
      inset: 8pt,
      stroke: 1.2pt + design-accent,
      fill: design-warn,
      radius: 3pt,
    )[#backpressure]
  }
}
