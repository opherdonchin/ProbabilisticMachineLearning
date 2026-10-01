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
      #uncover("3-")[
        #v(0.65em)
        Code heads as $y_i = 1$ and tails as $y_i = 0$\
        $N_1 = sum_(i=1)^N y_i, quad N_0 = N - N_1$
      ]
    ]
  ],
  key-points: [
    - A statistical model has data and unknown parameters
    #uncover("2-")[
      - How could observed data ($y$) have been generated.
      - What does it tell us about the parameters ($theta$)
    ]
    #uncover("3-")[
      - $N_1$ and $N_0$ count heads and tails in the observed sample
    ]
  ],
)

#speaker-note[
  Reactivate the familiar coin model and distinguish the individual binary
  outcomes from their aggregate counts. Each $y_i$ is a Bernoulli outcome;
  $N_1$ and $N_0$ count observed heads and tails.
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
        - Bernoulli for each yes/no outcome; Binomial for the count $N_1$.
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
          uncover("3-")[$ p(y | theta) prop theta^(N_1) (1-theta)^(N_0) $],
          uncover("5-")[#text(weight: "semibold", fill: palette.accent)[Posterior]],
          uncover("5-")[$ p(theta | y) = "Beta"(alpha + N_1, beta + N_0) $],
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
  adds the observed counts $N_1$ and $N_0$ to the two Beta parameters. The
  individual $y_i$ are Bernoulli; their aggregate $N_1$ has a Binomial sampling
  distribution. There is no need to derive the result here.
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
  $hat(p)_N (x) = 1/N sum_(n=1)^N delta_(x^(n))(x)$.
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
      #text(size: 1.5em)[
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

== A few key operations underlie many machine learning tasks

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
          spacing: 0.55em,
          [$s(x_"obs") = integral.double g(y_*) p_D (z, y_* | x_"obs") dif z dif y_*$],
          [weighted summary of the target],
        )],
        density: "prose",
      ),
      uncover("2-")[
        #schema-node(
          [Marginalize],
          [#stack(
            spacing: 0.55em,
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
            spacing: 0.55em,
            [$p_D (z | x_"obs") = frac(p_D (x_"obs", z), integral p_D (x_"obs", z') dif z')$],
            [infer the latent variable from observations],
          )],
          density: "prose",
        )
      ],
    )
  ],
  key-points: [
    - Almost all machine learning tasks require an integral
    - Latent variables are inferred or averaged out
    - Much methodology addresses computing these integrals efficiently
  ],
)

#speaker-note[
  Reveal one operation at a time from the joint distribution. The first integral
  summarizes the target by averaging over both target and latent variables. The
  second integrates out the latent variable; the third normalizes the marginal
  joint to infer that variable from the observed values.
]

// Compact reminders of the three operations introduced in this lecture.
#let operation-cue(label, formula, fill: palette.accent.lighten(87%)) = align(right)[
  #box(width: 32%)[
    #text(size: 0.56em)[
      #schema-node(label, formula, fill: fill)
    ]
  ]
]

#let summarize-formula = [$E[g(X)] = integral g(x) p(x) dif x$]
#let marginalize-formula = [$p(x) = integral p(x, y) dif y \ p(y) = integral p(x, y) dif x$]
#let condition-formula = [$ p(x | y) = frac(p(x, y), p(y)) $]

#let summarize-cue = operation-cue([Summarize], summarize-formula)
#let marginalize-cue = operation-cue(
  [Marginalize],
  marginalize-formula,
  fill: palette.paper,
)
#let condition-cue = operation-cue([Condition], condition-formula)

== Generalize the operations using generic random variables 

#content-block(
  layout: "top",
  object-width: 96%,
  object: [
    #align(center)[$X$ and $Y$ have joint density $p(x, y)$]
    #v(0.6em)
    #grid(
      columns: (1fr, 1fr, 1fr),
      gutter: 0.7em,
      align: center + horizon,
      schema-node([Summarize], summarize-formula, density: "prose"),
      schema-node([Marginalize], marginalize-formula, density: "prose", fill: palette.paper),
      schema-node([Condition], condition-formula, density: "prose"),
    )
  ],
  key-points: [
    - The same operations apply to any pair of random variables $X$ and $Y$
    - Lowercase $x$ and $y$ are possible values; conditioning fixes $Y=y$

    - The normalizer  is another marginal
  ],
)

#speaker-note[
  Make the notation change explicit. The observed, latent, and target roles in
  the previous slide motivated the operations; $X$ and $Y$ now stand for any
  pair of random variables. The three formulas are generic versions of the
  same operations. For discrete variables, replace integrals with sums.
]

#section-metadata(
  short-title: [Probabilistic modelling],
  subtitle: [Probabilistic models update based on data],
)

== Expectation is a summarizing integral

#summarize-cue

#content-block(
  layout: "top",
  object-width: 92%,
  object: [
    #twocol(
      schema-node(
        [Continuous],
        summarize-formula,
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

== Integrals create linearity

#summarize-cue

#content-block(
  layout: "top",
  object-width: 90%,
  object: [
    #align(center)[$E[a X + b] = a E[X] + b$]
    #v(0.9em)
    #align(center)[$E[sum_i X_i] = sum_i E[X_i]$]
    #v(1.5em)
    #align(center)[$E[product_(i=1)^n X_i] = product_(i=1)^n E[X_i]$ for independent $X_1, dots, X_n$]
  ],
  key-points: [
    - Expectations of sums are sums of expectations
    - Independence is not required for sums
    - Expectations of products factor when the variables are independent
  ],
)

#speaker-note[
  Keep this slide separate from the definition of expectation. The teaching
  move is computational: expectation respects linear combinations even when the
  random variables are dependent. Contrast this with products: their expectations
  factor under independence, not by linearity.
]

== Variance is another integral

#summarize-cue

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
    - The second raw moment contains both spread and location
  ],
)

#speaker-note[
  The alternative variance identity introduces $E[X^2]$ naturally. Together,
  the mean, variance, and raw second moment show that distribution summaries can
  be organized by the powers of the random variable they average.
]

== Mean and variance are the first two moments 

#summarize-cue

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
          [$m_1 = E[X]$],
          [$m_2 = E[X^2]$],
          [$m_k = E[X^k]$],
        )],
      ),
      schema-node(
        [Central moments],
        [#stack(
          spacing: 0.5em,
          [$mu_2 =  E[(X-E[X])^2] = V[X]$],
          [$mu_k = E[(X-E[X])^k]$],
        )],
        fill: palette.paper,
      ),
    )
  ],
  key-points: [
    - A moment is a property of a probability distribution
    - Central moments are moments of deviation from the mean
  ],
)

#speaker-note[
  This slide supplies the missing vocabulary. Students have already seen the
  first raw moment, second raw moment, and second central moment. Name the
  general pattern without opening a catalogue of skewness, kurtosis, or moment
  generating functions.
]

== Conditioning is a special case of summarizing

#condition-cue

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
        [$p(x | y)$],
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

#marginalize-cue

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
  short-title: [Univariate Gaussian],
  subtitle: [Density, cumulative probability, and a point-mass limit],
)

= The univariate Gaussian

#speaker-note[
  Introduce the Gaussian while probability distributions are still treated
  as given. This gives a concrete continuous model before the statistics
  section asks how its parameters can be estimated from data. The limiting
  case also explains the point-mass notation used in probability models.
]

== A Gaussian density has a center and a spread

#content-block(
  layout: "top",
  object-width: 92%,
  object: [
    #align(center)[$Y tilde cal(N)(mu,sigma^2)$]
    #v(0.8em)
    #align(center)[$cal(N)(y | mu,sigma^2)=frac(1,sqrt(2 pi sigma^2)) exp(-frac((y-mu)^2,2 sigma^2))$]
    #source-note[Murphy, Book 1 §2.6.2, Eq. 2.112; Book 2 §2.2.2.1]
  ],
  key-points: [
    - $mu$ is the mean and mode; $sigma^2$ is the variance
    - The exponent penalizes squared distance from the mean
    - $lambda=1/sigma^2$ is the precision
  ],
)

#speaker-note[
  Connect the parameters to the moment language students already saw.
  A larger variance produces a wider, lower density; a smaller variance
  produces a narrower, taller one because the total area stays one.
  Precision is useful when we later combine Gaussian information.
]

== The CDF turns density into interval probability

#content-block(
  layout: "top",
  object-width: 92%,
  object: [
    #align(center)[$Phi(x;mu,sigma^2)=integral_(-infinity)^x cal(N)(z | mu,sigma^2) dif z$]
    #v(0.75em)
    #align(center)[$Pr(a < Y <= b)=Phi(b;mu,sigma^2)-Phi(a;mu,sigma^2)$]
    #source-note[Murphy, Book 2 §2.2.2.1, Eq. 2.28; Book 1 §2.6.2]
  ],
  key-points: [
    - Density at one point is not a point probability
    - Probability is area under the density over an interval
  ],
)

#speaker-note[
  The CDF integrates the density up to x. Subtracting CDF values gives
  interval probability. This distinction matters for understanding why a
  limiting Gaussian can become concentrated at one point even though the
  density height itself is not a probability.
]

== Shrinking variance concentrates Gaussian mass at one value

#content-block(
  layout: "top",
  object-width: 90%,
  object: [
    #align(center)[$lim_(sigma arrow.r 0) cal(N)(y | mu,sigma^2)=delta(y-mu)$]
    #v(0.8em)
    #align(center)[$Pr(mu-epsilon < Y < mu+epsilon) arrow.r 1 quad (epsilon>0)$]
    #source-note[Murphy, Book 1 §2.6.5, Eq. 2.124]
  ],
  key-points: [
    - The distribution becomes a point mass at $mu$
    - The peak grows while the mass outside any fixed neighborhood vanishes
  ],
)

#speaker-note[
  The displayed limit is a limit of distributions, not an ordinary
  pointwise limit of finite density values. For any fixed positive
  neighborhood of mu, its probability tends to one. This is a convenient
  way to motivate a deterministic value inside probabilistic notation.
]

