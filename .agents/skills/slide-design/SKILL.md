---
name: slide-design
description: Turn an approved slide organization into a constrained, reviewable Typst design specification without silently changing the teaching sequence or prematurely solving production geometry.
---

# Slide design

Follow the [repository writing requirements](../../../AGENTS.md#writing-for-the-instructor-and-students). Address a mathematically mature reader who may be unfamiliar with later methods: retain precise names, decision-relevant equations and assumptions, explain the concern clearly, and give verified focused book readings when needed. Clarity must preserve the mathematical substance rather than move every important distinction into checking notes.

Use this skill after lecture/section scope and slide-level organization are
approved, and before production authoring.

The primary question is:

> Given the approved teaching move, what should the student actually see, and
> how should those visible objects relate in content, space, and time?

Work one section at a time unless the instructor explicitly asks otherwise.

Under Lecture Development coordination,
[the coupled slide protocol](../shared/slide-convergence.md) permits explicitly
labeled exploration of provisional Organization with Authoring before formal
design approval. Offer semantic arrangements and invariants, ask for measured
production counteroffers, and negotiate Organization changes with its owner.
This informs a coherent proposed contract; it does not authorize production
replacement or silently change approved teaching decisions.

## Operating modes

Use `build` (default), `feasibility-review`, or `revision`. Follow `../shared/backpressure.md` for the common mode/result/ownership contract. When the Lecture Development Coordinator (`../lecture-development/SKILL.md`) is active, return decisions and review results through the coordinator, not a second instructor-facing conversation.

- **Build:** the section-first visual design procedure below; produce the approved student-visible explanation in `slide_design.typ` without silently revising the slide sequence.
- **Feasibility Review:** inspect a **provisional slide organization**, its section purpose, required mathematics, examples, figures, and time/extent assumptions. Assess whether each teaching move can plausibly be expressed in readable visual content and coherent reveal states using the constrained design language. Examine possible information density, simultaneous comparisons, summary dependencies, and asset feasibility. Return a verdict (`feasible`, `feasible-with-risks`, or `blocked`) and stage-owned issues with evidence and smallest repair. **Do not** draft slides, generate `slide_design.typ`, choose finished layouts, or change slide titles/order.
- **Revision:** given an approved design plus **specific** Slide Authoring backpressure or instructor change, revise only affected design units/content, semantics, visuals, or reveals; preserve unchallenged teaching moves. Send changes to slide count/title/order back to Slide-Level Organization and changes to section endpoints/depth to the appropriate owner. Report which production slides now need rebuilding or revalidation.

Independent feasibility reviews are preferable where delegation exists, but a same-agent review must be labeled as such. A preview cannot replace actual design review or production render validation.

## Required references

Before designing, read:

- the relevant section-design / lecture-scope artifact;
- the approved `slide_organization.md`;
- `Lectures/slide_design_conventions.md`;
- `Lectures/design.typ`;
- the relevant authoritative source material;
- neighboring slides/sections when continuity matters;
- mature Lecture 1 precedent when a concrete course example helps.

When producing executable `.typ` mathematics, use the available Typst-authoring
skill and verified current syntax/documentation alongside this pedagogical skill.
A rendered equation must preserve the intended delimiters and attachment grouping;
compilation alone does not establish that.

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
- transient entry emphasis when the newly revealed material needs an attention cue;
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

For an insertion into an existing deck, inspect rendered immediate neighbors
and a relevant established teaching slide (a proof precedent for a new proof).
Extract a brief visual/notation contract before choosing content: what is the
inspected object, which transformations and local reasons make its argument
readable, what explanation belongs in key points, what prior knowledge is
carried forward, and how the deck distinguishes new reasoning from recall.
Apply the instructor's course conventions; sharing a theme is not sufficient
continuity. Report concrete precedent evidence, not merely that files were read.

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
- entry context and continuity (no closing handoff);
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
- reveal structure, including any transient entry emphasis;
- key points;
- summary candidates when justified;
- unresolved design constructs explicitly.

Ordinary mathematical objects should be light on explanatory text, following
[the object/key-point convention](../../../Lectures/slide_design_conventions.md#objects-and-key-points).
Keep equations, figures, intrinsic labels/conditions and local mathematical
warrants where students need them to follow the object. Put task framing and
takeaway interpretation in key points. Light text is not an equation-only rule:
removing a centering label, substitution map or reason for an implication can
remove the argument. Key points can accompany the step they interpret rather
than wait for the final reveal.
This is a semantic choice made before layout, not a word-count target or a reason
to omit mathematics. Text may itself be an inspected object (e.g. an algorithm).

Keep object and key-point roles distinct in the composition and through reveals.
Prefer a layout with a separate key-point slot. A generic label grid does not
make every label a mathematical object; if the intended relation cannot be
expressed faithfully, use an explicit design escape/backpressure rather than
flattening the roles. Do not duplicate the same explanation as both a titled
object and a takeaway.

For each recalled mathematical item, check the actual preceding student-visible
state and identify where it was established. A functional prerequisite brief is
not evidence that an adjacent candidate taught it. A previous definition does
not make a newly averaged or otherwise transformed consequence recalled knowledge.
Use ordinary proof objects for new reasoning; a recall object is subordinate
because students already possess its content, not because space is scarce.

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

Run `python scripts/check_typst_math_attachments.py <design-file>` after editing
executable design mathematics, and resolve new hits before handoff. Use documented
math constructors for compound delimiters (e.g. norms inside expectations) rather
than assuming adjacent shorthand characters will parse as intended. For ambiguous
delimiters or attachments, check local syntax and inspect the rendered expression;
use a minimal parsed-content probe when visual inspection cannot resolve it.

The rendered design document is itself a review artifact.

Check:

- title/body alignment;
- clarity of the dominant object;
- real equation/figure density;
- layout relationships;
- reveal state logic;
- whether requested entry emphasis helps locate the new material without adding competing chrome;
- persistence;
- summary nominations;
- unresolved escape hatches;
- section continuity.

Compare the candidate explanation with the selected precedent contract. Identify
any prose retained in the object and why it is intrinsic to reading that object;
check that key points still occupy their interpretation role, and that new proof
steps receive teaching attention. Reconstruct the argument from the visible
sequence: what is being established, which previous expression each new operation
acts on, what licenses it, and how the result answers the opening question. Keep
a load-bearing equation syntactically whole; make its terms and connection to
the proof readable without giving every equation equal visual weight. An A4 design render or a complete list of
labels cannot establish final slide readability or alignment by itself.

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
- retrospective summary as the final section teaching move, with no handoff to the next section.

The summary is the **end** of the section: do not add a teaser, "next we will" statement, next-section question, or exit bridge after it. Necessary connective explanation belongs at the **start of the receiving section**. The notebook handoff is separate from section closure. Keep both the designed summary and its preceding slides faithful to what was actually established.

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
- the summary selection is deliberate and the summary is the final, backward-looking section move;
- unresolved `design-*` items are either resolved or explicitly delegated;
- upstream pressure is recorded rather than silently absorbed.

## General principle

Organization defines the teaching sequence.

Slide Design defines the student-visible explanation in a constrained,
reviewable intermediate language.

Slide Authoring should be able to realize that design without inventing a new
explanation.
