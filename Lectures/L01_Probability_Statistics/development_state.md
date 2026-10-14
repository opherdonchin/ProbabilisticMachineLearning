# L01 — development state

**Purpose:** coordinator workflow register. The instructor's teaching proposal is [lecture_scope.md](lecture_scope.md); this file records its status, decisions, evidence and next owners.
**Maintainer:** Lecture Development Coordinator (`/root`); initialized at branch kickoff and maintained during this session.
**Working branch:** `rescope-l01-l12-architecture-alignment-20261014`. Branch kickoff source: `16850fbda82ff9a4a0a665ddab52115cda14a2bf`.
**Stage:** Lecture Scope, mathematical spine proposed and ready for instructor discussion. Current route and live/recorded proof boundary accepted; no complete five-part Scope is approved. No class has been taught.

## Resume from the office VS Code

**Handoff source revision:** `a685e2c1bef606d63acff87c2a12b5a11466bf2a`; the subsequent handoff commit adds this section. The instructor requested committing and syncing the current stack before resuming from another VS Code connected to the office.

Start with this register and the current [scope](lecture_scope.md), then load the canonical lecture-development skill including its recorded-session coordination. Retain the accepted route, operation-centered notebook direction and live/recorded proof boundary. Do not reopen those decisions merely because the chat/session changes. The instructor subsequently clarified that the recorded proof is required, examinable course content; viewing is not recorded, evaluated or monitored.

**Current work:** `/root/l01_existing_argument` returned the mathematical spine in the existing scope file, under a bounded commission at `5ba226342cbca91a1d52b5bd88bc7efeeee04b37`. It separates existing mathematics, proposed depths and accepted live/recorded boundaries. The recording contract specifies proof assumptions, normalization, source equations, endpoint and a proposed duration. Instructor review is next. Notebook handoff, examples and contract remain undeveloped. No downstream recording/slide/notebook task is running or completed; no video or new Typst recording source exists.

Suggested opening message in the new session:

> Resume L01 reconciliation on `rescope-l01-l12-architecture-alignment-20261014` using `$lecture-development`. Read `Lectures/L01_Probability_Statistics/development_state.md` and `lecture_scope.md`; reconcile them with the current branch before continuing. The lecture route and separate recorded block-elimination proof are already selected; the proof is examinable content, with no tracked or assessed viewing. Review the proposed mathematical spine and its live/recorded depths before developing the notebook handoff. Keep unresolved decisions explicit and do not advance to L02.

Git carries the artifacts, decisions and review evidence; this register is the durable handoff rather than assuming that the new VS Code exposes the same chat history.

## Instructor-agreed teaching direction

Current discussion, 2026-10-14: the notebook's strongest message is that the same dataset and probabilistic formulation support different questions. The instructor's subsequent “Sounds good” accepts in principle a hidden-block distribution $p(z\mid y)$, its squared-loss mean summary $E[Z\mid y]$, and a forward measurement distribution $p(y)=\int p(z,y)\,dz$, with a short generation activity. Conditioning, summarization and marginalization can combine in inference, prediction and generation; they do not pair one-to-one.

**Subsequent explicit decisions (current discussion, 2026-10-14):** retain the current route because of the strong existing work and absence of a deep architecture-driven reason to reorder it. Keep residual conditioning and the stated/interpreted quadratic identity live; prepare the full block-elimination proof as a separate recorded session with a dedicated Typst deck. Use the existing section/organization/design/authoring skills under coordination.

