# Syllabus planning decisions — Advanced Statistics 2027-1

**Development branch:** `curriculum-l04-l06-information-review` — branch proposal; **do not merge without instructor approval**.  
**Status:** Original decisions through 2026-10-08 retained except the *provisional* L04–L10 alternative schedule, corrected 2026-10-11. L03 onward is tentative.  
**Current plan:** [`../syllabus_plan.typ`](../syllabus_plan.typ)  
**Formal syllabus:** [`../advanced_statistics_2027_1_syllabus.typ`](../advanced_statistics_2027_1_syllabus.typ) — **not** an authoritative constraint on this planning exercise.

This note preserves the reasoning behind the **Book-2-first** syllabus plan. The branch proposes **L04 Information → L05 GLMs + optimization (substantive general framework) → L06 EM → L07 Inference → L08 Structured inference → L09 VI → L10 MCMC**. The actual alternative is **retaining the unchanged main-branch sequence: combined information/objectives/optimization L04 → EM L05 → inference through L09 → dedicated GLMs L10**. See the [L04–L10 side-by-side assessment](l04_l10_curriculum_comparison.md). No new lecture scope is approved by the existence of this branch.

## Course-level teaching goals

The instructor wants students to understand ML primarily as:

1. **A task is a joint probability distribution and an integral.** For particular problems, the query may be a marginal, posterior, predictive distribution, expectation or decision.
2. **The shape of the joint distribution and the integral required determine the method.**
3. **Methods balance simplifying structural assumptions, approximating integrals and brute-force (sometimes exact) computation to obtain practical predictive value.**
4. Students should develop a useful repertoire of modern, essential methods, including **classical models and neural-network-based tools**.

A lecture should end with *solid conceptual understanding, substantial enough mathematics for genuine understanding, and a clear practical application*. Do not move large amounts of general framing backward just to foreshadow later lectures. Reuse the L1 conceptual framework throughout. The notebook should culminate in a specific problem students can actually work on.

## Curriculum structure and ordering

**Murphy Book 2 is the curricular spine.** Book 1 is a selective supplement where it contributes prerequisites, richer pedagogy, worked examples, or a better local sequence. The following schedule is a **provisional A route**, not a new instructor decision.

| Meeting | Tentative topic | Primary Murphy Book 2 |
|---|---|---|
| 1 | Probabilistic ML and Gaussian systems — *delivered* | Ch. 2, §2.3 |
| 2 | Exponential families, moment matching and learned Markov chains — *agreed scope* | §§2.4, 2.6 |
| 3 | Graphical models | Ch. 4 |
| 4 | Information theory: dependence, communication and representations | Ch. 5 (selected §§5.1–5.5) |
| 5 | Learning probabilistic models: GLMs and optimization | Ch. 15 §15.1 and §15.3.2 with Ch. 6 §§6.1–6.3.2 |
| 6 | Latent-variable learning and EM | §6.5, selected §28.2 |
| 7 | Inference as computation | Ch. 7 |
| 8 | Exact inference in structured sequence models | Chs. 8–9 |
| 9 | Variational and amortized inference | Ch. 10 |
| 10 | Monte Carlo and MCMC | Chs. 11–12 |
| 11 | Neural networks as probabilistic conditional models | Ch. 16, optional evaluation/penalty bridges to Ch. 14/15 |
| 12 | Variational autoencoders; rate-distortion and representation | Ch. 21 and selected §5.4.2 (IB comparison optional) |
| 13 | Project presentations / synthesis | No committed new material |

**Reasons and constraints behind the proposal:**

- Give **information theory** enough room to be computational and operational (mutual information, coding), not just another name for a loss function. Choose **one** coding endpoint for the L04 notebook. Its exact adaptation/timing is not yet validated.
- Integrate **the fundamental GLM family with optimization in L05**: conditional exponential-family structure and canonical links (§15.1), Gaussian/Bernoulli/Poisson contrasts, derivation of the general GLM likelihood gradient (§15.1.3), multinomial softmax (§15.3.2), then reverse-mode AD and minibatch SGD (§§6.2–6.3.2) as the method for learning this model. PyTorch Iris notebook. Avoid deep GLM priors, Newton/IRLS, black-box gradient estimators and broad optimizer surveys in this already-dense lecture.
- Place **EM after explicit optimization** to show how hidden variables complicate parameter learning. Inference overview and subsequent methods shift one slot to L07–L10.
- Remove the **standalone GLM lecture**, while retaining the *unifying core of its model family* in L05: contrasts among Gaussian, Bernoulli, Poisson and categorical outcomes, link/mean relationships and likelihood-gradient learning. Logistic posterior/Laplace returns in L07; L11 carries a narrow weight-decay/prior analogy and at most one optional calibration diagnostic. Deep sparse-prior taxonomy, complete frequentist/Bayesian GLM inference and the dedicated L1/L2 digit experiment are **not** preserved.
- Preserve **VI before MCMC**, **neural networks in L11** and **VAEs in L12**. Return to mutual information/rate-distortion in L12 as a β-VAE interpretation; keep the supervised classical information bottleneck and InfoVAE as optional *comparisons*, not full additional derivations.
- Book 2 Chapter 6 §§6.3.4–6.4 are candidate resources for VI/VAE; §§6.6–6.9 are not promised. There is still no dedicated SMC or broad predictive overview lecture.
- This proposed route does **not** override the delivered L01 or the agreed L02 scope. The current formal syllabus remains an output to revise after the instructor decides, not a constraint on the decision.

