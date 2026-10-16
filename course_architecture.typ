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

This document defines the *intellectual purpose and planned progression* of the course. It guides scope choices and explains how mathematical understanding supports competence with actual problems. The #link("advanced_statistics_2027_1_syllabus.typ")[student syllabus] summarizes it; the #link("curriculum_map.typ")[curriculum map] allocates proposed topics and practical exercises; agreed lecture scopes own detailed commitments. The #link("curriculum_map_actual.typ")[actual curriculum map] will record what is taught once classes begin. Planned and actual coverage should be compared and reconciled without turning prepared materials into claims about student learning.

= What the course is for

The goal is *working competence in probabilistic machine learning*. Since the field of machine learning is large and constantly developing, it is not the goal of this course to be exhaustive. Rather, the student should have practical experience with a number of substantive datasets, the types of scientific and practical questions that can be asked about them, and the computational tools that are appropriate. This practical knowledge is built upon a *coherent probabilistic understanding* of the field. The probabilistic approach is the main intellectual instrument for developing the practical competence. By understanding machine learning problems as a process of formulating a probabilistic model, specifying the desired query on that probabilistic model, and a performance criterion for evaluating the answer, students will have a tool for extending their competence to new problems. The computational methods are seen as tools appropriate for exploiting specific structure and scale of the problem at hand and its formulation. The mathematical details matter: without them, students cannot see what an algorithm computes, why its assumptions help, when it fails, or how it differs from an alternative. This is a graduate course in which students already know probability and Bayesian statistics; it develops that background into the ability to tackle new machine-learning problems.

The course therefore has *two intertwined threads*. One develops the mathematical ability to formulate and compare methods. The other builds a concrete repertoire: particular learning problems, datasets, implementations, performance checks and diagnoses. Every substantive lecture should advance both threads at an appropriate depth. The algorithm or mathematical principle is an *exemplar* of a transferable idea; the example is substantial enough that students learn how to use and question the method, rather than merely recognize its algebra. Practical competence here means credible, guided first use and informed method selection—not unassisted production mastery of every technique after one notebook.

== From learning problems to mathematical formulations

The first lecture formulates the language and the approach in which the rest of the course will understand machine learning.  A *learning task* specifies what a system should accomplish; its *experience* is the data, feedback, or interaction available. The *structure and scale* of that experience matter. Its success must be judged by a *performance requirement*: what predictions, distributions, representations or decisions must be good, and how good is good enough? The same dataset can support prediction, generation, discovery or action, each with different legitimate criteria.

The mathematical formulation contains *two distinct, related objects*. A probabilistic model represents relevant observed and latent variables, their dependencies, and uncertainty. A performance functional specifies what counts as a good answer. For example, a predictive action $a$ can be evaluated by

$ cal(R)(a) = integral L(a, y) p(y) dif y. $

The distribution under which actual performance is assessed need not equal the model we fit. Model mismatch, the choice of training surrogate, and numerical or approximation error are different possible sources of failure.

A formulation gives us *probabilistic queries*: conditional distributions, marginal probabilities, expectations, predictions or decisions, often requiring integrals or optimizations. This means, directly, that the same data and probabilistic formulation can be used for different queries requiring, potentially, different computational approaches. This is established in the first lecture, and the rest of the course develops both richer probabilistic models and ways to perform the necessary computations at useful scale. A student's practical question is not merely "Which formula applies?" but "Which answer do I need, how can I compute it, and how can I tell whether it is good enough?"

== The task–model–performance–computation relationship

#align(center)[
  #block(width: 91%)[
    #concept-card(
      [Learning problem],
      [Recognizable task · available experience · data structure and scale · required performance],
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
        [Observed and latent variables; dependencies, structural assumptions, posterior and predictive queries],
        tint: pale-blue,
      ),
      concept-card(
        [Performance functional],
        [Expected loss, predictive score, distributional discrepancy, information retained or decision utility; required fidelity],
        tint: pale-blue,
      ),
    )
    #v(5pt)
    #align(center)[#text(size: 14pt, fill: blue)[$arrow.b$]]
    #v(5pt)
    #concept-card(
      [Induced computational demand and method choice],
      [Required query or optimization · cost at relevant scale · exact computation or defensible approximation],
      tint: rgb("#F5F6F7"),
    )
    #v(5pt)
    #align(center)[#text(size: 14pt, fill: blue)[$arrow.b$]]
    #v(5pt)
    #concept-card(
      [Use, check, and compare on a concrete problem],
      [Fit or infer · evaluate task performance · diagnose model and computation · choose a next move],
      tint: rgb("#F5F6F7"),
    )
    #v(3pt)
    #text(size: 8pt, fill: muted)[A reasoning framework, not a rigid recipe: failures in application can lead us to revise the task, model, criterion or algorithm.]
  ]
]

