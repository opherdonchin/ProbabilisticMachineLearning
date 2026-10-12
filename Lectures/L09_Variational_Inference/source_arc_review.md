# L09 source-arc review — optimize distributions rather than point parameters

**Review mode:** same-context source-arc review; no independent Codex agent and no changes to the lecture scope. **Source:** Murphy Book 2 Chapter 10, *Variational inference*, with Ch. 6 stochastic optimization background.

## 1. Murphy's arc

The first sentence of **§10.1** defines the chapter's move: approximate posterior inference becomes an *optimization problem over distributions*. Start with an intractable posterior and a tractable family Q, minimize directed `KL(q||p)`, drop the evidence normalizer to obtain a computable ELBO (§10.1.1), then ask **which q is expressive enough** (§10.1.2) and **how to optimize q**. Murphy develops both gradient-based VI (§10.2, including black-box methods) and coordinate-ascent updates (§10.3). Further sections expand the allowable posterior family (§10.4), tighten bounds (§10.5), and consider other approximations and inference-learning schemes (§§10.6–10.7). Amortization (§10.1.5) changes the computational economics across observations and anticipates VAEs.

The spine is **posterior integral → choose a simpler distribution → optimize a divergence/bound → inspect family/optimization error → extend representation or inference strategy**. Not every optimizer or family needs to be taught.

## 2. Scope's arc

The [L09 scope](../../L09_Variational_Inference/lecture_scope.md) recalls the L06 ELBO identity, chooses independent Gaussian factors for the posterior over regression coefficients, derives exactly how correlation loss biases different uncertainties, then derives a *pathwise gradient through a random draw* and checks numerical VI against the exact Gaussian and the best diagonal approximation. It briefly applies a coordinate-ascent update and recognizes amortization before L12.

The point that the best `KL(q||p)` diagonal Gaussian matches the target **precision-conditioned** variances, not simply its marginal variances, is excellent: it exposes the effect of model family restrictions with an honest query-dependent comparison.

## 3. Assessment

**Judgment: faithful selective development, with a notable imbalance in the algorithmic alternatives.** The main source arc survives: optimizing distributions, geometric effect of restrictions and a computable stochastic estimator. VI is not reduced to PyTorch optimization. The lecture concentrates §10.1–§10.2 and offers §10.3 at recognition/brief example depth; richer variational posterior families and other inference algorithms are openly excluded. This is a warranted selectivity given the L12 objective.

The specific risk is that a **diagonal Gaussian and pathwise gradient** could come to seem like the *definition* of VI, rather than one computational route among coordinate updates, score-function gradients, richer approximations and per-case amortization. The scope does mention these distinctions, but the general-first argument should be protected in the opening and closure.

Murphy reintroduces the ELBO derivation in Chapter 10. Our course appropriately moves it into L06, which **improves cross-lecture continuity**; this departure should be explicitly credited, not diagnosed as missing fidelity.

## 4. Minimum repair

Keep the two central mathematical developments and the exact-reference notebook. At the beginning make one conceptual comparison: **what is being optimized** in L05 (parameters), L06 (parameters plus an auxiliary latent distribution), and L09 (the *approximation distribution itself*)? Use the same generic variational problem `min_{q in Q} KL(q||posterior)` before specifying Gaussian Q.

After deriving the pathwise method, explicitly name *gradient-based versus coordinate-ascent VI* as two ways of increasing the **same** ELBO, and **parametric choice of q** as a different design dimension. One bounded non-Gaussian/structured q reference at **recognition** depth is justified if it does not displace the existing derivations; a full Ising CAVI or flow example is not.

L12 then provides an authentic change of inference strategy—*amortization across observations*—without having to re-prove L09's pathwise derivative.

## 5. Extent and disposition

The live plan (~112 minutes) is tight; the 31-minute derivative and Gaussian KL geometry cannot both expand. More broad methods must be comparisons within existing time, not added derivations. No synthetic-to-real data change is required by this **arc** review, though the loss of GDP application remains an educational-value question.

**Disposition:** preserve scope, make the general VI problem and alternative update axes prominent in Section Design. **No source-arc blocker, modest explicit arc clarification recommended.**