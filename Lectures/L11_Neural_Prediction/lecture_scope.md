# L11 — Neural prediction: nonlinear conditional probability models

**Status:** Reviewed five-part scope proposal; [current agent approval and exact reviews](../course_architecture_scope/STATUS.md) are maintained by the coordinator. Instructor acceptance pending; timing and notebook implementation remain unvalidated. **Stage/mode:** Lecture Scope / BUILD. **Builder:** `/root/build_l11`, 2026-10-11. **Branch:** `scope-l03-l12-course-architecture`; checkpoint `9b62b6c`. **Input:** [architecture contract v3](../course_architecture_scope/architecture_audit.md), blob `54064183398bd643a895c5e38a023f793dc2d9d6`. [WORK_ORDER](../course_architecture_scope/WORK_ORDER.md) delegates autonomous provisional choices without instructor checkpoints. Only this Scope is owned here; no sections, slides, notebook implementation or shared-file edits.

## Starting boundary, sources and route choice

Protected L01 deck and Gaussian-imputation solution establish Gaussian conditioning and exact-versus-sampled comparison. The solution's missing-value posterior conditions on known parameters; it is not a weight posterior. Delivered ledger boundaries remain B2 §2.3.2/B1 §3.3. Protected agreed L02 section design supplies exponential-family moments, likelihood learning and categorical counts, but remains undelivered; malformed development-state metadata adds no authority.

Inspected L05 scope, blob `736943b90f24826e29955115896929742f2961f5`, owns common GLM likelihood gradients, a complete reverse-mode graph and minibatch SGD, with first PyTorch practice. L09 provisional blob `a8080351116f51a34eddd3e5dc06d65f7025722e` supplies Gaussian pathwise VI and posterior-predictive uncertainty; L10 provisional blob `9503b32aef49e7090792ea7e38d3acfb808a973b` distinguishes target uncertainty from numerical Monte Carlo error. These are planned handoffs, not delivered coverage. L11 adds a nonlinear learned predictor and input-dependent observation scale; it does not repeat GLM-family derivations, VI or sampler theory. PyTorch practice needs a short refresh after L10's NumPy lab.

**Direct reading:** B2 December 10, 2025 edition, `/tmp/pml-book2.txt`, §§16.1, 16.2.1–16.2.2 and 16.3.1 (printed pp. 631–633, 641–642); selected §15.2.2.1 Gaussian-prior connection (p. 597). B1 April 18, 2025 edition, `/tmp/pml-book1.txt`, §§13.2.2–13.2.3, 13.2.4.4 (pp. 428–434), selected §§13.3.3.2–13.3.3.3 for local derivative application and §§13.5.1–13.5.2 for early stopping/weight decay. B2 remains the spine; B1 supplies the concrete regression example and notation scaffolding. No entire chapter is promised.

Current syllabi list selected other architectures, lasso, dropout and SGD regularization more broadly. Contract v3 narrows these promises: only MLP blocks and Gaussian-prior/L2 meaning are substantive here. Coordinator must reconcile the formal artifacts rather than interpreting those lists as extra required material.

| Route | Endpoint and tradeoff | Provisional disposition |
|---|---|---|
| **Nonlinear conditional Gaussian** | B2 §16.3.1/B1 §13.2.4.4: learn a mean and positive scale; score held-out observations | Selected: a useful probabilistic endpoint, one scaffolded PyTorch lab and reusable network components for L12. |
| Nonlinear Iris classifier | B2 §§16.1/16.3.1: replace L05 affine logits with an MLP | Strong continuity and low coding burden, but another Iris fit underuses probabilistic output scale. Classification is a brief transfer example only. |
| Bayesian neural-weight inference | B2 Ch. 17/B1 §13.5.5: infer weight distributions and integrate predictions | Connects L09/L10, but adds a second inference/modeling chain and lab burden. Preserve the uncertainty distinction; omit fitting a weight posterior. |
| Architecture/regularization survey | B2 §§16.2–16.3; B1 §13.5 | Broad recognition without a worked probability endpoint. Omit CNN/RNN/attention, sparse priors and dropout theory; autoencoder purpose belongs to L12. |