== The Dirac delta encodes a point mass

#content-block(
  layout: "top",
  object-width: 92%,
  object: [
    #align(center)[$delta_mu (y)=delta(y-mu), quad integral_(-infinity)^infinity delta(y-mu) dif y=1$]
    #v(0.75em)
    #align(center)[$integral_(-infinity)^infinity f(y) delta(y-mu) dif y=f(mu)$]
    #source-note[Murphy, Book 1 §2.6.5, Eqs. 2.125–2.128]
  ],
  key-points: [
    - Informally, the spike is zero away from $mu$ and carries unit mass at $mu$
    - The integral identity is the precise rule used in calculations
  ],
)

#speaker-note[
  Book 1 describes the delta with an infinite spike at zero, and uses the
  shifted notation delta_mu(y)=delta(y-mu). Explain that the infinity-at-a-point
  picture is shorthand: delta is a generalized function or probability
  measure, not an ordinary finite-valued density. Its defining action is the
  integral identity, which selects f(mu).
]

== Summary: The univariate Gaussian

#content-block(
  key-points: [
    - $cal(N)(mu,sigma^2)$ describes a continuous quantity through center and spread
    - The CDF converts density into event probabilities
    - As $sigma^2$ vanishes, the Gaussian approaches a point mass
  ],
)

#speaker-note[
  Close the probability-only treatment with the distribution, its cumulative
  probability, and its point-mass limit. The final statement prepares the
  statistics question without turning this summary into a preview slide.
]

#section-metadata(
  short-title: [From data to unknowns],
  subtitle: [Estimating unknown quantities from observed data],
)

= Inverse probability

== The goal is to learn from data

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

== A statistic is something calculated on observed data

#content-block(
  layout: "top",
  object-width: 94%,
  object: [
    #align(center)[$D arrow.r T(D)$]
    #v(0.8em)
    #grid(
      columns: (1fr, 1fr),
      gutter: 0.9em,
      align: center + horizon,
      schema-node(
        [Continuous measurements],
        [#stack(
          spacing: 1em,
          [$D_x = (x_1, dots, x_N)$],
          [$overline(x) = frac(1, N) sum_(n=1)^N x_n$],
        )],
      ),
      schema-node(
        [Bernoulli tosses, Binomial count],
        [#stack(
          spacing: 1em,
          [$D_y = (y_1, dots, y_N)$],
          [Each $y_n$ is $0$ or $1$],
          [$N_1 = sum_(n=1)^N y_n, quad N_0 = N - N_1$],
        )],
        fill: palette.paper,
      ),
    )
  ],
  key-points: [
    - The sample mean and coin counts are both statistics computed from data
    - A statistic's definition must not contain an unknown parameter
  ],
)

#speaker-note[
  Use $x_n$ for continuous measurements and $y_n$ for binary coin outcomes so
  the change of sampling model is visible. The count $N_1$ is Binomial under
  the coin model, while its observed value is computed from the binary sample.
  Both the sample mean and the counts are statistics: functions of data, not
  necessarily estimators.
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
    - $theta$ will generally be an integral over the distribution as before
    - The estimate $hat(theta)$ is calculated on the data
      - Different estimates can target the same parameter
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
      row-gutter: 0.9em,
      align: center + horizon,
      schema-node(
        [Population raw moment],
        [$m_k = E[X^k]$],
        fill: palette.paper,
      ),
      schema-arrow,
      schema-node(
        [Sample raw moment],
        [$hat(m)_k = frac(1, N) sum_(n=1)^N x_n^k$],
      ),
      schema-node(
        [Population central moment],
        [$mu_k = E[(X - E[X])^k]$],
        fill: palette.paper,
      ),
      schema-arrow,
      schema-node(
        [Sample central moment],
        [$hat(mu)_k = frac(1, N) sum_(n=1)^N (x_n - overline(x))^k$],
      ),
    )
  ],

)

#speaker-note[
  Compare each population moment with the matching function of the observed
  sample. Raw moments average powers; central moments first subtract the
  population mean $E[X]$ or the sample mean $overline(x)$. The sample formula
  uses $1/N$ because it defines a sample central moment, not the unbiased
  sample variance estimator.
]

#section-metadata(
  short-title: [Likelihood estimation],
  subtitle: [Maximum likelihood as empirical risk minimization with log loss],
)

= Methods of building estimators

#speaker-note[
  The previous section distinguished a population quantity from a statistic
  computed on data. Recall the empirical-risk framework from the earlier
  machine-learning section, then show that a probabilistic model supplies a
  particular loss whose minimizer is the maximum-likelihood estimate.
]

== Recall: empirical risk minimizes average loss

#content-block(
  layout: "top",
  object-width: 92%,
  object: [
    #align(center)[$L(theta) = frac(1,N) sum_(n=1)^N ell(x_n,y_n;theta) \ quad hat(theta) = arg min_(theta) L(theta)$]
    #source-note[Murphy, Book 1 §§1.2.1.2 and 4.1]
  ],
  key-points: [
    - Empirical risk and the loss function were introduced in the section "From Statistics to Machine learning"
      - The loss function supports evaluation of performance
        - Machine learning is improved *performance* on a *task* with increase in *experience*
  ],
)

#speaker-note[
  Treat this as a reminder, not a new definition. Slide 18 already introduced
  a per-case loss, empirical risk, and empirical risk minimization. The only
  extension here is to use the same construction for parameter estimation.
  Different losses produce different estimators, and a point estimate still
  does not describe uncertainty about its value.
]

== MLE is a special case of empirical risk minimization

