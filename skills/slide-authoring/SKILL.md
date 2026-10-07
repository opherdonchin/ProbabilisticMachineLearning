---
name: slide-authoring
description: Lower an approved Typst slide-design document into the course's flexible Typst/Touying production system, preserving semantic objects, layout intent, reveal logic, and pedagogy while validating presentation and handout renders.
---

# Author approved slide designs

Use this skill after lecture scope, section design, slide-level organization, and slide design have been approved.

The primary responsibility is:

> **Lower the approved design representation into a faithful, maintainable, legible production slide.**

Slide Authoring owns realization. It does not own a second round of pedagogical design.

Work one approved section or an explicit allowlist of slides at a time unless the instructor asks for a broader pass.

## What Slide Authoring owns

Slide Authoring owns:

- Typst/Touying production implementation;
- exact geometry needed to realize the approved design;
- mapping abstract layout specifications to `course.typ`;
- source structure and readability;
- lecture-local helpers when justified;
- implementation of required figures and schematics;
- author-facing figure-generation notebooks;
- provenance placement;
- Touying reveal mechanics;
- stable reveal geometry;
- mechanical validation;
- presentation/handout compilation;
- targeted visual review;
- implementation backpressure;
- evidence-based proposals for shared production API changes.

## What Slide Authoring does not own

Do not use this skill to:

- change lecture scope;
- change section boundaries or endpoints;
- silently reorder, split, merge, add, or remove slides;
- rewrite approved mathematical meaning;
- rewrite approved labels, claims, or key points merely to make layout easier;
- change which objects are dominant or simultaneous;
- change reveal teaching logic;
- solve density by shrinking below reasonable course norms;
- write speaker notes;
- add speculative course-level abstractions.

# Required inputs

Before implementation, inspect:

- the approved lecture-local `slide_design.typ`;
- `Lectures/design.typ` so the design representation is interpreted correctly;
- the approved slide organization for title/order context;
- the existing target `slide_deck.typ`, if any;
- neighboring production source;
- `Lectures/course.typ`;
- `Lectures/README.md`;
- `Lectures/slide_authoring_implementation.md`;
- mature Lecture 1 source when a concrete precedent helps.

Live source files are authoritative.

# Authority boundary

Slide Design owns:

- student-visible mathematical and verbal meaning;
- semantic object identity;
- grouping;
- visual dominance;
- abstract layout relationships;
- simultaneous versus progressive presentation;
- reveal teaching sequence and persistence;
- figure/schema role;
- summary content and the selected retrospective visual anchors/key points.

Slide Authoring may decide:

- exact production geometry;
- exact column ratios, widths, spacing, and calibrated font-scale choices;
- which established production primitive realizes an approved abstract relationship;
- local grid/stack mechanics;
- low-level annotation placement;
- asset implementation details;
- Touying syntax that realizes the approved reveal specification;
- optical tuning that does not change meaning.

If an implementation choice changes what students attend to, compare, infer, or retain, it is a design change and must not be made silently.

For section summaries, preserve the design-stage selection of retrospective anchors. Production may compact or align the selected material, but it must not substitute a different set of visuals or takeaways merely because another composition is easier.

# Design-to-production lowering

The design document is not a rough deck. Treat it as a constrained intermediate representation.

A `section-design-notes(...)` page is design metadata, **not a production slide**. Read it as the section-level realization contract and do not lower it into the deck.

Likewise, ordinary-slide summary nominations are design metadata. They do not become visible content on those slides; only the summary designer's selected retrospective anchors belong on the production summary slide.

## Preserve stable semantic objects

When design source already uses production-ready semantic names such as `card`, `bordered-card`, `recall-card`, `figure-card`, `schema-card`, or `key-points`, preserve their semantic role.

The design-stage wrapper/rendering may disappear, but do not gratuitously rename or reinterpret the object.

## Use labels to connect structure

Object labels in the design artifact connect:

- the abstract layout sketch;
- the actual content object;
- the reveal specification.

Use those labels to lower the design. Labels need not survive as production API parameters if they are no longer useful, but their mapping must remain unambiguous during authoring.

## First production pass should be mechanical where possible

For each slide:

1. instantiate the real production layout corresponding to the abstract layout specification;
2. place the already-authored semantic object bodies into their specified regions;
3. implement the reveal specification around those same objects;
4. only then tune widths, spacing, line breaks, and optical details.

Do not use production freedom to silently redesign the slide.

## Treat design-* constructs as explicit unresolved work

A remaining `design-card`, `design-content`, `design-layout`, or `design-reveal` means the design representation contains an unresolved or deliberately exceptional item.

Do not silently guess. Resolve it with the design stage when it affects meaning, or implement it only when delegation is explicit and the choice is genuinely production-local.

# Core production model

## Source and design remain separate

Lecture source should read like the intellectual argument. Shared course infrastructure owns stable mechanics and visual language.

## Ordinary slides normally use object plus interpretation

Use the current `content-block` grammar when it matches the approved design.

The object region carries the mathematical or visual object; key points carry interpretation, framing, consequence, or synthesis.

