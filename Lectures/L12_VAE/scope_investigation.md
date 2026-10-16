# L12 scope investigation: a compact VAE and its generative limits

**Current instructor direction, 2026-10-15:** City data preferred; investigate
unconstrained observation transforms and inverse-map generation before revisiting
the older application choice. [Owning record](reconciliation/city_transform_direction.md).
The half-minimum-positive-training bicycle replacement is now accepted, with
exact rule/provenance in that owning record and the scope notice. Final acceptance
of the other transformed-model choices remains open. Raw-Gaussian results below
retain their exact baseline meaning; they do not show that a transformed city
model must violate the same constraints. L12-APPLICATION now routes to this
bounded investigation; L12-GENERATIVE-ENDPOINT remains a separate later question.

**Stage/mode:** Lecture Scope / feasibility-review with explicitly authorized isolated author probes. **Specialist:** `/root/investigate_l11_l12`, 2026-10-14. **Target:** `lecture_scope.md` at baseline `5e4c86ee3518958157d21d6bcb4c51bcdab3537e`; existing scope remains unchanged. Target scope blob `22fa2d8307ef7cb621456521383b6c352dcd451a`. **Verdict:** feasible with risks for learning and critically evaluating the proposed standardized-space latent model. It is unsuitable as evidence of physically valid generated metropolitan areas. These are different performance requirements, and the latter was never promised by the current scope.

New CPU evidence establishes that the 19-feature/four-latent candidate can be trained and scored within a bounded supplied driver. The β comparison survives correct likelihood/KL normalization and held-out preprocessing. A more consequential empirical result is that full prior-generated observations violate simple raw-variable bounds much more often than decoder means. The notebook can therefore teach use and criticism of a generative model; it must not present only attractive means and call them observation samples.

## Mathematical and practical competence

Students would **apply** L06's ELBO and L09's Gaussian pathwise derivative, **work** the event-summed sampled loss, run one bounded joint encoder/decoder fit, and **derive** the rate identity to interpret the fitted code. The practical task is approximate representation and generation of 349 observations with 19 selected measurements, using a four-dimensional local latent variable. It is not emissions prediction, recovery of causal urban factors, posterior inference over network weights, or physically validated synthetic-city design.

For standardized observations x and local z,

$$
p_\theta(x,z)=N(z;0,I)N(x;d_\theta(z),\tfrac12I),\qquad
q_\phi(z\mid x)=N(\mu_\phi(x),\operatorname{diag}(e^{\ell_\phi(x)})),
$$

$$
z=\mu+e^{\ell/2}\odot\epsilon,\quad\epsilon\sim N(0,I),\qquad
L_\beta=E[D(X,Z)]+\beta E[r(X)],
$$

$$
D(x,z)=\|x-d_\theta(z)\|^2+\tfrac{19}{2}\log\pi,\qquad
r(x)=\tfrac12\sum_{j=1}^{4}(\mu_j^2+e^{\ell_j}-1-\ell_j).
$$

Sum observation coordinates and latent coordinates within each case, then average cases. β=1 minimizes negative ELBO; β≠1 changes the criterion. A decoder evaluated at encoder mean generally does not compute expected distortion. The source's separate feature and latent averages imply `β_course=(19/4)β_source`, so source β4 cannot be renamed course β4. All retained probe comparisons are newly fitted using course units.

The validity regime is a useful descriptive Gaussian approximation to transformed measurements, evaluated on cases reasonably like the training set. The loss and gradients are mathematically coherent despite raw support mismatch; a finite held-out density score does not establish physically valid generation. Amortization saves repeated per-case variational fitting after shared training: approximately `T_train+M C_encoder` versus `M K C_local` for M cases and K local iterations. This 349-row example demonstrates that mechanism, but supplies no measured break-even advantage, necessity for neural representation, or generalization guarantee. Restricted Gaussian q, shared encoder restrictions and unfinished nonconvex fitting remain distinct errors.

## New execution evidence

