# L07 — Inference as computation: a local Gaussian and a checked numerical reference

**Status:** provisional five-part Lecture Scope, pending independent Section Design feasibility review and global reconciliation; no approval asserted. **Stage/mode:** Lecture Scope / BUILD. **Builder:** `/root/build_l04`, 2026-10-11. **Branch:** `scope-l03-l12-course-architecture`; checkpoint `791e71b`. **Input contract:** [architecture audit v2](../course_architecture_scope/architecture_audit.md), blob `12ae5e1608eb2d74c6c70ba857eb5a75ff2114c1`. [WORK_ORDER](../course_architecture_scope/WORK_ORDER.md) delegates autonomous provisional choices; consequential questions go to the coordinator. This artifact owns scope only, not sections, slides, figures or notebook code.

## Starting boundary, sources and route choice

The actual L01 deck and `InClass/Solutions/lecture1_missing_data.ipynb` establish joint/marginal/conditional operations, Gaussian moment/precision coordinates and exact-versus-sampled conditional inference for a known Gaussian. Their delivered ledger boundaries remain B2 §2.3.2/B1 §3.3. Using PyMC did not establish MCMC correctness. Protected L02 `section_design.md` promises exponential-family moments, moment matching, maximum entropy and categorical/Markov learning through B2 §2.6.3; it is agreed, not delivered. Its malformed development-state text supplies no extra authority.

Inspected reviewed L03–L05 scopes supply local-factor normalization and joint-versus-marginal decisions (L03), information/KL and finite enumeration (L04), and Bernoulli/categorical GLMs, one likelihood gradient, reverse AD and SGD (L05). L05 explicitly excludes a Hessian derivation and substantive Bayesian GLM inference: **posterior curvature is new here**, not renamed review. L06 is concurrently being built; assume only its stated latent-posterior/EM bound, KL identity and monotonicity endpoint. L07 needs no deeper VI or EM machinery. All later scopes remain proposed rather than delivered coverage.

Directly inspected B2 Ch. 7 §§7.1–7.5, especially §§7.4.1–7.4.3 (printed pp. 349–352), plus §15.3.5 Eq. (15.145) and §15.3.6 Eq. (15.146). B1 §4.6.8.2 and §10.5.1 support the Gaussian/Taylor and logistic exposition. The local editions are B2 December 10, 2025 and B1 April 18, 2025; `/tmp/pml-book2.txt` and `/tmp/pml-book1.txt` are inspection aids, not course dependencies. The ledger, syllabi and notebook audit currently propose broad Ch. 7 coverage; their lists must be narrowed to the depths below. In particular, naming VI/MCMC/SMC is not teaching their algorithms.