Selection prioritizes continuity, one likelihood and computational reuse. No required recording or new ecosystem.

## 1. Intellectual arc

These provisional macrosegments may be split/combined by Section Design while preserving depths, endpoint and time. Connections start receiving segments; every section ends retrospectively. Required development is **Live**.

### Learned nonlinear features change the predictor — about 22 minutes

**Transition in:** L05 models response distributions through an affine predictor. Retain that probabilistic construction while replacing the predictor by a learned composition.

**Purpose/sources:** B2 §§16.1, 16.2.1–16.2.2, 16.3.1; B1 §§13.2.2–13.2.3. Explain what an MLP contributes beyond stacking linear maps.

**Core:** carry `Wx+b` and parameter learning from L05. Define hidden activations and output coordinates with explicit dimensions; work the collapse of two affine layers and one course-constructed ReLU function. Distinguish nonlinear hidden features from a probability distribution's output constraints. ReLU is piecewise differentiable; state the chosen derivative at zero without a nonsmooth-optimization detour. Use one shallow backbone, not a depth/architecture comparison. Briefly recognize that affine logits can likewise become nonlinear logits inside the already-known categorical model. The network alone does not specify a likelihood.

**Retrospective summary:** affine compositions remain affine; nonlinear hidden transformations create learned features, while the output distribution still determines what the predictions mean.

### A positive scale makes regression a conditional density — about 30 minutes

**Transition in:** nonlinear features can parameterize several distribution coordinates. The regression data have both curved mean and changing noise spread.

**Purpose/sources:** B2 §16.3.1 and B1 §13.2.4.4; establish a shared-backbone Gaussian with mean and scale heads.

**Core:** define `p(y|x,ψ)=N(y|μψ(x),σψ(x)²)`, with unconstrained mean and `σ=σ_min+softplus(aσ)>0`. Derive per-observation NLL from the scalar Gaussian density, retaining the log-scale term and variance denominator. Derive its local derivatives in mean and log-standard-deviation coordinates; interpret residual-dependent pressure on mean and scale. Apply fixed-known-scale NLL's equivalence to squared error. Work the numerical scale comparison below: arbitrarily widening intervals is penalized. A positive floor prevents zero scale numerically but neither guarantees generalization nor establishes an optimum. A very flexible unconstrained model can drive likelihood upward by interpolating observations and shrinking scales; training loss alone cannot validate the fit.

**Retrospective summary:** a mean and positive standard deviation define the conditional Gaussian; its NLL trades residual fit against distribution width, and removing log scale changes the learning problem.

### Existing differentiation and training operate on the new likelihood — about 18 minutes

**Transition in:** the probability model supplies a scalar differentiable objective. Apply the already-established L05 machinery to its new outputs.

**Purpose/sources:** B2 §16.1 with L05 §§6.2/6.3 ownership; B1 selected §13.3.3 local layer rules.

**Core:** carry the mean empirical NLL, batch averaging and reset/backward/update cycle. Apply local affine/nonlinearity derivatives to the mean/scale heads; explain summation of their contributions at the shared backbone using L05 fan-out accumulation. This is bounded application, not another full reverse traversal or a manual multilayer backpropagation derivation. Separate gradient computation from optimizer updates; nonlinear parameterization generally loses the canonical affine GLM's convexity. State training/validation/test responsibilities and given initialization/bounded training configuration. Recognize early stopping as validation-based model selection, not posterior sampling. Software boilerplate belongs to scaffolding.

**Retrospective summary:** familiar AD accumulates both head contributions and familiar minibatch training optimizes their common likelihood; low training loss and completed updates do not establish predictive quality.

### Conditional intervals represent observation noise at fitted weights — about 18 minutes

**Transition in:** a fitted distribution can generate intervals and scores. Determine exactly which uncertainty its scale represents before interpreting the plot.

