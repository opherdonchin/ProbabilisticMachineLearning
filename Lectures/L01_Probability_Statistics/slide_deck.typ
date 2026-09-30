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

// `twocol` and `triad` are shared course components (see course.typ); import
// them via `*` above rather than redefining them per lecture.

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
  subtitle: [Probabilistic models update based on data],
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
      - How could observed data ($y$) have been generated.
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
  Close by naming the shared probabilistic vocabulary: models, graphs, Bayes'
  rule, conjugacy, and posterior uncertainty all describe how data inform
  unknown quantities.
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


== Machine learning defined

#content-block(
  layout: "top",
  object-width: 100%,
  object: [
#grid(
  columns: (0.6fr, 1.8fr),
  gutter: 1.5em,
  align: top,
  [
    #course-figure(
      lecture-figure-path("figures/mitchell_1997__machine_learning_cover.jpg"),
      source: "Tom M. Mitchell, Machine Learning (1997), cover",
      width: 100%,
      height: 7.7cm,
    )
  ],
  [
    #stack(
      spacing: 0.85em,
      align(left + top)[
      #text(size: 0.85em)[
        A computer program is said to *learn* from experience $E$ with respect
        to some class of tasks $T$ and performance measure $P$, if its
        performance at tasks in $T$, as measured by $P$, improves with
        experience $E$.
      ],      
      ],
      grid(
        columns: (1fr, 1fr, 1fr),
        gutter: 1em,
        align: center + horizon,
        [
          #uncover("2-")[
            *Training*
            #v(0.05em)
              #text(size: 0.7em)[$ f_T: "E" quad arrow.r quad f_A $]
              #text(size: 0.9em)[$E$: Experience]
          ]
        ],
        [
          #uncover("3-")[
            *Task*
              #v(0.05em)
              #text(size: 0.7em)[$ f_A: "In" quad arrow.r quad "Out" $]
              #text(size: 0.9em)[$f_A$: Task function]
          ]
        ],
        [
          #uncover("4-")[
            *Evaluation*
              #v(0.05em)
              #text(size: 0.7em)[$ f_P: ("In", "Out") quad arrow.r quad "P" $]
              #text(size: 0.9em)[$P$: Performance]
          ]
        ],
      ),
    )
  ],
)

  ],
  key-points: [
  #uncover("5-")[
    - Machine learning is a mapping from $(E, f_P) arrow.r f_T arrow.r f_A$
      - That maximizes $f_A$ performance according to $P$]  ],
)


#speaker-note[
  This is Mitchell's classic definition of machine learning from *Machine
  Learning* (McGraw-Hill, 1997). The cover anchors the definition in the book;
  the compact flow separates the three roles. Experience E is the data or
  interaction used by a learning procedure A. Its product is a function. Task
  T specifies what that function must do, and performance measure P says what
  counts as improvement. A canonical pairing is supervised experience used to
  learn a predictor.
]

== Supervised experience supports prediction

#content-block(
  layout: "top",
  object-width: 94%,
  object: [
    #grid(
      columns: (1fr, 1fr),
      gutter: 2.2em,
      align: center + horizon,
      [
        #align(center)[
          *Experience: paired examples*
          #v(0.35em)
          #text(size: 0.7em)[$ f_T: "E" quad arrow.r quad f_A $]
          $ f_T: D = {(x_i, y_i)}_(i=1)^N quad arrow.r quad f_D $
          #v(0.28em)
          #text(size: 0.72em, fill: palette.muted)[paired examples $arrow.r$ learned predictor]
        ]
      ],
      [
        #align(center)[
          *Task: prediction*
          #v(0.35em)
          #text(size: 0.7em)[$ f_A: "In" quad arrow.r quad "Out" $]
          $ f_D: x_* quad arrow.r quad hat(y)_* $
          #v(0.28em)
          #text(size: 0.72em, fill: palette.muted)[new input $arrow.r$ predicted output]
        ]
      ],
    )
  ],
  key-points: [
    #uncover("2-")[
      - Experience is a training set $D = {(x_n, y_n)}$
          - $x$: called feature, covariate, or predictor
          - $y$: called label, target, or response
      - Task is to produce a predictor $f_D$ that maps new $x_*$ to correct $y_*$
      - Performance is measured by a loss, introduced shortly
    ]
  ],
)

#speaker-note[
  This follows the notation in Murphy, Book 1, Section 1.2. A learner is
  described by the task T, the experience E, and the performance measure P.
  Supervised experience is the canonical training regime for prediction, but
  it is not identical to prediction. Here the deployed function maps a new
  input to an output, while the learning algorithm maps paired examples to that
  predictor. A loss says how well the predictor performs. Classification makes
  this pairing concrete.
]

== Classification: Iris flowers

#content-block(
  layout: "top",
  object-width: 92%,
  object: [
    #stack(
      spacing: 0.35em,
      grid(
        columns: (1.35fr, 1fr),
        gutter: 1.1em,
        align: center + horizon,
        [
          #grid(
            columns: (1fr, 1fr, 1fr),
            gutter: 0.3em,
            [#align(center)[
              #stack(spacing: 0.12em,
                image("figures/book1_fig1_1a_setosa.png", width: 100%, height: 3cm, fit: "contain"),
                text(size: 0.45em, fill: palette.muted)[Setosa],
              )
            ]],
            [#align(center)[
              #stack(spacing: 0.12em,
                image("figures/book1_fig1_1b_versicolor.png", width: 100%, height: 3cm, fit: "contain"),
                text(size: 0.45em, fill: palette.muted)[Versicolor],
              )
            ]],
            [#align(center)[
              #stack(spacing: 0.12em,
                image("figures/book1_fig1_1c_virginica.png", width: 100%, height: 3cm, fit: "contain"),
                text(size: 0.45em, fill: palette.muted)[Virginica],
              )
            ]],
          )
        ],
        [#align(center)[
          #text(size: 0.45em, weight: "semibold")[
            Table 1.1: subset of the Iris design matrix
          ]
          #v(0.28em)
          #text(size: 0.45em)[
            #table(
              columns: (auto, auto, auto, auto, auto, auto),
              align: center + horizon,
              inset: (x: 3.5pt, y: 3pt),
              table.header(
                [*index*], [*sl*], [*sw*], [*pl*], [*pw*], [*label*],
              ),
              [0], [5.1], [3.5], [1.4], [0.2], [Setosa],
              [1], [4.9], [3.0], [1.4], [0.2], [Setosa],
              [dots], [dots], [dots], [dots], [dots], [dots],
              [50], [7.0], [3.2], [4.7], [1.4], [Versicolor],
              [dots], [dots], [dots], [dots], [dots], [dots],
              [149], [5.9], [3.0], [5.1], [1.8], [Virginica],
            )
          ]
          #v(0.24em)
          #text(size: 0.45em, fill: palette.muted)[
            sl: sepal length; sw: sepal width; pl: petal length; pw: petal width
          ]
        ]],
      ),
      figure-source("Murphy (2025), Book 1, Fig. 1.1 and Table 1.1"),
    )
  ],
  key-points: [
    - Classification:   $y in {1, dots, C}$ 
      - The classes are unordered and mutually exclusive
    #uncover("2-")[
      - For the Iris dataset
        - $y in {"Setosa", "Versicolor", "Virginica"}$
        - $x in RR^4$
    ]
  ],
)

#speaker-note[
  Murphy begins the classification example with three Iris subspecies, shown
  in Figure 1.1. Table 1.1 makes the training-set representation concrete:
  each row gives four numeric measurements and the known species label. The
  flower photographs are reproduced from Murphy, Book 1 (online version,
  April 18, 2025); Figure 1.1 credits Dennis Kramb and SIGNA. The table is
  recreated from Table 1.1. See `figures/book1_section12_sources.md`.
]

== Exploratory data analysis

#content-block(
  layout: "side-left",
  object-width: 50%,
  object: [
    #course-figure(
      lecture-figure-path("figures/book1_fig1_3_iris_pairplot.png"),
      source: "Murphy (2025), Book 1, Fig. 1.3; generated by iris_plot.ipynb",
      width: 100%,
      height: 9cm,
    )
  ],
  key-points: [
    #text(size: 0.85em)[
    - Training set 
      - 150 labeled examples
      - 50 in each class
    #uncover("2-")[
      - Pair plots shows every pair of features
        - Diagonal shows marginal distributions
    ]
    #uncover("3-")[
      - Always inspect data before modeling
        - Structure
        - Outliers
        - Missing values
    ]
    ]
  ],
)

#speaker-note[
  This is Figure 1.3 from Murphy, Book 1. It shows why Iris is a useful first
  classification example: some feature pairs visibly separate Setosa from the
  other classes, while Versicolor and Virginica overlap more. At this point we
  only inspect the data. We deliberately omit Section 1.2.1.3 and its decision
  tree, Figure 1.4, as requested. The source notebook is linked by the book as
  `iris_plot.ipynb`; see `figures/book1_section12_sources.md`.
]

== Performance: empirical risk minimization

#content-block(
  layout: "top",
  object-width: 94%,
  object: [
    #align(center)[
      $ L(x,y ; theta) = ell(y, f(x; theta)) $
      #uncover("2-")[
        $ L(theta) = 1/N sum_(n=1)^N L(x_n, y_n ; theta) $
      ]
      #uncover("3-")[
        $ hat(theta) = arg min_theta L(theta) $
      ]
      #uncover("4-")[
        #v(0.55em)
        #note[
          #text(size: 0.72em)[
            Given samples $D = {x^(1), dots, x^(N)}$ from $p(X)$, where $X in RR$,
            the empirical distribution is
            $hat(p)_N(x) = 1/N sum_(n=1)^N delta_(x^(n))(x)$.
          ]
        ]
      ]
    ]
  ],
  key-points: [
    - The loss function: the cost of predicting $f(x; theta)$ when the true label is $y$
    #uncover("2-")[
      - The empirical risk: loss evaluated on the training set
    ]
    #uncover("3-")[
      - Empirical risk minimization: minimizing the empirical loss
    ]
  ],
)