The inspected [Berkeley Stat 238 reference](https://stat238.berkeley.edu/spring-2026/codelecturethirtysix238spring2026/) (`/tmp/berkeley-laplace.html`, SHA256 `539be24de77588d434e7a52de238194cfafa8938f7bfe8590fba6eab36496c63`) contains scalar logistic grid/VI/Laplace and an eight-dimensional frogs VI/Laplace/MH comparison. Select the **scalar model and grid/Laplace method only**. Its “exact grid” wording and stored-output accuracy commentary are not accepted: the printed scalar grid mean 2.778 and Laplace mean 2.523 do not agree to two or three decimals as the prose claims. No reference was executed here. Also correct the reversed Gaussian-prior variance-limit explanation in B2 §15.3.5: small variance strongly shrinks; large variance weakens shrinkage.

| Alternative route | Endpoint / sources | Provisional decision |
|---|---|---|
| **Local curvature → checked scalar posterior** | B2 §§7.4.1–7.4.3, selected §7.5 and logistic application; one grid/Laplace lab | **Selected.** A substantial approximation derivation advances beyond query framing, reuses L05 and gives a numerical checking skill without importing later algorithms. |
| Exact conjugate benchmark first | B2 §7.4.2 beta-Bernoulli case; grid/Laplace against analytic Beta | Lower software burden and known truth, but less forward progress after undergraduate conjugacy/L01. Keep its support/skew example optional live. |
| Broad inference-method survey | All §7.4 strategies and challenging-posterior examples | Useful map, but duplicates L08–L10 and risks shallow algorithm promises. Keep only a short ownership-aware comparison. |

No new software ecosystem or required recording. The chosen fixed eight-observation logistic variant is course-constructed, endorsed provisionally by the coordinator during this build; Berkeley supplies method/model provenance, not these data or numerical results.

## 1. Intellectual arc

These are conceptual **macrosegments, not finalized sections**. Section Design may combine/split them within the depth and budget. Transitions begin receiving segments; every resulting section ends retrospectively. The notebook handoff remains separate.

### Queries determine which computations are needed — about 16 minutes, Live

**Transition in:** L06 inferred missing quantities while fitting parameters; L05 optimized known-response likelihoods. Separate computing a conditional distribution from fitting or summarizing it.

**Purpose/source:** B2 §§7.1–7.3: identify a posterior, normalization integral, expectation and predictive integral before choosing a computation.

**Core:** carry Bayes forward as `p(θ|D)=u(θ)/Z`, with `u=p(θ)p(D|θ)` and `Z=∫u`. Mean/variance and posterior prediction are integrals, whereas MAP is an optimization. Recognize global parameters, local missing values and combined latent patterns using existing logistic/missing-Gaussian examples, without three new models. Recall exact conjugacy/Gaussians and finite enumeration; state exponential tensor-grid growth and why conditional independence may permit exact structured computation, leaving the algorithm to L08.

**Retrospective summary:** a model does not specify a single inference operation; the target query determines whether normalization, summation/integration, optimization or a posterior expectation is needed.

### A mode and a numerical distribution answer different questions — about 20 minutes, Live

**Transition in:** optimization can find a high-density parameter without computing the integral. Ask what that point loses and how a one-dimensional grid recovers a distribution numerically.

**Purpose/source:** B2 §§7.4.1–7.4.2: distinguish posterior mass from density height and establish an honest numerical reference.

**Core:** MAP alone provides no posterior spread; a mode need not equal a mean or represent most mass. State the change-of-variable Jacobian and work the short normal-to-lognormal mode example in Part 4. Restrict this warning to continuous-density modes; L04's finite-state MAP was a probability-mass decision. Introduce quadrature weights, stable shifted-log normalization, grid masses versus densities and weighted moments. Refining spacing addresses discretization; widening the domain addresses truncation. Neither is guaranteed by a normalized plot. A converged grid is a numerical reference, not analytic truth.

**Retrospective summary:** MAP is a coordinate-dependent density summary; grid quadrature estimates normalized probabilities and expectations, whose credibility requires spacing and domain checks.

### Taylor curvature yields a normalized local Gaussian — about 32 minutes, Live

**Transition in:** exhaustive grids become expensive in many dimensions. Use optimization to locate an interior mode, then retain local quadratic information rather than collapse all mass to a point.

**Purpose/source:** B2 §7.4.3 Eqs. (7.24)–(7.28), B1 §4.6.8.2: derive Laplace, including its normalizer and conditions.

**Core:** derive scalar second-order expansion of negative log joint at the stationary mode, exponentiate and recognize Gaussian precision. Normalize the quadratic surrogate explicitly. State the multivariate form and determinant normalizer, using L01 Gaussian coordinates. A twice-differentiable interior minimum has nonnegative Hessian, but **positive definite** curvature is required to invert and normalize this Gaussian. Boundary modes, singular curvature, multimodality or nonlocal skew invalidate or limit the construction. The approximation has mean equal to the selected mode, not necessarily the true posterior mean; its variance is local curvature, not a guaranteed posterior variance. An optional brief Beta example makes support leakage tangible. No asymptotic error theorem, parameter-transform remedy derivation or evidence-based model-selection exercise.

**Retrospective summary:** a positive-curvature quadratic around an interior stationary mode defines a normalized Gaussian approximation. Its center and spread describe local geometry, and its normalizer and posterior moments are approximations.

### One Bayesian logistic posterior tests the approximation — about 30 minutes, Live

**Transition in:** a familiar L05 Bernoulli GLM supplies a posterior whose likelihood is smooth but not Gaussian. Add a proper Gaussian coefficient prior and test local curvature against whole-distribution integration.

**Purpose/source:** B2 §§7.4.3, 7.5, 15.3.5–15.3.6 and Berkeley scalar-method precedent, with the course data below.

**Core:** reuse the Bernoulli log likelihood and gradient; derive its scalar second derivative plus prior precision. Prove strict positive curvature/coercivity for this proper-prior model, explaining finite unique MAP despite separated labels. Work the Laplace mode/SD and compare checked grid mean/SD and prediction at `x*=1`. A normalized Gaussian can still misrepresent skew or prediction; neither visual agreement nor optimizer convergence proves approximation accuracy. Apply the same predictive integral to grid and Laplace and contrast plug-in MAP. A final short method map recognizes structured exact computation (L08), VI distribution optimization (L09) and correlated posterior sampling (L10). SMC is named as a distinct sequential family intentionally omitted substantively; no algorithm, ELBO rederivation or MCMC transition proof.

**Retrospective summary:** proper-prior logistic curvature produces a well-defined Laplace approximation, while a converged grid reveals differences in posterior summaries and prediction. Approximation quality depends on the query, not solely on finding a mode or matching a plot.

### Extent and first cut

**98 minutes substantive + 12 reserve = 110 minutes**, plus a separate 60-minute lab. Reserve covers questions/transitions/slippage. All required mathematics is Live; no recording or recording candidate is excluded from this total. **Tight but plausible; timing unmeasured, confidence medium.** Novelty is concentrated in quadrature bookkeeping, Taylor normalization and logistic posterior curvature, rather than Chapter 7's catalogue.

L01's 61 content slides/70 pages and 29-slide Gaussian mathematical span are comparative anchors, not a rate. Estimated `K=4`, `P≈8–10` substantive source-page equivalents, `E_new≈10–12`, `E_carry≈12–18`, `E_deriv≈8–11`, `V≈5–6`; the provisional timing model gives about **19–23 content-slide-equivalents**, not a slide commitment or time validation. Repeated Bayes, Gaussian forms and Bernoulli gradients count as carry-forward; new families include quadrature weights/moments, transformation Jacobian, quadratic precision/normalizer, posterior curvature and predictive comparison.

**First cut:** remove the optional Beta support-leakage calculation and multivariate determinant illustration, about 6–8 minutes, retaining the multivariate statement, scalar normalization, conditions and logistic comparison. If a further cut is needed, return Scope backpressure rather than compress the derivation or drop grid checks. Re-estimate at section/slide drafting and partially rehearse the Taylor and grid portions.

## 2. Mathematical spine

Use natural logarithms, as L05 does; `θ` is the scalar coefficient here, `s(a)=1/(1+e^(−a))`, `E=−log u`. A constant omitted from `E` does not change posterior shape/MAP but does change evidence normalization.

| Object/result | Purpose, treatment and delivery |
|---|---|
| `p=u/Z`, `E_p[g]=∫gp`, predictive `∫p(y*|x*,θ)p(θ|D)dθ` | **Apply** Bayes/expectations; **Motivate** query distinction, Live. Evidence is mentioned, not model-selection training. |
| `r=f(θ)`, `p_r(r)=p_θ(f⁻¹(r))|d f⁻¹/dr|` | **State + Work** one mode example, Live; no general transform-calculus development. |
| `Z_grid=Σ_j u(θ_j)ω_j`; mass `w_j=u_jω_j/Z_grid`; moments `Σ_jw_jg(θ_j)` | **Derive + Work**, Live; equal-width density is `w_j/Δ`, not `w_j`. Stable log shift **Motivate**, implementation Notebook. |
| `E(θ)≈E(hatθ)+½H(θ−hatθ)²`, `H=E''(hatθ)>0` | **Derive carefully**, Live; stationary first-order term vanishes only under the interior differentiable-mode condition. |
| `Z_L=e^(−E(hatθ))√(2π/H)`, `q_L=N(hatθ,H⁻¹)` | **Derive scalar normalizer**, Live. `Z_L` approximates `Z`; it is exact only for the quadratic surrogate. |
| Multivariate `q_L=N(hatθ,H⁻¹)`, `Z_L=e^(−E(hatθ))(2π)^(d/2)|H|^(−1/2)` | **State + Explain**, Live; determinant illustration optional. Require symmetric positive-definite `H`, not merely semidefinite. |
| Logistic `E=θ²/(2τ²)+Σ[log(1+e^(x_iθ))−y_ix_iθ]+constant` | **Work**, Live; model likelihood reused from L05, prior added explicitly. |
| `E'=θ/τ²+Σx_i(s_i−y_i)`; `E''=τ⁻²+Σx_i²s_i(1−s_i)>0` | Gradient **Apply**; curvature **Derive**, finite unique minimizer **Proof sketch** (strict convexity plus Gaussian-prior coercivity); Live. No Newton/IRLS theory or generic Hessian catalogue. |
| `m_L=hatθ`, `v_L=1/E''(hatθ)` versus grid posterior moments | **Work + Compare**, Live; distinguish approximation mean from actual posterior mean. |
| `P(y*=1|x*,D)=E_p[s(x*θ)]` versus `s(x*hatθ)` | **Apply/Compare**, Live and Notebook; generally `E[s(x*θ)]≠s(x*E[θ])`. No probit formula or new sampler. |

KL from L04 and ELBO from L06 support only recognition of VI's later role. Laplace does not minimize a promised KL objective. L08 may use Gaussian curvature notation but owns sequence recursions; L09/L10 own their algorithms.

## 3. Notebook handoff — a checked scalar logistic benchmark

**Entry:** the full fixed model, log posterior/curvature, Laplace normalization, grid weights and prediction have been established. Students bring NumPy and L05 gradient/optimizer literacy; no advanced SciPy solver, quadrature package or PyTorch Hessian API expertise is assumed.

**Source/adaptation:** Berkeley's scalar case uses `n=30`, `x=linspace(−2,2)`, simulated Bernoulli labels, prior `τ=2`, SciPy `expit/logsumexp/minimize/norm`, and a fixed `[-8,8]` 10,000-point grid. Retain the method, replace random data with the course's fixed eight observations, and add explicit convergence checks. Use NumPy/SciPy/Matplotlib; omit reference pandas/statsmodels/PyTorch, Gauss–Hermite VI, frogs data and MH. No new required ecosystem, external data or sampler.

**New work:** complete stable negative log posterior and curvature calculations, obtain a supplied-solver mode, build weighted grid probabilities, compare density/moments/predictive probabilities with Laplace and plug-in MAP, and change domain and resolution independently. The live calculation is one local fit; the lab establishes whole-distribution numerical reliability and query differences.

**60-minute scaffold:** 8 minutes model/data/axis orientation; 12 log posterior and solver/curvature checks; 15 grid normalization and moments; 12 domain/spacing convergence; 8 supplied comparison plots and prediction; 5 interpretation/debug reserve. Solver wrapper, mesh/weights, plot and comparison-table infrastructure are given. One parameter/prior sensitivity manipulation is optional outside the core hour; no second model or sampling implementation.

**Reference criteria:** check stationarity, positive curvature, normalized quadrature masses, finite posterior summaries and stable predictive probabilities. Refine spacing at fixed domain and widen domain at fixed spacing; stability of mean/SD/prediction plus declining boundary density supports, but does not mathematically bound, remaining tail error. A deliberately narrow domain exposes misleading normalization. The authoring stage sets/times numerical tolerances; no arbitrary “exact truth” label. Keep Gaussian tails in Laplace prediction accounted for too. Distinguish numerical integration error from the residual Laplace approximation error.

**Endpoint:** construct and challenge a numerical posterior reference, then assess a local approximation for specified summary/predictive queries. No required recording. Clean local uv, hosted Colab and student-workload checks remain future publication obligations; inspected source and scratch mathematics are not notebook execution evidence.

## 4. Concrete examples

**Fixed logistic endpoint — Work through, Live/Notebook, course-constructed:** `x=(−2,−1.5,−1,−0.5,0.5,1,1.5,2)`, `y=(0,0,0,0,1,1,1,1)`, `Y_i|θ~Bernoulli(s(x_iθ))`, `θ~N(0,4)` (`τ=2`), conditional independence across observations, no intercept. The labels are separable: unregularized slope MLE escapes to positive infinity; the Gaussian prior makes the posterior proper with finite unique mode. At zero, `E'(0)=−5`, `E''(0)=4`.

A builder scratch calculation using standard-library bisection/trapezoidal integration gives `hatθ≈2.272283`, `H≈0.734161`, Laplace SD `≈1.167090`; the checked grid mean/SD are approximately `2.688288/1.199567`. For `x*=1`, plug-in MAP gives `≈0.906555`, grid prediction `≈0.901938`, Laplace-integrated prediction `≈0.863072`. The approximation is not uniformly better than plug-in for every query; this particular comparison is diagnostic, not a universal ranking. Domain expansion `[-8,8]→[-12,12]→[-16,16]` and spacing refinement `0.004→0.002` stabilized these rounded targets. These are builder mathematical checks, not an independently reviewed/executed course notebook or certified tail bound.

**Coordinate-dependent mode — Brief Work, Live, course-constructed:** `Θ~N(0,1)`, `R=e^Θ`. Transforming the normal mode gives 1, whereas the transformed density's mode is `e^(−1)` because of the Jacobian. Probability beliefs are transformed consistently; a density-height maximizer is not invariant. No second lab.

**Support/skew caution — optional Brief Compare, Live:** B2 §7.4.2/Fig. 7.3 uses 10 heads, one tail and uniform prior, hence `Beta(11,2)`. Its mode `10/11` and mean `11/13` differ; a Gaussian on that probability coordinate assigns mass outside `[0,1]`. Recall conjugacy and interpret the failure without a second full inference derivation or notebook. A logit transformation requires its Jacobian and is not a silently equivalent MAP procedure.

Available book figures include 7.1, 7.2, 7.3 and 7.6; only the optional 7.3 example's mathematics is selected. About five to six semantic visual groups support query distinctions, grid mass/density, quadratic curvature, logistic shape/moment comparison and convergence/prediction. No exact figure reproduction, layout or asset creation is committed.

## 5. Lecture contract

**Starting assumptions:** prior probability/Bayesian modeling and L01/L02 commitments, reviewed L03–L05 handoffs above, and L06's bounded EM endpoint. **Central question:** how can optimization supply a posterior approximation, and how can numerical integration reveal what it gets wrong? **Lecture endpoint:** derive and normalize Laplace under its actual conditions, apply it to one logistic coefficient and distinguish a mode, local uncertainty, checked posterior moments and prediction. **Lab endpoint:** a convergence-challenged grid reference and query-specific Laplace comparison. **No required recording.**

Supported outcomes: identify a query's computation; derive scalar Laplace and explain positive-curvature/interior-mode requirements; distinguish density MAP from probability summaries; obtain a proper-prior logistic approximation; validate grid spacing/domain sensitivity and assess posterior/predictive discrepancies.

| Allocation | Exact commitment |
|---|---|
| **Core/Live deep** | B2 §7.4.3 scalar Taylor/normalizer; selected §7.4.2 quadrature; scalar logistic curvature/application (§15.3.5), selected §7.5 comparison. |
| **Short bridge** | §§7.1–7.3 query/latent taxonomy and exact possibilities; §7.4.1 MAP limitations; multivariate formula; §15.3.6 predictive integral only. |
| **Notebook owned** | Stable implementation, complete grid moments/prediction, spacing/domain study and comparison on the one fixed posterior. |
| **Optional** | Beta failure comparison and determinant illustration; prior-sensitivity extension outside required lab. |
| **Deferred, named owners** | Exact sequence/messages L08; VI algorithms L09; MC/MCMC correctness and diagnostics L10. §§7.4.4–7.4.5 are recognition here, not primary algorithm coverage. |
| **Omitted deliberately** | Substantive SMC/Ch. 13 (mention only §7.4.6), §7.4.7 challenging-posterior tour, Bayesian-risk/model-comparison framework, Laplace asymptotic proofs, multiple modes/mixtures, INLA, constrained/transformed Laplace derivations, full Bayesian GLM/IRLS and frogs/VI/MH reference extensions. |

Future ledger/syllabus bookkeeping must separate these selected depths from delivered coverage and remove “numerical gold standard” or blanket §§7.4.1–7.4.7 teaching promises. B2 progression reaches selected §7.5; B1 use is isolated backfill, not a new contiguous boundary.

**Consequential questions / risks to coordinator:**

- **Medium priority, Scope-owned:** confirm a controlled fixed/separated scalar dataset instead of the reference's random 30-case example. It exposes prior regularization, skew and prediction differences without data setup; keeping source data would require freezing observations and rechecking all targets. The eight-case choice is provisional and coordinator-endorsed.
- **Medium priority, downstream-owned:** grid checks and density/mass distinctions may dominate the hour. Supply solver/mesh/plots and preserve independent domain/spacing checks; remove optional sensitivity first. If core checking cannot fit, escalate the endpoint/time change to Scope rather than call an unchecked grid exact.
- **Low priority, Scope-owned:** optional Beta example gives a clear support failure at a six-minute cost. It is first cut and creates no later dependency. Formal syllabus should not promise it.

**Next owner:** coordinator dispatches independent Section Design feasibility review against this artifact revision, testing the substantial Taylor/normalizer chain, new curvature prerequisites and 60-minute numerical-checking workload. Builder stops editing on handoff. A preview is not approval or measured feasibility.
