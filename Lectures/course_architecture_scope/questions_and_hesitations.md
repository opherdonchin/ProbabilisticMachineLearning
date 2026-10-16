# Teaching choices for instructor review

**Historical review context (2026-10-13):** This document analyzes the earlier proposed scopes and teaching choices. The updated [course architecture](../../course_architecture.typ) places *practical competence with recognizable machine-learning tasks and particular algorithms* above a self-contained mathematical system, and proposes changes to the L04 and L07–L10 notebook exercises. Thus prior instructor selections and calculations below remain useful *provenance*, not current final designs. Reassess feasibility and choices against the newer architecture before using these notes as a decision list.

This report explains the mathematical and pedagogical stakes of the proposed choices. It assumes probability, calculus, linear algebra and Bayesian modeling; it does not assume that the later methods or Murphy's chapter contents are familiar. The formulas identify the distinctions that matter for a decision, rather than asking the instructor to check the authors' algebra.

L03’s existing scope and simpler notebook restoration method, and L04’s lighter parity-code example, are instructor-agreed. The other choices remain proposals. The instructor reviews each scope alongside its questions and chooses where to stop for work; no predetermined question-by-question sequence is imposed. The [review register](STATUS.md) identifies the evidence and versions. **Derive** means students follow the calculation; **state** means they receive and interpret the result without its full proof; **apply** means they use an established result.

Each reading suggestion below is selective: it explains what to look for, rather than assigning a chapter. **Book 2** is Murphy's *Probabilistic Machine Learning: Advanced Topics* (inspected online edition December 10, 2025); **Book 1** is *Probabilistic Machine Learning: An Introduction* (April 18, 2025). Relevant passages were checked against the actual local texts. The course retains the source corrections recorded in the [source-inspection report](source_inspection.md); a reading reference is not a blanket endorsement of every printed formula or claim.

## L03 — Preserve the agreed graphical-model argument and notebook work

**Already agreed:** The scope on `lecture-3-authoring` develops graphical models as a language for joint distributions and conditional independence. The simpler image-restoration method is the notebook application. The batch proposal missed that scope; no fresh choice between lecture routes is needed. [Restored scope](../L03_Graphical_Models/lecture_scope.md).

The mathematical argument starts with L02’s Markov chain. The chain rule always factorizes a joint distribution; restricting each conditional to a small set of graph parents adds independence assumptions. Murphy’s student network shows what those assumptions buy: a compact joint model described by small conditional probability tables. Students then learn how paths, conditioning and colliders determine the independences a directed graph guarantees. Undirected models describe local interactions using positive potentials and a global normalizing constant. Their separation rules differ from directed rules; the collider and four-cycle comparisons make that difference precise. The lecture ends by interpreting the binary Ising model.

**What remains new in the notebook:** Students construct the Ising prior and Gaussian observation likelihood, form the joint and posterior, and derive the single-site conditional by canceling factors independent of that site. For a uniform coupling $J$ and observations $y_i\mid z_i\sim N(z_i,\sigma^2)$, the resulting local preference is $H_i=y_i/\sigma^2+J\sum_{j\in N(i)}z_j$. Here $N(i)$ is the neighbor set and $z_i\in\{-1,+1\}$. Students connect that conditional to a local maximum-a-posteriori choice and implement or complete iterative conditional modes (ICM): change one pixel to its better value while holding the others fixed. These are notebook derivations, not solved live examples.

**Concern to retain:** Model construction, conditional derivation and implementation are substantial work for one hour. Authors should supply data handling, plotting, small interfaces and checks while preserving the conceptual work. The algorithm may stop at a local optimum and does not produce posterior samples or marginal probabilities. Its initialization or local-optimum limitation must be examined. Actual student timing and runtime remain untested. Moving the derivation live to save lab time would change the existing agreement and requires an explicit teaching decision.

**Focused reading:** Book 2 §§4.2.2 and 4.2.4 for DAG factorization, the student network and path-based independence; §§4.3.1 and 4.3.6.1 for positive potentials and undirected separation; §4.5.1 for the collider/four-cycle distinction. Then read §4.3.2.1 and §4.3.8 for the Ising model and image inference. These readings explain the restored argument and the live/notebook boundary; Murphy’s inference algorithms are references, not the selected student method.

