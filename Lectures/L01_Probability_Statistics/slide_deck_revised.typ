// Lecture 1 — Probabilistic Machine Learning
#import "../course.typ": *
#import "figures/beta_bernoulli_graph.typ": beta_bernoulli_graph
#import "figures/input_output_function_schema.typ": input_output_function_schema
#import "figures/linear_gaussian_graph.typ": linear_gaussian_graph

#let lecture = (
  number: 1,
  title: [Probability and Bayesian Statistics],
  short-title: [Probability & Statistics],
  subtitle: [From Bayesian statistics to probabilistic machine learning],
)

#show: course-theme.with(info: lecture)
#show: touying-set-config.with(config-common(handout: true))

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
    #stack(
      spacing: 0.35em,
      [
        - A statistical model has data and unknown parameters
      ],
      uncover("2-")[
        - How could observed data ($y$) have been generated.
        - What does it tell us about the parameters ($theta$)
      ],
      uncover("3-")[
        - $N_1$ and $N_0$ count heads and tails in the observed sample
      ],
    )
  ],
)

#speaker-note[
  Begin with data and the unknown bias. Reveal the model and its two questions
  together on step 2, then introduce the coding and counts on step 3.

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
  object: [
    #uncover("2-")[
      #align(center)[
        #stack(
          spacing: 1.0em,
          text(weight: "semibold", fill: palette.accent)[Bayes' rule],
          text(size: 1.3em)[$
            p(theta | y) &= frac(p(y | theta) p(theta), p(y)) \
            &prop p(y | theta) p(theta)$],

        )
      ]
    ]
  ],
  key-points: [
    #stack(
      spacing: 0.35em,
      uncover("2-")[
        - *Prior:* $p(theta)$
        - *Likelihood:* $p(y | theta)$
        - *Posterior:* $p(theta | y)$
      ],
      uncover("3-")[
        - We explored the posterior of $theta$
          - Treating $p(y)$ as a normalizing constant
      ],
    )
  ],
)

#speaker-note[
  Begin with the familiar model. Step 2 reveals Bayes' rule and names its
  three distributions together; step 3 interprets the normalizing constant.

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
          row-gutter: 0.65em,
          align: (left, left),
          [#text(weight: "semibold", fill: palette.accent)[Prior]],
          [$ p(theta) = "Beta"(alpha, beta) $],
          [#text(weight: "semibold", fill: palette.accent)[Likelihood]],
          [$ p(y | theta) prop theta^(N_1) (1-theta)^(N_0) $],
          uncover("2-")[#text(weight: "semibold", fill: palette.accent)[Posterior]],
          uncover("2-")[$ p(theta | y) = "Beta"(alpha + N_1, beta + N_0) $],
        )
      ],
    )
  ],
  key-points-title: [#uncover("3-")[Conjugacy]],
  key-points: [
    #uncover("3-")[
      #text(size: 0.85em)[
        The prior and likelihood are conjugate when the posterior belongs to the
        same distribution family as the prior.
      ]
    ]
  ],
)

#speaker-note[
  Start with the prior and likelihood already in view. Ask what family the
  posterior belongs to; reveal the update on step 2, then name and define
  conjugacy on step 3. The definition follows the example it describes.

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
    #stack(
      spacing: 0.35em,
      [
        - The prior and the posterior are both probability distributions
      ],
      uncover("2-")[
        - Their width expresses the uncertainty
        - The uncertainty in the posterior is less than in the prior
      ],
    )
  ],
)

#speaker-note[
  Keep the prior, likelihood, and posterior visible together for comparison.
  Identify the curves first; on step 2 interpret their widths in this example.

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
    #stack(
      spacing: 0.35em,
      [
        - Get data $arrow.r$ build a model $arrow.r$ apply Bayes' rule $arrow.r$ interpret $theta$
          - For many scientific questions, that posterior *is* the answer
      ],
      uncover("2-")[
        - Statistics arose from an interest in the underlying parameters in nature
      ],
    )
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
    #stack(
      spacing: 0.35em,
      [
        - A computational task is an *input/output contract*
          - Produce a function $f$ that maps input $x$ to output $y$
      ],
      uncover("2-")[
        - Implementation is secondary to the requirement
        - Multiple implementations may be possible
      ],
      uncover("3-")[
        - Machine learning developed in this context
      ],
    )
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
      // Reserve the complete figure-and-caption row across replacements.
      rows: (6.5cm,),
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
        position: left + top,
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
        position: left + top,
        stretch: false,
      ),
    )
  ],
  key-points: [
    #stack(
      spacing: 0.35em,
      uncover("3-")[
        - Fisher's discriminant and Rosenblatt's perceptron share an interface
          - complex input $arrow.r$ class or response
      ],
      uncover("4-")[
        - Machine learning asks how data can produce the required function $f$
      ],
    )
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
      uncover("2-")[
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
    #stack(
      spacing: 0.35em,
      [
        - Experience is a training set $D = {(x_n, y_n)}$
          - $x$: called feature, covariate, or predictor
          - $y$: called label, target, or response
      ],
      uncover("2-")[
        - Task is to produce a predictor $f_D$ that maps new $x_*$ to correct $y_*$
      ],
      uncover("3-")[
        - Performance is measured by a loss, introduced shortly
      ],
    )
  ],
)

#speaker-note[
  Read the training examples and their notation on the base slide. Reveal
  the deployed predictor with its task key point on step 2, then introduce
  performance on step 3 to motivate the loss function.

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
        uncover("2-")[#align(center)[
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
    #stack(
      spacing: 0.35em,
      [
        - Classification: $y in {1, dots, C}$
          - The classes are unordered and mutually exclusive
      ],
      uncover("2-")[
        - For the Iris dataset
          - $y in {"Setosa", "Versicolor", "Virginica"}$
          - $x in RR^4$
      ],
    )
  ],
)

#speaker-note[
  Begin with the flowers and the idea of a class label. Reveal the design
  matrix and the matching feature/label notation together on step 2.

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
    #stack(
      spacing: 0.35em,
      [
        - The loss function: the cost of predicting $f(x; theta)$ when the true label is $y$
      ],
      uncover("2-")[
        - The empirical risk: loss evaluated on the training set
      ],
      uncover("3-")[
        - Empirical risk minimization: minimizing the empirical loss
      ],
    )
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
    #stack(
      spacing: 0.35em,
      [
        - A loss function assigns a cost to a prediction when the true label is known
      ],
      uncover("2-")[
        - The zero-one loss is one for a misclassification and zero for a correct classification
        - $II(e)$ is an indicator function: it evaluates whether condition $e$ holds
      ],
    )
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
    #stack(
      spacing: 0.35em,
      [
        - The exploratory data analysis suggests:
          - Features in each class have similar distributions
          - Different classes have different distributions
      ],
      uncover("2-")[
        - Bayes' rule converts those ingredients to posterior class probabilities
      ],
      uncover("3-")[
        - A possible classifier: choose the class with maximum a posteriori probability
      ],
    )
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
    #stack(
      spacing: 0.35em,
      [
        - *Task:* predict the Iris species from four sepal and petal measurements
      ],
      uncover("2-")[
        - *Experience:* 150 labeled flowers, with 50 examples from each species
      ],
      uncover("3-")[
        - *Performance:* mean zero-one loss, the training misclassification rate
      ],
    )
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
    #stack(
      spacing: 0.35em,
      [
        - Statistics and computer science
          - Statistics focused on the values of unknown parameters
          - Computer science develops functions that map inputs to outputs
      ],
      uncover("2-")[
        - Machine learning is a branch of computer science
          - Where the function is learned from experience
      ],
      uncover("3-")[
        - A learning problem is defined by three ingredients: task, experience, and performance
          - One canonical pairing uses supervised experience $D = {(x_n, y_n)}$ for prediction
          - The experience regime and the task are related, but they are not the same taxonomy
      ],
    )
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
      #text(size: 1em)[
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

// ============================================================================
// STRUCTURAL REBUILD — Lecture 1
// BUILD PROMPT comments identify the slides still to be developed.
// Completed slides below include their content, reveal sequence, and teaching notes.
// Estimation, probability-review, high-dimensional-Gaussian, and Gaussian-potential
// material has been removed from this working deck according to the disposition map.
// ============================================================================

