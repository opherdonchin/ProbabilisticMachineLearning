# L01 provisional Lecture Scope — intellectual arc and mathematical spine

**Agreed route:** retain the current formulation-to-Gaussian/LGS progression. Keep the residual derivation and stated/interpreted quadratic identity live; develop the full block-elimination proof in a separate recorded session. The short squared-error posterior-mean derivation is now also accepted for live teaching. **Remaining proposal:** strengthen the concrete problem-to-query connection and selectively reduce repeated taxonomy/dataset exposition. These other refinements and timing await discussion.

**Status:** intellectual arc with selected instructor decisions and a proposed mathematical spine, 2026-10-14; not a complete approved Scope. Route, live/recorded proof boundary and live squared-error derivation are accepted. Remaining depths, refinements and workload are proposed. Exact versions are recorded below.

## Accepted instructor direction

The instructor's “Sounds good,” recorded in [development state](development_state.md), accepts in principle using the same dataset and probabilistic formulation to answer different questions: the hidden-block distribution $p(z\mid y)$, its summary $E[Z\mid y]$ under squared loss, and the forward measurement distribution $p(y)=\int p(z,y)\,dz$, with a short generation activity. Conditioning, summarization and marginalization are operations; inference, prediction and generation are uses that can combine those operations.

The instructor subsequently explicitly chose the current route, citing the substantial existing work and the absence of a deep architecture-driven reason to reorder it. They also selected a separate recorded full proof of quadratic separation, while retaining the residual derivation and stated/interpreted identity live. They endorsed using the existing Section Design → Slide Organization → Slide Design → Slide Authoring skills for that recording under the coordinator. These choices do not approve every milestone refinement, timing, taxonomy reduction, new context or proposed addition. The instructor clarified that the proof is required course content and may appear on the exam; viewing itself is not recorded, evaluated or monitored.

**Subsequent explicit decision:** “Let's go ahead and add the derivation slides to the lecture. We can always reduce or move them to recording later.” This accepts the short squared-error posterior-mean proof live now. Its time remains in the live budget until an explicit later reduction or relocation decision. The two slides have been added after the LGS conditioning/summarizing material, at handout pages 64–65 of the [69-page deck](slide_deck.pdf). The [bounded authoring/validation report](reconciliation/squared_loss_authoring_review.md) records compilation and author/coordinator visual checks; this does not approve the whole Scope.

## 1. What the existing artifacts do — baseline before the accepted insertion

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

### E. LGS questions and useful outputs — retain; accepted live loss derivation; about 20 minutes proposed

The preceding rules require joint blocks; derive those blocks from the existing LGS state/measurement model, then retain the gain, scalar noise regimes, sensor fusion and forward marginal. **Accepted addition: derive live** the brief squared-loss argument:

$$
E[\|Z-a\|^2\mid y]
=\operatorname{tr}\operatorname{Cov}(Z\mid y)
+\|E[Z\mid y]-a\|^2.
$$

Thus $E[Z\mid y]$ is appropriate for that loss, not automatically every decision. Forward $p(y)$ uses fixed parameters, not averaging over their posterior. Generation uses the model's laws; it is not another probability operation. Explicit sensor-noise dependence and prior assumptions are author corrections. Sources: Book 2 §§2.3.2.1–2.3.2.3; Book 1 §5.1.5.1.

**Retrospective:** one model supports inverse inference and forward prediction; uncertainty controls evidence combination, while a criterion determines the useful summary.

## 4. Agreed boundary, remaining decisions and next gate

**Recording development commitment:** develop the full block-elimination proof from Murphy Book 2 §2.3.1.5, “Derivation: moment form.” Entry knowledge is Gaussian block notation, the centered residual and its Schur-complement covariance. The endpoint is the quadratic identity and the factorization $p(x_1,x_2)=p(x_1\mid x_2)p(x_2)$. The live residual argument stands alone: understanding it does not depend on viewing this additional proof. The mathematical-spine proposal below makes the proof obligation and provisional recording contract explicit; acceptance of that detailed contract remains pending.