#speaker-note[
  This is Murphy's Equation 1.6. The learning algorithm A introduced earlier
  can be understood here as the procedure that solves, or approximates the
  solution to, this optimization problem. The loss operationalizes the
  performance measure P on training data. We have still not claimed that this
  predictor will work on future cases. The distribution implicit in the average
  is an equal-weight mixture of point masses at the
  observed values of a random variable.
]


== A loss function

#content-block(
  layout: "top",
  object-width: 78%,
  object: [
    #align(center)[
      $ L(x,y ; theta) = ell(y, f(x; theta)) $
      $ ell(y, f(x; theta)) = ell_"01" (y, hat(y)) = II(y != hat(y)) $
      #uncover("2-")[
        #v(0.65em)
        $ II(e) = cases(
          1 "if " e " is true",
          0 "if " e " is false",
        ) $
      ]
    ]
  ],
  key-points: [
    - A loss function assigns a cost to a prediction when the true label is known
    #uncover("2-")[
      - The zero-one loss is one for a misclassification and zero for a correct classification
      - $II(e)$ is an indicator function: it evaluates whether condition $e$ holds
    ]
  ],
)

#speaker-note[
  This follows Murphy's zero-one loss in Equation 1.5. The loss compares the
  true label y with a proposed class decision hat(y). It charges one for any
  mismatch and zero for a match, so averaging this loss over examples gives a
  misclassification rate.

  On the second reveal, define the indicator function carefully. It is not an
  unknown probability: it is a deterministic function of a true-or-false
  condition. In the expression above, the condition is that the prediction is
  different from the observed label. More general loss functions can assign
  different costs to different kinds of mistakes.
]

== A probabilistic perspective

#content-block(
  layout: "top",
  object-width: 90%,
  object: [
    #align(center)[
      $ p(x | y = c, theta) $
      #uncover("2-")[
        #v(0.65em)
        $ p(y = c | x, theta) prop p(x | y = c, theta) p(y = c) $
      ]
      #uncover("3-")[
        #v(0.65em)
        $ hat(y) = arg max_(c in cal(Y)) p(y = c | x; theta) $
      ]
    ]
  ],
  key-points: [
    - The exploratory data analysis suggests:
      - Features in each class have similar distributions
      - Different classes have different distributions
    #uncover("2-")[
      - Bayes' rule converts those ingredients to posterior class probabilities
    ]
    #uncover("3-")[
      - A possible classifier: choose the class with maximum a posteriori probability
    ]
  ],
)

#speaker-note[
  Connect this to the Iris pair plot: within each class, the features appear
  to have a characteristic distribution, and those distributions differ
  across classes. A generative classifier makes that intuition explicit by
  modeling the class-conditional likelihood p(x given y=c, theta): how inputs
  tend to look if the flower belongs to class c.

  On the second reveal, Bayes' rule combines that likelihood with the class
  prior p(y=c). The proportionality sign omits the normalizing constant, which
  is the same for every candidate class c. The result is a posterior class
  probability p(y=c given x, theta).

  On the final reveal, choose the class with largest posterior probability.
  This is the MAP class decision and is optimal under zero-one loss. Emphasize
  that this is inference about a class label with parameters theta held fixed,
  not yet Bayesian inference about uncertainty in theta. Present it as one
  generative route to a predictive classifier, not as the only form a
  probabilistic predictor can take.
]


== Task, experience, and performance

#content-block(
  layout: "top",
  object-width: 96%,
  object: [
    #grid(
      columns: (1fr, 1fr, 1fr),
      gutter: 1.5em,
      align: center + horizon,
      [#align(center)[
        #text(size: 0.72em, weight: "semibold", fill: palette.accent)[Task]
        #v(0.18em)
        #text(size: 0.48em, fill: palette.muted)[What must the learned system do?]
        #v(0.34em)
        $ x in RR^4 arrow.r hat(y) in cal(Y) $
        #v(0.12em)
        #text(size: 0.48em, fill: palette.muted)[four measurements $arrow.r$ species]
      ]],
      [#uncover("2-")[
        #align(center)[
          #text(size: 0.72em, weight: "semibold", fill: palette.accent)[Experience]
          #v(0.18em)
          #text(size: 0.48em, fill: palette.muted)[What data, feedback, or interaction is available?]
          #v(0.34em)
          $ D = {(x_n, y_n)}_(n=1)^N $
          #v(0.12em)
          #text(size: 0.48em, fill: palette.muted)[150 labeled flowers]
        ]
      ]],
      [#uncover("3-")[
        #align(center)[
          #text(size: 0.72em, weight: "semibold", fill: palette.accent)[Performance]
          #v(0.18em)
          #text(size: 0.48em, fill: palette.muted)[How is success evaluated?]
          #v(0.34em)
          $ L(theta) = 1/N sum_(n=1)^N II(y_n eq.not f(x_n; theta)) $
          #v(0.12em)
          #text(size: 0.48em, fill: palette.muted)[zero-one loss / misclassification rate]
        ]
      ]],
    )
  ],
  key-points: [
    - *Task:* predict the Iris species from four sepal and petal measurements
    #uncover("2-")[
      - *Experience:* 150 labeled flowers, with 50 examples from each species
    ]
    #uncover("3-")[
      - *Performance:* mean zero-one loss, the training misclassification rate
    ]
  ],
)

#speaker-note[
  This is Mitchell's framework and the conceptual hinge for the rest of the
  machine-learning discussion. Task is what the learned system must do.
  Experience is what data, feedback, or interaction the learner receives.
  Performance is how success is evaluated.

  For Iris, the task is species prediction from four measurements, the
  experience is 150 labeled flowers, and performance is mean zero-one loss.
  Stress that these are separate axes. The same prediction task can be trained
  from different experience regimes, and the same experience regime can
  support different tasks. Low training loss also does not yet show that the
  predictor will work on future flowers.
]

== Summary: From statistics to machine learning

#content-block(
  key-points: [
    - Statistics and computer science
      - Statistics focused on the values of unknown parameters
      - Computer science develops functions that map inputs to outputs
    #uncover("2-")[
    - Machine learning is a branch of computer science
      - Where the function is learned from experience
    ]
    #uncover("3-")[
    - A learning problem is defined by three ingredients: task, experience, and performance
      - One canonical pairing uses supervised experience $D = {(x_n, y_n)}$ for prediction
      - The experience regime and the task are related, but they are not the same taxonomy
    ]
  ],
)

#speaker-note[
  This summary closes the conceptual change in emphasis. Statistics contributed
  unknown parameters; computer science contributed input-output functions; and
  machine learning learns those functions from experience and evaluates their
  performance. Iris made the three ingredients concrete: a predictor maps four
  measurements to a species, labeled examples provide experience, and zero-one
  loss measures classification errors.

  Supervised learning is one canonical pairing of experience and task, not a
  definition of every learned probabilistic system. The section ends with the
  distinction between the learning rule, the information available to it, and
  the criterion used to judge it.
]

#section-metadata(
  short-title: [ML taxonomies],
  subtitle: [Experience regimes, task classes, and performance criteria],
)

= Classes of machine learning problems

// Lecture 1 continuation after the machine-learning task taxonomy.
// Slide bodies use equations, figures, and schematics; teaching prose stays in speaker notes.

// `schema-node`, `schema-arrow`, and `source-note` are shared course
// components (see course.typ); they are imported via `*` above.

== Experience taxonomy

#content-block(
  layout: "top",
  object-width: 94%,
  object: [
    #text(size: 0.85em)[
      #grid(
        columns: (1fr, 1fr),
        column-gutter: 0.8em,
        row-gutter: 0.7em,
        align: center + horizon,
        schema-node([Supervised], [$D = {(x_n, y_n)}$]),
        uncover("2-")[
          #schema-node([Unsupervised], [$D = {x_n}$])
        ],
        uncover("3-")[
          #schema-node([Self-supervised], [$D = {x_n, f(x_n)} "or" {f(x_n), x_n}$])
        ],
        uncover("4-")[
          #schema-node([Reinforcement / interaction], [
            #stack(
              spacing: 0.3em,
              [$"decision": x(t) arrow.r a(t)$],
              [$"action": (x(t), a(t)) arrow.r x(t+1)$],
              [$"reward": x(t+1) arrow.r r(t+1)$],
            )
          ])
        ],
      )
      #source-note[]
    ]
  ],
  key-points: [#text(size: 0.75em)[
    Experience describes what the learner gets to observe  ]
  ],
)

#speaker-note[
  These familiar Book 1 categories are primarily experience regimes. They
  describe what the learner gets to observe: paired inputs and targets,
  unlabeled observations, targets constructed from the observations, or a
  stream of states, actions, rewards, and consequences. They do not by
  themselves say what the learned system is ultimately for.
]

== Task taxonomy

