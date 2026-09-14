# ProbabilisticMachineLearning

Course-development repository for probabilistic machine learning.

## Notebook development

The student runtime is Google Colab; uv provides the reproducible local check
in the repository's standard `.venv`.

```text
uv sync --locked
uv run python scripts/execute_notebook.py Lectures/L01_Probability_Statistics/coin_model.ipynb --expect-file figures/coin_model__prior_likelihood_posterior.svg --expect-file figures/coin_model__sequential_updating.svg --expect-file figures/coin_model__posterior_predictive.svg --expect-file figures/coin_model__sampling_monte_carlo.svg
uv run jupyter lab
```

To intentionally regenerate the figures produced by the first notebook, run
the same notebook-check command with `--in-place` and review the resulting SVG
changes.

Before publishing a notebook, connect it to the course-target runtime through
the official Google Colab VS Code extension and run every cell from a fresh
hosted runtime. The current baseline is Colab `2026.07` on CPU.
