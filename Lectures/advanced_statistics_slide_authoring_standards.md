# Slide Authoring Standards for Advanced Statistics 2027-1

Use these standards when creating or editing lecture slides for this project.

## Core architecture

- Use Typst + Touying for lecture slides.
- Use Touying version `0.7.4` for project-owned lecture themes and shared components.
- Keep lecture content separate from reusable styling and layout logic.
- Put shared visual style, layout helpers, and reusable slide components in a common course include such as `course/common.typ`.
- Lecture `.typ` files should focus on narrative, equations, figures, examples, and speaker notes rather than ad hoc styling.

## Shared course API

Prefer a small stable vocabulary of reusable course components rather than one-off formatting in individual lecture files.

Examples include:

- `#takehome[...]`
- `#bridge[...]`
- `#warn[...]`
- `#checkpoint[...]`
- `#definition[...]`
- `#example[...]`
- `#eqbox[...]`
- `#twocol[...] [...]`
- `#triad[...] [...] [...]`
- `#course-figure(...)`
- `#maybe-image(...)`
- `#section-slide(...)`
- `#summary-slide(...)`
- `#speaker-note[...]`

If a visual or layout pattern is used repeatedly, add or improve it in `common.typ` rather than reproducing it inside lecture files.

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
- Use `#maybe-image(...)` or an equivalent wrapper during development so missing figures produce a correctly sized labeled placeholder.
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

## Narrative planning

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