The course's main mathematical *moves* broaden *(i) what probabilistic models can express, (ii) what performance functionals can distinguish, and (iii) what computational methods can deliver*. The computational obstacle is *induced* by the data structure and size, the model and query, the performance requirement, and available resources. An algorithm becomes appropriate because it meets those particular demands, not because the syllabus has reached its chapter.

== The ideal quantity and the practical calculation

Computational difficulties can concern the probabilistic query, fitting the model, or evaluating performance; these are not necessarily the same calculation. A factorization may let us reorganize a sum and obtain an *exact* result more cheaply. A point estimate may replace integration over parameter uncertainty; Laplace or variational inference may instead supply an approximate posterior distribution; and Monte Carlo may estimate a particular expectation using a finite sample. A desired performance criterion may itself be estimated on data or replaced by a tractable training surrogate. Some of these moves simplify computation without approximating the target, while others introduce specific errors. We should not call all of them "posterior approximations." For any chosen approach, the recurring questions are: *When is it appropriate for this structure and scale? What computation does it save relative to a plausible alternative? Is its accuracy sufficient for the actual task?*

== How mathematical depth becomes practical familiarity

Each lecture needs a recognizable *problem encounter*: what is observed, what must be predicted, inferred, generated or decided, and how success will be checked. Its mathematical argument then explains a method's assumptions, what is computed and the regime in which the method pays off. Finally, students should see and use the approach on a concrete dataset, inspect its output and failures, and compare it with at least one meaningful baseline or alternative when feasible. This is a *design test*, not a mandatory slide sequence; some lectures develop representation or performance rather than a new algorithm.

A transparent toy model and a credible practical example have *different instructional jobs*. A small controlled case can expose a theorem, exact reference, bias or numerical failure that is otherwise hidden. A substantive case demonstrates why one would use the method and what it means to evaluate an answer. A lecture or notebook may use both, with much of the code or data preparation supplied, rather than forcing every student to implement two complete applications in an hour. Whenever possible, revisit an earlier problem with a new method: the difference between tools becomes visible when the question, dataset and performance criterion stay fixed.

The approximately two-hour lecture develops the mathematical reasoning, conceptual comparisons and interpretation of representative results, often through a worked example. The approximately one-hour notebook provides a guided encounter with the method: *construct or run* it, *read and validate* its output, and *judge* whether it answers the learning problem. The expected effort is in recognizing and using ideas, not in independently building a substantial program. Questions should be local, short, fully specified, and easy to answer with the information and code already provided; unfamiliar concepts and APIs need gentle introduction, while familiar ones can be exercised without unnecessary re-teaching.

The course's notebook pattern is a fine-grained, AI-assisted question-and-answer sequence, not an open-ended software assignment. Authors first validate a worked solution, then write a solved notebook with questions followed immediately by complete answers; the student version is generated from that solved source. Supply data preparation, plotting helpers and arbitrary setup choices when they are not the point of the lesson. Small steps can include interpreting a mathematical object, applying a lecture equation, completing a short operation, predicting or checking an output, and evaluating a meaningful comparison. Students may consult AI for each self-contained question. The questions should be easy to approach without making the reasoning entirely optional. Use #link("InClass/Solutions/lecture1_missing_data.ipynb")[the prepared L01 solved notebook] and the #link("https://github.com/opherdonchin/BayesShortCourse/tree/main/sleep")[Sleep Deprivation notebook sequence] as style precedents, adapted to this course's methods. The #link(".agents/skills/build-teaching-notebook/SKILL.md")[notebook-building] and #link(".agents/skills/teaching-notebook-authoring/SKILL.md")[teaching-notebook] skills define the detailed authoring and validation process.

Murphy's two books provide the main mathematical and conceptual source. Book 2 supplies the broader logic and methods; Book 1 often supplies more gradual derivations or useful introductory examples. The course is a deliberate selection, not comprehensive chapter coverage. Formal proofs and calculations are retained where they explain a method's ability, limits, or relation to other methods. Their pedagogical value is tested by the understanding and problem-solving judgment they make possible—not by the number of pages or results reproduced.

= How the semester develops

== What constitutes a class of learning problems?

