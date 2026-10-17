#import "../../../../design.typ": *

// Autonomous experimental baseline: not approved, not the canonical recording.
// Formula rows are independent display equations with explicit generous gaps.
#let rows(..xs) = stack(spacing: 1.1em, ..xs.pos())
#let unit(title, move, objects, points, stages, constraints: [], layout: none) = slide-design(
  title: title, section: [L01-R01 experiment], teaching-move: move,
  cards: objects, key-points: (key-points(points, label: "kp"),),
  layout: if layout == none { layout-stack(items: objects.map(o => o.label), key-points: "kp", dominant: objects.last().label) } else { layout },
  reveal: if stages.len() == 1 { reveal-static(stages.first()) } else { reveal-cumulative(initial: stages.first(), then: stages.slice(1).map(labels => reveal-step(labels, purpose: [Add the named mathematical operation or consequence; preserve preceding dependencies.], emphasize: false))) },
  constraints: constraints,
)

#section-design-notes(
  title: [Gaussian conditioning by block elimination — autonomous experimental baseline],
  purpose: [Derive the normalized conditional Gaussian density directly from the joint density.],
  entry: [Live lecture: partitioned Gaussians; Gaussian density; affine covariance rule; conditional mean and residual covariance via Gaussian independence; Bayes/density ratio; elementary invertible matrices, determinants and positive quadratics. Positive-definite notation is explicitly explained here.],
  endpoint: [$ p(x_1|x_2)=cal(N)(x_1|mu_1+Sigma_12 Sigma_22^(-1)(x_2-mu_2),Sigma_11-Sigma_12 Sigma_22^(-1)Sigma_21) $ with justified inverses, positive covariances and full normalized density factorization.],
  arc: [Density query → row/column elimination → positivity and inverse → separated quadratic → determinant and normalizer → normalized factors → marginal and conditional → diagnostic case.],
  anchors: [Keep the original block notation, the coefficient $B$, residual $r$, and covariance $S$ used live. Introduce $T$ only to perform repeated elimination and $u$ only to shorten the repeated observed deviation. $Q$ and $C$ name the displayed density parts. Keep $Sigma_22$ unaliased.],
  summary-brief: [Recording override: no section heading or summary slides. End by deriving independence in the zero cross-covariance case.],
  continuity: [Title then orientation. No new computational method or notebook content. Actual live proof uses local operation labels and matched expressions; this candidate follows that contract.],
  constraints: [One continuous recording. Experimental slide boundaries are autonomous choices authorized for this first pass. No consultation pause. No approved canonical source changed. Production may adjust geometry, not mathematical content or reveal meaning. Separate formula rows with full-height clearance. No object boxes unless grouping needs them.],
)

#unit([Gaussian conditioning by block elimination], [Identify the linked proof recording.], (
  card([L01-R01 \ A normalized density proof of the Gaussian conditioning formulas], label: "title"),
), [Probabilistic Machine Learning: Advanced Topics], (("title", "kp"),), constraints: [Production title slide; no separate section divider.])

#unit([From a joint Gaussian to a conditional density], [Recall the exact live result and pose its direct density proof.], (
  recall-card(rows(
    [$ m(x_2)=mu_1+Sigma_12 Sigma_22^(-1)(x_2-mu_2) $],
    [$ S=Sigma_11-Sigma_12 Sigma_22^(-1)Sigma_21 $],
  ), label: "lecture", from: [Live: conditioning mean and covariance; independent residual], title: [From the lecture]),
  card(rows(
    [$ p(x_1,x_2)=cal(N)(x|mu,Sigma) $],
    [$ p(x_1|x_2)=cal(N)(x_1|m(x_2),S) $],
    [Establish the second density directly from the first.],
  ), label: "question", title: [To prove here]),
), [The joint covariance is symmetric and positive definite: $v^T Sigma v>0$ for every $v!=0$ (written $Sigma succ 0$). Blocks $x_i,mu_i in RR^(d_i)$; $d=d_1+d_2$.], (("lecture", "question", "kp"),),
  layout: layout-stack(items: ("lecture", "question"), key-points: "kp", dominant: "question"),
  constraints: [Negotiated geometry: stack From the lecture above To prove here, both simultaneously visible. Two narrow columns made the exact m/S formulas too small. Keep formulas on separate generously spaced display rows. Conditional equation is the explicit target, not a premise for this proof. No proof-step roadmap.])

