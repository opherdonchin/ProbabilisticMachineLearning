---
name: lecture-scope
description: Develop an agreed lecture scope from prior course material, Murphy Books 1 and 2, the course material ledger, and any authoritative syllabus before slide or notebook drafting begins.
---

# Develop a lecture scope

Use this skill when deciding what a lecture should cover and how its intellectual structure should work before any slide-level, visual, Typst, or notebook authoring begins.

The purpose of this skill is not to generate a lecture plan in one pass. It is to guide an iterative instructor-agent process that explores alternative routes through the material, evaluates tradeoffs, converges on a coherent scope, and records that scope in a form that downstream drafting skills can use.

The final Lecture Scope has five parts:

1. Intellectual arc
2. Mathematical spine
3. Notebook handoff
4. Concrete examples
5. Lecture contract

Build these parts iteratively and in that order. Do not draft the complete scope all at once unless the instructor explicitly asks for a one-pass result.

## What this skill is not

This skill stops at lecture scope.

Do not use it to:

- draft individual slides;
- decide exact slide counts;
- write Typst;
- design slide layouts or graphics;
- generate figures;
- implement the student notebook;
- write a slide-by-slide outline;
- perform section-level or slide-level drafting that belongs to later skills.

Exception: before scope approval, request a **lightweight Section Design feasibility review**, not a section design. Follow the protocol in `../shared/backpressure.md` and the review mode of `../section-design/SKILL.md`.

The approximate time allocations in the scope are constraints for later drafting, not slide counts. Scope-stage timing is a planning estimate, not a validated rehearsal time.

## Required sources

Before proposing a new lecture scope, inspect the sources that establish the actual course state.

Use, when available:

- the actual previous lecture deck or other delivered lecture artifact;
- the actual previous lecture notebook and any assigned recording;
- `Lectures/material_ledger.md`;
- the relevant parts of Murphy Book 1;
- the relevant parts of Murphy Book 2;
- an authoritative course syllabus, if one exists;
- any current instructor instructions or decisions in the conversation;
- actual timing, rehearsal, or instructor pacing reports from previous lectures, if available;
- instructor-specific delivery-rate experience from comparable courses, used only as a rough calibration.

When estimating lecture extent, also read `references/timing-calibration.md`. Its counts and coefficients are provisional course-specific priors, not universal rules.

Do not infer the starting point from an old plan when actual lecture artifacts exist.

Treat the material ledger as the canonical record of curriculum boundaries and prior section dispositions. A section that was merely mentioned is not thereby covered.

If an existing syllabus conflicts with actual delivered material or with a more recent instructor decision, surface the conflict rather than silently choosing one.

## Order of authority

When constraints conflict, use this order:

1. explicit current instructor decisions;
2. actual previously delivered course material and the agreed Lecture Scope of prior lectures, when available;
3. the current material ledger;
4. an authoritative current syllabus;
5. Murphy Book 2 and Book 1 as source texts;
6. generic pedagogical preference.

Book order matters, but it is not a command to cover every intervening section.

## Core optimization principle

Optimize the lecture as a whole rather than maximizing any single criterion.

Protect these first:

- internal coherence;
- feasibility in the available time;
- alignment with what students actually know;
- coherence and continuity with previous lectures in pacing, coverage density, notation, mathematical depth, and intellectual style.

Within those constraints, prefer:

- a substantive and useful intellectual or applicative endpoint;
- a strong handoff to the student notebook when a notebook is part of the lecture;
- recognizable forward progress through the books;
- reuse of nearby material before large forward jumps when pedagogical value is comparable.

Do not include material merely because it lies numerically between two sections. Backfill earlier material when it materially enables the lecture. Otherwise leave it for later.

Do not force a nominal syllabus topic into the lecture if doing so weakens the lecture's coherence or endpoint. Conversely, do not make large jumps through the books when a nearby route produces a comparably strong lecture.

A good scope should feel like a plausible continuation of the course already taught, not an independently optimized standalone lecture.

# Scope-development process

## 1. Establish the starting boundary

Inspect the actual prior course artifacts and summarize the state from which the new lecture begins.

Identify, concisely:

