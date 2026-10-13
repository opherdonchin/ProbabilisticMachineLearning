#set page(
  paper: "a4",
  flipped: false,
  margin: (x: 15mm, y: 13mm),
)
#set text(font: "Libertinus Serif", size: 11pt)
#set par(leading: 1em, spacing: 0.8em)

#let navy = rgb("#173A5E")
#let blue = rgb("#2F6690")
#let pale-blue = rgb("#EEF4F8")
#let rule = rgb("#D8DEE4")
#let muted = rgb("#59636E")

#show heading.where(level: 1): it => block(above: 1.1em, below: 1em)[
  #text(size: 16pt, weight: "bold", fill: navy)[#it.body]
]
#show heading.where(level: 2): it => block(above: 1.1em, below: 0.8em)[
  #text(size: 11.3pt, weight: "bold", fill: blue)[#it.body]
]

#let hdr(body) = table.cell(fill: navy, inset: 5pt)[
  #text(weight: "bold", fill: white)[#body]
]
#let note(body) = text(size: 7.3pt, fill: muted, body)

#let concept-card(title, body, tint: pale-blue) = rect(
  width: 100%,
  inset: 9pt,
  radius: 5pt,
  fill: tint,
  stroke: 0.65pt + rule,
)[
  #align(center)[
    #text(weight: "bold", fill: navy)[#title]
    #v(3pt)
    #text(size: 8.5pt, fill: black)[#body]
  ]
]

= Course architecture

#text(size: 9pt, fill: muted)[Advanced Statistics 2027-1 / Probabilistic Machine Learning · Course-level intellectual and curricular authority]

This document defines the *intellectual purpose and planned progression* of the course. It is the primary reference when selecting lecture scopes, weighing changes across lectures, and interpreting the relationship between mathematical results and applications. The #link("advanced_statistics_2027_1_syllabus.typ")[student syllabus] is a concise description of this architecture; approved lecture scopes determine their own detailed teaching commitments. Actual delivery and source coverage are recorded in #link("Lectures/material_ledger.md")[the material ledger]. These authorities should be reconciled when they disagree, not silently overwritten.

= What the course is about

Understanding probabilistic machine learning is understanding *the probabalistic formulation of machine language problems*, *how different machine language problems are expressed in this machinery*, and *why specific classes of learning problems apply different computational approaches to the same machinery*. The goal is to achieve a coherent and integrated view of how the structured data, the questions being asked, and the computational tools are all related through the probabalistic formulation. This will not be a catalogue of models and it is not a progression from one approximation algorithm to the next. Each mathematical advance is motivated by a kind of task and available experience for which our existing models, performance criteria, or computations are insufficient.

== From learning problems to mathematical formulations

A *learning task* specifies what a system should accomplish; its *experience* specifies the data, feedback, or interaction available. Its success must be defined by a *performance criterion*. The same dataset may support prediction, generation, discovery, or action; data alone do not specify the learning problem.

The mathematical formulation has *two distinct, related objects*. A probabilistic model describes the relevant observed and unobserved variables, their dependencies, and our uncertainty. A performance functional defines what counts as a good prediction, representation, decision, or learned distribution—often by taking an expectation with respect to a relevant distribution. For example, a predictive action $a$ may be evaluated by

$ cal(R)(a) = integral L(a,y) p(y) dif y. $

The distribution under which we evaluate actual performance need not be the same as our fitted model. Distinguishing a mismatch of models from an error of computation is itself part of the discipline.

The formulation then gives us probabilistic *queries*. These are generally addressed with specific integrals on the probabilistic models: conditioning, marginalization, and summarizing are three operations developed explicitly  that may deliver the quantities required to evaluate or optimize performance. They are tractable in some models, but the course deals primarily with how queries can be approached when computation is a challenge.

== The task–model–performance–computation relationship

#align(center)[
  #block(width: 91%)[
    #concept-card(
      [Learning problem],
      [Task and question · available experience · data structure and scale],
    )
    #v(5pt)
    #align(center)[#text(size: 14pt, fill: blue)[$arrow.b$]]
    #v(5pt)
    #text(weight: "bold", fill: navy)[Mathematical formulation]
    #v(5pt)
    #grid(
      columns: (1fr, 1fr),
      gutter: 10pt,
      concept-card(
        [Probabilistic model],
        [Joint and conditional distributions; observed and latent variables; structural assumptions; posterior and predictive queries],
        tint: pale-blue,
      ),
      concept-card(
        [Performance functional],
        [Expected loss, predictive score, distributional discrepancy, information retained, or decision utility; required fidelity],
        tint: pale-blue,
      ),
    )
    #v(5pt)
    #align(center)[#text(size: 14pt, fill: blue)[$arrow.b$]]
    #v(5pt)
    #concept-card(
      [Induced computational demand and approach],
      [Required query or optimization · cost from data structure and scale · exact algorithms, tractable proxies, and numerical approximations],
      tint: rgb("#F5F6F7"),
    )
    #v(5pt)
    #align(center)[#text(size: 14pt, fill: blue)[$arrow.b$]]
    #v(5pt)
    #concept-card(
      [Learned model, answer, or decision],
      [Evaluate performance on the original task; identify remaining model, objective, and computational limitations],
      tint: rgb("#F5F6F7"),
    )
    #v(3pt)
    #text(size: 8pt, fill: muted)[The arrows describe the logical dependence, not a one-way workflow. Results and computational limits can motivate revising the formulation.]
  ]
]

