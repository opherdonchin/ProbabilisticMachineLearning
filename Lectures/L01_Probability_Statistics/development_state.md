# L01 — scope and artifact reconciliation state

**Stage:** Lecture Scope build / provisional intellectual arc ready for instructor discussion. Operation-centered notebook direction agreed in principle; whole-lecture arc awaits instructor acceptance.
**Maintainer:** Lecture Development Coordinator (`/root`). The register was initialized at the branch kickoff before this session; the coordinator updated it during the current review and discussion.
**Working branch:** `rescope-l01-l12-architecture-alignment-20261014`, created from `scope-l04-l12-after-architecture-20261014` at `16850fbda82ff9a4a0a665ddab52115cda14a2bf`.
**Course-wide sources:** `course_architecture.typ`, `curriculum_map.typ`, `curriculum_map_actual.typ`, `Lectures/START_SCOPING.md`.
**No complete revised L01 Scope, slide design or notebook implementation is approved yet.** The limited notebook-direction agreement is recorded below. No class has yet been taught.

## Initial review checkpoint — 2026-10-14

**Last-reviewed baseline:** `692d10372f4e1cd091ae1e2977402900148f33c7`. Reviewed deck source `235b8eeb48ec9075d2bcea82b6a377c0a45b6a79`, PDF `8d9ffbf49873bd890d0aee1c8b7262c897176a7c`, coverage specification `c4457bc4fdb11df14de54658f20e487030766328`, solved notebook `ab441941c8b526151a927bfbcf292bd9bc629ce5`, architecture `cb111196e44df211e39864be596233a1a3f22aba`, curriculum map `63fb5cea0a7b0a4c908c8f803e550d087d20a412`.

**Inspection artifact:** [two-way reconciliation matrix](reconciliation/matrix.md), with mathematical/practical outcomes, recommendations, downstream effects and source/evidence limitations. These are proposals, not an approved scope.

**Review evidence:** Separate delegated Lecture Scope analyses by `/root/l01_existing_argument` and `/root/l01_architecture_tensions`, retained verbatim in [existing-material assessment](reconciliation/existing_material_assessment.md) and [architecture assessment](reconciliation/architecture_assessment.md). These are initial conceptual assessments, not formal source-arc/Section Design previews or implementation validation. Coordinator checked current source, PDF text, selected rendered pages, book passages, prior decision records and named branch content. Historical persona reviews target an earlier production revision and remain simulated reader evidence.

**Accepted instructor direction (current discussion, 2026-10-14):** The notebook's strongest message should be that the same dataset and probabilistic formulation can support different questions. This clarifies the intended emphasis; it does not approve a revised Scope, concrete query set or notebook implementation. The coordinator's earlier reconstruction-baseline proposal is secondary to this endpoint.

**Subsequent limited agreement (current discussion, 2026-10-14):** The instructor responded “Sounds good” to the proposal that the three main notebook questions exercise conditioning, summarization and marginalization, with inference, prediction and generation as concrete uses. The query types are agreed in principle: hidden-block distribution $p(z\mid y)$, point reconstruction $E[Z\mid y]$ under squared loss, and forward measurement distribution $p(y)=\int p(z,y)\,dz$, accompanied by a short generation activity. Summarizing the posterior builds on conditioning; task uses and probability operations do not pair one-to-one. This is acceptance of the pedagogical direction, not the complete lecture scope, notebook design or workload.

**Open instructor decisions:** Whole-lecture endpoint and intellectual arc; required mathematical treatment depths (particularly the residual proof and quadratic decomposition); concrete measurement context; live/notebook time allocation and the retained role of PyMC/exact comparison. The coordinator should bring a concrete arc proposal to the instructor rather than ask the instructor to independently resolve the matrix's entire issue list.

**Current proposal and review:** [lecture_scope.md](lecture_scope.md), blob `120056e4fd426832f9275d03b765b960b0f03898`, authored by `/root/l01_existing_argument` under a bounded Lecture Scope `build` commission at `ab5fdcdaa4aaa22d4ba0bb2bc701ddceee5d6b49`. It contains the intellectual arc only, with a recommendation to preserve the general-to-operational route, a measurement-first alternative, and proposed proof-depth/time tradeoffs. Coordinator read the complete proposal for clarity, mathematical distinctions, agreement fidelity and stage boundaries; this is a same-context coordination check, not independent source-arc or Section Design validation.

