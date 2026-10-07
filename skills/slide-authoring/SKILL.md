---
name: slide-authoring
description: Lower an approved slide-design specification into the course's Typst/Touying production system, preserving pedagogy while choosing exact geometry, implementation mechanics, assets, and validation.
---

# Slide authoring

Use this skill after slide design is approved.

The primary responsibility is:

> Realize the approved student-visible explanation faithfully, maintainably, and legibly in the live production system.

Work one approved section or an explicit slide allowlist at a time unless the instructor asks for a broader pass.

## Required references

Before authoring, read:

- the approved lecture-local `slide_design.typ`;
- `Lectures/slide_authoring_conventions.md`;
- `Lectures/course.typ`;
- the target `slide_deck.typ`, if one exists;
- neighboring production source when continuity matters;
- `Lectures/design.typ` only as needed to interpret design-stage structures;
- mature Lecture 1 source when a concrete production precedent helps.

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
- reveal syntax;
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

Do not add or remove teaching clicks merely because another implementation is easier.

### 6. Tune production geometry

Only after the approved composition exists should you tune widths, line breaks, spacing, calibrated font size, and optical alignment.

Do not solve substantive density problems by shrinking important content below normal classroom readability.

### 7. Run mechanical checks

After editing a lecture `.typ` file, run:

```text
python scripts/check_typst_math_attachments.py <edited-file>
```

Fix new hits introduced by the edit.

Compile both handout mode and presentation/reveal mode.

### 8. Perform targeted visual review

Use the repository review workflow documented in `Lectures/README.md`.

Inspect every changed state and the final handout for legibility, hierarchy, equation density, figure readability, alignment, spacing, reveal stability, premature answers, missing content, and fidelity to the approved design.

Mechanical success is not visual approval.

### 9. Surface backpressure

Report rather than silently solve design-fidelity pressure, density pressure, asset pressure, reveal-mechanics pressure, or repeated API pressure suggesting a stable production abstraction.

For each item state the implementation problem, safe provisional implementation if any, recommended design/API change, and consequence.

### 10. Stop when faithful and stable

Do not continue refactoring for aesthetic novelty once the approved design is legible, stable, maintainable, and validated.

## Completion gate

Before completion, verify:

- every visible object traces to the approved design;
- layout relationships preserve design intent;
- reveal states preserve design timing and persistence;
- summary anchors match the approved summary selection;
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
