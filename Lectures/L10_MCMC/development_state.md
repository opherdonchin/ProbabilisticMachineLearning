# L10 development state

## Current ownership and authority — 2026-10-15

Lecture Scope / revision only. Branch `resume/l10-ais-selection-20261015`, worktree
`/tmp/pml-l10-ais-selection-20261015`, base `13b209b`. This task owns only
`lecture_scope.md`, `reconciliation/ml_rescope_brief.md` and this register.
Coordinator owns course-level status and instructor review; another owner runs
the bounded AIS pilot on `investigate/l10-ais-pilot-20261015` under
`Lectures/L10_MCMC/notebook_ais/`. Other worktrees and owners remain intact.

The [brief](reconciliation/ml_rescope_brief.md) contains exact discussion/source
records. Instructor acceptance in replacement thread
`01a14017-0a80-7150-b7e7-c6511cb25698`: “I like the idea of AIS. I think it will
work well.” Accepted: **AIS notebook direction**. The instructor explicitly asks
for delegation/backgrounding while the review continues. This narrow revision
records that decision; it does not freeze the full Scope.

## Reconciled decisions and boundaries

- The earlier introductory MH-first Scope is reopened. Proposed live direction:
  IS → MCMC → HMC, assessing accuracy of task-relevant performance functionals
  versus computation. Only a light Murphy-based NUTS reference is wanted.
- The original instructor hold (“Don't develop it: explore the idea”) still
  blocks full Scope/production development. The coordinator authorizes the narrow
  documentation revision and separate pilot; these do not lift that hold.
- Preserve the accepted cumulative Laplace → VI → sampling comparison; dataset
  continuity is optional. L09 `39dd5dc` selects Challenger thermal distress under
  the frozen all-23-flight Bernoulli-logistic model and `N(0,4I₂)` prior. It does
  not select Challenger for L10. L09's proposed student-diagonal / supplied-full
  split remains provisional; full-family reuse must be described as supplied.
- The [Scope notice](lecture_scope.md) now owns AIS selection and explains which
  old baseline notebook/omission statements it replaces. Remaining live content,
  examples and time estimates in the old body are under review, not newly approved.
- No dataset, transition kernel, family, exact queries, accuracy threshold,
  detailed student/supplied allocation, required recording or whole Scope is
  selected by AIS acceptance. No actual teaching is recorded.

## Evidence and validation

Read the existing baseline Scope/brief, coordinator envelope, accepted L09
application and proposed handoff at `39dd5dc`, exact original-thread exchanges,
and Murphy B2 December 10, 2025 §§11.5.3–11.5.4 / §13.6.2. Existing source/route
reviews (`b9e0a0e`, `4cbacf5`) retain their original targets; the AIS selection is
not itself an affected source-arc or Section Design feasibility review. Source
indexing/correctness and measured compute/query behavior belong to the separate
pilot and later technical review. No script, notebook or runtime was validated
by this documentation change; no learner-time or Colab readiness is claimed.

## Open decisions and next owner

Coordinator continues the instructor review while the pilot runs. Collect its
exact committed report before promising a dataset, efficacy claim or student
exercise. Instructor-owned choices remain: live mathematical depths and
mixed-entry bridge; L10 application/query/family and L09-family continuity;
student/supplied AIS allocation and one-hour extent. Author/reviewer-owned work
includes valid path/update indexing, support/moment conditions, honest compute
accounting, replicated query error and source corrections where verified.

After the instructor authorizes further development, Lecture Scope reconciles
its affected five-part contract and obtains the affected source/Section Design
preview before Scope approval. No L10 section/slide artifact is altered here;
any future downstream work must use that reconciled Scope. Student notebooks
require later worked-solution/pedagogy and clean uv plus hosted Colab checks.
No architecture/map/environment/shared-skill changes, merge or publishing here.
