---
name: slide-design
description: Turn an approved slide-level organization into a constrained Typst design document with real student-visible content, labeled semantic objects, abstract layout and reveal specifications, and explicit design backpressure.
---

# Design slides from an approved organization

Use this skill after lecture scope, section design, and slide-level organization have established the section purpose, treatment depth, and ordered slide-level teaching moves.

The primary question is:

> **Given the approved teaching move, what should the student actually see, and how should those visible objects relate in space and time?**

Work one section at a time unless explicitly asked otherwise.

The persistent output is normally a lecture-local `slide_design.typ`. It is an intermediate representation, not a rough production slide deck.

## Core architecture

The design language and production language deliberately have different jobs.

- **Design is strongly opinionated.** It constrains choices, exposes object identity, forces explicit layout and reveal decisions, and makes unresolved design work visible.
- **Production remains flexible.** `course.typ` must be able to realize unusual geometry cleanly once the design is known.

The design document therefore uses **real content but abstract geometry**:

- real equations;
- real or near-final prose;
- real figures when available;
- real semantic grouping;
- stable object labels;
- abstract layout sketches;
- abstract reveal sketches.

It does **not** normally execute the final slide layout or Touying reveal mechanics.

## What Slide Design owns

Slide Design owns:

- exact or near-final visible mathematics;
- exact or near-final visible prose, labels, and key points;
- the main object students inspect, construct, compare, derive, or interpret;
- semantic grouping and object-versus-interpretation structure;
- visual hierarchy and relative emphasis;
- figure versus schema role;
- carried-forward context;
- simultaneity versus progression;
- reveal teaching logic and persistence;
- section-summary content and retrospective anchors;
- asset briefs for visuals not yet available;
- explicit design backpressure.

A downstream author should be able to realize the design without inventing a new explanation.

## What Slide Design does not own

Do not use this skill to:

- redefine lecture scope or section endpoints;
- silently change approved slide titles, order, or count;
- silently change treatment depth;
- author the production slide deck;
- choose exact production widths, font sizes, gutters, raw spacing, colors, or low-level geometry;
- write Touying reveal syntax;
- refactor `course.typ` while solving a local design problem;
- write speaker notes.

Typst is allowed and normally preferred for the design artifact itself. The boundary is not “no code”; it is “no production implementation.”

When design reveals that a slide should be split, merged, reordered, or reframed, record explicit upstream pressure rather than silently changing the organization.

# Required inputs

Before designing a section, inspect:

- the approved section-design / lecture-contract artifact;
- the approved `slide_organization.md`;
- source material required for mathematical and factual accuracy;
- neighboring organization where continuity matters;
- `Lectures/L01_Probability_Statistics/slide_deck.typ` as mature precedent;
- `Lectures/course.typ`;
- `Lectures/README.md`;
- `Lectures/slide_authoring_implementation.md`;
- `Lectures/design.typ` when it already exists.

Use live course files as authoritative references.

# Stable semantic vocabulary across stages

When a semantic object is already understood, use the ordinary course name rather than inventing a stage-prefixed substitute.

Examples include:

- `card`;
- `bordered-card`;
- `recall-card`;
- `figure-card`;
- `schema-card`;
- `key-points`;
- section-summary semantic objects where appropriate.

The active template may render the same semantic name differently at different stages. For example, `figure-card` in the design document may render as a labeled document object with the actual figure and diagnostic metadata; in production it becomes the course slide presentation object.

Do not invent names such as `design-figure-card` merely because the rendering stage differs.

# Labels are the connective tissue

Every object that participates in layout or reveal structure should have a short stable label.

The same label is used in:

1. the layout specification;
2. the labeled content-object rendering;
3. the reveal specification.

This identity is the invariant that lets production lower the design mechanically.

Where practical, `design.typ` should detect duplicate labels, unknown layout references, unknown reveal references, important objects never placed, and contradictory structured reveal specifications.

# Layout specification

Layout at design stage is declarative and relational.

A design layout may use a small predefined vocabulary corresponding to recurring course relationships such as top, bottom, side-left, side-right, comparison, or stack, and may use an abstract grid specification when those forms are insufficient.

The layout answers questions such as:

- which object labels occupy which regions;
- which objects are peers;
- which object is dominant;
- which regions span rows or columns;
- where interpretation/key points sit relative to the main object.

It should not normally specify centimeters, exact percentages or ratios, production gutters, or exact Typst `grid` / `content-block` code.

The rendered design document should show a **layout sketch containing labels**, rather than execute the actual slide layout.

# Reveal specification

Reveal at design stage describes teaching states, not Touying syntax.

Prefer a small structured vocabulary such as:

- static;
- cumulative construction;
- deliberate replacement/focus.

Reveal states refer to the same stable object labels used by layout.