## L04 — A parity check can detect an error without locating it

**Instructor-selected split (2026-10-12):** Use the lighter three-bit parity detector for the **lecture** and the five-bit correcting code for the **student notebook**. The latter changes student work and requires a targeted feasibility review and notebook timing trial.

Encode a two-bit message as $c(m)=(m_1,m_2,m_1\mathbin{\mathrm{XOR}}m_2)$. Its valid words are `000,011,101,110`; each pair differs in two positions. With a uniform prior over the four messages and independent flips with probability $\alpha$, the likelihood of a received word is $\alpha^d(1-\alpha)^{3-d}$, where $d$ counts differing positions. Exactly one flip violates parity, but the observed word may lie one bit from three valid originals. At $\alpha=0.2$, receiving `100` gives posterior probabilities $(16,1,16,16)/49$ in the listed message order. A MAP decoder has three equally good guesses, not guaranteed correction.

Students **derive** mutual information and follow the data-processing proof sketch, **work** this posterior, and **apply** both information and error calculations to the complete finite channel. The distinction matters: at this noise level the check bit increases information per message, but optimal whole-message error remains 0.36, equal to uncoded two-bit transmission. More information and a lower error under a particular decision loss are different statements. The notebook develops the five-bit construction `c5(m1,m2)=(m1,m2,m1,m2,m1 XOR m2)` with minimum distance 3, so nearest-codeword decoding recovers the message whenever at most one bit flips. With α=0.2, its optimal whole-message error is 0.22176 (versus 0.36 for three-bit parity or uncoded transmission), at a lower message rate of 2/5 rather than 2/3. Students use supplied 4×32 channel enumeration to check the decoder, MI and the reliability/rate tradeoff, not a second full lecture derivation. [L04 scope](../L04_Information_Theory/lecture_scope.md).

**Focused reading:** Book 2 §5.5, **Error-correcting codes (channel coding)**, contains this exact parity-channel model and its three posterior modes. Read it to distinguish the Bayesian decoding problem from a claim that any added parity bit guarantees correction. Book 1 §6.3.2, **Interpretation**, explains mutual information as average uncertainty reduction.

## L05 — A unified GLM lesson, a vector classifier and reverse differentiation in one meeting

**Open, high priority:** Does combining these mathematical transitions with first PyTorch exposure leave enough time for understanding?

The scalar canonical generalized linear model has log likelihood $[y\eta-A(\eta)]/\phi+\log h(y,\phi)$, with $\eta=w^Tx$, fixed dispersion $\phi$ and mean $\mu=A'(\eta)$. Students **derive one common mean-loss gradient**:

$$
\nabla_w L=\frac1{N\phi}\sum_n x_n(\mu_n-y_n).
$$

This genuinely unifies Gaussian, Bernoulli and Poisson responses without three separate proofs. The three-class Iris model needs a second, short mathematical step: categorical probabilities are a vector. With class-score vector (logits) $z=Wx+b$, probabilities $p=\operatorname{softmax}(z)$ obtained by normalizing exponentials, and one-hot target $t$ (one at the observed class, zero elsewhere), students **work/apply** $\nabla_z\ell=p-t$ and $\nabla_W\ell=(p-t)x^T$. It is not justified by mechanically inserting a vector response into the scalar formula. A common shift of all logits leaves probabilities unchanged, so even this simple fit does not uniquely identify every coefficient.

They then **work one complete reverse-mode automatic-differentiation graph**. The key new point is adding derivative contributions when an intermediate value feeds multiple paths; merely calling `backward()` would conceal it. Minibatch gradient descent is introduced with a brief uniform-sampling expectation argument, not a convergence theorem. The lab checks one manual batch gradient against PyTorch and fits all three Iris classes using supplied data preparation, indexing and plots.