A learning-problem family is not simply "medicine," "images," or a convenient dataset on which to demonstrate an algorithm. It is characterized by *the available experience and the structure and size of the data* (what is observed, missing, sequential, dependent, or high-dimensional), *the task and probabilistic question*, and *the performance requirement* (what must be estimated, predicted, preserved or decided, and how accurately). These induce the necessary calculations and their costs relative to a computational budget. *Computational difficulty is a consequence of the formulation, not a fourth independent ingredient.* Different datasets may share the same mathematical problem, while the same dataset may support several distinct questions.

But the purpose of this classification is *to help students solve recognizable machine-learning problems*. Every lecture therefore needs a practical destination as well as an intellectual contribution: students should understand *what the problem looks like in data*, which method they would reach for, what its output means, how it is evaluated, and where it is likely to fail. The mathematical progression supplies a shared explanation for that repertoire. A lecture fails if students see only formulas without a usable technique, or only a technique without an intelligible reason for choosing it.

The semester follows a recurring argument: *recognize the learning problem → formulate its model and performance → identify the required computation and its scale → develop the mathematical move → use and evaluate the method*. This is a conceptual relationship, not a required presentation order. The notes and notebooks may begin with a practical puzzle or a mathematical result, whichever reveals the connection most clearly. We should cultivate both familiarity with individual methods and the ability to transfer that familiarity to a new dataset.

== Models, probabilistic queries and performance (L01–L04)

*L01 — Probabilistic machine learning.*
When measurements are incomplete or noisy, the same dataset can support prediction of a missing measurement, inference of a hidden state, generation or a decision. The practical starting point is a multivariate measurement problem: students specify what they observed, what they want, and what counts as a useful answer; then use multivariate Gaussian conditioning to impute missing observations and quantify uncertainty. The *mathematical move* is to express different tasks as conditioning, marginalization and summarizing a joint distribution. The Gaussian case provides a complete, workable baseline; it also establishes the challenge of retaining this problem-solving ability when the relevant distributions stop being Gaussian. The prepared L01 notebook is designed to give initial practical experience with conditioning, rather than just a derivation of conditional moments; this has not yet been tested in class.

*L02 — The exponential family.*
Binary measurements, real measurements, categories, counts and observed character transitions each call for an appropriate distribution. Students should recognize these data types, estimate a law from observed samples, score new cases and simulate additional examples. Exponential-family models make the connection between these tasks transparent: sufficient statistics summarize relevant data; derivatives of the log-partition function give moments; moment matching supports MLE; maximum entropy motivates distributions under stated constraints. The *practical exemplar* is a character bigram model: count transitions, fit and inspect the transition matrix, score strings under the fitted model and generate names; held-out evaluation is optional. The goal is not to reduce text modeling to bigrams, but to learn a complete small modeling cycle and recognize when the Markov/finite-statistic assumptions would be inadequate.

*L03 — Graphical models*
An image, network or spatial measurement field is not well modeled as a collection of unrelated observations. Students should learn to recognize a plausible conditional-independence structure, specify its factors, and use a graphical model to predict or reconstruct missing components. DAGs, d-separation, Markov blankets and undirected potentials express different constraints on a joint probability distribution; the reduced representation may, but need not, make inference tractable. In the image-restoration exemplar, students construct an Ising prior and an observation likelihood, derive a single-site conditional, and perform a local reconstruction update. They must interpret the image and recognize that conditional optimization is not global MAP or a posterior marginal. The *transferable insight* is when a structural assumption enables modeling and which further computational question remains open for L08.

*L04 — Information theory.*
A classifier can be correct but badly calibrated; a compressed representation can preserve some distinctions while losing others. These are learning problems whose success cannot be described by a single accuracy or squared-error number. The *performance move* introduces entropy, cross-entropy, KL divergence and mutual information. Expected negative log score relates probabilistic predictions to KL discrepancy; mutual information describes a selected dependency, not universal usefulness for every decision. Students should compare *actual probabilistic predictions*—for instance, prepared competing probability forecasts for Iris species—and identify what different performance measures reward. The noisy parity-code example offers an exact small experiment in the tension between information, error probability and resource rate, but it is *not the practical destination of the lecture by itself*. It should be explicitly related back to evaluation of machine-learning predictions and learned representations. The notebook should make a real distinction between a metric calculated correctly and a model or decision that is useful.

== Fitting probabilistic models (L05–L06)

These lectures extend fitting beyond the elementary models of L01–L02. GLMs specify appropriate conditional response distributions and enable direct gradient-based point fitting; EM uses conditional expectations to fit models with missing or latent observations. Neither should be confused with obtaining a full posterior over model parameters.

