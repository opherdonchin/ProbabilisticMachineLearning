# Lecture 2 slide organization — draft

This file applies `skills/slide-level-organization/SKILL.md` to the current section contracts in `section_design.md`.

This is an **organization draft for instructor review**, not an approved slide-design specification. It owns slide titles, order, and concise teaching intentions. It does not prescribe finished layouts or Typst implementation.

## Lecture-level organization

Current trajectory:

Exponential-family representation → moments from the log-partition function → learning by moment matching → Gamma rainfall application → categorical counts → Markov learning from transition counts.

Proposed content-slide count: **41** (excluding title and section-divider slides).

The organization is intentionally less dense in slide count than Lecture 1 because Sections 2–4 contain sustained derivations and worked mathematical development.

---

# Section 1 — Exponential families give familiar distributions a common form

## Working specification

- **Purpose:** introduce the exponential-family representation as a useful common coordinate system.
- **Endpoint:** students can identify `h(x)`, `T(x)`, `η`, and `A(η)` in familiar distributions and understand their roles.
- **Sources:** Murphy Book 2 §§2.4.1–2.4.2; Book 1 §3.4 as supporting exposition.
- **Treatment:** general form State + Motivate; Bernoulli Work through; Gaussian Recognize/connect to Lecture 1.
- **Extent:** ~15–18 minutes.
- **Boundary:** no derivatives of `A`, MLE, or categorical material yet.

No clarification is needed before a first organization draft.

## Proposed slides

### 1. Different distributions can share the same algebraic structure

**Intention / goal:** Motivate why the lecture is changing representation. Students should see exponential families as a way to expose common structure across familiar distributions, not as another list of probability distributions.

**Design note:** Revisit Bernoulli and Gaussian only as familiar anchors; avoid doing algebra yet.

### 2. Exponential families separate data statistics from natural parameters

**Intention / goal:** State the general form

`p(x | η) = h(x) exp(ηᵀT(x) - A(η))`

and establish the four roles `h`, `T`, `η`, and `A` before specializing it.

**Design note:** Keep the general form persistent enough that the next examples can map their terms onto it.

### 3. Bernoulli already has the exponential-family form

**Intention / goal:** Work from the ordinary Bernoulli probability to the exponential-family representation. Make the sufficient statistic `T(x)=x` and the natural parameter emerge from familiar algebra rather than appear as definitions.

### 4. Bernoulli log odds are its natural parameter

**Intention / goal:** Interpret `η = log(p/(1-p))` and identify `A(η)`. The point is that the new coordinates are meaningful, not merely an algebraic rewrite.

**Design note:** Carry forward the result of the previous slide rather than restarting the derivation.

### 5. Gaussian precision coordinates are natural parameters too

**Intention / goal:** Connect the representation to Lecture 1. Show that the precision/information coordinates already encountered there are the Gaussian natural parameters, so the new framework unifies rather than replaces prior material.

**Design note:** Recognition/comparison, not a second full Gaussian derivation.

### 6. One representation exposes the same ingredients across families

**Intention / goal:** Consolidate the roles of sufficient statistics, natural parameters, base measure, and log-partition function across Bernoulli and Gaussian. End with the question that motivates Section 2: what does the log-partition function actually buy us?

## Issues / critique

- **Gaussian-detail tension:** the section contract mentions full Gaussian canonical algebra as a recording candidate while also specifying that the live treatment should be recognition rather than a second full derivation. The draft follows the latter and does not allocate a separate full-algebra slide. If the fuller algebra is meant to remain genuinely live until a recording decision, it would require additional slide/time allocation.
- **Extent:** six content slides for 15–18 minutes appears plausible given that only the Bernoulli transformation is worked in detail.

## Upstream change requests

None required for the draft. Clarify the intended status of the full Gaussian canonical algebra before final approval.

---

# Section 2 — The log-partition function connects parameters to moments

## Working specification

- **Purpose:** show why the exponential-family representation is computationally useful.
- **Endpoint:** students understand `∇A(η)=E[T(X)]`, the covariance interpretation of `∇²A`, and natural versus mean parameters.
- **Sources:** Murphy Book 2 §§2.4.3–2.4.4.
- **Treatment:** first derivative Derive carefully live; second derivative State + derivational sketch; natural ↔ mean State + Motivate.
- **Extent:** ~18–22 minutes.
- **Boundary:** stop before sample likelihood and MLE.

No clarification is needed before a first organization draft.

## Proposed slides

### 1. The normalizer must change when the natural parameter changes

