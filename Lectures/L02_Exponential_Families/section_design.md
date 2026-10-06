# Lecture 2 section design

This file partitions the agreed Lecture 2 scope into section-level contracts for downstream slide organization.

Use `skills/slide-level-organization/SKILL.md` on **one section at a time**. The slide-organization stage owns slide titles, order, slide count, and teaching-move granularity. This file owns the section boundaries, purposes, endpoints, assigned content, treatment constraints, and neighboring-section boundaries.

## Lecture-level frame

**Lecture trajectory**

Exponential-family representation → Gaussian canonical derivation → moments from the log-partition function → MLE as moment matching → maximum-entropy characterization → empirical Gamma fit → categorical counts → transition counts and Markov learning.

**Live-time target**

Approximately 100–120 minutes total. Section 2 is deliberately self-contained so that it can later be moved to a recording with minimal disruption. Recording candidates remain in the live budget until explicitly moved.

**Starting assumptions**

- Students know Bernoulli/binomial models well from prior Bayesian statistics.
- Lecture 1 established multivariate Gaussians, Gaussian conditioning, linear Gaussian systems, and precision coordinates.
- Entropy and KL divergence are review material rather than first exposure.

**Global boundaries**

- Skip/defer Book 2 §2.5 transformations.
- Stop Markov-chain coverage before §2.6.4 stationary distributions.
- Book 2 §2.6.3 parameter estimation is the bridge to the student notebook.
- Sparse-data smoothing / Dirichlet-MAP treatment is optional notebook extension, not required live scope.
- Section-summary slides should be explicitly labeled as summaries in the slide-organization handoff.

---

## Section 1 — Exponential families give familiar distributions a common form

**Status:** Ready for slide organization.

### Purpose / role

Introduce the exponential-family representation as a useful common coordinate system for familiar distributions, not as a catalogue of distributions.

### Entry condition / transition in

Lecture 1 ended with familiar probabilistic models and Gaussian information/precision coordinates. Begin from Bernoulli as a simple known distribution and ask whether apparently different families can share one algebraic form.

### Endpoint

Students can identify the roles of

- base measure `h(x)`;
- sufficient statistic `T(x)`;
- natural parameter `η`;
- log-partition function `A(η)`;

and understand conceptually why this representation is useful.

### Sources

- Murphy Book 2 §§2.4.1–2.4.2.
- Murphy Book 1 §3.4 as supporting exposition where useful.

### Assigned content

- General exponential-family form.
- Meaning of `h(x)`, `T(x)`, `η`, and `A(η)`.
- Bernoulli in canonical/exponential-family form.
- Brief forward pointer that Gaussian models also fit the same representation; the full algebra belongs to Section 2.

### Mathematical treatment constraints

- General exponential-family form — **State + Motivate**.
- Bernoulli canonical form — **Work through**.
- Gaussian — **Mention / bridge only** in this section.

### Carry-forward / prerequisites

- Bernoulli/binomial likelihoods.
- Familiarity with Gaussian precision coordinates from Lecture 1.

### Boundary / exclusions

Do not perform the Gaussian canonical derivation here. Do not yet develop derivatives of `A(η)`, dataset likelihoods, MLE, or categorical distributions.

### Extent

Approximately 10–12 minutes.

### Take-home

Apparently different distributions can share one mathematical architecture that separates data statistics, parameters, and normalization.

---

## Section 2 — A Gaussian can be rewritten in exponential-family coordinates

**Status:** Ready for slide organization. **Whole-section recording candidate.**

### Purpose / role

Work through the full Gaussian-to-exponential-family algebra in one self-contained place. This gives students a substantial familiar example, connects directly to Lecture 1 precision/information coordinates, and makes the material easy to remove intact to a recording later.

### Entry condition / transition in

Section 1 established the general exponential-family form using Bernoulli. Students already know the multivariate Gaussian density and precision matrix from Lecture 1.

### Endpoint

Students can see explicitly how the multivariate Gaussian density is rearranged into exponential-family form and identify its sufficient statistics, natural parameters, and log-partition term.

### Sources

