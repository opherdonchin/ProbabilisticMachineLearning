# Example: decomposing the Lecture 1 Gaussian missing-data solution

This reference illustrates intended **question granularity, notation management, and current-library scaffolding**. It is not a substitute for the actual Lecture 1 notebook and should not be copied mechanically when the worked solution changes.

## Worked-solution path

The technical solution is:

1. define a joint Gaussian vector $x=(x_1,x_2)$ with known $\mu$ and $\Sigma$;
2. generate one complete observation;
3. hide $x_1$ and retain $x_2$ as observed;
4. infer the missing block with PyMC;
5. rewrite the same joint Gaussian as a linear-Gaussian system (LGS) with latent $z=x_1$ and observation $y=x_2$;
6. use the lecture's LGS posterior equations to compute the exact posterior mean and covariance;
7. display and compare the sampled and exact posteriors.

The teaching-notebook author should unpack this path, not invent a different solution.

## Give the synthetic construction as setup

The compound-symmetry covariance model is an author-created device for generating a controlled example, not a central Lecture 1 learning objective.

Provide one coherent setup block that:

- defines $x_1=(x_{11},x_{12},x_{13})^T\in\mathbb R^3$;
- defines $x_2=(x_{21},x_{22},x_{23},x_{24})^T\in\mathbb R^4$;
- gives $\mu_1$ and $\mu_2$;
- explains $\sigma_1,\sigma_2,\rho_1,\rho_2,\kappa$;
- gives the formulas for $\Sigma_{11}$, $\Sigma_{22}$, $\Sigma_{12}$ and $\Sigma_{21}$;
- supplies code constructing the four covariance blocks.

Begin numbered student work after those blocks exist.

## Early questions should use coherent local units

### Block dimensions

**Question:** The setup defines $x_1\in\mathbb R^3$ and $x_2\in\mathbb R^4$. What are the shapes of $\Sigma_{11}$, $\Sigma_{12}$, $\Sigma_{21}$ and $\Sigma_{22}$?

### One concrete covariance-and-correlation question

Do not split the normalization into a second numbered item.

**Question:** Using the supplied cross-covariance formula, calculate $\operatorname{Cov}(X_{11},X_{21})$ and then the corresponding $\operatorname{Corr}(X_{11},X_{21})$.

### Assemble and check the full covariance matrix

Give the API by name and ask for the task-specific construction plus its immediate sanity check.

**Question:** Using `np.block`, construct

$$
\Sigma=\begin{pmatrix}
\Sigma_{11}&\Sigma_{12}\\
\Sigma_{21}&\Sigma_{22}
\end{pmatrix},
$$

print its shape, and check that the dimensions make sense from $x_1\in\mathbb R^3$ and $x_2\in\mathbb R^4$.

Do not split function identification, matrix construction and shape checking into separate questions.

## Connect the concrete problem to the lecture's task schema

Before asking for $p(x_1\mid x_2)$, re-establish the relevant lecture framing.

For example, reproduce the lecture's generic forms:

$$
\text{prediction: } p_D(y_*\mid x_*),
\qquad
\text{discovery: } p_D(z_*\mid x_*),
$$

where the lecture includes a missing value among possible latent $z$ variables.

Then use two questions:

1. **Which task class describes reconstructing an unobserved part of the vector from the observed part?**
2. **Map the generic variables to this example and write the specific probability query.**

In the controlled known-Gaussian example, the final query is

$$
p(x_1\mid x_2,\mu,\Sigma).
$$

This preserves the connection between the notebook and the lecture taxonomy instead of introducing a conditional distribution without context.

## Treat current PyMC behavior as new when it changed after the prior course

Students used PyMC and ArviZ previously, but the current course stack may differ from what they learned.

For unfamiliar library-specific behavior, provide official documentation rather than asking students to guess.

For missing values, point students to the current PyMC introductory documentation that explains automatic imputation of masked/NaN observed values. Ask them to use that source to answer what happens when `np.nan` values are passed to an observed random variable.

## Scaffold extension of an existing model

Ordinary `pm.Model` construction is familiar, but extending an already-created model in a later context may not be.

A useful pattern is:

```python
coords = {"component": component_names}
model = pm.Model(coords=coords)
```

Then explain as **[GIVEN]** that re-entering

```python
with model:
    ...
```

adds new PyMC variables to the existing model.

Ask students to extend the supplied model with the task-specific `pm.MvNormal` rather than making them reconstruct unrelated boilerplate.

## Use the current inference-results representation

Sample into a variable named `idata`, then ask students to inspect:

```python
type(idata)
```

and the variables in the `posterior` group.

The current PyMC/ArviZ stack uses `xarray.DataTree`, whereas students previously encountered `InferenceData`. Treat that change as new course knowledge rather than assuming continuity from the old API.