**Actual open alternative (A, baseline):** Keep the **main** syllabus unchanged, including its *combined* information/optimization L04, EM L05, general inference L06, structured inference L07, VI L08, MCMC L09 and dedicated GLM L10. Under this choice, L04 already includes introductory autodiff/SGD and the Iris PyTorch notebook, but not substantive MI/coding; fitting the instructor's stronger information-theory goal requires deliberate compression/displacement. **Branch alternative (B):** dedicated L04 information + coding and L05 optimization/softmax GLM; EM and each intervening inference lecture shift one slot, removing the old L10 GLM meeting. Compare both **through L10** and audit L11/L12 consequences in the linked assessment.

## Book 1's role: lecture-by-lecture decisions

Only retain material with a distinct contribution beyond the Book 2 treatment. `Core` means strong present justification; `Possible` means keep while deciding the detailed lecture scope; `None` means do not designate Book 1 coverage merely because a topic is also discussed there.

| Lecture | Book 1 status | Specific rationale |
|---|---|---|
| **L1** | Historical delivered provenance, especially §§3.1.1–3.3.4 | Pedagogically useful covariance → MVN conditioning → missing data → linear-Gaussian examples. Earlier introductory and basic-Bayes references are retained as delivery provenance, **not** required future reading. |
| **L2** | **None required** | Book 2 §2.4 is the richer exponential-family treatment; Book 1 §§3.4 and 4.2 are redundant with the agreed scope or prior statistics background. |
| **L3** | **Possible:** §3.6.1 and §3.6.2 | Very compact Representation / Inference / Learning orientation, but Book 2 Ch. 4 remains the full mathematical treatment. Do not claim all of §3.6 as a requirement. |
| **L4** | **Possible:** §§6.1–6.2 | Entropy, cross-entropy and KL scaffolding when Murphy Book 1 is more accessible; Book 2 Ch. 5 remains the mathematical spine. |
| **L5** | **Core:** §7.8; §§8.1–8.2, §§8.4.1–8.4.3; **Possible:** §§10.2–10.3 | Matrix calculus, reverse-mode AD and SGD are paired with Murphy Book 2 §15.1 (Gaussian/Bernoulli/Poisson GLM common form) and §15.3.2 softmax; Book 1 logistic-regression calculations provide optional support rather than a second survey. |
| **L6** | **Core:** §3.5; §§8.7.1–8.7.3 | The GMM latent-variable model and a teachable worked EM example; do not double count Book 2 §28.2. |
| **L7** | **None** | Book 2 Ch. 7 provides the general inference-as-integral overview. |
| **L8** | **None** | Book 2 Chs. 8–9 cover Kalman filtering and HMM/message-passing methods. |
| **L9** | **None** | Book 2 Ch. 10 suffices for VI; defer detailed VAE applications to L12. |
| **L10** | **None** | Book 2 Chs. 11–12 provide Monte Carlo/MCMC; use prior familiar models only as examples. |
| **L11** | **Core support:** selected §§13.2–13.5; **Possible:** brief §§11.3–11.4 | Book 1 develops neural-network training and regularization more deeply than Book 2 Ch. 16. The displaced GLM material does *not* become a new lecture inside L11: weight-decay/normal-prior analogy and perhaps a brief evaluation diagnostic only. |
| **L12** | **None** | Book 2 Ch. 21 is the substantive VAE source and Ch. 16 §16.3.3 supplies autoencoder context; the short Book 1 §20.3.5 is not needed. |
| **L13** | **None** | Projects / synthesis only for now. |

