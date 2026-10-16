# L01 runtime check — existing solved draft

Assessment at `main@8889ac0a433a784482a7ecf0931a006e3965bd6e`, 2026-10-16. Bounded L01-RUNTIME-CHECK assignment. No repository source, notebook, manifest, lock or environment packages were changed. A subsequently commissioned follow-up installed dependencies only in an isolated uv project under the same scratch directory. All outputs are under `/tmp/l01-delivery-runtime/`. The coordinator owns pedagogical questions and persistent records.

## Result

The supplied Gaussian construction, LGS translation and exact posterior equations pass a fresh-process check using the repository `.venv`. The solved notebook is not validated against the repository-locked environment: its imported pandas/PyMC/modular-ArviZ stack is absent from both the manifest/lock and installed environment. Its first code cell is a `%pip install` operation; it was inspected, **not executed**, because repository dependency changes were outside the assignment. A separately extracted, unchanged import cell fails on `import pandas as pd`. This is an actual import failure, not a claim to have executed the original notebook top-to-bottom.

The initial repository-environment check had no installed PyMC API. The commissioned isolated-environment follow-up below now provides actual API, sampling and display evidence for the existing computation. No hosted Colab session was accessed or run. Repository-locked full-notebook readiness and hosted readiness remain unestablished.

## Commissioned isolated uv follow-up: actual PyMC path

The coordinator subsequently commissioned a separate uv-managed project at `/tmp/l01-delivery-runtime/exploratory`, using the notebook's provisional pins and existing course scientific pins, with pandas/nbclient/nbformat/ipykernel. No Torch or JupyterLab installation was needed. `uv add` and `uv sync --locked` completed. This **exploratory lock is separate from the repository lock** and does not establish Colab compatibility.

The copied notebook preserves the exact source and order of all 79 remaining cells after omitting only original cell index 2 (`%pip install`), because uv provides dependencies. Outputs/counts were cleared before execution. One labelled author-only diagnostic was appended after the original cells. [exploratory-copy-provenance.txt](exploratory-copy-provenance.txt) records this distinction; [exploratory_execute.py](exploratory_execute.py) records the execution and diagnostic code.

The first fresh-kernel run completed the computations but emitted an `ImportError` traceback from ArviZ's summary LaTeX representation because minimal scratch dependencies omitted Jinja2. That error did not stop subsequent notebook cells. The repository already contains Jinja2 3.1.6 in its `.venv` and lock, through JupyterLab, so this was a **scratch-environment omission**, not an established notebook or repository defect. The coordinator authorized adding that same Jinja2 pin in scratch and rerunning once. The second fresh-kernel run completed all original computations and the author diagnostic in **3.38 seconds, with zero notebook error outputs**. First-run total was 13.10 seconds with compilation cache cold. PyMC reported sampling time about one second in each run; these are local observations, not delivery-time or controlled algorithm benchmarks.

Raw records:

- [initial-exploratory-cell-outputs.log](initial-exploratory-cell-outputs.log) preserves the actual initial display traceback and first diagnostics.
- [exploratory-cell-outputs.log](exploratory-cell-outputs.log) and [exploratory-execution.log](exploratory-execution.log) preserve the successful repaired-scratch run and cell order.
- [exploratory-install.log](exploratory-install.log), [exploratory-sync.log](exploratory-sync.log), [exploratory-display-repair.log](exploratory-display-repair.log), [exploratory-display-repair-sync.log](exploratory-display-repair-sync.log), and [exploratory-installed.txt](exploratory-installed.txt) record installation/sync and versions. The exploratory manifest/lock are in `exploratory/pyproject.toml` and `exploratory/uv.lock`.
- [exploratory.executed.ipynb](exploratory.executed.ipynb) is the full repaired scratch execution record. Source-preserving scratch input is `exploratory/lecture1_missing_data.exploratory.ipynb`.