#content-block(
  layout: "top",
  object-width: 96%,
  object: [
    #align(center)[$ell_"log" (x_n,y_n;theta) = -log p(y_n | x_n,theta)$]
    #pause
    #v(0.55em)
    #align(center)[
      #touying-equation(`
        arg min_(theta) frac(1,N) sum_(n=1)^N [-log p(y_n | x_n,theta)] & pause = arg max_(theta) sum_(n=1)^N log p(y_n | x_n,theta) \
        & pause = arg max_(theta) product_(n=1)^N p(y_n | x_n,theta) \
        & pause = arg max_(theta) p(D | theta) \
        & pause = hat(theta)_"MLE"
      `)
    ]
  ],
  key-points: [
    - Negative log probability is the per-case loss
      - The MLE is the minimizer of the empirical risk with log loss
  ],
)

#speaker-note[
  This derives Murphy, Book 1 §4.2.1, Eqs. 4.2–4.6 from the familiar ERM
  template rather than introducing likelihood first. A probabilistic predictor
  assigns a probability to the observed target; negative log probability is
  its per-case loss. Scaling by the positive constant $1/N$ does not change the
  minimizer, negation changes a minimum to a maximum, and the logarithm turns
  the sum into a product. The final equality uses conditional independence
  across cases. Only at the end name this optimizer maximum likelihood
  estimation.
]

== The modeled variables determine log loss

#content-block(
  layout: "top",
  object-width: 94%,
  object: [
    #triad[
      *Conditional*\
      $ell_n (theta) = -log p(y_n | x_n,theta)$
    ][
      *Unconditional*\
      $ell_n (theta) = -log p(y_n | theta)$
    ][
      *Joint*\
      $ell_n (theta) = -log p(x_n,y_n | theta)$
    ]
  ],
  key-points: [
    - Each choice becomes an empirical-risk objective by averaging the per-case losses
    - Treating an input as given or modeling it jointly is a modeling decision
  ],
)

#speaker-note[
  Extend the log-loss construction without restarting the MLE derivation; the
  unconditional and joint forms correspond to Murphy, Book 1 §4.2.1, Eqs.
  4.7–4.8. Conditional prediction scores y given x; an unconditional model
  scores y; a joint model scores x and y together. In every case, averaging the
  displayed per-case loss gives the objective. The difference is which
  variables the model treats as generated, not how probabilistic the model is.
]

== Bernoulli likelihood starts with individual tosses

#content-block(
  layout: "top",
  object-width: 94%,
  object: [
    #align(center)[$"NLL"(theta) = -log product_(n=1)^N p(y_n | theta)$]
    #uncover("2-")[
      #v(0.8em)
      #align(center)[$= -log product_(n=1)^N theta^(II(y_n=1)) (1-theta)^(II(y_n=0))$]
    ]
    #source-note[Murphy, Book 1 §4.2.3, Eqs. 4.20–4.21]
  ],
  key-points: [
    - Reuse the coin model: $y_n=1$ for heads, $y_n=0$ for tails
    #uncover("2-")[- $II(A)$ equals one when $A$ is true and zero otherwise]
  ],
)

#speaker-note[
  Return to the Beta-Bernoulli example from the start of the lecture. The
  indicators select theta for a head and 1-theta for a tail. This is a
  likelihood for the individual Bernoulli observations, even though its value
  can later be summarized by the two counts.
]

== The two coin counts summarize the likelihood

#content-block(
  layout: "top",
  object-width: 90%,
  object: [
    #align(center)[$N_1 = sum_(n=1)^N I(y_n=1), quad N_0 = sum_(n=1)^N I(y_n=0)$]
    #v(0.8em)
    #align(center)[$"NLL"(theta) = -[N_1 log theta + N_0 log(1-theta)]$]
    #source-note[Murphy, Book 1 §4.2.3, Eq. 4.23]
  ],
  key-points: [
    - Once the model is fixed, the order of heads and tails does not affect this likelihood
    - $N=N_0+N_1$ is the sample size
  ],
)

#speaker-note[
  Explain the step from a product over tosses to counts without adding the
  intermediate equation omitted from the requested coverage. For this model,
  N_1 and N_0 contain the data information needed for estimating theta.
]

== The likelihood estimate is the observed head fraction

#content-block(
  layout: "top",
  object-width: 92%,
  object: [
    #align(center)[$frac(d, d theta) "NLL"(theta) = -frac(N_1, theta) + frac(N_0, 1-theta)$]
    #uncover("2-")[
      #v(0.85em)
      #align(center)[$hat(theta)_"MLE" = frac(N_1, N_0+N_1) = frac(N_1, N)$]
    ]
    #source-note[Murphy, Book 1 §4.2.3, Eqs. 4.24–4.25]
  ],
  key-points: [
    - Set the interior derivative to zero and solve for $theta$
    #uncover("2-")[- The boundary cases give zero or one when all tosses agree]
  ],
)

#speaker-note[
  Work through the algebra aloud: N_1(1-theta)=N_0 theta, then theta=N_1/N.
  The derivative argument assumes an interior solution. If all observations are
  heads or all tails, the optimum is at the boundary; the same fraction still
  gives the MLE.
]

== Gaussian likelihood fits location and spread

#content-block(
  layout: "top",
  object-width: 94%,
  object: [
    #align(center)[$Y_n tilde cal(N)(mu, sigma^2)$]
    #v(0.75em)
    #align(center)[$"NLL"(mu,sigma^2) = -sum_(n=1)^N log (frac(1, sqrt(2 pi sigma^2)) exp(-frac((y_n-mu)^2, 2 sigma^2)))$]
    #uncover("2-")[
      #v(0.8em)
      #align(center)[$= frac(1, 2 sigma^2) sum_(n=1)^N (y_n-mu)^2 + frac(N,2) log(2 pi sigma^2)$]
    ]
    #source-note[Murphy, Book 1 §4.2.5, Eqs. 4.32–4.33]
  ],
  key-points: [
    - The NLL balances residual size with the proposed variance
  ],
)

#speaker-note[
  Contrast with the Bernoulli: now theta has two components, location and
  spread. The expanded NLL shows why making sigma arbitrarily large does not
  remove the cost of the residuals: the log variance term also rises.
]

== Stationarity gives the Gaussian mean estimate

#content-block(
  layout: "top",
  object-width: 90%,
  object: [
    #align(center)[$frac(partial, partial mu) "NLL"(mu,sigma^2)=0, quad frac(partial, partial sigma^2) "NLL"(mu,sigma^2)=0$]
    #uncover("2-")[
      #v(0.9em)
      #align(center)[$hat(mu)_"MLE" = frac(1,N) sum_(n=1)^N y_n = overline(y)$]
    ]
    #source-note[Murphy, Book 1 §4.2.5, Eqs. 4.34–4.35]
  ],
  key-points: [
    - The optimum must be stationary in both parameters
    #uncover("2-")[- The fitted Gaussian is centered at the sample mean]
  ],
)

#speaker-note[
  Differentiate with respect to mu first. The common sigma factor cancels,
  leaving the average of the observed values. The variance equation is solved
  on the next slide; this is one joint optimization problem, not two unrelated
  rules.
]

== Gaussian MLE uses the average squared deviation

#content-block(
  layout: "top",
  object-width: 93%,
  object: [
    #align(center)[$s^2 = frac(1,N) sum_(n=1)^N y_n^2$]
    #v(0.75em)
    #align(center)[$
      hat(sigma^2)_"MLE"
      = frac(1,N) sum_(n=1)^N (y_n-hat(mu)_"MLE")^2
      = frac(1,N) sum_(n=1)^N (y_n^2+hat(mu)_"MLE"^2-2 y_n hat(mu)_"MLE")
    $]
    #uncover("2-")[
      #v(0.75em)
      #align(center)[$hat(sigma^2)_"MLE" = s^2 - overline(y)^2$]
    ]
    #source-note[Murphy, Book 1 §4.2.5, Eqs. 4.36–4.37]
  ],
  key-points: [
    - This MLE averages over $N$ observed values
    #uncover("2-")[- The first two sample raw moments determine both estimates]
  ],
)

#speaker-note[
  Equation 4.36 is shown as both the deviation form and its expanded form;
  Equation 4.37 defines s squared. Substitute the sample mean to obtain
  s squared minus y-bar squared. Do not add Book 1 Eq. 4.38, which the brief
  explicitly excludes.
]

== Likelihood turns a sampling model into fitted parameters

#content-block(
  layout: "top",
  object-width: 92%,
  object: [
    #twocol[
      *Bernoulli*\
      $hat(theta)_"MLE" = N_1/N$
    ][
      *Gaussian*\
      $hat(mu)_"MLE" = overline(y)$\
      $hat(sigma^2)_"MLE" = s^2-overline(y)^2$
    ]
  ],
  key-points: [
    - The model determines the likelihood; the observed sample determines its maximum
    - The resulting estimates are functions of the data
  ],
)

#speaker-note[
  Close the section by connecting the worked examples to the estimator
  definition immediately before it. Their formulas differ because their
  sampling models differ. Both return point estimates from the observed data.
]

#section-metadata(
  short-title: [Moment matching],
  subtitle: [Estimating parameters by matching model and sample summaries],
)

= Method of moments

#speaker-note[
  We have used the familiar empirical-risk framework and shown that log loss
  yields MLE. Now introduce one genuinely different construction: choose
  parameters by equating model moments with their sample counterparts.
]

== Method of moments solves matching equations

#content-block(
  layout: "top",
  object-width: 93%,
  object: [
    #align(center)[$m_k (theta) = E_theta [Y^k], quad hat(m)_k = frac(1,N) sum_(n=1)^N y_n^k$]
    #uncover("2-")[
      #v(0.8em)
      #align(center)[$m_k (theta) = hat(m)_k, quad k=1,dots,K$]
    ]
    #source-note[Murphy, Book 1 §4.4.1, Eq. 4.68]
  ],
  key-points: [
    - Use as many moment equations as parameters to be estimated
    #uncover("2-")[- Solve for the parameters whose model moments match the sample moments]
  ],
)

#speaker-note[
  Book 1 uses mu_k for a raw moment here; these slides retain m_k from the
  preceding probability section, where mu_k denoted a central moment. Only
  the notation changes. Computational ease is a reason to try moment matching,
  but it can have costs.
]

== Gaussian moments recover the likelihood estimates

#content-block(
  layout: "top",
  object-width: 92%,
  object: [
    #align(center)[Match each model moment to its sample counterpart.]
    #v(0.65em)
    #align(center)[$E[Y] = mu = overline(y)$]
    #v(0.8em)
    #align(center)[$E[Y^2] = sigma^2 + mu^2 = s^2$]
    #uncover("2-")[
      #v(0.8em)
      #align(center)[$hat(mu)_"MOM" = overline(y), quad hat(sigma^2)_"MOM" = s^2-overline(y)^2$]
    ]
    #source-note[Murphy, Book 1 §4.4.1.1, Eqs. 4.69–4.70]
  ],
  key-points: [
    - Match the first two raw moments to estimate two parameters
    #uncover("2-")[- For this Gaussian model, MOM and MLE coincide]
  ],
)

#speaker-note[
  Work from the first moment to mu, then use the second moment to solve for
  sigma squared. The agreement with MLE is specific to this model, not a
  general property of method of moments.
]

== A uniform model has two unknown endpoints

#content-block(
  layout: "top",
  object-width: 94%,
  object: [
    #align(center)[$Y tilde "Unif"(theta_1,theta_2), quad p(y|theta) = frac(1,theta_2-theta_1) I(theta_1 <= y <= theta_2)$]
    #v(0.8em)
    #twocol[
      *First raw moment*\
      $m_1 = E[Y] = frac(theta_1+theta_2,2)$
    ][
      *Second raw moment*\
      $m_2 = E[Y^2] = frac(theta_1^2+theta_1 theta_2+theta_2^2,3)$
    ]
    #source-note[Murphy, Book 1 §4.4.1.2, Eqs. 4.71–4.73]
  ],
  key-points: [
    - Two unknown endpoints require two moment equations
  ],
)

#speaker-note[
  The uniform density is zero outside the endpoints. The first moment locates
  the midpoint; the second gives information about spread. Keep that support
  constraint in mind when the estimates are checked against actual observations.
]

== Inverting the moments gives endpoint estimates

#content-block(
  layout: "top",
  object-width: 92%,
  object: [
    #align(center)[$theta_1 = m_1 - sqrt(3(m_2-m_1^2))$]
    #v(0.75em)
    #align(center)[$theta_2 = 2m_1-theta_1 = m_1 + sqrt(3(m_2-m_1^2))$]
    #uncover("2-")[
      #v(0.8em)
      #align(center)[Replace $m_1,m_2$ with the observed sample moments.]
    ]
    #source-note[Murphy, Book 1 §4.4.1.2, Eq. 4.74]
  ],
  key-points: [
    - The midpoint is the mean; the half-width comes from the variance
    #uncover("2-")[- An algebraic solution still needs a model check]
  ],
)

#speaker-note[
  Show the symmetry of the two estimates around m_1. The half-width is
  sqrt(3 times the population variance). Then insert the empirical moments to
  get an estimator. The next slide tests whether it defines a plausible
  sampling model for the actual data.
]

== Moment matching can contradict an observation

#content-block(
  layout: "top",
  object-width: 92%,
  object: [
    #align(center)[$D=(0,0,0,0,1), quad hat(m)_1=hat(m)_2=0.2$]
    #v(0.75em)
    #align(center)[$hat(theta)_1 approx -0.493, quad hat(theta)_2 approx 0.893$]
    #uncover("2-")[
      #v(0.85em)
      #align(center)[The fitted interval ends at $0.893$, but the sample contains $1$.]
    ]
    #source-note[Murphy, Book 1 §4.4.1.2]
  ],
  key-points: [
    - The method-of-moments estimate assigns zero probability to an observed value
    #uncover("2-")[- Matching selected summaries need not fit the full sample]
  ],
)

#speaker-note[
  Calculate the mean and second raw moment directly: one of five values is 1,
  so both equal 1/5. Substitution gives the displayed endpoints. The upper
  endpoint is below the observed maximum; this is a concrete failure, not a
  small numerical discrepancy.
]

== Uniform likelihood must contain every observation

#content-block(
  layout: "top",
  object-width: 94%,
  object: [
    #align(center)[$p(D | theta) = (theta_2-theta_1)^(-N) I(y_((1)) >= theta_1) I(y_((N)) <= theta_2)$]
    #uncover("2-")[
      #v(0.8em)
      #align(center)[$Delta=theta_2-theta_1, quad frac(d, d Delta) log p(D|theta) = -frac(N,Delta) < 0$]
    ]
    #uncover("3-")[
      #v(0.75em)
      #align(center)[$hat(theta)_1 = y_((1)), quad hat(theta)_2 = y_((N))$]
    ]
    #source-note[Murphy, Book 1 §4.4.1.2, Eqs. 4.75–4.77]
  ],
  key-points: [
    - The indicators enforce support for the smallest and largest observations
    #uncover("3-")[- Among valid intervals, likelihood chooses the narrowest one]
  ],
)

#speaker-note[
  Ordered observations are denoted y_(1) and y_(N). For any interval that
  contains them, the log likelihood decreases with its width. Therefore the
  MLE places its endpoints at the observed minimum and maximum. For the five
  values on the previous slide, it returns [0,1].
]

== The objective determines which data features matter

#content-block(
  layout: "top",
  object-width: 93%,
  object: [
    #twocol[
      *Moments*\
      Match selected averages to model expectations.
    ][
      *Likelihood*\
      Score the probability of the whole observed sample.
    ]
  ],
  key-points: [
    - The Gaussian example gave the same estimates by both routes
    - The uniform example exposed a support failure of moment matching
  ],
)

#speaker-note[
  Close the section with the principle established by the examples. ERM allows
  a chosen loss; MOM matches selected summaries; MLE follows the full sampling
  model. There is no need to claim one objective is always best.
]

#section-metadata(
  short-title: [MAP and regularization],
  subtitle: [Point estimation with a prior, then a broader penalty view],
)

= MAP and regularization

#speaker-note[
  First derive MAP from the familiar posterior, using the coin model. Only
  after that introduce regularization as a wider way to modify a fitting
  objective. This order is deliberate: the prior is not introduced as a penalty.
]

== A perfect fit to three tosses makes a brittle prediction

#content-block(
  layout: "top",
  object-width: 92%,
  object: [
    #align(center)[$D=(1,1,1), quad hat(theta)_"MLE" = 3/3 = 1$]
    #uncover("2-")[
      #v(0.9em)
      #align(center)[$p(y_"next"=0 | hat(theta)_"MLE") = 0$]
    ]
    #source-note[Murphy, Book 1 §4.5]
  ],
  key-points: [
    - Three observed heads do not establish that tails are impossible
    #uncover("2-")[- This training fit is overconfident about unseen tosses]
  ],
)

#speaker-note[
  Reuse the coin model. The MLE fits these three observations exactly, but its
  plug-in prediction puts zero probability on a tail. The issue is learning
  from a small sample and then generalizing beyond it, not a failure of the
  Bernoulli model itself.
]

== MAP chooses one value from the posterior

#content-block(
  layout: "top",
  object-width: 93%,
  object: [
    #align(center)[$p(theta | D) prop p(D | theta) p(theta)$]
    #uncover("2-")[
      #v(0.85em)
      #align(center)[$hat(theta)_"MAP" = arg max_(theta) p(theta | D) = arg max_(theta) [log p(D|theta)+log p(theta)]$]
    ]
    #source-note[Murphy, Book 1 §4.5, Eq. 4.92]
  ],
  key-points: [
    - The posterior combines the same likelihood with a prior
    #uncover("2-")[- MAP reports its mode, so it remains a point estimator]
  ],
)

#speaker-note[
  Students already know the posterior from the opening Beta-Bernoulli slides.
  MAP is the parameter value at its peak. The normalizing probability of D
  does not depend on theta, so it drops out of the argmax. A posterior mode
  does not communicate the posterior's width.
]

== The Beta prior changes the coin objective

#content-block(
  layout: "top",
  object-width: 94%,
  object: [
    #align(center)[$theta tilde "Beta"(alpha,beta), quad alpha,beta>1$]
    #v(0.8em)
    #align(center)[$ell_"MAP" (theta) = log p(D|theta)+log p(theta)$]
    #uncover("2-")[
      #v(0.75em)
      #align(center)[$= [N_1 log theta+N_0 log(1-theta)] + [(alpha-1) log theta+(beta-1) log(1-theta)]$]
    ]
    #source-note[Murphy, Book 1 §4.5.1, Eqs. 4.93–4.94; $alpha,beta$ notation as earlier]
  ],
  key-points: [
    - The prior changes the objective before a point estimate is chosen
    #uncover("2-")[- Its two shape parameters contribute to the two log terms]
  ],
)

#speaker-note[
  Use alpha and beta to match the opening slides; Book 1 writes a and b.
  The log posterior has exactly the same theta-dependent terms as the earlier
  conjugate update. Alpha and beta greater than one keep an interior mode in
  the examples shown.
]

== The posterior mode smooths the observed fraction

#content-block(
  layout: "top",
  object-width: 93%,
  object: [
    #align(center)[$hat(theta)_"MAP" = frac(N_1+alpha-1, N_1+N_0+alpha+beta-2)$]
    #uncover("2-")[
      #v(0.8em)
      #align(center)[$alpha=beta=2 quad arrow.r quad hat(theta)_"MAP" = frac(N_1+1, N+2)$]
    ]
    #uncover("3-")[
      #v(0.75em)
      #align(center)[$D=(1,1,1): quad hat(theta)_"MLE"=1, quad hat(theta)_"MAP"=4/5$]
    ]
    #source-note[Murphy, Book 1 §4.5.1, Eqs. 4.95–4.96]
  ],
  key-points: [
    - The $"Beta"(2,2)$ prior yields add-one smoothing
    #uncover("3-")[- The MAP plug-in prediction leaves a nonzero chance of tails]
  ],
)

#speaker-note[
  Differentiate the log posterior from the previous slide or invoke the
  familiar Beta posterior: Beta(alpha+N_1,beta+N_0). For an interior Beta mode,
  subtract one from each shape parameter and divide by their sum minus two.
  With three heads, the mode is 4/5, so a future tail receives probability 1/5.
  This does not make MAP a substitute for the full posterior predictive.
]

== Regularization adds a penalty to empirical risk

#content-block(
  layout: "top",
  object-width: 93%,
  object: [
    #align(center)[$L(theta;lambda) = [frac(1,N) sum_(n=1)^N ell(y_n,theta;x_n)] + lambda C(theta)$]
    #v(0.8em)
    #align(center)[$lambda >= 0$]
    #source-note[Murphy, Book 1 §4.5, Eq. 4.89]
  ],
  key-points: [
    - Training loss rewards fit to observed cases
    - $C(theta)$ expresses a preference among models; $lambda$ sets its strength
  ],
)

#speaker-note[
  Introduce the name regularization only now, after MAP is concrete. A
  regularized objective adds a penalty to the empirical loss. The penalty can
  favor less extreme or less complex fitted parameters and may improve
  predictions on future data. Avoid saying that every penalty is a prior.
]

== A negative log prior is one regularizer

#content-block(
  layout: "top",
  object-width: 94%,
  object: [
    #align(center)[$C(theta) = -log p(theta)$]
    #v(0.65em)
    #align(center)[$L(theta;lambda) = -frac(1,N) sum_(n=1)^N log p(y_n|x_n,theta) - lambda log p(theta)$]
    #uncover("2-")[
      #v(0.75em)
      #align(center)[$N L(theta;1/N) = -[log p(D|theta)+log p(theta)]$]
    ]
    #source-note[Murphy, Book 1 §4.5, Eqs. 4.90–4.91]
  ],
  key-points: [
    - With log loss and matching scaling, minimizing this objective gives MAP
    #uncover("2-")[- MAP is one interpretation of regularized fitting]
  ],
)

#speaker-note[
  In the displayed average-loss convention, lambda=1/N gives the exact MAP
  objective for the original prior. Book 1 uses an equivalent rescaling of
  the prior to show the same relationship. The conceptual connection is that
  the log prior contributes a penalty term to a negative log likelihood.
]

== A prior can temper a small sample's extreme fit

#content-block(
  layout: "top",
  object-width: 92%,
  object: [
    #twocol[
      *Maximum likelihood*\
      Three heads: $hat(theta)=1$\
      Next-tail probability: $0$
    ][
      *MAP with $"Beta"(2,2)$*\
      Three heads: $hat(theta)=4/5$\
      Next-tail probability: $1/5$
    ]
  ],
  key-points: [
    - The prior changes a point estimate in a transparent direction
    - Its strength matters most when the dataset is small
  ],
)

#speaker-note[
  End with the same example that opened the section. The table compares
  plug-in predictions using two point estimates; it does not compare full
  Bayesian posterior predictions. With more observations, the fixed Beta
  prior's contribution becomes smaller relative to the likelihood.
]

#section-metadata(
  short-title: [Sampling variation],
  subtitle: [How an estimator changes across repeated datasets],
)

= Sampling variation of the MLE

#speaker-note[
  This is a familiar frequentist idea and receives only a short reminder.
  It concerns variation of a procedure across hypothetical datasets, not the
  posterior distribution of a parameter given the observed dataset.
]

== With enough data, an MLE often varies approximately normally

#content-block(
  layout: "top",
  object-width: 93%,
  object: [
    #align(center)[$hat(theta)_"MLE" (tilde(D)) approx cal(N)(theta^*, [N F(theta^*)]^(-1))$]
    #v(0.75em)
    #align(center)[$F(theta) = E_theta [(nabla_theta log p(Y|theta))(nabla_theta log p(Y|theta))^T]$]
    #source-note[Murphy, Book 1 §4.7.2, Eqs. 4.219–4.220]
  ],
  key-points: [
    - $theta^*$ is the fixed true parameter; $F$ is Fisher information
    - Repeated datasets produce different estimates around $theta^*$
    - The approximation needs an identifiable, regular model and a large sample
  ],
)

#speaker-note[
  State the scope: this is a large-sample approximation under regularity and
  identifiability conditions, not a guarantee for every model or small sample.
  Fisher information measures how sensitive the data distribution is to the
  parameter. The covariance scales roughly as 1/N. Students have encountered
  sampling variation before, so do not derive the matrix result here.
]

#section-metadata(
  short-title: [Joint uncertainty],
  subtitle: [From scalar variation to a Gaussian joint model],
)

= From scalar to joint Gaussian uncertainty

#speaker-note[
  Students have fitted a scalar Gaussian and already know expectation and
  variance. Ask what changes when the observation is a vector: we need to
  represent how its coordinates vary together, not just their individual
  spreads. Book 2 §2.3 is the main route; Book 1 §§3.1–3.3 supplies the bridge.
]

== Covariance measures variation together

#content-block(
  layout: "top",
  object-width: 90%,
  object: [
    #align(center)[$"Cov"[X,Y] = E[(X-E[X])(Y-E[Y])]$]
    #v(0.75em)
    #align(center)[$"Cov"[X,Y] = E[X Y]-E[X]E[Y]$]
    #source-note[Murphy, Book 1 §3.1.1, Eq. 3.1]
  ],
  key-points: [
    - Positive covariance: deviations tend to have the same sign
    - Negative covariance: deviations tend to have opposite signs
    - Zero covariance rules out linear co-variation, not all dependence
  ],
)

#speaker-note[
  Begin with the deviations from the two means. Their product is positive
  when both variables move the same way and negative when they move in
  opposite directions. The second equality connects covariance to the raw
  moments students already used. Zero covariance alone is not independence.
]

== A covariance matrix collects all pairwise variation

#content-block(
  layout: "top",
  object-width: 92%,
  object: [
    #align(center)[$mu = E[bold(x)], quad Sigma = E[(bold(x)-mu)(bold(x)-mu)^T]$]
    #v(0.7em)
    #align(center)[$Sigma_(i j) = "Cov"[X_i,X_j], quad Sigma = Sigma^T$]
    #v(0.7em)
    #align(center)[$E[bold(x)bold(x)^T] = Sigma + mu mu^T$]
    #source-note[Murphy, Book 1 §3.1.1, Eqs. 3.2–3.4]
  ],
  key-points: [
    - Diagonal entries are variances; off-diagonal entries are covariances
    - For any direction $a$, $a^T Sigma a = V[a^T bold(x)] >= 0$
  ],
)

#speaker-note[
  The matrix is symmetric because covariance is symmetric. Show why it must
  be positive semidefinite: its quadratic form is a variance in direction a.
  The raw second-moment identity is the vector analogue of the earlier scalar
  relation, and will generate the joint Gaussian covariance later.
]

== Correlation separates direction from units

#content-block(
  layout: "top",
  object-width: 91%,
  object: [
    #align(center)[$rho = frac("Cov"[X_1,X_2], sigma_1 sigma_2), quad -1 <= rho <= 1$]
    #v(0.85em)
    #align(center)[$Sigma = mat(sigma_1^2, rho sigma_1 sigma_2; rho sigma_1 sigma_2, sigma_2^2)$]
    #source-note[Murphy, Book 1 §3.1.2, Eq. 3.7; Book 2 §2.3.1.1, Eq. 2.73]
  ],
  key-points: [
    - $sigma_1,sigma_2$ set the coordinate scales
    - $rho$ describes the direction and strength of linear association
  ],
)

#speaker-note[
  Use this two-dimensional matrix throughout the geometry and conditioning
  examples. Correlation is covariance standardized by the two marginal
  standard deviations; it does not encode a slope or all forms of dependence.
]

== Affine maps carry Gaussian means and covariances

#content-block(
  layout: "top",
  object-width: 90%,
  object: [
    #align(center)[$bold(y) = A bold(x)+b$]
    #v(0.8em)
    #align(center)[$E[bold(y)] = A mu+b, quad "Cov"[bold(y)] = A Sigma A^T$]
    #source-note[Murphy, Book 1 §3.1.1, Eq. 3.5]
  ],
  key-points: [
    - A shift changes the mean but not the covariance
    - A linear map changes the scale, orientation, and dimension of variation
  ],
)

#speaker-note[
  Briefly derive the covariance formula by subtracting the new mean:
  y-E[y]=A(x-mu). This fact is a workhorse rather than an isolated identity.
  It is the main route to the joint distribution of a linear Gaussian system.
]

== A multivariate Gaussian assigns density to a vector

#content-block(
  layout: "top",
  object-width: 96%,
  object: [
    #align(center)[$bold(x) tilde cal(N)(mu,Sigma), quad mu in RR^D, quad Sigma in RR^(D times D)$]
    #v(0.65em)
    #align(center)[$cal(N)(bold(x) | mu,Sigma) = frac(exp(-frac(1,2)(bold(x)-mu)^T Sigma^(-1)(bold(x)-mu)), (2 pi)^(D/2) |Sigma|^(1/2))$]
    #source-note[Murphy, Book 2 §2.3.1.1, Eq. 2.71]
  ],
  key-points: [
    - The mean locates the cloud; the covariance sets its shape
    - The determinant and $(2 pi)^(D/2)$ normalize the density
  ],
)

#speaker-note[
  Read the density in two pieces. The exponent measures displacement in the
  covariance geometry; the denominator ensures total probability one. Assume
  a positive definite covariance here, so the inverse and density exist.
  Singular Gaussian distributions require a different treatment.
]

== Mahalanobis distance uses the cloud's own scale

#content-block(
  layout: "top",
  object-width: 92%,
  object: [
    #align(center)[$d_Sigma (bold(x),mu)^2 = (bold(x)-mu)^T Sigma^(-1)(bold(x)-mu)$]
    #uncover("2-")[
      #v(0.85em)
      #align(center)[$Sigma = sigma^2 I_D quad arrow.r quad d_Sigma^2 = frac(norm(bold(x)-mu)^2, sigma^2)$]
    ]
    #source-note[Murphy, Book 2 §2.3.1.1, Eq. 2.72]
  ],
  key-points: [
    - Equal Mahalanobis distances trace equal-density contours
    #uncover("2-")[- With spherical covariance, it becomes squared Euclidean distance in standard-deviation units]
  ],
)

#speaker-note[
  Ask why the same physical displacement may be unsurprising in one direction
  but extreme in another. The inverse covariance rescales the direction.
  Reveal the spherical special case only after students interpret the general
  quadratic form.
]

== Covariance controls the contour shape

#content-block(
  layout: "top",
  object-width: 95%,
  object: [
    #course-figure(
      lecture-figure-path("generated/gaussian_contours.svg"),
      source: "Course rendering of Murphy, Book 2, Fig. 2.8",
      width: 100%,
      height: 5.5cm,
      show-source: false,
    )
    #source-note[Course rendering of Murphy, Book 2, Fig. 2.8]
  ],
  key-points: [
    - A full covariance can rotate the principal axes
    - Diagonal covariance removes linear correlation in these coordinates
    - Spherical covariance assigns the same variance in every direction
  ],
)

#speaker-note[
  Read the three covariance families from general to restricted. A full matrix
  has D(D+1)/2 free entries, a diagonal matrix D, and a spherical matrix one.
  These restrictions change the density contours and the model's flexibility.
  The figure is generated by gaussian_geometry_figures.ipynb.
]

== Gaussian draws concentrate at a relative radius

#content-block(
  layout: "top",
  object-width: 88%,
  object: [
    #course-figure(
      lecture-figure-path("generated/gaussian_shell_radius.svg"),
      source: "Course simulation; Murphy, Book 2 §2.3.1.2",
      width: 100%,
      height: 5.4cm,
      show-source: false,
    )
    #source-note[Course simulation; Murphy, Book 2 §2.3.1.2]
  ],
  key-points: [
    - The plot shows $R/sqrt(D)$ for standard Gaussian draws
    - Relative radial spread narrows as dimension grows
  ],
)

#speaker-note[
  The dashed line marks R/sqrt(D)=1. Compare D=2, 20, and 100 before
  showing the variance calculation on the next slide. The statement is about
  relative radius, not shrinking absolute radial width. The fixed-seed
  simulation is generated by gaussian_geometry_figures.ipynb.
]

== The mode is not where most high-dimensional mass lies

#content-block(
  layout: "top",
  object-width: 94%,
  object: [
    #align(center)[$bold(x) tilde cal(N)(bold(0),I_D), quad R^2 = sum_(i=1)^D X_i^2$]
    #v(0.75em)
    #align(center)[$E[R^2]=D, quad V[R^2]=2D, quad frac("sd"(R^2),E[R^2])=sqrt(frac(2,D))$]
    #source-note[Murphy, Book 2 §2.3.1.2, Gaussian shells]
  ],
  key-points: [
    - Density is highest at the origin
    - Most draws lie at radius approximately $sqrt(D)$
    - Relative radial variation shrinks as dimension grows
  ],
)

#speaker-note[
  Each squared standard normal has mean one and variance two, so the sum has
  mean D and variance 2D. This makes the concentration calculation explicit.
  Contrast density at one point with probability mass across a region: growing
  volume wins over the local density near the origin. Do not overstate a single
  exact radius for finite D.
]

== Joint Gaussian geometry has a compact vocabulary

#content-block(
  key-points: [
    - $mu$ locates the joint distribution
    - $Sigma$ describes variance in every direction and co-variation between coordinates
    - $Sigma^(-1)$ determines distance in the density exponent
    - Affine maps preserve Gaussian form and transform $mu,Sigma$ predictably
  ],
)

#speaker-note[
  Close by tying the scalar Gaussian parameters from the estimation section
  to their vector counterparts. The section established the meaning of the
  joint distribution, including its density geometry and high-dimensional
  mass; it did not yet use an observation to update an unknown coordinate.
]

#section-metadata(
  short-title: [Gaussian conditioning],
  subtitle: [Marginals, conditional distributions, and two parameterizations],
)

= Marginals and conditionals of a Gaussian

#speaker-note[
  The question is now operational: when some coordinates are observed, what
  distribution remains for the others? Develop the moment form first, then
  show why information form is useful for the same operation.
]

== Partition the variables and their parameters together

#content-block(
  layout: "top",
  object-width: 94%,
  object: [
    #align(center)[$bold(x)=mat(x_1; x_2), quad mu=mat(mu_1; mu_2)$]
    #v(0.7em)
    #align(center)[$Sigma=mat(Sigma_11,Sigma_12;Sigma_21,Sigma_22), quad Sigma_21=Sigma_12^T$]
    #source-note[Murphy, Book 2 §2.3.1.3, Eq. 2.75]
  ],
  key-points: [
    - $x_1$ and $x_2$ can each be vectors
    - The diagonal blocks describe within-group variation
    - The cross blocks describe variation between groups
  ],
)

#speaker-note[
  Treat the block partition as bookkeeping. The symbols refer to two groups
  of coordinates, not necessarily two scalar variables. Point to how every
  mean and covariance block follows the same partition of x.
]

== Marginalization keeps the matching blocks

#content-block(
  layout: "top",
  object-width: 91%,
  object: [
    #align(center)[$p(x_1)=integral p(x_1,x_2) dif x_2=cal(N)(x_1 | mu_1,Sigma_11)$]
    #v(0.75em)
    #align(center)[$p(x_2)=cal(N)(x_2 | mu_2,Sigma_22)$]
    #source-note[Murphy, Book 2 §2.3.1.3, Eqs. 2.76–2.77]
  ],
  key-points: [
    - To ignore $x_2$, keep only its complement's mean and covariance block
    - Cross-covariance affects conditioning, not the marginal of $x_1$
  ],
)

#speaker-note[
  This is the easiest Gaussian operation in moment form. The integral explains
  what marginalization means; the block rule gives its answer without doing
  the integral explicitly. Ask students to predict the second marginal.
]

== Conditioning shifts the mean by an observed deviation

#content-block(
  layout: "top",
  object-width: 93%,
  object: [
    #align(center)[$p(x_1 | x_2)=cal(N)(x_1 | mu_(1|2),Sigma_(1|2))$]
    #v(0.9em)
    #align(center)[$mu_(1|2)=mu_1+Sigma_12 Sigma_22^(-1)(x_2-mu_2)$]
    #source-note[Murphy, Book 2 §2.3.1.3, Eq. 2.78]
  ],
  key-points: [
    - Start at the prior mean $mu_1$
    - Respond to the innovation $x_2-mu_2$
    - The cross-covariance and observed variance determine the response
  ],
)

#speaker-note[
  Hold x2 fixed at its observed value. The deviation from its expected value
  is the innovation. If the cross-covariance is zero, the conditional mean
  stays at mu1. If x2 equals its mean, there is no mean shift even when the
  variables are correlated.
]

== Conditioning removes explained covariance

#content-block(
  layout: "top",
  object-width: 92%,
  object: [
    #align(center)[$Sigma_(1|2)=Sigma_11-Sigma_12 Sigma_22^(-1) Sigma_21$]
    #v(0.8em)
    #align(center)[$Sigma_(2|1)=Sigma_22-Sigma_21 Sigma_11^(-1) Sigma_12$]
    #source-note[Murphy, Book 2 §2.3.1.3, Eqs. 2.78–2.79]
  ],
  key-points: [
    - Conditional uncertainty cannot exceed the marginal covariance
    - In a Gaussian, this covariance depends on which variables are observed, not their values
  ],
)

#speaker-note[
  The subtracted matrix is positive semidefinite. Explain that the observed
  coordinates remove uncertainty that can be linearly predicted from them.
  Show the reverse direction to establish symmetry of the operation, without
  working through the matrix products twice.
]

== The bivariate formula makes the update tangible

#content-block(
  layout: "top",
  object-width: 93%,
  object: [
    #align(center)[$X_1 | X_2=x_2 tilde cal(N)(mu_1+rho frac(sigma_1,sigma_2)(x_2-mu_2), sigma_1^2 (1-rho^2))$]
    #source-note[Murphy, Book 1 §3.2.4; Book 2 §2.3.1.3]
  ],
  key-points: [
    - Positive $rho$ moves the estimate in the observed direction
    - $rho=0$ leaves both mean and variance unchanged
    - Larger $|rho|$ leaves less conditional variance
  ],
)

#speaker-note[
  Substitute the two-by-two covariance matrix from the previous section into
  the block formula. The scalar expression lets students reason about sign,
  units, and remaining variance. For a joint Gaussian, zero correlation also
  gives independence; that is special to this family.
]

== One observed coordinate can change both the estimate and its uncertainty

#content-block(
  layout: "top",
  object-width: 91%,
  object: [
    #align(center)[$mu_1=mu_2=0, quad sigma_1=sigma_2=1, quad rho=0.8, quad x_2=1.5$]
    #uncover("2-")[
      #v(0.8em)
      #align(center)[$X_1 | X_2=1.5 tilde cal(N)(0.8(1.5),1-0.8^2)=cal(N)(1.2,0.36)$]
    ]
    #source-note[Worked example of Murphy, Book 2 §2.3.1.3, Eq. 2.78]
  ],
  key-points: [
    - The observed value lies above its mean, so the conditional mean rises
    #uncover("2-")[- The variance falls from $1$ to $0.36$]
  ],
)

#speaker-note[
  Ask for the direction of the mean change and whether uncertainty rises or
  falls before revealing the calculation. The 0.8 correlation transfers part
  of the 1.5 deviation; the remaining variance is independent of the exact
  observed value. Reuse this numerical intuition when reading the matrix rule.
]

== A Schur complement names the remaining covariance

#content-block(
  layout: "top",
  object-width: 92%,
  object: [
    #align(center)[$S = Sigma_11-Sigma_12 Sigma_22^(-1) Sigma_21$]
    #v(0.75em)
    #align(center)[$Sigma_(1|2)=S, quad r=x_1-mu_1-Sigma_12 Sigma_22^(-1)(x_2-mu_2)$]
    #source-note[Murphy, Book 2 §2.3.1.5, Eqs. 2.91, 2.102–2.103]
  ],
  key-points: [
    - $S$ is the Schur complement of $Sigma_22$ in $Sigma$
    - $r$ is the unexplained part of $x_1$ after observing $x_2$
  ],
)

#speaker-note[
  Give the two recurring algebraic pieces names before showing the proof.
  The Schur complement is the conditional covariance. The residual is x1
  centered at its conditional mean. Neither definition requires students to
  invert the full covariance by hand.
]

== The joint quadratic separates into conditional and marginal parts

#content-block(
  layout: "top",
  object-width: 95%,
  object: [
    #align(center)[$(bold(x)-mu)^T Sigma^(-1)(bold(x)-mu)$]
    #v(0.55em)
    #align(center)[$= r^T S^(-1)r+(x_2-mu_2)^T Sigma_22^(-1)(x_2-mu_2)$]
    #v(0.6em)
    #align(center)[$p(x_1,x_2)=p(x_1 | x_2)p(x_2)$]
    #source-note[Murphy, Book 2 §2.3.1.5, Eqs. 2.94–2.103]
  ],
  key-points: [
    - The first quadratic describes $x_1$ after seeing $x_2$
    - The second describes the marginal distribution of $x_2$
  ],
)

#speaker-note[
  This is the proof idea behind the moment-form conditioning rule. Block
  inversion rewrites the joint exponent as two Gaussian exponents. Their
  factors become p(x1|x2) and p(x2). Keep the detailed matrix multiplication
  in the book; the two terms and their interpretation are the live result.
]

== A block matrix has two related Schur complements

#content-block(
  layout: "top",
  object-width: 91%,
  object: [
    #align(center)[$M=mat(E,F;G,H)$]
    #v(0.75em)
    #align(center)[$S_H=E-F H^(-1)G, quad S_E=H-G E^(-1)F$]
    #source-note[Murphy, Book 2 §2.3.1.5, Eqs. 2.88, 2.91–2.92]
  ],
  key-points: [
    - Removing one block produces an adjusted matrix on the other block
    - The conditional covariance is one such adjustment
  ],
)

#speaker-note[
  Now generalize the specific covariance S. The notation S_H means the
  Schur complement with respect to H; S_E uses E. Students need these
  definitions to read the inversion lemma. Both require the indicated
  inverse to exist.
]

== The matrix inversion lemma reuses smaller inverses

#content-block(
  layout: "top",
  object-width: 95%,
  object: [
    #align(center)[$(E-F H^(-1)G)^(-1)=E^(-1)+E^(-1)F(H-G E^(-1)F)^(-1)G E^(-1)$]
    #source-note[Murphy, Book 2 §2.3.1.5, Eqs. 2.88–2.93]
  ],
  key-points: [
    - Both sides represent the inverse of the same Schur complement
    - Choosing the form with the smaller inverse can greatly reduce computation
  ],
)

#speaker-note[
  Do not derive this algebraic identity live. Locate the two Schur complements
  and explain why the identity matters: it connects the observation-space and
  state-space posterior formulas. It also underlies the block decomposition on
  the preceding slide.
]

== Information form uses precision instead of covariance

#content-block(
  layout: "top",
  object-width: 92%,
  object: [
    #align(center)[$Lambda=Sigma^(-1), quad eta=Lambda mu$]
    #v(0.65em)
    #align(center)[$mu=Lambda^(-1)eta, quad Sigma=Lambda^(-1)$]
    #v(0.65em)
    #align(center)[$log p(bold(x)) = bold(x)^T eta-frac(1,2) bold(x)^T Lambda bold(x)+"constant"$]
    #source-note[Murphy, Book 2 §2.3.1.4, Eqs. 2.80–2.83]
  ],
  key-points: [
    - $Lambda$ is the precision matrix; $eta$ is the precision-weighted mean
    - Expanding the Gaussian exponent exposes a linear and a quadratic term
  ],
)

#speaker-note[
  Reparameterize the same normalized Gaussian; no new distribution has been
  introduced. Completing the square recovers the moment parameters. The
  normalizing constant is
  $exp(-frac(1,2)eta^T Lambda^(-1)eta) /
  ((2 pi)^(D/2) |Lambda^(-1)|^(1/2))$.
  The x-dependent terms are what make Gaussian combination and conditioning
  simple.
]

== Conditioning is especially simple in information form

#content-block(
  layout: "top",
  object-width: 94%,
  object: [
    #align(center)[$eta=mat(eta_1;eta_2), quad Lambda=mat(Lambda_11,Lambda_12;Lambda_21,Lambda_22)$]
    #v(0.75em)
    #align(center)[$p(x_1 | x_2)=cal(N)_c (x_1 | eta_1-Lambda_12 x_2, Lambda_11)$]
    #source-note[Murphy, Book 2 §2.3.1.4, Eq. 2.86]
  ],
  key-points: [
    - Fixing $x_2$ changes the linear coefficient for $x_1$
    - The conditional precision is simply $Lambda_11$
  ],
)

#speaker-note[
  Collect the terms involving x1 in the joint log density. The quadratic
  coefficient stays Lambda11; the cross term shifts eta1 by minus Lambda12 x2.
  State that N_c denotes a Gaussian specified by eta and Lambda, not by mean
  and covariance. This is Book 2's short derivation in §2.3.1.6.
]

== Information-form marginalization needs a Schur complement

#content-block(
  layout: "top",
  object-width: 93%,
  object: [
    #align(center)[$p(x_2)=cal(N)_c (x_2 | eta_2-Lambda_21 Lambda_11^(-1)eta_1, Lambda_22-Lambda_21 Lambda_11^(-1)Lambda_12)$]
    #source-note[Murphy, Book 2 §2.3.1.4–2.3.1.6, Eq. 2.85]
  ],
  key-points: [
    - Integrating out $x_1$ changes both the linear and quadratic coefficients
    - Moment form makes marginals easy; information form makes conditioning easy
  ],
)

#speaker-note[
  Recognize the integral over x1 as the Gaussian normalizer of its conditional
  quadratic. That normalizer depends on x2, producing the two Schur-complement
  adjustments. This slide completes the comparison of the two parameterizations
  without repeating the full expansion in Book 2 §2.3.1.6.
]

== Gaussian conditioning answers a reusable inference question

#content-block(
  key-points: [
    - Partition a joint Gaussian into unknown and observed coordinates
    - Marginalization discards coordinates and keeps matching moment blocks
    - Conditioning shifts the unknown mean and reduces its covariance
    - Moment and information forms make different operations simple
  ],
)

#speaker-note[
  End with the operational rule and the two ways of representing it. The
  central result is a full conditional distribution, not merely a point
  imputation. The proof slides supplied the structural reason the answer
  remains Gaussian; no additional case study is needed in this section.
]

#section-metadata(
  short-title: [Linear Gaussian systems],
  subtitle: [A prior and a noisy linear observation produce a Gaussian posterior],
)

= Linear Gaussian systems

#speaker-note[
  Now assemble the joint model from a prior on an unknown vector and a noisy
  observation. Reuse the same conditioning formula rather than introducing a
  separate inference trick. The goal is to understand both gain and precision
  forms of Gaussian Bayes' rule.
]

== A linear Gaussian system defines a latent state and an observation

#content-block(
  layout: "top",
  object-width: 93%,
  object: [
    #align(center)[$z tilde cal(N)(mu_z,Sigma_z), quad y | z tilde cal(N)(W z+b,Omega)$]
    #v(0.8em)
    #align(center)[$y=W z+b+epsilon, quad epsilon tilde cal(N)(0,Omega)$]
    #source-note[Murphy, Book 2 §2.3.2, Eqs. 2.118–2.119]
  ],
  key-points: [
    - $z in RR^L$ is unknown; $y in RR^D$ is observed
    - $W$ maps state to measurement; $Omega$ describes measurement noise
  ],
)

#speaker-note[
  Distinguish the random latent state from the noise, which is independent of
  it. The conditional equation says what measurements would look like for a
  given state. The same system can represent many state and observation sizes.
]

== The joint mean and covariance follow from affine rules

#content-block(
  layout: "top",
  object-width: 94%,
  object: [
    #align(center)[$E[mat(z;y)]=mat(mu_z;W mu_z+b)$]
    #v(0.7em)
    #align(center)[$"Cov"[mat(z;y)]=mat(Sigma_z,Sigma_z W^T;W Sigma_z,W Sigma_z W^T+Omega)$]
    #source-note[Murphy, Book 2 §2.3.2.1, Eq. 2.120]
  ],
  key-points: [
    - $"Cov"[z,y]=Sigma_z W^T$ links state and measurement
    - Measurement variance combines projected state uncertainty and noise
  ],
)

#speaker-note[
  Derive the lower-right block with y=Wz+b+epsilon: independent noise adds
  Omega to W Sigma_z W^T. Derive the cross block using covariance of z and
  Wz. These are precisely the affine and cross-covariance facts introduced in
  the joint-uncertainty section.
]

== The system predicts observations before seeing them

#content-block(
  layout: "top",
  object-width: 92%,
  object: [
    #align(center)[$m=W mu_z+b, quad S=W Sigma_z W^T+Omega$]
    #v(0.85em)
    #align(center)[$p(y)=cal(N)(y | m,S)$]
    #source-note[Murphy, Book 2 §2.3.2.2, Eq. 2.129]
  ],
  key-points: [
    - $m$ is the predicted measurement
    - $S$ combines uncertainty in the state with sensor noise
    - $p(y)$ scores how plausible an observed measurement is under the model
  ],
)

#speaker-note[
  This is the marginal of the joint distribution, before any particular y is
  observed. In the posterior update, y-m will be the prediction error or
  innovation. The same density p(y) is the normalizing evidence for Bayes'
  rule and can be used as a marginal likelihood.
]

== Gaussian conditioning gives the posterior state

#content-block(
  layout: "top",
  object-width: 94%,
  object: [
    #align(center)[$p(z | y)=cal(N)(z | mu_(z|y),Sigma_(z|y))$]
    #v(0.65em)
    #align(center)[$mu_(z|y)=mu_z+Sigma_z W^T S^(-1)(y-m)$]
    #v(0.55em)
    #align(center)[$Sigma_(z|y)=Sigma_z-Sigma_z W^T S^(-1)W Sigma_z$]
    #source-note[Murphy, Book 2 §2.3.2.2, Eq. 2.121]
  ],
  key-points: [
    - The posterior mean responds to the innovation $y-m$
    - The posterior covariance subtracts explained uncertainty
  ],
)

#speaker-note[
  Plug the joint blocks from Eq. 2.120 into the general conditional Gaussian
  rule. This is Bayes' rule for Gaussians: a Gaussian prior and linear Gaussian
  likelihood yield a Gaussian posterior. Do not present this as an unrelated
  formula to memorize.
]

== The gain writes the same update as prediction plus correction

#content-block(
  layout: "top",
  object-width: 92%,
  object: [
    #align(center)[$K=Sigma_z W^T S^(-1)$]
    #v(0.7em)
    #align(center)[$mu_(z|y)=mu_z+K(y-m), quad Sigma_(z|y)=Sigma_z-K S K^T$]
    #source-note[Murphy, Book 2 §2.3.2.2, Eqs. 2.122–2.126]
  ],
  key-points: [
    - $K$ converts a measurement error into a state correction
    - Less reliable observations contribute a smaller correction
  ],
)

#speaker-note[
  The Kalman gain is just a name for the block-conditioning coefficient.
  The covariance expression uses KSK^T=Sigma_z W^T S^-1 W Sigma_z. Emphasize
  the structure of the update and the dimensions: K maps D-dimensional
  observations to L-dimensional states.
]

== Precision form adds prior and data information

#content-block(
  layout: "top",
  object-width: 94%,
  object: [
    #align(center)[$Sigma_(z|y)^(-1)=Sigma_z^(-1)+W^T Omega^(-1)W$]
    #v(0.75em)
    #align(center)[$mu_(z|y)=Sigma_(z|y)(Sigma_z^(-1)mu_z+W^T Omega^(-1)(y-b))$]
    #source-note[Murphy, Book 2 §2.3.2.2, Eqs. 2.127–2.128]
  ],
  key-points: [
    - Posterior precision is prior precision plus measurement information
    - This is the same posterior as the gain form
  ],
)

#speaker-note[
  Show the correspondence with information-form multiplication: quadratic
  coefficients add. The matrix inversion lemma connects this state-space form
  to the observation-space gain form. Either may be computationally better,
  depending on whether L or D is smaller.
]

== A scalar update shows how noise controls trust

#content-block(
  layout: "top",
  object-width: 91%,
  object: [
    #align(center)[$z tilde cal(N)(0,1), quad y | z tilde cal(N)(z,0.25), quad y=1$]
    #uncover("2-")[
      #v(0.75em)
      #align(center)[$Sigma_(z|y)=frac(1,1+4)=0.2, quad mu_(z|y)=0.2(4)=0.8$]
    ]
    #source-note[Worked example from Murphy, Book 1 §3.3.1 and Book 2 §2.3.2.2]
  ],
  key-points: [
    - A precise observation moves the posterior mean toward the measurement
    #uncover("2-")[- The posterior variance is smaller than either starting variance]
  ],
)

#speaker-note[
  Have students predict whether the posterior mean is nearer zero or one.
  Prior precision is one and observation precision is four, so the answer is
  four-fifths of the way toward y=1. The variance 0.2 comes from total
  precision five. The example grounds the matrix formulas without a new model.
]

== The system turns an observation into a distribution over unknowns

#content-block(
  key-points: [
    - A Gaussian prior and linear Gaussian observation model define a joint Gaussian
    - The observation marginal predicts $y$ before it arrives
    - Conditioning that joint gives the posterior $p(z | y)$
    - Gain and precision forms express the same update
  ],
)

#speaker-note[
  Close the linear-system arc. State the role of each distribution: prior,
  observation model, predictive distribution, posterior. The endpoint is the
  full conditional distribution over z, with both an updated center and
  remaining uncertainty.
]

#section-metadata(
  short-title: [Gaussian calculus],
  subtitle: [Reusable operations for larger linear Gaussian systems],
)

= An information calculus for Gaussian systems

#speaker-note[
  Book 2 §2.3.3 extends the two-variable update to systems with many factors.
  Explain why a compact representation is useful: combining factors,
  observing variables, and eliminating hidden variables can all be described
  as operations on Gaussian quadratic forms.
]

== A Gaussian potential need not be normalized

#content-block(
  layout: "top",
  object-width: 94%,
  object: [
    #align(center)[$phi(bold(x);g,h,K)=exp(g+bold(x)^T h-frac(1,2)bold(x)^T K bold(x))$]
    #v(0.7em)
    #align(center)[$K=Sigma^(-1), quad h=K mu, quad g=log p-frac(1,2)mu^T K mu$]
    #source-note[Murphy, Book 2 §2.3.3.1, Eqs. 2.131–2.135]
  ],
  key-points: [
    - $K$ and $h$ describe the quadratic and linear terms
    - $g$ tracks scale; $phi$ can be an unnormalized factor
    - For a normalized Gaussian, $p=(2 pi)^(-D/2)|Sigma|^(-1/2)$
  ],
)

#speaker-note[
  Distinguish this potential from the normalized information-form density
  introduced earlier. The extra scalar g retains the multiplier needed for
  evidence calculations. A factor need not integrate to one; the algebraic
  operations can still be performed on its coefficients.
]

== Multiplying Gaussian factors adds their coefficients

#content-block(
  layout: "top",
  object-width: 94%,
  object: [
    #align(center)[$phi_1 (bold(x)) phi_2 (bold(x))=phi(bold(x);g_1+g_2,h_1+h_2,K_1+K_2)$]
    #v(0.7em)
    #align(center)[$phi_1 (bold(x))/phi_2 (bold(x))=phi(bold(x);g_1-g_2,h_1-h_2,K_1-K_2)$]
    #source-note[Murphy, Book 2 §2.3.3.2, Eqs. 2.136–2.137]
  ],
  key-points: [
    - Logarithms turn products and quotients into sums and differences
    - Extend factors to the same variable vector with zero blocks first
  ],
)

#speaker-note[
  Point back to the posterior precision as prior precision plus data
  information. These rules are general coefficient bookkeeping. Division can
  produce an improper potential, so no claim is made that every intermediate
  result is a normalized distribution.
]

== The earlier scalar update is addition of quadratic information

#content-block(
  layout: "top",
  object-width: 92%,
  object: [
    #align(center)[$log p(z)=-frac(1,2)z^2+"constant"$]
    #v(0.55em)
    #align(center)[$log p(y=1 | z)=-frac((1-z)^2,2(0.25))+"constant"$]
    #uncover("2-")[
      #v(0.6em)
      #align(center)[$log p(z | y=1)=-frac(5,2)z^2+4z+"constant"$]
    ]
    #source-note[Worked example from Murphy, Book 2 §§2.3.2.2, 2.3.3.2]
  ],
  key-points: [
    - Prior precision $1$ plus measurement precision $4$ gives posterior precision $5$
    #uncover("2-")[- The linear coefficient $4$ gives posterior mean $4/5=0.8$]
  ],
)

#speaker-note[
  Reuse the scalar example from the linear-system section. Expand the
  likelihood's square, then add its quadratic and linear coefficients to
  the prior's. This produces K=5 and h=4, hence variance 1/5 and mean 4/5.
  The example makes the potential addition rule concrete before elimination.
]

== Eliminating a Gaussian variable changes all remaining coefficients

#content-block(
  layout: "top",
  object-width: 92%,
  object: [
    #align(center)[$bold(x)=mat(x_1;x_2), quad h=mat(h_1;h_2), quad K=mat(K_11,K_12;K_21,K_22)$]
    #v(0.7em)
    #align(center)[$integral phi(x_1,x_2) dif x_1=phi(x_2;hat(g),hat(h),hat(K))$]
    #source-note[Murphy, Book 2 §2.3.3.3, Eqs. 2.138–2.139]
  ],
  key-points: [
    - Integrate out $x_1$ to retain a potential over $x_2$
    - The result remains an exponential quadratic in $x_2$
  ],
)

#speaker-note[
  First define the operation conceptually. The eliminated variable appears
  quadratically, so its integral is a Gaussian normalizer. The resulting
  potential still has the same form; the next slide gives the updated
  coefficients. K11 must be positive definite for this integral to exist.
]

== Marginalization uses another Schur complement

#content-block(
  layout: "top",
  object-width: 94%,
  object: [
    #align(center)[$hat(K)=K_22-K_21 K_11^(-1)K_12$]
    #v(0.55em)
    #align(center)[$hat(h)=h_2-K_21 K_11^(-1)h_1$]
    #v(0.55em)
    #align(center)[$hat(g)=g+frac(d_1,2)log(2 pi)-frac(1,2)log|K_11|+frac(1,2)h_1^T K_11^(-1)h_1$]
    #source-note[Murphy, Book 2 §2.3.3.3, Eqs. 2.140–2.142]
  ],
  key-points: [
    - $d_1$ is the dimension of the eliminated vector
    - The scale update matters when computing evidence
  ],
)

#speaker-note[
  Connect hat K and hat h to the earlier information-form marginal rule.
  The g update is the log normalizer of the eliminated Gaussian, including
  its dimension, determinant, and completed-square term. It can be read as
  bookkeeping rather than memorized.
]

== Observing a variable substitutes its value into the potential

#content-block(
  layout: "top",
  object-width: 93%,
  object: [
    #align(center)[$phi(x,y)=exp(g+mat(x;y)^T mat(h_x;h_y)-frac(1,2)mat(x;y)^T mat(K_(x x),K_(x y);K_(y x),K_(y y)) mat(x;y))$]
    #source-note[Murphy, Book 2 §2.3.3.4, Eqs. 2.143–2.144]
  ],
  key-points: [
    - Fix $y$ at its observed value
    - Regroup the remaining expression by powers of $x$
  ],
)

#speaker-note[
  This slide sets up substitution. It is deliberately separate from the
  answer so students can identify constant, linear, and quadratic terms in
  the unknown x. The displayed matrix is a block version of the same
  exponential quadratic already used for normalized conditioning.
]

== Evidence changes the scale and linear term

#content-block(
  layout: "top",
  object-width: 92%,
  object: [
    #align(center)[$K^*=K_(x x), quad h^*=h_x-K_(x y)y$]
    #v(0.75em)
    #align(center)[$g^*=g+y^T h_y-frac(1,2)y^T K_(y y)y$]
    #source-note[Murphy, Book 2 §2.3.3.4, Eq. 2.144]
  ],
  key-points: [
    - The quadratic coefficient for $x$ stays the same
    - The observed value changes the linear and constant terms
  ],
)

#speaker-note[
  Collect the x^T x, x, and constant terms from the preceding slide. This
  is the general potential version of conditioning in information form.
  The result is a potential over x; it may need normalization before being
  reported as a posterior probability distribution.
]

== A linear Gaussian conditional becomes a joint potential

#content-block(
  layout: "top",
  object-width: 93%,
  object: [
    #align(center)[$p(x | u)=cal(N)(x | mu+B^T u,Sigma)$]
    #v(0.65em)
    #align(center)[$v=mat(x;u), quad A=(I,-B^T), quad x-mu-B^T u=A v-mu$]
    #source-note[Murphy, Book 2 §2.3.3.5, Eqs. 2.145–2.147]
  ],
  key-points: [
    - Express the conditional residual as one affine function of $(x,u)$
    - Expanding its squared Mahalanobis distance produces a potential
  ],
)

#speaker-note[
  The notation A packages the two coefficients [I,-B^T]. Dimensions:
  x is n-dimensional, u is k-dimensional, and B is k by n. This turns
  a directed conditional density into a factor over both variables, ready
  for multiplication and elimination.
]

== The conditional's canonical coefficients come from expansion

#content-block(
  layout: "top",
  object-width: 94%,
  object: [
    #align(center)[$K=A^T Sigma^(-1)A, quad h=A^T Sigma^(-1)mu$]
    #v(0.65em)
    #align(center)[$g=-frac(1,2)mu^T Sigma^(-1)mu-frac(n,2)log(2 pi)-frac(1,2)log|Sigma|$]
    #source-note[Murphy, Book 2 §2.3.3.5, Eqs. 2.148–2.150]
  ],
  key-points: [
    - $K$ captures the joint quadratic in state and parent variables
    - $h$ and $g$ retain the linear and normalizing terms
  ],
)

#speaker-note[
  Expand -1/2(Av-mu)^T Sigma^-1(Av-mu) and collect coefficients.
  Equivalently K has blocks [Sigma^-1,-Sigma^-1 B^T; -B Sigma^-1,
  B Sigma^-1 B^T]. The conditional alone is flat in some joint directions;
  its K can be singular until other factors are multiplied in.
]

== Gaussian inference can be assembled from four operations

#content-block(
  layout: "top",
  object-width: 93%,
  object: [
    #grid(
      columns: (1fr, 1fr, 1fr, 1fr),
      gutter: 0.5em,
      schema-node([Convert], [Conditionals to potentials]),
      schema-node([Multiply], [Combine factors], fill: palette.paper),
      schema-node([Observe], [Insert data]),
      schema-node([Marginalize], [Eliminate variables], fill: palette.paper),
    )
    #source-note[Murphy, Book 2 §2.3.3.1–2.3.3.5]
  ],
  key-points: [
    - All intermediate factors retain an exponential-quadratic form
    - The final normalized result is a Gaussian posterior over the unknowns
  ],
)

#speaker-note[
  End the lecture at the promised general Gaussian calculus. The earlier
  two-variable Bayes update is one application; a larger linear Gaussian
  system repeats the same algebraic operations. This is a structural
  synthesis, not an invitation to introduce belief propagation algorithms.
]
