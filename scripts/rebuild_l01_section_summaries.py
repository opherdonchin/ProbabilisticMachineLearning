from pathlib import Path
import re

path = Path("Lectures/L01_Probability_Statistics/slide_deck.typ")
text = path.read_text()


def replace_once(old: str, new: str, label: str):
    global text
    n = text.count(old)
    if n != 1:
        raise RuntimeError(f"{label}: expected exactly one match, found {n}")
    text = text.replace(old, new, 1)


def replace_summary(heading: str, replacement: str, final: bool = False):
    global text
    if final:
        pattern = re.escape(heading) + r".*?(?=\n\n\n== Lecture 1: four visual anchors)"
    else:
        pattern = re.escape(heading) + r".*?(?=\n\n\n#section-metadata\()"
    text2, n = re.subn(pattern, replacement.rstrip(), text, count=1, flags=re.S)
    if n != 1:
        raise RuntimeError(f"summary {heading}: expected one match, found {n}")
    text = text2


# ---------------------------------------------------------------------------
# Reusable section-summary grammar: one large memory panel + a take-home strip.
# This is intentionally different from the 2x2 end-of-lecture visual gallery.
# ---------------------------------------------------------------------------
marker = "\n\n\n= A familiar modeling language"
helper = r'''

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
    column-gutter: 0.55em,
    align: (left + top, left + top),
    text(size: 0.58em, weight: "semibold", fill: palette.accent)[TAKE HOME],
    text(size: 0.69em)[#body],
  )
]
'''
if "#let section-summary-visual" not in text:
    if marker not in text:
        raise RuntimeError("Could not find first section marker for helper insertion")
    text = text.replace(marker, helper + marker, 1)


# ---------------------------------------------------------------------------
# Upstream key-point sharpening. Summary statements must already have been
# taught as key points; the summaries themselves should not introduce claims.
# ---------------------------------------------------------------------------
replace_once(
'''      uncover("2-")[
        - *Prior:* $p(theta)$
        - *Likelihood:* $p(y | theta)$
        - *Posterior:* $p(theta | y)$
      ],
      uncover("3-")[
        - We explored the posterior of $theta$
          - Treating $p(y)$ as a normalizing constant
      ],''',
'''      uncover("2-")[
        - Bayes' rule combines prior and likelihood into a posterior
          - *Prior:* $p(theta)$; *Likelihood:* $p(y | theta)$; *Posterior:* $p(theta | y)$
      ],
      uncover("3-")[
        - We explored the posterior of $theta$, treating $p(y)$ as a normalizing constant
      ],''',
"Bayes key point",
)

replace_once(
'''      uncover("2-")[
        - Their width expresses the uncertainty
        - The uncertainty in the posterior is less than in the prior
      ],''',
'''      uncover("2-")[
        - Posterior width represents remaining uncertainty
        - The uncertainty in the posterior is less than in the prior
      ],''',
"posterior-width key point",
)

replace_once(
'''    #stack(
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
    )''',
'''    #stack(
      spacing: 0.35em,
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
    )''',
"task-experience-performance key point",
)

# The task-taxonomy key-point region is a staged glossary. Put the general rule
# immediately above it so the section summary can legitimately repeat it.
replace_once(
'''  key-points: [
    #let task-focus(title, basic, performance, example) = stack(''',
'''  key-points: [
    #text(size: 0.72em)[Task describes what the learned system must do.]
    #v(0.18em)
    #let task-focus(title, basic, performance, example) = stack(''',
"task taxonomy general key point",
)

replace_once(
'''  key-points: [ #text(size:0.75em)[
    - Machine learning is built around a small number of canonical datasets
      - These four datasets are commonly used
    - Each dataset supports multiple tasks
    - Datasets support benchmarks that make comparisons easy
  ] ],''',
'''  key-points: [ #text(size:0.75em)[
    - Machine learning uses common datasets for practice and example problems
    - The same dataset can support different learning tasks
    - Datasets support benchmarks that make comparisons easy
  ] ],''',
"dataset overview key points",
)

replace_once(
'''  key-points: [
    - Every task invokes probability models: $p_D (y|x)$, $p_D (x|c)$, $p_D (z|x)$
    - Performances are expectations over future cases: $f_P = E[dot]$
    - Probability models provide a common language for all four task schemas
  ],''',
'''  key-points: [
    - A learning problem is specified by the variables available and the query we want answered
    - Performances are expectations over future cases: $f_P = E[dot]$
    - Probabilistic notation gives a common language for expressing those queries
  ],''',
"probabilistic-query key points",
)

replace_once(
'''  key-points: [
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
  ],''',
'''  key-points: [
    #stack(
      spacing: 0.35em,
      [
        - A small set of recurring operations—summarize, marginalize, condition—answers many of these questions
      ],
      uncover("2-")[
        - Integrals are a central tool for answering these queries
      ],
      uncover("3-")[
        - Latent variables are inferred or averaged out
      ],
    )
  ],''',
"probability-operations key points",
)

