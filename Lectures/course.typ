// Probabilistic Machine Learning — shared course layer
// Base visual system: SeaSlides "ruled-page" theme.
// The vendored theme is treated as read-only. Course-specific behavior lives here.
//
// Expected repository layout:
// Lectures/
//   course.typ
//   themes/ruled-page/template.typ
//   L01_Probability_Statistics/slide_deck.typ
//   ...

#import "@preview/touying:0.7.4": *
#import "@preview/based:0.2.0": base64
#import "@preview/fletcher:0.5.8" as fletcher

#import "themes/ruled-page/template.typ": ruled-page-theme, ruled-card, margin-note, palette
#import "themes/ruled-page/template.typ": focus-slide as ruled-focus-slide, ending-slide as ruled-ending-slide

// Fletcher primitives shared by all lectures. `course-diagram` uses Touying's
// reducer so pause and meanwhile markers also work inside diagrams.
#let course-diagram = touying-reduce.with(fletcher)
#let graph-node = fletcher.node
#let graph-edge = fletcher.edge

// -----------------------------------------------------------------------------
// Course metadata
// -----------------------------------------------------------------------------

#let course = (
  title: [Probabilistic Machine Learning],
  term: [2027-1],
  author: [Opher Donchin],
  institution: [Department of Biomedical Engineering, Ben-Gurion University],
)

// Section state is updated by the level-1 heading handler below.
#let _section-number = state("pml-section-number", 0)
#let _section-short-title = state("pml-section-short-title", [])
#let _section-subtitle = state("pml-section-subtitle", none)
#let _pending-section-short-title = state("pml-pending-section-short-title", [])
#let _pending-section-subtitle = state("pml-pending-section-subtitle", none)

#let section-metadata(
  short-title: none,
  subtitle: none,
) = {
  _pending-section-short-title.update(short-title)
  _pending-section-subtitle.update(subtitle)
}

#let _course-section-slide(self: none, body) = touying-slide-wrapper(self => {
  self = utils.merge-dicts(
    self,
    config-page(
      margin: 2em,
      header: none,
      footer: none,
    ),
  )

  let main-body = {
    _section-number.update(n => n + 1)

    context {
      let n = _section-number.get()
      let short-title = _pending-section-short-title.get()
      let subtitle = _pending-section-subtitle.get()

      // Activate the pending metadata on the divider, after the preceding
      // content slide has ended, so its footer retains the old section label.
      _section-short-title.update(short-title)
      _section-subtitle.update(subtitle)

      set align(left + horizon)

      pad(left: 36pt)[
        #stack(
          spacing: 0.8em,

          text(
            size: 0.75em,
            fill: palette.muted,
            weight: "medium",
          )[Section #n],

          line(length: 40pt, stroke: 2pt + palette.accent),

          text(
            size: 32pt,
            weight: "semibold",
            fill: palette.dark,
            utils.display-current-heading(level: 1),
          ),

          if subtitle != none {
            text(size: 15pt, fill: palette.text, subtitle)
          },
        )
      ]
    }
  }

  touying-slide(self: self, main-body)
})

// -----------------------------------------------------------------------------
// Ordinary slide chrome
// -----------------------------------------------------------------------------

#let _course-slide(title: auto, align: auto, ..args) = touying-slide-wrapper(self => {
  if title != auto {
    self.store.title = title
  }
  if align != auto {
    self.store.align = align
  }

  let header(self) = {
    set std.align(top)

    block(width: 100%, inset: (x: 2em, top: 0.65em, bottom: 0.45em))[
      #set text(size: 0.58em, fill: palette.muted)

      #stack(
        spacing: 0.45em,

        [Lecture #self.store.lecture-number — #self.store.lecture-short-title],

        {
          set text(size: 22pt, fill: palette.dark, weight: "medium")

          if self.store.title != none {
            utils.call-or-display(self, self.store.title)
          } else {
            utils.display-current-heading(level: 2)
          }
        },

        line(length: 100%, stroke: 1.2pt + palette.accent),
      )
    ]
  }

  let footer(self) = {
    set std.align(bottom)

    pad(x: 2em, bottom: 0.55em)[
      #set text(size: 0.58em, fill: palette.muted)

      #grid(
        columns: (1fr, 1fr),
        gutter: 1em,
        align: (left + horizon, right + horizon),

        context {
          let n = _section-number.get()
          let short = _section-short-title.get()

          if n > 0 {
            [#n. #short]
          }
        },

        context {
          [Slide #utils.slide-counter.display()/#utils.last-slide-number]
        },
      )
    ]
  }

  let setting(body) = {
    show: std.align.with(self.store.align)
    body
  }

  self = utils.merge-dicts(
    self,
    config-page(
      header: header,
      footer: footer,
    ),
  )

  touying-slide(self: self, setting: setting, ..args)
})

