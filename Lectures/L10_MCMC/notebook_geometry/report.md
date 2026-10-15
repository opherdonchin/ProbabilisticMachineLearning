# L10 real-posterior screening: Gaussian VI, finite MH and parameterization

**Verdict: feasible-with-risks; candidates, not a selected notebook.** Eight Schools gives the stronger investigation of posterior geometry and task-dependent method choice. It requires a supplied noncentered parameterization and an explicit Scope decision about that additional explanation. Bioassay is the smaller revision: Gaussian VI already answers mean-prediction questions well, but finite MH improves particular uncertainty/tail queries. Neither case supports a hierarchy in which MCMC simply succeeds after VI fails.

This is Lecture Scope **revision research plus author-only computational feasibility**, on `investigate/l10-geometry-20261015`, input base `e8a0f6cc3601084714271d7c8d916803545e4fac`. The [instructor decision and research envelope](../../course_architecture_scope/reconciliation/notebook_geometry/decision_and_tasks.md) authorize cumulative comparison, optional dataset continuity and at most two real candidates. No owning Scope, map, architecture, environment, shared skill, previous probe, section, slide or student notebook was revised. This is not an independently reviewed final worked solution.

## The cumulative comparison and what remains conditional

L09's investigator reports full-covariance Gaussian reverse-KL VI in standardized regression-coefficient coordinates as a supported **candidate**, with diagonal VI retained as a separate family diagnostic. Both multinomial Iris and the Challenger alternate show a same-family improvement over Laplace. This investigation therefore fits actual full Gaussians, not an arbitrarily weak diagonal proxy. The exact L09 model/family is still unselected; a future non-Gaussian or structured L09 family requires a new L10 fit before calling these results a comparison with “the previous approach.” The prior and parameter dimension may differ across datasets without changing the variational principle.

L07's existing binary Iris evidence remains reusable and its investigator recommends it conditionally as a good-Laplace case. The proposed sequence can therefore be Iris → L09's selected classifier → one of the present cases. Dataset changes cost model orientation time but do not require three unrelated inference implementations. These messages are dependency evidence, not instructor approval; the final selected L09 artifact must replace this provisional communication record.

For each case, the minimized negative ELBO, up to constants independent of its parameters, is

$$J(m,L)=-E_{\epsilon\sim N(0,I)}[\log u(m+L\epsilon)]-\log|L|,\qquad q=N(m,LL^T),\quad L_{jj}>0.$$

Here `u` is the target density in the **stated coordinates**, including transformation Jacobians. Three actual fresh-noise pathwise Adam fits use seeds 101/202/303, 6,000 updates and 128 coefficient draws per update. For diagnosis, Gaussian moment identities plus one-dimensional Gauss–Hermite expectations give a deterministic objective, optimized by BFGS from three shifted starts. Those fits agree to numerical tolerance at small gradient residuals; they are best observed stationary solutions, not certified global optima. Stochastic objective gaps are measured against that observed reference, separating unfinished fitting from persistent family error. No second variational optimizer is proposed as student work.

## Candidate 1: sparse bioassay dose response