#unit([The joint density has a quadratic and a normalizing factor], [Identify the actual density expressions whose factorization establishes the target.], (
  card(rows(
    [$ x=mat(x_1;x_2), quad mu=mat(mu_1;mu_2), quad Sigma=mat(Sigma_11,Sigma_12;Sigma_21,Sigma_22) $],
    [$ p(x_1,x_2)=frac(exp[-frac(1,2)(x-mu)^T Sigma^(-1)(x-mu)],(2pi)^(d/2)sqrt(det Sigma)) $],
  ), label: "density"),
  card(rows(
    [$ Q=(x-mu)^T Sigma^(-1)(x-mu), quad C=frac(1,(2pi)^(d/2)sqrt(det Sigma)) $],
    [$ p(x_1,x_2)=C exp(-Q/2) $],
  ), label: "parts"),
), [$Q$ controls the exponential; $C$ is the factor that makes the density integrate to one. A conditional density requires both parts, with their correct constants.], (("density",), ("parts", "kp")),
  constraints: [State 1 full density is dominant. State 2 keeps it visible, names its parts underneath. No unproved product decomposition. Source: Murphy §2.3.1.5 Eq2.94; full coefficient restored.])

#unit([The observed covariance block is invertible], [License the observed-block inverse before choosing an elimination coefficient.], (
  recall-card([$ Sigma=Sigma^T succ 0 $], label: "premise", from: [Orientation]),
  card(rows(
    [$ z in RR^(d_2), quad z!=0, quad mat(0;z)!=0 $],
    [$ z^T Sigma_22 z=mat(0;z)^T Sigma mat(0;z)>0 $],
  ), label: "test", title: [Test positive definiteness on the observed coordinates]),
  card([$ Sigma_22=Sigma_22^T succ 0 quad => quad Sigma_22^(-1) " exists" $], label: "conclusion"),
), [Positive definiteness of the joint covariance also holds on the observed coordinate subspace.], (("premise", "test"), ("conclusion", "kp")),
  constraints: [The nonzero-vector condition belongs beside the test, not in a footer. No set-difference notation.])

#unit([Choose the row subtraction to cancel the cross block], [Derive the subtraction coefficient from the specific matrix entry it must cancel.], (
  card(rows(
    [$ T=mat(I,-B;0,I), quad T Sigma=mat(Sigma_11-B Sigma_21,Sigma_12-B Sigma_22;Sigma_21,Sigma_22) $],
  ), label: "product", title: [First block row minus B times the second]),
  card(rows(
    [$ Sigma_12-B Sigma_22=0 $],
    [$ B=Sigma_12 Sigma_22^(-1) $],
  ), label: "choose", title: [Make the upper-right block zero]),
  card([$ T Sigma=mat(Sigma_11-B Sigma_21,0;Sigma_21,Sigma_22) $], label: "result"),
), [A block diagonal covariance has a block diagonal inverse. In those transformed coordinates, the quadratic separates into two block contributions.], (("product", "kp"), ("choose",), ("result",)),
  constraints: [B is initially an unknown d1×d2 coefficient; the visible cancellation determines it. The inverse was justified on slide4. At state2 use restrained matching accent on the source upper-right entry and cancellation equality together; this is persistent token-level correspondence, not transient entry emphasis on the whole object. No peer boxes around each equation.])

#unit([The matching column subtraction leaves a block diagonal matrix], [Complete the covariance elimination and name the remaining first block.], (
  card(rows(
    [$ T Sigma T^T=mat(Sigma_11-B Sigma_21,0;Sigma_21,Sigma_22)mat(I,0;-B^T,I) $],
    [$ Sigma_22 B^T=Sigma_21 $],
  ), label: "product", title: [First block column minus the second times Bᵀ]),
  card([$ T Sigma T^T=mat(Sigma_11-B Sigma_21,0;underbrace(Sigma_21-Sigma_22 B^T,=0),Sigma_22)=mat(S,0;0,Sigma_22) $], label: "diagonal"),
  card([$ S=Sigma_11-Sigma_12 Sigma_22^(-1)Sigma_21 $], label: "definition"),
), [The remaining first block is the Schur complement of $Sigma_22$ in $Sigma$, the same residual covariance obtained in the live lecture.], (("product",), ("diagonal", "definition", "kp")),
  constraints: [Negotiated regrouping after measured overflow: use the actual connected matrix product instead of a separate repeated recall box. Source lower-left entry and cancellation are simultaneous in state2. Retain the congruence as the anchor for later slides. Generous formula clearance is unchanged.])

