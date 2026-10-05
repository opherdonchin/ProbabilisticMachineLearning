from pathlib import Path

path = Path("Lectures/L01_Probability_Statistics/slide_deck.typ")
text = path.read_text()

marker = "== Lecture 1: four visual anchors"
if marker in text:
    raise SystemExit("Visual anchor summary slide already present")

slide = r'''


== Lecture 1: four visual anchors

#content-block(
  layout: "top",
  object-width: 98%,
  object: [
    #grid(
      columns: (1fr, 1fr),
      gutter: 0.55em,
      align: top,
      course-card(title: [One dataset, several questions])[
        #block(height: 3.25cm)[
          #stack(
            spacing: 0.24em,
            text(size: 0.62em, weight: "semibold")[A dataset is not a task.],
            grid(
              columns: (0.55fr, 0.45fr),
              gutter: 0.35em,
              align: center + horizon,
              image("figures/book1_fig1_12a_mnist.png", width: 100%, height: 2.05cm, fit: "contain"),
              text(size: 0.53em)[
                #stack(
                  spacing: 0.22em,
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
                column-gutter: 0.35em,
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
            spacing: 0.35em,
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
            spacing: 0.24em,
            text(size: 0.62em, weight: "semibold")[Uncertainty controls how evidence is combined.],
            image("generated/sensor_fusion_schematic.svg", width: 100%, height: 2.15cm, fit: "contain"),
          )
        ]
      ],
    )
    #source-note[Visual anchors from Lecture 1: MNIST tasks, three probability operations, Gaussian conditioning, and sensor fusion]
  ],
)

#speaker-note[
  Use this as a visual memory slide, not a list of everything covered. The four
  anchors are deliberately selective. First, the same dataset can support
  different learning questions. Second, those questions translate into a small
  set of probability operations. Third, for Gaussians, conditioning has a closed
  form that updates both mean and covariance. Fourth, the linear Gaussian sensor
  fusion example shows the practical interpretation: measurements are combined
  according to their uncertainty.
]
'''

path.write_text(text.rstrip() + slide + "\n")
print("Added Lecture 1 visual anchor summary slide")