The task is to estimate a dose-response curve and uncertainty about toxicity at a measured dose. [Gelman and Vehtari's author case study](https://arviz-devs.github.io/bayesian-workflow/bioassay/bioassay.html) gives four log doses `(-.86,-.30,-.05,.73)`, five animals per dose and deaths `(0,1,3,5)`. We use its **Python-model** independent `Normal(0,5)` priors on intercept and slope; 5 is a standard deviation. The original physical dose coordinates are retained:

$$Y_i\mid\alpha,\beta\sim\operatorname{Binomial}(5,s(\alpha+\beta x_i)),\quad \alpha,\beta\stackrel{ind}{\sim}N(0,25),\quad s(t)=(1+e^{-t})^{-1}.$$

This is a real experiment with only twenty outcomes, not a generated density. Its posterior is proper, smooth and strictly log-concave: negative-log-posterior Hessian is a positive prior precision plus a positive semidefinite binomial term. Multiple modes are not the mechanism. A full Gaussian captures linear dependence, while the finite-data posterior retains asymmetry and tail behavior. The Gaussian is fitted in `(alpha,beta)`, not in a log slope or an LD50 coordinate. The preceding classification likelihood/general coefficient posterior remains familiar.

The primary uncertainty query is `P(s(alpha-.3 beta)>.2 | D)`, at an **observed** low dose; `.2` is a course-chosen reporting threshold, not a validated safety decision. `P(beta>10 | D)` is a second steep-response tail diagnostic, also course-chosen. A mean LD50 is deliberately not used: a ratio with a denominator near zero can have ill-behaved moments, even when its plotted central range appears stable.

| Query | Checked reference | Best observed full Gaussian VI | Four main MH estimates |
|---|---:|---:|---:|
| Predictive toxicity at `x=-.3` | .237217 | .235599 | .233768–.239264 |
| Predictive toxicity at `x=0` | .625912 | .629057 | .623254–.627988 |
| Predictive toxicity at `x=.3` | .877770 | .883816 | .877023–.878491 |
| `P(p(-.3)>.2)` | .558037 | .537233 | .548350–.563450 |
| `P(beta>10)` | .087783 | .047665 | .087600–.096125 |

The stochastic fits preserve the substantive limitation: toxicity-threshold estimates `.53193–.53793`, steep-response tails `.04578–.04990`, and objective gaps `.00032–.00101`. This is not just a deliberately unfinished optimizer. For mean prediction at these doses, VI is already useful; the practical case for more computation depends on requiring uncertainty/tail accuracy finer than a few percentage points. A richer non-Gaussian VI family has not been ruled out.

The main chains use the fitted full Gaussian Cholesky as a **fixed supplied proposal preconditioner**, not as their target: `w'=w+L epsilon`, with the original posterior in the acceptance ratio. Four dispersed starts `(0,1),(2,12),(-2,3),(4,18)` pair with seeds 11/22/33/44. Each makes 50,000 transitions and retains 40,000 after a 10,000 comparison discard. Acceptance is `.565–.570`. Rejected stays remain in every calculation. Tail-indicator ESS is approximately 3,604–3,921 per chain; batch MCSE `.00424–.00457`; all chains cross the `beta>10` region 1,710–1,812 times. Ordinary split R-hat is below `1.0002` for these queries. These finite checks support this run, not a universal mixing guarantee.

The retained bad-proposal comparison uses the **same target** and scale `.08`, with 10,000 transitions/2,000 discard. Acceptance `.959–.966` coexists with poor exploration: `P(beta>10)` ranges `.0071–.2860`, versus `.0878`, and ordinary split R-hat reaches `1.131`. Changing the target was unnecessary to obtain a sampler failure. Its shorter length and smaller step both matter; it is a poor finite budget, not a controlled comparison isolating only one setting.

The reference uses trapezoidal boxes `[-25,25]^2`/`[-32,32]^2`, meshes `1001²`/`1601²`, plus nested adaptive integration on `[-40,40]` for both discontinuous event boundaries. Smooth-query changes are at most `1.56e-6`; the finer outer-strip mass is about `3.21e-12`. Threshold indicators on a rectangular mesh show visible discretization errors, so the report uses the independently integrated event values. These are qualified float64 reference checks, not a certified posterior tail bound. Quadrature is competitive with MCMC at this dimension; this example teaches accuracy/cost judgment, not the necessity of a chain for a two-dimensional integral.

## Candidate 2: Eight Schools and uncertain pooling

The recognizable task is hierarchical estimation of coaching effects from eight noisy study summaries, including the strength of pooling across schools. [RStan's official example](https://mc-stan.org/rstan/articles/rstan.html) supplies estimated effects `(28,8,-3,7,-1,1,18,12)` and **standard errors** `(15,10,16,11,9,11,10,18)`. These are not eight student-level outcomes or raw within-school standard deviations. We use the published proper prior in [Betancourt's case study](https://mc-stan.org/learn-stan/case-studies/divergences_and_bias.html):

$$\mu\sim N(0,25),\quad\tau\sim\operatorname{HalfCauchy}(5),\quad\theta_j\mid\mu,\tau\sim N(\mu,\tau^2),\quad y_j\mid\theta_j\sim N(\theta_j,\sigma_j^2).$$

The ten-dimensional centered coordinates are `z=(mu,ell,theta[1:8])`, `ell=log tau`. Up to fixed constants,

$$\log u_C(z)=-\frac{\mu^2}{50}+\ell-\log(1+e^{2\ell}/25)-8\ell-\frac12\sum_j(\theta_j-\mu)^2e^{-2\ell}-\frac12\sum_j\frac{(y_j-\theta_j)^2}{\sigma_j^2}.$$

The `+ell` is the positive-scale prior's change-of-variables Jacobian. At small `tau`, all group effects must lie close to `mu`; their allowable spread changes with the scale. This changing width, rather than ordinary linear correlation alone, is the family/transition challenge. The noncentered coordinates `z_N=(mu,ell,eta[1:8])` use `theta_j=mu+exp(ell) eta_j`, `eta_j~N(0,1)`. The corresponding density satisfies `log u_N=log u_C+8ell`. The probe checks this equality numerically. A Gaussian in noncentered coordinates maps to a **non-Gaussian** distribution over centered effects: the posterior model is unchanged, the induced variational family and random-walk geometry change.

Two queries have direct pooling interpretations. `P(tau<1 | D)` reports substantial posterior support for group heterogeneity below one score point. The threshold is a transparent course query, not an external scientific decision rule. `E[w_1|D]`, where `w_1=sigma_1²/(sigma_1²+tau²)`, is the expected weight toward the global mean in the conditional school-1 estimate. The first is a scale-region probability; the second averages a bounded smooth function. They need not have similar errors.

| Query | Reference | Centered full Gaussian VI | Noncentered full Gaussian VI | Four noncentered MH estimates |
|---|---:|---:|---:|---:|
| `E log tau` | .802139 | 1.394521 | .849402 | .763684–.826197 |
| `E tau` | 3.597705 | 4.169568 | 3.054596 | 3.493200–3.647620 |
| `P(tau<1)` | .199901 | .0000000325 | .122652 | .182375–.212750 |
| `E w_1` | .924649 | .925249 | .946274 | .923408–.927693 |
| `E theta_1` | 6.211884 | 6.151500 | 5.722326 | 5.931506–6.367575 |
| `P(theta_1>0)` | .904846 | .899265 | .901962 | .892700–.908275 |

These results prevent a misleading ranking. Centered VI catastrophically misses the small-scale region while its **smooth mean-shrinkage query is better than noncentered VI's**. Noncentering improves the scale-region probability but changes the whole variational family and can worsen other queries. Noncentered VI's remaining probability error `.07725` is materially larger than the finite-chain errors in the present runs. Stochastic fits have objective gaps `.00590–.00876` and `P(tau<1)=.11999–.12850`, supporting a persistent limitation of this family rather than merely the selected deterministic solution. Centered stochastic fits similarly miss the region, despite gaps `.00401–.00567`.

The **centered MH failure is part of the result**, not discarded tuning history. Four runs use the same seeds, 50,000 transitions, 10,000 discard and Gaussian proposals `.65 L_VI`; starts use `(mu,tau,eta_j)` values `(0,.1,-.5),(8,1,.5),(-5,10,-.3),(5,20,.3)`, transformed to centered effects. The small-scale start accepts **zero** proposals in 50,000 steps; the other chains accept `.305–.319` but estimate `P(tau<1)` as `.0385,.000375,.000375`. Their errors are not explained by a small stationary MCSE. Region crossings are `0,12,2,2`; split R-hat for the indicator is `4.81`. A finite chain can fail on the same geometry as a Gaussian proxy.

The noncentered comparison keeps the same original starts and prior, transforms the variables, and uses fixed diagonal proposal standard deviations `.65*(3,1,.8,...,.8)`. It uses the **same MH kernel**, not HMC or NUTS. Its acceptance is `.377–.378`; each chain crosses the `tau<1` region 1,532–1,746 times. For that indicator, batch MCSE is `.01047–.01177`, ESS about 1,051–1,319, and split R-hat `1.00077`. For `log tau`, ESS is only 495–784, while the positive-effect indicator has ESS 1,990–2,659. The half-run summaries and batch-length sensitivity remain in the raw JSON. These are reasonable finite estimates for the demonstrated tolerance; a single chain's `theta_1` error still reaches `.2804`, and stricter accuracy would cost more. No general exploration/CLT guarantee is claimed.

This case has a cheap independent reference because Gaussian conditional structure lets us integrate out the eight effects, then the global mean. For `v_j=sigma_j²+tau²`,

$$V_\mu(\tau)=\left(1/25+\sum_jv_j^{-1}\right)^{-1},\qquad M_\mu(\tau)=V_\mu\sum_jy_j/v_j,$$

$$p(\ell\mid y)\propto\frac{e^\ell\sqrt{V_\mu(\tau)}}{1+\tau^2/25}\prod_jv_j^{-1/2}\exp\left[-\frac12\left(\sum_jy_j^2/v_j-M_\mu^2/V_\mu\right)\right].$$

Adaptive one-dimensional integration with wider `ell` domain `[-16,6]` → `[-24,8]` and tighter tolerance stabilizes all listed queries within `4.1e-7`. Independent direct `(mu,ell)` grids `501²`/`1001²` confirm the smooth queries; grid indicators are excluded from an accuracy claim because their boundary staircases converge slowly. For example, the final independent grid gives `E log tau=.802139220`, versus `.802139211` from one-dimensional integration. The plots in the source are **not** used as numerical truth. This exact marginalization is an author reference, supplied in a student lab; it also shows why MCMC is unnecessary for this particular tiny Gaussian hierarchy if one exploits all available structure. Ten-dimensional generic grids would be infeasible, while the structure-specific reference remains cheap.

## Computation, checks and identifiable failure evidence

The executable [probe](geometry_probe.py), [raw results](probe_results.json), [source/input manifest](source_manifest.json), [visual subsamples](trace_subsamples.json) and [screening plot](screening.png) are the deliverables. The manifest contains exact URL snapshot, dataset, textbook-text, source, scope, decision, skill, lock and script SHA256 records, with the full input commit. All numerical data are explicit in the script; no private or synthetic dataset is substituted. Source HTML snapshots are cached outside the repository; their hashes identify the inspected versions. Rerunning against changed web pages can update those source records without changing the fixed data/model.

```bash
PYTHONDONTWRITEBYTECODE=1 MPLCONFIGDIR=/tmp/pml-l10-mpl \
  /tmp/pml-l04-l12-reconciliation/.venv/bin/python \
  Lectures/L10_MCMC/notebook_geometry/geometry_probe.py
```

No dependencies were installed or changed. The existing locked-course NumPy/SciPy/PyTorch environment was reused read-only. Per-fit stochastic VI is roughly 2–3 seconds; each main MH chain roughly .6–.9 seconds, excluding imports. Three-start deterministic author fitting is under .1 seconds per case. The complete screening is roughly 35–40 seconds locally, not learner time. Main retained draws require .64 MB per bioassay chain or 3.2 MB per school chain (decimal units); query arrays add 2.24 MB per chain. Peak **whole-process** resident memory is around .8 GB, dominated by imports, large diagnostic grids and validation arrays, not a requirement of MH. The larger bioassay grid's explicitly counted main arrays occupy 226 MB. Timings and peak memory are machine-specific raw records.

The fixed variational proxy stores `O(d²)` covariance parameters (65 total mean/Cholesky entries at `d=10`); its new draws and repeated queries are independent and cheap after fitting. A fixed MH chain permits many later queries without refitting, but their ESS/MCSE differ. Longer chains increase likelihood evaluations and stored draws; storage can be reduced with online summaries, though that is not this probe's implementation. Neither candidate demonstrates a large-data throughput advantage for MCMC. Report proxy error, integration error and chain error separately instead of comparing seconds without an accuracy requirement.

Validation includes NumPy/Torch log-density agreement below `3e-14`, fixed deterministic-objective finite-difference gradients below `1.4e-8`, the centered/noncentered Jacobian identity below `4e-15`, independent IID expectation checks, and 64→128-point quadrature objective changes at fitted solutions below `4e-12`. The initialized centered expectation has substantial Monte Carlo variance: its independent IID discrepancy `-.153` has IID SE `.124`, while the separate Sobol discrepancy is `-.0170`. That variability is not presented as a quadrature error or an exact optimizer check. Every MH run checks that rejection and repeat fractions agree to their one-transition endpoint difference.

The existing MH driver's diagnostic helper was reused by source hash. Its odd-lag-pair positive-cutoff ACF ESS is a heuristic that forces ESS≤N, not canonical Geyer IPS or ArviZ's rank-normalized multi-chain diagnostics. Ordinary split R-hat was added as a **supplied author check**. Batch lengths 100/500/1,000 expose sensitivity. None establishes stationarity, exploration of all important regions, geometric ergodicity or a CLT. A 10,000-step discard is a comparison setting, not a convergence certificate.

One numerical defect was found without editing the shared helper: an exactly constant trace can have a tiny nonzero computed variance due to floating-point summation, causing a false finite ESS or near-zero MCSE. A local `range==0` guard now marks **all constant queries unassessed**. The raw pre-guard values and exact correction remain in each relevant `constant_query_guard_evidence` record. The zero-acceptance chain is not reported as a precise estimate. Full-chain calculations determine diagnostics; the committed 200-point visual subsamples are explicitly not thinned estimator input.

## Conditional one-hour handoff, not student authoring

The live MH derivation, full Hastings correction, retained rejection, detailed-balance proof, conditional-Gibbs recognition and dependent-error reasoning remain the baseline contract. HMC/NUTS remain recognition-only; none was implemented. Every future section still ends in a retrospective summary. Introducing a real model replaces baseline lab work; it must not append a second complete optimizer or sampler to the hour.

| Lab responsibility | Bioassay estimate | Eight Schools estimate | Student-written / supplied |
|---|---:|---:|---|
| Read task, prior, coordinates and queries | 6 min | 8 min | Supplied model/data; explain target/query |
| Revisit L09 VI and inspect approximation error | 8 | 8 | Supplied full-family fit infrastructure/results; rerun rather than reimplement |
| Complete and check one MH acceptance/stay update | 12 | 12 | Student writes update; supplied density/driver/proposal |
| Compare finite runs and exploration | 12 | 10 | Supplied multiple-chain runs, traces and diagnostics; student reads failure evidence |
| Compute bounded task queries and compare reference/MCSE | 12 | 12 | Student writes indicator/average; reference/MCSE supplied |
| Explain adequacy at stated tolerance, including the bad run | 5 | 5 | Student interpretation |
| Debugging/slippage reserve | 5 | 5 | Estimate only |
| **Total** | **60 min** | **60 min** | **No measured learner-time evidence** |

For Eight Schools, the centered/noncentered transform, Jacobian-correct density and Gaussian-reference derivation are supplied. Deriving a hierarchical model, implementing Cholesky optimization, producing a second sampler, fitting a new diagnostics API and deriving the reference cannot all fit this hour. The model/prior interpretation and why changing coordinates changes a Gaussian family must still be explained. Entry knowledge includes conceptual hierarchy/partial pooling and sampling; noncentered parameterizations are only “previously encountered—scaffold,” and practical API experience does not supply the mathematical explanation. The proposed eight-minute orientation is therefore the main workload risk, not CPU time. A feasibility review may require spending live time or dropping secondary material; this report does not authorize either change.

These exercises evaluate specified posterior queries against a checked reference. They do **not** establish predictive validation on held-out experiments/schools, model adequacy, causal identification, or routine skill with a general probabilistic-programming sampler. If those are required notebook endpoints, the one-hour contract needs a new choice. A diagnostic toy check can remain supplied and bounded, but these real-model failures already make an additional bimodal lab unnecessary; removing/replacing that baseline commitment is a Scope-owned instructor decision.

## Focused reading and source cautions

The textbook is Murphy, *Probabilistic Machine Learning: Advanced Topics*, online edition **December 10, 2025**, verified by the local source text and hashed in the manifest. For Eight Schools, read §3.6.2 **A hierarchical Gaussian model**, especially §3.6.2.1 **Example: the eight schools dataset** and §3.6.2.2 **Non-centered parameterization**, printed pp.111–114: identify noisy study summaries, conditional shrinkage and `theta=mu+tau eta`. Then §12.6.5 **Non-centered parameterizations and Neal's funnel**, pp.532–533, explains why a local move can be obstructed. This adds background beyond the baseline lab, not a new required derivation.

For the method comparison, §10.1.2 **Form of the variational posterior**, pp.440–442, and §10.2.1.2 **Gaussian with full covariance**, pp.448–449, distinguish the family from its optimizer. §§12.2.1–12.2.2 **Basic idea / Why MH works**, pp.500–502, justify the acceptance correction; §12.6.1 **Mixing rates of Markov chains** and §12.6.3 **Effective sample size**, pp.524–531, separate invariant transitions from useful finite averages. The current live theory can remain intact while the notebook changes.

Relevant source cautions must survive later authoring. Murphy's Eight Schools prose calls the summary uncertainty a standard deviation, whereas the dataset entries are standard errors of estimated effects. In §12.6.5, Eqs.12.112/12.115 must be reconciled with the course's variance convention: `x=z exp(nu)` implies conditional variance `exp(2nu)`; variance `exp(nu)` requires `x=z exp(nu/2)`. Use the explicit `theta=mu+tau eta`, `Var(theta|mu,tau)=tau²` convention here. Preserve the already-recorded Gaussian-KL sign/constant and negative-autocorrelation cautions. Betancourt's introductory CLT language should not be read as finite-sample unbiasedness from dispersed starts or geometric ergodicity as universally necessary. Our numerical reference is derived independently rather than imported from its plotted mean. The bioassay webpage's Stan model restricts `beta>0`, whereas its Python models do not; this probe explicitly uses the unconstrained Python variant, so it must not be represented as reproducing all implementations on that page.

## Decisions returned to the coordinator

1. **Priority 1, joint L09/L10 Scope:** confirm the actual L09 family before dependent final authoring. Full-Gaussian continuity is supported conditionally, not approved. If it changes, refit that family on the selected L10 target; no need to repeat this independent real-data screening.
2. **Priority 1, L10 Scope/instructor:** choose between the smaller bioassay lab and the stronger but costlier Eight Schools geometry argument. My conditional recommendation is Eight Schools **if supplied noncentering and its explanation fit**; otherwise bioassay is a defensible smaller revision, with an honest modest predictive-mean limitation. A simple “full Gaussian fails, MH succeeds” claim is unsupported in either case without the query and computational settings.
3. **Priority 2, L10 Scope:** reconcile the chosen real case with the existing deliberate mixture notebook/example commitment and any noncentering treatment. Keep the MH algorithm and current live depths; obtain appropriate feasibility review for changes in coverage/extent. Alternative sampler infrastructure would require a new scope/dependency decision; it is not needed for the evidence here.
4. **Technical gates, author/reviewer:** independent review of densities, Jacobians, reference checks and diagnostics; final worked solution and handoff after selection; pedagogical decomposition; a learner workload trial; local locked-uv and clean hosted Colab checks. The present clean local script is not a Colab publication pass. All delivered/actual-teaching records remain unchanged.
