# Start lecture re-scoping and alignment — L01 onward

**Working branch:** `rescope-l01-l12-architecture-alignment-20261014`
**Architecture baseline:** PR #16 merge `730b5cbde055cc166f48f1a73dc63df190e6187b` into `scope-l03-l12-course-architecture`. This branch continues the prior L04-scoping kickoff but supersedes its instruction to start at L04.
**First task:** L01 scope reconciliation; then L02 and L03, then L04–L12. **Do not edit or merge `main`**; do not merge this branch without explicit instructor authorization.
**Instructor direction (2026-10-14):** Substantial changes in the course goals justify *re-scoping L01, L02 and L03* against their existing decisions, designs and slides. Those artifacts and the new architecture may all be questioned and improved. L04 onward may begin scope authoring from the updated course architecture, while checking the prerequisites actually established by L01–L03.

## Two distinct workstreams

### A. L01–L03: reciprocal alignment, not a clean-sheet restart

Begin from **all existing artifacts, prior approvals and working examples**. Compare their educational purpose, mathematical argument, substantive examples and one-hour notebook outcome with `course_architecture.typ` and `curriculum_map.typ`. Identify where:
- the architecture explains and strengthens existing material;
- a modest scope, design or slide change would improve consistency and practical competence;
- an existing derivation, application, explanation or transition is worth preserving even though the architecture does not yet adequately accommodate it;
- a substantive conflict requires the instructor to choose or **revise the architecture**;
- the apparent conflict is merely terminology, documentation drift or an artifact that was only proposed.

Do **not** assume either “the architecture wins” or “the old lecture wins.” Develop the strongest justified course as a whole, minimizing unnecessary rework. Prior agreement is historical evidence and a reason to preserve strong work, *not* a veto on the instructor's newly authorized reconsideration. Conversely, a new architecture paragraph is not by itself approval to discard well-developed material. State both the mathematical and practical cost of important changes.

Carry an explicit **two-way reconciliation matrix** for each lecture: existing component and status; intended educational job; fit/tension with architecture; recommended keep/reframe/modify/replace/defer; effects on other lectures; instructor decision required; downstream assets affected. Use this as an inspection artifact, not a second authoritative syllabus.

**Stages:** First diagnose the scope and obtain instructor decisions; produce an agreed five-part Lecture Scope; preview feasibility via Section Design review. Then revisit Section Design, Slide-Level Organization, Slide Design, Slide Authoring and the notebook handoff in their proper order, *reusing approved or strong existing material* wherever appropriate. Do not reflexively recreate all slides. Existing decks/designs are reviewable evidence during scope development, but an old slide is not a constraint that forces the revised scope. If downstream construction uncovers a conceptual problem, return backpressure to Scope or Architecture instead of patching symptoms into slides.

Review the three lecture scopes together for shared prerequisites and coverage so L01 changes do not create avoidable L02/L03 contradictions. Scope discussions can be sequential, but check the L01–L03 joint trajectory before freezing each scope. After the early scopes stabilize, downstream drafting can proceed in parallel with later scope reviews if ownership and dependencies are explicit.

### B. L04–L12: architecture-led new/revised scope authoring

Start with the current course architecture, planned curriculum map, Murphy and the **reviewed prerequisites left by L01–L03**. Existing L04–L12 scope proposals, source reviews and earlier instructor choices are evidence, not an automatic finished scope or permission to revise historically agreed details silently. Follow the normal iterative Lecture Scope procedure with source-arc reconstruction, alternative routes where useful, instructor decisions, Section Design feasibility review, and downstream handoff.

A real future decision remains in L04: previously instructor-selected three-bit parity in lecture and five-bit code in notebook vs a *new, not approved* Iris-based probability scoring/information-preservation notebook proposal. Do not make this the first question of the present kickoff; resolve it when L04 comes up.

## Artifacts and branch reconnaissance (checked at kickoff)

All SHAs below are **content identifiers / historical pointers**, not immutable authority. Inspect live branches and compare commits before editing.

