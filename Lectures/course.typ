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

// Section state is updated only by section-slide().
#let _section-number = state("pml-section-number", 0)
#let _section-short-title = state("pml-section-short-title", [])

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

#let section-slide(
  title: none,
  short-title: title,
  subtitle: none,
) = touying-slide-wrapper(self => {
    self = utils.merge-dicts(
      self,
      config-page(
        margin: 2em,
        header: none,
        footer: none,
      ),
    )

    // Keep the state updates inside the explicit slide body. Emitting them
    // before touying-slide-wrapper creates an unintended empty first slide.
    let body = {
      _section-number.update(n => n + 1)
      _section-short-title.update(short-title)

      context {
        let n = _section-number.get()

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
              title,
            ),

            if subtitle != none {
              text(size: 15pt, fill: palette.text, subtitle)
            },
          )
        ]
      }
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
      text(size: 0.34em, fill: palette.muted)[#raw(_path-text(source))]
    },
  )
]

// The provenance line on its own, for a composite whose panels each set
// show-source: false.
#let figure-source(source) = align(center)[
  #text(size: 0.34em, fill: palette.muted)[#raw(_path-text(source))]
]

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