Observed versions: Python 3.12.13; NumPy 2.0.2; SciPy 1.16.3; Matplotlib 3.10.0; pandas 3.0.6; PyMC 6.3.2; PyTensor 3.3.4; arviz-base 1.3.0; arviz-stats 1.3.2; xarray 2026.9.0. The actual installed xarray differs from the earlier smaller metadata-only resolution; these are distinct dependency contexts, and the scratch installed list/lock owns this run.

Actual API results:

| Object/check | Observed result |
|---|---|
| `type(idata)` | `xarray.core.datatree.DataTree` |
| posterior variables, order | `['x_unobserved', 'x']` |
| missing-block dimensions | `(chain=4, draw=2000, x_unobserved_dim_0=3)` |
| reconstructed `x` dimension | `x_dim_0=7` |
| summary columns | `['mean', 'sd', 'hdi90_lb', 'hdi90_ub']` |
| summary index, order | `x_unobserved[0]`, `[1]`, `[2]` |
| `azb.extract` result | `xarray.core.dataarray.DataArray` |
| extracted dimensions and shape | `('x_unobserved_dim_0', 'sample')`, `(3, 8000)` |
| supplied plotting transpose | `(8000, 3)`, as intended |

All four original plotting cells rendered. The covariance display, PyMC violin display, exact-Gaussian-draw violin display and combined mean ± SD figure were extracted and visually inspected. The comparison uses the same quantities in one plot and is readable. [exploratory-cell-77-plot-0.png](exploratory-cell-77-plot-0.png) contains the direct comparison; [exploratory-cell-42-plot-0.png](exploratory-cell-42-plot-0.png) and [exploratory-cell-71-plot-0.png](exploratory-cell-71-plot-0.png) preserve the two posterior displays.

PyMC initialized NUTS using `jitter+adapt_diag` and sampled `x_unobserved`, four chains × 1,000 warmup + 2,000 retained draws. Diagnostics observed: zero divergences; bulk ESS approximately `(4964, 4685, 4656)`; tail ESS `(5521, 5479, 5499)`; R-hat displayed `1.00` for all coordinates. Reported mean MCSE approximately `(0.0096, 0.010, 0.010)` and SD MCSE approximately `(0.0070, 0.0065, 0.0069)`. These printed values are rounded by ArviZ; no extra precision is inferred.

| Coordinate | PyMC mean | Exact mean | PyMC SD | Exact SD |
|---|---:|---:|---:|---:|
| 0 | -0.573310 | -0.568086 | 0.677365 | 0.682900 |
| 1 | 0.435174 | 0.431914 | 0.681029 | 0.682900 |
| 2 | 0.937995 | 0.931914 | 0.692606 | 0.682900 |

The mean discrepancies `(-0.00522386, 0.00325982, 0.00608075)` are each within 0.7 of their reported mean MCSE. SD discrepancies `(-0.00553568, -0.00187161, 0.00970533)` are each within about 1.5 reported SD MCSE. Maximum absolute covariance discrepancy was `0.01340971`; a covariance MCSE for correlated chains was not estimated, so it is recorded without a standardized acceptance claim. This is good numerical agreement in this run, conditional on the supplied model; it is not a mathematical guarantee of sampler convergence.

Warnings retained: the expected `ImputationWarning` and a Rich progress-display request to install ipywidgets. The latter reflects the intentionally small scratch environment and did not affect calculations or plots. There were no divergence warnings or final error outputs. The initial missing-Jinja2 display traceback remains identifiable in its own raw record.

This follow-up verifies the draft's intended PyMC/DataTree/modular-ArviZ path in an **isolated exploratory environment**. The actual repository environment is still missing its directly imported notebook dependencies; its own lock has not been updated, and hosted Colab has not been tested. PyMC's educational role remains an instructor decision and was not changed.

## Exact source and evidence

[input-hashes.txt](input-hashes.txt) identifies all inspected input blobs and SHA-256 hashes. In particular:

- solved notebook: `ab441941c8b526151a927bfbcf292bd9bc629ce5`;
- worked source: `d605e135b732856060a98e7a6f5bb08bd35f8672`;
- authoring report: `1c710e379317d8b7955924dc9f9110c341a1101d`.

