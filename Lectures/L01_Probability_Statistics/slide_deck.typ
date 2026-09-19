// Lecture 1 — Probabilistic Machine Learning
#import "../course.typ": *
#import "figures/beta_bernoulli_graph.typ": beta_bernoulli_graph
#import "figures/input_output_function_schema.typ": input_output_function_schema

#let lecture = (
  number: 1,
  title: [Probability and Bayesian Statistics],
  short-title: [Probability & Statistics],
  subtitle: [From Bayesian statistics to probabilistic machine learning],
)

#show: course-theme.with(info: lecture)

#title-slide()

// These are lecture-local structural conveniences only.
// They intentionally carry no independent visual theme.
#let twocol(left, right) = grid(
  columns: (1fr, 1fr),
  gutter: 1.2em,
  align: top,
  left, right,
)

#let triad(a, b, c) = grid(
  columns: (1fr, 1fr, 1fr),
  gutter: 0.8em,
  align: top,
  a, b, c,
)

// `course-figure` resolves file strings from Lectures/course.typ. Keep these
// lecture-local assets addressable without relying on Typst's removed path().
#let lecture-figure-path(file) = "L01_Probability_Statistics/" + file

// Keeps a reveal-only note in the same visual space as a course figure.
#let figure-note(body) = block(width: 100%, height: 5.45cm)[
  #align(center + horizon)[
    #block(width: 88%)[
      #note[#text(size: 0.72em)[#body]]
    ]
  ]
]

#section-metadata(
  short-title: [Probabilistic modelling],
  subtitle: [Probablistic models update based on data],
)

= A familiar modeling language

== The Beta-Binomial model

#content-block(
  layout: "top",
  object-width: 82%,

  object: [
    #align(center)[
      #twocol[
        *Observed*\
        the coin tosses $y_1, dots, y_N$
      ][
        *Unknown*\
        the coin bias $theta$
      ]

      #uncover("2-")[
        $ theta tilde "Beta"(alpha, beta) $
        \
        $ y_i  tilde "Bernoulli"(theta), quad i = 1, dots, N $
      ]
    ]
  ],
  key-points: [
    - A statistical model has data and unknown parameters
    #uncover("2-")[
      - How could observed data ($y$) could have been generated.
      - What does it tell us about the parameters ($theta$)
    ]
  ],
)

#speaker-note[
  The first step in reactivating the undergraduate course is to remind them of the language of models.
]

== Models are built out of distributions

#content-block(
  layout: "side-left",
  object-width: 60%,
  object: [
    #grid(
      columns: (28%, 1fr),
      column-gutter: 1.2em,
      row-gutter: 0.25em,
      align: center + horizon,

      [
        #align(center)[
          #text(size: 0.68em)[
            $ theta tilde "Beta"(alpha, beta) $
          ]
        ]
      ],
      [
        #course-figure(
          lecture-figure-path("figures/coin_model__beta_distribution.svg"),
          source: "figures/coin_model__beta_distribution.svg",
          width: 100%,
          height: 4cm,
        )
      ],
      [
        #uncover("2-")[
          #align(center)[
            #stack(
              spacing: 0.2em,
              text(size: 0.68em)[$ y_i  tilde "Bernoulli"(theta) $],
              text(size: 0.68em, fill: palette.muted)[$ i = 1, dots, N $],
            )
          ]
        ]
      ],
      [
        #uncover("2-")[
          #course-figure(
            lecture-figure-path("figures/coin_model__bernoulli_likelihood.svg"),
            source: "figures/coin_model__bernoulli_likelihood.svg",
            width: 100%,
            height: 4cm,
          )
        ]
      ],
    )
  ],
  key-points: [
    #text(size: 0.82em)[
      - Beta for continuous variables on $[0,1]$.
      #uncover("2-")[
        - Bernoulli four the number of counts in a yes/no process.
      ]
      #uncover("3-")[
        - Distributions are parameterized families
      ]
    ]
  ],
)

#speaker-note[
  Reactivate distributions are parameterized families and start remembering a few that they know.
]

== Models can be drawn as graphs

#stack(
  spacing: 0.7em,
  content-block(
    layout: "side-left",
    object-width: 55%,

    object: [
      #twocol[
        #text(size: 1em)[
          $ theta tilde "Beta"(alpha, beta) $
          \
          $ y_i tilde "Bernoulli"(theta) $
        ]
      ][
        #beta_bernoulli_graph()
      ]
    ],

    key-points: [
      - Nodes represent quantities.
        - Shading marks observed data.
      #uncover("2-")[
        - Arrows encode conditional dependence.
          - We will not use Kruschke diagrams
      ]
    ],
  ),

  pause,

  note([
    In this course, graphs will allow us to factor complex problems into smaller, more tractable problems
  ]),
)

#speaker-note[
  Introduce graphical-model notation through the familiar Beta-Binomial model. Emphasize the new types of graphs that are familiar from the previous course but not the heart of it.
]

== Bayes' rule combines prior and likelihood

#note[#text(size:0.9em)[#stack(spacing:0.7em,
  [Model],
  [$ theta tilde "Beta"(alpha, beta) $],
  [$ y_i tilde "Bernoulli"(theta) $],
)]]

#content-block(
  layout: "top",
  object-width: 94%,
  object: [ #pause
      #align(center)[
        #stack(
          spacing: 1.0em,
          text(weight: "semibold", fill: palette.accent)[Bayes' rule],
          text(size: 1.3em)[$
            p(theta | y) &= frac(p(y | theta) p(theta), p(y)) \
            &prop p(y | theta) p(theta)$],

        )
      ]
    ],
  key-points: [
    #pause
    - *Prior:* $p(theta)$
    - *Likelihood:* $p(y | theta)$
    - *Posterior:* $p(theta | y)$
    #pause
    - We explored the posterior of $theta$
      - Treating $p(y)$ as a normalizing constant
  ],
)

#speaker-note[
  Connect the two model statements to Bayes' rule. The Bernoulli model supplies
  the likelihood, the Beta model supplies the prior, and normalization turns
  their product into the posterior distribution.
]

== Conjugacy permits simple calculations

#note[#text(size:0.9em)[#stack(spacing:0.7em,
  [Model],
  pad(left: 1em)[$ theta tilde "Beta"(alpha, beta) $],
  pad(left: 1em)[$ y_i tilde "Bernoulli"(theta) $],
  [Bayes rule],
  pad(left: 1em)[$ p(theta | y) &prop p(y | theta) p(theta) $],
)]]

#content-block(
  layout: "top",
  object-width: 68%,
  object: [
    Applying Bayes' rule to our model
    #stack(
      spacing: 0.9em,
      text(size: 0.88em)[
        #grid(
          columns: (auto, 1fr),
          column-gutter: 0.9em,
          row-gutter: 0.75em,
          align: (left, left),
          uncover("2-")[#text(weight: "semibold", fill: palette.accent)[Prior]],
          uncover("2-")[$ p(theta) = "Beta"(alpha, beta) $],
          uncover("3-")[#text(weight: "semibold", fill: palette.accent)[Likelihood]],
          uncover("3-")[$ p(y | theta) = "Binomial"(N, theta) $],
          uncover("5-")[#text(weight: "semibold", fill: palette.accent)[Posterior]],
          uncover("5-")[$ p(theta | y) = "Beta"(alpha + y, beta + N - y) $],
        )
      ],
    )
  ],
  key-points-title: [#uncover("4-")[Conjugacy]],
  key-points: [
    #uncover("4-")[
      #text(size: 0.85em)[
        The prior and likelihood are conjugate when the posterior belongs to the
        same distribution family as the prior.
      ]
    ]
  ],
)

