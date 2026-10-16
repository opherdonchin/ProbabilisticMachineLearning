# Worked example — L01 exact Gaussian queries

Stage: `worked-solution-authoring`, mode `revision`, completed technical route before student-question decomposition. This handoff does not approve the complete lecture Scope, notebook workload or hosted runtime readiness.

## Learning target

Use one supplied joint Gaussian to compute a hidden block's conditional distribution and its squared-loss action, then translate the same joint into the lecture's linear Gaussian system (LGS). Use its forward measurement marginal and a short fresh-case generation activity to distinguish different questions answered by the same model.

The controlled task is reconstructing three withheld coordinates from four recorded coordinates. Parameters are known. The example demonstrates exact inference under supplied assumptions, not learned parameters, a realistic-scale bottleneck or practical experience with an approximate inference algorithm.

## Relevant lecture material

Inputs inspected on `lecture/l01-delivery-readiness` at `2d8d949d86ec7ba8dbc77fec25fb86d7cca58260`:

- `Lectures/L01_Probability_Statistics/lecture_scope.md`: accepted same-model hidden distribution, squared-loss summary, forward marginal and short generation direction; incomplete overall Scope status preserved.
- Live `slide_deck.typ`: “Conditioning shifts the mean by an observed deviation”/conditional block equations around lines 1999–2081; LGS model/joint/update around 2332–2580; “A point estimate needs a loss function” and “The conditional mean minimizes squared-error risk” around 2773–2864; “The same model can also predict measurements” around 2920–2963. Titles/equations, rather than page numbers, identify the conceptual inputs.
- Current `InClass/Preparation/lecture1_missing_data_worked_solution.py` and `InClass/Solutions/lecture1_missing_data.ipynb`: preserved model, original seed-2027 case, joint-to-LGS mapping and useful uncertainty interpretation. They are current drafts being replaced, not approved exemplars. Their sampling stack and supplied comparisons do not carry forward. The original case is now supplied at full precision rather than redrawn at runtime; this preserves the case across numerical platforms.

For the partitioned joint, the implemented lecture equations are

$$
\begin{pmatrix}X_1\\X_2\end{pmatrix}
\sim\mathcal N\left(\begin{pmatrix}\mu_1\\\mu_2\end{pmatrix},
\begin{pmatrix}\Sigma_{11}&\Sigma_{12}\\\Sigma_{21}&\Sigma_{22}\end{pmatrix}\right),
$$
$$
m_{1\mid2}=\mu_1+\Sigma_{12}\Sigma_{22}^{-1}(x_{2,\mathrm{obs}}-\mu_2),\qquad
V_{1\mid2}=\Sigma_{11}-\Sigma_{12}\Sigma_{22}^{-1}\Sigma_{21}.
$$

The live squared-loss identity is applied, not rederived:

$$
R(a\mid y)=E[\|Z-a\|^2\mid y]
=\operatorname{tr}(V)+\|m-a\|^2,
\qquad m=E[Z\mid y],\quad V=\operatorname{Cov}(Z\mid y).
$$

Finite conditional second moments suffice for this identity. Gaussianity is what makes the particular conditional distribution available from these matrix formulas. The risk is the expected **sum** of squared coordinate errors, without dividing by three. The optimal action is $a=m$ and its model expected risk is $\operatorname{tr}(V)$; this is different from its error at one realized hidden vector.

The LGS is the same joint factored as $p(z)p(y\mid z)$:

$$
z=x_1,\quad y=x_2,\quad \mu_z=\mu_1,\quad\Sigma_z=\Sigma_{11},
$$
$$
W=\Sigma_{21}\Sigma_{11}^{-1},\quad b=\mu_2-W\mu_1,\quad
\Omega=\Sigma_{22}-\Sigma_{21}\Sigma_{11}^{-1}\Sigma_{12}.
$$

Its independent Gaussian residual supplies $y=Wz+b+\epsilon$, $\epsilon\sim\mathcal N(0,\Omega)$. This is a mathematical representation of the synthetic joint; no physical sensor or causal interpretation has been inferred from the covariance.