**Concern and alternative cost:** the proposed 115 live minutes plus 60-minute lab are unpiloted, and these are distinct conceptual changes despite their shared loss. First remove optional prior/probit illustrations and repeated examples, preserving the common derivation, vector application and full backward calculation. A separate optimization/software meeting would create more space but displace another lecture and change the preparation for L09–L12. [L05 scope](../L05_GLM_Optimization/lecture_scope.md).

**Focused reading:** Book 2 §15.1.3, **Maximum likelihood estimation**, shows the scalar residual-gradient argument; §15.3.2, **Multinomial logistic regression**, identifies the vector model. Then §6.2.2.2, **From chains to circuits**, explains why multiple paths require summing reverse contributions. Book 1 §13.3.1, **Forward vs reverse mode differentiation**, is an alternative chain-rule explanation if the circuit presentation is unfamiliar. The scalar fitting passage's uniqueness claim needs the course's rank/separation qualifications; convexity alone does not give a finite unique estimate. These readings clarify the workload, not extra required lecture proofs.

## L06 — EM as a touching-bound argument, not repeated mean imputation

**Open:** Keep missing-Gaussian measurements as the deep application, or replace the notebook with Gaussian-mixture MRI segmentation?

Expectation–maximization (EM) alternates inference about missing values with parameter fitting. Its reason for improving observed likelihood depends on a distribution over those values, not filling blanks with a guessed completion. Students **derive** the identity

$$
\ell(\theta)=F(q,\theta)+\sum_n\operatorname{KL}\!\left(q_n\|p_\theta(z_n\mid o_n)\right).
$$

Here $o_n$ denotes observed entries and $z_n$ missing entries. The trial distribution $q_n$ is over the missing entries for case n, and $F$ is the sum of the per-case entropy-including evidence lower bounds. An exact posterior E-step makes $F$ equal to $\ell$ at the current parameters; increasing the same bound with $q$ fixed gives the short monotonicity proof. The expected complete-data log likelihood alone omits the entropy constant, although it has the same parameter maximizer in that M-step. A restricted or approximate E-step need not make the bound touch, so improving it does not automatically preserve this observed-likelihood monotonicity. Exact-step monotonicity itself is not a guarantee of global fitting success.

The Gaussian application requires two expected statistics, not one:

$$
E[X_nX_n^T\mid o_n]=m_nm_n^T+C_n,
\qquad m_n=E[X_n\mid o_n].
$$

Students **derive/work** this second-moment calculation, **derive** the mean update and **apply** Gaussian moment matching for covariance. Dropping conditional covariance $C_n$ changes the estimator. The lab deliberately uses value-independent random masking; more general missingness would require additional ignorability assumptions. A mixture responsibility is briefly **stated/worked** as the expected component indicator, without a second complete mixture fit.

**Concern and alternative cost:** the bound proof plus moment assembly is already tight within 112 live minutes and one hour of lab. MRI segmentation offers a stronger biomedical outcome but adds component-specific parameter updates, preprocessing and interpretation of tissue assignments. It should replace the current application, not be appended. The present choice concentrates on the uncertainty calculation and reuses L01 conditioning; it gives up the medical-image result. [L06 scope](../L06_EM/lecture_scope.md).

**Focused reading:** Book 2 §§6.5.3.1–6.5.3.3, **Lower bound / E step / M step**, make tightness and the fixed-distribution maximization explicit; §§6.5.4.1–6.5.4.2, **E step / M step** in the missing-Gaussian example, show the moments/updates. For the alternative, Book 1 §8.7.3.1–§8.7.3.2, **E step / M step** for a Gaussian mixture, shows what extra fitting mathematics it entails. The course distinguishes the full bound $F$ from its entropy-free expected log likelihood even where Murphy's notation changes across passages.

## L07 — Laplace uses local curvature; the comparison must assess the whole posterior

**Open:** Retain a scalar, independently checkable regression posterior rather than a larger real-data example?

Laplace approximation expands negative log joint density $E(\theta)$ at an interior stationary mode $\hat\theta$. Students **derive** the scalar Taylor approximation and its Gaussian normalizer, and **state** the multivariate result:

$$
q_L(\theta)=N(\hat\theta,H^{-1}),\qquad H=\nabla^2E(\hat\theta)\succ0.
$$

