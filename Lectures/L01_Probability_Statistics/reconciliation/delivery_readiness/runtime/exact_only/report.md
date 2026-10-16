# L01 exact-only notebook — integration validation

**Local status: passed, 2026-10-16.** Implements the instructor's removal of PyMC entirely. This is technical/pedagogical authoring validation of the current draft, not complete Scope approval, measured one-hour workload or hosted Colab readiness.

## Current artifacts and review

The canonical worked source, structured handoff, solved Q&A, mechanically generated student version, authoring report and prospective knowledge-change report are under `InClass/`. Exact source/output hashes and structural counts are in [canonical validation](canonical_validation.json). The same seven-dimensional known model and original observation are preserved as fixed full-precision data. Fresh generation has a separate seed and no numerical answer-key assertion. [Portability check](reference_case_portability.txt) records the fixed case's equality to the reference NumPy 2.0.2 seed-2027 draw.

The worked-solution specialist validated the technical route before the separate teaching-notebook specialist authored Q&A. The coordinator integrated their sources, checked question/answer context and mechanically generated the student file using the repository transformer. A separate Scope specialist performed a [bounded feasibility review](notebook_feasibility_review.md); this was not blind because that reviewer drafted the notebook Scope handoff. No material mathematical or scaffolding issue was found. Author and coordinator inspected all three inline figures; labels, legends and data are readable. No image asset or local data file is required by the notebook.

The solved source has 69 cells, 18 immediate question/solution pairs, 17 executable code cells and three inline figures. The student version preserves every question/given cell and replaces exactly nine code answers and nine prose/math answers; outputs and execution counts are clear. Its incomplete placeholders are not claimed to execute as a solved notebook. The active notebook contains no removed-package content, installer, local path, external asset dependency or forced backend. Central conditional solves, squared-loss risk, LGS parameters, forward moments and one-case generation remain visible.

## Reproducible local commands

The repository environment passed `uv sync --locked`; no manifest, lock or package pin changed. [Runtime versions](runtime_versions.txt): Python 3.12.13, NumPy 2.0.2, SciPy 1.16.3, Matplotlib 3.10.0.

```bash
MPLCONFIGDIR=/tmp/l01-exact-mpl UV_CACHE_DIR=/tmp/l01-exact-uv-cache \
  uv run --locked python InClass/Preparation/lecture1_missing_data_worked_solution.py
UV_CACHE_DIR=/tmp/l01-exact-uv-cache uv run --locked python \
  scripts/make_self_work_notebook.py InClass/Solutions/lecture1_missing_data.ipynb \
  InClass/lecture1_missing_data.ipynb
IPYTHONDIR=/tmp/l01-exact-ipython MPLCONFIGDIR=/tmp/l01-exact-mpl \
  UV_CACHE_DIR=/tmp/l01-exact-uv-cache uv run --locked python \
  scripts/execute_notebook.py InClass/Solutions/lecture1_missing_data.ipynb
```

The cache overrides merely give this restricted authoring container writable caches. The notebooks contain none of these paths. The first canonical execution passed with an IPython cache fallback warning; the final identical-source run used the explicit writable cache and had no warnings. An initial parent structural-check invocation used system Python and lacked `nbformat`; rerunning that check in the required uv environment passed. These one-off diagnostic invocations are not new dependencies or course tests. Neither event changed source or dependencies.

[Worked stdout](worked_execution.txt), [canonical executor stdout](notebook_execution.txt) and [notebook numerical outputs](numerical_outputs.txt) are actual captures. The official executor clears all prior state and executes from a temporary copy. Its current executed notebook is at ignored `build/notebooks/InClass/Solutions/lecture1_missing_data.executed.ipynb` and its exact hash is recorded. The supplied notebook assertions check SPD/shape/covariance reduction, block/LGS identity, minimum risk, original forward moments and algebraic generator population moments. Fresh realized values are illustrative, not population checks. No synthetic benchmark or second student inference implementation was added.

## Remaining delivery gates

- Author estimate **55–75 minutes**, subjective and unmeasured. A representative learner trial must include reading, supplied cells and interpretation. If it overruns, return consequential reductions to Scope/instructor.
- A fresh hosted **Colab 2026.07 CPU** Restart/Run All through the official VS Code extension is still required before publication. No hosted execution occurred in this pass; local execution is not described as Colab validation.
- Complete Scope and workload acceptance remain separate. The narrow prospective L01 knowledge reference and planned-map notebook cell reflect the new route; no class or student learning is recorded as completed.

The older sibling runtime report retains identifiable evidence for its exact pre-removal source; it is not current notebook validation.