- Murphy Book 2 §2.4.2.5 (multivariate Gaussian exponential-family example).
- Lecture 1 Gaussian precision/information-form material as carry-forward context.

### Assigned content

- Start from the multivariate Gaussian density.
- Introduce `Λ = Σ^{-1}`.
- Expand the quadratic form `(x-μ)^T Λ (x-μ)`.
- Separate data-dependent terms from parameter-only terms.
- Identify sufficient statistics involving `x` and `xx^T`.
- Identify natural parameters corresponding to `Λμ` and `-½Λ`.
- Identify the normalizing/log-partition term sufficiently to complete the mapping.
- Connect the result back to Lecture 1 information/precision coordinates.

### Mathematical treatment constraints

- Gaussian canonical rewrite — **Derive fully enough that every term in the exponential-family representation has an identifiable origin**.
- Matrix symmetry/vectorization technicalities — **Mention only if needed**; do not let them become the topic.
- The point is the representation and connection to prior Gaussian work, not new Gaussian inference.

### Carry-forward / prerequisites

- Multivariate Gaussian density.
- Precision matrix `Λ = Σ^{-1}`.
- Quadratic-form algebra from Lecture 1.

### Boundary / exclusions

Do not derive Gaussian conditioning or linear-Gaussian inference again. Do not yet use derivatives of the log-partition function.

### Extent

Approximately 8–10 minutes.

### Take-home

The Gaussian precision/information form from Lecture 1 is exactly an exponential-family natural-parameter representation.

---

## Section 3 — The log-partition function connects parameters to moments

**Status:** Ready for slide organization.

### Purpose / role

Show why the exponential-family representation is computationally useful rather than merely elegant notation.

### Entry condition / transition in

Students now know the exponential-family form and have seen it instantiated in both Bernoulli and Gaussian models. The next question is what the log-partition function buys us.

### Endpoint

Students understand

`∇A(η) = Eη[T(X)]`

and that the curvature of `A` is related to uncertainty in the sufficient statistics. They also understand natural parameters and mean parameters as two descriptions of the same family.

### Sources

- Murphy Book 2 §§2.4.3–2.4.4.

### Assigned content

- First derivative of the log-partition function gives expected sufficient statistics.
- Second derivative gives covariance of sufficient statistics.
- Natural parameters versus mean parameters.
- Bernoulli as a compact check of the first-derivative result.

### Mathematical treatment constraints

- `∇A(η) = E[T(X)]` — **Derive carefully live**.
- `∇²A(η) = Cov[T(X)]` — **State + derivational sketch**; full derivation remains a **Recording candidate**.
- Natural ↔ mean parameterization — **State + Motivate**.
- Convex-conjugate machinery is not load-bearing; do not allow it to expand the section unless the scope is explicitly revised.

### Carry-forward / prerequisites

- Exponential-family form from Section 1.
- Bernoulli canonical representation from Section 1.
- Gaussian example from Section 2 may be referenced but is not required for the derivation.

### Boundary / exclusions

Stop before sample likelihood, sufficient statistics for a dataset, and MLE.

### Extent

Approximately 18–20 minutes.

### Take-home

Derivatives of the log-partition function convert natural parameters into moments of the sufficient statistics.

---

## Section 4 — Learning an exponential-family model means matching model moments to data

**Status:** Ready for slide organization.

### Purpose / role

Turn the exponential-family representation into a general maximum-likelihood learning rule. This is the main estimation section of the lecture.

### Entry condition / transition in

Section 3 established that model moments are derivatives of `A(η)`. Now introduce observed data and ask how `η` should be chosen from a sample.

### Endpoint

Students can derive the IID exponential-family likelihood, see why the data enter through aggregate sufficient statistics, and derive

`∇η ℓ(η) = Σn T(xn) - N Eη[T(X)]`,

hence

`Eη̂[T(X)] = (1/N) Σn T(xn)`.

They can recognize Bernoulli MLE as the simplest specialization of the same rule.

### Sources

- Murphy Book 2 §2.4.5.
- Murphy Book 1 §4.2 as familiar MLE scaffolding where useful.

### Assigned content

