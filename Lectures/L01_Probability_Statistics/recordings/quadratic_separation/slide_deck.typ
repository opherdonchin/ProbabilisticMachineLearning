// PROVISIONAL standalone recording deck — instructor-authorized build.
// Lowering of slide_design.typ; no speaker notes. Timing and final acceptance
// remain open. Shared mathematical content follows the approved provisional
// design; geometry and reveal mechanics are production choices.
#import "../../../course.typ": *

#let lecture = (
  number: 1,
  title: [Quadratic separation of a Gaussian],
  short-title: [Gaussian conditioning proof],
  subtitle: [A complete density proof of Gaussian conditioning],
)

#show: course-theme.with(info: lecture)
#show: touying-set-config.with(config-common(handout: true))

#let reveal(n, emphasis: false, body) = if emphasis { step(n, body) } else { uncover(str(n) + "-", body) }

#let teaching(object, points, width: 92%, key-state: none) = if key-state == none {
  content-block(object-width: width, object: object, key-points: points)
} else {
  stack(
    spacing: 0.9em,
    align(center, block(width: width)[#object]),
    uncover(str(key-state) + "-", key-points(points)),
  )
}

#let math-lines(..rows) = stack(spacing: 0em, ..rows.pos().map(row => block[#v(0.9em) #align(center)[#row] #v(0.9em)]))

#let math-card(body) = card[
  #set par(leading: 1.6em)
  #align(center)[#body]
]

#section-metadata(short-title: [Quadratic separation], subtitle: [Proving the algebra behind Gaussian conditioning])
#title-slide()

= Block elimination separates the joint quadratic

== The joint density sets two proof obligations
#teaching(
  stack(spacing: sp("s"),
    recall-card(from: [Prepared live: Gaussian blocks and density], label: [Supplied model])[$X=mat(X_1;X_2), quad mu=mat(mu_1;mu_2), quad Sigma=mat(Sigma_11,Sigma_12;Sigma_21,Sigma_22)=Sigma^T succ 0$\
$X_i,mu_i in RR^(d_i), quad Sigma_(i j) in RR^(d_i times d_j), quad d=d_1+d_2, quad d_i>=1$],
    reveal(2, emphasis: false)[#math-card(math-lines([$p(x_1,x_2)=cal(N)_(d)(x;mu,Sigma)$], [$=(2pi)^(-d/2)(det Sigma)^(-1/2) exp(-1/2 (x-mu)^T Sigma^(-1)(x-mu))$]))],
  ),
  [Separating the quadratic is one obligation. The normalizer must split as well.],
  key-state: 2,
)

== Positive definiteness makes the observed block invertible
#teaching(
  stack(spacing: sp("s"),
    math-card(math-lines([$H:=Sigma_22, quad z in RR^(d_2) backslash {0}$], [$z^T H z=mat(0;z)^T Sigma mat(0;z)>0 quad => quad H=H^T succ 0$])),
    reveal(2, emphasis: true)[#math-card([$B:=Sigma_12 H^(-1), quad S:=Sigma_11-B H B^T=S^T$])],
    reveal(3, emphasis: false)[#math-card(math-lines([$B H=Sigma_12, quad H B^T=Sigma_21$], [$S=Sigma_11-Sigma_12 H^(-1)Sigma_21$]))],
  ),
  [$S$ is the live residual covariance (the Schur complement of $H$). Its strict positivity still needs proof here.],
  key-state: 3,
)

== The elimination matrix has an explicit inverse
#teaching(
  stack(spacing: sp("m"),
    math-card([$T:=mat(I_(d_1),-B;0,I_(d_2)), quad U:=mat(I_(d_1),B;0,I_(d_2))$]),
    reveal(2, emphasis: true)[#math-card(math-lines([$T U=mat(I_(d_1),B-B;0,I_(d_2))=I_d$], [$U T=mat(I_(d_1),-B+B;0,I_(d_2))=I_d quad => quad T^(-1)=U$]))],
  ),
  [Block elimination is reversible; no covariance or independence argument was used.],
  key-state: 2,
)

== Left elimination removes the upper covariance block
#teaching(
  stack(spacing: sp("s"),
    recall-card(from: [R1.3])[$B H=Sigma_12, quad H B^T=Sigma_21, quad S=Sigma_11-B H B^T$],
    reveal(2, emphasis: true)[#math-card(math-lines([$T Sigma=mat(I,-B;0,I) mat(Sigma_11,B H;H B^T,H)$], [$=mat(Sigma_11-B H B^T,B H-B H;H B^T,H)$]))],
    reveal(3, emphasis: false)[#math-card([$T Sigma=mat(S,0;H B^T,H)$])],
  ),
  [The upper cross block vanishes. This single multiplication is not yet the covariance congruence.],
  key-state: 3,
)

== Right elimination completes the covariance congruence
#teaching(
  stack(spacing: sp("s"),
    recall-card(from: [R1.5 and transpose of R1.4])[$T Sigma=mat(S,0;H B^T,H), quad T^T=mat(I,0;-B^T,I)$],
    reveal(2, emphasis: true)[#math-card(math-lines([$T Sigma T^T=mat(S,0;H B^T,H) mat(I,0;-B^T,I)$], [$=mat(S,0;H B^T-H B^T,H)$]))],
    reveal(3, emphasis: false)[#math-card([$D:=T Sigma T^T=mat(S,0;0,H)$])],
  ),
  [The two multiplications form a congruence: $T Sigma T^T$. They do not form a similarity transformation.],
  key-state: 3,
)

== Invertible congruence proves the residual covariance positive definite
#teaching(
  stack(spacing: sp("s"),
    recall-card(from: [R1.4 and R1.6])[$D=T Sigma T^T=mat(S,0;0,H), quad T " invertible", quad Sigma succ 0$],
    reveal(2, emphasis: true)[#math-card(math-lines([$w!=0 quad => quad T^T w!=0$], [$w^T D w=(T^T w)^T Sigma(T^T w)>0 quad => quad D succ 0$]))],
    reveal(3, emphasis: true)[#math-card(math-lines([$a in RR^(d_1) backslash {0}, quad w=mat(a;0)$], [$a^T S a=w^T D w>0 quad => quad S succ 0$]))],
  ),
  [Both $S$ and $H$ have inverses and positive determinants. This follows from strict joint positivity.],
  key-state: 3,
)

== Inverting the congruence fixes the order of the factors
#teaching(
  stack(spacing: sp("s"),
    recall-card(from: [R1.6; inverses justified in R1.7])[$D=T Sigma T^T=mat(S,0;0,H)$],
    reveal(2, emphasis: true)[#math-card([$D^(-1)=T^(-T) Sigma^(-1) T^(-1), quad T^(-T):=(T^(-1))^T$])],
    reveal(3, emphasis: true)[#math-card(math-lines([$T^T D^(-1)T=Sigma^(-1)$], [$Sigma^(-1)=T^T mat(S^(-1),0;0,H^(-1))T$]))],
  ),
  [The factors do not commute. The order follows from undoing the congruence.],
  key-state: 3,
)

== Elimination turns the centered vector into a residual and an observation
#teaching(
  stack(spacing: sp("s"),
    math-card([$u:=x_2-mu_2, quad r:=x_1-mu_1-B u$]),
    reveal(2, emphasis: true)[#math-card(math-lines([$T(x-mu)=mat(I,-B;0,I)mat(x_1-mu_1;u)$], [$=mat(x_1-mu_1-B u;u)=mat(r;u)$]))],
  ),
  [$r$ is the centered residual. Its coordinates contain $x_2$; the original first block is still $x_1$.],
  key-state: 2,
)

== The joint quadratic is the sum of two block quadratics
#teaching(
  stack(spacing: sp("s"),
    recall-card(from: [R1.8 and R1.9])[$Sigma^(-1)=T^T D^(-1)T, quad T(x-mu)=mat(r;u)$\
$D^(-1)=mat(S^(-1),0;0,H^(-1))$],
    reveal(2, emphasis: true)[#math-card(math-lines([$ (x-mu)^T Sigma^(-1)(x-mu)=[T(x-mu)]^T D^(-1)[T(x-mu)]$], [$=mat(r;u)^T mat(S^(-1),0;0,H^(-1)) mat(r;u)$]))],
    reveal(3, emphasis: true)[#math-card([$(x-mu)^T Sigma^(-1)(x-mu)=r^T S^(-1)r+u^T H^(-1)u$])],
  ),
  [The exponent separates exactly. A normalized density equality has not yet been proved.],
  key-state: 3,
)

== Retrospective: elimination separates the quadratic
#content-block(
  object-width: 94%,
  object: section-summary-visual([$T Sigma T^T=mat(S,0;0,H), quad H succ 0, quad S succ 0$\
$(x-mu)^T Sigma^(-1)(x-mu)=r^T S^(-1)r+u^T H^(-1)u$\
$u=x_2-mu_2, quad r=x_1-mu_1-B u$]),
  key-points: section-summary-takeaways([Reversible elimination yields valid residual and observed covariance blocks. The inverse congruence separates their quadratic contributions.]),
)

#section-metadata(short-title: [Normalized factorization], subtitle: [From separated exponents to probability laws])
= Normalizers identify the conditional and marginal densities

== Unit-determinant elimination splits the covariance determinant
#teaching(
  stack(spacing: sp("s"),
    recall-card(from: [R1.4 and R1.6])[$T=mat(I,-B;0,I), quad D=T Sigma T^T=mat(S,0;0,H)$],
    reveal(2, emphasis: true)[#math-card([$det T=det I_(d_1) det I_(d_2)=1$])],
    reveal(3, emphasis: true)[#math-card(math-lines([$det D=(det T)(det Sigma)(det T^T)=det Sigma$], [$det Sigma=det S det H, quad det Sigma,det S,det H>0$]))],
  ),
  [Elimination changes the covariance blocks while preserving this determinant. Positivity licenses positive square roots.],
  key-state: 3,
)

== The dimensions split the remaining Gaussian normalizer
#teaching(
  stack(spacing: sp("s"),
    recall-card(from: [R1.2, R1.7 and R2.2])[$d=d_1+d_2, quad det Sigma=det S det H, quad S,H succ 0$],
    reveal(2, emphasis: true)[#math-card(math-lines([$(2pi)^(-d/2)(det Sigma)^(-1/2)$], [$=(2pi)^(-(d_1+d_2)/2)(det S det H)^(-1/2)$]))],
    reveal(3, emphasis: true)[#math-card(math-lines([$(2pi)^(-d/2)(det Sigma)^(-1/2)$], [$=[(2pi)^(-d_1/2)(det S)^(-1/2)] [(2pi)^(-d_2/2)(det H)^(-1/2)]$]))],
  ),
  [Each block receives its own determinant factor and its own dimension factor.],
  key-state: 3,
)

== The full density equals two normalized Gaussian factors
#teaching(
  stack(spacing: sp("m"),
    recall-card(from: [R1.3, R1.7 and R1.9])[$u=x_2-mu_2, quad r=x_1-(mu_1+B u), quad S,H succ 0$],
    reveal(2, emphasis: true)[#math-card(math-lines([$g_(1)(x_1;x_2):=(2pi)^(-d_1/2)(det S)^(-1/2) exp(-1/2 r^T S^(-1)r)$], [$=cal(N)_(d_1)(x_1;mu_1+B u,S)$]))],
    reveal(3, emphasis: true)[#math-card(math-lines([$g_(2)(x_2):=(2pi)^(-d_2/2)(det H)^(-1/2) exp(-1/2 u^T H^(-1)u)$], [$=cal(N)_(d_2)(x_2;mu_2,H)$]))],
    reveal(4, emphasis: false)[#math-card([$p(x_1,x_2)=g_(1)(x_1;x_2)g_(2)(x_2)$])],
  ),
  [For fixed $x_2$, $g_1$ is a Gaussian density in $x_1$. The factor names do not yet identify the marginal and conditional.],
  width: 96%,
  key-state: 4,
)

== Integrating the first factor identifies the marginal
#teaching(
  stack(spacing: sp("xs"),
    recall-card(from: [R2.4])[$p(x_1,x_2)=g_(1)(x_1;x_2)g_(2)(x_2), quad g_(1)(x_1;x_2)=cal(N)_(d_1)(x_1;mu_1+B u,S)$],
    reveal(2, emphasis: true)[#math-card(math-lines([$S succ 0, quad m:=mu_1+B(x_2-mu_2) " is fixed"$], [$integral_(RR^(d_1))g_(1)(x_1;x_2) dif x_1=integral_(RR^(d_1))cal(N)_(d_1)(x_1;m,S) dif x_1=1$]))],
    reveal(3, emphasis: true)[#math-card(math-lines([$p(x_2)&=integral_(RR^(d_1))p(x_1,x_2) dif x_1$], [$&=g_(2)(x_2) integral_(RR^(d_1))g_(1)(x_1;x_2) dif x_1$], [$&=g_(2)(x_2)=cal(N)_(d_2)(x_2;mu_2,H)$]))],
  ),
  [Normalization identifies $g_2$ as the marginal; no conditional formula was assumed.],
  width: 96%,
  key-state: 3,
)

== Dividing by the positive marginal identifies the conditional
#teaching(
  stack(spacing: sp("s"),
    math-card([$p(x_2)=g_(2)(x_2)=cal(N)_(d_2)(x_2;mu_2,H)>0 quad (x_2 in RR^(d_2))$]),
    reveal(2, emphasis: true)[#math-card(math-lines([$p(x_1|x_2)&:=frac(p(x_1,x_2),p(x_2))$], [$&=frac(g_(1)(x_1;x_2)g_(2)(x_2),g_(2)(x_2))=g_(1)(x_1;x_2)$], [$&=cal(N)_(d_1)(x_1;mu_1+B(x_2-mu_2),S)$]))],
    reveal(3, emphasis: false)[#math-card([$p(x_1,x_2)=p(x_1|x_2)p(x_2)$])],
  ),
  [The positive-density ratio gives a conditional-density version for every $x_2$. Its normalization was already proved.],
  key-state: 3,
)

== The conditional mean retains the observed-block dependence
#teaching(
  stack(spacing: sp("s"),
    recall-card(from: [R2.6])[$p(x_1|x_2)=cal(N)_(d_1)(x_1;mu_1+B(x_2-mu_2),S)$],
    reveal(2, emphasis: false)[#math-card(math-lines([$mu_(1|2)(x_2)=mu_1+B(x_2-mu_2), quad Sigma_(1|2)=S$], [$r=x_1-mu_(1|2)(x_2)$]))],
  ),
  [The mean is affine in $x_2$ and can depend on the observation; the covariance does not. A separated residual quadratic does not assert independence. This exact density proof assumes a joint Gaussian with $Sigma succ 0$; it does not establish adequacy of the supplied model.],
  key-state: 2,
)

== Retrospective: normalization completes Gaussian conditioning
#content-block(
  object-width: 96%,
  object: section-summary-visual([$p(x_1,x_2)=g_(1)(x_1;x_2)g_(2)(x_2)$\
$g_1=cal(N)_(d_1)(x_1;mu_1+B(x_2-mu_2),S), quad g_2=cal(N)_(d_2)(x_2;mu_2,H)$\
$integral_(RR^(d_1))g_(1)(x_1;x_2) dif x_1=1 quad => quad p(x_2)=g_(2)(x_2)$\
$frac(p(x_1,x_2),p(x_2))=g_(1)(x_1;x_2)=p(x_1|x_2)$]),
  key-points: section-summary-takeaways([The quadratic, determinant and dimension factors all split. Integration then division identify the Gaussian marginal and conditional.]),
)