#speaker-note[
  Reactivate the definition of conjugacy. In the Beta-Binomial model, updating
  adds the observed successes and failures to the two Beta parameters. There is
  no need to derive the result here.
]

== The posterior is a distribution representing uncertainty

#content-block(
  layout: "top",
  object-width: 82%,
  object: [
    #course-figure(
      lecture-figure-path("figures/coin_model__prior_likelihood_posterior.svg"),
      source: "figures/coin_model__prior_likelihood_posterior.svg",
      caption: [Bayesian updating for the familiar coin model],
      width: 100%,
      height: 8.5cm,
    )
  ],
  key-points: [
    - The prior and the posterior are both probability distributions
    - Their width expresses the uncertainty
    - The uncertainty in the posterior is less than in the prior
  ],
)

#speaker-note[
  Connect the algebra on the previous slide to these distribution shapes. With
  a Beta(2,2) prior and 7 heads in 10 tosses, the posterior is Beta(9,5).
]

== Summary: A familiar modeling language

#content-block(
  key-points: [
    - Probabilistic models link observed data to parameters
    - Graphs show model variables and dependencies
    - Bayes' rule combines prior and likelihood into a posterior
    - Conjugacy makes some updates analytic
    - Posterior width represents remaining uncertainty 
    - Posterior uncertainty narrows with more data
  ],
)

#speaker-note[
  This is the pivot from the previous course to introducing the current course. The next section will establish what is the same and what is different.
]

#section-metadata(
  short-title: [From statistics to machine learning],
  subtitle: [Same probabilistic language, different organizing questions],
)

= From statistics to machine-learning problems

== Statistics focuses on the unknown parameters

#content-block(
  layout: "top",
  object-width: 60%,
  object: [
    #align(center)[
      $ p(theta | D) = frac(p(D | theta) p(theta), p(D)) $
    ]
  ],
  key-points: [
    - Get data $arrow.r$ build a model $arrow.r$ apply Bayes' rule $arrow.r$ interpret $theta$
        - For many scientific questions, that posterior *is* the answer
    #uncover("2-")[
        - Statistics arose from an interest in the underlying parameters in nature
    ]
  ],
)

#speaker-note[
  Do not suggest that posterior prediction is new to them -- they have done it.
  The question on the table is different: is the posterior over theta always
  the object we ultimately care about? For a scientific inferential problem it
  often is. The rest of this section is about problems where it is not.
]

== Machine learning grew out of computer science

#content-block(
  layout: "top",
  object-width: 96%,
  object: [
    #input_output_function_schema()
  ],
  key-points: [
    - A computational task is an *input/output contract*
      - Produce a function $f$ that maps input $x$ to output $y$
      #uncover("2-")[
      - Implementation is secondary to the requirement
      - Multiple implementations may be possible
      ]
    #uncover("3-")[
    - Machine learning developed in this context
    ]
  ],
)

#speaker-note[
  It's worth emphasizing the relationship between science and engineering and the different questions they ask.
]

== Early machine learning grew out of classification problems

#content-block(
  layout: "top",
  object-width: 94%,
  object: [
    #grid(
      columns: (1fr, 1fr),
      gutter: 1em,
      align: top,

      alternatives-match(
        (
          "1, 3-": [
            #course-figure(
              lecture-figure-path("figures/fisher_1936__iris_discriminant_histograms.png"),
              source: "Fisher (1936), Fig. 1, The Use of Multiple Measurements in Taxonomic Problems",
              width: 100%,
              height: 5cm,
            )
          ],
          "2": [
            #figure-note[
              Rosenblatt considered the perceptron a model of the vertebrate
              visual system. He showed how neuron-like units could learn to
              “recognize” classes of input patterns from experience.
            ]
          ],
        ),
        position: center + horizon,
        stretch: false,
      ),
      alternatives-match(
        (
          "1": [
            #figure-note[
              Every flower started as four numbers. Fisher learned one weighted
              combination of those four numbers so that species became as
              separated as possible. The histogram shows the flowers after that
              learned projection.
            ]
          ],
          "2-": [
            #course-figure(
              lecture-figure-path("figures/rosenblatt_1958__perceptron_organization.png"),
              source: "Rosenblatt (1958), Fig. 1, The Perceptron",
              width: 100%,
              height: 5cm,
            )
          ],
        ),
        position: center + horizon,
        stretch: false,
      ),
    )
  ],
  key-points: [
    #uncover("3-")[
      - Fisher's discriminant and Rosenblatt's perceptron share an interface
        - complex input $arrow.r$ class or response
    ]
    #uncover("4-")[
      - Machine learning asks how data can produce the required function $f$
    ]
  ],
)

#speaker-note[
  Fisher's original Fig. 1 shows the Iris distributions of a discriminating
  linear function. Rosenblatt's original Fig. 1 diagrams the organization of
  a perceptron.

  Use these as early landmarks, not as a claim that the disciplines had clean
  boundaries. See `figures/historical_sources.md` for full citations and
  source URLs. End by separating two ideas that are easy to blur: a predictor
  maps an input to a class, while learning is the process that produces that
  predictor from examples.
]

== The prediction problem has two functions

#content-block(
  layout: "top",
  object-width: 90%,
  object: [
    #grid(
      columns: (1fr, 1fr),
      gutter: 1.6em,
      align: center + horizon,
      [
        #align(center)[
          *Training*
          #v(0.5em)
          $ D = {(x_i, y_i)}_(i=1)^N quad arrow.r^(A) quad f_D $
        ]
      ],
      [
        #align(center)[
          *Prediction*
          #v(0.5em)
          $ x_* quad arrow.r^(f_D) quad hat(y)_* in cal(Y) $
        ]
      ],
    )
  ],
  key-points: [
    - The predictor $f_D$ takes a complex input and returns a class
    #uncover("2-")[
      - The training algorithm $A$ is a separate function
        - paired examples in, predictor out
    ]
    #uncover("3-")[
      - Together, learning $f_D$ and applying it to a new input form the *prediction problem*
    ]
  ],
)

#speaker-note[
  The right-hand function is the one we deploy: an image, waveform, document,
  or other complex object goes in, and a class comes out. The left-hand
  function is training. Its output is itself a function. Keep these two maps
  distinct because most of the course concerns how to construct the second map
  so that the first one works on new cases.
]

== Probabilistic prediction keeps uncertainty about the class

