# Independent technical review: L07/L09/L10 geometry investigations

**Verdict: feasible-with-risks for the bounded technical investigation.** The
checked densities, coordinate transformations, fitted objectives and finite-run
results support the builders' principal numerical conclusions. No blocking
mathematical or implementation defect was found. This is neither selection of
a dataset/family/sampler nor approval of a Scope or a one-hour notebook.
Family continuity and a task-error requirement still need explicit reconciliation
before the sequence can be presented as an approved cumulative application.

Reviewer: `/root/inference_geometry_review`, 2026-10-15, review worktree
`/tmp/pml-inference-geometry-review-20261015`, branch
`review/inference-geometry-20261015`, base
`aa464c84cebc95f1a3de85478148e63fd2f7a173`.

## Evidence boundary and independence

The exact read-only inputs checked were:

| Investigation | Returned revision | Primary checked implementation and evidence |
|---|---|---|
| L07 | `d2404b328239da604a974b173dbc1e58ddede44d` | `Lectures/L07_Inference/notebook_geometry/geometry_probe.py`, results, source records and manifest; imported frozen classifier and existing analytic tail analysis |
| L09 | `f64fb54de202378430da644fd66173507da16907` | `Lectures/L09_Variational_Inference/notebook_geometry/geometry_probe.py`, `audit_probe.py`, both candidate result files, audit results, data/documentation, manifest and execution correction record |
| L10 | `0e5a39375369ff4258881e83d1a933de52fa8b8d` | `Lectures/L10_MCMC/notebook_geometry/geometry_probe.py`, results, source manifest, trace subsamples and imported MH/diagnostic driver |

These live worktree HEADs matched the assigned revisions. I inspected the
targets, objectives, reference algorithms and source records before reading the
builders' reports. I then compared their claims with the implementations and raw
outputs. Both committed screening figures were visually inspected. This is a
separate reviewer context, not a builder's self-check; it remains a selective
technical audit rather than an independent implementation of every computation.

The joint decision/review envelope, repository instructions, worked-solution
authoring skill, Lecture Scope feasibility instructions and shared backpressure
rules governed the review. No candidate search, source/input edits, dependency
changes, merges or student authoring were performed. Only this report is written
in the review repository. The existing locked interpreter
`/tmp/pml-l04-l12-reconciliation/.venv/bin/python` was reused read-only, with
bytecode writing disabled.

## Mathematical checks and their consequences

### L07: regular Gaussian approximation with visible residual error

The binary Iris target is correctly defined in standardized sepal-length
coefficient coordinates, with the training-only transformation, fixed split and
prior $w\sim N(0,4I_2)$. Its negative log unnormalized posterior is

$$
U(w)=\frac{w^Tw}{8}+\sum_i\bigl[\log(1+e^{x_i^Tw})-y_ix_i^Tw\bigr],
\qquad \nabla^2 U(w)=I/4+X^T\operatorname{diag}(p_i(1-p_i))X.
$$

The positive prior precision establishes a unique finite mode, not a Gaussian
posterior. The local inverse Hessian, whitening convention, polar ellipse
Jacobian $\det(L)r\,dr\,d\theta$, and scalar-Gaussian prediction reduction are
consistent. In particular, $x^TW\sim N(x^Tm,x^TCx)$ under the fitted Gaussian;
predictive integration does not require posterior samples.

An independently written tensor Gauss–Legendre calculation on `[-14,14]^2`
(320 nodes per axis) recovered the reported mean and covariance, with prediction
changes below `7.6e-15` and log-normalizer change `5.0e-14`. This is strong
cross-rule numerical agreement, not certification of those digits. The reported
maximum predictive error `.0147764`, modest SD underestimation, slope skewness
`.3341`, and imperfect ellipse coverage support a *qualified* positive regime.
They do not imply uniform predictive accuracy or exact coefficient uncertainty.

The prior-curvature envelope correctly retains the nonzero anchor gradient:
for $B=I/4$, its Gaussian upper-envelope center is $m-B^{-1}g$, not simply
the numerical mode $m$. The existing radius-10 tail-only probability bound
about `.000524` applies to bounded probability queries. The report correctly
does not use it to certify unbounded moments, KL, log loss or mesh error.
Likewise the half-L1 integral on the box is qualified: the Gaussian is not
explicitly box-conditioned. The nonsmooth integral's roughly `1e-6` mesh change
must survive any later rounding or figure caption.

### L09: the same Gaussian family fitted by different criteria

