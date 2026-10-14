# Independent L07–L10 reconciliation assessment

**Reviewer:** `/root/assess_l07_l10`, Lecture Scope / `feasibility-review`, 2026-10-14. **Worktree:** `/tmp/pml-l04-l12-reconciliation`, branch `assess-l04-l12-reconciliation-20261014`. **Baseline:** `16850fbda82ff9a4a0a665ddab52115cda14a2bf`. This report assesses existing proposals and recommends bounded repairs; it grants no instructor approval and changes no scope, map, skill, notebook, section or slide artifact.

**Verdict: feasible-with-risks.** The mathematics of the existing four lectures is sound at the specified depths, and the proposed shared Bayesian classifier is a credible additional practical thread. Its one-hour student tasks remain unvalidated. The shared task cannot replace all the current diagnostic cases: Gaussian-prior logistic regression has no separated posterior modes, and a diagonal VI versus full-covariance Laplace comparison changes both the fitting criterion and the family. Those are consequential design constraints, not failures that more notebook scaffolding alone can solve. Mathematical confidence is high; application/constructibility confidence is moderate; student-time and hosted-runtime confidence is low because neither was tested here.

## What was assessed and which authority governs

| Artifact | Exact baseline Git blob |
|---|---|
| `course_architecture.typ` | `cb111196e44df211e39864be596233a1a3f22aba` |
| `curriculum_map.typ` | `63fb5cea0a7b0a4c908c8f803e550d087d20a412` |
| `curriculum_map_actual.typ` | `cf143d8c5427030cf3ac6c6ad05d8ad9cd420fe3` |
| L07 scope | `43c403d65e58e1b852517dd7b2785de1f84933e8` |
| L08 scope | `8c442b362e4610edc4212988074c855b00e843b3` |
| L09 scope | `89ee9f324fd0384972ff1ef52c446d6b146367d6` |
| L10 scope | `9ce5a70b8ac1e1506820134b1a01d06b976c072f` |

Read AGENTS, lecture-scope skill, backpressure and timing calibration; all four complete scopes and adjacent source-arc critiques; the original independent L07–L10 reviews, including L09's targeted HMC recheck; STATUS, architecture audit, source inspection, notebook-reference audit, teaching-choice and planning records, and START_SCOPING. Earlier reviews concern their own explicitly identified versions. They support the isolated diagnostic labs and do not validate the newer classifier tasks. The current actual map and START_SCOPING explicitly establish that **no lecture has been taught**. Older descriptions of a delivered L01 book boundary or obsolete ledger are stale metadata, not student knowledge.

The instructor's current permission allows independent later-course investigation during L01 work. No L01-first process note blocks this review. The future scopes remain proposals. Their honest acknowledgements of a preferred Kalman forecasting lab, GDP regression and richer HMC use must survive reconciliation. A preference is evidence for a consequential choice; this report found no document approving the HMM substitution as an equivalent forecasting outcome.

## Recovered work prevents repeating an already tested source repair

Git contains a stronger source-grounded proposal that is absent from the assigned baseline. Commit `dd4f2c5053f29590845ae42a6331d245d773218c` (2026-10-12, *Revise L04–L12 source arcs with independent course reviews*) contains independent source reconstructions, revisions and Section Design previews. Its STATUS explicitly marks **final instructor acceptance pending**. It is evidence to reuse, not accepted scope authority.

The local reflog records `scope-l03-l12-course-architecture@{1}` as the `dd4f2c5` commit and `@{0}` as a reset to `3490f42`, then-current origin. No named local/remote branch currently contains `dd4f2c5`. This explains its absence without proving why the reset was chosen. Do not infer instructor rejection, acceptance or intentional mathematical deletion from that Git operation. The current remote scoping branches retain the same four old blobs as the assigned baseline.