#content-block(
  layout: "top",
  object-width: 90%,
  object: [
    #align(center)[
      $ p(y_* | x_*, D)
        = integral p(y_* | x_*, theta) p(theta | D) dif theta $
      #v(0.7em)
      #uncover("2-")[
        $ hat(y)_* = arg max_(c in cal(Y)) p(y_* = c | x_*, D) $
      ]
    ]
  ],
  key-points: [
    - The predictive distribution assigns probabilities to the possible classes
    #uncover("2-")[
      - A decision rule turns that distribution into a class when the task requires one
    ]
    #uncover("3-")[
      - The training data affect the prediction through what they tell us about $theta$
    ]
  ],
)

#speaker-note[
  In a probabilistic treatment, the deployed object need not return only one
  label. It can return a distribution over labels. The integral carries
  parameter uncertainty from the posterior into the prediction, while the
  argmax is one possible decision rule. Later, other losses will imply other
  decisions.
]

== Training performance cannot tell us whether prediction is solved

#content-block(
  layout: "top",
  object-width: 88%,
  object: [
    #grid(
      columns: (1fr, 1fr),
      gutter: 1.6em,
      align: center + horizon,
      [
        #align(center)[
          *Used to produce $f_D$*
          #v(0.45em)
          $ D_"train" = {(x_i, y_i)}_(i=1)^N $
        ]
      ],
      [
        #align(center)[
          *Used to evaluate $f_D$*
          #v(0.45em)
          $ D_"test" = {(x_j, y_j)}_(j=1)^M $
        ]
      ],
    )
  ],
  key-points: [
    - Good predictions on the training set may only show that the procedure fit those examples
    #uncover("2-")[
      - Prediction asks how $f_D$ performs on new input-class pairs
    ]
    #uncover("3-")[
      - Because future cases are unknown, we estimate that performance with data withheld from training
    ]
  ],
)

#uncover("3-")[
  #note[
    Designing an evaluation that genuinely represents future use is a central
    challenge in machine learning.
  ]
]

#speaker-note[
  We cannot certify a predictor using the same observations that produced it.
  A test set is the simplest approximation to the cases the system will face
  later, but its value depends on whether it truly represents that future use.
  This turns evaluation and generalization into central parts of the prediction
  problem, not bookkeeping after training.
]

== Familiar regression notation, two different roles

#content-block(
  layout: "top",
  object-width: 80%,
  object: [
    #align(center)[
      $ Y_i | X_i, theta tilde p(y | X_i, theta) $
    ]
  ],
  key-points: [
    #pause
    #twocol[
      *Dependent / independent*\
      #text(size: 0.8em)[how the statistical model is built: $Y_i$ is given a
        distribution; $X_i$ is conditioned on]
    ][
      *Input / output*\
      #text(size: 0.8em)[the interface of the computational task: what is
        supplied, what the system is asked to produce]
    ]
  ],
)

#note[
  In ordinary supervised regression these usually line up -- independent
  variable $arrow.r$ input, dependent variable $arrow.r$ output -- but they
  are conceptually different roles.
]

#speaker-note[
  Do not introduce "predictor / response" here -- it adds vocabulary without
  adding a distinction they need. The point is that "dependent/independent"
  describes how the model is built, while "input/output" describes what the
  task asks of it. They usually coincide, which is exactly why it is easy to
  stop noticing that they are different questions.
]

== What carries over

#content-block(
  key-points: [
    #twocol[
      - Probability distributions
      - Conditional distributions
      - Prior, likelihood, posterior
      - Bayesian updating
      - Latent variables
    ][
      - Hierarchical models
      - Graphical models
      - Posterior predictive distributions
      - Sampling, MCMC, HMC
      - Uncertainty
    ]
  ],
)

#key-points[The statistical grammar is familiar. Nothing on this list is being retired.]

#speaker-note[
  Read down the list and let it land as reassurance: every one of these
  survives intact into probabilistic ML. What is about to change is the class
  of problems we point this grammar at, not the grammar itself.
]

== What changes

#grid(
  columns: (1fr, 1fr),
  gutter: 1.2em,
  row-gutter: 0.6em,
  align: left + top,

  [*Carries over*], [*Changes*],

  [The grammar: distributions, conditioning, Bayes' rule], [The organizing question: often "how do we do well on new cases?"],

  [$x$, $y$, $theta$, $z$ as familiar roles], [$x$, $y$, and $z$ can all be very high-dimensional],

  [Parameters as meaningful quantities], [Parameters are often instrumental machinery, not the object of study],

  [Exact inference for simple conjugate models], [Exact inference becomes the exception rather than the rule],

  [Point estimates as convenient summaries], [Optimization and approximate inference become central tools],

  [More data sharpens a posterior], [Tasks reward models that can exploit more data and more compute],
)

#speaker-note[
  This is not "statistics does inference, ML does prediction" -- that framing
  is too crude and historically misleading. These are six shifts in emphasis
  and pressure, not a change of subject. Scale in particular is a reward for
  tackling harder prediction/generation/discovery tasks, not the reason those
  tasks exist.
]

== A model is not a task

#content-block(
  layout: "top",
  object-width: 80%,
  object: [
    #align(center)[
      #course-diagram(
        spacing: (3.6em, 2.4em),
        node-stroke: 1.2pt + palette.dark,
        node-fill: palette.paper,
        edge-stroke: 1.2pt + palette.muted,
        mark-scale: 65%,

        graph-node(
          (0, 1),
          name: <a-model>,
          shape: fletcher.shapes.pill,
          width: 6em,
          height: 2.2em,
          stroke: 1.6pt + palette.accent,
        )[Joint model],

        graph-node((1, 0), name: <a-q1>, shape: fletcher.shapes.rect, width: 6.5em, height: 1.8em)[$p(y | x, D)$],
        graph-node((1, 1), name: <a-q2>, shape: fletcher.shapes.rect, width: 6.5em, height: 1.8em)[$p(x | y, D)$],
        graph-node((1, 2), name: <a-q3>, shape: fletcher.shapes.rect, width: 6.5em, height: 1.8em)[$p(z | x, D)$],

        graph-edge(<a-model>, <a-q1>, "-|>"),
        graph-edge(<a-model>, <a-q2>, "-|>"),
        graph-edge(<a-model>, <a-q3>, "-|>"),
      )
    ]
  ],
  key-points: [
    - A probabilistic model specifies distributions and relationships
    - A task specifies which question we ask of that model
    #uncover("2-")[- The same joint model can support several different operations -- and, later, a decision]
  ],
)

#speaker-note[
  This is the bridge into the next section. Do not imply that every task
  corresponds to a unique mathematical form of probability model -- the point
  is the opposite: one sufficiently rich model can answer several different
  questions. Murphy organizes the rest of the book around exactly these
  questions: prediction, generation, discovery, and (beyond this course)
  action.
]

== Summary: From inference to machine-learning problems

#content-block(
  key-points: [
    - We are not abandoning Bayesian or statistical modeling
    - Inference remains part of the machinery
    - What changes is the class of problems and the criterion of success
    - The same probabilistic grammar now serves broader computational tasks
  ],
)

#align(center)[#text(weight: "semibold", fill: palette.accent)[So what do we actually want learned probabilistic models to do?]]