- Dataset likelihood for an exponential-family model.
- Aggregate sufficient statistics.
- Likelihood gradient.
- MLE as moment matching.
- Bernoulli MLE as a familiar specialization/check.

### Mathematical treatment constraints

- Dataset likelihood and sufficient-statistic reduction — **Derive**.
- Exponential-family MLE → moment matching — **Derive carefully live**.
- Bernoulli specialization — **Apply / check**.
- Concavity of the regular exponential-family log likelihood — **Optional brief consequence only, not a separate teaching move**. It follows from convexity of `A`; it is not the bridge to maximum entropy.

### Carry-forward / prerequisites

- `∇A(η) = E[T(X)]` from Section 3.
- Familiar Bernoulli MLE intuition from prior statistics.

### Boundary / exclusions

- Do not introduce maximum entropy here; it is a separate characterization in Section 5.
- Do not turn Bernoulli/Gaussian specializations into the main empirical example.
- End with the general learning rule in a form that can be reused directly later.

### Extent

Approximately 16–18 minutes.

### Take-home

For an exponential-family model, maximum likelihood matches model expectations of the sufficient statistics to their empirical averages.

---

## Section 5 — Moment constraints and maximum entropy lead to exponential families

**Status:** Ready for slide organization.

### Purpose / role

Present maximum entropy as a separate answer to a separate question: if only some expected feature values are known, what distribution should we choose without adding unsupported structure?

### Entry condition / transition in

Section 4 showed how to estimate parameters when an exponential family is already specified. Now reverse the direction: start from constraints on expected features and ask what form the distribution itself should take.

### Endpoint

Students understand that

- moment/feature constraints express what is assumed known;
- minimizing KL to a reference distribution `q(x)` chooses the least-committed distribution satisfying those constraints;
- with uniform `q`, this becomes maximum entropy;
- the Lagrange-multiplier solution has exponential-family form.

### Sources

- Murphy Book 2 §2.4.7.

### Assigned content

- Expected-feature constraints `E[f_k(X)] = F_k`.
- Minimum KL to a prior/reference distribution `q(x)` as the general principle.
- Maximum entropy as the uniform-reference special case.
- Lagrange-multiplier proof sketch yielding exponential-family form.

### Mathematical treatment constraints

- Conceptual setup — **Motivate**.
- KL / maximum-entropy equivalence for uniform `q` — **State + Explain**.
- Lagrange derivation — **Proof sketch live**.
- Full functional-derivative/calculus-of-variations detail — **Recording candidate** if desired; not required for the live conceptual result.

### Carry-forward / prerequisites

- Exponential-family form from Section 1.
- Entropy and KL divergence from prior coursework / review.

### Boundary / exclusions

Do not present this as a consequence of log-likelihood concavity. Do not introduce full convex-duality / Legendre-transform machinery unless the scope is explicitly expanded. The deep duality is real but is not required for this lecture.

### Extent

Approximately 8–10 minutes.

### Take-home

Moment constraints are the assumptions in a maximum-entropy problem; the least-committed distribution satisfying them has exponential-family form.

---

## Section 6 — Maximum likelihood fits a Gamma model to rainfall data

**Status:** Ready for slide organization.

### Purpose / role

Apply the Section 4 learning rule to a genuinely nontrivial two-parameter exponential family and real data. Make the sufficient-statistic reduction concrete without turning the example into another long derivation.

### Entry condition / transition in

Section 4 established the abstract MLE moment-matching rule. Section 5 provided an alternative characterization of why exponential families arise. Now return to estimation and ask what the learning rule looks like on real, non-Gaussian data.

### Endpoint

Students should be able to see, in a concrete fit, that

- the Gamma family can be written with sufficient statistics involving `x` and `log x`;
- the rainfall sample affects the Gamma likelihood through `Σ xi` and `Σ log xi`;
- Gamma MLE applies the general moment-matching principle;
- the resulting fitted Gamma distribution captures important structure in the observed skewed data.

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
- SciPy distribution-fitting reference: https://docs.scipy.org/doc/scipy/tutorial/stats/probability_distributions.html

These references are for exposition and implementation guidance. The course can reproduce the figures/code independently in Python; there is no requirement to reuse the source code verbatim.