The reference-class multinomial likelihood uses the correct coefficient order
and one proper prior contribution. Independent reconstruction of the categorical
negative log posterior agreed with the implementation at 29 independently
generated coefficient vectors. The fixed reference-class prior is not
class-exchangeable; the report makes that modeling choice explicit.

Challenger uses 23 flight-level Bernoulli observations, with seven positive
responses obtained from the erosion-or-blowby file. It is not a likelihood for
six independent rings or a model of catastrophic failure. The prior is again
in the saved standardized coefficient coordinates. An independent 320-by-320
Gauss–Legendre reference on `[-14,14]^2` gave

$$
(r(31),r(53),r(60),r(70),r(81))
\simeq(.983105,.889514,.731342,.249548,.043867),
$$

agreeing with the committed grid predictions within `7.2e-14`. At 60°F the
reported Laplace `.692094` and full VI `.732994` therefore demonstrate a
same-family fitting difference on the specified posterior query. The comparison
does not depend on forcing VI to have diagonal covariance. It also does not
establish an operational decision reversal, model adequacy or calibrated cold
extrapolation.

For $q=N(m,LL^T)$, the likelihood expectation plus the analytic

$$
\operatorname{KL}(q\|N(0,4I))=
\frac12\left[\frac{\|m\|^2+\|L\|_F^2}{4}-d+d\log4
-2\sum_j\log L_{jj}\right]
$$

has the correct signs and constants. Draws average the likelihood sum; the prior
KL is added once. The implemented mean/Cholesky pathwise gradient includes
entropy and log-diagonal chain-rule terms. New fixed-noise finite differences
at independent noise values agreed within `1.3e-9` for both cases and both
families. Actual fresh-noise PyTorch/Adam execution is present. Replaying
Challenger's full-family seed 20 recovered its saved mean and every objective
checkpoint exactly; the final objective is `13.0507580093`, versus diagnostic
`13.0505286443`. The optimizer gap is distinct from family error.

The exact expected objective is strictly convex in direct `(m,L)` coordinates
with positive diagonal here: convex likelihood expectation, strictly convex
quadratic prior contribution and convex negative log determinant. This does not
make the log-diagonal parameterization convex or turn approximate quadrature
and finite Adam runs into global numerical certificates. The builders retain
BFGS precision-loss messages and independent quadrature checks rather than
equating an optimizer status flag with posterior accuracy.

For multinomial Iris, a new `2^18`-point scrambled importance replication
(seed 887) changed predictions by at most `5.1e-6` from the stored last
replication, with weight ESS about 182,878. The Student-t proposal has
polynomial tails, whereas this posterior is Gaussian-prior dominated. This is
useful support for the numerical reference, not a rigorous error bound or IID
MCSE for QMC points. The builders correctly preserve the negative result:
Laplace's largest probability error is only about 1.29 percentage points and
all 60 class decisions agree. Diagonal VI's substantial density/covariance
error can coexist with its slightly better finite holdout score. Neither
categorical likelihood nor density mismatch alone proves a task failure.

### L10: correct transformed targets and query-specific finite-chain evidence

Bioassay uses the unconstrained Python-model prior

$$
\alpha,\beta\stackrel{ind}{\sim}N(0,25),\qquad
Y_i\sim\operatorname{Binomial}(5,\sigma(\alpha+\beta x_i)).
$$

The target is smooth and strictly log-concave, so multimodality is not its
mechanism. The reported distinction between accurate predictive means and
less accurate uncertainty/tail probabilities is supported. Independently
integrating the two event queries on an extended `[-50,50]^2` domain, splitting
at the exact linear threshold boundary, gave `.558036749749` for
`P(p(-.3)>.2)` and `.087782950226` for `P(beta>10)`. Changes from the stored
adaptive values were below `3.3e-14`. This extends the empirical tail check;
it does not turn finite-domain float64 quadrature into an analytic error bound.
Avoiding an LD50 mean is appropriate because the unconstrained slope's support
includes zero and a ratio can have ill-behaved moments.

For Eight Schools, both coordinate systems preserve the same proper model:

$$
\mu\sim N(0,25),\quad \tau\sim\operatorname{HalfCauchy}(5),\quad
\theta_j\mid\mu,\tau\sim N(\mu,\tau^2),\quad
y_j\mid\theta_j\sim N(\theta_j,\sigma_j^2).
$$

Writing $\ell=\log\tau$, the scale-prior term is

$$
\ell-\log(1+e^{2\ell}/25).
$$