The three major *moves* in the course extend *(i) what probabilistic models can represent, (ii) what performance functionals can express, and (iii) what computational methods can achieve*. The computational challenge is not a fourth, independent feature of the learning problem. It *emerges* from the structure and scale of the data, the probabilistic query and performance requirement, and the computational resources available. A mathematical move is justified by how it resolves that particular demand; no move is an end in itself.

== The ideal quantity and the practical calculation

One key move in the course is to substitue a tractable proxy for an ideal mathematical target. A desired performance functional may be replaced during training by an empirical score or surrogate objective. Likewise, an ideal posterior or expectation may be represented by a point estimate, a local Gaussian approximation, a variational distribution, or samples. Some structured problems admit *exact* solutions, so computation is not synonymous with approximation.

The central goal of the course is to develop an understanding of the possible substitutions and the situations in which they are appropriate. Each substitution has different meanings and limitations. The appropriate criterion for assessing the approximation depends on the *original question*, *the probabilistic formulation*, and *the computational power available* not merely whether an internal algorithm converged.

== The role of Murphy and mathematical depth

Murphy's books provide the central spine of the course's progression and guide the choice of material, the explanatory logic, the depth of the coverage, and the mathematical language. The course as a whole and each lecture provides only partial coverage, relative to Murphy's second book. Material is selected and occasionally re-ordered. 

A detailed understanding of the mathematical development of the material is an essential part of the course. As such, many of the mathematical developments in Murphy are presented in lecture or in the self-work notebooks. The first Murphy book often provides more detailed and scaffolded mathematical derivations, and is used as a reference for the course. The second Murphy book is the primary source fo the underlying logic of the course (as explained above) and for its structure.

= How the semester develops

== What constitutes a class of learning problems?

A class of learning problems is not simply an application domain (medicine, images, or language), nor a convenient dataset chosen to demonstrate an algorithm. It is characterized by *the experience and the structure and size of the data* (what is observed, missing, sequential or dependent; how many observations, variables and latent states are involved), *the task and probabilistic question*, and *the performance requirement* (which errors, distributions, information or decisions matter, and to what degree of accuracy). These jointly determine which probabilistic integrals or optimizations must be carried out and, for a given computational budget, which of them are difficult. *The computational obstacle is a consequence of these requirements, not a separate ingredient used to define the problem class.* The same dataset can support different tasks, and very different datasets can pose the same underlying problem.

The lectures trace this chain: *data and task → probabilistic model and performance functional → required calculation and its cost → appropriate mathematical move*. In each case we should explain which query or optimization follows from the task, why the current machinery cannot meet its performance requirements at the relevant data scale, and what the new tool makes possible. Some advances improve the representation of a probability distribution; others define what success means; still others provide exact or approximate computations. All ultimately affect which problems can be addressed. The alternatives in L07–L10 deliberately serve overlapping tasks: posterior structure, dimensionality, available evaluations, required accuracy and resources determine which computational strategy is appropriate.

A central learning outcome is therefore the ability to go *from a new problem to an appropriate formulation and computational approach*, rather than merely recognize an algorithm's name after seeing its worked example. Each notebook tests part of that relationship in a concrete setting; its example is neither the only application nor the justification for the mathematics.

== Families of observations and relationships (L01–L03)

*L01 — One body of observations, different questions.*
Given measurements from a system, we may want to predict an unobserved measurement, infer a hidden cause, generate another observation, or choose an action. These are *different tasks*, potentially on the same data, with different answers and performance measures. The first problem is conceptual: neither the dataset nor a statistical fitting procedure says which question we intend to answer. The *formulation move* is to specify task and experience, construct a joint probability model, identify the relevant query, and evaluate an answer under a performance criterion. Conditioning, marginalization, and summarizing express the corresponding operations. Linear-Gaussian measurement systems provide a baseline in which these operations are analytically tractable, showing how a single model can answer several questions. They also establish the limitation that motivates much of the later course: tractability in a Gaussian model does not imply tractability for arbitrary data and models.