#speaker-note[
  This is the pivot into the next section. Do not resolve the question here --
  let it hang and answer it with concrete, visually distinct examples.
]

#section-metadata(
  short-title: [Tasks: prediction, generation, discovery],
  subtitle: [Four questions, four domains -- and the same four questions of one dataset],
)

= What do we use learned models for?

== Four questions to ask of a fitted model

#grid(
  columns: (1fr, 1fr),
  row-gutter: 1.2em,
  column-gutter: 1.2em,
  align: left + top,

  [*Prediction*\ #text(size: 0.85em)[what should we say about a new case?]],
  [*Generation*\ #text(size: 0.85em)[what should we produce?]],

  [*Discovery*\ #text(size: 0.85em)[what structure explains the data?]],
  [*Action*\ #text(size: 0.85em)[what should we do?]],
)

#key-points[Same grammar. Four different questions. The next several lectures build one task at a time.]

#speaker-note[
  The syllabus builds prediction (Lectures 7-8), generation (9-10), and
  discovery (11-12) -- Murphy chapters up to 33. Action is Murphy's Part VI
  and is flagged, not built, in this course. Use concrete examples from here
  on; do not let this stay a dry four-item catalogue.
]

// A panel of the "same flowers, four questions" composite. The figures are
// deliberately untitled so the question and the probabilistic object are set
// in the deck's own type, and so the panels can be reused elsewhere.
#let iris-panel(question, object, gloss, file) = stack(
  spacing: 0.15em,
  text(size: 0.58em, weight: "semibold", fill: palette.accent)[#question],
  text(size: 0.52em)[
    #object #h(0.7em) #text(fill: palette.muted)[#gloss]
  ],
  course-figure(lecture-figure-path(file), width: 100%, height: 4.15cm, show-source: false),
)

== Same flowers, four different questions

#align(center)[#block(width: 78%)[#grid(
  columns: (1fr, 1fr),
  column-gutter: 1.1em,
  row-gutter: 0.35em,
  align: top,

  iris-panel(
    [Which species is this flower?],
    [$p(y | x, D)$],
    [measurements $arrow.r$ class],
    "figures/task_examples_figures__iris_prediction.svg",
  ),

  uncover("2-")[#iris-panel(
    [What would another such flower look like?],
    [$x tilde p(x | y, D)$],
    [class $arrow.r$ measurements],
    "figures/task_examples_figures__iris_generation.svg",
  )],

  uncover("3-")[#iris-panel(
    [With the species hidden, what grouping is there?],
    [$p(z | x, D)$],
    [measurements $arrow.r$ latent grouping],
    "figures/task_examples_figures__iris_discovery.svg",
  )],

  uncover("4-")[#iris-panel(
    [Which flower should we label next?],
    [$x_"next" = op("argmax")_x HH[p(y | x, D)]$],
    [uncertainty $arrow.r$ what to do],
    "figures/task_examples_figures__iris_action.svg",
  )],
)]]

#figure-source("figures/task_examples_figures__iris_*.svg")

#uncover("4-")[
  #align(center)[#text(weight: "semibold", fill: palette.accent)[Same 100 flowers. Same two measurements. Only the question changed.]]
]

#speaker-note[
  This is the centre of the section, and the one slide to slow down on. Build
  it one panel at a time and say each question out loud before the panel
  appears. The four probabilistic objects are deliberately different -- but do
  not let anyone leave thinking that prediction *is* $p(y|x)$ and generation
  *is* $p(x|y)$; that is the trap the next two "careful" slides close. What
  this slide licenses is only the weaker and more useful claim: a task is
  fixed by what is observed, what is unknown, and what we want the system to
  do -- not by the dataset.

  Details worth having ready. Generation: one Gaussian per species, fit by
  maximum likelihood -- a teaching choice, not a claim about flower
  morphology. Discovery: the mixture never sees a label, and its two clusters
  happen to agree with the species for 96 of the 100 flowers, which is worth
  mentioning *after* the point has landed, not before. Action: the model is
  fit to ten labeled flowers only, and the ringed flower is the one that
  maximizes predictive entropy over the ninety unlabeled ones -- the model is
  not reporting its uncertainty, it is spending it.

  Ask the room which of the four they would call "machine learning". All four.
  See `task_examples_figures.ipynb`, Family B, for provenance.
]

== Prediction: what should we say about a new case?

#content-block(
  layout: "side-left",
  object-width: 58%,
  object: [
    #course-figure(
      lecture-figure-path("figures/task_examples_figures__prediction_iris_logistic.svg"),
      source: "figures/task_examples_figures__prediction_iris_logistic.svg",
      caption: [Posterior over the decision boundary, Iris petal measurements],
      width: 100%,
      height: 7.4cm,
    )
  ],
  key-points: [
    - Given measured features $x_*$, what should we say about the class $y_*$?
    - The predictive object is $p(y_* | x_*, D)$ -- a full distribution
    #uncover("2-")[- A loss function can later turn that distribution into a decision or a point estimate]
  ],
)

#speaker-note[
  Adapted from Murphy Fig. 15.8 (Ch. 15, logistic regression),
  `logreg_iris_bayes_2d.ipynb`; see `task_examples_figures.ipynb` for
  provenance. Stress that prediction does not mean "output a point" -- the
  fan of posterior decision boundaries is the predictive distribution. Lectures
  7-8 build the models (GLMs, deep nets, Bayesian neural nets, GPs) that scale
  this idea.
]

== Generation: what should we produce?

#content-block(
  layout: "top",
  object-width: 84%,
  object: [
    #course-figure(
      lecture-figure-path("figures/task_examples_figures__generation_vae_samples.png"),
      source: "figures/task_examples_figures__generation_vae_samples.png",
      caption: [Training faces (top) and samples from a learned latent-variable model (bottom)],
      width: 100%,
      height: 4.9cm,
    )
  ],
  key-points: [
    #text(size: 0.88em)[
      - $z tilde p(z)$, $quad x | z tilde p_theta (x | z)$
      #uncover("2-")[
        - new objects: sample $z^((s)) tilde p(z)$, decode $x^((s)) tilde p_theta (x | z^((s)))$
        - retaining the distributional structure of the output is itself part of the task
      ]
    ]
  ],
)

#note[
  Especially compelling for high-dimensional structured outputs -- images,
  text, audio, trajectories -- but that is what makes generation *motivating*,
  not what *defines* it. A scalar distribution can be simulated too.
]

#speaker-note[
  Adapted from Murphy Fig. 21.2 (Ch. 21, VAEs), `celeba_vae_ae_comparison.ipynb`.
  Name the substitution out loud: this is a lightweight CPU lecture
  adaptation (Olivetti faces, a small fully-connected VAE, seconds of
  training) standing in for a GPU-trained convolutional VAE on CelebA -- the
  blur is a genuine property of pixel-wise VAE likelihoods, not a rendering
  failure. Lectures 9-10 build VAEs, autoregressive models, flows,
  energy-based models, diffusion, and GANs.
]

== Discovery: what structure explains the data?

