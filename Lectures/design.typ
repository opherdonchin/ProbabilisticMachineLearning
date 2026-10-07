// Constrained slide-design document language.
//
// This is intentionally more opinionated than course.typ. It renders a
// document-oriented design specification rather than a slide deck. Semantic
// object names are kept close to production names; spatial and reveal choices
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
#let design-paper = rgb("#f7f8f9")
#let design-warn = rgb("#fff3cf")

#let _object(
  kind,
  id,
  body,
  title: none,
  from: none,
  caption: none,
  unresolved: false,
) = (
  kind: kind,
  id: id,
  body: body,
  title: title,
  from: from,
  caption: caption,
  unresolved: unresolved,
)

#let card(body, id, title: none) =
  _object("card", id, body, title: title)

#let bordered-card(body, id, title: none) =
  _object("bordered-card", id, body, title: title)

#let recall-card(
  body,
  id,
  from:,
  title: none,
  label: [Carried forward],
) = _object(
  "recall-card",
  id,
  body,
  title: if title == none { label } else { title },
  from: from,
)

#let figure-card(
  body,
  id,
  from: none,
  caption: none,
  title: none,
) = _object(
  "figure-card",
  id,
  body,
  title: title,
  from: from,
  caption: caption,
)

#let schema-card(
  body,
  id,
  from: none,
  caption: none,
  title: none,
) = _object(
  "schema-card",
  id,
  body,
  title: title,
  from: from,
  caption: caption,
)

#let key-points(body, id, title: [Key points]) =
  _object("key-points", id, body, title: title)

#let section-summary-visual(body, id, title: [Summary visual]) =
  _object("section-summary-visual", id, body, title: title)

#let section-summary-takeaways(body, id, title: [Summary takeaways]) =
  _object("section-summary-takeaways", id, body, title: title)

#let design-card(body, id, title: [Unresolved card]) =
  _object("design-card", id, body, title: title, unresolved: true)

#let design-content(body, id, title: [Unresolved content]) =
  _object("design-content", id, body, title: title, unresolved: true)

#let layout-cell(id, colspan: 1, rowspan: 1) = (
  id: id,
  colspan: colspan,
  rowspan: rowspan,
)

#let layout-grid(
  columns,
  cells,
  dominant: none,
) = (
  kind: "grid",
  columns: columns,
  cells: cells,
  dominant: dominant,
)

#let layout-stack(
  items,
  key-points: none,
  dominant: none,
) = (
  kind: "stack",
  items: items,
  key-points: key-points,
  dominant: dominant,
)

#let layout-side(
  left,
  right,
  key-points: none,
  dominant: none,
) = (
  kind: "side",
  left: left,
  right: right,
  key-points: key-points,
  dominant: dominant,
)

#let layout-summary(
  visual,
  takeaways,
) = (
  kind: "summary",
  visual: visual,
  takeaways: takeaways,
  dominant: visual,
)

#let design-layout(body) = (
  kind: "free",
  body: body,
)

#let reveal-step(ids, purpose: none) = (
  ids: ids,
  purpose: purpose,
)

#let reveal-cumulative(initial, then) = (
  kind: "cumulative",
  initial: initial,
  then: then,
)

#let reveal-static(ids) = (
  kind: "static",
  ids: ids,
)

#let design-reveal(body) = (
  kind: "free",
  body: body,
)

#let summary-map(..pairs) = {
  let pairs = pairs.pos()
  grid(
    columns: (auto, 1fr),
    column-gutter: 1em,
    row-gutter: 0.35em,
    align: left + horizon,
    ..pairs.map(pair => (
      [#strong(pair.at(0))],
      pair.at(1),
    )).flatten(),
  )
}

#let _layout-ids(layout) = {
  if layout.kind == "grid" {
    layout.cells.map(cell => cell.id)
  } else if layout.kind == "stack" {
    let ids = layout.items
    if layout.key-points != none {
      ids += (layout.key-points,)
    }
    ids
  } else if layout.kind == "side" {
    let ids = (layout.left, layout.right)
    if layout.key-points != none {
      ids += (layout.key-points,)
    }
    ids
  } else if layout.kind == "summary" {
    (layout.visual, layout.takeaways)
  } else {
    ()
  }
}

#let _reveal-ids(reveal) = {
  if reveal.kind == "static" {
    reveal.ids
  } else if reveal.kind == "cumulative" {
    let ids = reveal.initial
    for step in reveal.then {
      ids += step.ids
    }
    ids
  } else {
    ()
  }
}