replace_once(
'''    #stack(
      spacing: 0.35em,
      [- Start at the prior mean $mu_1$],
      uncover("2-")[- Respond to the innovation $x_2-mu_2$],
      uncover("4-")[- Cross-covariance and observed variance determine the response],
    )''',
'''    #stack(
      spacing: 0.35em,
      [- Conditioning shifts the mean according to the observed deviation $x_2-mu_2$, cross-covariance, and observed variance],
    )''',
"Gaussian conditional-mean key point",
)


# ---------------------------------------------------------------------------
# Section summaries.
# ---------------------------------------------------------------------------
replace_summary(
"== Summary: A familiar modeling language\n",
r'''== Summary: A familiar modeling language

#content-block(
  layout: "top",
  object-width: 98%,
  object: [
    #section-summary-visual[
      #course-figure(
        lecture-figure-path("figures/coin_model__prior_likelihood_posterior.svg"),
        width: 92%,
        height: 4.75cm,
        show-source: false,
      )
    ]
    #v(0.35em)
    #section-summary-takeaways[
      #stack(
        spacing: 0.22em,
        [- A statistical model has data and unknown parameters],
        [- Bayes' rule combines prior and likelihood into a posterior],
        [- Posterior width represents remaining uncertainty],
      )
    ]
  ],
)''',
)

replace_summary(
"== Summary: From statistics to machine learning\n",
r'''== Summary: From statistics to machine learning

#content-block(
  layout: "top",
  object-width: 98%,
  object: [
    #section-summary-visual[
      #grid(
        columns: (1fr, 1fr, 1fr),
        gutter: 0.75em,
        align: center + horizon,
        course-card(title: [Training])[
          #text(size: 0.72em)[
            #stack(spacing: 0.35em, [$f_T: "E" arrow.r f_A$], [$E$: experience])
          ]
        ],
        course-card(title: [Task])[
          #text(size: 0.72em)[
            #stack(spacing: 0.35em, [$f_A: "In" arrow.r "Out"$], [$f_A$: learned function])
          ]
        ],
        course-card(title: [Evaluation])[
          #text(size: 0.72em)[
            #stack(spacing: 0.35em, [$f_P: ("In","Out") arrow.r P$], [$P$: performance])
          ]
        ],
      )
    ]
    #v(0.35em)
    #section-summary-takeaways[
      #stack(
        spacing: 0.22em,
        [- Machine learning asks how data can produce the required function $f$],
        [- A learning problem is defined by three ingredients: task, experience, and performance],
      )
    ]
  ],
)''',
)

replace_summary(
"== Summary: Two taxonomies, three ingredients\n",
r'''== Summary: Two taxonomies, three ingredients

#content-block(
  layout: "top",
  object-width: 98%,
  object: [
    #section-summary-visual[
      #grid(
        columns: (1fr, 1fr),
        gutter: 0.7em,
        align: top,
        course-card(title: [Experience: what the learner observes])[
          #text(size: 0.56em)[
            #grid(
              columns: (1fr, 1fr),
              gutter: 0.35em,
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
              columns: (1fr, 1fr),
              gutter: 0.35em,
              schema-node([Prediction], [$x_* arrow.r hat(y)_*$], density: "prose"),
              schema-node([Generation], [$x_* tilde p_D(x|c)$], density: "prose", fill: palette.paper),
              schema-node([Discovery], [$x_* arrow.r hat(z)_*$], density: "prose", fill: palette.paper),
              schema-node([Action], [$x_t arrow.r a_t$], density: "prose"),
            )
          ]
        ],
      )
    ]
    #v(0.35em)
    #section-summary-takeaways[
      #stack(
        spacing: 0.22em,
        [- Experience describes what the learner gets to observe],
        [- Task describes what the learned system must do],
        [- Not every type of experience supports every task; common pairings do exist],
      )
    ]
  ],
)''',
)

