# L05 — Learning conditional probability models: GLMs, gradients and computation

**Status:** Reviewed five-part scope proposal; [current agent approval and exact reviews](../course_architecture_scope/STATUS.md) are maintained by the coordinator. Instructor acceptance pending; timing and notebook implementation remain unvalidated. **Stage/mode:** Lecture Scope / BUILD. **Builder:** `/root/build_l05`, 2026-10-11. **Branch:** `scope-l03-l12-course-architecture`. **Inputs:** starting HEAD `906ce71dd9c8e29f3dede51ec809442a885354c9`; contract checkpoint `374bc6d`; cross-course contract v1 [architecture audit](../course_architecture_scope/architecture_audit.md), Git blob `882a9b2e76134d4952b218492a3564e117f6d6b4`. The [work order](../course_architecture_scope/WORK_ORDER.md) delegates provisional choices without interim instructor checkpoints. The coordinator owns review and approval; this builder owns only this scope. No sections, slides, figures, notebook code or runtime validation are produced.

## Starting boundary, evidence and alternatives

The actual L01 `slide_deck.typ` establishes probabilistic prediction, empirical risk, three-species Iris framing, Gaussian moment/precision coordinates, conditioning and linear Gaussian systems. The protected solution `InClass/Solutions/lecture1_missing_data.ipynb` uses a known seven-dimensional Gaussian with three hidden coordinates, PyMC conditional inference, an explicit LGS translation with NumPy solves and an exact-versus-sampled comparison. Its student skill is expressing and checking a conditional probability calculation, not learning weights with autodiff. Source inspection does not certify its runtime here. The ledger's delivered boundaries remain B2 §2.3.2 and B1 §3.3.

The protected L02 `section_design.md` is agreed, not delivered: exponential-family representation, natural/mean parameters, carefully derived `∇A=E[T]`, covariance interpretation, likelihood moment matching, maximum entropy, Gamma fitting and categorical/Markov counts through B2 §2.6.3. L05 carries the log-partition moment result and IID likelihood forward; it does not rederive normalization calculus. If these outcomes are absent after actual L02 delivery, report prerequisite backpressure rather than adding an unbudgeted exponential-family lecture. No authority is inferred from L02's malformed/stale development-state text.

The new provisional L03 and L04 scopes were inspected. L03's undirected factors and local conditionals do not imply students know gradient-based learning. L04's empirical cross-entropy bridge and information measures allow log loss to be interpreted concisely here; its finite calculations use bits. L05 uses natural logarithms, so losses are in nats. The L04 MI/DPI proof and coding algorithm are not prerequisites for differentiating a GLM. Current syllabi, ledger allocations, notebook audit and preliminary briefs fix substantial GLM-family modeling together with AD/SGD, followed by L06 EM. Broad B1 preparation ranges in those documents are narrowed below to enabling passages, not a second optimizer chapter.

### Direct source evidence

