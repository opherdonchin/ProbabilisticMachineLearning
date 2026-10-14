# L01 — development state

**Purpose:** coordinator workflow register. The instructor's teaching proposal is [lecture_scope.md](lecture_scope.md); this file records its status, decisions, evidence and next owners.
**Maintainer:** Lecture Development Coordinator (`/root`); initialized at branch kickoff and maintained during this session.
**Working branch:** `rescope-l01-l12-architecture-alignment-20261014`. Branch kickoff source: `16850fbda82ff9a4a0a665ddab52115cda14a2bf`.
**Stage:** Lecture Scope, intellectual arc only. Presentation revision ready for instructor review; no complete five-part Scope is approved. No class has been taught.

## Instructor-agreed teaching direction

Current discussion, 2026-10-14: the notebook's strongest message is that the same dataset and probabilistic formulation support different questions. The instructor's subsequent “Sounds good” accepts in principle a hidden-block distribution $p(z\mid y)$, its squared-loss mean summary $E[Z\mid y]$, and a forward measurement distribution $p(y)=\int p(z,y)\,dz$, with a short generation activity. Conditioning, summarization and marginalization can combine in inference, prediction and generation; they do not pair one-to-one.

That agreement does not settle the whole lecture arc, concrete measurement context, proof depth, exact workload or PyMC balance. Baseline reconstruction evaluation is a possible supporting exercise, not the central endpoint.

## Current proposal and instructor decisions

**Proposal:** [lecture_scope.md](lecture_scope.md), by Lecture Scope specialist `/root/l01_existing_argument`, current blob `682261132ed686f5f9eb80a95facadb597ad10e8`. The preceding committed proposal was blob `120056e4fd426832f9275d03b765b960b0f03898` at `7d47bd4615f8ad08a37d6cd0543658447e362f45`.

**Recommended defaults, not accepted decisions:** retain the existing general-to-operational route with a concrete problem/query connection; retain the residual argument and the stated/interpreted quadratic identity. A measurement-first opening is an alternative. A full block-elimination proof would be an addition to the existing deck, not retention of a second proof already present.

**Source-analysis correction:** the architecture already includes incomplete/noisy measurements, different questions and the three operations. No substantive architecture amendment is justified on this point. Any later notebook-description synchronization follows accepted handoff changes.

**Instructor's next task:** review the recommendations and choices in the revised scope. The matrix is supporting assessment; it is not a row-by-row approval request. Context, notebook workload and PyMC balance are handled when their Scope parts are developed.

## Next actions and owners

| Owner | Action | Gate / status |
|---|---|---|
| Scope specialist `/root/l01_existing_argument` | Repair the proposal's separation of existing facts, critique, recommendations and choices | Completed; no new pedagogical choices accepted |
| Coordinator `/root` | Reconcile supporting documents, check the revision and present the scope as the primary reading document | Completed; raw reports preserved and review limitations stated |
| Instructor, through coordinator discussion | Judge the route and proof-depth recommendations against concrete alternatives | After readable arc proposal is returned; no blanket register/matrix approval |
| Lecture Scope specialist and coordinator | Develop mathematical spine, notebook handoff, examples and contract iteratively; reconcile L02/L03 prerequisites | After arc agreement; no automatic L02 advancement |
| Coordinator and separate reviewers | Arrange source-arc review where needed and lightweight Section Design preview | After coherent five-part provisional Scope; not commissioned |
| Owning section/slide/notebook authors | Selectively revise existing work, repair mathematical errors, regenerate and validate artifacts | After corresponding upstream acceptance; not started |

Correctness, source verification, compilation and clean local/hosted Colab execution are author/reviewer responsibilities. Actual coverage stays untouched until teaching.

## Review evidence and its limits

- [Existing-material assessment](reconciliation/existing_material_assessment.md), by `/root/l01_existing_argument`, and [architecture assessment](reconciliation/architecture_assessment.md), by `/root/l01_architecture_tensions`: separate initial analyses, not formal feasibility previews or runtime validation.
- [Supporting reconciliation matrix](reconciliation/matrix.md): coordinator synthesis, updated to reflect current decisions and source corrections. Original raw reports remain unchanged.
- [Targeted communication review](reconciliation/communication_review.md) by `/root/l01_architecture_tensions` of working-tree scope blob `b37da7ffa4d1982ea1da0218ab01073b0aa093b5`: separate from the author; finds the main status-separation problem resolved and identifies three remaining repairs. Coordinator checked those repairs in final blob `682261132ed686f5f9eb80a95facadb597ad10e8`: current matrix withdraws the unsupported architecture amendment, register identifies the current version, computational complexity is explicitly author checking material, and correction attribution is accurate. This disposition is a coordinator recheck, not a second independent review. No source-arc, Section Design, mathematical or runtime validation is claimed.
- Historical persona reports target deck blob `69886a29870e4edd9d3fdde79c252b3e0037de54` at `e518d93f9566645da2eeff96e56662960f66d5a4`. They are simulated-reader evidence, not classroom results or validation of the production refactor.

**Open author checks:** malformed expanded marginal covariance product; coin uncertainty wording; sensor-noise independence and prior regime; sampling/error interpretation; clean local and Colab notebook execution; one-hour student feasibility. The actual deck is 67 pages/seven sections; the calibration's older count is stale. Teaching times remain unmeasured.

**Prerequisite reconciliation:** L02 introduces precision in its own Gaussian rewrite but inaccurately attributes information coordinates to L01. Resolve attribution before Scope freezing rather than automatically add an L01 unit. L03's joint/conditioning/simple-graph entry remains supported.

## Exact source records

Reviewed course artifacts are unchanged during this communication revision. Initial analysis source commit: `692d10372f4e1cd091ae1e2977402900148f33c7`; Scope build commission: `ab5fdcdaa4aaa22d4ba0bb2bc701ddceee5d6b49`.

| Artifact | Reviewed blob |
|---|---|
| `slide_deck.typ` | `235b8eeb48ec9075d2bcea82b6a377c0a45b6a79` |
| `slide_deck.pdf` | `8d9ffbf49873bd890d0aee1c8b7262c897176a7c` |
| `lecture_01_coverage_spec.typ` | `c4457bc4fdb11df14de54658f20e487030766328` |
| `InClass/Solutions/lecture1_missing_data.ipynb` | `ab441941c8b526151a927bfbcf292bd9bc629ce5` |
| `course_architecture.typ` | `cb111196e44df211e39864be596233a1a3f22aba` |
| `curriculum_map.typ` | `63fb5cea0a7b0a4c908c8f803e550d087d20a412` |

Course-wide sources: architecture, planned/actual maps and [START_SCOPING](../START_SCOPING.md). The two maps are the sole course-wide tracking documents; the actual map is blank until teaching. The instructor reopened L01–L03 for two-way reconciliation on 2026-10-14, but implementation still follows stage acceptance.

**Presentation requirement:** future instructor-facing documents must distinguish existing facts, critique, recommendations, agreed directions and decisions. The coordinator's check and future commissions follow [the instruction in START_SCOPING](../START_SCOPING.md#make-instructor-facing-claims-and-decisions-distinguishable). Only communication and source-analysis corrections were requested here; no new teaching commitment or stage advancement is implied.
