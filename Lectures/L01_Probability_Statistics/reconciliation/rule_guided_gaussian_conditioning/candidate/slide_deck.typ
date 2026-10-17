// Autonomous rule-guided experimental baseline. Not the canonical recording.
// One continuous recording section: no divider, section summary, or notes.
#import "../../../../course.typ": *

#let lecture = (
  number: "L01-R01",
  kind: "recording",
  title: [Gaussian conditioning by block elimination],
  short-title: [Gaussian conditioning proof],
  subtitle: [A normalized density proof of the Gaussian conditioning formulas],
)

#show: course-theme.with(info: lecture)
#show: touying-set-config.with(config-common(handout: true))

// Let reveals hide the entire interpretation card, including its border.
#let recording-content(object: none, points: none, key-points-from: 1) = stack(
  spacing: 0.9em,
  content-block(object: object),
  if key-points-from == 1 {
    key-points(points)
  } else {
    uncover(str(key-points-from) + "-")[#key-points(points)]
  },
)

#let math-label(body) = text(size: fs("m"), weight: "semibold", fill: palette.text)[#body]

#title-slide()

== From a joint Gaussian to a conditional density
#recording-content(
  object: stack(
    spacing: sp("m"),
    recall-card(
      math-rows(
        gap: 1em,
        [$m(x_2)=mu_1+Sigma_12 Sigma_22^(-1)(x_2-mu_2)$],
        [$S=Sigma_11-Sigma_12 Sigma_22^(-1)Sigma_21$],
      ),
      from: [L01 live lecture: conditioning mean and covariance; independent residual],
      label: [From the lecture],
    ),
    stack(
      spacing: sp("s"),
      text(size: fs("m"), weight: "semibold", fill: palette.accent)[To prove here],
      math-rows(
        gap: 0.8em,
        [$p(x_1,x_2)=cal(N)(x|mu,Sigma)$],
        [$p(x_1|x_2)=cal(N)(x_1|m(x_2),S)$],
      ),
    ),
  ),
  points: [Assume $Sigma=Sigma^T succ 0$ is symmetric positive definite: $v^T Sigma v>0$ for $v!=0$. Here $x_i,mu_i in RR^(d_i)$ and $d=d_1+d_2$.],
)

== The joint density has a quadratic and a normalizing factor
#recording-content(
  object: stack(
    spacing: sp("l"),
    math-rows(
      gap: 1em,
      [$x=mat(x_1;x_2), quad mu=mat(mu_1;mu_2), quad Sigma=mat(Sigma_11,Sigma_12;Sigma_21,Sigma_22)$],
    ),
    math-rows(gap: 1em, [$p(x_1,x_2)=frac(exp[-frac(1,2)(x-mu)^T Sigma^(-1)(x-mu)],(2pi)^(d/2)sqrt(det Sigma))$]),
    uncover("2-")[
      #math-rows(
        gap: 1em,
        [$Q=(x-mu)^T Sigma^(-1)(x-mu), quad C=frac(1,(2pi)^(d/2)sqrt(det Sigma))$],
        [$p(x_1,x_2)=C exp(-Q/2)$],
      )
    ],
  ),
  key-points-from: 2, points: [$Q$ controls the exponential; $C$ is the factor that makes the density integrate to one. A conditional density requires both parts, with their correct constants.],
)

== The observed covariance block is invertible
#recording-content(
  object: stack(
    spacing: sp("l"),
    recall-card([$Sigma=Sigma^T succ 0$], from: [Orientation], label: [Premise]),
    math-rows(
      gap: 1em,
      [$z in RR^(d_2), quad z!=0, quad mat(0;z)!=0$],
      [$z^T Sigma_22 z=mat(0;z)^T Sigma mat(0;z)>0$],
    ),
    uncover("2-")[
      #math-rows(gap: 1em, [$Sigma_22=Sigma_22^T succ 0 quad => quad Sigma_22^(-1) " exists"$])
    ],
  ),
  key-points-from: 2, points: [Positive definiteness of the joint covariance also holds on the observed coordinate subspace.],
)

