# L01 provisional Lecture Scope — intellectual arc only

**Status:** proposed for instructor discussion, 2026-10-14; not an agreed Scope or independent feasibility verdict. Only the intellectual arc is developed; four Scope parts await discussion.

**Baseline:** branch `rescope-l01-l12-architecture-alignment-20261014`, HEAD `ab5fdcdaa4aaa22d4ba0bb2bc701ddceee5d6b49`. Reviewed blobs: deck `235b8eeb48ec9075d2bcea82b6a377c0a45b6a79`; coverage specification `c4457bc4fdb11df14de54658f20e487030766328`; solved notebook `ab441941c8b526151a927bfbcf292bd9bc629ce5`; architecture `cb111196e44df211e39864be596233a1a3f22aba`; planned map `63fb5cea0a7b0a4c908c8f803e550d087d20a412`. Core L01 artifacts match named source branches; no branch was switched or merged. [Raw assessments and reconciliation](reconciliation/matrix.md) retain earlier evidence.

**Accepted direction:** the instructor's “Sounds good,” recorded in [development state](development_state.md), accepts different questions on one formulation in principle: conditioning $p(z\mid y)$, summarizing $E[Z\mid y]$ under squared loss, and marginalizing $p(y)$, with hidden-value inference, forward prediction and short generation. Operations and uses overlap; sequence, depths, timing and implementation remain proposed.

## Reconstructing the arguments

The existing lecture establishes learning-problem formulation, then makes joint probability operational. Covariance geometry and affine rules justify marginals; an independent residual justifies conditionals; these rules construct a linear-Gaussian joint and uncertainty-weighted state update. Forward prediction and posterior summaries reuse the model. The notebook presently compares two computations of one conditional, rather than contrasting questions.

Murphy Book 2, *Advanced Topics*, December 10, 2025 online edition, Chapter 1 (printed pp. 1–2), links model choice to task, available data and success metrics. Its §2.3 moves from Gaussian geometry through closed marginal/conditional laws, block-quadratic derivation, and linear measurement models to posterior and forward measurement distributions. The existing residual proof is a justified reorganization of §2.3.1.5 “Derivation: moment form”: it gives the Schur complement a probabilistic meaning without first proving a block inverse. Book 1, *An Introduction*, April 18, 2025 online edition, §3.2.5 “Example: Imputing missing values” applies conditioning and separates its posterior from the mean used as an imputation; §5.1.5.1 “L2 loss” explains why that mean is appropriate. The course's synthetic 3+4-dimensional example is distinct from Murphy's imputation example.

**Recommended reconciliation:** preserve this mathematical chain and strengthen its formulation-to-query hinge. Keep the experience/task distinction and concrete Iris illustration; reduce repeated symbolic/catalogue material only as needed to fund the hinge and interpretation. Do not restore the coverage specification's unimplemented MLE/MAP unit automatically. A small architecture-side amendment should describe L01 as **Gaussian inference for incomplete and noisy measurements**, with different questions on one model, rather than foreground imputation alone. No architecture or map amendment is made here.

## Proposed intellectual destination and validity regime

The problem family is correlated continuous measurements, some hidden or noisy. Experience here is a supplied/calibrated model, not parameter fitting from a training sample. The existing seven-dimensional example establishes controlled method use, not realism or a scaling bottleneck.

**Mathematical endpoint:** students explain how one joint model supports distributions and summaries through different operations, and why affine Gaussian closure makes the answers exact. **Practical endpoint:** students formulate and compute a hidden-block distribution, choose its mean when squared reconstruction loss is intended, obtain the forward measurement law, and distinguish generating another case from estimating this case's hidden values. They interpret remaining uncertainty and check equations against a reference computation.

The model requires jointly Gaussian variables with positive-definite covariance, or a Gaussian state with independent additive Gaussian noise and a linear measurement law. Dense conditioning factors an observed $D\times D$ covariance, costing $O(D^3)$; with fixed parameters and observation pattern, the factorization and gain can be reused, and a subsequent $L$-dimensional posterior mean costs $O(LD)$. This analytic structure avoids generic sampling for these queries. Seven dimensions illustrate the saving, not a need for approximation. Numerical error remains; incorrect covariance, nonlinear dependence, non-Gaussian tails or omitted parameter uncertainty can still give misleading answers. The Gaussian conditional covariance's independence from measured values is a validity restriction, not a universal property of Bayesian inference.

## Provisional macro milestones

These milestones are not a section partition. All are provisionally live; allocations within 120 minutes are unmeasured estimates.

### 1. Reactivate the model–question distinction — about 10 minutes

**Entry/reason:** students bring undergraduate probability, Bayesian modeling and matrix algebra. Recall the Beta–Bernoulli model and observed/unknown distinction rather than reteaching inference. Ask what a posterior supplies and what another requested output would require. Graphs are notation here, not general graphical-model theory. Source: existing opening and Book 2 Chapter 1.

**Treatment:** review model, Bayes and conjugacy; interpret uncertainty in the displayed example without asserting universal uncertainty reduction.

**Retrospective:** a model specifies uncertain quantities; an answer depends on the question asked of it.

### 2. Formulate learning problems and make the query concrete — about 35 minutes