*L02 — Learning a distribution when observations take different forms.*
We encounter samples of real measurements, binary events, category labels, counts, or observed categorical transitions. Tasks include estimating their probability laws, predicting another observation, and generating plausible sequences; we can judge fitted distributions by the probabilities they assign to held-out observations. Using a separate parameterization and derivation for every kind of observation obscures what these tasks have in common. The *model move* is the exponential-family representation, which relates likelihoods to sufficient statistics and the log-partition function. The *computational move* follows from that structure: log-partition derivatives give moments, and regular maximum-likelihood problems can be solved by matching model and empirical sufficient-statistic expectations. When only constraints on such expectations are known, maximum entropy provides another formulation of distribution selection. An observed-state character-transition model then makes fitting and generation concrete. This machinery unifies an important family of observation models; it neither covers every distribution nor by itself handles arbitrary dependencies between observations.

*L03 — Representing a joint distribution when many variables depend on one another.*
A student network, an interacting spatial field, or an image with locally related pixels contains numerous dependent variables. We may want to sample a coherent configuration, infer missing variables from observed ones, or predict a part from the rest. An unrestricted joint table grows exponentially with the number of variables, and a formula that ignores dependence cannot answer the intended questions. The *model move* is to factor the joint into smaller terms using conditional-independence assumptions: directed graphs express local conditional structure; undirected graphs express local compatibility or interaction through potentials and a partition function. D-separation, undirected separation, and Markov blankets make the model's conditional-independence implications explicit; neither graph formalism subsumes the other. Sparse factorization can make a large model describable and sometimes make inference efficient, but the latter is *not automatic*. The Ising-image notebook tests the representation by constructing a posterior conditional and a local reconstruction update. Local maximization does not yield exact posterior marginals or guarantee a global optimum. The sequence-inference problems of L08 will show when the structure does permit exact computation.

== Families distinguished by the meaning of performance and by hidden data (L04–L06)

*L04 — Evaluating distributions, or preserving what matters about them.*
For some learning tasks the output is *a distribution*: we must decide whether a probabilistic predictor represents future observations well, not merely whether its most likely label is correct. For other tasks we compress or transform observations and want to retain particular statistical relationships, such as information about a target variable, while discarding irrelevant variation. Accuracy or mean squared error on single decisions cannot express these objectives. The *performance move* is to introduce entropy, cross-entropy, KL divergence, and mutual information. Expected negative log score decomposes into target entropy plus a directed KL discrepancy, making empirical negative log likelihood a computable *estimate of distributional performance*. Mutual information instead measures a specified dependence, and the data-processing inequality constrains what a representation can preserve. These are different criteria: neither low KL nor high mutual information automatically guarantees good decisions under every loss. Noisy-channel parity codes provide a finite illustrative comparison of information preserved, error probability, and resource use; they are not a representative machine-learning task or the motivation for the whole lecture. The three-bit lecture and five-bit notebook cases retain that instructional role. The achievement is learning to *choose and operationalize the appropriate performance functional* before choosing an objective to optimize.

*L05 — Predicting labeled outcomes whose support and uncertainty differ.*
Given input–response pairs, we may need a probability of disease, a category among several classes, or an expected event count, rather than a continuous-valued prediction with constant Gaussian noise. We need models that put probability on the right outcomes and performance criteria that reward honest predictive distributions. A Gaussian linear observation law is not adequate for categorical or count responses, even when the surrounding Bayesian hierarchy is sound. The *model move* is a generalized linear model: an outcome-appropriate exponential-family likelihood is connected to predictors through a link, with softmax providing multiclass probabilities. For many observations, we also need a practical method for fitting its parameters. The *computational move* is differentiable empirical log-score or posterior-mode optimization, with automatic differentiation and mini-batch gradient updates. This produces a useful MLE/MAP *point fit*, not full Bayesian parameter uncertainty. The Iris notebook exercises the probabilistic predictions, gradients, training, and held-out evaluation. A low training objective may fail to deliver the desired held-out performance; the model and the computational fit must both be assessed.

*L06 — Learning shared parameters when parts of the training data are unobserved.*
Suppose each observation is partly missing, or a case belongs to an unobserved category. We want to learn population parameters from the *observed* measurements, not merely reconstruct missing entries using fixed known parameters as in L01. The model is a joint law of observations, latent quantities, and parameters; the observed-data likelihood requires summing or integrating away what was not measured. Filling in one best guess changes the fitting objective, and optimizing a marginalized likelihood directly may be inconvenient. The *computational move* is expectation–maximization: infer the conditional distribution over latent quantities at the current parameter setting, then improve a parameter objective built from expected complete-data statistics. The lower-bound/KL identity explains why correctly executed exact steps do not decrease the observed-data likelihood. Gaussian missing-data learning requires conditional *second moments*, including covariance, reconnecting L01's conditioning to L02's moment matching. A hidden class assignment leads to the same general construction. EM is suitable only when those expectations and updates are tractable; it returns a parameter fit, not the full parameter posterior, and the selected missing-data calculation assumes an ignorable missingness process.

== Families of difficult probabilistic queries (L07–L10)