$$
\mu_y=W\mu_z+b,\qquad \Sigma_{zy}=\Sigma_zW^T,\qquad
\Sigma_{yy}=W\Sigma_zW^T+\Omega,
$$
$$
\mu_{z\mid y}=\mu_z+\Sigma_{zy}\Sigma_{yy}^{-1}(y-\mu_y),\qquad
\Sigma_{z\mid y}=\Sigma_z-\Sigma_{zy}\Sigma_{yy}^{-1}\Sigma_{zy}^T.
$$

Forward $p(y_{\mathrm{new}})=\mathcal N(\mu_y,\Sigma_{yy})$ marginalizes the unknown state for a fresh case **before** its measurement. It differs from $p(y\mid z)$ and the old case's hidden conditional. With known fixed parameters, the old observed $y$ does not enter this fresh-case marginal.

## Starting information

- Given: $n_1=3$, $n_2=4$; $\mu_1=(-0.5,0.5,1)^T$; $\mu_2=(0,0.5,-0.5,1)^T$; $\sigma_1=1$, $\sigma_2=1.2$, $\rho_1=0.70$, $\rho_2=0.80$, $\kappa=0.90$.
- Covariance: the original $\Sigma_{11}=\sigma_1^2[(1-\rho_1)I_3+\rho_1J_3]$, $\Sigma_{22}=\sigma_2^2[(1-\rho_2)I_4+\rho_2J_4]$, $\Sigma_{12}=\kappa\sigma_1\sigma_2\sqrt{\rho_1\rho_2}\mathbf1_3\mathbf1_4^T$, $\Sigma_{21}=\Sigma_{12}^T$. This construction is supplied setup, not an additional estimation exercise.
- Controlled case: supplied full-precision reference data, originally the first complete draw from `np.random.default_rng(2027).multivariate_normal(mu, Sigma)` on the reference NumPy 2.0.2 runtime. The source records that provenance truthfully but does not regenerate the draw at runtime. Retain `x1_true` only for reference/evaluation; give only `x2_obs` to inference.
- Observed: `x2_obs = (-0.184131, -0.069738, -0.077779, 0.919187)` approximately.
- Unknown: this case's three hidden coordinates. Truth is `(-0.980927, -0.275007, 1.892047)` approximately and never enters the mean/covariance calculation.
- Fixed: joint distribution, Gaussian assumptions, coordinate withholding and all model parameters. No missingness-process model is being learned.

## Solution sequence

1. Construct the original joint; inspect its correlation structure. Author assertions check shapes, symmetry and positive definiteness.
2. Load the original full-precision controlled incomplete case as supplied data. Keep hidden simulation truth separate from inference input.
3. Evaluate the block conditional mean/covariance with explicit `np.linalg.solve` expressions. Display analytic marginal 90% intervals and conditional correlations. No conditional draws or Monte Carlo approximation are required.
4. Apply the squared-loss identity: choose the conditional mean and compute the minimum conditional model risk $\operatorname{tr}(V)$. Retained author checking arithmetic compares this action with the already supplied unconditional mean and separately prints this case's realized errors. This does **not** commission an additional baseline study or required coding task.
5. Translate the joint to LGS notation using the original $W,b,\Omega$ route. Supplied author checking reconstructs the joint blocks and recomputes the conditional using the live LGS equations, verifying exact agreement to numerical tolerance. Do not commission a second required conditional implementation. Keep `mu_y`/`Sigma_yy` names rather than reusing `m` for a forward mean and a conditional-mean action.
6. Read the same forward moments as the answer to $p(y_{\mathrm{new}})$ before observing a fresh case.
7. Generate one fresh LGS case with a separate supplied seed, `FRESH_RANDOM_SEED = 2028`: draw `z_new` from the unconditional state law, then independent `epsilon_new`, then form `y_new = W @ z_new + b + epsilon_new`. The observed case does not condition these draws, and this seed does not determine the supplied reference case. This vector computation follows the live equation directly. The affine generator moment check is author validation only.

