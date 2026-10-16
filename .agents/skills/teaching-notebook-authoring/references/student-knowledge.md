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

**Prospective authoring contract, revised 2026-10-16.** The instructor removed PyMC entirely from L01. The exact-only solved/student pair has passed local validation; hosted execution and learner time remain pending. No class has been taught, so this section does not advance actual student knowledge. The course-entry baseline above, including prior-course package experience, is unchanged.

### Assume familiar and reused

- Bayesian conditioning, expectation and posterior uncertainty;
- covariance/correlation at a basic level;
- matrix algebra, NumPy arrays/slicing and `@`;
- basic plotting.

No new construct is promoted to independent fluency after one notebook.

### Previously encountered — scaffold when needed

At entry, retain support for multivariate Gaussians, covariance matrices and nontrivial matrix shapes. Live lecture results are supplied for application rather than re-proved in the notebook.

### New in Lecture 1 / first notebook sequence

Introduce or scaffold:

- partitioned Gaussian notation, covariance blocks, exact conditional mean/covariance and conditional covariance as a Schur complement;
- exact conditional distribution versus a loss-selected action; the vector squared-loss identity, conditional-mean action and minimum conditional model risk; expected versus realized loss;
- explicit joint-to-LGS notation mapping and `W`, `b`, `Omega`, followed by forward marginal moments;
- old-case conditioning, a specified-state observation law, and the before-observation fresh-case marginal;
- `np.linalg.solve` with vector/matrix right-hand sides and the symmetry/transpose route for a right-side inverse product;
- `np.diag`, marginal SDs, normal quantiles and individual intervals versus simultaneous coverage;
- `np.trace` for total conditional variance;
- one fresh unconditional state and independent noise vector using `rng.multivariate_normal`, followed by the direct LGS vector equation.

`np.block` and `np.allclose` are explained in supplied code. Spectral checks, assertion APIs and the affine-generator population check remain supplied author verification; do not infer independent fluency. Plotting and arbitrary covariance/data construction are supplied infrastructure. No inference-package API or comparison is part of this L01 route.

After actual completion, these new practiced constructs may move to “previously encountered — scaffold when needed”; supplied checking APIs still require support. The [notebook knowledge-change report](../../../../InClass/Preparation/lecture1_missing_data_knowledge_change_report.md) specifies that prospective transition. Model fitting, empirical model validation, uncontrolled missingness, simultaneous regions, physical/causal identification and advanced batching remain unestablished by this notebook.

## Maintenance after each notebook

After a notebook is finalized, produce a knowledge-state change report and update this file separately.

Typical transition:

`new` -> `previously encountered — scaffold when needed` -> `assume familiar`

Do not automatically advance the second transition.

For each later lecture or notebook sequence, record only concrete items that affect question design. Keep the file operational rather than encyclopedic.