#section-metadata(
  short-title: [Probability queries],
  subtitle: [From learning problems to exact probabilistic operations],
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
    #stack(
      spacing: 0.35em,
      [
        - The variables may be high-dimensional, latent, or only partly observed
      ],
      uncover("2-")[
        - The task determines which quantity we need from the joint distribution
      ],
      uncover("3-")[
        - The probability language is familiar even when the model is large
      ],
    )
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
    #stack(
      spacing: 0.35em,
      [
        - Almost all machine learning tasks require an integral
      ],
      uncover("3-")[
        - Latent variables are inferred or averaged out
      ],
      uncover("3-")[
        - Much methodology addresses computing these integrals efficiently
      ],
    )
  ],
)

#speaker-note[
  The first key point accompanies summarization. Keep the remaining key
  points hidden until step 3, when marginalization and conditioning are both
  visible and their shared computational requirement can be compared.

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
  short-title: [Gaussian geometry],
  subtitle: [Describe and transform joint uncertainty with a mean and covariance],
)

= Joint Gaussian distributions and geometry

== Gaussians: a concrete example

#content-block(
  layout: "top",
  object-width: 96%,
  object: [
    #grid(
      columns: (auto, 1fr),
      column-gutter: 1em,
      row-gutter: 1em,
      align: (left + horizon, center + horizon),
      [*One variable*],
      [$ cal(N)(x | mu,sigma^2) = frac(exp(-frac((x-mu)^2,2 sigma^2)), sqrt(2 pi sigma^2)) $],
      uncover("2-")[*$D$ coordinates*],
      uncover("2-")[$ cal(N)(bold(x) | mu,Sigma) = frac(exp(-frac(1,2)(bold(x)-mu)^T Sigma^(-1)(bold(x)-mu)), (2 pi)^(D/2) |Sigma|^(1/2)) $],
    )
    #source-note[Murphy, Book 2 §2.3.1.1, Eq. 2.71; scalar case: $D=1$]
  ],
  key-points: [
    #stack(
      spacing: 0.7em,
      [- One variable: mean $mu$ and variance $sigma^2$],
      uncover("2-")[- Mean vector $mu in RR^D$ locates the cloud; covariance $Sigma in RR^(D times D)$ sets its shape],
      uncover("3-")[- Gaussian means, marginals, and conditionals have closed forms],
    )
  ],
)

#speaker-note[
  Instantiate the generic joint density from the preceding section with a
  familiar family. This section's goal is to read and transform a Gaussian
  using its mean and covariance; the next section will use those parameters
  to marginalize and condition. Begin with only the scalar density and its parameter key
  point. On reveal 2, show the vector density, its label, and the matching
  parameter key point together. The scalar Gaussian is the D=1 case: a mean
  becomes a mean vector, and a variance becomes a covariance matrix.
  Orient students to the parameters without deriving or memorizing the density.
  In each expression, the exponent measures displacement from the mean and the
  denominator makes the density integrate to one. In the vector case, the
  determinant and the factor (2π)^(D/2) supply the normalization.
  Assume sigma²>0 and positive definite Σ so these ordinary densities exist.
  Singular Gaussian laws require a different treatment.
  On reveal 3, show the payoff: means, marginals, and conditionals have exact
  formulas with geometric interpretations. Arbitrary nonlinear expectations
  need not have closed forms. Lead into the next slide by applying the same summarize,
  marginalize, and condition operations to this concrete joint model; then
  unpack covariance and the geometry of the exponent in the following slides.
]

== The three operations in multivariate Gaussian systems

#content-block(
  layout: "top",
  object-width: 98%,
  object: [
    #align(center)[One joint Gaussian: $p(bold(x)) = cal(N)(bold(x) | mu, Sigma)$]
    #grid(
      columns: (1fr, 1fr, 1fr),
      gutter: 0.8em,
      align: center + top,
      [
        #stack(
          spacing: 0.3em,
          align(center)[*Summarize*],
          course-figure(
            lecture-figure-path("generated/gaussian_operations__summarize.svg"),
            width: 100%, height: 4.7cm, show-source: false,
          ),
          text(size: 0.74em)[
            $ mu = integral bold(x) p(bold(x)) dif bold(x) $
          ],
        )
      ],
      uncover("2-")[
        #stack(
          spacing: 0.3em,
          align(center)[*Marginalize*],
          course-figure(
            lecture-figure-path("generated/gaussian_operations__marginalize.svg"),
            width: 100%, height: 4.7cm, show-source: false,
          ),
          text(size: 0.74em)[
            $ p(x_1) = integral p(x_1,x_2) dif x_2 $
          ],
        )
      ],
      uncover("3-")[
        #stack(
          spacing: 0.3em,
          align(center)[*Condition*],
          course-figure(
            lecture-figure-path("generated/gaussian_operations__condition.svg"),
            width: 100%, height: 4.7cm, show-source: false,
          ),
          text(size: 0.74em)[
            $ p(x_1 | x_2=a) = frac(p(x_1,a), integral p(u,a) dif u) $
          ],
        )
      ],
    )
    #source-note[Figures: `gaussian_geometry_figures.ipynb`]
  ],
  key-points: [
    #stack(
      spacing: 0.35em,
      [- *Summarize:* describe the center and spread with $mu$ and $Sigma$],
      uncover("2-")[- *Marginalize:* integrate over the coordinate we ignore],
      uncover("3-")[- *Condition:* fix an observed coordinate and normalize the slice],
    )
  ],
)

#speaker-note[
  Use the density just introduced as a concrete setting for the three generic
  operations from the preceding section. This slide is the roadmap across
  two sections: describe the joint law and its geometry here, then work out
  marginalization and conditioning in the next section. All three panels use the same
  bivariate Gaussian, with zero mean, unit marginal variances, and correlation
  0.8. The ellipses are equal-density contours, not sample paths or hard bounds.

  Begin with summarization. The dot is the mean vector; the covariance describes
  the cloud's spread and orientation. The vector integral averages every point
  against its joint density. The next slide introduces covariance as another
  expectation, of the centered outer product, and unpacks it entry by entry.

  On reveal 2, show the marginal panel, its integral, and its key point together.
  At each fixed x1, integrate vertically over all x2 values. The highlighted
  column illustrates that operation; it is not a finite-bin approximation.
  The resulting one-dimensional density is shown underneath. Ignoring x2 does
  not mean setting x2 to zero or taking a horizontal slice through the cloud.

  On reveal 3, show conditioning. Here x2 is observed at a=1.5. Hold it fixed,
  take the horizontal slice, and divide by its area to obtain a density in x1.
  The dummy variable u in the denominator ranges over possible x1 values.
  The solid conditional curve shifts right and narrows relative to the dashed
  marginal: its mean is 1.2 and its variance is 0.36. We will derive these rules
  and revisit these numbers later; the present aim is to distinguish the
  operations geometrically. Both curves integrate to one after normalization.

  Close by returning to the first panel: for Gaussians, these operations can be
  expressed using the mean and covariance. In the rest of this section, make
  precise what those parameters record and how they control the geometry.
  The next section will partition them into blocks to marginalize and condition.
]

== Covariance summarizes joint variation

#content-block(
  layout: "top",
  object-width: 96%,
  object: [
    #align(center)[For a vector $bold(x)$ with mean $mu = E[bold(x)]$]
    #v(0.75em)
    #twocol[
      $ Sigma_(i j) &= "Cov"[X_i,X_j] \
        &= E[(X_i-mu_i)(X_j-mu_j)] $

      #uncover("2-")[
        $ Sigma &= E[(bold(x)-mu)(bold(x)-mu)^T] \
          &= E[bold(x)bold(x)^T] - mu mu^T $
      ]
    ][
      #uncover("2-")[#align(center)[
        For three coordinates
        #text(size: 0.8em)[
        $ Sigma = mat(
          V[X_1], "Cov"[X_1,X_2], "Cov"[X_1,X_3];
          "Cov"[X_2,X_1], V[X_2], "Cov"[X_2,X_3];
          "Cov"[X_3,X_1], "Cov"[X_3,X_2], V[X_3];
          delim: "[",
        ) $
        ]
      ]]
    ]
    #source-note[Murphy, Book 1 §3.1.1, Eqs. 3.1–3.4]
  ],
  key-points: [
    #stack(
      spacing: 0.35em,
      [
        - Positive / negative covariance: deviations tend to have the same / opposite signs
      ],
      uncover("2-")[
        - Diagonal entries are variances; off-diagonal entries are covariances
      ],
      uncover("3-")[
        - Zero covariance does not imply independence
      ],
    )
  ],
)

