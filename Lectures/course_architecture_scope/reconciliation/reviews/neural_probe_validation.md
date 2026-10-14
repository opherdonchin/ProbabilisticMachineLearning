# Independent neural probe validation

**Mode:** bounded technical feasibility review and clean replay, 2026-10-14. **Reviewer:** `/root/validate_neural_probes`, independently delegated after the author investigation. **Target:** worktree `/tmp/pml-l04-l12-reconciliation`, branch `assess-l04-l12-reconciliation-20261014`, baseline `5e4c86ee3518958157d21d6bcb4c51bcdab3537e`. This review owns only this file; no author probe, scope, map, skill, notebook or shared queue was changed. The repository instructions and worked-solution-authoring validation boundary were read. Source/probe inspection preceded reading the owning investigation reports.

**Verdict:** the retained L11, L12 and conditional-digit results reproduce exactly apart from wall times. The Gaussian objectives, event reductions, pathwise gradients and validation-only checkpoint selection are correct for the declared models. The reports distinguish model coherence from task validity and make no supported claim of calibration, physically realistic cities, a measured amortization advantage, an optimal rate–distortion frontier, Colab readiness or student timing. One bounded L12 support-diagnostic improvement remains: include the fifth selected commuting category, working from home, in the joint sum check. It materially strengthens the demonstrated domain failure, without invalidating the explicitly partial four-share/scalar checks already reported.

## Replay record and exact versions

The reviewer copied only Python source to `/tmp/pml-neural-independent/L11/` and `/tmp/pml-neural-independent/L12/`, then launched separate clean processes using the isolated worktree's `.venv/bin/python`. Every process exited 0. The copied scripts write their JSON beside themselves; retained author JSON was not overwritten. Source data, rendered book page and exploratory output remain below `/tmp`, outside the course tree. PyTorch `2.14.0+cpu`, NumPy `2.0.2`; the digit probe records its scikit-learn version in its matching JSON. No dependency or lock change was made.

| Author artifact, relative to `Lectures/` | SHA-256 reviewed |
|---|---|
| `L11_Neural_Prediction/notebook_feasibility/probe.py` | `3a0c00e7b176e533c62db384685e768ea90d9ad876a68cd10fe07026e2c220a9` |
| `L11_Neural_Prediction/notebook_feasibility/results.json` | `020641340d961536d4454ab63b707dc8ac8d72ca075b9336c070ea2b0c8aac6d` |
| `L12_VAE/notebook_feasibility/probe.py` | `749a2deee29ca507289bf51a09086963f2da45ccbfc6d6205d269e7292ad4d94` |
| `L12_VAE/notebook_feasibility/results.json` | `33be8a142d50b831fcc353872851997073d6c318b7d9559cbe889dd166184107` |
| `L12_VAE/notebook_feasibility/source_audit.py` | `7642e2862df7d7ec148284fa04262720c9e2f406036f3bff038d0b45aab7d031` |
| `L12_VAE/notebook_feasibility/source_units.json` | `7973d186ee0736e25f63cf8f67c9c3889531d46ece89e7fc2d62c97b3bd0ccf4` |
| `L12_VAE/notebook_feasibility/digit_conditional_probe.py` | `3ec1ed6f1c6e10ad0fd7b5bf3cebf3fab6ff0fbc394b2e3174c1131e3bde9a68` |
| `L12_VAE/notebook_feasibility/digit_conditional_results.json` | `556a995b8c1932bf4262157051a2fe26c477f8f4c3d94bd492300eef11d03afd` |
| `L11_Neural_Prediction/scope_investigation.md` | `d4eef4131ba0b4162c8f3418d86100250bdab5bdadd14d9cae062a6dd7789f42` |
| `L12_VAE/scope_investigation.md` | `fdc29acfbffa2cdb9e09e8baa71af3af69ae1dac7c2e629335f6e11e7e2eca69` |

| Clean replay output under `/tmp/pml-neural-independent/` | SHA-256 | Comparison with retained author JSON |
|---|---|---|
| `L11/results.json` | `88f4afe17fa1cc6ad015990d3cf4573c5385551b198dbae21f071beb61e247da` | Every value equal after recursively removing only `training_seconds` |
| `L12/results.json` | `d342bb3fc246873d1948cf657c5ae179d9fdfd7e84640916aff3ac18cbf6c213` | Same exact non-time equality |
| `L12/digit_conditional_results.json` | `6f5f34113091dac8a9d5d286aaab3e12257f74b88abcdacd778f1de22272a98f` | Same exact non-time equality |
| `L12/source_units.json` | `7973d186ee0736e25f63cf8f67c9c3889531d46ece89e7fc2d62c97b3bd0ccf4` | Byte-identical |

