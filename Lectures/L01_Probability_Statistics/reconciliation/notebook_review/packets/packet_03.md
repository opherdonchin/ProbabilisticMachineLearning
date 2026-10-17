Cell 32, id f763c9f7, type markdown

### *Explanation to read*

---

Cell 33, id cd5bafca, type markdown

#### The reconstruction task

We want to infer the hidden part of a case from its recorded measurements. Write this query as $p(z_*\mid x_*)$, where $z_*$ is the unobserved quantity and $x_*$ is the available information. Here the joint model is supplied rather than estimated from a training dataset; its parameters $\mu,\Sigma$ are fixed. Reconstruction should first report a conditional distribution; choosing a point estimate requires a loss function.

---

Cell 34, id 864e5feb, type markdown

### *Questions to answer*

---

Cell 35, id 404b2887, type markdown

#### 1.3 Specify this reconstruction problem — prose and mathematics

We withhold the three values in `x1_true`, observe the four values in `x2_obs`, and know $\mu,\Sigma$. Identify the unobserved quantity $z_*$ and available information $x_*$ in the conditional query $p(z_*\mid x_*)$. Write the concrete target distribution and distinguish the unknown values from model parameters.

---

Cell 36, id e2640751, type markdown

- answer here