*L05 — Generalized linear models.*
Predicting a species or a binary clinical outcome requires different observation distributions from predicting a continuous measurement; counts introduce another mean–variance relationship. GLMs extend the repertoire of conditional likelihoods, with links relating their parameters to predictors. For canonical links, their structured gradients and convex likelihoods (under appropriate conditions) make point estimation especially manageable, although full parameter-posterior inference may not be. The *computational move* is to use likelihood gradients, reverse-mode automatic differentiation and minibatch optimization for an MLE/MAP fit. Students fit and evaluate a softmax classifier on Iris, inspect its predicted probabilities and held-out score, and compare hand-derived gradients with those from software. The aim is familiarity with an end-to-end probabilistic classifier, not just a backpropagation identity. The model's predictive output, training objective and empirical performance must remain distinct.

*L06 — Expectation Maximization.*
Suppose several physiological measurements are missing for some participants, or an observation belongs to an unknown mixture component. With unknown population parameters, imputing a value is no longer the whole task: we need to *fit the model using the observed data*. Marginal likelihood integrates over latent variables; filling each one in with a point guess changes the objective. Expectation–maximization exploits a tractable conditional posterior and manageable expected complete-data statistics to alternate inference with fitting. The ELBO/KL identity explains its likelihood-improvement guarantee under exact, improving steps. Gaussian incomplete-data fitting needs expected second moments *including the conditional covariance*, connecting L01's Gaussian calculations to L02's sufficient statistics. Practically, students fit parameters under controlled missingness, compare them with complete-case or mean-imputed baselines, and distinguish observed-data likelihood from reconstruction quality. The technique is worthwhile only if its E- and M-steps are tractable; EM supplies a point fit, not full parameter-posterior uncertainty.

== Inference: exact computations and defensible approximations (L07–L09)

Inference methods answer different queries under different structural and computational conditions. Laplace constructs a local posterior proxy; VI optimizes a distributional criterion; message passing reorganizes exact sums. Sample averages estimate particular expectations and introduce finite numerical error. These are distinct mathematical objects. L07 gives an inference overview and one bounded sampler comparison; L08 develops exact structured inference; L09 develops variational and amortized inference.

*L07 — Inference overview and Laplace approximation.*
A Bayesian predictor needs posterior probabilities or expectations, rather than only a fitted coefficient. Derive the scalar Laplace construction and state its multidimensional form; explain local regularity, Hessian cost and failures at boundaries, asymmetry or multiple modes. Use the accepted Challenger thermal-distress model, with a checked two-dimensional numerical reference, for a proposed comparison of point prediction, Laplace and a supplied posterior sampler. Derive iid sample-average variance under finite-variance assumptions; interpret supplied query-specific Monte Carlo error and dependent-output diagnostics without deriving an MCMC transition algorithm. Replace manual grid/coordinate detail to fund this encounter. Diagnostics support judgment rather than certify exploration. The event is thermal distress, not catastrophic-failure probability or a launch decision.

*L08 — Structured exact inference.*
Given noisy observations over time, filtering, smoothing, evidence and a most probable whole path are different answers. Derive scaled categorical-HMM forward–backward messages and their $O(T K^2)$ dense cost, contrasting exact structured sums with $K^T$ enumeration. The notebook transfers the same conditional-inference logic to Gaussian time series through the existing Oke package-backed workflow, with equations and small checks around prepared computations. A Kalman comparison uses L01 Gaussian conditioning; it does not require a second full live derivation. Source repairs, concrete data/model choices and runtime validation remain author responsibilities. The notebook is an extension of the lecture's argument rather than a second independent coding assignment.

*L09 — Variational and amortized inference.*
Choose a tractable posterior family and optimize the ELBO or reverse KL, rather than matching only a local mode and curvature. Derive the correlated-Gaussian mean-field diagnostic and pathwise gradient with its direct parameter term. Apply VI to the accepted 23-flight Challenger posterior and compare specified predictions with Laplace and a checked reference. Distinguish family restriction, optimization error and stochastic gradient noise. A shared evidence-to-variational-parameters map amortizes repeated optimization; introduce this computational payoff here and make its neural construction concrete in L11. Replace the numerical CAVI sweep with this explanation while retaining recognition of coordinate updates. Drawing from q for an objective estimate does not make those draws samples from the target posterior.

== Learned representations, prediction and generation (L10–L12)

The instructor's two-lecture neural-network decision replaces the dedicated MCMC meeting. The positive commitment is learned compositional representation: a GLM fixes its features, whereas a network learns a representation jointly with a probabilistic output. Architecture expresses assumptions about structure and computational resources. Two lectures develop this argument on images and sequences, before L12 uses networks for both a generative model and amortized posterior inference. Fitted weights are not a Bayesian weight posterior.

