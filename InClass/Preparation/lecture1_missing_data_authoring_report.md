# L01 exact Gaussian notebook — authoring report

Stage: teaching-notebook-authoring, revision. This is a bounded reviewable draft under the accepted exact-only route, not complete Scope/workload approval or a publication claim. Ownership is restricted to `/tmp/l01-exact-qa/`; no repository files or global knowledge records were edited.

## Knowledge report before authoring

### Assume familiar

Conditional probability, Bayes' rule, expectation, variance, basic covariance/correlation, posterior uncertainty, observed versus unknown quantities; mathematical matrix algebra and transposes; basic Python, NumPy arrays/slicing/arithmetic, `@`, and basic Matplotlib. Existing knowledge of probabilistic programming is irrelevant to the selected computation and creates no notebook prerequisite.

### Previously encountered — scaffold when needed

Multivariate Gaussians, covariance matrices beyond pairwise covariance, nontrivial matrix dimensions. Keep explicit block shapes and a notation checkpoint. Mathematical results established in the live lecture are supplied for application rather than re-proved: block conditioning, LGS moments and conditional equations, and vector squared-loss decomposition.

### New in this lecture/notebook

Partitioned Gaussian notation and Schur-complement conditional covariance; applying an exact law to three hidden/four observed coordinates; distribution versus loss-selected action; minimum conditional model risk versus realized squared error; transparent joint-to-LGS factorization; old-case inverse query versus before-observation fresh-case marginal and generation. Numerical `np.linalg.solve`, matrix-right-hand-side solves, the transpose route for a right-side inverse, `np.block`, `np.diag`, `np.trace`, analytic normal quantiles/individual marginal intervals, and `rng.multivariate_normal` require local explanation. `np.allclose`/`np.testing.assert_allclose` and spectral checks appear only in visibly supplied author verification. No fast-moving inference package API is used; no version-drift exercise is needed.

This contract was written before the solved draft. Cumulative knowledge source: `.agents/skills/teaching-notebook-authoring/references/student-knowledge.md`; stale sampler-specific L01 entries do not establish a requirement to retain that route.

## Mathematical route and preserved scaffolding

The new 69-cell solved source has 18 immediate `exercise-question`/`solution` pairs: nine code answers and nine mathematical/prose answers. It preserves the original fine-grained block shapes, concrete covariance/correlation, task-schema mapping, transparent NumPy operations, explicit notation checkpoint, joint-to-LGS equations and interpretation of known-model outputs. It replaces the old two-route comparison with a connected sequence:

1. Read the supplied block model and identify the hidden-case conditional target.
2. Apply the block conditional mean/covariance with explicit linear solves; compute marginal SDs and analytic central intervals; explain why individual intervals do not give joint coverage.
3. Apply the live squared-loss identity, select the conditional mean, compute its minimum conditional model risk, and distinguish that expectation from the supplied realized-error check.
4. Translate the same joint into `mu_z`, `Sigma_z`, `W`, `b`, `Omega` with locally explained right-inverse transpose/solve syntax.
5. Compute the fresh-case forward marginal; inspect supplied moment and same-conditional verification; distinguish the three probability queries.
6. Generate exactly one unconditional fresh state, one independent noise vector and one measurement with the direct vector equation.

Every instructional question states the expected action, has the necessary formulas/facts visible beforehand, and is immediately followed by one complete solution cell. Sections close retrospectively. The last technical block is explicitly supplied author verification, not another assignment.

Arbitrary covariance construction, initial data, normal quantile, plots and checks are supplied infrastructure. `np.block` is demonstrated in setup; it is no longer a separate reconstruction task after setup already needs the full covariance. The useful covariance/correlation interpretation remains one coherent question. Conditional mean and covariance are distinct code questions; SD and interval endpoints form one coherent summary operation. The LGS algebraic identification, right-side-inverse implementation and residual-covariance computation retain explicit scaffolding without demanding another conditional implementation.

## Accepted example and portability repair

The seven-dimensional model, coordinate split and old numerical inference case are unchanged. The original full-precision seven-coordinate case is supplied data with truthful seed-2027 / NumPy-2.0.2 provenance. This implements the worked owner's author-level repair: repeated covariance eigenvalues can rotate the numerical SVD basis across numerical libraries, so runtime seed reproducibility is not a portable numerical answer key. Hidden truth remains stored separately and unprinted until all conditional moments/intervals have been computed. It never enters an inferred law.

Fresh generation uses the separately supplied `FRESH_RANDOM_SEED = 2028` and `rng_new`. There are no fixed fresh-vector answer keys or strict seeded-draw assertions. No batched draws or unfamiliar reshaping/broadcasting are used. The substantive random equations remain those in the revised validated worked solution.

## Scope of student work and exclusions