Here the question is often shared—calculate an expectation, prediction, or decision from a posterior—but *different model and data structures, sizes and accuracy requirements induce different computational demands*. Computational difficulty is the result of the required calculation relative to the available resources, not an independently specified property of the task. There is no general mapping from “Bayesian prediction” to a unique algorithm: posterior geometry, dimensionality, exploitable factorization, evaluable quantities, frequency of repeated queries, and acceptable error all matter.

*L07 — Decisions and predictions that depend on continuous parameter uncertainty.*
For a nonlinear binary-response model, a fitted coefficient may predict reasonably but give no answer to questions about parameter spread, predictive uncertainty, or expected loss averaged over plausible coefficients. These tasks require *posterior integrals*, not just a parameter mode. When the posterior is smooth and sufficiently concentrated around one interior mode, direct integration may be difficult but local curvature is available. The *computational move* is Laplace approximation: approximate the posterior near its mode by a Gaussian and use that distribution to estimate relevant summaries and predictions. The mode and the fitted curvature do not guarantee accurate global probabilities or decisions when tails, skew, boundaries, or multiple modes matter. The small logistic notebook compares posterior and predictive quantities with a separately checked numerical grid. It exposes the difference between an easy local calculation and the *task-specific integral we actually wanted*.

*L08 — Inferring changing hidden states from sequential noisy measurements.*
In sequential sensing and monitoring, observations arrive over time while the underlying state is unobserved. We may need *filtering* to act using observations so far, *smoothing* to reconstruct earlier states using the full record, the probability of the observed sequence to assess a model, or the most probable *complete* state history. These queries are not equivalent. A hidden Markov model expresses the changing state and observations through local conditional probabilities, but naive summation over all hidden trajectories is exponentially large. The *computational move* exploits the chain factorization: forward and backward messages reuse intermediate sums to compute likelihoods and state marginals *exactly* for a specified HMM with known parameters. Dense discrete transitions require work that grows linearly with sequence length and quadratically with the number of states. A path-MAP computation is distinct from finding the most probable state at each time. A brief linear-Gaussian Kalman comparison reconnects to L01. The method's exactness follows from this particular structure; it is neither a universal graphical-model solver nor a latent-parameter learning algorithm.

*L09 — Repeated posterior predictions when a tractable distributional approximation can be optimized.*
For models with many continuous unknowns—such as correlated regression coefficients or local latent variables—we may need posterior averages or predictive distributions repeatedly, yet exact normalization and marginalization are too expensive. A local Gaussian around one mode may fail to represent the uncertainty required by the task. When the joint log density is evaluable and an approximate family admits manageable expectations or gradient estimators, we can seek a *reusable approximate distribution*. The *computational move* is variational inference: choose a family, optimize the L06 lower bound (equivalently a directed KL discrepancy), and then use the fitted distribution for the required probabilistic queries. This creates at least two separable errors: the best available member of the family may be inadequate, and the optimizer may fail to reach even that best member. Mean-field fitting loses dependencies that can matter differently for different posterior expectations. Reparameterized sampling and L05 differentiation make stochastic optimization of the variational objective practical. The regression notebook compares exact posterior answers, the analytically best diagonal approximation, and the numerical fit. Optimizing the ELBO is not identical to optimizing the original task performance.

*L10 — Posterior integrals when a convenient global approximation is unreliable.*
Some scientifically relevant posterior distributions are irregular, strongly dependent, or multimodal, while the question still concerns an expectation, probability, or risk. When we can evaluate a target density up to proportionality but cannot integrate it, or do not trust a restricted variational family to represent the features important to the query, *sampling* is another computational route. The *computational move* is Monte Carlo: estimate the specified integral using draws, with Markov chain Monte Carlo constructing dependent draws by transitions that preserve the target distribution. Metropolis–Hastings corrects a proposal using an acceptance ratio; invariance is a mathematical property of the transition, *not* a guarantee that a finite simulation has explored the target adequately. Poor mixing, multimodality, initialization, and autocorrelation create query-dependent numerical error, including false confidence in apparently stable averages. A known bimodal target makes those failures visible. MCMC does not solve every intractable posterior; its appropriateness depends on whether the target can be evaluated, whether the chain explores it, and whether the desired integral can be estimated accurately within the available computation.

== Families that require expressive conditional and generative models (L11–L12)

*L11 — Predicting nonlinear responses with input-dependent variability.*
Some labeled datasets show not only a nonlinear input–response relationship but also varying conditional noise: prediction should communicate both an expected outcome and how broadly observations vary at each input. A linear GLM or a nonlinear point predictor with fixed variance can miss this structure, and squared-error performance alone will not expose every failure in the *predictive distribution*. The *model move* is a neural conditional distribution: compose nonlinear differentiable functions and use their outputs to parameterize a valid Gaussian mean and positive scale for each input. The *computational move* largely reuses L05's automatic differentiation and training; the performance comparison includes held-out log score as well as squared error. Gaussian-prior shrinkage illustrates how a Bayesian assumption can appear in a point-fitting objective. The notebook tests mean, scale, and conditional intervals on held-out observations. These intervals describe *observation noise conditional on fitted network weights*, not uncertainty about the weights. Neural maps also create the possibility of learned inference networks in L12; increased flexibility does not remove all statistical or computational limitations.