Commands were `.venv/bin/python /tmp/pml-neural-independent/L11/probe.py`, and the corresponding `L12/probe.py`, `L12/source_audit.py`, `L12/digit_conditional_probe.py`, with stdout redirected to temporary logs. This establishes reproducibility in this CPU environment, not a hosted-runtime or final notebook pass.

## L11 mathematical and evaluation checks

For each scalar observation, the code uses

$$
\ell(y;\mu,\sigma)=\tfrac12\log(2\pi)+\log\sigma+\frac{(y-\mu)^2}{2\sigma^2},\qquad
\sigma=0.03+\operatorname{softplus}(a)>0.
$$

Targets, means and scales are all `B×1`; the explicit assertion prevents silent broadcasting into `B×B` losses. A batch mean is appropriate for this scalar event. The code retains both the scale log term and the derivative of the scale parameterization:

$$
\partial_\mu\ell=(\mu-y)/\sigma^2,\qquad
\partial_a\ell=\left(1/\sigma-(y-\mu)^2/\sigma^3\right)\operatorname{sigmoid}(a).
$$

The numerical checks include the batch factor `1/B`, distribution-reference NLL agreement (`4.44×10^{-16}`), analytic mean/scale gradients (maximum errors `6.94×10^{-18}` and `5.55×10^{-17}`), fixed float64 gradcheck, and shared-hidden adjoint equal to the sum of the two output paths (`5.55×10^{-17}`). Both paths have nonzero norm. Thus the scale branch is not detached from the hidden representation.

The generated interpolation law and fixed split are explicit: 320 training, 80 validation, 80 test cases. Only training inputs determine normalization. Each model's minimum validation NLL selects its checkpoint; the test slice is accessed only for final diagnostics. The nonlinear fixed-scale baseline estimates its residual SD on the training set at each checkpoint and again after restoring the selected state; its MSE mean fit is the fixed-scale Gaussian mean optimum. The affine baseline fits training-only least squares and residual scale. All three report the same test NLL/MSE/coverage quantities. The extra scale head adds parameters (130 versus 97 for the fixed-scale nonlinear network), so the result is a fitted capability contrast, not an equal-complexity model-selection experiment.

The retained test NLL ranges reproduce: affine `1.1844`, nonlinear fixed scale `0.5515–0.5657`, nonlinear scale head `0.3860–0.3982`. Mean MSE does not establish an analogous scale-head improvement. Regional 95% observation intervals use `±1.96 σ`; Wilson intervals quantify uncertainty of the observed binomial coverage counts, not uncertainty of Gaussian endpoints or a calibration guarantee. The two regions have 40 cases each. Three initializations on the same data are not three independent dataset replications. The report correctly confines the predictions to point-fitted weights and conditional observation spread; no weight-posterior uncertainty is supplied.

## L12 Gaussian objective, separation and comparisons

The implemented model is in standardized coordinates:

$$
p(z)=N(0,I_4),\quad p_\theta(x\mid z)=N(d_\theta(z),\tfrac12 I_{19}),\quad
q_\phi(z\mid x)=N(\mu_\phi(x),\operatorname{diag}(e^{\ell_\phi(x)})).
$$

With `z=μ+exp(ell/2) ε`, the loss terms are

$$
D=\|x-d_\theta(z)\|^2+\tfrac{19}{2}\log\pi,\qquad
R(x)=\tfrac12\sum_{j=1}^4(\mu_j^2+e^{\ell_j}-1-\ell_j).
$$

The code sums event coordinates before averaging cases. It uses the positive prior KL and log **variance**, and jointly differentiates reconstruction through the latent path and decoder. Distribution-reference maximum errors are `7.11×10^{-15}` for event NLL and zero for KL; analytic KL gradients match exactly; fixed-noise gradcheck passes for encoder coordinates and decoder weights. A full-network check reaches every encoder/head/decoder parameter block with finite nonzero gradients. Fixed decoder variance `1/2` is also used when drawing observation noise. The `decoder_variance` configuration is descriptive: changing it alone would not change the hard-coded mathematics, so any future manipulation must change NLL and observation sampling together.