| Recoverable proposal / review | Exact object and result |
|---|---|
| L07 revised scope | `696469ed003bfcad7d3c1083c927f6cbce3fba19`; global/local unknowns, queries and point/distribution/sample representation comparison restored at work/state depth; opening 16→24 minutes, funded by omission of Beta and determinant illustrations, Laplace 32→24; total 110 retained. |
| L07 post source review | `source_arc_agent_reviews/L07_post.md`, blob `968c9eee07c3379d81d5cc91c29ffd6458f1abb2`; independent `/root/clean_source_confirmation`: justified reorganization, feasible-with-risks. |
| L07 Section preview | `L07_section.md`, blob `39f85816e83d4c3f7e13cfc7e76dd15a310f8013`; independent `/root/section_inference_preview`: feasible with advisory risks; eight-minute funding is the upper end of an unmeasured estimate. |
| L08 revised scope | `5be1ba64a993ab46364c8bd6ff9b7b8d8c023e20`; explicit separator, common Bayes filtering operation, categorical/Gaussian closure and bounded tree/loop comparison; six-minute replacement funded by Viterbi mechanics and matrix-list narration; total 112 retained. |
| L08 post source review | `L08_post.md`, blob `7e0a1f33adec0d2385ec0023741b0f4ff8b1f78d`; independent `/root/clean_source_confirmation`: faithful selection with justified cross-chapter reorganization, feasible-with-risks. It explicitly **disagrees** with the old adjacent critique's claim that baseline lacked the source message argument; baseline already groups histories from factors and invokes past/future independence. |
| L08 Section preview | `L08_section.md`, blob `5ee579431914b1201237e6375a780dba9fc0bce6`; independent `/root/section_inference_preview`: feasible with advisory risks; retained message notation and Gaussian meanings still take time. |
| L09 / L10 confirmation | Scopes `dd7665143dbbcd5af443e6ca54c1a6a4baa9f3fa` / `884a24c67187557546c74d0e3935f08fc67edd93`, byte-identical to that run's baseline `115f2a3`; independent post reports `34049949b4962cd83adcc01cdf016ddfc789733f` / `b2e9cd5aa63324490cd2c9cdaab0936c1b79cdf0`: faithful selective arcs, no mandatory source repair. L10 reviewer specifically finds recognition-only HMC adequate and no source reason to rewrite its sequencing. |
| Whole-course check | `whole_course_post.md`, blob `ebfa6b9b9f730aaec990f96f452fca3e4f8f2c02`; independent `/root/whole_course_source_arc`: justified reorganization / feasible-with-risks, with no course-arc blocker at those targets. |

All paths in this table are under `Lectures/course_architecture_scope/` at **commit dd4f2c5**, not current-tree links. Recover with `git show dd4f2c5:<path>`; original reports retain raw evidence, target versions, reviewer independence and limits. Read the post reports and Section previews directly here, along with source passages and the scope deltas. Their claims are not new independent checks performed in this turn. Their stale delivery wording is qualified by current authority. The minimum source reconciliation is to consider this prepared work for selective reuse; recreating it or automatically importing the whole commit would be unnecessary.

## The computational objects and practical capabilities

For a shared Bayesian binary classifier, let rows of X be feature vectors including any declared intercept, labels be y, and weights be w. With a proper Gaussian prior, the model is

$$
p(w\mid D)\propto N(w\mid0,\Sigma_0)\prod_i \operatorname{Bernoulli}(y_i\mid\sigma(x_i^Tw)),
\qquad P(Y_*=1\mid x_*,D)=E_p[\sigma(x_*^Tw)].
$$

The data split, training-only transformations, feature choice, prior and query points must remain fixed across L07/L09/L10. Changing any of them creates a different comparison. Existing L07 numbers belong to its eight separated observations, one slope, no intercept and prior variance four; they cannot be reused as numerical targets for Iris.

