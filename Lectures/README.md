# First-pass shared Typst course layer

Expected local theme path:

```text
Lectures/themes/ruled-page/template.typ
```

Files:

```text
Lectures/
├── course.typ
└── L01_Probability_Statistics/
    ├── slide_deck.typ
    ├── coin_model.ipynb
    └── figures/
        ├── coin_model__beta_distribution.svg
        ├── coin_model__bernoulli_likelihood.svg
        ├── coin_model__prior_likelihood_posterior.svg
        ├── coin_model__sequential_updating.svg
        ├── coin_model__posterior_predictive.svg
        └── coin_model__sampling_monte_carlo.svg
```

## Design intent

`course.typ` is deliberately a thin course-specific layer over SeaSlides Ruled Page.

It adds:

- lecture metadata and title-slide ordering;
- muted lecture identity in the ordinary-slide header;
- current section at footer left and slide X/Y at footer right;
- numbered section slides with full title, short footer title, and subtitle;
- `content-slide` with `top`, `bottom`, `side-left`, and `side-right` composition;
- semantic wrappers `key-points`, `note`, `definition`, and `method`;
- `course-figure` with path provenance and missing-file fallback;
- lightweight coordinate-based annotations.

It intentionally delegates palette, typography, spacing, list styling, and most component styling to Ruled Page.

# # Slide Authoring Standards for Advanced Statistics 2027-1

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
- Lecture `.typ` files should focus on narrative, equations, figures, examples, and speaker notes rather than ad hoc styling.

## Coverage and source authority

- The authoritative source for slide coverage is the current agreed lecture or
  section plan from the discussion with the user, or an explicit construction
  brief supplied for that section.
- The syllabus and textbooks support that plan: use them to verify terminology,
  notation, equations, examples, provenance, and relevant background. Do not
  expand slide coverage merely because a topic appears in the syllabus or in an
  assigned reading.
- Treat a textbook as a coverage authority only when the user explicitly asks
  to follow, reproduce, or cover particular textbook material.
- If the current construction brief differs from the syllabus, an older plan, or
  a textbook's organization, follow the current construction brief for slide
  construction. Flag documentation that may need updating rather than silently
  reconciling the discrepancy inside the slides.
- Do not restore previously removed material simply because it is nearby in the
  source text. Every included topic must have a role in the current lecture
  argument.

## Intellectual construction of a lecture

A lecture is an argument, not a list of topics. Before implementing slides,
identify:

1. what students can be assumed to know when the section begins;
2. the question, tension, or problem that motivates the section;
3. the sequence of conceptual moves needed to address it;
4. the concrete example or examples that carry the argument;
5. what students should understand or be able to do when the section ends;
6. how that endpoint prepares the next section or later course material.

Include material because it advances that argument, not merely because it is
mathematically adjacent or available in the source material.

### Each section should have one job

A section should answer one identifiable question or accomplish one conceptual
transition. Start a new section when the kind of question changes substantially,
for example when moving from properties of probability distributions to
estimating unknown quantities from observed data.

Every slide in a section should have a clear answer to: "Why does this slide
occur here?" A technically correct slide that does not advance the section's
argument should be moved or removed.

### Prefer cumulative examples

Within a section, reuse an established example when it can support the next
conceptual move. Introduce a new example only when the change itself teaches
something.

Abstract structure should normally be motivated by a concrete case or used to
synthesize cases students have already seen. Avoid introducing an abstraction
and several unfamiliar examples at the same time.

## Slide-level content discipline

Control conceptual density, not only visual density.

- A substantive slide should normally make one principal conceptual move.
  Several equations, bullets, or visual elements are appropriate when they work
  together to make that one move.
- Split a slide when it asks students simultaneously to learn multiple new
  definitions, follow a derivation and interpret a new concept, absorb both a
  general principle and a substantially new example, track several new pieces of
  notation, or understand both a main result and an important caveat.
- Conversely, do not split one simple argument across multiple slides merely to
  reduce word count.
- Treat the densest successful slides elsewhere in the course as an upper bound,
  not as the default target.