#speaker-note[
  Begin with one covariance entry and the signs of centered deviations.
  Step 2 collects those entries into the outer product and the explicit
  matrix, with its diagonal/off-diagonal interpretation. Reserve the
  independence caveat for step 3 before moving to correlation.

  Return to the summarize operation: covariance is an expectation of products
  of centered coordinates. Carry forward scalar variance: i=j gives the squared
  deviation of one coordinate. For i≠j, the product of deviations is positive
  when they share a sign and negative when their signs differ. Averaging those
  products gives one entry; the outer product collects every pair at once.
  Read the three-coordinate matrix on the right entry by entry using the same
  definition on the left. Setting i=j recovers a variance on the diagonal;
  exchanging i and j leaves the covariance unchanged. The next slide writes
  these same entries as marginal variances and correlation times their scales.
  Expanding gives Cov[X_i,X_j]=E[X_i X_j]-mu_i mu_j, the entrywise version of
  the displayed matrix identity. Rearranging it gives
  E[xxᵀ]=Σ+μμᵀ, which will generate the joint Gaussian covariance later.
  The matrix is symmetric because covariance is symmetric, and it is positive
  semidefinite because aᵀΣa=V[aᵀx]≥0 for every direction a. These properties
  make it a valid description of spread in every direction. For the Gaussian
  model just introduced, the mean and covariance determine the joint law.
  Keep the caveat that zero covariance does not imply independence. To lead
  into correlation, ask what happens if one coordinate changes units: the
  covariance changes too, motivating division by the two standard deviations.
]

== Correlation separates direction from units

#content-block(
  layout: "top",
  object-width: 91%,
  object: [
    #align(center)[$rho_(i j) = frac("Cov"[X_i,X_j], sigma_i sigma_j), quad -1 <= rho_(i j) <= 1$]
    #v(0.85em)
    #uncover("2-")[
      #align(center)[$Sigma = mat(sigma_1^2, rho_12 sigma_1 sigma_2, rho_13 sigma_1 sigma_3; rho_12 sigma_1 sigma_2, sigma_2^2, rho_23 sigma_2 sigma_3; rho_13 sigma_1 sigma_3, rho_23 sigma_2 sigma_3, sigma_3^2; delim: "[")$]
    ]
    #source-note[Murphy, Book 1 §3.1.2, Eq. 3.7; Book 2 §2.3.1.1, Eq. 2.73]
  ],
  key-points: [
    #stack(
      spacing: 0.35em,
      [
        - $rho_(i j)$ describes the direction and strength of linear association
      ],
      uncover("2-")[
        - $sigma_1,sigma_2,sigma_3$ set the coordinate scales
      ],
    )
  ],
)

#speaker-note[
  Define unit-free correlation first. On step 2 reconstruct the covariance
  matrix using the coordinate scales and the correlation for each pair.

  Each coordinate pair has its own correlation. The two-coordinate case
  used in the conditioning examples keeps the matching two-by-two block.
  Correlation is covariance standardized by the two marginal
  standard deviations; it does not encode a slope or all forms of dependence.
]

== Affine maps carry Gaussian means and covariances

#slide(repeat: 4, self => [
  #let uncover = utils.uncover.with(self: self)

  #content-block(
    layout: "top",
    object-width: 96%,
    object: [
      #twocol[
        #align(center)[
          #stack(
            spacing: 0.9em,
            [$bold(y) = A bold(x)+b$],
            [$E[bold(y)] = A mu+b$],
            [$"Cov"[bold(y)] = A Sigma A^T$],
          )
        ]
      ][
        #uncover("2-")[
          #course-card(title: [Covariance proof])[
            #stack(
              spacing: 0.4em,
              [Center: $bold(d) = bold(x)-mu$],
              [$ bold(y) &= A(bold(d)+mu)+b \
                &= A bold(d)+(A mu+b) $],
              [$ bold(y)-E[bold(y)] = A bold(d) $],
              uncover("3-")[
                $ "Cov"[bold(y)] &= E[(A bold(d))(A bold(d))^T] \
                  &= A E[bold(d)bold(d)^T] A^T \
                  & uncover("4-", = A Sigma A^T) $
              ],
            )
          ]
        ]
      ]
      #source-note[Murphy, Book 1 §3.1.1, Eq. 3.5]
    ],
    key-points: [
      #uncover("2-")[- A shift changes the mean but not the covariance]
      #uncover("4-")[- A linear map changes the scale, orientation, and dimension of variation]
    ],
  )
])

#speaker-note[
  State the affine map and its moment rules first, with A and b fixed.
  On reveal 2, introduce d, rewrite y, and subtract its mean. The cancellation
  of b motivates showing the shift key point at this step.
  On reveal 3, expand the covariance, reverse the order when transposing Ad,
  and pull the fixed matrices outside the expectation. Pause before identifying
  the remaining E[ddᵀ] with Σ from the preceding covariance definition.
  On reveal 4, make that substitution and show the linear-map key point as
  the geometric interpretation of the completed result.
  These moment identities hold for any input
  with finite second moments; Gaussian inputs also remain Gaussian under the
  map. This is the main route to the joint law of a linear Gaussian system.
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
    #stack(
      spacing: 0.35em,
      [
        - Equal Mahalanobis distances trace equal-density contours
      ],
      uncover("2-")[
        - With spherical covariance, it becomes squared Euclidean distance in standard-deviation units
      ],
    )
  ],
)

#speaker-note[
  Recall the quadratic expression in the Gaussian density introduced at the
  start of this section. Ask why the same physical displacement may be
  unsurprising in one direction but extreme in another. The inverse covariance
  rescales the direction.
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
  The section summary now brings these shape descriptions together with the
  center, unit-free correlation, distance, and affine transformation rules.
]

== Summary: Joint Gaussian geometry

#content-block(
  layout: "top",
  object-width: 96%,
  object: [
    #align(center)[$bold(x) tilde cal(N)(mu,Sigma)$]
    #grid(
      columns: (0.85fr, 1.15fr),
      gutter: 1em,
      align: horizon,
      course-figure(
        lecture-figure-path("generated/gaussian_geometry__summary.svg"),
        width: 100%, height: 5.5cm, show-source: false,
      ),
      align(left, text(size: 0.8em)[
        #stack(
          spacing: 0.7em,
          [*Location:* $mu$ is the center],
          [
            *Variation:* $Sigma$ sets scale and orientation \
            $rho_(i j) = frac(Sigma_(i j), sigma_i sigma_j)$ removes units
          ],
          [
            *Distance:* $d_Sigma^2=(bold(x)-mu)^T Sigma^(-1)(bold(x)-mu)$ \
            One contour: equal distance and equal density
          ],
        )
      ]),
    )
    #align(center)[#text(size: 0.8em)[
      *Affine maps:* $bold(y)=A bold(x)+b quad arrow.r quad mu_y=A mu+b, quad Sigma_y=A Sigma A^T$
    ]]
    #source-note[Figure: `gaussian_geometry_figures.ipynb`]
  ],
  key-points: [
    - Mean and covariance determine a Gaussian's joint law and geometry
    - Next: ignore some coordinates, or condition on observed ones
  ],
)

#speaker-note[
  Close the section by reading one joint Gaussian through all the vocabulary
  we have developed. Keep this recap static: students need to compare the
  symbols and their geometric meanings simultaneously, not learn new rules.
  Use the same zero-mean, unit-marginal-variance example with correlation 0.8
  as in the three-operations overview. Point first to mu, then to the shape
  encoded by Sigma. Correlation standardizes its off-diagonal entries; it is
  derived from covariance, not an additional independent model parameter.

  The arrow points from mu to x. The marked point lies on the contour with
  squared Mahalanobis distance 2.5; every point on that ellipse has the same
  density in this Gaussian. The ellipses are neither hard bounds nor statements
  that all distributions are determined by their first two moments. Assume
  positive-definite Sigma for the inverse in the distance formula. Recall that
  diagonal and spherical covariance restrict the shape in these coordinates.

  Finish the recap at the affine strip: moving or linearly transforming the
  cloud preserves the Gaussian family and propagates the same two parameters.
  A rank-deficient map can give a degenerate Gaussian; the moment rules still
  hold. The proof belongs to the earlier affine slide, so do not repeat it.

  Then change the question. We now know how to describe the whole vector.
  What if we ignore some coordinates, or know the values of some coordinates?
  Identify these as marginalization and conditioning from the earlier roadmap.
  The next section uses known mean and covariance blocks to answer those
  queries, ending with missing-value prediction and its remaining uncertainty.
  The immediate first step is to partition variables and parameters together.
]

