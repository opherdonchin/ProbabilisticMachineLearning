# AIS source and indexing check

Checked 2026-10-15 by the bounded worked-solution author. This is a source/technical check, not independent review or approval of a live treatment depth.

## Murphy source

Kevin P. Murphy, *Probabilistic Machine Learning: Advanced Topics*, MIT Press 2023, online edition December 10, 2025. Original local PDF `/home/opher/Repositories/ProbabilisticMachineLearning/Resources/book2-1.pdf`, SHA256 `54d6bfa8cc4a367bb553bea1c5127ca63696a9655b2ca1f6137a8584dccfdbaf`. Extracted text `/tmp/pml-book2.txt`, SHA256 `1d77150146caf0f7e44b88b20370292abe5b6bfc506ce92fe26509a7bdb131b6`.

Focused reading: **§11.5.3, “Choosing the proposal,” p.492**, connects VI proposals to importance sampling and distinguishes support coverage from a useful proposal; **§11.5.4, “Annealed importance sampling (AIS),” pp.492–494**, introduces the geometric path, reverse transitions and extended-state importance argument; **§11.5.4.1, “Estimating normalizing constants using AIS,” p.494**, identifies the weight-average estimator. Read these with the corrections below. HMC kernels additionally use §12.5.2.3 and §12.5.3, pp.518–520; the inherited source review at `4cbacf5` owns the momentum/mass and ordinary MH energy-error corrections.

Original PDF pages 527–528 (printed pp.493–494) were rendered with Poppler and visually inspected in full. Scratch renders `/tmp/pml-l10-ais-source-0527.png`, `...-0528.png` are outside the repository. These are printed mathematical/indexing defects, not just text extraction:

1. The transition paragraph requires invariance of `p0`, whereas each intermediate kernel must preserve its **own** `p_j=f_j/Z_j`.
2. The paragraph samples `v_n~p_n`, then uses `T_{n-1}` to obtain `v_{n-1}`; Eq.11.45 evaluates its first `f_{n-1}/f_n` factor at that moved `v_{n-1}`. These instructions do not constitute the usual valid AIS algorithm. In a one-stage instance with an exact independent target refresh, the printed move-first form gives `E_p[f/q]`, not `∫f`. For `q=N(0,1)` and `f(x)=exp(-(x-1)^2/2)`, its expected estimated normalizer divided by the true normalizer is `e`. This course-constructed counterexample directly exposes the order problem.
3. The extended-path products also mix indices: Eq.11.46 jumps from reverse `T_0` to reverse `T_2`; Eq.11.49 similarly finishes with a `T_0` inconsistent with the intermediate sequence, while Eq.11.50 reverses the final conditional direction. Do not copy the path products literally.
4. The sentence following Eq.11.51 reverses the earlier prior/posterior orientation. With the section's original convention, `f_n` is the tractable base and `f_0` the unnormalized target. The mean weight estimates `Z_0/Z_n`; one cannot obtain the reverse ratio by simply calling the same mean weight `Z_n`. In this pilot the base q is normalized and the target f deliberately omits the prior normalizing constant, so the result is `∫f`, not yet marginal likelihood.

## Primary cross-check and adopted convention

Radford M. Neal, *Annealed Importance Sampling*, Technical Report 9805, revised September 1998; the [author's source page](https://glizen.com/radfordneal/ais.abstract.html) identifies that revision and its 2001 *Statistics and Computing* publication. The [revised primary PDF](https://glizen.com/radfordneal/ftp/ais-rev.pdf), downloaded to `/tmp/pml-neal-ais-rev.pdf`, was visually checked at **§2, pp.4–5**, especially Eqs.3–10. It starts `x_{n-1}~p_n`, uses `T_{n-1}` to obtain `x_{n-2}`, and pairs the ratio states with that sequence. Each kernel preserves its corresponding intermediate law. The requirement is invariance, not equilibration of every trajectory at every temperature. The current pilot uses the equivalent forward notation below; no claim is made that Murphy printed it this way.

Set `0=β_0<…<β_T=1`, `f_β=q^(1-β) f^β`, and `π_β=f_β/Z_β`. Draw `X_0~q`, with q normalized. For `t=1,…,T`:

$$
W_t=W_{t-1}\frac{f_{\beta_t}(X_{t-1})}{f_{\beta_{t-1}}(X_{t-1})},\qquad W_0=1.
$$

If `t<T`, draw `X_t~K_{β_t}(X_{t-1},·)`, where `K_{β_t}` preserves `π_{β_t}`. Return the final state `X_{T-1}` and `W_T`; an optional final target-invariant move is omitted. The code thus **weights before moving** and never mistakes an intermediate state for an exact draw from its invariant law.

For an integrable h, weighted propagation gives

$$
E[W_t h(X_t)]=\int f_{\beta_t}(x)h(x)\,dx
$$

after each intermediate move, by induction and invariance; the final weight gives `E[W_T h(X_{T-1})]=∫f h`. Hence `mean(W_T)` is unbiased for Z, and the weighted numerator is unbiased for `Z E_p[h]`. Their self-normalized ratio is generally biased at finite trajectory count. Its consistency requires the ordinary importance-sampling integrability conditions; a finite variance or useful finite budget is an additional question. Independent trajectories do not make endpoints unweighted posterior draws.

The implementation fixes schedule and kernel parameters before sampling. No trajectory-dependent tuning, resampling, assumed stationarity of the evolving AIS states, or claimed equilibration is used. MH includes rejected states. The supplied HMC transition refreshes standard Normal momentum in q-whitened coordinates, uses four leapfrog steps, flips final momentum and applies the Hamiltonian acceptance correction. Leapfrog is a composition of unit-determinant shears; reversal is also checked numerically. Identity mass is a convention in these transformed coordinates, not the inconsistent mass notation in Murphy's surrounding prose.