**Intention / goal:** Pose the problem behind `A(η)`: for every value of `η`, the density must still integrate or sum to one. This creates the identity from which the moment result will follow.

### 2. Differentiating normalization exposes the expected sufficient statistic

**Intention / goal:** Carry out the central differentiation step carefully enough that students can see why an expectation of `T(X)` appears rather than treating the result as a trick.

**Design note:** Progressive derivation; retain the normalization identity as carry-forward context.

### 3. The gradient of the log-partition function is the mean parameter

**Intention / goal:** State and interpret the completed result

`∇A(η) = Eη[T(X)]`.

Separate the result students should retain from the derivational algebra that produced it.

### 4. Bernoulli turns the general identity into the logistic function

**Intention / goal:** Check the abstract result in the running example: differentiating Bernoulli's `A(η)` returns `E[X]=p`, with `p` related to `η` through the logistic transformation.

### 5. Differentiating again turns curvature into covariance

**Intention / goal:** Give the derivational sketch leading to

`∇²A(η) = Covη[T(X)]`.

Students should understand both the covariance result and why it implies convexity of `A` without expanding into a separate convex-analysis development.

### 6. Natural parameters and mean parameters are two coordinates for one family

**Intention / goal:** Motivate the mapping `η ↔ μ = E[T(X)]` and prepare the conceptual move to estimation: if data tell us empirical values of `T`, perhaps we can choose `η` to reproduce them.

### 7. The log-partition function converts parameters into moments

**Intention / goal:** Consolidate Section 2 around the two derivative identities and explicitly hand off to Section 3: model moments are now available as functions of the parameters.

## Issues / critique

- The section's intellectual argument is linear and dependency order is clean: normalization → first derivative → interpretation → check → second derivative → parameterizations.
- Seven slides is appropriate for the proposed 18–22 minutes because two slides carry derivational work rather than merely stating results.
- The convex-conjugate material is deliberately absent, as required by the section contract.

## Upstream change requests

None.

---

# Section 3 — Learning an exponential-family model means matching model moments to data

## Working specification

- **Purpose:** turn the exponential-family representation into a general learning rule.
- **Endpoint:** derive the IID likelihood reduction, likelihood gradient, MLE moment-matching condition, and motivate the maximum-entropy interpretation.
- **Sources:** Murphy Book 2 §§2.4.5 and 2.4.7; Book 1 §4.2 as supporting MLE scaffolding.
- **Treatment:** likelihood/sufficient statistics Derive; MLE moment matching Derive carefully live; Hessian Brief/State; maximum entropy Motivate + Proof sketch.
- **Extent:** ~22–27 minutes.
- **Boundary:** no full empirical application and no categorical extension yet.

No clarification is needed before a first organization draft.

## Proposed slides

### 1. A sample enters the likelihood through a sum of sufficient statistics

**Intention / goal:** Form the IID likelihood and log likelihood for an exponential-family sample. Students should see the repeated single-observation structure collapse naturally into `Σn T(xn)`.

### 2. The full dataset reduces to an aggregate sufficient statistic

**Intention / goal:** Make the statistical meaning explicit: for likelihood-based inference about `η`, the data influence the likelihood through `T(D)=Σn T(xn)` (plus parameter-independent terms).

**Design note:** Distinguish the formal factorization from the conceptual claim that the data have been compressed for this model.

### 3. Maximum likelihood asks when the score is zero

**Intention / goal:** Differentiate the sample log likelihood. Carry forward `∇A(η)=Eη[T(X)]` from Section 2 so the gradient takes an interpretable form.

### 4. The likelihood gradient compares empirical and model statistics

**Intention / goal:** Isolate the load-bearing equation

`∇ηℓ(η) = Σn T(xn) - N Eη[T(X)]`

and interpret the two sides before setting the gradient to zero.

### 5. At the MLE, model moments match empirical moments

**Intention / goal:** Derive and foreground

`Eη̂[T(X)] = (1/N) Σn T(xn)`.

This is the central learning result of the lecture and should be identifiable independently of the derivation that preceded it.

### 6. Bernoulli moment matching recovers the sample proportion

**Intention / goal:** Perform a quick sanity check on the general result using a model students already know. This confirms the machinery without becoming the empirical application.

### 7. Covariance makes the regular exponential-family likelihood concave

**Intention / goal:** Use the Section 2 Hessian identity to state the shape consequence for the likelihood. The goal is to explain why the stationary point is well behaved, not to open a new optimization topic.