#content-block(
  layout: "side-left",
  object-width: 58%,
  object: [
    #course-figure(
      lecture-figure-path("figures/task_examples_figures__discovery_gmm_clusters.svg"),
      source: "figures/task_examples_figures__discovery_gmm_clusters.svg",
      caption: [Unlabeled data and the latent grouping a mixture model infers],
      width: 100%,
      height: 6.6cm,
    )
  ],
  key-points: [
    #text(size: 0.88em)[
      - $z tilde p(z)$, $quad x | z tilde p(x | z)$, then $p(z | x)$
      - Not predicting a supplied label. Not synthesizing new data.
      - Inferring hidden structure that organizes the observations
    ]
  ],
)

#speaker-note[
  Adapted from Murphy Fig. 28.2 (Ch. 28, mixture models), `gmm_2d.ipynb`. This
  should feel the most familiar of the four: it is posterior inference over a
  latent variable, exactly as in Section 1, just with cluster membership in
  place of a coin bias. Lectures 11-12 build latent factor models,
  state-space models, and representation learning.
]

== Generative model, or generation task?

#definition(
  title: [Generative model $eq.not$ generation task],
  label: [Careful],
)[
  Murphy Ch. 28 builds a generative model of $x$ -- a mixture model specifies
  $p(x)$ via a latent $z$. But the *task* Ch. 28 cares about is posterior
  inference of meaningful latent variables (discovery), not generating
  realistic-looking samples.
]

#key-points[A model being "generative" tells you it specifies a distribution over $x$. It does not tell you which task the model is being used for.]

#speaker-note[
  This is the first of two terminology traps this section needs to close.
  Land it clearly before moving to the second: task labels (prediction,
  generation, discovery, action) and model labels (discriminative,
  generative) are different axes.
]

== Careful: model type is not task type

#content-block(
  layout: "top",
  object-width: 88%,
  object: [
    #text(size: 0.9em)[
      #grid(
        columns: (auto, 1fr),
        column-gutter: 1em,
        row-gutter: 0.85em,
        align: (left, left),

        text(weight: "semibold", fill: palette.accent)[Discriminative / conditional model],
        [$p(y | x, theta)$ -- $x$ is conditioned on, never assigned a distribution],

        text(weight: "semibold", fill: palette.accent)[Generative model],
        [$ p(x, y | theta) = p(y | theta) med p(x | y, theta) $],

        [], uncover("2-")[still used for prediction, via Bayes' rule: $p(y | x, theta) prop p(x | y, theta) med p(y | theta)$],
      )
    ]
  ],
  key-points: [
    #uncover("2-")[
      - A generative model can solve a prediction task
      - A conditional model $p(y | x)$ can support the generation task
      - Do not read $p(y|x)$ as "prediction" and $p(x)$ as "generation"
    ]
  ],
)

#speaker-note[
  The second terminology trap. Discriminative/generative describes how the
  model factorizes the joint distribution. Prediction/generation/discovery/
  action describes what question we are asking. The two axes cross freely --
  a classical generative classifier is a standard way to solve a prediction
  task.
]

== How much distribution does prediction need?

#content-block(
  layout: "top",
  object-width: 88%,
  object: [
    #text(size: 0.88em)[
      #grid(
        columns: (auto, 1fr),
        column-gutter: 1em,
        row-gutter: 0.7em,
        align: (left, left),

        text(weight: "semibold", fill: palette.accent)[Prediction],
        [$ a^*(x) = op("argmin")_a bb(E)[L(Y, a) | X=x] $],
        [], text(size: 0.85em)[squared error $arrow.r$ mean, absolute error $arrow.r$ median, 0-1 loss $arrow.r$ mode],

        uncover("2-")[#text(weight: "semibold", fill: palette.accent)[Generation]],
        uncover("2-")[$ Q_theta (dot | x) approx P(dot | x), quad Y^((s)) tilde Q_theta (dot | x) $],
      )
    ]
  ],
  key-points: [
    Prediction asks for whatever functional of $p(y|x)$ a loss requires. Generation asks for enough of the distribution to sample from it.
  ],
)

#note[
  If a predictive system learns the full conditional distribution with a
  proper scoring rule and we then sample from it, the boundary between
  probabilistic forecasting and conditional generation can become thin --
  especially for high-dimensional, structured outputs. Worth stating once,
  not a hard boundary to defend.
]

#speaker-note[
  Keep this modest. The goal is a careful, usable distinction, not a
  philosophical thesis about prediction versus generation.
]

== Action: where should we measure next?

#content-block(
  layout: "side-left",
  object-width: 66%,
  object: [
    #course-figure(
      lecture-figure-path("figures/task_examples_figures__action_active_learning.svg"),
      source: "figures/task_examples_figures__action_active_learning.svg",
      caption: [A GP fit to what has been measured, and the acquisition function it maximizes],
      width: 100%,
      height: 8.8cm,
    )
  ],
  key-points: [
    #text(size: 0.82em)[
      - Measurements are expensive; the model decides where the next one goes
      - $x_"next" = op("argmax")_x alpha(x, D)$
      - with $alpha(x) = sqrt(VV[f(x) | D])$
      #uncover("2-")[
        - Prediction, generation and discovery all *report* something
        - Action *changes what happens next*
      ]
    ]
  ],
)

#speaker-note[
  Reproduces the active-learning half of Murphy Fig. 34.16 (Ch. 34.7),
  `bayes_opt_vs_active_learning.ipynb`; the Bayesian-optimization comparison
  is left out on purpose, and the JAX stack is replaced by a NumPy GP. See
  `task_examples_figures.ipynb`, Family A.

  Walk the figure in order: the black points are the two measurements we
  started with, the red ones are the six the algorithm asked for, and the
  bottom panel is what it was maximizing each time. The dotted line is the
  query it would make next. Note that the six red points are not evenly
  spaced -- they cluster where the function wiggles, because that is where the
  posterior stayed wide. Same Iris active-learning move as two slides back,
  in a completely different domain: there, which flower to label; here, where
  to measure a function.
]

== Beyond acquisition: actions with consequences

#content-block(
  layout: "top",
  object-width: 76%,
  object: [
    #align(center + horizon)[
      #course-diagram(
        spacing: (4.2em, 3em),
        node-stroke: 1.2pt + palette.dark,
        node-fill: palette.paper,
        edge-stroke: 1.2pt + palette.muted,
        mark-scale: 65%,

        graph-node((0, 0.5), name: <b-state>, shape: circle, width: 2.8em, height: 2.8em)[Oil\ state],
        graph-node((1, 0), name: <b-sound>, shape: fletcher.shapes.rect, width: 4.2em, height: 2em)[Sounding],
        graph-node((2, 0.5), name: <b-drill>, shape: fletcher.shapes.rect, width: 4.2em, height: 2em)[Drill?],
        graph-node((3, 0.5), name: <b-utility>, shape: fletcher.shapes.diamond, width: 3.8em, height: 2.8em)[Utility],

        graph-edge(<b-state>, <b-sound>, "-|>", bend: 12deg),
        graph-edge(<b-sound>, <b-drill>, "-|>"),
        graph-edge(<b-drill>, <b-utility>, "-|>"),
        graph-edge(<b-state>, <b-utility>, "-|>", bend: -20deg),
      )
    ]
  ],
  key-points: [
    #twocol[
      - Uncertainty alone told us where to *look*
      - It cannot tell us what a wrong choice *costs*
    ][
      #uncover("2-")[
        - That needs preferences and an action rule
        - $a^* = op("argmax")_a EE[U(a, "state") | "information"]$
      ]
    ]
  ],
)