Required computation is block conditional moments, marginal summaries, mean action/minimum risk, same-joint LGS parameter translation, forward moments and one fresh case. The repeated LGS conditional and covariance/spectral/affine-generator checks are visibly supplied author verification. The unconditional-action risk comparison remains in the technical worked solution only, with no required baseline coding or study. Plot helpers use inline figures and write no external assets.

The active notebook contains no PyMC, ArviZ, pandas, installation cell, package/container explanation, generic sampling comparison, conditional draw plot, sensitivity study, parameter estimation, baseline experiment, local path or forced backend. Exactness is limited to the supplied Gaussian model. Full covariance is retained and printed; individual intervals do not conceal that coordinate dependence. Expected risk is the sum of squared coordinate errors and is clearly distinguished from one realized error.

## Knowledge state after a successful student completion — prospective

The following are proposed transitions after teaching and learner completion, not a claim that students already learned them.

### Assume familiar

Retain the entry baseline for conditioning, expectation, basic covariance/correlation, matrix algebra, basic Python/NumPy indexing and `@`. No new construct is promoted to independent fluency after one notebook.

### Previously encountered — scaffold when needed

Propose moving partitioned Gaussian notation, conditional Schur-complement covariance, exact conditional implementation with `np.linalg.solve`, NumPy vector/matrix RHS shape reasoning, `np.diag`, `np.trace`, analytic marginal intervals, distribution/action/risk distinctions, explicit joint-to-LGS mapping and `W,b,Omega` computation, forward marginal query and direct one-case generation with `rng_new.multivariate_normal` here from new. `np.block` and `np.allclose` have been encountered in supplied code; they still need support when independently required. Covariance spectral/assertion and affine-generator APIs remain supplied checking code, not practiced student fluency.

### New in this lecture/notebook

Nothing beyond the bounded listed route is established. Model fitting, missingness-mechanism analysis, empirical model validation, simultaneous Gaussian regions, physical/causal identification from an LGS factorization, tensor batching/broadcasting and independent numerical-analysis expertise remain unestablished. The notebook does not alter knowledge status of removed inference-package APIs.

A separate `knowledge_change_report.md` identifies proposed future updates to the cumulative knowledge file. No global skill file was automatically changed.

## Validation and review boundary

Clean-kernel scratch execution uses the repository uv environment after the parent's successful locked sync; no dependency or environment files were changed. The execution record, numerical outputs, extracted inline figures and validation log are in this scratch directory. All 17 code cells completed. All 18 question/answer pairs passed structural checks. The three inline figures were visually inspected: labels/legends are readable, no clipping or obscured data, individual interval wording retained. Source has only NumPy/Matplotlib/SciPy imports; no notebook data/figure file is needed. The numerical conditional mean, covariance, SD, minimum risk, LGS moment identities and generator population-joint identity agree with the validated worked route within stated tolerances.

The official repository executor check and mechanical self-work generation remain parent-owned. A scratch in-memory call to the same repository transformation checks preservation of questions/given cells and replacement/clearing of solution cells; no separately authored student narrative was created. Hosted Colab execution has not been performed by this worker. This is not a publication-ready or hosted-compatible claim.

## Subjective learner-time estimate

Estimated **55–75 minutes** for a mathematically mature student using AI assistance as intended, including reading/running supplied cells: about 10 minutes for model/task inspection, 12–15 for conditional computation/interval interpretation, 8–10 for loss/risk, 12–15 for LGS translation, 8–10 for forward queries, and 5–10 for generation/consolidation. These are subjective author estimates, not measured learner timings; code execution speed provides no evidence for them. The one-hour target remains at risk, especially the transpose/solve identity and distinctions among three laws. No accepted mathematical target was silently removed to force a time claim. The parent/instructor own complete Scope and consequential workload choices.

## Canonical integration — coordinator

Integrated at `InClass/Solutions/lecture1_missing_data.ipynb` without substantive changes to the specialist source (SHA-256 `42dec1fa6d59af3f76e9102d3c07832b944bd3c225ed5947df2766b0e03ee9b7`). The student file at `InClass/lecture1_missing_data.ipynb` was mechanically generated by `scripts/make_self_work_notebook.py`. Official clean local execution and pair-preservation checks pass; [durable validation evidence](../../Lectures/L01_Probability_Statistics/reconciliation/delivery_readiness/runtime/exact_only/report.md) records commands, hashes, outputs and the separate non-blind Scope feasibility review. The coordinator inspected the three inline figures.

The L01 planned-map cell and matching PDF now link these current draft files. The cumulative knowledge reference's L01 section was reconciled as a prospective exact-only authoring contract; prior-course baseline facts are preserved and no actual student-knowledge promotion is recorded. Hosted runtime, learner-time and complete Scope approval remain pending.
