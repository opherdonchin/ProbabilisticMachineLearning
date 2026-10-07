// Lecture 1 — Probabilistic Machine Learning
#import "../course_01.typ": *
#import "figures/beta_bernoulli_graph_01.typ": beta_bernoulli_graph
#import "figures/input_output_function_schema.typ": input_output_function_schema
#import "figures/linear_gaussian_graph_01.typ": linear_gaussian_graph

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


// Section summaries deliberately reuse one or two visual anchors from the
// section, followed by a small set of key points that were already taught.
#let section-summary-visual(body) = block(
  width: 100%,
  height: 5.6cm,
  stroke: 0.7pt + palette.rule-line,
  fill: palette.paper,
  radius: 0.25em,
  inset: (x: 0.55em, y: 0.45em),
)[
  #align(center + horizon)[#body]
]

#let section-summary-takeaways(body) = block(
  width: 100%,
  fill: palette.accent.lighten(91%),
  radius: 0.25em,
  inset: (x: 0.65em, y: 0.42em),
)[
  #grid(
    columns: (6.5em, 1fr),
    column-gutter: sp("m"),
    align: (left + top, left + top),
    text(size: 0.58em, weight: "semibold", fill: palette.accent)[TAKE HOME],
    text(size: 0.69em)[#body],
  )
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
      spacing: sp("s"),
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



== Models are built out of distributions

#content-block(
  layout: "side-left",
  object-width: 60%,
  object: [
    #grid(
      columns: (28%, 1fr),
      column-gutter: sp("xl"),
      row-gutter: sp("xs"),
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
              spacing: sp("xs"),
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



== Models can be drawn as graphs

#stack(
  spacing: sp("l"),
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



== Bayes' rule combines prior and likelihood

#note[#text(size:0.9em)[#stack(spacing: sp("l"),
  [Model],
  [$ theta tilde "Beta"(alpha, beta) $],
  [$ y_i tilde "Bernoulli"(theta) $],
)]]

#content-block(
  layout: "top",
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
      spacing: sp("s"),
      uncover("2-")[
        - Bayes' rule combines prior and likelihood into a posterior
          - *Prior:* $p(theta)$; *Likelihood:* $p(y | theta)$; *Posterior:* $p(theta | y)$
      ],
      uncover("3-")[
        - We explored the posterior of $theta$, treating $p(y)$ as a normalizing constant
      ],
    )
  ],
)



== Conjugacy permits simple calculations

#note[#text(size:0.9em)[#stack(spacing: sp("l"),
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
      spacing: sp("s"),
      [
        - The prior and the posterior are both probability distributions
      ],
      uncover("2-")[
        - Posterior width represents remaining uncertainty
        - The uncertainty in the posterior is less than in the prior
      ],
    )
  ],
)



== Summary: A familiar modeling language

#content-block(
  layout: "top",
  object: [
    #section-summary-visual[
      #course-figure(
        lecture-figure-path("figures/coin_model__prior_likelihood_posterior.svg"),
        width: 92%,
        height: 4.75cm,
        show-source: false,
      )
    ]
    #v(sp("s"))
    #section-summary-takeaways[
      #stack(
        spacing: sp("xs"),
        [- A statistical model has data and unknown parameters],
        [- Bayes' rule combines prior and likelihood into a posterior],
        [- Posterior width represents remaining uncertainty],
      )
    ]
  ],
)


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
      spacing: sp("s"),
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



== Machine learning grew out of computer science

#content-block(
  layout: "top",
  object: [
    #input_output_function_schema()
  ],
  key-points: [
    #stack(
      spacing: sp("s"),
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



== Early machine learning grew out of classification problems

#content-block(
  layout: "top",
  object: [
    #grid(
      columns: cols("equal"),
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
      spacing: sp("s"),
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
        columns: cols("three"),
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




== Supervised experience supports prediction

#content-block(
  layout: "top",
  object: [
    #grid(
      columns: cols("equal"),
      gutter: 2.2em,
      align: center + horizon,
      [
        #align(center)[
          *Experience: paired examples*
          #v(sp("s"))
          #text(size: 0.7em)[$ f_T: "E" quad arrow.r quad f_A $]
          $ f_T: D = {(x_i, y_i)}_(i=1)^N quad arrow.r quad f_D $
          #v(0.28em)
          #text(size: 0.72em, fill: palette.muted)[paired examples $arrow.r$ learned predictor]
        ]
      ],
      uncover("2-")[
        #align(center)[
          *Task: prediction*
          #v(sp("s"))
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
      spacing: sp("s"),
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



== Classification: Iris flowers

#content-block(
  layout: "top",
  object-width: 92%,
  object: [
    #stack(
      spacing: sp("s"),
      grid(
        columns: (1.35fr, 1fr),
        gutter: 1.1em,
        align: center + horizon,
        [
          #grid(
            columns: cols("three"),
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
          #v(sp("xs"))
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
      spacing: sp("s"),
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



== Performance: empirical risk minimization

#content-block(
  layout: "top",
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
        #v(sp("m"))
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
      spacing: sp("s"),
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
      spacing: sp("s"),
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
      spacing: sp("s"),
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




== Task, experience, and performance

#content-block(
  layout: "top",
  object: [
    #grid(
      columns: cols("three"),
      gutter: 1.5em,
      align: center + horizon,
      [#align(center)[
        #text(size: 0.72em, weight: "semibold", fill: palette.accent)[Task]
        #v(sp("xs"))
        #text(size: 0.48em, fill: palette.muted)[What must the learned system do?]
        #v(0.34em)
        $ x in RR^4 arrow.r hat(y) in cal(Y) $
        #v(0.12em)
        #text(size: 0.48em, fill: palette.muted)[four measurements $arrow.r$ species]
      ]],
      [#uncover("2-")[
        #align(center)[
          #text(size: 0.72em, weight: "semibold", fill: palette.accent)[Experience]
          #v(sp("xs"))
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
          #v(sp("xs"))
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
      spacing: sp("s"),
      [
        - A learning problem is defined by three ingredients: task, experience, and performance
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



== Summary: From statistics to machine learning

#content-block(
  layout: "top",
  object: [
    #section-summary-visual[
      #grid(
        columns: cols("three"),
        gutter: sp("l"),
        align: center + horizon,
        course-card(title: [Training])[
          #text(size: 0.72em)[
            #stack(spacing: sp("s"), [$f_T: "E" arrow.r f_A$], [$E$: experience])
          ]
        ],
        course-card(title: [Task])[
          #text(size: 0.72em)[
            #stack(spacing: sp("s"), [$f_A: "In" arrow.r "Out"$], [$f_A$: learned function])
          ]
        ],
        course-card(title: [Evaluation])[
          #text(size: 0.72em)[
            #stack(spacing: sp("s"), [$f_P: ("In","Out") arrow.r P$], [$P$: performance])
          ]
        ],
      )
    ]
    #v(sp("s"))
    #section-summary-takeaways[
      #stack(
        spacing: sp("xs"),
        [- Machine learning asks how data can produce the required function $f$],
        [- A learning problem is defined by three ingredients: task, experience, and performance],
      )
    ]
  ],
)


