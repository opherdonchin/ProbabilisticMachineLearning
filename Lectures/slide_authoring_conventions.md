# Slide authoring conventions

This document is the course-wide production reference for lowering an approved
slide design into a Typst/Touying lecture deck.

It governs **authoring decisions**: how approved semantic objects, layout
relationships, reveal states, assets, and summaries are realized in maintainable
course source.

Use it with:

- `.agents/skills/slide-authoring/SKILL.md` — stage workflow, authority, validation,
  and backpressure;
- `Lectures/course.typ` — executable production API;
- the approved lecture-local `slide_design.typ` — design source of truth;
- the lecture-local `slide_deck.typ` — production artifact.

Slide design itself is governed separately by
`Lectures/slide_design_conventions.md` and `Lectures/design.typ`.

## 1. Production authority and boundary

Slide Authoring realizes an approved design. It does not perform a second round
of pedagogical design.

The design owns:

- student-visible mathematics and prose;
- semantic object identity;
- grouping;
- relative visual dominance;
- simultaneous versus progressive presentation;
- reveal teaching sequence and persistence;
- figure/schema role;
- summary anchor selection.

Authoring owns:

- exact production geometry;
- widths and column ratios;
- calibrated font and spacing choices;
- concrete `course.typ` primitives;
- local grid/stack mechanics;
- low-level annotation placement;
- asset implementation;
- Touying timing syntax;
- optical tuning;
- mechanical and visual validation.

If a production choice changes what students attend to, compare, infer, or
retain, it is a design change and should be returned as backpressure.

## 2. Design-to-production lowering

Treat `slide_design.typ` as a constrained intermediate representation, not a
rough deck.

A good first production pass is deliberately mechanical:

1. identify the labeled semantic objects;
2. instantiate the real production layout that realizes the abstract layout
   relationship;
3. place the corresponding object bodies;
4. implement the approved reveal states around those same objects;
5. only then tune widths, line breaks, spacing, and optical balance.

`section-design-notes(...)` pages and ordinary-slide summary nominations are
design metadata. They do not become production slides or visible content.

A remaining `design-card`, `design-content`, `design-layout`, or
`design-reveal` is explicit unresolved or delegated work. Do not silently
reinterpret it as a production-local choice when it affects meaning.

## 3. Source architecture

### Shared course layer

`Lectures/course.typ` is the live course production API.

It sits above the vendored Ruled Page theme and owns stable course-specific
mechanics and visual language.

The vendored theme under `Lectures/themes/ruled-page/` is treated as
read-only. Course-specific behavior belongs in `course.typ`, not in the
vendored theme.

### Lecture source

Lecture `.typ` files should read like the intellectual argument.

They should primarily contain:

- headings;
- equations;
- figures;
- schemas;
- examples;
- semantic presentation objects;
- reveal structure.

Avoid burying the teaching argument under repeated styling code.

### Local helpers

Lecture-local helpers are appropriate when they:

- express genuinely lecture-specific vocabulary;
- keep sibling objects consistent;
- encapsulate repeated local forwarding choices;
- isolate a substantial schematic from slide source.

Do not promote a helper course-wide merely because it appears twice.

## 4. Core slide composition

### Ordinary slides

Ordinary teaching slides normally use one `content-block(...)`.

Its roles are:

- `object:` — the mathematical or visual object being inspected;
- `key-points:` — interpretation, framing, consequence, or synthesis.

The default layout is top object with interpretation below.

Use `layout: "bottom"`, `"side-left"`, or `"side-right"` only when the
approved design calls for that relationship.

Do not create several peer `content-block` objects merely to imitate a design
document sketch.

### Cards and layout are orthogonal

Cards express semantic grouping.

Layout primitives express spatial relationship.

Do not choose a card type merely to obtain width or padding. Width belongs to
the parent composition.

## 5. Shared production vocabulary

### Layout

Prefer the shared helpers when they naturally express the design:

- `content-block`;
- `twocol`;
- `triad`;
- `cols(...)`;
- `sp(...)`.

Use raw `grid` when the intended geometry is not naturally represented by the
shared helpers, for example:

- multi-row layouts;
- tables or matrices;
- spanning cells;
- fixed replacement regions;
- more intricate schematic structure.

### Cards

- `card` — default semantic presentation object; intentionally visually
  unmarked;
- `bordered-card` — visible bounded card;
- `recall-card` — carried-forward material with required provenance;
- `figure-card` — complete figure presentation object;
- `schema-card` — complete conceptual-diagram presentation object.

The semantic role should match the approved design.

### Summary architecture

Use:

- `section-summary-visual`;
- `section-summary-takeaways`.

Summary takeaways default to `fs("l")` for normal classroom readability.
Smaller text is an explicit exception.

Preserve the design-stage selection of retrospective visual anchors and key
points. Production may compact or align them but should not silently substitute
a different retrospective story.

### Section metadata

For sections after the first, use:

```typst
#section-metadata(
  short-title: [Short footer title],
  subtitle: [Section subtitle],
)

= Full section title
```

Place `section-metadata` immediately before the level-1 heading.

For the first section immediately after an explicit `#title-slide()`, omit
`section-metadata`; `course.typ` falls back to the section heading for the
footer short title.

## 6. Typography, spacing, and density

Use the calibrated `fs(...)` and `sp(...)` scales rather than arbitrary
font sizes and repeated raw spacing values.

The scales are a coordinated family. Use smaller values only when the content
role justifies them.

