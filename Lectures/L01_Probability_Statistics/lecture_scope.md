# L01 provisional Lecture Scope — intellectual arc only

**Agreed route:** retain the current formulation-to-Gaussian/LGS progression. Keep the residual derivation and stated/interpreted quadratic identity live; develop the full block-elimination proof in a separate recorded session. **Remaining proposal:** add the concrete problem-to-query and squared-loss connections, and selectively reduce repeated taxonomy/dataset exposition to accommodate the agreed notebook direction. These refinements and their timing await discussion.

**Status:** intellectual arc with selected instructor decisions, 2026-10-14; not a complete approved Scope. Route and live/recorded proof boundary are accepted. Remaining depths, refinements and workload are proposed. Exact versions are recorded below.

## Accepted instructor direction

The instructor's “Sounds good,” recorded in [development state](development_state.md), accepts in principle using the same dataset and probabilistic formulation to answer different questions: the hidden-block distribution $p(z\mid y)$, its summary $E[Z\mid y]$ under squared loss, and the forward measurement distribution $p(y)=\int p(z,y)\,dz$, with a short generation activity. Conditioning, summarization and marginalization are operations; inference, prediction and generation are uses that can combine those operations.

The instructor subsequently explicitly chose the current route, citing the substantial existing work and the absence of a deep architecture-driven reason to reorder it. They also selected a separate recorded full proof of quadratic separation, while retaining the residual derivation and stated/interpreted identity live. They endorsed using the existing Section Design → Slide Organization → Slide Design → Slide Authoring skills for that recording under the coordinator. These choices do not approve every milestone refinement, timing, taxonomy reduction, new context or proposed addition. Whether students must watch the recording remains open.

## 1. What the existing artifacts do

The [deck](slide_deck.typ) begins with **“A familiar modeling language”**: Beta–Bernoulli modeling, observed/unknown quantities, graphs, Bayes and conjugacy. **“From statistics to machine-learning problems,” “Classes of machine learning problems,”** and **“From datasets to learning problems”** use Iris features, labels, zero-one loss and a probabilistic classifier; distinguish experience from task; and illustrate dataset uses through MNIST, CIFAR-10 and IMDB. **“Summary: Probability for machine learning”** presents the three operations.

The remaining argument is cumulative. **“Joint Gaussian distributions and geometry”** develops covariance, contours and affine rules. **“Marginals and conditionals of a Gaussian”** obtains marginals by coordinate selection and derives conditional means and covariances through an independent Gaussian residual. **“The Schur complement is the residual covariance”** interprets the resulting matrix. **“The joint quadratic separates into conditional and marginal parts”** displays and interprets an identity; it does not prove a second complete conditioning derivation.

**“Linear Gaussian systems”** constructs the state/measurement joint, applies conditioning, interprets the gain through scalar noise regimes, and illustrates sensor fusion. **“Inference often combines conditioning and summarizing”** distinguishes a distribution from an estimate. **“The same model can also predict measurements”** obtains the forward marginal from the same joint.

The [solved notebook](../../InClass/Solutions/lecture1_missing_data.ipynb) supplies a seven-dimensional Gaussian with known parameters, hides three coordinates of one simulated observation, samples their conditional posterior with PyMC, rewrites the joint as an LGS, and compares exact and sampled means/SDs. Its final comparison answers one conditional query by two computational routes. The [coverage specification](lecture_01_coverage_spec.typ) proposes an estimation/MLE/MAP bridge and a different book-based notebook route; those units are not implemented in the current deck/notebook.

## 2. Critique: evidence and teaching consequences

**Formulation connects less strongly to computation than the Gaussian argument does.** The taxonomy/query material repeats symbolic descriptions; sustained model-to-answer computation occurs later. Students can retain category names without learning to choose variables, query and criterion. Historical persona reports identify this hinge, but are simulated readings of an earlier rendering, not classroom outcomes.

**The notebook does not yet exercise the accepted different-question endpoint.** PyMC and exact LGS calculation compute the same $p(z\mid y)$. Their agreement is useful computational checking, but does not by itself teach forward prediction or generation. The consequence is a handoff mismatch, not a reason to discard its guided questions or representation translation.

**Correction to the previous architecture assessment:** `course_architecture.typ`, L01 paragraph, already explicitly includes incomplete/noisy measurements, different questions, prediction, hidden-state inference, generation and the three operations. The earlier reconciliation recommendation to amend it to include these ideas overstated the evidence. No substantive architecture amendment is presently justified on this point. The lecture's sensor-fusion and Gaussian development fit that framework; eventual synchronization of its brief notebook description should follow accepted scope decisions.

