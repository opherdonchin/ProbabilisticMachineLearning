# Independent technical review of the city observation map

**Verdict: feasible-with-risks.** No blocking mathematical, implementation or
accepted-zero-rule defect was found in the checked route. It is technically
usable as a supplied continuous observation proxy for the required
reconstruction / prior decoder-mean / full-generation comparison and critique.
It is not evidence of credible synthetic metropolitan areas, and this review
does not select the final observation model or approve the whole Scope.

Review mode: bounded worked-solution validation / Lecture Scope feasibility
review, 2026-10-15. Reviewer `/root/l12_transform_review`, isolated branch
`review/l12-transform-20261015`, launch base
`934fb5fdd805fb5f5bc60c016fc0ebb1284c0031`. The probe, assessment and results are
exactly revision `3e27b860f6304f979a2ac6b2ff4ccc9f5d9f5215`; unchanged source
records originate at `0c621d3`. Accepted limited Scope changes are checked at
`582ff0e43123a033eff3dc4cb6abdd6e8bd1bbc6`. The accepted zero rule at `c0a2a4f`
and generation/critique encounter at `582ff0e` are inputs, not reopened choices.

The review followed `AGENTS.md`, the exact envelope in
[city_transform_direction.md](city_transform_direction.md),
[worked-solution-authoring](../../../.agents/skills/worked-solution-authoring/SKILL.md),
[lecture-scope](../../../.agents/skills/lecture-scope/SKILL.md) review mode, and
the shared backpressure contract. Only this report was changed. Neither the
other reviewer’s workload artifact nor any shared source was edited. No new
instructor decision is needed for a correctness repair.

## Mathematical and source findings