The notebook has 80 cells. Its actual route is joint Gaussian → PyMC conditional sampling → LGS representation → exact posterior → comparison. The Python worked source uses monolithic `arviz`, whereas the solved notebook imports `arviz_base` and `arviz_stats`. These are distinct runtime paths; success of one would not validate the other.

Installed versions observed: Python repository `.venv`, NumPy 2.0.2, SciPy 1.16.3, Matplotlib 3.10.0, nbclient 0.10.4, nbformat 5.11.1, ipykernel 6.31.0. pandas, pymc, arviz, arviz-base, arviz-stats and xarray were all missing. NumPy/SciPy/Matplotlib pins match `pyproject.toml`; none of the missing directly imported notebook packages is declared there.

- `notebook-installer-cell.txt`: exact installer cell, not executed.
- [notebook-import-cell.py](notebook-import-cell.py) and [import-failure.log](import-failure.log): exact unchanged first import cell, fresh-process exit 1, `ModuleNotFoundError: No module named 'pandas'`.
- [check_analytic.py](check_analytic.py) and [analytic.log](analytic.log): reproducible fresh-process analytic subset and actual results.
- `analytic-figure-1.png`: original notebook covariance/correlation display; rendered and visually inspected.
- `analytic-figure-2.png`: author-side direct-draw diagnostic against exact marginal densities; rendered and visually inspected. This is validation evidence, not a proposed student exercise.
- `notebook-requirements.in`, `resolved-candidate.txt`, `dependency-resolution.log`: scratch-only dependency resolution, no installation.

## Analytic validation

The check executes unchanged original code cells 5, 12, 17, 20, 47, 51, 53, 57, 59, 65, 67 and 69, in that order, with the original random seed and supplied NumPy/Matplotlib imports. The PyMC path, pandas table, PyMC plot helper and sampling comparison are not executed. This is a clean process validating selected mathematical computations, not a clean full notebook kernel run.

The joint covariance is positive definite: eigenvalues are approximately `(0.288, 0.288, 0.288, 0.3, 0.3, 0.582757432111, 6.713242567889)`. The LGS noise covariance has eigenvalues `(0.288, 0.288, 0.288, 1.63008)`; posterior covariance eigenvalues are `(0.3, 0.3, 0.799058823529)`. Thus the inverses/solves used by this supplied example are legitimate, and the noise/posterior matrices are valid covariance matrices.

For

`W = Sigma21 Sigma11^{-1}`, `b = mu2 - W mu1`,

`Omega = Sigma22 - Sigma21 Sigma11^{-1} Sigma12`,

the reconstructed marginal covariance and cross-covariance agree exactly at displayed machine precision; the marginal mean has maximum error `5.55e-17`. Direct block-conditioning formulas and the LGS formulas agree with maximum absolute error zero in this run.

With seed 2027:

- hidden truth: `(-0.980926505519, -0.275006600480, 1.892047023038)`;
- observation: `(-0.184130936233, -0.069737546573, -0.077779038282, 0.919187226273)`;
- exact posterior mean: `(-0.568086107743, 0.431913892257, 0.931913892257)`;
- each exact posterior SD: `0.682900388912`;
- posterior covariance has diagonal `0.466352941176` and off-diagonal `0.166352941176`.

The existing notebook's rounded answer keys match these actual computations to their printed precision.

## Sampling roles and interpretation

An author-side check drew 8,000 independent samples directly from the known conditional Gaussian, equal to the notebook's four chains × 2,000 retained draws in count only. The direct-draw call took approximately 0.00048 seconds in this process. This is not a controlled timing comparison with PyMC: that initial repository-environment check had no PyMC, and did not measure its compilation, warmup or sampling costs. The subsequent isolated measurements are given separately above.

For independent exact Gaussian draws, marginal mean Monte Carlo SE is `sqrt(Sigma_post[j,j]/8000) = 0.007635058457`. Observed mean discrepancies in those SE units were `(0.184, -1.322, -0.458)`; maximum covariance discrepancy was `0.00793046` (maximum standardized covariance discrepancy 1.433). This checks the distribution and sampling arithmetic without inventing PyMC output.

