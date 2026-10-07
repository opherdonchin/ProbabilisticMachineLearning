---
name: slide-authoring
description: Implement an approved slide-design specification in the course's Typst/Touying system, including lecture-local assets and reveal mechanics, while preserving pedagogical meaning and validating presentation and handout renders.
---

# Author approved slide designs

Use this skill after lecture scope, section design, slide-level organization, and slide design have already been approved.

The primary responsibility of this skill is:

> **Express the approved student-visible design cleanly, reproducibly, and legibly in the course's Typst/Touying system.**

Slide Authoring owns implementation mechanics and visual realization. It does not own a second round of pedagogical design.

Work one approved section or an explicit allowlist of slides at a time unless the instructor asks for a broader implementation pass.

## What this skill owns

Slide Authoring owns:

- Typst/Touying implementation;
- mapping the approved design onto the current course API;
- exact layout geometry needed to realize the specified visual hierarchy;
- source structure and readability;
- lecture-local helpers when justified;
- implementation of figures, conceptual schematics, and other required assets;
- author-facing figure-generation notebooks;
- standalone `.typ` schematic files when appropriate;
- provenance placement;
- reveal syntax and stable reveal geometry;
- mechanical validation;
- presentation/handout compilation;
- targeted visual review and layout correction;
- implementation-level backpressure when the approved design cannot be realized cleanly;
- evidence-based proposals to extend the shared course API.

## What this skill is not

Do not use this skill to:

- change lecture scope;
- change section boundaries or endpoints;
- silently reorder, split, merge, add, or remove slides;
- silently rewrite mathematical claims, equations, examples, labels, or take-home statements;
- invent new visual concepts or assets not called for by the design;
- change the reveal teaching logic merely because another animation is easier to code;
- solve density by shrinking everything below the established course language;
- add speaker notes;
- introduce speculative course-level abstractions merely to make one slide easier to implement.

When the approved design needs a substantive content or design change, return explicit backpressure to Slide Design or Slide-Level Organization.

# Required inputs and authoritative references

Before implementation, inspect:

- the approved lecture-local `slide_design.md` or equivalent design artifact;
- the approved slide organization for title/order context;
- the existing target `slide_deck.typ`, if any;
- neighboring source around the target section;
- `Lectures/course.typ`;
- `Lectures/course_api_reference.md` when present;
- `Lectures/authoring_reference.typ`;
- `Lectures/README.md`;
- `Lectures/slide_authoring_implementation.md`;
- `Lectures/L01_Probability_Statistics/slide_deck.typ` when a mature concrete precedent is useful.

The live source files are authoritative. Numbered checkpoint files such as `course_07.typ` and `slide_deck_07.typ` are frozen references, not the API to import from.

Do not use a stale compiled PDF as an implementation authority.

When repository-level instructions require installed Typst/Touying authoring skills, follow them as well.

# Authority boundary

The approved Slide Design owns:

- what the student sees;
- exact mathematical and verbal meaning;
- figure/schema role;
- semantic grouping;
- visual dominance;
- simultaneous versus progressive presentation;
- reveal teaching sequence;
- what context persists;
- summary content.

Slide Authoring may decide:

- which established course component realizes a semantic group;
- top/bottom/side geometry within the approved design;
- exact column ratios, object widths, spacing, and font-scale choices;
- whether a one-off construction is best expressed with `grid`, `stack`, local helpers, or a standalone schematic;
- low-level annotation placement;
- implementation details of the specified asset;
- optical tuning that does not change meaning.

If an implementation decision changes what students attend to, compare, infer, or retain, it is a design decision and must not be made silently here.

# Core implementation model

## 1. Preserve the course's source/design separation

Lecture source should read like the intellectual argument of the lecture.

The shared course layer carries stable visual language and recurring mechanics.

Lecture-local source carries:

- equations;
- examples;
- figures;
- lecture-specific conceptual vocabulary;
- unusual one-off constructions;
- lecture-specific schematics.

Author-facing notebooks carry reproducible computational figures.

Standalone `.typ` files may carry substantial conceptual schematics whose internal implementation would otherwise obscure the slide source.

Do not bury ordinary slide meaning inside opaque helper abstractions.

## 2. Ordinary slides normally use one object + interpretation composition

For ordinary teaching slides, start from the course's normal `content-block` architecture.

The object region implements the mathematical/visual object under discussion.

The key-points region implements interpretation, framing, consequence, or verbal synthesis.

Do not make multiple peer `content-block` objects simply to reproduce a layout that should be internal to one slide argument.

Section summaries and genuinely special slides may use their established special architecture.

## 3. Cards and layout are orthogonal

Use semantic presentation objects to express what belongs together.

Use layout primitives to arrange those objects.

Do not choose a card type because of desired width. Do not make a layout primitive carry semantic meaning.

