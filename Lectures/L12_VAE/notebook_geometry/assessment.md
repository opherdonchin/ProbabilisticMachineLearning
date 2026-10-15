# City observations in unconstrained coordinates: bounded feasibility result

**Status:** teacher-only worked-solution revision, 2026-10-15;
**verdict: feasible with risks; accepted zero rule validated**. This implements the
instructor's training-derived half-minimum convention recorded in
[city_transform_direction.md](../reconciliation/city_transform_direction.md),
launch input `c0a2a4f`. The exact response was “This sounds prefect. Let's go with
it.” That accepts the concrete zero rule, not true cycling prevalence, every
other proposed transform, a complete Scope or student publication. The original
exploratory evidence remains in Git at `0c621d3`; current code/results below use
the accepted convention and replace the earlier nominal-policy artifacts.

The implemented route keeps the 19-dimensional observation, four-dimensional
Gaussian latent inference, ELBO/pathwise-gradient structure, network, split,
optimizer and seeds. It provides a coherent continuous proxy for the indicators
and fixes the audited support failures. It does **not** produce physically
validated metropolitan areas. Recommendation: retain the proposed city
**representation and generate-and-critique** route with supplied transforms,
the accepted explicit survey-zero adjustment. Subsequent instructor direction, recorded at `582ff0e`,
requires the reconstruction / prior decoder-mean / full prior-observation
comparison and one model-criticism diagnostic, replacing the optional extra
traversal. Make the remaining climate inconsistency and coarse reconstruction of
rare bicycle shares visible. A genuine survey recording model would require
different likelihood work; accepting this preprocessing convention does not
claim that model has been built. No further instructor answer is needed to
validate the accepted rule.

## Data and zero audit

The unchanged public CSV has 349 rows, 19 selected complete numeric features and
SHA-256 `05e02113771a0ab550a9e7a0098d099ee348820564b68bcdc6c71a28b24418d6`.
[Source records](source_records.json) contain pinned URLs, file/cell hashes, exact
expressions, original zero estimates and their margins of error.
[Audit code](source_audit.py) independently reconstructs the six commuting
percentages from the pinned ACS count estimates, agreeing within `1.43e-14`
percentage points. It confirms that the omitted sixth category is **taxicab,
motorcycle or other means**, rather than treating the five selected shares as a
closed composition.

| Actual CSV coordinates | Units and support used by this probe |
|---|---|
| Node density; intersection density | Counts per km²; `0 < intersection < node` in these observations. Intersections are a subset of nodes, so the non-strict physical relation is `intersection ≤ node`. |
| Street density | km of streets per km²; positive continuous indicator. |
| Circuity average | Dimensionless ratio of network edge length to endpoint straight-line length, at least one; all recorded values are strictly above one (1.01645–1.27571). |
| Car, transit, bicycle, walking, working from home | Percentages, sharing one commuting denominator. Add residual `100 − sum(five)`; all residuals positive, 0.25418–7.28673 percent. Bicycle is exactly zero in two records; all other parts are positive. |
| Median household income | ACS median household income in dollars; positive. This is an estimate, not an individual household outcome. |
| Employment Rate (%); Unemployment Rate (%) | Despite labels, fractions: employment/population and unemployed/labor force, respectively. They do not sum to one. A necessary common-population consistency condition is `e ≤ 1−u`, since `e/(1−u)` is the civilian labor-force share of the population used in e. All recorded rows are strictly inside. |
| Population density | Persons per km², positive. |
| Built-Up Area Proportion | Percentage of the selected land-cover area classified developed, computed using `*100`. Source's intermediate “openland” label is misleading: numerator contains four **developed** classes. It is not a fraction in `[0,1]`. |
| Cooling/heating degree days | Fahrenheit degree-days; nonnegative annual 2020 county measures averaged across counties in each MSA. All recorded values are positive (CDD 33–4746, HDD 169–9411). |
| Average temperature | Annual 2020 Fahrenheit county averages, averaged across counties; may in principle be negative Fahrenheit. Physical lower bound is −459.67°F. Recorded 39.875–77.2667°F. |
| Precipitation | Inches, nonnegative; recorded 2.69–91.23. The pinned aggregation names `Precipitation (inches)` and the final rename preserve this unit. |
| GDP ($) | Positive **source GDP indicator in CSV units**. Exact year/price basis/dollar multiplier is not established. The pinned preprocessing reads missing `data/raw/Table.csv`, selects industry codes 1 and 83, then sums values. Its comment describes all-industry total and government: potential double counting requires source resolution. Do not label raw values as verified dollar GDP or silently repair them. |