[Main probe](notebook_feasibility/probe.py), [compact results](notebook_feasibility/results.json), [source-unit audit](notebook_feasibility/source_audit.py) and [exact source records](notebook_feasibility/source_units.json) are isolated author research, not final reference/student notebooks. They ran in this worktree's locked uv environment using PyTorch `2.14.0+cpu`, NumPy `2.0.2`, one CPU thread. No dependencies or lock files changed, and no data/checkpoint files are stored in the course tree.

Reproduce from the isolated root with `.venv/bin/python Lectures/L12_VAE/notebook_feasibility/probe.py`; run the same Python on `source_audit.py` for exact source-cell records and on `digit_conditional_probe.py` for the unapproved alternative. These scripts regenerate only owned compact JSON and use `/tmp` for downloaded research data. Shared architecture/proposed-map/student-knowledge blobs checked are `cb111196e44df211e39864be596233a1a3f22aba`, `12a341b7e8733cdf9fe8154f066648d64e6034c0`, and `3fc6cd92b3c43b56c5ce4ca5a7d2963a2eb79942`; actual teaching remains unrecorded.

The probe downloads the [exact public CSV](https://github.com/narslab/mobile-emissions-typology/blob/049cb033a9814c0ec3df99ece5144d07688aa648/data/tidy/raw-data-cluster.csv) to `/tmp`, requires SHA-256 `05e02113771a0ab550a9e7a0098d099ee348820564b68bcdc6c71a28b24418d6`, and verifies 349 rows/57 columns and all 19 selected entries finite. It excludes names/Cluster and retains the source's selected transformations. A fixed seed chooses 245 training, 52 validation and 52 untouched test rows. The scaler mean/SD use training rows only. Log/share preprocessing is a fixed stated transform, not fit on held-out cases. Empirical row weighting is uniform; unequal final batches are never equally weighted in global evaluation.

The candidate has `19→32` ReLU encoder hidden features, four mean/four log-variance outputs, and `4→32→19` decoder means: 1,691 parameters. Configuration and seeds were fixed before test inspection: 300 epochs, batch 32, Adam 0.003, one reconstruction draw during training, validation every 20 epochs using 16 fixed-noise draws, minimum validation `D+βR` checkpoint. Three initialization seeds 17/29/43 and β1/β4 share the split/variance/transform/normalization. Test expected distortion averages 64 fresh fixed-noise draws; its reported Monte Carlo SE is conditional on the test cases and fitted weights, not uncertainty over other datasets.

| Course objective | Held-out expected D, nats/case | Held-out rate R, nats/case | Fit wall time, excluding imports |
|---|---:|---:|---:|
| β1, three seeds | 16.1639–16.3832 | 3.7816–3.9539 | Approximately 1.14–1.18 s per 300-epoch fit |
| β4, three seeds | 21.1576–21.6403 | 1.0974–1.1709 | Approximately 1.15–1.18 s per 300-epoch fit |

D's conditional MC SE is 0.028–0.036 for β1 and 0.066–0.078 for β4. The observed lower-rate/higher-distortion comparison is robust across these seeds, but is evidence for these fitted settings rather than a theorem about β or an optimal rate–distortion frontier. Students would fit one candidate; the second β fit remains supplied research/preparation, not another student assignment. No checkpoint is committed or approved by this investigation.

Float64 checks compare event NLL with summed `Normal.log_prob` and analytic KL with `kl_divergence`: maximum discrepancies `7.11e−15` and zero. Analytic prior-KL mean/log-variance gradients match exactly; fixed-noise numerical pathwise gradcheck passes for encoder coordinates and decoder weights. A full-network loss reaches every parameter block, including both encoder heads, with finite nonzero gradient norms. Correct scaling, log-variance conversion and gradient connectivity are author responsibilities rather than instructor approval questions.

The β1 deterministic mean-code reconstruction NLL is 14.5086–14.7258, compared with 15.3290 for a supplied training-only rank-four PCA reconstruction and 28.6897 for the training-mean reconstruction. These are straightforward **mean-reconstruction diagnostics**, not comparable probabilistic ELBOs. In particular expected VAE D≈16.2–16.4 is not the same quantity as deterministic PCA NLL≈15.3, and a lower mean-code score does not establish the VAE's generative superiority. PCA is a useful author-side guard against claiming the VAE is necessary for this small task. A brief supplied score is feasible if later interpretation design has room; a new student PCA fit or unexplained comparison is unwarranted.

## Additional source error verified against the printed page

The December 10, 2025 B2 PDF was read from the instructor's read-only duplicate, SHA-256 `54d6bfa8cc4a367bb553bea1c5127ca63696a9655b2ca1f6137a8584dccfdbaf`. A Poppler render of physical PDF page 827, printed p.793, visually verifies a sign error in §21.2.2 *Model fitting*, Algorithm 21.1. Its steps 10/11 are `log q`/`log p`, step 12 is **negative** Bernoulli log likelihood, and step 13 adds `log p−log q` before gradient-descent updates. That minimizes reconstruction NLL **minus** the sampled prior KL, whereas the correct negative ELBO uses reconstruction NLL **plus** `log q−log p` (or exact positive KL). This is additional source evidence, beyond the previously flagged L09 equations.

For a decoder independent of z and `q=N(μ,1)`, `p=N(0,1)`, take reconstruction NLL constant c. The printed objective has expectation `c−μ²/2` and gradient `−μ`; the correct objective is `c+μ²/2` with gradient `+μ`. Thus the error reverses prior regularization and is consequential. The course probe correctly uses `D+βR` with analytic nonnegative KL. Do not port this algorithm's loss line into the notebook. The same printed algorithm's full-covariance triangular-mask/density bookkeeping also needs checking before reuse; this course's diagonal q avoids that separate route. B2 Eq.21.7's log-variance ambiguity, the unrestricted-MLE guarantee in §21.2.1, and the β0/deterministic-AE claim remain the earlier documented cautions. No book page image is redistributed.

## Source transformations, checked units and domain validity

The original preprocessing uses `log1p(clip(v,lower=0))` for eight nonnegative size/economic/climate features, divides four commuting percentages by 100, and standardizes all features. Clipping makes the logarithmic transform non-invertible on arbitrary real input. In this exact dataset no selected log-transformed value is negative, so no information is lost by clipping on the observed domain. A complete inverse—training scaler inversion, then `expm1`, then commuting multiplication by 100—recovers observed raw values with maximum relative discrepancy below `4e−15` (absolute error `8.35e−7`, dominated by large GDP units). Scaler-only inversion does not recover original units. Applying `expm1` to unrestricted generated transformed values can return negative values, and percentages can leave their supports.

**New source warning:** column labels alone give incorrect physical bounds. `Employment Rate (%)` and `Unemployment Rate (%)` are actually fractions in `[0,1]`; `Built-Up Area Proportion` is stored as a percentage in `[0,100]`. Checked source provenance is preserved in [source_units.json](notebook_feasibility/source_units.json), with pinned notebook hashes, zero-based cell indices, whole-cell hashes and exact relevant expressions:

- [`msa-modeshare-income-employment-2020-dataprocessing.ipynb`](https://github.com/narslab/mobile-emissions-typology/blob/049cb033a9814c0ec3df99ece5144d07688aa648/bin/jupyter/preprocessing/msa-modeshare-income-employment-2020-dataprocessing.ipynb), SHA `ef3dac3493fad7fa9ffa54a49f788493a0e94176f2f37b1ffc6410952b4d0be8`, cell 17 strips percent signs and divides employment/unemployment by 100. Cell 5 uses one common row denominator for six commuting categories, including worked from home; its exact cell SHA is `a3b1439183cf024a9d3bb6b94c5303743ff51bf5ada5006d97c5dcd8c07fd1e8`.
- [`exploratory-factor-analysis.ipynb`](https://github.com/narslab/mobile-emissions-typology/blob/049cb033a9814c0ec3df99ece5144d07688aa648/bin/jupyter/preprocessing/exploratory-factor-analysis.ipynb), SHA `8b3929662119f2c5e236dd1d8ebc6cffb664be3627bd2bfa9cda295f5d093b5f`, cell 11 calculates the built-up percentage using `*100`; cell 13 applies the misleading employment label and renames the built-up variable; cells 14/15 apply the final built-up label. Cells 13/15 trace worked-from-home into `Working from Home Share` without changing its percentage units.

Raw employment spans 0.215–0.722, while built-up values span 0.8733–63.0797. The probe follows the checked source semantics. Correcting labels/plot units later is author work and does not require reopening the Gaussian objective.

Using 2,000 identical-seed prior latent draws per fit, full observation generation is

$$
z\sim N(0,I),\qquad X=d_\theta(z)+\sqrt{1/2}\,\eta,\quad\eta\sim N(0,I_{19}),
$$

followed by the complete inverse transform. Approximately 39.1–47.8% of full observations violate at least one checked nonnegativity/percentage bound; roughly 18.9–24.0% have negative transit/bicycle shares. Prior decoder means violate one such scalar bound in 0–4.75% of cases. A display of decoder means therefore conceals much of the chosen likelihood's domain failure. The existing four-share diagnostic reports sums above 100 in approximately 2.7–3.8% of full draws. A stronger necessary composition check includes **all five selected mutually exclusive categories**, adding working from home: their sum must be at most 100 because only taxicab/motorcycle/other is omitted. Observed five-share sums range 92.7133–99.7458%. Full prior observations violate this five-share condition in **36.60–37.75%** of cases across the same six fits; all six prior decoder-mean violation fractions are zero. Scalar bounds and the five-share joint constraint are separate, partial diagnostics; even satisfying both does not establish a plausible joint urban case. The script reports these violations without clipping samples, which would change the displayed generative model.

The [independent neural review](../course_architecture_scope/reconciliation/reviews/neural_probe_validation.md) replayed the original probes and identified the missing fifth category. The author independently checked the pinned source/category labels, added only the five-share statistic and source-cell records, and reran the affected probe after the original evidence was committed at `de2f020`. All pre-existing non-time outputs reproduce exactly; models, seeds, hyperparameters, train/test roles and unresolved pedagogical choices are unchanged. The repair strengthens the criticism of full generated observations and does not change the recommendation to retain mobility as a descriptive generate-and-critique candidate. It requires no instructor decision.

This result is compatible with the scope's explicit standardized-space approximation and no validated-city claim. It supports a required **generate-and-critique** encounter, and rules out silently presenting this candidate as a support-respecting raw generator. A constrained mixed likelihood would change the model mathematics, loss and preparation; it is not an implementation repair to hide behind an instructor-approved Gaussian equation.

## Rate, collapse and interpretation

Under the finite empirical case distribution and Gaussian encoder mixture,

$$
R=E_X\operatorname{KL}(q_\phi(Z\mid X)\Vert p(Z))
=I_q(X;Z)+\operatorname{KL}(q_\phi(Z)\Vert p(Z)),\quad
q_\phi(z)=E_Xq_\phi(z\mid X).
$$

Rate is an upper bound on this joint's information, not population MI and not a direct MI estimate. Identical shifted encoders `q(z|x)=N(1,1)` under standard Normal prior give `I=0`, `R=1/2`, all aggregate mismatch. The probe deliberately does not numerically estimate mixture MI or inherit a 0.1-KL “active” threshold as a theorem.

At β4 several coordinate rates shrink close to zero, with corresponding small variation in encoder means; other coordinates remain used. That is a fitted diagnostic, not proof of complete posterior collapse or a universal cure. Decoder independence from z plus q=prior gives the ideal zero-rate/zero-information case. Coordinate sign/permutation transformations preserve the isotropic prior and likelihood after corresponding decoder/encoder changes, so correlations/traversals do not identify unique causal factors. Network weights remain fitted points; random latent codes are not random weights.

## Primary attribution research and bounded alternative

The pinned [README](https://github.com/narslab/mobile-emissions-typology/blob/049cb033a9814c0ec3df99ece5144d07688aa648/README.md) expressly provides research code/data, identifying OSM-derived road variables and ACS, BEA, FTA and NCEI inputs; the [repository license](https://github.com/narslab/mobile-emissions-typology/blob/049cb033a9814c0ec3df99ece5144d07688aa648/LICENSE) is MIT, copyright Peiyao Zhao 2024. That software grant is not a checked per-column license for every derivative. OSM explicitly identifies ODbL and attribution obligations on its [official copyright page](https://www.openstreetmap.org/copyright). BEA permits reproduction of its information unless stated otherwise on its [official permissions FAQ](https://www.bea.gov/help/faq/145). These primary statements support an author-side packaging/attribution task, not a hypothetical question asking the instructor to approve legal correctness. This investigation downloads for research to `/tmp` and redistributes no CSV. Later publication should retain the research/paper citation, dataset version/hash, source acknowledgement and relevant OSM notice; the precise packaged derivative's obligations remain publication-owner work. Access itself is resolved by the exact pinned match.

A conditional digit option was also probed rather than selected. [Script](notebook_feasibility/digit_conditional_probe.py) and [results](notebook_feasibility/digit_conditional_results.json) use the [official scikit-learn packaged UCI 8×8 digits](https://scikit-learn.org/stable/modules/generated/sklearn.datasets.load_digits.html), all 1,797 cases, a fixed intensity threshold `>8`, a 64→32/four-latent/32→64 Bernoulli VAE, 100 epochs, and one seed. It runs in approximately 1.13 s; expected held-out Bernoulli distortion is 14.6142 and rate 4.3154 nats/case. Labels are unused. A Bernoulli draw has valid binary-pixel support, but no visual check here establishes recognizability. This is neither MNIST nor the original convolutional reference notebook. It loses the mobility interpretation and grayscale information and changes the Gaussian likelihood/event example. It is a bounded feasible research alternative if desired capability changes, not a silent fallback or a ready student notebook.

## Prerequisite and student-workload consequences

L04 must actually supply MI/KL and log-score meaning; L06 supplies the generic identity; L09 must preserve complete pathwise differentiation and the correct Normal KL; L11 supplies Gaussian NLL, constrained neural outputs and training practice. The L11 two-role choice changes how much receiving explanation L12 needs, but not whether the correct CPU candidate can be tested. L10/HMC is not a prerequisite.

The cumulative student-knowledge file contains entry/L01 state, so scoped L05/L09/L11 computations are planned prior encounters, not independent proficiency. Assume Bayesian/generative reasoning, expectation and ordinary array arithmetic familiar. Scaffold PyTorch shapes/event axes, gradient resetting, shared network usage and log-SD/log-variance conversion. Treat amortized per-case inference, the joint sampled loss, aggregate distribution and rate identity as new. Supply all cleaning/access/splits/scaler/model/plotting/baseline code; students complete only the declared latent transform/loss and one driver. The ~1-second fit does not establish the 60-minute fine-grained student sequence, and leaves debugging/interpretation as the main workload uncertainty. No additional student fit or MI estimator is justified by this runtime.

## Instructor-owned questions, deferred review

### L12-GENERATIVE-ENDPOINT — required generation encounter

**Resolved, current discussion 2026-10-15:** instructor selected “Require
generation and critique; replace the extra traversal (recommended).” The owning
scope Part 3 and contract now require the three-way comparison plus one supplied
criticism diagnostic. [Decision and follow-up boundary](reconciliation/city_transform_direction.md).
The earlier raw-Gaussian evidence below retains its source meaning; current
transformed-model evidence is in notebook_geometry/assessment.md. No whole-Scope,
transform-bundle, student-time or publication approval follows. The old options
below are retained as decision evidence, not an unanswered question.

**Status:** resolved by the current-discussion acceptance recorded in [lecture_scope.md](lecture_scope.md), Part3 and contract; owner Lecture Scope. Historical question/options below explain the accepted tradeoff.

**Question:** Should the notebook protect one supplied comparison of reconstruction, prior decoder means and full prior observation draws—including domain failures—by replacing the optional secondary traversal?

**Options:** (A) require that bounded comparison and remove the optional traversal; (B) retain the currently removable generation comparison and explicitly narrow the map's generative practical endpoint; (C) replace another named core interpretation activity to fund generation, requiring a concrete tradeoff review.

**Recommendation:** A. It makes the learner use and critically evaluate the actual generative model, with no second training run. The three displayed quantities start from different distributions or omit different randomness. Decoder means alone are insufficient evidence of observation generation.

**Evidence:** the map requires prior-generated cases while scope Part 3's generation comparison can be cut first. CPU probes demonstrate that full draws are inexpensive and expose scalar-support failures in 39.1–47.8% of cases versus 0–4.75% for means; the five-share composition condition fails in 36.60–37.75% of full draws versus zero for means. Earlier Section Design reviews accepted the old narrower endpoint; they are not approval of this change.

**Exactly waiting:** revised notebook generation/interpretation contract and receiving section/notebook organization for the required display; corresponding map/scope alignment. **Safe work completed/remains:** exact-data access, corrected transformation/units, Gaussian loss/gradient, β1/β4 CPU runs, support critique and conditional digit research are completed. No other lecture or independent model correctness work waits. No generation choice has been accepted or inserted into the scope.

### L12-APPLICATION — what the mobility example should accomplish

**Status:** city direction and zero rule recorded in [lecture_scope.md](lecture_scope.md); transformed-model evidence under independent review. Do not re-ask city versus digits. Final whole-Scope and remaining transform acceptance are separate.

**Question:** Should the final practical encounter retain mobility as a descriptive Gaussian representation/generate-and-critique task, or require a different support-respecting generative application?

**Options:** (A) retain the compact mobility Gaussian, with honest standardized-space scoring and explicit raw-support critique; (B) retain mobility but reopen observation-model design for bounded/compositional features, which requires a new mixed-likelihood feasibility/timing review; (C) choose a named narrow binary-digit alternative, changing dataset/likelihood/example rather than relabeling the mobility solution.

**Recommendation:** A for this scope. It keeps the instructor's researched data/context, the L11 Gaussian reuse and the existing event/KL normalization spine. The observed failures become part of judging whether the model answers its task well enough. It does not promise physically valid cities. Choose B only if that stronger capability is desired; C is now computationally plausible but is a distinct application choice, not required by a data-access failure.

**Evidence:** exact public mobility match, consistent CPU fits, 39.1–47.8% full-draw scalar failures and 36.60–37.75% five-share composition failures under checked source units, complete invertibility on observed data, and the bounded Bernoulli-digit probe. The Gaussian's support mismatch cannot be repaired by falsely labeling decoder means as observation draws or clipping generated values without changing the model. Existing proposals explicitly withhold raw physical/causal validity; no prior approval for substituting digits was found.

**Exactly waiting:** final application/model/performance commitment and any resulting scope/map/notebook replacement; mixed-likelihood or alternative student/worked-solution authoring is not approved. **Safe work completed/remains:** both bounded candidate CPU/source investigations are completed, including the conditional alternative. Cross-lecture investigation and review of current Gaussian mathematics can continue. Physical-validity claims are already disallowed on author evidence regardless of this pedagogical choice.

## Completion boundary

The bounded independent CPU/source/conditional-alternative investigation is complete; the coordinator can dispatch technical review and continue integrating other lectures. Acceptance, subsequent Section Design extent review, actual worked-solution preparation and student Q&A are distinct stages. Fresh hosted Colab, clean full notebook execution, derivative/source figure checking where needed, attribution packaging and a student workload trial remain publication gates. No scope/map/skill/shared queue was changed and no actual teaching was recorded.