#unit([The remaining covariance block is positive definite], [Show the strict positivity needed for the residual Gaussian factor.], (
  recall-card([$ T Sigma T^T=mat(S,0;0,Sigma_22), quad T=mat(I,-B;0,I) $], label: "anchor", from: [Previous slide]),
  card(rows(
    [$ a in RR^(d_1), quad a!=0, quad T^T mat(a;0)=mat(a;-B^T a)!=0 $],
    [$ a^T S a=mat(a;0)^T T Sigma T^T mat(a;0)=mat(a;-B^T a)^T Sigma mat(a;-B^T a)>0 $],
  ), label: "positive", title: [Apply the joint positive quadratic to this nonzero vector]),
  card([$ S=S^T succ 0 quad => quad S^(-1) " exists", quad det S>0 $], label: "licensed"),
), [The residual covariance is a valid nondegenerate Gaussian covariance. Both covariance blocks now have inverses and positive determinants.], (("anchor", "positive"), ("licensed", "kp")),
  constraints: [The long positive equality is load bearing; permit two aligned lines at the middle equality if necessary, preserving the entire relation. Do not replace it by generic words about congruence.])

#unit([The same subtraction produces the centered residual], [Connect the elimination matrix to actual Gaussian coordinates and verify reversibility.], (
  card(rows(
    [$ u=x_2-mu_2, quad r=x_1-mu_1-B u=x_1-m(x_2) $],
    [$ T(x-mu)=mat(I,-B;0,I)mat(x_1-mu_1;u)=mat(r;u) $],
  ), label: "coordinates"),
  card(rows(
    [$ T^(-1)=mat(I,B;0,I), quad T^(-1)mat(r;u)=mat(r+B u;u)=x-mu $],
    [$ T T^(-1)=mat(I,B-B;0,I)=I=T^(-1)T $],
  ), label: "undo", title: [Add the subtracted observed contribution back]),
), [The residual and observed deviation together retain all the original information. $u$ is fixed when conditioning; $r$ is the remaining centered variation.], (("coordinates",), ("undo", "kp")),
  constraints: [The inverse matrix is verified, not assumed. u shortens repeated observed deviations; r, B and m match live meaning. Use formula rows with tall-matrix clearance.])

#unit([The eliminated covariance gives the inverse in the density], [Explain why eliminating covariance helps with a density containing its inverse.], (
  recall-card([$ T Sigma T^T=mat(S,0;0,Sigma_22) $], label: "anchor", from: [Slide6; T invertible and both diagonal blocks positive definite]),
  card([$ (T^T)^(-1) Sigma^(-1) T^(-1)=mat(S^(-1),0;0,Sigma_22^(-1)) $], label: "invert", title: [Invert both sides; reverse the order of factors]),
  card([$ Sigma^(-1)=T^T mat(S^(-1),0;0,Sigma_22^(-1))T $], label: "recover", title: [Multiply on the left by Tᵀ and on the right by T]),
), [This is the inverse covariance that appears in $Q$. It lets the subtraction act directly on the centered data vector.], (("anchor", "invert"), ("recover", "kp")),
  constraints: [Exact factor order must remain explicit. No new D or inverse-transpose abbreviation. Do not expand all four blocks: the factorized inverse is the form immediately used.])