#content-block(
  layout: "top",
  object-width: 94%,
  object: [
    // Every node in this grid states a Task/Performance pair; route them all
    // through one wrapper so they stay visually consistent.
    #let taxonomy-node(label, ..body) = schema-node(label, stack(spacing: 0.7em, ..body), density: "prose")
    #grid(
      columns: (1fr, 1fr),
      column-gutter: 0.8em,
      row-gutter: 0.7em,
      align: center + horizon,

      taxonomy-node(
        [Prediction],
        [Task: ${(x_n, y_n)} arrow.r hat(y) = f_D (x_*)$],
        [Performance: $f_P ( y_*, hat(y) )$],
      ),

      uncover("2-")[
        #taxonomy-node(
          [Generation],
          [Task: ${x_n} arrow.r ({c}, p_D (x | c)) arrow.r x_* ~ p_D (x | c)$],
          [Performance: $f_P ( p (x | c), x_* )$],
        )
      ],

      uncover("3-")[
        #taxonomy-node(
          [Discovery],
          [Task: ${x_n} arrow.r ( {z}, f_D (x) ) arrow.r hat(z) = f_D (x_*)$],
          [Performance: $f_P (hat(z), x_*)$],
        )
      ],

      uncover("4-")[
        #taxonomy-node(
          [Action],
          [Task: $D arrow.r a_* ~ pi_D (dot | {x_(t,*)}) arrow.r (x_(t+1), r_(t+1)) = a_t (x_t)$],
          [Performance: $f_P ({r_(t)})$],
        )
      ],
    )
  ],
  key-points: [
    #let task-focus(title, basic, performance, example) = stack(
      spacing: 0.5em,
      align(left, text(weight: "semibold", fill: palette.accent, title)),
      grid(
        columns: (7em, 1fr),
        column-gutter: 0.65em,
        row-gutter: 0.25em,
        align: left,
        [*Basic task*], basic,
        [*Performance*], performance,
        [*Example*], example,
      ),
    )

    #text(size: 0.75em)[
      #block(width: 100%, height: 3.1cm)[
        #align(left + horizon)[
          #only("1")[
            #task-focus(
              [Prediction],
              [Map inputs to outputs],
              [Successful prediction],
              [Classification or regression],
            )
          ]

          #only("2")[
            #task-focus(
              [Generation],
              [Produce new examples],
              [Similarity to the true distribution],
              [Text or image synthesis],
            )
          ]

          #only("3")[
            #task-focus(
              [Discovery],
              [Find a representation of the data],
              [Quality of the discovered representation],
              [Clustering or dimensionality reduction],
            )
          ]

          #only("4")[
            #task-focus(
              [Action],
              [Choose actions to maximize future reward],
              [Ability to achieve the desired outcome],
              [Reinforcement learning],
            )
          ]

          #only("5")[
            #grid(
              columns: (7em, 1fr),
              column-gutter: 0.65em,
              row-gutter: 0.25em,
              align: left,
              [*Prediction*], [Map inputs to outputs],
              [*Generation*], [Produce new examples],
              [*Discovery*], [Find a representation of the data],
              [*Action*], [Choose actions to achieve desired outcomes],
            )
          ]
        ]
      ]
    ]
  ],
)

#speaker-note[
  This is the Book 2 shift. The advanced course is not primarily organized
  around the format of the training data. It is organized around what
  probabilistic models let us do: prediction, generation, discovery, and
  action. These are task or capability classes: they describe what the learned
  system is being asked to accomplish. Walk through one task at a time using
  the same three questions: what is the basic task, how is performance judged,
  and what is a paradigmatic example? The final reveal compresses the four
  classes to one line each so the organizing taxonomy remains visible.
]

== There are many combinations of experience and task 

#content-block(
  layout: "top",
  object-width: 98%,
  object: [
    #align(center)[
      #text(size: 0.46em)[
        #table(
          columns: (1.15fr, 1fr, 1fr, 1fr, 1fr),
          align: (left, center, center, center, center),
          inset: (x: 5pt, y: 5pt),
          stroke: 0.6pt + palette.rule-line,
          table.header(
            [*Experience*], [*Prediction*], [*Generation*], [*Discovery*], [*Action*],
          ),
          [*Supervised*], [Classification], [—], [—], [Imitation learning],
          [*Unsupervised*], [—], [Density modeling], [Clustering / PCA], [—],
          [*Self-supervised*], [Next-token prediction], [Language generation], [Representation learning], [—],
          [*Reinforcement / interaction*], [—], [—], [—], [Policy learning],
        )
      ]
    ]
  ],
  key-points: [
    #text(size: 0.7em)[
      - Not every type of experience supports every task.
      - Common pairings do exist.
    ]
  ]
)

#speaker-note[
  Cross the two axes explicitly. Supervised experience is common for prediction,
  but it can also support action through imitation learning. Unsupervised
  experience can support generation or discovery. Self-supervised experience
  can support prediction, generation, and representation discovery. Interactive
  experience is the canonical route to policy learning.

  The matrix is deliberately sparse. The point is not to catalogue every cell:
  the same task may be trained from different experience regimes, and the same
  experience regime can support different tasks. Performance remains the third
  axis that decides what counts as success.
]

== Summary: Two taxonomies, three ingredients

#content-block(
  key-points: [
    - *Learning problem* = task + experience + performance
    - *Experience regimes:* supervised, unsupervised, self-supervised, interactive
    - *Task classes:* prediction, generation, discovery, action
    - Probabilistic modeling provides a unifying language
  ],
)

#speaker-note[
  Close the taxonomy section by naming the distinction one last time.
  Experience says what information reaches the learner. Task says what the
  resulting system must accomplish. Performance says what counts as success.

  The matrix showed that these axes cross. A familiar pairing can be useful
  without becoming a definition: supervised data often supports prediction,
  for example, but supervised experience is not identical to prediction.
]

#section-metadata(
  short-title: [Problem examples],
  subtitle: [The same dataset can pose different learning problems],
)

= From datasets to learning problems

== Popular datasets

#content-block(
  layout: "top",
  object-width: 100%,
  object: [
    #let dataset-card(title, sample, age, tasks) = block(
      width: 100%,
      height: 3.8cm,
      stroke: 0.8pt + palette.rule-line,
      fill: palette.paper,
      radius: 0.25em,
      inset: (x: 0.6em, y: 0.48em),
    )[
      #stack(
        spacing: 0.28em,
        text(size: 0.66em, weight: "semibold", fill: palette.accent)[#title],
        block(width: 100%, height: 1.95cm, fill: white, inset: 0.12em)[
          #align(center + horizon)[#sample]
        ],
        grid(
          columns: (2.7em, 1fr),
          column-gutter: 0.35em,
          row-gutter: 0.08em,
          text(size: 0.42em, weight: "semibold", fill: palette.accent)[AGE],
          text(size: 0.46em)[#age],
          text(size: 0.42em, weight: "semibold", fill: palette.accent)[TASKS],
          text(size: 0.46em)[#tasks],
        ),
      )
    ]

    #grid(
      columns: (1fr, 1fr),
      gutter: 0.5em,
      align: top,
      dataset-card(
        [Iris],
        grid(
          columns: 3,
          gutter: 0.18em,
          image("figures/book1_fig1_1a_setosa.png", width: 100%, height: 1.7cm, fit: "contain"),
          image("figures/book1_fig1_1b_versicolor.png", width: 100%, height: 1.7cm, fit: "contain"),
          image("figures/book1_fig1_1c_virginica.png", width: 100%, height: 1.7cm, fit: "contain"),
        ),
        [Since 1936 -- about 90 years],
        [species prediction; clustering; visualization],
      ),
      dataset-card(
        [MNIST],
        image("figures/book1_fig1_12a_mnist.png", width: 100%, height: 1.78cm, fit: "contain"),
        [Since 1998 -- about 28 years],
        [digit classification; representation learning; generation],
      ),
      dataset-card(
        [CIFAR-10],
        image("figures/book1_fig1_13b_cifar10.png", width: 100%, height: 1.78cm, fit: "contain"),
        [Since 2009 -- about 17 years],
        [object classification; robustness; generation],
      ),
      dataset-card(
        [IMDB movie reviews],
        image("figures/book1_table1_3_imdb.png", width: 100%, height: 1.55cm, fit: "contain"),
        [Since 2011 -- about 15 years],
        [sentiment classification; text representation],
      ),
    )
    #source-note[Murphy (2025), Book 1, Figs. 1.1, 1.12a, 1.13b, and Table 1.3]
  ],
  key-points: [ #text(size:0.75em)[
    - Machine learning is built around a small number of canonical datasets
      - These four datasets are commonly used
    - Each dataset supports multiple tasks
    - Datasets support benchmarks that make comparisons easy
  ] ],
)

#speaker-note[
  These four datasets provide landmarks for comparing tasks in this section.
  Iris we have already used, for prediction — but the same 150 flowers also
  support clustering and two-dimensional visualization, so even our first
  example was never tied to one task. Longevity as a benchmark makes
  comparisons across methods and years easy, but also means that
  state-of-the-art benchmark performance should not be confused with having
  solved the broader task. Ages: Iris (Fisher, 1936), MNIST (LeCun et al.,
  1998), CIFAR-10 (Krizhevsky, 2009), IMDB (Maas et al., 2011). Reproduced
  from the corresponding Chapter 1 figures and table in Murphy, Book 1
  (online version, April 18, 2025).

  MNIST, CIFAR-10, and IMDB instantiate the same task-taxonomy schemas —
  prediction, discovery, and generation — so their right-hand sides can be
  compared directly against the taxonomy.
]

== MNIST: the same taxonomy, one dataset

#content-block(
  layout: "top",
  object-width: 94%,
  object: [
    #grid(
      columns: (0.85fr, 1.15fr),
      gutter: 1.0em,
      align: center + horizon,
      [
        #image("figures/book1_fig1_12a_mnist.png", width: 100%, height: 4.6cm, fit: "contain")
        #v(0.3em)
        #align(center)[#text(size: 0.85em)[$x_n in {0, dots, 255}^(28 times 28), quad y_n in {0, dots, 9}$]]
      ],
      [
        #stack(
          spacing: 0.55em,
          schema-node([Prediction], [$hat(y) = f_D (x_*)$]),
          uncover("2-")[#schema-node([Discovery], [$hat(z) = f_D (x_*)$], fill: palette.paper)],
          uncover("3-")[#schema-node([Generation], [$x_* tilde p_D (x | c)$], fill: palette.paper)],
        )
      ],
    )
    #source-note[Murphy (2025), Book 1, Fig. 1.12a]
  ],
)