Positive-definite curvature is needed to normalize this Gaussian; a merely nonnegative Hessian is insufficient. The approximation describes one neighborhood, so finding a mode and obtaining positive curvature do not establish global accuracy. A skewed posterior can have a different mean, and posterior prediction $E[\operatorname{sigmoid}(x_*\theta)\mid D]$ need not agree with the prediction at the mode.

**Current proposal:** use the fixed eight-observation logistic model with Gaussian prior. Students **derive** its curvature; prior precision makes it strictly positive and gives a finite unique mode despite separated labels. In the lab they compare summaries and predictions with numerical quadrature, independently refining spacing and widening the domain. This separates Laplace error from an inadequately checked reference integral.

**Concern and alternative cost:** the controlled example exposes the precise approximation issue, but does not demonstrate high-dimensional deployment. A larger model adds a Hessian/solver workload and loses the easily checked integration reference. The present 110-minute lecture and one-hour lab protect the derivation and the checking skill; they do not promise asymptotic error theory or an exact numerical gold standard. [L07 scope](../L07_Inference/lecture_scope.md).

**Focused reading:** Book 2 §7.4.3, **Laplace (quadratic) approximation**, gives the construction and a skew example; §7.4.2, **Grid approximation**, supplies the comparison method. Book 1 §10.5.1, **Laplace approximation**, connects it directly to logistic regression. Read these to distinguish mathematical existence of the local Gaussian from accuracy for a chosen posterior query.

## L08 — General discrete sum-product inference or Gaussian forecasting as the main application?

**Open, high priority:** Which exact sequence-inference calculation should students derive and implement in depth?

For a hidden Markov model (HMM), observations arise from unobserved categorical states that change over time. Forward–backward inference sums over possible histories while reusing partial sums. With $A_{ij}=p(z_t=j\mid z_{t-1}=i)$ and $\lambda_t(j)=p(y_t\mid z_t=j)$, its forward joint message satisfies

$$
a_t(j)=\lambda_t(j)\sum_i A_{ij}a_{t-1}(i).
$$

Students **derive/work** both forward and backward recurrences and their combination into smoothed marginals. Scaling prevents products of small probabilities from vanishing numerically. Dense calculation costs $O(TK^2)$ rather than enumerating $K^T$ histories. They **work** a counterexample distinguishing the most probable whole history from the sequence of marginally most probable states; these solve different decision problems.

Kalman filtering performs an analogous prediction/measurement update for continuous states. It is exact because a linear-Gaussian transition and Gaussian measurement preserve Gaussian beliefs, represented by mean/covariance rather than a finite probability vector. The current proposal **states** that model and **applies** L01 conditioning in a compact scalar/matrix comparison, including covariance propagation $P^-=FPF^T+Q$. It does not derive and implement a second full filtering system.

**Concern and alternative cost:** the discrete lab gives visible marginalization, smoothing and reusable factor-based computation. The alternative Kalman forecasting lab better serves the earlier continuous-time-series preference and reinforces Gaussian modeling. Making it primary would require reducing the discrete derivation/implementation; fully doing both would exceed the current 112-minute lecture and 60-minute lab. Forecasting questions/data were located, but the named solved notebook was not verified. [L08 scope](../L08_Structured_Inference/lecture_scope.md).

**Focused reading:** Book 2 §9.2.2, **The forwards algorithm**, and §9.2.3, **The forwards-backwards algorithm**, show the finite sums and smoothing. Then §8.2.2.1–§8.2.2.2, **Predict step / Update step**, shows their Gaussian counterpart. This side-by-side reading is useful before deciding which mathematics and application should dominate.

## L06–L11 — Checkable benchmarks versus empirical modeling experience

**Open across lectures:** How much realism should replace deliberately controlled examples?

The simple data are not intended to remove mathematics. They expose different kinds of error: missing covariance terms in L06, integration versus approximation error in L07, lost dependence in L09 and observation-noise versus parameter uncertainty in L11. A known answer lets a student see whether a failed result comes from an implementation, an unfinished optimization or the chosen model family.

