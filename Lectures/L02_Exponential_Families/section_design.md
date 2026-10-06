# Lecture 2 section design

This file partitions the agreed Lecture 2 scope into section-level contracts for downstream slide organization.

Use `skills/slide-level-organization/SKILL.md` on **one section at a time**. The slide-organization stage owns slide titles, order, slide count, and teaching-move granularity. This file owns the section boundaries, purposes, endpoints, assigned content, treatment constraints, and neighboring-section boundaries.

## Lecture-level frame

**Lecture trajectory**

Exponential-family representation → moments from the log-partition function → learning by moment matching → categorical counts → transition counts and Markov learning.

**Live-time target**

Approximately 90–110 minutes total. Recording candidates remain in the live budget until explicitly moved.

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

**Status:** **One open upstream issue before final slide organization:** select the empirical data application.

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

**Required but not yet selected.**

The application must be a genuine empirical example in the course sense:

`actual data → sufficient statistics → fitted distribution/model → interpretation`.

A merely mathematical instantiation such as “Bernoulli is an exponential-family member” does not satisfy this requirement.

Current candidate: fit a Gaussian to an actual measured variable (possibly an Iris measurement) and show how empirical sufficient statistics determine the fitted model. This is a candidate, not an agreed decision.

### Boundary / exclusions

- Do not introduce categorical distributions merely as another catalogue example here.
- Reserve categorical estimation for Section 4, where it becomes the bridge to Markov models.

### Extent

Approximately 25–30 minutes.

### Take-home

For an exponential-family model, maximum likelihood matches model expectations of the sufficient statistics to their empirical averages.

---

## Section 4 — Categorical distributions extend the same learning rule to multiple outcomes

**Status:** Ready for slide organization.

### Purpose / role

Extend the Bernoulli/exponential-family machinery just far enough that Markov-chain parameter estimation becomes a direct reuse of the same idea.

### Entry condition / transition in

Students now understand exponential-family MLE as moment matching. Move from a binary outcome to `K` mutually exclusive outcomes.

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

### Empirical application / required figure

No separate empirical application is required here. The normalized-count result should set up the actual text-data application in Section 5.

### Boundary / exclusions

No sequence dependence yet. End with one categorical distribution learned from counts; the next section repeats such categorical conditionals across states/contexts.

### Extent

Approximately 12–15 minutes.

### Take-home

Normalized category counts are the categorical instance of exponential-family moment matching.

---

## Section 5 — A Markov model learns one categorical distribution for each preceding state

**Status:** Ready for slide organization.

### Purpose / role

Turn the lecture's general estimation machinery into a concrete learned sequence model and establish the notebook handoff.

### Entry condition / transition in

Section 4 established how to estimate one categorical distribution from counts. A Markov model repeats that conditional categorical model for every preceding state/context.

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

- Categorical MLE as normalized counts from Section 4.
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

## Open section-design issue

Only one issue should block a clean section-by-section slide-organization pass:

1. **Section 3 empirical application:** select a concrete dataset/application that visibly demonstrates `data → sufficient statistics → fitted exponential-family model → interpretation`.

All other sections have enough section-level specification to begin slide organization. If slide organization exposes scope, extent, prerequisite, or neighboring-section pressure, return that pressure here rather than silently changing the section contract.