Do not solve design pressure by shrinking important content below normal
classroom readability.

`sp("xxs")` is for optical/micro spacing, not normal item separation.

A component expected to scale with ambient text should express its internal
geometry in `em` where practical. Fixed-point hairline strokes are fine.

## 7. Figures, schemas, and provenance

### Figures

Use `figure-card` for evidential/statistical/historical visuals regardless of
whether they are imported or course-generated.

### Schemas

Use `schema-card` for conceptual diagrams regardless of whether they are drawn
inline, loaded from an asset, or delegated to a standalone Typst helper.

### Low-level primitives

The following are implementation vocabulary inside larger semantic objects:

- `schema-node`;
- `schema-arrow`;
- `course-diagram`;
- `graph-node`;
- `graph-edge`;
- `course-image`;
- `source-note`.

Do not substitute a low-level drawing primitive for the semantic card role.

### Asset generation

Prefer Python notebooks for:

- empirical figures;
- statistical plots;
- simulations;
- posterior/model-generated graphics;
- data analysis.

Prefer Typst-native schematics for:

- conceptual structure;
- equations-as-diagrams;
- graphical models;
- process relationships.

Use a standalone lecture-local `.typ` helper when a substantial schematic
would obscure the slide source.

Generated assets should live in a predictable lecture-local location such as
`generated/`.

Preserve meaningful external, adapted, or computational provenance.

Missing assets may be tolerated while drafting but are errors before finalization.

## 8. Reveal implementation

Translate the approved design reveal into Touying mechanics.

### Normal cumulative reveal

- State 1 is implicit and remains unwrapped.
- Use explicit `uncover("2-")`, `uncover("3-")`, and so on for plain
  cumulative appearance.
- The same state number may coordinate object and interpretation regions.
- Interpretation may trail construction when explicitly designed that way.

### Transient entry emphasis

When the approved design marks a reveal step for entry emphasis, use the shared
course helper:

```typst
#step(2)[
  ...
]
```

`step(n)[...]` means:

- hidden before state `n`, with space reserved like `uncover`;
- visible and transiently emphasized on presentation state `n`;
- visible normally on all later states;
- visible normally in handout mode, including when `n` is the final reveal.

Use `uncover` when the design requests appearance without transient emphasis.
Do not substitute `step` merely because a region is new.

The course implementation uses a zero-inset visual outset so the emphasis does
not intentionally change layout geometry. Still inspect the affected reveal
states: large cards, nested blocks, or unusual containers may expose optical or
clipping issues.

### Replacement

Use `only` or `alternatives-match` only for genuine replacement/focus.

Preserve stable geometry around replacement regions.

### Avoid unnecessary mechanics

Do not use `pause` for ordinary course slides.

Use callback-style `#slide(repeat: ..., self => ...)` only when the reveal
cannot be expressed correctly with ordinary Touying state handling.

### Handout invariant

The final state must contain the complete intended slide.

Always inspect presentation reveals and handout mode.

## 9. Helper promotion

Reuse existing `course.typ` components before inventing new ones.

Promote a helper course-wide when:

- several real slides demonstrate the same stable behavior;
- centralization removes meaningful repeated authoring decisions;
- the abstraction makes later correction easier.

Repetition is evidence, not an automatic rule.

Do not introduce:

- a generic universal base-card API;
- universal width presets for every content type;
- a universal density abstraction;
- speculative slide types with no recurring evidence.

When a helper is promoted, update the production conventions in the same change.

## 10. Source readability

Production source should preserve the intellectual structure of the slide.

Prefer:

- a visible main object;
- a small number of semantic wrappers;
- local helpers with clear conceptual names;
- direct equations and labels.

Avoid:

- deeply nested styling indirection;
- one-off visual constants repeated through the slide;
- duplicated wrappers whose only difference is accidental formatting;
- abstractions that obscure what the student actually sees.

## 11. Validation

Mechanical checks and visual review are separate quality gates.

### Mechanical checks

After editing a lecture Typst source, run:

```text
python scripts/check_typst_math_attachments.py <edited-file>
```

Fix new hits introduced by the edit.

Compile both:

- handout mode;
- presentation/reveal mode.

Check that:

- imports resolve;
- required assets exist;
- no content overflows or clips;
- expected pages/states are produced.

### Targeted visual review

Use the repository review workflow documented in `Lectures/README.md`,
including `scripts/review_slides.py`.

Inspect every changed reveal state and the handout final state for:

- legibility;
- visual hierarchy;
- equation density;
- figure readability;
- alignment;
- spacing;
- reveal stability;
- premature answers;
- missing content;
- design fidelity.

Compilation success is not visual approval.

## 12. Layout review prompt

`Lectures/slide_layout_review.md` is a specialized bounded prompt for delegated
layout-only or read-only review.

It is not a general authoring standard and should not override this document or
the approved design.

## 13. Speaker notes and section closure

Do not write speaker notes during lecture development.

Each section's last visible teaching slide must be its retrospective summary; do not append an exit teaser, bridge, or question pointing to the next section. If connective context is indispensable, place it at the beginning of the receiving section.

## 14. Evidence and abstraction policy

Lecture 1 is the strongest mature production precedent for the current course
visual language.

Use it as evidence for:

- normal content density;
- card use;
- summary composition;
- reveal pacing;
- figure sizing;
- key-point readability.

Do not copy its geometry mechanically when the approved design calls for a
different relationship.

The live `course.typ` API is authoritative for current signatures.