== Choose the row subtraction to cancel the cross block
#recording-content(
  object: stack(
    spacing: sp("l"),
    math-label([First block row minus $B$ times the second]),
    only("1")[
      #math-rows(gap: 1em, [$T=mat(I,-B;0,I), quad T Sigma=mat(Sigma_11-B Sigma_21,Sigma_12-B Sigma_22;Sigma_21,Sigma_22)$])
    ],
    only("2-")[
      #math-rows(gap: 1em, [$T=mat(I,-B;0,I), quad T Sigma=mat(Sigma_11-B Sigma_21,text(fill: palette.accent, "Σ₁₂ − BΣ₂₂");Sigma_21,Sigma_22)$])
    ],
    uncover("2-")[
      #stack(
        spacing: sp("m"),
        math-label([Choose $B$ to make the upper-right block zero]),
        text(fill: palette.accent)[$Sigma_12-B Sigma_22=0$],
        math-rows(gap: 1em, [$B=Sigma_12 Sigma_22^(-1)$]),
      )
    ],
    uncover("3-")[
      #math-rows(gap: 1em, [$T Sigma=mat(Sigma_11-B Sigma_21,0;Sigma_21,Sigma_22)$])
    ],
  ),
  points: [A block diagonal covariance has a block diagonal inverse. In those transformed coordinates, the quadratic separates into two block contributions.],
)

== The matching column subtraction leaves a block diagonal matrix
#recording-content(
  object: stack(
    spacing: sp("l"),
    math-label([First block column minus the second times $B^T$]),
    math-rows(
      gap: 1em,
      [$T Sigma T^T=mat(Sigma_11-B Sigma_21,0;Sigma_21,Sigma_22)mat(I,0;-B^T,I)$],
      [$Sigma_22 B^T=Sigma_21$],
    ),
    uncover("2-")[
      #math-rows(
        gap: 1em,
        [$T Sigma T^T=mat(Sigma_11-B Sigma_21,0;underbrace(Sigma_21-Sigma_22 B^T,=0),Sigma_22)=mat(S,0;0,Sigma_22)$],
        [$S=Sigma_11-Sigma_12 Sigma_22^(-1)Sigma_21$],
      )
    ],
  ),
  key-points-from: 2, points: [The remaining first block is the Schur complement of $Sigma_22$ in $Sigma$, the same residual covariance obtained in the live lecture.],
)

== The remaining covariance block is positive definite
#recording-content(
  object: stack(
    spacing: sp("l"),
    recall-card(
      [$T Sigma T^T=mat(S,0;0,Sigma_22), quad T=mat(I,-B;0,I)$],
      from: [Previous slide],
      label: [Elimination],
    ),
    math-rows(
      gap: 0.9em,
      [$a in RR^(d_1), quad a!=0, quad T^T mat(a;0)=mat(a;-B^T a)!=0$],
      [$a^T S a=mat(a;0)^T T Sigma T^T mat(a;0)$],
      [$=mat(a;-B^T a)^T Sigma mat(a;-B^T a)>0$],
    ),
    uncover("2-")[
      #math-rows(gap: 1em, [$S=S^T succ 0 quad => quad S^(-1) " exists", quad det S>0$])
    ],
  ),
  key-points-from: 2, points: [The residual covariance is a valid nondegenerate Gaussian covariance. Both covariance blocks now have inverses and positive determinants.],
)

== The same subtraction produces the centered residual
#recording-content(
  object: stack(
    spacing: sp("l"),
    math-rows(
      gap: 1em,
      [$u=x_2-mu_2, quad r=x_1-mu_1-B u=x_1-m(x_2)$],
      [$T(x-mu)=mat(I,-B;0,I)mat(x_1-mu_1;u)=mat(r;u)$],
    ),
    uncover("2-")[
      #math-rows(
        gap: 1em,
        [$T^(-1)=mat(I,B;0,I), quad T^(-1)mat(r;u)=mat(r+B u;u)=x-mu$],
        [$T T^(-1)=mat(I,B-B;0,I)=I=T^(-1)T$],
      )
    ],
  ),
  key-points-from: 2, points: [$u$ is fixed when conditioning; $r$ is the remaining centered variation around the observation-dependent mean.],
)