Once the conditional mean and covariance are known, a multivariate-normal generator samples the exact conditional law up to numerical implementation. Its sample means, covariances and violin plots still have Monte Carlo variability. The notebook's plot labelled “Exact linear-Gaussian posterior” is itself based on finite direct Gaussian draws; its analytic posterior parameters are exact within this model.

The PyMC branch instead invokes a generic posterior sampler with compilation/warmup, correlated draws and convergence/Monte Carlo error considerations. Matching the same analytic target is a useful check, but `kind="stats"` suppresses diagnostic reporting. The answer-key claim that remaining disagreement is Monte Carlo error cannot establish adequate sampling by itself; the isolated follow-up supplies author-side diagnostics for this run. Those checks must be repeated against the eventual publication environment. This does not require teaching an MCMC course inside L01.

All validity here is conditional on the given means/covariance and joint Gaussian model. No parameters are estimated; agreement of two computational routes does not check whether that model describes real incomplete measurements. The 7-dimensional supplied example is not evidence of a computational bottleneck.

## Smallest concrete runtime repair, without applying it

If the existing PyMC route is retained, the smallest direct-dependency repair is to declare the packages actually imported by the solved notebook: pandas, pymc, arviz-base and arviz-stats. xarray and numerical backend dependencies then enter transitively unless notebook code begins importing them directly. Monolithic arviz is additionally a direct dependency only if the separate worked Python source is also intended to remain executable unchanged.

Scratch resolution successfully solved the notebook's provisional pins `pymc==6.3.2`, `arviz-base==1.3.0`, `arviz-stats==1.3.2`, plus pandas, against existing NumPy 2.0.2 / SciPy 1.16.3 / Matplotlib 3.10.0 constraints on Python 3.12: 34 packages, 2.70 s. The scratch candidate selected pandas 3.0.6, pytensor 3.3.4 and xarray 2026.2.0. This confirms metadata-level resolvability of that subset only, **not** full repository lock compatibility, successful installation, working PyMC behavior, or suitability for Colab 2026.07. No baseline scientific pins need changing on this evidence. The metadata command issued a credentials-cache warning but completed successfully; see [dependency-resolution.log](dependency-resolution.log).

After the PyMC role is decided, the production repair should use `uv add` with justified course-target versions, regenerate the real lock, and run `uv sync --locked`; this assessment does not authorize or perform those changes. The notebook installer must be reconciled with the shared environment and hosted package availability so local checking does not silently install outside the lock. The minimal exploratory environment initially omitted Jinja2 needed by the ArviZ summary rich display; repository JupyterLab already supplies Jinja2 3.1.6, so this is not evidence that the repository manifest needs a new Jinja2 dependency. Pin any genuinely needed hosted installation cell consistently. Choose pandas against the actual hosted target rather than blindly accepting the latest scratch resolution.

Recommended instructor decision: make the exact conditional/LGS computation and different-query argument the core, with direct exact Gaussian draws available for generation/visualization; retain PyMC as a bounded comparison only if comparing computational routes is itself a desired learning outcome. Removing or relocating the currently required PyMC section changes notebook workload and requires explicit approval. Either decision leaves the analytic validity above intact. The accepted forward-marginal and generation direction still needs a detailed notebook handoff; this check does not redesign it.

## API source checks and remaining gates

