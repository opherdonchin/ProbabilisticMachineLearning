---
name: slide-level-organization
description: Organize an already-scoped lecture section into an ordered sequence of slide-level teaching moves, centered on slide titles, order, and concise intention notes, with explicit clarification, critique, and non-blocking backpressure.
---

# Organize slides within a lecture section

Follow the [repository writing requirements](../../../AGENTS.md#writing-for-the-instructor-and-students) for every instructor-facing explanation and review. Explain unfamiliar ideas and the consequences of a choice before using specialist names; do not assume the instructor knows material beyond L03–L04. Keep exact mathematical and source checks available after the readable explanation.

Use this skill when a lecture section has already been substantially scoped and the next task is to determine the sequence of individual slides before detailed visual design or Typst implementation.

The primary responsibility of this skill is **slide titles and their order**.

Its output should make the teaching argument of the section visible as a sequence of slide-level moves. Brief intention and design notes exist to make those titles unambiguous and reviewable; they are not a substitute for the downstream slide-design stage.

This skill is deliberately iterative. It should support a cycle of:

1. clarification with the instructor;
2. a complete proposed organization;
3. explicit critique, issues, and backpressure;
4. further clarification and revision.

Do not silently resolve consequential ambiguities. Do not, however, stop midway through a proposed organization merely because a new question arises. When uncertainty is discovered during drafting, make a visible provisional choice, complete the section organization, record the issue, and return to it in critique.

## Operating modes

Use `build` (default), `feasibility-review`, or `revision` as assigned by the coordinator (`../lecture-development/SKILL.md`) or the instructor. Read `../shared/backpressure.md` for mode scope, report format, and issue routing. The interaction, drafting, and critique process below is **Build mode**.

- **Build:** given an agreed section contract, develop the complete ordered slide-level teaching sequence, review its argument and granularity, and return issues requiring decisions. When coordinated, route consequential instructor choices through the coordinator.
- **Feasibility Review:** inspect a **provisional Section Design contract**, its prerequisites and neighboring-section boundaries, mathematics, examples, and rough live extent. Ask whether the entry-to-endpoint move can plausibly be organized into slides without an incoherent detour, impractical density, or missing knowledge. Return verdict, uncertainties, named owner/severity, and smallest repair; **do not** propose slide titles, counts, ordered teaching moves, or a slide organization artifact. Do not silently change Section Design.
- **Revision:** receive an already approved slide organization plus focused design-stage or instructor backpressure. Update only affected slide titles/order/teaching-move granularity or local summary choices. If solving the issue would alter Section Design's responsibility, boundaries, or treatment depth, return it as upstream pressure instead. Report impacts on existing slide designs and production artifacts.

When a coordinator is active it commissions feasibility reviews, resolves disputes, and communicates with the instructor; otherwise use the established direct collaboration cycle.

## What this skill is not

This skill does not decide what the lecture is fundamentally about. That belongs to `../lecture-scope/SKILL.md`. The intervening `../section-design/SKILL.md` owns the section's intellectual job, entry state, endpoint, boundaries, modularity, and major assigned material.

Do not use this skill to:

- redefine the lecture's intellectual endpoint without instructor approval;
- silently add or remove major source coverage;
- silently change a required result from `Derive` to `State`, or vice versa;
- design finished slide layouts;
- choose exact typography, dimensions, colors, or component geometry;
- write Typst or Touying source;
- generate figures or computational assets;
- implement the student notebook;
- treat the source-book order as a slide outline merely because it is available.

The boundary with slide design is intentionally permeable at the level of **brief direction**. Organization may say that an equation should remain visually dominant, that two cases should be compared simultaneously, that a previous figure should be revisited, or that a derivation probably needs progressive disclosure. It should not specify the finished composition unless the instructor explicitly asks it to blur that boundary.

# Inputs

A section may arrive with some or all of the following:

- section title;
- section purpose or role in the lecture;
- the agreed Lecture Scope and the specific Section Design contract (usually `section_design.md`);
- exact source sections, pages, exercises, or other authoritative material;
- a suggested slide extent and/or live-teaching time;
- a required endpoint;
- required examples, figures, equations, distinctions, or results;
- treatment-depth decisions such as `Mention`, `State`, `Motivate`, `Derive`, `Proof sketch`, `Prove`, `Work`, or `Apply`;
- known prerequisites from earlier sections or lectures;
- explicit omissions or deferrals;
- surrounding material in the current slide deck;
- instructor constraints supplied directly in the conversation or prompt.

When an actual deck already exists, inspect enough of it to understand the local context. At minimum, when relevant, inspect:

- the end of the preceding section;
- the beginning of the following section;
- existing material inside the target section;
- notation and conventions already established;
- prior results that can be carried forward rather than redeveloped;
- recurring pedagogical structures already used in the course.

Use `Lectures/README.md` only for the current slide-system pipeline and `Lectures/material_ledger.md` when curriculum state matters. Do not import production geometry or authoring mechanics into organization. When a brief design note needs course design vocabulary, consult `Lectures/slide_design_conventions.md`.

Do not treat an old outline, abandoned draft, or source-book table of contents as more authoritative than the current instructor decision, agreed scope, or actual delivered material.

# Authority

Within an agreed section specification, this skill may decide:

- the number of slides within the allowed extent;
- slide titles;
- slide order;
- whether one conceptual move requires one slide or several;
- whether two closely related moves belong on one slide;
- where examples, comparisons, recaps, and section summaries belong;
- when an earlier equation, figure, or result should be carried forward for local readability;
- where a staged derivation or comparison is likely to need multiple teaching beats.

It may **recommend**, but must not silently enact, changes to:

- section scope;
- assigned source coverage;
- mathematical treatment depth;
- required endpoint;
- expected section extent;
- assumptions about student prerequisites;
- material assigned to neighboring sections;
- the Lecture Scope or Section Design contract.

When such a recommendation arises, preserve the current specification in the draft as far as reasonably possible, state the provisional choice made, and record the proposed upstream change explicitly.

# Handoff to Slide Design

The approved organization is a contract for the downstream design stage.

For each slide, the handoff should make recoverable:

- final-style title;
- position in the section;
- teaching move / intention;
- special role when relevant, such as summary, comparison, derivation, example, or recap;
- required equation, example, figure, or source when the upstream section contract makes it mandatory;
- brief design constraints only when they materially preserve the teaching move.

Design notes should describe pedagogical relationships rather than finished composition.

Good organization-level constraints include:

- compare A and B simultaneously;
- keep a previously established equation available as context;
- let the derivation unfold progressively;
- revisit a previously taught visual anchor;
- static summary.

Leave these to Slide Design:

- exact visible wording beyond what is needed to define the teaching move;
- semantic object decomposition;
- key-point wording;
- detailed visual hierarchy;
- abstract layout specification;
- reveal-state structure;
- summary visual/key-point selection.

Leave exact geometry and Typst/Touying mechanics to Slide Authoring.

The organization artifact should contain enough information that Slide Design can explain every slide's intellectual job without reverse-engineering it from the source book.

# Core organizational principle

Treat each slide as a **teaching move**, not as a container for a source subsection.

A good slide sequence should make the section's reasoning legible even before any visual design is applied.

Prefer slide boundaries when there is a genuine change in intellectual job, for example:

- establish a model;
- pose the probabilistic query;
- state a result;
- derive a result;
- interpret the structure of a result;
- specialize a general result;
- work an example;
- compare cases;
- consolidate what the section has established.

Do not create separate slides merely because a textbook gives separate paragraphs or equations. Conversely, do not force two distinct teaching moves onto one slide simply to hit a nominal slide-count target.

## Section closure: finish on the summary

The final teaching move in every section is a **retrospective summary** of that section's established argument. Do not place a preview, next-section question, "next we will" promise, bridge, or handoff **after** the summary or **inside** it. If essential continuity must be explained, establish it when the **receiving section begins**, not at the end of the preceding one. A later notebook task belongs to its separate lecture-level introduction, not to a forward-looking final summary.

Upstream author-facing notes about neighboring sections are permitted, but they are not student-facing closing content. Preserve this ending when choosing slide titles and order, and ask for upstream clarification if a section contract appears to require a conflicting ending.

# Slide titles are the main product

Titles should normally state the slide's claim, question, or teaching move.

Prefer titles such as:

- `Conditioning shifts the mean by an observed deviation`
- `Covariance determines the shape of a Gaussian`
- `The same dataset can support different learning tasks`
- `Bayes' rule becomes an update formula for Gaussians`

Avoid generic organizational labels such as:

- `Example`
- `Conditional Gaussian`
- `More on covariance`
- `Application`
- `Background`
- `Derivation`

unless the slide genuinely functions as a reference or navigation slide and a claim-style title would be misleading.

Use this as a central quality test:

> **If the slide titles are read in order without the slide bodies, do they recover the intellectual argument of the section?**

Titles need not always be complete sentences, but they should be specific enough that the intended teaching move is recoverable later.

# Interaction process

## 1. Establish the working specification

Before asking questions, summarize the section-level constraints already known.

Keep this compact. Include only information that materially affects slide organization, such as:

- section purpose;
- source coverage;
- endpoint;
- expected extent;
- mathematical treatment decisions;
- required examples or figures;
- relevant prerequisites;
- important neighboring-section constraints.

Distinguish explicit decisions from your own inference.

If the specification is already sufficiently clear, say so rather than manufacturing questions.

## 2. Clarification cycle

Ask questions whose answers could materially alter the slide titles, order, or teaching structure.

Useful questions include:

- Is this result meant to be derived or only stated?
- Is this example central, illustrative, or optional?
- Can this prerequisite be assumed, or should it be locally re-established?
- Is the section meant to end at the general result or at the application?
- Is the proposed extent a hard ceiling or a rough expectation?
- Is this source subsection meant for substantive treatment or acknowledgement only?
- Should two alternative formulations both be taught, or should one be reserved for later?

Do not ask for information already supplied by the instructor or available in the agreed scope.

You may indicate when you believe there is enough information to attempt an organization, but the instructor decides when to leave clarification and proceed to design.

Do not require every ambiguity to be resolved before drafting. Some important questions only become visible once the section has been organized.

## 3. Produce a complete organization draft

When the instructor asks you to proceed, draft the entire section rather than stopping at the first uncertainty.

For each proposed slide give:

### Slide title

The proposed final-style title.

### Intention / goal

Usually one or two sentences stating:

- what teaching move the slide performs;
- what students should understand or be able to do after it;
- why it appears at this point in the sequence when that is not obvious from the title.

### Design note

Optional and brief. Use only when needed to disambiguate the organizational decision or preserve an important pedagogical structure.

Appropriate examples:

- `Keep the conditioning equation visually dominant; derivation can unfold beside it.`
- `Compare the two cases simultaneously rather than serially.`
- `Reuse the covariance-contour figure already established earlier.`
- `Static recap; no reveal sequence needed.`
- `Likely progressive derivation, with the previous line retained as carry-forward context.`

Inappropriate detail at this stage includes exact widths, colors, font sizes, box geometry, coordinate placement, or Typst implementation.

### Provisional assumption, when needed

If drafting exposed an unresolved issue, state the provisional choice locally when that helps interpret the organization, but do not let the issue interrupt completion of the full draft.

## 4. Record issues exposed by drafting

After the complete organization, list the questions, tensions, or assumptions that became visible while designing it.

For each issue state:

- what the issue is;
- why it matters to the section sequence;
- what provisional choice the draft made;
- what alternatives are plausible;
- whether you recommend an upstream change.

Do not hide these choices inside the slide notes.

## 5. Critique the organization

Critique the proposed section as an intellectual sequence, not as a finished graphic artifact.

Check:

### Argument

- Do the titles form a coherent argument?
- Does each slide make a distinct contribution?
- Is the section's central question or purpose visible in the sequence?
- Does the section reach the agreed endpoint?

### Dependency order

- Does every slide have the prerequisites it needs?
- Are results introduced before they are interpreted or applied?
- Is previously established material carried forward where local readability requires it?
- Are any concepts explained only after students needed them?

### Granularity

- Are any slides carrying two genuinely distinct teaching moves?
- Are any consecutive slides doing essentially the same job?
- Would combining or splitting slides improve the reasoning rather than merely change slide count?

### Emphasis

- Does the number and placement of slides reflect the importance of the ideas?
- Is too much space being spent on source material that is incidental to the section's purpose?
- Are the load-bearing results and interpretations given enough room?

### Examples and summaries

- Does each example have a distinct pedagogical job?
- Does the section summary consolidate only material already established in the section?
- Are important take-home claims stated directly before they are reused in a summary?
- Does the summary *end the section*, without a teaser, closing bridge, or question aimed at the next section?

### Extent

- Is the organization plausible for the suggested slide/time extent?
- If it is tight, identify what creates the pressure rather than simply compressing everything.
- Compare with the current course's pacing and density conventions where relevant.

### Continuity

- Does the section enter naturally from what precedes it?
- Does it avoid silently doing work assigned to the following section?
- Does notation and mathematical depth remain consistent with the course?

After critique, recommend concrete revisions to the slide titles/order and identify any questions that should return to the instructor.

## 6. Iterate until approved

Return to clarification, revise the organization, and critique again as useful.

The agent may say that the organization appears stable, but the instructor decides when the section organization is approved.

Do not treat the first internally coherent draft as final merely because it is possible to implement.

# Backpressure

Backpressure is a normal output of this skill, not a failure condition. Read `../shared/backpressure.md` for issue ownership, severity, and the distinction between **preview feasibility** and **execution backpressure**.

When organizing slides for a real section, this is **execution backpressure**. If the section's single intellectual job, entry/endpoint, source assignment, modularity, or boundary fails, return the issue to **Section Design**. Escalate to **Lecture Scope** only when repairing it requires a lecture-level change. Changes solely to the teaching-move granularity, summaries, or slide count within an agreed section are owned here.

A downstream organization attempt may reveal that the upstream specification needs reconsideration. Make such pressure explicit and continue with a provisional full organization whenever reasonably possible. If no coherent provisional sequence is possible, report the blocker instead of pretending to complete it.

Use concise categories when helpful:

## Scope pressure

The requested source coverage does not fit the stated intellectual purpose of the section.

## Extent pressure

The intended treatment depth and examples do not plausibly fit the suggested time or slide extent.

## Prerequisite pressure

The section sequence depends on knowledge that students have not yet established or that the current course state does not support assuming.

## Endpoint pressure

The required endpoint does not follow naturally from the required material without additional conceptual work.

## Redundancy pressure

The section substantially repeats material already taught without a clear new function.

## Source pressure

The assigned source pages do not support the intended argument as cleanly as expected, or a better nearby source treatment exists.

## Neighboring-section pressure

A coherent organization suggests moving material into or out of an adjacent section.

For each backpressure item state:

1. owning stage and severity (`blocking`, `advisory`, or `downstream-owned`);
2. the specific pressure and evidence;
3. the provisional choice used to complete the organization, or why none is safe;
4. the smallest proposed change;
5. what would change in the slide sequence if the instructor accepts it.

Do not request a revision of Section Design merely because two slides should be combined, one derivation needs two slides, or a summary should be explicitly labeled.

Example:

> **Extent pressure:** Deriving both the multivariate conditioning formula and the Schur-complement proof is unlikely to fit the proposed six-slide extent.  
> **Draft choice:** Keep the conditioning derivation live and treat the Schur complement as interpretation rather than a separate proof.  
> **Proposed change:** Either expand the section to roughly eight slides or move the proof elsewhere.  
> **Sequence effect:** If the extent remains fixed, the current seven-step argument compresses to five substantive teaching slides plus summary.

Do not silently implement the proposed upstream change.

# Relationship to neighboring skills

## Upstream: Lecture Scope and Section Design

Lecture Scope defines the lecture-level intellectual territory, mathematical spine, examples, notebook handoff, and lecture contract.

Section Design defines this section's purpose, entry condition, endpoint, assigned mathematical treatment and sources, boundaries, and place in the lecture-level argument. Work on **one approved section at a time**. When a section contract is not yet available, clarify the missing contract rather than silently inventing it.

Slide-Level Organization should operationalize those decisions as teaching moves. If the sequence cannot do so coherently, apply explicit backpressure rather than quietly redesigning the section.

## Downstream: Slide Design

Slide-Level Organization asks:

> **What teaching move happens on this slide, and why does it come here?**

Slide Design asks:

> **Given that teaching move, what should the student actually see?**

The organization handoff may contain design-direction notes, but Slide Design owns finished composition, equation/figure hierarchy, reveals, typography, and visual emphasis.

Slide Design may itself create backpressure, for example:

- a proposed slide contains two distinct visual and pedagogical moves and should be split;
- an intended comparison cannot be read simultaneously at the proposed density;
- a derivation requires more persistent context than the organization anticipated;
- a summary depends on a claim that was never stated directly upstream.

Such feedback should return to organization rather than being silently repaired by changing the sequence during visual design.

## Downstream: Slide Authoring

Slide Authoring receives the approved Slide Design specification and implements it with the course's Typst/Touying production system, figures, assets, compilation, and review. It must not silently change approved visual explanation or pedagogical sequence. When that implementation exposes structural pressure, route it through Slide Design and, if necessary, back to Slide-Level Organization or its upstream owners.

# Final approved handoff

The final persistent output should be compact enough for a downstream slide-design agent to use directly.

It should contain three parts.

## 1. Section organization

An ordered list of slides. For each slide:

- **Title**
- **Intention / goal**
- **Design note** only where useful

Example:

> **Conditioning shifts the mean by an observed deviation**  
> **Intention / goal:** Establish the conditional-mean formula and make its update structure interpretable before addressing conditional covariance. Students should see the posterior mean as the prior mean plus a correction driven by the observation.  
> **Design note:** Keep the formula dominant; a derivation may occupy the secondary region or unfold progressively.

## 2. Open issues / explicit assumptions

Ideally empty or short by final approval. Preserve only assumptions a downstream designer must know.

## 3. Upstream change requests

List only changes requiring instructor approval. If none remain, say so.

Do not preserve a long history of rejected alternatives in the final handoff. Git/chat history carries the design discussion; the approved organization should remain usable.

# Quality tests

Before presenting an organization as stable, apply these tests.

## Title-sequence test

If only the slide titles are read in order, can the section's intellectual argument be reconstructed?

## Distinct-job test

Does each slide have a teaching job that would be lost or materially weakened if the slide disappeared?

## Dependency test

Does every slide arrive after the concepts and notation it needs?

## Load-bearing test

Are the claims students most need to retain stated directly somewhere in the section rather than appearing for the first time in the summary?

## Summary-reuse test

For important take-home statements, would the instructor be comfortable reusing essentially the same wording on the section-summary slide?

A negative answer may indicate that the upstream teaching slide's key point is not yet direct or load-bearing enough.

## Retrospective-closure test

Is the section's final slide a retrospective summary of established results, with no forward-looking handoff? If a connection is indispensable, move it to the next section's opening.

## Extent test

Does the proposed granularity fit the stated extent without requiring unusually dense slides or implausibly fast delivery?

## No-silent-decision test

Can every consequential deviation from the agreed section specification be found explicitly in assumptions, issues, or backpressure?

If not, surface it before handoff.

# General principle

The source material supplies content; the section plan supplies purpose; slide-level organization supplies **teaching sequence**.

A good organization should make the section readable as an argument before any slide is graphically designed.