The design must make clear:

- what is visible initially;
- what is added or replaced at each state;
- what remains visible;
- when interpretation appears.

The design document should render a reveal timeline or state sketch. Do not normally expose `uncover`, `only`, `alternatives-match`, or callback mechanics.

# Design-specific escape hatches

Use `design-*` names deliberately when something does not yet fit stable semantic or structural vocabulary.

Examples:

- `design-card`: a coherent object is intended, but its contents are still a textual brief rather than code-ready content;
- `design-content`: intended visible material does not yet fit a stable semantic object;
- `design-layout`: the intended spatial relationship does not fit the current structured layout vocabulary;
- `design-reveal`: the intended temporal logic does not fit the current structured reveal vocabulary.

These constructs are explicit evidence of unfinished or exceptional design work.

Do not generalize every escape-hatch use immediately. Repetition across real slides is evidence for extending `design.typ`.

# Section design-notes page

Every designed section should begin with one rendered `section-design-notes(...)` page before the first slide-design unit.

Its job is to make section-level design commitments visible without duplicating the upstream section-design artifact. It should normally state:

- **Purpose:** the conceptual job this section performs in the lecture.
- **Entry / assumed context:** what students already know or what the preceding section has established.
- **Endpoint:** what students should be able to recognize, explain, or use by the end.
- **Narrative arc:** the ordered argument across the section, expressed at the level of teaching moves rather than slide layouts.
- **Visual and notation anchors:** representations, notation, figures, schemas, equations, or motifs that should recur or remain stable.
- **Summary design brief:** what story the summary should retell and what compression or selection principles should govern it.
- **Continuity / handoff:** what the following section should inherit.
- **Constraints / open pressure:** known density, asset, timing, or representation issues that may affect design.

The notes page is a design contract for the section, not a prose lecture outline and not a replacement for `section_design.md`.

# Summary responsibility is shared

Summary design begins before the summary slide.

For every ordinary slide, the slide designer may nominate:

- a visual object that would be a useful retrospective anchor;
- a key point that would remain important at section end.

Use the design-stage summary-candidate constructs for these nominations. A nomination is not a requirement that the summary include the object.

The summary-slide designer then reviews the candidate pool across the section and selects a **small coherent combination** that best retells the section's argument. Selection should optimize narrative coverage, visual continuity, and hierarchy rather than frequency or exhaustive inclusion.

The summary designer may recombine or compact already-established anchors, but must not introduce a new conceptual argument merely to make the summary elegant.

When useful, record the selection rationale in the summary slide's design rationale: what was selected, what was deliberately omitted, and why the chosen combination tells the section story better.

# Normal slide-design rendering

A `slide-design(...)` unit should normally render in this order:

1. slide title and teaching move;
2. **layout sketch** using object labels;
3. **labeled content objects**, with real equations, wording, figures, and schemas where available;
4. **reveal sketch** using the same labels;
5. **summary candidates**, when the slide nominates any;
6. rationale, constraints, unresolved design items, and upstream pressure when needed.

One design unit corresponds conceptually to one eventual slide. It need not be forced onto exactly one physical document page.

# Core design rules

## Start from the teaching move

First identify what students must look at, what transformation or distinction they must notice, and what conclusion they should be able to state. Then specify objects, hierarchy, layout, and timing.

## Distinguish object from interpretation

Most ordinary slides should have a main mathematical or visual object plus compact interpretation. Do not make prose describe an object that should instead be shown.

## Keep one dominant attention target

At each reveal state, students should normally have one clear dominant target. Relative hierarchy belongs in design; exact geometry belongs in production.

## Separate grouping from geometry

Decide what belongs together before deciding where it sits. Visible boxes are not required merely because content forms a conceptual group.

## Figure versus schema is a pedagogical role

A figure functions as empirical/statistical/historical evidence or an observed/generated data object. A schema functions as conceptual explanation. Production mechanism does not determine the role.

## Carry earlier material deliberately

Carry forward an earlier equation, model, or visual when it materially helps students understand the new operation, and keep it subordinate.

## Comparison usually requires simultaneous visibility

If students must compare A and B, the relevant final state should normally show A and B together.

## Derivations expose conceptual steps

Show steps that carry conceptual meaning. Do not animate every algebraic motion.

## Summaries are retrospective

Section summaries reuse already-established visual anchors and conclusions; they do not introduce new argument.

Ordinary slide designers should think prospectively about which objects and conclusions may deserve reuse. Summary designers should think retrospectively about which nominations, taken together, actually tell the section's story. These are complementary responsibilities.

# Design process

## 1. Establish the section contract and write the design-notes page

Extract ordered slide titles, intentions, treatment depth, required mathematics/examples/assets, section endpoint, and neighboring dependencies. Distinguish approved decisions from design inference.

