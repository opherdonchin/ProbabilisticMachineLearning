# Backpressure between lecture-design stages

Use this protocol in Lecture Scope, Section Design, Slide-Level Organization, and subsequent design/implementation stages. The goal is to test upstream commitments without silently taking ownership of upstream decisions.

## Two kinds of backpressure

**Preview feasibility review:** An upstream stage asks the immediately downstream skill to inspect a **provisional** artifact before approval. The reviewer checks whether its own work seems constructible, without performing that work or treating the review as proof of feasibility. For example, Section Design reviews a provisional Lecture Scope without producing section contracts.

**Execution backpressure:** While performing its own stage, a downstream skill discovers that an approved upstream artifact cannot be used coherently as written. Such findings are stronger evidence than a preview. Escalate them even if the earlier preview passed.

## Decision ownership

- **Lecture Scope** owns the lecture purpose and endpoint, covered/deferred material, mathematical spine and depth, notebook handoff, examples promised, lecture-wide delivery status, and live-time envelope.
- **Section Design** owns the successive intellectual responsibilities, their boundaries, prerequisites, endpoints, source allocation, modularity, and section-level time distribution within the Scope.
- **Slide-Level Organization** owns slide teaching moves, title/order, teaching-move granularity, summaries, and slide-count proposals within an approved section.
- **Slide Design** (`skills/slide-design/SKILL.md`, when available) owns the student-visible explanation: mathematical/prose content, visual objects, semantic hierarchy, comparisons, and reveals, without dictating exact production geometry.
- **Slide Authoring** (`skills/slide-authoring/SKILL.md`, when available) owns the faithful Typst/Touying production implementation, asset integration, exact geometry, and validation. These stages can report upstream contradictions but must not quietly rewrite approved teaching decisions.

Route an issue to the **nearest stage that actually owns the decision**. Do not send every difficulty all the way to Lecture Scope. An upstream stage may change its own artifact after a valid challenge, but downstream reviewers cannot unilaterally amend it.

## Compact issue format

For each meaningful issue, specify:
1. **Owner and severity:** `blocking` (cannot proceed within commitments), `advisory` (risk or worthwhile alternative), or `downstream-owned` (can be solved locally).
2. **Evidence/constraint:** what cannot be done as specified, with the actual dependency, mathematical, source, or extent reason; not just a vague discomfort.
3. **Provisional treatment:** how work can continue without pretending an unapproved change is settled; state when no safe provisional treatment exists.
4. **Smallest proposed repair:** what the owning stage should change.
5. **Consequences:** which later contracts, timing, or teaching moves would change; what instructor decision is needed.

A reviewer may offer a compact verdict with no issues when the artifact appears feasible. Do not invent issues to justify the review.

## Bounded review and revision

- During Scope Building, normally request **one** Section Design feasibility preview after the full provisional Scope is assembled, before final instructor approval.
- Resolve blocking Scope issues, document advisory risks, and leave Section Design-owned details downstream. Re-review only after a substantive change that invalidates the previous assessment; do not recurse indefinitely.
- During actual construction, run local checks and send specific execution backpressure as soon as it matters. It is not necessary to finish an infeasible artifact merely to report the blocker.
- For nonblocking uncertainty, complete a clearly labeled provisional result when helpful, while preserving the upstream contract and recording the proposed change.
- Obtain instructor approval when repairs change emphasis, endpoint, mathematical depth, substantive coverage, examples, delivery status, or substantial teaching time.
- After an approved repair, update the **owning** artifact and only the affected downstream material. Preserve unaffected decisions.

**Escalate explicitly; revise at the correct level; rerun only the affected check.** Never treat a preview as final validation or make every stage redo all previous stages.