#section-metadata(
  short-title: [Marginals and conditionals],
  subtitle: [Ignore coordinates or use observations to update uncertainty],
)

= Marginals and conditionals of a Gaussian

== Partition the variables and their parameters together

#content-block(
  layout: "top",
  object-width: 94%,
  object: [
    #align(center)[$bold(x)=mat(x_1; x_2), quad mu=mat(mu_1; mu_2)$]
    #v(0.7em)
    #uncover("2-")[
      #align(center)[$Sigma=mat(Sigma_11,Sigma_12;Sigma_21,Sigma_22), quad Sigma_21=Sigma_12^T$]
    ]
    #source-note[Murphy, Book 2 §2.3.1.3, Eq. 2.75]
  ],
  key-points: [
    #stack(
      spacing: 0.35em,
      [
        - $x_1$ and $x_2$ can each be vectors
      ],
      uncover("2-")[
        - The diagonal blocks describe within-group variation
        - The cross blocks describe variation between groups
      ],
    )
  ],
)

#speaker-note[
  Open the section with its goal: obtain a marginal or a conditional from a
  known joint Gaussian. The preceding section supplies mu and Sigma and their
  meaning; no parameter estimation is needed here. We will distinguish
  ignoring a group from observing it, calculate the resulting mean and
  covariance, and use the conditional for missing-value prediction.

  Partition the coordinates and means first. Step 2 reveals the matching
  covariance blocks and both of their interpretations together.

  Treat the block partition as bookkeeping. The symbols refer to two groups
  of coordinates, not necessarily two scalar variables. Point to how every
  mean and covariance block follows the same partition of x.
]

== Marginalization keeps the matching blocks

#slide(repeat: 4, self => [
  #let uncover = utils.uncover.with(self: self)

  #content-block(
    layout: "top",
    object-width: 96%,
    object: [
      #twocol[
        #align(center)[
          #stack(
            spacing: 0.85em,
            [$bold(x) tilde cal(N)(mu,Sigma)$],
            [$ p(x_1) &= integral p(x_1,x_2) dif x_2 \
                &= cal(N)(x_1 | mu_1,Sigma_11) $],
            uncover("4-")[
              $p(x_2)=cal(N)(x_2 | mu_2,Sigma_22)$
            ],
          )
        ]
      ][
        #uncover("2-")[
          #course-card(title: [Marginal proof])[
            #stack(
              spacing: 0.45em,
              [Select $x_1$: $P=mat(I,0,delim: "["), quad x_1=P bold(x)$],
              [By the affine rule: \
                $x_1 tilde cal(N)(P mu,P Sigma P^T)$],
              uncover("3-")[
                $P mu=mu_1$
              ],
              uncover("3-")[
                $ P Sigma P^T &= mat(I,0,delim: "[") mat(Sigma_11,Sigma_12,delim: "[") mat(I;0,delim: "[") \
                  & uncover("4-", = Sigma_11) $
              ],
            )
          ]
        ]
      ]
      #source-note[Murphy, Book 2 §2.3.1.3, Eqs. 2.76–2.77; affine rule: Book 1 §3.1.1, Eq. 3.5]
    ],
    key-points: [
      #stack(
        spacing: 0.35em,
        [- Marginalizing $x_2$ integrates over all its possible values],
        uncover("4-")[
          - Cross-covariance affects conditioning, not the marginal of $x_1$
        ],
      )
    ],
  )
])

#speaker-note[
  Begin with the joint Gaussian assumption and the first marginal as the
  claim to prove. The base key point interprets the integral: we keep x1
  and sum over all values of x2, without observing or setting x2 to zero.
  The matching partition of x, mu, and Sigma is carried from the previous slide.

  On reveal 2, introduce the selector P=[I,0]. If x1 has d1 coordinates and
  x2 has d2, I is d1 by d1 and the zero block is d1 by d2. Multiplying by P
  retains x1. Apply the affine Gaussian result from the preceding section,
  with A=P and b=0: x1 is Gaussian with mean P mu and covariance P Sigma P^T.
  This closure property is essential: matching two moments alone would not
  establish the marginal distribution for an arbitrary joint law.

  On reveal 3, identify the mean block and multiply the covariance on the
  left by P to keep its first block row. The remaining multiplication by
  P^T keeps that row's first block. Pause for students to finish the product
  and predict the marginal of x2; keep the second marginal hidden everywhere.

  On reveal 4, show Sigma11 as the covariance, the second marginal obtained
  by the selector [0,I], and the cross-covariance interpretation together.
  No assumption that Sigma12 is zero was made: the groups may be correlated.
  The linear-image proof identifies the same distribution defined by the
  marginal integral, without evaluating that integral directly. Lead into
  conditioning by asking what changes when x2 is observed instead of ignored;
  the next slide uses the cross-covariance to respond to its observed deviation.
]

== Conditioning shifts the mean by an observed deviation

#slide(repeat: 4, self => [
  #let uncover = utils.uncover.with(self: self)

  #content-block(
    layout: "top",
    object-width: 96%,
    object: [
      #twocol[
        #align(center)[
          #stack(
            spacing: 0.85em,
            [$p(x_1 | x_2)=cal(N)(x_1 | mu_(1|2),Sigma_(1|2))$],
            [$ mu_(1|2) &= mu_1 
                &+Sigma_12 Sigma_22^(-1)(x_2-mu_2) $],
          )
        ]
      ][
        #uncover("2-")[
          #course-card(title: [Mean proof])[
            #text(size: 0.84em)[
              #stack(
                spacing: 0.5em,
                [$B=Sigma_12 Sigma_22^(-1)$],
                [$r=x_1-mu_(1|2)=x_1-mu_1-B(x_2-mu_2)$],
                uncover("3-")[
                  $E[r]=0$,
                  $ "Cov"[r,x_2] &= Sigma_12-B Sigma_22 \
                    &= 0 $
                ],
                uncover("3-")[
                  $(r,x_2)$ is jointly Gaussian: \
                  zero cross-covariance gives independence
                ],
                uncover("4-")[
                  $E[r | x_2]=E[r]=0$
                ],
                uncover("4-")[
                  $E[x_1 | x_2]=mu_(1|2)$
                ],
              )
            ]
          ]
        ]
      ]
      #source-note[Murphy, Book 2 §2.3.1.3, Eq. 2.78; proof uses affine Gaussian closure]
    ],
    key-points: [
      #stack(
        spacing: 0.35em,
        [- Start at the prior mean $mu_1$],
        uncover("2-")[- Respond to the innovation $x_2-mu_2$],
        uncover("4-")[- Cross-covariance and observed variance determine the response],
      )
    ],
  )
])

#speaker-note[
  State the conditional Gaussian and its mean update as the claim to prove.
  Carry forward the joint Gaussian assumption and matching covariance blocks;
  assume Sigma22 is invertible. Begin at the prior location mu1. The observed
  deviation x2-mu2 is the innovation, and the update responds to it linearly.

  On reveal 2, abbreviate the response matrix by B and define the residual
  directly as $r=x_1-mu_(1|2)$: deviation from the proposed conditional mean on
  the left. At this point $mu_(1|2)$ names the candidate expression
  mu1+B(x2-mu2); the proof verifies that it is the conditional expectation.
  Thus r=(x1-mu1)-B(x2-mu2), so it is centered before conditioning as well.
  Choosing B=Sigma12 Sigma22^(-1) removes its association with x2. Reveal the
  innovation key point with this subtraction. B maps observed deviations to
  corrections in the unobserved block.

  On reveal 3, compute Cov(r,x2)=Sigma12-B Sigma22=0. The pair (r,x2) is an
  affine transformation of the original joint Gaussian, so it is jointly
  Gaussian. In this family, zero cross-covariance gives independence: its
  block-diagonal covariance makes the joint Gaussian density factorize.
  This is precisely where Gaussianity matters. Zero covariance alone would
  not justify the next step for an arbitrary joint distribution.

  On reveal 4, independence gives E[r|x2]=E[r]=0; the last equality follows
  because r is a difference of centered variables. Rearrange the residual
  definition as $x_1=mu_(1|2)+r$, hold x2 fixed, and take its conditional
  expectation. This verifies the proposed mean, rather than assuming that a
  residual already has zero conditional expectation by its name. Reveal the
  response key point with this conclusion. If Sigma12 is zero, there is no
  update; if x2 equals mu2, there is no mean shift even for correlated blocks.

  The independent residual also explains why the conditional law is Gaussian:
  it is the Gaussian r shifted by mu1+B(x2-mu2). This slide establishes the
  center. The next slide identifies its remaining covariance, which is the
  covariance of r. Later, the Schur complement and quadratic decomposition
  name and interpret the same residual and covariance.
]