| Lecture | Reusable mathematical move and required prerequisite | Intended student competence, output and evaluation |
|---|---|---|
| L07 | Derive scalar Taylor/normalizer and logistic curvature; state multidimensional positive-definite Hessian. Requires L01 Gaussian precision, L05 likelihood gradients and Bayes; L06 bound is context, not a mathematical Laplace prerequisite. | Construct/use a local Gaussian `q_L=N(w_MAP,H^-1)`; compare plug-in and posterior-averaged probabilities with checked integration. Evaluate held-out log score separately from approximation error at declared queries. A good peak or small predictive error does not certify posterior shape/tails. |
| L08 | Derive forward/backward sums, normalization/evidence and complexity; apply L01 Gaussian conditioning briefly. Requires L02 categorical transitions and L03 factorization/separation. L07 supplies query vocabulary; L06 is context. | Given known transition/emission parameters, infer filtered/smoothed state probabilities and distinguish path MAP from per-time decisions. Verify tiny enumeration, including asymmetric transition indexing; assess probabilities/uncertain transitions and declared state-decision loss on supplied truth. No HMM training or forecasting competence follows automatically. |
| L09 | Apply L06 ELBO identity, work exact diagonal Gaussian geometry, derive total pathwise gradient; state/work bounded CAVI. Requires L01 Gaussian regression, L05 AD/SGD/PyTorch and L06 bound. L10 theory is not needed first. | Fit a diagonal q with the full-data likelihood and one global prior KL; differentiate through means/scales, check the actual fixed-noise estimator and distinguish family error from unfinished optimization. Predictive probability and posterior-logit uncertainty comparisons have different meanings. Retain the Gaussian diagnostic to identify those errors exactly. |
| L10 | Derive IID error and full MH correction, prove balance⇒invariance, bounded Gibbs cancellation and stationary finite-average variance. Requires probability, L02 transition notation and query discipline; L09 is context, not MH prerequisite. | Run/check one MH kernel, retain rejected stays, estimate a declared posterior expectation or predictive probability, compare chains/starts and query-specific MCSE/ESS with a reference. Preserve bimodal exploration checks. Recognition-only HMC is a bounded competence, not ability to derive or implement HMC/NUTS. |

L08 shows a distinct exactness regime. The separator gives `p(z_t,y_1:T)=p(z_t,y_1:t)p(y_(t+1):T|z_t)`, making reusable messages possible. Dense finite-state recurrences cost `O(TK²)` versus `K^T` paths, with stored beliefs `O(TK)` and a streaming filter `O(K)` work memory. Gaussian closure supplies another representation under linear-Gaussian assumptions. Sparse factorization alone does not guarantee cheap exact integration, and exact inference under a model does not make that model correct for the observed sequence.

For L09, `F(q)=E_q log p(D,w)+H(q)` is fitted by reverse KL. On exact target `N(a,S)`, best diagonal q has `m=a`, `D_jj=1/(S^-1)_jj`, not `S_jj`. The existing sum/difference variance example shows both under- and over-estimation for different linear queries. This is unusually strong evidence; preserve it at work/interpretation depth rather than replace it with a generic claim that VI is overconfident.

For L10, `πT=π` is a property of the transition, not the accuracy of `N^-1 Σg(W_n)`. The stationary finite-run variance is

$$
\operatorname{Var}(\hat\mu_g)=\frac{\sigma_g^2}{N}\left[1+2\sum_{k=1}^{N-1}(1-k/N)\rho_g(k)\right].
$$

It requires stationarity and finite variance; long-run ESS and CLT error statements require further assumptions. Initialization/exploration failure adds a distinct concern. MCSE is numerical uncertainty in a query estimate, not posterior spread. A constant region indicator in a stuck chain does not establish zero error. HMM model transitions in L08 are not a posterior MCMC kernel.

## Consequential constraints on the shared classifier

**C1 — Coordinator / Lecture Scope; advisory, high priority: select a common task without losing the diagnostic argument.** For Gaussian-prior logistic regression,

$$
\nabla^2[-\log p(w,D)]=\Sigma_0^{-1}+X^T\operatorname{diag}(p_i(1-p_i))X\succ0.
$$

