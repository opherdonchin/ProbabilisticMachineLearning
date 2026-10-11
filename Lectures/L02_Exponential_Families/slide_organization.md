# Lecture 2 slide organization — draft

This file applies `.agents/skills/slide-level-organization/SKILL.md` to the current section contracts in `section_design.md`.

This is an **organization draft for instructor review**, not an approved slide-design specification. It owns slide titles, order, and concise teaching intentions. It does not prescribe finished layouts or Typst implementation.

## Lecture-level organization

Current trajectory:

Exponential-family representation → Gaussian canonical derivation → moments from the log-partition function → MLE as moment matching → maximum entropy → Gamma rainfall application → categorical counts → Markov learning from transition counts.

Proposed section-slide count: **53**, including eight section title slides and eight section summaries. The separate lecture title slide brings the planned deck to **54 slides**; the lecture-level notebook handoff is not a slide.

Section 2 is intentionally self-contained and can later move wholesale to a recording. Each section begins with a title slide and ends with an explicitly labeled summary slide. On each title slide, the numbered heading is the full title; subtitle and abbreviated footer title are specified below it.

---

# Section 1 — Exponential families give familiar distributions a common form

## Working specification

- **Purpose:** introduce the exponential-family representation as a useful common coordinate system.
- **Endpoint:** students can identify `h(x)`, `T(x)`, `η`, and `A(η)` and understand their roles.
- **Sources:** Murphy Book 2 §§2.4.1–2.4.2; Book 1 §3.4 as supporting exposition.
- **Treatment:** general form State + Motivate; Bernoulli Work through; Gaussian Mention/bridge only.
- **Extent:** ~10–12 minutes.
- **Boundary:** the full Gaussian rewrite is Section 2; no derivatives of `A` or MLE yet.

No clarification is needed before a first organization draft.

## Proposed slides

### 1. Exponential families give familiar distributions a common form

**Role:** Section title.

**Subtitle:** Bernoulli reveals the shared roles of data statistics, parameters, and normalization.

**Abbreviated title:** Exponential-family form.

**Intention / goal:** Open the question of how familiar distributions can be described in common coordinates.

### 2. Different distributions can share the same algebraic structure

**Intention / goal:** Motivate why the lecture is changing representation. Students should see exponential families as a way to expose common structure across familiar distributions, not as another catalogue of probability distributions.

### 3. Exponential families separate data statistics from natural parameters

**Intention / goal:** State

`p(x | η) = h(x) exp(ηᵀT(x) - A(η))`

and establish the four roles `h`, `T`, `η`, and `A` before specializing it.

**Design note:** Keep the general form persistent enough that later examples can map their terms onto it.

### 4. Bernoulli already has the exponential-family form

**Intention / goal:** Work from the ordinary Bernoulli probability to the exponential-family representation. Make `T(x)=x` and the natural parameter emerge from familiar algebra.

### 5. Bernoulli log odds are its natural parameter

**Intention / goal:** Interpret `η = log(p/(1-p))` and identify `A(η)`. The new coordinates should feel meaningful rather than like arbitrary algebraic rewriting.

**Design note:** Carry forward the result of the previous slide rather than restarting the derivation.

### 6. One representation exposes the same ingredients across families

**Role:** Summary.

**Intention / goal:** Consolidate the four pieces of exponential-family structure—`h`, `T`, `η`, and `A`—using the Bernoulli mapping established in this section.

**Summary candidates (from earlier slides):**

- Slide 3's annotated general form, to recall the distinct jobs of `h`, `T`, `η`, and `A`.
- Slides 4–5's Bernoulli mapping and log-odds relation, to recall how one familiar model instantiates that form.

## Issues / critique

- The section is now intentionally lightweight. The Gaussian no longer competes with the introductory purpose.
- Six slides including the title slide for 10–12 minutes appears plausible.

## Upstream change requests

None.

---

# Section 2 — A Gaussian can be rewritten in exponential-family coordinates

## Working specification

- **Purpose:** work through the full Gaussian-to-exponential-family algebra in one removable unit.
- **Endpoint:** students can identify Gaussian sufficient statistics, natural parameters, and normalizer from the ordinary multivariate Gaussian density.
- **Sources:** Murphy Book 2 §2.4.2.5 plus Lecture 1 Gaussian density/covariance material as carry-forward context; precision/information coordinates are introduced here.
- **Treatment:** full canonical rewrite live.
- **Extent:** ~8–10 minutes.
- **Status:** whole-section recording candidate.

