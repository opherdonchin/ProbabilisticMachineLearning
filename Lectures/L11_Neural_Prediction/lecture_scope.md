# L11 — Predicting a curved mean and a changing amount of noise

**Status:** Rewritten for an instructor familiar with the course through L03–L04. The [course register](../course_architecture_scope/STATUS.md) records the exact current review and instructor-decision status. Lecture times are estimates; future notebooks have not been implemented or run.

Imagine observations following a curved trend: some parts of the input range are tightly clustered, while others are much more scattered. A straight-line predictor with one fixed noise level misses both features. This lecture builds a nonlinear function that predicts a Gaussian mean and standard deviation for each input, then asks what those predictions mean.

The function is a small **neural network**, also called a **multilayer perceptron (MLP)**. Its hidden layer makes learned nonlinear features; two final outputs use those features to predict the mean and a positive standard deviation. Input-dependent observation spread is called **heteroskedasticity**. The notebook fits one such model and checks it on held-out observations.

**What earlier lectures supply:** L01 gives Gaussian distributions and conditioning, including missing-value inference with known parameters, not uncertainty about network weights. L02's agreed plan gives likelihood learning; L04 explains probability-based scoring; L05 provides loss differentiation, gradient-based training and first PyTorch practice. L09 distinguishes a posterior over parameters from a fixed estimate and supplies predictive integration. L10's numerical-error discussion is useful context but not required for the new model. Planned lectures are not already delivered; the protected delivery boundary remains B2 §2.3.2/B1 §3.3. PyTorch needs a short refresh after L10's NumPy notebook.

**Choice and cost:** Fit nonlinear Gaussian regression with an input-dependent mean and scale, rather than repeat Iris classification with nonlinear logits. This adds a meaningful probability prediction and gives network components for L12. A neural network with a posterior distribution over its weights would instead represent uncertainty in those weights; fitting that distribution adds another inference chain and lab. A survey of convolutional, recurrent, attention and other networks gives breadth but loses the worked probabilistic endpoint. Keep one shallow model, a short classification connection and a narrow Gaussian-prior penalty explanation. Earlier broad promises of architecture surveys, sparse penalties or dropout must be narrowed in the shared course records.

<details>
<summary>Source verification and original build record for later authors</summary>

The material below records exactly which sources were inspected. B1 and B2 mean Murphy's first and second books. Section and equation numbers identify source passages; they do not require familiarity with the surrounding chapters. These notes are for checking the later teaching material, rather than for understanding this proposal.

**Stage/mode:** Lecture Scope / BUILD. **Builder:** `/root/build_l11`, 2026-10-11. **Branch:** `scope-l03-l12-course-architecture`; checkpoint `9b62b6c`. **Input:** [architecture contract v3](../course_architecture_scope/architecture_audit.md), blob `54064183398bd643a895c5e38a023f793dc2d9d6`. [WORK_ORDER](../course_architecture_scope/WORK_ORDER.md) delegates autonomous provisional choices without instructor checkpoints. Only this Scope is owned here; no sections, slides, notebook implementation or shared-file edits.

**Direct reading:** B2 December 10, 2025 edition, `/tmp/pml-book2.txt`, §§16.1, 16.2.1–16.2.2 and 16.3.1 (printed pp. 631–633, 641–642); selected §15.2.2.1 Gaussian-prior connection (p. 597). B1 April 18, 2025 edition, `/tmp/pml-book1.txt`, §§13.2.2–13.2.3, 13.2.4.4 (pp. 428–434), selected §§13.3.3.2–13.3.3.3 for local derivative application and §§13.5.1–13.5.2 for early stopping/weight decay. B2 remains the spine; B1 supplies the concrete regression example and notation scaffolding. No entire chapter is promised.