The posterior is strictly log-concave with a unique finite mode, including separated labels, when the prior covariance is positive definite. It can be skewed or correlated, but has no separated posterior modes. A shared logistic classifier therefore cannot replace L10's bimodal stress test. In one coefficient diagonal versus full covariance is also vacuous. In a benign well-identified classifier, approximation errors in predictions may be tiny; that is a useful positive result only if it does not masquerade as broad validation of every method.

**Minimum repair:** choose a small common classifier with at least two uncertain parameters, and retain the scalar Laplace/grid, correlated-Gaussian family/optimizer and bimodal mixing cases as bounded diagnostics with supplied infrastructure. The common classifier becomes the practical main encounter; diagnostics retain their mathematical jobs. Treat this as a substantive notebook-endpoint choice requiring instructor acceptance, then targeted source/Section feasibility review. It is not permission to add three complete second applications.

**Alternatives:** (a) retain all current isolated labs and demonstrate the shared classifier through supplied results; protects deep checks, gives less student practice selecting methods on a fixed learning task; (b) share a classifier as proposed, with diagnostics compressed into short checked interpretation/completion steps; stronger transfer at fixed task, but new workload validation needed; (c) share Gaussian regression; strongest exact references, but full Gaussian VI and Laplace coincide on the Gaussian target, so fitting-criterion differences disappear. Recommend (b) provisionally, with a small two-parameter model and explicit failure criteria for the pilot. No option is approved here.

**C2 — Lecture Scope / notebook authoring; advisory, high priority: separate family from fitting criterion.** Full-covariance Laplace compared with diagonal VI changes two things. Any observed discrepancy may reflect both lost correlation and the distinction between local curvature fitting and reverse-KL fitting. Both methods can supply Gaussian marginals, conditionals and draws; sampling from q does not distinguish them.

**Minimum repair:** show a supplied same-family comparison (full Gaussian Laplace versus full Gaussian VI), then identify diagonal VI as a second restriction. Do not require students to implement a second optimizer. Alternatively keep the two different families but explicitly limit attribution, using the exact Gaussian diagnostic to isolate the family restriction. The former better supports the architecture's method distinction; the latter reduces software burden. Student diagonal pathwise work and L12's prerequisites stay intact. Deterministic objective monitoring or multiple initializations provide optimizer evidence; a training trace alone is insufficient.

**C3 — Lecture Scope / notebook authoring; advisory: define which uncertainty and performance justify the method.** The Bernoulli predictive variance is `r(1-r)` for posterior-averaged r. The spread of `σ(x_*^Tw)` across weight draws is a different measure of parameter-dependent uncertainty. A few held-out labels cannot reliably establish calibration improvements. Coefficient covariance differences can coexist with almost identical class probabilities.

**Minimum repair:** retain held-out log score/accuracy as empirical task checks, and also compare selected posterior means, logit/parameter projections, probability expectations and their reference errors. Use reliability displays as descriptive, not guaranteed evidence that one method calibrates better. Specify a query tolerance and report wall time/memory or objective-evaluation count for supplied computations. At two parameters, quadrature is often affordable and serves as a diagnostic; Laplace/VI/MCMC's general payoff is extrapolation to larger dimensions/repeated queries, not demonstrated necessity on tiny Iris.

**C4 — Coordinator / L08 Scope; advisory consequential choice: HMM versus Kalman.** The HMM proposal gives transparent exact discrete inference and a checked recurrence implementation. It loses the prior continuous website-traffic forecasting outcome. Kalman filtering could still preserve the structural mathematical principle: Gaussian means/covariances summarize messages under linear dynamics. It requires a different primary worked method and exercise; retaining known parameters or supplied fitted dynamics would bound the workload. N4SID/system identification is an additional fitting method, not part of Gaussian conditioning.

The newer map proposes a labeled behavioral/instrument sequence but the inspected reference establishes only the casino model and simulated sequence. A domain label alone does not establish experience with behavioral or sensor data. If HMM remains primary, specify the sequence provenance, known/supplied parameters, actual state-inference task, naive baseline and state-probability/decision evaluation. A controlled simulated sequence can provide an honest first encounter with known truth; it does not validate scientific state meanings on empirical data.