#speaker-note[
  Same three right-hand sides as the task taxonomy slide, now with a concrete
  dataset substituted in. MNIST is not "the digit-classification dataset":
  the 70,000 images support prediction (digit image to label), discovery (an
  unsupervised representation z of what makes digits similar, with no labels
  involved), and generation (new, plausible digit images, optionally
  conditioned on a target class c). Point back explicitly to the task
  taxonomy slide — these are the same three formulas, x and y swapped in for
  the dataset at hand.
]

== CIFAR-10: higher-dimensional inputs, the same questions

#content-block(
  layout: "top",
  object-width: 94%,
  object: [
    #grid(
      columns: (0.85fr, 1.15fr),
      gutter: 1.0em,
      align: center + horizon,
      [
        #image("figures/book1_fig1_13b_cifar10.png", width: 100%, height: 4.6cm, fit: "contain")
        #v(0.3em)
        #align(center)[$x_n in RR^(32 times 32 times 3), quad y_n in {1, dots, 10}$]
      ],
      [
        #stack(
          spacing: 0.65em,
          schema-node([Prediction], [$hat(y) = f_D (x_*)$]),
          uncover("2-")[
            #grid(
              columns: (1fr, 0.2fr, 1fr),
              gutter: 0.3em,
              align: center + horizon,
              schema-node([$D_("train")$], [$L(theta; D_("train"))$], fill: palette.paper),
              schema-arrow,
              schema-node([$D_("test")$], [$L(theta; D_("test"))$], fill: palette.paper),
            )
          ],
        )
      ],
    )
    #source-note[Murphy (2025), Book 1, Fig. 1.13b]
  ],
)

#speaker-note[
  Formally this is the same prediction schema as MNIST, just with a
  higher-dimensional, three-channel input. What changes is not the task
  definition but its difficulty: a low loss is easy to reach on 50,000
  training images and says little on its own about the held-out 10,000. This
  revives the training-versus-held-out distinction from the earlier ERM
  discussion and attaches it to the dataset where it actually bites —
  CIFAR-10 is also a standard benchmark for robustness and distribution
  shift, which is a generalization question dressed up as a dataset.
]

== IMDB reviews: text as sequence data

#content-block(
  layout: "top",
  object-width: 94%,
  object: [
    #grid(
      rows: (0.85fr, 1.15fr),
      gutter: 1.0em,
      align: center + horizon,
      [
        #image("figures/book1_table1_3_imdb.png", width: 100%, height: 8cm, fit: "contain")
        #v(0.3em)
        #align(center)[#text(size: 0.85em)[$x_n = (w_1, dots, w_T), quad y_n in {"pos", "neg"}$]]
      ],
      [
        #stack(
          spacing: 0.55em,
          schema-node([Prediction], [$hat(y) = f_D (x_*)$]),
          uncover("2-")[#schema-node([Discovery], [$hat(z) = f_D (x_*)$], fill: palette.paper)],
          uncover("3-")[#schema-node([Generation], [$w_t tilde p_D (w_t | w_(<t))$], fill: palette.paper)],
        )
      ],
    )
    #source-note[Murphy (2025), Book 1, Table 1.3]
  ],
)

#speaker-note[
  IMDB looks like ordinary supervised prediction — a review maps to positive
  or negative — but x is now a variable-length sequence of words rather than
  a fixed vector, so the input space itself needs a modeling decision before
  any of the three schemas apply. Discovery gives a text representation z,
  e.g. an embedding, useful beyond sentiment. Generation here is language
  modeling: predicting the next word from its predecessors, the same
  p_D(x | c) idea as image generation, just factored token by token. Keep this
  as a brief sequence-data example, not a sequence-modeling lecture.
]

== Learning problems become probabilistic queries

#content-block(
  layout: "top",
  object-width: 94%,
  object: [
    // Same grid as the task taxonomy slide, shown all at once: this is a
    // recap under a new reading, not a first teaching pass.
    #let taxonomy-node(label, ..body) = schema-node(label, stack(spacing: 0.7em, ..body), density: "prose")
    #grid(
      columns: (1fr, 1fr),
      column-gutter: 0.8em,
      row-gutter: 0.7em,
      align: center + horizon,

      taxonomy-node(
        [Prediction],
        [Task: ${(x_n, y_n)} arrow.r hat(y) = f_D (x_*)$],
        [Performance: $f_P ( y_*, hat(y) )$],
      ),

      taxonomy-node(
        [Generation],
        [Task: ${x_n} arrow.r ({c}, p_D (x | c)) arrow.r x_* ~ p_D (x | c)$],
        [Performance: $f_P ( p (x | c), x_* )$],
      ),

      taxonomy-node(
        [Discovery],
        [Task: ${x_n} arrow.r ( {z}, f_D (x) ) arrow.r hat(z) = f_D (x_*)$],
        [Performance: $f_P (hat(z), x_*)$],
      ),

      taxonomy-node(
        [Action],
        [Task: $D arrow.r a_* ~ pi_D (dot | {x_(t,*)}) arrow.r (x_(t+1), r_(t+1)) = a_t (x_t)$],
        [Performance: $f_P ({r_(t)})$],
      ),
    )
  ],
  key-points: [
    - Every task invokes probability models: $p_D (y|x)$, $p_D (x|c)$, $p_D (z|x)$
    - Performances are expectations over future cases: $f_P = E[dot]$
    - Probability models provide a common language for all four task schemas
  ],
)

#speaker-note[
  This is the same grid as the task taxonomy slide two sections back — same
  four tasks, same Task/Performance lines, now shown all at once rather than
  built up, because the point here is a recap under a new reading, not a
  first teaching pass.

  Read $hat(y) = f_D (x_*)$ not as a bare function call but as the summary a
  probabilistic model reports for $p_D (y | x)$. Generation's task line
  already says this out loud — $x_* tilde p_D (x | c)$ — and discovery is the
  same idea with z in place of y. Every Performance line, written $f_P (dot)$
  here, is in every case an expectation over future cases, not the training
  average computed earlier for Iris and CIFAR-10.

  The common structure is now explicit: a task asks for a quantity, and a
  probability model supplies the distributional object from which that
  quantity is extracted. Expectation is one central way to summarize such an
  answer; conditional expectation specializes it to observed information.
]

== Summary: From datasets to learning problems

#content-block(
  key-points: [
    - A dataset is not a task
    - A learning problem names variables and a query
      - prediction: summarize $p_D (y_* | x_*)$
      - discovery: infer $p_D (z_* | x_*)$
      - generation: sample from $p_D (x | c)$
  ],
)

#speaker-note[
  This section did not add a fifth taxonomy: it showed the same task schemas
  concretely on four familiar datasets, then recast them as probabilistic
  queries on the previous slide. A task is fixed by what query we ask of the
  variables a dataset provides — not by which dataset happens to supply x
  and y.

  Action is not orphaned here: it already got its own schema on the task
  taxonomy slide two sections ago, but none of these four landmark datasets is
  naturally an action problem. The section ends with a query-centered view of
  learning: the variables come from the dataset, while the task is determined
  by the quantity we ask for.

]

#section-metadata(
  short-title: [Probability summaries],
  subtitle: [Expectations, moments, and conditioning],
)

= Probability for machine learning

== Large learning problems still ask familiar probability questions

#content-block(
  layout: "top",
  object-width: 94%,
  object: [
    #grid(
      columns: (1fr, 1fr, 1fr),
      gutter: 0.8em,
      align: center + horizon,
      schema-node(
        [Observed],
        [$x_"obs"$: features, measurements, context],
        density: "prose",
      ),
      schema-node(
        [Latent],
        [$z$: state, representation, missing value],
        density: "prose",
        fill: palette.paper,
      ),
      schema-node(
        [Target],
        [$y_*$: prediction, sample, decision],
        density: "prose",
      ),
    )
    #uncover("2-")[
      #v(0.8em)
      #align(center)[Joint distribution: $p_D (x_"obs", z, y_*)$]
      #v(0.8em)
    ]
  ],
  key-points: [
    - The variables may be high-dimensional, latent, or only partly observed
    #uncover("2-")[
      - The task determines which quantity we need from the joint distribution
    ]
    #uncover("3-")[
      - The probability language is familiar even when the model is large
    ]
  ],
)

#speaker-note[
  Reveal the observed, latent, and target variables first. Then add their joint
  distribution and ask which quantity the task requires. End by naming the
  continuity: the variables may be high-dimensional, latent, or partly
  observed, but the probability language is unchanged.
]

== A few operations answer many tasks

#content-block(
  layout: "top",
  object-width: 96%,
  object: [
    #align(center)[Joint distribution: $p_D (x_"obs", z, y_*)$]
    #grid(
      columns: (1fr, 1fr, 1fr),
      gutter: 0.7em,
      align: center + horizon,
      schema-node(
        [Summarize],
        [#stack(
          spacing: 0.35em,
          [$integral g(y_*) p_D (y_* | x_"obs", z) dif y_*$],
          [weighted summary of the target],
        )],
        density: "prose",
      ),
      uncover("2-")[
        #schema-node(
          [Marginalize],
          [#stack(
            spacing: 0.35em,
            [$p_D (y_* | x_"obs") = integral p_D (z, y_* | x_"obs") dif z$],
            [average out the latent variable],
          )],
          density: "prose",
          fill: palette.paper,
        )
      ],
      uncover("3-")[
        #schema-node(
          [Condition],
          [#stack(
            spacing: 0.35em,
            [$p_D (z | x_"obs", y_*) = frac(p_D (z, y_* | x_"obs"), integral p_D (z', y_* | x_"obs") dif z')$],
            [infer the latent variable],
          )],
          density: "prose",
        )
      ],
    )
  ],
  key-points: [
    - Prediction and performance often require expectations
    - Latent variables are inferred or averaged out
    - The same few operations recur across different learning tasks
  ],
)

