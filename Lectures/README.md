# Slide Authoring Standards for Advanced Statistics 2027-1

This is the canonical authoring standard for the course. It supersedes earlier
standalone drafts such as `advanced_statistics_slide_authoring_standards.md`
when those drafts disagree with the repository.

## Shared Typst course layer

The expected theme path is:

```text
Lectures/themes/ruled-page/template.typ
```

A lecture normally lives under `Lectures/LXX_.../` with its `slide_deck.typ`,
lecture-local figures and author notebooks, and a separate student-facing
notebook where appropriate.

## Design intent

`course.typ` is deliberately a thin course-specific layer over SeaSlides Ruled
Page. It carries the visual language and mechanics that future lecture authors
should not have to re-decide.

It adds:

- lecture metadata, title-slide ordering, section dividers, headers, and footers;
- `content-block` for ordinary object + key-points composition;
- calibrated `fs(...)`, `sp(...)`, and `cols(...)` scales plus simple row layouts;
- semantic presentation objects such as `card`, `bordered-card`,
  `recall-card`, `figure-card`, and `schema-card`;
- a recognizable section-summary architecture;
- low-level figure/schema loading, provenance, and diagram primitives.

It continues to delegate the base palette, page geometry, base typography, list
styling, and most theme styling to Ruled Page.

Use these standards when creating or editing lecture slides for this project.

## Agent Skills prerequisite

