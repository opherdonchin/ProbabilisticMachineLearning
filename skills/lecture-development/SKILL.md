---
name: lecture-development
description: Coordinate end-to-end lecture development through specialized Scope, Section Design, Slide Organization, Slide Design, and Slide Authoring skills, with instructor-facing decisions, delegation, reviews, and shared state.
---

# Coordinate lecture development

Use this skill for a **multi-stage lecture-development request** or when resuming a lecture across stages. It is the instructor-facing orchestration layer, not an extra specialist that decides the lecture content.

Read `../shared/backpressure.md` for the common mode, review-result, and escalation contracts. Before delegating any stage, read enough of its `SKILL.md` to identify its inputs, outputs, authority, and completion gate. Do not load the whole production stack unnecessarily.

## Workflow and authorities

| Stage | Skill | Owned outcome |
| --- | --- | --- |
| 1. Lecture Scope | `../lecture-scope/SKILL.md` | Intellectual destination, mathematical spine/depth, empirical commitments, notebook handoff, live-time envelope |
| 2. Section Design | `../section-design/SKILL.md` | Forward sequence of intellectual jobs and section contracts |
| 3. Slide-Level Organization | `../slide-level-organization/SKILL.md` | Titles, ordering, granularity of teaching moves within each section |
| 4. Slide Design | `../slide-design/SKILL.md` | Approved student-visible content and design specification |
| 5. Slide Authoring | `../slide-authoring/SKILL.md` | Faithful Typst/Touying implementation and validated output |

The latter two skills may be on an unmerged development branch; confirm file availability before assigning them. Existing notebook-building skills can be coordinated after the lecture's notebook handoff is agreed, but do not implicitly fold notebook implementation into slide authoring.

**Instructor** owns consequential pedagogical decisions and final acceptance. **Each specialist** owns its technical/pedagogical analysis at its level. **Coordinator** owns continuity, task routing, review scheduling, decision presentation, and approval state—not the specialist's intellectual decisions.

## Starting or resuming

1. Identify the lecture, request, current stage, authoritative branch/files, prior approvals, and current instructor constraints. Inspect current course artifacts and the live repository rather than trusting stale summaries.
2. Check whether an approved upstream artifact already exists. Resume at the earliest stage with a genuine unresolved problem; do not repeat completed planning merely to rerun the workflow.
3. Maintain a small **live workflow register** (in the conversation, or a lecture-local `development_state.md` if a durable cross-session handoff is needed). Include only:
   - current stage and exact artifact path/revision;
   - accepted decisions and the instructor's unresolved questions;
   - review verdicts with reviewed versions and outstanding blockers;
   - affected downstream artifacts that must be revalidated after an upstream change;
   - next action/owner and approval status.
4. The register is an index and status record, **not** a competing source of truth for Scope, section contracts, slide organization, design, or implementation. Avoid duplicate prose and historical logs; remove temporary workflow files when no longer operationally useful.

If an artifact's revision changes, treat approvals and reviews tied to its earlier substantive content as potentially stale; invalidate **only affected** downstream work.

## Dispatching work to specialists

Give the specialist a bounded task envelope:
- `stage` and `mode: build | feasibility-review | revision`;
- lecture, branch, target artifact path and version;
- authoritative upstream input artifacts and applicable constraints;
- exact task scope (whole lecture, one section, or explicit slide allowlist);
- specific issues to test or repair, if relevant;
- decisions reserved for the instructor and required report format.

**Prefer isolated specialist agents or subagents when the environment provides explicit delegation.** Give each agent the relevant skill and inputs. Independent feasibility reviews are especially valuable because the reviewer should not simply defend the builder's choices.

A skill reference alone does **not** launch an agent or load instructions. Use actual available delegation facilities; do not claim to have spawned agents without doing so. If none are available, run the stages serially in the existing context: explicitly load the relevant skill, switch modes, preserve artifact boundaries, and disclose that review was a same-agent feasibility check rather than independent validation.

