# Probabilistic Machine Learning — course.typ authoring reference

This file describes the current author-facing contract of `Lectures/course.typ`.
It is a descriptive companion to the implementation. The implementation remains
authoritative when signatures or defaults change.

The current stable visual reference is Lecture 1:
`Lectures/L01_Probability_Statistics/slide_deck.typ`.

A compact reference deck is:
`Lectures/authoring_reference.typ`.

The source `.typ` files are authoritative. A rendered PDF is a reliable visual
reference only when it has been freshly compiled from the current source and
current `course.typ`.

## 1. Course-level visual model

The shared course layer is intentionally thin over the vendored Ruled Page
SeaSlides theme. The theme supplies the base palette, page geometry, typography,
list styling, and general visual language. `course.typ` supplies the
course-specific structure and the authoring choices that are intended to remain
consistent across lectures.

The main separation of responsibilities is:

- slide source carries the intellectual argument, equations, examples, figures,
  and lecture-local constructions;
- `course.typ` carries stable course-wide presentation semantics and layout
  conveniences;
- author-facing notebooks carry reproducible computational figure generation;
- standalone `.typ` files may carry reusable or visually substantial
  lecture-specific schematics;
- speaker notes are not part of slide development. They belong to a later
  production stage after the visible deck is stable.

Cards and layout are orthogonal concepts. A card identifies content that belongs
together semantically or visually. `twocol`, `triad`, `grid`, `stack`,
alignment, and parent blocks determine geometry. A card may contain a layout,
and a layout may arrange cards or unboxed content.

Card type describes the role of an object in the current slide argument, not the
mechanism by which its contents were produced. An imported SVG can be a
`schema-card`; a Typst-generated image can be a `figure-card`; equations and
a graphical model can jointly form one `schema-card`.

## 2. Lecture shell

A lecture defines an `info` dictionary with:

```typst
#let lecture = (
  number: 2,
  title: [Lecture title],
  short-title: [Short footer title],
  subtitle: [Optional subtitle],
)
```

The normal setup is:

```typst
#import "../course.typ": *

#show: course-theme.with(info: lecture)
#show: touying-set-config.with(config-common(handout: true))

#title-slide()
```

`course-theme(info:, body)` installs the course slide chrome and section
behavior. Ordinary level-2 headings become titled course slides. Level-1
headings become section-divider slides.

`title-slide()` is the established title-slide convention.

`focus-slide[...]` and `ending-slide[...]` remain available theme
conveniences, but their role is provisional because Lecture 1 did not establish
a recurring course use for them.

## 3. Sections

Optional metadata immediately before a level-1 heading supplies a short footer
label and divider subtitle:

```typst
#section-metadata(
  short-title: [Gaussian geometry],
  subtitle: [Describe and transform joint uncertainty],
)

= Joint Gaussian geometry
```

The ordinary-slide footer shows the current section number and short title.

## 4. Calibrated scales

### Font sizes

`fs(name)` maps:

| name | size |
|---|---:|
| `xxs` | `0.58em` |
| `xs` | `0.68em` |
| `s` | `0.72em` |
| `m` | `0.78em` |
| `l` | `0.84em` |
| `xl` | `0.90em` |

### Spacing

`sp(name)` maps:

| name | size |
|---|---:|
| `xxs` | `0.22em` |
| `xs` | `0.35em` |
| `s` | `0.45em` |
| `m` | `0.60em` |
| `l` | `0.80em` |
| `xl` | `1.10em` |

The two scales are calibrated as a family. Matching labels are intended to
produce a coherent visual density. `sp("xxs")` is optical/micro spacing rather
than normal separation for `fs("xs")` text.

Raw numbers remain appropriate when they express deliberate optical tuning or
content-fitting geometry. Repeated raw values with the same semantic purpose
are evidence for a named choice; numerical repetition by itself is not.

### Column ratios

`cols(name)` maps:

- `"equal"` → `(1fr, 1fr)`
- `"left"` → `(3fr, 2fr)`
- `"right"` → `(2fr, 3fr)`
- `"three"` → `(1fr, 1fr, 1fr)`

## 5. Ordinary slide composition

### content-block

```typst
#content-block(
  layout: "top",
  object-width: auto,
  object: [...],
  key-points: [...],
  key-points-title: none,
)
```