No clarification is needed before a first organization draft.

## Proposed slides

### 1. A Gaussian can be rewritten in exponential-family coordinates

**Role:** Section title.

**Subtitle:** From the familiar density to precision and information coordinates.

**Abbreviated title:** Gaussian coordinates.

**Intention / goal:** Frame the algebraic rewrite as a test of the common form from Section 1.

### 2. The Gaussian density hides an exponential-family representation

**Intention / goal:** Start from the familiar multivariate Gaussian density and pose the task: rearrange it into `h(x) exp(ηᵀT(x)-A(η))` without changing the model.

### 3. Expanding the quadratic separates data-dependent and parameter-only terms

**Intention / goal:** Introduce the precision matrix `Λ=Σ^{-1}` and expand `(x-μ)^TΛ(x-μ)`. Students should see which terms contain `x` and which do not.

**Design note:** Progressive algebra; keep the original Gaussian density visible as context.

### 4. The Gaussian sufficient statistics are `x` and `xxᵀ`

**Intention / goal:** Group the data-dependent terms and identify the sufficient-statistic structure explicitly.

### 5. Precision and precision-weighted mean are Gaussian natural parameters

**Intention / goal:** Identify natural parameters corresponding to `-½Λ` and `Λμ`, together with the parameter-only normalizing term. Introduce these precision/information coordinates as a reparameterization of the familiar Gaussian density from Lecture 1.

### 6. Gaussian information coordinates are exponential-family coordinates

**Role:** Summary.

**Intention / goal:** Consolidate the complete mapping from ordinary Gaussian parameters `(μ,Σ)` to the exponential-family pieces. The section should be independently removable to a recording without creating a conceptual gap in Section 3.

**Summary candidates (from earlier slides):**

- Slide 3's expanded quadratic with data-dependent and parameter-only terms separated, to recall where the mapping comes from.
- Slides 4–5's pairing of `T(x)=(x,xxᵀ)` with `Λμ` and `-½Λ`, to recall the Gaussian natural coordinates introduced in this section.

## Issues / critique

- The section is deliberately self-contained. If moved to a recording, Section 3 can open directly from Section 1's Bernoulli example as the live worked member of the family.
- Matrix vectorization/symmetry details should not create extra teaching moves unless implementation proves they are necessary for correctness.

## Upstream change requests

None.

---

# Section 3 — The log-partition function connects parameters to moments

## Working specification

- **Purpose:** show why the exponential-family representation is computationally useful.
- **Endpoint:** students understand `∇A(η)=E[T(X)]`, the covariance interpretation of `∇²A`, and natural versus mean parameters.
- **Sources:** Murphy Book 2 §§2.4.3–2.4.4.
- **Treatment:** first derivative Derive carefully live; second derivative State + derivational sketch; natural ↔ mean State + Motivate.
- **Extent:** ~18–20 minutes.
- **Boundary:** stop before sample likelihood and MLE.

No clarification is needed before a first organization draft.

## Proposed slides

### 1. The log-partition function connects parameters to moments

**Role:** Section title.

**Subtitle:** Normalization links natural parameters to means and covariance.

**Abbreviated title:** Log-partition moments.

**Intention / goal:** Frame the question of what the normalizing term reveals about a model's statistics.

### 2. The normalizer must change when the natural parameter changes

**Intention / goal:** Pose the problem behind `A(η)`: for every value of `η`, the density must still integrate or sum to one. This creates the identity from which the moment result follows.

### 3. Differentiating normalization exposes the expected sufficient statistic

**Intention / goal:** Carry out the central differentiation step carefully enough that students can see why an expectation of `T(X)` appears.

**Design note:** Progressive derivation; retain the normalization identity as carry-forward context.

### 4. The gradient of the log-partition function is the mean parameter

**Intention / goal:** State and interpret

`∇A(η) = Eη[T(X)]`.

Separate the result students should retain from the derivational algebra that produced it.

### 5. Bernoulli shows natural and mean parameters are two coordinates for one family

**Intention / goal:** Use `A'(η)` for Bernoulli to recover `p` and make the logistic map `η ↔ p` the concrete example of natural versus mean parameterization.

### 6. Differentiating again turns curvature into covariance

**Intention / goal:** Give the derivational sketch leading to

`∇²A(η) = Covη[T(X)]`.

Students should understand the covariance result and the resulting convexity of `A` without expanding into a separate convex-analysis topic.

### 7. The log-partition function converts parameters into moments

**Role:** Summary.