- the curriculum boundary in each book;
- the conceptual and mathematical endpoint of the previous lecture;
- material primarily covered by lecture, notebook, or recording;
- deferred material that may be relevant now;
- the pacing and coverage density of the previous lecture;
- any actual timing or instructor pacing evidence that can calibrate the new lecture;
- notation and mathematical conventions that should carry forward;
- what students can reasonably be assumed to know at the beginning of the new lecture.

Do not turn this into a retrospective review of the whole course. Include only information that constrains the next scope.

## 2. Solicit instructor goals, issues, and priorities

Before generating alternative paths, explicitly ask the instructor for any goals, concerns, constraints, or priorities that should affect the lecture.

Useful categories include:

- desired endpoint;
- material the instructor particularly wants included or excluded;
- concerns about redundancy or overload;
- desired relation to the notebook;
- prerequisite assumptions;
- dissatisfaction with the previous lecture or nominal syllabus;
- preference for a Book 1 or Book 2 treatment;
- later material that should be prepared for but not yet taught;
- willingness to move self-contained mathematical developments into an assigned recording if the eventual live lecture becomes too dense.

If these have already been supplied in the conversation, summarize them and ask only about genuinely unresolved points. Never ask the instructor to repeat an answer already available.

## 3. Generate genuinely different forward paths

Normally propose 3-6 plausible trajectories.

Alternatives must differ pedagogically, not cosmetically. They may differ in endpoint, amount of backfill, which book provides the main exposition, whether a topic is deferred, whether a mathematical development is live or recorded, or how directly the lecture prepares the notebook.

For each path, state compactly:

- central question or organizing idea;
- endpoint;
- main Book 1 / Book 2 sections;
- likely notebook endpoint, if any;
- important inclusions;
- important deferrals or jumps;
- likely recording opportunities when they materially affect feasibility;
- why this path is worth considering.

Do not produce a slide outline at this stage.

## 4. Evaluate the alternatives

Compare the paths explicitly against the lecture-level priorities.

Include:

- internal coherence;
- substantive endpoint;
- notebook handoff;
- forward progress through the books;
- prerequisite burden and required backfill;
- feasibility in the available lecture time;
- alignment with previous lectures in pacing, amount of material, mathematical depth, and conceptual continuity;
- whether any valuable but self-contained mathematical development is a plausible recording candidate;
- implications for later lectures when they are material to the choice.

Expose real tradeoffs. Do not manufacture a numerical score unless it genuinely clarifies the decision.

Recommend a path when the evidence is strong, but keep the alternatives visible enough for the instructor to redirect the design.

## 5. Explore and converge with the instructor

Treat scope selection as iterative.

Useful moves include:

- moving an endpoint earlier or later and checking what that changes;
- comparing Book 1 and Book 2 treatments of the same idea;
- using one book for the main progression and the other for scaffolding;
- identifying material that should be derived carefully versus catalogued briefly;
- testing whether an intervening topic can be deferred safely;
- looking for a stronger application or notebook endpoint nearby in the books;
- identifying mathematically valuable developments that could move to recording if slide drafting later shows the live lecture is too dense;
- checking whether a proposed route creates an awkward burden for the following lecture;
- revising priorities when the instructor reacts to an alternative.

Do not rush from the first promising idea to a frozen scope.

Once a preferred route is clear, summarize the proposed coverage and any remaining choices that would materially affect the lecture. Resolve those before building the final scope, except choices explicitly marked for later validation such as `Recording candidate` decisions that depend on the eventual slide extent.

# Build the Lecture Scope iteratively

Build and review each part separately. If a later part reveals a structural problem, revise the earlier part rather than forcing consistency artificially.

## 6a. Intellectual arc

Build this first.

Divide the lecture into a small number of major conceptual segments, not slides.

For each segment include:

### Transition in

Explain why the lecture is entering this segment from the preceding material.

Transitions belong at the beginning of segments. Do not end a segment with a transition to the next one.

### Question / purpose

State the question the segment answers or the intellectual job it performs.

### Sources

Give exact relevant Book 1 / Book 2 sections and any other authoritative source material.

### Core content

State the concepts, claims, constructions, and relationships that should be taught.

Separate genuinely new material from review or scaffolding when that distinction matters.