== The eliminated covariance gives the inverse in the density
#recording-content(
  object: stack(
    spacing: sp("l"),
    recall-card(
      [$T Sigma T^T=mat(S,0;0,Sigma_22)$],
      from: [Slide 6; $T$ is invertible and both diagonal blocks are positive definite],
      label: [Covariance identity],
    ),
    math-label([Invert both sides; reverse the order of factors]),
    math-rows(
      gap: 1em,
      [$ (T^T)^(-1) Sigma^(-1) T^(-1)=mat(S^(-1),0;0,Sigma_22^(-1)) $],
    ),
    uncover("2-")[
      #stack(
        spacing: sp("m"),
        math-label([Multiply on the left by $T^T$ and on the right by $T$]),
        math-rows(gap: 1em, [$Sigma^(-1)=T^T mat(S^(-1),0;0,Sigma_22^(-1))T$]),
      )
    ],
  ),
  key-points-from: 2, points: [The recovered inverse covariance is the matrix in $Q$. Its factor order lets the subtraction act directly on the centered data vector.],
)

== Use the eliminated inverse in the quadratic
#recording-content(
  object: stack(
    spacing: sp("l"),
    recall-card(
      math-rows(
        gap: 1em,
        [$Q=(x-mu)^T Sigma^(-1)(x-mu)$],
        [$Sigma^(-1)=T^T mat(S^(-1),0;0,Sigma_22^(-1))T$],
      ),
      from: [Joint density and previous slide],
      label: [Inputs],
    ),
    uncover("2-")[
      #stack(
        spacing: sp("m"),
        math-label([Substitute the inverse; $(T v)^T=v^T T^T$]),
        math-rows(gap: 1em, [$Q=[T(x-mu)]^T mat(S^(-1),0;0,Sigma_22^(-1))[T(x-mu)]$]),
      )
    ],
  ),
  key-points-from: 2, points: [The outer factors $T$ act on the centered vector; the middle matrix is block diagonal.],
)

== Block diagonal multiplication separates the quadratic
#recording-content(
  object: stack(
    spacing: sp("l"),
    recall-card(
      math-rows(
        gap: 1em,
        [$Q=[T(x-mu)]^T mat(S^(-1),0;0,Sigma_22^(-1))[T(x-mu)]$],
        [$T(x-mu)=mat(r;u), quad r=x_1-m(x_2), quad u=x_2-mu_2$],
      ),
      from: [Previous slide and residual coordinates],
      label: [Inputs],
    ),
    uncover("2-")[
      #math-rows(
        gap: 1em,
        [$Q=mat(r;u)^T mat(S^(-1),0;0,Sigma_22^(-1))mat(r;u)$],
        [$=underbrace(r^T S^(-1)r,"residual")+underbrace(u^T Sigma_22^(-1)u,"observed deviation")$],
      )
    ],
  ),
  key-points-from: 2, points: [For fixed $x_2$, the observed term is constant in $x_1$; the residual term varies through $r=x_1-m(x_2)$.],
)

== The same elimination also splits the determinant
#recording-content(
  object: stack(
    spacing: sp("l"),
    recall-card(
      [$T Sigma T^T=mat(S,0;0,Sigma_22), quad T=mat(I,-B;0,I)$],
      from: [Elimination],
      label: [Covariance identity],
    ),
    math-rows(
      gap: 1em,
      [$det T=det I_(d_1) det I_(d_2)=1$],
    ),
    math-label([$T$ is triangular, so its determinant is $1$; determinants multiply]),
    math-rows(
      gap: 1em,
      [$det(T Sigma T^T)=det T dot det Sigma dot det T^T=det Sigma$],
    ),
    uncover("2-")[
      $det Sigma=det S dot det Sigma_22$
    ],
  ),
  key-points-from: 2, points: [The elimination preserves the determinant and exposes exactly the two covariance determinants needed for Gaussian normalization.],
)

== Dimensions and determinants split the normalizing factor
#recording-content(
  object: stack(
    spacing: sp("l"),
    recall-card(
      [$C=(2pi)^(-d/2)(det Sigma)^(-1/2), quad d=d_1+d_2$],
      from: [Full density and block dimensions],
      label: [Coefficient],
    ),
    math-rows(
      gap: 1em,
      [$C=(2pi)^(-(d_1+d_2)/2)(det S dot det Sigma_22)^(-1/2)$],
    ),
    uncover("2-")[
      #stack(
        spacing: sp("m"),
        math-label([Split the powers and positive square roots]),
        math-rows(gap: 1em, [$C=underbrace(frac(1,(2pi)^(d_1/2)sqrt(det S)),"residual factor") dot underbrace(frac(1,(2pi)^(d_2/2)sqrt(det Sigma_22)),"observed factor")$]),
      )
    ],
  ),
  key-points-from: 2, points: [Each coefficient has the dimension and covariance determinant of its Gaussian density; positivity licenses the positive square roots.],
)