A card may contain a grid or columns. Columns may arrange several cards. A schema may combine equations and a graphical model.

## 4. Width belongs to the parent composition

Do not invent or expect a universal cross-card width parameter.

Columns, parent blocks, and the object region allocate width. Cards fill the space they receive.

When a narrow recall or figure is needed, constrain the parent composition rather than adding ad hoc width behavior to the card.

## 5. Density is not a universal card property

Use the established calibrated `fs(...)` and `sp(...)` vocabulary.

Different object types may have different density needs. Do not add a generic density API without evidence that multiple components genuinely share the same semantic choice.

Raw lengths remain appropriate for real optical tuning or slide-specific content fitting.

## 6. Figure and schema roles follow the approved design

Use a figure presentation object for empirical/statistical/historical evidence.

Use a schema presentation object for conceptual explanation.

Production mechanism does not decide the role.

The low-level image loader owns only the asset. Caption and human-readable provenance belong to the outer figure/schema presentation object.

## 7. Section summaries use the established summary architecture

Use the course summary components for retrospective section summaries.

Do not force a summary into the ordinary slide grammar solely for consistency.

Do not introduce new argument on a summary slide.

# Asset implementation

Implement only assets required by the approved design.

## Statistical, empirical, simulation, and model-generated figures

Prefer reproducible author-facing Python notebooks.

Use one notebook per coherent conceptual construction, dataset, or family of related figures rather than one giant lecture notebook or one notebook per trivial image.

Prefer SVG for vector plots/diagrams when practical.

Save assets in predictable lecture-local locations.

Do not make the student-facing notebook double as the source of lecture figures.

## Conceptual schematics

Prefer Typst-native schematics when they communicate model structure, graphical relationships, equations, transformations, or conceptual process cleanly.

Use a standalone lecture-local `.typ` schematic when the diagram is substantial enough that inline implementation would obscure the slide source.

Use Python only when it is genuinely the clearer production mechanism for the specified schema.

## Existing external assets

Preserve meaningful provenance.

Redraw or regenerate material when a low-resolution screenshot would otherwise be the only implementation.

Do not add decorative assets absent from the approved design.

## Missing assets

Development-time placeholders are acceptable where the course API supports them.

A missing asset is an error before the slide or lecture is treated as final.

Successful compilation alone is not proof that production assets exist.

# Reveal implementation

Implement the reveal choreography specified by Slide Design.

## State 1 is implicit

Content visible when the slide first opens remains unwrapped.

Do not add `uncover("1-")` merely for bookkeeping.

## Cumulative numbered reveals are normal

Use explicit numbered cumulative reveals for ordinary construction:

- `uncover("2-")`;
- `uncover("3-")`;
- and so on.

Use matching state numbers across object and key-points regions when the visual/equation and its interpretation belong to the same teaching step.

Interpretation may intentionally appear one state later when the approved design is “build/derive, then interpret.”

## Replacement is exceptional

Use `only` or `alternatives-match` only when the approved design explicitly requires replacement/focus.

Reserve stable geometry for the replacement region so the slide does not jump.

## Do not use pause for ordinary course slides

Explicit numbered states are the normal readable timing representation.

Use callback-style `#slide(repeat: ..., self => ...)` only when technically necessary because nested reveal states cannot otherwise be inferred correctly.

Do not introduce another course-level reveal abstraction merely to shorten syntax.

## Handout mode is the final state

The final presentation state and the handout version must preserve the complete intended design.

The final handout should not depend on transient earlier states for meaning.

# Source and helper discipline

## Reuse before inventing

Check `course.typ` and the API reference before adding any helper.

Use established components whenever they express the approved design.

Do not recreate an existing primitive under another name.

## Lecture-local helpers are appropriate when the concept is local

A local helper is natural for:

- a lecture-specific asset-path prefix;
- a repeated local schema vocabulary;
- one-off reveal pairing;
- forwarding a shared choice to sibling nodes;
- keeping a substantial slide-local construction readable.

A local forwarding helper should not contain hidden independent visual logic.

## Promote shared helpers only with evidence

A repeated implementation is a prompt to review abstraction, not automatic evidence for a new course-level component.

Promote a helper when:

- its behavior is stable;
- it is genuinely course-wide rather than lecture-specific;
- centralizing it removes meaningful repeated authoring decisions or materially simplifies cross-lecture correction.

If a helper is promoted, update the relevant authoring documentation in the same change.

Do not create a generic base-card, universal width API, or universal density API without evidence from multiple real uses.

# Authoring process

## 1. Establish the implementation scope

Record:

- exact section or slide allowlist;
- approved slide titles;
- design artifact revision/current source;
- assets that must be created or reused;
- whether the target source already exists.

Do not widen scope silently.

## 2. Inspect current source and API