The train/validation/test indices are disjoint (245/52/52) from one fixed random permutation. Fixed log/share transforms precede train-only standardization; the diagnostic full-data ranges do not select or fit a transform. Each β fit uses its own minimum validation `D+βR` state, common split/settings and fixed validation-noise draws. Independent test-noise seed 902 is used only after state restoration. Fixed common random numbers reduce comparison noise without mixing test data into training. Global evaluations average all cases, rather than equally averaging the unequal final batch.

The held-out rate/distortion ranges reproduce (`D=16.1639–16.3832`, `R=3.7816–3.9539` at β1; `D=21.1576–21.6403`, `R=1.0974–1.1709` at β4). Conditional Monte Carlo SE is computed across independent draw-wise averages over the fixed test cases. It measures integration noise for these fitted weights/cases; it is not a confidence interval over training, data collection, geography or model selection. Both β settings remain nonconvex fits, not points certified on an optimal frontier.

The code separately evaluates expected-q reconstruction NLL, decoder-at-encoder-mean reconstruction NLL, prior decoder means and full Gaussian observations. These are different targets. Training-only rank-four PCA (`15.3290`) and training mean (`28.6897`) are deterministic reconstruction diagnostics, appropriately compared with the deterministic VAE mean-code scores, not with its expected D or ELBO. No PCA KL rate or generative superiority is asserted. Neither KL-coordinate shrinkage nor a small encoder-mean SD alone proves complete posterior collapse. The reported rate is encoder-to-prior KL; its exact information decomposition requires the explicitly chosen empirical case distribution and is not an estimated population MI.

## Exact source, units and support checks