`content-block` is the normal architecture for an ordinary teaching slide.

Its two conceptual regions are:

- `object:` — the thing being inspected, constructed, compared, derived, or
  manipulated;
- `key-points:` — verbal interpretation, consequences, or framing.

The default `layout: "top"` places the object above the key-points card.
Other layouts are:

- `"bottom"` — key points above object;
- `"side-left"` — object left, key points right;
- `"side-right"` — key points left, object right.

Default object width is 96% for top/bottom layouts and 58% for side layouts.
`object-width` may be overridden for the composition.

An ordinary teaching slide generally contains one `content-block`. Material
participating in the slide argument normally belongs inside either its object or
key-points region. Section summaries and genuinely special slides may use a
different architecture.

### twocol and triad

```typst
#twocol(
  columns: cols("equal"),
  gutter: sp("l"),
  align: top,
)[left][right]

#triad(
  gutter: sp("l"),
  align: top,
)[a][b][c]
```

These are convenient geometry helpers, not semantic structures. They may arrange
cards or unboxed content. Raw `grid` remains appropriate for geometry that the
helpers do not express naturally: multi-row or 2×2 layouts, tables/matrices,
fixed replacement regions, irregular arrow/node structures, or other schematic
arrangements.

## 6. Presentation cards

### card

```typst
#card[...]
```

The default card is intentionally visually unmarked. Its value is semantic in
the source: it marks one substantial presentation object without forcing a
visible border.

### bordered-card

```typst
#bordered-card(title: [Optional title])[...]
```

A normal visibly bounded card using the Ruled Page visual language. An untitled
variant uses the course accent rule at the left.

### recall-card

```typst
#recall-card(
  from: [Earlier: provenance],
  label: [Carried forward],
  size: fs("m"),
)[...]
```

A visually subordinate reminder of material already taught and needed again in
the current argument. `from:` is required and records where the material was
encountered.

Width is not a recall-card parameter. Width belongs to the parent composition.
A narrow standalone recall may therefore be composed as:

```typst
#align(left)[
  #block(width: 50%)[
    #recall-card(from: [Earlier: ...])[...]
  ]
]
```

Within a column layout the card normally fills the column allocated by its
parent.

### figure-card

```typst
#figure-card(
  from: none,
  caption: none,
)[...]
```

The complete presentation object for a figure or figure composite. It owns
figure chrome plus optional caption and human-readable provenance. Its body may
contain one image or a coordinated composite.

`from:` is optional at the API level. It is appropriate for meaningful
external, adapted, or computational provenance. Course-authored figures can omit
displayed provenance when none is useful.

### schema-card

```typst
#schema-card(
  from: none,
  caption: none,
)[...]
```

The complete presentation object for a conceptual schematic. The card has no
outer frame by default. Its body may be:

- an imported conceptual image;
- inline Typst drawing;
- a standalone `.typ` schematic;
- a coordinated representation combining equations, labels, and a graphical
  model.

A schema is defined by conceptual role rather than production mechanism.

### source-note

```typst
#source-note[...]
```

Small centered provenance/citation text for exceptional or non-card
compositions, including summaries. Figure/schema provenance normally belongs in
the corresponding card instead.

### note

```typst
#note[...]
```

A margin/aside note inherited from the theme.

## 7. Section-summary architecture

A section summary is a special course-level slide architecture. It looks
backward rather than introducing a new argument. It reuses a small number of
already-taught visual anchors and states short conclusions already established
by the section.

Current components:

```typst
#section-summary-visual[...]
#section-summary-takeaways[...]
```

`section-summary-visual` provides the recognizable 5.5 cm visual region.
`section-summary-takeaways` provides the TAKE HOME band and defaults to
`fs("xs")`.

The summary architecture does not need to imitate ordinary card composition
merely for consistency.

## 8. Schema drawing primitives

### schema-node

```typst
#schema-node(
  [Label],
  [Body],
  fill: ...,
  density: "normal",
)
```

A lower-level cell used inside a conceptual schema.

Current density vocabulary:

- `"normal"` — ambient-size, centered body for short symbolic content;
- `"prose"` — smaller, left-aligned body for multi-line descriptions.

This density vocabulary is schematic-specific and remains provisional. It is not
a general card-density system.

