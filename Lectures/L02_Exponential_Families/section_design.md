# Lecture 2 section design

This file partitions the agreed Lecture 2 scope into section-level contracts for downstream slide organization.

Use `skills/slide-level-organization/SKILL.md` on **one section at a time**. The slide-organization stage owns slide titles, order, slide count, and teaching-move granularity. This file owns the section boundaries, purposes, endpoints, assigned content, treatment constraints, and neighboring-section boundaries.

## Lecture-level frame

**Lecture trajectory**

Exponential-family representation → moments from the log-partition function → learning by moment matching → empirical Gamma fit → categorical counts → transition counts and Markov learning.

**Live-time target**

Approximately 100–120 minutes total. Recording candidates remain in the live budget until explicitly moved.

**Starting assumptions**

- Students know Bernoulli/binomial models well from prior Bayesian statistics.
- Lecture 1 established multivariate Gaussians, Gaussian conditioning, linear Gaussian systems, and precision coordinates.
- Entropy and KL divergence are review material rather than first exposure.

**Global boundaries**

- Skip/defer Book 2 §2.5 transformations.
- Stop Markov-chain coverage before §2.6.4 stationary distributions.
- Book 2 §2.6.3 parameter estimation is the bridge to the student notebook.
- Sparse-data smoothing / Dirichlet-MAP treatment is optional notebook extension, not required live scope.

---

## Section 1 — Exponential families give familiar distributions a common form

**Status:** Ready for slide organization.

### Purpose / role

Introduce the exponential-family representation as a useful common coordinate system for familiar distributions, not as a catalogue of distributions.

### Entry condition / transition in

Lecture 1 ended with Gaussians in ordinary and precision coordinates. Students also know Bernoulli/binomial models well. Begin from those familiar objects and show that their apparently different forms share a common representation.

### Endpoint

Students can identify the roles of

- base measure `h(x)`;
- sufficient statistic `T(x)`;
- natural parameter `η`;
- log-partition function `A(η)`;

and understand conceptually why natural parameters and sufficient statistics are useful descriptions of a distribution family.

### Sources

- Murphy Book 2 §§2.4.1–2.4.2.
- Murphy Book 1 §3.4 as supporting exposition where useful.

### Assigned content

- General exponential-family form.
- Meaning of `h(x)`, `T(x)`, `η`, and `A(η)`.
- Bernoulli in canonical/exponential-family form.
- Gaussian connection to the precision/information coordinates already encountered in Lecture 1.

### Mathematical treatment constraints

- General exponential-family form — **State + Motivate**.
- Bernoulli canonical form — **Work through**.
- Gaussian exponential-family representation — **Recognize / connect to Lecture 1**, not a second full derivation.
- Full Gaussian canonical algebra — **Recording candidate** if extent later requires relief; still counted live for now.

### Carry-forward / prerequisites

- Bernoulli/binomial likelihoods.
- Gaussian precision coordinates from Lecture 1.

### Empirical application / required figure

No empirical application is currently assigned to this section. Mathematical examples here are scaffolding, not counted as empirical examples.

### Boundary / exclusions

Do not yet develop derivatives of `A(η)`, mean parameters, dataset likelihoods, MLE, or categorical distributions.

### Extent

Approximately 15–18 minutes.

### Take-home

Apparently different familiar distributions can share one mathematical architecture.

---

## Section 2 — The log-partition function connects parameters to moments

**Status:** Ready for slide organization.

### Purpose / role

Show why the exponential-family representation is computationally useful rather than merely elegant notation.

### Entry condition / transition in

Students now know the exponential-family form and the roles of `T(x)`, `η`, and `A(η)`. The next question is what the log-partition function buys us.

### Endpoint

Students understand

`∇A(η) = Eη[T(X)]`

and understand that the curvature of `A` is related to uncertainty in the sufficient statistics. They also understand natural parameters and mean parameters as two descriptions of the same family.

### Sources

- Murphy Book 2 §§2.4.3–2.4.4.

### Assigned content

- First derivative of the log-partition function gives expected sufficient statistics.
- Second derivative gives covariance of sufficient statistics.
- Natural parameters versus mean parameters.
- Bernoulli as the running mathematical instance.

### Mathematical treatment constraints