### 8. Maximum entropy asks for the least committed distribution satisfying known moments

**Intention / goal:** Introduce the second interpretation of exponential families: maximize entropy subject to normalization and moment constraints. Establish the optimization problem and why it is a reasonable modeling principle.

### 9. Moment constraints produce an exponential-family solution

**Intention / goal:** Give the promised proof sketch: the Lagrange-multiplier stationarity condition yields an exponential form whose multipliers become natural parameters. Connect the result back to the representation from Section 1.

### 10. Exponential families connect data summaries, learning, and model construction

**Intention / goal:** Consolidate the section's two directions: exponential-family structure makes MLE become moment matching, while moment-constrained maximum entropy produces exponential-family structure. Hand off to Section 4 by asking what this looks like on real data with nontrivial sufficient statistics.

## Issues / critique

- **Extent pressure:** ten content slides in 22–27 minutes is plausible but tight because Slides 1–5 and 8–9 contain real derivational reasoning. The pressure comes from keeping both MLE and maximum entropy substantive in the same section.
- **Draft choice:** preserve both, as required. Keep the Hessian consequence to one concise slide and the maximum-entropy derivation to a two-slide proof sketch.
- **Possible relief if rehearsal is long:** the full Lagrange-multiplier derivation is already a recording candidate upstream; moving it would remove Slide 9 or radically simplify Slides 8–9. Until that decision is made, the draft counts it live.

## Upstream change requests

None yet. Revisit only if timing/slide design confirms the extent pressure.

---

# Section 4 — We can use methods of moments to fit a Gamma distribution

## Working specification

- **Purpose:** apply the general learning machinery to real, positive, skewed rainfall data using a nontrivial two-parameter family.
- **Endpoint:** students see the Gamma sufficient statistics, the compression to `Σx` and `Σlog x`, the fitted model, and the distinction between sufficient-statistic moment matching and ordinary raw-moment fitting.
- **Primary source:** MIT 18.443 rainfall/Gamma project; related Python precipitation example from Chris Fonnesbeck.
- **Treatment:** Gamma EF representation Work enough to identify `T` and `η`; likelihood reduction Work/Apply; MLE equations Apply Section 3; digamma State; ordinary MOM comparison optional but pedagogically attractive.
- **Extent:** ~10–15 minutes.

No clarification is required to produce a complete draft, but the section title creates a terminology tension noted below.

## Proposed slides

### 1. Rainfall amounts are positive and strongly right-skewed

**Intention / goal:** Begin with the actual precipitation data rather than the distribution. Establish the empirical modeling problem and why a symmetric Gaussian model is not an obvious choice.

**Design note:** Data visualization should dominate; avoid introducing Gamma algebra on this slide.

### 2. A Gamma family can describe positive skewed measurements

**Intention / goal:** Introduce the two-parameter Gamma model as a plausible model for the rainfall distribution and show what changing its parameters does to shape and scale.

### 3. Ordinary method of moments fits the Gamma from simple sample moments

**Intention / goal:** Present the conventional method-of-moments route used in the MIT example: equate ordinary theoretical moments to empirical moments to obtain a direct parameter estimate. This makes the section title literal and gives a concrete baseline fit.

### 4. Gamma sufficient statistics are `x` and `log x`

**Intention / goal:** Rewrite the Gamma model in exponential-family form and identify the nontrivial sufficient-statistic vector. The key surprise is the appearance of `log x` rather than a second raw power of `x`.

### 5. Exponential-family MLE matches `x` and `log x`, not mean and variance

**Intention / goal:** Apply Section 3 directly. Show that the likelihood depends on `Σxi` and `Σlog xi`, so EF-MLE matches expectations of those sufficient statistics. Acknowledge the digamma equation without making numerical root-finding the lesson.

### 6. The MOM and MLE fits use different summaries of the same rainfall data

**Intention / goal:** Compare the two fitted Gamma models and make the conceptual distinction explicit: ordinary method of moments chooses convenient raw moments; exponential-family MLE matches the expectations of the family's sufficient statistics.

**Design note:** Prefer simultaneous comparison over serial derivations.

### 7. A small set of summaries is enough to fit a useful rainfall model

**Intention / goal:** Return to the empirical distribution and fitted curves. Consolidate the sufficient-statistic lesson and close the application before changing domains to categorical data.

## Issues / critique

