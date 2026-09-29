#set document(
  title: "Advanced Statistics 2027-1 — Lecture 1 coverage specification",
  author: "Opher Donchin / ChatGPT draft",
)
#set page(margin: 1.75cm)
#set text(size: 10.5pt)
#set heading(numbering: "1.1")

= Purpose

This is the current implementation plan for Lecture 1. It should guide revisions
to `slide_deck.typ` and the design of the associated one-hour student notebook.

The intellectual endpoint of the live lecture is a reusable inference operation:
Gaussian conditioning in a linear Gaussian system. The notebook then extends
that machinery to missing-value imputation using material from Murphy Book 1
that is not taught in detail during the live lecture.

The lecture should distinguish two operations throughout:

- *parameter estimation*: infer or choose model parameters from a dataset;
- *probabilistic inference*: infer an unknown variable conditional on observed
  variables and a model.

MLE and MAP belong to the first operation. Gaussian conditioning and missing
value imputation belong to the second.

= Audience and source assumptions

Students are first-year MSc Biomedical Engineering students with a mathematical
probability course and a Bayesian-first undergraduate statistics course. That
course already covered Bayesian inference, likelihood, priors and posteriors,
conjugacy, probabilistic programming, MCMC/HMC, linear models, GLMs, and
Bayesian workflow. Lecture 1 should reactivate familiar material rather than
reteach it from scratch.

Primary source coverage:

- Murphy Book 1, Chapter 1: machine-learning framing and examples, used
  selectively.
- Murphy Book 1, §§2.1--2.6: probability review, moments, and familiar
  distributions, used selectively.
- Murphy Book 1, §§3.1--3.3: covariance, multivariate Gaussians, conditioning,
  missing-value imputation, and linear Gaussian systems.
- Murphy Book 1, §§4.1--4.2 and §4.6: likelihood, MLE, and MAP, used as review
  and connection rather than as a full estimation lecture.
- Murphy Book 2, Chapter 1 and §2.3: probabilistic-ML framing and Gaussian joint /
  linear Gaussian material as supplemental sources.

Exponential-family theory, general sufficient-statistic theory, moment matching,
exchangeability, empirical Bayes, and model averaging are not part of the
current live Lecture 1 plan. Their later placement should be decided when the
surrounding lectures are designed.

= Three-hour structure

The weekly meeting has two linked components:

- approximately two hours of live lecture;
- approximately one hour of student self-work in a Colab-first notebook.

The self-work is a design constraint on the lecture. The live lecture should
prepare students to use Gaussian conditioning; the notebook should make them
apply and extend it rather than simply repeat an in-class derivation.

A working time budget is:

- existing machine-learning framing and task material: about 55--65 minutes;
- statistics, estimation, and Gaussian inference: about 55--65 minutes;
- student self-work: about 60 minutes.

If the live material exceeds this budget, prefer moving algebraic derivations to
recorded support or reserve material rather than weakening the Gaussian
conditioning endpoint.

= Live Lecture 1 arc

The reviewed opening of the current deck establishes the modeling language and
moves from statistics to machine-learning problems, task taxonomies, datasets,
and probabilistic queries. The remainder should be organized around the
following arc.

== 1. Statistics, moments, and estimators

Goal: connect population quantities, functions of random variables, and
functions of observed data.

Core ideas:

- expectation and variance as population moments;
- conditional expectation where it directly supports later conditioning;
- covariance as the multivariate second-moment object;
- a statistic as a function of the observed sample;
- an estimator as a statistic used to estimate a model parameter;
- sample mean, variance, and covariance as familiar estimators.

Do not make "same summaries, different structure" an isolated warning. If used,
it should support the distinction between a summary statistic and the full data,
not open a separate sufficient-statistics unit.

== 2. MLE and MAP

Goal: reactivate estimation language the students already know and connect it to
the Gaussian parameters used later.

Core equations:

$
hat(theta)_"MLE" = arg max_theta p(D | theta)
$

$
hat(theta)_"MAP" = arg max_theta p(theta | D)
= arg max_theta p(D | theta) p(theta)
$

Use one or two familiar examples, with the Gaussian as the main bridge. The
important live result is that fitting a Gaussian estimates its location and
spread from data. Long derivative calculations are optional recorded support,
not a requirement of the live lecture.

MAP should remain light: it is included to connect the Bayesian background to
point estimation, not to start a general regularization unit.

== 3. Gaussian distributions