**Minimum repair:** retain the HMM proposal as provisional while routing the application priority to the instructor. If forecasting is selected, replace rather than append the HMM lab, recover/validate the named Oke solution or prepare a supplied known-parameter forecast baseline, and review the changed primary derivation/query workload. A compact HMM contrast could remain, but both full algorithms/labs cannot be promised in the same hour. No later lecture mathematically requires the HMM implementation specifically: the important dependency is understanding why structure can deliver exact inference, distinct from q-fitting and finite-sample estimates. Domain breadth and practical priority, not a prerequisite dead end, decide the substitution.

**C5 — Scope / downstream authors; advisory: preserve the actual time donors.** Existing envelopes are 110/112/112/110 live minutes and 60 minutes each lab, all unmeasured. The recovered L07/L08 repairs already spend optional illustrations/mechanics as donors; those cannot fund the classifier expansion again. L09's optional numerical CAVI sweep can be removed while retaining its update meaning. No new sampling-error proof is needed before L10 to use Gaussian draws in earlier quadrature/ELBO examples. Keep L05's software refresh in L09 and protect the pathwise derivative and prior-KL scaling needed by L12. A strict 100-minute lecture cap requires further instructor-owned tradeoffs.

## Limited independent computational feasibility evidence

A scratch calculation tested whether one particularly simple shared classifier can expose the claimed differences. It is **not** a student worked solution, stochastic-VI pilot, MCMC validation, Colab pass, scope commitment or approval. Used the repository `.venv` interpreter read-only; installed nothing and changed no environment. Libraries: NumPy 2.0.2, SciPy 1.16.3, scikit-learn 1.9.1. Dataset: bundled Iris, versicolor versus virginica, sepal length plus intercept; stratified 60/40 train/test split, random state 14; standardization by training mean `6.2733333333333325` and SD `0.6843163660828879`; prior `N(0,4I)`.

BFGS MAP; trapezoidal posterior grids on `[-8,8]^2` and `[-10,10]^2`, fixed spacing .08, then .04 at the larger domain; Gaussian expectations/objectives evaluated with 24×24 and 32×32 Gauss–Hermite nodes. Supplied-comparison feasibility was examined by deterministic reverse-KL optimization of diagonal and full Gaussians. This does not validate reparameterized stochastic training or certify the global VI optimum. Full-Gaussian BFGS reported precision loss with gradient norm about `6.7e-7`; the refined diagonal run reported success. The rounded results were stable under the stated checks; grid moment changes were below `2e-15`, which is empirical numerical stability, not a proven tail bound.

| Object | Inspectable scratch result |
|---|---|
| MAP / grid mean | `(0.05680094,1.37128993)` / `(0.06739634,1.46198084)` |
| Laplace covariance | `[[.09021183,.01408747],[.01408747,.15275644]]` |
| Grid covariance | `[[.09440826,.01531051],[.01531051,.16436410]]` |
| Diagonal VI mean / variances | `(0.06305666,1.45872503)` / `(.09167190,.15309075)` |
| Full VI mean / covariance | `(0.06724080,1.46040756)` / `[[.09288138,.01371679],[.01371679,.15495380]]` |
| Maximum held-out probability error versus grid | point `.00748728`; Laplace `.01477642`; diagonal VI `.00124843`; full VI `.00031000` |
| Held-out mean NLL | grid `.57867698`; point `.57790434`; Laplace `.57845522`; diagonal VI `.57872333`; full VI `.57874368` |
| Scratch compute time | roughly .3 seconds initial / .6 seconds refined on this host, excluding environment imports; no student-workload implication |