## New computational tools or APIs

| Tool / representation | Required interpretation and shape |
|---|---|
| NumPy vector arrays, slicing and `@` | Vectors have shapes `(3,)`/`(4,)`, not `(d,1)`. `x_complete[:3]` and `[3:]` select blocks. `@` is matrix multiplication, not entrywise multiplication. |
| `np.block`, `.T` | Assemble `(7,7)` covariance from `(3,3)`, `(3,4)`, `(4,3)`, `(4,4)` blocks. `.T` transposes a matrix; transposing a one-dimensional vector does not make a column array. |
| `np.linalg.solve(A, B)` | Solves $AU=B$. Conditional mean RHS `(4,)`; conditional covariance RHS `(4,3)`. The $W$ computation solves `(3,3)` against `(3,4)`, then transposes to `(4,3)`, using symmetric $\Sigma_{11}$. No explicit inverse. |
| `np.trace`, `np.sum((m-a)**2)` | Trace is total conditional variance; the squared vector norm is the action's excess conditional squared-loss risk. |
| `np.diag`, `np.sqrt`, `np.outer` | Extract marginal SDs and normalize covariance for a correlation display. Plot infrastructure can be supplied. |
| `scipy.stats.norm.ppf(0.95)` | Standard-normal quantile $1.6448536\ldots$ for central **individual marginal** 90% intervals. May be supplied as a plotting constant. These bars are neither a simultaneous joint region nor Monte Carlo uncertainty about an estimated mean. |
| `rng_new.multivariate_normal(mean, cov)` | Fresh state `z_new` has shape `(3,)`; independent noise `epsilon_new` and resulting measurement `y_new` have shape `(4,)`. The direct vector equation `W @ z_new + b + epsilon_new` implements the LGS. No batch/broadcast idiom is required. |
| `np.testing.assert_allclose`, `eigvalsh` | Author validation, not new required student programming. |

The `save_figure` helper and the Matplotlib figure construction are supplied presentation infrastructure. `Path(__file__)`, `matplotlib.use("Agg")`, output-directory creation and PNG/SVG saving are script-only mechanics. A notebook should show figures inline; it should not copy these filesystem assumptions into a Colab cell.

## Reference implementation

- Canonical integrated implementation: `InClass/Preparation/lecture1_missing_data_worked_solution.py`, linear technical route, numbered comments 0–7; central equations remain explicit. The specialist staged scratch source; the coordinator integrated it and corrected only its run-command docstring to the canonical path.
- `/tmp/l01-exact-worked/validation.log`: actual successful clean-process output; assertions are active.
- `/tmp/l01-exact-worked/runtime_versions.txt`: actual local interpreter/dependency versions.
- Generated PNG/SVG validation evidence is under `/tmp/l01-exact-worked/lecture1_missing_data_figures/`. The script defaults to a dedicated `lecture1_missing_data_figures/` directory beside itself, avoiding a shared generic figure directory. The student notebook should display inline outputs and require no local figure assets.

## Expected outputs

### Numerical

- Cross covariance `0.8081979955`; cross correlation `0.6734983296`.
- Joint covariance eigenvalues approximately `(0.288, 0.288, 0.288, 0.3, 0.3, 0.582757, 6.713243)`; positive definite.
- Conditional mean `(-0.56808611, 0.43191389, 0.93191389)`; covariance diagonal `0.4663529412`, off diagonal `0.1663529412`; SD `0.68290039` approximately in every coordinate. Conditional off-diagonal correlation `0.3567104` approximately.
- Marginal 90% conditional interval endpoints approximately `(-1.691357, -0.691357, -0.191357)` and `(0.555185, 1.555185, 2.055185)`.
- Optimal action minimum conditional model risk `1.3990588235`; supplied unconditional mean action risk `1.4129659777`, excess `0.0139071542`. The small difference is a property of the preserved observation, not a reason to reseed or strengthen the claim.
- Realized squared errors for this simulation: conditional-mean action `1.5920294059`; unconditional-mean action `1.6276734258`. The conditional expected-risk ordering does not guarantee a realized ordering in every case.
- $W$ is `(4,3)` with every entry approximately `0.3367491648`; $b\approx(-0.336749,0.163251,-0.836749,0.663251)$.
- $\Omega$ diagonal `0.62352`, off diagonal `0.33552`; positive definite.
- Forward mean exactly reproduces `mu2`; forward covariance reproduces `Sigma22` with diagonal `1.44`, off diagonal `1.152`.
- One fresh state and its measurement are printed in the validation log. Their realized values are runtime-specific illustrations, not a fixed numeric answer key or a moment-accuracy check. The stable generation result is the stated law and the equation `y_new = W @ z_new + b + epsilon_new`.