### Approximate time

Give a realistic live-teaching time allocation. Treat this as a constraint on later drafting and as a check on whether the scope fits the lecture.

Do not imply false precision. When timing materially affects feasibility, state the basis and confidence of the estimate. Prefer evidence in this order:

1. measured teaching or rehearsal time for closely comparable material;
2. instructor judgment about the length and pacing of an existing lecture in this course, especially when its slide structure and mathematical density can be compared directly;
3. instructor reports of actual pacing in previous lectures or comparable courses;
4. instructor-specific slide-delivery experience from comparable teaching, used as a rough prior rather than a fixed conversion rate;
5. comparison with similarly dense segments in existing course lectures;
6. complexity-based judgment using the number and depth of derivations, worked examples, conceptual transitions, reveals, and expected discussion;
7. generic timing heuristics only as a last resort.

Leave realistic room for transitions, questions, interaction, and slippage rather than budgeting every available minute as content delivery.

A `Recording candidate` remains part of the live-time budget until the instructor actually decides to move it out of the live lecture. Material marked `Recording` is excluded from the live-time budget, but the time needed to introduce or summarize it live must still be counted.

### Recording note, when relevant

Mark self-contained material as one of:

- `Live` — currently intended for substantive live treatment;
- `Recording candidate` — currently retained live, but a plausible item to move to recording if later extent validation shows the lecture is too dense;
- `Recording` — the instructor has decided the primary development belongs in a recording; state what, if anything, remains live.

Do not move core prerequisite reasoning into a recording merely to solve a timing problem. A recording should carry detail that can be separated without breaking the live intellectual chain.

### Summary

End the segment by consolidating what students should carry forward from it.

Summaries belong at the end of segments.

Review the entire intellectual arc with the instructor before proceeding.

## Timing and extent validation

Scope-stage timing is provisional. Validate lecture extent repeatedly as the artifact becomes more concrete.

### Current provisional course calibration

Until this course has measured timing data, use the instructor-specific anchors and feature definitions in `references/timing-calibration.md` as rough calibration rather than as hard limits.

In particular:

- treat the current L01 deck as the strongest course-specific extent benchmark;
- use the instructor's broader 60-80-slide undergraduate experience only as a wider plausibility range;
- distinguish new equation/result families from carried-forward equations and derivational algebra;
- count raw figures separately from slide-level visual/schema groups;
- count only source pages substantively traversed by the scope rather than the numeric span between first and last citation;
- use the prototype slide-extent equation in the calibration reference only as an independent warning signal, never as a target that overrides pedagogical judgment.

### At scope stage

- Sum planned live time across intellectual-arc segments.
- Check the total against the actual live-teaching window, not the nominal course-meeting length if part of the meeting belongs to a notebook, break, discussion, or other activity.
- Inspect whether the mathematical depth implied by the spine is consistent with the time allocation.
- Compare overall density with previous lectures, especially the current L01 benchmark.
- When enough detail exists, estimate `K`, `P`, `E_new`, `E_carry`, `E_deriv`, and `V` using the definitions in the calibration reference and compute the prototype slide-count estimate. Report the range and uncertainty; do not turn this into a slide outline.
- Flag the lecture as `comfortable`, `tight`, or `overfull` rather than disguising uncertainty behind precise minute totals.
- Record any `Recording candidate` material that could relieve pressure later, but continue counting it as live.

### During section and slide drafting

Re-estimate timing when the real teaching structure becomes visible. Use:

- actual number of conceptual steps;
- new equation/result families;
- carried-forward equation blocks;
- number and length of derivational blocks;
- worked examples and numerical calculations;
- selected visual/schema groups and the slides they occupy;
- staged reveals and figure interpretation;
- speaker-note content;
- planned questions or student interaction;
- transitions and summaries;
- total content-slide count relative to the current L01 deck and the instructor's broader 60-80-slide experience.

Slide count is only a coarse extent signal. A lecture with substantially fewer but much denser mathematical slides may still be longer than L01; a lecture with more short visual or transition slides may still be comfortable.

If the drafted lecture is materially denser than the scope estimate, revise scope decisions rather than simply assuming faster delivery. At this stage, `Recording candidate` items can be revisited with the instructor.