#speaker-note[
  Reveal one operation at a time from the joint distribution. The first integral
  summarizes the target for given observed and latent values. The second
  integrates out the latent variable; the third normalizes the joint to infer
  that variable given the observed and target values.
]

== Expectation summarizes a distribution

#content-block(
  layout: "top",
  object-width: 92%,
  object: [
    #twocol(
      schema-node(
        [Continuous],
        [$E[g(X)] = integral g(x) p(x) dif x$],
        fill: palette.paper,
      ),
      schema-node(
        [Discrete],
        [$E[g(X)] = sum_x g(x) p(x)$],
        fill: palette.paper,
      ),
    )
    #v(1.0em)
    #align(center)[$mu = E[X]$]
    #source-note[Course schematic; Murphy, Book 1 §2.2.5]
  ],
  key-points: [
    - Expectation is a probability-weighted average
    - Choosing $g(x)=x$ gives the mean
  ],
)

#speaker-note[
  Introduce expectation as a model-based summary, not as a new statistical
  estimator. The discrete and continuous forms are the same idea with different
  summation rules. Using a general function $g$ states the same summary idea
  for many possible quantities without adding another concept yet.
]

== Linearity makes expectations easy to combine

#content-block(
  layout: "top",
  object-width: 90%,
  object: [
    #align(center)[$E[a X + b] = a E[X] + b$]
    #v(0.9em)
    #align(center)[$E[sum_i X_i] = sum_i E[X_i]$]
  ],
  key-points: [
    - Expectations of sums are sums of expectations
    - Independence is not required
  ],
)

#speaker-note[
  Keep this slide separate from the definition of expectation. The teaching
  move is computational: expectation respects linear combinations even when the
  random variables are dependent.
]

== Variance records spread around the mean

#content-block(
  layout: "top",
  object-width: 90%,
  object: [
    #grid(
      columns: (1fr, 1fr),
      gutter: 1.1em,
      align: center + horizon,
      schema-node(
        [Variance],
        [#stack(spacing: 0.55em, [$V[X] = E[(X-mu)^2]$], [$= E[X^2] - mu^2$])],
      ),
      schema-node(
        [Second raw moment],
        [$E[X^2] = V[X] + mu^2$],
        fill: palette.paper,
      ),
    )
    #source-note[Course schematic; Murphy, Book 1 §2.2.5]
  ],
  key-points: [
    - Variance measures squared distance from the mean
    - The second raw moment contains both spread and location
  ],
)

#speaker-note[
  The alternative variance identity introduces $E[X^2]$ naturally. Together,
  the mean, variance, and raw second moment show that distribution summaries can
  be organized by the powers of the random variable they average.
]

== Moments organize these distribution summaries

#content-block(
  layout: "top",
  object-width: 92%,
  object: [
    #grid(
      columns: (1fr, 1fr),
      gutter: 1.0em,
      align: center + horizon,
      schema-node(
        [Raw moments],
        [#stack(
          spacing: 0.5em,
          [$m_k = E[X^k]$],
          [$m_1 = E[X]$],
          [$m_2 = E[X^2]$],
        )],
      ),
      schema-node(
        [Central moments],
        [#stack(
          spacing: 0.5em,
          [$mu_k = E[(X-E[X])^k]$],
          [$mu_2 = V[X]$],
        )],
        fill: palette.paper,
      ),
    )
  ],
  key-points: [
    - A moment is a property of a probability distribution
    - Mean and variance are particular moments
  ],
)

#speaker-note[
  This slide supplies the missing vocabulary. Students have already seen the
  first raw moment, second raw moment, and second central moment. Name the
  general pattern without opening a catalogue of skewness, kurtosis, or moment
  generating functions.
]

== Conditioning makes a summary depend on what we know

#content-block(
  layout: "top",
  object-width: 92%,
  object: [
    #grid(
      columns: (1fr, 0.22fr, 1.2fr),
      gutter: 0.4em,
      align: center + horizon,
      schema-node([$Y=y$], [$"observed information"$]),
      schema-arrow,
      schema-node(
        [$p(X | Y=y)$],
        [$E[X | Y=y]$],
        fill: palette.paper,
      ),
    )
    #v(0.9em)
    #align(center)[$E[X] = E_Y [E[X | Y]]$]
  ],
  key-points: [
    - $E[X | Y]$ is itself a function of the conditioning variable $Y$
    - Averaging the conditional means recovers the overall mean
  ],
)

#speaker-note[
  Move from unconditional to conditional summaries. The key conceptual point is
  that $E[X|Y]$ is not one number until $Y$ is specified; it is a function of
  what has been observed. The law of total expectation reconnects the
  conditional and marginal views.
]

== Total variance separates within- and between-condition variation

#content-block(
  layout: "top",
  object-width: 94%,
  object: [
    #align(center)[$
      V[X] =
      underbrace(E_Y [V[X | Y]])_("within")
      +
      underbrace(V_Y [E[X | Y]])_("between")
    $]
    #v(1.0em)
    #grid(
      columns: (1fr, 0.25fr, 1fr),
      gutter: 0.45em,
      align: center + horizon,
      schema-node([$V[X | Y]$], [$"conditional spread"$]),
      align(center + horizon)[#text(size: 1.2em, fill: palette.accent)[$+$]],
      schema-node([$E[X | Y]$], [$"changing conditional means"$]),
    )
    #source-note[Course schematic; Murphy, Book 1 §2.2.5]
  ],
)

#speaker-note[
  Introduce the within-plus-between decomposition without deriving it. It shows
  how conditional summaries combine to reconstruct an unconditional one. It is
  a general decomposition of within-condition and between-condition variation.
]

== Summary: Probability for machine learning

#content-block(
  key-points: [
    - Expectations and moments summarize a probability distribution
    - Conditioning makes those summaries depend on observed information
    - Total expectation and total variance combine conditional pieces
    - These identities are properties of a distribution treated as given
  ],
)

#speaker-note[
  Synthesize rather than enumerate formulas. Expectations and moments summarize
  a distribution, conditioning makes those summaries depend on information we
  have observed, and the total-expectation and total-variance identities
  recombine conditional pieces. The section closes on the model side of this
  distinction: the distribution is treated as given.
]

#section-metadata(
  short-title: [From probability to statistics],
  subtitle: [Estimating unknown quantities from observed data],
)

= From probability to statistics

== Probability describes a model; statistics learns from data

#content-block(
  layout: "top",
  object-width: 92%,
  object: [
    #grid(
      columns: (1fr, 0.22fr, 1fr),
      gutter: 0.45em,
      align: center + horizon,
      schema-node(
        [Population model],
        [#stack(spacing: 0.4em, [$Y tilde p(y | theta)$], [$"unknown " theta$])],
      ),
      schema-arrow,
      schema-node(
        [Observed sample],
        [$D = (y_1, dots, y_N)$],
        fill: palette.paper,
      ),
    )
    #v(0.9em)
    #align(center)[$"What can " D " tell us about " theta "?"$]
  ],
  key-points: [
    - Probability describes possible data given a model
    - Statistics uses observed data to learn unknown population quantities
  ],
)

#speaker-note[
  Make the section break explicit. The probability review treated the
  distribution as known and asked what summaries or conditionals follow from
  it. Statistics reverses the direction of the question: we have observed data
  and want to learn about an unknown feature or parameter of the model.
]

== A statistic is a function of the observed data

#content-block(
  layout: "top",
  object-width: 94%,
  object: [
    #grid(
      columns: (1fr, 0.2fr, 1fr),
      gutter: 0.45em,
      align: center + horizon,
      schema-node([Data], [$D = (y_1, dots, y_N)$]),
      schema-arrow,
      schema-node([Statistic], [$T(D)$], fill: palette.paper),
    )
    #v(0.8em)
    #align(center)[$overline(y) = frac(1, N) sum_(n=1)^N y_n quad "or" quad N_1 = sum_(n=1)^N y_n$]
  ],
  key-points: [
    - A statistic is computed from the observed sample
    - Its definition does not contain an unknown parameter
  ],
)

#speaker-note[
  Students already know sample means and counts. Give those familiar objects the
  general name statistic. The definition is intentionally broad: at this point
  a statistic is simply a function of the data, not necessarily an estimator.
]

== An estimator is a statistic aimed at an unknown quantity

#content-block(
  layout: "top",
  object-width: 92%,
  object: [
    #align(center)[$D quad arrow.r quad hat(theta)(D)$]
    #v(0.9em)
    #twocol(
      schema-node([Target], [$theta$], fill: palette.paper),
      schema-node([Estimator], [$hat(theta)(D)$]),
    )
  ],
  key-points: [
    - The estimator is the rule $D arrow.r hat(theta)(D)$
    - The estimate is the value produced for the dataset we actually observed
    - Different estimation principles can target the same parameter
  ],
)

#speaker-note[
  Keep the direction of the mapping explicit: data go into the estimator and an
  estimate comes out. The unknown parameter is the target, not the input. This
  slide establishes the data-to-estimate map that any estimation principle must
  instantiate.
]

== Sample moments estimate population moments

