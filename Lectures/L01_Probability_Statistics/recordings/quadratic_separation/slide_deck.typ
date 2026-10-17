// L01-R01 — one continuous proof recording. No section-divider or
// section-summary slides. No speaker notes.
#import "../../../course.typ": *

#let lecture = (
  number: "L01-R01",
  kind: "recording",
  title: [Quadratic separation of a Gaussian],
  short-title: [Gaussian conditioning proof],
  subtitle: [A proof of the formula for the conditional density of a Gaussian],
)

#show: course-theme.with(info: lecture)
#show: touying-set-config.with(config-common(handout: true))

#title-slide()

== From the lecture to this proof
#content-block(
  object: twocol(
    recall-card(
      from: [L01: Gaussian blocks, conditioning and centered residual],
      label: [From the lecture],
      math-rows(
        gap: 1em,
        [$X=mat(X_1;X_2) tilde cal(N)_(d)(mu,Sigma)$],
        [$mu=mat(mu_1;mu_2), quad Sigma=mat(Sigma_11,Sigma_12;Sigma_21,Sigma_22)$],
        [$Sigma=Sigma^T succ 0, quad d=d_1+d_2$],
      ),
    ),
    bordered-card(
      title: [To prove here],
      [#stack(
        spacing: sp("m"),
        math-rows(gap: 1em, [$p(x_1|x_2)=cal(N)_(d_1)(x_1;m(x_2),S)$]),
        [The conditional mean $m(x_2)$ and covariance $S$ obtained in the lecture.],
        [Derive this complete density from the supplied joint density $p(x_1,x_2)$.],
      )],
    ),
    columns: cols("equal"),
    gutter: sp("xl"),
  ),
  key-points: stack(
    spacing: sp("m"),
    [Fix the observed value $x_2$; the density describes the missing block $X_1$.],
    [We account for the exponential and its coefficient, then identify the conditional by integration and division.],
  ),
)

== The density contains an exponential and a coefficient
#content-block(
  object: stack(
    spacing: sp("l"),
    math-rows(gap: 1em, [$p(x_1,x_2)=C exp(-1/2 Q)$]),
    twocol(
      stack(
        spacing: sp("m"),
        text(size: fs("m"), weight: "semibold")[The quadratic in the exponent],
        math-rows(gap: 1em, [$Q=(x-mu)^T Sigma^(-1)(x-mu)$]),
        [Target: a residual contribution plus an observed-deviation contribution.],
        [Residual: $x_1-m(x_2)$. Observed deviation: $x_2-mu_2$.],
      ),
      step(2, stack(
        spacing: sp("m"),
        text(size: fs("m"), weight: "semibold")[The coefficient before the exponential],
        math-rows(
          gap: 1em,
          [$C=(2pi)^(-d/2)(det Sigma)^(-1/2)$],
          [$d=d_1+d_2$],
        ),
        [Target: the coefficient for the residual density times that for the observed-block density.],
      )),
      columns: cols("equal"),
      gutter: sp("l"),
    ),
  ),
  key-points: [Writing the exponential as a product will not establish a full density product until the coefficient also matches.],
)

== Choose B to remove the cross covariance
#content-block(
  object: stack(
    spacing: sp("m"),
    [Subtract $B$ times the observed block so the cross covariance cancels:],
    math-rows(
      gap: 1em,
      [$H:=Sigma_22$],
      [$Sigma_12-B H=0 quad <=> quad B H=Sigma_12$],
    ),
    twocol(
      step(2, stack(
        spacing: sp("m"),
        text(size: fs("m"), weight: "semibold")[Why the inverse of $H$ exists],
        [Take any nonzero vector $z$ for the observed block:],
        math-rows(
          gap: 1em,
          [$z in RR^(d_2) backslash {0}$],
          [$z^T H z=mat(0;z)^T Sigma mat(0;z)>0$],
          [$H=H^T succ 0 quad => quad H^(-1) " exists"$],
        ),
      )),
      step(3, stack(
        spacing: sp("m"),
        text(size: fs("m"), weight: "semibold")[Solve the cancellation equation],
        math-rows(
          gap: 1em,
          [$B=Sigma_12 H^(-1) in RR^(d_1 times d_2)$],
          [$B H=Sigma_12, quad H B^T=Sigma_21$],
        ),
      )),
      columns: cols("left"),
      gutter: sp("l"),
    ),
  ),
  key-points: [Canceling the cross blocks makes the inverse act separately on residual and observed coordinates. This is what will give the two terms in $Q$.],
)