**Intention / goal:** Consolidate the first- and second-derivative identities: `∇A(η)` gives the mean sufficient statistic, while `∇²A(η)` gives its covariance.

**Summary candidates (from earlier slides):**

- Slides 2–3's normalization identity and differentiation step, to recall why model moments arise from `A`.
- Slide 4's `∇A(η)=Eη[T(X)]` and Slide 6's `∇²A(η)=Covη[T(X)]`, to recall the paired mean and covariance results.
- Slide 5's Bernoulli natural-to-mean parameter map, to recall a concrete instance of the first identity.

## Issues / critique

- The section now has one continuous argument: normalization → first derivative → mean coordinates → second derivative/covariance.
- Seven slides including the title slide for 18–20 minutes is compatible with the two derivational teaching moves.

## Upstream change requests

None.

---

# Section 4 — Learning an exponential-family model means matching model moments to data

## Working specification

- **Purpose:** turn the exponential-family representation into a general maximum-likelihood learning rule.
- **Endpoint:** derive the IID likelihood reduction, likelihood gradient, and MLE moment-matching condition; check it on Bernoulli.
- **Sources:** Murphy Book 2 §2.4.5; Book 1 §4.2 as supporting MLE scaffolding.
- **Treatment:** likelihood/sufficient statistics Derive; MLE moment matching Derive carefully live; Bernoulli Apply/check.
- **Extent:** ~16–18 minutes.
- **Boundary:** maximum entropy is a separate Section 5.

No clarification is needed before a first organization draft.

## Proposed slides

### 1. Learning an exponential-family model means matching model moments to data

**Role:** Section title.

**Subtitle:** IID likelihoods turn observed statistics into an estimation rule.

**Abbreviated title:** Moment matching.

**Intention / goal:** Frame the question of how observed data determine the natural parameter of a specified family.

### 2. An IID sample enters the likelihood through its aggregate sufficient statistic

**Intention / goal:** Form the exponential-family sample likelihood/log likelihood and show the repeated single-observation terms collecting into `T(D)=ΣnT(xn)`.

### 3. Differentiating the likelihood reuses the log-partition moment identity

**Intention / goal:** Differentiate the log likelihood while carrying forward `∇A(η)=Eη[T(X)]` from Section 3.

### 4. The likelihood gradient compares empirical and model statistics

**Intention / goal:** Isolate and interpret

`∇ηℓ(η) = T(D) - N Eη[T(X)]`.

Students should see the score as a discrepancy between what the data contain and what the current model expects.

### 5. At the MLE, model moments match empirical moments

**Intention / goal:** Set the score to zero and foreground

`Eη̂[T(X)] = (1/N) Σn T(xn)`.

This is the central learning result of the lecture.

**Design note:** A brief note may mention that convexity of `A` makes the regular exponential-family log likelihood concave; do not create a separate slide for this consequence.

### 6. Bernoulli moment matching recovers the sample proportion

**Intention / goal:** Perform a quick sanity check using a model students already know. The general machinery should collapse immediately to the familiar Bernoulli MLE.

### 7. Maximum likelihood in an exponential family is moment matching

**Role:** Summary.

**Intention / goal:** Consolidate the full learning chain

`data → sufficient statistic → likelihood gradient → matched model moment`

and close the MLE argument.

**Summary candidates (from earlier slides):**

- Slide 2's dataset statistic `T(D)=ΣnT(xn)`, to recall how the sample enters the likelihood.
- Slides 4–5's score discrepancy and moment-matching condition, to recall the derivation's central comparison and result.
- Slide 6's Bernoulli sample-proportion check, to recall a familiar instance of the general rule.

## Issues / critique

- Removing maximum entropy and the standalone concavity slide makes this section a single coherent estimation argument.
- Seven slides including the title slide for 16–18 minutes appears plausible given that Slides 2–5 carry the derivation.

## Upstream change requests

None.

---

# Section 5 — Moment constraints and maximum entropy lead to exponential families

## Working specification

- **Purpose:** answer a different question from Section 4: how should we choose a distribution when only certain expected feature values are assumed known?
- **Endpoint:** students understand expected-feature constraints, minimum KL / maximum entropy, and why the constrained optimum has exponential-family form.
- **Sources:** Murphy Book 2 §2.4.7.
- **Treatment:** conceptual setup Motivate; KL/max-entropy relation State + Explain; Lagrange derivation Proof sketch.
- **Extent:** ~8–10 minutes.

No clarification is needed before a first organization draft.

## Proposed slides