- **Terminology / emphasis pressure:** the section title foregrounds “methods of moments,” but its section contract is primarily intended to illustrate the Section 3 exponential-family MLE result. Ordinary MOM and EF moment matching are related but not identical procedures.
- **Draft choice:** make ordinary MOM a real teaching move (Slide 3), then use it as the contrast that clarifies EF-MLE (Slides 4–6). This preserves the title while still fulfilling the section contract.
- **Extent pressure:** seven slides in 10–15 minutes is moderately tight but plausible if the Gamma algebra is kept to identification/application rather than a fresh general derivation.

## Upstream change requests

None required, but instructor should confirm that the title intentionally wants ordinary MOM to receive this much prominence. If not, Slides 3 and 6 should be reduced and the section title reconsidered upstream rather than silently changed here.

---

# Section 5 — Categorical distributions extend the same learning rule to multiple outcomes

## Working specification

- **Purpose:** extend the Bernoulli/exponential-family machinery to `K` outcomes and prepare Markov estimation.
- **Endpoint:** students understand indicator sufficient statistics, softmax/natural parameters, category counts, and normalized-count MLE.
- **Sources:** Murphy Book 2 §2.2.1.2 and categorical treatment in §2.4.2.
- **Treatment:** sufficient statistics Motivate + State; softmax selectively; multinomial/count representation Brief; MLE Apply general moment matching.
- **Extent:** ~12–15 minutes.
- **Boundary:** no sequence dependence yet.

No clarification is needed before a first organization draft.

## Proposed slides

### 1. Categorical data replace one binary indicator with a one-hot vector

**Intention / goal:** Move from Bernoulli to `K` mutually exclusive outcomes using indicator variables. This should feel like a structural extension of familiar binary data, not a new statistical paradigm.

### 2. Category indicators are the sufficient statistics

**Intention / goal:** Identify the vector `T(x)` and its expectation. Students should see immediately that `E[T_k(X)] = p_k`, which sets up normalized counts as moment matching.

### 3. Natural parameters become probabilities through softmax

**Intention / goal:** Develop the natural-parameter representation only far enough to explain the softmax map and the reference-category/redundancy issue. Keep the connection to the EF framework visible.

### 4. A categorical sample reduces to category counts

**Intention / goal:** Aggregate the one-hot observations to `Nk = Σn 1(xn=k)`. Make the sufficient-statistic reduction concrete before estimating probabilities.

### 5. Moment matching makes fitted probabilities equal observed frequencies

**Intention / goal:** Apply the general Section 3 result rather than re-derive MLE from scratch:

`p̂k = Nk/N`.

Students should recognize “count and normalize” as the categorical form of the same learning rule.

### 6. For categorical models, learning means count and normalize

**Intention / goal:** Consolidate the section in a form that can be immediately reused in the Markov section, while stopping short of introducing sequence dependence itself.

## Issues / critique

- The section has a clean argument: representation → sufficient statistics → parameter map → sample counts → fit.
- Six slides for 12–15 minutes is plausible because only the softmax slide requires substantive new algebra.
- The multinomial distribution does not need a separate slide unless slide design reveals that the distinction between repeated categorical observations and count-vector representation is becoming unclear.

## Upstream change requests

None.

---

# Section 6 — A Markov model learns one categorical distribution for each preceding state

## Working specification

- **Purpose:** turn categorical estimation into a learned sequence model and establish the notebook handoff.
- **Endpoint:** students can read the first-order factorization, interpret rows of `A` as categorical conditionals, identify transition counts as sufficient statistics, derive normalized-count MLE, and understand scoring/generation.
- **Sources:** Murphy Book 2 §§2.6.1–2.6.3 and Figs. 2.15–2.17.
- **Treatment:** factorization State + Motivate; transition matrix Work/Apply; transition-count MLE Apply prior results.
- **Empirical application:** character-level text modeling.
- **Extent:** ~20–25 minutes.
- **Boundary:** stop before stationary distributions; smoothing is optional notebook extension.

No clarification is needed before a first organization draft.

## Proposed slides

### 1. Sequence models need conditional probabilities, not independent draws

**Intention / goal:** Establish why the categorical model from Section 5 is insufficient for text or other ordered data. The next symbol depends on context.

### 2. A first-order Markov model keeps only the previous state as context

**Intention / goal:** State the Markov assumption and factorization

`p(x1:T) = p(x1) ∏t=2:T p(xt | x(t-1))`.

Use the state-transition diagram to make the conditional structure concrete.

### 3. Each transition-matrix row is one categorical distribution

**Intention / goal:** Connect Markov structure directly to Section 5. For a fixed previous state `j`, the row `Aj·` is simply a categorical model over the next state.

