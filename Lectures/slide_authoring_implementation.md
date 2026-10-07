# Slide authoring implementation reference

Use this alongside [`README.md`](README.md). This file records mechanics;
the standards in `README.md` govern the teaching sequence and visual decisions.

## Shared course API

Prefer a small stable vocabulary of reusable course components rather than one-off formatting in individual lecture files.

This reference documents the intended author-facing API, not every private implementation helper. When an exported helper is meant for normal lecture authoring, document it here and state whether it is established or provisional.

Slide structure and composition:

- Ordinary teaching slides normally use one `#content-block(...)`. Its `object:` region composes cards and layout primitives; its `key-points:` region carries the conclusions or interpretations. Section-summary and other special-purpose slides may deliberately use another architecture.
- `#content-block(...)` — object + key-points composition. `layout: "top"` is the normal/default arrangement; use `"bottom"`, `"side-left"`, or `"side-right"` only when the slide argument calls for them.
- `#twocol[...][...]`, `#triad[...][...][...]` — standard row layouts; `cols(...)` and `sp(...)` provide named layout choices
- Treat grouping and layout as separate decisions. Use cards when content forms a meaningful semantic or visual unit; a card may itself contain `twocol`, `triad`, `grid`, or other layout.
- Prefer `twocol` and `triad` whenever they express the intended two- or three-column geometry clearly, regardless of whether their children are cards or unboxed content. Use raw `grid` when the required geometry is not naturally expressed by the current layout helpers—for example tables/matrices, multi-row or 2×2 arrangements, fixed replacement geometry, or more intricate schematic structure.
- `#section-metadata(short-title: [...], subtitle: [...])` followed by a level-1
  heading (`= Section title`) — section divider and footer metadata
- `#title-slide()` is established. `#focus-slide[...]` and `#ending-slide[...]` remain available but provisional until later lectures provide recurring use cases.

Create every section with this exact structure. Do not introduce or call a `section-slide` helper:

```typst
#section-metadata(
  short-title: [From statistics to machine learning],
  subtitle: [Same probabilistic language, different organizing questions],
)

= From statistics to machine-learning problems
```

Place `section-metadata` immediately before its level-1 heading, with no slide
or other content between them. Check the rendered footer on the slide before
and after every section divider; metadata must not change the previous slide.

Cards and notes:

- `#card[...]` — default, visually unmarked presentation card.
- `#bordered-card(...)` — ordinary visibly bounded card.
- `#recall-card(from: [...], ...)[...]` — carried-forward material with required provenance; use inside `content-block.object`, not as a peer of `content-block`.
- The normal recall-card body size is `fs("m")`. Width belongs to the parent composition: constrain a standalone recall with `block(width: ...)` or let it fill its column.
- `#figure-card(from: [...], caption: [...])[...]` — complete figure presentation object; owns frame, optional caption, and optional provenance.
- `#note[...]` — margin/aside note.
- Deck source expresses card font sizes and internal spacing with named `fs(...)` and `sp(...)` choices. The scales are calibrated together: same-name choices should form a sensible default density, while `sp("xxs")` is reserved for optical/micro spacing. Do not add general density variants without evidence from later lectures.

Section summaries:

- `#section-summary-visual[...]` and `#section-summary-takeaways[...]` implement the current section-summary convention.
- Summaries look backward, reuse already-taught anchors, and state already-established conclusions. They are special architecture and need not imitate ordinary card composition merely for consistency.

Available but provisional:

- `#focus-slide[...]`, `#ending-slide[...]`, `#key-points[...]`, `#definition(...)`, `#method(...)`, `#callout(...)`, and `#annotated-object(...)` are retained but not yet validated as recurring course conventions.

Figures and schemas:

- `#figure-card(from: [...], caption: [...])[...]` is the complete figure presentation object. Imported, generated, and composite figures use the same card.
- `#schema-card(from: [...], caption: [...])[...]` is the complete conceptual-diagram presentation object. Imported and Typst-drawn schemas use the same card.
- `#schema-node(label, body, density: "normal")` and `#schema-arrow` are drawing primitives inside a schema, not presentation cards. The node density choices remain schematic-specific.
- `#course-diagram`, `#graph-node`, and `#graph-edge` are low-level Fletcher/Touying primitives for standalone Typst schematics such as graphical models.
- `#course-image(...)` is only an asset loader with sizing/aspect-ratio/missing-file behavior. Caption and provenance belong to the outer figure/schema card.
- `#source-note[...]` is for provenance in exceptional compositions that do not use a figure/schema card, including special summary architectures.

Coordinate annotations:

- `#callout(...)`, `#annotated-object(...)`

### Promote stable shared helpers

Check `course.typ` before adding a lecture-local helper. Promote a pattern when
it is used across lectures, its behavior has stabilized, and centralizing it
will make future slides easier to write or correct. A second use is a prompt to
review the pattern, not an automatic reason to enlarge the shared API.

- Reuse an existing shared component when it covers the need; do not reinvent
  an equivalent primitive under another name.
- Keep one-off teaching constructions local, even when they use a general
  layout primitive such as a grid or stack.
- A path prefix or a reveal pairing specific to one lecture can remain local.
- When promoting a helper, move the implementation and update this API list in
  the same change.
- Do not keep two definitions of the same helper in one file either (for example, a path-prefix helper defined twice under different names). If you find one, merge them.

### Keep a set of sibling nodes consistent with one local forwarding function

When a single grid has several `schema-node` cells that must look alike (for example, four task categories that all state a Task/Performance pair), do not repeat the same formatting override at every node call — that repetition is exactly how nodes silently drift out of sync when one call gets edited and a sibling is missed. Instead, define one local function at the top of that `object:` block that fixes the shared choice and forwards everything else to `schema-node`, and call that function for every node in the grid:

```typst
#let taxonomy-node(label, ..body) = schema-node(
  label,
  stack(spacing: sp("xs"), ..body),
  density: "prose",
)
```

This local function holds no independent visual logic. It forwards one shared
choice to sibling nodes so a later edit cannot make them drift apart.

## Speaker notes

Do not add speaker notes during slide development. Speaker notes are generated
later, after the visible deck is stable, as a separate production-stage task.

## Open design questions

Do not resolve an uncertain design question merely to make the API look complete.
If L01 does not provide enough evidence for a new component, density variant, or
special slide type, leave the decision open and use L02 as the next source of
evidence. Stable defaults should compress routine choices; speculative
abstractions should not.

## Student-facing notebooks

- Each lecture should also have one separate student-facing notebook for the approximately one-hour computational component.
- Student notebooks should be Colab-first and pedagogical: guided sequence, supplied code where appropriate, student modifications or implementation tasks, and interpretation/reflection questions.
- Do not force the student notebook to double as the source of lecture figures.
- Some duplication between student notebooks and author-facing figure notebooks is acceptable when it improves clarity and pedagogy.
- Do not assume that the student notebook must determine the lecture architecture
  during early slide planning. The relationship between lecture and self-work may
  be decided later, once the role of the computational component is clear, unless
  the user explicitly asks to co-design them.