| Lecture | Existing work on the architecture/scoping branches | Other branch evidence requiring inspection |
| --- | --- | --- |
| **L01** | `Lectures/L01_Probability_Statistics/slide_deck.typ` (blob `235b8eeb...`), `lecture_01_coverage_spec.typ` (`c4457bc4...`), prepared slide PDF, author-facing figure notebooks, review reports; `InClass/Solutions/lecture1_missing_data.ipynb` (`ab441941...`) plus worked solution and authoring report. No separate approved five-part Lecture Scope or Section Design is present here. | Current L01 core deck and solved notebook have the same blobs on `main`, `lecture-3-authoring` and the architecture branch. `slide-authoring-refactor` includes an additional `slide_deck_07.typ`; assess provenance if relevant, not automatically adopt. |
| **L02** | `Lectures/L02_Exponential_Families/section_design.md` (`bbf78a13...`), draft `slide_organization.md`, `slide_design.typ`, partial `slide_deck.typ`, `development_state.md` and L02-related notebook/source plans. Agreed scope/design aspects require recovery from prior decisions; do not infer blanket approval from the presence of files. | `l02-section-titles-summaries` has an alternate slide organization; `fix/l02-retrospective-summaries` has divergent section design and slide design. The `lecture-3-authoring` branch contains older L02 section-design/organization versions. Compare arguments, accepted fixes and changes; do not wholesale merge. The current L02 development-state file appears duplicated/corrupted: verify and repair in its owning stage rather than treating repetition as decisions. |
| **L03** | `Lectures/L03_Graphical_Models/lecture_scope.md` (restored instructor-agreed blob `2d5992a3...`) and development-state record. Intended live arc: chain-rule/DAG factorization, directed independence, undirected models and Ising; image-model construction and local restoration reserved for notebook. | `lecture-3-authoring` at commit `8007d42b2871181a6966ab4d55417c10af9b5544` has the original agreed scope (`0656648f...`) and proposed `Lectures/L03_Graphical_Models/section_design.md` (`2cb8c35a...`), **not approved in its entirety**. The previous section-design review identified an incorrect Figure 4.23 path interpretation; verify source before adopting that example. |

Other context: `Lectures/course_architecture_scope/STATUS.md`, `questions_and_hesitations.md`, `reviews/`, `Lectures/syllabus_planning_decisions.md`, `Lectures/L02_Exponential_Families/section_design.md`, the relevant books, the slide-design/authoring skills, and the student-facing solved notebook examples. `curriculum_map_actual.typ` has matching lecture columns and is **blank because no lecture has yet been taught**. Prepared decks are *authored*, not delivered.

## Technical and pedagogical authorities

Read `AGENTS.md`, `.agents/skills/lecture-development/SKILL.md` and its shared-backpressure contract, `.agents/skills/lecture-scope/SKILL.md`, `.agents/skills/section-design/SKILL.md`, and the downstream slide skills *when their stage becomes relevant*. Use timing calibration and inspect Murphy Book 2 (primary) and Book 1 (supplemental). Identify previous instructor agreement and source versions exactly. Use actual delegation when possible; do not call a same-agent check an independent review.

The course's objective is working competence with substantive probabilistic-ML problems and methods, with mathematical coherence giving the student a transferable tool for formulating models, specifying probabilistic queries and performance criteria, selecting computation and evaluating limits. For each lecture determine **both** the new mathematical understanding and the practical technique/learning problem students can actually experience. Distinguish toy mathematical diagnostics from substantive application; aim for an accessible two-hour lecture and one-hour guided, solved-first Q&A notebook. Meaningful, short intellectual actions are preferable to incidental coding burdens.

The architecture, instructor-approved lecture scopes, existing artifacts, and source text have **different roles**. A justified early-lecture disagreement with the architecture should be presented as a concrete amendment proposal with its consequences for the other lectures and prospective map. Do not silently rewrite architecture, syllabus, multiple scopes, or actual coverage.

## Interaction and gatekeeping

### Make instructor-facing claims and decisions distinguishable

**Instructor feedback (2026-10-14):** Across lecture-scoping documents, the instructor could not reliably distinguish description of existing artifacts, critique, highlighted choices and concrete recommendations. This is a communication requirement for subsequent scope work, not a change in mathematical level or teaching commitments.