== Conditioning removes explained covariance

#slide(repeat: 4, self => [
  #let uncover = utils.uncover.with(self: self)

  #content-block(
    layout: "top",
    object-width: 96%,
    object: [
      #twocol[
        #align(center)[
          #stack(
            spacing: 1.2em,
            [$Sigma_(1|2)=Sigma_11-Sigma_12 Sigma_22^(-1) Sigma_21$],
            uncover("4-")[
              $Sigma_(2|1)=Sigma_22-Sigma_21 Sigma_11^(-1) Sigma_12$
            ],
          )
        ]
      ][
        #uncover("2-")[
          #course-card(title: [Covariance proof])[
            #text(size: 0.84em)[
              #stack(
                spacing:0.9em,
                [$B=Sigma_12 Sigma_22^(-1)$],
                [$r=x_1-mu_(1|2)$],
                [From the mean proof: $r$ and $x_2$ are independent],
                uncover("3-")[
                  #stack(
                    spacing: 0.8em,
                  [Given $x_2$, the mean $mu_(1|2)$ is constant],
                  [$Sigma_(1|2)="Cov"[x_1 | x_2]="Cov"[r]$],

                  )
                ],
                uncover("3-")[
                  $Sigma_11=B Sigma_22 B^T+"Cov"[r]$
                ],
                uncover("4-")[
                  $ Sigma_(1|2) &= Sigma_11-B Sigma_22 B^T \
                    &= Sigma_11-Sigma_12 Sigma_22^(-1) Sigma_21 $
                ],
              )
            ]
          ]
        ]
      ]
      #source-note[Murphy, Book 2 §2.3.1.3, Eqs. 2.78–2.79; proof reuses the independent residual]
    ],
    key-points: [
      #stack(
        spacing: 0.35em,
        [- Conditioning cannot increase variance in any direction],
        uncover("4-")[
          - In a Gaussian, this covariance depends on which variables are observed, not their values
        ],
      )
    ],
  )
])

#speaker-note[
  Read the first update as marginal minus explained covariance, the claim to
  prove. Carry forward the joint Gaussian model and its positive-definite
  covariance so the required block inverses exist. The base key point refers
  to variance in every direction, not to an entrywise ordering of matrices.

  On reveal 2, recall exactly the B and $r=x_1-mu_(1|2)$ from the mean proof. That slide
  established that r and x2 are independent using their joint Gaussian law
  and zero cross-covariance. Reuse that result rather than re-proving it.

  On reveal 3, hold x2 fixed in $x_1=mu_(1|2)+r$. The conditional mean is
  now a constant shift, so the conditional covariance is Cov(r|x2). Independence
  makes this Cov(r). Before conditioning, the same decomposition has independent
  random parts B(x2-mu2) and r, whose covariances add. The affine covariance
  rule gives Sigma11=B Sigma22 B^T+Cov(r); both cross terms vanish. This identifies
  B Sigma22 B^T as the covariance of the part predicted from x2.

  On reveal 4, subtract that explained part and substitute B. Since Sigma22
  is symmetric, B Sigma22 B^T=Sigma12 Sigma22^(-1) Sigma21. Reveal the reverse
  conditioning formula and the values-independent key point with the result.
  Exchanging the two blocks gives the second rule without repeating the proof.

  The explained covariance is positive semidefinite: along any direction a,
  a^T B Sigma22 B^T a is the variance of a^T B x2 and is nonnegative. Thus the
  conditional variance cannot exceed the marginal variance in any direction.
  There may be no reduction in some directions, including when Sigma12 is zero.
  For fixed model parameters and a fixed observed block, changing the observed
  value changes the mean but leaves this residual covariance unchanged.
  The next slide specializes both updates to two scalar coordinates; later the
  Schur complement gives this same remaining covariance a standard name.
]

== The bivariate formula gives intuition

#content-block(
  layout: "top",
  object-width: 93%,
  object: [
    #align(center)[
      #stack(
        spacing: 1.5em,
        [$x_1, x_2 in RR$],
        [$( X_1 | X_2=x_2 ) tilde cal(N)(mu_(1|2), sigma_(1|2)^2)$],
        [$mu_(1|2) = mu_1 + rho frac(sigma_1,sigma_2)(x_2-mu_2)$],
        [$sigma_(1|2) = sigma_1 sqrt(1-rho^2)$],
      )
    ]
    #source-note[Murphy, Book 1 §3.2.4; Book 2 §2.3.1.3]
  ],
  key-points: [
    #stack(
      spacing: 0.35em,
      [
        - Positive $rho$ moves the estimate in the observed direction
      ],
      uncover("2-")[
        - $rho=0$ leaves both mean and variance unchanged
        - Larger $|rho|$ leaves less conditional variance
      ],
    )
  ],
)

#speaker-note[
  Read the conditional law, then its separate mean and standard-deviation
  formulas. The second argument of N is a variance throughout this deck, so
  it is sigma_(1|2)^2, while the last line displays sigma_(1|2) itself.
  Assume positive marginal standard deviations and correlation strictly between
  -1 and 1 for a nondegenerate joint Gaussian. Begin with the mean shift. Ask students to use the formulas to
  reason about zero and strong correlation, then reveal those interpretations
  together on step 2.

  Substitute the two-coordinate covariance block from the previous section into
  the block formula. The scalar expression lets students reason about sign,
  units, and remaining variance. For a joint Gaussian, zero correlation also
  gives independence; that is special to this family.
]

== One observed coordinate can change both the estimate and its uncertainty

#content-block(
  layout: "top",
  object-width: 91%,
  object: [
    #align(center)[$x_1|2 ~ cal(N)(mu_1 + rho frac(sigma_1,sigma_2)(x_2-mu_2), (1-rho^2) sigma_1^2) \ x_1 ~ cal(N)(0, 1), quad x_2 ~ cal(N)(0, 1), quad rho=0.8$]
    #uncover("2-")[
      #v(0.8em)
      #align(center)[$x_2=1.5 \ x_1 | x_2=1.5 tilde cal(N)(0.8(1.5),1-0.8^2)=cal(N)(1.2,0.36)$]
    ]
    #source-note[Worked example of Murphy, Book 2 §2.3.1.3, Eq. 2.78]
  ],
  key-points: [
    #stack(
      spacing: 0.35em,
      uncover("2-")[
        - The observed value lies above its mean, so the conditional mean rises
        - The variance falls from $1$ to $0.36$
      ],
    )
  ],
)

#speaker-note[
  Show only the numerical assumptions on the base slide. Keep both answer
  key points hidden during the prediction pause; reveal them with the
  calculation on step 2.

  Ask for the direction of the mean change and whether uncertainty rises or
  falls before revealing the calculation. The 0.8 correlation transfers part
  of the 1.5 deviation; the remaining variance is independent of the exact
  observed value. Reuse this numerical intuition when reading the matrix rule.
]

== The Schur complement is the residual covariance