### Slide titles should carry the argument

Prefer claim or question titles over topic labels when practical. A title such
as "Linearity makes expectations easy to combine" tells the student what the
slide is doing more clearly than "Linearity of expectation."

A topic title is still appropriate when defining or introducing that topic is
itself the purpose of the slide.

## Shared course API

Prefer a small stable vocabulary of reusable course components rather than one-off formatting in individual lecture files.

This list must stay in sync with what `Lectures/course.typ` actually exports. If you add, rename, or remove a component there, update this list in the same change — an API list that describes components which do not exist (or omits ones that do) is a standards-doc bug, not a minor omission.

Slide structure and composition:

- `#content-block(...)` — object + key-points composition, with `layout: "top" | "bottom" | "side-left" | "side-right"`
- `#twocol[...][...]`, `#triad[...][...][...]` — equal-width row layouts
- `#section-metadata(short-title: [...], subtitle: [...])` followed by a level-1
  heading (`= Section title`) — section divider and footer metadata
- `#title-slide()`, `#focus-slide[...]`, `#ending-slide[...]`

Create every section with this exact structure. Do not introduce or call a `section-slide` helper:

```typst
#section-metadata(
  short-title: [From statistics to machine learning],
  subtitle: [Same probabilistic language, different organizing questions],
)

= From statistics to machine-learning problems
```

Cards and notes:

- `#course-card(...)`, `#key-points[...]`
- `#definition(...)`, `#method(...)`
- `#note[...]` — margin/aside note

Schematic diagrams (boxes-and-arrows flow figures):

- `#schema-node(label, body, density: "normal")` — a labeled node box for a flow diagram cell. `density` picks a body-text preset from a small named vocabulary (currently `"normal"`, the default, for a short symbol-only line or two; `"prose"` for a smaller, left-aligned multi-line description) instead of a raw size number, so unrelated slides that pick the same density render identically.
- `#schema-arrow` — a right-pointing arrow cell to place beside nodes in a grid
- `#source-note[...]` — small muted caption/citation line for a schematic

Figures:

- `#course-figure(...)` — image with optional caption and source line; shows a labeled placeholder automatically when the file is missing, so a separate `maybe-image`-style wrapper is unnecessary
- `#figure-source(...)` — the provenance line alone, for a composite figure whose panels each set `show-source: false`

Speaker notes:

- `#speaker-note[...]` — provided by Touying directly, not by `course.typ`

Coordinate annotations:

- `#callout(...)`, `#annotated-object(...)`

### Do not duplicate a helper across lecture files

If a visual or layout pattern is used more than once, it belongs in `course.typ`, not copied into a lecture file. Concretely:

- The moment the same helper function (even a small one) appears — including by copy-paste — in a second lecture file, move it to `course.typ` and delete both local copies in the same change.
- Before writing a new lecture-local helper, check this list and `course.typ` for an existing component that already covers the need. Do not reinvent an existing primitive under a new name (for example, a second muted-caption function alongside `figure-source`).
- A helper is genuinely lecture-local only when it encodes a fact specific to that lecture, such as a fixed figure-directory prefix (`lecture-figure-path`) or a lecture-specific reveal pairing. Generic visual patterns (boxes, arrows, captions, layout grids) are course-wide by default.
- Do not keep two definitions of the same helper in one file either (for example, a path-prefix helper defined twice under different names). If you find one, merge them.

### Keep a set of sibling nodes consistent with one local forwarding function

When a single grid has several `schema-node` cells that must look alike (for example, four task categories that all state a Task/Performance pair), do not repeat the same formatting override at every node call — that repetition is exactly how nodes silently drift out of sync when one call gets edited and a sibling is missed. Instead, define one local function at the top of that `object:` block that fixes the shared choice and forwards everything else to `schema-node`, and call that function for every node in the grid:

```typst
#let taxonomy-node(label, ..body) = schema-node(label, stack(spacing: 0.35em, ..body), density: "prose")
```