**Purpose/sources:** B1 §13.2.4.4; L01/L09 conditional-versus-posterior prediction and L04 log-score interpretation carried forward. The uncertainty decomposition is course synthesis from conditional expectation/variance.

**Core:** conditional Gaussian observation interval `μhat±1.96σhat` has about 95% probability under the fitted model. It is not a credible interval for the mean, an interval for weights or a guaranteed frequentist coverage statement under the unknown data law. State posterior-predictive integration and apply total variance to distinguish expected conditional noise from variation in conditional means across weights. At one fitted weight vector, the latter is absent; scale can nevertheless absorb mean misspecification. Compare held-out NLL, mean squared error and low/high-noise interval behavior using supplied summaries. These answer different questions. One regional coverage check is an interpretation aid, not a calibration framework or OOD guarantee.

**Retrospective summary:** learned conditional spread describes observation variation at fixed fitted parameters; posterior weight uncertainty requires integration over weights, and empirical scoring/coverage must be checked rather than inferred from interval width.

### Gaussian weight priors explain a narrow L2 penalty — about 12 minutes

**Transition in:** predictive checks expose fitting flexibility. Connect one regularization choice to familiar Bayesian modeling without changing to weight-posterior inference.

**Purpose/sources:** selected B2 §15.2.2.1 and B1 §13.5.2, with §13.5.1 recognition.

**Core:** derive Gaussian negative log prior and its correctly scaled addition to a **mean** NLL. State which parameters are penalized; biases may have different treatment. Work ordinary SGD's resulting shrinkage term. Distinguish an objective's L2 penalty from decoupled optimizer weight shrinkage: equivalence holds for the stated ordinary SGD update, not generically for adaptive preconditioning. No Adam/AdamW comparison, sparse prior or penalty tuning lab. MAP gives a point estimate and does not supply a weight posterior or its epistemic variance.

**Retrospective summary:** Gaussian priors induce squared-weight penalties with explicit loss scaling; a regularized point fit remains a point fit, and optimizer shrinkage must be distinguished from the objective it updates.

### Extent and first cut

**100 substantive + 12 reserve = 112 minutes live**, plus separate 60-minute lab. Reserve includes questions, transitions and slippage. **Tight, unmeasured; confidence medium-low.** The main new chain is Gaussian NLL → mean/scale derivatives → distribution interpretation. Affine collapse and Gaussian-prior scaling are short algebraic applications, not additional full inference or optimizer derivations. L05 AD and L09 integration are carried support.

Against L01's instructor-judged 61-content-slide/70-page anchor, estimate `K=5`, `P≈7–10` substantive source-page equivalents, `E_new≈10–13`, `E_carry≈12–20`, `E_deriv≈6–9`, `V≈5–7`. The provisional calibration gives about **20–25 content-slide-equivalents**, a warning signal, not slide commitments or measured delivery. Coordinate/scale distinctions and interval interpretation consume time beyond equation count.

**First cut:** remove optional categorical transfer, numerical SGD shrinkage repetition and extra coverage stratification, approximately 6–8 minutes, retaining MLP nonlinearity, complete NLL/scale reasoning, Gaussian-prior scaling and the noise/posterior distinction. No content is silently moved to recording. Recount novelty during Section Design and time the likelihood/scale explanation; if core still exceeds the envelope, return Scope-owned backpressure.

## 2. Mathematical spine

Use `ψ` for all fitted network parameters, `h` for deterministic hidden features, `aσ` for raw scale, `σ` for standard deviation and `v=σ²` for variance. This prevents confusing a hidden activation with L12's random latent variable or a raw head with a positive variance.