#content-block(
  layout: "top",
  object-width: 96%,
  object: [
    #twocol[
      #course-card(title: [Conditional Gaussian])[
        #text(size: 0.84em)[
          #stack(
            spacing: 0.7em,
            [$mu_(1|2)=mu_1+Sigma_12 Sigma_22^(-1)(x_2-mu_2)$],
            [$S=Sigma_(1|2)=Sigma_11-Sigma_12 Sigma_22^(-1) Sigma_21$],
            [$(x_1 | x_2) tilde cal(N)(mu_(1|2),S)$],
          )
        ]
      ]
    ][
      #course-card(title: [Centered residual])[
        #text(size: 0.84em)[
          #stack(
            spacing: 0.7em,
            [$r=x_1-mu_(1|2)$],
            uncover("2-")[$r tilde cal(N)(0,S)$],
            uncover("2-")[The residual $r$ is independent of $x_2$],
          )
        ]
      ]
    ]
    #uncover("3-")[#align(center)[#text(size: 0.84em)[
      Remove the part predicted by $x_2$:
      $ "Cov"[mat(r; x_2)] = mat(S,0; 0,Sigma_22) $
    ]]]
    #source-note[Murphy, Book 2 §2.3.1.5, Eqs. 2.91, 2.102–2.103]
  ],
  key-points: [
    #stack(
      spacing: 0.35em,
      uncover("2-")[
        - $S$ measures the uncertainty left after subtracting the conditional mean
      ],
      uncover("3-")[
        - Block elimination leaves $S$: the *Schur complement of $Sigma_22$ in $Sigma$*
      ],
    )
  ],
)

#speaker-note[
  Collect the two conditioning results already proved: $mu_(1|2)$ is the
  conditional mean and S is shorthand for $Sigma_(1|2)$. Place their Gaussian
  law beside the same residual $r=x_1-mu_(1|2)$ introduced in the mean proof.
  The mean is a function of x2; r is defined jointly with the random x2 before
  a value is fixed. Assume a positive-definite joint covariance throughout.

  On reveal 2, shift the conditional Gaussian to zero mean. Subtracting its
  mean preserves its covariance, giving r|x2 distributed as N(0,S). The earlier
  proof established r independent of x2, so the unconditional law is also
  r distributed as N(0,S). These are the same uncertainty expressed around
  the conditional center or around zero. Show the uncertainty key point here.

  On reveal 3, explain the algebraic name. For a block matrix with blocks
  A,B,C,D and invertible D, block elimination leaves A-B D^(-1) C as the
  remaining block; this is called the Schur complement of D. Here D is
  Sigma22 and the remaining block is S. More concretely, multiply centered
  coordinates by T with block rows [I,-B] and [0,I], where B=Sigma12 Sigma22^(-1).
  Their covariance becomes T Sigma T^T, with diagonal blocks S and Sigma22
  and zero cross blocks, as displayed. This removes the predictable coupling
  to x2; it is not the operation of marginalizing x2, which leaves Sigma11.
  The transformation explains the word complement as the block left after
  eliminating the other block's coupling. The name honors Issai Schur.

  Naming reference: https://www.cfm.brown.edu/people/dobrush/cs52/python/Part2/partition.html
  Block-elimination reference: https://www.cs.cornell.edu/courses/cs6210/2025fa/lec/2025-09-15.html
  Keep the history and full multiplication in notes. The useful content for
  this lecture is that S is exactly the covariance of the independent residual.
  Lead into the next slide: r and S specify the conditional Gaussian exponent
  r^T S^(-1) r, while the observed block supplies the marginal exponent.
]

== The joint quadratic separates into conditional and marginal parts

#content-block(
  layout: "top",
  object-width: 95%,
  object: [
    #align(center)[$p(x_1,x_2)=p(x_1 | x_2)p(x_2)$]
    #align(center)[$(bold(x)-mu)^T Sigma^(-1)(bold(x)-mu)$]
    #v(0.55em)
    #uncover("2-")[
      #align(center)[$= r^T S^(-1)r+(x_2-mu_2)^T Sigma_22^(-1)(x_2-mu_2)$]
    ]
    #v(0.6em)
    #source-note[Murphy, Book 2 §2.3.1.5, Eqs. 2.94–2.103]
  ],
  key-points: [
    #stack(
      spacing: 0.35em,
      uncover("2-")[
        - The first quadratic describes $x_1$ after seeing $x_2$
        - The second describes the marginal distribution of $x_2$
      ],
    )
  ],
)

#speaker-note[
  Recall $r=x_1-mu_(1|2)$ and $S="Cov"[r]=Sigma_(1|2)$ from the preceding slide.
  Start with the joint quadratic. Step 2 shows its decomposition and
  interprets both terms; step 3 turns the sum in the exponent into the
  conditional-times-marginal factorization of the density.

  This is the proof idea behind the moment-form conditioning rule. Block
  inversion rewrites the joint exponent as two Gaussian exponents. Their
  factors become p(x1|x2) and p(x2). Keep the detailed matrix multiplication
  in the book; the two terms and their interpretation are the live result.
]

== Summary: Marginals and conditionals of a Gaussian

#content-block(
  layout: "top",
  object-width: 96%,
  object: [
    #align(center)[#text(size: 0.85em)[
      $mat(x_1; x_2) tilde cal(N)(mat(mu_1; mu_2), mat(Sigma_11,Sigma_12; Sigma_21,Sigma_22))$
    ]]
    #twocol[
      #course-card(title: [Ignore $x_2$: marginalize])[
        #text(size: 0.82em)[
          #stack(
            spacing: 0.75em,
            [$x_1 tilde cal(N)(mu_1,Sigma_11)$],
          )
        ]
      ]
    ][
      #course-card(title: [Observe $x_2=a$: condition])[
        #text(size: 0.82em)[
          #stack(
            spacing: 0.75em,
            [$(x_1 | x_2=a) tilde cal(N)(mu_(1|2),S)$],
            [$mu_(1|2)=mu_1+Sigma_12 Sigma_22^(-1)(a-mu_2)$],
            [$S=Sigma_11-Sigma_12 Sigma_22^(-1) Sigma_21$],
          )
        ]
      ]
    ]
    #source-note[Murphy, Book 2 §2.3.1: Gaussian marginals and conditionals]
  ],
  key-points: [
    - Conditioning gives a mean and remaining uncertainty: $S=Sigma_(1|2)$
    - The observed value changes the mean; $S$ depends only on the covariance blocks
    - If $Sigma_12=0$, observing $x_2$ gives the same law as ignoring it
  ],
)

#speaker-note[
  Keep this recap static so students can compare both queries at once. Begin
  with the known joint Gaussian at the top, then ask what information each
  branch uses. Marginalization averages over the second group; conditioning
  uses its observed value a. Neither operation fits the model parameters.
  Assume a positive-definite joint covariance, as in the preceding proofs.

  Recall that the conditional mean is the starting mean plus a response to
  a-mu2. S is the Schur complement of Sigma22 and the covariance of the
  independent residual from the earlier proof. The covariance reduction is
  positive semidefinite: uncertainty cannot increase in any direction, but
  there need not be a strict decrease. If Sigma12 is zero, the groups are
  independent and both branches give the same law. If a equals mu2, the mean
  stays put even when the covariance is reduced. For fixed observed coordinates,
  changing a changes the mean but not S. Do not repeat the quadratic proof.

  Close by asking students to identify the blocks used by each operation.
  The section's result is that a known joint Gaussian answers both queries
  exactly: retain matching blocks when marginalizing, and update the mean
  and covariance when conditioning. Keep the recap entirely retrospective.
]

#section-metadata(
  short-title: [Linear Gaussian systems],
  subtitle: [Inference from noisy linear measurements],
)

= Linear Gaussian systems


== A linear Gaussian system is a model of state and measurement

#content-block(
  layout: "top",
  object-width: 96%,
  object: [
    #grid(
      columns: (0.8fr, 1.2fr), gutter: 1em, align: horizon,
      linear_gaussian_graph(),
      [#course-card(title: [A prior and a measurement law])[
        #text(size: 0.85em)[
          $ z tilde cal(N)(mu_z,Sigma_z) $
          $ y | z tilde cal(N)(W z+b,Omega) $
          $ p(z,y)=p(z)p(y | z) $
        ]
      ]],
    )
    #uncover("2-")[#align(center)[#text(size: 0.85em)[
      $ y=W z+b+epsilon, quad epsilon tilde cal(N)(0,Omega) $
      Noise $epsilon$ is independent of the state $z$.
    ]]]
    #source-note[Murphy, Book 2 §2.3.2, Eqs. 2.118–2.119]
  ],
  key-points: [
    #stack(
      spacing: 0.35em,
      [- This model specifies how an unknown state generates a noisy measurement],
      uncover("2-")[- Here the parameters $mu_z, Sigma_z, W, b, Omega$ are given],
    )
  ],
)