== Subtracting the predicted deviation produces the residual
#content-block(
  object: stack(
    spacing: sp("l"),
    math-rows(
      gap: 0.8em,
      [$u:=x_2-mu_2$],
      [$m(x_2):=mu_1+B u, quad r:=x_1-m(x_2)$],
    ),
    step(2, stack(
      spacing: sp("l"),
      math-rows(
        gap: 0.8em,
        [$T:=mat(I_(d_1),-B;0,I_(d_2))$],
        [$T(x-mu)=mat(I,-B;0,I)mat(x_1-mu_1;u)=mat(r;u)$],
      ),
      [Target from the lecture — to prove here:],
      math-rows(gap: 1em, [$Q=r^T S^(-1)r+u^T H^(-1)u$]),
    )),
  ),
  key-points: [Here $r$ is the error around the predicted mean and $u$ is the observed deviation. The target uses the residual covariance $S$ from the lecture; it will be derived here.],
)

== The coordinate change is reversible
#content-block(
  object: stack(
    spacing: sp("m"),
    [The map sent $(x_1-mu_1,u)$ to $(r,u)$; add the predicted deviation back:],
    math-rows(gap: 0.8em, [$U:=mat(I,B;0,I), quad U mat(r;u)=mat(r+B u;u)=x-mu$]),
    step(2, math-rows(
      gap: 0.8em,
      [$T U=mat(I,B-B;0,I)=I$],
      [$U T=mat(I,-B+B;0,I)=I quad => quad T^(-1)=U$],
    )),
  ),
  key-points: [The residual and observation together determine the original centered vector. Invertibility will preserve strict positivity and let us recover the inverse covariance.],
)

== Subtract the observed rows to cancel the upper-right block
#content-block(
  object: stack(
    spacing: sp("l"),
    [Using $B H=Sigma_12$, multiply by $T$ on the left:],
    math-rows(
      gap: 0.8em,
      [$Sigma=mat(Sigma_11,B H;H B^T,H), quad T=mat(I,-B;0,I)$],
    ),
    step(2, math-rows(
      gap: 0.8em,
      [$T Sigma=mat(I,-B;0,I)mat(Sigma_11,B H;H B^T,H)$],
      [$B H-B H=0$],
    )),
    step(3, stack(
      spacing: sp("m"),
      math-rows(
        gap: 0.8em,
        [$S:=Sigma_11-B H B^T, quad T Sigma=mat(S,0;H B^T,H)$],
      ),
    )),
  ),
  key-points: [The chosen $B$ cancels the upper-right block exactly. The lower-left block remains because only the row operation has been applied.],
)

== The matching column operation cancels the lower-left block
#content-block(
  object: stack(
    spacing: sp("m"),
    [Carry the preceding product forward and multiply by $T^T$ on the right:],
    math-rows(
      gap: 0.8em,
      [$T Sigma=mat(S,0;H B^T,H), quad T^T=mat(I,0;-B^T,I)$],
    ),
    step(2, math-rows(
      gap: 0.8em,
      [$T Sigma T^T=mat(S,0;H B^T,H)mat(I,0;-B^T,I)$],
      [$=mat(S,0;H B^T-H B^T,H)$],
    )),
    step(3, math-rows(gap: 0.8em, [$D:=T Sigma T^T=mat(S,0;0,H)$])),
  ),
  key-points: [The row and column operations together give the covariance in residual and observation coordinates. Its off-diagonal blocks are zero; its inverse will produce the two quadratic terms.],
)

== The remaining residual block is positive definite
#content-block(
  object: stack(
    spacing: sp("l"),
    [The covariance congruence uses an invertible $T$ and a supplied $Sigma succ 0$:],
    math-rows(gap: 1em, [$D=T Sigma T^T=mat(S,0;0,H)$]),
    step(2, math-rows(
      gap: 1em,
      [$w!=0 quad => quad T^T w!=0$],
      [$w^T D w=(T^T w)^T Sigma(T^T w)>0$],
    )),
    step(3, math-rows(
      gap: 1em,
      [$a in RR^(d_1) backslash {0}, quad w=mat(a;0)$],
      [$a^T S a=w^T D w>0 quad => quad S=S^T succ 0$],
    )),
  ),
  key-points: [The supplied joint strict positivity survives the reversible coordinate change. Both $S$ and $H$ therefore have inverses and positive determinants, as the Gaussian density requires.],
)

