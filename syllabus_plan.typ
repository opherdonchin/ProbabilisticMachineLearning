#set page(
  paper: "a4",
  flipped: true,
  margin: 10mm,
)

#set text(
  font: "Libertinus Serif",
  size: 8pt,
)

#set par(
  leading: 0.55em,
  spacing: 0.6em,
)

#let navy = rgb("#173A5E")
#let rule = rgb("#D8DEE4")
#let muted = rgb("#59636E")

#show heading.where(level: 1): it => block(
  above: 0.7em,
  below: 0.4em,
)[
  #text(size: 15pt, weight: "bold", fill: navy)[#it.body]
]

#let hdr(body) = table.cell(fill: navy, inset: 5pt)[
  #text(weight: "bold", fill: white)[#body]
]

#let note(body) = text(size: 7.3pt, fill: muted)[#body]

= Syllabus plan

This working map records the instructor-selected architecture of 13 meetings and its reviewed L03–L12 scope proposal (2026-10-11). Dedicated information theory L04, unified GLMs/optimization L05 and EM L06 remain in their accepted order. The ten detailed scopes are *agent-approved / instructor-pending*, with independent previews and a separate adversarial course review. See #link("Lectures/course_architecture_scope/STATUS.md")[scope/review registry], #link("Lectures/course_architecture_scope/architecture_audit.md")[whole-course audit] and #link("Lectures/course_architecture_scope/questions_and_hesitations.md")[instructor decisions].
The course is organized around four recurring ideas:

- a machine-learning task can be expressed through a joint probability model and a query;
- the structure of the joint distribution and the required integral / expectation / decision determine the computational problem;
- practical methods trade simplifying structural assumptions, approximation, and brute-force computation;
- students should leave with a useful collection of modern tools, including both classical probabilistic methods and network-based models.

*Book 2 is the primary curricular spine.* Book 1 is supplementary rather than co-equal: a Book 1 section is retained only when it supplies necessary background, offers a more pedagogical development, gives a useful worked example, or provides an alternative treatment that may materially improve the lecture.

#note[*Status:* L01 delivered provenance; L02 agreed, not recorded delivered; L03–L12 reviewed agent proposal; L13 projects/synthesis. References mean the selected depths in the scopes, not whole-section coverage. Future notebooks are source-inspected interfaces, not tested implementations; no Colab/runtime claims are made.]

#v(0.5em)

