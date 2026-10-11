# L09 — Variational inference: optimize a posterior approximation

**Status:** provisional five-part Scope; independent feasibility review and global reconciliation pending. No self-approval or instructor approval. **Stage/mode:** Lecture Scope / BUILD. **Builder thread:** `/root/build_l03`, 2026-10-11. **Branch:** `scope-l03-l12-course-architecture`; input checkpoint `9b62b6c7033f64399c81f5ba6be6a96b95ae4e68`. **Upstream:** architecture contract v3, blob `54064183398bd643a895c5e38a023f793dc2d9d6`; autonomous authority in `WORK_ORDER.md`. Only this Scope is owned here; no sections, slides, notebook code or shared edits.

## Starting boundary, source evidence and alternatives

Protected L01 establishes Gaussian conditioning, precision coordinates and known-model numerical comparisons; L02's agreed, undelivered section design establishes EF moments/moment matching. Actual delivery remains ledger B2 §2.3.2/B1 §3.3. L05 scope blob `736943b90f24826e29955115896929742f2961f5` supplies reverse AD and SGD; L06 `326267281c6b6775ac9a33d7ed4f022a859fc49b` **owns the generic ELBO/KL identity, entropy-versus-Q distinction and exact-EM monotonicity proof**. L07 `f12fba8de7339675d09a771c5f956c8ed93649d8` supplies query-specific Laplace/grid checking; L08 `b7a2de325c364bcde8230c33aaba2a5cd6b8596a` supplies exact HMM marginals/messages. These inspected handoffs establish that approximation is a computational choice, not an automatic consequence of latent variables. Reviewed future scopes are not delivered coverage. L09 does not repeat these proofs or assume L10 HMC theory; L05 PyTorch needs a short lab refresh after three intervening meetings.

**Direct B2 inspection:** December 10, 2025 edition, local PDF identified in architecture/source register; `/tmp/pml-book2.txt` §§10.1.1–10.1.2 (printed pp. 439–442), §10.1.4–10.1.5 (pp. 444–445), §10.2.1/§10.2.1.1 (pp. 446–448), selected §10.2.1.5 (pp. 450–451), §§10.3–10.3.1 (pp. 455–457), §10.3.2 inspected only as another mean-field application; §§6.3.3–6.3.5.2 (pp. 273–277). B1 adds no required new coverage: the Gaussian/backprop scaffolding already has course owners. Book 2 remains the spine.

**Source discrepancy:** coordinator's `source_inspection.md` records visual inspection of original printed p. 448: Eq. 10.49 has an erroneous plus-KL sign and Eq. 10.50 omits the constant. Direct algebra below uses **expected log likelihood minus KL**, and `KL(N(m,diag(s²)) || N(0,I)) = (1/2)sum_j(m_j²+s_j²−1−log s_j²)`. Also distinguish standard deviation `s` from covariance `diag(s²)` throughout; do not inherit ambiguous source notation. These are corrected expressions, not literal reproduction of the defective equations.