**Recording obligation clarified (instructor's async answer, 2026-10-14):** the proof is required course content and may appear on the exam. Viewing the video is not recorded, evaluated or monitored. This defines content responsibility, not compulsory video watching or a promised exam question. The live proof and notebook remain independently sufficient for their agreed endpoints.

These decisions do not settle all proposed refinements, concrete measurement context, exact workload, other mathematical depths or PyMC balance. Baseline reconstruction evaluation is a possible supporting exercise, not the central endpoint.

## Current proposal and instructor decisions

**Current artifact:** [lecture_scope.md](lecture_scope.md), by Lecture Scope specialist `/root/l01_existing_argument`, current blob `ccb04e5bd6510109e05c8ff597f7411f0b52271c`. The intellectual arc and mathematical spine are present; the spine and detailed recording contract are proposals. Route/proof-boundary and recording-content obligations remain accepted. Spine commission baseline: `5ba226342cbca91a1d52b5bd88bc7efeeee04b37`.

**Remaining proposals:** strengthen the concrete problem/query connection and squared-loss interpretation; selectively reduce repeated exposition if needed to fit the agreed notebook direction. These refinements have not been silently approved by the decision to retain the route. The recording proof is an addition to existing materials, not an existing live proof being relocated.

**Source-analysis correction:** the architecture already includes incomplete/noisy measurements, different questions and the three operations. No substantive architecture amendment is justified on this point. Any later notebook-description synchronization follows accepted handoff changes.

**Instructor's next task:** review Part 2 of the scope. The one highlighted new depth choice is whether to derive the short squared-loss posterior-mean identity live (recommended, about 2–4 minutes), or state the result and apply it without proof. The recording's 20–30-minute estimate and exact contract remain proposed. Route choice and recording-content obligation are closed. Context, notebook workload and PyMC balance are handled when their Scope parts are developed.

## Live and recorded delivery units

| Unit | Accepted content boundary | Stage / next owner |
|---|---|---|
| Live L01 | Current formulation → Gaussian geometry/conditioning → LGS route; residual derivation and interpreted quadratic identity remain live | Mathematical-spine proposal ready for instructor discussion |
| `recording:quadratic-separation` | Full block-elimination proof of the joint quadratic separation and conditional/marginal factorization; separate slide source; required/examinable content, unmonitored viewing | Detailed recording contract proposed in mathematical spine; downstream stages not started |

Planned recording production path: `Lectures/L01_Probability_Statistics/recordings/quadratic_separation/slide_deck.typ`, with its own section design, organization and design specifications in that directory when authored. No placeholder source or recording exists yet. The live proof and notebook do not depend on this additional proof; its content remains examinable. Keep preparation, validated slides, video production and actual assignment separate; do not introduce viewing-compliance tracking.

The mathematical spine/recording brief must make invertibility/positive-definiteness assumptions and normalization explicit: separating the exponent alone must not be presented as a complete density-factorization proof. This is author checking work, not an instructor approval question.

## Next actions and owners

| Owner | Action | Gate / status |
|---|---|---|
| Instructor, through coordinator discussion | Review the mathematical-spine proposal and the one highlighted loss-proof depth choice | Ready in Part 2 of scope; no automatic acceptance |
| Lecture Scope specialist through coordinator | Develop notebook handoff, then examples and contract iteratively; reconcile L02/L03 prerequisites | After spine discussion; not yet dispatched |
| Coordinator and separate reviewers | Arrange source-arc review where needed and lightweight Section Design preview | After coherent five-part provisional Scope; not commissioned |
| Owning section/slide/notebook authors | Selectively revise live work; develop recorded-session sections, organization, design and standalone deck; validate artifacts | After each unit's corresponding upstream acceptance; not started |

Correctness, source verification, compilation and clean local/hosted Colab execution are author/reviewer responsibilities. Actual coverage stays untouched until teaching.

## Review evidence and its limits

- [Existing-material assessment](reconciliation/existing_material_assessment.md), by `/root/l01_existing_argument`, and [architecture assessment](reconciliation/architecture_assessment.md), by `/root/l01_architecture_tensions`: separate initial analyses, not formal feasibility previews or runtime validation.
- [Supporting reconciliation matrix](reconciliation/matrix.md): coordinator synthesis, updated to reflect current decisions and source corrections. Original raw reports remain unchanged.
- Mathematical spine and recorded-proof contract authored by `/root/l01_existing_argument` at source baseline `5ba2263`, output blob `ccb04e5bd6510109e05c8ff597f7411f0b52271c`. Author checked exact local Murphy passages and unchanged input blobs. Coordinator read the complete proposal and checked accepted/proposed distinctions, Gaussian assumptions, loss identity, block-congruence/inverse and determinant-normalizer arguments. These are author/coordinator checks, not independent source-arc or Section Design validation. The source's exponent argument and the course's explicit normalization completion are distinguished.
- [Recorded-session workflow check](reconciliation/recorded_session_workflow_review.md), by `/root/recorded_session_workflow_check`: independent read-only behavior test of coordinator-skill blob `45a2e60970697b809ca595c614848bb0988a1270`. It found the existing specialists usable for the separate recording, with stale register status and one ambiguity about separately accepted recording briefs. Coordinator reconciled the register and clarified that boundary in subsequent skill blob `1ec41d751f86aed447062b9675b6b4e878564cf2`; those small repairs were coordinator-checked, not independently re-reviewed. The later instructor clarification distinguishes examinable content from viewing compliance; the skill now records these separately. `quick_validate.py` passed frontmatter/skill validation. This is workflow testing, not Scope/Section Design, mathematical or runtime validation.
- [Targeted communication review](reconciliation/communication_review.md) by `/root/l01_architecture_tensions` of working-tree scope blob `b37da7ffa4d1982ea1da0218ab01073b0aa093b5`: separate from the author; finds the main status-separation problem resolved and identifies three remaining repairs. Coordinator checked those repairs in final blob `682261132ed686f5f9eb80a95facadb597ad10e8`: current matrix withdraws the unsupported architecture amendment, register identifies the current version, computational complexity is explicitly author checking material, and correction attribution is accurate. This disposition is a coordinator recheck, not a second independent review. No source-arc, Section Design, mathematical or runtime validation is claimed.
- Historical persona reports target deck blob `69886a29870e4edd9d3fdde79c252b3e0037de54` at `e518d93f9566645da2eeff96e56662960f66d5a4`. They are simulated-reader evidence, not classroom results or validation of the production refactor.

**Open author checks:** malformed expanded marginal covariance product; coin uncertainty wording; sensor-noise independence and prior regime; sampling/error interpretation; clean local and Colab notebook execution; one-hour student feasibility. The actual deck is 67 pages/seven sections; the calibration's older count is stale. Teaching times remain unmeasured.

**Prerequisite reconciliation:** L02 introduces precision in its own Gaussian rewrite but inaccurately attributes information coordinates to L01. Resolve attribution before Scope freezing rather than automatically add an L01 unit. L03's joint/conditioning/simple-graph entry remains supported.

## Exact source records

Reviewed course artifacts are unchanged during this decision update. Initial analysis source commit: `692d10372f4e1cd091ae1e2977402900148f33c7`; Scope build commission: `ab5fdcdaa4aaa22d4ba0bb2bc701ddceee5d6b49`.

| Artifact | Reviewed blob |
|---|---|
| `slide_deck.typ` | `235b8eeb48ec9075d2bcea82b6a377c0a45b6a79` |
| `slide_deck.pdf` | `8d9ffbf49873bd890d0aee1c8b7262c897176a7c` |
| `lecture_01_coverage_spec.typ` | `c4457bc4fdb11df14de54658f20e487030766328` |
| `InClass/Solutions/lecture1_missing_data.ipynb` | `ab441941c8b526151a927bfbcf292bd9bc629ce5` |
| `course_architecture.typ` | `cb111196e44df211e39864be596233a1a3f22aba` |
| `curriculum_map.typ` | `63fb5cea0a7b0a4c908c8f803e550d087d20a412` |

Course-wide sources: architecture, planned/actual maps and [START_SCOPING](../START_SCOPING.md). The two maps are the sole course-wide tracking documents; the actual map is blank until teaching. The instructor reopened L01–L03 for two-way reconciliation on 2026-10-14, but implementation still follows stage acceptance.

**Presentation requirement:** future instructor-facing documents must distinguish existing facts, critique, recommendations, agreed directions and decisions. The coordinator's check and future commissions follow [the instruction in START_SCOPING](../START_SCOPING.md#make-instructor-facing-claims-and-decisions-distinguishable). Recorded-session coordination follows the new section in the canonical lecture-development skill; its live/recorded approvals remain separate.
