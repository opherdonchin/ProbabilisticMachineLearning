# Curriculum alternatives, L04–L10 — comparison for instructor review

**Historical comparison (2026-10-11):** This document compares the original combined L04 + GLM L10 against the earlier proposed *optimization-led* L05. It predates the instructor's refined **GLM-and-optimization** L05 proposal and should not be treated as a current scope decision. For the revised briefs and capacity concerns, see [current initial scope previews](curriculum_scope_previews.md). The unchanged original sequence remains on main. This record is retained for provenance.


**Status:** PROVISIONAL / NOT APPROVED (corrected comparison, 2026-10-11). This replaces the earlier, incorrectly framed L04–L06 comparison, which had offered a GLM lecture in L05. That was **not** the instructor's proposed alternative.

**Authoritative baseline:** [main-branch syllabus plan](https://github.com/opherdonchin/ProbabilisticMachineLearning/blob/main/syllabus_plan.typ). The proposed revision is in [this branch's syllabus plan](../syllabus_plan.typ). Actual delivery and agreed scopes in [the material ledger](material_ledger.md) take precedence over tentative syllabus predictions.

**Question:** Is it more valuable to **retain the original combined L04 information/optimization lecture and the later L10 GLM lecture**, or to **give information and optimization separate lectures (L04/L05), shift intervening lectures one position, and remove the standalone GLM slot**?

**Instructor's aim for information theory:** Treat it as a computational field in its own right, *and* show why its central tools matter for machine learning. Do not reduce it to a list of loss functions. Both routes must be judged partly against this aim.

**Evaluation method:** Same-context application of [lecture-scope skill](../.agents/skills/lecture-scope/SKILL.md) (coherence, useful endpoint, notebook handoff, prerequisites, time feasibility, continuity, later value), [timing calibration](../.agents/skills/lecture-scope/references/timing-calibration.md), current syllabus, L01 delivery, L02 agreed scope and undergraduate prior knowledge. No independent specialist or separately named "account" skill was run; judgments below are qualitative estimates, not validation.

> **Updated assessment (2026-10-11):** The deeper [optimization-versus-GLM distribution and overload audit](optimization_vs_glm_distribution_audit.md) supersedes the coarse scores below. It finds substantial natural homes for advanced optimization in EM, VI and neural networks, and identifies L11 load from displaced GLMs as a consequential risk. Read the detailed audit before treating 23/30 versus 26/30 as a recommendation.

## The two actual progressions, *through the displaced L10 GLM meeting*

| Meeting | A — keep existing main syllabus (no **dedicated** optimization lecture) | B — information + dedicated optimization, remove standalone GLM (branch proposal) |
|---|---|---|
| **L04 (11 Nov)** | **Information, objectives, and optimization**: selected KL/cross-entropy plus autodiff/SGD; PyTorch Iris softmax notebook. Mutual information and coding are not substantive commitments in the current baseline. | **Information theory**: entropy, KL, MI/data processing, one serious coding application; noisy-channel decoding / information notebook. |
| **L05 (18 Nov)** | **EM / latent-variable learning**: hidden variables, bounds, E/M steps; missing-Gaussian-data or MRI/GMM notebook. | **Optimization of probabilistic models (+ GLM example)**: loss, derivative, autodiff, SGD, GLM likelihood/softmax; PyTorch Iris notebook. |
| **L06 (25 Nov)** | **Inference as computation**: numerical integration, MAP, Laplace, contrasting inference methods; logistic grid-vs-Laplace notebook. | **EM / latent-variable learning**: same substantial topic and notebook candidates as A, one meeting later. |
| **L07 (2 Dec)** | **Exact structured inference**: HMM/forward-backward, Gaussian filtering/Kalman candidate notebook. | **Inference as computation**: same as A L06. |
| **L08 (9 Dec)** | **VI and amortized inference**: ELBO, approximations, gradient estimators as needed; regression VI notebook. | **Exact structured inference**: same as A L07. |
| **L09 (16 Dec)** | **Monte Carlo / MCMC**: MH, Gibbs, HMC; multimodal mixture-sampling notebook. | **VI and amortized inference**: same as A L08. |
| **L10 (23 Dec)** | **Dedicated GLMs / regularization**: family, links, logistic likelihoods, priors/penalties, calibration; L1/L2-regularized digits notebook (or Poisson GLM). | **Monte Carlo / MCMC**: same as A L09. **The L10 GLM lecture disappears**. |
| **L11 (30 Dec)** | **Neural networks** as conditional models, PyTorch reused from L04. | **Neural networks**, PyTorch reused from L05; must incorporate selected GLM content: regularization as prior/penalty, proper predictive scores, calibration. |
| **L12 (6 Jan)** | **VAE**, possibly selected rate-distortion/MI return if L04 has introduced them. | **VAE**, with L04 MI/rate-distortion foundations available for β-VAE, information bottleneck framing and posterior-collapse interpretation. |

**Exactly one additional lecture** is allocated to early material in B. The inference sequence shifts from L05–L09 to L06–L10. L11–L13 retain their dates. No extra meeting has been invented.

## Alternative A: strengths and liabilities

**Arc:** information-theoretic objectives and practical parameter optimization (L04) → learning with latent variables (L05) → inference and algorithms (L06–L09) → rich interpretable GLM prediction (L10).

**Value:** best full lecture on interpretability, likelihood family, regularization, calibration and classical scientific analysis. A retains the dedicated scikit-learn regularized-digits notebook and an early PyTorch Iris lab. Smaller perturbation to the present syllabus; no extra load on L11.

**Main problem:** L04 already combines (i) theoretical KL/cross-entropy, (ii) autodiff/SGD mathematics and (iii) PyTorch onboarding + Iris. Adding substantial MI and operational source/channel coding *without removing something else* would make L04 overfull. If this route is selected, the instructor must decide how to honor the revised information-theory goal: a small MI/data-processing inclusion and a short illustrative coding example might fit, but **a genuine information-theory coding notebook would displace Iris or some optimization material**. Do not silently promise both.

**Opportunity cost:** information theory risks being treated largely as optimization objectives. Autodiff/SGD is taught, but without a full dedicated mathematical slot. The optimized-but-latent EM step arrives immediately after a necessarily compressed L04.

## Alternative B: strengths and liabilities

**Arc:** operational information, dependence and coding (L04) → optimizing a likelihood via autodiff/SGD, with categorical GLM (L05) → latent-variable EM (L06) → explicit/general, structured, variational and Monte Carlo inference (L07–L10).

**Value:** distinct conceptual endpoints and complementary notebooks (discrete-channel coding; differentiable categorical model). MI/rate-distortion becomes reusable in VAE. Gradients/autodiff/SGD acquire a reusable foundation before EM, VI and neural networks; no need to distribute their *first* substantial introduction into an already-dense downstream lecture.

**Main problem:** L05 must not become an indiscriminate tour of Ch. 6. It has two hours for a model-to-objective-to-gradient-to-update chain, a carefully chosen reverse-mode AD derivation, and the opening of PyTorch. Treat score-function gradients, natural gradients, Bayesian optimization, optimal transport, derivative-free and submodular methods as later/optional, *not* covered in L05.

**Opportunity cost:** no systematic graduate GLM lecture, especially the family-of-likelihoods view, Poisson GLMs, model interpretation, detailed ridge/lasso contrast and proper calibration. Preserve *selected* GLM elements explicitly:
- L05: exponential-family likelihood → link/predictor → categorical softmax / MLE, with regularization as a brief prior/penalty interpretation;
- L07: logistic regression with posterior grid vs Laplace;
- L11: regularization/prior and predictive scoring/calibration in the neural probability-output context;
- *Not preserved as a required notebook:* standalone L1/L2 regularized digit classification or dedicated Poisson example.

L11's proposed displaced content is **not free**. If its scope proves too dense, either narrow architectural survey or accept specific GLM losses; do not mark those subjects as covered solely because mentioned.

## Coherence / feasibility / value — provisional scoring

**Scale:** 1 = weak, 3 = workable with substantial limitations, 5 = strong; these are *same-reviewer judgments*, not measured outcomes. Each dimension applies to the **whole L04–L10 path**, not an isolated lecture. Equal weights are used deliberately; the instructor can set different priorities.

| Criterion | A: combined L04 + L10 GLM | B: dedicated L04 information + L05 optimization |
|---|---:|---:|
| Conceptual coherence across L04–L10 | 4 | 4 |
| Feasibility of the two-hour lectures and one-hour notebooks | 4 | 3 |
| Fidelity to operational information-theory objective | 2 | 5 |
| Novel/transferable computational skills beyond undergraduate Bayes | 4 | 5 |
| Direct biomedical/statistical modeling value | 5 | 4 |
| Foundations reused in L08–L12 | 4 | 5 |
| **Unweighted total (maximum 30)** | **23** | **26** |

**Verdicts:** A: **feasible** *as currently written*, but **feasible-with-risks** if the newly stated MI/coding goal is imposed. B: **feasible-with-risks** owing to L04 breadth, L05 mathematical/PyTorch density and L11 displaced GLM content. The scores favor B **slightly**, chiefly because the instructor's explicitly stated information-theory objective is not fulfilled by A unchanged; different pedagogical priorities could reverse this judgment.

**Critical sensitivity:** If information theory only needed MI as a mathematical objective, A is extremely attractive. If students should actually compute with coding and channels, B has a substantial advantage. If full GLM modeling practice is indispensable for this MSc audience, A has a substantial advantage.

## Lecture extents / notebooks / explicit boundaries

- **L04 A:** probably **tight** already if KL theory, autodiff and PyTorch onboarding all receive substantial mathematical treatment. Preserve Iris notebook; adding genuine coding requires an explicit displacement decision.
- **L04 B:** **tight** unless one of source or channel coding is selected as the single substantive application. Preferred candidate: [Murphy error-correcting-code demonstration](https://github.com/probml/pyprobml/blob/master/notebooks/book2/05/error_correcting_code_demo.ipynb); reference not yet executed or adapted. Keep deep IB/rate-distortion for L12.
- **L05 B:** **tight** if complete multi-class GLM treatment, autodiff internals and advanced stochastic gradients are all required. Reserve PyTorch training implementation for the notebook; lecture's math spine focuses on essential differentiation/optimization. [Batra Iris worked source](https://github.com/nipunbatra/pytorch-basics/blob/main/notebooks/04-softmax-regression.ipynb).
- **EM A L05 / B L06:** do not assume EM *requires* differentiation or SGD; emphasize surrogate lower bounds and alternating inference/parameter fitting as a distinct optimization mechanism. Keep the previously selected single MRI-vs-missing-data notebook choice.
- **A L10:** guard against overloading a classical-GLM talk with both the whole model family and a long survey of ridge/lasso/calibration; current course plan remains tentative.
- **B L11:** limited realistic capacity to absorb regularization *and* calibration. Revisit when that lecture's scope is designed.

The [timing calibration](../.agents/skills/lecture-scope/references/timing-calibration.md) uses L01 (~61 content slides) as an instructor-specific *anchor*, not a claim that these scopes have been rehearsed. These qualitative extent ratings are provisional; no slides, notebook runtimes or actual live timings were validated here.

## Dependencies and instructor decisions

1. Decide whether **A unchanged** adequately meets the information-theory goal, or which concrete content and notebook A would sacrifice to accommodate it.
2. Decide whether **B L05** may give mathematical depth to autodiff/SGD *and* preserve enough GLM substance through Iris, rather than attempt everything in Book 2 Ch. 6.
3. Decide which GLM material is genuinely required: model family / links, L1–L2 priors, calibration, Poisson application, scikit-learn skills.
4. Choose **one** coding notebook endpoint for B L04 and test its reference solution in the supported runtime.
5. If B is approved, revalidate the updated formal syllabus, notebook assignments, and L11/L12 scope; the coverage ledger must continue to distinguish plans from delivery.

**Branch representation:** This branch's `syllabus_plan.typ` and `advanced_statistics_2027_1_syllabus.typ` instantiate **B as a proposal** to make the displacement test concrete. **A is the intact baseline on `main`**, not the previously erroneous L05 GLM alternative. The existence of B files does not constitute instructor approval. Do not merge until the decision is made.