### 1. Moment constraints and maximum entropy lead to exponential families

**Role:** Section title.

**Subtitle:** Choose a distribution from expected features and a reference measure.

**Abbreviated title:** Maximum entropy.

**Intention / goal:** Frame the model-construction question that begins with known feature expectations.

### 2. Moment constraints state what we know about an otherwise unknown distribution

**Intention / goal:** Start from constraints `E[f_k(X)] = F_k`. Make clear that the constraints are inputs to a new model-construction problem, not consequences of the MLE derivation.

### 3. Maximum entropy chooses the least committed distribution satisfying those constraints

**Intention / goal:** Explain Murphy's more general minimum-KL-to-`q` formulation and the uniform-`q` special case of maximum entropy. The principle is to satisfy the constraints without adding unsupported structure.

### 4. Lagrange multipliers turn feature constraints into exponential-family natural parameters

**Intention / goal:** Give the proof sketch: constrained optimization yields an exponential form in the features `f_k(x)`, with the multipliers becoming natural parameters and the reference distribution becoming the base measure.

### 5. Moment constraints plus maximum entropy produce an exponential-family model

**Role:** Summary.

**Intention / goal:** Consolidate how expected-feature constraints, the minimum-KL principle, and Lagrange multipliers yield an exponential-family form.

**Summary candidates (from earlier slides):**

- Slide 2's feature constraints `E[f_k(X)]=F_k`, to recall what information the construction starts from.
- Slide 3's minimum-KL-to-`q` principle and uniform-reference special case, to recall the selection criterion.
- Slide 4's multiplier-to-natural-parameter mapping, to recall why the solution has exponential-family form.

## Issues / critique

- Concavity of the MLE objective is deliberately absent because it is not the conceptual bridge to maximum entropy.
- The deeper convex-duality relation between the two views is real but intentionally outside the current slide sequence.

## Upstream change requests

None.

---

# Section 6 — Maximum likelihood fits a Gamma model to rainfall data

## Working specification

- **Purpose:** apply the general learning rule to real, positive, skewed rainfall data using a nontrivial two-parameter family.
- **Endpoint:** students see the Gamma sufficient statistics, the compression to `Σx` and `Σlog x`, and the fitted model.
- **Primary source:** MIT 18.443 rainfall/Gamma project; related Python precipitation example from Chris Fonnesbeck.
- **Treatment:** Gamma EF representation only enough to identify `T`; sample reduction and MLE Apply Section 4; digamma State.
- **Extent:** ~7–9 minutes.

No clarification is needed before a first organization draft.

## Proposed slides

### 1. Maximum likelihood fits a Gamma model to rainfall data

**Role:** Section title.

**Subtitle:** Two sufficient statistics connect a positive-data fit to the general learning rule.

**Abbreviated title:** Gamma rainfall fit.

**Intention / goal:** Frame the real-data test of the general MLE rule with a two-parameter positive-data model.

### 2. Rainfall amounts are positive and strongly right-skewed

**Intention / goal:** Begin with the actual precipitation data. Establish the empirical modeling problem and why a symmetric Gaussian is not an obvious choice.

**Design note:** Data visualization should dominate.

### 3. A Gamma model summarizes the rainfall through `x` and `log x`

**Intention / goal:** Introduce the Gamma model only far enough to identify `T(x)=(log x,x)` and connect the family to the exponential-family machinery already established.

### 4. The Gamma MLE depends on `Σx` and `Σlog x`

**Intention / goal:** Apply Section 4 directly: the sample likelihood reduces to two aggregate statistics, and the MLE matches their model expectations. Acknowledge the digamma equation without making numerical solution a teaching move.

### 5. A low-dimensional sufficient statistic determines a useful rainfall fit

**Role:** Summary.

**Intention / goal:** Return to the empirical distribution with the fitted Gamma overlaid. Consolidate the data-to-statistics-to-fit chain visually rather than adding more algebra.

**Summary candidates (from earlier slides):**

- Slide 2’s rainfall distribution, to recall the empirical shape that motivated the model.
- Slides 3–4’s `T(x)=(log x,x)` and sample aggregates `Σlog x`, `Σx`, to recall the compression used by the fit.

## Issues / critique

- Four slides preserve the pedagogical payoff without turning the application into a second derivation sequence.
- The example remains substantive because the nontrivial sufficient statistic `log x` is still explicit.

## Upstream change requests

None.

---

# Section 7 — Categorical distributions extend the same learning rule to multiple outcomes

## Working specification