**Inspected reference:** [linreg_bayes_svi_hmc.ipynb](https://github.com/probml/pyprobml/blob/d1ea4122dcf3c2a2c02eb4e05343203b26440827/notebooks/book2/10/linreg_bayes_svi_hmc.ipynb), local pyprobml path `notebooks/book2/10/linreg_bayes_svi_hmc.ipynb`, checkout `d1ea4122dcf3c2a2c02eb4e05343203b26440827`, SHA-256 `415b81857e37701258718392c3c05db9a903f768ab59a54b03f438f211c204a1`. It downloads country ruggedness/GDP data, log-transforms GDP, includes Africa/interactions, unknown Uniform noise scale, Pyro autoguides, NUTS, and both diagonal/full-covariance fits. It is an inspected application precedent, not a validated course solution; no downloaded dataset, fitted result or runtime was verified here.

| Route | Endpoint / tradeoff | Disposition |
|---|---|---|
| **Controlled known-noise regression** | One diagonal posterior optimization against analytic Gaussian mean/covariance and predictions; B2 §10.1.2 geometry plus §10.2.1 pathwise VI | Selected: clean reference separates approximation from optimization, no pre-L10 HMC, preprocessing or new stack. |
| Simplified real ruggedness/GDP regression | Same math with known noise and supplied prepared features/data; preserves empirical context | Defensible alternate if data and fixed noise assumptions are validated. Source's unknown-scale/HMC model is not this exact benchmark; changing it requires an explicit model/data decision. |
| Ising CAVI as primary endpoint | B2 §10.3.2, repay L03 denoising with distributional means | Useful continuity, but a full CAVI derivation/solver displaces the pathwise skill needed by L12. Keep a bounded CAVI comparison on the same Gaussian target. |
| Automatic VI versus HMC on the full source model | Reference's two autoguides/NUTS | Too many implementations and transformed parameters; hides gradient mathematics and requires a new Pyro ecosystem. Omitted as required work. |

## 1. Intellectual arc

These are provisional macrosegments, not Section Design boundaries. Downstream may split/combine them within the endpoint/depth/time envelope. Connections enter receiving segments; every resulting section ends with a retrospective summary. All core treatment is **Live**; no recording prerequisite.

### A. Restricting the posterior changes the inference problem — 16 minutes

**Transition in:** L06 could compute an exact E-step; L08 exploited structure for exact sums. When those computations are unavailable, specify which tractable distributions may approximate the posterior.

**Purpose/sources:** B2 §§10.1.1–10.1.2; turn inference into an explicitly restricted optimization.

**Core:** Recall, rather than rederive, `log p(D)=F(q)+KL(q||p(w|D))`. Fixed model/data make the evidence constant with respect to variational parameters. Maximizing F minimizes reverse KL within a chosen family; a missing normalizer does not prevent optimizing expected log joint minus log q. Contrast unrestricted exact E-step with restricted q and distinguish variational parameters from model parameters/latent regression weights. Introduce diagonal Gaussian and mean-field factorization. Explain support asymmetry and why reverse KL penalizes q mass where p is very small, without a universal mode-seeking or underdispersion theorem.

**Retrospective summary:** VI chooses the best available distribution according to a directed divergence; evidence normalization cancels from the variational optimization, while family restrictions can leave irreducible approximation error.

### B. A correlated Gaussian reveals what diagonal VI loses — 24 minutes

**Transition in:** A family must be judged against a query, not just an objective trace. A Gaussian posterior with known covariance provides an exact, interpretable reference.

**Purpose/sources:** B2 §10.1.2/Fig. 10.2 supports the geometry; the exact two-dimensional target and calculations below are course-constructed.

**Core:** State Gaussian-to-Gaussian KL and work its diagonal restriction. Obtain best diagonal mean equal to the target mean and variances equal to reciprocal precision diagonals, using a short scalar stationarity calculation. Distinguish these from exact marginal variances. Work the specified correlated target: covariance is discarded and marginal variances shrink. Compare uncertainty along sum/difference directions to show that predictive variance error need not have one sign. Separate family error from optimization error using the analytic diagonal optimum; no second full-covariance optimizer. Recall known-noise Gaussian regression/LGS posterior formulas as the lab model, without a fresh conjugacy derivation.

**Retrospective summary:** The best diagonal approximation matches the Gaussian center but uses conditional-scale variances and loses correlations; accurate means or a good objective do not establish accurate uncertainty for every query.

### C. Reparameterization makes distribution parameters differentiable — 31 minutes

**Transition in:** L05 differentiated a fixed empirical loss. Here changing the variational parameters also changes the distribution under the expectation; treating a random draw as fixed would omit part of the derivative.

**Purpose/sources:** B2 §§6.3.3, 6.3.5–6.3.5.2 and §10.2.1.1; derive one Gaussian pathwise estimator.

**Core:** Set `s=exp(rho)`, `w=m+s⊙epsilon`, `epsilon~N(0,I)` independent of `(m,rho)`. Derive the expectation rewrite, the total derivative including direct parameter dependence, and the diagonal-Gaussian ELBO gradients using analytic entropy. State differentiation/interchange regularity; independent base noise alone is insufficient. Average pathwise sample derivatives to estimate the gradient; explain gradient noise versus data-minibatch noise without importing L10 variance/chain theory. Apply L05 AD to the reparameterized expression, retaining scale derivatives. State the score-function identity with its direct term as a contrast; no derivation, baseline catalogue or second coding task. Pathwise gradients need a differentiable sampling map/objective; variance is often favorable, not universally ordered.

**Retrospective summary:** An independent noise draw and differentiable transform preserve the sampling distribution while exposing a total derivative; Gaussian variational means and scales can be optimized with a correctly constructed stochastic gradient.

### D. Coordinate updates offer a bounded alternative — 16 minutes

**Transition in:** Pathwise gradients optimize a fixed parameterization. Some factorized models instead permit an exact update of one variational factor while holding the others fixed.

**Purpose/sources:** B2 §§10.3–10.3.1; show the distinction with the already established Gaussian target.

**Core:** State `log q_j*(w_j)=E_q_-j log p(D,w)+constant`, with normalization, without the full functional-optimization proof. Work one Gaussian coordinate sweep: replace other coordinates by their means in the target log quadratic, recognize the resulting Normal factor. This is a small application, not a second general CAVI derivation. Contrast an exact coordinate ELBO improvement with noisy gradient steps, and distinguish expectation over other factors from conditioning on a sampled/fixed neighboring state. No Ising solver, VBEM example or general convergence claim from coordinatewise concavity alone.

**Retrospective summary:** CAVI updates a distributional factor using an expected log joint; exact coordinate updates improve the variational objective but remain constrained by the same family and need not recover the true posterior.

### E. An analytic KL and explicit queries make VI checkable — 13 minutes

**Transition in:** Both optimizers target a bound; interpreting the approximation also requires correct objective signs, scaling and query evaluation.

**Purpose/sources:** B2 §§10.1.1.2, 10.2.1.1, with §10.1.5 recognition only; consolidate the lab's objective and limits.

**Core:** Apply `F=E log likelihood−KL(q||prior)` and the corrected diagonal Normal KL; check that matching standard Normals give zero KL. In known-noise regression use one global q(w), full-data likelihood and one prior KL, rather than one KL per observation. State Gaussian predictive mean and variance including observation noise. Distinguish objective estimates from exact ELBO/KL checks available in this controlled model. Recognize amortization as sharing a map from observations to variational parameters; the current lab optimizes one global posterior, not an encoder or per-row q. No network implementation or amortization-gap derivation here.

**Retrospective summary:** A correctly signed/scaled bound is an optimization objective; analytic checks and posterior/predictive queries expose errors that a stochastic loss trace alone can hide, and amortization shares inference parameters across inputs.

### Extent and first cut

**100 substantive + 12 reserve = 112 live minutes**, including summaries/transitions; separate 60-minute lab. **Tight, unmeasured; confidence medium-low.** Novel chains are diagonal reverse-KL geometry and a total pathwise derivative, with CAVI only a bounded application. L06's proof and L01 Gaussian algebra are carried support, not new coverage. Provisional calibration: `K=5`, `P≈10–14`, `E_new≈12–15`, `E_carry≈14–22`, `E_deriv≈10–14`, `V≈6–8`; prototype `S_hat≈24–30`, a warning signal rather than a slide target. L01's 61-content-slide judgment is not a measured rate for stochastic differentiation.

**First cut:** remove the six-minute numerical CAVI sweep, retaining its update rule and Gaussian factor interpretation. This yields about 106 minutes; no lab dependency changes. Retain the core pathwise derivation, correlation/query comparison and correct KL. No required mathematics moves to an unapproved recording. Later Section Design/rehearsal must return a Scope-owned repair if core depth cannot fit.

## 2. Mathematical spine

Model hyperparameters are fixed; unknown regression weights `w` are latent. Variational parameters are `psi=(m,rho)`, `s_j=exp(rho_j)>0`; `q=N(m,diag(s²))`. Natural logarithms throughout.

| Object/result | Depth / delivery and role |
|---|---|
| `log p(D)=F(q)+KL(q||p(w|D))`, `F=E_q[log p(D,w)−log q(w)]` | **Recall + Apply**, Live A; L06-owned identity. Restrict q, keep evidence constant in psi. |
| `q=product_j q_j`; diagonal Gaussian versus correlated target | **State/Motivate**, Live A/B. Family factorization is an assumption about q, not an asserted independence in p. |
| `KL(N(m,D)||N(a,S)) = (1/2)[tr(S^{-1}D)+(m−a)^T S^{-1}(m−a)−d+log(det S/det D)]` | **State + Work**, Live B. With diagonal D, **Work** stationarity giving `m*=a`, `D_jj*=1/(S^{-1})_jj`. No general Gaussian-KL proof. |
| `w=m+exp(rho)⊙epsilon`, parameter-independent standard Normal epsilon | **Derive** expectation rewrite, Live C. Distribution covariance is diag(s²), not diag(s). |
| `grad_psi E_epsilon f_psi(g_psi(epsilon))=E[partial_psi f+J_g^T grad_w f]` | **Derive**, Live C. Retain the direct term; require almost-everywhere differentiability and an integrable dominating derivative locally to interchange derivative/expectation. Gaussian quadratic model meets these conditions. |
| `H(q)=(d/2)(1+log(2pi))+sum rho_j`; `g(w)=grad_w log p(D,w)`; `grad_m F=E[g]`, `grad_rho F=E[s⊙epsilon⊙g]+1` | Entropy **State/Apply**, gradients **Derive + Work**, Live C. Analytic entropy includes explicit scale dependence; sample-average gradients target these expectations, without a monotone-SGD guarantee. |
| Score-function `grad_psi E_q f_psi=E_q[partial_psi f_psi+f_psi grad_psi log q]` | **State/contrast only**, Live C, common-support/differentiability assumptions. No score-function implementation or variance proof. |
| `q_j* ∝ exp(E_q_-j log p(D,w))` | **State + bounded Work**, Live D. Gaussian target gives `m_j←a_j−Lambda_jj^{-1}sum_{k≠j}Lambda_jk(m_k−a_k)`, variance `Lambda_jj^{-1}`. Numerical sweep optional; no full CAVI functional derivation. |
| Standard-Normal-prior KL `(1/2)sum(m²+s²−1−2rho)`; `F=E log likelihood−KL` | **Apply/Work**, Live E and Notebook. L12 specializes/reuses it; prior KL differs from KL to the posterior. |
| Known-noise regression `w~N(0,I)`, `y|w~N(Xw,sigma_y² I)`; exact `S=(I+X^T X/sigma_y²)^{-1}`, `a=S X^T y/sigma_y²` | **Recall/Apply**, Live B/Notebook, L01 LGS. Prior/noise fixed, no unknown scale or parameter-fitting E/M loop. |
| Prediction at feature vector v: mean `v^T m`, variance `sigma_y²+v^T Dv`; exact uses a,S | **Apply/Work**, Live B/E and Notebook. Distinguish latent-mean uncertainty from future-observation uncertainty. |

## 3. Notebook handoff — one 60-minute diagonal Gaussian fit

**Selected anchor:** known-noise Gaussian regression with supplied correlated synthetic design/data; B2 §10.1.2 geometry and §10.2.1 reparameterization, adapted from the inspected regression reference. One optimized diagonal Gaussian, analytic exact posterior and analytic best-diagonal oracle; **no required HMC, second full-covariance optimization or Pyro**. Parameter dimension is small; supplied data/seed/model constants are frozen and checked in the later worked solution. The tiny two-row example below is a mathematical oracle, not the entire student dataset.

The lecture supplies the bound, mean/scale parameterization, entropy/prior KL and pathwise derivative. Students reuse PyTorch tensors, loss/backward/update and NumPy solves. The lab adds a stochastic **latent draw** to familiar training mechanics, preserves gradients through the scale/mean transform, and evaluates covariance/predictions. Full-data likelihood avoids another minibatch-scaling implementation; minimize negative F, including one analytic prior KL. Supply data, initialization, optimizer configuration, bounded driver, analytic-reference routines and plots. Students own reparameterized sample/objective assembly and one fixed-noise analytic/autograd gradient comparison; no custom data loader, inference-network class or generic distribution library survey.

| Required work, including refresh | Minutes |
|---|---:|
| PyTorch refresh: shapes, requires-grad, zero/backward/update; distinguish psi from sampled w | 10 |
| Complete one reparameterized objective and check gradient at supplied fixed base-noise draws | 15 |
| Fit diagonal q using supplied bounded stochastic driver; inspect exact objective diagnostics | 12 |
| Compare learned m/D with exact a/S and best-diagonal oracle | 10 |
| Interpret supplied predictive variance/interval comparisons in two directions | 8 |
| Debugging/retrospective reserve | 5 |
| **Total** | **60** |

Durable skill: **differentiate an expectation through a sample transform and judge the resulting distribution against an exact query reference**. Distinguish optimization residual from family error; stochastic training trace need not be monotone. A supplied exact Gaussian objective checker is diagnostic, not a second deterministic training exercise. First lab cut is a repeated fit/extra noise-sample comparison if added later; preserve refresh, gradient check and query interpretation. No promised exact learned numbers, convergence tolerance, iteration duration or runtime pass. Later authoring must validate the worked solution, student extent, clean local uv and hosted Colab. Reference outputs and source inspection prove none of those gates.

## 4. Concrete examples and provenance

**Correlated Gaussian, Work/Live B and reused D/E.** Course-constructed target mean zero, `S=[[1/2,2/5],[2/5,1/2]]`; determinant `9/100`, precision `Lambda=[[50/9,−40/9],[−40/9,50/9]]`. Best diagonal covariance is `D=(9/50)I`, versus exact marginal variances `1/2`; minimum reverse KL is `(1/2)log(25/9)≈0.510826` nats. Direct rational arithmetic checked these values. B2 Fig. 10.2 supplies the phenomenon, not these parameters or claims of source figure replication.

For `v=(1,1)`, exact latent predictive variance is `9/5` versus diagonal `9/25`; for `v=(1,−1)`, exact is `1/5` versus diagonal `9/25`. Add known observation variance separately. Thus diagonal error can reverse direction for a linear query. One optional CAVI sweep starting at means `(1,−1)` gives `m_1=−4/5`, then `m_2=−16/25`, with variances `9/50`; this is coordinate distribution optimization, not a Gibbs sample or L03 coordinate MAP.

**Regression realization, Brief Work/Live B.** With standard Normal prior and noise variance 1, choose rows `X_1=(3/√2,−3/√2)`, `X_2=(1/(3√2),1/(3√2))`, observations `y=(0,0)`. Then `I+X^T X=Lambda` above and exact posterior is the same target. Algebra checked; course-constructed, not ruggedness/GDP observations. It shows that posterior correlation arises within familiar Gaussian regression. No fresh conjugate-posterior proof or empirical-accuracy claim.

**Gradient check, Work/Live C.** Scalar standard-Normal target specialization gives `F=−KL(q||p)`, gradients `partial_m F=−m`, `partial_rho F=1−s²`; at matching `m=0,s=1` both vanish. This checks the entropy sign and direct scale term, not a separate application/model. The lab performs a supplied fixed-noise check on its actual regression objective.

About 6–8 selected conceptual visual groups support family geometry, rotated versus diagonal uncertainty, sample-transform dependence, one gradient calculation, coordinate factor interpretation and posterior/predictive comparisons. No source asset reproduction or generated figure is required at Scope stage.

## 5. Lecture contract

**Start:** L01 Gaussian/LGS and numerical checks; L02 sufficient statistics; L05 AD/SGD; L06 ELBO identity; L07/L08 query and exact/approximate distinctions. **Goal:** optimize and assess a restricted posterior without differentiating a parameter-dependent expectation incorrectly. **Lecture endpoint:** reverse-KL diagonal geometry, one total Gaussian pathwise gradient and bounded CAVI interpretation. **Lab endpoint:** one checked diagonal Gaussian regression posterior with exact covariance/predictive references. **No required recording.** Estimated 112 minutes live and 60-minute lab.

Supported outcomes: explain restriction/optimization errors; interpret directed KL and query-specific uncertainty loss; derive the diagonal Gaussian sample transform/ELBO gradient with correct regularity and direct terms; recognize a coordinate factor update; implement and assess one reparameterized objective. No general VI solver, encoder or HMC mastery is claimed.

| Allocation | Commitment / boundary |
|---|---|
| **Core/Live deep** | B2 §§10.1.1–10.1.2 restricted objective/geometry; §§6.3.3, 6.3.5.2 and §10.2.1.1 Gaussian total pathwise derivative. Generic bound identity reused from L06. |
| **Short bridges** | §6.3.4 score-function contrast; §§10.3–10.3.1 CAVI update/application, numerical sweep optional; §10.1.5 amortization recognition. Gaussian KL/known-noise posterior applied, not complete source derivations. |
| **Notebook owned** | PyTorch refresh, one stochastic transform/objective, local gradient check, diagonal fit and exact/analytic-diagonal/predictive diagnostics. |
| **Deferred, named owners** | MC variance/dependent-chain analysis → L10; HMC recognition/mechanics there, full HMC theory omitted; nonlinear networks → L11; amortized encoder/decoder, VAE specialization and joint training → L12. |
| **Omitted by course decision** | Full real-data unknown-noise/HMC comparison; full-covariance optimizer; low-rank/flow family implementation; natural gradients, ADVI transforms/Jacobian catalogue, control-variate/score estimator derivations, stochastic-variational-EM/VBEM model catalogue, Ising CAVI solver, EP/wake-sleep, semi-amortized inference, IWAE and normalizing flows. These are not hidden future obligations. |

Coordinator should narrow blanket Ch. 10/§10.4 syllabus promises and record selective proposed coverage, preserving actual delivered ledger boundaries. Recognition does not mark amortized inference or structured families substantively taught. L12 may rely on pathwise differentiation and correct Normal KL but must establish its own neural amortization and VAE model contract.

**Questions/risks for consolidation:** (1) **Scope owner/advisory, medium:** synthetic controlled regression provisionally replaces the real GDP narrative to protect exact-reference mathematics and one-hour extent. A prepared known-noise GDP variant is viable after data/model validation; preserving the source unknown-noise/HMC model is a larger scope change. (2) **Scope owner/advisory:** total differentiation and covariance interpretation are tight; optional CAVI sweep is first cut. (3) **Notebook owner/downstream-owned:** include the ten-minute PyTorch refresh and supplied exact diagnostics; optimizer noise or slower refresh should reduce extra runs/scaffolding load before changing required math. No runtime evidence exists.

**Next owner:** coordinator dispatches independent Section Design feasibility review of this revision, testing Gaussian geometry plus the 31-minute total derivative, bounded CAVI and the complete 60-minute lab. Builder stops editing at handoff. A preview does not validate teaching duration, runtime or instructor acceptance.