The cost is less experience with data preparation, model misspecification and decisions under an unavailable exact reference. The current proposal gives up the MRI segmentation, Kalman forecasting and unknown-noise economic-regression notebooks; L12 retains real metropolitan data. Selecting one empirical application is a substantive preference, not an author correctness check. It should replace its corresponding notebook and be reviewed for workload; retaining all of them would displace mathematical methods or require more course time.

## L09 — Separate restricted-family error from optimization error in variational inference

**Open:** Use known-noise Gaussian regression to understand variational inference before a more realistic unknown-noise application?

Variational inference chooses a distribution $q$ from a restricted family by minimizing **reverse KL**, $\operatorname{KL}(q\|p(w\mid D))$. Students **apply** L06's bound identity and **work** the effect of restricting $q$ to independent Gaussian coordinates. For a Gaussian target $N(a,S)$ and approximation $q=N(m,V)$ with diagonal covariance V, the best reverse-KL approximation has

$$
m^*=a,\qquad V_{jj}^*=\frac1{(S^{-1})_{jj}},
$$

not simply the target marginal variances $S_{jj}$. In the course's correlated two-dimensional example, $V_{jj}=0.18$ whereas $S_{jj}=0.5$. Consequently even perfectly optimized independent coordinates cannot reproduce every predictive variance. The lab has both an exact target and an analytic best-diagonal reference, separating fitting error from this family error.

The main algorithmic teaching is a **derived pathwise gradient**: write $w=m+e^\rho\odot\epsilon$ with mean m, log standard deviations $\rho$, elementwise multiplication $\odot$ and fixed-law $\epsilon\sim N(0,I)$, then differentiate through the draw. This includes any direct parameter dependence of the integrand, not only the derivative through $w$; exchanging differentiation and expectation requires differentiability almost everywhere and a locally integrable bound on the derivatives. The Gaussian quadratic example supplies those conditions. Coordinate-ascent variational inference (CAVI) is an alternative: **state/apply** $q_j\propto\exp(E_{q_{-j}}\log p(D,w))$ on the same Gaussian target. It optimizes one distributional factor at a time; it is neither a Gibbs draw nor L03's pointwise coordinate maximization. A full functional derivation or second solver is not promised.

**Concern and alternative cost:** known noise makes the posterior exactly computable and protects the gradient/geometry lesson in 112 live minutes and a one-hour lab. Economic data with an unknown scale adds an inference dimension and removes that direct reference. A sampling comparison would also import L10's method early. The tradeoff is empirical breadth, rather than whether an analytically solvable problem deserves an approximation for teaching. [L09 scope](../L09_Variational_Inference/lecture_scope.md).

**Focused reading:** Book 2 §10.1.2, **Form of the variational posterior**, explains the family choice; §6.3.5.2, **Total derivative**, explains the full reparameterized derivative. Read §10.3.1, **Derivation of CAVI algorithm**, only to compare the coordinate alternative. Book 1 §6.2.6, **Forward vs reverse KL**, explains why the direction of divergence matters; it does not establish a universal claim that every variational estimate is too narrow for every query.

## L10 — Invariance is a correctness property; mixing determines usable estimates

**Open:** Keep Metropolis–Hastings as the principal implementation and Hamiltonian Monte Carlo at recognition depth?

For target density $\pi$, Metropolis–Hastings proposes $x'$ from $q(x'\mid x)$ and accepts with

$$
a(x,x')=\min\left\{1,\frac{\pi(x')q(x\mid x')}{\pi(x)q(x'\mid x)}\right\}.
$$

Students **derive** this rule and **prove** detailed balance implies invariance: if the current distribution is $\pi$, the next distribution is also $\pi$. Rejection repeats the current state and is part of the chain. An asymmetric proposal needs the proposal ratio; an unknown target normalizer cancels.

Invariance does not say how quickly a chain started elsewhere approaches its target or travels between separated modes. Students **state/explain** convergence conditions: in a finite state space, irreducibility and aperiodicity ensure eventual convergence, without a useful finite-run rate; continuous-state results require corresponding recurrence conditions. They **derive** the stationary variance accounting for dependence. Effective sample size is tied to a particular function $g(X)$ being estimated; an apparently large estimate cannot certify that an unvisited mode has been explored. The two-mode lab compares starts/proposal sizes against known mean and mode-region probabilities, so correctness and practical mixing can fail in visibly different ways.