**Exact calculation has a limited validity regime.** Supplied parameters mean inference within a model. Gaussianity, linear measurements and independent additive Gaussian noise permit exact answers. Incorrect covariance, nonlinearity, non-Gaussian tails, numerical error or ignored parameter uncertainty can still undermine the answer. Seven controlled dimensions demonstrate the method, not realism or a bottleneck.

## 3. Concrete proposed arc and changes

**Proposed mathematical endpoint:** explain how one joint distribution supports different queries and why Gaussian structure makes their computation exact. **Proposed practical endpoint:** formulate and compute a hidden-value distribution, choose a justified point summary, predict possible measurements and generate another case. These uses serve the broader formulation framework; Gaussian imputation is an application, not the lecture's intellectual purpose.

These milestones preserve the accepted route; they are not section boundaries. Their detailed refinements and timing remain proposed. The residual derivation and interpreted quadratic identity stay live; the full block-elimination proof has a separate recorded-session development commitment.

### A. Bayesian reactivation — keep and clarify; about 10 minutes

Students enter with probability, Bayesian modeling and matrix algebra. Retain the coin model, Bayes and conjugacy as review. Clarify that a posterior is a distribution over an unknown quantity and that the displayed uncertainty reduction is particular to that example. This retains the existing entry rather than building a new estimation unit. Source: existing opening and Book 2 Chapter 1.

**Retrospective:** a model specifies uncertain quantities; the answer depends on the question asked of it.

### B. Learning-problem formulation — keep the core; add a worked connection; about 35 minutes

Beginning from that distinction, retain Iris and the experience/task distinction. **Add** one supplied-measurement formulation: observed/hidden components and a requested distribution, estimate or forward law. **Reduce** repeated full symbolic task mappings and repeated dataset task catalogues, preserving distinct input/experience examples. Explain future-case performance versus training risk and fixed-parameter inference versus fitting. Context remains supplied; no new dataset or estimation unit is selected. Sources: Book 2 Chapter 1; Book 1 §3.2.5 and §5.1.5.1.

**Retrospective:** a dataset does not determine its task, query or criterion; parameter fitting and variable inference have different unknowns.

### C. Gaussian representation and geometry — retain; about 20 minutes

The measurement questions require dependence to remain represented. Retain covariance/correlation, contours, affine covariance derivation and the marginal-versus-conditional visual comparison. State affine Gaussian closure explicitly because the following proof uses it. Mahalanobis distance supports geometry rather than introducing another application. Sources: Book 2 §2.3.1.1; Book 1 §3.2.4.

**Retrospective:** mean and covariance represent Gaussian uncertainty; affine transformations preserve the family, while ignoring and observing coordinates are different operations.

### D. Gaussian conditioning — retain the residual argument and interpreted identity; about 25 minutes

The geometry distinguishes operations; this milestone establishes their answers. Retain coordinate-selection marginalization, the residual proof sketch and bivariate check. For

$$
B=\Sigma_{12}\Sigma_{22}^{-1},\qquad
r=X_1-\mu_1-B(X_2-\mu_2),
$$

zero cross-covariance and joint Gaussianity establish residual independence. This gives the conditional mean and covariance

$$
\mu_{1\mid2}=\mu_1+B(x_2-\mu_2),\qquad
\Sigma_{1\mid2}=\Sigma_{11}-B\Sigma_{21}.
$$

Keep the Schur-complement interpretation and displayed quadratic separation at state/interpret depth live, as accepted. Develop the full block-quadratic proof separately for the recorded session; it is an addition to existing materials. Sources: Book 2 §§2.3.1.3 and 2.3.1.5.

**Retrospective:** residual independence establishes the conditional Gaussian law; its covariance is the unexplained variation and does not depend on measured values.

### E. LGS questions and useful outputs — retain; add the loss connection; about 20 minutes

The preceding rules require joint blocks; derive those blocks from the existing LGS state/measurement model, then retain the gain, scalar noise regimes, sensor fusion and forward marginal. **Add** the brief squared-loss argument:

$$
E[\|Z-a\|^2\mid y]
=\operatorname{tr}\operatorname{Cov}(Z\mid y)
+\|E[Z\mid y]-a\|^2.
$$

Thus $E[Z\mid y]$ is appropriate for that loss, not automatically every decision. Forward $p(y)$ uses fixed parameters, not averaging over their posterior. Generation uses the model's laws; it is not another probability operation. Explicit sensor-noise dependence and prior assumptions are author corrections. Sources: Book 2 §§2.3.2.1–2.3.2.3; Book 1 §5.1.5.1.

