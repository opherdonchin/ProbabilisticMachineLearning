# L10 reopened: MCMC for machine learning

Instructor direction, current discussion 2026-10-15: the prior introductory
MCMC scope repeats an undergraduate lecture for departmental students. Some
entrants from outside the department lack that background. Develop a richer
path through Murphy for **MCMC for machine learning**, seeking the most insight
for the least unnecessary prerequisite/technical struggle. This reopens the L10
intellectual arc and depth allocation, not just its notebook dataset.

The old MH-first Scope is a baseline proposal, not an accepted endpoint to defend.
Eight Schools versus bioassay is deferred until the lecture's purpose is agreed.
The proposed replacement live route is IS → MCMC → HMC through task-query
accuracy versus computation, with only a light Murphy-based NUTS reference.
AIS is now selected as the notebook direction; detailed live depths, a required
recording and the full Scope are not approved. Preserve the broader geometry/task-driven cumulative
L07/L09/L10 direction and the accepted L09 Challenger application. No method-power
hierarchy, automatic mixing guarantee or automatic assumption of advanced fluency.

## Inputs and authority

Base `0e5a393`, isolated coordinator branch `rescope/l10-mcmc-for-ml-20261015`,
worktree `/tmp/pml-l10-ml-rescope-20261015`. Read actual architecture/maps,
L10 Scope/source-arc review/investigations and original reviews, existing L10
computational candidate report (do not repeat its screening), current L09 Scope
at `resume/l09-challenger-contract-20261015@39dd5dc` in its worktree, and relevant
L01/L05/L06/L08/L11/L12 artifacts as prerequisites require. Student-knowledge entry
records conceptual MCMC/HMC, PyMC/ArviZ and partial pooling; instructor now
explicitly identifies mixed entry backgrounds. Use a bounded bridge without
making the whole live lecture remedial or inventing universal prior competence.

Primary source: Murphy, *Probabilistic Machine Learning: Advanced Topics*, online
December 10, 2025, source text `/tmp/pml-book2.txt`; exact PDF/source identity is
in existing source manifests. Book2 is primary; Book1 only selective scaffolding.
Reconstruct the book's arguments from actual passages, not TOC or a method list.
Use the existing lecture-scope skill and timing/backpressure instructions.

Architecture currently names MH as the core construction. A proposed different
allocation must make that delta explicit for later authorized alignment; it is
not forbidden by the prior wording or permission to edit architecture/maps now.

## Completed route inquiry and its boundaries

No production, new probes, full five-part Scope, sections, slides, Q&A notebooks,
shared-skill adoption, architecture/map edits or merges. Preserve exact existing
source/math findings and reveal genuine book errors, including mass/covariance
conventions and variance notation. Student scale is approximately 110 live
minutes plus a one-hour notebook; timing estimates remain provisional and must
include questions/reserve. A fixed roadmap/count is not an instructor decision.

Each writer starts from the commit containing this brief in a separate isolated
worktree. You are not alone; do not revert peers or edit another owner's artifacts.

| Owner | Branch / worktree | Exact sole write | Deliverable |
|---|---|---|---|
| `/root/l10_ml_routes` | `rescope/l10-ml-routes-20261015`; `/tmp/pml-l10-ml-routes-20261015` | `Lectures/L10_MCMC/reconciliation/ml_route_options.md` | Lecture Scope/build initial inquiry: compare 2–3 genuinely distinct source-grounded routes, recommend a coherent intellectual endpoint and teaching tradeoffs. No full Scope. |
| `/root/l10_murphy_review` | `review/l10-ml-source-20261015`; `/tmp/pml-l10-ml-source-review-20261015` | `Lectures/L10_MCMC/reconciliation/murphy_source_review.md` | Independently reconstruct Murphy/prior-course argument before reading builder options, then critique fidelity/prerequisites and unsupported payoff claims. Do not design a competing lecture arc. |
| Coordinator | This branch/worktree | This brief, Scope direction notice; course index in its own branch | Instructor discussion, authority and collection; no route silently selected. |

Routes must express a recognizable ML task/model/query/scale and show how the
computation is induced. Distinguish validity, payoff in gradients/density calls/
memory, and task-relevant remaining error. Explain mathematics at derive/work/
state depth, what students practise, what prior material is reused, what each
choice gives up, and bounded support for external entrants. Do not compress a
chapter catalogue into an hour or turn a convenient notebook into lecture purpose.
Possible areas to assess, not required coverage: gradient-informed geometry/HMC,
structured/blocked/collapsed Gibbs and marginalization, stochastic-gradient
Langevin for large datasets, selective importance/reweighting connections to VI.
Source reader first works independently; then exchange actual evidence with
builder. Return precise objections/counteroffers to coordinator. No new agents.
Complete a bounded evidence pass; unresolved consequential choices are deferred
to instructor. Agreement and source inspection do not grant approval or establish
student-time/notebook/runtime validation.

## Inquiry returned; live-depth decision remains pending