#section-metadata(
  short-title: [ML taxonomies],
  subtitle: [Experience regimes, task classes, and performance criteria],
)

= Classes of machine learning problems

// Lecture 1 continuation after the machine-learning task taxonomy.
// Slide bodies use equations, figures, and schematics to carry the teaching argument.

// `schema-node`, `schema-arrow`, and `source-note` are shared course
// components (see course.typ); they are imported via `*` above.

== Experience taxonomy

#content-block(
  layout: "top",
  object: [
    #text(size: 0.85em)[
      #grid(
        columns: cols("equal"),
        column-gutter: sp("l"),
        row-gutter: sp("l"),
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



== Task taxonomy

#content-block(
  layout: "top",
  object: [
    // Every node in this grid states a Task/Performance pair; route them all
    // through one wrapper so they stay visually consistent.
    #let taxonomy-node(label, ..body) = schema-node(label, stack(spacing: sp("l"), ..body), density: "prose")
    #grid(
      columns: cols("equal"),
      column-gutter: sp("l"),
      row-gutter: sp("l"),
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
    #text(size: 0.72em)[Task describes what the learned system must do.]
    #v(sp("xs"))
    #let task-focus(title, basic, performance, example) = stack(
      spacing: 0.5em,
      align(left, text(weight: "semibold", fill: palette.accent, title)),
      grid(
        columns: (7em, 1fr),
        column-gutter: 0.65em,
        row-gutter: sp("xs"),
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
              row-gutter: sp("xs"),
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



== There are many combinations of experience and task 

#content-block(
  layout: "top",
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



== Summary: Two taxonomies, three ingredients

#content-block(
  layout: "top",
  object: [
    #section-summary-visual[
      #grid(
        columns: cols("equal"),
        gutter: sp("l"),
        align: top,
        course-card(title: [Experience: what the learner observes])[
          #text(size: 0.56em)[
            #grid(
              columns: cols("equal"),
              gutter: sp("s"),
              schema-node([Supervised], [$D={(x_n,y_n)}$], density: "prose"),
              schema-node([Unsupervised], [$D={x_n}$], density: "prose", fill: palette.paper),
              schema-node([Self-supervised], [$x_n, f(x_n)$], density: "prose", fill: palette.paper),
              schema-node([Interaction], [$x_t arrow.r a_t arrow.r r_(t+1)$], density: "prose"),
            )
          ]
        ],
        course-card(title: [Task: what the system must do])[
          #text(size: 0.56em)[
            #grid(
              columns: cols("equal"),
              gutter: sp("s"),
              schema-node([Prediction], [$x_* arrow.r hat(y)_*$], density: "prose"),
              schema-node([Generation], [$x_* tilde p_D(x|c)$], density: "prose", fill: palette.paper),
              schema-node([Discovery], [$x_* arrow.r hat(z)_*$], density: "prose", fill: palette.paper),
              schema-node([Action], [$x_t arrow.r a_t$], density: "prose"),
            )
          ]
        ],
      )
    ]
    #v(sp("s"))
    #section-summary-takeaways[
      #stack(
        spacing: sp("xs"),
        [- Experience describes what the learner gets to observe],
        [- Task describes what the learned system must do],
        [- Not every type of experience supports every task; common pairings do exist],
      )
    ]
  ],
)


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
          column-gutter: sp("s"),
          row-gutter: 0.08em,
          text(size: 0.42em, weight: "semibold", fill: palette.accent)[AGE],
          text(size: 0.46em)[#age],
          text(size: 0.42em, weight: "semibold", fill: palette.accent)[TASKS],
          text(size: 0.46em)[#tasks],
        ),
      )
    ]

    #grid(
      columns: cols("equal"),
      gutter: 0.5em,
      align: top,
      dataset-card(
        [Iris],
        grid(
          columns: 3,
          gutter: sp("xs"),
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
    - Machine learning uses common datasets for practice and example problems
    - The same dataset can support different learning tasks
    - Datasets support benchmarks that make comparisons easy
  ] ],
)



== MNIST: the same taxonomy, one dataset