- Use one primary teaching proposal for the current discussion. The scope is the instructor's reading document; reconciliation matrices, registers and raw reports support it. Do not make the instructor reconstruct the proposal by combining all of them.
- State the recommendation and the exact changes from the actual deck/notebook near the beginning. Distinguish **existing material**, **assessment/critique**, **recommended changes**, and **instructor decisions** with meaningful headings or local labels. Do not silently change a paragraph from one role to another.
- Keep instructor-agreed directions distinct from newly proposed sequences, treatment depths, examples and timing. A previously planned unit is not existing teaching merely because it appears in a coverage specification.
- For each recommended retain/add/reduce/reorder/defer action, identify the current baseline, concrete change, reason and mathematical/practical consequence. Preserve important equations and assumptions in the main explanation; move exact Git identifiers and extended source records to checking material.
- Present each consequential choice with a recommended default, a serious alternative, and what the alternative gains or costs. Describe an added derivation as an addition if the current deck only states its result. Do not create an apparent decision by misdescribing the baseline.
- Separate author-owned correctness repairs and workflow actions from instructor-owned pedagogical choices. State who acts next and what decision gates that action.
- Before handing over a document, have the coordinator check whether the reader can identify what already exists, what is criticized, what is proposed, what is agreed, and precisely what they are being asked to decide. A targeted communication review can help; do not label it mathematical, source-arc or Section Design validation.

1. **Begin with L01.** Inspect the actual existing deck and Gaussian missing-data solved notebook, the L01 coverage specification and review reports, and the current architecture's L01 role. Compare their *intellectual arcs and practical outcomes*, not only section lists.
2. In the first reply, give a concise, balanced diagnosis (strong existing components, possible mismatches, uncertainty) and ask **one genuinely consequential instructor question** about the L01 endpoint/emphasis. Do not propose a full deck rewrite, nor produce ten lecture scopes.
3. Once the instructor responds, iterate Scope's five parts: intellectual arc → mathematical spine → notebook handoff → concrete examples → lecture contract. Obtain stage-appropriate feasibility review and explicit instructor acceptance; record version/provenance in a compact L01 `development_state.md`.
4. Cross-check L02/L03 coverage before freezing L01; then reconcile L02 and L03 against the same standard, preserving approved material unless a reasoned improvement is accepted. Decide explicitly whether an identified conflict should change an early lecture or change the course architecture.
5. For early lectures, use the accepted scope to review existing Section Design → slide organization → slide design → authored slides; identify which units can be reused, selectively revised or replaced. Keep source and rendered PDFs synchronized, inspect render visually, validate notebook mathematics, and do not conflate a source-compilation check with student feasibility.
6. From L04 onward use the usual architecture-led Scope Build process, informed by finalized early prerequisites. Review inter-lecture dependencies before committing neighboring scopes.
7. Update `curriculum_map.typ` when prospective decisions are accepted; keep `curriculum_map_actual.typ` untouched until teaching. Record and explicitly approve proposed architecture changes where they are warranted. Pause at consequential instructor decisions rather than autopiloting through lectures.

## Status and handoff boundary

**L01 decisions during reconciliation (2026-10-14):** retain the current lecture route. Keep the residual conditioning derivation and stated/interpreted quadratic separation live; develop the full block-elimination proof as a separate recording with its own Typst deck. Its content is required and may appear on the exam; viewing is not recorded, evaluated or monitored. Coordinate it through the existing design/authoring skills under the [recorded-session section of lecture-development](../.agents/skills/lecture-development/SKILL.md#recorded-sessions-linked-to-a-lecture). This is a development commitment, not a produced recording or full Scope approval. The L01 register owns content/assessment obligations, artifact status and next actions.

**Subsequent bounded implementation decision (2026-10-14):** the instructor requested adding the short squared-error posterior-mean derivation slides to live L01 now. This authorizes that insertion through targeted organization/design/authoring, while the complete reconciled Scope remains provisional. It stays in the live-time budget unless the instructor later reduces or relocates it. See the L01 register for implementation and validation status.

The kickoff itself is not approval of a complete revised scope, slide design or notebook; the subsequent bounded decision above has its own authority. Existing L01–L03 artifacts remain recoverable on their source branches and in Git history. The L01 register records current decisions and evidence. The previous L04-first plan is superseded by this explicit instructor direction.
