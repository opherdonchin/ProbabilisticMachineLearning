# L06 source-arc review — EM as optimization with latent variables

**Review type:** source-arc fidelity and educational value, *same-context independent analysis by ChatGPT* (not a separate Codex agent). **Scope status:** assessment only; no scope, syllabus, ledger, notebook or canonical skill edited. **Primary source:** Murphy, *Probabilistic Machine Learning: Advanced Topics*, online edition dated December 10, 2025, inspected directly; subsection names refer to that edition. This is an analysis of the selected material, not a requirement to cover the entire chapter.

## 1. Murphy's source development

**Book 2 §6.5, Bound optimization (MM) algorithms**, follows differentiable/stochastic optimization by asking what can be done when direct optimization is awkward but a tractable lower-bound/surrogate can be improved. The general **minorize-maximize** idea gives an optimization mechanism, and EM is its probabilistic specialization: hidden variables lead to an expected complete-data objective, a tight bound at the current posterior, and an M-step that increases the same bound. The text proceeds through examples such as Gaussian missing-data estimation and mixture models, with extensions, not the other way around.

The intellectual point is broader than “fill in missing values iteratively.” It is **an objective containing an intractable marginalization can be optimized by an auxiliary-distribution argument**, with precise conditions for monotonicity. That connects directly to VI in Ch. 10 and to VAEs in Ch. 21.

## 2. Proposed arc

The [L06 scope](lecture_scope.md) begins with unknown Gaussian parameters and missing observations, contrasted with L01's known-parameter imputation and L05's observed-label likelihood fitting. It constructs the marginal likelihood, derives
`log p_theta(o)=F(q,theta)+KL(q||p_theta(z|o))`,
establishes bound tightness and monotonicity for exact E-step plus improving M-step, then carefully derives expected Gaussian first and **second** moments. It works a complete fitted Gaussian update and briefly shows how mixture responsibilities instantiate the same logic. The student notebook repeats the optimization mechanism on missing-Gaussian data rather than assuming values known.

## 3. Fidelity assessment

**Judgment: faithful selection, with a deliberate application-first motivation.** The core of Murphy's §6.5 is preserved mathematically: the auxiliary distribution, lower-bound construction, tightness and EM objective-improvement argument genuinely structure the lecture. The Gaussian application is not substituted for these ideas; it demonstrates why they matter. The generic MM framework is only lightly recognized, and many extensions/mixture fits are omitted. This is reasonable because the main probabilistic EM mechanism is what later lectures need.

One possible intellectual gap is that the scope moves quickly from posterior tightness to Gaussian moments, which can make students think EM is specifically a Gaussian-missingness method. It already offers the responsibilities contrast, but **that comparison needs to appear as conceptual generalization**, not as an afterthought before the notebook.

## 4. Minimum change

Do not restore a whole mixture-model lab or MRI pipeline by default. Strengthen the verbal transition: *ordinary gradient-based fitting changes parameters directly; EM adds a distribution over latent variables so that the objective is easier to optimize*. After the Gaussian calculation, explicitly point back to the general bound, then show how a mixture's hidden category supplies another q without re-deriving the M-step. Keep the short chain proving when observed-data likelihood cannot decrease, and distinguish it from approximation or hard-imputation variants. The structural argument can survive without extra material.

If time is truly short, cut the **numeric responsibility example** before the EM proof or expected conditional covariance term. The present selected data/problem gives one strong graduate-level derivation.

## 5. Course continuity / omissions

L06 owns the generic bound identity. L09 should recall rather than re-prove it; L12 should apply it to learned latent distributions. The lack of a separate broad MM/IRLS/bound-optimization lecture is a named omission, not automatically owed. The risk to L06 is **first exposure to an unfamiliar auxiliary distribution and matrix second moments inside 112 estimated live minutes**, not loss of Murphy's main arc.

**Disposition:** source arc substantially preserved; retain the scope and request only the explicit generalization bridge. **No source-arc blocker.**
## Instructor observation and revised scope — 2026-10-12

The instructor recommended exposing EM as a new way to **compute with the latent-variable hierarchies** students already understand. The current [L06 scope](lecture_scope.md) now begins with the familiar Bayesian joint model and posterior, then makes the different target explicit: marginal-likelihood **point estimation**, integrating over latent/missing variables at each proposed parameter value. EM uses the conditional latent posterior at *fixed current parameters* in a lower-bound optimization step, not a replacement for Bayesian posterior inference over parameters. The Gaussian-missingness example remains the worked instantiation, and the mixture responsibility comparison restores the method's generality. The inherited 112-minute live envelope is not expanded. This framing remains subject to a targeted independent review before re-approval.
