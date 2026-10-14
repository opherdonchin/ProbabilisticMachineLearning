// Experimental one-slide authoring test.
// Lowers baseline64/slide_design.typ only; this is not the live L01 deck.
#import "../../../Lectures/course.typ": *
#import "@preview/touying:0.7.4": touying-set-config, config-common

#let lecture = (
  number: 1,
  title: [Probability and Bayesian Statistics],
  short-title: [Probability & Statistics],
  subtitle: [From Bayesian statistics to probabilistic machine learning],
)
#show: course-theme.with(info: lecture)
#show: touying-set-config.with(config-common(handout: true))

== A point estimate needs a loss function

#content-block(
  object: [
    #stack(
      spacing: sp("s"),

      card[
        #text(size: fs("m"))[
          After observing $y$, estimate the latent state $z in RR^L$ by a vector $a in RR^L$.

          Assume $E[ norm(z)^2 | y ] < infinity$.
        ]
      ],

      bordered-card(title: [Squared-Euclidean loss and conditional risk])[
        #text(size: fs("m"))[
          $L(z,a) = norm(z-a)^2$

          $R(a|y) = E[L(z,a)|y] = E[ norm(z-a)^2 | y ]$
        ]
      ],

      uncover("2-")[
        #card[
          #text(size: fs("m"))[
            *Center the error about the posterior mean*

            $m = E[z|y] quad (= mu_(z|y) " for the Gaussian")$

            $z-a = (z-m) + (m-a)$

            $norm(z-a)^2 = norm(z-m)^2 + 2(z-m)^T (m-a) + norm(m-a)^2$

            #text(size: fs("s"))[Centered residual $z-m$ + displacement $m-a$.]
          ]
        ]
      ],
    )
  ],
  key-points: [
    - Conditional risk averages the loss over the posterior $p(z|y)$.
  ],
)
