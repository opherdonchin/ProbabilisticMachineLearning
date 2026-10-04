# Example: decomposing the Lecture 1 Gaussian missing-data solution

This reference illustrates the intended **question granularity and sequencing**. It is not a substitute for the actual Lecture 1 notebook and should not be copied mechanically when the worked solution changes.

## Worked-solution path

The technical solution has the following structure:

1. Define a joint Gaussian vector $x=(x_1,x_2)$ with known $\mu$ and $\Sigma$.
2. Generate one complete observation.
3. Hide $x_1$ and retain $x_2$ as observed.
4. Infer $p(x_1\mid x_2,\mu,\Sigma)$ with PyMC.
5. Rewrite the same joint Gaussian as a linear-Gaussian system with latent $z=x_1$ and observation $y=x_2$.
6. Use the lecture's linear-Gaussian posterior equations to compute the exact posterior mean and covariance.
7. Plot the PyMC and exact posteriors with the same graphical grammar.
8. Compare them directly.

The teaching-notebook author should **unpack this path**, not invent a different one.

## Important setup decision

The particular compound-symmetry covariance construction used in the worked solution is an author-created device for producing a controlled example. It is not itself a central Lecture 1 learning objective.

Therefore do **not** begin by asking students to reconstruct the covariance model line by line.

Instead, provide one coherent given setup block that:

- states $x_1=(x_{11},x_{12},x_{13})^T\in\mathbb R^3$;
- states $x_2=(x_{21},x_{22},x_{23},x_{24})^T\in\mathbb R^4$;
- gives $\mu_1$ and $\mu_2$;
- explains the covariance construction and what $\sigma_1,\sigma_2,\rho_1,\rho_2,\kappa$ mean;
- gives the formulas for $\Sigma_{11}$, $\Sigma_{22}$, and $\Sigma_{12}$;
- supplies the code that constructs the four covariance blocks;
- generates the complete observation and splits it into hidden $x_1$ and observed $x_2$.

Students can simply run that block.

Then ask questions about the mathematical objects the setup created.

## Example early sequence

### Given setup

For example, visibly establish:

$$
x_1=(x_{11},x_{12},x_{13})^T\in\mathbb R^3,
\qquad
x_2=(x_{21},x_{22},x_{23},x_{24})^T\in\mathbb R^4.
$$

Use the supplied covariance construction

$$
\Sigma_{11}=\sigma_1^2[(1-\rho_1)I_3+\rho_1J_3],
$$

$$
\Sigma_{22}=\sigma_2^2[(1-\rho_2)I_4+\rho_2J_4],
$$

$$
\Sigma_{12}=\kappa\sigma_1\sigma_2\sqrt{\rho_1\rho_2}\,\mathbf 1_3\mathbf 1_4^T,
\qquad
\Sigma_{21}=\Sigma_{12}^T.
$$

Use the worked-solution values

$$
\sigma_1=1,
\quad
\sigma_2=1.2,
\quad
\rho_1=0.70,
\quad
\rho_2=0.80,
\quad
\kappa=0.90.
$$

Provide the code that creates these blocks and the simulated observation.

### Question: dimensions

**Question:** The setup defines $x_1\in\mathbb R^3$ and $x_2\in\mathbb R^4$. What are the shapes of $\Sigma_{11}$, $\Sigma_{12}$, $\Sigma_{21}$, and $\Sigma_{22}$?

**Answer:**

- $\Sigma_{11}$ is $3\times3$;
- $\Sigma_{12}$ is $3\times4$;
- $\Sigma_{21}$ is $4\times3$;
- $\Sigma_{22}$ is $4\times4$.

### Question: concrete cross-covariance

**Question:** Using the supplied formula for $\Sigma_{12}$, calculate $\operatorname{Cov}(X_{11},X_{21})$ for the parameter values above.

**Answer:**

Every entry of $\Sigma_{12}$ is

$$
\kappa\sigma_1\sigma_2\sqrt{\rho_1\rho_2}
=0.90(1)(1.2)\sqrt{0.70\cdot0.80}
\approx0.808.
$$

Therefore

$$
\operatorname{Cov}(X_{11},X_{21})\approx0.808.
$$

### Question: corresponding correlation

**Question:** What is the corresponding correlation between $X_{11}$ and $X_{21}$?

**Answer:**

$$
\operatorname{Corr}(X_{11},X_{21})
=\frac{0.808}{(1)(1.2)}
\approx0.674.
$$

### Question: assemble the full covariance matrix

Do not split API recognition from implementation unless API recognition matters by itself.

**Question:** Using `np.block`, construct