#note[Murphy covers this in Part VI, from Ch. 34. This course stops at Ch. 33 -- see `Syllabus.md`.]

#speaker-note[
  Murphy's oil-wildcatter example (Ch. 34): sound before drilling, or drill
  blind? This slide earns its place only by contrast with the previous one.
  There, the acquisition function came for free from the posterior -- maximum
  variance, maximum entropy. Here it does not: a dry hole and a missed
  gusher are both errors, and nothing in the probability model says which one
  hurts more. That is the extra ingredient, and it is where the course stops.

  Say the boundary out loud: Murphy keeps going into decision theory,
  bandits, reinforcement learning and causality. We stop at Ch. 33. Action is
  on the map so that the map is honest, not because we will build it.
]

== Summary: What do we use learned models for?

#content-block(
  key-points: [
    - Prediction, generation, discovery and action are different questions asked of a fitted model -- not different kinds of model
    - The four tasks arise in very different domains -- and all four can be asked of one small table of flower measurements
    - A task is fixed by what is observed, what is unknown, and what we want done -- not by the dataset
    - Discriminative / generative describes the model; prediction / generation / discovery / action describes the task
    - Action needs a rule for choosing, and utilities once choices have costs -- outside this course (Murphy Part VI)
    - Lectures 7-12 build prediction, generation, and discovery in turn
  ],
)

#speaker-note[
  Pivot back to careful notation: having motivated why the distinctions
  matter, the next section fast-reactivates the joint/conditional grammar
  that all four tasks are built from.
]

#section-metadata(
  short-title: [Model grammar],
  subtitle: [Observed quantities, unknown quantities, predictions, and factorization],
)

= The grammar of probabilistic models

== Three recurring model objects

#triad[
  *Observed data*\
  $D$, $x$, $y$\
  #text(size: 0.8em)[what we measured]
][
  *Unknown quantities*\
  $theta$, $z$\
  #text(size: 0.8em)[parameters and latent variables]
][
  *Future quantities*\
  $tilde(y)$, $tilde(x)$\
  #text(size: 0.8em)[what we want to predict or generate]
]

#key-points[Most confusion in probabilistic ML is confusion about which object a distribution is over.]

== Factorisation is where assumptions live

The same joint distribution can be written as products of simpler terms.

#align(center)[$
  p(D, theta) = p(D | theta) p(theta)
$]

#align(center)[$
  p(x, z) = p(x | z) p(z)
$]

#align(center)[$
  p(y, x, theta) = p(y | x, theta) p(x) p(theta)
$]

#key-points[Model structure is not decoration; it is the set of independence and generative assumptions.]

== Do not mix up these distributions

#table(
  columns: (auto, 1fr, 1fr),
  inset: 8pt,
  [*Expression*], [*Distribution over*], [*Role*],
  [$p(y | theta)$], [data $y$], [sampling / observation model],
  [$p(D | theta)$], [viewed as a function of $theta$], [likelihood],
  [$p(theta)$], [parameter $theta$], [prior],
  [$p(theta | D)$], [parameter $theta$], [posterior],
  [$p(tilde(y) | D)$], [future data], [posterior predictive],
)

#note[*Common trap:* A likelihood is not a probability distribution over $theta$ until it is multiplied by a prior and normalized.]

#section-metadata(
  short-title: [Probability & Bayes],
  subtitle: [Only the probability machinery we will use repeatedly],
)

= Fast reactivation: probability and Bayes

== Probability calculus in one slide

#twocol[
  *Rules we use constantly*
  - product rule
  - sum / marginalisation rule
  - conditioning
  - Bayes' rule
][
  #align(center)[$ p(a,b)=p(a|b)p(b) $]
  #align(center)[$ p(a)=sum_b p(a,b) $]
  #align(center)[$ p(a|b)=frac(p(a,b), p(b)) $]
]

#key-points[Nearly every derivation in the course is product-rule plus sum-rule plus normalization.]

== Transforming variables: the equation we will need

If $y = g(x)$ is invertible, probability mass is preserved but density changes:

#align(center)[$
  p_y(y) = p_x(g^(-1)(y)) abs(frac(d g^(-1)(y), d y))
$]

In multiple dimensions:

#align(center)[$
  p_y(bold(y)) = p_x(g^(-1)(bold(y))) abs(det frac(partial g^(-1)(bold(y)), partial bold(y)))
$]

#key-points[Changing coordinates changes densities through the Jacobian. This is the root of reparameterization tricks and normalizing flows.]

== Bayes' rule as workflow

#align(center)[$
  p(theta | D) = frac(p(D | theta) p(theta), p(D))
$]

#align(center)[$
  p(D) = integral p(D | theta) p(theta) d theta
$]

#triad[
  prior\
  #text(size: 0.8em)[what values were plausible?]
][
  likelihood\
  #text(size: 0.8em)[which values explain the data?]
][
  posterior\
  #text(size: 0.8em)[what remains plausible?]
]

== Posterior prediction is the payoff

#align(center)[$
  p(tilde(y) | D) = integral p(tilde(y) | theta) p(theta | D) d theta
$]

#key-points[Prediction averages over uncertainty. It is not just plugging in one best parameter.]

#note[This is the bridge from Bayesian statistics to machine learning: learn from data, then predict, generate, or infer hidden structure.]

== Model checking: compare data to replicated data

A fitted model implies new datasets:

#align(center)[$
  p(tilde(D) | D) = integral p(tilde(D) | theta) p(theta | D) d theta
$]

Choose a statistic or visual summary $T( dot )$ and compare:

#align(center)[$
  T(D) quad "vs." quad T(tilde(D))
$]

#key-points[Model comparison asks which model is better. Model checking asks whether the model is good enough to trust.]

== Point estimates are not the model

#twocol[
  *Point summaries*
  - MLE
  - MAP
  - posterior mean
  - posterior median
][
  *Full inferential object*
  #align(center)[$ p(theta | D) $]
  #align(center)[$ p(tilde(y) | D) $]
]

#key-points[We will often optimize point objectives, but the probabilistic target is still a distribution.]

#section-metadata(
  short-title: [Coin model],
  subtitle: [The full probabilistic workflow in one deliberately simple model],
)

= Anchor example: the coin model, compressed

== Coin model: data and parameter

Let $y_n in {0,1}$, where 1 means heads.

#align(center)[$
  y_n | theta tilde "Ber"(theta)
$]

#align(center)[$
  D = {y_1, dots, y_N}, quad theta = P(y_n = 1)
$]

#key-points[$D$ is observed. $theta$ is unknown. The model connects them.]

== Likelihood: from observations to counts