AI agents must always use both the `typst-author` and `touying-author` skills from
[apcamargo/typst-skills](https://github.com/apcamargo/typst-skills) when creating
or editing lecture slides. Before continuing, check that both skills are installed
in the current agent environment; if either is unavailable, inform the user.

## Core architecture

- Use Typst + Touying for lecture slides.
- Use Touying version `0.7.4` for project-owned lecture themes and shared components.
- Keep lecture content separate from reusable styling and layout logic.
- Put shared visual style, layout helpers, and reusable slide components in the shared course include `Lectures/course.typ`. It sits on top of a vendored, read-only base theme in `Lectures/themes/`.
- Lecture `.typ` files should focus on narrative, equations, figures, and examples rather than ad hoc styling.

## Shared course API

Prefer a small stable vocabulary of reusable course components rather than one-off formatting in individual lecture files.

This section documents the intended author-facing API, not every private implementation helper. When an exported helper is meant for normal lecture authoring, document it here and state whether it is an established convention or still provisional.

Slide structure and composition:

- Ordinary teaching slides normally use one `#content-block(...)`. Its `object:` region composes presentation cards and layout primitives; its `key-points:` region states the conclusions or interpretations. Section-summary and other special-purpose slides may use a different architecture when that better matches their pedagogical role.
- `#content-block(...)` — object + key-points composition. `layout: "top"` is the normal/default arrangement; use `"bottom"`, `"side-left"`, or `"side-right"` only when the slide argument calls for them.
- `#twocol[...][...]`, `#triad[...][...][...]` — standard row layouts; use `cols(...)` and `sp(...)` for named column ratios and spacing choices
- Treat grouping and layout as separate decisions. Use cards when content forms a meaningful semantic or visual unit; a card may itself contain `twocol`, `triad`, `grid`, or other layout.
- Prefer `twocol` and `triad` whenever they express the intended two- or three-column geometry clearly, regardless of whether their children are cards or unboxed content. Use raw `grid` when the required geometry is not naturally expressed by the current layout helpers—for example tables/matrices, multi-row or 2×2 arrangements, fixed replacement geometry, or more intricate schematic structure.
- `#section-metadata(short-title: [...], subtitle: [...])` followed by a level-1
  heading (`= Section title`) — section divider and footer metadata
- `#title-slide()` — established course title slide. `#focus-slide[...]` and `#ending-slide[...]` remain available theme conveniences, but are provisional until later lectures demonstrate a recurring need.

Create every section with this exact structure. Do not introduce or call a `section-slide` helper:

```typst
#section-metadata(
  short-title: [From statistics to machine learning],
  subtitle: [Same probabilistic language, different organizing questions],
)

= From statistics to machine-learning problems
```

Cards and notes:

- `#card[...]` — the default presentation card. It is intentionally unmarked; use it to identify a substantial semantic or visual unit even when no visible boundary is wanted.
- `#bordered-card(...)` — ordinary card with visible Ruled Page chrome.
- `#recall-card(from: [...], ...)[...]` — previously established material brought into the current argument; provenance is required. It belongs inside the `object:` region of an ordinary `content-block`.
- The normal recall-card body size is `fs("m")`; override it only when the carried-forward material clearly benefits from a larger or smaller presentation.
- Standalone recall cards normally use a parent alignment/width composition such as `#align(left)[#block(width: 50%)[#recall-card(...) [...]]]`. Within a `twocol` or other column layout, let the card fill its allocated column.
- `#figure-card(from: [...], caption: [...])[...]` — complete figure presentation object. It owns the figure frame, optional caption, and optional provenance. Its body may be a single image or a composite.
- `#note[...]` — margin/aside note.
- During authoring, font size and internal spacing choices remain explicit through named `fs(...)` and `sp(...)` values. The two scales are calibrated as a family: matching labels should give a coherent density. Use `xxs` spacing for deliberately optical/micro gaps; do not use it as the normal item spacing for `fs("xs")` text. Do not invent a general card-density API until later lectures provide evidence.

Section summaries:

- `#section-summary-visual[...]` and `#section-summary-takeaways[...]` form the current course-level summary convention.
- A section summary looks backward: reuse a small number of already-taught visual anchors and state short conclusions that the section has already established. Do not introduce a new argument on a summary slide.
- **End the section on this summary.** Do not append a preview, segue, teaser, "next we will" remark, or question whose purpose is to lead into the following section. If a connection is needed, establish it when the following section begins; do not make a handoff the preceding section's conclusion.
- A lecture-to-notebook task may have a separately defined introduction, but do not turn a section summary into a preview of that task.
- Section summaries are a special slide architecture. They need not imitate the ordinary card grammar merely for consistency.

Available but provisional:

- `#focus-slide[...]`, `#ending-slide[...]`, `#key-points[...]`, `#definition(...)`, `#method(...)`, `#callout(...)`, and `#annotated-object(...)` remain available, but L01 did not establish them as recurring course conventions. Keep them simple and let later lectures determine whether they deserve promotion, redesign, or removal.

Figures and schemas:

- `#figure-card(from: [...], caption: [...])[...]` classifies a complete figure by its pedagogical role. Imported, course-generated, and composite figures use the same outer card; how the visual was produced is an implementation detail.
- `#schema-card(from: [...], caption: [...])[...]` classifies a complete conceptual diagram. The body may be an imported image, a generated asset, inline Typst, or a standalone `.typ` helper.
- `#schema-node(label, body, density: "normal")` and `#schema-arrow` are lower-level drawing primitives used *inside* Typst-drawn schemas. They are not presentation cards. `schema-node` retains its existing schematic-specific density vocabulary.
- `#course-diagram`, `#graph-node`, and `#graph-edge` are low-level Fletcher/Touying primitives for standalone Typst diagrams such as graphical models; they are implementation vocabulary beneath a `schema-card`, not alternative presentation-card types.
- `#course-image(...)` is a low-level image loader only: sizing, aspect-ratio preservation, and missing-file placeholder. It does not own caption or provenance.
- `#source-note[...]` remains available for small provenance/citation lines in compositions that are not figure/schema cards (for example special summary architectures).
- Use `from:` on a figure/schema card when the card has meaningful external, adapted, or computational provenance. Course-authored diagrams may omit it when no displayed attribution is useful.

Coordinate annotations:

- `#callout(...)`, `#annotated-object(...)`

### Promote stable shared helpers

Check `course.typ` before adding a lecture-local helper. Reuse an existing component when it already covers the need.

Promote a pattern when its behavior is stable and centralizing it will reduce future authoring choices or make cross-lecture correction easier. Repetition is evidence, not an automatic promotion rule: a second use should trigger review, while one-off teaching constructions and lecture-specific vocabulary may remain local.

- A path prefix, a lecture-specific reveal pairing, or a local forwarding function may remain lecture-local.
- Generic visual logic should not be copied under multiple names.
- When a helper is promoted, move the implementation and update the authoring docs in the same change.
- Do not keep duplicate definitions of the same helper in one file.

### Keep a set of sibling nodes consistent with one local forwarding function

When one grid has several `schema-node` cells that must look alike, a slide-local forwarding function can fix their shared choices without inventing a new course component:

```typst
#let taxonomy-node(label, ..body) = schema-node(
  label,
  stack(spacing: sp("xs"), ..body),
  density: "prose",
)
```

Such a function contains no independent visual logic; it only keeps sibling nodes consistent. It can remain local even if a similar forwarding pattern appears elsewhere.

## Speaker notes

- Do not add speaker notes during slide development.
- Speaker notes are a later production-stage artifact, generated after the visible slide deck is stable. Add them only when the instructor explicitly asks to enter that production stage.

## Figures and computational provenance

- Statistical, simulation, posterior, data-analysis, and model-generated figures should be created in Python notebooks.
- Prefer one author-facing notebook per coherent conceptual construction, example dataset, or family of related figures rather than one giant lecture notebook or one notebook per individual figure.
- Save generated lecture figures as named files, preferably SVG for vector plots and diagrams.
- Place generated assets in a predictable lecture-local directory such as `generated/`.
- Typst should include generated files by path rather than screenshots or pasted raster copies.
- Use `#course-image(...)` inside the appropriate `figure-card` or `schema-card` during development; it automatically renders a correctly sized, labeled placeholder when the file is missing, so no separate wrapper is needed.
- Missing assets are acceptable during drafting but should be treated as errors before a lecture is considered final.

## Student-facing notebooks

- Each lecture should also have one separate student-facing notebook for the approximately one-hour computational component.
- Student notebooks should be Colab-first and pedagogical: guided sequence, supplied code where appropriate, student modifications or implementation tasks, and interpretation/reflection questions.
- Do not force the student notebook to double as the source of lecture figures.
- Some duplication between student notebooks and author-facing figure notebooks is acceptable when it improves clarity and pedagogy.

## Layout and styling discipline

- Prefer reusable components and theme-level abstractions over ad hoc `rgb()`, manual fills, arbitrary spacing, or one-off boxes in lecture files.
- Use repeated layouts deliberately when comparison, sequence, or conceptual continuity benefits from consistency.
- Do not introduce visual variation solely for novelty.
- Keep mathematical slides readable: avoid excessive density, tiny text, or too many competing visual elements.
- Prefer Typst-native explanatory diagrams for conceptual structure, equations, graphical models, and schematic relationships.
- Prefer Python-generated figures for empirical, probabilistic, simulation, and data-driven graphics.
- Reusable components that a lecture may wrap in an ambient `#text(size: ...)` (such as `schema-node`) must express their own geometry — inset, radius, gaps — in `em` rather than fixed `pt` values. A component whose padding is hard-coded in points will not visibly shrink or grow when a caller changes the surrounding text size, which silently defeats the caller's intent. Fixed-`pt` hairline strokes are fine.

## Progressive disclosure and reveal planning

- **Use reveals by default for staged explanations.** New or substantially revised slides introducing several concepts, developing a derivation, or working through an example should normally build progressively. Keep single-point slides, recaps, reference material, and comparisons requiring simultaneous inspection static.
- **Design the complete final slide first.** Establish the content, visual hierarchy, and layout with everything visible. Then choose the pedagogical reveal sequence within that layout. Begin with meaningful context, assumptions, or a question. Each subsequent reveal should advance one teaching step. Usually one to three additional reveals suffice; avoid clicks that merely expose individual words.
- **State 1 is implicit.** Content visible when the slide first appears stays unwrapped. Do not write `uncover("1-")` merely to label the initial state.
- **Use cumulative `uncover("N-")` as the normal timing mechanism.** Explicit state numbers make timing readable across the object and key-points regions. Use the same state number when a visual/equation and its interpretation belong to the same teaching step.
- **Interpretation may deliberately trail construction.** It is fine to reveal a result first and a synthesis or takeaway on a later state when the pedagogy is “build/derive, then interpret.”
- **Use replacement only when replacement is the teaching operation.** Reserve `only` and `alternatives-match` for temporary focus or mutually replacing content, and provide stable surrounding geometry so the slide does not jump.
- **Avoid `pause` in ordinary course slides.** Explicit numbered states are easier to coordinate and review. Likewise, use callback-style `#slide(repeat: ..., self => ...)` only when some technical requirement genuinely needs callback animation; ordinary `uncover` markup should rely on Touying's normal reveal handling.
- **Keep the layout stable.** `uncover` should normally reserve space for hidden content. Check that equations, figures, and bullets do not shift between states and that essential results remain present in the final handout state.
- **Verify presentation and handout modes.** Inspect every state of changed slides with handout mode off, then check the final handout. Check overflow, premature answers, stray bullets, redundant clicks, replacement-state geometry, and missing content.

## Content blocks and component arguments

- Prefer Typst content blocks for user-facing text in reusable components, for example:
  
  ```typst
  #card[Title][Body]
  ```
  
  rather than passing visible slide copy as quoted strings.

- Use strings for genuinely string-valued data such as file paths, URLs, enum/config values, and font names.

## Drafting versus finalization

During drafting:

- placeholders are acceptable;
- incomplete notes are acceptable;
- draft-only TODO markers are acceptable;
- visual review may be targeted.

Before a lecture is considered final:

- the Typst source must compile cleanly;
- all required figures and assets must exist;
- there should be no unintended overflow or clipped content;
- slide count should be plausible for the intended lecture duration;
- the rendered deck should be visually reviewed.

## Mechanical checks versus visual review

Treat these as separate quality gates.

### Mechanical checks

Check that:

- Typst compiles successfully;
- no required files are missing;
- there is no content overflow or layout failure;
- expected output pages are generated;
- figure paths and imports resolve correctly.

### Visual review

Inspect the rendered slides for:

- legibility;
- equation density;
- figure readability;
- visual hierarchy;
- alignment and spacing;
- sensible use of repeated layouts;
- narrative flow across slides;
- whether the intended teaching emphasis is visually apparent.

Compilation alone is not sufficient evidence that a slide is good.

## Efficient iteration for local slide edits

- Read the target slide and its immediate neighbors first. Expand context only
  when a mathematical dependency, section change, or shared component requires it.
- Reuse the build command below instead of writing new compilation and extraction
  scripts for each edit. It checks math attachments, compiles both full-deck modes,
  renders selected slides and all their reveals, compares final reveals with the
  handout, and detects changes to the entry source during the run.
- Inspect every changed reveal and handout; open only the previews listed in the
  current `report.json`. The report's mechanical pass is not visual approval.
  Check mathematical correctness and narrative continuity separately.
- Once checks pass, stop unless new edits or a specific concern justify another
  pass. Broaden visual review for shared styles, figure changes, or section
  restructuring. Regenerate distribution artifacts at delivery checkpoints;
  do not claim older exports are current.
- Keep tool output and completion reports concise. Do not reread unchanged
  instructions already available in the current conversation. Batch related
  edits and checks, preserving concurrent user changes.

From the repository root:

```powershell
uv --no-config --cache-dir tmp/uv-cache run scripts/review_slides.py Lectures/L01_Probability_Statistics/slide_deck.typ --slide "The Schur complement is the residual covariance"
```

Repeat `--slide` for multiple titles. The script uses pinned, isolated tooling
dependencies and leaves the notebook environment and lecture source untouched.
The workspace-local cache avoids sandbox access errors in the user cache. Add
`--offline` before the script path when these tooling dependencies are cached.
Current review PDFs and PNGs are in `build/slide-review/<lecture>/<entry>/`.
It supports the course's explicit `config-common(handout: true/false)` setting
and plain-text slide headings; it fails visibly if it cannot locate a title.

For delegated layout review, use [the reusable review prompt](slide_layout_review.md).
Supply exact slide titles, the current render report, and explicit read-only or
layout-only permission. Prefer a lower-cost model for this bounded review; the
author remains responsible for mathematics and the teaching argument.

## Narrative planning

- Summary slides look back only: consolidate the completed section's ideas,
  results, and distinctions. Do not preview the next section or end with a
  forward-looking question; put transitions on separate slides.
- For a model-based inference section, establish the model (including a graphical
  description), state the tasks as probability queries, then present solutions
  explicitly tied to those tasks. Separate model and task slides when needed
  for readability. Distinguish inference with given parameters from learning.
- Use transition slides only when they do conceptual work, such as posing a
  substantive problem. Avoid slides that merely announce what comes next.

For substantial lecture revisions, plan the intellectual sequence before expanding every slide.

Prefer:

1. conceptual goal;
2. sequence of claims or constructions;
3. examples and figures needed;
4. slide implementation.

For long lectures, maintain a lightweight slide inventory or outline so that planning and execution remain separate.

## Asset discipline

- Use images and figures only when they serve the explanation.
- Do not add decorative visuals merely because they are available.
- Prefer original, reproducible, course-owned explanatory graphics when practical.
- When reusing material from earlier course slides, redraw or regenerate it cleanly rather than relying on low-resolution screenshots where possible.

## General principle

The lecture source should read like the intellectual argument of the lecture.

The shared include should carry the course's visual language and reusable mechanics.

The notebooks should carry the computation.

The final rendered deck should be reproducible, visually coherent, and easy to revise without duplicating styling or infrastructure across lectures.