#content-block(
  layout: "top",
  object: [
    #grid(
      columns: cols("right"),
      gutter: 1.0em,
      align: center + horizon,
      [
        #image("figures/book1_fig1_12a_mnist.png", width: 100%, height: 4.6cm, fit: "contain")
        #v(0.3em)
        #align(center)[#text(size: 0.85em)[$x_n in {0, dots, 255}^(28 times 28), quad y_n in {0, dots, 9}$]]
      ],
      [
        #stack(
          spacing: sp("m"),
          schema-node([Prediction], [$hat(y) = f_D (x_*)$]),
          uncover("2-")[#schema-node([Discovery], [$hat(z) = f_D (x_*)$], fill: palette.paper)],
          uncover("3-")[#schema-node([Generation], [$x_* tilde p_D (x | c)$], fill: palette.paper)],
        )
      ],
    )
    #source-note[Murphy (2025), Book 1, Fig. 1.12a]
  ],
)



== CIFAR-10: higher-dimensional inputs, the same questions

#content-block(
  layout: "top",
  object: [
    #grid(
      columns: cols("right"),
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



== IMDB reviews: text as sequence data

#content-block(
  layout: "top",
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
          spacing: sp("m"),
          schema-node([Prediction], [$hat(y) = f_D (x_*)$]),
          uncover("2-")[#schema-node([Discovery], [$hat(z) = f_D (x_*)$], fill: palette.paper)],
          uncover("3-")[#schema-node([Generation], [$w_t tilde p_D (w_t | w_(<t))$], fill: palette.paper)],
        )
      ],
    )
    #source-note[Murphy (2025), Book 1, Table 1.3]
  ],
)



== Learning problems become probabilistic queries

#content-block(
  layout: "top",
  object: [
    // Same grid as the task taxonomy slide, shown all at once: this is a
    // recap under a new reading, not a first teaching pass.
    #let taxonomy-node(label, ..body) = schema-node(label, stack(spacing: sp("l"), ..body), density: "prose")
    #grid(
      columns: cols("equal"),
      column-gutter: sp("l"),
      row-gutter: sp("l"),
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
    - A learning problem is specified by the variables available and the query we want answered
    - Performances are expectations over future cases: $f_P = E[dot]$
    - Probabilistic notation gives a common language for expressing those queries
  ],
)



== Summary: From datasets to learning problems

#content-block(
  layout: "top",
  object: [
    #section-summary-visual[
      #grid(
        columns: (0.95fr, 1.05fr),
        gutter: sp("l"),
        align: center + horizon,
        course-card(title: [Common practice datasets])[
          #grid(
            columns: cols("equal"),
            gutter: sp("xs"),
            [#stack(spacing: 0.08em, image("figures/book1_fig1_1a_setosa.png", width: 100%, height: 1.25cm, fit: "contain"), text(size: 0.42em)[Iris])],
            [#stack(spacing: 0.08em, image("figures/book1_fig1_12a_mnist.png", width: 100%, height: 1.25cm, fit: "contain"), text(size: 0.42em)[MNIST])],
            [#stack(spacing: 0.08em, image("figures/book1_fig1_13b_cifar10.png", width: 100%, height: 1.25cm, fit: "contain"), text(size: 0.42em)[CIFAR-10])],
            [#stack(spacing: 0.08em, image("figures/book1_table1_3_imdb.png", width: 100%, height: 1.25cm, fit: "contain"), text(size: 0.42em)[IMDB])],
          )
        ],
        course-card(title: [One dataset, different tasks])[
          #grid(
            columns: (0.56fr, 0.44fr),
            gutter: sp("s"),
            align: center + horizon,
            image("figures/book1_fig1_12a_mnist.png", width: 100%, height: 2.65cm, fit: "contain"),
            text(size: 0.55em)[
              #stack(
                spacing: 0.32em,
                schema-node([Prediction], [$hat(y)=f_D(x_*)$], density: "prose"),
                schema-node([Discovery], [$hat(z)=f_D(x_*)$], density: "prose", fill: palette.paper),
                schema-node([Generation], [$x_* tilde p_D(x|c)$], density: "prose", fill: palette.paper),
              )
            ],
          )
        ],
      )
    ]
    #v(sp("s"))
    #section-summary-takeaways[
      #stack(
        spacing: sp("xs"),
        [- Machine learning uses common datasets for practice and example problems],
        [- The same dataset can support different learning tasks],
        [- A learning problem is specified by the variables available and the query we want answered],
        [- Probabilistic notation gives a common language for expressing those queries],
      )
    ]
  ],
)


== Summary: Probability for machine learning

#content-block(
  layout: "top",
  object: [
    #section-summary-visual[
      #align(center)[Joint distribution: $p_D(x_"obs",z,y_*)$]
      #v(0.45em)
      #grid(
        columns: cols("three"),
        gutter: sp("m"),
        align: center + horizon,
        schema-node(
          [Summarize],
          [$E[g(X)] = integral g(x) p(x) dif x$],
          density: "prose",
        ),
        schema-node(
          [Marginalize],
          [$p(x) = integral p(x,y) dif y$],
          density: "prose",
          fill: palette.paper,
        ),
        schema-node(
          [Condition],
          [$p(x|y) = frac(p(x,y),p(y))$],
          density: "prose",
        ),
      )
    ]
    #v(sp("s"))
    #section-summary-takeaways[
      #stack(
        spacing: sp("xs"),
        [- The task determines which quantity we need from the joint distribution],
        [- A small set of recurring operations—summarize, marginalize, condition—answers many of those questions],
        [- Integrals are a central tool for answering these queries],
      )
    ]
  ],
)



#section-metadata(
  short-title: [Gaussian geometry],
  subtitle: [Describe and transform joint uncertainty with a mean and covariance],
)

= Joint Gaussian distributions and geometry

== Gaussians: a concrete example

#content-block(
  layout: "top",
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
      spacing: sp("l"),
      [- One variable: mean $mu$ and variance $sigma^2$],
      uncover("2-")[- Mean vector $mu in RR^D$ locates the cloud; covariance $Sigma in RR^(D times D)$ sets its shape],
      uncover("3-")[- Gaussian means, marginals, and conditionals have closed forms],
    )
  ],
)