Assuming conditionally independent trials:

#align(center)[$
  p(D | theta) = product_(n=1)^N theta^(y_n) (1-theta)^(1-y_n)
$]

Let $N_1=sum_n y_n$ and $N_0=N-N_1$.

#align(center)[$
  p(D | theta) prop theta^(N_1) (1-theta)^(N_0)
$]

#key-points[The sequence has been compressed to sufficient statistics for this model.]

== Beta prior and Beta posterior

#align(center)[$
  theta tilde "Beta"(alpha, beta)
$]

#align(center)[$
  p(theta) prop theta^(alpha-1) (1-theta)^(beta-1)
$]

Combine prior and likelihood:

#align(center)[$
  theta | D tilde "Beta"(alpha + N_1, beta + N_0)
$]

#key-points[Conjugacy here is closure under updating: posterior has the same family as the prior.]

== Predicting the next toss

#align(center)[$
  P(tilde(y)=1 | D) = integral theta p(theta | D) d theta
$]

#align(center)[$
  P(tilde(y)=1 | D) = frac(alpha + N_1, alpha + beta + N)
$]

#key-points[The predictive probability is the posterior mean of the coin bias, not necessarily the MLE.]

== Why keep this elementary example?

The coin model contains the whole course in miniature:

#triad[
  *model*\
  $ p(D | theta) p(theta) $
][
  *inference*\
  $ p(theta | D) $
][
  *prediction*\
  $ p(tilde(y) | D) $
]

#note[Later models change the variables and the algorithms, not the basic grammar.]

#section-metadata(
  short-title: [Exponential families],
  subtitle: [A common algebraic skeleton behind many probabilistic models],
)

= Exponential families: the reusable structure

== The common form

Many distributions we use can be written as:

#align(center)[$
  p(x | eta) = h(x) exp(eta^T T(x) - A(eta))
$]

#table(
  columns: (auto, 1fr),
  inset: 8pt,
  [$T(x)$], [sufficient statistics: what the data contributes],
  [$eta$], [natural parameters: the coordinates in which updates often simplify],
  [$A(eta)$], [log-partition function: the normalization term],
  [$h(x)$], [base measure: what is left over],
)

#key-points[The exponential family explains why many apparently different models have the same algebraic skeleton.]

== Bernoulli as an exponential-family model

Start with:

#align(center)[$
  p(y | theta) = theta^y (1-theta)^(1-y)
$]

Rewrite:

#align(center)[$
  p(y | eta) = exp(y eta - log(1 + exp(eta)))
$]

where:

#align(center)[$
  eta = log frac(theta, 1-theta), quad T(y)=y, quad A(eta)=log(1+exp(eta))
$]

#key-points[The log-odds is the natural parameter of the Bernoulli. This is why logistic models are so central.]

== Data enter through sufficient statistics

For independent observations:

#align(center)[$
  p(D | eta) = product_n h(y_n) exp(eta^T T(y_n) - A(eta))
$]

#align(center)[$
  p(D | eta) prop exp(eta^T sum_n T(y_n) - N A(eta))
$]

#key-points[The full dataset often enters the likelihood through $sum_n T(y_n)$. That is the deeper version of "heads and tails are enough" in the coin model.]

== Why the log-partition function matters

The normalization term is not bookkeeping. Its derivatives encode moments:

#align(center)[$
  bb(E)_eta [T(X)] = nabla_eta A(eta)
$]

#align(center)[$
  "Cov"_eta(T(X)) = nabla_eta^2 A(eta)
$]

#key-points[The same object that normalizes the distribution also gives means, variances, and local curvature. This is the bridge to Fisher information and optimization geometry.]

== Why this matters for probabilistic ML

Exponential-family structure reappears in:

#twocol[
  - generalized linear models
  - conjugate priors
  - variational inference
  - message passing
][
  - natural-gradient ideas
  - Fisher information
  - Gaussian approximations
  - maximum-entropy models
]

#note[The point is not to memorize the taxonomy. The point is to recognize when a model has algebra we can exploit.]

#section-metadata(
  short-title: [Multivariate Gaussian],
  subtitle: [Dependence, geometry, conditioning, and high-dimensional probability],
)

= From scalar uncertainty to multivariate structure

== Why the multivariate Gaussian matters

Many later models reduce locally, approximately, or exactly to Gaussian algebra:

#twocol[
  - Gaussian processes
  - Kalman filters
  - Laplace approximations
  - variational approximations
][
  - Bayesian linear models
  - factor models
  - state-space models
  - neural-network uncertainty approximations
]

#key-points[The multivariate Gaussian is not just another distribution; it is a computational workhorse.]

== Multivariate Gaussian: object and geometry

#align(center)[$
  bold(x) tilde cal(N)(bold(mu), Sigma)
$]

#align(center)[$
  p(bold(x)) prop |Sigma|^(-1/2)
  exp(-frac(1, 2)(bold(x)-bold(mu))^T Sigma^(-1)(bold(x)-bold(mu)))
$]

#key-points[$bold(mu)$ locates the cloud; $Sigma$ sets its size, orientation, and dependence structure.]

== Covariance is geometry

#twocol[
  *Diagonal covariance*
  #align(center)[$ Sigma = "diag"(sigma_1^2, dots, sigma_D^2) $]
  #text(size: 0.8em)[axis-aligned uncertainty]
][
  *Full covariance*
  #align(center)[$ Sigma_(i j) = "Cov"(X_i, X_j) $]
  #text(size: 0.8em)[tilted / coupled uncertainty]
]

#key-points[Correlations are geometric constraints on plausible joint variation.]

== Typical sets: high-dimensional Gaussians are not near the mode

For $bold(x) ~ cal(N)(bold(0), I_D)$:

#align(center)[$
  R^2 = norm(bold(x))^2 = sum_(i=1)^D x_i^2 tilde chi^2_D
$]

#align(center)[$
  bb(E)[R^2] = D, quad "Var"(R^2) = 2D, quad frac("sd"(R^2), bb(E)[R^2]) = sqrt(frac(2, D)) arrow.r 0
$]

#key-points[In high dimensions, most probability mass is in a thin shell. The mode can be a terrible guide to typical samples.]

#speaker-note[
  They have seen the idea of typical sets before; this slide supplies the Murphy-style quantification. Emphasize that density and probability mass diverge in high dimension because volume matters.
]

== Marginalization: ignore variables properly

Partition:

#align(center)[$
  bold(x) = mat(bold(x)_1; bold(x)_2), quad
  Sigma = mat(Sigma_11, Sigma_12; Sigma_21, Sigma_22)
$]

For a joint Gaussian:

#align(center)[$
  p(bold(x)_1) = cal(N)(bold(x)_1 | bold(mu)_1, Sigma_11)
$]

#key-points[Gaussian marginalization is easy in moment form: keep the relevant block.]

== Conditioning: use observations to update expectations

#align(center)[$
  p(bold(x)_1 | bold(x)_2) = cal(N)(bold(x)_1 | bold(mu)_(1|2), Sigma_(1|2))
$]