// -----------------------------------------------------------------------------
// Course theme wrapper
// -----------------------------------------------------------------------------
//
// Ruled Page remains responsible for the palette, page geometry, list styling,
// and general visual language. We override only course-specific structure.

#let course-theme(info: (:), body) = {
  let lecture-subtitle = info.at("subtitle", default: none)

  show: ruled-page-theme.with(
    aspect-ratio: "16-9",
    footer: none,

    // Later config values are intended to override the corresponding Ruled Page
    // defaults while leaving the rest of the theme intact.
    config-common(
      breakable: false,
      slide-fn: _course-slide,
      new-section-slide-fn: _course-section-slide,
    ),

    config-store(
      lecture-number: info.number,
      lecture-short-title: info.short-title,
    ),

    config-info(
      title: info.title,
      subtitle: lecture-subtitle,
      author: course.author,
      institution: course.institution,
      date: datetime.today(),
    ),
  )

  body
}

// -----------------------------------------------------------------------------
// Special slides
// -----------------------------------------------------------------------------

#let title-slide() = touying-slide-wrapper(self => {
  self = utils.merge-dicts(
    self,
    config-page(
      margin: (top: 0pt, bottom: 0pt, left: 0pt, right: 0pt),
      header: none,
      footer: none,
    ),
  )

  let body = {
    set align(left + horizon)

    pad(x: 72pt, y: 56pt)[
      #stack(
        spacing: 0.8em,

        stack(
          spacing: 0.8em,
          text(
            size: 38pt,
            weight: "bold",
            fill: palette.dark,
          )[
            Lecture #self.store.lecture-number\
            #self.info.title
          ],

          line(length: 80pt, stroke: 2.5pt + palette.accent),
        ),

        if self.info.subtitle != none {
          text(size: 16pt, fill: palette.text, self.info.subtitle)
        },

        text(size: 14pt, fill: palette.muted)[#course.title #course.term],

        stack(
          spacing: 0.45em,
          text(size: 12pt, fill: palette.muted, utils.display-info-date(self)),
        ),
      )
    ]
  }

  touying-slide(self: self, body)
})

#let focus-slide(body) = ruled-focus-slide(body)
#let ending-slide(body) = ruled-ending-slide(body)

// -----------------------------------------------------------------------------
// Semantic course components
// -----------------------------------------------------------------------------
//
// These deliberately wrap Ruled Page rather than creating a second visual theme.

#let _untitled-ruled-card(body) = block(
  width: 100%,
  stroke: (left: 2.5pt + palette.accent),
  inset: (left: 14pt, y: 10pt, right: 10pt),
  fill: palette.paper,
)[
  #body
  #lazy-v(1fr)
]

#let course-card(body, title: none) = if title == none {
  _untitled-ruled-card(body)
} else {
  ruled-card(title, body)
}

// Usage:
//   #key-points[Body without a title]
//   #key-points(title: [Optional title])[Body]
#let _key-points(body, title: none) = course-card(body, title: title)
#let key-points(body, title: none) = _key-points(body, title: title)

#let note(body) = margin-note(body)

#let _semantic-title(label, title) = stack(
  dir: ltr,
  spacing: 0.6em,

  box(
    fill: palette.accent,
    inset: (x: 5pt, y: 2pt),
    radius: 2pt,
  )[
    #text(size: 0.68em, weight: "bold", fill: white)[#label]
  ],

  title,
)

#let definition(
  title: none,
  label: [Definition],
  body,
) = course-card(
  body,
  title: if title == none { none } else { _semantic-title(label, title) },
)

#let method(
  title: none,
  label: [Method],
  body,
) = course-card(
  body,
  title: if title == none { none } else { _semantic-title(label, title) },
)

// -----------------------------------------------------------------------------
// Slide-level content composition
// -----------------------------------------------------------------------------

#let _object-box(object, width) = align(
  center,
  block(width: width)[#object],
)

// Course-wide layout conveniences for pairing two or three blocks side by
// side. Prefer these over a lecture-local grid() when the layout is just an
// equal-width row; add a new named helper here rather than in a lecture file
// if another repeated arrangement emerges.
#let twocol(left, right) = grid(
  columns: (1fr, 1fr),
  gutter: 1.2em,
  align: top,
  left, right,
)

#let triad(a, b, c) = grid(
  columns: (1fr, 1fr, 1fr),
  gutter: 0.8em,
  align: top,
  a, b, c,
)