== The three operations in multivariate Gaussian systems

#content-block(
  layout: "top",
  object: [
    #align(center)[One joint Gaussian: $p(bold(x)) = cal(N)(bold(x) | mu, Sigma)$]
    #grid(
      columns: cols("three"),
      gutter: sp("l"),
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
      spacing: sp("s"),
      [- *Summarize:* describe the center and spread with $mu$ and $Sigma$],
      uncover("2-")[- *Marginalize:* integrate over the coordinate we ignore],
      uncover("3-")[- *Condition:* fix an observed coordinate and normalize the slice],
    )
  ],
)



== Covariance summarizes joint variation

#content-block(
  layout: "top",
  object: [
    #align(center)[For a vector $bold(x)$ with mean $mu = E[bold(x)]$]
    #v(sp("l"))
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
      spacing: sp("s"),
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
      spacing: sp("s"),
      [
        - $rho_(i j)$ describes the direction and strength of linear association
      ],
      uncover("2-")[
        - $sigma_1,sigma_2,sigma_3$ set the coordinate scales
      ],
    )
  ],
)



== Affine maps carry Gaussian means and covariances

#slide(repeat: 4, self => [
  #let uncover = utils.uncover.with(self: self)

  #content-block(
    layout: "top",
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
      spacing: sp("s"),
      [
        - Equal Mahalanobis distances trace equal-density contours
      ],
      uncover("2-")[
        - With spherical covariance, it becomes squared Euclidean distance in standard-deviation units
      ],
    )
  ],
)



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



== Summary: Joint Gaussian geometry

#content-block(
  layout: "top",
  object: [
    #section-summary-visual[
      #grid(
        columns: cols("left"),
        gutter: sp("l"),
        align: center + horizon,
        course-figure(
          lecture-figure-path("generated/gaussian_contours.svg"),
          width: 100%,
          height: 4.35cm,
          show-source: false,
        ),
        course-card(title: [Affine map])[
          #text(size: 0.75em)[
            #stack(
              spacing: sp("m"),
              [$bold(y)=A bold(x)+b$],
              [$E[bold(y)]=A mu+b$],
              [$"Cov"[bold(y)]=A Sigma A^T$],
            )
          ]
        ],
      )
    ]
    #v(sp("s"))
    #section-summary-takeaways[
      #stack(
        spacing: sp("xs"),
        [- Mean vector $mu$ locates the cloud; covariance $Sigma$ sets its shape],
        [- A linear map changes the scale, orientation, and dimension of variation],
      )
    ]
  ],
)


#section-metadata(
  short-title: [Marginals and conditionals],
  subtitle: [Ignore coordinates or use observations to update uncertainty],
)

= Marginals and conditionals of a Gaussian

== Partition the variables and their parameters together

#content-block(
  layout: "top",
  object: [
    #align(center)[$bold(x)=mat(x_1; x_2), quad mu=mat(mu_1; mu_2)$]
    #v(sp("l"))
    #uncover("2-")[
      #align(center)[$Sigma=mat(Sigma_11,Sigma_12;Sigma_21,Sigma_22), quad Sigma_21=Sigma_12^T$]
    ]
    #source-note[Murphy, Book 2 §2.3.1.3, Eq. 2.75]
  ],
  key-points: [
    #stack(
      spacing: sp("s"),
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



== Marginalization keeps the matching blocks

#slide(repeat: 4, self => [
  #let uncover = utils.uncover.with(self: self)

  #content-block(
    layout: "top",
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
        spacing: sp("s"),
        [- Marginalizing $x_2$ integrates over all its possible values],
        uncover("4-")[
          - Cross-covariance affects conditioning, not the marginal of $x_1$
        ],
      )
    ],
  )
])



== Conditioning shifts the mean by an observed deviation

#slide(repeat: 4, self => [
  #let uncover = utils.uncover.with(self: self)

  #content-block(
    layout: "top",
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
        spacing: sp("s"),
        [- Conditioning shifts the mean according to the observed deviation $x_2-mu_2$, cross-covariance, and observed variance],
      )
    ],
  )
])



== Conditioning removes explained covariance

#slide(repeat: 4, self => [
  #let uncover = utils.uncover.with(self: self)

  #content-block(
    layout: "top",
    object: [
      #twocol[
        #align(center)[
          #stack(
            spacing: sp("xl"),
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
                    spacing: sp("l"),
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
        spacing: sp("s"),
        [- Conditioning cannot increase variance in any direction],
        uncover("4-")[
          - In a Gaussian, this covariance depends on which variables are observed, not their values
        ],
      )
    ],
  )
])



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
      spacing: sp("s"),
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



== One observed coordinate can change both the estimate and its uncertainty

#content-block(
  layout: "top",
  object-width: 91%,
  object: [
    #align(center)[$x_1|2 ~ cal(N)(mu_1 + rho frac(sigma_1,sigma_2)(x_2-mu_2), (1-rho^2) sigma_1^2) \ x_1 ~ cal(N)(0, 1), quad x_2 ~ cal(N)(0, 1), quad rho=0.8$]
    #uncover("2-")[
      #v(sp("l"))
      #align(center)[$x_2=1.5 \ x_1 | x_2=1.5 tilde cal(N)(0.8(1.5),1-0.8^2)=cal(N)(1.2,0.36)$]
    ]
    #source-note[Worked example of Murphy, Book 2 §2.3.1.3, Eq. 2.78]
  ],
  key-points: [
    #stack(
      spacing: sp("s"),
      uncover("2-")[
        - The observed value lies above its mean, so the conditional mean rises
        - The variance falls from $1$ to $0.36$
      ],
    )
  ],
)