[OSMnx's definition](https://osmnx.readthedocs.io/en/stable/user-reference.html#osmnx.stats.circuity_avg)
provides the circuity ratio and node/intersection definitions; the lower bound
follows from path length being at least endpoint distance, subject to consistent
geometric measurement. [NIST](https://www.nist.gov/si-redefinition/kelvin-introduction)
gives the temperature lower bound. The pinned climate CSV metadata explicitly
identifies January–December 2020 and Fahrenheit/degree-day units. NOAA's
[degree-day explanation](https://www.cpc.ncep.noaa.gov/pacdir/DDdir/)
gives the base-65 construction. These support bounds, not a claim that every
heterogeneously aggregated indicator obeys an exact same-day algebraic identity.

The two zeros are **Anniston-Oxford, AL** (row index 11) and **East Stroudsburg,
PA** (94). The pinned ACS B08006 raw table gives bicycle estimates **0 ±29** and
**0 ±26**, with total workers 47,349 and 78,593. The source removes margins of
error before normalizing six count estimates. Thus these are survey-estimate
zeros, not evidence for a structural absence of bicycle commuters.
The [Census zero-estimate FAQ](https://www.census.gov/help/topics/faq.in-the-estimate-column-for-my-acs-table-value-of-0.html)
explains that rare population characteristics may be absent from the survey
sample. It supplies no justified deterministic censoring threshold or latent
positive value for these particular records.

For this **continuous approximation**, derive the replacement from training:

$$
\delta=\frac{1}{2}\min_{i\in\mathrm{train}:\,x_{i,\mathrm{bike}}>0}
       \frac{x_{i,\mathrm{bike}}}{100}
       =0.0000938790837401425.
$$

The minimizing training row is **Decatur, AL**, index 84, bicycle share
`0.0187758167480285%`: minimum fraction `0.000187758167480285`. Thus each
recorded zero becomes `0.00938790837401425%`, or about 0.00939 percentage
point. Freeze this training-derived δ for validation/test; never recompute a
held-out minimum. Multiply **all five other parts**, including the residual,
by `1−δ`. All 349 rows remain; only the two zero rows change. Every originally
positive part ratio is preserved, while the inverse recovers the adjusted
composition rather than the original zero. The exact before/after vectors are
in results. The factor one-half is the accepted convention, not an estimate
of true cycling prevalence or a quantity inferred from ACS margins of error.

The declared sensitivity uses **δ/2 and 2δ**, seed 17, both β values (four
additional fits). These are checks around the accepted convention, not candidate
policies selected by loss. Their replacements are 0.00469395 and 0.01877582
percentage point. No other transform, model, split or architecture is searched.

The fixed existing split places row 11 in training, 94 in validation, neither in
test. Consequently every one of the 52 unchanged test cases has a genuine finite
continuous-coordinate transform and Jacobian. A genuine model for recorded
zeros would need an observation process with boundary probabilities (for
example a survey measurement/count model). Simple smoothing is not that model;
structural zero inflation or arbitrary censoring are not established by this
source. Nonnegative precipitation/degree-day zeros, equality circuity=1 and
other boundary cases also fall outside this strict-interior continuous proxy,
although none occur here.

## One fixed map and its probability model

Write raw observations x, unstandardized coordinates t=T(x), and
`u_j=(t_j−a_j)/s_j`, with a,s fitted on the **245 training rows only**. Let n,i
be node/intersection density; e,u₀ employment/unemployment fractions. Avoid
confusing u₀ with the full standardized vector u. The map is:

- `t_n=log n`, `t_i=log[i/(n−i)]`;
- `t_u₀=log[u₀/(1−u₀)]`, `t_e=log[e/(1−u₀−e)]`;
- `t_b=log[b/(100−b)]` for built-up percentage b;
- `t_c=log(c−1)` for circuity c; `t_F=log(F+459.67)` for temperature F;
- ordinary logs for street density, income, population density, CDD, HDD,
  precipitation and the positive source GDP indicator;
- `t_mj=log(c_j/c₆)` for j=1,…,5, where `c_j=x_mj/100` and
  `c₆=1−Σ_{j=1}⁵c_j`.

There are still **19 coordinates**: the six-part composition contributes five,
not six. No factorization independence is asserted for raw coordinates merely
because the decoder is conditionally diagonal in transformed coordinates.

The inverse gives `n=exp t_n`, `i=n sigmoid(t_i)`,
`u₀=sigmoid(t_u₀)`, `e=(1−u₀)sigmoid(t_e)`,
`b=100 sigmoid(t_b)`, `c=1+exp t_c`, `F=exp t_F−459.67`, ordinary
exponentials for positive variables, and

$$
c_j=\frac{e^{t_{mj}}}{1+\sum_{h=1}^5e^{t_{mh}}},\quad
c_6=\frac1{1+\sum_{h=1}^5e^{t_{mh}}},\quad x_{mj}=100c_j.
$$

These formulas prove a bijection between the specified strict-interior domain
and ℝ¹⁹. In particular, positivity, circuity>1, percentage bounds, the **whole**
commuting simplex, intersection<node and e+u₀<1 hold for every finite real input,
including **full** noisy observation draws. Stable softmax subtracts the maximum;
logistic uses `logaddexp`. Ordinary floating-point extremes can still overflow
exponentials or round fractions to boundaries; sampled probes report finiteness
and actual support rather than claiming numerical validity for all machine inputs.

For the employment bound, the [2020 ACS Subject Definitions](https://www2.census.gov/programs-surveys/acs/tech_docs/subject_definitions/2020_ACSSubjectDefinitions.pdf),
*Employment Status*, printed p. 68, define employed civilians, civilian labor
force and unemployment rate. With employed E, unemployed Q and population P,
`e=E/P`, `u₀=Q/(E+Q)` give `e/(1−u₀)=(E+Q)/P≤1`. This civilian share need
not equal the published total labor-force participation rate including armed
forces. Source values are survey estimates and rounded, so exact identities
can fail at that measurement level; all selected rows pass the stated bound.

The two triangular ratio coordinates prevent an easy hidden failure: independent
noise on separately logged node and intersection densities can make intersections
exceed all nodes. They are necessary consistency constraints, not an invitation
to fit more network features. Employment and unemployment also have different
denominators; treating them as two parts summing to one would be incorrect.

The model is exactly

$$
z\sim N(0,I_4),\quad U\mid z\sim N(d_\theta(z),\tfrac12 I_{19}),\quad
X=T^{-1}(a+s\odot U),
$$

with `q_φ(z|u)=N(μ_φ(u),diag(exp ℓ_φ(u)))`. Full generation draws prior z,
then Gaussian U including decoder noise, then inverts. Inverting only decoder
means omits observation variability. This is a nonlinear transformed Gaussian
observation distribution with a Gaussian conditional in U; no raw-unit additive
Gaussian noise is appended after inversion.

## Jacobian and what is actually scored

Let P be the seven ordinary positive coordinates (street density, income,
population density, CDD, HDD, precipitation, source GDP). For the complete
**standardized** map S(x)=(T(x)−a)/s, the log absolute determinant is

$$
\begin{aligned}
J(x)={}&-\sum_{j\in P}\log x_j-\log(c-1)-\log(F+459.67)\\
&-\log i-\log(n-i)\\
&-\log e-\log u_0-\log(1-u_0-e)\\
&+\log100-\log b-\log(100-b)\\
&-5\log100-\sum_{h=1}^{6}\log c_h-\sum_{j=1}^{19}\log s_j.
\end{aligned}
$$

For the network block, the diagonal derivatives of its triangular map multiply
to `(1/n) n/[i(n−i)]=1/[i(n−i)]`. For the employment block, order u₀ before e:
the product is `1/[u₀(1−u₀)] × (1−u₀)/[e(1−u₀−e)]`.
For additive log ratios, `∂t_j/∂c_h=δ_jh/c_j+1/c₆`;
the matrix determinant lemma gives `1/∏_{h=1}⁶c_h`. Converting five independent
percentage coordinates to fractions adds `100⁻⁵`. The remaining scalar factors
and train-scaler determinant follow directly. This also specifies the measure:
Lebesgue measure on the original 19 independent CSV coordinates, using five
shares rather than six redundant composition coordinates. The official
[Stan transform discussion](https://mc-stan.org/docs/reference-manual/transforms.html#unit-simplex)
gives a related simplex determinant; the calculation here is specifically the
five-coordinate additive-log-ratio map, not a claim to use Stan's current map.

Thus

$$
\log p_X(x\mid z)=\log p_U(S(x)\mid z)+J(x),\qquad
D_X=D_U-E[J(X)],\qquad -\mathrm{ELBO}_X=D_X+R.
$$

For fixed preprocessing J has no θ/φ derivative. Minimizing `D_U+βR` therefore
has the same trainable-parameter minimizers as `D_X+βR` for **that fixed map**.
The Jacobian cannot be omitted when comparing different observation maps/raw
coordinate densities. Train-fitted scales are constants after fitting, not
learned flow parameters. The [change-of-variables reference](https://mc-stan.org/docs/stan-users-guide/reparameterization.html)
explains both density adjustment and why data-only terms may be omitted during
parameter fitting.

A different transform changes the metric imposed by squared error, the implied
raw likelihood and the fitted inference approximation. Its standardized D is
**not** directly comparable to the baseline D. The raw quantities below are
expected conditional reconstruction NLL and negative ELBO, **not** estimates of
the exact marginal NLL. At β4 the training objective is not an ELBO; reporting
`D_X+R` for that fitted model still evaluates a valid variational bound.

## Executed comparison and limitations

[Probe](probe.py), [compact raw results](results.json) and source audit are the
reproducible handoff. Run from this branch root:

```
/tmp/pml-l04-l12-reconciliation/.venv/bin/python Lectures/L12_VAE/notebook_geometry/source_audit.py
/tmp/pml-l04-l12-reconciliation/.venv/bin/python Lectures/L12_VAE/notebook_geometry/probe.py
```

No environment/dependency/lock changes, source data copies, checkpoints, student
notebooks or plots are committed. Scratch downloads stay under `/tmp`. Python,
NumPy/PyTorch versions, exact data/config/split/probe/input hashes, train centers
and scales, every selected epoch, per-latent rates and diagnostics are in results.
Technical execution records the exact `c0a2a4f` run inputs; the generation
encounter decision at `582ff0e` changes the pedagogical handoff, not these
computations. No new fit is required for that decision.
The current run has **16 fits**: six baseline, six accepted-map and four
declared sensitivities. Baseline fits are rerun to verify exact reproduction
and add matching affected-row diagnostic labels; their underlying model and
D/R results are unchanged. The model/loss/config definitions are imported by AST
from the unchanged baseline source without running its output-writing driver. This prevents accidental
baseline implementation drift. Baseline D/R reproduce its six committed fits
**bit for bit**. Both routes use the same original 245/52/52 split; seeds
17/29/43; 19→32/four-latent/32→19 network (1,691 parameters); variance .5;
300 Adam epochs, batch 32, learning rate .003; validation every 20 epochs,
16 noise draws; minimum validation `D+βR`; test 64 draws and same evaluation
noise. Only observation geometry and the explicitly stated two replacements
change. Baseline is the original-data approximation, not refit on smoothed data;
test data are identical and interior for both.

| Model/objective, three seeds | Test D in own standardized coordinates | Test R | Raw CSV-coordinate negative ELBO | Backtransformed mean-code RMSE / training raw SD |
|---|---:|---:|---:|---:|
| Original preprocessing, β1 | 16.164–16.383 | 3.782–3.954 | 65.999–66.123 | .477–.503 |
| Fixed map, accepted δ, β1 | 17.398–17.568 | 3.703–3.798 | 60.566–60.711 | .555–.570 |
| Original preprocessing, β4 | 21.158–21.640 | 1.097–1.171 | 68.210–68.619 | .688–.698 |
| Fixed map, accepted δ, β4 | 22.407–22.791 | .959–1.044 | 62.820–63.120 | .742–.768 |

R and scores are nats/case. Expected D MC standard errors are recorded conditional
on these cases/weights, not sampling uncertainty for a new dataset. Each fit
runs about **1.1–1.3 seconds** on one CPU thread, excluding imports; this does
not measure student completion or hosted Colab. The stronger raw density bound
coexists with worse reconstruction under the stated raw-SD metric; neither is
universal superiority. No held-out criterion was used to choose a new architecture
or to tune δ. Larger β retains a lower-rate/higher-distortion comparison across
these fitted seeds, without establishing an optimal frontier or population MI.

The seed-17 sensitivity preserves the broad β comparison, but not every rare
bicycle reconstruction magnitude:

| Replacement | β1 D / R | β1 raw negative ELBO | β4 D / R | β4 raw negative ELBO |
|---|---:|---:|---:|---:|
| δ/2 | 17.5565 / 3.7807 | 60.7152 | 22.7356 / .9676 | 63.0813 |
| Accepted δ | 17.5604 / 3.7808 | 60.7109 | 22.7911 / .9594 | 63.1201 |
| 2δ | 17.5696 / 3.7879 | 60.7203 | 22.7702 / .9654 | 63.0984 |

The same selected epochs at seed 17 (140 for β1, 80 for β4) result at all three
replacement levels. Neither score nor reconstruction chooses a different rule.
This is finite-fit evidence, not invariance to zero handling or validation of
a survey observation model. The affected-row results below expose sensitivity
that small aggregate loss changes can conceal.

Author checks pass for the accepted rule: training-only derivation and an
explicit held-out perturbation check; rows changed exactly `[11,94]`; all
nonzero-bicycle rows and noncommuting coordinates **exactly unchanged**; six-part
replacement discrepancy `1.61e-16`; closure error zero; preserved positive-part
ratios within `2.43e-14` relative error; finite log ratios for all 349 adjusted
rows; full 19×19 Jacobian agrees with float64 automatic differentiation to the
reported machine precision (zero discrepancy in this run); round-trip relative
error below `4.91e-15` against **adjusted** observations; training mean/SD,
dimensions and finite loss checks. Both sensitivity maps also pass replacement,
closure, ratio, finite-log-ratio and adjusted round-trip checks. The accepted
δ is derived by a function that receives only training observations, and then
passed unchanged to every row's preprocessing. Replacing held-out bicycle values
with arbitrarily tiny positives does not change its value.

The baseline's independently checked analytic KL, event-summed Normal NLL and
pathwise gradients are reused, not rewritten. The map does not change those
latent calculations. The old source's log1p+clipping is not mistaken for a global
bijection; on actual nonnegative inputs its inverse/derivative used for scores
agree with this extended baseline model.

For 2,000 same-seed prior latent and observation-noise draws per fit, all six
accepted-map fits and all four sensitivity fits have **zero nonfinite or
audited support failures**: positivity/shifted bounds, individual fractions, whole commuting
composition, circuity, intersection≤node and e+u₀≤1. That observation complements
the analytic support proof. Old 39–48% scalar failures concerned the old model.
Our stronger combined commuting check also includes negative individual parts
and negative residual: the old baseline fails it in 62.8–66.7%, a different
statistic from its old five-share-sum-only 36–38% failure.

Realism remains materially limited. The fixed-map generated feature correlations
have off-diagonal RMSE .147–.178 relative to training correlations; the 52 real
test cases give .116 by the same diagnostic. A median generated case lies
2.72–2.98 training-raw-SD units from its nearest training case, versus 1.77 for
a median real test case; these distances are descriptive checks, not independent
proofs of invalidity. About 26–42% of generated cases leave the training bounding
box in at least one feature; real test cases do so in 9.6%. Novelty outside an
observed range alone is not a support error.

A particularly informative joint failure is climate. For annual base-65 daily
values, `CDD−HDD = Σ_day(T_day−65)`; with aligned averaging this would be
`366(F−65)` in leap year 2020. Source rounding/aggregation need not preserve exact
equality, so use `CDD−HDD−366(F−65)` as a **diagnostic**, not an imposed identity.
Real training 5/50/95 percentiles are approximately **8/41/72 degree-days**;
real test approximately **13/48/73**. Fixed-map full draws have 5th percentiles
around **−6,800 to −5,900** and 95th around **+5,200 to +5,500**. The discrepancy
is far beyond the empirical source mismatch. Independent decoder noise in the
three transformed climate coordinates does not preserve their near deterministic
relationship. This route solves the selected geometry constraints, not all
cross-variable urban/weather relationships. A final task requiring credible
synthetic cities would require another observation-model investigation; it is
not achieved by these support results.

## Bicycle reconstructions for the two adjusted records

The encoded bicycle input is `0.0093879%` in each zero row. The **Anniston**
record is a training reconstruction; **East Stroudsburg** is a validation
reconstruction, and validation already selects the checkpoint. These are
specific reconstruction diagnostics, not two new independent held-out tests.
Each is encoded **after** its accepted adjustment and train-fitted transform.
The original recorded zero is retained as a comparison label and is never passed
through a logarithm.

The table gives ranges across the three fixed model seeds, in **percentage
points of bicycle share**. It separates three actual computations:

| Row / β | Decoder-mean backtransform at encoder mean code | Mean over decoder noise, fixed encoder mean code | Mean over encoder-q latent draws **and** decoder noise |
|---|---:|---:|---:|
| Anniston, β1 | .0535–.0637 | .0742–.0881 | .0891–.1003 |
| East Stroudsburg, β1 | .1030–.1502 | .1373–.2004 | .1623–.2207 |
| Anniston, β4 | .1793–.1876 | .2465–.2578 | .2658–.2847 |
| East Stroudsburg, β4 | .1982–.2076 | .2638–.2761 | .3099–.3313 |

The two means use 4,096 Monte Carlo draws; q-plus-noise mean standard errors
are about .0014–.0050 percentage point. The last column samples
`Z~qφ(z|S(adjusted x))`, `U~pθ(u|Z)`, then backtransforms. It is an
**encoder-based reconstruction distribution**, not the exact model posterior
predictive distribution or a prior-generated city. The middle column instead
fixes z at the encoder mean and draws only observation noise; the first omits
both sources of randomness. Full quantiles and MC errors are recorded per row,
seed, β and sensitivity in results.

For seed 17, β1 q-plus-noise 5/50/95 percentiles are
`.0163/.0661/.2821%` (Anniston) and `.0290/.1168/.4939%` (East Stroudsburg).
Only 1.07% and .171% of these draws lie at or below the adjusted input. The
continuous model assigns no mass to exactly zero. Reconstruction moves these
rare shares upward, more at β4; replacing a boundary input does not make the
fitted low-dimensional VAE interpolate it or model the survey observation
mechanism. That is a task-relevant reconstruction limitation rather than a
failed preprocessing implementation.

The small declared sensitivity is visible locally: at seed 17, β1, changing
δ/2 → δ → 2δ changes the q-plus-noise reconstruction mean from
`.0843 → .0979 → .1143%` for Anniston and
`.1532 → .1703 → .2002%` for East Stroudsburg. These are all substantially
above the respective adjusted inputs; aggregate D/R stability should not be
reported as accurate rare-share recovery. β4 means vary less over these factors
but are farther above the small inputs. These diagnostics support retaining the
model as a descriptive approximation with explicit limitations; they do not
reopen the accepted factor by selecting whichever reconstruction looks best.

## Queries, supplied work and downstream consequences

`S⁻¹(dθ(μ₍φ₎(S(x))))` is a **backtransformed mean-code reconstruction**, not
`E[X|x]`, not the model posterior predictive mean, and not even generally
`E[X|z=μ]`. For a logged coordinate with lower bound L,

$$
E[X_j\mid z]=L+\exp\{a_j+s_jd_j(z)+\tfrac12s_j^2\tau^2\},
$$

whereas backtransforming the decoder mean omits the last term. Here τ²=.5.
Logistic and composition expectations generally require integration; network
ratios introduce further dependence in raw coordinates. The probe averages
1,024 decoder-noise draws at each **fixed mean code** to demonstrate the
distinction, not to approximate latent-posterior averaging. The two reconstructed
summaries differ by about .204–.212 raw-SD RMS units at β1 in the final route;
results record exact values. Integrating over `q(z|x)` as well answers yet another
approximate reconstruction query. Keep labels tied to the actual distribution
being averaged.

The computational payoff remains amortized Gaussian local inference and cheap
sampling after shared fitting. The inverse adds O(19) scalar operations and a
six-part softmax per case; it adds no neural parameters or iterative per-case
optimization. With only 349 cases this is a compact competence exercise, not
measured evidence that a VAE beats simpler methods or reaches a practical
amortization break-even point. Fitted latent coordinates remain nonidentified;
rate is average encoder-to-prior KL, an MI upper bound with aggregate mismatch,
not a direct information estimate or causal factor discovery.

Supply all data access, exact unit labels/proxy policy, split/scaler, T/T⁻¹,
model skeleton, driver, β4 fit and plotting/diagnostic code. Students should
**apply** the existing reparameterization and **work** the event-summed loss;
run one fit; reconstruct real cases; compare reconstructions, prior decoder-mean
backtransforms and full prior observations; use one climate-consistency diagnostic; compare rate and the
stated task scores with the supplied second β; explain a support success and
a joint-realism failure. Keep the Jacobian proof as instructor checking material
or a stated density-bookkeeping result, rather than silently adding a new
student derivation to the VAE lab. No new Jacobian coding, source archaeology,
PCA fit, MI estimator or zero-model fitting belongs in the one-hour task.

A **60-minute estimate, not a pilot**, is: 5 minutes for supplied data/model and
zero caveat; 15 to complete latent sampling and loss; 8 to run/check one fit;
10 to compare reconstruction / prior decoder-mean / full-generation summaries;
12 to inspect one supplied climate-consistency diagnostic; 8 to interpret the
supplied β comparison; 2 for a retrospective explanation of what the fitted model delivers.
It is conditional on planned L06/L09/L11 encounters and supplied software. The
knowledge record actually covers only course entry/L01, so later fluency is not
established evidence. Scaffold PyTorch event axes, `exp(logvar/2)`, noise shapes,
zeroing gradients and held-out preprocessing. A full student derivation of the
observation map/Jacobian would materially enlarge the workload and needs scope
review; roughly 6–10 minutes for a supplied-map receiving explanation is a
lecture planning estimate, not measured delivery time. The existing 112-minute
live estimate is already tight. The required comparison and one criticism
diagnostic replace the optional extra traversal; they do not add another fit
or a new exercise block to the hour. Geometric support checks and further
author diagnostics remain supplied rather than additional student tasks.

The current deliverable is a validated computational probe and mathematical
handoff, **not a publishable worked/student notebook**. No independent review,
hosted Colab run, student pilot or source packaging check is claimed. Only the
locked local interpreter was used, without writing to its environment.

For the VAE source argument, retain the already verified Murphy, *Probabilistic
Machine Learning: Advanced Topics*, December 10, 2025 online edition, §21.2.1
**Modeling assumptions** (printed p. 792) and §21.2.2 **Model fitting** (printed p. 793):
read for the latent generative joint, approximate encoder and joint ELBO fit,
not for a justification of this course-constructed city transform. The existing
[baseline investigation](../scope_investigation.md) flags Algorithm 21.1’s loss
sign error and Eq. 21.7’s log-variance ambiguity; reuse the checked course loss.

Remaining items have distinct owners:

- **Instructor/Scope:** the half-minimum zero convention is accepted and
  validated. The reconstruction / decoder-mean / full-generation comparison
  plus one model-criticism diagnostic is required, replacing the optional extra
  traversal. Final acceptance of the remaining proposed transforms and complete
  Scope remains separate. A later demand to model recorded survey zeros rather
  than use this proxy would reopen an endpoint/likelihood commitment; no such
  decision is required for the authorized checks reported here.
- **Worked-solution author:** if the proxy is accepted, carry these exact formulas,
  support and score checks into a clean worked solution; resolve or label the GDP
  source indicator and provenance, supply fitted comparison and reproducible plots.
  This technical work need not become an instructor approval question.
- **Section Design and notebook pedagogy:** recheck the receiving explanation,
  required full-draw/realism activity and one-hour workload. Preserve the ELBO,
  joint-gradient and rate-not-MI commitments; the instructor has assigned the
  optional extra traversal's time to the required comparison and one criticism
  diagnostic. Validate that concrete receiving workload before publication.
- **Publication/runtime owner:** clean local notebook execution and fresh hosted
  Colab 2026.07 CPU run, source attribution/packaging and actual student timing.
  No learner readiness follows merely from these fast CPU fits.

No course map, approved historical scope, source data or shared skill was changed.
No technical blocker was found for the accepted convention. Rare-share
reconstruction, climate consistency, unverified GDP units and unmeasured student/
Colab readiness remain advisory limitations with the owners above. The next
owner can continue the Scope/worked-solution handoff without reopening the city
preference or asking the instructor to approve routine numeric checks.