The planned separate source is `Lectures/L01_Probability_Statistics/recordings/quadratic_separation/slide_deck.typ`. No recording or deck exists yet; the path is a development target. Students are responsible for the proof as examinable content, regardless of whether they watch the video. Viewing is not recorded, evaluated or monitored, and no particular exam question is promised. The accepted workflow applies the existing design/authoring stages under the coordinator; it does not start those stages automatically.

The proposed allocations total 110 minutes plus approximately 10 for discussion/slippage: plausible but tight. The baseline PDF had 67 pages/seven sections; the two-slide addition makes the current handout 69 pages. Calibration's 70/eight count is stale. No measured delivery time exists. The separate one-hour notebook needs selective reuse to accommodate accepted forward/generation questions; its exact PyMC balance and context await the notebook-handoff discussion, not a new decision here.

L02/L03 retain Gaussian density, conditioning, joint reasoning and simple graph prerequisites. L02 already introduces $\Lambda=\Sigma^{-1}$ in its Gaussian rewrite; reconcile its inaccurate L01 information-coordinate attribution there. No later lecture is rescoped.

**Remaining decisions:** mathematical depths beyond the accepted proof boundary; concrete context; proposed additions/reductions and live/notebook workload, including PyMC's role. The mathematical spine below is now proposed for discussion. Notebook handoff, concrete examples and lecture contract have not been drafted; appropriate source-arc review and Section Design preview still precede complete Scope approval.

## Part 2 — Mathematical spine: proposed treatment and accepted boundaries

**Recommendation:** preserve the existing mathematical chain and use its results for the accepted different-question aim. The short live squared-loss justification is now **accepted**. The recording completes the selected second proof route; it does not carry prerequisites needed to understand live conditioning or begin the notebook. Other detailed depths below remain proposals unless marked **accepted**.

### Existing mathematics and recommended live treatment

The model parameters remain supplied. For the ordinary densities/inverses used here, assume joint covariance $\Sigma\succ0$; in an LGS assume $\Sigma_z\succ0$, $\Omega\succ0$ and independent Gaussian noise. Degenerate Gaussian measures are outside this treatment. Finite second moments suffice for the squared-loss identity, independently of Gaussianity.

| Mathematical object and baseline | Arc role and practical purpose | Delivery and recommended depth/status |
|---|---|---|
| Joint model, Bayes, conditional/marginal laws and expectations: existing coin, three-operation and LGS material | A–B: identify the observed/unknown variables and requested answer; distinguish a distribution from its summary | **Live: review/state; work** the concrete query distinction. Retention follows the accepted route; the strengthened concrete hinge remains proposed. |
| Empirical risk and zero-one loss: existing Iris material | B: make a performance criterion explicit; prevent training loss from being mistaken for future-case performance | **Live: state/work** the existing average-loss example; clarify generalization without adding a validation unit. Exact exposition remains proposed. |
| Gaussian density, covariance/correlation, contours, affine moments: existing geometry and covariance proof | C: retain dependence and construct measurement/joint blocks | **Live: state/interpret** density and geometry; **derive** $\operatorname{Cov}(AX+b)=A\Sigma A^T$; **state** Gaussian affine closure. Preserve the existing level; no Gaussian-integral proof or information-form unit. |
| Block marginals and independent residual: existing selection, mean and covariance derivations | D: compute a hidden-block distribution, not merely a linear predictor | **Live: derive** marginals and residual conditioning; this live derivation is **accepted**. **Work** the bivariate numerical check; retain explicit Gaussianity in the covariance-to-independence step. |
| LGS joint blocks, gain, posterior and forward law: existing state/measurement development | E: one model supplies inverse inference and forward prediction | **Live: apply** affine and conditioning rules; recommend **derive** joint entries through moments and **work** the scalar gain regimes. This proposed depth makes existing reuse explicit rather than introducing another theorem family. |
| Schur complement and separated quadratic: existing residual interpretation and displayed identity | D–E: connect remaining uncertainty with density factorization | **Live: state/interpret**, **accepted**. **Recording: prove** the complete factorization, also **accepted** in purpose/allocation; detailed contract below is proposed. |

