Cell 37, id 4b1f5cf2, type markdown

### *Explanation to read*

---

Cell 38, id 132ebde5, type markdown

#### Section summary

We identified the covariance blocks for hidden and recorded coordinates, the dependence between those blocks, and the conditional distribution needed to infer the hidden coordinates from the recorded ones.

---

Cell 39, id 00979f8f, type markdown

## 2. Evaluate the exact conditional distribution

---

Cell 40, id 602bfa01, type markdown

### *Explanation to read*

---

Cell 41, id e3fd2fba, type markdown

#### Compute the hidden-block conditional distribution

Apply the lecture's block-Gaussian equations:
$$
X_1\mid X_2=x_{2,\mathrm{obs}}\sim\mathcal N(m,V),
$$
$$
m=\mu_1+\Sigma_{12}\Sigma_{22}^{-1}(x_{2,\mathrm{obs}}-\mu_2),\qquad
V=\Sigma_{11}-\Sigma_{12}\Sigma_{22}^{-1}\Sigma_{21}.
$$

The covariance $V$ is the **Schur complement** of $\Sigma_{22}$ in $\Sigma$. Here it describes uncertainty about the hidden coordinates after conditioning on the recorded coordinates.

The **innovation** $x_{2,\mathrm{obs}}-\mu_2$ is the difference between the recorded values and their model mean. `np.linalg.solve(A, B)` solves $AU=B$ for $U$; when $A$ is invertible, this evaluates $A^{-1}B$ without explicitly forming an inverse. A vector right-hand side produces a vector; a matrix right-hand side solves for all its columns. Keep the displayed multiplication order.

---

Cell 42, id 32bb1769, type markdown

### *Questions to answer*

---

Cell 43, id d84bd482, type markdown

#### 2.1 Compute the conditional mean — code

Using `np.linalg.solve(A, B)` for $A^{-1}B$, calculate `innovation = x2_obs - mu2` and
$$
m=\mu_1+\Sigma_{12}\Sigma_{22}^{-1}(x_{2,\mathrm{obs}}-\mu_2).
$$
Store the result as `conditional_mean`; print it and its shape. Check in a code comment how a $(3,4)$ matrix acts on the solved $(4,)$ vector.

---

Cell 44, id f2e568a3, type code

```python
# answer here
```
