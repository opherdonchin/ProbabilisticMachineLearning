# Student knowledge state

This file records what notebook authors may reasonably assume students already know. Update it cumulatively as the course progresses.

The purpose is not to document the entire curriculum. It is to prevent two opposite authoring errors:

- quizzing students repeatedly on syntax or concepts already established;
- assuming fluency with new notation, APIs, packages, or computational idioms that have not yet been introduced.

When uncertain whether a construct is familiar, scaffold it rather than assume it.

## Course-entry background

Students are first-year MSc students in Biomedical Engineering.

They enter this course with:

- a mathematics-department probability course;
- an undergraduate Bayesian-first statistics course;
- experience with Bayesian inference and probabilistic modeling;
- experience using PyMC/ArviZ for Bayesian analysis;
- prior exposure to graphical models, MCMC, and HMC.

For notebook authoring, therefore:

- treat routine Bayesian conditioning and posterior reasoning as familiar;
- treat routine PyMC model construction and sampling as broadly familiar;
- do not assume familiarity with every PyMC distribution, missing-data mechanism, advanced coordinate pattern, or recently introduced API;
- do not assume familiarity with machine-learning libraries or numerical linear-algebra idioms merely because they are standard to practitioners.

## Lecture 1: Probability, statistics, and Gaussian systems

### Mathematical notation/concepts established in lecture

Authors may rely on the lecture introducing or refreshing:

- partitioned multivariate Gaussian notation;
- covariance blocks $\Sigma_{11}$, $\Sigma_{12}$, $\Sigma_{21}$, $\Sigma_{22}$;
- marginal and conditional Gaussian distributions;
- conditional mean and covariance;
- the Schur complement as the remaining conditional covariance;
- linear-Gaussian-system notation;
- posterior mean/covariance for a linear-Gaussian system.

These equations should normally be **applied** in the notebook rather than re-derived.

### Computational constructs that may be new and deserve scaffolding

Unless already established earlier in the notebook, treat these as potentially unfamiliar:

- `np.block` for assembling block matrices;
- `np.linalg.solve` as preferable to explicitly computing a matrix inverse;
- shape reasoning for block-matrix operations;
- `pm.MvNormal` in a missing-data setting;
- PyMC's handling of missing entries through `np.nan` in observed data;
- extracting and comparing a multivariate posterior sample with an exact analytic Gaussian posterior.

### Computational constructs that need not be re-taught generically

Assume broad familiarity with:

- `numpy` arrays and elementary arithmetic;
- basic Matplotlib plotting;
- `pm.Model`;
- common scalar PyMC random variables;
- `pm.sample`;
- the idea of posterior samples and posterior summaries.

If a notebook uses one of these in a substantively new way, scaffold the new use rather than quiz the generic syntax.

## Maintenance format for later lectures

Append a section for each lecture or notebook sequence with three headings:

### Mathematical notation/concepts established

What later notebooks may treat as conceptually available.

### Computational constructs newly introduced

APIs, packages, array/tensor operations, plotting idioms, or model-building patterns first taught here.

### Computational constructs now assumed familiar

Items that future notebooks should normally stop quizzing explicitly.

Keep entries concrete enough to guide question granularity.
