# Backpressure between lecture-design stages

Use this protocol in Lecture Scope, Section Design, Slide-Level Organization, and subsequent design/implementation stages. The goal is to test upstream commitments without silently taking ownership of upstream decisions.

## Three explicit specialist modes

Every specialist skill supports these externally selectable modes; when an agent is delegated a task, the coordinator specifies the mode.

- **`build`:** perform the skill's normal construction or implementation process. It may discover execution backpressure and may pause at instructor-owned choices. Persist only the artifact belonging to this stage.
- **`feasibility-review`:** inspect the **provisional output of the immediately upstream stage** and test whether the specialist's work seems achievable. Do **not** perform the build, produce the downstream artifact, revise upstream files, or demand settled downstream details. The reviewer should be prepared to report "feasible with uncertainties." For Lecture Scope (no preceding lecture-design specialist), the optional review target is an instructor's proposed lecture brief checked against actual prior course state, sources, and available time.
- **`revision`:** update **only the owning stage's** existing artifact in response to a specific approved issue or changed upstream decision. Preserve unaffected decisions; report changed contracts, dependent artifacts, and validation needed.

A reviewer returns its assessment; it does not grant instructor approval. Missing essential evidence is an uncertainty or blocker, not license to complete another stage's work. A claimed exact graph, theorem statement, figure, formula, or numerical result must be checked against the relevant source or explicitly marked unverified; apparent precision is not proof of provenance.

## Specialist handoff and review result

Every delegated task receives stage/mode, target artifact + version, upstream artifacts + versions, bounded scope, constraints, and any focused review question. Response formats can be compact prose, but should make the following recoverable:

- **Build:** artifact produced or proposed, its status/validation, unresolved specialist issues, and instructor decisions needed.
- **Feasibility review:** target + revision checked; verdict `feasible`, `feasible-with-risks`, or `blocked`; confidence/limitations; issues with owner, severity, evidence, smallest proposed repair, and effect. Report `no material concerns found` when appropriate. Do not generate the downstream design.
- **Revision:** trigger and approval, exact changes, unaffected constraints preserved, impacts on dependent work, validation and remaining concerns.

When coordinated, route the response to the **Lecture Development Coordinator** (`../lecture-development/SKILL.md`) for instructor interaction and issue arbitration. In standalone work, the specialist may communicate with the instructor directly.

## Two kinds of backpressure

**Preview feasibility review:** An upstream stage asks the immediately downstream skill to inspect a **provisional** artifact before approval. The reviewer checks whether its own work seems constructible, without performing that work or treating the review as proof of feasibility. For example, Section Design reviews a provisional Lecture Scope without producing section contracts.

**Execution backpressure:** While performing its own stage, a downstream skill discovers that an approved upstream artifact cannot be used coherently as written. Such findings are stronger evidence than a preview. Escalate them even if the earlier preview passed.

## Decision ownership

- **Lecture Scope** owns the lecture purpose and endpoint, covered/deferred material, mathematical spine and depth, notebook handoff, examples promised, lecture-wide delivery status, and live-time envelope.
- **Section Design** owns the successive intellectual responsibilities, their boundaries, prerequisites, endpoints, source allocation, modularity, and section-level time distribution within the Scope.
- **Slide-Level Organization** owns slide teaching moves, title/order, teaching-move granularity, summaries, and slide-count proposals within an approved section.
- **Slide Design** (`.agents/skills/slide-design/SKILL.md`, when available) owns the student-visible explanation: mathematical/prose content, visual objects, semantic hierarchy, comparisons, and reveals, without dictating exact production geometry.
- **Slide Authoring** (`.agents/skills/slide-authoring/SKILL.md`, when available) owns the faithful Typst/Touying production implementation, asset integration, exact geometry, and validation. These stages can report upstream contradictions but must not quietly rewrite approved teaching decisions.

Route an issue to the **nearest stage that actually owns the decision**. Do not send every difficulty all the way to Lecture Scope. An upstream stage may change its own artifact after a valid challenge, but downstream reviewers cannot unilaterally amend it.

## Compact issue format

For each meaningful issue, specify:
1. **Owner and severity:** `blocking` (cannot proceed within commitments), `advisory` (risk or worthwhile alternative), or `downstream-owned` (can be solved locally).
2. **Evidence/constraint:** what cannot be done as specified, with the actual dependency, mathematical, source, or extent reason; not just a vague discomfort.
3. **Provisional treatment:** how work can continue without pretending an unapproved change is settled; state when no safe provisional treatment exists.
4. **Smallest proposed repair:** what the owning stage should change.
5. **Consequences:** which later contracts, timing, or teaching moves would change; what instructor decision is needed.

A reviewer may offer a compact verdict with no issues when the artifact appears feasible. Do not invent issues to justify the review.

## Who invokes the review

When using the coordinator, **the coordinator**, not the building specialist, dispatches feasibility reviews and arranges instructor consultation. The builder signals that its provisional artifact is ready for review and responds to substantive reviewer findings. Without a coordinator, a specialist may invoke or request the next-stage review itself as described in the individual skills.

A feasibility review is not the same as a second full build and need not be produced by a separate agent if delegation is unavailable; disclose whether it was independent or a same-context check.

## Bounded review and revision

- During Scope Building, normally obtain **one** Section Design feasibility preview after the full provisional Scope is assembled, before final instructor approval; the coordinator arranges it when active.
- Resolve blocking Scope issues, document advisory risks, and leave Section Design-owned details downstream. Re-review only after a substantive change that invalidates the previous assessment; do not recurse indefinitely.
- During actual construction, run local checks and send specific execution backpressure as soon as it matters. It is not necessary to finish an infeasible artifact merely to report the blocker.
- For nonblocking uncertainty, complete a clearly labeled provisional result when helpful, while preserving the upstream contract and recording the proposed change.
- Obtain instructor approval when repairs change emphasis, endpoint, mathematical depth, substantive coverage, examples, delivery status, or substantial teaching time.
- After an approved repair, update the **owning** artifact and only the affected downstream material. Preserve unaffected decisions.

**Escalate explicitly; revise at the correct level; rerun only the affected check.** Never treat a preview as final validation or make every stage redo all previous stages. Preserve instructor-approved stylistic invariants (including retrospective section endings) across every handoff, even when a later stage offers a convenient alternate structure.