| Object/result | Depth, role and delivery |
|---|---|
| `h=ReLU(Wx+b)`, `μ=wμᵀh+bμ`, `aσ=wσᵀh+bσ`; `W:H×D`, `h,wμ,wσ:H` | **Motivate + Work**, Live: shapes and learned features. General multilayer recurrence **State**; no universal-approximation theorem/proof. |
| `W2(W1x+b1)+b2=(W2W1)x+W2b1+b2` | **Work**, Live: affine depth alone does not create nonlinear expressiveness. |
| `σ=σ_min+log(1+exp(aσ))`, fixed `σ_min>0`; `∂σ/∂aσ=sigmoid(aσ)` | **State + Motivate/Apply**, Live; stable softplus implementation supplied. The floor is a numerical/model constraint, not inferential uncertainty. |
| `ℓ=(1/2)log(2π)+logσ+(y−μ)²/(2σ²)` | **Derive + Work**, Live; `L=N⁻¹Σℓ_n`. Fixed-known-scale MSE equivalence **Apply**. NLL can be negative for continuous densities. |
| `∂ℓ/∂μ=(μ−y)/σ²`; at `ρ=logσ`, `∂ℓ/∂ρ=1−(y−μ)²/σ²`; `∂ℓ/∂aσ=[1/σ−(y−μ)²/σ³]sigmoid(aσ)` | First two **Derive + Interpret**, Live; raw-head chain **Apply**, not a new log-scale model. Notebook checks the actual softplus parameterization. |
| Shared-backbone adjoint is the sum of mean/scale path contributions; batch-mean gradients and SGD | **Apply**, Live/Notebook: L05 result, no second complete reverse-mode derivation or convergence proof. |
| `μhat±1.96σhat`; `p(y*|x*,D)=∫p(y*|x*,ψ)p(ψ|D)dψ` | Interval **Apply**, integration **State/recall**, Live: conditional noise versus posterior averaging. No BNN inference implementation. |
| `Var(Y*|x*,D)=E[σψ(x*)²|D]+Var[μψ(x*)|D]` | **Apply + Explain**, Live: total variance under the stated conditional Gaussian and finite moments. This decomposition is model-relative, not identified from one fitted scale. |
| For selected weights `w~N(0,τ²I)`, `L_MAP=L+||w||²/(2Nτ²)+constant` | **Derive**, Live: mean-loss scaling. Write `λ=1/(Nτ²)` for penalty `λ||w||²/2`; prior itself is not repeatedly counted per observation. |
| Ordinary SGD `w_next=(1−αλ)w−αg_B`; decoupled shrinkage versus preconditioned penalty gradient | **Work briefly/State**, Live: narrow implementation distinction. Numerical repetition optional; no adaptive optimizer derivation. |

All new required mathematics remains live. The lab assembles this model rather than introducing another likelihood or a stochastic weight draw.

## 3. Notebook handoff — one scaffolded 60-minute PyTorch regression lab

