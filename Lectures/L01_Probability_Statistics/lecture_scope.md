# L01 provisional Lecture Scope — five-part delivery proposal

**Agreed route:** retain the current formulation-to-Gaussian/LGS progression. Keep the residual derivation and stated/interpreted quadratic identity live; develop the full block-elimination proof in a separate recorded session. The short squared-error posterior-mean derivation is also accepted for live teaching. **Accepted bounded refinement, 2026-10-16:** activate the existing bivariate Gaussian example as a task-to-query checkpoint, funded provisionally by shortening the second verbal explanation of the repeated Task/Performance grid. [Exact decision and content](goal_alignment_review.md#current-source-assessment-and-concrete-choice--2026-10-16). Other reductions and whole-lecture timing remain unresolved.

**Status:** complete five-part proposal assembled from existing teaching and selected instructor decisions, status reconciled 2026-10-17; not an approved Scope. Route, live/recorded proof boundary, live squared-error derivation and the bounded checkpoint are accepted. Remaining depths, other refinements and workload are proposed. Exact versions are recorded below.

**Notebook decision, current session 2026-10-16:** “I think we can get rid of PyMC entirely. It takes away from the current focus of the notebook.” Remove PyMC entirely, including a supplied comparison, from the active L01 notebook and worked solution. Exact Gaussian conditioning/LGS computation, squared-loss summarization, forward marginalization and short generation are the accepted direction; the detailed handoff and learner-time validation remain separate. [Owning decision](goal_alignment_review.md#l01-notebook-computation--exact-computation-without-pymc).

**Feasibility preview completed, 2026-10-16:** the separate Section Design specialist found the assembled five-part proposal **feasible with advisory risks**, with no substantive Scope repair requested. [Raw preview and exact source records](reconciliation/delivery_readiness/scope_feasibility_preview.md) cover proposal SHA-256 `0e589e96d2053e5958a633bf670e6044de85fd970887809b9f617a37048ee0e2`; subsequent edits record notebook and selected-loss acceptance without changing the reviewed mathematical route. The preview is tied to its recorded earlier source. The live 110+10-minute envelope and notebook author's 55–75-minute estimate remain unmeasured. Feasibility is not instructor acceptance or delivery readiness.

**Notebook artifact acceptance, 2026-10-17:** the instructor accepted the current
solved/student notebook's content and pedagogy in chat, after the Question 2.3
execution-order diagnosis. [The owning register](development_state.md) records
the exact provenance and source basis. This resolves review of the notebook
artifact; measured learner time, hosted runtime/public availability and the
complete Lecture Scope remain separate.

## Accepted instructor direction

The instructor's “Sounds good,” recorded in [development state](development_state.md), accepts in principle using the same dataset and probabilistic formulation to answer different questions: the hidden-block distribution $p(z\mid y)$, its summary $E[Z\mid y]$ under squared loss, and the forward measurement distribution $p(y)=\int p(z,y)\,dz$, with a short generation activity. Conditioning, summarization and marginalization are operations; inference, prediction and generation are uses that can combine those operations.

The instructor subsequently explicitly chose the current route, citing the substantial existing work and the absence of a deep architecture-driven reason to reorder it. They also selected a separate recorded full proof of quadratic separation, while retaining the residual derivation and stated/interpreted identity live. They endorsed using the existing Section Design → Slide Organization → Slide Design → Slide Authoring skills for that recording under the coordinator. These choices do not approve every milestone refinement, timing, taxonomy reduction, new context or proposed addition. The instructor clarified that the proof is required course content and may appear on the exam; viewing itself is not recorded, evaluated or monitored.

**Live squared-loss proof and realization accepted:** the earlier instruction “Let's go ahead and add the derivation slides to the lecture. We can always reduce or move them to recording later” settled derive-live depth. On 2026-10-17 the instructor explicitly accepted its selected three-slide realization: “The three slide squared loss proof replacement is ok.” That exact replacement is integrated at handout pages 64–66 of the [70-page deck](slide_deck.pdf); [current validation](reconciliation/selected_loss_sequence/production_validation.md) records matching full builds and contextual renders. Its time remains in the live budget until an explicit later relocation decision. This approval does not approve the whole Scope.

**Current design status:** the previously rejected insertion has been replaced by the accepted three-move setup → averaging proof → decision realization. Its [Organization/Design contract and approval record](reconciliation/selected_loss_sequence/result.md) own this bounded explanation. No further layout comparison is pending. Shared slide-skill experiments remain separate from acceptance of this concrete artifact.

## Part 1 — Intellectual arc and reconciliation

### Existing artifacts — baseline before the accepted insertion

The [deck](slide_deck.typ) begins with **“A familiar modeling language”**: Beta–Bernoulli modeling, observed/unknown quantities, graphs, Bayes and conjugacy. **“From statistics to machine-learning problems,” “Classes of machine learning problems,”** and **“From datasets to learning problems”** use Iris features, labels, zero-one loss and a probabilistic classifier; distinguish experience from task; and illustrate dataset uses through MNIST, CIFAR-10 and IMDB. **“Summary: Probability for machine learning”** presents the three operations.

The remaining argument is cumulative. **“Joint Gaussian distributions and geometry”** develops covariance, contours and affine rules. **“Marginals and conditionals of a Gaussian”** obtains marginals by coordinate selection and derives conditional means and covariances through an independent Gaussian residual. **“The Schur complement is the residual covariance”** interprets the resulting matrix. **“The joint quadratic separates into conditional and marginal parts”** displays and interprets an identity; it does not prove a second complete conditioning derivation.

**“Linear Gaussian systems”** constructs the state/measurement joint, applies conditioning, interprets the gain through scalar noise regimes, and illustrates sensor fusion. **“Inference often combines conditioning and summarizing”** distinguishes a distribution from an estimate. **“The same model can also predict measurements”** obtains the forward marginal from the same joint.

The recovered solved-notebook baseline (blob `ab441941c8b526151a927bfbcf292bd9bc629ce5`) supplies a seven-dimensional Gaussian with known parameters, hides three coordinates of one simulated observation, samples their conditional posterior with PyMC, rewrites the joint as an LGS, and compares exact and sampled means/SDs. Its final comparison answers one conditional query by two computational routes. The current decision reuses its controlled model and LGS translation while removing the sampler route. The [coverage specification](lecture_01_coverage_spec.typ) proposes an estimation/MLE/MAP bridge and a different book-based notebook route; those units are not implemented in the deck and are not added by this notebook revision.

### Critique: evidence and teaching consequences

**Formulation connects less strongly to computation than the Gaussian argument does.** The taxonomy/query material repeats symbolic descriptions; sustained model-to-answer computation occurs later. Students can retain category names without learning to choose variables, query and criterion. Historical persona reports identify this hinge, but are simulated readings of an earlier rendering, not classroom outcomes.

**The recovered notebook's two routes do not exercise the different-question endpoint.** PyMC and exact LGS calculation compute the same $p(z\mid y)$. The instructor has removed the sampler comparison to focus the revision on exact conditional, summary and forward/generation queries. Reuse effective guided questions and representation translation; do not replace the deleted sampler work with another lengthy sampling comparison.

**Correction to the previous architecture assessment:** `course_architecture.typ`, L01 paragraph, already explicitly includes incomplete/noisy measurements, different questions, prediction, hidden-state inference, generation and the three operations. The earlier reconciliation recommendation to amend it to include these ideas overstated the evidence. No substantive architecture amendment is presently justified on this point. The lecture's sensor-fusion and Gaussian development fit that framework; eventual synchronization of its brief notebook description should follow accepted scope decisions.

**Exact calculation has a limited validity regime.** Supplied parameters mean inference within a model. Gaussianity, linear measurements and independent additive Gaussian noise permit exact answers. Incorrect covariance, nonlinearity, non-Gaussian tails, numerical error or ignored parameter uncertainty can still undermine the answer. Seven controlled dimensions demonstrate the method, not realism or a bottleneck.

### Concrete proposed arc and changes

**Proposed mathematical endpoint:** explain how one joint distribution supports different queries and why Gaussian structure makes their computation exact. **Proposed practical endpoint:** formulate and compute a hidden-value distribution, choose a justified point summary, predict possible measurements and generate another case. These uses serve the broader formulation framework; Gaussian imputation is an application, not the lecture's intellectual purpose.

These milestones preserve the accepted route; they are not section boundaries. Their detailed refinements and timing remain proposed. The residual derivation and interpreted quadratic identity stay live; the full block-elimination proof has a separate recorded-session development commitment.

#### A. Bayesian reactivation — keep and clarify; about 10 minutes

Students enter with probability, Bayesian modeling and matrix algebra. Retain the coin model, Bayes and conjugacy as review. Clarify that a posterior is a distribution over an unknown quantity and that the displayed uncertainty reduction is particular to that example. This retains the existing entry rather than building a new estimation unit. Source: existing opening and Book 2 Chapter 1.

**Retrospective:** a model specifies uncertain quantities; the answer depends on the question asked of it.

#### B. Learning-problem formulation — keep the core; shorten the repeated recap; about 35 minutes proposed

Beginning from that distinction, retain Iris and the experience/task distinction. The instructor accepted a shorter second verbal walkthrough of the repeated Task/Performance grid on current p33, preserving its distinct query/performance key points and the experience/task examples. This provisionally funds the existing bivariate example's task-to-query checkpoint in milestone D; no additional early measurement example or broader taxonomy reduction is commissioned. Explain future-case performance versus training risk and fixed-parameter inference versus fitting. No new dataset or estimation unit is selected. Sources: Book 2 Chapter 1; Book 1 §3.2.5 and §5.1.5.1.

**Retrospective:** a dataset does not determine its task, query or criterion; parameter fitting and variable inference have different unknowns.

#### C. Gaussian representation and geometry — retain; about 20 minutes

The measurement questions require dependence to remain represented. Retain covariance/correlation, contours, affine covariance derivation and the marginal-versus-conditional visual comparison. State affine Gaussian closure explicitly because the following proof uses it. Mahalanobis distance supports geometry rather than introducing another application. Sources: Book 2 §2.3.1.1; Book 1 §3.2.4.

**Retrospective:** mean and covariance represent Gaussian uncertainty; affine transformations preserve the family, while ignoring and observing coordinates are different operations.

#### D. Gaussian conditioning — retain the residual argument and interpreted identity; about 25 minutes

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

Keep the Schur-complement interpretation and displayed quadratic separation at state/interpret depth live, as accepted. In the existing bivariate numerical example, **work/apply** the accepted checkpoint: distinguish the supplied parameters from the missing variable, choose the conditional law given the recorded coordinate, then contrast its marginal when that coordinate is unobserved. Neither calculation fits model parameters. Develop the full block-quadratic proof separately for the recorded session; it is an addition to existing materials. Sources: Book 2 §§2.3.1.3 and 2.3.1.5.

**Retrospective:** residual independence establishes the conditional Gaussian law; its covariance is the unexplained variation and does not depend on measured values.

#### E. LGS questions and useful outputs — retain; accepted live loss derivation; about 20 minutes proposed

The preceding rules require joint blocks; derive those blocks from the existing LGS state/measurement model, then retain the gain, scalar noise regimes, sensor fusion and forward marginal. **Accepted addition: derive live** the brief squared-loss argument:

$$
E[\|Z-a\|^2\mid y]
=\operatorname{tr}\operatorname{Cov}(Z\mid y)
+\|E[Z\mid y]-a\|^2.
$$

Thus $E[Z\mid y]$ is appropriate for that loss, not automatically every decision. Forward $p(y)$ uses fixed parameters, not averaging over their posterior. Generation uses the model's laws; it is not another probability operation. Explicit sensor-noise dependence and prior assumptions are author corrections. Sources: Book 2 §§2.3.2.1–2.3.2.3; Book 1 §5.1.5.1.

**Retrospective:** one model supports inverse inference and forward prediction; uncertainty controls evidence combination, while a criterion determines the useful summary.

### Agreed boundary, remaining decisions and next gate

**Recording development commitment:** develop the full block-elimination proof from Murphy Book 2 §2.3.1.5, “Derivation: moment form.” Entry knowledge is Gaussian block notation, the centered residual and its Schur-complement covariance. The endpoint is the quadratic identity and the factorization $p(x_1,x_2)=p(x_1\mid x_2)p(x_2)$. The live residual argument stands alone: understanding it does not depend on viewing this additional proof. The mathematical-spine proposal below makes the proof obligation and provisional recording contract explicit; acceptance of that detailed contract remains pending.

The separate source is [recordings/quadratic_separation/slide_deck.typ](recordings/quadratic_separation/slide_deck.typ). The instructor authorized a provisional deck through all specialist stages on 2026-10-17; final acceptance and video capture remain separate. [Current production/review status](reconciliation/delivery_finalization/report.md) owns its exact version and results. Students are responsible for the proof as examinable content, regardless of whether they watch the video. Viewing is not recorded, evaluated or monitored, and no particular exam question is promised. The accepted workflow applies the existing design/authoring stages under the coordinator; it does not start those stages automatically.

The proposed allocations total 110 minutes plus approximately 10 for discussion/slippage: a tight unmeasured envelope. The current handout has 70 pages, including one lecture title and seven section dividers, after the accepted three-slide loss replacement. These counts are inventory, not teaching-time evidence. No measured delivery time exists. The separate notebook uses exact computation without PyMC; its source is locally validated, but its 55–75-minute subjective learner estimate leaves the one-hour target unvalidated.

L02/L03 retain Gaussian density, conditioning, joint reasoning and simple graph prerequisites. L02 already introduces $\Lambda=\Sigma^{-1}$ in its Gaussian rewrite; reconcile its inaccurate L01 information-coordinate attribution there. No later lecture is rescoped.

**Remaining decisions:** mathematical depths beyond the accepted proof boundary, other proposed additions/reductions, and live/notebook workload. PyMC's removal is settled. The mathematical spine below is proposed for discussion; the exact-only notebook handoff and locally validated pair are specified from the accepted direction. Concrete examples and the lecture contract are proposed in Parts 4/5 below. The retained route is not substantially redirected; prior source-arc evidence is preserved. A lightweight Section Design preview and instructor review precede complete Scope approval.

## Part 2 — Mathematical spine: proposed treatment and accepted boundaries

**Recommendation:** preserve the existing mathematical chain and use its results for the accepted different-question aim. The short live squared-loss justification is now **accepted**. The recording completes the selected second proof route; it does not carry prerequisites needed to understand live conditioning or begin the notebook. Other detailed depths below remain proposals unless marked **accepted**.

### Existing mathematics and recommended live treatment

The model parameters remain supplied. For the ordinary densities/inverses used here, assume joint covariance $\Sigma\succ0$; in an LGS assume $\Sigma_z\succ0$, $\Omega\succ0$ and independent Gaussian noise. Degenerate Gaussian measures are outside this treatment. Finite second moments suffice for the squared-loss identity, independently of Gaussianity.

| Mathematical object and baseline | Arc role and practical purpose | Delivery and recommended depth/status |
|---|---|---|
| Joint model, Bayes, conditional/marginal laws and expectations: existing coin, three-operation and LGS material | A–B and D: identify the observed/unknown variables and requested answer; distinguish a distribution from its summary | **Live: review/state; work/apply** the concrete query distinction in the accepted bivariate checkpoint. The existing route and that bounded strengthening are accepted; complete Scope approval remains pending. |
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

**Accepted new live proof:** the baseline deck extracts $E[Z\mid y]$ without proving squared-loss optimality. The instructor now accepts **derive live** the risk decomposition shown in the arc, using the centered cross-term's zero expectation. The provisional 2–4-minute allowance remains in milestone E's live budget; its measured duration and whole-lecture fit are unverified. **Then apply**: the mean minimizes conditional expected squared error, whereas covariance describes uncertainty about the unknown value. The accepted three-slide realization is implemented after the LGS condition/summarize explanation; its exact rendering is recorded above. Other losses and reconstruction-baseline experiments remain outside this bounded addition.

**Notebook: apply**, rather than rederive, the conditional, summary and forward laws. Retain the existing joint-to-LGS translation; remove the exact/sampler comparison entirely. Apply conditional Gaussian formulas through transparent linear solves, choose the conditional mean and interpret minimum model risk, calculate the forward marginal, and generate a fresh case from the supplied model. Direct model generation is distinct from solving the missing-block query. Parameter fitting and generic posterior sampling remain outside this notebook. The detailed handoff/workload is specified separately below.

### Recorded-session mathematical contract — proposed details within accepted boundary

**Entry:** after live block notation, residual conditioning and Schur-complement interpretation; matrix multiplication/transposition and determinants are prior mathematical knowledge. **Endpoint:** prove the normalized joint density is the conditional Gaussian times its marginal. **Delivery:** `Recording`, full block-elimination proof; required/examinable content, with no tracked, evaluated or monitored viewing. It is not a prerequisite to the live derivation or notebook. Target duration **20–30 minutes**, a complexity-based estimate, not measured or approved workload. The separate Typst source and provisional specialist-stage build are tracked above. Final contract acceptance, measured duration and video capture remain open.

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

## Part 3 — Notebook handoff: exact queries from one known Gaussian

**Proposed handoff, 2026-10-16; not complete-Scope approval.** Revision trigger: the instructor's “I think we can get rid of PyMC entirely. It takes away from the current focus of the notebook.” The exact-only computation decision is accepted. This Part 3 proposal preserves the previously accepted hidden-block conditional, squared-loss mean summary, forward marginal and short generation direction; its complete student workload still requires review. It changes no live proof depth, lecture route, dataset, parameter-fitting commitment or recording boundary.

### Problem, supplied model and entry boundary

Students encounter incomplete multivariate measurements: four coordinates of one case are recorded, and three must be reconstructed with uncertainty. The controlled example retains the existing seven-dimensional joint Gaussian and original seed-2027 reference case. The complete case is supplied at full precision, with its NumPy 2.0.2 provenance, so platform-dependent Gaussian factorization cannot change the numerical exercise. A separate seed 2028 is used only for fresh-case generation. Its supplied means are $\mu_1=(-0.5,0.5,1)^T$ and $\mu_2=(0,0.5,-0.5,1)^T$; its covariance blocks remain

$$
\Sigma_{11}=0.3I_3+0.7J_3,\qquad
\Sigma_{22}=1.2^2(0.2I_4+0.8J_4),\qquad
\Sigma_{12}=0.9(1.2)\sqrt{0.7\cdot0.8}\,\mathbf1_3\mathbf1_4^T,
$$

with $J_d=\mathbf1_d\mathbf1_d^T$ and $\Sigma_{21}=\Sigma_{12}^T$. This is the existing course-constructed example, not a Murphy dataset. The model is known; the available experience for inference is the observed block of this case, not a training set for estimating its parameters. Write $Z=X_1\in\mathbb R^3$ and $Y=X_2\in\mathbb R^4$. The realized $y_{\rm obs}$ is observed; $z_{\rm true}$ is hidden during inference and retained separately only for checking the simulated reconstruction. Neither is a model parameter.

Before the notebook, live teaching establishes Gaussian block notation, marginalization, conditional mean/covariance through the residual argument, LGS joint/update/forward laws, and why the conditional mean minimizes expected squared loss. Students bring matrix algebra and basic NumPy indexing/multiplication; unfamiliar numerical operations receive local scaffolding. The separate full block-elimination recording is required/examinable course content, but is **not a prerequisite** to this notebook: students apply the live results rather than reconstructing that proof.

Source anchors retained from the Scope's checked editions are Murphy, *Probabilistic Machine Learning: An Introduction* (April 18, 2025), §3.2.5 “Example: Imputing missing values” and §5.1.5.1 “L2 loss”; and *Probabilistic Machine Learning: Advanced Topics* (December 10, 2025), §2.3.1.3 “Marginals and conditionals of an MVN,” §2.3.2.1 “Joint distribution” and §2.3.2.2 “Posterior distribution (Bayes’ rule for Gaussians).” Look for block conditioning, the criterion selecting the mean, and reuse of the same joint law for inverse and forward queries. These references support the method; the numerical construction above remains course-owned.

### Work and useful output

**Work/apply, not re-prove:** students identify the supplied, observed and unknown quantities; inspect the covariance dependence; formulate the hidden-block target $p(z\mid y_{\rm obs})$; and evaluate its block-Gaussian conditional with linear solves. They then translate the same joint into the lecture's LGS notation:

$$
Z\sim\mathcal N(\mu_z,\Sigma_z),\qquad
Y=WZ+b+\varepsilon,\qquad
\varepsilon\sim\mathcal N(0,\Omega),\quad\varepsilon\perp Z,
$$
$$
\mu_z=\mu_1,\quad\Sigma_z=\Sigma_{11},\quad
W=\Sigma_{21}\Sigma_{11}^{-1},\quad
b=\mu_2-W\mu_1,\quad
\Omega=\Sigma_{22}-W\Sigma_{12}.
$$

The translation is a factorization of the supplied joint, not model fitting or a second inference method. Students implement the block conditional once using linear solves rather than explicit matrix inverses; the LGS re-evaluation below is supplied verification of the same answer, not a second coding assignment. With $\mu_y=W\mu_z+b$, $V_y=W\Sigma_zW^T+\Omega$ and $C=\Sigma_zW^T$, the required conditional is

$$
p(z\mid y_{\rm obs})=\mathcal N(m,S),\qquad
m=\mu_z+CV_y^{-1}(y_{\rm obs}-\mu_y),\qquad
S=\Sigma_z-CV_y^{-1}C^T.
$$

The meaningful reconstruction output reports the three conditional means and marginal standard deviations, retains the joint covariance, and relates uncertainty to the separately retained hidden values. Marginal standard deviations do not describe every dependence in that joint distribution; any displayed coordinate interval has marginal coverage, not simultaneous coverage of the whole hidden vector. Students choose $a=m$ under squared loss and compute/interpret its minimum conditional model risk $R(m\mid y_{\rm obs})=\operatorname{tr}S$, applying the live identity

$$
R(a\mid y_{\rm obs})
=E_{\rm model}[\|Z-a\|^2\mid y_{\rm obs}]
=\operatorname{tr}S+\|m-a\|^2.
$$

Students distinguish this **model-based expected loss** from the single realized error $\|z_{\rm true}-a\|^2$. Optimal conditional risk does not guarantee exact recovery of a hidden realization. A single case cannot validate the model or establish average real-world performance. The unconditional-mean action's risk can remain author evidence or one short supplied interpretation; no extra student coding, baseline experiment, sensitivity study or repeated-case evaluation is required. Retain this fixed reference case and model even if their risk improvement is modest.

Students also compute the **before-observations forward law**

$$
p(y)=\int p(y\mid z)p(z)\,dz=\mathcal N(\mu_y,V_y),
$$

checking that its moments reproduce the supplied $\mu_2,\Sigma_{22}$. This describes possible measurements for an unobserved case under fixed model parameters; conditioning on $y_{\rm obs}$ answers the different question about the hidden block of the existing case. A short generation activity uses the known laws to draw a fresh state and measurement, $z_{\rm new}\sim p(z)$ and $y_{\rm new}\sim p(y\mid z_{\rm new})$. Generation creates a new possible case; it is neither an approximation to the analytic conditional nor an extra inference algorithm.

### Validity, computational payoff and extent

Exactness is within the supplied Gaussian model, with positive-definite covariance blocks and Schur complements; the equivalent LGS has independent additive Gaussian noise. Linear algebra gives the full conditional and marginal parameters without fitting or numerical integration. Fixed parameters and an unchanged observation pattern allow matrix factorizations to be reused for more cases; seven dimensions demonstrate this structure, not a large-scale bottleneck. Factorization complexity is author checking context, not an added student derivation.

The remaining distinctions are substantive: floating-point error is computational; residual conditional uncertainty persists even with exact arithmetic; and model mismatch or ignored parameter uncertainty can make exact model answers poor answers to a real task. The controlled hidden value lets students inspect one realized error, not diagnose these failures empirically. This establishes guided first use of Gaussian reconstruction and query choice; it does not establish population-model fitting or practical familiarity with uncontrolled missingness.

**One-hour target, unvalidated learner time.** The extension beyond lecture is numerical formulation, block-to-LGS translation, implementation, output interpretation and switching queries on the same concrete case. Preserve fine-grained theoretical, technical and interpretive scaffolding; supply arbitrary setup, numerical validation and plotting infrastructure. Removing PyMC releases the old model/container/output/API work, but does not by itself prove that the remaining work fits. The current solved-Q&A artifact and scaffolding are instructor-accepted; actual learner time remains unmeasured. Do not reopen that pedagogy solely because time has not been measured. Keep the conditional-mean choice and minimum-risk calculation, accepted four query uses and LGS translation; escalate any required substantive reduction through Scope rather than silently cutting them. A fast technical execution is not a learner-time measurement.

### Revision handoff to the coordinator

**Verdict: feasible-with-risks**, as a bounded Scope proposal. The mathematics reuses the live results and the original concrete model; no new prerequisite method is needed. Confidence is high in the interface and lower in the one-hour student workload. The independent worked-solution revision owns technical execution; this document claims no new runtime, hosted Colab, learner or independent Section Design validation.

**Exact changes proposed:** replace the old one-conditional/two-route handoff with exact conditional computation, a criterion-based summary, forward marginalization and short generation. Preserve the LGS translation, known parameters, original reference case, controlled context and lecture proof commitments. Remove every PyMC role, including supplied comparison.

**Remaining ownership:** the instructor accepted the current notebook content/pedagogy on 2026-10-17; exact-only authoring, mechanical student derivation and local execution are complete. The coordinator owns public/hosted validation and measurement of learner time; any consequential reduction returns to the instructor. The complete five-part Scope has received its separate feasibility preview and still needs instructor acceptance. The provisional recording build is authorized separately; no remote publication or actual-teaching record is implied.

**Basis inspected:** delivery branch `lecture/l01-delivery-readiness@2d8d949d86ec7ba8dbc77fec25fb86d7cca58260`; live `lecture_scope.md`, `development_state.md`, `goal_alignment_review.md`; actual 80-cell solved notebook; existing worked source; architecture and planned/actual maps. The register already contains the current accepted PyMC-removal decision; older “pending PyMC” passages are historical/stale status, not a reopened choice. The actual map remains empty because no class has been taught. The specialist wrote only `/tmp/l01-exact-scope/`; the coordinator integrated this Part 3 and aligned its fixed-case provenance and supplied verification boundary with the validated worked/Q&A route.

## Part 4 — Concrete examples: proposal using the existing teaching argument

These examples complete the provisional Scope; their inclusion does not approve the complete Scope, every proposed depth or workload. They reuse the current formulation → Gaussian → LGS route. Book 1 means Murphy, *Probabilistic Machine Learning: An Introduction*, April 18, 2025 online edition; Book 2 means *Probabilistic Machine Learning: Advanced Topics*, December 10, 2025 online edition. Section titles and the qualifications below were checked against the local course copies.

### 1. Coin observations and an unknown bias

**Provenance:** existing live opening, `slide_deck.typ`, “The Beta-Binomial model” through the opening retrospective; Book 2 §3.2.1 “Tossing coins” and §3.4.1 “The binomial model.” **Purpose/spine:** reactivate the distinction between observations, unknown quantities and model assumptions through the familiar Beta–Bernoulli joint. Retain the posterior $\theta\mid y\sim\operatorname{Beta}(\alpha+N_1,\beta+N_0)$ as Bayesian review. **Treatment/delivery:** **Brief; Live: review/state and interpret**, preserving the existing exposition rather than adding a new conjugacy proof or estimation unit. **Notebook relation:** the coin's unknown is a parameter, whereas the notebook's unknown is a missing coordinate block with parameters supplied. This contrast prevents “inference” from being mistaken for parameter fitting in every problem. The coin is an entry example, not a second notebook assignment or a general claim that every posterior becomes narrower after every observation.

### 2. Iris classification and the dataset/task distinction

**Provenance:** existing live “Classification: Iris flowers,” “Exploratory data analysis,” “Performance: empirical risk minimization,” “A loss function,” “A probabilistic perspective” and task/experience examples; Book 1 §1.2.1.1 “Example: classifying Iris flowers,” §1.2.1.2 “Exploratory data analysis,” Figs. 1.1/1.3 and Table 1.1. **Purpose/spine:** use 150 labeled cases with four measurements and three classes to make a learning problem concrete: a design matrix is available experience, predicting species is a task, and zero-one loss specifies a criterion. Bayes' rule turns a class-conditional model into $p(c\mid x)$; a class decision then selects $\arg\max_c p(c\mid x)$ under zero-one loss. Training misclassification risk is not future-case performance. **Treatment/delivery:** **Work through; Live: state/work/apply** the existing formulation and interpret the displayed empirical-loss formula; no new classifier fitting or validation unit is promised. **Notebook relation:** carries forward the need to specify a query and criterion, while the notebook changes the unknown and criterion to hidden measurements and squared loss.

Keep MNIST, CIFAR-10 and IMDB as **Brief; Live: compare** examples of differing data structure/scale and possible uses, not additional practical-method commitments. Their existing figure/table provenance is Book 1 Figs. 1.12a/1.13b and Table 1.3, recorded in `figures/book1_section12_sources.md`. The images and reviews make the task/experience distinction visible; they do not establish competence in image/text algorithms. The only accepted compression is the shorter second explanation of the repeated Task/Performance grid to fund the checkpoint below; no broader catalogue cut is inferred.

### 3. Bivariate Gaussian: ignoring a coordinate versus observing it

**Provenance:** existing live “Gaussians: a concrete example,” now the accepted task-to-query checkpoint; course adaptation of Book 1 §3.2.4 “Example: conditioning a 2d Gaussian,” Eqs. 3.29–3.32. Murphy's numerical observation there is $y_2=1$; the course's accepted observation is **$X_2=1.5$**. **Purpose/spine:** connect covariance geometry, block marginalization and residual conditioning to a question students themselves formulate. The supplied law is

$$
\begin{pmatrix}X_1\\X_2\end{pmatrix}\sim\mathcal N\!\left(0,\begin{pmatrix}1&0.8\\0.8&1\end{pmatrix}\right).
$$

With $X_2=1.5$ recorded and $X_1$ missing, the answer is $p(X_1\mid X_2=1.5)=\mathcal N(1.2,0.36)$; when $X_2$ is unobserved, $p(X_1)=\mathcal N(0,1)$. The second Gaussian argument is variance. **Treatment/delivery:** **Work through/Compare; Live: work/apply**, using the accepted checkpoint to identify supplied parameters, observed/unknown variables, required law and operation before revealing the result. The surrounding covariance/contour and marginal/conditional visuals explain the geometry; no extra numerical example is needed. **Notebook relation:** gives a small, checkable instance of the same hidden-block reasoning and fixed-parameter boundary. Its provisional 2–3-minute interaction allowance remains unmeasured.

### 4. Noisy measurements: scalar gain and sensor fusion

**Provenance:** existing live LGS construction, “The scalar Gaussian update,” “The update is weighted by relative uncertainty,” “Sensor fusion combines measurements according to their uncertainty,” and forward-law explanation; Book 2 §§2.3.2.1 “Joint distribution,” 2.3.2.2 “Posterior distribution (Bayes' rule for Gaussians)” and 2.3.2.3 “Example: Sensor fusion with known measurement noise.” The scalar specialization is course work from Eqs. 2.121–2.123. The sensor graphic is the existing **qualitative course schematic after** Fig. 2.10, not an exact numerical reproduction.

**Purpose/spine:** show why the update's dependence on uncertainty is useful for measurement reconstruction. For $Y=Z+\varepsilon$, independent Gaussian noise gives

$$
K=\frac{\sigma_z^2}{\sigma_z^2+\sigma_\varepsilon^2},\qquad
E[Z\mid y]=\mu_z+K(y-\mu_z).
$$

Compare precise, equally uncertain and noisy measurements. With two conditionally independent sensors, discuss how precision and direction affect evidence combination. Equal isotropic sensor noise gives the midpoint **in the weak-prior limit**; finite prior mean/precision also matter. Correlated sensor errors require a different observation covariance. **Treatment/delivery:** **Work through/Compare; Live: apply/derive** the existing scalar specialization, then **state/interpret** the sensor cases and same-model forward marginal. Preserve the proposed LGS moment derivation depth in Part 2; these examples add no new proof family. **Notebook relation:** prepares the LGS factorization and forward query; it does not turn the synthetic covariance-derived representation into a physical or causal sensor model.

### 5. Seven-dimensional missing measurements: guided exact method use

**Provenance:** current course-constructed worked source and solved/student missing-data notebooks, indexed by the current authoring report; the unchanged three-hidden/four-observed model and original seed-2027/NumPy-2.0.2 case are fixed reference data. Fresh generation uses a separate seed without a fixed vector answer key. Method anchors: Book 1 §3.2.5 “Example: Imputing missing values” and §5.1.5.1 “L2 loss”; Book 2 §2.3.1.3 “Marginals and conditionals of an MVN” and §§2.3.2.1–2.3.2.2. Murphy's imputation example has ten eight-dimensional cases with half the entries hidden; this notebook's numerical model/case are not that dataset.

**Purpose/spine:** extend the live formulas into a bounded computation and interpretation encounter. **Treatment/delivery:** **Work through; Notebook: apply/implement/interpret**, not re-prove: compute the exact conditional moments with linear solves, report marginal uncertainty while retaining joint covariance, choose the conditional-mean action and minimum squared-loss model risk, translate the same joint to an LGS, compute the fresh-case forward marginal, and generate one fresh state/measurement pair. The repeated LGS conditional is supplied verification. **Relation to the lecture:** this is its practical handoff, specified fully in Part 3, rather than a replacement for its intellectual purpose.

The visible reconstruction/uncertainty display and one realized hidden error are useful outputs. They do not validate the model or establish population performance. Individual 90% coordinate intervals are not a simultaneous 90% region. The uncontrolled-missingness and parameter-estimation problems remain for later work; no real dataset, baseline study or sensitivity exercise is added here. Gaussian structure permits exact full-law calculation; fixed parameters/observation pattern permit reuse of matrix factorizations. Seven dimensions demonstrate these benefits without asserting a large-scale bottleneck. Floating-point error, conditional uncertainty and model mismatch remain different limitations.

## Part 5 — Lecture contract: provisional until full-Scope acceptance

**Starting assumptions:** graduate probability/Bayesian reasoning, expectations/covariances, calculus and matrix algebra. Basic Python/NumPy array work is available for the guided notebook; unfamiliar solve/shape/summary/generation operations receive local scaffolding. No previous lecture in this semester has been taught. The reviewed artifacts are preparation, not evidence of student mastery.

**Central question:** how do a learning task, available experience, data structure/scale and performance requirement determine a joint model, a query and a useful calculation? Develop that judgment along the accepted formulation → Gaussian representation → conditioning → LGS route.

**Live endpoint:** students can formulate conditional versus marginal questions under supplied parameters, understand the independent-residual derivation of Gaussian conditioning, use the LGS joint for inverse and forward queries, and justify the conditional mean under squared loss. **Derive live:** residual conditioning and the complete finite-second-moment vector risk decomposition, its unique mean minimizer and minimum risk. **State/interpret live:** the separated quadratic identity. Preserve Part 2's other proposed derivation/application depths; whole-Scope acceptance is not inferred from these settled proof decisions. The selected three-slide squared-loss realization is instructor-accepted and integrated; its live mathematical depth remains settled.

**Notebook endpoint:** guided first use of exact Gaussian reconstruction on the fixed known model: conditional law/uncertainty, mean action and minimum model risk, same-joint LGS translation, forward marginal and one fresh generated case. Students distinguish model expected risk from one realized error, marginal from joint coverage, and generation from inference on an existing case. Exactness requires the Gaussian/linear-independent-noise assumptions and valid covariance inverses; it does not establish the model's real-world adequacy. Practical competence claimed here is bounded application and interpretation, not parameter fitting or empirical validation of missing-data models.

**Required proof and separate recording:** the full block-elimination/quadratic-separation proof is required/examinable content; developing it in a separate recording is accepted. Viewing itself is not recorded, evaluated or monitored. No viewing-compliance requirement is inferred; proof responsibility is independent of how students study it, and no particular exam question is promised. The live residual argument stands alone and supplies the notebook prerequisites. The detailed contract in Part 2 remains proposed: enter after live block/residual/Schur-complement material; prove the block-elimination quadratic identity and normalized density factorization, including positive-definite/Schur assumptions and determinant/normalizer factors. Its 20–30-minute estimate is unmeasured and unapproved. Exponent separation alone is insufficient. A provisional deck is authorized and tracked in the [delivery report](reconciliation/delivery_finalization/report.md); final contract acceptance, rehearsal and video capture remain open. No speaker notes are commissioned.

**Learning outcomes, after successful teaching and practice:** students should be able to

1. Specify observed/unknown quantities, model parameters, query and criterion for a concrete prediction or missing-measurement problem; distinguish variable inference from fitting.
2. Derive the Gaussian conditional through a jointly Gaussian independent residual, apply the resulting conditional/marginal laws, and explain which uncertainty each law represents.
3. Construct/use the LGS joint, interpret scalar gain and qualified sensor weighting, and obtain inverse and before-observation forward distributions from the same model.
4. Justify and compute the squared-loss conditional-mean action and minimum model risk; interpret the guided reconstruction, uncertainty and generation outputs without claiming guaranteed hidden-value recovery or model validation.

**Extent and readiness:** target approximately two hours live plus a separate one-hour notebook. The existing macro estimates total 110 minutes plus about ten minutes for discussion/slippage; this is a **tight, unmeasured planning envelope**, not demonstrated fit. The accepted checkpoint and live loss proof retain their provisional allowances. Rehearse the actual accepted sequence before declaring the two-hour fit; any further compression or proof relocation needs the appropriate instructor decision. The notebook author's **55–75-minute** estimate is subjective and signals risk to the one-hour target, not measured timing. Local execution is separate evidence; hosted Colab and learner-time validation remain pending. The lightweight Section Design preview is complete; full-Scope approval still requires instructor review.

### Handoff and exact review basis

These additions supply missing Parts 4/5 only: a role/provenance/depth/delivery/notebook link for the existing example families and a short endpoint/outcomes/assumptions contract. They neither redesign sections nor reopen accepted proof or route decisions. Current examples and notebook continuation fit the architecture's working-competence aim at a deliberately controlled first-use level; stronger practical claims await later data/model-fitting encounters.

**Unresolved instructor-owned choices:** acceptance of the assembled Scope, the recording's detailed contract/extent, and any necessary workload/live-time adjustment after measured trials or rehearsal. The current notebook and selected loss realization are accepted. The Section Design preview, author/runtime checks and hosted Colab run are validation responsibilities, not choices about formula correctness to hand to the instructor. The independent Section Design feasibility preview is linked above at its recorded source; it is not instructor approval.

**Source basis inspected:** current delivery-branch Scope, `development_state.md`, `NEXT_SESSION.md`, architecture and planned/actual maps; live `slide_deck.typ` source SHA-256 `66ec0914f65f008b8ecacb20c2faad61e9b630dfd1f8b1dc5a9e8f196d073e7f`; solved notebook `42dec1fa6d59af3f76e9102d3c07832b944bd3c225ed5947df2766b0e03ee9b7` and its current authoring report. These were read during the coordinator's integration, committed locally as `44f9a4d`. Local source checks used `Resources/book1.pdf` and `Resources/book2-1.pdf`; exact titles/numerical qualifications above were checked anew. No repository/map edits were made. The actual map remains untouched until teaching occurs.


## Source records and checking material

Decision-update baseline: `rescope-l01-l12-architecture-alignment-20261014`, HEAD `18d652d28a9139a9b1ab7189190ead1005d7c236`. Mathematical-spine construction used HEAD `5ba226342cbca91a1d52b5bd88bc7efeeee04b37` and input arc blob `fb2775ac8d25d891bf8a2f5c3031ef58542afc94`. The following hashes preserve the examined baseline; the accepted insertion has changed the live deck through separately owned implementation work. Live-loss-insertion baseline source SHA-256: `5c4d188124c261ea0a576f4eb46fceeec136076bd3e9f9098305fee73b84006c`; the bounded report records mechanical/render checks, while comparative alignment is now reopened:

- Deck: `235b8eeb48ec9075d2bcea82b6a377c0a45b6a79`.
- Coverage specification: `c4457bc4fdb11df14de54658f20e487030766328`.
- Solved notebook: `ab441941c8b526151a927bfbcf292bd9bc629ce5`.
- Architecture: `cb111196e44df211e39864be596233a1a3f22aba`.
- Planned map: `63fb5cea0a7b0a4c908c8f803e550d087d20a412`.

Murphy, *Probabilistic Machine Learning: Advanced Topics*, December 10, 2025 online edition: Chapter 1, printed pp. 1–2, for model/task distinctions; §2.3.1.1 “Definition”; §2.3.1.3 “Marginals and conditionals of an MVN”; §2.3.1.5 “Derivation: moment form,” for the source's block-quadratic argument; §§2.3.2.1 “Joint distribution,” 2.3.2.2 “Posterior distribution (Bayes’ rule for Gaussians),” and 2.3.2.3 “Example: Sensor fusion with known measurement noise,” for joint-to-forward/inverse reuse. Murphy, *Probabilistic Machine Learning: An Introduction*, April 18, 2025 online edition: §3.2.4 “Example: conditioning a 2d Gaussian”; §3.2.5 “Example: Imputing missing values”; §5.1.5.1 “L2 loss,” for the mean/loss distinction. The course residual proof reorganizes the source derivation; its synthetic example is course-constructed.

**Spine source check:** Book 2 §2.3.1.1, Eqs. 2.71–2.73 (density/geometry); §2.3.1.3, Eqs. 2.75–2.79 (blocks/marginals/conditionals); §2.3.1.5, Eqs. 2.88–2.92 (block inverse/Schur complements), 2.94–2.103 (separated exponent, factorization and conditional parameters); §§2.3.2.1–2.3.2.2, Eqs. 2.118–2.126 and 2.129 (LGS/posterior/marginal). Book 1 §3.1.1, Eq. 3.5 (affine covariance), §3.2.5 (imputation), and §5.1.5.1, Eqs. 5.32–5.34 (squared-loss posterior mean). The vector risk decomposition and explicit determinant step are course elaborations. The recording's SPD assumption guarantees both full and Schur inverses; mere invertibility of two diagonal blocks alone does not. Source inspection used local edition extracts; no new implementation, rehearsal, runtime or independent mathematical review was performed.

**Author checking material, not a student-visible teaching commitment:** dense conditioning factors an observed $D\times D$ covariance in $O(D^3)$ work. Fixed parameters and observation pattern permit reuse of factors/gain; subsequent $L$-dimensional posterior means cost $O(LD)$. This is an exact structural computational advantage over generic sampling for these queries, not a claim that sampling is necessary at this example's scale. Factorization/reuse complexity is absent from the existing deck; this analysis does not add it to the proposed live teaching.

[Reconciliation evidence](reconciliation/matrix.md) preserves historical review versions, source errors and runtime limitations. This Scope edit records the accepted live addition; its separately owned slide implementation and validation are tracked by the coordinator. No independent feasibility, runtime or student validation is claimed for this decision update.
