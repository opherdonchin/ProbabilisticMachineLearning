---
name: section-design
description: Construct a lecture's sequence of coherent intellectual sections from an agreed Lecture Scope, with evolving student-state tracking, selective instructor decisions, periodic global checks, and explicit upstream/downstream backpressure.
---

# Design the lecture sections

Follow the [repository writing requirements](../../../AGENTS.md#writing-for-the-instructor-and-students) for every instructor-facing explanation and review. Explain unfamiliar ideas and the consequences of a choice before using specialist names; do not assume the instructor knows material beyond L03–L04. Keep exact mathematical and source checks available after the readable explanation.

Use this skill after Lecture Scope has identified the lecture's destination, route, mathematical spine, examples, notebook handoff, and time budget, but before deciding slide titles or order.

**Design sections as successive intellectual moves, not as an optimal partition of textbook pages.** The governing question is: *Given what students can now understand, what is the most valuable next move toward the agreed lecture endpoint?*

The section sequence is constructed forward with a visible global horizon. Section contracts are provisionally settled one at a time, checked against the remaining lecture, and revisable for named reasons. Do not confuse sequential design with irreversible greedy decisions.

## Operating modes and interaction

Use `build` (default), `feasibility-review`, or `revision`; follow `../shared/backpressure.md`. The sequential construction procedure below applies only to **Build**.

- **Build:** construct one intellectual section after another from the evolving student state; involve the instructor selectively; maintain contracts, global checks, and controlled backtracking. If coordinated, return consequential pedagogical questions to the coordinator (`../lecture-development/SKILL.md`) to present to the instructor.
- **Feasibility Review:** receive a **provisional five-part Lecture Scope**, examine whether its route, prerequisites, mathematics depths, applications, notebook handoff, and time budget appear workable as a sequence. Report a verdict, evidence, risks, and minimum Scope-level repairs, while explicitly distinguishing questions Section Design can settle later. Do **not** create section contracts or mutate the Scope. This is the preview review described below.
- **Revision:** receive a previously approved section contract and specific execution backpressure (usually from Slide-Level Organization), plus any instructor decision. Diagnose ownership, recommend the **smallest** change in boundaries, dependencies, treatment allocation, or modularity; apply only approved consequential changes, then update affected neighboring contracts and carried-forward student state. Escalate genuine lecture-level changes to Scope; do not alter Scope unilaterally or draft slide sequences.

In coordinated work the coordinator schedules reviews and mediates instructor decisions; standalone Section Design may request review and consult the instructor directly.

## Responsibilities and boundaries

Own:
- section boundaries and order, each section's single intellectual responsibility, entry state, endpoint, and carry-forward;
- allocation of agreed scope material, mathematical treatment depth, examples, figures, source support, and live time to sections;
- modular boundaries for substantial derivations, standalone empirical applications, and potentially removable or recorded material;
- the section contract passed to Slide-Level Organization.

Do **not** decide slide titles, slide order, exact slide count, reveals, composition, typography, figure implementation, or notebook code. A short anticipated *next intellectual move* is allowed; it is not a slide plan.

Lecture Scope owns the destination, scope-level mathematical treatment and coverage obligations. Slide-Level Organization owns the sequence and granularity of teaching moves **within** an agreed section. If those decisions appear infeasible, return explicit backpressure; do not silently change upstream decisions.

Read `../shared/backpressure.md` for severity, ownership, and revision rules. Follow it for both preliminary feasibility reviews and problems discovered during actual section construction.

## Sources and authority

Read the current agreed Lecture Scope, including its five parts, and any explicit current instructor decisions. Inspect the actual preceding lecture and notebook where they clarify the student starting state, relevant Book 2/Book 1 sections, the material ledger, and the course timing-calibration reference where extent is uncertain.

Use `Lectures/L02_Exponential_Families/section_design.md` as an example **output contract**, not as a template for the sequence of intellectual moves in another lecture. Read `../slide-level-organization/SKILL.md` to understand what the downstream stage needs.

If the Scope is absent, internally inconsistent, or provisional in a way that changes section structure, clarify or send backpressure rather than inventing a new lecture-level scope. Source order is evidence about the material, not an instruction to preserve its sequence.

## Specificity, source verification, and stage boundary

The Section Design contract must be **specific enough for Slide-Level Organization to proceed without inventing mathematical coverage**, while leaving that stage free to decide the ordered teaching moves. Neither a topic label alone nor a script of individual slides is an acceptable substitute.

Use this three-level test:

- **Too vague:** "Apply d-separation to a nontrivial DAG." This leaves the worked case, prerequisite and source verification to the next stage.
- **Appropriate section contract:** "Work a multiple-path d-separation query, including a collider descendant, on a named and source-verified graph; derive the directed Markov blanket for a specified node."
- **Too prescriptive:** prescribe the exact classroom questions, sequence of traversed paths, click order, or wording for each presentation beat. That belongs to Slide-Level Organization and Slide Design.

For each **required** example or worked calculation, state (a) the distinct teaching job, (b) the relevant source or explicitly **course-constructed** provenance, (c) the specific mathematical result or capability it demonstrates, and (d) treatment depth. Name required figures/equations only when selection matters pedagogically; secondary visual candidates may remain provisional.

**Verify before committing an exact example claim.** Inspect the relevant Murphy page/figure/equation or authoritative artifact—not merely a citation from an earlier plan—and check node labels, edges, conditioning sets, graphical conclusions, formulas, cardinalities, numerical values, and attribution as applicable. A reference to "Murphy Fig. N" is not evidence that a newly invented teaching calculation appears in that figure. Label course-selected queries and derived numerical examples honestly. If the source cannot be inspected, record the example as *unverified/provisional* and do not turn its exact content into an approved obligation.

Keep a compact, actionable contract: list the required mathematical objects and the **extent of their treatment**, not every intermediate derivation step, student question, reveal, or layout. Escalate material source conflicts rather than making an apparently concrete but unsupported plan.

## Section closure invariant

Every section's **last teaching move** is a retrospective summary of results established **in that section**. The take-home must stand alone; it must not introduce an untaught result, tease what comes next, pose a next-section question, promise reuse, or hand off to the following section. If a connection is pedagogically necessary, place it at the **beginning of the receiving section**. Author-facing prerequisite/boundary notes may name other sections, but they are not permission to make forward-looking closing slides. Keep notebook task instructions in the separate lecture-level notebook handoff; they must not replace the final section summary.

## Feasibility-review procedure: backpressure to Lecture Scope

When invoked by the **coordinator**, or directly by a standalone Scope Builder, **before scope approval**, perform a lightweight feasibility review, not full Section Design.

Check whether a plausible sequence of intellectual moves can:
- start from what students actually know and reach the defined endpoint;
- establish prerequisite results before their use, at the specified mathematical depth;
- fit required examples, derivations, notebook prerequisites, and live time;
- respect source support, omissions, recording decisions, and essential module boundaries.

Use a rough dependency/route sketch if necessary, **without producing section titles, a final partition, or slide moves**. Report only material concerns and their owners. Distinguish a genuine Scope conflict from a choice Section Design can make later. Return a short verdict: `feasible`, `feasible with advisory risks`, or `blocked`; for each issue give evidence, minimum repair, and impact. An absence of identified blockers is not a guarantee that later Section Design will succeed.

## Build mode: sequential construction

### 1. Establish the global horizon

Before proposing the first section, record a compact evolving state:

- **Starting student state:** already usable concepts, notation, mathematical results, empirical intuitions, and operations, not merely topics previously mentioned.
- **Destination:** the agreed lecture endpoint and notebook handoff.
- **Critical path:** mathematical and conceptual dependencies required to reach the destination.
- **Remaining obligations:** must-cover and optional content, source treatment, required empirical applications, exclusions/deferrals, and delivery modes.
- **Flexibility:** recording candidates, independent modules, and material allowed to be compressed or dropped.
- **Budget:** available live time and realistic reserve for essential later moves.

A coarse milestone map is permitted. Do not lock a complete section partition at this stage. `Recording candidate` material remains in the live-time budget until explicitly moved to a recording.

### 2. Determine the next intellectual move

From the current student state, consider what **one new understanding** best advances toward the next milestone and final endpoint.

Candidate jobs include: introduce a representation, establish a load-bearing result, interpret a result, apply it to real data, generalize a model, or prepare a necessary later dependency.

Test the candidate:
1. Can students enter it with what they currently know?
2. Does it answer one coherent question and produce an identifiable new capability?
3. Why is it needed **now**, given the lecture's later destination?
4. Does it consume material or time better reserved for a later move?
5. Does the intended treatment match the agreed mathematical spine and sources?
6. Would independent treatment improve modularity, pacing, removability, or empirical interpretation?
7. Is the expected live cost justified?
8. Can the required mathematics and a specific, checkable example be named without specifying slide-by-slide pedagogy?

Evaluate serious alternatives only if the tradeoff changes emphasis, treatment depth, order, extent, an empirical application, recording/removability, or future dependencies. Do not manufacture choices for routine bookkeeping.

A useful single-job test: **Can the entire section be stated as one question whose answer develops continuously from entry to endpoint?** Being adjacent in Murphy, or simply relating to the same topic, does not satisfy this test.

### 3. Make the consequential decision with the instructor

Normally present **one next section** in compact form:

- proposed intellectual move and why it comes next;
- entry state and section endpoint;
- assigned key material with treatment depths and source support;
- boundary (especially what belongs later);
- approximate live time and the likely next dependency;
- a meaningful alternative or unresolved tradeoff, only if needed.

Ask for instructor judgment when alternatives change pedagogical value, theoretical emphasis, example role, mathematical depth, recording status, substantial time use, or a consequential omission. Handle obvious source references, prerequisite bookkeeping, and equivalent wording independently.

Do not flood the instructor with approval requests for trivial details. If the instructor asks for a complete provisional design in one pass, construct it forward internally while keeping consequential choices and uncertainties visible; do not present it as approved. If working collaboratively section by section, do not silently continue past a consequential unresolved decision.

### 4. Commit provisionally and carry state forward

A section is sufficiently settled to continue when its purpose, entry condition, endpoint, core material, load-bearing treatment depth, boundaries, and rough extent are stable.

Update the evolving state after **each provisionally accepted section**:
- capabilities now available to students;
- material and prerequisites still unmet;
- time spent and time remaining;
- notebook prerequisites now available;
- structural uncertainties, dependencies, and recording/defer candidates.

The following can stay provisional: exact title wording, secondary examples, figure choice, take-home phrasing, and supplementary references. Do **not** hide unresolved structural choices that might change boundaries.

Persist a compact section contract while the decisions are fresh. The file records agreed reasoning; filling out its fields is not itself the design procedure.

### 5. Check the whole argument without replacing forward construction

After every section, perform a quick (usually internal) check: endpoint still reachable, time remains plausible, no dependency stranded, no duplicated material, no notebook prerequisite lost.

After a major transition or roughly every 2–3 sections, perform a stronger review:
- read the section purposes and endpoints in order as one argument;
- compare remaining must-cover work against remaining time;
- inspect mathematical depth and prerequisite order;
- verify the distinct jobs of empirical applications and the notebook handoff;
- reconsider recording/defer options and modularity;
- identify any locally reasonable move that has created a global detour.

Show only consequential global issues to the instructor.

### 6. Backtrack only for a named structural reason

Previously accepted sections are stable but not immune to revision. Reopen them when a later discovery identifies:
- **responsibility conflict:** two different intellectual questions in one section;
- **dependency/endpoint conflict:** something essential is absent, late, or unreachable;
- **trajectory/extent conflict:** the sequence cannot reach the endpoint in time;
- **modularity conflict:** substantial removable material is entangled with required work;
- **application conflict:** an empirical example requires a distinct intellectual job;
- **source/method conflict:** title, purpose, mathematics, or source support disagree.

State what exposed the problem, the smallest upstream repair, and the effect on neighboring sections. Obtain instructor approval for consequential changes. Do not reopen earlier work for purely cosmetic improvements.

Concrete L02 lessons: MLE and maximum entropy warranted different responsibilities; a Gaussian derivation warranted a removable module; a rainfall data fit warranted an independent application section. Compressing two slides on categorical counts, by contrast, belonged to Slide-Level Organization.

### 7. Test the complete construction

Before seeking approval, verify:

- **Argument:** section purposes/endpoints read as a coherent forward progression.
- **Reachability:** each entry relies only on established or explicitly assigned prerequisites.
- **Single job:** every section answers a clear intellectual question.
- **Coverage:** each required Scope item has a home or an explicit approved defer/record/omit disposition.
- **Mathematical fidelity:** agreed treatment depth and sources remain intact.
- **Notebook:** every required conceptual prerequisite is available at handoff.
- **Extent:** live time remains credible; recording candidates still count as live.
- **Modularity:** optional or recorded blocks can be removed without breaking required reasoning, where feasible.
- **Examples:** empirical applications have teaching jobs and interpretations, not decorative roles.
- **Continuity:** notation, pacing, and depth align with the actual preceding lectures.
- **Specificity:** required mathematical work and examples have verified sources/clear provenance, distinct jobs, and treatment depth; placeholders are not silently passed downstream.
- **Stage boundary:** the contract does not prescribe individual slides or a step-by-step classroom script.
- **Closure:** every take-home is backward-looking, with the summary as the section's final teaching move.

The instructor, not the agent, accepts the design.

## Persistent output: section_design.md

Write the file in the lecture directory and keep it short enough to serve as an operational handoff. Use the L02 example for style. Begin with:

- lecture-level trajectory, start state, endpoint, live-time target;
- global exclusions, recording candidates, and notebook handoff;
- any unresolved structure-level risks.

For **each section**, include:
1. title / identity and status;
2. purpose / intellectual role;
3. entry condition / transition in;
4. endpoint (what students now understand or can do);
5. assigned content and precise, verified sources (flag any unverified item as provisional);
6. mathematical treatment constraints (reuse Scope labels such as `State`, `Motivate`, `Derive`, `Work`, `Apply`);
7. prerequisites / carry-forward and dependencies;
8. empirical application or figure requirements, if relevant;
9. boundary / exclusions and recording status, if relevant;
10. approximate extent;
11. retrospective take-home claim that ends the section without a next-section handoff.

Document only fields with real content; do not use filler to complete a template. Preserve significant open issues, but leave rejected alternatives to chat/Git history.

## Two completion states and downstream validation

**Approved Section Design:** the instructor accepts the coherent complete section sequence and its contracts. It is ready for Slide-Level Organization. This stage does **not** require the slide sequence to have been produced.

**Validated Section Design:** one or more actual slide-organization attempts have tested the contracts, and any substantive upstream backpressure has been resolved. A complete slide-organization pass may expose additional concerns. Approval and downstream validation must not be conflated.

For each section, pass its contract to `../slide-level-organization/SKILL.md` **one section at a time**. That skill chooses slide titles, order, teaching-move granularity, and slide extent. It may return a structural issue. Triage using the shared backpressure protocol: revise Section Design for intellectual-responsibility, dependency, or modularity failures; let Slide-Level Organization solve slide granularity, summary placement, or layout-neutral compression. Escalate to Lecture Scope only if lecture-level commitments must change.

## General principle

**Maintain the global destination; construct forward from students' evolving intellectual state; settle one coherent move at a time; periodically test the whole route; allow justified backtracking.**