Read the target section and immediate neighbors.

Inspect only as much additional source as needed to understand shared helpers, notation, or existing assets.

Read current `course.typ` signatures rather than relying on memory.

## 3. Map the design to the established course grammar

For each slide decide:

- ordinary content-block or established special architecture;
- semantic presentation objects;
- layout primitive;
- calibrated size/spacing choices;
- asset path/provenance;
- reveal mapping.

This is an implementation plan, not a redesign.

## 4. Implement the complete final composition first

Build the full final-state slide so that all required content exists and the static hierarchy works.

Compile and inspect the final composition before adding complex reveal behavior when practical.

If the complete slide cannot be made legible within the approved design using reasonable course-scale choices, stop shrinking and report density/design backpressure.

## 5. Implement assets

Create any required figure notebooks, standalone schematics, or lecture-local files.

Use predictable names and source relationships.

Keep computational provenance reproducible.

## 6. Add the approved reveal choreography

Translate the design states into Touying timing while preserving stable geometry.

Do not create extra clicks or omit design states merely because another implementation is simpler.

## 7. Run focused source checks

After editing a lecture `.typ` file, run the repository's Typst math-attachment checker on that edited file and fix hits introduced by the change.

Report pre-existing unrelated hits separately rather than silently modifying unrelated slides.

## 8. Compile and render both modes

Use the repository's current review workflow rather than ad hoc rendering scripts.

For targeted review, run `scripts/review_slides.py` through the command documented in `Lectures/README.md`.

Compile:

- presentation mode;
- handout mode.

Render all reveal states of every changed slide.

## 9. Perform visual review

Mechanical pass is not visual approval.

Inspect every changed state for:

- legibility;
- visual hierarchy;
- equation density;
- figure readability;
- alignment;
- spacing;
- stable reveal geometry;
- premature answers;
- missing content;
- correspondence between visible emphasis and the approved design;
- final-state equivalence with the handout.

Fix implementation/layout problems directly.

Do not rewrite mathematics or teaching claims during visual review. Return those concerns as design backpressure.

## 10. Stop when the approved design is realized

Do not keep refactoring for aesthetic novelty after the design is legible, stable, and validated.

Broaden review only when shared styles, course-level helpers, figures, or section-wide geometry have changed.

# Implementation backpressure

Backpressure is required when authoring exposes a problem outside implementation authority.

## Design-fidelity pressure

The approved design cannot be realized without changing which object is dominant, which items are simultaneous, or what students see at a reveal state.

## Density pressure

The exact approved content does not fit legibly using reasonable course-scale choices.

## Asset pressure

A specified figure/schema cannot be produced or sourced with the required content or provenance.

## API pressure

The design repeatedly requires behavior not supported by the current course API.

Do not immediately add a global helper. First decide whether the need is lecture-local or evidence of a stable course-wide pattern.

## Reveal pressure

The specified temporal logic causes unavoidable layout instability or conflicts with Touying behavior.

For each pressure item state:

1. the implementation problem;
2. the provisional implementation, if one is safe;
3. the design/API change recommended;
4. what would change if accepted.

# Final authoring output

The persistent output is the implemented lecture source and any required assets.

A completion report should be concise and state:

- slides/section implemented;
- files created or changed;
- assets generated or reused;
- whether any course-level API changed;
- source checks run;
- presentation/handout review run;
- unresolved implementation or design backpressure.

Do not generate speaker notes as part of this task.

# Quality tests

Before presenting the authored slides as complete, apply these tests.

## Design-fidelity test

Can every visible object, key point, grouping, hierarchy decision, and reveal state be traced to the approved design?

## Source-readability test

Does the Typst source still read like the slide's intellectual structure rather than a pile of formatting mechanics?

## API-discipline test

Did the implementation reuse the current course grammar instead of adding local ad hoc styling or speculative global abstractions?

## Semantic-grouping test

Do cards/presentation objects correspond to meaningful groups, with geometry handled separately?

## Width-ownership test

Are widths allocated by parent composition rather than hidden inside semantic cards?

## Reveal-stability test

Do equations, figures, and key points remain geometrically stable across states unless replacement itself is the teaching operation?

## Final-handout test

Does handout mode contain the intended final state and preserve the same teaching meaning?

## Asset-completeness test

Do all required production assets exist with appropriate provenance?

## Mechanical-validation test

Do source checks and both deck modes complete without unintended overflow, clipping, missing files, or layout failure?

## Visual-review test

Has every changed slide been inspected in every relevant reveal state and in handout form?

## No-silent-redesign test

Were all substantive deviations from the approved design surfaced explicitly instead of being hidden inside implementation?

# General principle

Slide Design owns the explanation.

Slide Authoring owns the **faithful, maintainable, validated realization** of that explanation in the course system.