// A composable object + key-points unit. Put it in the normal body of a
// heading-defined slide, optionally alongside other components:
//   == Slide title
//   #stack(spacing: 0.7em, content-block(...), note([Supporting note]))
#let content-block(
  layout: "bottom",
  object-width: auto,
  object: none,
  key-points: none,
  key-points-title: none,
) = {
  let is-side = layout == "side-left" or layout == "side-right"

  let resolved-width = if object-width == auto {
    if is-side { 58% } else { 82% }
  } else {
    object-width
  }

  if object != none and key-points != none {
    let obj = _object-box(
      object,
      if is-side { 100% } else { resolved-width },
    )
    let points = _key-points(key-points, title: key-points-title)

    if layout == "top" {
      stack(spacing: 0.9em, obj, points)
    } else if layout == "bottom" {
      stack(spacing: 0.9em, points, obj)
    } else if layout == "side-left" {
      grid(
        columns: (resolved-width, 1fr),
        gutter: 1.4em,
        align: top,
        obj,
        points,
      )
    } else if layout == "side-right" {
      grid(
        columns: (1fr, resolved-width),
        gutter: 1.4em,
        align: top,
        points,
        obj,
      )
    } else {
      panic("Unknown content-block layout: " + layout)
    }
  } else if object != none {
    _object-box(
      object,
      if object-width == auto { 82% } else { object-width },
    )
  } else if key-points != none {
    _key-points(key-points, title: key-points-title)
  } else {
    []
  }
}


// Carried-forward knowledge: the provenance is separate from the current
// slide title and from any key-points title. Only this header uses smaller,
// muted text; content-block keeps its ordinary typography and geometry.
#let _recall-header(label, from) = block(
  width: 100%,
  stroke: (bottom: 0.6pt + palette.rule-line),
  inset: (bottom: 0.35em),
)[
  #set text(size: 0.68em, fill: palette.muted)
  #grid(
    columns: (auto, 1fr),
    column-gutter: 0.8em,
    align: left + top,
    text(weight: "semibold", fill: palette.accent, label),
    from,
  )
]

// `from:` is required author-supplied provenance and accepts Typst content.
// Typst named parameters need a default; the assertion enforces this contract.
// All layout arguments have the same meaning and defaults as content-block.
//
// Material supplied by an assigned recording:
//   #recall-block(
//     from: [Recorded: Probability review],
//     object: [$ E[A X + b] = A E[X] + b $],
//   )
//
// Material recalled from an earlier lecture:
//   #recall-block(
//     from: [Lecture 1: Gaussian conditioning],
//     layout: "side-left",
//     object: [$ E[X | Y = y] = mu_(X | y) $],
//     key-points: [The conditional mean depends on the observed value $y$.],
//   )
#let recall-block(
  from: none,
  label: [Carry forward],
  layout: "bottom",
  object-width: auto,
  object: none,
  key-points: none,
  key-points-title: none,
) = {
  assert(from != none, message: "recall-block requires provenance via from: [...]")

  if object != none or key-points != none {
    block(width: 100%, breakable: false)[
      #stack(
        spacing: 0.55em,
        _recall-header(label, from),
        content-block(
          layout: layout,
          object-width: object-width,
          object: object,
          key-points: key-points,
          key-points-title: key-points-title,
        ),
      )
    ]
  } else {
    []
  }
}


// -----------------------------------------------------------------------------
// Schematic diagram primitives
// -----------------------------------------------------------------------------
//
// A small vocabulary for the boxes-and-arrows schematics used across lectures
// to lay out task/experience/model flows, typically inside a content-block
// grid. Keep these course-wide: if a lecture needs a bespoke diagram box, it
// most likely belongs here rather than as a lecture-local copy.
//
// Geometry (inset, radius) is expressed in `em` so schema-node scales
// uniformly with whatever ambient text size a lecture wraps it in; only the
// hairline stroke stays a fixed absolute thickness.
//
// `density` selects a body-text preset from a small, named vocabulary rather
// than a raw size number, so unrelated slides that pick the same density
// render identically instead of drifting to slightly different numbers:
//   - "normal" (default): body inherits the ambient size, centered — fits a
//     short symbol-only line or two.
//   - "prose": smaller, left-aligned — fits a multi-line "Task: ... /
//     Performance: ..."-style description without overflowing the node.
// When a grid has several nodes that must look alike, define one local
// forwarding function that fixes the density and call that for every node in
// the grid, rather than repeating `density: "prose"` at each call site.

#let _schema-node-density = (
  normal: (size: 1em, align: center),
  prose: (size: 0.62em, align: left),
)