replace_summary(
"== Summary: From datasets to learning problems\n",
r'''== Summary: From datasets to learning problems

#content-block(
  layout: "top",
  object-width: 98%,
  object: [
    #section-summary-visual[
      #grid(
        columns: (0.95fr, 1.05fr),
        gutter: 0.8em,
        align: center + horizon,
        course-card(title: [Common practice datasets])[
          #grid(
            columns: (1fr, 1fr),
            gutter: 0.25em,
            [#stack(spacing: 0.08em, image("figures/book1_fig1_1a_setosa.png", width: 100%, height: 1.25cm, fit: "contain"), text(size: 0.42em)[Iris])],
            [#stack(spacing: 0.08em, image("figures/book1_fig1_12a_mnist.png", width: 100%, height: 1.25cm, fit: "contain"), text(size: 0.42em)[MNIST])],
            [#stack(spacing: 0.08em, image("figures/book1_fig1_13b_cifar10.png", width: 100%, height: 1.25cm, fit: "contain"), text(size: 0.42em)[CIFAR-10])],
            [#stack(spacing: 0.08em, image("figures/book1_table1_3_imdb.png", width: 100%, height: 1.25cm, fit: "contain"), text(size: 0.42em)[IMDB])],
          )
        ],
        course-card(title: [One dataset, different tasks])[
          #grid(
            columns: (0.56fr, 0.44fr),
            gutter: 0.35em,
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
    #v(0.35em)
    #section-summary-takeaways[
      #stack(
        spacing: 0.18em,
        [- Machine learning uses common datasets for practice and example problems],
        [- The same dataset can support different learning tasks],
        [- A learning problem is specified by the variables available and the query we want answered],
        [- Probabilistic notation gives a common language for expressing those queries],
      )
    ]
  ],
)''',
)

replace_summary(
"== Summary: Probability for machine learning\n",
r'''== Summary: Probability for machine learning

#content-block(
  layout: "top",
  object-width: 98%,
  object: [
    #section-summary-visual[
      #align(center)[Joint distribution: $p_D(x_"obs",z,y_*)$]
      #v(0.45em)
      #grid(
        columns: (1fr, 1fr, 1fr),
        gutter: 0.55em,
        align: center + horizon,
        schema-node([Summarize], summarize-formula, density: "prose"),
        schema-node([Marginalize], marginalize-formula, density: "prose", fill: palette.paper),
        schema-node([Condition], condition-formula, density: "prose"),
      )
    ]
    #v(0.35em)
    #section-summary-takeaways[
      #stack(
        spacing: 0.22em,
        [- The task determines which quantity we need from the joint distribution],
        [- A small set of recurring operations—summarize, marginalize, condition—answers many of those questions],
        [- Integrals are a central tool for answering these queries],
      )
    ]
  ],
)''',
)

replace_summary(
"== Summary: Joint Gaussian geometry\n",
r'''== Summary: Joint Gaussian geometry

#content-block(
  layout: "top",
  object-width: 98%,
  object: [
    #section-summary-visual[
      #grid(
        columns: (1.15fr, 0.85fr),
        gutter: 0.8em,
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
              spacing: 0.55em,
              [$bold(y)=A bold(x)+b$],
              [$E[bold(y)]=A mu+b$],
              [$"Cov"[bold(y)]=A Sigma A^T$],
            )
          ]
        ],
      )
    ]
    #v(0.35em)
    #section-summary-takeaways[
      #stack(
        spacing: 0.22em,
        [- Mean vector $mu$ locates the cloud; covariance $Sigma$ sets its shape],
        [- A linear map changes the scale, orientation, and dimension of variation],
      )
    ]
  ],
)''',
)

replace_summary(
"== Summary: Marginals and conditionals of a Gaussian\n",
r'''== Summary: Marginals and conditionals of a Gaussian

#content-block(
  layout: "top",
  object-width: 98%,
  object: [
    #section-summary-visual[
      #grid(
        columns: (0.8fr, 1.2fr),
        gutter: 0.8em,
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
    #v(0.35em)
    #section-summary-takeaways[
      #stack(
        spacing: 0.22em,
        [- Marginalizing $x_2$ integrates over all its possible values],
        [- Conditioning shifts the mean according to the observed deviation, cross-covariance, and observed variance],
        [- Conditioning cannot increase variance in any direction],
      )
    ]
  ],
)''',
)

replace_summary(
"== Summary: one model, three probability operations\n",
r'''== Summary: Linear Gaussian systems

#content-block(
  layout: "top",
  object-width: 98%,
  object: [
    #section-summary-visual[
      #grid(
        columns: (0.72fr, 1.28fr),
        gutter: 0.75em,
        align: center + horizon,
        course-card(title: [State and measurement])[
          #stack(
            spacing: 0.35em,
            linear_gaussian_graph(),
            text(size: 0.6em)[$z tilde cal(N)(mu_z,Sigma_z), quad y|z tilde cal(N)(Wz+b,Omega)$],
          )
        ],
        course-figure(
          lecture-figure-path("generated/sensor_fusion_schematic.svg"),
          width: 100%,
          height: 4.55cm,
          show-source: false,
        ),
      )
    ]
    #v(0.35em)
    #section-summary-takeaways[
      #stack(
        spacing: 0.22em,
        [- The model plus affine-Gaussian rules determine the full joint distribution],
        [- Posterior estimate = prior estimate + gain $times$ prediction error],
        [- More measurement noise gives smaller $K$; more prior uncertainty gives larger $K$],
      )
    ]
  ],
)''',
final=True,
)

path.write_text(text)
print("Rebuilt Lecture 1 section summaries and sharpened upstream key points")
