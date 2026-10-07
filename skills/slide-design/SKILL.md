---
name: slide-design
description: Turn an approved slide organization into a constrained, reviewable Typst design specification without silently changing the teaching sequence or prematurely solving production geometry.
---

# Slide design

Use this skill after lecture/section scope and slide-level organization are
approved, and before production authoring.

The primary question is:

> Given the approved teaching move, what should the student actually see, and
> how should those visible objects relate in content, space, and time?

Work one section at a time unless the instructor explicitly asks otherwise.

## Required references

Before designing, read:

- the relevant section-design / lecture-scope artifact;
- the approved `slide_organization.md`;
- `Lectures/slide_design_conventions.md`;
- `Lectures/design.typ`;
- the relevant authoritative source material;
- neighboring slides/sections when continuity matters;
- mature Lecture 1 precedent when a concrete course example helps.

Use `Lectures/README.md` only as the pipeline/index document.

## Authority

Slide Design may decide:

- exact or near-final visible mathematics and prose;
- the main object students inspect;
- semantic grouping;
- relative visual hierarchy;
- figure versus schema role;
- carried-forward context;
- simultaneity versus progression;
- reveal teaching states and persistence;
- key points / interpretation;
- summary nominations and summary selection;
- asset briefs;
- design-specific abstractions or explicit escape hatches.

Slide Design must not silently change:

- section purpose or endpoint;
- assigned source coverage;
- mathematical treatment depth;
- approved slide titles;
- approved slide order;
- approved slide count.

When design reveals pressure against those decisions, record explicit
backpressure.

Exact production geometry, calibrated font/spacing choice, low-level Typst
composition, and Touying reveal syntax belong downstream.

## Persistent artifact

The normal output is:

```text
Lectures/<lecture>/slide_design.typ
```

It imports `Lectures/design.typ`.

The design artifact is a constrained intermediate representation, not a rough
production deck.

It should contain:

- real content;
- stable object labels;
- shared semantic object names where the role is known;
- abstract layout relationships;
- abstract reveal structure;
- design metadata and backpressure.

Use `design-*` constructs when the intended design is genuinely unresolved or
not yet expressible in the constrained vocabulary.

## Section-first workflow

### 1. Establish the design contract

Extract from the upstream artifacts:

- section purpose;
- endpoint;
- treatment depth;
- ordered slide titles and teaching moves;
- required equations, examples, figures, and sources;
- continuity constraints;
- timing/extent constraints where relevant.

Distinguish explicit decisions from design inference.

### 2. Write the section design-notes page

Begin the section with `section-design-notes(...)`.

Record only the section-level information that controls detailed design:

- purpose;
- entry assumptions;
- endpoint;
- narrative arc;
- visual and notation anchors;
- summary brief;
- continuity / handoff;
- known design pressure.

Do not duplicate the entire upstream section plan.

### 3. Design the whole section in pseudo-Typst

Before forcing the section into the current API, write the design you actually
want.

For each slide specify:

- teaching move;
- labeled content objects;
- exact or near-final content;
- abstract layout;
- reveal structure;
- key points;
- summary candidates when justified;
- unresolved design constructs explicitly.

A design may temporarily use syntax that `design.typ` does not yet support if
that makes the intended structure clearer.

### 4. Evolve design.typ from real needs

Revise `Lectures/design.typ` only when the section provides evidence for a
stable design construct.

Prefer a restrictive, legible abstraction over a highly general API.

Do not distort the slide merely to fit the current template.

Do not generalize a one-off case unless repeated use demonstrates a stable
pattern.

### 5. Compile and inspect the design document

The rendered design document is itself a review artifact.

Check:

- title/body alignment;
- clarity of the dominant object;
- real equation/figure density;
- layout relationships;
- reveal state logic;
- persistence;
- summary nominations;
- unresolved escape hatches;
- section continuity.

Where practical, `design.typ` should fail visibly on structural mistakes such
as unknown labels or contradictory references.

### 6. Design the summary from the candidate pool

Review the visual and key-point nominations made by ordinary slides.

Select a small coherent combination that best retells the section's argument.

Do not treat every nomination as mandatory.

Record selection rationale when the choice is not obvious.

### 7. Review the section as one visual argument

Read the slide titles, inspect the design pages in sequence, and check:

- notation continuity;
- reuse of anchors;
- comparison simultaneity;
- reveal pacing;
- cumulative density;
- summary integrity;
- handoff to the next section.

### 8. Surface backpressure

When design exposes an upstream problem, state:

1. the problem;
2. the provisional design under current constraints;
3. the upstream change recommended;
4. the consequence if accepted.

Do not silently rewrite the organization.

## Completion gate

A section is ready for production when:

- it begins with a useful section design-notes page;
- every approved slide has a design unit;
- visible content is exact or near-final;
- layout intent is explicit;
- reveal intent is explicit;
- semantic object labels are stable;
- summary nominations have been considered;
- the summary selection is deliberate;
- unresolved `design-*` items are either resolved or explicitly delegated;
- upstream pressure is recorded rather than silently absorbed.

## General principle

Organization defines the teaching sequence.

Slide Design defines the student-visible explanation in a constrained,
reviewable intermediate language.

Slide Authoring should be able to realize that design without inventing a new
explanation.