- `∇A(η) = E[T(X)]` — **Derive carefully live**.
- `∇²A(η) = Cov[T(X)]` — **State + derivational sketch**; full derivation remains a **Recording candidate**.
- Natural ↔ mean parameterization — **State + Motivate**.
- Convex-conjugate machinery is not load-bearing; do not allow it to expand the section unless the scope is explicitly revised.

### Carry-forward / prerequisites

- Exponential-family form from Section 1.
- Bernoulli canonical representation from Section 1.

### Empirical application / required figure

No empirical application is currently assigned to this section.

### Boundary / exclusions

Stop before dataset likelihood, sufficient statistics for a sample, and MLE.

### Extent

Approximately 18–22 minutes.

### Take-home

Derivatives of the log-partition function recover moments of the sufficient statistics.

---

## Section 3 — Learning an exponential-family model means matching model moments to data

**Status:** Ready for slide organization.

### Purpose / role

Turn the exponential-family representation into a general learning rule. This is the mathematical center of the lecture.

### Entry condition / transition in

Section 2 established that model moments are derivatives of `A(η)`. Now introduce observed data and ask how those parameters are learned.

### Endpoint

Students can derive the IID exponential-family likelihood, see why the data enter through aggregate sufficient statistics, and derive

`∇η ℓ(η) = Σn T(xn) - N Eη[T(X)]`,

hence the MLE moment-matching condition

`Eη̂[T(X)] = (1/N) Σn T(xn)`.

Students should also understand the maximum-entropy interpretation as an explanation for why exponential families arise under moment constraints.

### Sources

- Murphy Book 2 §2.4.5.
- Murphy Book 2 §2.4.7.
- Murphy Book 1 §4.2 as familiar MLE scaffolding where useful.

### Assigned content

- Dataset likelihood for an exponential-family model.
- Aggregate sufficient statistics.
- Likelihood gradient.
- MLE as moment matching.
- Bernoulli MLE as a familiar specialization if useful for checking the general rule.
- Maximum-entropy interpretation of the exponential family.

### Mathematical treatment constraints

- Dataset likelihood and sufficient-statistic reduction — **Derive**.
- Exponential-family MLE → moment matching — **Derive carefully live**.
- Likelihood Hessian / concavity consequence — **Brief / State**, not a separate major development.
- Maximum-entropy result — **Motivate + Proof sketch live**.
- Full Lagrange-multiplier maximum-entropy derivation — **Recording candidate**; still counted live until moved.

### Carry-forward / prerequisites

- `∇A(η) = E[T(X)]` from Section 2.
- Familiar Bernoulli MLE intuition from prior statistics.

### Empirical application / required figure

No full empirical application is required inside this section. The next section is reserved for a dedicated real-data application of the general result.

### Boundary / exclusions

- Do not turn Bernoulli/Gaussian specializations into the main empirical example here.
- Do not introduce categorical distributions merely as another catalogue example here.
- End with the general learning rule in a form that can be applied immediately to a less-trivial family.

### Extent

Approximately 22–27 minutes.

### Take-home

For an exponential-family model, maximum likelihood matches model expectations of the sufficient statistics to their empirical averages.

---

## Section 4 — Maximum likelihood fits a Gamma model to rainfall data

**Status:** Ready for slide organization.

### Purpose / role

Apply the Section 3 learning rule to a genuinely nontrivial two-parameter exponential family and real data. Make the sufficient-statistic reduction concrete before moving on to categorical models.

### Entry condition / transition in

Section 3 established the abstract rule

`Eη̂[T(X)] = (1/N) Σn T(xn)`.

Now ask what that rule actually looks like for a real dataset when the sufficient statistics are not simply `x` or `(x, x²)`.

### Endpoint

Students should be able to see, in a concrete fit, that

- the Gamma family can be written as an exponential family with sufficient statistics involving `x` and `log x`;
- the entire rainfall sample affects the Gamma likelihood through the aggregate statistics `Σ xi` and `Σ log xi`;
- Gamma MLE therefore matches the model expectations of `X` and `log X` to their empirical averages;
- exponential-family “moment matching” means matching expectations of the sufficient statistics;
- the fitted Gamma distribution can be interpreted against the observed skewed rainfall data.

### Primary empirical source

MIT 18.443 *Statistics for Applications*, R Project 2: Le Cam–Neyman precipitation data.