Do not start multiple agents editing the same artifact concurrently. Delegate analysis in parallel only if the outputs are nonconflicting; integrate changes through the artifact's owning stage.

## Coordinator interaction with the instructor

Provide **one continuous human-facing discussion** across stages. Specialists return questions, evidence, proposals, alternatives, and uncertainties to the coordinator. Present them faithfully, distinguishing specialist conclusions from the coordinator's process recommendations.

- Surface choices about emphasis, endpoint, mathematics depth, real-data applications, recording decisions, substantial time allocations, coverage/deferral, and other consequential judgments.
- Present the smallest meaningful set of alternatives and tradeoffs; ask a focused question. The coordinator may synthesize explanations but must not silently answer the instructor's decision.
- Handle routing, source/version lookup, routine bookkeeping, and uncontroversial corrections without interrupting the instructor.
- If a specialist is operating standalone rather than under coordination, it may work directly with the instructor using its existing protocol.

Instructor approval must be **explicit or already documented**. Silence, a favorable automated review, or a specialist's self-declared completion is not approval.

## Normal build and review cycle

For each stage:

1. **Build:** delegate the specialist's normal design/authoring workflow, with selective checkpoints for consequential human decisions. A specialist may pause at a real decision and return it rather than guessing.
2. **Feasibility review:** once a provisional artifact is coherent enough to test, ask the **immediately downstream specialist** to review it in `feasibility-review` mode, without producing that specialist's actual artifact. Normally once per stage before instructor approval; skip or defer explicitly if the next-stage skill is unavailable or the instructor elects not to review.
3. **Adjudicate:** classify findings by severity and owning stage. Ask the original specialist to respond to technically substantive objections and propose a minimal repair. Consult the instructor if the repair changes a pedagogical commitment. Re-review only after a material change.
4. **Approve and hand off:** record accepted artifact/version, residual advisory risks, and the exact next-stage input. Advance only after necessary instructor approval.
5. **Execution feedback:** later construction can reveal new structural problems despite a successful preview. Route them to the **nearest owning upstream stage**, commission targeted revision, and revalidate affected downstream artifacts.

For Slide Authoring there is no mandatory sixth pedagogical preview. Its own mechanical and visual validation is the build gate; a separate targeted implementation review may be requested when useful. For a brand-new lecture request, Lecture Scope can first test a proposed lecture brief against current curriculum and time constraints using its own `feasibility-review` mode, but the normal preview of Scope itself is performed by Section Design.

## Resolving disagreement and stopping loops

Require each review item to specify evidence, issue owner/severity, smallest repair, and the impact on accepted work. The coordinator should not simply forward contradictory reviews as unexplained instructions.

If builder and reviewer disagree:
1. ask the artifact owner for a short, evidence-based response;
2. decide whether there is an objective error, an alternative that can remain advisory, or a pedagogical tradeoff requiring the instructor;
3. request one targeted review of the repair if the conflict is substantive.

Limit routine preview loops to one pass plus a targeted recheck when substantial changes justify it. Do not claim global convergence merely because each specialist independently reports success. Escalate unresolved, repeated, or cross-stage conflicts to the instructor with concrete alternatives rather than recursing indefinitely.

## Stage transitions and completion

Require the owning skill's actual completion gate, the appropriate preview/revision disposition, and documented instructor acceptance before promoting an artifact. Distinguish **approved Section Design** from **downstream-validated Section Design**; actual slide organization may still trigger revisions.

At whole-lecture completion report:
- accepted Scope, Section Design, slide organization, design, and production artifacts (or stages intentionally excluded);
- delivered slides/notebooks/recordings and validation evidence;
- unresolved advisory risks and outstanding human decisions;
- any downstream artifacts requiring regeneration because of a changed upstream contract.

Do not represent a feasible preview as a successful implementation test. Do not merge branches, publish course material, or schedule delivery without authorization.

**The coordinator maintains one coherent conversation and reviewable sequence of decisions; specialists maintain the quality of their own artifacts.**