*L10 — Deep Neural Networks I: learned representations and images.*
Move from an affine GLM through nonlinear composition to image features. Without a nonlinearity, affine layers collapse to one affine map; with nonlinearities, hidden representations can support decisions unavailable to the original features. Reuse L05 categorical likelihood, reverse-mode differentiation and minibatch fitting. Derive a local shared filter, parameter sharing and receptive-field composition; distinguish translation equivariance under stated boundaries/stride from invariance. Work one residual-path derivative as a trainability argument, with normalization and regularization explained only as needed. The proposed notebook adapts the published PyTorch LeNet/Fashion-MNIST source: inspect a filter calculation, shapes and sharing, perform bounded updates, then judge held-out log score and errors against a supplied dense baseline. Prepared drivers/checkpoints keep the argument within one hour. A short likelihood-head comparison preserves probabilistic meaning without making heteroskedastic regression the lecture's organizing purpose.

*L11 — Deep Neural Networks II: representing sequence context.*
Revisit L02 character prediction. An RNN replaces the last-character Markov context with a learned deterministic summary; shared parameters enable varying-length computation but do not guarantee retention of distant information. Work an unrolled derivative and Jacobian products, then derive a small causal attention retrieval and its matrix form. Positional information and causal masking have distinct jobs. Compare recurrent compression, local convolution and direct retrieval by dependency, storage and computational cost, rather than treating architectures as a ranking. Attention is a substantive live mechanism; the one-hour notebook focuses on a source-adapted RNN on Time Machine text, with held-out token log score against a smoothed bigram baseline and a clear distinction between teacher-forced scoring and generated sequences. Finally distinguish a network parameterizing p from a shared inference network parameterizing q. No second transformer-training notebook is added.

*L12 — Variational autoencoders: amortized inference and rate–distortion.*
Use networks in both roles: $p(z)p_theta(x|z)$ generates observations and $q_phi(z|x)$ supplies a shared posterior approximation. Reuse ELBO, pathwise gradients and composition, applying the Gaussian density to the feature-summed reconstruction term rather than assuming a full earlier heteroskedastic derivation. Preserve the accepted city/mobility direction and required prior generation. Distinguish reconstruction, decoder means and sampled observations after the validated transformations. Compare reconstruction/rate tradeoffs, recognizing that average encoder-to-prior KL equals mutual information plus aggregate-posterior mismatch, not mutual information alone. Interpret collapse, approximation/amortization error and nonidentifiability without claiming recovered causal factors.

== Deliberate sampling boundary

The retained competencies are sample-average reasoning and a supplied posterior-sampling comparison in L07, sampling from q for stochastic gradients in L09, and generation from fitted models in L02/L11/L12. Prior PyMC use is practical experience, not proof of MH/HMC algorithm understanding. General MH correction/balance, Gibbs-as-MH, proposal design, formal chain convergence/mixing theory, HMC/NUTS construction, importance sampling and AIS are omitted. Their loss is real algorithmic depth, not repaired by optional mentions or scattered fragments. No hidden sampling recording or extra lecture is required. L07's bounded encounter replaces existing detail; it does not preserve the former MCMC lecture under another title.

== Using the tools to address a new problem (L13)

*L13 — Demonstrate practical selection and justification on a new problem.*
Student presentations should begin with a recognizable dataset and problem, identify the task and performance requirement, select a plausible probabilistic model and method, and show an actual result with a meaningful check or comparison. Mathematical explanations should clarify what their algorithms deliver and what remains uncertain. The course's success is visible when students can use a concrete method *and* give a principled reason for choosing or rejecting it—not when they can only recite the unified architecture or reproduce a worked notebook.


= Curricular selection and teaching records

The course is a deliberate selection from Murphy, not comprehensive coverage. It retains mathematical depth where a result explains a method's construction, efficiency, validity or limitations, while making room for meaningful practice. Exact sequence inference, Laplace, VI and sample-average estimation answer different kinds of computational questions rather than forming an approximation hierarchy. More advanced optimization, particle methods, Gaussian processes, Bayesian neural networks and further generative families are worthwhile subjects but have no dedicated teaching commitment in the current thirteen-meeting plan.

The #link("curriculum_map.typ")[curriculum map] gives the proposed allocation of topics, Book 1 and Book 2 reading sections, examples, notebook references and specific omissions. Approved lecture scopes may differ from newly proposed examples; that disagreement is to be considered before modifying a scope. The parallel #link("curriculum_map_actual.typ")[actual curriculum map] starts empty and will be updated after each meeting to capture substantive lecture and student-notebook coverage. Prepared decks and solutions are evidence for planning, not evidence that students encountered or completed material.