Do not create multiple peer `content-block` objects merely to mimic a design-document sketch.

## Cards and layout are orthogonal

Semantic presentation objects say what belongs together. Layout primitives say where those objects go.

Do not choose a card type to obtain width, and do not make a layout primitive carry semantic meaning.

## Width belongs to parent composition

Allocate width in the parent layout. Cards fill the space they receive.

## Density is not universal

Use calibrated `fs(...)` and `sp(...)` choices. Do not invent a universal density API without evidence.

## Figure/schema role follows the design

Use figure presentation for evidential/statistical/historical material and schema presentation for conceptual explanation. Production mechanism does not determine role.

## Section summaries use their established architecture

Do not force retrospective summaries into ordinary slide grammar merely for consistency.

# Asset implementation

Implement only assets required by the approved design.

Prefer reproducible author-facing Python notebooks for empirical, statistical, or simulation figures.

Prefer Typst-native conceptual schematics when that is the clearest mechanism. Use a standalone lecture-local `.typ` schematic when substantial inline code would obscure the slide source.

Preserve provenance for external assets.

A missing asset may be tolerated as an explicit development placeholder but is an error before completion.

# Reveal implementation

Translate the abstract design reveal into Touying mechanics.

- State 1 is implicit.
- Explicit cumulative numbered reveals are the normal implementation for staged construction.
- Matching state numbers may coordinate object and interpretation regions.
- Replacement/focus uses `only` or `alternatives-match` only when the design explicitly calls for replacement.
- Preserve stable geometry.
- Do not use `pause` for ordinary course slides.
- Handout mode must represent the intended final state.

Do not create extra clicks or omit design states merely because another implementation is easier.

# Helper discipline

Reuse the live `course.typ` vocabulary before inventing helpers.

Lecture-local helpers are appropriate for genuinely local repeated constructions.

Promote a helper course-wide only when multiple real uses show stable behavior and centralization removes meaningful repeated authoring decisions.

Do not add a generic base-card, universal width API, or universal density API without evidence.

# Authoring process

## 1. Establish implementation scope

Record the exact section or slide allowlist, approved design artifact, target source, and required assets.

## 2. Inspect live APIs and neighboring source

Read current `course.typ` signatures rather than relying on memory.

## 3. Lower layout and semantic objects

Build the complete final-state composition first.

Use the design layout sketch to choose the production composition, then place the approved semantic objects in their intended relationships.

If the design cannot fit legibly using reasonable course-scale choices, stop shrinking and report design backpressure.

## 4. Implement assets

Create required notebooks, standalone schematics, or lecture-local files with reproducible provenance.

## 5. Add the approved reveal choreography

Translate design states into Touying timing while preserving geometry, persistence, and final-state completeness.

## 6. Run focused source checks

After editing a lecture `.typ` file, run:

`python scripts/check_typst_math_attachments.py <edited-file>`

Fix hits introduced by the edit. Report unrelated pre-existing hits separately.

## 7. Compile and review both modes

Use the repository's current review workflow, including `scripts/review_slides.py` as documented in `Lectures/README.md`.

Compile presentation and handout modes and inspect all changed reveal states.

## 8. Perform visual review

Inspect:

- legibility;
- visual hierarchy;
- equation density;
- figure readability;
- alignment;
- spacing;
- reveal stability;
- premature answers;
- missing content;
- correspondence between visible emphasis and approved design;
- final-state/handout equivalence.

Fix implementation problems directly. Return substantive design concerns as backpressure.

## 9. Stop when the approved design is realized

Do not continue refactoring for aesthetic novelty once the design is legible, stable, maintainable, and validated.

# Implementation backpressure

Report rather than silently solve:

- design-fidelity pressure;
- density pressure;
- asset pressure;
- reveal-mechanics pressure;
- repeated API pressure suggesting a stable production abstraction.

For each item state the implementation problem, safe provisional implementation if any, recommended design/API change, and consequence.

# Completion report

A concise completion report should state:

- slides/section implemented;
- files created or changed;
- assets generated or reused;
- whether any shared API changed;
- source checks run;
- presentation/handout review run;
- unresolved implementation or design backpressure.

# Quality tests

Before completion, check:

- **Design fidelity:** every visible object, hierarchy relation, and reveal state traces to the approved design.
- **Lowering fidelity:** labeled design objects were placed and timed according to their layout/reveal specifications.
- **Source readability:** production source still reads like the slide's intellectual structure.
- **API discipline:** current course grammar was reused rather than bypassed.
- **Semantic grouping:** cards represent meaningful groups; geometry remains separate.
- **Width ownership:** parent composition allocates width.
- **Reveal stability:** geometry remains stable unless replacement is the teaching operation.
- **Final handout:** handout contains the complete intended final state.
- **Asset completeness:** required production assets exist with provenance.
- **Mechanical validation:** source checks and both deck modes pass.
- **Visual validation:** every changed state has been inspected.
- **No silent redesign:** substantive deviations were surfaced explicitly.

# General principle

Slide Design owns the explanation and records it in a constrained intermediate representation.

Slide Authoring owns the **faithful lowering of that representation into the flexible course production system**.