#content-block(
  layout: "top",
  object-width: 94%,
  object: [
    #grid(
      columns: (1fr, 0.2fr, 1fr),
      gutter: 0.45em,
      align: center + horizon,
      schema-node(
        [Population moment],
        [$m_k = E[X^k]$],
        fill: palette.paper,
      ),
      schema-arrow,
      schema-node(
        [Sample moment],
        [$hat(m)_k = frac(1, N) sum_(n=1)^N x_n^k$],
      ),
    )
    #v(0.9em)
    #align(center)[$E[Y] = theta quad "for Bernoulli data, while" quad overline(y) = frac(N_1, N)$]
  ],
  key-points: [
    - A population moment is a property of the distribution
    - A sample moment is a statistic computed from observed data
  ],
)

#speaker-note[
  This is the bridge the previous version was missing. The notation on the two
  sides deliberately parallels the probability section. For Bernoulli data the
  first population moment is the success probability itself, while the first
  sample moment is the observed fraction of successes.
]

== Method of moments matches model and sample moments

#content-block(
  layout: "top",
  object-width: 92%,
  object: [
    #align(center)[$m_k(theta) = hat(m)_k$]
    #v(0.95em)
    #grid(
      columns: (1fr, 0.2fr, 1fr),
      gutter: 0.45em,
      align: center + horizon,
      schema-node(
        [Bernoulli model],
        [$E_theta [Y] = theta$],
        fill: palette.paper,
      ),
      schema-arrow,
      schema-node(
        [Method of moments],
        [$hat(theta)_"MOM" = overline(y) = frac(N_1, N)$],
      ),
    )
    #source-note[Murphy, Book 1 §4.4.1]
  ],
  key-points: [
    - Choose parameter values whose model moments equal the empirical moments
    - The choice of moments defines an estimation rule
  ],
)

#speaker-note[
  Method of moments is the direct continuation of the previous slide. For the
  Bernoulli model there is one parameter and the first moment is enough. Do not
  generalize into a survey of moment estimators; the purpose is to establish one
  principled way to construct $D arrow.r hat(theta)$.
]

== Maximum likelihood uses the sampling model instead

#content-block(
  layout: "top",
  object-width: 94%,
  object: [
    #align(center)[$hat(theta)_"MLE" = arg max_(theta) p(D | theta)$]
    #v(0.85em)
    #align(center)[$p(D | theta) prop theta^(N_1) (1-theta)^(N-N_1)$]
    #uncover("2-")[
      #v(0.75em)
      #align(center)[$hat(theta)_"MLE" = frac(N_1, N) = hat(theta)_"MOM"$]
    ]
  ],
  key-points: [
    - MLE uses the likelihood rather than selected moments
    #uncover("2-")[
      - For Bernoulli data the two principles happen to give the same estimate
    ]
  ],
)

#speaker-note[
  Present MLE as a sibling of method of moments, not as its consequence. The
  objective is different: MLE uses the probability of the whole observed sample
  under each parameter value. For this simple model both rules lead to the same
  numerical estimate, which makes the conceptual comparison unusually clean.
]

== MAP adds prior information to a point estimate

#content-block(
  layout: "top",
  object-width: 94%,
  object: [
    #align(center)[$
      hat(theta)_"MAP"
      = arg max_(theta) p(theta | D)
      = arg max_(theta) p(D | theta) p(theta)
    $]
    #v(0.9em)
    #grid(
      columns: (1fr, 0.18fr, 1fr),
      gutter: 0.4em,
      align: center + horizon,
      schema-node([Likelihood], [$p(D | theta)$]),
      align(center + horizon)[#text(size: 1.05em, fill: palette.accent)[$times$]],
      schema-node([Prior], [$p(theta)$], fill: palette.paper),
    )
    #uncover("2-")[
      #v(0.75em)
      #align(center)[$p(theta) prop 1 quad arrow.r quad hat(theta)_"MAP" = hat(theta)_"MLE"$]
    ]
  ],
  key-points: [
    - MAP is another estimator: it returns the posterior mode
    #uncover("2-")[
      - A uniform prior reduces MAP to MLE
      - The full posterior retains uncertainty that a single MAP estimate discards
    ]
  ],
)

#speaker-note[
  Reconnect directly to the Beta-Bernoulli material from the start of the
  lecture. Bayes' rule is already familiar; MAP simply keeps the maximizing
  parameter value instead of the full posterior distribution. The final point
  is a reminder, not a new Bayesian-inference lesson: a point estimate cannot
  represent posterior width.
]

== Summary: Different estimators answer the same fitting question

#content-block(
  layout: "top",
  object-width: 94%,
  object: [
    #grid(
      columns: (1fr, 1.3fr),
      gutter: 0.75em,
      align: center + horizon,
      schema-node([Method of moments], [$m_k(theta) = hat(m)_k$]),
      schema-node([Maximum likelihood], [$max_theta p(D | theta)$], fill: palette.paper),
      schema-node([MAP], [$max_theta p(D | theta) p(theta)$], fill: palette.paper),
      schema-node([Common goal], [$D arrow.r hat(theta)$]),
    )
  ],
  key-points: [
    - Statistics provides rules for turning data into estimates of unknown quantities
    - MOM, MLE, and MAP use different principles to construct that rule
    - A point estimate gives one value, while the posterior retains uncertainty
  ],
)

#speaker-note[
  End on the organizing idea rather than another formula. All three methods are
  estimators, but they use different information and objectives. Method of
  moments matches summaries, likelihood scores the observed sample, and MAP
  combines likelihood with a prior. Together they show three ways to construct
  a rule from data to an estimate.
]

#section-metadata(
  short-title: [Categorical],
  subtitle: [The probability language of multiclass labels],
)

= Categorical, multinomial, and softmax

== Categorical labels

#content-block(
  layout: "top",
  object-width: 90%,
  object: [
    #align(center)[$"Cat"(y | theta) = product_(c=1)^C theta_c^(I(y = c))$]
    #v(0.9em)
    #grid(
      columns: (1fr, 0.2fr, 1fr),
      gutter: 0.4em,
      align: center + horizon,
      schema-node([$y in {1, dots, C}$], [$"one label"$]),
      schema-arrow,
      schema-node([$theta in Delta^(C-1)$], [#stack(spacing: 0.12em, [$0 <= theta_c <= 1$], [$sum_c theta_c = 1$])]),
    )
  ],
)

#speaker-note[
  The categorical distribution is the multiclass extension of Bernoulli. The
  simplex constraints, rather than any fitting method, are the important new
  object on this slide.
]

== One-hot encoding

#content-block(
  layout: "top",
  object-width: 90%,
  object: [
    #grid(
      columns: (1fr, 0.2fr, 1fr),
      gutter: 0.4em,
      align: center + horizon,
      schema-node([$y = 2$], [$"class index"$]),
      schema-arrow,
      schema-node([$bold(y) = (0, 1, 0)^T$], [$"one-hot vector"$]),
    )
    #v(0.9em)
    #align(center)[$"Cat"(y | theta) = product_(c=1)^C theta_c^(y_c)$]
  ],
)

#speaker-note[
  One-hot notation lets the categorical probability be written as a product
  with a single active class. It is convenient for vector-valued models.
]

== Multinomial counts

#content-block(
  layout: "top",
  object-width: 94%,
  object: [
    #grid(
      columns: (1fr, 0.18fr, 1.4fr),
      gutter: 0.4em,
      align: center + horizon,
      schema-node([$N = (N_1, dots, N_C)$], [$sum_c N_c = N$]),
      schema-arrow,
      schema-node([$"Mult"(N | N, theta)$], [$binom(N, N_1, dots, N_C) product_(c=1)^C theta_c^(N_c)$]),
    )
    #source-note[Course schematic; Book 1 §2.5]
  ],
)

#speaker-note[
  The categorical model describes one label. The multinomial describes the
  counts after repeated categorical draws. Counts are the natural summary of
  repeated categorical outcomes.
]

== Softmax

#content-block(
  layout: "top",
  object-width: 96%,
  object: [
    #grid(
      columns: (1fr, 0.2fr, 1.3fr, 0.2fr, 1fr),
      gutter: 0.3em,
      align: center + horizon,
      schema-node([$a in RR^C$], [$"logits"$]),
      schema-arrow,
      uncover("2-")[
        #schema-node([$"softmax"(a)_c = frac(exp(a_c), sum_(c') exp(a_(c')))$], [$"normalization"$], fill: palette.paper)
      ],
      uncover("2-")[#schema-arrow],
      uncover("3-")[#schema-node([$theta in Delta^(C-1)$], [$"class probabilities"$])],
    )
  ],
)

#speaker-note[
  Softmax is a map from arbitrary real-valued scores to a point on the
  probability simplex. Do not derive cross-entropy or optimization here.
]

== Multiclass logistic notation

#content-block(
  layout: "top",
  object-width: 94%,
  object: [
    #align(center)[$p(y | x; theta) = "Cat"(y | "softmax"(W x + b))$]
    #v(0.9em)
    #grid(
      columns: (1fr, 0.18fr, 1fr, 0.18fr, 1fr),
      gutter: 0.3em,
      align: center + horizon,
      schema-node([$x$], [$"features"$]),
      schema-arrow,
      schema-node([$W x + b$], [$"scores"$], fill: palette.paper),
      schema-arrow,
      schema-node([$p(y | x; theta)$], [$"categorical output"$]),
    )
  ],
)

#speaker-note[
  Treat this as notation preparation. The slide connects features, a linear
  score vector, softmax, and a categorical distribution without teaching the
  fitting algorithm.
]

== Summary: Categorical, multinomial, and softmax

#content-block(
  key-points: [
    - Categorical: one multiclass label
    - One-hot vectors encode class membership
    - Multinomial: counts from repeated categorical draws
    - Softmax maps logits to the probability simplex
    - $p(y | x; theta) = "Cat"(y | "softmax"(W x + b))$
  ],
)