*L12 — Generating high-dimensional observations and learning compact hidden descriptions.*
An unlabeled dataset of many measurements raises at least two tasks: *generation* of coherent new observations and *discovery* of a useful low-dimensional representation of existing cases. A single observed-space distribution may be too rigid, while a flexible latent-variable generative model can make the reverse query—inferring hidden coordinates for an observed case—computationally demanding. The *model move* is a neural generative joint: sample latent coordinates from a prior and map them through a decoder to an observation distribution. The *computational move* is to amortize approximate latent inference through a shared encoder, learned with L06's lower-bound identity, L09's pathwise gradients, and L11's nonlinear parameterizations. The *performance move* explicitly evaluates reconstruction quality alongside a rate-related regularizer, using L04's log-scoring and information framework. The average KL from encoder to prior decomposes into mutual information and aggregate-posterior mismatch; treating that penalty as identical to information retained would distort the intended performance interpretation. Posterior collapse, restricted inference, and nonidentifiable coordinates limit what the discovered representation establishes scientifically. The notebook measures the reconstruction/rate tradeoff rather than claiming to identify causal factors.

*L13 — Choosing machinery for a new scientific problem.*
The students' own projects are the final *problem family*: new data and a substantive question for which no lecture has already supplied a complete answer. Students must identify the available experience, define the task and its performance criterion, justify a probabilistic model and query, explain why the chosen inference or fitting method is appropriate, and distinguish empirical performance from model assumptions and numerical error. The ability to make and defend that chain of choices—not simply to reproduce the semester's algorithms—is the intended synthesis.

= Lecture allocation and notebook commitments

The table below retains the selected 13-meeting allocation and source readings. It is a *planning contract*: L01 is delivered, L02 is agreed, L03 preserves its instructor-approved scope, and L04's live/notebook split is selected. Other lecture scopes remain proposed pending their own reviews. Each notebook should extend rather than reproduce the live mathematics, normally within a separate hour. Full mathematical source-to-lecture ownership and unresolved feasibility questions remain in #link("Lectures/course_architecture_scope/architecture_audit.md")[the architecture audit] and #link("Lectures/course_architecture_scope/STATUS.md")[the scope register].