#table(
  columns: (8mm, 31mm, 55mm, 46mm, 42mm, 71mm),
  inset: 4pt,
  stroke: 0.45pt + rule,
  align: (left, left, left, left, left, left),

  table.header(
    hdr[No.],
    hdr[Lecture],
    hdr[Topics covered],
    hdr[Book 2 — primary],
    hdr[Book 1 — supplemental],
    hdr[Notebook problem, worked reference and skill],
  ),

  [1],
  [*Probabilistic ML and Gaussian systems* \
  #note[Delivered]],
  [Machine-learning task framing; probabilistic models; Bayes review; covariance and correlation; multivariate Gaussians; conditioning; missing-data inference; linear Gaussian systems.],
  [
    - 2.1.5–2.1.6 Conditional probability; Bayes
    - 2.2.1.1 Bernoulli and binomial
    - 2.2.4.1 Beta distribution
    - 2.3.1.1 Gaussian joint distribution
    - 2.3.1.3–2.3.1.5 Gaussian conditionals; information form
    - 2.3.2.1–2.3.2.2 Linear-Gaussian systems
    - 3.2.1 Coin-flipping Bayes
    - 3.4–3.4.1 Conjugate priors; binomial
  ],
  [
    - 1.1–1.5 ML tasks and datasets
    - 2.3 Bayes’ rule
    - 2.4.1 Bernoulli; binomial
    - 2.7.4 Beta distribution
    - 3.1.1–3.1.3 Covariance; correlation
    - 3.2.1–3.3.4 Multivariate and linear Gaussians
    - 4.3–4.3.1 Empirical risk
    - 4.6.1–4.6.2 Beta-binomial Bayes
  ],
  [*Gaussian measurement imputation (already delivered).* Condition a multivariate Gaussian on observed measurements, infer missing values and their uncertainty. Reference: #link("https://github.com/opherdonchin/ProbabilisticMachineLearning/blob/lecture-3-prep/InClass/Solutions/lecture1_missing_data.ipynb")[Existing L1 solved notebook].],

  [2],
  [*Exponential families and learning from sufficient statistics* \
  #note[Agreed scope]],
  [Exponential-family representation; Gaussian canonical form; derivatives of the log-partition function; natural and mean parameters; MLE as moment matching; maximum entropy; Gamma fit; categorical counts; Markov-chain learning.],
  [
    - 2.2.1.2 Categorical distribution
    - 2.4.1–2.4.2 Exponential-family form; examples
    - 2.4.3–2.4.4 Log partition; moments
    - 2.4.5 MLE; moment matching
    - 2.4.7 Maximum entropy
    - 2.6.1–2.6.3 Markov chains; language models
  ],
  [],
  [*Baby-name character bigram model.* Count character transitions in the names corpus, normalize the transition matrix, compute sequence NLL and generate new names. Reference: #link("https://github.com/karpathy/nn-zero-to-hero/blob/master/lectures/makemore/makemore_part1_bigrams.ipynb")[Karpathy’s solved bigram notebook].],

  [3],
  [*Graphical models* \
  #note[Agent-approved / instructor-pending]],
  [DAG entailment recall; positive MRF potentials and global normalization; a tiny Ising partition function; separator/local CI; posterior local conditionals and coordinate MAP limitations; factor-graph incidence.],
  [
    - 4.2.1 / 4.2.4 DAG recall (selected)
    - 4.3.1–4.3.2.1 MRF / Ising normalization
    - 4.3.6.1 CI; selected 4.3.8 restoration model
    - 4.6.1.1 Factor graphs
  ],
  [
    - 3.6.1–3.6.2 Directed-graph recall only
  ],
  [Check a local Ising conditional against enumeration, then restore a noisy course image with a supplied coordinate-update driver. Label the result a coordinate-stable candidate, not exact MAP or posterior marginals. #link("https://github.com/probml/pyprobml/blob/d1ea4122dcf3c2a2c02eb4e05343203b26440827/notebooks/book2/04/ising_image_denoise_demo.ipynb")[Inspected reference]. *Skill:* NumPy factor-to-conditional computation and exact tiny-model checks. *Limit:* Source Gibbs/mean-field is not the course algorithm; ICM adaptation unimplemented/unrun.],

  [4],
  [*Information theory: dependence and communication* \
  #note[Agent-approved / instructor-pending]],
  [Finite entropy, cross-entropy and KL; mutual-information identity; DPI proof sketch and bounded sufficiency recall; stated source-code length bounds; one five-bit noisy code with single-error correction, posterior ties and channel-use accounting.],
  [
    - 5.1.3 / 5.1.6; 5.2.1 / 5.2.4 Finite quantities (selected)
    - 5.3.1–5.3.4 MI / DPI / bounded sufficiency
    - 5.4.1 Source-length bounds (state)
    - 5.5 Channel decoding (course adaptation)
  ],
  [
    - Selected 6.1 / 6.2.1–6.2.2 / 6.3 Finite MI and DPI support
  ],
  [Enumerate a four-message, five-bit channel; compute MI and exact Bayes block error; expose ties and compare noise curves with channel-use cost. #link("https://github.com/probml/pyprobml/blob/d1ea4122dcf3c2a2c02eb4e05343203b26440827/notebooks/book2/05/error_correcting_code_demo.ipynb")[Inspected reference]. *Skill:* Normalized finite-probability tables, information and decision computations in NumPy. *Limit:* Source three-bit XOR is an anchor, not a guaranteed correction code; five-bit course construction independently checked, lab unrun.],

  [5],
  [*Learning probabilistic models: GLMs and optimization* \
  #note[Agent-approved / instructor-pending]],
  [Conditional exponential-family GLMs: Gaussian, Bernoulli and Poisson supports/links; one dispersion-correct canonical NLL gradient; a distinct vector softmax application; one complete reverse-mode graph and minibatch SGD. First PyTorch practice.],
  [
    - 15.1 / 15.1.1 / 15.1.3 GLM family and canonical gradient
    - 15.1.2 Noncanonical-link contrast only
    - 15.3.2 Multinomial softmax
    - 6.2 (selected); 6.3.1–6.3.2 Reverse AD and finite-sum SGD
  ],
  [
    - Selected 7.8.2 / 7.8.5 Matrix derivatives
    - Selected 8.2 / 8.4.1 / 8.4.3 Gradient and minibatch support
  ],
  [Fit all three Iris species with an affine softmax model; check manual versus autograd batch gradients, run visible SGD and evaluate held-out probabilities/log loss. #link("https://github.com/nipunbatra/pytorch-basics/blob/main/notebooks/04-softmax-regression.ipynb")[Inspected reference]. *Skill:* PyTorch tensors, checked gradients and one optimization/evaluation loop. *Limit:* Source inspected; extract Iris only. First-library onboarding and 60-minute student extent unpiloted.],

  [6],
  [*Latent-variable learning and EM* \
  #note[Agent-approved / instructor-pending]],
  [Observed versus complete likelihood; generic ELBO/KL identity, tightness and exact-EM monotonicity; Gaussian conditional first and second moments; learning unknown mean/covariance; ignorability/SPD assumptions. Mixture responsibilities as a short bridge.],
  [
    - 6.5.1 / 6.5.3 Bound optimization and EM (selected)
    - 6.5.4 Gaussian missing-data EM
    - 3.11 Ignorability (bounded statement)
    - 28.2.1 Mixture responsibility recognition only
  ],
  [
    - 3.5 / selected 8.7 EM and mixture exposition; no second full GMM fit
  ],
  [Complete expected Gaussian sufficient statistics, aggregate an E/M update and use a supplied driver to inspect observed likelihood and missing-entry reconstruction. #link("https://github.com/probml/pyprobml/blob/d1ea4122dcf3c2a2c02eb4e05343203b26440827/notebooks/book2/opt/gauss_imputation_em_demo.ipynb")[Inspected reference]. *Skill:* Turn posterior uncertainty into expected statistics and check an alternating objective. *Limit:* Source hides EM in a helper; course must expose moments. MRI/GMM lab displaced; adaptation unrun.],

  [7],
  [*Inference as computation: grid and Laplace* \
  #note[Agent-approved / instructor-pending]],
  [Queries and posterior summaries; parameterization-sensitive MAP; scalar Taylor/Laplace normalizer and positive curvature; proper-prior logistic application; grid domain/resolution checks and predictive comparison. Later algorithms recognized, not derived.],
  [
    - 7.1–7.3 Query framing (compact)
    - 7.4.1–7.4.3 MAP / grid / scalar Laplace (selected)
    - 7.5 Approximation checks (selected)
    - 15.3.5–15.3.6 Scalar logistic application only
  ],
  [],
  [Build a domain/resolution-challenged grid reference for a fixed eight-observation logistic posterior; compare Laplace, posterior moments and prediction. #link("https://stat238.berkeley.edu/spring-2026/codelecturethirtysix238spring2026/")[Inspected reference]. *Skill:* Stable numerical integration, local curvature and approximation-error checks with NumPy/SciPy. *Limit:* Source method inspected; random data replaced by course case and accuracy prose rejected. No source/course notebook run.],

  [8],
  [*Exact inference in structured sequence models* \
  #note[Agent-approved / instructor-pending]],
  [HMM factorization; derived forward/backward recursions, scaling and evidence; filtered/smoothed marginals; dense complexity and path-MAP versus marginal-mode distinction. Kalman filtering is a compact L01 application, not a second full algorithm/lab.],
  [
    - 9.2.1–9.2.5 HMM inference / scaling / complexity
    - 9.2.6 Path-versus-marginal decision distinction only
    - 8.1.2 / 8.2.2 Kalman application (selected)
  ],
  [],
  [Implement scaled HMM recursions and marginals with supplied simulation/plots; compare tiny enumeration and include a supplied asymmetric-transition assertion. #link("https://github.com/probml/pyprobml/blob/d1ea4122dcf3c2a2c02eb4e05343203b26440827/notebooks/misc/casino_hmm.ipynb")[Inspected reference]. *Skill:* Dynamic programming, probability scaling and exact sequence-inference tests in NumPy. *Limit:* Source JAX/Dynamax hides inference; NumPy adaptation unrun. Oke forecasting questions/data located, named solution unverified; Kalman lab displaced.],

  [9],
  [*Variational inference: restricted posteriors and stochastic gradients* \
  #note[Agent-approved / instructor-pending]],
  [Restricted-q optimization and reverse-KL Gaussian geometry; one total pathwise-gradient derivation with regularity/direct terms; bounded CAVI same-target application; amortization recognition. Generic bound reused from L06.],
  [
    - 10.1.1–10.1.2 Restricted objective / family
    - 6.3.3 / 6.3.5; 10.2.1.1 Gaussian pathwise gradient
    - 6.3.4 Score-function contrast (state)
    - 10.3.1 CAVI application; 10.1.5 amortization (recognize)
  ],
  [],
  [Optimize one diagonal Gaussian for controlled known-noise regression; compare exact and analytic best-diagonal posteriors and query-specific predictive variances. #link("https://github.com/probml/pyprobml/blob/d1ea4122dcf3c2a2c02eb4e05343203b26440827/notebooks/book2/10/linreg_bayes_svi_hmc.ipynb")[Inspected reference]. *Skill:* Differentiate through a latent sample transform and separate optimizer error from family error in PyTorch. *Limit:* Source Pyro/unknown-noise/GDP/HMC workflow not transplanted; exact controlled reference avoids pre-L10 HMC. PyTorch adaptation unrun.],

  [10],
  [*Monte Carlo and MCMC* \
  #note[Agent-approved / instructor-pending]],
  [IID estimator variance; stationarity and detailed balance; full Hastings ratio and rejected states; bounded Gibbs cancellation; stationary dependent error and query-specific mixing/ESS limits. HMC mechanics recognized only.],
  [
    - 11.2–11.2.2 MC integration / variance
    - 2.6.4; 12.2.1–12.2.2 Stationarity / MH
    - 12.3.1–12.3.2 Gibbs (bounded)
    - 12.6.3 Dependent error (selected); 12.5.3 HMC recognition
  ],
  [],
  [Complete a NumPy MH kernel and compare proposal scales/dispersed starts on a fixed multimodal mixture; assess mean and mode-mass queries against exact references. #link("https://github.com/probml/pyprobml/blob/d1ea4122dcf3c2a2c02eb4e05343203b26440827/notebooks/book2/12/mcmc_gmm_demo.ipynb")[Inspected reference]. *Skill:* Sampler transition correctness, finite exploration and function-specific numerical uncertainty. *Limit:* JAX/TFP source inspected, not required. Supplied diagnostics must flag stuck/constant chains; no executed NumPy port.],

  [11],
  [*Neural networks as probabilistic conditional models* \
  #note[Agent-approved / instructor-pending]],
  [MLP nonlinearity and mean/positive-SD heads; heteroskedastic Gaussian NLL and loss derivatives; shared AD/SGD reuse; conditional noise versus posterior weight uncertainty; correctly scaled Gaussian-prior/L2 connection.],
  [
    - 16.2.1–16.2.2 / 16.3.1 MLPs (selected)
    - 15.2.2.1 Gaussian-prior connection only
    - 14.2.1 Log-score application only
  ],
  [
    - 13.2.4.4 Heteroskedastic example
    - 13.5.2 Weight decay; 13.5.1 early-stopping recognition
  ],
  [Fit one shallow heteroskedastic PyTorch model and compare held-out NLL/MSE and conditional intervals with a supplied nonlinear fixed-scale baseline and known generating law. #link("https://github.com/probml/pyprobml/blob/d1ea4122dcf3c2a2c02eb4e05343203b26440827/notebooks/book1/13/mlp_1d_regression_hetero_tfp.ipynb")[Inspected reference]. *Skill:* Neural probability heads, matching batch shapes and honest conditional-uncertainty interpretation. *Limit:* TFP source needs PyTorch port; SD law is not the same as variance. One fit/baseline/checkpoint CPU pilot unrun.],

  [12],
  [*Variational autoencoders: neural latent-variable models* \
  #note[Agent-approved / instructor-pending]],
  [Generative model and amortized posterior roles; joint encoder/decoder objective; prior results applied to correctly normalized reconstruction/KL and gradients; beta tradeoff; rate equals MI plus aggregate-posterior KL; collapse and nonidentifiability limits.],
  [
    - 21.1–21.2 VAE model / amortization / objective (selected)
    - 21.3.1 Beta-VAE
    - 5.4.2 Rate–distortion / rate decomposition (selected)
    - 21.4 Collapse diagnostics (selected)
  ],
  [],
  [Complete a compact mobility VAE objective and bounded joint update run; compare freshly normalized beta summaries and descriptive latent patterns using supplied fits when needed. Instructor mobility reference; see #link("Lectures/course_architecture_scope/source_inspection.md")[source register]. *Skill:* Encoder/likelihood-decoder integration, event-axis loss scaling and information-rate diagnostics in PyTorch. *Limit:* Source/data inspected (349×19); source beta4 is not course beta4. Portable distribution permission, prepared comparisons and clean CPU runs remain unverified.],

  [13],
  [*Project presentations and course synthesis*],
  [Student project presentations connecting probabilistic assumptions, computation, prediction, evaluation, uncertainty and scientific interpretation. No additional substantive lecture topic is committed at this stage.],
  [],
  [],
  [No notebook — project presentations and synthesis.],
)

= Bounded returns and deliberate omissions

A future source reference is neither delivered coverage nor an obligation to teach the full chapter. The source-ownership matrix in the whole-course audit controls these boundaries.

#table(
  columns: (65mm, 51mm, 1fr), inset: 4pt, stroke: 0.45pt + rule,
  table.header(hdr[Material], hdr[Disposition in this proposal], hdr[Consequence]),
  [Book 2 §2.5 transformations], [Bounded scalar MAP example L07; Gaussian pathwise map L09/L12], [No general change-of-variables / flow curriculum.],
  [Book 2 §2.6.4 stationary distributions], [Primary bounded theory L10], [Pays the named boundary after L02; not assumed in L03.],
  [Book 2 §§6.3.3–6.3.5], [Gaussian pathwise L09; VAE reuse L12], [Score function stated; Gumbel/straight-through and natural gradients omitted.],
  [Book 2 §§6.6–6.9 and Ch. 13], [Deliberately omitted], [No Bayesian/derivative-free/transport/submodular optimization or substantive SMC; no hidden recording debt.],
  [Full MRI/GMM fitting and Kalman forecasting], [Displaced practical candidates], [Gaussian EM and HMM lab selected; alternatives and costs remain in instructor report.],
  [Full Bayesian/sparse GLMs, calibration/conformal and regularized-digit lab], [Deliberately omitted], [L05 preserves family/gradient; L11 only Gaussian-prior/L2 and log-score connection.],
  [General tree/loopy/VE/JTA inference, advanced VI/MCMC], [Deliberately omitted], [Exact HMM, diagonal pathwise VI and MH/mixing each get one primary implementation. HMC mechanics only.],
  [Book 2 Chs. 17–19 and broader generative architectures], [No committed teaching destination], [BNN/GP/shift, flows/diffusion/GANs need a real displacement decision; L12 retains VAE.],
  [Full supervised IB / InfoVAE / hierarchical or VQ VAE], [Deliberately omitted], [L12 retains rate-versus-MI, beta and cautious collapse diagnostics.],
)