These judgments are **provisional selections**, not a blanket assignment of every subsection in a cited range. In particular, do not use Book 1 because it happens to repeat Book 2.

## Deferred versus skipped — avoid invisible curriculum debt

**Pay back in a known lecture (proposed):** mixture models and EM (Book 1 §3.5, Book 1 §8.7, Book 2 §6.5) in L6; GLM conditional likelihood / multinomial logistic in L5; a brief penalty/weight-decay bridge in L05/L11 and only optional calibration in L11; matrix calculus/autodiff in L5; optional hierarchical/model-checking material in later inference and prediction lectures.

**Keep selectively available without committing a whole lecture:**

- Book 2 §2.5 transformations (use for reparameterization / flow methods if needed).
- Book 2 §2.7 non-KL divergences / IPMs (use in generative or two-sample methods only when warranted).
- Book 2 Ch. 3 hierarchical priors, empirical Bayes, model checking or Fisher information as examples require.
- Book 2 §§4.3–4.4 detailed MRFs and CRFs (not automatically owed because they are in Ch. 4).
- Book 1 Ch. 7 EVD/SVD if factor models or PCA are later chosen.
- Book 2 §14.2.1 log score and MLE/MAP (§14.1.2) briefly in L05; §14.2.2 calibration remains optional within L11.
- Book 2 Chs. 17–19 remain useful options, not current commitments.

**Tentatively skip as a separate lecture:** Book 2 Ch. 13 SMC. A brief mention within the L7 inference overview is not a commitment to teaching its full method.


## Rapid scope feasibility and approval boundary (2026-10-11)

The instructor asked for provisional syllabus/ledger updates plus initial scope feasibility checks. The branch now includes [rapid scope briefs and initial checks](curriculum_scope_previews.md) for materially revised L04, L05, L11 and L12, plus explicit continuity checks for L06–L10. These are **not approved Lecture Scopes**, not independent multi-agent reviews, and do not bypass the lecture-scope skill's iterative process. A [VS Code Codex review prompt](curriculum_scope_review_codex_prompt.md) specifies the independent follow-up.

**Critical feasibility tradeoff:** L05 is intended to preserve genuine GLM generality *and* foundational AD/SGD. It must teach the §15.1.3 gradient with one canonical-link example and avoid trying to derive Poisson, Bernoulli and multinomial gradients separately at length. L11 is deliberately trimmed rather than used as a catch-all for displaced GLM material. L12 retains rate-distortion but not a full information-bottleneck lecture. Final instructor acceptance and subsequent Section Design checks are still required.

## Immediate L3 scoping work

The next task is **scope design, not Typst slide drafting**. Follow [`.agents/skills/lecture-scope/SKILL.md`](../.agents/skills/lecture-scope/SKILL.md), taking [`material_ledger.md`](material_ledger.md) and the [L2 section design](L02_Exponential_Families/section_design.md) as the actual prior boundary.

For L3, evaluate genuinely different internally complete graphical-model routes, with a concrete notebook endpoint. The currently preferred application is [Ising-image restoration](https://github.com/probml/pyprobml/blob/master/notebooks/book2/04/ising_image_denoise_demo.ipynb). L3 should make a substantive advance from elementary DAGs to *undirected factorization, potentials, partition functions and conditional-independence structure*. The Ising notebook uses simple local probability computations but also Gibbs sampling / mean-field ideas studied formally later; validate how much of the local update can be explained using L3 alone. ALARM CPT learning remains an alternative, not a committed problem. The final lecture boundary and notebook are deliberately provisional. The instructor has explicitly asked **not** to pull general inference framing into L3 as a mere forward reference; teach the chosen graphical-model mathematics to depth, with a practical notebook handoff.

## Latest notebook and toolkit decisions (2026-10-08)

The plan now explicitly includes *mathematical contribution, worked reference, lecture complementarity and durable computational skill* as criteria for each exercise; see [notebook_reference_audit.md](notebook_reference_audit.md). Students already know PyMC and Bambi from the undergraduate course, but their MCMC exercises must go beyond running HMC and diagnostics. In the review proposal, adopt **PyTorch from L5** and reuse it later; **do not teach JAX**. Use SciPy/scikit-learn for numerical reference solutions, not to conceal the new algorithm. Preferred new examples include Ising restoration (L3), three-class Iris softmax in PyTorch (L5), multimodal MH sampling (L10), and heteroskedastic neural prediction (L11); retain the L7 grid/Laplace reference. Keep L6's MRI-versus-incomplete-Gaussian EM choice and L12's mobility-versus-MNIST VAE choice open.