**Transition/reason:** familiar Bayesian quantities become useful ML answers only after specifying task, available experience and performance. Retain Iris as a concrete task/experience/loss instance and experience versus task as distinct axes. Then enact the conversion on the supplied measurement formulation: observations, hidden quantities, and requested distribution or point answer. Source: Book 2 Chapter 1; existing Iris/taxonomy material; Book 1 §3.2.5 and §5.1.5.1.

**Treatment:** work one formulation; mention broader task families through their roles rather than requiring every custom symbolic template. Distinguish training risk from future-case performance, and parameter learning from inference with given parameters. Motivate a conditional expectation as a loss-dependent summary; defer its short derivation to milestone 5.

**Retrospective:** a dataset does not determine its task, query or success criterion; inference and parameter fitting have different unknowns.

### 3. Represent and transform joint Gaussian uncertainty — about 20 minutes

**Transition/reason:** the measurement questions require a joint distribution that retains dependence. Gaussian structure makes that distribution manageable. Source: Book 2 §2.3.1.1 “Definition”; existing affine and three-operation explanations; Book 1 §3.2.4 “Example: conditioning a 2d Gaussian.”

**Treatment:** review covariance/correlation, work contour interpretation, derive affine covariance transformation, and state affine Gaussian closure. Contrast integrating a coordinate with fixing and normalizing a slice. Mahalanobis distance supports geometry; it is not a separate application endpoint.

**Retrospective:** mean and covariance encode Gaussian joint uncertainty; affine operations preserve the family, while marginalization and conditioning use different information.

### 4. Explain Gaussian conditioning through residual uncertainty — about 25 minutes

**Transition/reason:** the preceding geometry distinguishes the operations but does not establish their answers. Source: Book 2 §2.3.1.3 “Marginals and conditionals of an MVN” and §2.3.1.5 “Derivation: moment form.”

**Treatment:** derive marginals by selection; sketch the residual argument with $B=\Sigma_{12}\Sigma_{22}^{-1}$ and $r=X_1-\mu_1-B(X_2-\mu_2)$. Joint Gaussianity plus zero residual cross-covariance gives independence. Derive the conditional mean and residual covariance; work a bivariate check. Interpret the Schur complement. Provisionally state and interpret the quadratic separation rather than adding a second full derivation.

**Retrospective:** conditioning shifts the mean and removes explained covariance; Gaussian residual independence establishes the entire conditional law, not just its moments.

### 5. Use one linear-Gaussian model for inverse and forward questions — about 20 minutes

**Transition/reason:** a generative state/measurement description must supply the joint blocks needed by the established rules. Source: Book 2 §§2.3.2.1 “Joint distribution,” 2.3.2.2 “Posterior distribution (Bayes’ rule for Gaussians),” 2.3.2.3 “Example: Sensor fusion with known measurement noise”; Book 1 §5.1.5.1.

**Treatment:** derive the LGS joint blocks and apply conditioning to the gain update; work scalar uncertainty regimes. Contrast $p(z\mid y)$ with $p(y)=\int p(z,y)\,dz$: forward prediction under fixed parameters, not posterior prediction averaged over uncertain parameters. Briefly derive $\arg\min_a E[\|Z-a\|^2\mid y]=E[Z\mid y]$. Interpret sensor fusion with explicit conditional-noise and prior assumptions; generation uses the probability laws, rather than defining another inference operation.

**Retrospective:** the same measurement model answers inverse and forward questions; uncertainty controls evidence combination, and a loss determines which posterior summary is useful.

## Extent, alternative and decisions returned

The allocations total about 110 minutes, leaving roughly 10 for questions and slippage. Assessment: **plausible but tight**, especially residual reasoning plus LGS interpretation. The instructor's earlier L01 length judgment is the strongest available anchor; no rehearsal or teaching time exists. Current PDF has 67 pages/seven sections, not timing calibration's stale 70/eight. Repeated equations are carried support, not equal amounts of novelty. The separate 60-minute guided notebook must reuse existing questions selectively to add forward prediction/generation; retaining every current PyMC/API step plus those additions is not presumed feasible.

A serious alternative begins from the supplied measurement problem before the broad taxonomy, states conditioning for early use, then reconstructs its Gaussian justification and LGS interpretation. It preserves the same notebook aim and mathematical endpoint, improves immediate practical motivation, but changes more of the opening and asks students to use a result before understanding why it holds. Recommend the existing general-to-operational route with a concrete hinge first.

**Instructor choices for discussion:** (1) retain that route or adopt the measurement-first alternative; (2) endorse the residual proof sketch with quadratic separation interpreted, or require both derivations live, which needs additional time funded from framing or LGS interpretation. These are proposed commitments, not technical approval requests.

**Prerequisite effects:** preserve Gaussian density, quadratic reasoning, conditioning, joint reasoning and simple graph familiarity for L02/L03. L02 already introduces $\Lambda=\Sigma^{-1}$ during its Gaussian rewrite; correcting its claim that L01 taught information coordinates appears smaller than adding an L01 unit. L03's entry assumptions remain supported; no d-separation or plates are established here. Neither later lecture is rescoped.

**Next gate:** instructor discusses the arc through the coordinator. After agreement, develop four remaining Scope parts iteratively, then obtain source-arc review where warranted and Section Design preview before complete Scope approval. Downstream implementation remains gated.
