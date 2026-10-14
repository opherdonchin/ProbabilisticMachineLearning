// Experimental isolated production trial for slide 64.
#import "../../../Lectures/course.typ": *

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
  object-width: 96%,
  object: [
    #stack(
      spacing: sp("s"),
      [
        #recall-card(
          from: [Slide 63],
          label: [Posterior mean],
          size: fs("s"),
        )[
          $p(z | y)=cal(N)(z | mu_(z|y),Sigma_(z|y)), quad E[z | y]=mu_(z|y)$
        ]
      ],
      [
        #text(size: fs("m"))[
          #align(center)[
            $y " observed", quad a in RR^d, quad E[norm(z)^2 | y] < infinity \
             ell(a,z)=norm(z-a)^2, quad R(a | y)=E[ell(a,z) | y]$
          ]
        ]
      ],
      [
        #step(2)[
          #align(center)[
            #text(size: fs("l"))[
              $ norm(z-a)^2
                &= norm((z-mu_(z|y))+(mu_(z|y)-a))^2 \
                &= norm(z-mu_(z|y))^2
                  + 2(z-mu_(z|y))^T (mu_(z|y)-a)
                  + norm(mu_(z|y)-a)^2 $
            ]
          ]
        ]
      ],
    )
  ],
  key-points: [
    #uncover("3-")[
      - A point estimate is judged by its posterior expected loss.
    ]
  ],
)