Returned builder `b9e0a0e` and reviewer `4cbacf5` (both clean); the review
checks that final builder revision. The two owning reports above contain the
substantive comparison and actual source/feasibility review. Builder recommends posterior geometry through
algorithm-level HMC; blocked HMM inference and large-data Langevin are serious
alternative endpoints. Reviewer finds these source-faithful selective arguments;
HMC and blocking remain feasible with timing/application risks, while Langevin
has a larger new prerequisite and practical-validation burden. No source-level
blocker prevents considering the recommendation. Exact source/render evidence,
reviewed revisions and author-owned corrections stay in the reports.

The instructor subsequently proposed IS → MCMC → HMC through accuracy versus
compute, judging that this lens can make revisited material worthwhile. This is
narrower authority than accepting the builder's full geometry/HMC route. Exact
live derive/work/state depths, the mixed-entry bridge, examples and timing remain
unsettled. Preserve the prior evidence without launching all alternative routes.

## AIS notebook selection — 2026-10-15

**Trigger and approval:** In replacement thread
`01a14017-0a80-7150-b7e7-c6511cb25698`, the instructor states: “I like the idea of
AIS. I think it will work well.” The next steering says to delegate/background
such tasks so instructor review can continue. This selects AIS as the L10 notebook
direction. It does not approve a dataset, kernel, VI family, detailed student work,
live derivation depth or whole Scope. The old notebook-application deferral is
resolved only at the method level.

**Recovered authority:** Original thread
`01a13b84-cc43-76e2-a709-9ef2700a21bf`, saved in
`/home/opher/.codex/sessions/2026/10/14/rollout-2026-10-14T20-45-21-01a13b84-cc43-76e2-a709-9ef2700a21bf.jsonl`:

- User, 2026-10-15 13:04 Jerusalem, line 2020: “Don't develop it: explore the
  idea”; this holds full development while alternatives are discussed.
- User, 13:22, line 2080: computation concerns accuracy of a specific performance
  functional, including regions with material target probability and functional
  weight; keep NUTS to Murphy's light reference without supplementation.
- User, 13:27, line 2118: proposes IS → MCMC → HMC with a nod to NUTS for the
  two-hour lecture, and asks which extension best serves a one-hour notebook.
- Assistant recommendation, 13:31, line 2188: AIS using supplied MH or HMC
  transitions, density/gradient and experiment infrastructure; possible student
  incremental weights and query-versus-compute comparisons. This is a proposal,
  not instructor approval of that allocation. Challenger might be too easy to
  justify AIS overhead. The current acceptance selects AIS, not that example.

**Mathematical and teaching purpose:** AIS should connect the lecture's weighting
and target-preserving transitions, asking when work on intermediate targets earns
its cost for the specified queries. Correct importance weighting does not require
an equilibrium draw at every intermediate stage; finite-run query accuracy still
depends on overlap, moments and useful transitions. A self-normalized expectation
estimate is a ratio and generally has finite-sample bias; do not transfer a
normalizing-constant estimator's unbiasedness to it. Additional temperatures or
transitions do not guarantee improved accuracy per computation. These correctness
conditions are author/reviewer responsibilities, not instructor decisions.

**Focused source route:** Murphy, *Probabilistic Machine Learning: Advanced
Topics*, online December 10, 2025, §11.5.3 “Choosing the proposal” (p.492),
§11.5.4 “Annealed importance sampling (AIS)” (pp.492–494), and §13.6.2
“Likelihood tempering (geometric path)” (p.565). Inspect the functional-sensitive
proposal criterion, path weighting and invariant transitions; §13.6.2 relates AIS
to tempering without resampling. No full SMC teaching is selected. The extracted
text of §11.5.4 contains apparent target/index inconsistencies; verify the original
PDF before reproducing equations or declaring source errors. NUTS remains the
light §12.5.4.1 reference, without a supplementary algorithm or proof.

**Bounded work and ownership:** The coordinator's envelope in
`/tmp/pml-course-development-20261014/Lectures/course_development_state.md` assigns
this narrow Scope record to `resume/l10-ais-selection-20261015` from `13b209b`.
Allowed writes are only this brief, `lecture_scope.md` and `development_state.md`.
The separate pilot owner writes only `Lectures/L10_MCMC/notebook_ais/` on
`investigate/l10-ais-pilot-20261015`, also from `13b209b`. Reuse the accepted L09
Challenger contract at `39dd5dc` as an initial computational candidate, not a
selected L10 application. No new full Scope, sections, slides, student notebook,
architecture/maps/environment/shared-skill edits, merges or publishing. The
pilot's execution authority does not lift the hold on full development.

**Remaining pedagogical choices:** Accept or adjust the live argument's precise
treatment depths and mixed-entry bridge; select L10's task/model/query and VI
family after the bounded pilot; resolve the L09 diagonal-student/full-supplied
allocation and honest L10 continuation; agree the student/supplied AIS work and
new-theory allocation within one hour. A query's reported numerical discrepancy
is not an accepted accuracy tolerance or task decision loss. The pilot can expose
minimum repairs, but cannot settle these instructor-owned choices or establish
measured learner time. No required recording has been chosen.