The live residual argument must establish $r\perp X_2$, not just zero covariance: $(r,X_2)$ is jointly Gaussian, $E[r]=0$ and $\operatorname{Cov}(r,X_2)=0$. Therefore $X_1\mid X_2=x_2$ has the shifted Gaussian law already displayed in the arc. Its covariance reduction is positive semidefinite and independent of the observed value within this Gaussian regime. Students apply the distribution and explain why conditioning differs from marginalization; no general covariance-independence rule is implied.

For the LGS, carry the same results into

$$
\mu_y=W\mu_z+b,\quad V_y=W\Sigma_zW^T+\Omega,\quad C=\Sigma_zW^T,
$$
$$
K=CV_y^{-1},\quad E[Z\mid y]=\mu_z+K(y-\mu_y),\quad
\operatorname{Cov}(Z\mid y)=\Sigma_z-KC^T.
$$

Here $V_y$ denotes the observed marginal covariance; these are existing joint/update results carried forward, not fresh content each time. Marginalization gives $p(y)=\mathcal N(\mu_y,V_y)$ under fixed parameters. Generation draws from this marginal, or from the equivalent state/measurement construction; it does not estimate this observation's hidden state. Sensor-fusion interpretation retains all prior and conditional-noise assumptions.

### Accepted live addition and proposed notebook use

**Accepted new live proof:** the baseline deck extracts $E[Z\mid y]$ without proving squared-loss optimality. The instructor now accepts **derive live** the risk decomposition shown in the arc, using the centered cross-term's zero expectation. The provisional 2–4-minute allowance remains in milestone E's live budget; its measured duration and whole-lecture fit are unverified. **Then apply**: the mean minimizes conditional expected squared error, whereas covariance describes uncertainty about the unknown value. The two slides are now implemented after the existing LGS condition/summarize explanation, with bounded production validation recorded above. Other losses and reconstruction-baseline experiments remain outside this bounded addition.

**Notebook: apply**, rather than rederive, the conditional, summary and forward laws. Existing joint-to-LGS translation and exact/sampled comparison remain reusable evidence; adding forward prediction/generation implements the agreed direction, with workload and PyMC balance still to be settled in the handoff. Sample-based summaries have Monte Carlo error; direct draws from an analytically known Gaussian do not turn it into an approximate posterior family. Parameter fitting remains outside this spine.

### Recorded-session mathematical contract — proposed details within accepted boundary

**Entry:** after live block notation, residual conditioning and Schur-complement interpretation; matrix multiplication/transposition and determinants are prior mathematical knowledge. **Endpoint:** prove the normalized joint density is the conditional Gaussian times its marginal. **Delivery:** `Recording`, full block-elimination proof; required/examinable content, with no tracked, evaluated or monitored viewing. It is not a prerequisite to the live derivation or notebook. Target duration **20–30 minutes**, a complexity-based estimate, not measured or approved workload. The separate Typst path remains the planned path above; downstream stages and video production have not begun.

Write $H=\Sigma_{22}$, $B=\Sigma_{12}H^{-1}$ and $S=\Sigma_{11}-BH B^T$. From $\Sigma\succ0$, prove $H,S\succ0$, so every inverse and determinant below is valid. Block elimination gives

$$
T=\begin{pmatrix}I&-B\\0&I\end{pmatrix},\qquad
T\Sigma T^T=\begin{pmatrix}S&0\\0&H\end{pmatrix},\qquad
\Sigma^{-1}=T^T\begin{pmatrix}S^{-1}&0\\0&H^{-1}\end{pmatrix}T.
$$

With $u=x_2-\mu_2$ and $r=x_1-\mu_1-Bu$, the inverse/congruence identity proves

$$
(x-\mu)^T\Sigma^{-1}(x-\mu)=r^TS^{-1}r+u^TH^{-1}u.
$$

Complete the proof using $\det T=1$, hence $\det\Sigma=\det S\det H$. The determinant and dimension-dependent $(2\pi)$ factors then split the normalizer, establishing

$$
\mathcal N(x;\mu,\Sigma)
=\mathcal N(x_1;\mu_1+Bu,S)\,\mathcal N(x_2;\mu_2,H).
$$

Exponent separation alone is insufficient for this normalized equality. Murphy develops the block-inverse/exponent route and states factorization; the explicit determinant/normalizer argument is the course's completion of that proof, not a separately displayed Murphy derivation. No Woodbury proof, second Schur orientation or information-form calculus is required.

