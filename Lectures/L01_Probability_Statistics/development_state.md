# L01 — scope and artifact reconciliation state

**Stage:** instructor-led Lecture Scope / notebook emphasis clarified; intellectual arc and query selection remain under discussion.
**Working branch:** `rescope-l01-l12-architecture-alignment-20261014`, created from `scope-l04-l12-after-architecture-20261014` at `16850fbda82ff9a4a0a665ddab52115cda14a2bf`.
**Course-wide sources:** `course_architecture.typ`, `curriculum_map.typ`, `curriculum_map_actual.typ`, `Lectures/START_SCOPING.md`.
**No revised L01 scope, design, notebook, or new pedagogical approval exists yet.** No class has yet been taught.

## Initial review checkpoint — 2026-10-14

**Last-reviewed baseline:** `692d10372f4e1cd091ae1e2977402900148f33c7`. Reviewed deck source `235b8eeb48ec9075d2bcea82b6a377c0a45b6a79`, PDF `8d9ffbf49873bd890d0aee1c8b7262c897176a7c`, coverage specification `c4457bc4fdb11df14de54658f20e487030766328`, solved notebook `ab441941c8b526151a927bfbcf292bd9bc629ce5`, architecture `cb111196e44df211e39864be596233a1a3f22aba`, curriculum map `63fb5cea0a7b0a4c908c8f803e550d087d20a412`.

**Inspection artifact:** [two-way reconciliation matrix](reconciliation/matrix.md), with mathematical/practical outcomes, recommendations, downstream effects and source/evidence limitations. These are proposals, not an approved scope.

**Review evidence:** Separate delegated Lecture Scope analyses by `/root/l01_existing_argument` and `/root/l01_architecture_tensions`, retained verbatim in [existing-material assessment](reconciliation/existing_material_assessment.md) and [architecture assessment](reconciliation/architecture_assessment.md). These are initial conceptual assessments, not formal source-arc/Section Design previews or implementation validation. Coordinator checked current source, PDF text, selected rendered pages, book passages, prior decision records and named branch content. Historical persona reviews target an earlier production revision and remain simulated reader evidence.

**Accepted instructor direction (current discussion, 2026-10-14):** The notebook's strongest message should be that the same dataset and probabilistic formulation can support different questions. This clarifies the intended emphasis; it does not approve a revised Scope, concrete query set or notebook implementation. The coordinator's earlier reconstruction-baseline proposal is secondary to this endpoint.

**Open instructor decision:** Which contrasting queries should students actually formulate and answer under one fixed Gaussian model? In the current discussion the instructor asks whether the three questions can explicitly exercise summarization, marginalization and conditioning, and connect to inference, prediction and generation. The coordinator recommends that relationship while preserving the distinction between probability operations and task/model uses: there is no one-to-one correspondence. A provisional LGS query set is a point reconstruction $E[Z\mid y]$, a forward measurement distribution $p(y)=\int p(z,y)\,dz$, and a hidden-block posterior $p(z\mid y)$. Summarizing the posterior builds on conditioning; generation can draw new cases from the same forward model. The existing PyMC and exact-LGS routes compute the same conditional query. Exact query selection, context, mathematical depths, timing and retained PyMC comparison remain unapproved.

**Uncertainties and next owner:** Coordinator continues the intellectual-arc discussion with the notebook's different-question emphasis, keeping the query set provisional. No rewriting of Scope, slides, notebook, architecture or curriculum allocation is authorized yet. Before freezing L01, reconcile L02's asserted precision/information-form prerequisite and L03's actual entry conditions. Notebook clean local/Colab execution and student-time feasibility are unverified. Current-source correctness concerns are recorded in the matrix for author repair at the appropriate stage.

**Impact:** No downstream approvals invalidated or artifacts rewritten at this checkpoint. Scope, architecture L01 description, coverage specification and notebook handoff may require selective changes after decisions. Keep actual coverage untouched.

## Existing authored work to inspect

- `slide_deck.typ` (starting blob `235b8eeb48ec9075d2bcea82b6a377c0a45b6a79`) and its PDF; the deck has substantial Beta–Binomial/Bayesian reactivation, task/experience/performance framing, datasets and probabilistic queries, multivariate Gaussian conditioning, linear Gaussian inference and sensor fusion.
- `lecture_01_coverage_spec.typ` (blob `c4457bc4fdb11df14de54658f20e487030766328`): prior design rationale and topics; may not perfectly reflect the later deck. Do not treat it as an unchangeable approved five-part Lecture Scope.
- `InClass/Solutions/lecture1_missing_data.ipynb` (blob `ab441941c8b526151a927bfbcf292bd9bc629ce5`) and `InClass/Preparation/` worked solution and authoring report. The solved notebook is Q&A-first; it models missing data through a conditional Gaussian by both PyMC and exact linear-Gaussian calculation. Check mathematical and runtime completeness before student use.
- `review/` reports and original figure/author notebooks in the L01 directory; characterize what they actually evaluated, which version, and what remains open.
- `slide-authoring-refactor` carries `slide_deck_07.typ` as a possible historical comparison; inspect only if it contains relevant accepted teaching moves.

## Required first analysis

1. Read and characterize the *existing lecture's real mathematical argument*, relevant figures and examples, time/density, and the practical notebook endpoint, independently of the new architecture.
2. Explain how the new course's educational goal changes—or validates—that argument. Test whether the task/model/query/performance framing and concrete Gaussian application develop a genuine method repertoire, and whether the volume of framing vs computation is appropriate. Do not prejudge that changes are needed.
3. Look forward to L02's exponential-family/Markov-chain commitments and L03's graphical-model argument, so L01 reallocations do not create gaps or repetitions.
4. State specific opportunities for minimal revisions to the scope, course architecture, section boundaries, slide-design content and notebook; distinguish required versus optional improvements. Nothing downstream should be rewritten before scope-level acceptance.
5. Ask the instructor a single consequential question about L01's endpoint/emphasis; discuss iteratively. Later record decisions, source evidence and feasibility-review provenance here.

## Current accepted authority

The instructor explicitly authorized reconsidering L01–L03 in both directions (existing lecture and architecture) on 2026-10-14. Earlier authored work and instructor decisions remain important evidence but not an automatic veto on a justified revision. The architecture is the current course-level baseline, not beyond criticism. No current lecture-delivery evidence exists.
