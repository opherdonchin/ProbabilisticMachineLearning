# Syllabus planning decisions — Advanced Statistics 2027-1

**Development branch:** `syllabus-2027-1-revision` (merged into `main` when approved)  
**Status:** Working decisions as of 2026-10-08. Lectures 3 onward are tentative.  
**Current plan:** [`../syllabus_plan.typ`](../syllabus_plan.typ)  
**Formal syllabus:** [`../advanced_statistics_2027_1_syllabus.typ`](../advanced_statistics_2027_1_syllabus.typ) — **not** an authoritative constraint on this planning exercise.

This note preserves the reasoning behind the current **Book-2-first** syllabus plan. It is a current planning document, not an archive of superseded draft syllabi.

## Course-level teaching goals

The instructor wants students to understand ML primarily as:

1. **A task is a joint probability distribution and an integral.** For particular problems, the query may be a marginal, posterior, predictive distribution, expectation or decision.
2. **The shape of the joint distribution and the integral required determine the method.**
3. **Methods balance simplifying structural assumptions, approximating integrals and brute-force (sometimes exact) computation to obtain practical predictive value.**
4. Students should develop a useful repertoire of modern, essential methods, including **classical models and neural-network-based tools**.

A lecture should end with *solid conceptual understanding, substantial enough mathematics for genuine understanding, and a clear practical application*. Do not move large amounts of general framing backward just to foreshadow later lectures. Reuse the L1 conceptual framework throughout. The notebook should culminate in a specific problem students can actually work on.

## Curriculum structure and ordering

**Murphy Book 2 is the curricular spine.** Murphy Book 1 is a selective supplement where it contributes prerequisites, richer pedagogy, worked examples, or a better local sequence. The current book ordering is intentional but not binding within individual lectures.

| Meeting | Tentative topic | Primary Murphy Book 2 |
|---|---|---|
| 1 | Probabilistic ML and Gaussian systems — *delivered* | Ch. 2, §2.3 |
| 2 | Exponential families, moment matching and learned Markov chains — *agreed scope* | §§2.4, 2.6 |
| 3 | Graphical models | Ch. 4 |
| 4 | Information, objectives and optimization | Chs. 5–6 |
| 5 | Latent-variable learning and EM | §6.5, with mixture-model example |
| 6 | Inference as computation | Ch. 7 |
| 7 | Exact inference in structured sequence models | Chs. 8–9 |
| 8 | Variational and amortized inference | Ch. 10 |
| 9 | Monte Carlo and MCMC | Chs. 11–12 |
| 10 | Classical probabilistic prediction: GLMs and regularization | Ch. 15; selected §14.2 for evaluation |
| 11 | Neural networks as probabilistic conditional models | Ch. 16 |
| 12 | Variational autoencoders | Ch. 21 |
| 13 | Project presentations / synthesis | No committed new material |

**Decisions behind this ordering:**

- The EM / mixture lecture comes *before* the general inference overview: it gives one concrete and mathematically complete latent-variable learning problem, so later general inference concepts can refer back to it.
- VI precedes MC/MCMC, paralleling Book 2 and contrasting optimization-based posterior approximation with sampling-based computation.
- We are not adding a separate lecture for Book 2 Ch. 13 (SMC) or Ch. 14 (prediction overview). Ch. 13 can be a deliberate skip; Ch. 14 evaluation/calibration can be used selectively in L10.
- Keep the VAE lecture as the present last substantive lecture. Do not now allocate extra meetings to Book 2 Chs. 17–19 (Bayesian NNs, Gaussian processes, distribution shift). Reconsider only as course delivery evolves; do not over-specify the end of semester.
- This plan is **not** required to match the previously written formal syllabus; the current syllabus was explicitly removed as even a loose planning constraint.

## Book 1's role: lecture-by-lecture decisions

Only retain material with a distinct contribution beyond the Book 2 treatment. `Core` means strong present justification; `Possible` means keep while deciding the detailed lecture scope; `None` means do not designate Book 1 coverage merely because a topic is also discussed there.

