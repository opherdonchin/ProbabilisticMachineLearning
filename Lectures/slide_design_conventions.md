# Slide design conventions

This document is the course-wide design reference for turning an approved slide
organization and its source material into a student-visible slide design.

It governs **design decisions**: what students see, what they attend to, what is
grouped, what is interpreted, what appears together, and how the explanation
unfolds. It does not govern exact Typst geometry or Touying syntax.

Use it with:

- `skills/slide-design/SKILL.md` — stage workflow, authority, and backpressure;
- `Lectures/design.typ` — executable constrained design representation;
- the lecture-local `slide_design.typ` — the actual approved design.

Production authoring is governed separately by
`Lectures/slide_authoring_conventions.md` and `Lectures/course.typ`.

## 1. Inputs to slide design

Slide Design receives decisions from several sources. They have different
authority and should not be collapsed into one undifferentiated brief.

### From section design / lecture scope

The section-level artifact owns:

- the section purpose;
- the required conceptual endpoint;
- assigned source coverage;
- treatment depth such as State, Motivate, Derive, Work, or Apply;
- prerequisites and carry-forward assumptions;
- exclusions and neighboring-section boundaries;
- timing or extent constraints when specified.

Slide Design may surface pressure against these decisions but must not silently
change them.

### From slide organization

The approved slide organization owns:

- slide titles;
- slide order;
- slide count;
- the teaching move or intention of each slide;
- special roles such as summary, comparison, derivation, example, or recap when
  already decided;
- brief design constraints that are necessary to preserve the teaching move,
  such as “compare simultaneously” or “carry forward the previous equation.”

The organization handoff should say **what intellectual job the slide performs**,
not solve the detailed visual composition.

### From source material and course context

Design must also inspect the resources needed to make the slide correct and
coherent:

- the authoritative textbook/source sections;
- prior slides whose notation, equations, figures, or concepts are reused;
- neighboring slides needed for continuity;
- existing lecture-local figures and schematics;
- mature course precedent, especially Lecture 1.

Source material determines mathematical and factual content. Existing slides
determine already-established notation and visual anchors. Neither source-book
layout nor prior slide geometry should be copied mechanically.

## 2. Design output

A complete slide design specifies the **student-visible explanation**, not merely
a topic and not production code.

For each slide, design should determine:

- exact or near-final visible mathematics;
- exact or near-final labels and prose;
- the main object students inspect, manipulate, compare, derive, or interpret;
- semantic grouping;
- visual dominance and relative hierarchy;
- which earlier material is carried forward;
- which content appears simultaneously;
- reveal teaching states and persistence;
- figure versus schema role;
- key points / interpretation;
- summary nominations when the slide establishes a strong retrospective anchor;
- explicit unresolved design work or upstream backpressure.

The design artifact should contain real content but deliberately abstract
geometry.

## 3. Content design conventions

### One slide, one teaching move

The title and body should perform the same intellectual job.

A slide may contain several pieces, but they should support one dominant move.
If two independent conclusions require separate attention, the organization may
need a split.

A useful test is:

> After this slide, what is the one new thing students should be able to see,
> state, or do?

### Start from the object students inspect

Prefer showing the mathematical or visual object directly over describing it in
prose.

Typical objects include:

- an equation or derivation;
- a probability model;
- a figure;
- a schema;
- a comparison;
- a worked numerical example;
- a table or matrix;
- a carried-forward result being transformed.

Interpretation should explain what the object means, what changes, what matters,
or what conclusion follows.

### Titles are claims or teaching moves

Titles should recover the section argument when read in order. Prefer specific
claims or questions over generic labels such as “Example,” “Background,” or
“Derivation.”

The body must visibly support the title. Do not let a strong claim title sit over
a slide whose main content is merely preparatory.

### Key points state conclusions, not the teaching plan

Lecture 1 establishes the preferred style for key points.

Good key points are:

- short declarative claims;
- directly supported by the visible object;
- phrased as what students should retain;
- concrete enough to be reused later;
- often one or two bullets rather than a paragraph.

Prefer:

- “Bayes' rule combines prior and likelihood into a posterior.”
- “Conditioning cannot increase variance in any direction.”
- “The natural parameter is the log odds.”

Avoid key points that primarily narrate the instructor's plan:

- “We will now…”
- “This representation is useful because we are going to…”
- “Next we will see…”

Roadmap language belongs in transitions or section notes, not in the take-home
region of an ordinary slide.

When a later summary needs the same conclusion, reuse or minimally compress an
already-established key point rather than inventing a new formulation.

### Mathematical content should be exact before authoring

Design should use real equations, notation, limits, and labels whenever they are
known. Do not defer substantive mathematical choices to production simply
because the design document is not the final deck.

For derivations:

- expose conceptual steps, not every algebraic motion;
- retain prior lines when comparison or causality depends on them;
- reveal the mapping or interpretation only after the algebra that motivates it;
- avoid animation that turns a derivation into click-by-click transcription.

### Carry-forward material is subordinate but deliberate

Carry an earlier equation, model, or figure when students need it to understand
the new operation without mentally reconstructing context.

Carried-forward material should be visibly subordinate to the new object. Its
role is orientation, not repetition.

### Comparison normally requires simultaneous visibility

If the teaching move is “compare A and B,” the relevant state should normally
show A and B together.

Serial reveals are appropriate when the comparison itself is built
progressively, but the final comparison state should preserve both sides.

### Examples should make the intended structure visible

A worked example should not merely instantiate symbols. Choose values or cases
that make the target relationship easy to see.

Use examples to reveal:

- scale;
- direction of an effect;
- limiting behavior;
- correspondence between general and special forms;
- how an operation changes an estimate or uncertainty.

## 4. Figure and schema conventions

“Figure” and “schema” are pedagogical roles, not file formats.

Use a **figure** when the visual is evidence or an observed/generated object:

- data visualization;
- simulation output;
- statistical plot;
- historical figure;
- model-generated result.

Use a **schema** when the visual explains conceptual structure:

- process;
- dependency;
- correspondence;
- taxonomy;
- model structure;
- input/output relationship.

The same visual may be generated in Python, Typst, or another tool; production
mechanism does not determine its semantic role.

When a visual does not yet exist, design should specify an asset brief:

- pedagogical role;
- what must be visible;
- salient relationships;
- required labels/values;
- provenance/source;
- whether an existing figure can be adapted;
- whether the visual is expected to recur or become a summary anchor.

## 5. Form and hierarchy conventions

### One dominant attention target

At every reveal state, students should normally have one clear focal target.

Other material may support it, but avoid several peer elements competing for
attention unless the teaching move is explicitly comparative.

### Grouping and geometry are different decisions

First decide what belongs together semantically. Then decide the spatial
relationship.

A card means “this is one semantic/presentation object.” It does not mean “draw
a border here,” and it does not determine width.

Use visible borders only when they clarify grouping or comparison. The course
style is restrained; chrome should not compete with mathematics or figures.

### Use abstract layout relationships at design stage

Design should specify relationships such as:

- top object + interpretation below;
- side-by-side comparison;
- primary object with subordinate recall;
- stacked derivation and mapping;
- abstract grid with spanning regions;
- summary visual plus takeaways.

Do not specify exact widths, centimeters, font sizes, gutters, or production
Typst grid code unless the instructor explicitly asks to blur the
design/authoring boundary.

### Density is a design problem before it is a font-size problem

Do not solve an overloaded slide by assuming production can shrink it.

Generate backpressure when:

- important equations cannot remain readable;
- a figure's labels would need to become tiny;
- key points compete with the main object;
- two teaching moves are packed into one slide;
- a comparison cannot be seen simultaneously.

### Course visual style

The preferred visual style is academic and restrained:

- mathematics, figures, and schemas carry the explanatory burden;
- prose is compact;
- whitespace and hierarchy matter more than decorative variety;
- repeated structures are reused when they support continuity;
- visual novelty is not a goal;
- accent color and borders are used sparingly;
- key conclusions should remain readable from normal classroom distance.

Lecture 1 is the strongest mature precedent for this style, but it is evidence,
not immutable law.

## 6. Reveal design

Design the final complete state first.

Use a static slide when simultaneity is the teaching operation.

For staged explanations, cumulative construction is the default:

- state 1 contains meaningful opening context;
- each later state advances one teaching step;
- necessary earlier context remains visible;
- interpretation may trail construction when the move is “build/derive, then
  interpret.”