### Before teaching, when possible

A rehearsal, partial rehearsal, or instructor timing report is the strongest validation. Use it to revise the live plan and to inform timing estimates for later lectures.

If no measured timing evidence exists, say so. Do not describe complexity-based estimates as validated timings.

## 6b. Mathematical spine

Extract the mathematics that the agreed arc depends on.

For each item specify:

- the mathematical object, definition, equation, result, or derivation;
- where it enters the intellectual arc;
- why it matters later in the lecture or course;
- the intended treatment depth;
- intended delivery status: `Live`, `Recording candidate`, `Recording`, or `Notebook` when relevant.

Treatment depth must be explicit. Useful labels include:

- `Mention` - name or recognize; no substantive development;
- `State` - present the result or definition clearly without derivation;
- `Motivate` - explain why the object/result has the stated form or why it matters;
- `Derive` - work through the mathematical derivation;
- `Proof sketch` - show the essential argument without all algebraic detail;
- `Prove` - give a substantive proof appropriate to the course;
- `Work` - carry through a concrete symbolic or numerical example;
- `Apply` - use an already-established result in a new setting.

Use more than one label when appropriate, but do not add labels for decoration.

If only part of a mathematical item may move to recording, state the split explicitly, for example: `Live: result and interpretation; Recording candidate: full derivation`.

When a previously established equation is needed again to make a subsequent derivation or specialization legible, treat it as carried-forward support rather than as new mathematical content. Downstream slide design may use the course's existing `Carry forward` visual language or a lighter same-lecture variant; this scope skill should record the dependency but not design the block.

The mathematical spine is selective. It is not a list of every equation in the source sections.

Review the mathematical spine with the instructor before proceeding.

## 6c. Notebook handoff

Define the interface between lecture and notebook, not the notebook itself.

Specify:

- the source section, exercise, example, or method that anchors the notebook;
- what the lecture must already have established before the notebook begins;
- what new mathematical or computational work the notebook adds;
- what students will manipulate, estimate, simulate, compare, or implement;
- the notebook's conceptual endpoint;
- how the notebook extends rather than simply repeats the lecture;
- whether any definite recording is prerequisite to the notebook.

If the notebook handoff exposes a gap in the intellectual arc or mathematical spine, revise those earlier parts.

Do not author notebook questions or code in this skill.

Review the handoff with the instructor before proceeding.

## 6d. Concrete examples

Choose examples only after the arc, mathematical spine, and notebook handoff are stable enough to know what the examples must accomplish.

For each example specify:

- source or provenance;
- teaching purpose;
- relevant part of the mathematical spine;
- relation to the notebook, if any;
- treatment level: `Work through`, `Compare`, or `Brief`;
- delivery status if the example is tied to a recording decision.

When inspecting source material, distinguish figures/schemas that are merely available from those actually selected for teaching. Estimate slide cost using selected visual/schema groups rather than raw image-file count.

Prefer a small number of examples with distinct pedagogical jobs over a catalogue of similar examples.

A source text may contain a long example catalogue even when the lecture needs only one careful derivation plus a compact comparison of the others.

Review the examples with the instructor before proceeding.

## 6e. Lecture contract

Write the authoritative lecture contract last, once the rest of the scope is stable.

Keep it short.

Include:

- starting assumptions: what students are expected to bring into the lecture;
- central lecture goal or question;
- lecture endpoint;
- notebook endpoint, when applicable;
- any definite required recording and its role, when applicable;
- a small number of learning outcomes that are genuinely supported by the agreed scope.

Do not inflate the learning outcomes beyond what the lecture, notebook, and any required recording actually establish.

# Assemble and freeze the scope

After all five parts have been reviewed, assemble them into one coherent Lecture Scope document without expanding them unnecessarily.

Check that:

- the contract matches the actual arc;
- the mathematical spine contains the mathematics required by the arc and notebook;
- examples serve identified purposes;
- live time allocations fit the available lecture time with realistic room for interaction and slippage;
- timing confidence and evidence are represented honestly;
- `Recording candidate` material is still counted in the live scope;
- definite `Recording` decisions state what remains live and what students are expected to get from the recording;
- transitions occur at segment beginnings;
- summaries occur at segment ends;
- notation and depth align with previous lectures;
- the lecture has a clear endpoint;
- the notebook has a clear handoff;
- the scope does not contain slide-level drafting.

