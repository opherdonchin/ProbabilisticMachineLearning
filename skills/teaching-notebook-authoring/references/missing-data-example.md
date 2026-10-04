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
9. Manipulate cross-group dependence and predict the consequence.

The teaching-notebook author should **unpack this path**, not invent a different one.

## Example question sequence

### Introduce the block structure

**Question:** Which coordinates of $x$ are going to be treated as missing, and which will remain observed?

**Answer:** $x_1$ will be hidden and inferred; $x_2$ will remain observed.

**Question:** If $x_1\in\mathbb{R}^{n_1}$ and $x_2\in\mathbb{R}^{n_2}$, what are the shapes of $\Sigma_{11}$, $\Sigma_{12}$, $\Sigma_{21}$, and $\Sigma_{22}$?

**Answer:**

- $\Sigma_{11}$ is $n_1\times n_1$;
- $\Sigma_{12}$ is $n_1\times n_2$;
- $\Sigma_{21}$ is $n_2\times n_1$;
- $\Sigma_{22}$ is $n_2\times n_2$.

**Question:** Which covariance block determines whether observing $x_2$ can shift our mean prediction for $x_1$?

**Answer:** $\Sigma_{12}$ (equivalently $\Sigma_{21}=\Sigma_{12}^T$) carries the cross-covariance between the missing and observed blocks.

### Introduce a new NumPy operation only when needed

**Question:** We have built the four covariance blocks separately. Which NumPy function can assemble them into one block matrix with the layout

$$
\Sigma=
\begin{pmatrix}
\Sigma_{11} & \Sigma_{12}\\
\Sigma_{21} & \Sigma_{22}
\end{pmatrix}?
$$

**Answer:** `np.block`.

Then show the concrete code.

### Connect PyMC to the probability target

**Question:** After hiding $x_1$, what probability distribution are we asking PyMC to sample from?

**Answer:**

$$
p(x_1\mid x_2,\mu,\Sigma).
$$

**Question:** The students know ordinary observed PyMC variables, but this missing-data use may be new. How can we mark the missing entries in the observed vector supplied to `pm.MvNormal`?

**Answer:** Put `np.nan` in the missing positions of the observed array; PyMC then treats those entries as unobserved variables.

Then show the actual code rather than asking students to reconstruct unrelated PyMC boilerplate.

### Map the same problem into the lecture's LGS notation

**Question:** In the lecture's linear-Gaussian system

$$
z\sim\mathcal N(\mu_z,\Sigma_z),\qquad y\mid z\sim\mathcal N(Wz+b,\Omega),
$$

which variables in our missing-data problem should play the roles of $z$ and $y$?

**Answer:** Set $z=x_1$ and $y=x_2$.

**Question:** Which distribution from the joint Gaussian gives the required observation model $p(x_2\mid x_1)$?

**Answer:** The conditional Gaussian distribution of $x_2$ given $x_1$.

**Question:** Comparing

$$
E[x_2\mid x_1]
=\mu_2+\Sigma_{21}\Sigma_{11}^{-1}(x_1-\mu_1)
$$

with

$$
E[y\mid z]=Wz+b,
$$

what must $W$ be?

**Answer:**

$$
W=\Sigma_{21}\Sigma_{11}^{-1}.
$$

**Question:** What should $b$ be so that $W\mu_1+b=\mu_2$?

**Answer:**

$$
b=\mu_2-W\mu_1.
$$

**Question:** We could write `Sigma21 @ np.linalg.inv(Sigma11)`, but which NumPy operation should we prefer to solve the corresponding linear system without explicitly computing an inverse?

**Answer:** `np.linalg.solve`.

### Use prediction before manipulation

**Question:** In the conditional-mean equation

$$
\mu_{1\mid2}=\mu_1+\Sigma_{12}\Sigma_{22}^{-1}(x_2-\mu_2),
$$

what should happen to the posterior mean if we set $\Sigma_{12}=0$?

**Answer:** The update term becomes zero, so the conditional mean should remain $\mu_1$ regardless of the observed value of $x_2$.

Then perform the manipulation and show that this happens.

**Question:** If we strengthen the cross-group covariance while keeping the marginal scales comparable, what should happen to the uncertainty about $x_1$ after observing $x_2$?

**Answer:** The observed block should carry more information about the missing block, so the conditional covariance should decrease.

Then change the relevant covariance parameter and inspect the result.

### Compare the two methods directly

**Question:** If the PyMC model and the linear-Gaussian equations describe the same joint Gaussian, what should we expect when we compare the two posterior means and covariances?

**Answer:** They should agree up to Monte Carlo error in the PyMC samples.

Then display:

- PyMC posterior in the chosen common plot format;
- exact LGS posterior in the same format;
- one direct comparison plot or table;
- numerical differences in posterior means/covariances.

## What not to ask here

Avoid generic prompts such as:

- "Interpret the posterior."
- "Discuss the covariance matrix."
- "What did you learn?"

Prefer questions whose answers make a checkable commitment about the mathematical mechanism.

Also avoid re-teaching generic `pm.Model` or `pm.sample` syntax unless the notebook uses them in a genuinely new way.