The [official PyMC introductory documentation](https://www.pymc.io/projects/docs/en/stable/pymc-examples/examples/getting_started.html), headed PyMC 6.3.2 when inspected, supports DataTree as the expected result. The [official backend source](https://www.pymc.io/projects/docs/en/stable/_modules/pymc/backends/arviz.html) also constructs `DataTree`. Those documents support the draft's direction; they do not verify this model's actual variable names or result shapes. The old report's expected API wording is now supported by the isolated execution above; final repository/hosted validation remains outstanding. The [official ArviZ API](https://python.arviz.org/en/stable/api.html) describes its split libraries. No numerical or API run has been inferred from documentation; actual exploratory results are recorded above.

The isolated follow-up has checked actual `type(idata)`, posterior group/data variables, `x_unobserved` shape/order, summary columns/index order, `azb.extract` output type/dimensions, all plotting cells, diagnostics and mean/SD agreement on the scale of reported MCSE. Repeat these checks after repository environment repair; covariance differences were measured but not assigned a correlated-chain covariance MCSE. Run the existing source top-to-bottom with the repository executor (whose default clears outputs and executes a temporary directory copy). It writes successful execution evidence under ignored `build/notebooks/`; this bounded assignment did not run it because its installer would mutate the environment. Then validate the reconciled solved notebook, mechanically generate self-work, and perform a fresh hosted Colab 2026.07 CPU run before publication. Hosted access was not attempted here; its availability is unknown, separate from the demonstrated local dependency gap.

## Reproduction

From the repository root:

```bash
.venv/bin/python /tmp/l01-delivery-runtime/notebook-import-cell.py > /tmp/l01-delivery-runtime/import-failure.log 2>&1
.venv/bin/python /tmp/l01-delivery-runtime/check_analytic.py > /tmp/l01-delivery-runtime/analytic.log 2>&1
UV_CACHE_DIR=/tmp/l01-delivery-runtime/uv-cache uv pip compile /tmp/l01-delivery-runtime/notebook-requirements.in --python-version 3.12 --output-file /tmp/l01-delivery-runtime/resolved-candidate.txt > /tmp/l01-delivery-runtime/dependency-resolution.log 2>&1
```

Expected exits: import diagnostic 1; analytic check 0; scratch dependency resolution 0. Matplotlib fell back to a temporary `/tmp` cache because the home configuration directory was not writable; rendered plots succeeded. `MPLCONFIGDIR=/tmp/l01-delivery-runtime/matplotlib` may be set to avoid that environmental warning in repeated checks.

### Isolated follow-up reproduction

The exact package setup and locked sync were:

```bash
UV_CACHE_DIR=/tmp/l01-delivery-runtime/uv-cache uv add --project /tmp/l01-delivery-runtime/exploratory 'numpy==2.0.2' 'scipy==1.16.3' 'matplotlib==3.10.0' 'pymc==6.3.2' 'arviz-base==1.3.0' 'arviz-stats==1.3.2' pandas 'nbclient>=0.10,<0.11' 'nbformat>=5.10,<6' 'ipykernel>=6,<7'
UV_CACHE_DIR=/tmp/l01-delivery-runtime/uv-cache uv sync --project /tmp/l01-delivery-runtime/exploratory --locked
UV_CACHE_DIR=/tmp/l01-delivery-runtime/uv-cache uv add --project /tmp/l01-delivery-runtime/exploratory 'jinja2==3.1.6'
UV_CACHE_DIR=/tmp/l01-delivery-runtime/uv-cache uv sync --project /tmp/l01-delivery-runtime/exploratory --locked
JUPYTER_PATH=/tmp/l01-delivery-runtime/exploratory/jupyter MPLCONFIGDIR=/tmp/l01-delivery-runtime/exploratory/matplotlib PYTENSOR_FLAGS=base_compiledir=/tmp/l01-delivery-runtime/exploratory/pytensor-cache NUMBA_CACHE_DIR=/tmp/l01-delivery-runtime/exploratory/numba-cache /tmp/l01-delivery-runtime/exploratory/.venv/bin/python /tmp/l01-delivery-runtime/exploratory_execute.py > /tmp/l01-delivery-runtime/exploratory-execution.log 2>&1
```

The initial scratch project had `package = false` and Python `>=3.12,<3.13`. Its dedicated kernel spec points to the scratch interpreter; `exploratory_execute.py` uses kernel name `l01-exploratory`. Scratch paths in these commands are execution provenance; the linked logs, script and exploratory lock are the durable evidence to retain with this report.