### Figures

- `joint_correlation.{png,svg}`: known joint dependence, with the block boundary marked.
- `hidden_block_uncertainty.{png,svg}`: unconditional versus conditional marginal intervals, their means, and hidden simulation truth marked as reference only. Interpretation: conditioning reduces uncertainty in this known Gaussian regime; it does not identify the missing vector exactly. Individual intervals do not encode all conditional dependence, so the exact covariance/correlation is also printed.
- `forward_measurements.{png,svg}`: exact forward marginal means/intervals, one fresh generated measurement case and the old recorded case marked as reference only. The legend is outside the data area. The fresh-case horizontal offset separates markers; it does not alter measurements.

All three PNGs were visually inspected. No clipping or obscured plotted data remains.

## Validated equivalences or checks

Successful local command from the repository root:

```bash
MPLCONFIGDIR=/tmp/l01-exact-worked/mplconfig UV_CACHE_DIR=/tmp/l01-exact-uv-cache \
  uv run --no-sync python /tmp/l01-exact-worked/lecture1_missing_data_worked_solution.py \
  > /tmp/l01-exact-worked/validation.log 2>&1
```

The coordinator had already run `uv sync --locked`; this worker made no dependency, manifest or lock changes. Clean-process execution exited zero. Local runtime: Python 3.12.13, NumPy 2.0.2, SciPy 1.16.3, Matplotlib 3.10.0.

- The supplied full-precision case is exactly equal, component by component, to the original seed-2027 draw on the recorded NumPy 2.0.2 reference runtime; `portability_validation.log` records this check. Original case and posterior also agree with the original notebook's rounded values to absolute tolerance `5e-4`. Model construction and dimensions are retained. The rounded assertions now check supplied reference data and analytic inference, not a platform-specific random generator outcome.
- Joint, hidden conditional and residual-noise covariances checked symmetric and strictly positive definite. Covariance reduction checked positive semidefinite to tolerance `1e-12`.
- LGS reconstructs original observed mean, cross covariance and observed covariance to `1e-14` absolute tolerance.
- Block and LGS conditional mean/covariance checked to `1e-12` absolute tolerance, with observed maximum errors both exactly `0.0` on this runtime.
- Squared-loss identity checked as trace-plus-norm and as the sum of marginal second moments; minimum risk checked against the numerical reference.
- Independent-state/noise generator checked **algebraically**: its affine mean/covariance equal the original full joint to `1e-12`; no generic Monte Carlo study was added.

## Useful manipulations

No additional sensitivity activity is commissioned. The existing contrast between ignoring the observed block and conditioning on it is already visible in the uncertainty display. The unchanged model predicts a smaller conditional covariance that depends on the observed-coordinate pattern, not the numerical observation. The actual observation controls the mean shift. These interpretations need no new parameter-changing coding exercise.

## Deliberate exclusions

No PyMC, ArviZ, pandas, sampling comparison, posterior approximation, hidden-state conditional sample plot, package-internals exercise, parameter fitting, artificial scaling bottleneck, reseeding for a dramatic improvement, or additional sensitivity/Monte Carlo task. No claim that generated or inferred data validate the Gaussian model. No student questions or self-work notebook yet.

## Runtime or technical caveats

Local technical route is validated. A clean hosted Google Colab run is still required before publication; no hosted run was performed by this worker. Removing the earlier sampling stack does not establish hosted compatibility by assertion.