#unit([Use the eliminated inverse in the quadratic], [Apply the recovered inverse to the precise quadratic from the joint density.], (
  recall-card(rows(
    [$ Q=(x-mu)^T Sigma^(-1)(x-mu) $],
    [$ Sigma^(-1)=T^T mat(S^(-1),0;0,Sigma_22^(-1))T $],
  ), label: "inputs", from: [Density parts and previous slide]),
  card([$ Q=[T(x-mu)]^T mat(S^(-1),0;0,Sigma_22^(-1))[T(x-mu)] $], label: "substitute", title: [Substitute the inverse; (Tv)ᵀ=vᵀTᵀ]),
), [The outer factors $T$ act on the centered vector. The middle matrix is block diagonal.], (("inputs",), ("substitute", "kp")),
  constraints: [First half of a reasoning split after the original combined slide exceeded available height by54pt. Preserve normal formula clearance; do not shrink the inverse or quadratic. Exact inverse identity and affected Q stay together.])

#unit([Block diagonal multiplication separates the quadratic], [Insert the residual coordinates and explicitly multiply the diagonal quadratic.], (
  recall-card(rows(
    [$ Q=[T(x-mu)]^T mat(S^(-1),0;0,Sigma_22^(-1))[T(x-mu)] $],
    [$ T(x-mu)=mat(r;u), quad r=x_1-m(x_2), quad u=x_2-mu_2 $],
  ), label: "inputs", from: [Previous slide and residual coordinates]),
  card(rows(
    [$ Q=mat(r;u)^T mat(S^(-1),0;0,Sigma_22^(-1))mat(r;u) $],
    [$ =underbrace(r^T S^(-1)r,"residual")+underbrace(u^T Sigma_22^(-1)u,"observed deviation") $],
  ), label: "separate", title: [Insert the coordinates and multiply the diagonal blocks]),
), [For fixed $x_2$, the second term is constant in $x_1$. The first depends on $x_1$ through its deviation from $m(x_2)$.], (("inputs",), ("separate", "kp")),
  constraints: [Second half of the negotiated reasoning split. Inputs subordinate, main multiplication dominant. Match coordinate blocks to resulting terms using alignment or restrained color. No independence claim; this is not yet a normalized density identity.])

#unit([The same elimination also splits the determinant], [Use the determinant of the same transformation, not an unexplained block-determinant lemma.], (
  recall-card([$ T Sigma T^T=mat(S,0;0,Sigma_22), quad T=mat(I,-B;0,I) $], label: "anchor", from: [Elimination]),
  card(rows(
    [$ det T=det I_(d_1) det I_(d_2)=1 $],
    [$ det(T Sigma T^T)=det T dot det Sigma dot det T^T=det Sigma $],
  ), label: "preserve", title: [T is triangular; determinants multiply]),
  card([$ det Sigma=det S dot det Sigma_22 $], label: "split", title: [The block diagonal determinant is the product of its blocks]),
), [The elimination preserves the determinant and exposes exactly the two covariance determinants needed for Gaussian normalization.], (("anchor", "preserve"), ("split", "kp")),
  constraints: [The coefficient C from slide3 is the reason for this calculation. Keep all determinant factors in one equality, with the values1 visually grouped or underbraced only where helpful.])

#unit([Dimensions and determinants split the normalizing factor], [Show the exact coefficient of each Gaussian factor.], (
  recall-card([$ C=(2pi)^(-d/2)(det Sigma)^(-1/2), quad d=d_1+d_2 $], label: "coefficient", from: [Slide3 and block dimensions]),
  card([$ C=(2pi)^(-(d_1+d_2)/2)(det S dot det Sigma_22)^(-1/2) $], label: "insert", title: [Insert det Σ = det S det Σ22]),
  card([$ C=underbrace(frac(1,(2pi)^(d_1/2)sqrt(det S)),"residual factor") dot underbrace(frac(1,(2pi)^(d_2/2)sqrt(det Sigma_22)),"observed factor") $], label: "factors", title: [Split powers and positive square roots]),
), [The coefficients have the dimensions and covariance determinants of the two Gaussian densities. Positivity licenses the positive square roots.], (("coefficient", "insert"), ("factors", "kp")),
  constraints: [Show the actual coefficient transformation rather than a statement that constants work out. Generous spacing around underbraces.])