**Concern and alternative cost:** Hamiltonian Monte Carlo (HMC) uses gradients and auxiliary momentum to propose longer trajectories. The current proposal **states/recognizes** its mechanism and acceptance correction. Deriving Hamiltonian dynamics and leapfrog's reversibility/volume preservation, then implementing them, would replace part of the present 110-minute correctness/diagnostics lesson and one-hour comparison lab. HMC is also not an automatic cure for separated modes. [L10 scope](../L10_MCMC/lecture_scope.md).

**Focused reading:** Book 2 §12.2.2, **Why MH works**, gives the invariant-distribution argument; §12.6.1, **Mixing rates of Markov chains**, explains the distinct convergence question. For the alternative's additional machinery, inspect §12.5.2.3, **Leapfrog integrator**, and §12.5.3, **The HMC algorithm**. These show why using a library sampler and understanding its construction are different teaching commitments.

## L11 — A heteroskedastic predictor does not provide a posterior over network weights

**Open:** Make a small nonlinear Gaussian predictor the first neural-network application, rather than Bayesian weight inference or an architecture survey?

The selected network outputs mean $\mu_w(x)$ and positive standard deviation $\sigma_w(x)$, learning input-dependent observation noise: *heteroskedastic regression*. Students **derive/work** its Gaussian loss and mean/log-scale derivatives:

$$
\ell=\log\sigma+\frac{(y-\mu)^2}{2\sigma^2}+\tfrac12\log(2\pi),
\qquad \frac{\partial\ell}{\partial\log\sigma}=1-\frac{(y-\mu)^2}{\sigma^2}.
$$

The log-scale term prevents simply making every predicted variance large to reduce a squared-error penalty. Students **apply** L05 reverse differentiation through the shared network and two outputs; they do not learn another complete backpropagation proof.

At fitted weights, an interval from $\mu_{\hat w}\pm1.96\sigma_{\hat w}$ describes conditional observation noise. A Bayesian predictive distribution instead averages over $p(w\mid D)$, with total variance

$$
\operatorname{Var}(Y_*\mid x_*,D)
=E[\sigma_w^2(x_*)\mid D]+\operatorname{Var}[\mu_w(x_*)\mid D].
$$

Students **apply/explain** this decomposition and **derive** the narrow Gaussian-prior/squared-weight-penalty connection. A MAP penalty still gives a point fit, not a weight posterior. Neither the fitted scale nor these conditional intervals automatically establish calibration or extrapolation reliability.

**Concern and alternative cost:** one shallow network plus a supplied fixed-noise comparison preserves probability-model interpretation and prepares L12 within 112 live minutes and one lab hour. Bayesian neural-network inference would add a high-dimensional approximation/sampling task; a classification-architecture survey would instead spend that time on different model structures. Both offer worthwhile breadth but replace the worked mean/scale endpoint. [L11 scope](../L11_Neural_Prediction/lecture_scope.md).

**Focused reading:** Book 1 §13.2.4.4, **MLP for heteroskedastic regression**, directly explains the two-output model. Book 2 §16.1, **Introduction** to the deep-neural-network chapter, explains using differentiable networks inside probability distributions; the opening equations of §17.3.10, **Approximating the posterior predictive distribution**, show what averaging over weights adds. Reading the latter is for the uncertainty distinction, not a proposed Bayesian-network lab.

## L12 — A VAE rate penalty is not mutual information alone, and its units matter

**Open, high priority:** Retain real mobility data as the synthesis application under a deliberately approximate Gaussian likelihood?

A variational autoencoder (VAE) combines a generative decoder $p_\theta(x\mid z)$ with an encoder $q_\phi(z\mid x)$ that approximates the hidden-coordinate posterior. The encoder shares its inference parameters across observations, instead of optimizing a new free distribution for each row. Students **apply** L06's lower bound, L09's pathwise derivative and L11's Gaussian likelihood to jointly train these networks; this reuse is what makes the final lecture possible.