== The Schur complement is the residual covariance

#content-block(
  layout: "top",
  object: [
    #twocol[
      #course-card(title: [Conditional Gaussian])[
        #text(size: 0.84em)[
          #stack(
            spacing: sp("l"),
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
            spacing: sp("l"),
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
      spacing: sp("s"),
      uncover("2-")[
        - $S$ measures the uncertainty left after subtracting the conditional mean
      ],
      uncover("3-")[
        - Block elimination leaves $S$: the *Schur complement of $Sigma_22$ in $Sigma$*
      ],
    )
  ],
)



== The joint quadratic separates into conditional and marginal parts

#content-block(
  layout: "top",
  object-width: 95%,
  object: [
    #align(center)[$p(x_1,x_2)=p(x_1 | x_2)p(x_2)$]
    #align(center)[$(bold(x)-mu)^T Sigma^(-1)(bold(x)-mu)$]
    #v(sp("m"))
    #uncover("2-")[
      #align(center)[$= r^T S^(-1)r+(x_2-mu_2)^T Sigma_22^(-1)(x_2-mu_2)$]
    ]
    #v(0.6em)
    #source-note[Murphy, Book 2 §2.3.1.5, Eqs. 2.94–2.103]
  ],
  key-points: [
    #stack(
      spacing: sp("s"),
      uncover("2-")[
        - The first quadratic describes $x_1$ after seeing $x_2$
        - The second describes the marginal distribution of $x_2$
      ],
    )
  ],
)



== Summary: Marginals and conditionals of a Gaussian

#content-block(
  layout: "top",
  object: [
    #section-summary-visual[
      #grid(
        columns: cols("right"),
        gutter: sp("l"),
        align: center + horizon,
        course-card(title: [Marginalize])[
          #text(size: 0.77em)[
            #stack(
              spacing: 0.65em,
              [$p(x_1)=integral p(x_1,x_2) dif x_2$],
              [$x_1 tilde cal(N)(mu_1,Sigma_11)$],
            )
          ]
        ],
        course-card(title: [Condition])[
          #text(size: 0.72em)[
            #stack(
              spacing: 0.62em,
              [$p(x_1|x_2)=cal(N)(x_1|mu_(1|2),Sigma_(1|2))$],
              [$mu_(1|2)=mu_1+Sigma_12 Sigma_22^(-1)(x_2-mu_2)$],
              [$Sigma_(1|2)=Sigma_11-Sigma_12 Sigma_22^(-1)Sigma_21$],
            )
          ]
        ],
      )
    ]
    #v(sp("s"))
    #section-summary-takeaways[
      #stack(
        spacing: sp("xs"),
        [- Marginalizing $x_2$ integrates over all its possible values],
        [- Conditioning shifts the mean according to the observed deviation, cross-covariance, and observed variance],
        [- Conditioning cannot increase variance in any direction],
      )
    ]
  ],
)


#section-metadata(
  short-title: [Linear Gaussian systems],
  subtitle: [Inference from noisy linear measurements],
)

= Linear Gaussian systems


== A linear Gaussian system is a model of state and measurement

#content-block(
  layout: "top",
  object: [
    #grid(
      columns: cols("right"), gutter: 1em, align: horizon,
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
      spacing: sp("s"),
      [- This model specifies how an unknown state generates a noisy measurement],
      uncover("2-")[- Here the parameters $mu_z, Sigma_z, W, b, Omega$ are given],
    )
  ],
)



== One linear Gaussian system supports different questions

#content-block(
  layout: "top",
  object: [
    #align(center)[
      $z tilde cal(N)(mu_z, Sigma_z), quad
       y | z tilde cal(N)(W z + b, Omega)$
    ]
    #v(sp("l"))

    #grid(
      columns: cols("three"),
      gutter: sp("l"),
      align: top,
      uncover("1-")[
        #course-card(title: [Condition])[
          #text(size: 0.85em)[
            $p(z | y) = frac(p(y | z) p(z), p(y))$
          ]
        ]
      ],

      uncover("2-")[
        #course-card(title: [Summarize])[
          #text(size: 0.85em)[
            $E[g(z) | y] = integral g(z) p(z | y) dif z$
          ]
        ]
      ],

      uncover("3-")[
        #course-card(title: [Marginalize])[
          #text(size: 0.85em)[
            $p(y) = integral p(y | z) p(z) dif z$
          ]
        ]
      ],
    )

    #source-note[Murphy, Book 2 §2.3.2]
  ],

  key-points: [
    #uncover("1-")[
      - Conditioning asks what we can learn from an observed measurement
        - What is the distribution of the hidden state after seeing a measurement?
    ]

    #uncover("2-")[
      - Summarizing turns a distribution into a quantity
        - What is our estimate of the hidden state?
    ]

    #uncover("3-")[
      - Marginalization averages over an unknown variable to predict another
        - What is the distribution of a measurement before it is observed?
    ]
  ],
)



== A linear Gaussian model defines a joint Gaussian