Goal: establish the univariate Gaussian as the simplest case whose parameters,
moments, and estimators will generalize cleanly.

Emphasize:

- mean and variance;
- estimated versus assumed parameters;
- affine transformations when they prepare the multivariate case.

== 4. Multivariate Gaussians

Goal: move from scalar uncertainty to joint uncertainty.

Core ideas:

- mean vector and covariance matrix;
- covariance as geometry and dependence;
- affine transformations:
  $Y = A X + b$,
  $E[Y] = A mu + b$,
  $"Cov"[Y] = A Sigma A^T$;
- Gaussian marginals;
- Gaussian conditionals.

The conditioning formula is central. Students should understand the block
partition into observed and unknown components and what the conditional mean
and covariance mean, even if matrix-algebra derivations are omitted.

== 5. Linear Gaussian systems

Goal: combine the preceding material into the first reusable inference machine.

Canonical form:

$
z tilde cal(N)(mu_z, Sigma_z)
$

$
y | z tilde cal(N)(W z + b, Sigma_y)
$

The joint distribution is Gaussian, so posterior inference about $z$ given $y$
is Gaussian conditioning. Sensor fusion is a useful live example because it
makes the role of relative uncertainty visible.

The lecture should end with this operational message:

- estimation supplies or learns the model parameters;
- the fitted/assumed joint Gaussian supplies a distribution over variables;
- conditioning turns observations into a distribution over unknown quantities.

= Student self-work: Gaussian missing-value imputation

The one-hour notebook should be based directly on Murphy Book 1 §3.2.5 and the
associated ProbML notebook
`notebooks/book1/03/gauss_imputation_known_params_demo.ipynb`.

Reproducing the book example is acceptable and desirable here because the
notebook extends into a section not taught in detail during the live lecture.
Using the book example reduces implementation risk and gives both students and
instructors a known reference point.

== Core task

Students work with partially observed multivariate Gaussian data. Given known
$mu$ and $Sigma$, they:

1. identify observed and missing components;
2. partition the mean vector and covariance matrix accordingly;
3. compute the conditional Gaussian for the missing values;
4. use the conditional mean as an imputation;
5. inspect how the conditional covariance represents remaining uncertainty.

The notebook should preserve a clear distinction between a point imputation and
the conditional distribution that justifies it.

== Extension

If time permits, add one modest extension that connects back to the estimation
part of the lecture:

- provide a complete training sample;
- estimate $hat(mu)$ and $hat(Sigma)$ from the training data;
- use those estimates for imputation on partially observed cases.

This makes the workflow explicit:

$
D_"train" arrow (hat(mu), hat(Sigma))
arrow p(x_"miss" | x_"obs", hat(mu), hat(Sigma))
$

A second possible extension is to vary which entries are observed and ask
students to predict how the conditional uncertainty should change before they
run the calculation.

Do not turn the notebook into a general missing-data lecture. Missingness
mechanisms, EM with unknown parameters, and MAR/MNAR theory are outside this
one-hour exercise.

= Implementation guidance for the current deck

Treat the existing material after the reviewed machine-learning framing as
revisable source, not as a sequence that must be preserved.

In particular:

- integrate moments, covariance, estimators, MLE, and MAP into one coherent
  statistical bridge;
- keep the strongest existing Gaussian geometry, marginalization, conditioning,
  and linear-Gaussian material where it serves the new arc;
- do not retain standalone categorical/multinomial/softmax, empirical
  distribution, missing-values, or other sections merely because they already
  exist;
- missing-value imputation belongs primarily in the student notebook, with at
  most a short live bridge from Gaussian conditioning;
- the live endpoint is linear Gaussian inference, not exponential-family theory.

The slide deck remains concept-first: one conceptual move per slide, modest
equation density, and meaningful speaker notes. Long derivations belong in
recorded support, reserve slides, or the notebook when computation is the point.

= Completion criteria

Before Lecture 1 is considered ready:

- the two-hour live deck has a plausible timed run;
- the student notebook can be completed in about one hour;
- the notebook runs from a fresh Colab runtime;
- the transition from MLE/MAP to Gaussian parameterization is explicit;
- the distinction between parameter estimation and probabilistic inference is
  explicit;
- students reach Gaussian conditioning before the live lecture ends;
- the self-work actually uses Gaussian conditioning for missing-value
  imputation;
- the deck and notebook are visually and mechanically checked according to
  `Lectures/README.md` and `AGENTS.md`.