## Section Design feasibility review before approval

After assembling the five-part provisional Lecture Scope and checking its internal consistency, request **one preview feasibility review** using the review mode in `../section-design/SKILL.md` and `../shared/backpressure.md`. Do this **before final instructor approval / freezing**, not as a substitute for the Scope Builder's own analysis.

Ask:

> Can a plausible sequence of coherent intellectual moves carry students from the stated starting state to the lecture and notebook endpoints, given the mathematical treatment depths, required examples, source constraints, and live-time budget? Identify obstacles and the smallest repairs. Do not design sections or slides.

Review for:
- missing or reversed prerequisites and student-state assumptions;
- required treatment or empirical applications that cannot plausibly fit the live time;
- a destination that is inaccessible from the proposed intellectual arc;
- mismatches among coverage, source support, mathematical spine, examples, and notebook handoff;
- recording/removability conflicts that make the proposed route fragile.

Classify findings as **blocking**, **advisory**, or **downstream-owned**. Only repair decisions owned by Lecture Scope here. Do not force the Section Designer to pick titles, section counts, exact boundaries, or teaching moves to justify its verdict.

Discuss consequential blocking changes with the instructor, revise the relevant part(s) of the Scope, and re-review only if a substantial revision invalidates the preview. Record remaining advisory risks for downstream stages. Then obtain instructor approval and freeze the agreed scope.

A successful preview is **not** evidence that later section construction, slide organization, or actual timing will succeed. Accept execution backpressure later from Section Design or Slide-Level Organization and revise Scope-level decisions when warranted, rather than requiring downstream skills to work around them silently.

Treat the agreed scope as the source of truth for downstream lecture-drafting skills.

## Material-ledger implications

Consult `Lectures/material_ledger.md` throughout scope development, but do not silently rewrite the ledger while alternatives are still being explored.

After the instructor agrees to the scope:

- identify the curriculum-boundary changes implied by the agreed scope;
- identify sections expected to become `Covered`, `Deferred`, or `Skipped`;
- distinguish primary `Lecture`, `Notebook`, and definite `Recording` coverage;
- record mere mentions only as comments, not as coverage;
- do not treat `Recording candidate` as recording coverage until the instructor makes that decision and the recording is part of the course plan.

Updating the canonical ledger is a separate bookkeeping action. If the current task includes that action, update it only after scope agreement; otherwise state the proposed ledger changes succinctly for later use.

# Cross-lecture coherence

At every stage, preserve course-level uniformity where it helps students build cumulative understanding.

Check for consistency in:

- terminology;
- notation;
- mathematical treatment depth;
- pacing and density;
- section size and rhythm;
- use of review versus new material;
- expectations about what lives in lecture versus notebook versus recording;
- use of transitions and summaries;
- intellectual progression from one lecture to the next.

Uniformity is not an end in itself. Break a prior pattern when there is a clear pedagogical reason, but make the departure deliberate rather than accidental.

# Completion criteria

The skill is complete when:

- the actual starting boundary has been established from current course artifacts;
- instructor goals and priorities have been incorporated;
- multiple plausible routes were considered unless the instructor explicitly fixed the route;
- the selected route was evaluated against coherence, endpoint, book progression, time, prerequisites, notebook integration, and prior-lecture alignment;
- the intellectual arc has been agreed;
- the mathematical spine has been agreed, including treatment depth and any recording status;
- the notebook handoff has been agreed;
- the concrete examples have been agreed;
- the final lecture contract accurately summarizes the agreed scope;
- the assembled Lecture Scope contains no premature slide or notebook drafting;
- a lightweight Section Design feasibility preview has been performed or explicitly waived by the instructor, with blocking Scope-level issues resolved and advisory risks recorded;
- scope-stage timing has been labeled honestly as estimated rather than validated unless actual timing evidence exists;
- likely later timing-validation points and any `Recording candidate` decisions are visible to downstream drafting;
- material-ledger implications are clear enough to update separately.