**Retrospective:** one model supports inverse inference and forward prediction; uncertainty controls evidence combination, while a criterion determines the useful summary.

## 4. Agreed boundary, remaining decisions and next gate

**Recording development commitment:** develop the full block-elimination proof from Murphy Book 2 §2.3.1.5, “Derivation: moment form.” Entry knowledge is Gaussian block notation, the centered residual and its Schur-complement covariance. The endpoint is the quadratic identity and the factorization $p(x_1,x_2)=p(x_1\mid x_2)p(x_2)$. The live residual argument stands alone: understanding it does not depend on viewing this additional proof. The exact recorded treatment, equation selection and duration will be developed in the mathematical-spine discussion and recording brief.

The planned separate source is `Lectures/L01_Probability_Statistics/recordings/quadratic_separation/slide_deck.typ`. No recording or deck exists yet; the path is a development target. Student-required versus optional status is pending clarification and must not be inferred from the authoring commitment. The accepted workflow applies the existing design/authoring stages under the coordinator; it does not start those stages automatically.

The proposed allocations total 110 minutes plus approximately 10 for discussion/slippage: plausible but tight. Current PDF has 67 pages/seven sections; calibration's 70/eight count is stale. No measured delivery time exists. The separate one-hour notebook needs selective reuse to accommodate accepted forward/generation questions; its exact PyMC balance and context await the notebook-handoff discussion, not a new decision here.

L02/L03 retain Gaussian density, conditioning, joint reasoning and simple graph prerequisites. L02 already introduces $\Lambda=\Sigma^{-1}$ in its Gaussian rewrite; reconcile its inaccurate L01 information-coordinate attribution there. No later lecture is rescoped.

**Remaining decisions:** recording's required/optional student status; mathematical depths beyond the accepted proof boundary; concrete context; proposed additions/reductions and live/notebook workload, including PyMC's role. The selected route supports proceeding to mathematical-spine discussion through the coordinator. The remaining four Scope parts have not been drafted or approved; appropriate source-arc review and Section Design preview still precede complete Scope approval.

## Source records and checking material

Revision baseline: `rescope-l01-l12-architecture-alignment-20261014`, HEAD `d1ffd4c3407b686677c84ebd8aa3375b30da142f`; preceding arc blob `682261132ed686f5f9eb80a95facadb597ad10e8`. Reviewed source blobs:

- Deck: `235b8eeb48ec9075d2bcea82b6a377c0a45b6a79`.
- Coverage specification: `c4457bc4fdb11df14de54658f20e487030766328`.
- Solved notebook: `ab441941c8b526151a927bfbcf292bd9bc629ce5`.
- Architecture: `cb111196e44df211e39864be596233a1a3f22aba`.
- Planned map: `63fb5cea0a7b0a4c908c8f803e550d087d20a412`.

Murphy, *Probabilistic Machine Learning: Advanced Topics*, December 10, 2025 online edition: Chapter 1, printed pp. 1–2, for model/task distinctions; §2.3.1.1 “Definition”; §2.3.1.3 “Marginals and conditionals of an MVN”; §2.3.1.5 “Derivation: moment form,” for the source's block-quadratic argument; §§2.3.2.1 “Joint distribution,” 2.3.2.2 “Posterior distribution (Bayes’ rule for Gaussians),” and 2.3.2.3 “Example: Sensor fusion with known measurement noise,” for joint-to-forward/inverse reuse. Murphy, *Probabilistic Machine Learning: An Introduction*, April 18, 2025 online edition: §3.2.4 “Example: conditioning a 2d Gaussian”; §3.2.5 “Example: Imputing missing values”; §5.1.5.1 “L2 loss,” for the mean/loss distinction. The course residual proof reorganizes the source derivation; its synthetic example is course-constructed.

**Author checking material, not a student-visible teaching commitment:** dense conditioning factors an observed $D\times D$ covariance in $O(D^3)$ work. Fixed parameters and observation pattern permit reuse of factors/gain; subsequent $L$-dimensional posterior means cost $O(LD)$. This is an exact structural computational advantage over generic sampling for these queries, not a claim that sampling is necessary at this example's scale. Factorization/reuse complexity is absent from the existing deck; this analysis does not add it to the proposed live teaching.

[Reconciliation evidence](reconciliation/matrix.md) preserves historical review versions, source errors and runtime limitations. This revision performed source/communication checks, not independent feasibility, runtime or student validation. No architecture, map, deck or notebook was changed.