### Status after the live-derivation decision

The short squared-loss proof depth is settled for live teaching; it is no longer an open choice between proving and stating the result. Any later reduction or move to recording requires a further instructor decision. The separate full quadratic-separation recording boundary remains intact. Other spine depths and the detailed recording contract remain authored proposals, not complete Scope approval or independent feasibility validation.

## Source records and checking material

Decision-update baseline: `rescope-l01-l12-architecture-alignment-20261014`, HEAD `18d652d28a9139a9b1ab7189190ead1005d7c236`. Mathematical-spine construction used HEAD `5ba226342cbca91a1d52b5bd88bc7efeeee04b37` and input arc blob `fb2775ac8d25d891bf8a2f5c3031ef58542afc94`. The following hashes preserve the examined baseline; the accepted insertion has changed the live deck through separately owned implementation work. Current validated deck source SHA-256: `5c4d188124c261ea0a576f4eb46fceeec136076bd3e9f9098305fee73b84006c`, with evidence in the bounded report linked above:

- Deck: `235b8eeb48ec9075d2bcea82b6a377c0a45b6a79`.
- Coverage specification: `c4457bc4fdb11df14de54658f20e487030766328`.
- Solved notebook: `ab441941c8b526151a927bfbcf292bd9bc629ce5`.
- Architecture: `cb111196e44df211e39864be596233a1a3f22aba`.
- Planned map: `63fb5cea0a7b0a4c908c8f803e550d087d20a412`.

Murphy, *Probabilistic Machine Learning: Advanced Topics*, December 10, 2025 online edition: Chapter 1, printed pp. 1–2, for model/task distinctions; §2.3.1.1 “Definition”; §2.3.1.3 “Marginals and conditionals of an MVN”; §2.3.1.5 “Derivation: moment form,” for the source's block-quadratic argument; §§2.3.2.1 “Joint distribution,” 2.3.2.2 “Posterior distribution (Bayes’ rule for Gaussians),” and 2.3.2.3 “Example: Sensor fusion with known measurement noise,” for joint-to-forward/inverse reuse. Murphy, *Probabilistic Machine Learning: An Introduction*, April 18, 2025 online edition: §3.2.4 “Example: conditioning a 2d Gaussian”; §3.2.5 “Example: Imputing missing values”; §5.1.5.1 “L2 loss,” for the mean/loss distinction. The course residual proof reorganizes the source derivation; its synthetic example is course-constructed.

**Spine source check:** Book 2 §2.3.1.1, Eqs. 2.71–2.73 (density/geometry); §2.3.1.3, Eqs. 2.75–2.79 (blocks/marginals/conditionals); §2.3.1.5, Eqs. 2.88–2.92 (block inverse/Schur complements), 2.94–2.103 (separated exponent, factorization and conditional parameters); §§2.3.2.1–2.3.2.2, Eqs. 2.118–2.126 and 2.129 (LGS/posterior/marginal). Book 1 §3.1.1, Eq. 3.5 (affine covariance), §3.2.5 (imputation), and §5.1.5.1, Eqs. 5.32–5.34 (squared-loss posterior mean). The vector risk decomposition and explicit determinant step are course elaborations. The recording's SPD assumption guarantees both full and Schur inverses; mere invertibility of two diagonal blocks alone does not. Source inspection used local edition extracts; no new implementation, rehearsal, runtime or independent mathematical review was performed.

**Author checking material, not a student-visible teaching commitment:** dense conditioning factors an observed $D\times D$ covariance in $O(D^3)$ work. Fixed parameters and observation pattern permit reuse of factors/gain; subsequent $L$-dimensional posterior means cost $O(LD)$. This is an exact structural computational advantage over generic sampling for these queries, not a claim that sampling is necessary at this example's scale. Factorization/reuse complexity is absent from the existing deck; this analysis does not add it to the proposed live teaching.

[Reconciliation evidence](reconciliation/matrix.md) preserves historical review versions, source errors and runtime limitations. This Scope edit records the accepted live addition; its separately owned slide implementation and validation are tracked by the coordinator. No independent feasibility, runtime or student validation is claimed for this decision update.