#let schema-node(
  label,
  body,
  fill: palette.accent.lighten(87%),
  density: "normal",
) = {
  let d = _schema-node-density.at(density)
  box(
    width: 100%,
    stroke: 0.8pt + palette.rule-line,
    fill: fill,
    radius: 0.25em,
    inset: (x: 0.6em, y: 0.5em),
  )[
    #align(center)[
      #stack(
        spacing: 0.4em,
        text(size: 0.6em, weight: "semibold", fill: palette.accent)[#label],
        align(d.align)[#text(size: d.size)[#body]],
      )
    ]
  ]
}

// A right-pointing arrow sized to sit beside `schema-node` cells in a grid.
#let schema-arrow = align(center + horizon)[
  #text(size: 1.35em, fill: palette.accent)[$arrow.r$]
]

// A small muted, centered caption/citation line, e.g. under a schematic or
// a course-authored figure. `figure-source` below is a thin wrapper for
// path-valued citations; call `source-note` directly for descriptive text
// such as "Course schematic; Book 1 §1.2.2".
#let source-note(body) = align(center)[
  #text(size: 0.6em, fill: palette.muted)[#body]
]

// -----------------------------------------------------------------------------
// Figures
// -----------------------------------------------------------------------------
//
// A path value keeps the caller's directory as its base, so lecture decks can
// pass path("figures/plot.svg"). A bare string is instead resolved relative to
// this shared module. `source` controls the path shown in the provenance line.
// Width and height are both optional: when both are set, `fit: "contain"`
// treats them as a bounding box and preserves the image's aspect ratio.
// If caption is omitted, the source path is the only caption line.
// Set show-source: false for the individual panels of a composite figure, and
// name the provenance once for the composite instead of four times over.
//
// Missing-file handling uses the context/query workaround discussed in:
// https://github.com/typst/typst/issues/2025#issuecomment-2500280417
// This is intentionally isolated here because it relies on compiler behavior.

#let _context-function = (context { }).func()
#let _path-text(path) = if type(path) == str { path } else { repr(path) }
#let _unique-path-label(path) = base64.encode(_path-text(path))

#let _image-or-placeholder(path, width: 100%, height: auto) = context {
  let path-label = label(_unique-path-label(path))
  let first-time = query(_context-function).len() == 0
  let used-path = query(path-label).len() > 0

  if first-time or used-path [
    #image(path, width: width, height: height, fit: "contain")
    #path-label
  ] else {
    block(
      width: width,
      height: if height == auto { 5.5cm } else { height },
      stroke: 0.8pt + palette.rule-line,
      inset: 12pt,
      fill: palette.paper,
    )[
      #align(center + horizon)[
        #stack(
          spacing: 0.4em,
          text(weight: "semibold", fill: palette.dark)[Missing figure],
          text(size: 0.72em, fill: palette.muted)[#raw(_path-text(path))],
        )
      ]
    ]
  }
}

#let course-figure(
  path,
  source: path,
  caption: none,
  width: 100%,
  height: auto,
  show-source: true,
) = align(center)[
  #stack(
    spacing: 0.28em,

    _image-or-placeholder(path, width: width, height: height),

    if caption != none {
      text(size: 0.41em, fill: palette.text, caption)
    },

    if show-source {
      source-note(raw(_path-text(source)))
    },
  )
]

// The provenance line on its own, for a composite whose panels each set
// show-source: false.
#let figure-source(source) = source-note(raw(_path-text(source)))

// -----------------------------------------------------------------------------
// Coordinate-based annotations
// -----------------------------------------------------------------------------
//
// Callout coordinates are percentages/relative lengths within the annotated
// object's bounding box. This first implementation intentionally stays simple.
// It draws a pointer line and a small target marker when arrow: true.

#let callout(
  target: none,
  label-at: none,
  text: none,
  arrow: true,
) = (
  target: target,
  label-at: label-at,
  text: text,
  arrow: arrow,
)

#let annotated-object(
  object,
  callouts: (),
) = block(width: 100%)[
  #object

  #for c in callouts {
    if c.arrow {
      place(
        top + left,
        line(
          start: c.label-at,
          end: c.target,
          stroke: (paint: palette.accent, thickness: 0.8pt),
        ),
      )

      place(
        top + left,
        dx: c.target.at(0),
        dy: c.target.at(1),
        circle(radius: 1.8pt, fill: palette.accent),
      )
    }

    place(
      top + left,
      dx: c.label-at.at(0),
      dy: c.label-at.at(1),
      box(
        fill: palette.paper,
        stroke: 0.5pt + palette.rule-line,
        inset: (x: 5pt, y: 3pt),
        radius: 2pt,
      )[
        #text(size: 0.68em, fill: palette.dark)[#c.text]
      ],
    )
  }
]