#content-block(
  layout: "top",
  object: [
    #grid(
      columns: cols("right"),
      gutter: 0.9em,
      align: top,
      course-card(title: [Linear Gaussian model])[
        #text(size: 0.8em)[
          #stack(
            spacing: 0.42em,
            [$z tilde cal(N)(mu_z,Sigma_z)$],
            [$y=W z+b+epsilon$],
            [$epsilon tilde cal(N)(0,Omega)$],
            [#text(size: 0.82em, fill: palette.muted)[$epsilon$ is independent of $z$]],
          )
        ]
      ],
      course-card(title: [Affine Gaussian rules])[
        #text(size: 0.8em)[
          #stack(
            spacing: 0.42em,
            [$u=A x+c$],
            [$E[u]=A E[x]+c$],
            [$"Cov"[u]=A "Cov"[x] A^T$],
          )
        ]
      ],
    )
    #uncover("2-")[
      #v(0.15em)
      #course-card(title: [Joint Gaussian])[
        #text(size: 0.76em)[
          #stack(
            spacing: 0.42em,
            [$mat(z;y) tilde cal(N)(mat(mu_z;mu_y), mat(Sigma_(z z),Sigma_(z y);Sigma_(y z),Sigma_(y y)))$],
            [$mu_y=W mu_z+b, quad Sigma_(z z)=Sigma_z$],
            [$Sigma_(z y)=Sigma_z W^T=Sigma_(y z)^T$],
            [$Sigma_(y y)=W Sigma_z W^T+Omega$],
          )
        ]
      ]
    ]
    #source-note[Murphy, Book 2 §2.3.2.1, Eq. 2.120]
  ],
  key-points: [
    #stack(
      spacing: sp("s"),
      [- The model plus affine-Gaussian rules determine the full joint distribution],
      uncover("2-")[- Once $p(z,y)$ is known, the Gaussian marginal and conditioning rules apply directly],
    )
  ],
)



== Bayes' rule for Gaussians

#content-block(
  layout: "top",
  object: [
    #twocol[
      #text(size: 0.86em)[
      #stack(
        spacing: sp("m"),
        course-card(title: [Model and joint Gaussian])[
        #text(size: 0.9em)[
          $ mat(z;y) tilde cal(N)(mat(mu_z;mu_y),mat(Sigma_(z z),Sigma_(z y);Sigma_(y z),Sigma_(y y))) $
          #stack(
            spacing: sp("m"),
            [$mu_y=W mu_z+b, quad Sigma_(z z)=Sigma_z$],
            [$Sigma_(z y)=Sigma_z W^T=Sigma_(y z)^T$],
            [$Sigma_(y y)=W Sigma_z W^T+Omega$],
          )
        ]
        ],
        course-card(title: [Gaussian conditioning rule])[
        #text(size: 0.9em)[
          #stack(
            spacing: sp("l"),
            [$mu_(1|2)=mu_1+Sigma_12 Sigma_22^(-1)(x_2-mu_2)$],
            [$Sigma_(1|2)=Sigma_11-Sigma_12 Sigma_22^(-1)Sigma_21$],
          )
        ]
        ],
      )
      ]
    ][
      #course-card(title: [Apply: $x_1=z$, $x_2=y$])[
        #v(1.5em)
        #text(size: 0.85em)[
          #stack(
            spacing: 1.5em,
            [$p(z | y)=cal(N)(z | mu_(z|y),Sigma_(z|y))$],
            uncover("2-")[$mu_(z|y)=mu_z+Sigma_(z y) Sigma_(y y)^(-1)(y-mu_y)$],
            uncover("3-")[$Sigma_(z|y)=Sigma_(z z)-Sigma_(z y) Sigma_(y y)^(-1)Sigma_(y z)$],
          )
        ]
      ]
    ]
    #source-note[Murphy, Book 2 §2.3.2.2, Eq. 2.121]
  ],
  key-points: [
    #stack(
      spacing: sp("s"),
      [- Apply the Gaussian conditioning rule to the joint blocks],
      uncover("2-")[- The mean responds to observed minus predicted measurement],
      uncover("3-")[- The covariance subtracts the uncertainty explained by the measurement],
    )
  ],
)



== Bayes' rule as an update formula

#content-block(
  layout: "top",
  object: [
    #twocol[
      #course-card(title: [From Gaussian conditioning])[
        #text(size: 0.82em)[
          #stack(
            spacing: sp("l"),
            [$mu_(z|y)=mu_z+Sigma_(z y) Sigma_(y y)^(-1)(y-mu_y)$],
            [$mu_y=W mu_z+b$],
            [$Sigma_(z y)=Sigma_z W^T$],
            [$Sigma_(y y)=W Sigma_z W^T+Omega$],
          )
        ]
      ]
    ][
      #course-card(title: [Define the gain])[
        #text(size: 0.9em)[
          #stack(
            spacing: 1.0em,
            uncover("2-")[$K=Sigma_(z y) Sigma_(y y)^(-1)$],
            uncover("3-")[$mu_(z|y)=mu_z+K(y-mu_y)$],
          )
        ]
      ]
    ]
    #source-note[Murphy, Book 2 §2.3.2.2, Eqs. 2.122–2.124]
  ],
  key-points: [
    #stack(
      spacing: sp("s"),
      uncover("2-")[- $K$ is the gain: it converts a measurement discrepancy into a state correction],
      uncover("3-")[- Posterior estimate = prior estimate + gain $times$ prediction error],
    )
  ],
)



== The scalar Gaussian update

