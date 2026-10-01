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
    ├── gaussian_geometry_figures.ipynb
    ├── generated/
    │   ├── gaussian_contours.svg
    │   ├── gaussian_shell_radius.svg
    │   └── gaussian_spread.svg
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

# Slide Authoring Standards for Advanced Statistics 2027-1

Use these standards when creating or editing lecture slides for this project.

## Style recipe and exemplars

The visual reference is the rendered `L01_Probability_Statistics/slide_deck.pdf`,
not a generic presentation template. The course uses a 16:9 warm paper canvas,
dark serif text, a restrained terracotta rule and emphasis color, generous open
space, and small muted lecture/section metadata. `course.typ` and the vendored
Ruled Page theme own those choices; reuse them rather than recreating the look
in a lecture file.

Use these three slides in `L01_Probability_Statistics/slide_deck.typ` as layout
examples, while checking their *rendered* versions before copying a pattern:

- **Figure-led:** “The posterior is a distribution representing uncertainty”
  gives one plot the main visual area and puts its interpretation below.
- **Equation-led:** “Integrals create linearity” separates the identities from
  the short statements students should retain.
- **Comparison:** “Sample moments estimate population moments” aligns related
  population and sample quantities so their correspondence is visible.

These are compositional examples, not content to repeat. Start with the object
students need to inspect, then add only the explanation needed to read it. Use
the theme's normal body size as the baseline. If a formula, plot label, or
annotation needs substantially smaller text, simplify, crop, or split the slide
and inspect it at projected size.

## Section brief before authoring

For each new section, record the following in a short plan or the working
discussion. A textbook section list alone does not choose the lecture argument.

| Decision | Record |
| --- | --- |
| Starting point | What students already know and which earlier example can be reused |
| Section question and endpoint | The question this section answers and the result students should retain |
| Required source coverage | Book sections, specific equations/figures, and the role each plays |
| Exclusions | Material deliberately left for another lecture, notebook, or reading |
| Slide sequence | The conceptual moves and the example that carries them |
| Time | Approximate presentation and discussion minutes, including reveals |

Use the current agreed brief as the coverage authority described below. Recheck
the sequence after drafting: an equation can need more than one teaching slide,
and several adjacent textbook paragraphs can need only one.

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

### Close sections without foreshadowing

- A section summary or final slide must close the section's own argument: synthesize its claims, name its endpoint, or state the result students should retain.
- Do not use summary bullets or speaker notes to preview the next section, promise later material, or explain what the next slide or lecture will do. If a transition is needed, begin the next section with it or use a dedicated bridge slide whose job is explicitly to make that transition.
- During review, inspect the last substantive slide and the summary slide as endpoints. Remove phrases such as "next section," "next slide," "later," "will return," or "will meet again" when they point outside the current section; replace them with a statement about what the current section established.

## Implementation reference

The component API, section syntax, and helper guidance live in
[`slide_authoring_implementation.md`](slide_authoring_implementation.md).
Read it when implementing a slide or changing `course.typ`; use the visual
and teaching standards here to decide what to implement.

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
- Give students a source they can recognize, such as `Murphy, Book 1, Fig. 1.3`
  or an author and publication. Keep SVG filenames, notebook names, local
  paths, and regeneration details in source comments or speaker notes. Do not
  print them as the visible figure source.

## Layout and styling discipline

- Prefer reusable components and theme-level abstractions over ad hoc `rgb()`, manual fills, arbitrary spacing, or one-off boxes in lecture files.
- Use repeated layouts deliberately when comparison, sequence, or conceptual continuity benefits from consistency.
- Do not introduce visual variation solely for novelty.
- Keep mathematical slides readable: avoid excessive density, tiny text, or too many competing visual elements.
- Prefer Typst-native explanatory diagrams for conceptual structure, equations, graphical models, and schematic relationships.
- Prefer Python-generated figures for empirical, probabilistic, simulation, and data-driven graphics.
- Reusable components that a lecture may wrap in an ambient `#text(size: ...)` (such as `schema-node`) must express their own geometry — inset, radius, gaps — in `em` rather than fixed `pt` values. A component whose padding is hard-coded in points will not visibly shrink or grow when a caller changes the surrounding text size, which silently defeats the caller's intent. Fixed-`pt` hairline strokes are fine.
- Use reveals only when the order of appearance explains a dependency, invites
  a prediction, or keeps a comparison aligned while one part is introduced.
  Count the time and rendered pages created by reveals in the section plan.

### Typst math attachment spacing

- In Typst math, an ungrouped subscript or superscript can consume the following expression until the next space. When a script is followed by a separate bracketed expression, add a space: write `$E_Y [V[X | Y]]$` and `$E_theta [Y]$`, not `$E_Y[V[X | Y]]$` or `$E_theta[Y]$`.
- The same rule applies to a scripted symbol followed by a parenthesized argument: write `$p_D (z | x_"obs")$`, not `$p_D(z | x_"obs")$`. Group a compound attachment explicitly, as in `$sum_(i=1)^n X_i$`.
- During source review, search math for `_` and `^`, especially when an attachment is immediately followed by `[...]`, another identifier, or a separate grouped expression. Use explicit parentheses after `_` or `^` when the attachment itself contains multiple terms, as in `sum_(n=1)^N`.
- Before handing off a changed lecture deck, run `python scripts/check_typst_math_attachments.py Lectures/L01_Probability_Statistics/slide_deck.typ` (substitute the edited deck path). It flags likely run-ons inside math, including `p_D(` and `E_Y[`. Review each result; the check is intentionally focused and does not replace visual review.

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
- every reveal state should be rendered and visually reviewed at projection
  size, including the first and last state of each slide;
- the committed PDF should be regenerated from the current source.

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
- Math source has been checked for unintended subscript/superscript grouping, especially an attachment immediately followed by a bracketed expression.
- section metadata starts on the intended divider and does not change the
  previous slide's footer;
- the source and generated PDF agree on the section sequence and slide count.

### Visual review

Inspect the rendered slides for:

- legibility;
- equation density;
- figure readability;
- visual hierarchy;
- alignment and spacing;
- subscripts and superscripts attach only to the intended symbols, and a following bracketed argument remains on the baseline rather than becoming part of the attachment;
- sensible use of repeated layouts;
- narrative flow across slides;
- whether the intended teaching emphasis is visually apparent;
- whether summary and final slides feel like endpoints rather than previews of what comes next.
- header and footer clearance on every reveal state, especially after a long
  title, equation, note, or progressive reveal;
- plot axes, legends, annotations, and image text at realistic projector size;
- visible citations that name a source rather than a local asset file.

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
