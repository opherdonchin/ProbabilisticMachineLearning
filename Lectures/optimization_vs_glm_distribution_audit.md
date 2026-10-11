# Detailed curriculum audit: distributing optimization versus GLMs

**Date:** 2026-10-11. **Status:** Instructor review; neither path approved. **No changes to the proposed timetable are implied by this audit.** Compare [current baseline on main](https://github.com/opherdonchin/ProbabilisticMachineLearning/blob/main/syllabus_plan.typ) with [split proposal on branch](../syllabus_plan.typ). This supplements [the existing L04–L10 comparison](l04_l10_curriculum_comparison.md) and supersedes its coarse numeric evaluation.

## Question and criteria

Two actual options:

- **A — retain GLM L10:** the main syllabus has information/objectives/basic optimization combined in L04, EM L05, general inference L06, structured inference L07, VI L08, MCMC L09, GLMs L10, neural networks L11, VAEs L12. Optimization detail must be distributed beyond the early L04 foundation. *Importantly, the main syllabus as written does not substantively cover MI/coding; making the instructor's newer information-theory goal real requires a scoped revision, not pretending the main draft already does it.*
- **B — retain separate optimization L05:** this branch's information/coding L04, differentiable optimization + categorical GLM L05, EM L06, general inference L07, structured inference L08, VI L09, MCMC L10, no standalone GLM; neural networks L11 and VAEs L12.

Evaluate not "how many subchapters are cited" but (i) which mathematical claims students can derive, (ii) which computational skill they genuinely practice, (iii) what becomes coherent only when gathered together, (iv) where material fits *because* the host lecture needs it, and (v) new load on lecture and notebook. Each lecture has about 100–120 live minutes plus one-hour student notebook. The L01 slide-count calibration is preliminary, not a workload measurement for these as-yet-unscoped lectures. L02 is already scoped; do **not** silently add GLMs to it.

### Overall structural finding

Chapter 6 **is not a single pedagogical dependency chain**. A number of its parts have excellent homes in independent course lectures. A single optimization slot should therefore be judged by the depth of **AD / stochastic training foundations**, not by a supposed ability to cover all of Chapter 6. By contrast, the unifying GLM framework connects otherwise separate examples in a way not automatically achieved by seeing softmax in L05, a Laplace logistic posterior in L07, and regularization in L11. This is a genuine pedagogical asymmetry.

## Exact Book 2 Chapter 6 allocation

Notation: **Core** = worked mathematical idea/skill; **Partial** = narrowed concept or example; **Optional** = could be used but should not be claimed; **Not allocated** = intentionally no course commitment. L-numbers differ between A and B.

| Book 2 section | A: no dedicated optimization lecture | B: dedicated L05 | Assessment of natural fit |
|---|---|---|---|
| §6.1 optimization framing | **Core** L04 via negative log-likelihood / information objective | **Core** L05 via GLM likelihood | Equally natural |
| §6.2.1 derivatives as linear maps, JVP/VJP | **Partial** L04: chain rule and gradient; **Core** L11 for backprop as reverse-mode AD if deliberately scoped | **Core** L05 in a compact example; revisit L11 for backprop | B yields earlier systematic account; A teaches the same ideas when neural computation makes them concrete. L11 is already broad. |
| §6.2.2 chains, circuits, reverse-mode differentiation | **Partial** L04 just enough to understand autograd; deeper treatment **Core candidate** L11 NN | **Core** L05, reuse L11 | A can be more intuitive, B more explicit mathematical foundation; neither needs full treatment of general programs/circuits |
| §6.3.1–6.3.2 SGD and finite-sum minibatch objectives | **Core** L04 + PyTorch Iris notebook; revisit L11 training | **Core** L05 + same Iris notebook; revisit L11 | Both must teach early: Iris fit requires an actual optimizer loop. No meaningful advantage from postponing *all* optimization until L11. |
| §6.3.3 SGD for distribution-dependent expectations | **Partial or optional** L08 VI (after L04 basic SGD) | **Partial or optional** L09 VI (after L05 basic SGD) | Most meaningful in VI, not in Iris softmax training |
| §6.3.4 score function / REINFORCE | **Core candidate** L08 VI as one route to gradients of expectations | **Core candidate** L09 VI | An excellent local motivation for the mathematics; too abstract to front-load without a stochastic objective |
| §6.3.5 reparameterization | **Core candidate** L08 VI and definitive return L12 VAE | **Core candidate** L09 VI and definitive return L12 VAE | Fits better in VI/VAE, despite B's extra lecture |
| §6.3.6–6.3.8 Gumbel softmax, stochastic computation graphs, straight-through | **Optional** L12 only if discrete-latent VAE is explicitly chosen | **Optional** L12 on same condition | No automatic inclusion in either syllabus |
| §6.4 natural gradient (incl exponential-family Fisher geometry) | **Optional** L08 VI; conceptual connection to L02 log-partition geometry | **Optional** L09 VI | Mathematical depth substantial; including full derivation would exacerbate VI overload. No requirement in either option. |
| §6.5.1–6.5.6 MM / EM | **Core, selected** L05 EM, especially general minorization and EM; one worked missing Gaussian or GMM problem | **Core, selected** L06 EM | EM is a different kind of bound optimizer; belongs in its own lecture regardless of B |
| §6.6 Bayesian optimization | **Not allocated** | **Not allocated** | Needs own experimental-design / black-box-optimization application, not a casual add-on |
| §6.7 derivative-free methods | **Not allocated** | **Not allocated** | A distinct algorithm family, not to be conflated with MCMC |
| §6.8 optimal transport | **Not allocated** | **Not allocated** | Possible generative-model extension but L12 VAE already dense |
| §6.9 submodular optimization | **Not allocated** | **Not allocated** | Applications to feature/sensor selection are real but not in current core lecture sequence |

**In A, the distributed optimization spine actually works:** objective/SGD L04 → EM L05 → gradient estimators in VI L08 → backprop in NN L11 → reparameterization/optimization with latent codes L12. Main risk: students operate PyTorch in L04 while the mathematical implementation of reverse-mode AD may not be explained until L11. Address with a **minimal correct AD explanation in L04**, then a genuine derivation in L11, not six weeks of treating autograd as magic.

**In B, L05's unique additional content beyond A's L04 is the unified, substantial treatment of AD/optimization and more room for training details.** It does *not* newly unlock EM, REINFORCE, reparameterization, natural gradients, BO, transport or submodularity: those either remain later or unallocated. Claiming that B covers more of Chapter 6 just by allocating L05 to it is misleading.

## Book 2 Chapter 15, and §14.2, allocation

Chapter 15 has a powerful central mathematical idea: exponential-family response model + linear predictor/link + fitted conditional probability. Examples and inference algorithms are distributable; **a comparative model-family account** is much less so.

| Material | A: dedicated GLM L10 | B: distributed GLM coverage | What students actually gain/lose |
|---|---|---|---|
| §15.1.1 popular GLMs, common architecture; §15.1.2 links | **Core L10**, conditional Gaussian/Bernoulli/multinomial and at least one count/Poisson example if time | **Partial L05**: categorical softmax GLM, likely quick general form and link function; **not** a multi-family comparison | A gives a meaningful framework for choosing a probability family/link in biomedical problems; B gives one legitimate GLM but weak transfer across different response types |
| §15.1.3–15.1.4 MLE and Bayesian GLM inference | **Partial L10**, building on prior inference/VI/MCMC | **Core L05** for categorical MLE, **partial L07** for Bayesian logistic posterior | B distributes learning mechanisms naturally and may be equally strong for estimation mechanics, not for model-family coherence |
| §15.2.1 Gaussian/OLS | **Review/bridge L10** | **Prior knowledge**, perhaps bridge in L11 | Neither should spend long reteaching familiar regression |
| §15.2.2–15.2.4 priors | **Selected L10** | **Brief L05** MAP; **selected L11** NN weight decay/priors | Bayesian regularization already partly familiar; detailed interpretation easier in A |
| §15.2.5–15.2.8 spike-slab, lasso, horseshoe, ARD | **Select one or two L10** (ridge/lasso contrast strongest); **not** a promise to teach all | **Selected L11** weight decay vs sparsity *if room*, possibly no variable-selection story | B's main tangible loss: regularization as scientific model selection rather than merely training stabilization |
| §15.3.1–15.3.2 binary and multinomial logistic | **Core L10**, referencing L04 Iris softmax | **Core L05** multinomial Iris; **partial L07** one-dimensional logistic posterior | Both can retain a mathematically serious logistic likelihood; A more explicit binary/multinomial relation |
| §15.3.3–15.3.4 imbalance and priors | **Selected L10** | **Possible L11**, not guaranteed | Not essential to course spine |
| §15.3.5–15.3.8 posterior approximation / prediction | **Connection L10** to previously learned Laplace, VI and MCMC | **L07** grid/Laplace logistic posterior; posterior predictive **selected L11** | B can be strong algorithmically, but pieces are separated in time |
| §15.4 probit; §15.5 hierarchical GLMs | **Optional / not automatic in L10** | **Not allocated** | These do not independently justify keeping L10; students have prior Bayesian/hierarchical regression experience |
| §14.2 proper scoring / calibration | **Core/selected L10** as model evaluation of probabilities | **Selected L11**, competing with NN architecture and heteroskedastic prediction | B risks no properly developed probability calibration or evaluation lecture |
| GLM-specific notebook | **One-hour L10 lab**: scikit-learn digit classification, coefficient sparsity vs error; possible biomedical Poisson | **L05 Iris PyTorch**, no separate GLM lab | A offers model comparison/evaluation/interpretability; B offers core softmax training but no additional comparative modeling lab |

**In B, L05 → L07 → L11 is a plausible application chain** (fit a categorical GLM; infer a logistic posterior; replace the linear predictor with nonlinear networks). However, those encounters do **not** amount to a cohesive comparative exposition of GLMs unless we deliberately give students a summary contrasting the response distributions, links and purposes. There is no free lecture for that summary. In A, L10 is particularly well placed **just before L11 neural nets**: from interpretable linear conditional distributions to nonlinear conditional parameterizations. It is also a synthesis of the preceding inferential methods applied to a scientifically common model.

**Yet A L10 is itself at risk of overpromising.** Murphy Ch. 15 includes many more priors, logistic-inference methods, probit and hierarchical extensions than a two-hour lecture can responsibly teach. To earn its slot, A L10 must center on **model choice, links, regularization and calibration, a scientific endpoint, and one lab** — not a comprehensive catalogue of §§15.1–15.5.

## Information theory, the nonnegotiable third constraint

The instructor's goal is neither information theory as pure communications engineering nor mere loss-function terminology: **the computational discipline and its important tools for ML**.

- **A as written on main:** entropy/KL/cross-entropy; introductory autodiff and Iris. **MI, data processing and operational source/channel coding are not substantive commitments.** It does **not** satisfy the stronger information goal without modifying L04.
- **A refined (not yet instantiated):** L04 teaches essential entropy/KL/MI and one **worked** coding example but compresses optimizer/AD depth to the prerequisite for Iris notebook. The rest of optimization is distributed according to the matrix above. This is *plausible but tight*. There is only one student notebook hour; keeping the full PyTorch/Iris fitting lab means the coding example is primarily in the lecture, **not** a full one-hour independent coding notebook. Assigning coding to L07 structured message passing would overload an HMM+Kalman lecture; assigning rate-distortion/IB to L12 is natural but does not replace the operational coding practice.
- **B:** L04 gains a coherent mathematical/coding endpoint and a dedicated information notebook; L05 inherits Iris/PyTorch. This is a real pedagogical gain, not just the absence of the GLM lecture.

**MI/rate-distortion return in L12** under either choice if the material is introduced in L04. It should be integrated selectively with β-VAE and posterior collapse. Full classical IB, variational IB, InfoVAE and all VAE mechanics in one lecture would be overfull in **both** schedules. A's weaker MI introduction makes the later return harder.

## Load propagation: absolute and incremental risks

Scale: **M** moderate, **H** high/tight, **VH** very high/likely overloaded *if the entire currently listed content is treated substantively*. All are qualitative scope-level estimates; no slide drafts/timing tests and no claim of measured teaching pace. The row labels give the topics occupying a given *meeting*, not the same named subject in both paths.

| Meeting | A: keep GLM L10 | B: add optimization L05 | Sources of pressure and opportunities to trim |
|---|---|---|---|
| L02 (already scoped) | H | H | Exponential family, MVN canonical algebra, moments/MLE, max entropy, Markov estimation; **no room to offload full GLM** without reopening agreed scope |
| L03 | H | H | MRFs/Ising/partition functions/graph review plus denoising, with later sampling method used locally. Unchanged by choice. |
| **L04** | **VH if MI/coding added; H as currently written** | **H** | A's information + optimizer + PyTorch is the main bottleneck. B's full Chapter 5 still must be trimmed to one coding application. |
| **L05** | H: EM | **VH: optimization + GLM model + autodiff + PyTorch** | A's EM one-example endpoint is stable; B must stop well before advanced Ch. 6 methods. |
| L06 | H: general inference | H: EM | General inference has large menu, keep a few decision principles and one Laplace example; EM should use only one full application. |
| L07 | **VH: HMM + Kalman** | H: general inference | Structured exact inference combines distinct algebraic cases; a second complete method and full notebook would be too much. |
| L08 | **VH: VI/ELBO + CAVI + black-box gradients + amortization** | **VH: HMM + Kalman** | In A, moving §6.3.4/5 here makes VI heavier; choose one gradient estimator in depth and postpone others, or relax amortization. |
| L09 | H: MCMC/MC | **VH: VI/ELBO + CAVI + black-box gradients + amortization** | In B, optimizer background helps but cannot remove time cost of VI's *new conceptual content*. |
| **L10** | **H: GLM family + penalties + calibration + lab** | H: MCMC/MC | A must select few GLM variants; B's MCMC width remains unchanged, merely renumbered. |
| **L11** | **H: NN architecture + backprop + probabilistic prediction** | **VH if GLM regularization/calibration carried in** | B incurs displaced GLM load on an already broad lecture; must drop architectures or admit some GLM content not covered. A can use L10 as explicit conceptual bridge. |
| **L12** | **H/VH if full MI/IB added** | **H/VH if full MI/IB added** | Both need VAE generative derivation + reparameterization + model implementation. B's better L04 preparation helps recognition, not runtime. |

**Two important overload conclusions:**

1. B **shifts** the initial L04 overload into a distinct L05 optimization lecture, but does not make L05 light; it also creates *extra L11 pressure*. VI, HMM/Kalman, MCMC and VAE retain their intrinsic widths under both choices. A's well-distributed advanced optimization does not necessarily impose substantially more later load, because those ideas are needed to understand their host methods anyway.
2. A's most serious pressure is **information-theory fidelity in L04**, not the absence of a standalone optimization lecture. If students are expected to *write actual coding/decoding algorithms* in their notebook, A has no obviously available notebook slot without displacement. B's separate information notebook solves that problem.

### A: what to move out of L04, concretely

- **Keep in L04:** KL, entropy/cross-entropy; MI + data processing (selective); negative log likelihood; ordinary SGD and minimal autograd explanation. Retain Iris notebook only if its first PyTorch exposure is scaffolded adequately.
- **Move to L11:** deeper §6.2 JVP/VJP, reverse-mode computational graph and neural-network backprop; do not merely repeat the API.
- **Move to L08:** §6.3.3–6.3.5 as they arise in VI, but **one estimator** can be a worked derivation while the other is compared.
- **L05 EM:** §6.5 independently, without claiming basic SGD is required for EM.
- **L12:** reparameterization as a VAE training mechanism, and rate-distortion/selected IB as interpretation. Do not try to add full InfoVAE or a new coding lab.
- **Explicit omissions:** §6.4 natural gradients and §§6.6–6.9 are not promised. §6.3.6–6.3.8 only if a fitting discrete-latent VAE application is selected.

### B: what to keep of GLMs, concretely

- **L05:** §15.1.1/§15.1.3 narrowed to one exponential-family conditional likelihood, §15.3.2 softmax; the Iris notebook is truly categorical GLM fitting, not only an abstract optimization example.
- **L07:** §15.3.1/§15.3.5, logistic posterior and Laplace; link between likelihood, approximate posterior, predictive uncertainty.
- **L11:** selected §15.2 prior/penalty intuition and §14.2 scoring/calibration, **only if capacity is explicitly freed** by restricting the architecture survey. Merely adding these references to the syllabus is insufficient.
- **Accept a real sacrifice:** multi-family links, Poisson count prediction as a dedicated scientific example, full model-based regularization/variable selection, and the scikit-learn GLM notebook are not retained automatically.

## Comparative educational value and the decision

**A — keep GLM slot, distribute optimization:** strong systematic probabilistic modeling and an especially good GLM→NN bridge; naturally motivated advanced optimization topics, but L04 must either be trimmed aggressively or underserve information/coding. Most of Chapter 6 beyond the foundation remains *equally* unallocated in B, so that is not a reason to prefer B.

**B — separate information and optimization, distribute GLM:** much stronger operational information-theory and an independent coding notebook; cleaner basic AD/SGD progression into EM and subsequent methods; loses the statistical unity and independent GLM modeling skill, while putting extra burden on L11.

**Assessment revision:** The earlier simple 23/30 versus 26/30 totals over-credit B's "downstream foundations" and do not count redistribution pressure on L11 or A's ability to place advanced optimization *where used*. They should **not be treated as decisive scores**. The tradeoff is closer, and the real deciding constraint is whether operational coding deserves **its own student notebook**. If yes, B likely wins for reasons of **information theory**, not optimization. If a technically meaningful in-lecture coding demonstration is enough and Iris retains the lab, **A with distributed optimization may provide better total-course coherence and coverage**, assuming L04 is carefully narrowed. None of this requires a detailed Section Design before choosing.

**Feasibility verdicts:**
- **A unchanged:** feasible with risks as written, **but misses the new substantive MI/coding goal**.
- **A revised:** feasible-with-risks, with L04 a major scope bottleneck; L08/L11 need carefully selected derivations.
- **B:** feasible-with-risks, with L05 first-PyTorch/autodiff crowding, L11 GLM-pressure and VAE scope requiring checks.

**Recommended next instructor decision:** determine the depth of *operational coding* required (lecture mathematical worked example versus full independent notebook). Then scope only L04 under A and L04/L05 under B to test whether that obligation can be fulfilled without crowding out their core computational skill. Do not change L10 or mark advanced Ch. 6 material covered on the strength of a proposed title.