#speaker-note[
  The categorical family gives the probability language for the classification
  problems introduced earlier: a single label, a one-hot representation,
  repeated counts, and normalized logits are different views of multiclass
  outcomes.
]

#section-metadata(
  short-title: [Empirical distribution],
  subtitle: [Observed data as a distribution of point masses],
)

= Dirac delta and empirical distribution

== Point mass

#content-block(
  layout: "top",
  object-width: 90%,
  object: [
    #align(center)[$lim_(sigma -> 0) cal(N)(y | mu, sigma^2) = delta(y - mu)$]
    #v(1em)
    #grid(
      columns: (1fr, 0.22fr, 1fr),
      gutter: 0.45em,
      align: center + horizon,
      schema-node([$cal(N)(y | mu, sigma^2)$], [$sigma^2 " tends to " 0$]),
      schema-arrow,
      schema-node([$delta(y - mu)$], [$"all mass at " mu$]),
    )
  ],
)

#speaker-note[
  Use the narrow-Gaussian limit as an intuition for a point mass. The purpose
  is the empirical distribution, not distribution-theoretic details.
]

== Empirical distribution

#content-block(
  layout: "top",
  object-width: 94%,
  object: [
    #align(center)[$p_D(y) = frac(1, N) sum_(n=1)^N delta(y - y_n)$]
    #v(0.9em)
    #grid(
      columns: (1fr, 0.2fr, 1fr),
      gutter: 0.4em,
      align: center + horizon,
      schema-node([$y_1, dots, y_N$], [$"observations"$]),
      schema-arrow,
      schema-node([$p_D$], [$1/N, 1/N, dots, 1/N$]),
    )
    #source-note[Course schematic; empirical-distribution definition in the coverage specification]
  ],
)

#speaker-note[
  The empirical distribution makes the observed dataset into a distribution:
  equal mass at each observed value. It represents the sample without adding
  smoothing or a parametric assumption.
]

== Summary: Empirical distribution

#content-block(
  key-points: [
    - $delta(y - mu)$: a point mass at $mu$
    - $p_D(y) = 1/N sum_n delta(y-y_n)$
    - The empirical distribution records observations without smoothing
  ],
)

#speaker-note[
  This short section closes by identifying the empirical distribution as a
  distributional representation of observed data, with equal point masses and
  no smoothing.
]

#section-metadata(
  short-title: [Covariance],
  subtitle: [Joint variation as geometry],
)

= Covariance, correlation, and dependence

== Covariance

#content-block(
  layout: "top",
  object-width: 96%,
  object: [
    #grid(
      columns: (1.1fr, 0.95fr),
      gutter: 1.0em,
      align: center + horizon,
      [
        #course-figure(
          lecture-figure-path("figures/book1_fig1_3_iris_pairplot.png"),
          source: "Murphy (2025), Book 1, Fig. 1.3; generated by iris_plot.ipynb",
          width: 100%,
          height: 6.4cm,
          show-source: false,
        )
      ],
      [
        #stack(
          spacing: 0.85em,
          align(center)[$"Cov"[X,Y] = E[(X-E[X])(Y-E[Y])]$],
          uncover("2-")[
            #grid(
              columns: (1fr, 1fr, 1fr),
              gutter: 0.35em,
              schema-node([$> 0$], [$+$]),
              schema-node([$= 0$], [$0$], fill: palette.paper),
              schema-node([$< 0$], [$-$]),
            )
          ]
        )
      ],
    )
    #figure-source("Murphy (2025), Book 1, Fig. 1.3; generated by iris_plot.ipynb")
  ],
)

#speaker-note[
  Covariance records co-variation around the means. The three symbolic panels
  show how the sign of covariance describes the orientation of joint variation.
]

== Covariance matrix

#content-block(
  layout: "top",
  object-width: 90%,
  object: [
    #align(center)[$"Cov"[bold(x)] = E[(bold(x)-E[bold(x)])(bold(x)-E[bold(x)])^T] = Sigma$]
    #v(0.9em)
    #align(center)[$E[bold(x) bold(x)^T] = Sigma + mu mu^T$]
    #v(0.8em)
    #align(center)[$Sigma = mat(sigma_1^2, "Cov"[X_1,X_2]; "Cov"[X_2,X_1], sigma_2^2)$]
  ],
)

#speaker-note[
  The covariance matrix gathers every variance and covariance in one object.
  The second-moment identity mirrors the scalar identity introduced earlier.
]

== Affine transformations

#content-block(
  layout: "top",
  object-width: 90%,
  object: [
    #grid(
      columns: (1fr, 0.22fr, 1fr),
      gutter: 0.45em,
      align: center + horizon,
      schema-node([$bold(x)$], [$"random vector"$]),
      schema-arrow,
      schema-node([$A bold(x) + b$], [$"affine map"$], fill: palette.paper),
    )
    #v(0.95em)
    #align(center)[$"Cov"[A bold(x) + b] = A "Cov"[bold(x)] A^T$]
  ],
)

#speaker-note[
  Linear transformations rotate and scale covariance geometry; adding a
  constant changes the mean but not covariance. This is essential for the
  linear Gaussian system at the end of the lecture.
]

== Correlation

#content-block(
  layout: "top",
  object-width: 90%,
  object: [
    #align(center)[$rho = "corr"[X,Y] = frac("Cov"[X,Y], sqrt(V[X] V[Y]))$]
    #v(0.9em)
    #grid(
      columns: (1fr, 1fr, 1fr),
      gutter: 0.65em,
      schema-node([$rho approx 1$], [$"aligned variation"$]),
      schema-node([$rho approx 0$], [$"no linear association"$], fill: palette.paper),
      schema-node([$rho approx -1$], [$"opposed variation"$]),
    )
  ],
)

#speaker-note[
  Correlation rescales covariance into a unitless measure. Keep causation out
  of the live narrative; a causal warning can remain a reserve discussion.
]

== Summary: Covariance and dependence

#content-block(
  key-points: [
    - Covariance: joint variation around the means
    - $Sigma$: covariance matrix
    - $E[bold(x)bold(x)^T] = Sigma + mu mu^T$
    - $"Cov"[A bold(x)+b] = A Sigma A^T$
    - Correlation rescales covariance
  ],
)

#speaker-note[
  This section turns dependence into an object that can be transformed and
  conditioned. Covariance records joint variation, affine maps transform it,
  and correlation expresses the same dependence on a unit-free scale.
]

#section-metadata(
  short-title: [Multivariate Gaussian],
  subtitle: [Geometry, marginalization, and conditioning],
)

= Multivariate Gaussian and conditioning

== Gaussian geometry

#content-block(
  layout: "top",
  object-width: 96%,
  object: [
    #align(center)[$cal(N)(y | mu, Sigma) = frac(1, (2 pi)^(D/2) |Sigma|^(1/2)) exp(-frac(1,2)(y-mu)^T Sigma^(-1)(y-mu))$]
    #v(0.8em)
    #grid(
      columns: (1fr, 1fr, 1fr),
      gutter: 0.6em,
      schema-node([$Sigma = sigma^2 I$], [$"spherical"$]),
      uncover("2-")[
        #schema-node([$Sigma = "diag"(sigma_1^2, sigma_2^2)$], [$"axis-aligned"$], fill: palette.paper)
      ],
      uncover("3-")[#schema-node([$Sigma_12 != 0$], [$"tilted"$])],
    )
  ],
)

#speaker-note[
  Read the density through geometry. The mean locates the cloud; the covariance
  determines its scale, axes, and dependence. Do not derive its normalizer.
]

== Mahalanobis distance

#content-block(
  layout: "top",
  object-width: 88%,
  object: [
    #align(center)[$Delta^2 = (y - mu)^T Sigma^(-1)(y - mu)$]
    #v(0.9em)
    #grid(
      columns: (1fr, 0.2fr, 1fr),
      gutter: 0.4em,
      align: center + horizon,
      schema-node([$y - mu$], [$"displacement"$]),
      schema-arrow,
      schema-node([$Sigma^(-1)$], [$"geometry-aware scaling"$]),
    )
  ],
)

#speaker-note[
  The inverse covariance measures distance in units adapted to the Gaussian's
  own geometry. Equal Mahalanobis distance means equal-density contours.
]

== Typical set

#content-block(
  layout: "top",
  object-width: 90%,
  object: [
    #align(center)[$bold(x) tilde cal(N)(bold(0), I_D), quad R^2 = norm(bold(x))^2 = sum_(i=1)^D x_i^2$]
    #v(0.85em)
    #grid(
      columns: (1fr, 0.25fr, 1fr),
      gutter: 0.45em,
      align: center + horizon,
      schema-node([$E[R^2] = D$], [$"radius squared"$]),
      align(center + horizon)[#text(size: 1.2em, fill: palette.accent)[$,$]],
      schema-node([$"sd"(R^2) / E[R^2] = sqrt(2/D)$], [$"relative width"$]),
    )
  ],
)

#speaker-note[
  In high dimensions, probability mass concentrates in a shell away from the
  mode. The equation quantifies why the relative shell thickness shrinks.
]

== Gaussian blocks and marginals

#content-block(
  layout: "top",
  object-width: 90%,
  object: [
    #align(center)[$y = mat(y_1; y_2), quad mu = mat(mu_1; mu_2), quad Sigma = mat(Sigma_11, Sigma_12; Sigma_21, Sigma_22)$]
    #v(0.9em)
    #grid(
      columns: (1fr, 1fr),
      gutter: 1.0em,
      schema-node([$p(y_1) = cal(N)(y_1 | mu_1, Sigma_11)$], [$"first marginal"$]),
      schema-node([$p(y_2) = cal(N)(y_2 | mu_2, Sigma_22)$], [$"second marginal"$], fill: palette.paper),
    )
  ],
)