$$
\Sigma=
\begin{pmatrix}
\Sigma_{11}&\Sigma_{12}\\
\Sigma_{21}&\Sigma_{22}
\end{pmatrix}
$$

from the four covariance blocks already defined.

**Answer:**

```python
Sigma = np.block([
    [Sigma11, Sigma12],
    [Sigma21, Sigma22],
])
```

## Asking about supplied code after it appears

It is valid to give the complete setup code and then ask students to read it.

For example, after supplying

```python
x_complete = rng.multivariate_normal(mean=mu, cov=Sigma)
x1_true = x_complete[:n1]
x2_obs = x_complete[n1:]
```

ask:

**Question:** Which part of `x_complete` is being treated as missing, and which part remains observed?

**Answer:** The first three entries are stored as `x1_true` and will be hidden; the final four entries are stored as `x2_obs` and remain observed.

This is preferable to asking students to invent the simulation setup when the simulation itself is not the learning objective.

## Connect PyMC to the probability target

**Question:** After hiding $x_1$ and observing $x_2$, what probability distribution are we asking PyMC to sample from?

**Answer:**

$$
p(x_1\mid x_2,\mu,\Sigma).
$$

The students know ordinary observed PyMC variables, but this missing-data use is new.

**Question:** In the supplied vector `x_partial`, the missing entries are represented by `np.nan`. When `x_partial` is passed as `observed` to `pm.MvNormal`, what does PyMC do with those entries?

**Answer:** PyMC treats the `np.nan` positions as unobserved components and samples them conditional on the observed components.

Then ask students to construct the task-specific `pm.MvNormal` model if that coding step is useful, while supplying routine `pm.sample` boilerplate.

## Map the same problem into the lecture's LGS notation

**Question:** In the lecture's linear-Gaussian system

$$
z\sim\mathcal N(\mu_z,\Sigma_z),\qquad y\mid z\sim\mathcal N(Wz+b,\Omega),
$$

which variables in our missing-data problem should play the roles of $z$ and $y$?

**Answer:** Set $z=x_1$ and $y=x_2$.

**Question:** The lecture gives

$$
E[x_2\mid x_1]
=\mu_2+\Sigma_{21}\Sigma_{11}^{-1}(x_1-\mu_1).
$$

Comparing this with $E[y\mid z]=Wz+b$, what are $W$ and $b$?

**Answer:**

$$
W=\Sigma_{21}\Sigma_{11}^{-1},
\qquad
b=\mu_2-W\mu_1.
$$

For the implementation, give the relevant API in the question rather than asking trivia about its name:

**Question:** Use `np.linalg.solve(A, B)` to compute $A^{-1}B$ without explicitly forming an inverse. Use it to construct $W=\Sigma_{21}\Sigma_{11}^{-1}$ from `Sigma11` and `Sigma12`.

**Answer:**

```python
W = np.linalg.solve(Sigma11, Sigma12).T
```

## Use prediction before manipulation

**Question:** In

$$
\mu_{1\mid2}=\mu_1+\Sigma_{12}\Sigma_{22}^{-1}(x_2-\mu_2),
$$

what should happen to the posterior mean if $\Sigma_{12}=0$?

**Answer:** The update term becomes zero, so the conditional mean remains $\mu_1$ regardless of the observed value of $x_2$.

Then perform the manipulation and show that this happens.

**Question:** If the cross-group dependence becomes stronger while the marginal scales remain fixed, what should happen to the posterior uncertainty about $x_1$ after observing $x_2$?

**Answer:** The observed block carries more information about the missing block, so the conditional covariance should become smaller.

Then change the relevant parameter and inspect the result.

## Compare the two methods directly

**Question:** If the PyMC model and the linear-Gaussian equations describe the same joint Gaussian, what should we expect when we compare their posterior means and covariances?

**Answer:** They should agree up to Monte Carlo error in the PyMC samples.

Then display:

- PyMC posterior in the chosen common plot format;
- exact LGS posterior in the same format;
- one direct comparison plot or table;
- numerical differences in posterior means/covariances.

## What not to ask here

Avoid:

- questions that require an arbitrary setup fact not supplied beforehand;
- decomposing the synthetic covariance construction into line-by-line coding exercises;
- separate "which function?" and "now use the function" questions when one task-specific coding prompt is enough;
- ambiguous code blocks whose status as given or student-written is unclear;
- generic prompts such as "Interpret the posterior," "Discuss the covariance matrix," or "What did you learn?";
- re-teaching generic `pm.Model` or `pm.sample` syntax unless the current use is genuinely new.