- **Purpose:** extend Bernoulli/exponential-family machinery to `K` outcomes and prepare Markov estimation.
- **Endpoint:** students understand one-hot sufficient statistics, softmax/natural parameters, and count-and-normalize MLE.
- **Sources:** Murphy Book 2 §2.2.1.2 and categorical treatment in §2.4.2.
- **Treatment:** sufficient statistics Motivate + State; softmax selectively; counts + MLE combined as Apply.
- **Extent:** ~10–12 minutes.
- **Boundary:** no sequence dependence yet.

No clarification is needed before a first organization draft.

## Proposed slides

### 1. Categorical distributions extend the same learning rule to multiple outcomes

**Role:** Section title.

**Subtitle:** One-hot indicators turn observations into normalized counts.

**Abbreviated title:** Categorical learning.

**Intention / goal:** Frame a `K`-outcome extension of Bernoulli that reuses the exponential-family form and general MLE rule.

### 2. Categorical data replace one binary indicator with a one-hot vector

**Intention / goal:** Move from Bernoulli to `K` mutually exclusive outcomes using indicator variables. This should feel like a structural extension of familiar binary data.

### 3. Category indicators are the sufficient statistics

**Intention / goal:** Identify the one-hot `T(x)` and base measure on the category support. Students should see that `E[T_k(X)] = p_k`, setting up normalized counts as moment matching.

### 4. Natural parameters become category probabilities through softmax

**Intention / goal:** Identify the categorical log-partition term and develop the natural-parameter representation far enough to explain the softmax map and reference-category/redundancy issue.

### 5. Category counts are sufficient statistics, and normalization gives their MLE

**Intention / goal:** Combine sample aggregation and estimation in one move:

`N_k = Σn 1(x_n=k)`,  `p̂_k=N_k/N`.

Students should recognize “count and normalize” as the categorical instance of the same moment-matching rule.

### 6. For categorical models, learning means count and normalize

**Role:** Summary.

**Intention / goal:** Consolidate the categorical exponential-family mapping and how its probabilities are learned from indicator statistics and normalized counts without a fresh MLE derivation.

**Summary candidates (from earlier slides):**

- Slides 2–3's one-hot indicator vector and `E[T_k(X)]=p_k`, to recall the categorical statistic and its model moment.
- Slide 4's log-partition/softmax map, to recall how natural coordinates yield category probabilities.
- Slide 5's counts `N_k` and normalized MLE `p̂_k=N_k/N`, to recall the count-and-normalize result.

## Issues / critique

- Combining the old count slide and MLE slide removes an unnecessary separation between a statistic and the immediate estimator derived from it.
- Six slides including the title slide for 10–12 minutes appears plausible; only the softmax slide requires substantial new algebra.

## Upstream change requests

None.

---

# Section 8 — A Markov model learns one categorical distribution for each preceding state

## Working specification

- **Purpose:** turn categorical estimation into a learned sequence model and establish the notebook handoff.
- **Endpoint:** students can read the first-order factorization, interpret rows of `A` as categorical conditionals, identify transition counts as sufficient statistics, derive normalized-count MLE, and understand scoring/generation.
- **Sources:** Murphy Book 2 §§2.6.1–2.6.3 and Figs. 2.15/2.17; course-generated first-order character sample from the validated *The Time Machine* bigram transition matrix.
- **Treatment:** factorization State + Motivate; transition matrix Work/Apply; transition-count MLE Apply prior results.
- **Empirical application:** character-level text modeling.
- **Extent:** ~20–24 minutes.
- **Boundary:** stop before stationary distributions; smoothing is optional notebook extension.

No clarification is needed before a first organization draft.

## Proposed slides

### 1. A Markov model learns one categorical distribution for each preceding state

**Role:** Section title.

**Subtitle:** Transition counts fit conditional categorical models for sequence data.

**Abbreviated title:** Markov learning.

**Intention / goal:** Frame the shift from one categorical model to a collection of conditional categorical models for sequences.

### 2. Sequence models need conditional probabilities, not independent draws

**Intention / goal:** Establish why the categorical model from Section 7 is insufficient for text or other ordered data. The next symbol depends on context.

### 3. A first-order Markov model keeps only the previous state as context

**Intention / goal:** State the Markov assumption and factorization

`p(x1:T) = p(x1) ∏t=2:T p(xt | x(t-1))`.

Use the state-transition diagram to make the conditional structure concrete.

### 4. Each transition-matrix row is one categorical distribution