Centered effects additionally contribute

$$
-8\ell-\tfrac12\sum_j(\theta_j-\mu)^2e^{-2\ell}.
$$

The noncentered map $\theta_j=\mu+e^\ell\eta_j$ has effect-coordinate
Jacobian $e^{8\ell}$. Its relation
`log u_N = log u_C + 8 ell` was independently replayed to `3.6e-15`.
The Gaussian exponential-tilting terms in the deterministic objective retain
the relevant correlations with `ell`. Independent IID expectation checks at
the saved fitted solutions agreed with the deterministic objectives within
1.3 estimated standard errors. These checks are numerical corroboration, not
a proof that the three-start optimum is globally best.

I independently collapsed the Gaussian hierarchy using the determinant lemma
and integrated **directly over `tau` in `(0,infinity)`**, splitting at one,
rather than reusing the builder's finite `logtau` integration. The reference
queries were

$$
(E\mu,E\log\tau,E\tau,P(\tau<1),Ew_1,E\theta_1,P(\theta_1>0))
\simeq(4.396821,.802139,3.597705,.199901,.924649,6.211884,.904846).
$$

All changes were below `2.0e-10`. This is particularly helpful evidence for
the long small-scale log tail; it remains adaptive float64 integration rather
than validated interval arithmetic.

The full-family stochastic noncentered fit at seed 202 replayed exactly.
The large small-scale-region errors survive actual stochastic fitting:
centered VI gives probabilities near `3e-8`, while noncentered stochastic VI
gives `.120–.129` against `.199901`. The noncentered Gaussian induces a
non-Gaussian family over centered effects. Its improvement cannot be described
as the same distribution family fitted in different notation. Nor is it
uniformly better: centered VI's smooth expected-shrinkage query is closer to
the reference, as the report explicitly shows.

The supplied random-walk proposals are symmetric, so the implemented log
acceptance uses the correct target-density difference. Rejected states remain
in the averages. One full 50,000-transition/10,000-discard chain at seed 11 was
replayed for each target/coordinate case. Acceptance values matched exactly
and retained query means within `7.4e-13`. The centered chain accepted **zero**
proposals; every retained query was constant. The local constant-query guard
correctly suppresses ESS/MCSE claims even where floating-point variance is
spuriously nonzero.

The remaining raw chain records preserve the serious failures: two centered
chains have just two small-scale-region crossings each, while the bioassay
small-step comparison combines acceptance above `.95` with tail estimates
`.0071–.2860`. Ordinary split R-hat, half-chain means, crossings and batch-size
sensitivity support the reported contrast. The four noncentered chains estimate
`P(tau<1)` as `.1824–.2128`, with conditional batch MCSE about `.0105–.0118`.
Thus these runs improve this query materially relative to the demonstrated
VI fits; they do not prove exploration or a CLT. The retained odd-lag-pair ESS
is explicitly heuristic, not canonical Geyer IPS or rank-normalized multi-chain
ESS. No large-data MCMC advantage follows from these small problems; the cheap
collapsed reference itself demonstrates why structure-specific integration is
competitive.

## Findings, owners and minimum repairs

There are **no blocking technical findings** in this research envelope. The
following qualifications affect the next owning stages.

| Finding | Owner / severity | Evidence and smallest repair |
|---|---|---|
| F1. Cumulative continuity currently means the supplied full family. | Joint L09/L10 Scope; **advisory now, required before final cumulative handoff**. | L09 proposes students implement one diagonal fit and inspect supplied full VI; L10 fits only full VI. The latter genuinely revisits the supplied family/principle, but not the student's own diagonal implementation. State that distinction explicitly, pin the selected L09 artifact revision, and decide whether supplied-family reuse meets the intended endpoint. If the selected family changes, fit that family on the selected L10 target. No new screen is needed merely to document current conditional continuity. |
| F2. A task-error tolerance has not been approved, and L10's wording presupposes one. | Scope/instructor for the requirement; author for wording; **advisory**. | L07's two-percentage-point criterion is explicitly author-proposed. L09 correctly says there is no operational tolerance/loss. L10 calls its runs adequate for a “demonstrated tolerance” and budgets interpretation at a “stated tolerance,” but does not specify one. Replace those assertions provisionally with the measured errors/MCSE, or supply an explicitly author-proposed query/tolerance for later instructor consideration. Do not call the criterion approved. The `.2`, `10` and `tau<1` event thresholds are reporting queries, not accuracy tolerances. |
| F3. Preserve query, coordinate and reference qualifications when condensing the evidence. | Final worked-solution/notebook author; **downstream-owned**. | Raw six-decimal tables, high-acceptance runs and smooth prediction agreement can be misread as universal accuracy. Retain the conditional MCSE and failed chains, label noncentered induced-family change, round student-facing estimates to meaningful precision, and keep numerical refinement separate from analytic guarantees. Existing technical evidence need not be rerun just to retain these qualifications. |