== Invert the covariance identity to reach the exponent
#content-block(
  object: stack(
    spacing: sp("l"),
    [The density uses $Sigma^(-1)$, while elimination established an identity for $Sigma$:],
    math-rows(gap: 1em, [$D=T Sigma T^T, quad D=mat(S,0;0,H)$]),
    step(2, math-rows(
      gap: 1em,
      [$D^(-1)=T^(-T) Sigma^(-1) T^(-1)$],
      [$T^(-T):=(T^(-1))^T$],
    )),
    step(3, math-rows(
      gap: 1em,
      [$T^T D^(-1)T=Sigma^(-1)$],
      [$Sigma^(-1)=T^T mat(S^(-1),0;0,H^(-1))T$],
    )),
  ),
  key-points: [Invert the product in reverse order, then multiply on the left by $T^T$ and on the right by $T$. Do not reorder the factors. This gives the inverse covariance needed in $Q$.],
)

== The joint quadratic becomes a residual term plus an observed term
#content-block(
  object: stack(
    spacing: sp("l"),
    [From the covariance congruence and residual coordinates:],
    math-rows(gap: 1em, [$Sigma^(-1)=T^T D^(-1)T, quad T(x-mu)=mat(r;u)$]),
    step(2, stack(
      spacing: sp("m"),
      [Substitute into the quadratic $Q$ from the joint density:],
      math-rows(
        gap: 1em,
        [$Q=(x-mu)^T Sigma^(-1)(x-mu)=[T(x-mu)]^T D^(-1)[T(x-mu)]$],
        [$=mat(r;u)^T mat(S^(-1),0;0,H^(-1))mat(r;u)$],
      ),
    )),
    step(3, math-rows(
      gap: 1em,
      [$Q=underbrace(r^T S^(-1)r,"residual term")+underbrace(u^T H^(-1)u,"observed term")$],
    )),
  ),
  key-points: [At fixed $x_2$, $u$ is fixed while $r=x_1-m(x_2)$ varies with $x_1$. The zero off-diagonal blocks remove the mixed term.],
)

== A sum in the exponent becomes a product
#content-block(
  object: stack(
    spacing: sp("l"),
    [Use the proved quadratic split in $exp(-Q/2)$:],
    math-rows(gap: 1em, [$Q=r^T S^(-1)r+u^T H^(-1)u$]),
    [Use $exp(a+b)=exp(a)exp(b)$ with the quadratic split:],
    step(2, math-rows(
      gap: 1em,
      [$exp(-1/2 Q)=exp(-1/2 r^T S^(-1)r) exp(-1/2 u^T H^(-1)u)$],
      [$p(x_1,x_2)=C exp(-1/2 r^T S^(-1)r) exp(-1/2 u^T H^(-1)u)$],
    )),
    step(2, math-rows(gap: 1em, [$C=(2pi)^(-d/2)(det Sigma)^(-1/2)$])),
  ),
  key-points: [The two exponentials have the required shapes. To make two complete Gaussian densities, $C$ must supply the coefficient for each dimension and covariance.],
)

== The same elimination gives the determinant product
#content-block(
  object: stack(
    spacing: sp("l"),
    [Reuse the same covariance congruence; $T$ is block triangular with identity diagonal blocks:],
    math-rows(gap: 1em, [$D=T Sigma T^T=mat(S,0;0,H), quad det T=det I_(d_1) det I_(d_2)=1$]),
    step(2, math-rows(
      gap: 1em,
      [$det D=det T det Sigma det T^T=det Sigma$],
      [$det D=det S det H quad => quad det Sigma=det S det H$],
    )),
  ),
  key-points: [The coefficient $C$ contains $(det Sigma)^(-1/2)$. This identity replaces it by determinant factors for the residual and observed blocks.],
)

== The factors before the exponentials split too
#content-block(
  object: stack(
    spacing: sp("l"),
    [The dimensions and covariance determinants both split; $S$ and $H$ are positive definite:],
    math-rows(
      gap: 1em,
      [$d=d_1+d_2, quad det Sigma=det S det H$],
      [$(2pi)^(-d/2)=(2pi)^(-d_1/2)(2pi)^(-d_2/2)$],
      [$(det Sigma)^(-1/2)=(det S)^(-1/2)(det H)^(-1/2)$],
    ),
    step(2, math-rows(
      gap: 1em,
      [$C=C_1 C_2$],
      [$C_1:=(2pi)^(-d_1/2)(det S)^(-1/2)$],
      [$C_2:=(2pi)^(-d_2/2)(det H)^(-1/2)$],
    )),
  ),
  key-points: [The residual exponential receives $C_1$, for dimension $d_1$ and covariance $S$. The observed exponential receives $C_2$, for dimension $d_2$ and covariance $H$.],
)

