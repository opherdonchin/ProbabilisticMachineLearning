---
name: slide-design
description: Turn an approved slide-level organization into a complete student-visible design specification: what each slide shows, how content is grouped and prioritized, and how it unfolds over reveal states, without writing Typst or silently changing the teaching sequence.
---

# Design slides from an approved organization

Use this skill after lecture scope, section design, and slide-level organization have already established what the section is for, what it must cover, and the ordered sequence of slide-level teaching moves.

The primary responsibility of this skill is:

> **Given the approved teaching move, what should the student actually see?**

Its output is a design specification that a downstream slide-authoring agent can implement without inventing substantive content, visual meaning, or reveal logic.

Work one section at a time unless the instructor explicitly asks for a whole-lecture design pass. Preserve enough neighboring context to maintain continuity across section boundaries.

## What this skill owns

Slide Design owns the student-visible design decisions for each approved slide:

- the exact or near-final visible mathematical content;
- the exact or near-final visible prose, labels, and take-home statements;
- the main object students are meant to inspect, construct, compare, derive, or interpret;
- the distinction between object and interpretation;
- semantic grouping: what belongs together and what should remain separate;
- the dominant visual hierarchy and relative emphasis of groups;
- whether a visual object is functioning as a figure, conceptual schema, comparison, derivation, worked example, or carried-forward reminder;
- whether related material should be simultaneous or progressive;
- reveal choreography, including what is visible initially, what appears later, and what remains visible;
- whether a slide should be static, cumulatively constructed, or use deliberate replacement/focus;
- the role and content of section summaries;
- required figures, schematics, or other assets, expressed as design briefs rather than implementation code;
- continuity with surrounding slides and reuse of established visual anchors.

A slide-design specification should be precise enough that downstream authoring is translation and implementation, not a second round of pedagogy.

## What this skill is not

Do not use this skill to:

- redefine lecture scope or the section endpoint;
- silently change slide titles, order, or slide count;
- silently change mathematical treatment depth;
- write Typst or Touying source;
- choose exact dimensions, font sizes, raw spacing values, colors, or low-level geometry;
- implement Python figure notebooks or standalone Typst schematics;
- add or refactor course-level API components;
- perform compilation or mechanical validation;
- write speaker notes.

The boundary with slide organization is strict at the level of teaching sequence. If visual design reveals that a slide should be split, merged, reordered, or reframed, record explicit backpressure rather than silently changing the organization.

The boundary with slide authoring is strict at the level of implementation. Slide Design may specify semantic groups, relative geometry, and visual dominance, but not component syntax or code.

# Required inputs and references

Before designing a section, inspect:

- the approved section contract or section-design artifact;
- the approved slide-level organization;
- the source material needed to specify equations, claims, examples, and figures accurately;
- the immediately preceding and following slides or section contracts when continuity matters;
- the current course visual reference:
  - `Lectures/authoring_reference.typ`;
  - `Lectures/L01_Probability_Statistics/slide_deck.typ`;
- the current course-wide authoring standards in `Lectures/README.md`.

When working on the slide-authoring refactor branch, `Lectures/course_api_reference.md` is useful for understanding the semantic vocabulary available downstream, but design should remain implementation-independent.

Do not use an old PDF as a visual authority unless it was freshly compiled from the corresponding current source. The source `.typ` files are authoritative.

## Order of authority

When constraints conflict, use:

1. explicit current instructor decisions;
2. approved slide organization;
3. approved section design / lecture scope;
4. current course visual language and mature Lecture 1 precedent;
5. source material;
6. generic slide-design preference.

If the approved organization and source material cannot both be satisfied cleanly, surface the conflict.

# Core design model

## 1. Start from the teaching move, not from a layout template

The slide title and intention define the intellectual job. Design the student-visible slide around that job.

Do not begin by choosing a two-column layout, a card type, a figure placement, or an animation pattern.

First identify:

- what students must look at;
- what transformation, relationship, or distinction they must notice;
- what conclusion they should be able to state after the slide.

Only then choose grouping, geometry, and timing.

## 2. Distinguish object from interpretation

Most ordinary course slides should have one main **object** and a compact **interpretation**.

The object is the thing being inspected, built, manipulated, derived, compared, or visualized. It may be:

- an equation or derivation;
- a conceptual schema;
- a statistical or empirical figure;
- a model specification;
- a worked calculation;
- a comparison;
- a data object;
- a small set of tightly coordinated representations.

The interpretation states what students should understand about that object:

- meaning;
- consequence;
- distinction;
- framing;
- reusable conclusion.

Do not let the interpretation merely paraphrase the object. Do not make prose carry the conceptual load that should be visible in the object.

A useful test is:

> If the interpretation were temporarily hidden, would students still be looking at the right mathematical or visual object?

## 3. One dominant attention target

A slide may contain several groups, but it should normally have one dominant thing students are meant to attend to at each reveal state.

Avoid equal-weight collections of equations, prose, and figures that compete for attention.

Relative hierarchy belongs in the design specification. Use descriptions such as:

- dominant central equation;
- subordinate carried-forward model;
- simultaneous equal-weight comparison;
- empirical figure dominant, algebra secondary;
- result dominant, derivation supporting;
- small provenance note only.

Do not encode that hierarchy as exact percentages or point sizes.

## 4. Grouping and geometry are separate

Decide first what forms one semantic or visual unit. Then decide how those units should be arranged.

A single conceptual object may contain several internal representations. Two visually similar things may still need separate groups if the comparison between them is the teaching point.

Do not use visible boxes merely because content is grouped. Grouping is semantic; visible chrome is a separate choice downstream.

## 5. Figure versus schema is a pedagogical role

Treat something as a **figure** when it functions as empirical evidence, a statistical visualization, a historical source, a simulation output, or an observed data object.

Treat something as a **schema** when it functions as a conceptual representation: model structure, graphical relationship, symbolic-to-graphical correspondence, process, taxonomy, or explanatory diagram.

Production mechanism does not decide the role.

An imported SVG can be a schema. A Python-generated visual can be a schema. A Typst-drawn object can be a figure if its role is evidential rather than explanatory.

The design brief should state the role, not the implementation mechanism.

## 6. Use carried-forward material deliberately

Bring an earlier equation, model, or visual anchor forward when it materially helps students understand the new operation.

Carried-forward material should be visibly subordinate to the new teaching move.

Do not repeat old material merely because there is space. Do not make students reconstruct a necessary prior result from memory when keeping it visible would make the transformation legible.

## 7. Comparison usually requires simultaneous visibility

When the teaching move is to compare two cases, parameterizations, models, or interpretations, prefer simultaneous visibility unless the temporal contrast itself is the teaching device.

If students must visually compare A and B, do not force them to remember A while looking at B.

Progressive disclosure can still build the comparison, but the final relevant state should preserve both sides.

## 8. Derivations should expose conceptual steps, not every algebraic motion

A derivation slide should show the mathematical structure students need to understand the result.

Preserve earlier lines when they remain necessary context. Omit algebraic manipulations that do not carry a teaching decision unless the treatment depth explicitly requires them.

Split a derivation only when there is a genuine change in intellectual job, not simply because the equation is long.

A result that students must retain should usually receive a visually stable final form rather than disappearing when the next line appears.

## 9. Section summaries are retrospective

A section summary:

- looks backward;
- reuses a small number of visual anchors already taught;
- states conclusions already established;
- does not introduce a new argument, example, notation, or forward-looking problem.

If the summary needs to introduce an important claim for the first time, that claim belongs on an earlier teaching slide.

# Designing reveal sequences

## Design the complete final state first

Before specifying animation, design the full final slide with all required content visible.

The final state must:

- be coherent as a handout;
- preserve the relationships students need to review later;
- not depend on remembering an earlier transient state;
- maintain a clear visual hierarchy.

Then determine whether temporal staging improves the explanation.

## Static slides

Use a static slide when simultaneous inspection is the pedagogical operation or when progressive disclosure adds no useful teaching step.

Typical cases:

- compact recaps;
- reference/comparison slides;
- a single strong figure with interpretation;
- a summary slide;
- a result whose components must be inspected together.

Do not add reveals merely because the course supports them.

## Cumulative construction is the default reveal pattern

For staged explanation, prefer cumulative construction.

State 1 should contain meaningful context: the starting equation, model, question, data object, or first comparison element.

Each later state should add one substantive teaching step.

Typical sequence:

1. establish context or starting object;
2. add the next mathematical/visual construction;
3. add the result or comparison;
4. optionally add interpretation after the result has been constructed.

Most slides should need only two or three states. Four or more states require a real teaching sequence, not click-by-click text exposure.

## Interpretation may trail construction

It is often useful to let students first see a mathematical or visual result and only then reveal the synthesis or conceptual consequence.

Use this deliberately when the teaching move is:

> build or derive → then interpret.

Do not routinely delay a key point that students need in order to understand the object as it is being built.

## Replacement/focus is exceptional

Use replacement only when replacement itself is the teaching operation:

- focusing on one category at a time;
- posing a question and then replacing it with an answer;
- switching emphasis between two representations while keeping the frame stable.

The design must specify what fixed visual region is being reused so the implementation can avoid layout jumps.

## Preserve useful context across reveals

Students should not have to remember a line, figure, or label that the next reveal depends on if it can remain visible without creating clutter.

Design reveal sequences around persistence, not disappearance.

# Visual and mathematical density

The course is mathematically serious, but slides are explanatory teaching artifacts rather than compressed textbook pages.

For each slide ask:

- Is the main mathematical object readable at lecture distance?
- Are there too many independent symbolic systems or visual encodings competing at once?
- Is supporting prose shorter than the object it is supposed to interpret?
- Does every label or annotation earn its place?
- Would splitting the slide improve the teaching argument, or merely spread one coherent object across pages?

Do not solve density problems by silently shrinking everything. If the content cannot be designed legibly within the approved slide role, apply backpressure.

# Assets and provenance at design stage

When a slide needs an asset, provide a short asset brief.

For each required asset specify:

- pedagogical role: figure or schema;
- what the asset must show;
- which relationships or quantities must be visually salient;
- whether an existing course/Murphy/source asset is suitable;
- any required provenance or citation;
- whether exact numerical values or labels matter;
- whether the same asset should be reused later for continuity.

Do not prescribe Python, SVG, Typst, or notebook implementation unless the production mechanism is itself pedagogically relevant.

# Slide-design process

## 1. Establish the section design contract

Summarize only the constraints that affect visible slide design:

- ordered slide titles;
- teaching intention for each slide;
- treatment depth;
- required equations, figures, examples, or comparisons;
- section endpoint;
- known design notes from organization;
- relevant neighboring-slide dependencies.

Distinguish approved decisions from design inference.

## 2. Inspect the minimum useful precedent

Inspect the mature Lecture 1 deck and compact authoring reference for similar teaching structures, not for superficial visual mimicry.

Useful precedent categories include:

- equation + interpretation;
- side-by-side comparison;
- figure-dominant slide;
- schema combining several representations;
- carried-forward context;
- staged derivation;
- replacement/focus;
- section summary.

Reuse an established course language when it fits. Do not force a precedent onto a different teaching move.

## 3. Design the whole final slide before reveals

For every slide, specify the complete final-state composition before reveal choreography.

Decide:

- main object;
- interpretation;
- semantic groups;
- relative hierarchy;
- exact visible equations and prose;
- any carried-forward context;
- asset needs.

## 4. Add reveal choreography

Choose static, cumulative, or replacement timing.