== Both parts combine into normalized Gaussian factors
#recording-content(
  object: stack(
    spacing: sp("l"),
    recall-card(
      [$Q=r^T S^(-1)r+u^T Sigma_22^(-1)u, quad u=x_2-mu_2, quad r=x_1-m(x_2)$],
      from: [Quadratic split],
      label: [Quadratic],
    ),
    math-label([Substitute the separated quadratic and coefficient in $C exp(-Q/2)$]),
    math-rows(
      gap: 1em,
      [$p(x_1,x_2)=frac(exp[-frac(1,2)r^T S^(-1)r],(2pi)^(d_1/2)sqrt(det S)) dot frac(exp[-frac(1,2)u^T Sigma_22^(-1)u],(2pi)^(d_2/2)sqrt(det Sigma_22))$],
    ),
    uncover("2-")[
      $p(x_1,x_2)=cal(N)(x_1|m(x_2),S) cal(N)(x_2|mu_2,Sigma_22)$
    ],
  ),
  key-points-from: 2, points: [For each fixed $x_2$, the first factor is a normalized density in $x_1$. Its mean still depends on the observation.],
)

== Integrating out the residual identifies the marginal
#recording-content(
  object: stack(
    spacing: sp("l"),
    recall-card(
      [$p(x_1,x_2)=cal(N)(x_1|m(x_2),S) cal(N)(x_2|mu_2,Sigma_22)$],
      from: [Previous slide],
      label: [Joint density],
    ),
    math-label([Hold $x_2$ fixed and integrate with respect to $x_1$]),
    math-rows(
      gap: 1em,
      [$p(x_2)=integral_(RR^(d_1))p(x_1,x_2)dif x_1$],
      [$=cal(N)(x_2|mu_2,Sigma_22) underbrace(integral_(RR^(d_1))cal(N)(x_1|m(x_2),S)dif x_1,=1)$],
    ),
    uncover("2-")[
      $p(x_2)=cal(N)(x_2|mu_2,Sigma_22)>0$
    ],
  ),
  key-points-from: 2, points: [The factor that depends only on the observation is its marginal density. Its strict positivity makes the density ratio available at every $x_2$.],
)

== Dividing by the marginal gives the conditional Gaussian
#recording-content(
  object: stack(
    spacing: sp("l"),
    math-label([Cancel the positive observed-block density]),
    [$p(x_1|x_2)=frac(p(x_1,x_2),p(x_2))=frac(cal(N)(x_1|m(x_2),S) cal(N)(x_2|mu_2,Sigma_22),cal(N)(x_2|mu_2,Sigma_22))=cal(N)(x_1|m(x_2),S)$],
    uncover("2-")[
      #math-rows(
        gap: 1em,
        [$m(x_2)=mu_1+Sigma_12 Sigma_22^(-1)(x_2-mu_2)$],
        [$S=Sigma_11-Sigma_12 Sigma_22^(-1)Sigma_21$],
      )
    ],
  ),
  key-points-from: 2, points: [The observed deviation shifts the conditional mean. The conditional covariance is the residual covariance and does not depend on the observed value.],
)

== Zero cross-covariance removes the observation
#recording-content(
  object: stack(
    spacing: sp("l"),
    math-rows(
      gap: 1em,
      [$Sigma_12=0 quad => quad B=0, quad m(x_2)=mu_1, quad S=Sigma_11$],
      [$p(x_1|x_2)=cal(N)(x_1|mu_1,Sigma_11)=p(x_1)$],
    ),
    uncover("2-")[
      $p(x_1,x_2)=p(x_1)p(x_2) quad => quad X_1 perp X_2$
    ],
  ),
  key-points-from: 2, points: [For a joint Gaussian, zero cross-covariance makes observations of one block uninformative about the other.],
)