### 4. Transition counts are the sufficient statistics for a Markov chain

**Intention / goal:** Introduce `Njk` by counting observed `j→k` transitions and show how the sequence likelihood groups into row-wise categorical factors.

### 5. Normalizing each row gives the maximum-likelihood transition matrix

**Intention / goal:** Reuse categorical moment matching to obtain

`Âjk = Njk/Nj`.

The result should feel inevitable from Sections 3 and 5 rather than like another independent MLE derivation.

### 6. Character bigrams turn text into a transition-count matrix

**Intention / goal:** Move to the real-data application. Use Murphy's raw bigram-count visualization to show how a corpus becomes `Njk`.

**Design note:** Let the empirical matrix be the dominant object; connect selected cells back to actual character transitions.

### 7. Row normalization turns bigram counts into next-character distributions

**Intention / goal:** Use Murphy's normalized version of the same matrix to make the fitted conditional probabilities visible. This is the empirical counterpart of Slide 5.

### 8. The fitted Markov model assigns probabilities to new sequences

**Intention / goal:** Reuse the factorization with learned `Â` to show how an unseen string receives a probability. This establishes the model as more than a descriptive transition table.

### 9. Sampling the fitted transitions generates new text

**Intention / goal:** Show the generative consequence using Murphy's generated-text example. Students should see generation as repeated sampling from the learned row corresponding to the current state.

### 10. The notebook will learn the same model directly from text

**Intention / goal:** Consolidate the full empirical pipeline

`text → transition counts → normalized rows → sequence probability / generation`

and hand off explicitly to the one-hour notebook.

## Issues / critique

- Ten slides for 20–25 minutes is plausible because several are empirical/visual rather than algebra-heavy.
- Slides 6 and 7 should remain separate teaching moves: raw counts answer “what did the data contain?” while normalized rows answer “what model did we learn?”. Combining them would weaken the lecture's central count-to-model transition.
- Sequence scoring (Slide 8) and generation (Slide 9) are also distinct uses of the same fitted model and justify separate slides.

## Upstream change requests

None.

---

# Whole-lecture critique

## Title-sequence test

The titles recover a coherent lecture argument:

1. familiar distributions share a representation;
2. the log-partition function maps natural parameters to moments;
3. likelihood learning matches those model moments to empirical statistics;
4. Gamma rainfall shows the distinction on real data;
5. categorical models reduce learning to normalized counts;
6. Markov models repeat that categorical learning rule across conditioning states.

## Extent

Proposed content slides by section:

- Section 1: 6
- Section 2: 7
- Section 3: 10
- Section 4: 7
- Section 5: 6
- Section 6: 10

**Total: 46 content slides.**

This is somewhat larger than the initial ~41-slide rough target but still plausible against the 100–120 minute scope and the Lecture 1 course-specific calibration. The reason is visible rather than hidden: Sections 3 and 4 each need more teaching moves than the coarse scope estimate suggested.

The lecture is derivation-heavy through Section 3, then becomes progressively more empirical/visual. That change of texture is desirable, but the first ~55–65 minutes may feel mathematically dense.

## Main backpressure items

### Extent pressure — Section 3

Keeping the full live MLE derivation, Hessian consequence, and maximum-entropy proof sketch produces ten slides. If rehearsal shows the lecture running long, the already-identified maximum-entropy derivation recording candidate is the cleanest place to recover time without damaging later dependencies.

### Terminology / emphasis pressure — Section 4

The current title foregrounds “methods of moments,” while the lecture's mathematical spine foregrounds exponential-family MLE moment matching. The draft resolves this provisionally by teaching ordinary MOM first and then contrasting it with EF-MLE. Instructor approval is needed before that emphasis is treated as final.

### Gaussian-detail pressure — Section 1

The current contract simultaneously says Gaussian treatment should be recognition rather than re-derivation and calls the full Gaussian algebra a recording candidate that remains live until moved. The draft follows the recognition-level treatment. Resolve this before final approval if the full algebra is intended to consume live time.

## Open issues / explicit assumptions

1. Section 4's current title is treated as intentional and therefore ordinary Gamma method-of-moments receives one substantive teaching slide plus a later comparison slide.
2. Full Gaussian canonical algebra is not given a separate live slide in Section 1.
3. Recording candidates remain conceptually live in the scope, but only material compatible with each section's stated treatment depth is instantiated as a slide-level move here.

## Upstream change requests

No automatic changes have been made to `section_design.md`. The three pressures above should be reviewed by the instructor before this organization is considered approved.