Use replacement/focus only when replacement itself serves the teaching move.

Transient **entry emphasis** is a separate design decision from reveal timing.
Use it when students are likely to need help locating the newly added material
among content that remains visible, especially in cumulative derivations,
sequential constructions, or slides where old and new objects have similar
visual weight.

Do not make entry emphasis automatic for every reveal. Omit it when the new
material is already visually dominant, when several highlighted regions would
compete, or when simultaneous comparison is the teaching operation.

In structured design reveals, request it with
`reveal-step(..., emphasize: true)`. The design document renders this as
`entry emphasis`. For intra-object reveals that still require a
`design-reveal`, state explicitly which newly added subparts receive transient
entry emphasis.

Entry emphasis is temporary: it applies only on the state where the material
first appears. Later states and the handout show the same material normally.

Design-level reveal descriptions should express semantic states, persistence,
and attention intent—not Touying syntax. Exact `uncover`, `step`, `only`,
`alternatives-match`, callback, and repeat mechanics belong to authoring.

The final state must remain coherent as a handout.

## 7. Section design notes

Every designed section begins with a `section-design-notes(...)` page.

It should capture section-level decisions that individual slide pages cannot
express well:

- purpose;
- entry assumptions;
- endpoint;
- narrative arc;
- visual and notation anchors;
- summary design brief;
- entry context and continuity (connections begin the receiving section; no closing handoff);
- known design constraints or open pressure.

This page is design metadata. It is not a production slide.

It should not duplicate the complete upstream section plan. Its value is to
record the subset of section-level decisions that control visual and explanatory
continuity.

## 8. Summary design is shared work

Summary quality depends on decisions made before the summary slide itself.

### Ordinary slide designer

When a slide establishes a strong reusable anchor, the slide designer may
nominate:

- a visual object for retrospective reuse;
- a key point worth retaining at section end.

Nomination should be selective. Do not nominate every object merely because it
exists.

### Summary-slide designer

The summary designer reviews the candidate pool and selects the smallest
combination that best retells the section's argument.

Selection should optimize:

- narrative coverage;
- visual continuity;
- hierarchy;
- recognition of already-taught anchors;
- classroom readability.

A nomination is not an obligation.

The summary may recombine or compact already-established material, but it should
not introduce a new conceptual argument. **It is the final teaching move of the section.** Do not put a next-section teaser, handoff, forward-looking question, or bridge in or after the summary. Any necessary connection belongs to the opening of the receiving section; a notebook task has its own lecture-level introduction.

Summary takeaways should use an easy-to-read size by default. Production
currently implements this as `fs("l")`; smaller text is an explicit exception.

## 9. What design must know about eventual authoring

Design should be implementation-aware without becoming production code.

### Preserve stable semantic vocabulary

When the semantic role is already known, use the same names that production
uses:

- `card`;
- `bordered-card`;
- `recall-card`;
- `figure-card`;
- `schema-card`;
- `key-points`;
- section-summary semantic objects.

The active template may render them differently at design and production
stages.

### Use explicit escape hatches for unresolved design

Use `design-card`, `design-content`, `design-layout`, or
`design-reveal` when the current design language cannot yet express the idea
cleanly.

Their presence is useful evidence. Do not disguise uncertainty as
production-ready structure.

### Leave production choices downstream

Normally leave these to Slide Authoring:

- exact widths and ratios;
- exact spacing;
- calibrated font-scale choice;
- low-level Typst composition;
- Touying reveal syntax;
- optical alignment;
- whether a semantic object needs visible chrome in the final composition.

### But design must remain realizable

A design should not depend on impossible geometry or unreadably dense content.

When real equations, figures, or labels reveal a production problem, revise the
design or surface backpressure rather than assuming authoring will rescue it.

## 10. Evidence and abstraction policy

Use mature course artifacts as evidence.

- Lecture 1 is the principal precedent for key-point style, summaries, visual
  hierarchy, and reveal pacing.
- Repetition across real slides is evidence for a new design abstraction.
- A single unusual slide is usually not enough reason to generalize the API.
- The constrained design language should become more expressive only when real
  sections demonstrate a recurring need.

The goal is not a complete taxonomy of every possible slide. The goal is a small
design vocabulary that makes routine good decisions explicit while leaving
unusual cases visible.
