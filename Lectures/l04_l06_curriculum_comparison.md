# L04–L06 curriculum alternatives — instructor review

**Status:** PROPOSAL / NOT APPROVED (2026-10-10). This document is an aid to selecting a curriculum, not an accepted Lecture Scope or a change to delivered coverage.
**Base:** current `main` syllabus plan and actual L01 coverage ledger; L02 is an agreed scope, L03 and later are tentative.
**Method:** same-context comparison using [lecture-scope](../.agents/skills/lecture-scope/SKILL.md) priorities and [timing calibration](../.agents/skills/lecture-scope/references/timing-calibration.md). **No independent specialist agent reviewed this.** A named "account" skill was not found among the repository's skills.
**Time:** each lecture has approximately two hours of teaching and a separate one-hour student notebook. Listed content is a provisional intellectual destination, *not* a promise to cover every cited page or subsection.

## Shared commitments: what L04 must accomplish

The instructor's aim is **between a purely abstract information-theory survey and a training-objectives treatment**. Students should understand information theory as a computational discipline with tools that are fundamental to machine learning.

Both alternatives therefore share the same *provisional* L04:

- **Question:** What does information measure, and how does it constrain useful representation and communication?
- **Mathematical spine:** entropy, cross-entropy and KL; `I(X;Y) = D_KL(p(x,y) || p(x)p(y))`; conditional MI at recognition level; data processing inequality; source coding and/or a noisy-channel decoding example. Book 2 §§5.1–5.3, selected §§5.4–5.5.
- **Working endpoint:** calculate a quantity with an operational meaning (information preserved across a noisy channel, or coding cost); show where it enters an ML problem.
- **Notebook, preferred:** a tiny parity-check error-correcting code: enumerate `p(x,y)`, compute entropies/MI, infer `p(x|y)`, and compare decoding accuracy across noise levels. Adapt Murphy's [error_correcting_code_demo.ipynb](https://github.com/probml/pyprobml/blob/master/notebooks/book2/05/error_correcting_code_demo.ipynb), rather than requiring JAX. Alternative: empirical source entropy versus lossless code length. **Not yet executed or timed.**
- **Scope boundary:** do **not** derive the full information bottleneck or variational MI-estimation methods here. Give only a short rate-distortion / bottleneck orientation if space permits. The substantive return is L12 VAE (Book 2 §§5.4.2, 5.6, 21.3–21.4). Detailed channel coding is optional if the lecture is too dense.

This lecture itself is **tight** if *both* source- and channel-coding are substantive. At the lecture-scope stage choose one concrete coding path; use the other only as a comparison.

## Alternative A: Information → Optimization → EM (current review-branch proposal)

