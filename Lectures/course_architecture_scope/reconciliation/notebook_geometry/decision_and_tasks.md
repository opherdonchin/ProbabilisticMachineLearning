# L07/L09/L10 notebook direction and candidate investigation

Instructor decision, current discussion 2026-10-15. Owner: L07/L09/L10
Lecture Scope notebook handoffs; this record preserves their joint direction and
bounded research envelope. Source base `61f113e`. The old shared-Iris question
is replaced by this direction, not answered A. No dataset, model, variational
family, sampler or complete scope is approved.

## Accepted direction

The primary educational objective is understanding which posterior characteristics
make an inference method appropriate or inappropriate. Dataset continuity is
desirable, not essential. Investigate real dataset/model combinations before
selection; do not construct artificial examples merely to justify each method.
Controlled targets remain useful diagnostics, explicitly labelled.

- L07: a posterior sufficiently close to Gaussian for local quadratic approximation
  to work well; apply Laplace against a checked numerical reference.
- L09: revisit Laplace on a new problem, assess its shortcomings, then introduce
  an appropriate VI family and compare. A non-Gaussian, approximately factorized
  posterior is a possible route, not a requirement. VI is not inherently diagonal
  Gaussian. Multinomial Iris is a candidate to investigate, not evidence that
  Laplace will fail.
- L10: revisit the selected variational approach on a more complicated posterior,
  assess its limitations, then introduce MCMC and compare. Dependence, irregular
  geometry or multiple modes are possible features; none establishes VI failure
  or finite-chain success by itself.
- Develop cumulative one-hour notebooks. Revisit each preceding method, supplying
  code where needed rather than appending full exercises. Different datasets are
  acceptable when they naturally expose the relevant geometry.

These methods are not a hierarchy of increasing power. Separate local/global fit,
family restriction, optimization, numerical reference error and Monte Carlo/
exploration error. Geometry depends on parameterization: report coordinates and
prior. A richer VI family may remove a proposed failure; dependence alone does
not defeat full-covariance VI. Report task-relevant query error, time/memory and
repeated-query cost. Do not confuse posterior spread and Monte Carlo uncertainty.

The instructor's detailed current reply is provenance. Existing source arcs,
live derivations and unrelated commitments remain in force. Proposed changes to
them return to Scope review. Existing notebook/example commitments in the scopes
are baseline proposals needing reconciliation where they conflict with this
direction. Architecture/maps remain unchanged pending evidence and selection.

## Bounded research and ownership

Use existing lecture-scope revision/feasibility and worked-solution-authoring for
teacher-only probes; no student notebooks/slides. Each agent starts from the
commit containing this envelope in its own worktree. Inputs: architecture/maps,
the three scopes/investigations at `61f113e`, original source reviews, existing
probes/results and current student knowledge. Reuse established results rather
than rerun the classifier without a new question. Reports record exact inputs,
source/data hashes, reproducible code, raw failures and reference checks.

| Owner | Branch / worktree | Exact allowed write prefix | Deliverable / dependency |
|---|---|---|---|
| L07 investigator | `investigate/l07-geometry-20261015`; `/tmp/pml-l07-geometry-20261015` | `Lectures/L07_Inference/notebook_geometry/` | Good-Laplace real-data candidate, task/query/reference evidence and hour budget. Independent start. |
| L09 investigator | `investigate/l09-geometry-20261015`; `/tmp/pml-l09-geometry-20261015` | `Lectures/L09_Variational_Inference/notebook_geometry/` | Test multinomial Iris and at most one justified alternative/family; actual Laplace and VI comparison. Screening independent; communicate candidate family promptly to L10. |
| L10 investigator | `investigate/l10-geometry-20261015`; `/tmp/pml-l10-geometry-20261015` | `Lectures/L10_MCMC/notebook_geometry/` | At most two justified real-data/model candidates, prior-family VI and actual multi-chain MCMC, reference/diagnostics, query error and hour budget. Screening independent; final cumulative comparison conditional on L09 family. |
| Coordinator | `investigate/inference-notebook-geometry-20261015`; `/tmp/pml-inference-notebook-geometry-20261015` | Joint record, three scope notices, three investigation resolution pointers, existing group queue/register | Record direction; collect evidence and route candidate selection/feasibility. No broad live/math rewrites. |

Workers are not alone: never revert peers or edit outside their prefix. Shared
skills, APIs, maps, architecture, existing scopes/probes/results and slide evidence
are excluded. Read peer artifacts by absolute worktree path; exchange candidates
directly. No merges or additional agents. Use locked repository uv, no shared
dependency/lock edits. Read-only reuse of
`/tmp/pml-l04-l12-reconciliation/.venv/bin/python` is allowed; cache outside repo.

Stop after bounded screening and actual computational evidence; no convincing
sequence is a valid outcome. Return serious candidate options, recommendation,
focused verified reading route, proposed student-written versus supplied work,
estimated hour budget (not measured learner time), blockers and next actions.
Defer questions with evidence/priority and exact dependent work. Family/model
selection blocks dependent final authoring, not other candidate/source work.
Independent technical review, Scope reconciliation, instructor selection, final
worked solutions, pedagogical authoring, workload trial and local/hosted Colab
checks retain separate gates. Fast scripts do not validate an hour of student work.

## Returned evidence and independent technical review

All three bounded investigations returned without selecting examples. Exact
task results remain in their owning branches, not merged here:

- L07 `investigate/l07-geometry-20261015@d2404b3`,
  `/tmp/pml-l07-geometry-20261015/Lectures/L07_Inference/notebook_geometry/report.md`.
- L09 `investigate/l09-geometry-20261015@f64fb54`,
  `/tmp/pml-l09-geometry-20261015/Lectures/L09_Variational_Inference/notebook_geometry/REPORT.md`.
- L10 `investigate/l10-geometry-20261015@0e5a393`,
  `/tmp/pml-l10-geometry-20261015/Lectures/L10_MCMC/notebook_geometry/report.md`.

Next bounded owner `/root/inference_geometry_review`: independent technical
review, base this record's next commit; branch `review/inference-geometry-20261015`,
worktree `/tmp/pml-inference-geometry-review-20261015`. Exact allowed write:
`Lectures/course_architecture_scope/reconciliation/notebook_geometry/technical_review.md`.
All candidate worktrees are read-only inputs at the stated commits. First inspect
models/objectives/reference algorithms and source records, then compare builder
claims. Selectively replay decisive checks with scratch output in `/tmp`; do not
repeat candidate search or rewrite scripts. Check densities/coordinates/Jacobians,
references/tails, actual stochastic fits and chain failure evidence, query versus
density error, same-family versus criterion comparisons, and numerical precision.
Also flag whether L10 actually revisits the L09 proposed student/supplied family,
and whether author-proposed tolerances are being mistaken for instructor choices.
Return `feasible | feasible-with-risks | blocked`, exact checked revisions,
independence, findings with owner/severity/smallest repair, and what remains
unvalidated. No model selection, Scope approval, learner pilot, new candidate,
dependency edit, merges or student authoring. Worker is not alone and must not
revert peers or modify any input. Further teaching feasibility and instructor
selection remain separate from this technical review.