### schema-arrow

```typst
#schema-arrow
```

A right-pointing arrow sized for use beside schema nodes.

### Fletcher/Touying diagram primitives

`course-diagram`, `graph-node`, and `graph-edge` are low-level primitives
for standalone Typst schematics such as graphical models. They sit below
`schema-card` in the presentation hierarchy.

## 9. Images and assets

### course-image

```typst
#course-image(
  path,
  width: 100%,
  height: auto,
)
```

A low-level asset loader. It preserves aspect ratio and contains missing-asset
fallback behavior. It does not own captions or provenance.

Lecture-local path helpers may turn lecture-relative asset names into paths
resolved from `Lectures/course.typ`.

A missing asset can intentionally render as a placeholder during development,
so successful Typst compilation alone does not prove that all production assets
exist.

Production mechanism and presentation role remain separate. A Python-generated
SVG may sit in a figure-card or schema-card depending on what it means in the
slide.

## 10. Reveal architecture

The normal temporal structure is a cumulative numbered build.

State 1 is implicit: material visible when the slide first appears is left
unwrapped.

Subsequent states normally use:

```typst
#uncover("2-")[...]
#uncover("3-")[...]
```

The same state number may coordinate object content and its corresponding
interpretation in key-points. Interpretation may also intentionally trail the
construction when the teaching move is “build or derive first, then interpret.”

`only` and `alternatives-match` are exceptional replacement/focus mechanisms.
Replacement regions normally reserve stable geometry so the slide does not
jump.

Ordinary course slides do not use `pause`; explicit numbered states are more
legible across separate regions.

Callback-style `#slide(repeat: ..., self => ...)` is exceptional. It is useful
when nested reveal states cannot be discovered by Touying's ordinary repeat
inference. Lecture 1 contains a concrete example on “Conditioning shifts the mean
by an observed deviation.”

No additional course-level reveal helper is currently part of the API. Native
Touying state notation is the readable symbolic representation.

Handout mode contains the final reveal state. Presentation and handout renderings
are both part of validation.

## 11. Width and density

Width and density are deliberately not unified into a generic base-card API.

Width normally belongs to the parent composition: columns, explicit blocks, and
object regions allocate space; cards fill the space they receive.

Density is not yet a single cross-card property. Recall material has a body-size
default, schema nodes have schematic-specific density, and ordinary cards often
use explicit `fs(...)`/`sp(...)` choices appropriate to their content.

The absence of a generic `_card`, `width:`, or universal `density:`
parameter is therefore intentional in the current API.

## 12. Provisional exported helpers

The following exist but are not established course conventions:

- `focus-slide`
- `ending-slide`
- `key-points` as a standalone component
- `definition`
- `method`
- `callout`
- `annotated-object`

Later lectures may supply evidence for promotion, redesign, or removal.

## 13. Helper promotion and lecture-local vocabulary

A repeated construction is evidence for review rather than an automatic reason
for abstraction.

Stable behavior belongs course-wide when centralizing it removes routine future
choices or makes cross-lecture correction materially easier. Lecture-specific
vocabulary, fixed figure-directory helpers, and local forwarding functions may
remain local.

A local forwarding helper can keep sibling schema nodes consistent without
creating a new global component. Such a helper contains no independent visual
logic.

## 14. Source/readability conventions

The slide source is intended to read like the intellectual argument.

User-facing visible content normally uses Typst content blocks rather than quoted
strings. Strings remain natural for enum/configuration values, paths, font names,
and similar data.

Named scales and layout helpers express ordinary choices. Raw layout values are
still acceptable when they communicate real content-fitting or optical geometry
more clearly.

The deck distinguishes established course conventions from provisional exported
helpers. Open design questions can remain open until later lectures provide
evidence.

## 15. Reference files and validation

Authoritative live files:

- `Lectures/course.typ`
- `Lectures/L01_Probability_Statistics/slide_deck.typ`
- `Lectures/authoring_reference.typ`
- this API reference

Frozen numbered files such as `course_07.typ` and `slide_deck_07.typ` are
checkpoints, not the live authoring API.

The compact reference deck is source-first. Any PDF used to judge its appearance
is expected to have been freshly compiled from the current
`authoring_reference.typ` and current `course.typ`; a stale PDF is not a
design authority.
