# ProbabilisticMachineLearning

Course-development repository for probabilistic machine learning.

## Notebook development

The student runtime is Google Colab; uv provides the reproducible local check
in the repository's standard `.venv`.

```text
uv sync --locked
uv run python scripts/execute_notebook.py Lectures/L01_Probability_Statistics/coin_model.ipynb --expect-file figures/coin_model__prior_likelihood_posterior.svg --expect-file figures/coin_model__sequential_updating.svg --expect-file figures/coin_model__posterior_predictive.svg --expect-file figures/coin_model__sampling_monte_carlo.svg
uv run python scripts/execute_notebook.py Lectures/L01_Probability_Statistics/task_examples_figures.ipynb --expect-file figures/task_examples_figures__prediction_iris_logistic.svg --expect-file figures/task_examples_figures__generation_vae_samples.png --expect-file figures/task_examples_figures__discovery_gmm_clusters.svg
uv run jupyter lab
```

To intentionally regenerate the figures produced by a notebook, run the same
notebook-check command with `--in-place` and review the resulting figure
changes.

`task_examples_figures.ipynb` also pulls in `scikit-learn` and a CPU build of
`torch`, on top of the NumPy/SciPy/Matplotlib baseline used by
`coin_model.ipynb`; both are pinned in `pyproject.toml` (`torch` resolves from
the `pytorch-cpu` extra index configured in `[tool.uv.sources]`).

Before publishing a notebook, connect it to the course-target runtime through
the official Google Colab VS Code extension and run every cell from a fresh
hosted runtime. The current baseline is Colab `2026.07` on CPU.