== Reassemble the complete Gaussian densities
#content-block(
  object: stack(
    spacing: sp("l"),
    twocol(
      stack(
        spacing: sp("m"),
        text(size: fs("m"), weight: "semibold")[Gaussian density in $x_1$ for fixed $x_2$],
        math-rows(
          gap: 1em,
          [$g_(1)(x_1;x_2):=C_1 exp(-1/2 r^T S^(-1)r)$],
          [$=cal(N)_(d_1)(x_1;m(x_2),S)$],
          [$m(x_2)=mu_1+B u, quad r=x_1-m(x_2)$],
        ),
      ),
      step(2, stack(
        spacing: sp("m"),
        text(size: fs("m"), weight: "semibold")[Gaussian density in the observed block],
        math-rows(
          gap: 1em,
          [$g_(2)(x_2):=C_2 exp(-1/2 u^T H^(-1)u)$],
          [$=cal(N)_(d_2)(x_2;mu_2,H), quad u=x_2-mu_2$],
        ),
      )),
      columns: cols("equal"),
      gutter: sp("l"),
    ),
    step(3, math-rows(gap: 1em, [$p(x_1,x_2)=g_(1)(x_1;x_2)g_(2)(x_2)$])),
  ),
  key-points: [Each coefficient and positive definite covariance matches its dimension. Integration and division will identify which factor is the marginal and which is the conditional.],
)

== Integrate over x1 to identify the marginal
#content-block(
  object: stack(
    spacing: sp("l"),
    [Carry the product forward. For fixed $x_2$, $m(x_2)$ is fixed and $S succ 0$:],
    math-rows(
      gap: 1em,
      [$p(x_1,x_2)=g_(1)(x_1;x_2)g_(2)(x_2)$],
      [$integral_(RR^(d_1))g_(1)(x_1;x_2) dif x_1=1$],
    ),
    step(2, math-rows(
      gap: 0.9em,
      [$p(x_2)=integral_(RR^(d_1))p(x_1,x_2) dif x_1$],
      [$=g_(2)(x_2) integral_(RR^(d_1))g_(1)(x_1;x_2) dif x_1=g_(2)(x_2)$],
      [$p(x_2)=cal(N)_(d_2)(x_2;mu_2,H)$],
    )),
  ),
  key-points: [For each fixed observation, the first factor integrates to one. Marginalizing the joint therefore leaves exactly the second factor.],
)

== Divide by the marginal to obtain the conditional density
#content-block(
  object: stack(
    spacing: sp("l"),
    [The marginal is positive for every observed value:],
    math-rows(gap: 1em, [$p(x_2)=g_(2)(x_2)=cal(N)_(d_2)(x_2;mu_2,H)>0$]),
    step(2, math-rows(
      gap: 0.9em,
      [$p(x_1|x_2)=frac(p(x_1,x_2),p(x_2))$],
      [$=frac(g_(1)(x_1;x_2)g_(2)(x_2),g_(2)(x_2))=g_(1)(x_1;x_2)$],
    )),
    step(3, math-rows(
      gap: 1em,
      [$p(x_1|x_2)=cal(N)_(d_1)(x_1;mu_1+B(x_2-mu_2),S)$],
    )),
  ),
  key-points: [The factor identified by division is already normalized in $x_1$. This establishes the complete conditional density for every observed value $x_2$.],
)

== The observation can shift the conditional mean
#content-block(
  object: stack(
    spacing: sp("l"),
    [From the proved conditional density:],
    math-rows(gap: 1em, [$m(x_2)=mu_1+B(x_2-mu_2), quad Sigma_(1|2)=S$]),
    step(2, math-rows(
      gap: 1em,
      [$m(x_2+Delta)-m(x_2)=B Delta$],
      [$S=Sigma_11-Sigma_12 H^(-1)Sigma_21$],
    )),
  ),
  key-points: stack(
    spacing: sp("m"),
    [The mean can change with $x_2$ through $B$; $S$ does not depend on the observed value.],
    [The residual $r=x_1-m(x_2)$ uses the observation. Its quadratic being separate does not make the original $X_1$ and $X_2$ independent.],
    [The result is exact for the supplied joint Gaussian with $Sigma succ 0$; it does not test that model against data.],
  ),
)