Do not add a separate question asking how many values one draw of the missing variable contains unless that fact serves a later conceptual need.

## Prefer native ArviZ operations

Do not manually reshape chain/draw arrays merely to get posterior samples.

Prefer:

```python
arviz_base.extract(...)
```

for sample extraction and

```python
arviz_stats.summary(...)
```

for posterior means, standard deviations, intervals and diagnostics.

If a later comparison needs the actual sample array, extract it through ArviZ first and only then use NumPy for a calculation that ArviZ does not directly provide.

## Manage the Gaussian-to-LGS notation transition explicitly

The partitioned-Gaussian section uses

$$
(x_1,x_2),\quad
(\mu_1,\mu_2),\quad
\Sigma_{11},\Sigma_{12},\Sigma_{21},\Sigma_{22}.
$$

The LGS section uses

$$
z,\quad y,\quad \mu_z,\quad \Sigma_z,\quad W,\quad b,\quad \Omega.
$$

Before doing LGS calculations, ask students to establish the mapping

$$
z=x_1,
\qquad
y=x_2,
\qquad
\mu_z=\mu_1,
\qquad
\Sigma_z=\Sigma_{11}.
$$

Then explicitly say that the notebook is switching to **LGS notation** for the next block.

### Identify $W$ and $b$ clearly

Use the conditional Gaussian observation model

$$
E[x_2\mid x_1]
=\mu_2+\Sigma_{21}\Sigma_{11}^{-1}(x_1-\mu_1)
$$

and ask students to rewrite it in the LGS form

$$
E[y\mid z]=Wz+b.
$$

This gives

$$
W=\Sigma_{21}\Sigma_{11}^{-1},
\qquad
b=\mu_2-W\mu_1.
$$

### Make $\Omega$ student work

Use two questions:

1. write, in Markdown math, the conditional covariance of $x_2\mid x_1$ and identify it with $\Omega$;
2. use `np.linalg.solve` to implement that expression in code.

The answer is

$$
\Omega
=\Sigma_{22}-\Sigma_{21}\Sigma_{11}^{-1}\Sigma_{12}.
$$

### Verify the translation once, in LGS notation

After $W,b,\Omega$ exist, remain in LGS notation and compute

$$
m=W\mu_z+b,
\qquad
S=W\Sigma_zW^T+\Omega.
$$

Give `np.allclose` by name and ask students to verify

$$
m=\mu_2,
\qquad
S=\Sigma_{22}.
$$

This check confirms that the LGS observation marginal reproduces the original $x_2$ marginal. Do not repeatedly alternate notation after this point.

## Use lecture terminology only when it is actually present

Lecture 1 explicitly calls the observed deviation an **innovation**. Under the partitioned-Gaussian notation it is

$$
x_2-\mu_2,
$$

and under the LGS mapping it is the same quantity written

$$
y-m.
$$

If the term is used in the notebook, remind students of this equivalence at the notation transition rather than introducing it as unexplained new jargon.

## Exact posterior section

Supply the lecture LGS equations and ask students to implement them:

$$
\mu_{z\mid y}
=\mu_z+\Sigma_zW^TS^{-1}(y-m),
$$

$$
\Sigma_{z\mid y}
=\Sigma_z-\Sigma_zW^TS^{-1}W\Sigma_z.
$$

Use `np.linalg.solve` in code instead of explicit inverses.

After calculation, simply display the exact posterior mean, covariance and marginal SDs. Do not manufacture extra questions about obvious consequences unless they test an important misconception.

## Comparison section

Keep the comparison short.

Use native ArviZ summaries for the PyMC posterior and compare them with the exact LGS mean/SD. Display the two posterior plots with the same visual grammar.

Do not automatically add:

- a prediction that the two methods should agree;
- a separate question about Monte Carlo convergence with more samples;
- posterior-correlation calculations;
- generic interpretation questions.

Add such material only if it serves a specific learning objective.

## What not to ask here

Avoid:

- questions that require setup facts not supplied beforehand;
- line-by-line reconstruction of the synthetic covariance generator;
- separate questions for covariance and its immediately related correlation when one coherent calculation is enough;
- separate "which function?" and "now use the function" questions when one task-specific coding prompt is enough;
- library-behavior questions without a supplied documentation source or example;
- manual chain/draw reshaping when native ArviZ extraction exists;
- manual posterior summaries when native ArviZ summaries exist;
- casual back-and-forth between $(x_1,x_2)$ notation and $(z,y)$ notation;
- generic prompts such as "Interpret the posterior";
- prediction questions inserted mechanically before routine computations;
- re-teaching generic `pm.sample` syntax while ignoring meaningful changes in the object it now returns.