**Inspected anchor:** [pyprobml heteroskedastic MLP notebook](https://github.com/probml/pyprobml/blob/d1ea4122dcf3c2a2c02eb4e05343203b26440827/notebooks/book1/13/mlp_1d_regression_hetero_tfp.ipynb), local checkout `d1ea4122dcf3c2a2c02eb4e05343203b26440827`, SHA256 `1e685b9e50518ab79a7448d6bfdcc27803596ae58a7ab1de9e1fbee7aeef37a6`. Source uses TensorFlow/TFP, 1,000 evenly spaced inputs on `[-20,60]`, seed 12345, two 50-unit backbone layers, 20-unit heads, Adam at 0.01 and two 500-epoch fits. Its learned SD is `softplus(10⁻³+0.05·raw)`; the constant is inside softplus, not an additive positive floor. Fixed variance is re-estimated from training residual MSE. These are inspected source settings, not required course settings, reliable outcomes or runtime evidence.

**Original upstream version references:** L05 scope, blob `736943b90f24826e29955115896929742f2961f5`; L09 provisional blob `a8080351116f51a34eddd3e5dc06d65f7025722e`; L10 provisional blob `9503b32aef49e7090792ea7e38d3acfb808a973b`.

</details>

## 1. Intellectual arc — what the lecture explains, in order

These are the lecture's main jobs, rather than final section boundaries. Later section design can split or combine them without changing the promised mathematics, outcomes or time. Explain necessary connections at the start of the receiving section. End every section with a summary of what it has taught. Notebook instructions remain a separate item. All required material is taught live; no recording is a prerequisite.

### A. Explain what a nonlinear hidden layer adds — 22 minutes

Begin with L05's affine predictor `Wx+b`, then compose learned transformations. Show that stacking two affine maps still gives one affine map. Introduce a nonlinear activation and work the simple absolute-value example in Part 4.

Use one shallow hidden layer and explicit input/hidden/output dimensions. The activation **ReLU**, or rectified linear unit, keeps positive inputs and replaces negative inputs by zero. It is piecewise differentiable; state the chosen derivative at zero without a separate nonsmooth-optimization lesson. Learned hidden features and valid probability-output constraints have different jobs: a network alone is not a likelihood.

Briefly recognize that the same hidden features can replace L05's affine classification logits. That transfer is optional, not another classification fit or depth/architecture comparison.

**End summary:** Nonlinear hidden transformations change what the predictor can represent; the chosen output distribution still determines what its predictions mean.

### B. Turn two outputs into a Gaussian prediction — 30 minutes

Use one output for the mean and another for a positive standard deviation. Set `σ=σ_min+softplus(aσ)` with a fixed positive floor. Softplus is the smooth function `log(1+exp(aσ))`; the raw output aσ need not be positive.

Derive the Gaussian **negative log likelihood (NLL)**. Its squared residual divided by variance rewards fitting, while its log-standard-deviation term penalizes simply making the distribution wider. Derive local derivatives with respect to mean and log standard deviation, then apply the chain rule to the actual softplus output. For a known fixed scale, minimizing NLL is equivalent to minimizing squared error.

Work the numerical residual/scale comparison in Part 4. The floor prevents a zero scale numerically, but does not guarantee generalization or an optimum. A sufficiently flexible model can interpolate the observations and push unrestricted scales toward zero, so low training loss is not evidence of a useful predictive distribution.

**End summary:** Mean and positive standard deviation define the Gaussian prediction. Both residual fit and distribution width belong in the loss; omitting log scale changes the problem.

### C. Reuse differentiation and training for the two outputs — 18 minutes

Apply L05 **automatic differentiation (AD)** and **stochastic gradient descent (SGD)** to the average NLL. Trace the mean and scale derivatives locally and explain why both contributions add where they share hidden features. Do not rederive a full multilayer backward traversal.

Separate computing gradients from taking optimizer steps. A nonlinear network generally loses the convexity of an affine canonical generalized linear model. State the training/validation/test roles and use supplied initialization and a bounded driver. **Early stopping** chooses a stopping point based on validation behavior; it is not drawing weights from their posterior. Software boilerplate is supplied.

**End summary:** Familiar differentiation accumulates both output contributions, and familiar training minimizes the common likelihood. Neither completed updates nor low training loss establish predictive quality.

### D. Say exactly what the predicted spread describes — 18 minutes

At one fitted weight vector, the interval `μhat±1.96σhat` contains about 95% probability under the fitted Gaussian model. It describes a future observation, not the uncertainty in the mean or in the weights. It does not guarantee 95% coverage under the unknown true data-generating process.

State the alternative posterior prediction, which averages the conditional distribution over uncertain weights. Apply the total-variance formula: one term averages observation-noise variance, and another measures how the predicted mean changes across possible weights. Our single fitted network does not compute the second term. Its learned scale can also absorb errors in the mean function, so it is not automatically a pure physical noise measurement.

Compare held-out NLL, mean squared error and interval behavior in low/high-noise regions using supplied summaries. They answer different questions. One regional coverage check can aid interpretation, but is not a full **calibration** framework, which would establish agreement between stated probabilities and empirical frequencies, or a guarantee for inputs unlike the training data.

**End summary:** Conditional spread describes observation variation at fitted weights. Weight uncertainty requires averaging over weights; predictive scores and observed coverage need checking.

### E. Connect one squared-weight penalty to a Gaussian prior — 12 minutes

A Gaussian prior on selected weights contributes a squared-weight penalty to the negative log posterior. Derive its coefficient when the data loss is a **mean** rather than a sum. Specify which weights receive the prior; biases can be treated differently.

Work the resulting shrinkage term for ordinary SGD. A squared-weight penalty in the objective and a separate optimizer rule shrinking weights are equivalent for the stated ordinary SGD update, but not generally for adaptive preconditioning. Do not add Adam/AdamW comparisons, sparse priors or penalty tuning. A maximum a posteriori (**MAP**) weight estimate remains one point, not a posterior distribution or its uncertainty.

**End summary:** A Gaussian prior gives an explicitly scaled squared-weight penalty. A regularized point fit is still a point fit, and the update rule must match the stated objective.

### Time estimate and what to shorten first

The estimate is **100 substantive plus 12 reserve =112 live minutes**, with a separate 60-minute lab. It is tight and unmeasured, with medium-low confidence. The main new chain is the Gaussian loss, its mean/scale derivatives, and interpretation of the distribution. Affine composition and prior scaling are short algebraic applications; earlier training/integration are reused.

First remove optional classification transfer, a repeated numerical SGD-shrinkage example and extra regional coverage breakdowns, saving about 6–8 minutes. Keep nonlinearity, the complete NLL/scale explanation, Gaussian-prior scaling and the observation-noise/weight-uncertainty distinction. No material silently moves to recording. Time the likelihood/scale explanation during section design and rehearsal; change the scope if core commitments still do not fit.

Later-author counts `K=5`, `P≈7–10`, `E_new≈10–13`, `E_carry≈12–20`, `E_deriv≈6–9`, `V≈5–7` refer to major parts, substantive pages, new equation families, repeated support, algebra blocks and visual groups. The rough prediction is 20–25 content-slide equivalents, not a slide target or measured delivery rate. L01's 61-content-slide/70-page judgment is only a comparison; scale and interval explanations can be slow despite few equations.

## 2. Mathematical spine — the results students will use

`ψ` denotes all fitted network parameters. h is the deterministic hidden-feature vector; it is not the random latent variable introduced in L12. `aσ` is the raw scale output, `σ` standard deviation and `v=σ²` variance. W maps D input coordinates to H hidden features; the mean and scale output vectors also have H entries. The “backbone” is this shared hidden computation; “heads” are the two output maps.

`ℓ` is one observation's NLL; L is its mean across N observations. `ρ=logσ` is a convenient coordinate for interpreting one derivative, not a replacement for the actual softplus model. In the prior calculation, τ² is the fixed prior variance and λ the resulting mean-loss penalty coefficient. Adaptive preconditioning means rescaling gradient directions differently; no such optimizer theory is taught. A BNN is a Bayesian neural network with uncertain weights, which is excluded here. OOD means out of distribution: inputs unlike those represented by training data.

In the table, **Derive** means work through the calculation; **Work** means carry out an example; **State** means give the result without proving it; **Apply** means use a result established earlier. These depths are unchanged by the wording revision.

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

## 3. Notebook handoff — what students do and what is supplied

**Student endpoint:** Assemble a nonlinear Gaussian mean/scale model, check its loss and derivatives, run one supplied PyTorch fit, and interpret held-out scores and observation intervals. The lecture supplies the shapes, positive-scale rule, NLL and uncertainty meanings. Reuse PyTorch from L05/L09 rather than introduce TensorFlow Probability, JAX or Pyro.

**Supplied:** data generation/splits, training-only normalization, a shallow backbone and model wrapper, optimizer/training driver, plots, a checked fixed-scale baseline and local checks. **Students complete:** the mean and positive-scale outputs and batch-mean NLL, then compare their values/derivatives on a fixed batch and interpret one fitted model. No new data loader, second optimizer or second data pipeline is required.

Provisionally use 320 training observations and 160 held-out observations, one 32-unit ReLU hidden layer and linear mean/scale outputs. Keep targets and outputs as matching `B×1` tensors: mismatched shapes can accidentally compare every prediction with every target. Fit one input-dependent-scale model through a bounded CPU driver. A fixed-scale nonlinear baseline is supplied as a validated fit/configuration; students do not run a second full fit. Validate driver settings and a fallback checkpoint later rather than promise convergence, epoch count or speed.

Required local checks are finite positive scales, matching shapes, agreement with a reference loss/derivative, and no detached mean or scale gradients. Compare held-out mean NLL/MSE, means and interval widths with the baseline and the known generating law. A coarse low/high-noise coverage summary is optional and removed first if debugging overruns.

The 60-minute budget is: 10 minutes PyTorch/data/split/shape refresh; 15 completing the heads and NLL; 12 local value/gradient checks and one driver run; 13 interpreting intervals and held-out scores; 10 reserve for debugging, runtime and discussion.

No regularization sweep, architecture search, weight-posterior inference or second fit is required. A failure to recover the generating law is evidence to interpret, not a reason to call intervals calibrated. The inspected source uses two long TensorFlow/TFP fits; the course PyTorch port remains unimplemented and unrun. Clean local uv execution, hosted Colab Restart/Run All and a student-workload pilot remain necessary before publication.

## 4. Concrete examples and their sources

One simple function shows why nonlinearity is needed. One residual calculation shows why wider predictions are not always better. The synthetic data then provide a known curved mean and changing noise level against which to interpret the fit. Finally, the uncertainty/prior comparison prevents a regularized point estimate being mistaken for a Bayesian weight posterior. SD means standard deviation; variance is its square. “Heads” are output maps, and “shared backbone” means their common hidden-feature calculation.

**Affine collapse/nonlinear feature — Work Live, course-constructed:** two scalar affine maps compose to one affine map. In contrast `h1=ReLU(x)`, `h2=ReLU(−x)`, `μ=h1+h2=|x|` gives a nonlinear conditional mean. For `x=−1,0,1`, means are `1,0,1`. This verifies expressiveness without XOR/architecture catalogues or approximation-theorem debt.

**Correct scale scoring — Work Live, course-constructed:** at residual `y−μ=2`, `σ=1,2,4` give NLLs approximately `2.91894,2.11209,2.43023`; at `σ=2`, the log-SD derivative is zero. For this fixed nonzero residual, the local optimum is `σ=|y−μ|`; this is a single-observation calculation, not an estimator rule for every input. At zero residual, unrestricted scale tends toward zero and NLL toward minus infinity. These algebraic/numerical commitments motivate the log term and floor, not a fitted-result claim.

**Nonlinear growing-noise data — Work Notebook, Compare Live:** inspected source sets `g=(x+20)/80`, `μ_true(x)=sin(0.2x)+0.1x`, `σ_true(x)=0.25+g²`, `Y=μ_true+σ_true·ε`, `ε~N(0,1)`. Endpoint SDs are `0.25,1.25`, variances `0.0625,1.5625`; their ratio is 25. At `x=20`, SD is 0.5. The **SD**, not variance, is quadratic in rescaled input; variance is its square. Do not inherit B1's loose “variance increases quadratically” description as an exact data law. Source ±2-SD curves represent about 95.45% conditional Gaussian probability; the course uses explicit 1.96-SD interpretation. No financial/climate application, source figure replication or fit quality is promised.

**Uncertainty and penalty comparison — Brief Live, course synthesis:** contrast fixed-weight `σhat²` with posterior-weight mean variation using the stated total-variance identity. Compare one Gaussian-prior log density with the mean-loss penalty; no simulated ensemble or posterior-weight dataset is required. These consolidate distinctions rather than create additional laboratories.

Selected visual/schema groups are affine/nonlinear mapping, shared backbone/two heads, residual/scale scoring, source-law versus fitted mean/intervals, and conditional-versus-weight uncertainty, approximately five to seven groups. B2 Fig. 16.11/B1 Figs. 13.5–13.6 are inspected context; no exact figure asset is selected or authored. All source adaptations and constructed calculations remain explicitly labeled downstream.

## 5. Lecture contract — what this proposal commits to

**Starting knowledge:** Gaussian distributions, likelihood learning, probability-based scoring, L05 differentiation/training and PyTorch, and L09's distinction between a fixed parameter fit and posterior prediction. L10 sampling-error theory is context rather than a dependency.

**Main question:** How can a nonlinear learned function define an interpretable probability distribution for a response? **Lecture endpoint:** explain nonlinear hidden features; derive/use a Gaussian mean/positive-scale loss; reuse differentiation and training; interpret observation intervals; and connect a scaled squared-weight penalty to a Gaussian prior. **Notebook endpoint:** one checked PyTorch mean/scale fit with held-out scoring and interval interpretation. The estimate is 112 live minutes plus 60 lab minutes, with no required recording.

Supported outcomes include explicit network dimensions, the collapse of purely affine layers, correct mean/scale derivatives, summed contributions at shared features, honest interval interpretation and prior/loss scaling. Core sources are selected B2 §§16.2.1–16.2.2/16.3.1 and B1 §13.2.4.4, with a narrow prior connection from B2 §15.2.2.1/B1 §13.5.2.

**What is left out, and the lost capability:** Students do not learn a survey of image, sequence, graph or attention architectures, nor a theorem about network depth or approximation power. They do not derive dropout/adaptive-optimizer theory, sparse priors or lasso, so the course cannot promise that regularization breadth. They do not infer network-weight posteriors or fit ensembles, and therefore cannot claim to measure weight uncertainty. Full calibration/model-selection systems and guarantees for unfamiliar inputs are also outside scope. None becomes L12's debt. L12 owns random latent codes, the shared encoder/decoder and their joint objective; no encoder construction is assumed here.

**Choices and risks:** Synthetic growing-noise data preserve exact truth and one-hour checking, but lose an empirical domain application. The supplied baseline, bounded CPU fit and fallback checkpoint protect the lab; source training duration is not portable timing evidence. Pilot the refresh and likelihood/scale checks. If teaching is too slow, apply optional cuts before weakening the probability loss or uncertainty distinction.

**Record updates:** Narrow broad Chapters 16/13 claims and remove survey/lasso/dropout promises while preserving delivered coverage. Mere mentions do not count as teaching a subsection.

<details>
<summary>Exact source allocation for checking the syllabus and material ledger</summary>

This table preserves the reviewed source boundaries. The plain-language explanation above states what the omissions mean for students. A method named as omitted is not promised elsewhere unless a receiving lecture is explicitly named.

| Allocation | Commitment / proposed bookkeeping |
|---|---|
| **Core/Live deep** | B2 §§16.2.1–16.2.2/16.3.1 MLP construction and nonlinear conditional Gaussian; B1 §13.2.4.4 example scaffolding. Gaussian NLL/derivatives are explicit course development. |
| **Short bridges** | B2 §16.1 likelihood versus inference-network distinction; §15.2.2.1/B1 §13.5.2 Gaussian-prior/L2 meaning; §13.5.1 early-stopping recognition; L05 AD/SGD and L09 predictive integration reused. |
| **Notebook owned** | PyTorch refresh, head/NLL assembly, given checks/one driver fit, held-out scoring and interval interpretation against supplied baseline. |
| **Optional** | Categorical transfer, extra numerical shrinkage, one coarse regional coverage check; no formal promise of a calibration unit. |
| **Deferred, named owner** | Encoder/decoder roles, random latent representation, amortized inference, VAE objective and joint training → L12. Its builder owns inference-network construction; no implicit encoder prerequisite here. |
| **Omitted deliberately** | CNN/RNN/transformer/GNN zoo, depth theorem, full backprop rederivation, dropout theory, adaptive-optimizer theory, sparse/lasso/horseshoe priors, BNN posterior fitting, uncertainty ensembles, full calibration/model selection, OOD guarantees and second GLM lecture. No omitted content becomes L12 debt. |

</details>

**Next owner:** The instructor reviews the proposal's choices and explanations. Detailed section design follows acceptance. If later writing or rehearsal cannot meet the stated commitments, return the affected choice to Lecture Scope. The [registry](../course_architecture_scope/STATUS.md) holds review evidence. This document does not establish notebook runtime, Colab readiness or measured teaching time.