#content-block(
  layout: "top",
  object: [
    #grid(
      columns: cols("right"),
      gutter: 0.9em,
      align: top,
      course-card(title: [Carry forward])[
        #text(size: 0.8em)[
          #stack(
            spacing: sp("l"),
            [$mu_(z|y)=mu_z+K(y-mu_y)$],
            [$K=Sigma_(z y) Sigma_(y y)^(-1)$],
          )
        ]
      ],
      course-card(title: [Scalar specialization])[
        #text(size: 0.78em)[
          #stack(
            spacing: 0.5em,
            [$y,z in RR, quad W=1, quad b=0$],
            [$Sigma_z=sigma_z^2, quad Omega=sigma_epsilon^2$],
            [$z tilde cal(N)(mu_z,sigma_z^2)$],
            [$y=z+epsilon, quad epsilon tilde cal(N)(0,sigma_epsilon^2)$],
            [#text(size: 0.82em, fill: palette.muted)[$epsilon$ is independent of $z$]],
          )
        ]
      ],
    )
    #uncover("2-")[
      #v(0.45em)
      #grid(
        columns: cols("three"),
        gutter: sp("m"),
        align: center + horizon,
        course-card(title: [Predicted mean])[
          #text(size: 0.72em)[$mu_y=E[z+epsilon]=mu_z$]
        ],
        course-card(title: [Cross-covariance])[
          #text(size: 0.72em)[$Sigma_(z y)="Cov"[z,z+epsilon]=sigma_z^2$]
        ],
        course-card(title: [Measurement variance])[
          #text(size: 0.72em)[$Sigma_(y y)="Var"[z+epsilon]=sigma_z^2+sigma_epsilon^2$]
        ],
      )
    ]
    #uncover("3-")[
      #v(0.45em)
      #align(center)[
        #text(size: 0.9em)[
          $K=frac(sigma_z^2,sigma_z^2+sigma_epsilon^2)
          quad arrow.r quad
          mu_(z|y)=mu_z+K(y-mu_z)$
        ]
      ]
    ]
    #source-note[Murphy, Book 2 §2.3.2.2; scalar specialization of Eqs. 2.121–2.123]
  ],
  key-points: [
    #uncover("3-")[- The scalar gain is prior state variance divided by total measurement variance]
  ],
)



== The update is weighted by relative uncertainty

#let estimate-track(left, right) = align(center)[
  $mu_z$ #h(0.12em)
  #text(fill: palette.muted)[●#left]
  #text(fill: palette.accent)[◆]
  #text(fill: palette.muted)[#right●]
  #h(0.12em) $y$
]

#content-block(
  layout: "top",
  object: [
    #align(center)[
      #stack(
        spacing: 0.4em,
        text(size: 0.9em)[$mu_(z|y)=mu_z+K(y-mu_z), quad K=frac(sigma_z^2,sigma_z^2+sigma_epsilon^2)$],
        text(size: 0.62em, fill: palette.muted)[◆ = posterior mean $mu_(z|y)$],
      )
    ]
    #v(sp("m"))
    #triad[
      #uncover("2-")[
        #course-card(title: [Precise measurement])[
          #text(size: 0.73em)[
            #stack(
              spacing: sp("s"),
              [$sigma_epsilon^2 << sigma_z^2 quad K approx 1$],
              estimate-track([─────], [─]),
              [#align(center)[Trust the measurement]],
            )
          ]
        ]
      ]
    ][
      #uncover("3-")[
        #course-card(title: [Equal uncertainty])[
          #text(size: 0.73em)[
            #stack(
              spacing: sp("s"),
              [$sigma_epsilon^2=sigma_z^2 quad K=frac(1,2)$],
              estimate-track([───], [───]),
              [#align(center)[Split the difference]],
            )
          ]
        ]
      ]
    ][
      #uncover("4-")[
        #course-card(title: [Noisy measurement])[
          #text(size: 0.73em)[
            #stack(
              spacing: sp("s"),
              [$sigma_epsilon^2 >> sigma_z^2 quad K approx 0$],
              estimate-track([─], [─────]),
              [#align(center)[Trust the prior]],
            )
          ]
        ]
      ]
    ]
    #source-note[Scalar interpretation of Murphy, Book 2 §2.3.2.2]
  ],
  key-points: [
    #stack(
      spacing: sp("s"),
      [- $K$ is the fraction of the prediction error used in the correction],
      uncover("4-")[- More measurement noise gives smaller $K$; more prior uncertainty gives larger $K$],
    )
  ],
)



== Inference often combines conditioning and summarizing

#content-block(
  layout: "top",
  object: [
    #course-card(title: [Condition, then summarize])[
      #grid(
        columns: (1fr, auto, 1.35fr, auto, 1.25fr),
        column-gutter: 0.45em,
        row-gutter: sp("s"),
        align: center + horizon,
        [#align(center)[#stack(spacing: sp("xs"), [*Observed*], [$y$])]],
        [$arrow.r$],
        [#align(center)[#stack(spacing: sp("xs"), [*Condition*], [$p(z | y)=cal(N)(z | mu_(z|y),Sigma_(z|y))$])]],
        uncover("2-")[$arrow.r$],
        uncover("2-")[#align(center)[#stack(spacing: sp("xs"), [*Summarize*], [$hat(z)=E[z | y]=mu_(z|y)$])]],
      )
    ]
    #uncover("2-")[
      #v(0.65em)
      #align(center)[#text(size: 0.85em)[$E[z | y]=integral z p(z | y) dif z$]]
    ]
    #source-note[Murphy, Book 2 §2.3.2.2–2.3.2.3]
  ],
  key-points: [
    #stack(
      spacing: sp("s"),
      [- Conditioning preserves the whole posterior distribution and its uncertainty],
      uncover("2-")[- Summarizing extracts a quantity from that posterior; for a Gaussian the mean is $mu_(z|y)$],
    )
  ],
)



== Sensor fusion combines measurements according to their uncertainty

#content-block(
  layout: "top",
  object: [
    #grid(
      columns: cols("left"),
      gutter: sp("l"),
      align: top,
      course-card(title: [Two noisy measurements of one state])[
        #text(size: 0.76em)[
          $z tilde cal(N)(mu_z,Sigma_z)$
          $x | z tilde cal(N)(z,Sigma_x), quad y | z tilde cal(N)(z,Sigma_y)$
        ]
      ],
      course-card(title: [Same two operations])[
        #text(size: 0.76em)[
          $p(z | x,y) quad arrow.r quad E[z | x,y]$
        ]
      ],
    )
    #uncover("2-")[
      #v(sp("s"))
      #course-figure(
        lecture-figure-path("generated/sensor_fusion_schematic.svg"),
        width: 100%,
        height: 5.2cm,
        show-source: false,
      )
    ]
    #source-note[Course schematic after Murphy, Book 2 §2.3.2.3, Fig. 2.10; `sensor_fusion_figure.ipynb`]
  ],
  key-points: [
    #stack(
      spacing: 0.3em,
      uncover("2-")[- Equal uncertainty puts the posterior mean between the measurements],
      uncover("3-")[- A more precise sensor pulls the posterior mean closer to its measurement],
      uncover("4-")[- With anisotropic uncertainty, the weighting can differ by direction],
    )
  ],
)



