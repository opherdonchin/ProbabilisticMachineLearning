# Independent technical replay: L07–L10 author probes

Reviewer `/root/validate_inference_probes`, 2026-10-14. Baseline `5e4c86e`, branch `assess-l04-l12-reconciliation-20261014`. This is a targeted technical review, following worked-solution validation principles, of the new author-only evidence. It is not a fresh scope, Section Design, instructor approval, student workload assessment or hosted-runtime check.

**Verdict: the five stable probes pass the bounded technical review.** All five execute independently in a mirrored directory; every non-timing JSON field reproduces exactly. No required mathematical or implementation repair was found for their stated targets. The investigations correctly preserve the distinctions between numerical reference, Gaussian proxy, finite expectation estimate, known-model exact inference and exploratory empirical prediction. Their consequential scope questions remain instructor-owned.

## Targets, isolation and reproducibility

I read the five scripts and result files before assessing the investigation narratives, then checked the latter against the technical evidence. Scripts and their sibling paths were copied to `/tmp/pml-inference-review-replay/Lectures/…`, preserving L09/L10's relative import of the L07 model. Only mirrored outputs were overwritten. The interpreter was `/tmp/pml-l04-l12-reconciliation/.venv/bin/python`: Python 3.12.13, NumPy 2.0.2, SciPy 1.16.3, scikit-learn 1.9.1 and Torch 2.14.0+cpu. No package/environment changes were made. This review did not independently rebuild the locked environment.

The author [manifest](../../../L07_Inference/notebook_feasibility/probe_manifest.json), SHA256 `de6f5c18ec1960e9b83f144970908b52a4bc140473e60462f970e2741f2421dd`, matches **all 11 exact file targets**, including README, five scripts and five result JSON files. Its baseline/execution labels are retained. Each script ran as a fresh process, with classifier first, then dependent VI/MH; sequence and traffic are independent. Recursive comparison excluded only fields named `seconds`, `prep_seconds`, and `median_seconds`: all other keys, strings, arrays, integers and numerical values matched exactly, with maximum absolute difference **0** for each probe.

The optional traffic run read, without copying, `/home/opher/OneDrive/CurrentSemester/Teaching/Advanced Bayesian Statistics/Oke Advanced Probability Course/spring-2026/PS2/PS2-Questions/lacity.org-website-traffic.csv`. Its independently computed source hash is the expected `eb65714213b7364a79f9caa2accfa257e180a106cc9201862abf96908ffdf880`. The giant CSV was not added to this worktree.

Investigation narratives reviewed at these exact SHA256 versions:

| Target | SHA256 |
|---|---|
| L07 `scope_investigation.md` | `d85c6e7428060433a25221de1a5d6a39d823fada7f7570f28be125956121ba9e` |
| L08 `scope_investigation.md` | `3003de7c8d5b36be6be12b1642e81b7ebf8c3dcb99761e70ffc88480efb862d3` |
| L09 `scope_investigation.md` | `51d721c029d127b7ea3da7fa68b85c2191fe2f1ceb3621775300c82f9f43c209` |
| L10 `scope_investigation.md` | `30221749cdadd25ba2234528e24fa4ca69175c7b9c2140216424854fd7da7e01` |

## Classifier, Laplace and quadrature

L09 and L10 import L07's `model()`, `nll()` and numerical reference. They therefore use the same 60 training cases, 40 test cases, seed 14 split, training-only sepal-length transformation, labels, `N(0,4I)` prior and five prediction queries. There is one global coefficient vector; no method changes the likelihood scaling or prior. L10 estimates the five common probability queries and coefficient means; it does **not** evaluate all 40 test predictions/held-out score as L07/L09 do. These are bounded overlapping query comparisons, not identical evaluation coverage.

For `U(w)=Σ_i[log(1+exp(x_iᵀw))−y_i x_iᵀw]+‖w‖²/8`, the supplied gradient and Hessian are correct. The prior contributes `I/4`, making the Hessian positive definite everywhere and the posterior strictly log-concave. BFGS fits the unique finite mode, and Laplace uses its inverse Hessian. This establishes a local Gaussian construction, not accurate global probabilities or multimodal behavior.

