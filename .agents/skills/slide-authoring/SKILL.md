---
name: slide-authoring
description: Lower an approved slide-design specification into the course's Typst/Touying production system, preserving pedagogy while choosing exact geometry, implementation mechanics, assets, and validation.
---

# Slide authoring

Follow the [repository writing requirements](../../../AGENTS.md#writing-for-the-instructor-and-students). Address a mathematically mature reader who may be unfamiliar with later methods: retain precise names, decision-relevant equations and assumptions, explain the concern clearly, and give verified focused book readings when needed. Clarity must preserve the mathematical substance rather than move every important distinction into checking notes.

Use this skill after slide design is approved.

The primary responsibility is:

> Realize the approved student-visible explanation faithfully, maintainably, and legibly in the live production system.

Work one approved section or an explicit slide allowlist at a time unless the instructor asks for a broader pass.

## Operating modes

Use `build` (default), `feasibility-review`, or `revision`. Follow `../shared/backpressure.md` for common modes and issue ownership. When the Lecture Development Coordinator (`../lecture-development/SKILL.md`) is active, send instructor decisions and backpressure through the coordinator.

- **Build:** lower the approved design to `slide_deck.typ` using the workflow below, compile handout and presentation, run checks and inspect changed render states.
- **Feasibility Review:** inspect a **provisional Slide Design specification** against the current `design.typ`, live `course.typ` API, fonts/assets available in the repository, reveal semantics, and production constraints. Test preservation of semantic roles and the existing deck's object/key-point convention as well as constructibility. Identify likely layout overflow, illegible density, impossible/unsupported primitives, missing assets, or unimplementable reveal behavior. Return `feasible`, `feasible-with-risks`, or `blocked` with actual evidence, owner, smallest fix, and uncertainty. **Do not** generate `slide_deck.typ`, rewrite `slide_design.typ`, or claim compilation/render validation of a production deck that has not been built.
- **Revision:** accept focused feedback from compilation/visual inspection, instructor, or changed approved design. Apply the smallest production-level correction, recompile and visually recheck affected output states. If a faithful implementation is impossible without changing the intended explanation or teaching sequence, return explicit Slide Design (or earlier owner) backpressure instead of silently redesigning.

A feasibility review is optional before implementation; actual mechanical and visual validation remain mandatory at the Build completion gate. Under coordination, preview scheduling and human approval belong to the coordinator, not the authoring agent.

## Required references

Before authoring, read:

- the approved lecture-local `slide_design.typ`;
- `Lectures/slide_authoring_conventions.md`;
- `Lectures/course.typ`;
- the target `slide_deck.typ`, if one exists;
- neighboring production source when continuity matters;
- `Lectures/design.typ` only as needed to interpret design-stage structures;
- mature Lecture 1 source when a concrete production precedent helps.

For executable `.typ` mathematics, use the available Typst-authoring skill and
verified current syntax/documentation. Check the rendered mathematical grouping,
not just whether the equation compiles; shorthand delimiters can parse legally
while representing a different expression.

Use `Lectures/README.md` only as the pipeline/index document.

## Authority

Slide Authoring may decide:

- exact production geometry;
- exact widths and column ratios;
- calibrated `fs(...)` and `sp(...)` choices;
- which current `course.typ` primitives realize the approved design;
- local grid/stack mechanics;
- low-level annotation placement;
- asset implementation details;
- Typst/Touying source structure;
- reveal syntax, using `step(n)[...]` when the design requests transient entry emphasis and `uncover` for plain cumulative appearance;
- optical tuning;
- lecture-local implementation helpers;
- production API proposals supported by repeated evidence.

Slide Authoring must not silently change:

- mathematical meaning;
- approved labels or claims;
- semantic object role;
- relative visual dominance;
- which items are simultaneous;
- reveal teaching logic;
- summary anchor selection;
- slide order, split/merge decisions, or section scope.

If implementation pressure would change what students attend to, compare, infer, or retain, return it as design backpressure.

## Persistent artifact

The normal output is:

```text
Lectures/<lecture>/slide_deck.typ
```

Supporting production artifacts may include lecture-local generated figures, author-facing figure notebooks, standalone Typst schematics, and local helper modules.

Design-only metadata such as `section-design-notes(...)` and ordinary-slide summary nominations do not become visible production content.

## Lowering workflow

### 1. Establish implementation scope

Record the exact section/slide allowlist, approved design artifact, target production source, required assets, and any explicitly delegated unresolved `design-*` items.

### 2. Inspect the live production API

Check the design's precedent/role contract against the existing rendered deck.
Trace typed key points to the production `key-points:` slot (or the exported
`key-points(...)` wrapper when the entire region must reveal independently), and
mathematical objects to `object:`. Preserve the course's semantic helper and text
hierarchy rather than reproducing a visually similar generic card. A generic grid in the design is not permission to flatten
both roles into `object:`. If placement contradicts semantic roles, return
Slide Design backpressure before tuning geometry. Likewise, newly derived
mathematics marked as recall is a design issue, not a request to shrink the proof.
Preserve local proof warrants and operation labels as well as equations: a bare
equation stack can violate design fidelity even when prose has a separate slot.

Read the current `course.typ` signatures and relevant neighboring source.

### 3. Lower the final-state composition first

For each slide:

1. identify the labeled semantic objects;
2. instantiate the corresponding production layout;
3. place those object bodies in their approved relationships;
4. establish readable final-state geometry.

Do this before adding complex reveal mechanics.

### 4. Implement assets

Create or reuse required figures and schematics according to `slide_authoring_conventions.md`. Preserve provenance and reproducibility.

### 5. Implement reveal mechanics

Translate approved semantic reveal states into Touying syntax while preserving intended timing, persistence, stable geometry, and final handout completeness.

When a reveal step is marked for transient entry emphasis, lower it with the
shared `step(n)[...]` helper. Use ordinary `uncover` when no entry emphasis
is specified. Do not decide this distinction during authoring.

Do not add or remove teaching clicks merely because another implementation is easier.

### 6. Tune production geometry

Only after the approved composition exists should you tune widths, line breaks, spacing, calibrated font size, and optical alignment.

Do not solve substantive density problems by shrinking important content below normal classroom readability.

### 7. Run mechanical checks

After editing a lecture `.typ` file, run:

```text
python scripts/check_typst_math_attachments.py <edited-file>
```

Fix new hits introduced by the edit. The design input must also have passed
its attachment check; report failures upstream rather than silently copying or
repairing mathematically different parsed content. Inspect delimiters and exponent/
subscript grouping in the rendered equations. Use verified math constructors for
compound notation; when meaning remains uncertain, a minimal parsed-content query
can distinguish a legal parse from the intended expression.

Compile both handout mode and presentation/reveal mode. For a linked insertion,
inspect the actual predecessor and the affected slides together, not only
isolated slide briefs. Verify that carried equations and notation were really
established, and that each reveal makes the intended operation and its reason
visible. Stable positions and cumulative persistence alone do not establish flow.

### 8. Perform targeted visual review

Use the repository review workflow documented in `Lectures/README.md`.

Inspect every changed state and the final handout for legibility, hierarchy, equation density, figure readability, alignment, spacing, reveal stability, premature answers, missing content, and fidelity to the approved design.

Compare the final state with the selected established proof/neighbor renders,
not only with its own design sketch. Verify that the mathematical object remains
light on explanatory prose, its equation/figure stays coherent, and necessary
interpretation occupies the separate key-point region. Short intrinsic labels
and mathematically necessary conditions can stay with their object; a paragraph
of explanation cannot be made into an object merely by grouping it in a card.
If a faithful render violates this course convention, report design backpressure.

Report mechanical validity, design fidelity and comparative alignment separately,
with actual evidence for each. Inspecting every state establishes coverage of
review; it does not itself establish any of those judgments. Mechanical success
is not visual approval.

### 9. Surface backpressure

Report rather than silently solve design-fidelity pressure, density pressure, asset pressure, reveal-mechanics pressure, or repeated API pressure suggesting a stable production abstraction.

For each item state the implementation problem, safe provisional implementation if any, recommended design/API change, and consequence.

Do not write speaker notes during lecture development.

### 10. Stop when faithful and stable

Do not continue refactoring for aesthetic novelty once the approved design is legible, stable, maintainable, and validated.

## Completion gate

Before completion, verify:

- every visible object traces to the approved design;
- layout relationships preserve design intent;
- reveal states preserve design timing and persistence;
- summary anchors match the approved summary selection and the section ends on its retrospective summary, with no following teaser or transition;
- source remains readable as an intellectual argument;
- current course API is reused rather than bypassed;
- parent composition owns width;
- required assets exist with provenance;
- math attachment check passes;
- handout and presentation modes compile;
- all changed states have been visually inspected;
- substantive deviations are reported explicitly.

## Completion report

Report concisely:

- slides/section implemented;
- files created or changed;
- assets generated or reused;
- shared API changes, if any;
- checks run;
- unresolved implementation/design pressure.

## General principle

Slide Design owns the explanation.

Slide Authoring owns the faithful production realization of that explanation.