For the data distribution $p_D$, define the joint inference distribution $q(x,z)=p_D(x)q_\phi(z\mid x)$ and its aggregate encoder distribution $q(z)=E_{p_D}q_\phi(z\mid X)$. Mutual information $I_q(X;Z)$ is computed under that joint distribution. Suppressing the fixed encoder parameters in the notation, students **derive**

$$
R=E_{p_D}\operatorname{KL}(q(Z\mid X)\|p(Z))
=I_q(X;Z)+\operatorname{KL}(q(Z)\|p(Z)).
$$

Thus nonzero “rate” R may mean mismatch with the prior rather than useful information about observations. If every input has the same $q(z\mid x)=N(1,1)$ against prior $N(0,1)$, then R=1/2 but mutual information is zero. This is why neither a positive KL penalty nor a latent scatterplot establishes an informative or uniquely meaningful representation. Collapse and sign/permutation ambiguities are explained without promising a general identifiability proof.

The beta-VAE objective $D+\beta R$ trades expected reconstruction cost $D=E_{p_D}E_{q(z\mid X)}[-\log p_\theta(X\mid Z)]$ against rate. **Apply/work:** D sums Gaussian negative log likelihood over 19 features, R sums KL over four latent coordinates, then both average over observations. At decoder variance $\tau^2=1/2$, the variable part of D is squared-error **sum**. The inspected source instead averages feature errors and latent KL separately: multiplying its objective by 19 makes source $\beta=4$ correspond to course $\beta=19$, not 4. Comparisons must therefore use the normalized course objective; changing reductions changes the tradeoff being taught. D also averages over encoder draws; decoding only the encoder mean illustrates reconstruction but does not estimate the same D.

**Current proposal:** four hidden coordinates for 19 preprocessed metropolitan measurements; one small fit and supplied, consistently normalized beta comparisons in 112 live minutes and a one-hour lab. A diagonal Gaussian likelihood in transformed/standardized coordinates is tractable, but raw proportions, counts and other constrained quantities do not all have Gaussian support. We teach that approximation explicitly, not claim the decoder reproduces every raw measurement type or discovers independent urban causes.

**Concern and alternative cost:** type-specific likelihoods would improve support fidelity but introduce several likelihoods/output parameterizations and more code. Synthetic or substitute open data could simplify distribution permission but change the practical application. The mobility-data choice is pedagogical; portable access and redistribution permission are publication obligations to resolve separately. Prepared results may support interpretation if bounded student training is slow, without claiming convergence. [L12 scope](../L12_VAE/lecture_scope.md).

**Focused reading:** Book 2 §21.2.1–§21.2.2, **Modeling assumptions / Model fitting**, shows the encoder/decoder roles. §5.4.2, **Lossy compression and the rate-distortion tradeoff**, defines expected distortion and explains why rate bounds information; §21.3.1, **β-VAE**, shows the objective's tradeoff. The short §21.3.1.1, **Disentangled representations**, explains why changing beta does not identify true latent factors. These are selected interpretations, not a commitment to the chapter's broader VAE variants.

## What remains for oversight, and what belongs to the authors

The largest remaining pedagogical choices are L05's combined workload, HMM versus Kalman priority in L08, the course-wide balance between checkable benchmarks and empirical applications, and the L12 mobility likelihood/application. Other substantial additions—particle methods, Bayesian neural networks, Gaussian-process prediction or alternative generative-model families—would require displacing something in the thirteen-meeting course. The [architecture audit](architecture_audit.md) explains that allocation; they are not silently assigned future work.

The authors own correct gradient signs, covariance terms, probability normalization, variance conventions, objective reductions and consistent diagnostics. The distinctions above explain why a choice matters; they are not technical approvals for the instructor to supply. Authors also owe promised helper code, technically validated worked solutions, clean local uv and hosted Colab runs, and realistic student-workload trials. None of those runs or trials has occurred in this scope-writing phase. Lecture budgets remain estimates, and L01/L02's established material is unchanged.