The trapezoidal grid normalizes the unnormalized posterior over its box with proper endpoint weights. Reported domain/mesh changes reproduce as `8.88e−16` and `3.77e−15` in the 45 prediction queries. I additionally widened the fine `.04` grid from radius 10 to radius 14: maximum changes were `1.11e−15` in means, `1.11e−16` in covariance, and `3.66e−15` in predictions; normalized radius 14 outer-unit mass was `9.00e−45`. This strengthens this target's numerical check, including the coefficient moments used by MH. An outer-strip mass and agreement between finite boxes are still not a rigorous bound on mass beyond every box. No claim of analytic exactness or arbitrary-target certification follows.

Laplace's maximum prediction discrepancy `.014776` and the held-out losses reproduce. Point prediction `.577904` is slightly better on this split than integration `.578677`; the author correctly does not interpret this as a general ranking of uncertainty methods.

## VI: objective, actual training and comparisons

The minimized sampled negative ELBO is the average over fresh coefficient-noise draws of the **sum over all 60 data terms**, plus one analytic `KL[N(m,LLᵀ) || N(0,4I)]`. The KL is

$$\frac12\left[\frac{\|m\|^2+\|L\|_F^2}{4}-2+2\log4-2\sum_j\log L_{jj}\right].$$

Positive Cholesky diagonals are parametrized exponentially. Manual derivatives include `L/4−L^{-T}`, including the entropy derivative; diagonal log-scale gradients multiply by the diagonal scale. Full lower-triangular gradients and `W=m+εLᵀ` shapes are correct. Fixed-noise finite differences and actual Torch autograd reproduce the reported errors, at most `9.40e−10` and `1.78e−15` respectively.

Fresh-noise stochastic Adam genuinely trains both manual families. Three additional diagonal runs execute Torch's differentiable sampled loss, backward and Adam updates, rather than merely checking one autograd call. Their outputs reproduce and agree with same-noise manual runs to roundoff. BFGS/Gauss–Hermite is separately labelled a deterministic diagnostic optimum; it is not the training algorithm or a convergence guarantee. The analytic correlated-Gaussian diagnostic correctly gives `D=.18I`, reverse KL `.510826`, sum variance `1.8` versus `.36`, and difference variance `.2` versus `.36`.

Independent 32→64 node-per-coordinate Gauss–Hermite checks at all eight manual fitted/diagnostic Gaussians changed objectives by at most `2.84e−14`, gradients by `3.77e−15`, and predictions by `2.67e−15`. Thus the reported small optimizer gaps are not visibly driven by this integration resolution. This does not certify all iterates or global optimization. Full-Gaussian VI versus full-Gaussian Laplace holds the output family fixed and varies the criterion; diagonal VI adds family restriction. Sampling from the proxy is not the distinguishing criterion.

## MH: correction, stays and finite diagnostics

The random-walk proposal is symmetric and uses a fixed supplied Laplace preconditioner. Log acceptance is correct for that proposal, and rejection retains the current state. The independent asymmetric two-state check correctly includes the Hastings proposal ratio and demonstrates failure of target invariance if it is omitted. Four dispersed starts, three scales, fixed burn settings and query-specific diagnostics are retained in the JSON. All 12 classifier and 12 bimodal runs reproduce exactly.

The maximum classifier query/mean error `.0365847` is finite-run error, not failure of invariance. The narrow bimodal chains have zero sign crossings; constant sign queries return null MCSE/ESS and an explicit warning. Exact bimodal reference mean 1.6 and positive-region probability `.3Φ(−4)+.7Φ(4)` are correct. Batch MCSE and the described odd-lag-pair ACF cutoff are conditional stationary-error estimates, not canonical Geyer IPS, rank-normalized multi-chain diagnostics or proof of exploration. The report correctly states this and excludes ESS>N behavior under its forced nonnegative correlation multiplier. Neither discard nor acceptance rate establishes convergence.

## HMM and Kalman checks

Forward normalization, backward division by the matching next-step normalizer, smoothed marginals, and summed log-normalizers for evidence are consistent. Independent enumeration checks cover filtering prefixes, smoothing and evidence in both symmetric and asymmetric examples; zero likelihood is rejected. I additionally generated 12 non-symmetric three-state/five-observation HMMs and compared all prefixes/full marginals/evidence to path enumeration: maximum error `3.33e−16`. Exact marginals and path MAP remain different decisions. The synthetic encounter supports a method illustration under known parameters, not empirical state semantics or a universal realized smoothing improvement.