**Intention / goal:** Connect Markov structure directly to Section 7. For a fixed previous state `j`, the row `Aj·` is simply a categorical model over the next state.

### 5. Transition counts are the sufficient statistics for a Markov chain

**Intention / goal:** Introduce `Njk` by counting observed `j→k` transitions and show how the sequence likelihood groups into row-wise categorical factors.

### 6. Normalizing each row gives the maximum-likelihood transition matrix

**Intention / goal:** Reuse categorical moment matching to obtain

`Âjk = Njk/Nj`.

The result should feel inevitable from Sections 4 and 7 rather than like another independent MLE derivation.

### 7. Character bigrams turn text into a transition-count matrix

**Intention / goal:** Move to the real-data application. Use Murphy's raw bigram-count visualization to show how a corpus becomes `Njk`.

**Design note:** Let the empirical matrix be the dominant object; connect selected cells back to actual character transitions.

### 8. Row normalization turns bigram counts into next-character distributions

**Intention / goal:** Use Murphy's normalized version of the same matrix to make the fitted conditional probabilities visible. This is the empirical counterpart of Slide 6.

### 9. The fitted Markov model assigns probabilities to new sequences

**Intention / goal:** Reuse the factorization with learned `Â` to show how an unseen string receives a probability. This establishes the model as more than a descriptive transition table.

### 10. Sampling the fitted transitions generates new text

**Intention / goal:** Show the generative consequence using an explicitly labeled course-generated first-order character sample from the same validated *The Time Machine* bigram transition matrix used in this section, with a declared initial distribution or starting character. Students should see generation as repeated sampling from the learned row corresponding to the current state.

### 11. From text to a fitted Markov model

**Role:** Summary.

**Intention / goal:** Consolidate

`text → transition counts → normalized rows → sequence probability / generation`.

**Summary candidates (from earlier slides):**

- Slides 3–4’s factorization and transition-matrix rows, to recall the model’s conditional structure.
- Slides 5–8’s transition counts and row normalization, to recall the data-to-parameter map.
- Slides 9–10’s sequence scoring and generation, to recall what the fitted model does.

## Issues / critique

- Eleven slides including the title slide for 20–24 minutes is plausible because several are empirical/visual rather than algebra-heavy.
- Raw counts and normalized rows remain separate teaching moves because they distinguish the observed data from the learned conditional model.
- Sequence scoring and generation remain separate because they are distinct uses of the same fitted model.

## Upstream change requests

None.

---

# Lecture-level notebook handoff

After the Section 8 summary, introduce the one-hour student notebook as a separate lecture-level activity, not as part of a section summary or an additional slide. The notebook operationalizes the established chain `sequence data → transition counts → fitted transition matrix → inspection / scoring / generation`. The proposed section-slide count remains 53.

---

# Whole-lecture critique

## Title-sequence test

The titles now recover a more explicit lecture argument:

1. familiar distributions share an exponential-family representation;
2. the Gaussian provides a full familiar derivation and a removable recording unit;
3. derivatives of the log-partition function produce moments;
4. maximum likelihood matches those model moments to empirical sufficient statistics;
5. maximum entropy is a separate reverse characterization: feature constraints produce exponential-family models;
6. Gamma rainfall makes MLE moment matching concrete on real data;
7. categorical learning becomes count and normalize;
8. Markov models repeat that categorical learning rule across conditioning states.

## Extent

Proposed section slides, including title and summary slides:

- Section 1: 6
- Section 2: 6
- Section 3: 7
- Section 4: 7
- Section 5: 5
- Section 6: 5
- Section 7: 6
- Section 8: 11

**Total: 53 section slides** (8 title slides, 37 other teaching slides, and 8 summaries). With the separate lecture title slide, the planned deck has **54 slides**.

Moving Section 2 to a recording would reduce the live deck to 47 section slides, or 48 including the lecture title, without damaging the remaining dependency chain.

## Main backpressure items

No blocking backpressure remains at the organization stage.

The main timing uncertainty is now empirical rather than structural: Sections 3–5 contain the densest mathematical reasoning. If rehearsal runs long, Section 2 is the cleanest whole-section recording move, followed by reducing the maximum-entropy proof sketch rather than compressing the central MLE derivation.

## Open issues / explicit assumptions

1. Concavity of the regular exponential-family likelihood is treated only as a brief consequence within the MLE section, not as its own slide.
2. The maximum-entropy section intentionally avoids full convex-duality machinery.
3. Section 2 remains fully live until an explicit recording decision is made.

## Upstream change requests

None.