Write the section's `section-design-notes(...)` page before detailed slide design. Use it to establish the section purpose, endpoint, narrative arc, visual/notation anchors, summary brief, continuity, and known constraints.

## 2. Design the whole section first in pseudo-Typst

Before perfecting the design API, draft the section as if the desired vocabulary already existed.

For every proposed slide, write a provisional `slide-design(...)` specification containing:

- stable object labels;
- real or near-final visible content;
- ordinary semantic object names where appropriate;
- abstract layout;
- abstract reveal structure;
- summary visual/key-point nominations when a slide establishes a strong candidate;
- `design-*` escape hatches where needed.

The purpose of pseudo-Typst is to expose what the design language actually needs.

Commit the pseudo-design before normalizing it if doing so will make the design-language evolution easier to inspect in Git history.

## 3. Evolve design.typ to fit the real section

Implement or revise the template based on the pseudo-Typst.

Prefer a restrictive standard construct when the section shows a stable design choice. Preserve an escape hatch when the pattern is still uncertain.

Do not distort the slide design to fit the API. Do not make the API broad merely for one unusual slide.

## 4. Compile and inspect the design document

The design artifact is itself a review object.

Check whether layout sketches communicate intended relationships, labels resolve, real equations and figures expose density problems, the reveal sketch matches the intended teaching sequence, and unresolved `design-*` constructs are conspicuous.

## 5. Iterate section and template together

Early sections are allowed to change `design.typ` substantially. The purpose is to learn the language from real slides while the cost of changing it is low.

Do not prematurely stabilize the API.

## 6. Design the summary from the candidate pool

Review the visual and key-point nominations from the ordinary slides.

Select the smallest combination that retells the section's argument coherently. Prefer visual anchors students have already inspected, and reuse earlier key-point wording when it remains accurate. Do not treat every nomination as an obligation.

Record summary-selection rationale when the choice is not obvious.

## 7. Review the section as a visual argument

Check notation, continuity, reuse of visual anchors, simultaneity, persistence, summary integrity, and transitions from the preceding slide.

## 8. Apply backpressure explicitly

If design exposes an organization problem, record:

1. the problem;
2. the provisional design;
3. the upstream change recommended;
4. what changes if accepted.

Do not silently alter the sequence.

# Reveal design rules

Design the complete final state first.

Use static slides when simultaneity is the teaching operation.

For staged explanation, cumulative construction is the default. State 1 is the opening view, not a bookkeeping reveal. Each later state should correspond to a substantive teaching step.

Interpretation may trail construction when the teaching move is “build/derive, then interpret.”

Replacement/focus is exceptional and must preserve a stable conceptual region.

The final state must work coherently as a handout.

# Density and backpressure

Do not solve density by silently shrinking everything.

Apply backpressure when a slide contains two independent teaching operations, required content cannot remain legible, a comparison cannot be simultaneous, a reveal needs more persistent context, a required asset is unavailable, a summary depends on something never established, or neighboring slides do not connect cleanly.

# Final design handoff

The persistent artifact is normally:

`Lectures/<lecture>/slide_design.typ`

importing:

`Lectures/design.typ`

A section is ready for production when it begins with a section design-notes page, every approved slide has a design unit, visible content is exact or near-final, layout and reveal intent are structurally explicit, object identities are stable, summary nominations have been considered and the summary selection is deliberate, remaining `design-*` escape hatches are resolved or explicitly delegated, and upstream pressure is recorded rather than silently absorbed.

# Quality tests

Before treating a section design as ready for production, check:

- **Title-body alignment:** does the slide show what its title claims?
- **Object-first:** is there a clear object students inspect?
- **Dominant attention:** is the focal object clear at each state?
- **Object-interpretation:** does interpretation add meaning rather than paraphrase?
- **Simultaneity:** can compared items be seen together?
- **Reveal value:** does every state correspond to a teaching step?
- **Persistence:** does each state preserve needed context?
- **Final-handout:** does the final state stand alone?
- **Density:** is the real content plausibly slide-legible?
- **Continuity:** does the slide begin from what the preceding slide established?
- **No silent organization change:** are split/merge/reorder pressures explicit?
- **Representation completeness:** do layout, content objects, and reveal all refer to the same stable labels?
- **Section contract:** does the section begin with a useful design-notes page?
- **Summary nominations:** did ordinary slides nominate strong anchors without over-nominating everything?
- **Summary selection:** does the summary use a small coherent subset that retells the section rather than merely listing it?

# General principle

Slide organization defines the teaching sequence.

Slide Design defines the **student-visible explanation in a constrained intermediate language**.

The design API should clarify and limit design choices. The production API should retain enough freedom to realize those choices elegantly.

Slide Authoring should lower the approved design into production without inventing a new explanation.