The script's `Agg` backend/output directory and the local `MPLCONFIGDIR` are scratch validation mechanics. First local run succeeded with Matplotlib's fallback temporary cache; the final run uses an explicit writable cache and emits no cache warning. This is not a notebook dependency problem. Do not add installation cells for NumPy/SciPy/Matplotlib unless the real target hosted environment demonstrates a need.

The joint has repeated covariance eigenvalues. SVD/eigenvector bases within those eigenspaces may rotate across BLAS/library/platform implementations. Even with the same seed, this can change a generated case by much more than rounding while preserving its correct Gaussian law. The supplied seven-component reference array therefore fixes the original example **independently** of a runtime sampler. Its recorded seed-2027 origin is provenance, not a claim of cross-platform random-draw reproducibility. Fresh generation uses a separate seed 2028; its realized values may vary across platforms and must not become numeric answer-key assertions. The exact joint moments, conditional results for the fixed reference observation, and algebraic generator checks remain the validation targets.

No unresolved mathematical issue requiring instructor approval was found in this bounded exact route. Complete Scope depth, final workload and hosted publication approval remain coordinator-owned decisions/checks.

## Notes for pedagogical decomposition

- Preserve the effective original fine-grained progression and joint-to-LGS translation while making the target distribution explicit before computation.
- Do not mechanically turn author assertions, covariance spectral checks, generator affine proof, repeated block/LGS conditional verification or the prior-action risk check into required student tasks. The core action application is the conditional mean and minimum risk $\operatorname{tr}(V)$.
- Make new NumPy operations explicit where first needed. Supplied setup/plotting is appropriate; central solves, conditional moments, $W,b,\Omega$ translation and query interpretations should remain visible. Load the supplied full-precision case rather than recreating it with `rng.multivariate_normal`. Retain the brief truthful seed-2027/NumPy-2.0.2 origin note; fresh generation alone uses seed 2028. Do not freeze fresh generated values into numerical answer keys.
- Keep simulation truth separate from inference input, conditional uncertainty separate from a chosen point action, and conditional expected risk separate from one realized error.
- Introduce $p(y_{\mathrm{new}})$ as a different query from the same known joint before generation. Fresh states use the unconditional prior, not the old hidden-case posterior. Generation is a use of the model; it is not a fourth probability operation.
- Use notebook display math `$$ ... $$`. Follow the solved-Q&A source and mechanical self-work generation policy downstream.

## Exact source records

SHA-256 of inspected inputs at the stated baseline:

```text
e6ae3d469e66b422d9a08bd9a747333f35694249c6ddc90040186053f67b26c8  InClass/Preparation/lecture1_missing_data_worked_solution.py
f114516ca6a9c0823c14da0a734822a8901e4fdccf237481d47d0e3a61f80a8c  InClass/Solutions/lecture1_missing_data.ipynb
d0f14f76b1a89afaf8eb308d332a8675c65f582a7c1ab0538b251b63427e0e0b  Lectures/L01_Probability_Statistics/lecture_scope.md
66ec0914f65f008b8ecacb20c2faad61e9b630dfd1f8b1dc5a9e8f196d073e7f  Lectures/L01_Probability_Statistics/slide_deck.typ
ceee37b641a982ed82251242b0d725ac56051801add5faa998643d1dd5645f00  /tmp/l01-exact-worked/lecture1_missing_data_worked_solution.py
```

## Canonical integration check — coordinator

The integrated source passed a clean process under `uv run --locked python InClass/Preparation/lecture1_missing_data_worked_solution.py`; all three current PNG/SVG pairs were regenerated. Canonical source SHA-256: `d859b53fcf1d3fb59dc0f15c1250bc568c0f5872b4e6509d4902ff863344e80b`. This differs from the specialist source only in the canonical command docstring. Durable raw output, reference-case check and runtime versions are under [current exact-only evidence](../../Lectures/L01_Probability_Statistics/reconciliation/delivery_readiness/runtime/exact_only/). Hosted validation remains pending.