These findings do not select the smaller bioassay revision over the stronger
but more demanding Eight Schools explanation, nor Challenger over multinomial
Iris. Those are consequential teaching choices. This review also does not
approve the proposed replacement of existing scalar/synthetic/mixture labs.

## Source verification and cautions to retain

The [official scikit-learn Iris description](https://scikit-learn.org/stable/datasets/toy_dataset.html#iris-plants-dataset)
confirms the known transcription difference from older UCI data. The installed
scikit-learn arrays and recorded split hashes define the experiments.
The [UCI Challenger record](https://archive.ics.uci.edu/dataset/92/challenger+usa+space+shuttle+o+ring)
confirms the 23-flight provenance, two file variants, relevant columns and
53°F historical minimum. The saved original `.names` description is preferable
to inferring the scientific response from the web table's feature/target labels.

The [RStan example](https://mc-stan.org/rstan/articles/rstan.html) confirms all
Eight Schools data and identifies the uncertainties as standard errors. Its
example hyperprior differs from this probe; the actual proper prior is verified
against [Betancourt's case study](https://mc-stan.org/learn-stan/case-studies/divergences_and_bias.html).
The latter's introductory asymptotic discussion must not be copied as a claim
of finite-start unbiasedness or universal necessity of geometric ergodicity.

The [Gelman–Vehtari bioassay page](https://arviz-devs.github.io/bayesian-workflow/bioassay/bioassay.html)
confirms the dose/count values and unconstrained Python priors. Its Stan/Bambi
positive-slope variants are different models. The builder correctly warns
against claiming to reproduce all implementations on that page.

The available Murphy Book 2 extraction was directly inspected at §3.6.2.1–2,
§10.2.1.1–2, §12.6.5 and §15.3.5, alongside the builders' source records and
the [official edition page](https://probml.github.io/pml-book/book2.html).
The relevant cautions are real: §3.6.2.1 calls the uncertainty a standard
deviation where this dataset requires a standard error; Eqs.10.49–10.50 have
the recorded ELBO sign/KL constant problem; and Eqs.12.112/12.115 need consistent
variance-versus-scale interpretation. The course's explicit `tau^2` variance
and corrected KL formulas avoid those problems. These are focused technical
source checks, not a new full source-arc review. Original PDF authenticity was
not independently re-established.

## Replay records and remaining limits

The scratch implementation and complete successful replay output are:

- `/tmp/inference_geometry_review_replay.py`, SHA256
  `8c54237e7d32c510e214953caf480a2c904e6edd8c6e08eff49aac2341ecd426`.
- `/tmp/inference_geometry_review_replay.json`, SHA256
  `dd19cca4498397f69667197c9cf7cce0e56a5a7a519ce0e5e51859b49961d5fb`.

Reproduce with the stated locked interpreter and `-B`; the script imports the
assigned read-only probes without calling their file-writing `main` functions.
It records 69 matching checks of listed input/artifact hashes and L10 cached
primary-source snapshots, independent quadratures/density/gradient checks, a new
Iris importance replication, selected actual stochastic-fit replays and three
full MH-chain replays. Source retrieval paths remain transient `/tmp` evidence;
the report and input commits retain their exact identity. There was no failed
numerical replay or omitted adverse candidate result in this review.

The independent replay did not regenerate every geometry statistic, every VI
seed or every chain, independently validate all source/input manifests, benchmark
runtime across machines, replace the heuristic diagnostics with a new library,
prove global Gaussian VI optimality for Eight Schools, or certify all tails and
quadrature errors. In particular it did not repeat the poor-step bioassay chains;
their full recorded summaries and algorithm were inspected.

This verdict leaves separate gates intact: instructor model/family/query
selection and Scope reconciliation, appropriate teaching feasibility review,
final worked solution and handoff, solved-Q&A/student derivation, measured
learner-time trial, and clean local plus hosted Colab execution. Fast author
scripts and this technical audit establish none of those gates. No actual
teaching or publication readiness is recorded.