### Assigned content

- Show the positive, right-skewed rainfall data.
- Introduce the two-parameter Gamma model only as much as needed for the fit.
- Identify `T(x) = (log x, x)` up to ordering/sign conventions.
- Show that the sample enters through `Σ log xi` and `Σ xi`.
- Apply the general MLE moment-matching result.
- Show the fitted distribution against the observed data.

### Mathematical treatment constraints

- Gamma exponential-family representation — **Work only enough to identify `T(x)` and `η`**.
- Sample reduction and MLE equations — **Apply** the general Section 4 result.
- Digamma-function appearance — **State / acknowledge** only.
- Numerical root finding / optimizer details — **Omit** from the lecture argument.

### Carry-forward / prerequisites

- General exponential-family form from Section 1.
- `∇A(η) = E[T(X)]` from Section 3.
- General MLE moment-matching condition from Section 4.

### Empirical application / required figures

This section is itself the empirical application. Preserve the compact chain

`rainfall data → Gamma sufficient statistics → fitted Gamma model → comparison with data`.

A histogram/density view with the fitted Gamma overlaid is strongly desirable.

### Boundary / exclusions

- Do not survey Gamma-distribution properties.
- Do not require hand solution of the nonlinear shape-parameter MLE.
- Do not let numerical optimization become the topic.

### Extent

Approximately 7–9 minutes.

### Take-home

A nontrivial real dataset can be compressed to a small sufficient-statistic vector that determines a useful maximum-likelihood fit.

---

## Section 7 — Categorical distributions extend the same learning rule to multiple outcomes

**Status:** Ready for slide organization.

### Purpose / role

Extend the Bernoulli/exponential-family machinery just far enough that Markov-chain parameter estimation becomes a direct reuse of the same idea.

### Entry condition / transition in

Students now understand exponential-family MLE as moment matching and have seen it applied to a nontrivial real-data fit. Move from continuous positive data to `K` mutually exclusive outcomes.

### Endpoint

Students understand categorical indicator sufficient statistics, the natural-parameter / softmax representation, and why a sample of categorical observations reduces to counts whose normalized values are the MLE probabilities.

### Sources

- Murphy Book 2 §2.2.1.2.
- Murphy Book 2 §2.4.2 categorical exponential-family treatment.

### Assigned content

- Categorical distribution as a `K`-outcome extension of Bernoulli.
- Indicator-vector sufficient statistics.
- Natural parameters / softmax relation.
- Category counts and categorical MLE as one combined count-and-normalize step.

### Mathematical treatment constraints

- Categorical sufficient statistics — **Motivate + State**.
- Softmax from natural parameters — **Develop selectively**.
- Count aggregation + categorical MLE — **Combine in one teaching move and apply general moment matching**, rather than deriving MLE independently.

### Carry-forward / prerequisites

- Bernoulli as the familiar binary case.
- Moment-matching result from Section 4.

### Boundary / exclusions

No sequence dependence yet. End with one categorical distribution learned from counts; the next section repeats such categorical conditionals across states/contexts.

### Extent

Approximately 10–12 minutes.

### Take-home

For categorical data, exponential-family learning reduces to count and normalize.

---

## Section 8 — A Markov model learns one categorical distribution for each preceding state

**Status:** Ready for slide organization.

### Purpose / role

Turn categorical estimation into a learned sequence model and establish the notebook handoff.

### Entry condition / transition in

Section 7 established how to estimate one categorical distribution from counts. A Markov model repeats that conditional categorical model for every preceding state/context.

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

- Categorical MLE as normalized counts from Section 7.
- General sufficient-statistic / moment-matching logic from Section 4.

### Empirical application / required figures

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

Approximately 20–24 minutes.

### Take-home

A learned first-order Markov chain is a structured collection of categorical conditional distributions whose parameters are estimated from transition counts.

---

## Open section-design issues

No section currently has a blocking section-design issue.

The main deliberate flexibility is Section 2: it is designed as a complete live section but can later be moved wholesale to a recording.

If slide organization exposes scope, extent, prerequisite, source, or neighboring-section pressure, return that pressure here rather than silently changing the section contract.