| Lecture | Intellectual job and mathematical endpoint | Notebook endpoint | Main deferrals |
|---|---|---|---|
| L04 Information theory | The shared L04 above. Operational measures, dependence and the consequences of lossy/noisy representation. | Noisy-channel decoding and MI, or source-coding experiment | Full bottleneck, variational MI bounds, bits-back |
| L05 Optimization of probabilistic models | From likelihood/cross-entropy to `∇θ L`, reverse-mode autodiff and mini-batch SGD. Work categorical/softmax regression as an **actual GLM**, linking the L02 exponential family to parameter learning. Book 2 §§6.1–6.3.3 and selected §§15.1, 15.3. | PyTorch three-class Iris likelihood fit; write/update a training loop, check gradient/fit and predictive probabilities. [Worked reference](https://github.com/nipunbatra/pytorch-basics/blob/main/notebooks/04-softmax-regression.ipynb). | Score-function and reparameterization gradients to L09 VI/L12 VAE; natural gradient optional; advanced §§6.6–6.9 not committed |
| L06 Latent-variable learning with EM | Hidden assignments, observed/complete-data likelihoods, bound improvement, E/M steps; connect to exponential-family sufficient statistics. Book 2 §6.5 and selected §28.2. | Explicit Gaussian missing-data EM or GMM/MRI segmentation; one candidate must be validated | Advanced EM variants unless the concrete example needs them |

**Coherence test:** L04 introduces information-theoretic functionals; L05 makes a probabilistic objective computationally learnable; L06 teaches optimization when the objective contains hidden variables. The L05→L06 transition is strong. The L04→L05 transition needs an explicit shared bridge, e.g. negative log-likelihood/cross-entropy as a learning objective, while protecting L04's own coding endpoint.

**Downstream:** L07 inference overview, L08 structured filtering/message passing, L09 VI, L10 MCMC, L11 neural prediction and L12 VAE. PyTorch begins in L05; GLM structure is learned in L05, Bayesian logistic Laplace is revisited in L07, regularization/predictive calibration receive *selected* treatment in L11. A dedicated GLM-model-family survey and standalone L1/L2 digit-classification lab are sacrificed.

**Feasibility pressure:** L05 will be *tight* if we add a detailed autodiff derivation, stochastic gradient estimators and a full multinomial-GLM treatment simultaneously. Limit the core to one end-to-end likelihood/gradient/optimizer chain, plus one intelligible reverse-mode example. L06 is comparatively stable because an EM example was already allocated a full meeting.

## Alternative B: Information → GLMs → EM (not adopted in the branch's provisional schedule)

| Lecture | Intellectual job and mathematical endpoint | Notebook endpoint | Main deferrals |
|---|---|---|---|
| L04 Information theory | Identical shared L04. | Identical information-theory notebook. | Identical deferrals. |
| L05 Probabilistic prediction with GLMs | From exponential-family likelihood to linear predictors, links, MLE/MAP, regularization and calibration. Include only enough derivative-based training to make the estimation concrete. Book 2 §§15.1–15.3, selected §14.2 and Book 1 regression/penalty treatments. | Either an interpretable Poisson/biomedical GLM or an L1/L2-regularized classification experiment (existing scikit-learn worked reference). | A systematic account of automatic differentiation, stochastic computation graphs and mini-batch optimization. |
| L06 Latent-variable learning with EM | Same as A. Connect EM to a concrete likelihood rather than a broad optimization foundation. | Same as A. | Same as A. |

**Coherence test:** L04→L05 naturally connects cross-entropy and likelihood to statistical prediction; L05→L06 generalizes from observed-data parameter estimation to hidden-data parameter estimation. This is a persuasive *models first* sequence.

**Downstream:** The theory of gradients/autodiff/SGD must be distributed later: basic operations in L05's notebook *or* first PyTorch introduction in L11; stochastic gradient estimators in L09; reparameterization in L12. If PyTorch is first introduced in L11, L11 must now carry both neural-network mathematics and the first major differentiable-programming skill. If L05 introduces PyTorch, it becomes a less focused GLM lecture. The current early-PyTorch decision would need an explicit exception or revision.

**Feasibility pressure:** GLM coverage is comfortable only after narrowing the model family or its statistical extensions; categorical logistic + Poisson + detailed regularization + calibration in two hours is **tight**. The choice between a PyTorch-based optimization lab and a scikit-learn modeling lab is consequential.

## Comparative assessment

Scores are *judgmental ordinal ratings* (1 weak → 5 strong) anchored in the current syllabus, prior undergraduate preparation, and the scope skill's evaluation criteria. They are **not empirical results, rehearsal times, or an independent expert panel**. The shared information-theory lecture contributes equally and does not decide the comparison.

| Dimension | Weight | A: Optimization | B: GLMs | Main reason |
|---|---:|---:|---:|---|
| Coherence across L04–L06 | 25% | 4 | 4 | Both have a substantive arc; A proceeds information→objectives→latent objectives, B information→prediction→latent modeling |
| Payoff for L07–L12 | 25% | 5 | 3 | A builds reusable autodiff/SGD skill earlier; B leaves a methodological gap to fill |
| Scientific/modeling applicability | 20% | 4 | 5 | B develops directly interpretable likelihood and GLM choices more fully |
| Novelty beyond undergraduate Bayes | 15% | 5 | 3 | Bayesian regression and likelihood modeling are already familiar; differentiable programming less so |
| Feasibility within lecture + notebook time | 15% | 3 | 4 | A's autodiff/optimizer/PyTorch introduction is tight; B can use existing modeling tools |
| **Weighted heuristic (out of 5)** | **100%** | **4.25** | **3.80** | A's advantage is not robust to a preference for immediate applied GLM depth over reusable optimization infrastructure |

**Verdict:** Both alternatives are **feasible with risks** at provisional-scope level. A is favored because of stronger downstream reuse and non-redundancy with prior statistics coursework, *not* because GLMs are unimportant or because all of Chapter 6 is essential. It is a modest preference requiring instructor review, not an approval.

## Specific follow-through and omissions

| Essential element | A: proposed home | B: proposed home / risk |
|---|---|---|
| Entropy, KL, MI, data processing | L04 | L04 |
| Coding as computational application | L04 notebook | L04 notebook |
| Information bottleneck and rate-distortion | Selected return in L12 VAE | Selected return in L12 VAE |
| GLM as exponential-family conditional model | L05 softmax | L05 main mathematical spine |
| Logistic likelihood / MLE gradients | L05 | L05 |
| Bayesian logistic posterior / Laplace | L07 | L07 |
| Regularization as prior/penalty | L05 briefly + L11 selected | L05 substantively |
| Predictive scoring and calibration | L11 selected; at risk of being squeezed | L05 |
| Poisson and other non-Gaussian GLMs | Not promised; possible L11 example | L05 if time |
| Autodiff + stochastic mini-batch learning | L05 main mathematical spine | Fragments in L05/L11; risk of no coherent treatment |
| Score-function/reparameterization estimators | L09 VI / L12 VAE | L09 VI / L12 VAE, possibly without foundation |
| EM bound optimization | L06 | L06 |
| Full Book 2 §§6.6–6.9 | Deliberately unassigned | Deliberately unassigned |

## Decisions to make before approving and propagating this branch

1. **A or B?** In particular, is a systematic GLM-model-family treatment worth postponing the common optimization foundation?
2. **L04 coding endpoint:** error-correcting noisy-channel inference (preferred) or genuine source coding? Both should not become full one-hour notebook promises.
3. **L05 A mathematical depth:** how far through reverse-mode AD and gradient estimators, while preserving the complete Iris notebook handoff?
4. **GLM preservation:** is a brief treatment of calibration and regularization in L11 enough, or is a separate required notebook/recording necessary?
5. **L12 load:** include IB/rate-distortion as an integral conceptual framework, but determine whether InfoVAE details displace other planned VAE material.

All lecture scopes, section plans, notebook references, runtime tests, and timing estimates require separate validation if the instructor selects a route. **Do not merge without approval.**