- Project index and downloadable R materials: https://ocw.mit.edu/courses/18-443-statistics-for-applications-spring-2015/pages/projects/
- R script/output containing the Gamma MLE fit: https://live.ocw.mit.edu/ans7870/18/18.443/s15/projects/Rproject2_script2_gamma_MOMwithMLE.html
- MIT lecture notes introducing the Gamma rainfall example: https://ocw.mit.edu/courses/18-443-statistics-for-applications-spring-2015/6408c60bd43d4da05fc6837a12341c29_MIT18_443S15_LEC2.pdf
- MIT MLE lecture notes with a worked two-parameter Gamma likelihood: https://ocw.mit.edu/courses/18-443-statistics-for-applications-spring-2015/2a08e2ffa8c87f3187d3969cc24c168b_MIT18_443S15_LEC4.pdf

The MIT dataset is described as average rainfall from summer storms measured by a network of rain gauges in southern Illinois, 1960–1964. Their R fit reports approximately `shape = 0.4408`, `rate = 1.9648` by MLE.

### Related Python / notebook references

- Chris Fonnesbeck, *Statistical Data Modeling* Jupyter notebook. Uses NOAA Nashville precipitation data and a Gamma model and includes an MLE fit: https://gist.github.com/fonnesbeck/5850483
- SciPy Gamma distribution reference: https://docs.scipy.org/doc/scipy/tutorial/stats/continuous_gamma.html
- SciPy distribution-fitting interface/reference, including Gamma parameterization: https://docs.scipy.org/doc/scipy/tutorial/stats/probability_distributions.html

These references are for exposition and implementation guidance. The course can reproduce the figures/code independently in Python; there is no requirement to reuse the source code verbatim.

### Assigned content

- Show the positive, right-skewed rainfall data.
- Introduce the two-parameter Gamma density in a parameterization compatible with the exponential-family derivation.
- Identify the sufficient-statistic vector, e.g. `T(x) = (log x, x)` up to ordering/sign conventions.
- Show that the sample enters the likelihood through `Σ log xi` and `Σ xi`.
- Connect the general MLE moment-matching condition from Section 3 to the Gamma case.
- Show the fitted distribution against the observed data.

### Mathematical treatment constraints

- Gamma exponential-family representation — **Work through enough to identify `T(x)` and `η`; do not turn this into another general derivation**.
- Reduction of the Gamma likelihood to `Σ xi` and `Σ log xi` — **Work / Apply**.
- Gamma MLE equations — **Apply the general Section 3 result**; do not require a closed-form solution for the shape parameter.
- Digamma-function appearance may be **State / acknowledge** as the consequence of differentiating `log Γ(α)`; it should not become a new mathematical branch.

### Carry-forward / prerequisites

- General exponential-family form from Section 1.
- `∇A(η) = E[T(X)]` from Section 2.
- General MLE moment-matching condition from Section 3.

### Empirical application / required figures

This section is itself the empirical application.

At minimum, the slide organization should preserve the empirical chain

`rainfall data → skewed empirical distribution → Gamma model → sufficient statistics → fitted parameters/model → comparison with data`.

A histogram/density view and at least one visual representation of the fitted Gamma model are strongly desirable.

### Boundary / exclusions

- Do not turn this into a general survey of Gamma-distribution properties.
- Do not require hand solution of the nonlinear shape-parameter MLE.
- Do not let numerical optimization machinery become the topic; the point is the sufficient-statistic structure and the meaning of the fitted model.
- End by returning to the general lesson before changing domains to categorical data.

### Extent

Approximately 10–15 minutes.

### Take-home

A nontrivial real dataset can be compressed to a small sufficient-statistic vector for parameter estimation, and exponential-family MLE matches the model expectations of those statistics to their empirical values.

---

## Section 5 — Categorical distributions extend the same learning rule to multiple outcomes

**Status:** Ready for slide organization.

### Purpose / role

Extend the Bernoulli/exponential-family machinery just far enough that Markov-chain parameter estimation becomes a direct reuse of the same idea.

### Entry condition / transition in

Students now understand exponential-family MLE as moment matching and have seen it applied to a nontrivial real-data fit. Move from continuous positive data to `K` mutually exclusive outcomes.

### Endpoint