Dense arithmetic is `O(TK²)`; retained message arrays are `O(TK)`. The measured small-K wall times do not certify quadratic K scaling; the narrative correctly separates the arithmetic count from Python-dominated timing. Scalar Kalman filtered means/covariances and the seasonal eight-coordinate full covariance oracle reproduce. Additional scalar **pre-observation** Gaussian conditioning checks validate one-step observation means/variances to `2.22e−16`. Singular process covariance is valid here: propagated covariance is positive semidefinite and positive R keeps innovations invertible; Q need not be positive definite.

Traffic preprocessing reproduces 8,348,985 rows, 2,065 dates, source hash, missing-cell checks and pre-2019 transformation. Sequential predictions are saved before incorporating the current observation; later dates do not affect earlier saved forecasts. Rolling holdout forecasts may use previous holdout observations. The separate 90-step forecast starts from the 2018-12-31 filtered state and propagates without test updates. These are different information sets, and the script/report label them correctly. Baselines use previous-day/previous-week observations for the rolling task. Scores/intervals are on standardized log1p sessions; no count-scale guarantee is implied.

The scalar model reproduces RMSE 1.077968 versus weekly-naive `.531583`, with 90% coverage `.366667`. The supplied seasonal alternative gives rolling RMSE `.444625`, coverage `.866667`; open-loop RMSE `.562265`, coverage `.688889`. Its construction followed inspection of the scalar/weekly results on this period. That post hoc comparison cannot serve as final unbiased model-selection/test evidence, as the author explicitly states. Neither known-parameter implementation recovers learned N4SID dynamics or validates the absent named solved notebook.

## Issue ownership and remaining author checks

No blocking technical defect was found at the reviewed versions. The following are limits to preserve or production checks to complete, rather than retrospective approval requests:

| Owner | Severity/status | Evidence and minimum required action |
|---|---|---|
| L07 worked-solution author | Nonblocking reference limitation | Box/mesh/GH checks are strong for this target, but not formal tail bounds. Preserve “checked numerical reference”; if stronger precision/certification is claimed, provide a controlled tail/error argument. |
| L09 worked-solution author | Nonblocking inference limitation | Supplied deterministic optima and finite stochastic fits do not prove convergence. Preserve distinct family/optimizer/integration errors and full-family criterion comparison. |
| L10 worked-solution author | Nonblocking diagnostic limitation | Finite chains and heuristic MCSE/ESS do not establish stationarity or exploration. Preserve retained stays, null constant-query diagnostics and bimodal failure evidence. |
| L08 empirical worked-solution author | Required before final evaluation claims | Seasonal performance is post hoc on inspected data; freeze a new validation/test protocol if this alternative becomes a final task. Keep rolling/open-loop information sets and known versus learned parameters explicit. |
| L07–L10 notebook authors | Outstanding production checks | These are scripts, not completed worked-solution/student handoffs. Follow notebook-stage validation, clean local execution and hosted Colab gates if later authorized for production; separately measure bounded learner workload. |

This review did not verify book/tutoral source quotations or external catalog claims, recover/run Darts/N4SID, change scopes/maps/skills, or assess instructor-owned application/depth choices. Those claims remain with their existing source evidence and owners.

## Identifiable replay evidence

Transient raw reviewer evidence remains under `/tmp/pml-inference-review-replay`; it is not an additional course artifact. The author raw results and manifest remain the persistent target record. Reviewer evidence hashes:

- `manifest_verification.json`: `bd76c48fb409791ed6584031bde066e43ac0c0e5e7dd09bf24abcd5b24eaa982` (11 matches).
- `replay_comparison.json`: `737c444d5074abe86d899e8ca7c571cfca3848d074248da146475b34aa1babae` (five zero-difference non-timing comparisons).
- `extra_checks.py`: `029de3da18ac6699f3a38bedddd84c7fa5377615774570f79ba8caffc31d7c7a`.
- `extra_checks.json`: `8cb72c782db5d61d6af0e5ed3055b988e5ec6100a29d4c5ef2896f3fa2a34949` (extended box, all eight VI GH refinements, randomized HMM oracles and scalar one-step oracle).

The extended check script imports only mirrored author modules, writes only in `/tmp`, uses seed 704 for the randomized HMMs, radius 14/spacing .04 for the grid, and 64 GH nodes per coordinate for refinements. The main replay commands are those in the reviewed README, with the mirror as cwd and the explicit interpreter/source path above.
