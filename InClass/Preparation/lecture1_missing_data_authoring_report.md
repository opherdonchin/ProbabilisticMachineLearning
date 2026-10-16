# L01 exact Gaussian notebook — current authoring report

Stage: teaching-notebook-authoring, revision. The instructor approved extracting only the three plotting functions and requested a first-notebook student introduction. This is a reviewable draft, with current local validation; full notebook/Scope acceptance, public distribution, hosted validation and learner-time evidence remain separate.

## Knowledge report before revision

### Assume familiar

Probability/Bayesian reasoning, expectation, variance, elementary covariance/correlation, matrix algebra; basic Python, NumPy arrays/indexing/arithmetic and `@`. These are entry assumptions, not evidence that this notebook has been taught. Existing prior-course inference-package experience is unrelated to the selected exact computation.

### Previously encountered — scaffold when needed

Multivariate Gaussians, nontrivial covariance matrices and matrix shapes. Live lecture results are supplied for application: block conditioning, LGS moments/updates and vector squared-loss decomposition. Maintain explicit notation and numerical-operation explanations.

### New in this lecture/notebook

First-course-notebook operation: questions and answer cells, Markdown/code editing, supplied versus student work, ordered execution and runtime state, interpreting outputs, AI-assisted help and final clean execution. The introduction explicitly supports these rather than assuming notebook fluency. Supplied helper import/install is explained; optional `help`/`inspect.getsource` permits transparency without a new required task.

The mathematical/computational contract remains exact conditional mean/covariance and Schur complements, marginal summaries/intervals, action versus distribution and expected versus realized loss, explicit joint-to-LGS mapping, forward marginal and independent one-case generation. `np.linalg.solve` with vector/matrix RHS and symmetry/transposition, `np.diag`, `np.trace`, quantiles and one-vector Gaussian generation retain local scaffolding. Spectral/assertion/population checks are supplied, not independently practised competencies.

## Current student-facing structure

Six introductory Markdown cells orient the learner to the problem, how to start/save a copy, what cells to run/edit, placeholders/givens, execution state, AI assistance and completion expectations. They add no grading or deadline rule; submission follows separate instructor instructions. The solved notebook remains the Q&A source; the student notebook is mechanically derived. Students are directed to work in their own copy of the student notebook and use the solved source as a reference.

The technical sequence is unchanged: known joint/task → exact block conditional and individual intervals → squared-loss mean action/minimum model risk → same-joint LGS translation → fresh-case forward marginal → one generated state/noise/measurement case. Fixed reference coordinates and the separate fresh-generation seed are preserved. Hidden truth enters evaluation only. No model fitting, second student conditional implementation, sampler, baseline study or sensitivity assignment is introduced.

The notebook has **75 cells, 18 code cells, 18 immediate Q&A pairs (nine code and nine written answers), and three inline figures**. All original numbered questions and mathematical/code answers are unchanged. The new 849-word orientation adds reading time; the earlier subjective 55–75-minute author estimate did not measure this revised introduction and must not be treated as a timing guarantee.

Three plotting functions live in `notebook_support/src/course_support/l01.py`, with docstrings and explicit arguments. Notebook setup retains means, covariance blocks, fixed case and quantile; all target mathematics is visible. The small separate package requires only NumPy/Matplotlib, avoiding the root authoring environment's PyTorch/Jupyter dependencies in a Colab installation. The package revision and source link are fixed at `7304c542dd1b0bfd6762ea08d2cb384ffd7d2e39`.

## Validation and limitations

[Current validation evidence](../../Lectures/L01_Probability_Statistics/reconciliation/delivery_readiness/runtime/support_package/report.md) records source hashes, raw outputs and review provenance. Official clean local execution, numerical assertions, valid solved/student file schemas, mechanical student derivation, wheel metadata and a fresh isolated-kernel Git-install bootstrap pass. The isolated installation changes public HTTPS to local Git transport; **no hosted or public URL success is claimed**. The package worker checked pixel identity and independently read the student introduction; the coordinator inspected all three current inline figures. That reviewer also built the package, so the review is not blind.

The old instructor run was preserved in Git before replacement. Current source outputs/counts are cleared; the executed copy lives under ignored `build/notebooks/`. The student placeholders are intentionally incomplete and are not claimed to run as a solved notebook.

**Release blocker:** the pinned package commit remains local. The Colab install and GitHub source links need that revision published after explicit authorization, followed by a fresh hosted course-target run. Do not call this draft Colab-ready. Instructor review proceeds in ordinary chat, beginning with the opening through “Supplied plotting tools”; later exercises/slides/Scope await their own review.

## Prospective knowledge-state change

After actual successful teaching/completion, record these mathematical and computational constructs as previously encountered, with continued scaffolding; promote none to fluency after one notebook. Notebook cell workflow and the supplied import mechanism have been introduced, not independently mastered. Optional source inspection and supplied spectral/assertion checks remain supported tools. Prior-course baseline facts are preserved. The [knowledge-change report](lecture1_missing_data_knowledge_change_report.md) and prospective cumulative L01 section reflect this boundary; no delivered teaching is recorded.

The student generator's redundant insertion of execution counts into Markdown cells was repaired during schema validation; L01 was regenerated and both files validate. Only code cells carry execution counts.