Students understand categorical indicator sufficient statistics, the natural-parameter / softmax representation, multinomial counts, and why MLE yields normalized category counts.

### Sources

- Murphy Book 2 §2.2.1.2.
- Murphy Book 2 §2.4.2 categorical exponential-family treatment.

### Assigned content

- Categorical distribution as a `K`-outcome extension of Bernoulli.
- Indicator-vector sufficient statistics.
- Natural parameters / softmax relation.
- Multinomial or count representation where useful.
- Categorical MLE as normalized counts.

### Mathematical treatment constraints

- Categorical sufficient statistics — **Motivate + State**.
- Softmax from natural parameters — **Develop selectively**; do not reproduce every algebraic detail unless needed for the argument.
- Multinomial/count representation — **Brief**.
- Categorical MLE — **Apply the general moment-matching result**, rather than performing a wholly independent MLE derivation from scratch.

### Carry-forward / prerequisites

- Bernoulli as the familiar binary case.
- Moment-matching result from Section 3.
- Section 4 as evidence that the same learning principle works beyond trivial familiar distributions.

### Empirical application / required figure

No separate empirical application is required here. The normalized-count result should set up the actual text-data application in Section 6.

### Boundary / exclusions

No sequence dependence yet. End with one categorical distribution learned from counts; the next section repeats such categorical conditionals across states/contexts.

### Extent

Approximately 12–15 minutes.

### Take-home

Normalized category counts are the categorical instance of exponential-family moment matching.

---

## Section 6 — A Markov model learns one categorical distribution for each preceding state

**Status:** Ready for slide organization.

### Purpose / role

Turn the lecture's general estimation machinery into a concrete learned sequence model and establish the notebook handoff.

### Entry condition / transition in

Section 5 established how to estimate one categorical distribution from counts. A Markov model repeats that conditional categorical model for every preceding state/context.

### Endpoint

Students can

- read the first-order Markov factorization;
- interpret each row of a transition matrix as a categorical conditional distribution;
- identify transition counts `Njk` as the relevant sufficient statistics;
- understand why `Âjk = Njk / Nj`;
- understand what the fitted model can do, including scoring/generating sequences.

### Sources

- Murphy Book 2 §§2.6.1–2.6.3.
- Murphy Book 2 Fig. 2.15: state-transition diagrams.
- Murphy Book 2 Fig. 2.16: generated character-level text.
- Murphy Book 2 Fig. 2.17: raw and row-normalized character bigram counts.

### Assigned content

- First-order Markov factorization.
- Transition matrix as repeated categorical conditionals.
- Transition counts as sufficient statistics.
- Normalized-count MLE for transition probabilities.
- Character-level language modeling as the concrete empirical application.
- Direct conceptual handoff to the student notebook.

### Mathematical treatment constraints

- First-order factorization — **State + Motivate**.
- Transition-matrix interpretation — **Work / Apply**.
- Transition-count likelihood and MLE — **Apply the categorical / exponential-family learning result**, with enough algebra to make the correspondence explicit.
- Higher-order models may be mentioned only if needed to interpret the language-model example; they are not a new mathematical branch.

### Carry-forward / prerequisites

- Categorical MLE as normalized counts from Section 5.
- General sufficient-statistic / moment-matching logic from Section 3.

### Empirical application / required figures

This application is fixed:

**Character-level text modeling.** Use actual text counts to show

`text data → unigram / bigram counts → row-normalized transition probabilities → fitted Markov model → generated or scored sequences`.

Murphy's *The Time Machine* character bigram counts / normalized rows and generated-text examples are the primary source material.

### Notebook handoff

The live lecture establishes the factorization, count statistics, and learning rule. The student notebook then operationalizes

`sequence data → counts → fitted transition matrix → inspection / scoring / generation`.

Optional notebook extension: sparse counts and Dirichlet/MAP smoothing.

### Boundary / exclusions

- Stop before Book 2 §2.6.4 stationary distributions.
- Sparse-data smoothing is not required live material.

### Extent

Approximately 20–25 minutes.

### Take-home

A learned first-order Markov chain is a structured collection of categorical conditional distributions whose parameters are estimated from transition counts.

---

## Open section-design issues

No section currently has a blocking section-design issue.

If slide organization exposes scope, extent, prerequisite, source, or neighboring-section pressure, return that pressure here rather than silently changing the section contract.