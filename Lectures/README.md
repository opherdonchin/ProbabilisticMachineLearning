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
- Lecture `.typ` files should focus on narrative, equations, figures, and examples rather than ad hoc styling.

## Shared course API

Prefer a small stable vocabulary of reusable course components rather than one-off formatting in individual lecture files.

This list must stay in sync with what `Lectures/course.typ` actually exports. If you add, rename, or remove a component there, update this list in the same change — an API list that describes components which do not exist (or omits ones that do) is a standards-doc bug, not a minor omission.

Slide structure and composition:

- Ordinary teaching slides normally use one `#content-block(...)`. Its `object:` region composes presentation cards and layout primitives; its `key-points:` region states the conclusions or interpretations. Section-summary and other special-purpose slides may use a different architecture when that better matches their pedagogical role.
- `#content-block(...)` — object + key-points composition, with `layout: "top" | "bottom" | "side-left" | "side-right"`
- `#twocol[...][...]`, `#triad[...][...][...]` — standard row layouts; use `cols(...)` and `sp(...)` for named column ratios and spacing choices
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

- `#card[...]` — the default presentation card. It is intentionally unmarked in the current implementation; use it to identify a substantial semantic unit even when no visible boundary is wanted.
- `#bordered-card(...)` — ordinary card with visible Ruled Page chrome.
- `#recall-card(from: [...], ...)[...]` — previously established material brought into the current argument; provenance is required. It belongs inside the `object:` region of an ordinary `content-block`.
- `#figure-card[...]` — neutral frame for an imported or otherwise visually bounded figure object.
- `#key-points[...]`, `#definition(...)`, `#method(...)`
- `#note[...]` — margin/aside note
- During the current authoring stage, font size and internal spacing choices remain explicit in the deck through named `fs(...)` and `sp(...)` values. Do not infer a final card-density API yet.

Schematic diagrams (boxes-and-arrows flow figures):

- `#schema-card(label, body, density: "normal")` — a labeled card for a flow-diagram cell. Its existing `density` parameter is specific to schematic content and currently distinguishes short centered content from smaller left-aligned prose.
- `#schema-arrow` — a right-pointing arrow cell to place beside schema cards in a grid
- `#source-note[...]` — small muted caption/citation line for a schematic

Figures:

- `#course-figure(...)` — image with optional caption and source line; shows a labeled placeholder automatically when the file is missing, so a separate `maybe-image`-style wrapper is unnecessary
- `#figure-source(...)` — the provenance line alone, for a composite figure whose panels each set `show-source: false`

Coordinate annotations:

- `#callout(...)`, `#annotated-object(...)`

### Do not duplicate a helper across lecture files

If a visual or layout pattern is used more than once, it belongs in `course.typ`, not copied into a lecture file. Concretely:

- The moment the same helper function (even a small one) appears — including by copy-paste — in a second lecture file, move it to `course.typ` and delete both local copies in the same change.
- Before writing a new lecture-local helper, check this list and `course.typ` for an existing component that already covers the need. Do not reinvent an existing primitive under a new name (for example, a second muted-caption function alongside `figure-source`).
- A helper is genuinely lecture-local only when it encodes a fact specific to that lecture, such as a fixed figure-directory prefix (`lecture-figure-path`) or a lecture-specific reveal pairing. Generic visual patterns (boxes, arrows, captions, layout grids) are course-wide by default.
- Do not keep two definitions of the same helper in one file either (for example, a path-prefix helper defined twice under different names). If you find one, merge them.

### Keep a set of sibling nodes consistent with one local forwarding function

When a single grid has several `schema-card` cells that must look alike (for example, four task categories that all state a Task/Performance pair), do not repeat the same formatting override at every node call — that repetition is exactly how nodes silently drift out of sync when one call gets edited and a sibling is missed. Instead, define one local function at the top of that `object:` block that fixes the shared choice and forwards everything else to `schema-card`, and call that function for every node in the grid:

```typst
#let taxonomy-card(label, ..body) = schema-card(label, stack(spacing: 0.35em, ..body), density: "prose")
```

This is a narrow, named exception to "do not duplicate a helper": the function holds no independent visual logic (no stroke, fill, or box geometry of its own), it only forwards a fixed choice of already-shared `schema-card` parameters, and it is scoped to the one slide that needs it.

## Speaker notes

- Do not add speaker notes unless the instructor explicitly requests them.

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

## Layout and styling discipline

- Prefer reusable components and theme-level abstractions over ad hoc `rgb()`, manual fills, arbitrary spacing, or one-off boxes in lecture files.
- Use repeated layouts deliberately when comparison, sequence, or conceptual continuity benefits from consistency.
- Do not introduce visual variation solely for novelty.
- Keep mathematical slides readable: avoid excessive density, tiny text, or too many competing visual elements.
- Prefer Typst-native explanatory diagrams for conceptual structure, equations, graphical models, and schematic relationships.
- Prefer Python-generated figures for empirical, probabilistic, simulation, and data-driven graphics.
- Reusable components that a lecture may wrap in an ambient `#text(size: ...)` (such as `schema-card`) must express their own geometry — inset, radius, gaps — in `em` rather than fixed `pt` values. A component whose padding is hard-coded in points will not visibly shrink or grow when a caller changes the surrounding text size, which silently defeats the caller's intent. Fixed-`pt` hairline strokes are fine.

## Progressive disclosure and reveal planning

- **Use reveals by default for staged explanations.** New or substantially revised slides introducing several concepts, developing a derivation, or working through an example should normally build progressively. Keep single-point slides, recaps, reference material, and comparisons requiring simultaneous inspection static.
- **Design the complete final slide first.** Establish the content, visual hierarchy, and layout with everything visible. Then choose the pedagogical reveal sequence within that layout. Begin with meaningful context, assumptions, or a question. Each subsequent reveal should advance one teaching step. Usually one to three additional reveals suffice; avoid clicks that merely expose individual words.
- **Synchronize related content.** Reveal each equation, figure component, label, and corresponding interpretation together. Preserve earlier material needed to understand the next step.
- **Time key points deliberately.** Show orienting context immediately, interpretations with their supporting content, and concluding takeaways when justified. When asking students to predict, conceal the answer everywhere until the response step.
- **Prefer cumulative `uncover` sequences.** Use explicit reveal numbers when coordinating separate regions. Reserve `pause` for simple sequential flow and `only` or alternatives for intentional replacement.
- **Keep the layout stable.** Reserve space for hidden content and check that equations, figures, and bullets do not shift between states. Keep essential results available in the final handout state.
- **Make reveal timing clear from the slide content.** Keep consequential pauses and prediction questions legible in the reveal sequence.
- **Verify presentation and handout modes.** Inspect every state of changed slides with handout mode off, then check the final handout. Check overflow, premature answers, stray bullets, redundant clicks, and missing content.

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
uv --no-config --cache-dir tmp/uv-cache run scripts/review_slides.py Lectures/L01_Probability_Statistics/slide_deck_revised.typ --slide "The Schur complement is the residual covariance"
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