#speaker-note[
  Introduce a generative probability model, not an inference algorithm.
  Read the directed edge from the latent state z to the measured y: the model
  specifies a state prior and the conditional measurement law. The shaded y
  node marks the variable available in the inference problem. It remains a
  random variable when predicting measurements before seeing them.

  On step 2, write the equivalent affine equation with independent Gaussian
  noise. W maps an L-dimensional state to a D-dimensional measurement, b is
  an offset, and Omega is noise covariance. Assume positive-definite Sigma_z
  and Omega throughout the inverse-based formulas in this section.
  All model parameters are given; no fitting procedure has been introduced.
  The next slide asks which distributions this one model lets us compute.
]

== All three of our operations work on Linear Gaussian systems

#content-block(
  layout: "top",
  object-width: 96%,
  object: [
    #stack(
      spacing: 0.65em,
      [#course-card(title: [Summarize])[
        #text(size: 0.85em)[$p(z,y)$ #h(1em) Construct the joint Gaussian with *affine rules*]
      ]],
      uncover("2-")[#course-card(title: [Prediction task: what measurements are plausible?])[
        #text(size: 0.85em)[$p(y)=integral p(z,y) dif z$ #h(1em) *Marginalize* the unknown state]
      ]],
      uncover("3-")[#course-card(title: [Inference task: what state explains the measurement?])[
        #text(size: 0.85em)[$p(z | y)=p(z,y)/p(y)$ #h(1em) *Condition* on the observed measurement]
      ]],
    )
  ],
  key-points: [
    #stack(
      spacing: 0.35em,
      [- The model is fixed; the task determines which distribution we need],
      uncover("3-")[- Gain and precision forms will express the same inference solution],
    )
  ],
)

#speaker-note[
  Make the problems explicit before doing their algebra. The joint task asks
  how z and y vary together; its solution supplies the blocks needed for both
  other queries. The generative specification p(z)p(y|z) is already known;
  the first job is to collect it into a multivariate Gaussian.

  Reveal prediction next: no value of y is supplied, and z is integrated out.
  Reveal inference last: a measured y is supplied, and we seek a distribution
  over z. This is the same marginalization-versus-conditioning distinction
  developed in the previous section. Gain and precision are alternative
  representations of this posterior, not additional distributions or tasks.
]

== Joint task: construct the state and measurement law

#content-block(
  layout: "top",
  object-width: 96%,
  object: [
    #align(center)[#text(size: 0.8em)[Find $p(z,y)$: apply the affine rules to $(z,epsilon)$.]]
    #twocol[
      #course-card(title: [Linear Gaussian model])[
        #text(size: 0.8em)[
          #stack(
            spacing: 0.45em,
            [$z tilde cal(N)(mu_z,Sigma_z)$],
            [$y=W z+b+epsilon$],
            [$epsilon tilde cal(N)(0,Omega)$, independent of $z$],
          )
        ]
      ]
    ][
      #course-card(title: [Affine rules])[
        #text(size: 0.8em)[
          #stack(
            spacing: 0.45em,
            [$u=A x+c$],
            [$E[u]=A E[x]+c$],
            [$"Cov"[u]=A "Cov"[x] A^T$],
          )
        ]
      ]
    ]
    #uncover("2-")[
      #align(center)[#text(size: 0.82em)[
        $ E[mat(z;y)]=mat(mu_z;W mu_z+b) $
        $ "Cov"[mat(z;y)]=mat(Sigma_z,Sigma_z W^T;W Sigma_z,W Sigma_z W^T+Omega) $
      ]]
    ]
    #source-note[Murphy, Book 2 §2.3.2.1, Eq. 2.120]
  ],
  key-points: [
    #stack(
      spacing: 0.35em,
      uncover("2-")[
        - $"Cov"[z,y]=Sigma_z W^T$ links state and measurement
        - Measurement variance combines projected state uncertainty and noise
      ],
    )
  ],
)

#speaker-note[
  Solve the joint task announced on the task slide.
  On the base slide, recall the two model equations and the independent noise
  assumption alongside the affine mean and covariance rules. Ask students to
  predict the joint moments, especially where the noise covariance enters.
  On step 2, reveal both joint equations and their two interpretations together.

  Apply the affine rules to the augmented vector (z,epsilon): its mean is
  (mu_z,0) and its covariance is block diagonal with blocks Sigma_z and Omega.
  The map to (z,y) has block rows [I,0] and [W,I], with offset (0,b).

  Derive the lower-right block with y=Wz+b+epsilon: independent noise adds
  Omega to W Sigma_z W^T. Derive the cross block using covariance of z and
  Wz. These are precisely the affine and cross-covariance facts introduced in
  the joint-uncertainty section.
]

== Prediction task: marginalize the unknown state

#content-block(
  layout: "top",
  object-width: 92%,
  object: [
    #align(center)[$ p(y)=integral p(z,y) dif z $]
    #align(center)[$m=W mu_z+b, quad S=W Sigma_z W^T+Omega$]
    #v(0.85em)
    #uncover("2-")[
      #align(center)[$p(y)=cal(N)(y | m,S)$]
    ]
    #source-note[Murphy, Book 2 §2.3.2.2, Eq. 2.129]
  ],
  key-points: [
    #stack(
      spacing: 0.35em,
      [
        - $m$ is the predicted measurement
        - $S$ combines uncertainty in the state with sensor noise
      ],
      uncover("2-")[
        - $p(y)$ scores how plausible an observed measurement is under the model
      ],
    )
  ],
)

#speaker-note[
  Solve the prediction task by keeping the y blocks of the joint Gaussian.
  Here S denotes measurement covariance, not the preceding section's residual covariance.
  Name the predictive moments from the joint blocks first. Step 2
  collects them into the marginal density and explains what it can score.

  This is the marginal of the joint distribution, before any particular y is
  observed. In the posterior update, y-m will be the prediction error or
  innovation. The same density p(y) is the normalizing evidence for Bayes'
  rule and can be used as a marginal likelihood.
]

== Inference task: condition on the measurement

#content-block(
  layout: "top",
  object-width: 94%,
  object: [
    #align(center)[$p(z | y)=cal(N)(z | mu_(z|y),Sigma_(z|y))$]
    #v(0.65em)
    #uncover("2-")[
      #align(center)[$mu_(z|y)=mu_z+Sigma_z W^T S^(-1)(y-m)$]
    ]
    #v(0.55em)
    #uncover("3-")[
      #align(center)[$Sigma_(z|y)=Sigma_z-Sigma_z W^T S^(-1)W Sigma_z$]
    ]
    #source-note[Murphy, Book 2 §2.3.2.2, Eq. 2.121]
  ],
  key-points: [
    #stack(
      spacing: 0.35em,
      uncover("2-")[
        - The posterior mean responds to the innovation $y-m$
      ],
      uncover("3-")[
        - The posterior covariance subtracts explained uncertainty
      ],
    )
  ],
)

#speaker-note[
  State the posterior query first. Step 2 substitutes the joint blocks
  into the conditional mean; step 3 does the same for covariance. Pair each
  formula with its interpretation so the two operations remain distinct.

  Plug the joint blocks from Eq. 2.120 into the general conditional Gaussian
  rule. This is Bayes' rule for Gaussians: a Gaussian prior and linear Gaussian
  likelihood yield a Gaussian posterior. Do not present this as an unrelated
  formula to memorize.
]

== Inference solution: gain times innovation

#content-block(
  layout: "top",
  object-width: 92%,
  object: [
    #align(center)[#text(size: 0.8em)[How strongly should $y-m$ correct our estimate of $z$?]]
    #align(center)[$K=Sigma_z W^T S^(-1)$]
    #v(0.7em)
    #uncover("2-")[
      #align(center)[$mu_(z|y)=mu_z+K(y-m), quad Sigma_(z|y)=Sigma_z-K S K^T$]
    ]
    #source-note[Murphy, Book 2 §2.3.2.2, Eqs. 2.122–2.126]
  ],
  key-points: [
    #stack(
      spacing: 0.35em,
      [
        - $K$ converts a measurement error into a state correction
      ],
      uncover("2-")[
        - Less reliable observations contribute a smaller correction
      ],
    )
  ],
)

#speaker-note[
  Name the gain and its role first. Step 2 rewrites both updates with K;
  use the compact form to discuss how observation noise changes trust.

  The Kalman gain is just a name for the block-conditioning coefficient.
  The covariance expression uses KSK^T=Sigma_z W^T S^-1 W Sigma_z. Emphasize
  the structure of the update and the dimensions: K maps D-dimensional
  observations to L-dimensional states.
]

