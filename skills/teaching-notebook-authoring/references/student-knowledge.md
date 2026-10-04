# Student knowledge state

This file records what notebook authors may reasonably assume students already know. Update it cumulatively as the course progresses.

The purpose is not to document the entire curriculum. It is to prevent two opposite authoring errors:

- quizzing students repeatedly on syntax or concepts already established;
- assuming fluency with new notation, APIs, packages, or computational idioms that have not yet been introduced.

Use three states:

1. **Assume familiar** — may normally be used without explicit scaffolding.
2. **Previously encountered — scaffold when needed** — students have seen this before, but notebook authors should not yet assume independent fluency.
3. **New / not yet established** — if required in a notebook, introduce it explicitly.

A construct does **not** move to "assume familiar" merely because it appeared once. Promotion should be deliberate and based on repeated use or an explicit course decision.

## Course-entry baseline

Students are first-year MSc students in Biomedical Engineering. They enter this course after:

- a mathematics-department probability course;
- an undergraduate Bayesian-first statistics course;
- practical use of PyMC and ArviZ;
- prior work with Bayesian inference, probabilistic programming, graphical models, MCMC, and HMC.

### Assume familiar at course entry

#### Probability and Bayesian reasoning

- random variables and probability distributions;
- conditional probability;
- Bayes' rule;
- expectation and variance;
- covariance and correlation at a basic level;
- prior, likelihood, posterior, and posterior predictive distributions;
- posterior uncertainty and interval summaries;
- Bayesian conditioning as updating information.

#### Statistical modeling

- basic regression modeling;
- the distinction between observed quantities, parameters, and deterministic model quantities;
- hierarchical modeling and partial pooling at a conceptual level;
- the idea of generative probabilistic models;
- graphical-model notation at a basic level.

#### PyMC / ArviZ concepts and older course idioms

- `pm.Model`;
- common scalar PyMC distributions;
- `observed=...`;
- `pm.Deterministic` at a basic level;
- `pm.sample` as the standard posterior-sampling operation;
- posterior draws and chains;
- basic ArviZ summaries and posterior plots;
- HDIs;
- the idea of a structured inference-results object;
- `InferenceData` as the representation used in their previous course.

Do **not** infer from this that the current PyMC/ArviZ return types and modular ArviZ 1.x APIs are familiar. Those changed after the previous course.

#### MCMC concepts

- why posterior sampling is used;
- Monte Carlo approximation;
- multiple chains;
- MCMC at a conceptual level;
- HMC/NUTS at a conceptual level;
- R-hat, ESS, divergences, and trace/mixing diagnostics at a basic practical level.

#### Python

- basic Python syntax;
- NumPy arrays and indexing;
- elementary NumPy arithmetic;
- matrix multiplication with `@`;
- basic Matplotlib plotting.

### Previously encountered — scaffold when needed at course entry

Students may have seen these, but authors should not assume effortless independent use:

- multivariate Gaussian distributions;
- covariance matrices beyond simple pairwise covariance;
- matrix dimension reasoning in nontrivial expressions;
- extracting and reshaping multivariate posterior samples;
- more advanced ArviZ operations;
- non-centered hierarchical parameterizations;
- LOO / ELPD / Pareto-$k$;
- interaction terms and more elaborate GLMs;
- Bambi formula syntax;
- posterior predictive diagnostics beyond the basic idea;
- creating a PyMC model object and re-entering its `with model:` context later to add additional variables, even if ordinary `with pm.Model():` construction is familiar.

### New / not yet established at course entry

Do not assume familiarity with:

- machine-learning libraries such as scikit-learn, PyTorch, or JAX unless introduced later;
- numerical linear-algebra idioms merely because they are standard to practitioners;
- arbitrary PyMC distributions or advanced APIs;
- PyTensor internals;
- missing-data mechanisms in PyMC;
- advanced coordinate/indexing patterns;
- tensor reshaping and broadcasting beyond ordinary NumPy use;
- `xarray.DataTree` as the current PyMC/ArviZ inference-results representation;
- the modular ArviZ 1.x packages and names such as `arviz_base`, `arviz_stats`, and `arviz_plots`;
- `arviz_base.extract`;
- `arviz_stats.summary` in its current modular form;
- `np.allclose` unless introduced in the notebook.

## Lecture 1: Probability, statistics, and Gaussian systems

### Assume familiar and reused

Authors may use without generic re-teaching:

- Bayesian conditioning and posterior reasoning;
- covariance/correlation at a basic level;
- NumPy arrays and slicing;
- matrix multiplication with `@`;
- `pm.Model` as a modeling container;
- ordinary observed PyMC variables;
- `pm.sample` as the operation used to draw posterior samples;
- the concept of posterior samples and basic summaries;
- basic plotting.

Do not assume the current return type of `pm.sample` is familiar merely because the function itself is familiar.

### Previously encountered — scaffold when needed

- multivariate Gaussian distributions;
- covariance matrices;
- matrix shape reasoning;
- manipulating multivariate posterior samples;
- extending an already-created PyMC model through a later model context.

### New in Lecture 1 / first notebook sequence

The lecture introduces or refreshes the mathematical material, and the notebook may apply it without derivation:

- partitioned multivariate Gaussian notation;
- covariance blocks $\Sigma_{11}$, $\Sigma_{12}$, $\Sigma_{21}$, $\Sigma_{22}$;
- conditional Gaussian mean and covariance;
- the Schur complement as conditional covariance;
- linear-Gaussian-system notation;
- exact posterior mean/covariance for a linear-Gaussian system.

Computational constructs likely new and deserving explicit scaffolding:

- `np.block`;
- `np.linalg.solve` as preferable to explicitly computing a matrix inverse;
- `np.allclose` if used for a numerical equivalence check;
- `pm.MvNormal` in a missing-data setting;
- PyMC handling of `np.nan` entries in observed data;
- `xarray.DataTree` as the current return container from `pm.sample` under the current PyMC/ArviZ stack;
- inspecting the groups and variables in that DataTree;
- `arviz_base.extract` for extracting/combining posterior samples;
- `arviz_stats.summary` for native posterior summaries;
- comparing a Monte Carlo multivariate posterior with an exact analytic Gaussian posterior.

## Maintenance after each notebook

After a notebook is finalized, produce a knowledge-state change report and update this file separately.

Typical transition:

`new` -> `previously encountered — scaffold when needed` -> `assume familiar`

Do not automatically advance the second transition.

For each later lecture or notebook sequence, record only concrete items that affect question design. Keep the file operational rather than encyclopedic.