**Uncertainties and next owner:** Instructor discusses the concrete arc through the coordinator. The remaining four Scope parts, downstream design/authoring, architecture/map edits and L02 advancement are excluded from the completed commission. No additional instructor answer was needed before commissioning; unsettled depth/time/context choices are now presented against the proposal. Before freezing L01, reconcile L02's asserted precision/information-form prerequisite and L03's actual entry conditions. Notebook clean local/Colab execution and student-time feasibility are unverified. Current-source correctness concerns are recorded in the matrix for author repair at the appropriate stage.

**Impact:** No downstream approvals invalidated or artifacts rewritten at this checkpoint. Scope, architecture L01 description, coverage specification and notebook handoff may require selective changes after decisions. Keep actual coverage untouched.

## Existing authored work to inspect

- `slide_deck.typ` (starting blob `235b8eeb48ec9075d2bcea82b6a377c0a45b6a79`) and its PDF; the deck has substantial Beta–Binomial/Bayesian reactivation, task/experience/performance framing, datasets and probabilistic queries, multivariate Gaussian conditioning, linear Gaussian inference and sensor fusion.
- `lecture_01_coverage_spec.typ` (blob `c4457bc4fdb11df14de54658f20e487030766328`): prior design rationale and topics; may not perfectly reflect the later deck. Do not treat it as an unchangeable approved five-part Lecture Scope.
- `InClass/Solutions/lecture1_missing_data.ipynb` (blob `ab441941c8b526151a927bfbcf292bd9bc629ce5`) and `InClass/Preparation/` worked solution and authoring report. The solved notebook is Q&A-first; it models missing data through a conditional Gaussian by both PyMC and exact linear-Gaussian calculation. Check mathematical and runtime completeness before student use.
- `review/` reports and original figure/author notebooks in the L01 directory; characterize what they actually evaluated, which version, and what remains open.
- `slide-authoring-refactor` carries `slide_deck_07.typ` as a possible historical comparison; inspect only if it contains relevant accepted teaching moves.

## Next actions and owners

| Action | Owner | Trigger / status |
|---|---|---|
| Prepare a provisional whole-lecture intellectual arc from existing material and the agreed notebook direction; identify smallest revisions, unresolved depth/time choices and any architecture amendment | `/root/l01_existing_argument`, Lecture Scope specialist; coordinator owns dispatch and instructor presentation | Returned in `lecture_scope.md`; first part only, proposed; coordinator check completed |
| Review that arc and decide consequential endpoint, emphasis and depth choices | Instructor, through coordinator discussion | When the concrete proposal is presented; no blanket approval of this register or matrix is required |
| Develop mathematical spine, notebook handoff, examples and lecture contract iteratively; check L02/L03 prerequisite effects | Lecture Scope specialist, coordinated by `/root`; instructor accepts teaching commitments | After arc agreement; no automatic advance to L02 |
| Commission source-arc review where needed and a lightweight Section Design feasibility preview; adjudicate findings | Coordinator arranges separate reviewers; reviewers assess, instructor approves Scope | Once the five-part provisional Scope is coherent; not yet commissioned |
| Revisit existing sections, organization, design and production; implement accepted notebook handoff; repair mathematical/source errors and validate artifacts | Owning section/slide/notebook specialists; coordinator routes work | After corresponding upstream acceptance; no slide or notebook edits started |

Correctness, source verification, compilation and local/Colab execution belong to authors/reviewers. They are not instructor action items. `curriculum_map.typ` and `curriculum_map_actual.typ` are the only course-wide material tracking documents; keep the actual map untouched until teaching.

## Current accepted authority

The instructor explicitly authorized reconsidering L01–L03 in both directions (existing lecture and architecture) on 2026-10-14. Earlier authored work and instructor decisions remain important evidence but not an automatic veto on a justified revision. The architecture is the current course-level baseline, not beyond criticism. No current lecture-delivery evidence exists.