#unit([Both parts combine into normalized Gaussian factors], [Combine the two proved identities in the joint density and recognize the Gaussian forms.], (
  recall-card([$ Q=r^T S^(-1)r+u^T Sigma_22^(-1)u, quad u=x_2-mu_2, quad r=x_1-m(x_2) $], label: "quadratic", from: [Slide11]),
  card(rows(
    [$ p(x_1,x_2)=frac(exp[-frac(1,2)r^T S^(-1)r],(2pi)^(d_1/2)sqrt(det S)) dot frac(exp[-frac(1,2)u^T Sigma_22^(-1)u],(2pi)^(d_2/2)sqrt(det Sigma_22)) $],
  ), label: "explicit", title: [Substitute the separated quadratic and coefficient in C exp(−Q/2)]),
  card([$ p(x_1,x_2)=cal(N)(x_1|m(x_2),S) cal(N)(x_2|mu_2,Sigma_22) $], label: "identify", title: [Read the mean and covariance in each factor]),
), [For each fixed $x_2$, the first factor is a normalized density in $x_1$. Its mean still depends on the observation.], (("quadratic", "explicit"), ("identify", "kp")),
  constraints: [The full equality remains whole. If too wide, split at multiplication with an aligned continuation, not into disconnected peer boxes. Show each factor paired with its Gaussian identification. Covariance S and Σ22 are positive definite by slides4/7. Do not yet label the factors p(x1|x2) and p(x2); establish that on the next slides.])

#unit([Integrating out the residual identifies the marginal], [Use normalization in the integration variable, without circularly assuming the conditional formula.], (
  recall-card([$ p(x_1,x_2)=cal(N)(x_1|m(x_2),S) cal(N)(x_2|mu_2,Sigma_22) $], label: "joint", from: [Previous slide]),
  card([$ p(x_2)=integral_(RR^(d_1)) p(x_1,x_2) dif x_1=cal(N)(x_2|mu_2,Sigma_22) underbrace(integral_(RR^(d_1)) cal(N)(x_1|m(x_2),S) dif x_1,=1) $], label: "integrate", title: [Hold x₂ fixed and integrate in x₁]),
  card([$ p(x_2)=cal(N)(x_2|mu_2,Sigma_22)>0 $], label: "marginal"),
), [The factor that depends only on the observation is exactly its marginal density. Its strict positivity makes the density ratio available at every $x_2$.], (("joint", "integrate"), ("marginal", "kp")),
  constraints: [The normalization integral is new reasoning, not a recall. If needed use a two-line aligned integral equality; the integral1 stays adjacent to the factor it removes.])

#unit([Dividing by the marginal gives the conditional Gaussian], [Apply the density ratio and state the derived parameters.], (
  card([$ p(x_1|x_2)=frac(p(x_1,x_2),p(x_2))=frac(cal(N)(x_1|m(x_2),S) cal(N)(x_2|mu_2,Sigma_22),cal(N)(x_2|mu_2,Sigma_22))=cal(N)(x_1|m(x_2),S) $], label: "ratio", title: [Cancel the positive observed-block density]),
  card(rows(
    [$ m(x_2)=mu_1+Sigma_12 Sigma_22^(-1)(x_2-mu_2) $],
    [$ S=Sigma_11-Sigma_12 Sigma_22^(-1)Sigma_21 $],
  ), label: "parameters"),
), [The observed deviation shifts the conditional mean. The conditional covariance is the residual covariance and does not depend on the observed value.], (("ratio",), ("parameters", "kp")),
  constraints: [Ratio may use two aligned lines, retaining numerator and denominator together so the actual cancelled factor is visible. This is the achieved target, not a proof roadmap or summary slide.])

#unit([Zero cross-covariance removes the observation], [Use the derived conditional law to check a diagnostic case and derive independence.], (
  card(rows(
    [$ Sigma_12=0 quad => quad B=0, quad m(x_2)=mu_1, quad S=Sigma_11 $],
    [$ p(x_1|x_2)=cal(N)(x_1|mu_1,Sigma_11)=p(x_1) $],
  ), label: "check", title: [Set the cross-covariance to zero in the proved formula]),
  card([$ p(x_1,x_2)=p(x_1)p(x_2) quad => quad X_1 perp X_2 $], label: "independence"),
), [For a joint Gaussian, zero cross-covariance makes observations of one block uninformative about the other.], (("check",), ("independence", "kp")),
  constraints: [The marginal equality p(x1)=N(x1|μ1,Σ11) was proved live. Independence is derived here from the normalized conditional law; it was not assumed in the recorded proof. End on this mathematical conclusion; no added recap.])