For every reveal state state:

- what newly appears or changes;
- what remains visible;
- what teaching step the state accomplishes.

Do not number an initial state merely for bookkeeping; state 1 is simply the opening view.

## 5. Review the section as a visual argument

Check continuity across slides:

- Is the same notation rendered consistently?
- Are visual anchors reused when useful?
- Does each slide begin from what the previous one actually established?
- Does a slide unexpectedly depend on a transient reveal that is no longer visible?
- Are comparisons and summaries visually consistent with the claims they consolidate?

## 6. Apply backpressure explicitly

If design exposes a problem in the approved organization, complete a provisional design where possible and record the issue.

Do not silently fix upstream decisions.

# Backpressure categories

## Split/merge pressure

A proposed slide contains two independent visual or pedagogical operations, or two proposed slides are really one inseparable visual comparison.

## Density pressure

The required visible mathematics, prose, or figures cannot be made legible without violating the teaching hierarchy.

## Reveal pressure

The proposed teaching move needs more persistent context or more steps than the organization anticipated.

## Asset pressure

The proposed slide depends on an unavailable or unsuitable figure/schema, or the source material does not support the intended visual claim.

## Summary pressure

A summary requires a claim or visual anchor that was never actually established earlier.

## Continuity pressure

The proposed design does not connect cleanly to neighboring slides or requires notation/representations that appear only later.

For each pressure item state:

1. the problem;
2. the provisional design choice;
3. the upstream change you recommend;
4. what would change if accepted.

# Final design handoff

The persistent artifact should normally be a lecture-local `slide_design.md`, organized by section.

For each slide include:

## Title

Exactly the approved slide title unless an upstream change is explicitly requested.

## Teaching move

One concise sentence inherited from the organization, included only to keep the design interpretable.

## Final-state design

Specify:

- **Object:** the exact mathematical/visual object and its visible content;
- **Interpretation:** exact or near-final key points / take-home statements;
- **Grouping and hierarchy:** which elements belong together and their relative emphasis;
- **Carry-forward:** any earlier material retained as context;
- **Asset brief:** when an external/generated asset is required.

## Reveal choreography

Either:

- `Static`; or
- a short ordered sequence of states, describing new content and persistent context.

## Design constraints

Only when useful: non-negotiable visual relationships, simultaneity requirements, or known density risks that the authoring agent must preserve.

Do not include Typst code, exact widths, raw spacing, or component syntax.

At the end of each section include:

- **Open design issues / explicit assumptions**
- **Upstream change requests**

Ideally both are short or empty before authoring begins.

# Quality tests

Before presenting a section design as ready for authoring, apply these tests.

## Title-body alignment test

Does the visible slide actually show the claim, question, or teaching move named by the title?

## Object-first test

Is there a clear object students are meant to inspect, or has the slide become mostly prose describing an idea that should be shown?

## Dominant-attention test

At each reveal state, is it clear where students should look?

## Object-interpretation test

Does the interpretation explain meaning or consequence rather than duplicating the object?

## Simultaneity test

If the learning goal is comparison, can the relevant items be seen together when the comparison is made?

## Reveal-value test

Does every reveal correspond to a genuine teaching step rather than an arbitrary click?

## Persistence test

Does the next state retain the context students need to understand it?

## Final-handout test

Does the complete final state work as a coherent static slide?

## Density test

Can the intended mathematics and visuals be displayed legibly without tiny text or competing focal points?

## Continuity test

Does the design reuse notation and visual anchors coherently across adjacent slides?

## Summary-reuse test

Does every summary claim and visual anchor refer to something already explicitly taught?

## No-silent-organization-change test

Are all requested splits, merges, reorders, title changes, or treatment-depth changes surfaced explicitly as backpressure?

# General principle

Slide organization defines the teaching sequence.

Slide Design defines the **student-visible explanation**.

Slide Authoring should be able to implement the approved design without inventing a new explanation.
