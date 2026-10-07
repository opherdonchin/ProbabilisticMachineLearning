// Constrained slide-design document language.
//
// This is intentionally more opinionated than course.typ. It renders a
// document-oriented design specification rather than a slide deck. Semantic
// object names stay close to production names; spatial and reveal choices
// remain abstract and are rendered as sketches.

#set page(
  paper: "a4",
  margin: (x: 12mm, y: 8mm),
)
#set text(size: 8.8pt)
#set par(leading: 0.52em)

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

#let card(body, label: none, title: none) = _object(
  "card",
  body,
  label: label,
  title: title,
)

#let bordered-card(body, label: none, title: none) = _object(
  "bordered-card",
  body,
  label: label,
  title: title,
)

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

#let key-points(body, label: none, title: [Key points]) = _object(
  "key-points",
  body,
  label: label,
  title: title,
)

#let section-summary-visual(body, label: none, title: [Summary visual]) = _object(
  "section-summary-visual",
  body,
  label: label,
  title: title,
)

#let section-summary-takeaways(body, label: none, title: [Summary takeaways]) = _object(
  "section-summary-takeaways",
  body,
  label: label,
  title: title,
)

#let design-card(body, label: none, title: [Unresolved card]) = _object(
    "design-card",
    body,
    label: label,
    title: title,
    unresolved: true,
  )

#let design-content(body, label: none, title: [Unresolved content]) = _object(
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

#let summary-visual-candidate(label, reason: none) = (
  kind: "visual",
  label: label,
  reason: reason,
)

#let summary-key-point-candidate(body, from: none, reason: none) = (
  kind: "key-point",
  body: body,
  from: from,
  reason: reason,
)

#let _notes-block(title, body) = block(
  width: 100%,
  breakable: true,
  inset: 6pt,
  stroke: 0.7pt + design-rule,
  radius: 3pt,
  fill: white,
)[
  #text(size: 8pt, weight: "bold", fill: design-accent)[#title]
  #v(2pt)
  #body
]

#let section-design-notes(
  title: none,
  purpose: none,
  entry: none,
  endpoint: none,
  arc: none,
  anchors: none,
  summary-brief: none,
  continuity: none,
  constraints: none,
) = {
  let title = _require(title, "section-design-notes requires title:")
  let purpose = _require(purpose, "section-design-notes requires purpose:")
  let endpoint = _require(endpoint, "section-design-notes requires endpoint:")
  let arc = _require(arc, "section-design-notes requires arc:")
  let anchors = _require(anchors, "section-design-notes requires anchors:")
  let summary-brief = _require(
    summary-brief,
    "section-design-notes requires summary-brief:",
  )

  pagebreak(weak: true)
  text(size: 8pt, weight: "medium", fill: design-accent)[SECTION DESIGN NOTES]
  v(2pt)
  text(size: 16pt, weight: "bold")[#title]

  v(5pt)
  grid(
    columns: (1fr, 1fr),
    gutter: 5pt,
    _notes-block([Purpose], purpose),
    _notes-block([Endpoint], endpoint),
  )

  if entry != none {
    v(5pt)
    _notes-block([Entry / assumed context], entry)
  }

  v(5pt)
  _notes-block([Narrative arc], arc)

  v(5pt)
  grid(
    columns: (1fr, 1fr),
    gutter: 5pt,
    _notes-block([Visual and notation anchors], anchors),
    _notes-block([Summary design brief], summary-brief),
  )

  if continuity != none or constraints != none {
    v(5pt)
    grid(
      columns: (1fr, 1fr),
      gutter: 5pt,
      if continuity == none { [] } else {
        _notes-block([Continuity / handoff], continuity)
      },
      if constraints == none { [] } else {
        _notes-block([Constraints / open pressure], constraints)
      },
    )
  }
}

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

#let _validate-summary-candidates(objects, candidates) = {
  let labels = objects.map(obj => obj.label)
  for candidate in candidates {
    if candidate.kind == "visual" {
      assert(
        candidate.label in labels,
        message: "summary visual candidate references unknown object label: " + candidate.label,
      )
    } else if candidate.kind == "key-point" and candidate.from != none {
      assert(
        candidate.from in labels,
        message: "summary key-point candidate references unknown source label: " + candidate.from,
      )
    }
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
      height: 9mm,
      inset: 4pt,
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
    inset: 4pt,
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
    #v(2pt)
    #obj.body
    #if obj.caption != none {
      v(2pt)
      text(size: 8.5pt, fill: design-muted, obj.caption)
    }
    #if obj.from != none {
      v(2pt)
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

#let _render-summary-candidates(candidates) = {
  let rows = ()
  for candidate in candidates {
    if candidate.kind == "visual" {
      rows.push(
        [
          #text(size: 7.5pt, weight: "bold", fill: design-accent)[VISUAL]
          #h(0.5em)
          #text(size: 7.8pt)[#candidate.label]
          #if candidate.reason != none {
            [ — #text(size: 7.5pt, fill: design-muted)[#candidate.reason]]
          }
        ],
      )
    } else {
      rows.push(
        [
          #text(size: 7.5pt, weight: "bold", fill: design-accent)[KEY POINT]
          #if candidate.from != none {
            [ #text(size: 7.5pt, fill: design-muted)[(#candidate.from)]]
          }
          [ #candidate.body]
          #if candidate.reason != none {
            [ — #text(size: 7.5pt, fill: design-muted)[#candidate.reason]]
          }
        ],
      )
    }
  }

  stack(
    spacing: 1pt,
    ..rows,
  )
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
  section: none,
  teaching-move: none,
  layout: none,
  cards: (),
  key-points: (),
  reveal: none,
  summary-candidates: (),
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
  _validate-summary-candidates(objects, summary-candidates)

  pagebreak(weak: true)

  if section != none {
    text(size: 8pt, weight: "medium", fill: design-accent)[#section]
    v(2pt)
  }
  text(size: 14pt, weight: "bold")[#title]

  v(2pt)
  text(size: 7.8pt, weight: "medium", fill: design-muted)[Teaching move]
  parbreak()
  teaching-move

  v(4pt)
  text(size: 10.5pt, weight: "bold")[Layout sketch]
  v(2pt)
  _render-layout(layout)

  v(4pt)
  text(size: 10.5pt, weight: "bold")[Content objects]
  v(2pt)
  stack(
    spacing: 3pt,
    ..objects.map(_render-object),
  )

  v(4pt)
  text(size: 10.5pt, weight: "bold")[Reveal sketch]
  v(2pt)
  _render-reveal(reveal)

  if summary-candidates.len() > 0 {
    v(3pt)
    text(size: 8.5pt, weight: "bold")[Summary candidates]
    v(1pt)
    _render-summary-candidates(summary-candidates)
  }

  if rationale != none {
    v(4pt)
    text(size: 10.5pt, weight: "bold")[Rationale]
    v(2pt)
    rationale
  }

  if constraints != none {
    v(4pt)
    text(size: 10.5pt, weight: "bold")[Design constraints]
    v(2pt)
    constraints
  }

  if backpressure != none {
    v(4pt)
    text(size: 10.5pt, weight: "bold")[Backpressure]
    v(2pt)
    block(
      width: 100%,
      inset: 6pt,
      stroke: 1.2pt + design-accent,
      fill: design-warn,
      radius: 3pt,
    )[#backpressure]
  }
}