#align(center)[$
  bold(mu)_(1|2) = bold(mu)_1 + Sigma_12 Sigma_22^(-1) (bold(x)_2 - bold(mu)_2)
$]

#align(center)[$
  Sigma_(1|2) = Sigma_11 - Sigma_12 Sigma_22^(-1) Sigma_21
$]

#key-points[Conditioning shifts the mean and removes uncertainty explained by the observed variables.]

== Precision form: why inverse covariance appears everywhere

Define:

#align(center)[$
  Lambda = Sigma^(-1), quad eta = Sigma^(-1) bold(mu)
$]

Then the Gaussian can be written as:

#align(center)[$
  p(bold(x)) prop exp(eta^T bold(x) - frac(1, 2) bold(x)^T Lambda bold(x))
$]

#key-points[Precision form makes many updates additive and connects naturally to exponential-family notation.]

#section-metadata(
  short-title: [Comparing distributions],
  subtitle: [Why divergences become training and approximation objectives],
)

= Comparing distributions: the ML pressure point

== Divergences: when the object being compared is a distribution

A divergence measures mismatch between distributions, not merely between point estimates.

#align(center)[$
  D_"KL"(q || p) = bb(E)_(q(x)) [log frac(q(x), p(x))]
$]

#twocol[
  *Statistics framing*\
  estimate parameters, quantify uncertainty, check model adequacy
][
  *ML framing*\
  learn predictive distributions, compare approximations, optimize scalable objectives
]

#key-points[When the target is a predictive or posterior distribution, training and evaluation naturally become distribution-comparison problems.]

== Two places divergences will appear

#twocol[
  *Prediction*\
  fit $p_theta(y|x)$ so the predictive distribution assigns high probability to held-out data.

  #align(center)[$ - log p_theta(y | x) $]
][
  *Approximate inference*\
  choose an approximation $q(theta)$ close to the posterior $p(theta | D)$.

  #align(center)[$ D_"KL"(q(theta) || p(theta | D)) $]
]

#note[We will not catalogue divergences today. We will use this idea when we reach information theory and variational inference.]

#section-metadata(
  short-title: [Looking forward],
  subtitle: [Latent variables, computational inference, and the bridge to Lecture 2],
)

= Looking forward: probability as ML infrastructure

== Latent variables change the target

#align(center)[$
  p(z, x) = p(z) p(x | z)
$]

After observing $x$:

#align(center)[$
  p(z | x) = frac(p(x | z) p(z), p(x))
$]

#note[This is the logic behind mixture models, factor models, VAEs, state-space models, and representation learning.]

== Why inference algorithms dominate the course

Often the quantity we want is easy to write and hard to compute:

#align(center)[$
  p(theta, z | D) = frac(p(D, theta, z), integral sum_z p(D, theta, z) d theta)
$]

#key-points[The model gives the target distribution; inference algorithms are how we approximate it.]

== Notebook bridge for today

The first notebook should do five things:

1. Recreate the beta-binomial update.
2. Plot prior, likelihood, posterior, and posterior predictive samples.
3. Show how posterior samples approximate integrals.
4. Quantify the typical-set effect for a high-dimensional Gaussian.
5. Introduce a small multivariate Gaussian conditioning example.

#note[*Diagnostic checkpoint:* This tells us whether Lecture 2 can assume notation fluency or needs more scaffolding.]

== Diagnostic questions before next time

Students should be able to answer:

- Is this expression over data, parameters, latent variables, or predictions?
- Which factorization assumptions are being made?
- What is being conditioned on?
- What integral, sum, or Jacobian term is hard?
- What approximation might be needed?
- How would we check whether replicated data look like observed data?

#key-points[These questions will work for almost every model in the course.]

== Summary

- We are building on a Bayesian-first undergraduate course, not repeating it.
- Bayes' rule is now a modeling grammar for ML tasks.
- Posterior predictive inference is the bridge to prediction.
- Multivariate Gaussian algebra is a central tool for dependence and conditioning.
- The next step is graphical structure and information-theoretic objectives.

#align(center)[[Next: graphical models]]

#section-metadata(
  short-title: [Reserve],
  subtitle: [Material to use only if the room needs additional reactivation],
)

= Reserve / expansion slides

== Reserve: probability space

#align(center)[$
  (Omega, cal(F), P), quad P: cal(F) -> [0,1]
$]

#triad[
  *$Omega$*\
  sample space
][
  *$cal(F)$*\
  event space
][
  *$P$*\
  probability measure
]

#key-points[Useful only if students are shaky on the mathematical foundation.]

== Reserve: random variables and densities

#twocol[
  *Discrete*\
  #align(center)[$ p_X(a) = P(X = a) $]
][
  *Continuous*\
  #align(center)[$ P(a <= X <= b) = integral_a^b p_X(x) d x $]
]

#note[*Common trap:* A density value is not a probability.]

== Reserve: common scalar distributions

#table(
  columns: (auto, 1fr),
  inset: 8pt,
  [*Distribution*], [*When it appears*],
  [Bernoulli], [one binary outcome],
  [Binomial], [count of successes],
  [Categorical], [one class among $K$],
  [Multinomial], [count vector across classes],
  [Poisson], [counts per unit exposure],
  [Gaussian], [continuous measurement/noise/approximation],
)

== Reserve: credible intervals

#align(center)[$
  P(a <= theta <= b | D) = 0.95
$]

#twocol[
  *Central interval*\
  equal tail probability
][
  *HDI*\
  shortest high-density region
]

#key-points[The probability statement is about $theta$ conditional on the observed data and the model.]

== Reserve: Dirichlet-multinomial

#align(center)[$
  bold(theta) tilde "Dir"(bold(alpha))
$]

#align(center)[$
  bold(theta) | D tilde "Dir"(bold(alpha) + bold(N))
$]

#key-points[This is the categorical/multinomial analogue of beta-binomial updating.]

== Reserve: Gaussian conjugacy in one line

Known variance, unknown mean:

#align(center)[$
  y_n | mu tilde cal(N)(mu, sigma^2), quad mu tilde cal(N)(m_0, v_0)
$]

#align(center)[$
  mu | D tilde cal(N)(m_N, v_N)
$]

#key-points[Precision form makes the posterior update look like adding evidence.]

== Reserve: Markov property

#align(center)[$
  p(x_(1:T)) = p(x_1) product_(t=2)^T p(x_t | x_(t-1))
$]

#key-points[A Markov chain is a structured joint distribution over a sequence.]

== Reserve: transition matrix propagation

#align(center)[$
  pi_(t+1) = pi_t A, quad pi_(t+n) = pi_t A^n
$]

#align(center)[$
  pi = pi A
$]

#key-points[Stationarity is a fixed point of repeated probabilistic transition.]

== Revision notes

- Basic probability is now reserve material, not the live spine.
- The live spine is: model grammar $arrow.r$ Bayes/prediction $arrow.r$ multivariate Gaussian $arrow.r$ ML tasks.
- Add notebook-generated plots after choosing the first coding example.
- Consider moving precision-form slide to reserve if the class looks rusty.
- Keep Markov chains for Lecture 2 unless needed as a sequence-model teaser.