| Lecture | Book 1 status | Specific rationale |
|---|---|---|
| **L1** | Historical delivered provenance, especially §§3.1.1–3.3.4 | Pedagogically useful covariance → MVN conditioning → missing data → linear-Gaussian examples. Earlier introductory and basic-Bayes references are retained as delivery provenance, **not** required future reading. |
| **L2** | **None required** | Book 2 §2.4 is the richer exponential-family treatment; Book 1 §§3.4 and 4.2 are redundant with the agreed scope or prior statistics background. |
| **L3** | **Possible:** §3.6.1 and §3.6.2 | Very compact Representation / Inference / Learning orientation, but Book 2 Ch. 4 remains the full mathematical treatment. Do not claim all of §3.6 as a requirement. |
| **L4** | **Core:** §7.8; §§8.1–8.2, §8.3.1, §§8.4.1–8.4.3. **Possible:** §§6.1.1–6.1.5, §6.2.6 | Book 1 supplies introductory matrix calculus and first-order / Newton / SGD optimization assumed or compressed by Book 2. Its entropy/cross-entropy and forward-v-reverse KL explanations may be pedagogically clearer, but are not necessarily needed. |
| **L5** | **Core:** §3.5; §§8.7.1–8.7.3 | Book 1 provides the concrete GMM latent-variable model and worked EM-for-GMM example that Book 2 §6.5 cites as an application in the prequel. Do not add Book 1 §21.4 as duplicate mixture-model coverage. |
| **L6** | **None** | Book 2 Ch. 7 directly provides the inference-as-integral overview; Book 1 §§4.6.7–4.6.8 and §5.1.6 are not needed for it. |
| **L7** | **None** | Book 2 Chs. 8–9 provide the detailed filtering and message-passing methods; the Book 1 §3.6.2 overview adds little. |
| **L8** | **None** | Book 2 Ch. 10 suffices for VI; save VAE applications for L12 rather than previewing via Book 1 §20.3.5. |
| **L9** | **None** | Book 2 Chs. 11–12 provide general Monte Carlo/MCMC; a familiar Book 1 model may be used as an example without assigning its chapter. |
| **L10** | **Core support:** selected §§10.2–10.3 and §§11.3–11.4. **Possible:** selected §§9.1–9.4 | Book 1 develops logistic-regression MLE/gradient training and the ridge/lasso geometry and MAP interpretation more concretely than Book 2 §15. If generative classifiers earn a place, Book 1 Ch. 9 offers LDA, naive Bayes and generative/discriminative comparison; otherwise drop. Book 1 Ch. 12 GLM repetition does not independently earn a place. |
| **L11** | **Core support:** selected §§13.2–13.5, excluding §13.5.5 unless needed | Book 1 gives a thorough teachable treatment of MLPs, reverse-mode differentiation/backpropagation, training/regularization, where Book 2 Ch. 16 is a rapid architecture survey. |
| **L12** | **None** | Book 2 Ch. 21 is the substantive VAE source and Ch. 16 §16.3.3 supplies autoencoder context; the short Book 1 §20.3.5 is not needed. |
| **L13** | **None** | Projects / synthesis only for now. |

These judgments are **provisional selections**, not a blanket assignment of every subsection in a cited range. In particular, do not use Book 1 because it happens to repeat Book 2.

## Deferred versus skipped — avoid invisible curriculum debt

**Pay back in a known lecture:** mixture models and EM (Book 1 §3.5, Book 1 §8.7, Book 2 §6.5) in L5; predictive regularization in L10–L11; nontrivial matrix calculus in L4; optional hierarchical/model-checking material with VI, MCMC or prediction examples.

**Keep selectively available without committing a whole lecture:**

- Book 2 §2.5 transformations (use for reparameterization / flow methods if needed).
- Book 2 §2.7 non-KL divergences / IPMs (use in generative or two-sample methods only when warranted).
- Book 2 Ch. 3 hierarchical priors, empirical Bayes, model checking or Fisher information as examples require.
- Book 2 §§4.3–4.4 detailed MRFs and CRFs (not automatically owed because they are in Ch. 4).
- Book 1 Ch. 7 EVD/SVD if factor models or PCA are later chosen.
- Book 2 Ch. 14 §14.2 calibration/proper scoring selectively in L10.
- Book 2 Chs. 17–19 remain useful options, not current commitments.

**Tentatively skip as a separate lecture:** Book 2 Ch. 13 SMC. A brief mention within the L6 inference overview is not a commitment to teaching its full method.

## Immediate L3 scoping work

The next task is **scope design, not Typst slide drafting**. Follow [`.agents/skills/lecture-scope/SKILL.md`](../.agents/skills/lecture-scope/SKILL.md), taking [`material_ledger.md`](material_ledger.md) and the [L2 section design](L02_Exponential_Families/section_design.md) as the actual prior boundary.

For L3, evaluate genuinely different internally complete graphical-model routes, with a concrete notebook endpoint. The currently preferred application is [Ising-image restoration](https://github.com/probml/pyprobml/blob/master/notebooks/book2/04/ising_image_denoise_demo.ipynb). L3 should make a substantive advance from elementary DAGs to *undirected factorization, potentials, partition functions and conditional-independence structure*. The Ising notebook uses simple local probability computations but also Gibbs sampling / mean-field ideas studied formally later; validate how much of the local update can be explained using L3 alone. ALARM CPT learning remains an alternative, not a committed problem. The final lecture boundary and notebook are deliberately provisional. The instructor has explicitly asked **not** to pull general inference framing into L3 as a mere forward reference; teach the chosen graphical-model mathematics to depth, with a practical notebook handoff.

## Latest notebook and toolkit decisions (2026-10-08)

The plan now explicitly includes *mathematical contribution, worked reference, lecture complementarity and durable computational skill* as criteria for each exercise; see [notebook_reference_audit.md](notebook_reference_audit.md). Students already know PyMC and Bambi from the undergraduate course, but their MCMC exercises must go beyond running HMC and diagnostics. Adopt **PyTorch from L4** and reuse it later; **do not teach JAX**. Use SciPy/scikit-learn for numerical reference solutions, not to conceal the new algorithm. Preferred new examples include Ising restoration (L3), three-class Iris softmax in PyTorch (L4), multimodal MH sampling (L9), and heteroskedastic neural prediction (L11); retain the L6 grid/Laplace reference. Keep L5's MRI-versus-incomplete-Gaussian EM choice and L12's mobility-versus-MNIST VAE choice open.