The point baseline has slightly better held-out score on this one split although full VI is numerically closest to grid probabilities. Thus empirical predictive performance and approximation accuracy genuinely require separate comparisons. It also shows that a convenient overlapping classifier does **not** automatically provide a dramatic practical win for full VI or posterior integration. Data/feature selection needs to serve a declared question, rather than search until a preferred method wins. Correlated Gaussian and bimodal diagnostics remain necessary.

Exact scratch source records, outside the repository: `/tmp/l07-l10-classifier-feasibility.py` SHA-256 `2e20a94ed410cafe5efc24e3d12c46ae409859c20e5c07fa81868c9518ae683f`; refined script `2c09382fe0fbfe30cc885fdee350e9793058fb9ab1a357b644e178aa147ad10a`. These temporary scripts are checking material, not persistent course code. The parameters, operations, raw algorithm statuses and numerical results needed to judge the finding are preserved above.

## Focused source route and validation limits

Directly inspected `/tmp/pml-book2.txt` passages from Murphy *Probabilistic Machine Learning: Advanced Topics*, online edition December 10, 2025, against the source register. Coordinator freshly confirmed the original PDF SHA-256 `54d6bfa8cc4a367bb553bea1c5127ca63696a9655b2ca1f6137a8584dccfdbaf` at `Resources/book2-1.pdf`; Book 1, April 18, 2025, SHA-256 `89749245bc8065d7575f990815c621a091de3facca1585168fc0369542742dcf`. This reviewer did not newly render the PDF sign-error page or execute external reference notebooks.

- **Inference representation and Laplace versus VI:** B2 §§7.1–7.3, *Introduction / Common inference patterns / Exact inference algorithms*, pp.345–348; §7.4.3, *Laplace (quadratic) approximation*, pp.351–352; §7.4.4, *Variational inference*, pp.352–354. Inspect how the unknowns and query determine integration, and how local curvature differs from fitting q. The chain contrast is course-constructed; Murphy Fig.7.1b's independent per-case latents are not a chain.
- **Classifier:** §§15.3.5–15.3.6, *Laplace approximation to the posterior / Approximating the posterior predictive distribution*, pp.613–616. Gaussian-prior variance-limit prose on p.615 is reversed: smaller variance strengthens shrinkage. Predictions are an expectation of the sigmoid, not the sigmoid at the posterior mean/mode.
- **Exact structural alternative:** §9.1 and §§9.2.1–9.2.5, pp.401–409; §8.1.2, *Bayesian filtering equations*, pp.361–362; §8.2.2, *The Kalman filter*, pp.365 onward. Inspect side-evidence messages and closure, rather than reading Chapters 8–9 as promised algorithm coverage. §9.2.6.2 p.410 falsely asserts unique path MAP equals pointwise smoothed modes; the existing untied `000` versus `001` counterexample refutes it. Preserve the correction.
- **VI family versus optimization:** §§10.1.1–10.1.2, *The variational objective / Form of the variational posterior*, pp.439–442, and §10.2.1.1, *Gaussian with diagonal covariance (mean field)*, pp.447–448. Eqs.10.49–10.50 have the registered plus-KL/missing-constant errors. Use expected log likelihood **minus** prior KL and `0.5 Σ(m²+s²−1−2ρ)` for a standard Normal prior; covariance is `diag(s²)`.
- **Finite estimator versus invariant target:** §§12.2.1–12.2.2, *Basic idea / Why MH works*, pp.500–502; §12.6.3, *Effective sample size*, pp.529–531. The source's generic claim that correlation always increases variance is too strong; negative correlation can reduce it. The scope's more careful assumptions and query-dependent formulation should survive. Recognition-only §12.5.3 HMC is a legitimate selective choice, not missing future proof debt.

No scope was regenerated. No independent Section Design preview of a revised classifier scope was performed because that revised scope does not yet exist. No new student notebook, local uv notebook execution, hosted Colab run, MCMC pilot, stochastic optimization runtime, student completion trial or lecture rehearsal was conducted. Work can continue through instructor-owned application decisions and bounded feasibility research; it must not promote the current proposal or recovered reviews into approval or delivered teaching.