This is a narrow, named exception to "do not duplicate a helper": the function holds no independent visual logic (no stroke, fill, or box geometry of its own), it only forwards a fixed choice of already-shared `schema-node` parameters, and it is scoped to the one slide that needs it.

## Speaker notes

- Every substantive slide should have a meaningful `#speaker-note[...]`.
- Speaker notes should record the intended argument, transition, emphasis, caveat, or teaching move.
- Do not use speaker notes merely to restate the visible slide text.

## Figures and computational provenance

- Statistical, simulation, posterior, data-analysis, and model-generated figures should be created in Python notebooks.
- Prefer one author-facing notebook per coherent conceptual construction, example dataset, or family of related figures rather than one giant lecture notebook or one notebook per individual figure.
- Save generated lecture figures as named files, preferably SVG for vector plots and diagrams.
- Place generated assets in a predictable lecture-local directory such as `generated/`.
- Typst should include generated files by path rather than screenshots or pasted raster copies.
- Use `#course-figure(...)` during development; it automatically renders a correctly sized, labeled placeholder when the file is missing, so no separate wrapper is needed.
- Missing assets are acceptable during drafting but should be treated as errors before a lecture is considered final.

## Student-facing notebooks

- Each lecture should also have one separate student-facing notebook for the approximately one-hour computational component.
- Student notebooks should be Colab-first and pedagogical: guided sequence, supplied code where appropriate, student modifications or implementation tasks, and interpretation/reflection questions.
- Do not force the student notebook to double as the source of lecture figures.
- Some duplication between student notebooks and author-facing figure notebooks is acceptable when it improves clarity and pedagogy.
- Do not assume that the student notebook must determine the lecture architecture
  during early slide planning. The relationship between lecture and self-work may
  be decided later, once the role of the computational component is clear, unless
  the user explicitly asks to co-design them.

## Layout and styling discipline

- Prefer reusable components and theme-level abstractions over ad hoc `rgb()`, manual fills, arbitrary spacing, or one-off boxes in lecture files.
- Use repeated layouts deliberately when comparison, sequence, or conceptual continuity benefits from consistency.
- Do not introduce visual variation solely for novelty.
- Keep mathematical slides readable: avoid excessive density, tiny text, or too many competing visual elements.
- Prefer Typst-native explanatory diagrams for conceptual structure, equations, graphical models, and schematic relationships.
- Prefer Python-generated figures for empirical, probabilistic, simulation, and data-driven graphics.
- Reusable components that a lecture may wrap in an ambient `#text(size: ...)` (such as `schema-node`) must express their own geometry — inset, radius, gaps — in `em` rather than fixed `pt` values. A component whose padding is hard-coded in points will not visibly shrink or grow when a caller changes the surrounding text size, which silently defeats the caller's intent. Fixed-`pt` hairline strokes are fine.

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
- every substantive slide should have speaker notes;
- the rendered deck should be visually reviewed.

## Intellectual, mechanical, and visual review

Treat these as separate quality gates.

### Intellectual review

Before polishing layout, review the deck for:

- the purpose and endpoint of each section;
- the logical dependency between slides;
- whether terminology and notation are introduced before they are used;
- whether each slide contains one manageable conceptual move;
- whether any slide is present only because the source material contains it;
- unnecessary repetition or unjustified jumps in abstraction;
- whether examples persist long enough to provide scaffolding;
- whether summaries synthesize rather than merely repeat;
- whether section transitions explain why the next question arises;
- whether the planned slide count is credible for the available teaching time.


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

## Narrative planning

For substantial lecture revisions, plan the intellectual sequence before
expanding every slide. Work from the authoritative coverage decision above, not
from the order of a textbook chapter.

Prefer:

1. conceptual goal and section endpoint;
2. sequence of claims or constructions;
3. motivating and cumulative examples;
4. equations and figures needed;
5. slide implementation.

For long lectures, maintain a lightweight slide inventory or outline so that
planning and execution remain separate. Revisit the outline when a new slide
changes the section's purpose, dependency structure, or time budget.

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