**Inspected anchor:** [pyprobml heteroskedastic MLP notebook](https://github.com/probml/pyprobml/blob/d1ea4122dcf3c2a2c02eb4e05343203b26440827/notebooks/book1/13/mlp_1d_regression_hetero_tfp.ipynb), local checkout `d1ea4122dcf3c2a2c02eb4e05343203b26440827`, SHA256 `1e685b9e50518ab79a7448d6bfdcc27803596ae58a7ab1de9e1fbee7aeef37a6`. Source uses TensorFlow/TFP, 1,000 evenly spaced inputs on `[-20,60]`, seed 12345, two 50-unit backbone layers, 20-unit heads, Adam at 0.01 and two 500-epoch fits. Its learned SD is `softplus(10⁻³+0.05·raw)`; the constant is inside softplus, not an additive positive floor. Fixed variance is re-estimated from training residual MSE. These are inspected source settings, not required course settings, reliable outcomes or runtime evidence.

**Entry:** lecture supplies network shapes, Gaussian NLL, scale constraints, shared differentiation and conditional/predictive uncertainty meanings. Reuse L05/L09 PyTorch rather than introducing TFP, JAX or Pyro. Give data generation/splits, input scaling, backbone/model wrapper, optimizer/driver, plots, baseline and local checks. Students own nonlinear probability-head assembly and batch-mean NLL, then interpret results; no custom data loader, second optimizer or second data pipeline.

**Course adaptation:** retain the source mean/noise laws below, with supplied train/test data and train-only normalization. Provisionally use 320 training and 160 held-out points, one shallow 32-unit ReLU backbone and linear mean/scale heads; these are course choices to pilot, not source results. Keep all scalar targets/outputs as matching `B×1` tensors to prevent accidental pairwise broadcasting. Fixed-scale nonlinear baseline is supplied as a checked fitted artifact/configuration; students fit one heteroskedastic model through a bounded CPU driver. Driver/settings and a fallback checkpoint must be validated later; no epoch count, convergence or speed is guaranteed here.

**Required new work:** assemble positive scale and mean, construct the correct NLL, compare its value/derivatives with a supplied reference on one fixed batch, run one provided fit, and compare held-out mean NLL/MSE and observation intervals to the supplied baseline and known generating law. Software check includes finite positive scales, matching shapes and no detached head gradients. The source's long training and two full fits are not student requirements.

| Responsibility | Minutes |
|---|---:|
| PyTorch refresh, given data/split and tensor/model shapes | 10 |
| Complete mean/positive-scale heads and NLL | 15 |
| Supplied local value/gradient checks and one training-driver run | 12 |
| Interpret mean, interval width and held-out NLL/MSE against given baseline | 13 |
| Reserve for debugging, runtime and discussion | 10 |
| **Total** | **60** |

The notebook applies the mathematics to an empirically checked conditional model. A coarse low/high-noise coverage summary is optional; omit it first if debugging overruns. Regularization sweeps, architecture searches, weight-posterior inference and a second fit are excluded. Failure to recover truth is evidence to interpret, not permission to label intervals calibrated. No required recording. Clean local uv execution, hosted Colab Restart/Run All and workload pilot remain downstream obligations; the PyTorch port is unimplemented/unrun.

## 4. Concrete examples and provenance

**Affine collapse/nonlinear feature — Work Live, course-constructed:** two scalar affine maps compose to one affine map. In contrast `h1=ReLU(x)`, `h2=ReLU(−x)`, `μ=h1+h2=|x|` gives a nonlinear conditional mean. For `x=−1,0,1`, means are `1,0,1`. This verifies expressiveness without XOR/architecture catalogues or approximation-theorem debt.

**Correct scale scoring — Work Live, course-constructed:** at residual `y−μ=2`, `σ=1,2,4` give NLLs approximately `2.91894,2.11209,2.43023`; at `σ=2`, the log-SD derivative is zero. For this fixed nonzero residual, the local optimum is `σ=|y−μ|`; this is a single-observation calculation, not an estimator rule for every input. At zero residual, unrestricted scale tends toward zero and NLL toward minus infinity. These algebraic/numerical commitments motivate the log term and floor, not a fitted-result claim.

**Nonlinear growing-noise data — Work Notebook, Compare Live:** inspected source sets `g=(x+20)/80`, `μ_true(x)=sin(0.2x)+0.1x`, `σ_true(x)=0.25+g²`, `Y=μ_true+σ_true·ε`, `ε~N(0,1)`. Endpoint SDs are `0.25,1.25`, variances `0.0625,1.5625`; their ratio is 25. At `x=20`, SD is 0.5. The **SD**, not variance, is quadratic in rescaled input; variance is its square. Do not inherit B1's loose “variance increases quadratically” description as an exact data law. Source ±2-SD curves represent about 95.45% conditional Gaussian probability; the course uses explicit 1.96-SD interpretation. No financial/climate application, source figure replication or fit quality is promised.

**Uncertainty and penalty comparison — Brief Live, course synthesis:** contrast fixed-weight `σhat²` with posterior-weight mean variation using the stated total-variance identity. Compare one Gaussian-prior log density with the mean-loss penalty; no simulated ensemble or posterior-weight dataset is required. These consolidate distinctions rather than create additional laboratories.

Selected visual/schema groups are affine/nonlinear mapping, shared backbone/two heads, residual/scale scoring, source-law versus fitted mean/intervals, and conditional-versus-weight uncertainty, approximately five to seven groups. B2 Fig. 16.11/B1 Figs. 13.5–13.6 are inspected context; no exact figure asset is selected or authored. All source adaptations and constructed calculations remain explicitly labeled downstream.

## 5. Lecture contract

**Start:** L01 Gaussian distributions, L02 likelihood/EF coordinates, L04 log scoring, L05 reverse AD/SGD and PyTorch, L09 posterior-predictive distinction; L10 numerical sampling error is contextual, not a new dependency. **Question:** how does a nonlinear learned function define an interpretable conditional probability distribution? **Lecture endpoint:** explain MLP nonlinearity, derive/use heteroskedastic Gaussian NLL with positive SD, reuse AD/training, and distinguish conditional noise from posterior weight uncertainty. **Lab endpoint:** one checked PyTorch mean/scale model with held-out scoring and conditional-interval interpretation. **No required recording.** Estimated live112/lab60 minutes.

Supported outcomes: identify hidden/output dimensions; show affine collapse; compute correct mean/scale loss derivatives; explain shared gradient accumulation; interpret conditional intervals honestly; connect a scaled L2 objective to a Gaussian prior without claiming Bayesian weight inference.

| Allocation | Commitment / proposed bookkeeping |
|---|---|
| **Core/Live deep** | B2 §§16.2.1–16.2.2/16.3.1 MLP construction and nonlinear conditional Gaussian; B1 §13.2.4.4 example scaffolding. Gaussian NLL/derivatives are explicit course development. |
| **Short bridges** | B2 §16.1 likelihood versus inference-network distinction; §15.2.2.1/B1 §13.5.2 Gaussian-prior/L2 meaning; §13.5.1 early-stopping recognition; L05 AD/SGD and L09 predictive integration reused. |
| **Notebook owned** | PyTorch refresh, head/NLL assembly, given checks/one driver fit, held-out scoring and interval interpretation against supplied baseline. |
| **Optional** | Categorical transfer, extra numerical shrinkage, one coarse regional coverage check; no formal promise of a calibration unit. |
| **Deferred, named owner** | Encoder/decoder roles, random latent representation, amortized inference, VAE objective and joint training → L12. Its builder owns inference-network construction; no implicit encoder prerequisite here. |
| **Omitted deliberately** | CNN/RNN/transformer/GNN zoo, depth theorem, full backprop rederivation, dropout theory, adaptive-optimizer theory, sparse/lasso/horseshoe priors, BNN posterior fitting, uncertainty ensembles, full calibration/model selection, OOD guarantees and second GLM lecture. No omitted content becomes L12 debt. |

Coordinator should narrow syllabus/ledger Ch.16/Ch.13 claims and remove lasso/dropout/architecture breadth, preserving actual delivered coverage. Mentions do not mark subsections covered; no ledger changes are made by this builder.

**Questions/risks to consolidate:** **Scope-owned, medium:** synthetic heteroskedastic regression is deliberately the practical endpoint rather than an empirical domain dataset; preserves exact noise truth and one-hour feasibility, but sacrifices application context. **Downstream-owned, medium:** one supplied baseline and bounded fit/checkpoint are necessary to protect the lab; reference training length is not a portable timing claim. Pilot software refresh, train duration and NLL/scale checks. **Scope-owned, advisory:** correct likelihood, scale and uncertainty interpretation are load-bearing; if rehearsal exceeds budget, apply first cuts before adding recordings or removing these distinctions. Current independent review evidence and bounded residual risks are recorded in the registry.

**Next owner:** Instructor oversight of this reviewed proposal. Subsequent Section Design requires human acceptance; its execution backpressure returns to the nearest owning stage. Review and approval provenance are in the registry. No rehearsal, notebook runtime or hosted Colab validation is implied.
