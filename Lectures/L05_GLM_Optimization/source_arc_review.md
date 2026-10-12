# L05 source-arc review — GLMs and optimization as one coherent departure

**Review type:** source-arc fidelity and educational value, *same-context independent analysis by ChatGPT* (not a separate Codex agent). **Scope status:** assessment only; no scope, syllabus, ledger, notebook or canonical skill edited. **Primary source:** Murphy, *Probabilistic Machine Learning: Advanced Topics*, online edition dated December 10, 2025, inspected directly; subsection names refer to that edition. This is an analysis of the selected material, not a requirement to cover the entire chapter.

## 1. What Murphy is arguing in the two source chapters

**Chapter 6, Optimization** begins with a general objective `argmin L(theta)` and asks what matters computationally when the loss, parameter domain and model are complicated. Its first major answer is automatic differentiation (§6.2), followed by stochastic optimization and expectations (§6.3). It then branches into substantially different optimization settings: natural gradients (§6.4), optimizing surrogate bounds/EM (§6.5), black-box/Bayesian/derivative-free methods (§§6.6–6.7), transport (§6.8) and submodularity (§6.9). This is deliberately a **toolbox chapter**, not a requirement that all tools form one lecture-long derivation. The book itself moves EM to its source chapter because it is a different use of optimization.

**Chapter 15, Generalized linear models** is different: it has one recognizable modeling argument. A *conditional exponential-family* distribution with predictor-linked natural parameter yields a family of scientifically interpretable response models (§15.1). Gaussian, Bernoulli/binomial and Poisson conditional distributions demonstrate the shared structure; likelihood gradients and inference follow. Chapters/sections §15.2 (linear regression and priors), §15.3 (logistic and multinomial regression), §15.4 (probit), §15.5 (hierarchical GLMs) explain families, uncertainty and scientific interpretation. Importantly, Murphy's §15.1 introduction notes GLMs' use in **hypothesis testing / interpretation**, not just predictive classification. A scope that teaches only logistic training would miss this.

## 2. The proposed argument and its deliberate deviation

The [L05 scope](../../L05_GLM_Optimization/lecture_scope.md) has a strong new sequence: L02 exponential-family representation → predictors and canonical links → compare Gaussian/Bernoulli/Poisson responses → derive the shared canonical NLL gradient → extend to vector softmax → show a reverse-mode derivative graph → mini-batch SGD → fit three Iris species in PyTorch.

This is **not Murphy's chapter order**. It brings Ch. 15 forward and uses Ch. 6 as the computational answer to the model-fitting problem. But the departure is principled, not an application opportunistically replacing a theory chapter. The core mathematical link is
`L(w)=-N^{-1} sum_n log p(y_n|x_n,w)` and, for the specified scalar canonical GLM with fixed dispersion, `grad_w L = (N phi)^{-1} sum_n x_n(mu_n-y_n)`.
The multiclass log-softmax derivative then has the vector form `grad_z ell=p-t`; the scope correctly does **not** mistake it for the scalar identity.

## 3. Fidelity, losses and conceptual tension

**Judgment: justified synthesis; relatively strong source-arc fidelity to §15.1 and selective §6.2–6.3.** Students see what the general response-model choice buys before seeing how parameters are trained. This is a recognizable general-to-special argument, not a PyTorch demonstration padded with modeling terminology.

The genuine **departure/cost** is that Murphy's GLM chapter also concerns Bayesian uncertainty, regression priors, variable interpretation and scientific hypothesis testing. Those subjects are largely compressed to brief MAP recognition and redistributed logistic posterior (L07) and weight-decay prior analogy (L11). The revised course thereby teaches the *GLM family for predictive fitting* far more convincingly than it teaches *GLMs for scientific inference*. This is an intellectual choice, not just missing §§15.2–15.5.

Similarly, §6.2's more general AD calculus and §6.3's random-expectation estimators are not all covered; later VI and VAE appropriately own the latter. §§6.4, 6.6–6.9 are named exclusions. No claim to have covered “optimization” wholesale should survive.

## 4. Minimum proposed changes to the arc

Keep the existing sequence and Iris notebook. Make the **central question explicit**: *How does the choice of conditional distribution determine both prediction and the gradient of its learning objective?* Contrast this with “how does one implement SGD?” which is only the second half. Retain three GLM types as a structural comparison, not three separate fit derivations.

Add a **one-sentence loss-and-benefit statement**: the GLM's fixed linear predictor buys interpretable coefficients and comparatively tractable likelihood geometry but limits expressivity; L11 later generalizes the predictor nonlinearly, not the observation-model principle. Where time permits, recognize what model coefficients mean for Gaussian, logistic and Poisson means. This strengthens Murphy's scientific-modeling motivation without adding a separate Bayesian-inference derivation.

The deep scalar gradient, short vector extension and one shared-node reverse-mode example are all essential. If timing fails, trim *repeated examples and optional optimizer/family side roads*, not the general-to-specific bridge or the autograd explanation. Preserve log-likelihood/NLL sign, dispersion and softmax-identifiability cautions.

## 5. Feasibility and dependencies

The scope's **115 live minutes** and first PyTorch notebook are the greatest overload risk among early lectures. This is not an argument to abandon the combined arc; it is an argument for Section Design to rehearse transitions and move notebook boilerplate into supplied scaffolds. L06 should contrast known-response optimization with latent marginal likelihood, while L07 should explicitly show why a single GLM MLE is not Bayesian posterior inference. L11 can use the conditional-distribution connection rather than re-teach GLM family taxonomy.

**Disposition:** approve the *direction of the combined intellectual arc*, but preserve the lost inference/interpretation dimension as a conspicuous course-level tradeoff. **No source-arc blocker; high feasibility pressure.**