== Inference solution: switch to precision coordinates

#content-block(
  layout: "top",
  object-width: 92%,
  object: [
    #align(center)[#text(size: 0.8em)[How can we express $p(z | y)$ so prior and measurement contributions add?]]
    #align(center)[$Lambda=Sigma^(-1), quad eta=Lambda mu$]
    #v(0.65em)
    #uncover("2-")[
      #align(center)[$mu=Lambda^(-1)eta, quad Sigma=Lambda^(-1)$]
    ]
    #v(0.65em)
    #uncover("3-")[
      #align(center)[$log p(bold(x)) = bold(x)^T eta-frac(1,2) bold(x)^T Lambda bold(x)+"constant"$]
    ]
    #source-note[Murphy, Book 2 §2.3.1.4, Eqs. 2.80–2.83]
  ],
  key-points: [
    #stack(
      spacing: 0.35em,
      [
        - $Lambda$ is the precision matrix; $eta$ is the precision-weighted mean
      ],
      uncover("3-")[
        - Expanding the Gaussian exponent exposes a linear and a quadratic term
      ],
    )
  ],
)

#speaker-note[
  Define the new parameters first. Step 2 recovers the familiar moments
  to establish equivalence; step 3 exposes the log-density terms that will
  make information addition possible.

  Reparameterize the same normalized Gaussian; no new distribution has been
  introduced. Completing the square recovers the moment parameters. The
  normalizing constant is
  $exp(-frac(1,2)eta^T Lambda^(-1)eta) /
  ((2 pi)^(D/2) |Lambda^(-1)|^(1/2))$.
  The x-dependent terms are what make Gaussian combination and conditioning
  simple.
]

== Inference solution: add prior and measurement information

#content-block(
  layout: "top",
  object-width: 94%,
  object: [
    #align(center)[#text(size: 0.8em)[Find the same $p(z | y)$ by combining prior and measurement information.]]
    #align(center)[$Sigma_(z|y)^(-1)=Sigma_z^(-1)+W^T Omega^(-1)W$]
    #v(0.75em)
    #uncover("2-")[
      #align(center)[$mu_(z|y)=Sigma_(z|y)(Sigma_z^(-1)mu_z+W^T Omega^(-1)(y-b))$]
    ]
    #source-note[Murphy, Book 2 §2.3.2.2, Eqs. 2.127–2.128]
  ],
  key-points: [
    #stack(
      spacing: 0.35em,
      [
        - Posterior precision is prior precision plus measurement information
      ],
      uncover("2-")[
        - This is the same posterior as the gain form
      ],
    )
  ],
)

#speaker-note[
  First add the quadratic coefficients to obtain posterior precision.
  Step 2 combines the precision-weighted means and identifies the result
  with the posterior already obtained in gain form.

  Show the correspondence with information-form multiplication: quadratic
  coefficients add. The matrix inversion lemma connects this state-space form
  to the observation-space gain form. Either may be computationally better,
  depending on whether L or D is smaller.
]

== Inference example: estimate a state from one measurement

#content-block(
  layout: "top",
  object-width: 91%,
  object: [
    #align(center)[#text(size: 0.8em)[Given $y=1$, find $p(z | y=1)$ and a squared-error estimate of $z$.]]
    #align(center)[$z tilde cal(N)(0,1), quad y | z tilde cal(N)(z,0.25), quad y=1$]
    #uncover("2-")[
      #v(0.75em)
      #align(center)[$Sigma_(z|y)=frac(1,1+4)=0.2, quad mu_(z|y)=0.2(4)=0.8$]
    ]
    #uncover("2-")[#align(center)[$p(z | y=1)=cal(N)(z | 0.8,0.2), quad hat(z)=0.8$]]
    #source-note[Worked example from Murphy, Book 1 §3.3.1 and Book 2 §2.3.2.2]
  ],
  key-points: [
    #stack(
      spacing: 0.35em,
      uncover("2-")[
        - A precise observation moves the posterior mean toward the measurement
        - Under squared error, report the posterior mean: $hat(z)=0.8$
      ],
    )
  ],
)

#speaker-note[
  Keep both conclusions hidden while students predict from the prior,
  likelihood, and observation. Reveal the numerical update and both
  interpretations together on step 2.

  The loss is squared state-estimation error. For this loss, the conditional
  mean minimizes posterior expected loss; uncertainty is still given by 0.2.
  Have students predict whether the posterior mean is nearer zero or one.
  Prior precision is one and observation precision is four, so the answer is
  four-fifths of the way toward y=1. The variance 0.2 comes from total
  precision five. The example grounds the matrix formulas without a new model.
]

== Summary: Linear Gaussian tasks and solutions

#content-block(
  layout: "top",
  object-width: 96%,
  object: [
    #align(center)[#text(size: 0.85em)[$z tilde cal(N)(mu_z,Sigma_z), quad y=W z+b+epsilon$]]
    #triad[
      #course-card(title: [Joint])[
        $p(z,y)$ \
        #text(size: 0.8em)[Affine rules build the joint mean and covariance]
      ]
    ][
      #course-card(title: [Prediction])[
        $p(y)$ \
        #text(size: 0.8em)[Marginalization keeps the measurement blocks]
      ]
    ][
      #course-card(title: [Inference])[
        $p(z | y)$ \
        #text(size: 0.8em)[Conditioning gives a state estimate and uncertainty]
      ]
    ]
    #align(center)[#text(size: 0.82em)[
      *Two forms of the same posterior:*
      $ mu_(z|y)=mu_z+K(y-m) $
      $ Sigma_(z|y)^(-1)=Sigma_z^(-1)+W^T Omega^(-1)W $
    ]]
  ],
  key-points: [
    - One model answers different tasks through different probability queries
    - Gain corrects a prediction; precision adds prior and measurement information
  ],
)

#speaker-note[
  Keep this summary static and retrospective. Read the three tasks with the
  operation that solved each. The joint law was constructed from the independent
  state and noise; the prediction was a marginal; the inverse problem was a
  conditional. In the recalled model, epsilon is independent Gaussian noise
  with zero mean and covariance Omega.

  Recall m=W mu_z+b, S=W Sigma_z W^T+Omega, and K=Sigma_z W^T S^(-1).
  The two displayed identities highlight complementary interpretations of
  the same posterior, not separate inference algorithms with different answers.
  The scalar example verified both views with mean 0.8 and variance 0.2.
  Conclude with what was solved; do not introduce a new topic or future task.
]

== Summary: Task, experience, and performance

#content-block(
  layout: "top",
  object-width: 96%,
  object: [
    #triad[
      #course-card(title: [Task])[
        #text(size: 0.8em)[
          Estimate the state from a measurement.
          $y arrow.r p(z | y) arrow.r hat(z)$
        ]
      ]
    ][
      #course-card(title: [Experience])[
        #text(size: 0.8em)[
          Training examples can determine the model parameters.
          $D={(y_n,z_n)}_(n=1)^N$
        ]
      ]
    ][
      #course-card(title: [Performance])[
        #text(size: 0.8em)[
          Evaluate estimates on held-out cases.
          $ell(z,hat(z))=norm(z-hat(z))^2$
        ]
      ]
    ]
    #align(center)[#text(size: 0.85em)[
      For squared error, the posterior gives the estimate:
      $ hat(z)=E[z | y]=mu_(z|y) $
    ]]
  ],
  key-points: [
    - This section solved inference with given parameters; it did not fit the model
    - Learning requires performance on the task to improve with experience
  ],
)

#speaker-note[
  Close the section by applying the earlier task/experience/performance
  definition to the state-estimation problem we have just solved. Keep all
  three visible so their roles can be compared. Task: estimate z from y.
  Performance: squared error on held-out pairs. The conditional mean is the
  optimal action for posterior expected squared error under the assumed model.
  It need not be optimal for a different loss or a misspecified model.

  Experience means training examples used to determine a predictive procedure,
  not simply the y supplied at inference time. Paired (y,z) examples are one
  possible supervised experience regime, recalled from the earlier framework.
  Such data could determine the model parameters; we have not fitted them here.
  Do not claim empirical improvement or a completed learning algorithm.
  Conditioning an already specified model is the inference component that
  can be used inside a learned system. This distinguishes the task we solved
  from the additional requirement in Mitchell's definition of learning.
]