#let _validate(objects, layout, reveal) = {
  let ids = objects.map(obj => obj.id)
  let seen = ()
  for id in ids {
    assert(
      not id in seen,
      message: "duplicate slide-design object id: " + id,
    )
    seen.push(id)
  }

  let layout-ids = _layout-ids(layout)
  for id in layout-ids {
    assert(
      id in ids,
      message: "layout references unknown object id: " + id,
    )
  }

  if layout.kind != "free" {
    for id in ids {
      assert(
        id in layout-ids,
        message: "object is defined but not placed in layout: " + id,
      )
    }
  }

  let reveal-ids = _reveal-ids(reveal)
  for id in reveal-ids {
    assert(
      id in ids,
      message: "reveal references unknown object id: " + id,
    )
  }
}

#let _label-box(id, dominant: false, colspan: 1, rowspan: 1) = {
  let stroke = if dominant { 1.5pt + design-accent } else { 0.7pt + design-rule }
  let fill = if dominant { rgb("#edf4f8") } else { white }

  grid.cell(
    colspan: colspan,
    rowspan: rowspan,
  )[
    #block(
      width: 100%,
      height: 100%,
      min-height: 17mm,
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
        )[#id]
      ]
    ]
  ]
}

#let _render-layout(layout) = {
  if layout.kind == "grid" {
    grid(
      columns: layout.columns,
      gutter: 5pt,
      ..layout.cells.map(cell => _label-box(
        cell.id,
        dominant: cell.id == layout.dominant,
        colspan: cell.colspan,
        rowspan: cell.rowspan,
      )),
    )
  } else if layout.kind == "stack" {
    stack(
      spacing: 5pt,
      ..layout.items.map(id => _label-box(
        id,
        dominant: id == layout.dominant,
      )),
      if layout.key-points != none {
        _label-box(layout.key-points, dominant: layout.key-points == layout.dominant)
      },
    )
  } else if layout.kind == "side" {
    grid(
      columns: (1fr, 1fr),
      gutter: 5pt,
      _label-box(layout.left, dominant: layout.left == layout.dominant),
      _label-box(layout.right, dominant: layout.right == layout.dominant),
      if layout.key-points != none {
        _label-box(
          layout.key-points,
          dominant: layout.key-points == layout.dominant,
          colspan: 2,
        )
      },
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
  let unresolved = obj.unresolved
  let stroke = if unresolved { 1.2pt + design-accent } else { 0.7pt + design-rule }
  let fill = if unresolved { design-warn } else { white }

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
        #text(size: 8.5pt, weight: "bold", fill: design-accent)[#obj.id]
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

#let _ids-text(ids) = {
  if ids.len() == 0 {
    [—]
  } else {
    ids.join(", ")
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
      *Static:* #_ids-text(reveal.ids)
    ]
  } else if reveal.kind == "cumulative" {
    let rows = (
      (
        [OPEN],
        _ids-text(reveal.initial),
        [Initial meaningful context],
      ),
    )

    let n = 2
    for step in reveal.then {
      rows.push((
        [STATE #n],
        [+ #_ids-text(step.ids)],
        if step.purpose == none { [] } else { step.purpose },
      ))
      n += 1
    }

    grid(
      columns: (auto, auto, 1fr),
      column-gutter: 0.9em,
      row-gutter: 0.4em,
      align: left + top,
      table.header([*State*], [*Change*], [*Teaching purpose*]),
      ..rows.flatten(),
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
  title,
  teaching-move,
  layout,
  cards: (),
  key-points: (),
  reveal,
  rationale: none,
  constraints: none,
  backpressure: none,
) = {
  let objects = cards + key-points
  _validate(objects, layout, reveal)

  pagebreak(weak: true)
  heading(level: 2, title)
  text(size: 9pt, fill: design-muted)[Teaching move]
  parbreak()
  teaching-move

  v(8pt)
  heading(level: 3)[Layout sketch]
  _render-layout(layout)

  v(8pt)
  heading(level: 3)[Content objects]
  stack(
    spacing: 6pt,
    ..objects.map(_render-object),
  )

  v(8pt)
  heading(level: 3)[Reveal sketch]
  _render-reveal(reveal)

  if rationale != none {
    v(8pt)
    heading(level: 3)[Rationale]
    rationale
  }

  if constraints != none {
    v(8pt)
    heading(level: 3)[Design constraints]
    constraints
  }

  if backpressure != none {
    v(8pt)
    heading(level: 3)[Backpressure]
    block(
      width: 100%,
      inset: 8pt,
      stroke: 1.2pt + design-accent,
      fill: design-warn,
      radius: 3pt,
    )[#backpressure]
  }
}
