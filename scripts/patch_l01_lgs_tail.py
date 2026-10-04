from pathlib import Path

DECK = Path("Lectures/L01_Probability_Statistics/slide_deck.typ")
text = DECK.read_text(encoding="utf-8")

anchor = "== One linear Gaussian system supports different questions"
start = text.index("== Inference often combines the operations", text.index(anchor))

prefix = text[:start].rstrip()

# Add a teaching note to the orientation slide immediately before the rebuilt tail.
if not prefix.endswith("]") or "The next slides solve these questions" not in prefix[-1200:]:
    prefix += r'''

#speaker-note[
  Use this slide as an orientation map, not as three separate derivations. The
  model stays fixed; the probability query changes with the question. The next
  slides solve these questions by first constructing the joint Gaussian and
  then reusing the marginalization and conditioning rules already established.
]
'''

new_tail = r'''

== A linear Gaussian model defines a joint Gaussian

#content-block(
  layout: "top",
  object-width: 96%,
  object: [
    #grid(
      columns: (0.85fr, 1.15fr),
      gutter: 0.9em,
      align: top,
      course-card(title: [Linear Gaussian model])[
        #text(size: 0.8em)[
          #stack(
            spacing: 0.55em,
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
            spacing: 0.55em,
            [$u=A x+c$],
            [$E[u]=A E[x]+c$],
            [$"Cov"[u]=A "Cov"[x] A^T$],
          )
        ]
      ],
    )
    #uncover("2-")[
      #v(0.45em)
      #course-card(title: [Joint Gaussian])[
        #text(size: 0.76em)[
          #stack(
            spacing: 0.55em,
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
      spacing: 0.35em,
      [- The model plus affine-Gaussian rules determine the full joint distribution],
      uncover("2-")[- Once $p(z,y)$ is known, the Gaussian marginal and conditioning rules apply directly],
    )
  ],
)

#speaker-note[
  This is the payoff from the earlier affine-map material. Stack the state and
  measurement into one vector. Since both are affine functions of jointly
  Gaussian quantities, their joint law is Gaussian. Emphasize the three blocks
  we will reuse: the predicted measurement mean mu_y, the cross-covariance
  Sigma_zy, and the measurement covariance Sigma_yy.
]


== Bayes' rule for Gaussians

#content-block(
  layout: "top",
  object-width: 98%,
  object: [
    #twocol[
      #text(size: 0.86em)[
      #stack(
        spacing: 0.55em,
        course-card(title: [Model and joint Gaussian])[
        #text(size: 0.9em)[
          $ mat(z;y) tilde cal(N)(mat(mu_z;mu_y),mat(Sigma_(z z),Sigma_(z y);Sigma_(y z),Sigma_(y y))) $
          #stack(
            spacing: 0.55em,
            [$mu_y=W mu_z+b, quad Sigma_(z z)=Sigma_z$],
            [$Sigma_(z y)=Sigma_z W^T=Sigma_(y z)^T$],
            [$Sigma_(y y)=W Sigma_z W^T+Omega$],
          )
        ]
        ],
        course-card(title: [Gaussian conditioning rule])[
        #text(size: 0.9em)[
          #stack(
            spacing: 0.8em,
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
      spacing: 0.35em,
      [- Apply the Gaussian conditioning rule to the joint blocks],
      uncover("2-")[- The mean responds to observed minus predicted measurement],
      uncover("3-")[- The covariance subtracts the uncertainty explained by the measurement],
    )
  ],
)

#speaker-note[
  Do not derive Bayes' rule from products of Gaussian densities here. We already
  proved the general Gaussian conditioning rule. Identify x_1 with z and x_2
  with y, then substitute the joint blocks from the previous slide. This is the
  short proof Murphy uses in Book 2.
]


== Bayes' rule as an update formula

#content-block(
  layout: "top",
  object-width: 96%,
  object: [
    #twocol[
      #course-card(title: [From Gaussian conditioning])[
        #text(size: 0.82em)[
          #stack(
            spacing: 0.7em,
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
      spacing: 0.35em,
      uncover("2-")[- $K$ is the gain: it converts a measurement discrepancy into a state correction],
      uncover("3-")[- Posterior estimate = prior estimate + gain $times$ prediction error],
    )
  ],
)

#speaker-note[
  Read the posterior mean as an update rather than as a matrix formula. The
  prediction error is y-mu_y: what was observed minus what the model expected
  to observe. K determines how much that discrepancy changes the state estimate.
  The next two slides make the role of K transparent in one dimension.
]


== The scalar Gaussian update

#content-block(
  layout: "top",
  object-width: 96%,
  object: [
    #grid(
      columns: (0.82fr, 1.18fr),
      gutter: 0.9em,
      align: top,
      course-card(title: [Carry forward])[
        #text(size: 0.8em)[
          #stack(
            spacing: 0.7em,
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
        columns: (1fr, 1fr, 1fr),
        gutter: 0.55em,
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

#speaker-note[
  Define the scalar symbols explicitly rather than introducing new notation by
  fiat: sigma_z^2 is the scalar version of Sigma_z, while sigma_epsilon^2 is
  the scalar version of the measurement-noise covariance Omega. Since
  y=z+epsilon and z is independent of epsilon, Cov(z,y)=Var(z), while Var(y)
  adds the two variances. Substituting these moments into the generic gain gives
  the uncertainty ratio used on the next slide.
]


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
  object-width: 98%,
  object: [
    #align(center)[
      #stack(
        spacing: 0.4em,
        text(size: 0.9em)[$mu_(z|y)=mu_z+K(y-mu_z), quad K=frac(sigma_z^2,sigma_z^2+sigma_epsilon^2)$],
        text(size: 0.62em, fill: palette.muted)[◆ = posterior mean $mu_(z|y)$],
      )
    ]
    #v(0.55em)
    #triad[
      #uncover("2-")[
        #course-card(title: [Precise measurement])[
          #text(size: 0.73em)[
            #stack(
              spacing: 0.35em,
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
              spacing: 0.35em,
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
              spacing: 0.35em,
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
      spacing: 0.35em,
      [- $K$ is the fraction of the prediction error used in the correction],
      uncover("4-")[- More measurement noise gives smaller $K$; more prior uncertainty gives larger $K$],
    )
  ],
)

#speaker-note[
  Keep this slide visual. Hold mu_z and the observed y fixed and vary only the
  relative uncertainties. When measurement noise is small, K is near one and
  the posterior mean moves almost all the way to y. Equal variances give the
  midpoint. Large measurement noise makes K small, so the prior mean moves very
  little. This is the one-dimensional intuition that sensor fusion generalizes.
]


== Inference often combines conditioning and summarizing

#content-block(
  layout: "top",
  object-width: 94%,
  object: [
    #course-card(title: [Condition, then summarize])[
      #grid(
        columns: (1fr, auto, 1.35fr, auto, 1.25fr),
        column-gutter: 0.45em,
        row-gutter: 0.35em,
        align: center + horizon,
        [#align(center)[#stack(spacing: 0.2em, [*Observed*], [$y$])]],
        [$arrow.r$],
        [#align(center)[#stack(spacing: 0.2em, [*Condition*], [$p(z | y)=cal(N)(z | mu_(z|y),Sigma_(z|y))$])]],
        uncover("2-")[$arrow.r$],
        uncover("2-")[#align(center)[#stack(spacing: 0.2em, [*Summarize*], [$hat(z)=E[z | y]=mu_(z|y)$])]],
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
      spacing: 0.35em,
      [- Conditioning preserves the whole posterior distribution and its uncertainty],
      uncover("2-")[- Summarizing extracts a quantity from that posterior; for a Gaussian the mean is $mu_(z|y)$],
    )
  ],
)

#speaker-note[
  This is deliberately a process slide, not another derivation. Conditioning
  answers which states remain plausible after observing y. If the downstream
  task needs one estimate, summarize that posterior. Under squared-error loss
  the posterior mean is the Bayes estimator, but the important point here is
  that conditioning and summarizing are sequential operations, not competing
  alternatives.
]


== Sensor fusion combines measurements according to their uncertainty

#content-block(
  layout: "top",
  object-width: 98%,
  object: [
    #grid(
      columns: (1.15fr, 0.85fr),
      gutter: 0.8em,
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
      #v(0.35em)
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

#speaker-note[
  This is Murphy's sensor-fusion example and the first real application of the
  condition-then-summarize pipeline. The scalar gain intuition survives in
  multiple dimensions: a more precise source has more influence. In the third
  panel reliability is directional, so the posterior can be closer to one
  sensor horizontally and the other vertically. Algebraically x and y can be
  stacked into one observation vector and handled by the same LGS formula.
]


== The same model can also predict measurements

#content-block(
  layout: "top",
  object-width: 96%,
  object: [
    #twocol[
      #course-card(title: [Model and joint])[
        #text(size: 0.78em)[
          #stack(
            spacing: 0.55em,
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
            spacing: 0.75em,
            [$p(y)=integral p(z,y) dif z$],
            [$= integral p(y | z)p(z) dif z$],
          )
        ]
      ]
    ]
    #uncover("2-")[
      #v(0.55em)
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
      spacing: 0.35em,
      [- Before observing $y$, marginalization gives the distribution of possible measurements],
      uncover("2-")[- These are the same $mu_y$ and $Sigma_(y y)$ that appear inside the conditioning update],
    )
  ],
)

#speaker-note[
  Return explicitly to the third operation from the orientation slide. Here we
  are not inferring z. We integrate z out and ask what measurements the model
  predicts before one is observed. The result reuses the same predicted mean
  and measurement covariance that appeared in Bayes' rule; evaluating this
  density at an observed y tells us how plausible that measurement was under
  the model.
]


== Summary: one model, three probability operations

#content-block(
  layout: "top",
  object-width: 98%,
  object: [
    #align(center)[#text(size: 0.8em)[
      $z tilde cal(N)(mu_z,Sigma_z), quad y | z tilde cal(N)(W z+b,Omega)
      quad arrow.r quad p(z,y)$
    ]]
    #v(0.5em)
    #triad[
      #uncover("1-")[
        #course-card(title: [Marginalize])[
          #text(size: 0.72em)[
            #stack(
              spacing: 0.45em,
              [$p(y)=integral p(z,y) dif z$],
              [$=cal(N)(y | mu_y,Sigma_(y y))$],
              [What measurements should we expect?],
            )
          ]
        ]
      ]
    ][
      #uncover("2-")[
        #course-card(title: [Condition])[
          #text(size: 0.72em)[
            #stack(
              spacing: 0.45em,
              [$p(z | y)$],
              [$=cal(N)(z | mu_(z|y),Sigma_(z|y))$],
              [What does the measurement tell us about the state?],
            )
          ]
        ]
      ]
    ][
      #uncover("3-")[
        #course-card(title: [Summarize])[
          #text(size: 0.72em)[
            #stack(
              spacing: 0.45em,
              [$E[z | y]=integral z p(z | y) dif z$],
              [$=mu_(z|y)$],
              [What single estimate should we report?],
            )
          ]
        ]
      ]
    ]
    #source-note[Murphy, Book 2 §2.3.2]
  ],
  key-points: [
    #uncover("3-")[- Linear Gaussian systems remain analytic under affine transformation, marginalization, conditioning, and expectation]
  ],
)

#speaker-note[
  Close the lecture by returning to the three operations introduced before the
  Gaussian material. One model supplies all three answers. The special value of
  the linear Gaussian case is closure: each operation remains analytic. A useful
  forward reference is that repeating Gaussian prediction and conditioning over
  time gives the Kalman filter, which appears later in the course.
]
'''

DECK.write_text(prefix + "\n\n" + new_tail.lstrip(), encoding="utf-8")
print(f"Rebuilt LGS tail in {DECK}")