A fresh independent fetch of the pinned [public CSV](https://github.com/narslab/mobile-emissions-typology/blob/049cb033a9814c0ec3df99ece5144d07688aa648/data/tidy/raw-data-cluster.csv) returned 222,695 bytes with SHA-256 `05e02113771a0ab550a9e7a0098d099ee348820564b68bcdc6c71a28b24418d6`. It is byte-identical to the instructor's read-only `spring-2026/PS4/PS4-Questions/mobile-msa.csv`. The replay verifies 349 rows, 57 columns and finite selected `349×19` values. No CSV was committed.

The instructor source notebook was independently read, SHA-256 `f99265bf611aed7698ee16be356ef6880815d1367a1a684d33897adef38d9c07`. Its cell 2 uses exactly the eight clipped `log1p` transforms and four percentage divisions retained by the probe, but fits its original scaler on all cases. Cell 4 separately averages 19-dimensional reconstruction and four-dimensional KL; multiplying its loss by 19 gives `β_course=(19/4)β_source`. The new probe fixes the train-only scaler and refits β1/β4 in course units; it does not inherit the source checkpoint.

Both pinned preprocessing notebooks were independently fetched by the replayed source audit and inspected beyond the matched lines:

- [Employment/modeshare preprocessing](https://github.com/narslab/mobile-emissions-typology/blob/049cb033a9814c0ec3df99ece5144d07688aa648/bin/jupyter/preprocessing/msa-modeshare-income-employment-2020-dataprocessing.ipynb), whole-file SHA `ef3dac3493fad7fa9ffa54a49f788493a0e94176f2f37b1ffc6410952b4d0be8`: cell 17 strips `%` then divides employment/unemployment by 100; its whole-cell SHA is `f25466b82d17faa421072e76a8f38787fe2046d401bc72bb070db6b14caaa9fc`. The `[0,1]` bound despite `%` labels is supported.
- [Factor preprocessing](https://github.com/narslab/mobile-emissions-typology/blob/049cb033a9814c0ec3df99ece5144d07688aa648/bin/jupyter/preprocessing/exploratory-factor-analysis.ipynb), whole-file SHA `8b3929662119f2c5e236dd1d8ebc6cffb664be3627bd2bfa9cda295f5d093b5f`: cell 5 constructs the denominator by summing land-cover categories; cell 11 sums the developed subset and computes `row_sum_1/row_sum*100`. Later renaming yields `Built-Up Area Proportion`. The `[0,100]` bound is supported, rather than inferred from “Proportion.” Exact existing cell records reproduce byte-for-byte in `source_units.json`.

The inverse correctly undoes standardization, then `log1p` and commuting division. No observed log feature is negative, so clipped preprocessing is lossless on these observed rows; it is not a global bijection on arbitrary real input. The raw roundtrip relative error is below `4×10^{-15}`. The Gaussian standardized model remains a valid probability model even when inverse-transformed observations have negative shares or other forbidden raw values. The inverse of a standardized decoder mean is also generally **not** the conditional raw mean, because `expm1` is nonlinear; later plots should describe it as an inverse-transformed decoder mean. None of these checks establishes a scientifically plausible joint urban distribution.

The retained support calculation uses the verified employment, unemployment and built-up units; it does not clip generated data. Its `39.1–47.8%` full-draw scalar failures and `0–4.75%` decoder-mean failures reproduce. These are explicitly selected necessary bounds, not an exhaustive physical-support validator.

### Bounded repair: all five selected commuting shares

**Owner:** L12 probe/worked-solution author. **Severity:** medium diagnostic omission, not a loss/training failure or a false existing four-share statistic. **Minimal repair:** add a separate five-share sum-over-100 statistic and preserve the existing four-share number with its exact name; carry the stronger result into generation interpretation. No observation-model or scope change is required to calculate/report it.

The modeshare preprocessing cell 5 defines `calculate_percentage(row): return (row/row.sum())*100`. Its saved output has six mutually exclusive categories: car, transit, bicycle, walked, taxicab/motorcycle/other and worked from home. Whole-cell SHA `a3b1439183cf024a9d3bb6b94c5303743ff51bf5ada5006d97c5dcd8c07fd1e8`; factor-preprocessing cells 13/15 trace worked-from-home into `Working from Home Share`. Thus all **five selected** categories together must sum to at most 100, because only taxicab/motorcycle/other is omitted. Actual five-share sums range `92.71326796182863–99.74582119952194` in the CSV.

The reviewer added only this statistic to a temporary copied probe and reran it, writing `/tmp/pml-neural-independent/L12/support_refinement_results.json` (SHA `00c112c9308b7de11d4f7575b870df37ee4e703dc5164cf7498efd7e3ea4c78e`). Full prior observations then give:

| Seed | β | Existing four-share sum >100 | Five-share sum >100 |
|---|---:|---:|---:|
| 17 | 1 | 0.0300 | 0.3680 |
| 17 | 4 | 0.0280 | 0.3755 |
| 29 | 1 | 0.0345 | 0.3660 |
| 29 | 4 | 0.0300 | 0.3705 |
| 43 | 1 | 0.0375 | 0.3675 |
| 43 | 4 | 0.0270 | 0.3775 |

All six prior-decoder-mean five-share violation fractions are zero. The stronger check reinforces why decoder means alone conceal observation-model failures. The report's current four-share claims are numerically correct and explicitly partial; do not rename their numbers as a full commuting-composition check. Passing even the stronger check still does not establish joint realism.

## Independent printed-source check

Read-only Murphy Book 2 PDF SHA-256 `54d6bfa8cc4a367bb553bea1c5127ca63696a9655b2ca1f6137a8584dccfdbaf`; physical page 827/printed p.793, §21.2.2 **Model fitting**, Algorithm 21.1. The reviewer independently extracted and visually inspected a Poppler render. Steps 10/11 define `log q`/`log p`, step 12 defines **negative** Bernoulli log likelihood, step 13 adds `log p−log q`, and steps 14/15 minimize. This indeed subtracts the sampled prior KL from reconstruction NLL. With constant reconstruction c and `q=N(μ,1), p=N(0,1)`, its expected objective is `c−μ²/2`, whose minimizing gradient pushes μ away from zero. The correct negative ELBO is `c+μ²/2`.

**Owner:** later lecture/notebook source author. **Severity:** high mathematical source error, already correctly avoided in the retained probe. **Minimal repair:** retain exact positive prior KL or use `log q−log p` with reconstruction NLL; preserve the warning when introducing the source algorithm. This independent check supports the investigation's warning. The printed full-covariance mask/density bookkeeping was not independently implemented or validated; the current diagonal-q probe does not use that route. No page image was committed.

## Conditional digit probe and disposition

The independent clean digit run exactly reproduces expected held-out Bernoulli distortion `14.6142` and rate `4.3154`, checkpoint epoch and all non-time outputs. Fixed threshold `>8` yields binary observations. `binary_cross_entropy_with_logits(..., reduction='none').sum(-1)` is the correct event Bernoulli NLL; prior KL and reparameterization are consistent with the mobility diagonal-Gaussian latent model. The 1,397/200/200 split is disjoint and validation selects the state. This probe does not actually draw/display binary prior observations or assess recognizable digits; its report does not claim to do so. It is a conditional alternative, not evidence that the mobility Gaussian task has been replaced or that image quality is established.

No additional independent CPU check is needed for the declared fixed candidates' loss correctness, separation or reproducibility. The bounded five-share diagnostic repair remains author work supported by this completed independent calculation. Subsequent actual worked-solution preparation, plot/source checks, attribution packaging, clean notebook run, fresh hosted Colab and student workload trial remain downstream gates; none was performed or claimed here. This review grants no pedagogical approval and introduces no instructor question.

## Focused follow-up: additive five-share repair resolved

**Current disposition, 2026-10-14:** the author applied the bounded diagnostic repair after the original reviewed targets were preserved in commit `de2f020`. The earlier paragraphs above record that original target; the medium diagnostic omission is now **resolved**. This follow-up inspected only the additive probe/source/report changes and performed one focused clean replay. No model, data, seed, split, objective, checkpoint selection, prior scalar/four-share statistic or pedagogical recommendation changed.

| Updated target, relative to `Lectures/L12_VAE/` | SHA-256 |
|---|---|
| `notebook_feasibility/probe.py` | `f428d4f64694a3ddc0e2913e1350aa2c343132b9539be89723b0358f279bbff3` |
| `notebook_feasibility/results.json` | `5aa4e956fde11a1aed3fa71ef9de9c49e1c88ff6362e5ab92afd10b913f64c82` |
| `notebook_feasibility/source_audit.py` | `6aab5b41f2f8f88bf987d846275f240cba92db8ae2c918e61c9aa9266ec9e6bd` |
| `notebook_feasibility/source_units.json` | `af6bf188f51c05686da53314e9618e72b4843fe7495abdd88cddffbb287bbea5` |
| `scope_investigation.md` | `571340ea239a6b33717e8851f968387c2cb1ab3da56d8549a8e6f07c383ddbc4` |

The added `five_commute_idx` comprises the original four commuting categories plus `Working from Home Share`. `support_summary` sums these **after the complete inverse transform**, when all five are in percentage units: the four original fractional transforms have been multiplied by 100, and working from home already remains in source percentage units. The observed range is calculated on raw values in the same units. Thus the addition does not incorrectly combine fractions and percentages.

The extended source audit records the already independently checked shared denominator, modeshare-preprocessing cell 5, SHA `a3b1439183cf024a9d3bb6b94c5303743ff51bf5ada5006d97c5dcd8c07fd1e8`, and the worked-from-home rename chain in factor-preprocessing cells 13/14/15 with the same cell hashes preserved above. The source cell's six mutually exclusive mode columns include the five selected features and one omitted taxicab/motorcycle/other category, establishing the necessary five-sum bound. The updated report preserves the distinction between selected scalar checks, four-share checks, the stronger five-share joint check and scientific joint realism.

Copied repaired source to `/tmp/pml-neural-independent/L12/repaired/` and ran `.venv/bin/python` on `probe.py` and `source_audit.py` in separate clean processes; both exited 0. Repaired replay `results.json` SHA `154001fe896dca8b3a001a41924c86f4356f8e96571c6c65f39be063f87a9a38` matches the updated author JSON exactly after removing only `training_seconds`. Recursively removing only the two new diagnostic keys and wall times also gives exact equality with `git show de2f020:Lectures/L12_VAE/notebook_feasibility/results.json`, including every previous finite metric, selection, gradient check and support statistic. The repaired source-unit JSON replay is byte-identical to the updated author artifact, SHA `af6bf188f51c05686da53314e9618e72b4843fe7495abdd88cddffbb287bbea5`.

The clean replay reproduces observed selected-five sums `[92.71326796182863, 99.74582119952194]`; full-observation violation fractions in seed/β order are `0.368, 0.3755, 0.366, 0.3705, 0.3675, 0.3775`, while all six prior decoder-mean fractions are zero. This equals the independent refinement calculation above. The precise author repair is validated; no further authorized independent checks remain for this repair. Downstream readiness gates and the absence of pedagogical approval remain as stated above.