| Inspected input | Use and limit |
|---|---|
| Actual L01 source and solution; L02 agreed section design; L03/L04 provisional scopes | Actual Gaussian/Iris conventions and proposed cumulative prerequisites; no new delivered coverage or approval inferred. L01 solution SHA256 `f114516ca6a9c0823c14da0a734822a8901e4fdccf237481d47d0e3a61f80a8c`. |
| Murphy B2, online edition December 10, 2025, local extraction `/tmp/pml-book2.txt` | §15.1, §§15.1.1.1–15.1.1.3, §15.1.2, §15.1.3, printed pp. 591–595: conditional exponential-dispersion form, means/links and scalar likelihood gradient. §15.3.2, pp. 611–612, Eqs. 15.135–15.137: categorical softmax model and likelihood. §6.2.2.1–6.2.2.2, especially pp. 268–270 and Algorithm 6.4: chain rule, fan-out and reverse accumulation. §§6.3.1–6.3.2, pp. 271–273: SGD and finite empirical objectives. §§14.1.2 and 14.2.1, pp. 576–578: MLE/MAP and log score, selective bridge only. |
| Murphy B1, local PDF whose text identifies online edition April 18, 2025, `/tmp/pml-book1.txt` | §7.8.2 gradients and §7.8.5 Jacobian/shape conventions; §8.2 descent direction, §8.4.1 finite-sum SGD, §8.4.3 qualitative step-size behavior. §13.3.1 and §13.3.4 provide optional AD exposition, not neural-network coverage. §10.2.3.3 checks the binary NLL gradient sign; no separate logistic-regression derivation assigned. |
| [Batra softmax notebook](https://github.com/nipunbatra/pytorch-basics/blob/main/notebooks/04-softmax-regression.ipynb), downloaded `/tmp/batra-iris.ipynb` | Inspected source SHA256 `40a2d3387ffcbc14f599cf55bdfb91cb996e8886b9fa2e0cc1fe3f8f1f6aebb7`. Contains Iris loading, train-only standardization, manual/autograd gradient comparison, full-batch SGD, several loss designs, four-feature comparison and spiral/polynomial extras. Course adaptation selects one Iris path and replaces full-batch training with a supplied minibatch scaffold. Reference source has not been executed; embedded accuracy/loss outputs are not course promises. |

**Source cautions:** B2 Eq. 15.35 gives the **log-likelihood** derivative with dispersion set to one; NLL reverses its sign and general dispersion must be restored. B2's subsequent uniqueness wording is too strong: convexity alone guarantees neither a unique nor a finite optimum. Rank deficiency, separation and redundant softmax parameters matter. B2's binomial passage uses a success probability where `E[Y]=N_trials p`; L05's required binary example is Bernoulli with one trial, so `μ` always denotes the actual response mean. No zero-inflated count model is implied. AD graphs are computational dependence graphs, not stochastic graphical models or CI claims.

| Route | Endpoint, source route and notebook | Tradeoff / provisional decision |
|---|---|---|
| **Common GLM residual → categorical fit → computational gradients** | B2 §15.1 → §15.3.2 → §6.2 / §§6.3.1–6.3.2. Understand a common family and fit three-class Iris in PyTorch. | **Selected.** Strong L02 continuity and durable training skill; real GLM generality is preserved. Tight because model coordinates and computational differentiation are distinct new responsibilities. One common scalar gradient, one vector specialization and one AD graph bound the load. |
| Optimization first, softmax as the principal model | B2 §6.2 / §6.3 → §15.3.2; Iris lab, with §15.1 family comparison at the end. | Direct software handoff, but risks making Gaussian/Poisson a catalogue and losing the instructor's unified-model objective. Retain computation as the second half, not the organizing starting point. |
| GLM statistical inference first | B2 §15.1 / §15.2 / §15.3, using IRLS and priors; separate binary or count lab. | Strong statistical depth but exceeds time and displaces AD/SGD/PyTorch onboarding; would burden L11 with missing prerequisites. Omit this route's IRLS and Bayesian survey rather than pushing them into later lectures. |

The selected route makes forward progress in B2 while selectively backfilling differentiation; chapter order is deliberately crossed because the conditional model explains what is being optimized. No required recording is introduced. Agent choices below are reversible and instructor-pending.

## 1. Intellectual arc

These are macro-level conceptual responsibilities, **not finalized sections or section boundaries**. Section Design may split/combine them while retaining coverage, mathematical depth and live extent. Every resulting section ends with a retrospective summary; essential connections begin the receiving section. The notebook handoff remains a separate lecture-level item.

### Conditional exponential families explain several response types — about 30 minutes

**Transition in:** L02 estimated a common distribution from repeated observations. Now each observation has predictors: the response distribution should change with `x`, while its family remains specified.

**Purpose:** distinguish response support, mean, linear predictor, canonical parameter and link, so GLMs are a modeling framework rather than three unrelated regressions.

**Sources:** B2 §15.1, §§15.1.1.1–15.1.1.3 and a bounded §15.1.2 contrast; L02 §2.4 results carried forward.

**Core:** state the fixed-dispersion scalar conditional form and reuse `A′`/`A″` to obtain mean/variance. In the canonical case the linear predictor equals the canonical parameter, and the link maps the mean back to it. Work/compare Gaussian identity, Bernoulli logit and Poisson log in one common representation, including response support and variance. Work a small Poisson prediction: log mean changes additively while the mean changes multiplicatively. Bernoulli is a familiar specialization; no full separate family-gradient derivations. Briefly distinguish a noncanonical probit link: a linear predictor need not itself be the distribution's canonical coordinate. Fixed known dispersion here avoids simultaneous noise estimation; no binomial trial-count extension, exposure model or count-model catalogue is required.

**Delivery:** Live. Family comparison and parameter distinctions are protected; a numerical probit comparison is optional within this time, not a required recording.

**Retrospective summary:** Gaussian, Bernoulli and Poisson GLMs share a conditional exponential-family form; the mean is determined by the log partition and a canonical link makes its canonical coordinate linear in predictors. Response support and variance still differ.

### Learning compares observed responses with model means — about 20 minutes

**Transition in:** the conditional family gives a probability to each observed response. Carry L02's likelihood construction into the predictor-dependent parameters and ask how the weights change it.

**Purpose:** establish one interpretable, sign-correct canonical scalar gradient and relate its use to the empirical NLL objective.

**Sources:** B2 §15.1.3 and §14.1.2; §14.2.1 / L04 log-score interpretation; B1 §7.8.2 and §10.2.3.3 as selective scaffolding/checks.

**Core:** derive the mean-NLL gradient by differentiating the conditional log likelihood once and applying `∂(wᵀx)/∂w=x`. Restore dispersion and explicitly reverse log-likelihood sign. Apply the common formula to the earlier Poisson case and recognize Gaussian residual/Bernoulli probability-error cases without proving them again. State the canonical NLL's convexity under the specified fixed-dispersion model, with no proof or Hessian derivation; explain that rank/separation can prevent finite/unique MLEs. Briefly connect held-out log loss with assigned probabilities, using L04's mismatch interpretation rather than a scoring-rule survey. Optional two-minute MAP penalty recognition uses the correctly scaled mean-loss objective; primary Gaussian-prior/weight-decay teaching remains L11.

**Delivery:** Live. The common gradient derivation is load-bearing and cannot move out of the live chain.

**Retrospective summary:** a canonical scalar likelihood gradient is predictor times observed-minus-predicted response, scaled by dispersion; minimizing NLL reverses the sign. Optimizing a convex objective is distinct from proving a finite, uniquely identified estimate exists.

### Categorical outcomes require a vector model — about 20 minutes

**Transition in:** Iris has three species, so one scalar Bernoulli response is insufficient. Use a vector sufficient statistic and a vector of scores to allocate probability across all three outcomes.

**Purpose:** carry the residual interpretation into a correctly shaped categorical GLM and identify exactly the lab's objective.

**Sources:** B2 §15.3.2 and L02 categorical representation; Batra's inspected gradient comparison as computational reference. The matrix-gradient application is course synthesis from this likelihood, not an equation attributed to B2 §15.1.3.

**Core:** affine logits, softmax, one-hot sufficient statistics and categorical NLL. Motivate `∂ℓ/∂z=p−t` through the log-sum-exp derivative, then apply it to obtain the weight/bias gradients with shapes. This is a short vector specialization, not an additional long scalar-family derivation. Work one three-class probability/gradient calculation. Explain common-logit-shift invariance and the resulting redundant full-class parameterization; no claim of uniquely identified weights. Stable log-sum-exp/log-softmax computes NLL from logits; applying softmax before a loss that already expects logits changes the objective. The latter is a notebook interface obligation, not a catalogue of loss APIs.

**Delivery:** Live. Full manual softmax-Jacobian algebra is omitted. A supplied reference-class interpretation is enough to explain redundancy; students do not implement a constrained parameterization.

**Retrospective summary:** softmax normalizes class logits; categorical NLL compares predicted class probabilities with one-hot observations, producing matrix gradients of the declared shape. Probabilities depend on logit differences, and the loss must receive the intended mathematical object.

### Reverse mode evaluates that gradient by local accumulation — about 20 minutes

**Transition in:** the likelihood supplies a gradient formula. Ask how a program obtains the same result from its executed primitive operations, without needing a new hand derivation for every model.

**Purpose:** complete one forward/reverse computation with genuine branching and accumulated contributions.

**Sources:** B2 §§6.2.2.1–6.2.2.2, Algorithm 6.4; selective B1 §13.3.1 / §13.3.4 support.

**Core:** use the Bernoulli NLL `log(1+exp(r))−yr`, `r=wᵀx`, as the **one** fully worked computational graph. Store forward values; seed loss adjoint one; traverse reverse order and sum both contributions at the shared predictor. Work one numerical pass and recover the already-established gradient. State the local adjoint rule and explain why scalar loss/many parameters favors reverse mode. Distinguish AD from finite differencing and symbolic simplification at recognition depth. Graph edges carry computational dependencies, not probabilistic independence. No second unrelated graph, full JVP/VJP theory, programming-language differentiation or neural network is required.

**Delivery:** Live. The whole graph, including the sum at fan-out, is protected.

**Retrospective summary:** reverse-mode AD stores intermediate values and propagates local derivatives backward; contributions from every path are summed. It reproduces the likelihood gradient for the program's scalar loss.

### Minibatches make repeated likelihood learning computationally usable — about 13 minutes

**Transition in:** AD computes the derivative of an evaluated batch loss. The full empirical objective is a finite average, so choose a random subset to approximate its gradient before updating weights.

**Purpose:** separate the gradient computation from the stochastic parameter-update rule and define the lab's reusable training cycle.

**Sources:** B2 §§6.3.1–6.3.2; B1 §8.4.1 and qualitative §8.4.3 support.

**Core:** mean empirical loss, an unbiased uniformly sampled minibatch gradient at fixed current parameters, and `θ_next=θ−α g_batch`. Motivate estimator cost/noise and explain small/large step-size behavior without a convergence theorem. Distinguish stochastic *data indices* independent of parameters from learning the parameters of a sampling distribution, which is L09-owned. Explain the conceptual cycle: choose examples, evaluate loss, reset accumulated software gradients, differentiate, update. Lab mechanics extend this reasoning; no live PyTorch tutorial. Iris is deliberately tiny, so minibatches teach a reusable skill rather than promise a speedup over full-batch Iris training.

**Delivery:** Live. No momentum/Adam/natural-gradient comparison or learning-rate-schedule derivation.

**Retrospective summary:** a uniformly sampled batch estimates the finite empirical gradient; reverse AD calculates that batch derivative and SGD uses it to change parameters. Learning rate and batch size affect the computation and noisy trajectory.

### Extent, uncertainty and first cut

Substantive live allocations total **103 minutes** (`30+20+20+20+13`); **12 minutes reserve** yields a **115-minute plan**, including transitions, questions and slippage. The separate lab is 60 minutes. No recording is required or excluded from this budget. Optional bridges remain counted within the allocations.

**Judgment: tight / high cognitive-load risk; timing unmeasured, confidence medium-low.** The L01 anchor is 61 content slides/70 rendered pages, with a 29-content-slide Gaussian mathematical span; instructor experience is 60–80 slides in three hours. Neither provides a fixed rate or validated timing for first AD exposure. L02's plan is not a delivery measurement. L05 contains **two substantial novel worked chains**: common likelihood gradient and one full reverse graph. The softmax log-sum-exp specialization adds a short vector calculation; the finite-batch expectation argument is brief. Family links and software interfaces add conceptual novelty beyond the derivation count.

Provisional calibration: `K=5`, `P≈9–12` substantively used source-page equivalents, `E_new≈12–15`, `E_carry≈18–26`, `E_deriv≈9–13`, `V≈5–7` selected visual/schema groups. New retained families include conditional dispersion form, mean/link relationship, family specializations, common gradient, vector logits/softmax and NLL, vector residual/parameter gradients, adjoint accumulation, minibatch estimator and update. EF moment identities, IID likelihood and repeated residual formulas are carried support. The prototype gives roughly **24–30 content-slide-equivalent extent**, a warning signal only, not a slide-count target; its coarse coefficients can undercount the time for graph bookkeeping and the shift from scalar to vector parameters. Downstream design must count actual new families and derivational steps again and time at least the gradient/AD portions.

**Single most useful cut:** remove the optional MAP recognition, numerical noncanonical-link contrast and repeated numerical family applications (about **6–8 minutes**) while retaining the full family table/mean-link interpretation, one worked Poisson prediction, one common gradient, essential softmax specialization and the complete AD graph. The canonical/noncanonical distinction remains stated. This produces roughly 107–109 minutes including reserve. If only 100 minutes are available, or AD needs appreciably more time, return Scope-level backpressure for a genuine depth/time repair rather than assume faster delivery or take reserve as extra content. Core GLM generality and AD skills cannot be rescued by being silently renamed review or recording.

## 2. Mathematical spine

Use `r=wᵀx` for the linear predictor, `θ` for the scalar canonical parameter, `φ>0` for fixed dispersion and `μ=E[Y|x]`. In the canonical case `θ=r`; do not use `θ` for all optimizer parameters in the same calculation. For generic SGD use parameter tuple `ψ=(W,b)`. The coefficient of `y` in the normalized exponent is `θ/φ`; “canonical parameter” here follows the exponential-dispersion convention of B2. Bernoulli/Poisson have `φ=1`. Write the sigmoid as `s(r)` to avoid confusing it with a noise standard deviation.

| Object/result | Role and treatment depth | Delivery |
|---|---|---|
| `p(y|x,w,φ)=h(y,φ) exp{[yθ−A(θ)]/φ}`, with `θ=wᵀx` in the canonical case | **State + Motivate** conditional distribution/family and fixed dispersion; carry L02 EF form | Live, first macrosegment |
| `μ=A′(θ)`, `Var(Y|x)=φ A″(θ)`; canonical `ℓ(μ)=(A′)⁻¹(μ)=θ=r` | **Apply + Work** L02 moments, **Motivate** the link; no new partition-function derivation | Live |
| Gaussian: `A(θ)=θ²/2`, `φ=σ²`, `μ=r`, `ℓ(μ)=μ`; Bernoulli: `A(θ)=log(1+e^θ)`, `φ=1`, `μ=s(r)`, `ℓ(μ)=log[μ/(1−μ)]`; Poisson: `A(θ)=e^θ`, `φ=1`, `μ=e^r`, `ℓ(μ)=log μ` | **Compare + Apply** each to mean/variance/support; **Work** one Poisson prediction. Gaussian variance `σ²`, Bernoulli `μ(1−μ)`, Poisson `μ`. No separate gradient proofs | Live, substantive family comparison |
| Noncanonical Bernoulli probit: `μ=Φ(r)`, `θ=logit(μ)≠r` generally | **State + Explain** distinction; numerical comparison optional. The common canonical-gradient shortcut is not asserted for this case | Live short bridge |
| `L(w)=−N⁻¹Σ_n log p(y_n|x_n,w,φ)`; `∇_w log p(D|w,φ)=φ⁻¹Σ_n x_n(y_n−μ_n)`; `∇L=(Nφ)⁻¹Σ_n x_n(μ_n−y_n)` | **Derive** the one canonical scalar chain, **Apply** to earlier examples; fixed known `φ`, `h` independent of `w` | Live, deep |
| Convex canonical NLL, conditions on existence/identification | Convexity **State**; rank deficiency and binary separation **Explain briefly**. No Hessian calculation, strict-convexity proof, finite/unique MLE guarantee or IRLS | Live short safeguard |
| `z=Wx+b`, `p_c=e^{z_c}/Σ_j e^{z_j}`, `A(z)=logΣ_j e^{z_j}`, `t=onehot(y)` | **Motivate + Work** vector categorical EF. `W∈R^{C×D}`, `b,z,p,t∈R^C`; common shifts leave probabilities unchanged | Live, vector specialization |
| `ℓ(z,t)=A(z)−tᵀz`; `∇_zℓ=p−t`; `∇_W L=N⁻¹(P−T)ᵀX`, `∇_bL=N⁻¹Σ_n(p_n−t_n)` | **Motivate + Apply + Work**, using `∇A=p` from L02; only the short log-sum-exp derivative needed. `X:N×D`, `P,T:N×C`, gradients `C×D` and `C`; not substituted into the scalar formula | Live; manual/autograd batch equality Notebook |
| Stable `A(z)=m+logΣ_j exp(z_j−m)`, `m=max_j z_j` | **State + Explain** exact identity; logits-to-NLL interface, no floating-point theory | Live brief / apply in Notebook |
| Local adjoint `bar(v_i) += bar(v_j) ∂v_j/∂v_i`, seeded `bar(L)=1` | **Work** one complete Bernoulli circuit, including both predictor paths; **State** general accumulation and scalar-loss motivation | Live, deep; software reuse Notebook/L11/L12 |
| `L(ψ)=N⁻¹Σ_nℓ_n(ψ)`, `g_B=|B|⁻¹Σ_{n∈B}∇ℓ_n(ψ)`, `E[g_B|ψ]=∇L(ψ)` under fresh uniform independent index sampling, `ψ_next=ψ−α g_B` | **Motivate + brief expectation argument + Apply**. Do not claim the same conditional-unbiased property for every sequential shuffled-batch scheme | Live; practice Notebook |
| Mean held-out categorical NLL and 0–1 error | **Apply** probability scoring and decision distinction; no calibration guarantee from empirical loss minimization | Live interpretation / Notebook evaluation |
| Optional MAP mean loss `L_MAP=L−N⁻¹log p(w)` up to constants | **Recognize**, no penalty-gradient derivation; B2's summed likelihood-plus-prior must be rescaled consistently | Live optional; primary weight-decay connection L11 |

No new proof of L02's moment identities or L04's KL/log-score result is promised. No optimizer convergence proof is promised. L06 consumes the fully observed conditional-likelihood baseline; L07 may reuse a scalar logistic model, L09 the AD/gradient-versus-update distinction, and L11/L12 the training cycle. Expectations under a parameter-dependent sampling distribution are explicitly absent here.

## 3. Notebook handoff — one scaffolded 60-minute three-class Iris fit

**Anchor:** B2 §15.3.2, §§6.2 / 6.3.1–6.3.2 and the inspected Batra Iris reference. This is the first required PyTorch experience. Students enter with Python/NumPy and undergraduate PyMC/Bambi/ArviZ; neither PyTorch tensors nor autograd are assumed. No new JAX/Pyro stack or recording prerequisite.

**Lecture must supply:** categorical probability model, logits/one-hot distinction, mean NLL, vector gradient shapes, complete reverse-mode reasoning, batch-average scaling, SGD's sign and held-out log-loss interpretation. The notebook teaches the software translation and checks rather than another mathematical model.

**Required student endpoint:** fit **all three Iris species** using one affine softmax GLM on the two petal features; verify a manual batch gradient against autograd at identical parameters; train with a visible SGD loop and supplied fresh-uniform minibatch indexing; inspect held-out probabilities, mean NLL and classification error. All three species are protected; reducing the software burden must not turn this into a binary subset. Two features preserve readable plots; a four-feature refit is optional and excluded from completion requirements.

**Scaffolding:** instructor supplies data loading, fixed train/test indices, train-only standardization, seed/configuration, CPU setup, plotting and batch-index utilities. Students manipulate the likelihood, tensor/model dimensions, one batch gradient check and the forward/reset/backward/update cycle; no custom `Dataset`/`DataLoader` or model-class boilerplate is required. Choose one stable logits-based cross-entropy API; `float` features, integer class targets, explicit one-hot targets only for mathematical gradient comparison. Do not teach three interchangeable loss designs or ask students to hand-code an unstable probability-log loss. Gradient reset and evaluation without gradient recording are explained locally. A supplied bounded training configuration must be timed later; no convergence, exact accuracy or runtime promised now.

| Lab responsibility | Budget |
|---|---:|
| Tensor shapes, targets, supplied data split and one forward probability calculation | 12 min |
| Stable categorical loss and one manual/autograd batch-gradient comparison | 10 min |
| Complete and inspect the supplied minibatch SGD training cycle | 15 min |
| Held-out probabilities, mean log loss, classification error and provided plot | 12 min |
| One bounded manipulation: compare a supplied alternate batch size at fixed update count and interpret noise, without treating it as a controlled convergence theorem | 6 min |
| Reserve for onboarding/debugging | 5 min |
| **Total** | **60 min** |

The required loop and evaluation extend the live mathematics into reusable computational practice; supplied preprocessing is not a separate model-selection lesson. If onboarding consumes reserve, **first lab cut is the alternate-batch-size comparison**, preserving one complete three-class fit and gradient check. Spiral data, polynomial features, Adam comparisons, four-feature refit, several loss APIs, confusion-matrix implementation and uncertainty/calibration surveys are optional or omitted, not required lab tasks. A full second manual training implementation is omitted; only one local manual gradient verifies AD.

**Validation boundary:** reference downloaded/inspected only; no execution here. The later notebook-authoring stage must independently validate the mathematical gradient and stable loss, pilot the onboarding time, run from a clean local uv kernel and a fresh hosted Colab course-target runtime before publication. Source embedded outputs, a URL and local source inspection are not evidence of those checks. PyTorch compatibility/version and training runtime remain downstream tasks.

## 4. Concrete examples and provenance

| Selected example | Purpose, mathematical link and treatment | Provenance / relation to notebook |
|---|---|---|
| One parallel Gaussian/Bernoulli/Poisson family comparison | **Compare, Live**. At `r=0`, means are `0`, `1/2`, `1`; variances are `σ²`, `1/4`, `1`. Same linear predictor, different support/link/uncertainty; not three interchangeable outcome distributions | Family formulas verified in B2 §§15.1.1.1–15.1.1.3. Numerical comparison course-constructed; no source figure attribution. |
| Poisson count prediction with `x=(1,2)`, `w=(log 2,0)`, `y=3`, `φ=1` | **Work, Live**. `r=log2`, `μ=2`, response variance `2`; common per-observation NLL gradient `(μ−y)x=(−1,−2)`. Doubling the modeled mean adds `log2` to the predictor. A model expectation of 2 is not a deterministic count | Course-constructed from B2 Poisson form. One applied gradient after the common derivation, no separate Poisson likelihood proof or count notebook. |
| Three-class logits `z=(log2,0,0)`, observed class 3, input `x=(1,2)` | **Work, Live**. `p=(1/2,1/4,1/4)`, `ℓ=log4`, `p−t=(1/2,1/4,−3/4)`; per-observation weight gradient is `(p−t)xᵀ`. Work dimensions and signs rather than the full softmax Jacobian | Course-constructed numerical specialization of B2 §15.3.2. Connects directly to Iris targets and the lab gradient check; not an Iris fit or source numerical result. |
| One Bernoulli NLL computational graph at `x=(1,2)`, `w=(0,0)`, `y=1` | **Work fully, Live**. `r=0`; branches are `r→exp(r)→1+exp(r)→log(1+exp(r))` and `r→yr`; subtraction gives `L=log2`. Reverse seed one gives predictor contribution `1/2` from log-partition branch and `−1` from target branch, hence `bar(r)=−1/2` and `∇_wL=(−1/2,−1)` | Course-constructed graph, applying B2 §6.2.2.2 accumulation. This is the only full AD graph. Reuses a family/result already taught; no claim that B2 Fig. 6.1 depicts this model. |
| Three-species Iris with two petal measurements | **Brief Live, Work Notebook**. Assign probabilities rather than just an argmax label; compare NLL and error. The complete fit practices vector GLM learning, AD and SGD | Iris framing already in L01. Batra reference supplies inspected computational precedent, adapted as above; no source accuracy or decision-boundary result promised. |

Approximately five to seven selected visual/schema groups can support these responsibilities: common family/links comparison, residual interpretation, class-probability comparison, the one AD graph, and batch/loss trajectory plus supplied Iris plot. Book figures are available source context, **not selected exact reproductions**. No figures or finished visual layouts are specified here. The rank/separation caution is a brief conceptual safeguard, not a second worked dataset.

## 5. Lecture contract

**Starting assumptions:** rigorous probability and undergraduate Bayesian modeling; L01 Gaussian/probabilistic-prediction results; agreed L02 exponential-family moments, categorical representation and likelihood moment matching; L04 log-loss/KL interpretation can be recalled briefly. Python/NumPy familiarity, no prior PyTorch requirement.

**Central question:** how does one exponential-family modeling framework describe several response types, and how can we learn its predictor-dependent parameters from a differentiable likelihood?

**Lecture endpoint:** students can distinguish mean/link/canonical coordinates for Gaussian, Bernoulli and Poisson GLMs, derive the common scalar canonical NLL gradient with correct sign/dispersion, apply the vector categorical residual gradient, follow one full reverse-mode graph and explain minibatch SGD on the finite empirical objective.

**Notebook endpoint:** one checked three-class Iris softmax fit in PyTorch, with a manual/autograd batch-gradient comparison, visible minibatch update cycle and held-out probability/log-loss/error interpretation. **No required recording.** Planned live duration 115 minutes including reserve; separate lab 60 minutes, both estimates unvalidated.

**Supported outcomes:** identify the appropriate response family/support and canonical mean link; compute and interpret a likelihood gradient without confusing it with an update; explain reverse accumulation through a shared intermediate; translate a categorical probability objective into one checked training/evaluation workflow. No mastery of Bayesian GLM inference, general optimizer theory or neural networks is asserted.

### Coverage boundaries and proposed ledger implications

| Allocation | Material and disposition |
|---|---|
| **Core / Live, deep** | B2 §15.1/§15.1.1 canonical family form, substantive Gaussian/Bernoulli/Poisson comparison; §15.1.3 one scalar gradient; §15.3.2 essential categorical model/vector-gradient application; §6.2.2.2 one worked reverse graph; §§6.3.1–6.3.2 finite-sum SGD. Selective B1 calculus/SGD passages support these, not separate primary coverage. |
| **Short bridge / recognize or apply** | §15.1.2 noncanonical predictor distinction; §14.1.2 MLE/ERM; §14.2.1 log score; canonical convexity/rank/separation safeguard. Mentions do not mark all of these subsections covered. |
| **Notebook owned** | PyTorch onboarding, categorical loss interface, shape/target handling, local manual/autograd equality, explicit minibatch training and held-out scoring. |
| **Optional, excluded from formal promises** | Two-minute correctly scaled MAP recognition; numerical probit contrast; four-feature Iris refit; alternate batch-size experiment may be dropped if onboarding needs reserve. |
| **Deferred to named owners** | Parameter-dependent stochastic expectation gradients, pathwise/score-function distinction: L09; scalar logistic posterior approximation: L07; narrow Gaussian-prior/weight-decay analogy and nonlinear conditional predictors: L11; VAE stochastic computational synthesis: L12. No neighbor inherits an additional GLM survey. |
| **Omitted by course decision** | Hessian/IRLS/Newton derivation, optimizer convergence proofs/survey, sparse-prior taxonomy/full Bayesian GLMs, zero-inflated/binomial/ordinal/multitask catalogue, full noncanonical learning treatment, natural gradients, B2 §§6.6–6.9. These are not unassigned obligations or recording coverage. |

After approval, the coordinator should record selective **proposed** L05 allocation separately from actual delivery. The isolated Ch. 15 model source is not a sequential coverage boundary through every intervening chapter; L05 owns the chosen §15.1/§15.3.2 topics and Chapter 6 differentiation/finite-sum portions, not all of Chapters 6 or 15. No ledger or syllabus is edited by this builder.

### Scope-owned questions, risks and handoff

- **Advisory, high priority — combined GLM/AD novelty.** Protected outcomes require the 115-minute plan and two deep worked chains. Provisional treatment is a unified family comparison, one scalar gradient, short vector application and one complete graph. Smallest repair is the first-cut package above; consequential alternatives are a longer live envelope or explicitly narrowed bridges. Preserve family generality and reverse accumulation; the coordinator should raise this bounded risk in the instructor report if independent review/rehearsal cannot establish enough margin.
- **Advisory — first PyTorch exposure in 60 minutes.** Reference is much larger than the selected lab and full-batch, not a validated minibatch teaching solution. Supplied indexing/preprocessing/plotting and one loss API bound the burden. The pilot must confirm that gradient checking plus training/evaluation fit; first repair is removal of the optional batch-size comparison, not the three-class outcome or manual/autograd check.
- **Advisory — software MLE versus finite estimates.** Separable class components and softmax redundancy make finite training weights different from proof of finite/unique MLE. Interpret bounded training iterates and held-out probabilities; do not add unbudgeted priors or promise convergence to a unique coefficient estimate. The source paragraph's stronger wording must not reach downstream slides.
- **Downstream-owned — exact teaching organization and software/version checks.** Section Design owns successive student states and boundaries; notebook authoring owns scaffolding and local/Colab execution. Neither may silently remove a load-bearing live result to resolve its workload.

**Next owner:** Instructor oversight of this reviewed proposal. Subsequent Section Design requires human acceptance; its execution backpressure returns to the nearest owning stage. Review and approval provenance are in the registry. No rehearsal, notebook runtime or hosted Colab validation is implied.