#speaker-note[
  Partition the random vector, mean, and covariance consistently. Gaussian
  marginalization is simple in this representation: retain the relevant mean
  and covariance block.
]

== Gaussian conditioning

#content-block(
  layout: "top",
  object-width: 96%,
  object: [
    #align(center)[$p(y_1 | y_2) = cal(N)(y_1 | mu_(1|2), Sigma_(1|2))$]
    #uncover("2-")[
      #v(0.75em)
      #align(center)[$mu_(1|2) = mu_1 + Sigma_12 Sigma_22^(-1)(y_2 - mu_2)$]
    ]
    #uncover("3-")[
      #v(0.45em)
      #align(center)[$Sigma_(1|2) = Sigma_11 - Sigma_12 Sigma_22^(-1) Sigma_21$]
    ]
  ],
)

#speaker-note[
  Conditioning shifts the conditional mean according to the observed deviation
  and subtracts the uncertainty explained by the observation. The result stays
  Gaussian, which makes this a reusable inference operation.
]

== Bivariate conditional

#content-block(
  layout: "top",
  object-width: 94%,
  object: [
    #align(center)[$p(y_1 | y_2) = cal(N)(y_1 | mu_1 + rho frac(sigma_1, sigma_2)(y_2-mu_2), sigma_1^2(1-rho^2))$]
    #v(0.85em)
    #grid(
      columns: (1fr, 0.18fr, 1fr, 0.18fr, 1fr),
      gutter: 0.3em,
      schema-node([$y_2 - mu_2$], [$"observation"$]),
      schema-arrow,
      schema-node([$rho sigma_1/sigma_2$], [$"mean shift"$], fill: palette.paper),
      schema-arrow,
      schema-node([$sigma_1^2(1-rho^2)$], [$"remaining variance"$]),
    )
  ],
)

#speaker-note[
  The bivariate special case makes the general block formula visible. If the
  variables are uncorrelated, the observed value does not shift the conditional
  mean and does not reduce its variance.
]

== Conditioning as an inference machine

#content-block(
  layout: "top",
  object-width: 92%,
  object: [
    #grid(
      columns: (1fr, 0.18fr, 1fr, 0.18fr, 1fr),
      gutter: 0.3em,
      align: center + horizon,
      schema-node([$p(y_1, y_2)$], [$"joint Gaussian"$]),
      schema-arrow,
      schema-node([$y_2$], [$"observed"$], fill: palette.paper),
      schema-arrow,
      schema-node([$p(y_1 | y_2)$], [$"Gaussian posterior"$]),
    )
    #v(0.8em)
    #align(center)[$Sigma_(1|2) <= Sigma_11$]
  ],
)

#speaker-note[
  This slide names the reusable pattern. We start with a joint model, observe
  one part, and infer the other. The posterior covariance cannot exceed the
  marginal covariance in the positive-semidefinite ordering.
]

== Summary: Multivariate Gaussian and conditioning

#content-block(
  key-points: [
    - $mu$: location; $Sigma$: scale, orientation, and dependence
    - Mahalanobis distance follows covariance geometry
    - High-dimensional Gaussian mass concentrates in a shell
    - Marginals retain covariance blocks
    - Conditionals are Gaussian with shifted mean and reduced covariance
  ],
)

#speaker-note[
  The section's endpoint is the Gaussian conditioning rule: marginals retain
  covariance blocks, while conditioning shifts the mean and reduces remaining
  uncertainty according to the observed variables.
]

#section-metadata(
  short-title: [Missing values],
  subtitle: [Inference about hidden entries by conditioning],
)

= Missing values as Gaussian conditioning

== Visible and hidden entries

#content-block(
  layout: "top",
  object-width: 92%,
  object: [
    #grid(
      columns: (1fr, 0.18fr, 1fr, 0.18fr, 1fr),
      gutter: 0.3em,
      align: center + horizon,
      schema-node([$y = (y_v, y_h)$], [$"vector"$]),
      schema-arrow,
      schema-node([$y_v$], [$"visible"$], fill: palette.paper),
      schema-arrow,
      schema-node([$p(y_h | y_v, theta)$], [$"hidden entries"$]),
    )
    #v(0.85em)
    #align(center)[$p(y_h | y_v, theta)$]
  ],
)

#speaker-note[
  Missing-value imputation is simply inference about the hidden partition of a
  vector conditional on the visible partition. Avoid missingness mechanisms and
  full imputation workflows here.
]

== Summary: Missing values as conditioning

#content-block(
  key-points: [
    - Partition a vector into visible entries $y_v$ and hidden entries $y_h$
    - Infer hidden entries with $p(y_h | y_v, theta)$
    - Gaussian conditioning supplies this distribution analytically
  ],
)

#speaker-note[
  This brief section concludes that missing-value inference is Gaussian
  conditioning on hidden entries. The visible/hidden partition states the
  problem cleanly, and the conditional distribution supplies the imputation
  target.
]

#section-metadata(
  short-title: [LGS],
  subtitle: [Latent state, observation, and Gaussian posterior],
)

= Linear Gaussian systems

== Linear Gaussian model

#content-block(
  layout: "top",
  object-width: 92%,
  object: [
    #grid(
      columns: (1fr, 0.2fr, 1fr),
      gutter: 0.4em,
      align: center + horizon,
      schema-node([$z tilde cal(N)(mu_z, Sigma_z)$], [$"latent state"$]),
      uncover("2-")[#schema-arrow],
      uncover("2-")[
        #schema-node([$y | z tilde cal(N)(W z+b, Sigma_y)$], [$"observation"$], fill: palette.paper)
      ],
    )
    #v(0.9em)
    #align(center)[$p(z,y) = p(z)p(y|z)$]
  ],
)

#speaker-note[
  This is the first complete inference machine. A Gaussian prior over the
  state and a linear Gaussian observation model together imply a joint
  Gaussian distribution.
]

== Joint Gaussian form

#content-block(
  layout: "top",
  object-width: 96%,
  object: [
    #align(center)[$mu = mat(mu_z; W mu_z + b)$]
    #v(0.55em)
    #align(center)[$Sigma = mat(Sigma_z, Sigma_z W^T; W Sigma_z, Sigma_y + W Sigma_z W^T)$]
    #v(0.85em)
    #align(center)[$mat(z; y) tilde cal(N)(mu, Sigma)$]
  ],
)

#speaker-note[
  Show how the prior covariance propagates through the linear map and combines
  with observation noise. Do not derive the block covariance on the slide.
]

== Posterior state

#content-block(
  layout: "top",
  object-width: 96%,
  object: [
    #align(center)[$p(z | y) = cal(N)(z | mu_(z|y), Sigma_(z|y))$]
    #uncover("2-")[
      #v(0.65em)
      #align(center)[$Lambda_(z|y) = Sigma_z^(-1) + W^T Sigma_y^(-1) W$]
    ]
    #uncover("3-")[
      #v(0.35em)
      #align(center)[$Sigma_(z|y) = Lambda_(z|y)^(-1)$]
    ]
    #uncover("4-")[
      #v(0.35em)
      #align(center)[$mu_(z|y) = Sigma_(z|y)(W^T Sigma_y^(-1)(y-b) + Sigma_z^(-1) mu_z)$]
    ]
  ],
)

#speaker-note[
  The posterior is Gaussian because this is just Gaussian conditioning. The
  precision form makes the update look like added information from prior and
  observation.
]

== Sensor fusion

#content-block(
  layout: "top",
  object-width: 96%,
  object: [
    #grid(
      columns: (1fr, 0.2fr, 1fr, 0.2fr, 1fr),
      gutter: 0.3em,
      align: center + horizon,
      schema-node([Prior], [$cal(N)(z | mu_z, Sigma_z)$]),
      align(center + horizon)[#text(size: 1.1em, fill: palette.accent)[$times$]],
      schema-node([Measurement], [$cal(N)(y | W z+b, Sigma_y)$], fill: palette.paper),
      align(center + horizon)[#text(size: 1.1em, fill: palette.accent)[$prop$]],
      schema-node([Posterior], [$cal(N)(z | mu_(z|y), Sigma_(z|y))$]),
    )
    #v(0.8em)
    #align(center)[$Sigma_(z|y)^(-1) = Sigma_z^(-1) + W^T Sigma_y^(-1) W$]
  ],
)

#speaker-note[
  This is sensor fusion in probabilistic form. Reliable measurements contribute
  more precision and shrink the posterior uncertainty more strongly.
]

== Summary: Linear Gaussian systems

#content-block(
  key-points: [
    - Prior: $p(z) = cal(N)(z | mu_z, Sigma_z)$
    - Observation: $p(y | z) = cal(N)(y | W z+b, Sigma_y)$
    - Joint model: $p(z,y) = p(z)p(y|z)$
    - Posterior: $p(z|y)$ is Gaussian
    - Precision adds information from the prior and observation
  ],
)

#speaker-note[
  This is the final worked architecture for Lecture 1. It assembles task
  notation, moments, covariance, Gaussian geometry, and conditioning.
]

== Lecture 1 summary

#content-block(
  key-points: [
    - ML tasks specify observed quantities, unknown quantities, and required outputs
    - Moments and conditional moments describe probabilistic summaries
    - Categorical, multinomial, and softmax distributions describe labels
    - Covariance gives multivariate geometry
    - Gaussian marginalization and conditioning are reusable inference machinery
    - Linear Gaussian systems provide the first complete inference machine
  ],
)

#speaker-note[
  End by naming the linear Gaussian system as a composition of familiar pieces.
  The lecture has moved from learning tasks and data to probability objects and
  conditioning, ending with a complete inference machine.
]