**The 19-dimensional map has the claimed domain and inverse.** For network
densities, `t_n=log n`, `t_i=log(i/(n−i))` invert to
`n=exp t_n`, `i=n sigmoid(t_i)`. OSMnx defines an intersection as a node with
sufficient incident streets; the two densities use the same area denominator,
so `i≤n` is a justified necessary condition for these columns. The pinned source
uses `intersection_count`, not a differently constructed clean-intersection
measure. Its street-density conversion divides metres per km² by 1000.
I reconstructed all 349 selected network-density values from the raw source.
See [OSMnx statistics definitions](https://osmnx.readthedocs.io/en/stable/user-reference.html#osmnx.stats.intersection_count)
and the exact pinned aggregation record in [source_records.json](../notebook_geometry/source_records.json).

For employment, the actual selected S2301 row is **population 16 years and
over**, not all-age population. With civilian employed E, civilian unemployed Q
and that population P, `e=E/P`, `u=Q/(E+Q)`, hence

$$
\frac{e}{1-u}=\frac{E+Q}{P}\le1.
$$

Thus `t_u=logit(u)`, `t_e=log(e/(1−u−e))` is justified on the strict interior.
Employment and unemployment are not complementary shares. The civilian
labor-force fraction above need not equal total participation, which can include
armed forces. The source’s two percentages are divided by 100 before their
misleading final `(%)` names are attached. I matched the two final columns to
the raw S2301 row for all 349 cities. The source rounding caveat remains:
this is a population-consistency model, not an exact identity guaranteed for
arbitrary independently rounded estimates. The definitions are in the
[2020 ACS Subject Definitions](https://www2.census.gov/programs-surveys/acs/tech_docs/subject_definitions/2020_ACSSubjectDefinitions.pdf),
*Employment Status*, printed pp. 67–68; read the civilian-employed,
unemployment-rate and total-participation definitions together.

The five commuting percentages use one worker denominator. Their residual is
specifically **taxicab, motorcycle or other means**. Six parts yield five
unconstrained additive log-ratio coordinates, `t_j=log(c_j/c_6)`; softmax inversion produces
the complete positive simplex. I independently reconstructed all five selected
percentages from ACS B08006 count rows and verified that the six category counts
sum to the raw total workers. The selected built-up coordinate is a percentage:
source code divides the four developed-class areas by its selected land-cover
area sum and multiplies by 100. Its intermediate “openland” name is erroneous.

The other audited units and transformations are consistent with the pinned
records: circuity is a path/endpoint-distance ratio; degree days use Fahrenheit;
annual temperature is Fahrenheit; precipitation is inches. The absolute-zero
shift is valid, and the log transforms deliberately require strictly positive
values or excess above a lower bound. These are continuous interior proxies,
not models of every boundary or measurement process. The
[NIST temperature reference](https://www.nist.gov/si-redefinition/kelvin-introduction)
confirms −459.67°F, while the pinned climate headers establish January–December
2020. GDP remains a positive **source GDP indicator in CSV units**: its missing
`Table.csv`, unknown year/price basis/multiplier and possible all-industry plus
government double counting remain unresolved. The assessment correctly avoids
claiming verified dollar GDP. No GDP repair was inferred from an unrelated file.

**The accepted zero policy is implemented without held-out derivation.** The
training-only minimum is row 84, Decatur, bicycle fraction
`0.000187758167480285`; half is exactly the accepted
`delta=0.0000938790837401425`. Only rows 11 and 94 are adjusted, respectively
training and validation; no test row is a bicycle zero. All other commuting
parts, including residual, are multiplied by `1−delta`. The independently
written percentage-unit replacement agrees within `1.43e−14` percentage point
(the arithmetic order differs). Positive-part ratios and closure are preserved.
No row is dropped and noncommuting data remain unchanged. The function deriving
delta takes only training observations; the explicit held-out perturbation test
and its call sites agree with that provenance.

This replacement is **not** part of a bijection on the original zero-containing
observations. `S⁻¹(S(adjusted x))` returns the adjusted interior composition;
there is no change-of-variables density or positive point mass for the original
recorded zero supplied by this preprocessing. Source estimates are 0±29 and
0±26, not established structural zeros. The
[Census zero-estimate explanation](https://www.census.gov/help/topics/faq.in-the-estimate-column-for-my-acs-table-value-of-0.html)
supports uncertainty about rare characteristics; it does not identify delta as
true prevalence or provide this replacement rule.

**The standardized Jacobian and reference scores are correct.** For
`S(x)=(T(x)−a)/s`, the network block determinant is `1/[i(n−i)]`, the employment
block is `1/[e u(1−u−e)]`, and the five percentage-coordinate ALR block is
`100⁻⁵/∏_{h=1}⁶c_h`. Multiplying the scalar derivatives and `∏s_j⁻¹` yields
exactly the assessment’s formula and implemented `Geometry.logjac`. Both center
and scale are fitted on 245 training cases only. My separately expressed map
and central finite-difference determinants at four rows, including both
adjusted cases, agree within `5.81e−9` in log determinant. This checks the whole
19×19 map, not only its ALR block. The
[Stan change-of-variables discussion](https://mc-stan.org/docs/stan-users-guide/reparameterization.html)
is a suitable focused reference; its current simplex implementation need not
be this particular ALR map.

For a fixed map,

$$
\log p_X(x\mid z)=\log p_U(S(x)\mid z)+J(x),\quad
D_X=D_U-\overline J,\quad -\mathrm{ELBO}_X=D_X+R.
$$

The data-only J has no encoder/decoder parameter gradient. Its inclusion is
necessary when comparing maps. The baseline’s raw-density extension has
`x>−1` on its log1p coordinates and unconstrained remaining scalar coordinates;
it need not share the transformed model’s physical support to have a density
against the same 19-coordinate Lebesgue measure. On the unchanged interior
test set its inverse/Jacobian bookkeeping is valid. The clipped source
preprocessor itself is not a global bijection; the assessment explicitly
separates that fact. Mean test J is −45.881362920596686 for baseline and
−39.369603675771614 for the accepted map. Every saved raw-score calculation
recomputes exactly from D, R and J. Standardized D values across maps are not
a common reconstruction metric. Raw negative ELBOs are comparable upper bounds
on respective marginal NLLs, **not a proved ordering of the actual marginal
NLLs**: variational gaps can differ.

**Training, sampling and query labels are consistent.** The model is
`Z~N(0,I4)`, `U|Z~N(d_theta(Z),.5 I19)`, `X=S⁻¹(U)` with diagonal Normal encoder
q. Event-summed NLL has squared-error coefficient one and constant `9.5 log pi`;
KL uses encoder log variance. Independent distribution references and a
fixed-noise pathwise gradcheck pass. The model/loss definitions are imported
from the unchanged baseline source. β=1 trains the standard negative ELBO;
β=4 trains the stated penalized objective, and `D_X+R` remains a variational
bound when evaluated at that fitted model. No exact MLE, population MI,
convergence, optimal rate frontier or posterior-accuracy guarantee follows.
Validation selects checkpoints by `D+βR`, using the same split/settings.

The quantities must retain their existing labels. `S⁻¹(d(mu(x)))` is a
backtransformed decoder mean at an encoder mean code. Averaging observation
noise at that fixed code estimates `E[X|z=mu(x)]`. Drawing both q latent noise
and decoder noise gives an **encoder-based reconstruction distribution**, not
the exact model posterior predictive. Prior generation instead draws Z from
the prior and adds observation noise **before** inversion. The code implements
all these distinctions. Because S⁻¹ is nonlinear, backtransforming its argument’s
mean generally does not produce an original-unit mean.

## Risks, owners and smallest treatments

No unresolved issue blocks continuation of the bounded supplied-map route.
These are material limits already exposed by the author evidence, not new
requests for epsilon/model selection.

| Owner / severity | Evidence and smallest treatment | Consequence |
|---|---|---|
| Worked-solution author / advisory | GDP provenance is unresolved. Keep “source GDP indicator in CSV units” in every future label; resolve the missing source only if verified GDP interpretation becomes necessary. | No new fit or transform choice is needed for this descriptive exercise. Verified dollar-economic claims remain unavailable. |
| Notebook author / downstream-owned | Support success coexists with extreme generated climate residuals. Retain the supplied climate diagnostic and explicit realism caveat. Do not describe supported observations as validated synthetic cities. | The accepted generation/critique task is valuable precisely because it reveals this failure. A credible-synthetic-city endpoint would need a separate model investigation. |
| Notebook author / downstream-owned | δ/2→δ→2δ changes seed-17 β1 q-plus-noise bicycle means .0843→.0979→.1143% (Anniston) and .1532→.1703→.2002% (East Stroudsburg). Keep that limitation visible alongside aggregate D/R stability. | No further delta choice is needed. The reconstruction does not recover rare-share survey truth. |
| Notebook author / downstream-owned | Bound values, mean-code reconstructions, fixed-code conditional means and q-based reconstruction means answer different queries. Preserve the current explicit labels; compare raw-unit metrics only under one named metric/reference measure. | No new student likelihood/Jacobian implementation is implied. |
| Worked-solution/notebook author / downstream-owned | Analytic support is an exact-real interior statement. Floating-point extremes, future boundary rows and a survey measurement process are outside its blanket guarantee. Preserve the existing finite-output checks and declared domain. | Do not silently clip later data or claim a structural-zero model. Current checked rows/draws are finite and supported. |

The climate diagnostic is mathematically appropriate as a **diagnostic**. For
aligned daily means, `CDD−HDD=Σ(T_day−65)`, and 2020 has 366 days. The pinned
county aggregation/rounding can disturb exact equality; use its observed
real-data residual as context rather than enforcing a universal algebraic
identity. [NOAA’s degree-day definitions](https://www.cpc.ncep.noaa.gov/pacdir/DDdir/)
support this calculation. My selective full-generation replay gives residual
5/50/95 percentiles −6720.39/113.44/5311.28 degree-days, versus
12.99/48.25/72.52 for real test cases. No change to the required student-visible
diagnostic or distribution labels is needed.

## Independence, replay evidence and limits

This was a separate reviewer from the builder, using the author’s committed
artifacts as inputs. I independently reconstructed source columns and transform
algebra, wrote a separate forward map and finite-difference check, used new
random coordinates for inverse/support checks, and checked loss/KL/gradients
against PyTorch distribution references. I selectively replayed **one** nominal
fit (accepted delta, seed 17, β1); the training implementation remains the
reviewed author implementation, not an independently implemented optimizer.
Its selected epoch, all test/query summaries, both affected-row diagnostics and
both prior-generation summaries match the committed results exactly. I inspected
all saved sensitivity records and score arithmetic, but did not independently
repeat the remaining fifteen fits or conduct a variant search.

All execution used the existing read-only
`/tmp/pml-l04-l12-reconciliation/.venv/bin/python` (Python 3.12.13,
NumPy 2.0.2, Torch 2.14.0+cpu); scripts/download caches/results stayed under
`/tmp`. All 16 cached primary-source files match their recorded SHA-256 values.
The exact source commit is `049cb033a9814c0ec3df99ece5144d07688aa648`; public
model CSV SHA-256 is
`05e02113771a0ab550a9e7a0098d099ee348820564b68bcdc6c71a28b24418d6`.
The technical results’ input hashes refer to their `c0a2a4f` execution inputs;
subsequent direction/Scope wording changes are not silently represented as new
runs. The current checked artifact hashes are preserved below.

This is local teacher-only evidence. It is not a clean final notebook uv run,
a hosted Colab 2026.07 check, a portable data/permission package, a learner pilot,
validated live-time estimate, full Section Design or instructor approval.
Those existing downstream gates remain. The separate receiving-workload
review owns the one-hour allocation, not this technical audit.

### Exact compact review evidence

The three scratch checks ran with the locked interpreter:

```text
/tmp/l12_transform_independent_review.py
/tmp/l12_transform_source_check.py
/tmp/l12_transform_selective_fit.py
```

The independent geometry check loads only the probe prefix preceding `geos=[`
(no author checks, training driver or output writes), and defines a new map
using `log(x_j)` on indices 0,2,9,12,14,15,17,18; `log(x_3−1)`;
`log(x_16+459.67)`; the two triangular blocks above; `logit(x_13/100)`;
and `log(x_commute/(100−sum(x_commute)))`. It applies the saved training center
and scale, checks all rows, differentiates at rows 0/11/94/348 with centered
steps `1e−6*max(abs(x_j),1e−3)`, and checks 10,000 new standardized draws from
`default_rng(20261015).normal(0,1.5,(10000,19))`. This recipe plus the input
hashes fixes its deterministic numerical target. A preliminary bit-equality
assertion for two algebraically equivalent replacement orders was relaxed to
`3e−14` percentage point after observing ordinary roundoff; no author defect
was inferred and no input changed.

The raw compact outputs below preserve exact review numbers rather than only a
verdict. Script/output hashes identify the temporary execution records; their
contents are not additional course source files.

```json
{
  "independent_checks": {
    "python": "3.12.13",
    "numpy": "2.0.2",
    "torch": "2.14.0+cpu",
    "independent_zero_adjustment_max_abs_error": 1.4210854715202004e-14,
    "delta": 9.38790837401425e-05,
    "training_minimum_row": [
      84
    ],
    "zero_split": {
      "train": [
        11
      ],
      "validation": [
        94
      ],
      "test": []
    },
    "independent_forward_max_abs_error": 1.4210854715202004e-13,
    "four_row_finite_difference_logjac_abs_errors": [
      5.8075571018889605e-09,
      5.623427057344088e-09,
      1.968693652543152e-09,
      2.8817979114137415e-09
    ],
    "independent_generated_support_n": 10000,
    "new_draws_roundtrip_max_abs_error": 1.1795009413617663e-12,
    "event_nll_reference_max_error": 8.526512829121202e-14,
    "KL_reference_max_error": 4.440892098500626e-16,
    "fixed_noise_pathwise_gradcheck": true,
    "saved_raw_score_arithmetic_max_error": 0.0,
    "all_cached_source_record_hashes_match": true,
    "source_records_checked": 16,
    "baseline_saved_D_R_max_difference": 0.0,
    "sensitivity": [
      {
        "delta_factor": 1.0,
        "beta": 1,
        "epoch": 140,
        "q_noise_means": [
          0.09791745347561032,
          0.17027502472300393
        ]
      },
      {
        "delta_factor": 1.0,
        "beta": 4,
        "epoch": 80,
        "q_noise_means": [
          0.2847150174627271,
          0.3313341002089395
        ]
      },
      {
        "delta_factor": 0.5,
        "beta": 1,
        "epoch": 140,
        "q_noise_means": [
          0.08431808086262427,
          0.15320697893759688
        ]
      },
      {
        "delta_factor": 0.5,
        "beta": 4,
        "epoch": 80,
        "q_noise_means": [
          0.2831158424362177,
          0.32746011034474787
        ]
      },
      {
        "delta_factor": 2.0,
        "beta": 1,
        "epoch": 140,
        "q_noise_means": [
          0.11428850008636887,
          0.20023402682063096
        ]
      },
      {
        "delta_factor": 2.0,
        "beta": 4,
        "epoch": 80,
        "q_noise_means": [
          0.28734984824852305,
          0.33729500428911346
        ]
      }
    ],
    "mean_test_logjac": [
      -45.881362920596686,
      -39.369603675771614
    ],
    "file_hashes": {
      "Lectures/L12_VAE/notebook_geometry/probe.py": "f9bc650c9b9e6d6b3e857d84f4b9f73552755bc4d9024600c7402f33cdd8ed44",
      "Lectures/L12_VAE/notebook_geometry/assessment.md": "c725fb1d311265c856b5acced014053239f74cde0d8a5206a5a6a49a90b17c41",
      "Lectures/L12_VAE/notebook_geometry/results.json": "820fe312680c11b0fb3e29d5c4fc01b71aff323d3db7928464c0965a20dc2dda",
      "Lectures/L12_VAE/notebook_geometry/source_audit.py": "ea8428e19be063d3be25f0f5e162c8841272b5754f9395f0cda301c605991db0",
      "Lectures/L12_VAE/notebook_geometry/source_records.json": "3acc759b8613f94706fb79dc32b5a47bfc1a40654a0a91f171987f7b440d388b",
      "Lectures/L12_VAE/lecture_scope.md": "ab756f67662141db3fc7dd47545d83981d7d7dfd504712076f2c70000b859dd9"
    }
  },
  "source_reconstruction": {
    "rows_checked": 349,
    "source_column_max_absolute_errors": {
      "node_density": 1.7763568394002505e-15,
      "intersection_density": 1.7763568394002505e-15,
      "street_km_per_km2": 8.881784197001252e-16,
      "employment_fraction": 5.551115123125783e-17,
      "unemployment_fraction": 9.71445146547012e-17
    },
    "same_worker_denominator_for_all_six_parts": true,
    "commute_max_percentage_point_error": 2.842170943040401e-14,
    "zeros": [
      {
        "msa": "Anniston-Oxford, AL",
        "estimate": "0",
        "MOE": "\u00b129",
        "workers": "47,349"
      },
      {
        "msa": "East Stroudsburg, PA",
        "estimate": "0",
        "MOE": "\u00b126",
        "workers": "78,593"
      }
    ]
  },
  "selective_fit": {
    "selective_replay": "fixed_transform, accepted delta, seed 17, beta 1",
    "exact_matching_fields": {
      "selected_epoch": true,
      "test": true,
      "reconstruction": true,
      "affected_bicycle_reconstructions": true,
      "prior_decoder_mean_backtransforms": true,
      "prior_full_observations": true
    },
    "selected_epoch": 140,
    "test": {
      "D": 17.5604305267334,
      "D_mc_se": 0.029919801279902458,
      "R": 3.7808406352996826,
      "per_latent_rate": [
        0.7062807083129883,
        0.8113383650779724,
        1.1599847078323364,
        1.1032370328903198
      ],
      "mean_code_D": 15.739222526550293,
      "raw_units_expected_decoder_NLL": 56.93003420250501,
      "raw_units_negative_ELBO": 60.710874837804695
    },
    "training_seconds": 1.1865417640656233,
    "full_generation_support": {
      "n": 2000,
      "nonfinite_fraction": 0.0,
      "positive_or_shifted_bound_failure_fraction": 0.0,
      "individual_fraction_bound_failure_fraction": 0.0,
      "commute_joint_support_failure_fraction": 0.0,
      "circuity_below_one_fraction": 0.0,
      "intersection_density_above_node_density_fraction": 0.0,
      "employment_plus_unemployment_above_one_fraction": 0.0
    },
    "climate_residual": [
      -6720.3883971378245,
      113.44240331362244,
      5311.278677243333
    ]
  }
}
```

| Scratch record | SHA-256 |
|---|---|
| `l12_transform_independent_review.py` | `742c4cecfe21b74df33ef721859c1fc81a9c8e67f2db04d7fcdbdaecaac47d49` |
| `l12_transform_independent_review.json` | `dbbf642ea58f0a852795b6cd9a2972f2f106888ca717d729d0fb56c368878866` |
| `l12_transform_source_check.py` | `d2fb4cfbce039ab9d1895ac3886896a4b6d13143be5b640822aa669353a28169` |
| `l12_transform_source_check.json` | `5140c6d736af647dc3f045a453f3924d4bd6411e09e4d8ac119b97f9b89001bc` |
| `l12_transform_selective_fit.py` | `9b6bc8d11bf6d6a1540d7eb209fcec12e74fbab1867d44341a3412ac101e66a2` |
| `l12_transform_selective_fit.json` | `67a438ec48599758332a8ed54674d2de982ea17eae65008ab8d57cb9e6092242` |