#pagebreak()
#set text(size: 8pt)
#set par(leading: 0.55em, spacing: 0.6em)

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
  [*Graphical models: factorization and conditional independence* \
  #note[Agreed scope restored]],
  [Derive DAG factorization from the probability chain rule and independence assumptions; work the student network and parameter economy. Develop d-separation and directed Markov blankets. Define undirected potentials and global normalization, compare separation and independence expressivity, and interpret the binary Ising model. Image posterior and algorithm derivations belong to the notebook.],
  [
    - 4.2.1–4.2.2 DAG factorization; student network
    - 4.2.4 / selected 4.2.8 Independence; plates
    - 4.3.1–4.3.2.1 / 4.3.6.1 Undirected models; Ising; separation
    - 4.5.1 Directed/undirected independence comparison
    - 4.3.8 Image restoration: notebook
  ],
  [
    - Optional 3.6.1–3.6.2 Graphical-model orientation
  ],
  [Construct an Ising prior and Gaussian observation likelihood; derive the joint, posterior and single-site conditional. Implement or complete sequential local maximization (ICM) in a NumPy scaffold; compare with a pixelwise baseline and examine initialization or local-optimum limitations. *Skill:* Build a probabilistic restoration model from local factors, derive its posterior update, and distinguish local maximization from a global optimum or posterior marginal inference. #link("https://github.com/probml/pyprobml/blob/d1ea4122dcf3c2a2c02eb4e05343203b26440827/notebooks/book2/04/ising_image_denoise_demo.ipynb")[Inspected source]. *Limit:* The instructor agreed to this simpler method. It differs from Murphy’s algorithm and does not promise the best possible image or posterior uncertainty. All course adaptations remain unrun.],

  [4],
  [*Information theory: distributional comparison and information preservation* \
  #note[Proposed teaching scope]],
  [Use entropy, cross-entropy and KL to compare distributions and relate expected log score to discrepancy; derive mutual information and sketch the data-processing inequality as a limit on information preservation. State source-length bounds. Use three-bit parity detection and posterior decoding to distinguish information, decision risk and the resource cost of coding.],
  [
    - 5.1.3 / 5.1.6; 5.2.1 / 5.2.4 Information and uncertainty
    - 5.3.1–5.3.4 Shared information and processing
    - 5.4.1 Code-length bounds: statement only
    - 5.5 Noisy-channel example: three-bit parity model
  ],
  [
    - Selected 6.1 / 6.2.1–6.2.2 / 6.3 Uncertainty and shared information
  ],
  [Extend the lecture's three-bit parity detector to a five-bit correcting code for the same two-bit message. Check minimum Hamming distance three and decode any single-bit flip; use supplied 4×32 channel enumeration to compute mutual information and optimal message error and compare against the three-bit and uncoded benchmarks, accounting for rate. *Skill:* Calculate information and decision risk from one finite joint distribution without conflating information gain, code rate and guaranteed error correction. #link("https://github.com/probml/pyprobml/blob/d1ea4122dcf3c2a2c02eb4e05343203b26440827/notebooks/book2/05/error_correcting_code_demo.ipynb")[Inspected source]. *Limit:* The lecture uses the lighter detection-only code; the notebook develops the stronger correcting code. Guarantee applies only to at most one flipped bit; all notebook adaptations and one-hour timing remain untested. All course adaptations remain unrun.],

  [5],
  [*Generalized linear models, automatic differentiation and SGD* \
  #note[Proposed teaching scope]],
  [Start from the familiar Bayesian regression likelihood and parameter prior; explain why Gaussian observations are unsuitable for binary responses and counts, without implying that the hierarchical model fails. Generalize the observation family using Gaussian/Bernoulli/Poisson GLMs and links. Contrast full posterior inference with MLE/MAP point fitting; derive the canonical NLL and vector softmax gradients, then reverse-mode autodiff and minibatch SGD.],
  [
    - 15.1 / 15.1.1 / 15.1.3 Common model structure and derivative
    - 15.1.2 Brief alternative-link comparison
    - 15.3.2 Three-class probabilities
    - Selected 6.2; 6.3.1–6.3.2 Automatic differentiation and batch updates
  ],
  [
    - Selected 7.8.2 / 7.8.5 Matrix derivatives
    - Selected 8.2 / 8.4.1 / 8.4.3 Gradient and batch-update support
  ],
  [Fit the three-class Iris softmax model in PyTorch; compare the manual mean-batch gradient with autograd at identical parameters, run visible SGD updates and evaluate held-out log loss/probabilities. Data preparation and program scaffolding are supplied. *Skill:* Connect a likelihood derivative with reverse-mode automatic differentiation and a checked stochastic parameter-update/evaluation loop. #link("https://github.com/nipunbatra/pytorch-basics/blob/main/notebooks/04-softmax-regression.ipynb")[Inspected source]. *Limit:* First PyTorch use makes this meeting tight. Data preparation and plotting are supplied; the lecture does not teach a large software framework. All course adaptations remain unrun.],

  [6],
  [*Latent-variable learning and expectation-maximization* \
  #note[Proposed teaching scope]],
  [Recall Bayesian latent-variable hierarchies and joint posterior inference, then distinguish point estimation by marginal likelihood from inference over all unknowns. Show why unknown latent values complicate direct fitting, and derive the ELBO/KL identity, exact E-step tightness and EM monotonicity. Apply Gaussian conditional first/second moments to unknown mean/covariance with missing data; briefly interpret mixture responsibilities and assumptions.],
  [
    - Selected 6.5.1 / 6.5.3 Probability bound and EM
    - 6.5.4 Gaussian missing-data updates
    - 3.11 When the missing-data mechanism can be ignored
    - 28.2.1 Group-assignment probabilities: brief example
  ],
  [
    - Selected 3.5 / 8.7 Grouped observations and EM explanation
  ],
  [Assemble expected Gaussian sufficient statistics, including conditional covariance, and perform an E/M update inside a supplied iteration driver. Check observed likelihood and missing-entry reconstruction; no second full mixture fit. *Skill:* Use conditional uncertainty in sufficient-statistic estimation and distinguish an exact EM improvement guarantee from arbitrary approximate hidden-value updates. #link("https://github.com/probml/pyprobml/blob/d1ea4122dcf3c2a2c02eb4e05343203b26440827/notebooks/book2/opt/gauss_imputation_em_demo.ipynb")[Inspected source]. *Limit:* This replaces the candidate MRI tissue-classification lab. Class-assignment probabilities are explained briefly; a second mixture-model fit is not required. All course adaptations remain unrun.],

  [7],
  [*Bayesian computation: grid reference and Laplace approximation* \
  #note[Proposed teaching scope]],
  [Posterior queries and parameterization-dependent MAP; derive scalar Laplace curvature and normalizer under positive-curvature conditions. Apply to proper-prior logistic regression, check quadrature domain and resolution, and compare posterior moments and predictive integrals.],
  [
    - 7.1–7.3 What posterior questions require: short introduction
    - Selected 7.4.1–7.4.3 Most likely parameter, grid and Gaussian shortcut
    - Selected 7.5 Checking approximation quality
    - Selected 15.3.5–15.3.6 One-parameter logistic example
  ],
  [],
  [Build a stable quadrature reference for the fixed eight-observation logistic posterior, challenge domain and mesh separately, and assess Laplace error in moments and prediction. Solver/plot helpers are supplied. *Skill:* Validate the numerical reference as well as the posterior approximation, and separate local curvature matching from global integral/prediction accuracy. #link("https://stat238.berkeley.edu/spring-2026/codelecturethirtysix238spring2026/")[Inspected source]. *Limit:* The small example is chosen for checkability. A finite grid is also an approximation, not an automatically exact answer. All course adaptations remain unrun.],

  [8],
  [*Exact inference in structured sequence models* \
  #note[Proposed teaching scope]],
  [Derive scaled HMM forward/backward recursions, evidence and filtered/smoothed marginals; establish dense computational cost and distinguish joint path MAP from marginal modes. Give a compact Kalman-filter application of L01 Gaussian conditioning, without a second full sequence implementation.],
  [
    - 9.2.1–9.2.5 Hidden-state calculations and scaling
    - 9.2.6 Whole history versus separate state decisions
    - Selected 8.1.2 / 8.2.2 Gaussian filtering: short application
  ],
  [],
  [Implement scaled HMM likelihood messages and marginals in NumPy. Check tiny-sequence enumeration and an asymmetric-transition case to expose orientation errors. Simulation, reference and plotting code are supplied. *Skill:* Use sum-product dynamic programming to obtain exact sequence probabilities and marginals while controlling numerical scaling. #link("https://github.com/probml/pyprobml/blob/d1ea4122dcf3c2a2c02eb4e05343203b26440827/notebooks/misc/casino_hmm.ipynb")[Inspected source]. *Limit:* The main lab is discrete hidden-state inference. The previously preferred continuous Kalman forecasting lab is not included. All course adaptations remain unrun.],

  [9],
  [*Variational inference: posterior geometry and pathwise gradients* \
  #note[Proposed teaching scope]],
  [Reuse L06 ELBO identity; optimize restricted reverse KL and work the correlated-Gaussian diagonal optimum. Derive the total pathwise gradient including direct parameter terms and regularity conditions; apply bounded coordinate-ascent VI and recognize amortization.],
  [
    - 10.1.1–10.1.2 Fitting a restricted distribution
    - 6.3.3 / 6.3.5; 10.2.1.1 Derivatives through Gaussian draws
    - 6.3.4 Another gradient estimator: statement only
    - 10.3.1 Coordinate updates; 10.1.5 learned inference: introduction only
  ],
  [],
  [Fit a diagonal Gaussian to controlled known-noise regression using reparameterized PyTorch gradients. Compare exact posterior and analytic best-diagonal solution; use fixed-noise, matched-estimator gradient checks and query-specific predictive variances. *Skill:* Separate optimization error from variational-family error, and differentiate a parameter-dependent expectation with correct full-data likelihood/prior scaling. #link("https://github.com/probml/pyprobml/blob/d1ea4122dcf3c2a2c02eb4e05343203b26440827/notebooks/book2/10/linreg_bayes_svi_hmc.ipynb")[Inspected source]. *Limit:* Uses controlled data and known noise. The real economic-data example and sampling comparison are replaced; no new Pyro software is required. All course adaptations remain unrun.],

  [10],
  [*Monte Carlo and MCMC: invariance, mixing and estimator error* \
  #note[Proposed teaching scope]],
  [Derive IID estimator variance, stationarity/detailed balance and the general Metropolis–Hastings ratio, retaining rejected states. Explain Gibbs cancellation briefly and dependent-sample error under its conditions. Distinguish invariant transitions, finite-run mixing and function-specific effective sample size; recognize HMC mechanics only.],
  [
    - 11.2–11.2.2 Averages and sampling error
    - 2.6.4; 12.2.1–12.2.2 Invariant distribution and acceptance rule
    - 12.3.1–12.3.2 Conditional-coordinate sampling: brief derivation
    - Selected 12.6.3 Dependent-sample error; 12.5.3 Hamiltonian mechanics only
  ],
  [],
  [Implement the NumPy MH kernel on a fixed bimodal target. Compare proposal scales and dispersed starts; assess the mean and probability above zero against exact references. Supplied diagnostics flag stuck chains and query-dependent error. *Skill:* Check transition validity separately from finite exploration and quantify uncertainty for a specified Monte Carlo query. #link("https://github.com/probml/pyprobml/blob/d1ea4122dcf3c2a2c02eb4e05343203b26440827/notebooks/book2/12/mcmc_gmm_demo.ipynb")[Inspected source]. *Limit:* Helper diagnostics are supplied. Gibbs updates are explained briefly. Hamiltonian Monte Carlo uses derivatives for directed moves but is not fully derived or implemented. All course adaptations remain unrun.],

  [11],
  [*Neural conditional models: heteroskedastic likelihood and regularization* \
  #note[Proposed teaching scope]],
  [Nonlinear feedforward mean/positive-scale model; derive heteroskedastic Gaussian NLL and output derivatives, reusing AD/SGD. Distinguish conditional observation noise from posterior weight uncertainty via total variance. Work the Gaussian-prior/L2 coefficient under mean-loss normalization.],
  [
    - Selected 16.2.1–16.2.2 / 16.3.1 Small feedforward networks
    - 15.2.2.1 Gaussian prior and weight shrinkage
    - 14.2.1 Evaluating predicted probabilities
  ],
  [
    - 13.2.4.4 Noise that depends on input
    - 13.5.2 Weight shrinkage; 13.5.1 stopping training: brief mention
  ],
  [Fit one shallow PyTorch mean/scale network and compare held-out NLL, MSE and conditional intervals with a supplied fixed-scale nonlinear baseline and known data law. Match splits/shapes and estimate baseline noise using training data. *Skill:* Implement and interpret a neural conditional likelihood, preserving standard-deviation/variance distinctions and the limits of fixed-weight predictive intervals. #link("https://github.com/probml/pyprobml/blob/d1ea4122dcf3c2a2c02eb4e05343203b26440827/notebooks/book1/13/mlp_1d_regression_hetero_tfp.ipynb")[Inspected source]. *Limit:* Intervals describe observation noise conditional on fitted weights. They do not include a Bayesian posterior over weights. One CPU fit and prepared fallback still need testing. All course adaptations remain unrun.],

  [12],
  [*Variational autoencoders: amortized inference and rate–distortion* \
  #note[Proposed teaching scope]],
  [Generative model versus amortized posterior; joint encoder/decoder objective with event-summed Gaussian NLL and diagonal KL, then observation averaging. Reuse ELBO/pathwise/neural results. Derive rate as mutual information plus aggregate-posterior mismatch; interpret beta, collapse and nonidentifiability.],
  [
    - Selected 21.1–21.2 Model, inference network and training objective
    - 21.3.1 Changing the penalty weight
    - Selected 5.4.2 Reconstruction/information tradeoff
    - Selected 21.4 When the model ignores hidden coordinates
  ],
  [],
  [Complete the compact mobility VAE loss and one bounded joint fit. Use fresh, consistently normalized supplied beta comparisons; evaluate expected-q reconstruction NLL and average prior KL, keeping encoder-mean visualizations separate. *Skill:* Integrate amortized variational inference with a neural likelihood and assess a defined distortion/rate tradeoff without treating rate as mutual information or latent patterns as identified causes. #link("Lectures/course_architecture_scope/source_inspection.md")[Instructor mobility source]. *Limit:* Uses 19 measurements and four hidden coordinates. Data access, prepared comparisons and CPU runtime remain untested. Patterns are descriptive, not identified causal factors. All course adaptations remain unrun.],

  [13],
  [*Project presentations and course synthesis*],
  [Student project presentations connecting probabilistic assumptions, computation, prediction, evaluation, uncertainty and scientific interpretation. No additional substantive lecture topic is committed at this stage.],
  [],
  [],
  [No notebook — project presentations and synthesis.],
)

#pagebreak()

= Deliberate scope boundaries

This course develops selected mathematical capabilities, not an exhaustive survey of Murphy. The exclusions below are deliberate; they are not hidden promises to cover material during L13 project presentations. The #link("Lectures/course_architecture_scope/architecture_audit.md")[independent architecture audit] evaluates source coverage and teaching feasibility.

#table(
  columns: (65mm, 51mm, 1fr), inset: 4pt, stroke: 0.45pt + rule,
  table.header(hdr[Other possible topic], hdr[Choice in this plan], hdr[What we give up]),
  [More advanced optimization], [Basic derivatives and small-batch updates are sufficient here], [No separate study of curved-geometry updates, expensive black-box search, transport or subset selection.],
  [Particle methods for changing hidden states], [Exact sequence calculations in L08 and sampling theory in L10], [No method for tracking a complex changing state with a cloud of weighted samples (Book 2 Ch. 13).],
  [MRI classification and continuous forecasting], [Missing-data fitting and discrete hidden-state lab selected], [Less biomedical and forecasting practice. Either application can replace its corresponding lab after review.],
  [More complex regression and prediction checks], [Common models in L05 and one neural probability model in L11], [No full sparse/hierarchical regression, calibration or guaranteed prediction-interval course.],
  [Larger inference toolkits], [One checked method per main lab], [No general-purpose graph solver, broad variational-family catalogue or full Hamiltonian sampler derivation.],
  [Bayesian neural networks and Gaussian processes], [Small fitted networks only], [No separate treatment of uncertainty about network weights or Gaussian-process prediction.],
  [Other generative models], [A variational autoencoder in L12], [No flow, diffusion or adversarial model teaching. These are different ways to learn data distributions and need their own time.],
)