== The same model can also predict measurements

#content-block(
  layout: "top",
  object: [
    #twocol[
      #course-card(title: [Model and joint])[
        #text(size: 0.78em)[
          #stack(
            spacing: sp("m"),
            [$z tilde cal(N)(mu_z,Sigma_z)$],
            [$y | z tilde cal(N)(W z+b,Omega)$],
            [$p(z,y)=p(z)p(y | z)$],
          )
        ]
      ]
    ][
      #course-card(title: [Marginalization rule])[
        #text(size: 0.78em)[
          #stack(
            spacing: sp("l"),
            [$p(y)=integral p(z,y) dif z$],
            [$= integral p(y | z)p(z) dif z$],
          )
        ]
      ]
    ]
    #uncover("2-")[
      #v(sp("m"))
      #align(center)[
        #text(size: 0.9em)[
          $p(y)=cal(N)(y | mu_y,Sigma_(y y))$
          $mu_y=W mu_z+b, quad Sigma_(y y)=W Sigma_z W^T+Omega$
        ]
      ]
    ]
    #source-note[Murphy, Book 2 §2.3.2.2, Eq. 2.129]
  ],
  key-points: [
    #stack(
      spacing: sp("s"),
      [- Before observing $y$, marginalization gives the distribution of possible measurements],
      uncover("2-")[- These are the same $mu_y$ and $Sigma_(y y)$ that appear inside the conditioning update],
    )
  ],
)



== Summary: Linear Gaussian systems

#content-block(
  layout: "top",
  object: [
    #section-summary-visual[
      #grid(
        columns: (0.72fr, 1.28fr),
        gutter: sp("l"),
        align: center + horizon,
        course-card(title: [Linear Gaussian model])[
          #text(size: 0.75em)[
            #stack(
              spacing: 0.65em,
              [$z tilde cal(N)(mu_z,Sigma_z)$],
              [$y | z tilde cal(N)(W z+b,Omega)$],
              [$p(z,y)=p(z)p(y|z)$],
            )
          ]
        ],
        course-figure(
          lecture-figure-path("generated/sensor_fusion_schematic.svg"),
          width: 100%,
          height: 4.55cm,
          show-source: false,
        ),
      )
    ]
    #v(sp("s"))
    #section-summary-takeaways[
      #stack(
        spacing: sp("xs"),
        [- The model plus affine-Gaussian rules determine the full joint distribution],
        [- Posterior estimate = prior estimate + gain $times$ prediction error],
        [- More measurement noise gives smaller $K$; more prior uncertainty gives larger $K$],
      )
    ]
  ],
)


== Lecture 1: four visual anchors

#content-block(
  layout: "top",
  object: [
    #grid(
      columns: cols("equal"),
      gutter: sp("m"),
      align: top,
      course-card(title: [One dataset, several questions])[
        #block(height: 3.25cm)[
          #stack(
            spacing: sp("xs"),
            text(size: 0.62em, weight: "semibold")[A dataset is not a task.],
            grid(
              columns: (0.55fr, 0.45fr),
              gutter: sp("s"),
              align: center + horizon,
              image("figures/book1_fig1_12a_mnist.png", width: 100%, height: 2.05cm, fit: "contain"),
              text(size: 0.53em)[
                #stack(
                  spacing: sp("xs"),
                  [$x arrow.r hat(y)$  Prediction],
                  [$x arrow.r hat(z)$  Discovery],
                  [$x_* tilde p(x | c)$  Generation],
                )
              ],
            ),
          )
        ]
      ],
      course-card(title: [Three probability operations])[
        #block(height: 3.25cm)[
          #stack(
            spacing: 0.30em,
            text(size: 0.62em, weight: "semibold")[The task determines the operation.],
            text(size: 0.56em)[
              #grid(
                columns: (5.7em, 1fr),
                column-gutter: sp("s"),
                row-gutter: 0.28em,
                align: (right + horizon, left + horizon),
                [*Summarize*], [$E[g(X)] = integral g(x) p(x) dif x$],
                [*Marginalize*], [$p(x) = integral p(x,y) dif y$],
                [*Condition*], [$p(x | y) = frac(p(x,y),p(y))$],
              )
            ],
          )
        ]
      ],
      course-card(title: [Gaussian conditioning])[
        #block(height: 3.25cm)[
          #stack(
            spacing: sp("s"),
            text(size: 0.62em, weight: "semibold")[Observation changes estimate and uncertainty.],
            text(size: 0.58em)[
              $mu_(1|2)=mu_1+Sigma_12 Sigma_22^(-1)(x_2-mu_2)$
            ],
            text(size: 0.58em)[
              $Sigma_(1|2)=Sigma_11-Sigma_12 Sigma_22^(-1)Sigma_21$
            ],
          )
        ]
      ],
      course-card(title: [Sensor fusion])[
        #block(height: 3.25cm)[
          #stack(
            spacing: sp("xs"),
            text(size: 0.62em, weight: "semibold")[Uncertainty controls how evidence is combined.],
            image("generated/sensor_fusion_schematic.svg", width: 100%, height: 2.15cm, fit: "contain"),
          )
        ]
      ],
    )
    #source-note[Visual anchors from Lecture 1: MNIST tasks, three probability operations, Gaussian conditioning, and sensor fusion]
  ],
)
