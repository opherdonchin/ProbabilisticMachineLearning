#import "../../../Lectures/design.typ": *

// Activate the design-document defaults; imported set rules do not propagate.
#set page(paper: "a4", margin: (x: 12mm, y: 8mm))
#set text(size: 8.8pt)
#set par(leading: 0.52em)

#section-design-notes(
  title: [Affine transfer — isolated one-slide contract],
  purpose: [Establish how a fixed affine map transports a vector's mean and covariance.],
  entry: [Mean, centered covariance, linearity of expectation, matrix multiplication and transposition are available. Gaussian affine closure is already stated; it is used, not proved.],
  endpoint: [Students can justify $E[A x+b]=A mu+b$ and $"Cov"[A x+b]=A Sigma A^T$, and distinguish translation of a Gaussian cloud from its linear transformation.],
  arc: [Fix the map and finite-second-moment assumptions; compute the mean; center the transformed vector; carry the two deterministic matrix factors through expectation; interpret the result.],
  anchors: [Use $x,mu,Sigma$ for the input and $y,mu_y,Sigma_y$ for the output. The centered outer product is the algebraic anchor. A separate proof object receives attention as new reasoning.],
  summary-brief: [Nominate the transformed moments as a retrospective anchor. This bounded insertion contains no section-summary slide; it does not replace or extend the surrounding section closure.],
  continuity: [The supplied proof precedent (page 48) places inspected mathematics beside a new proof and reserves a lower region for interpretation. Pages 62, 63 and 66 likewise keep conclusions separate from equations or schemas. Preserve that role division.],
  constraints: [One slide; retain the assigned title and derivation. No extra example or parameter-fitting method. No rank or invertibility restriction on $A$; the Gaussian output may be degenerate. The contract is the target-content source; source-book attribution is not asserted.],
)

#slide-design(
  title: [Affine maps carry Gaussian means and covariances],
  section: [Isolated affine-transfer design],
  teaching-move: [Derive both transformed moments from expectation and centered covariance, then interpret them for an initially Gaussian vector using the already stated affine-closure rule.],
  cards: (
    card(
      label: "affine-setting",
      [
        $ x in RR^d, quad y=A x+b in RR^m $
        $ A in RR^(m times d), quad b in RR^m quad ("deterministic") $
        $ E[x]=mu, quad "Cov"[x]=Sigma $
        $ E[sum_(i=1)^d x_i^2] < infinity $
      ],
    ),
    bordered-card(
      label: "affine-proof",
      title: [Moment proof],
      [
        $ mu_y = E[y] = A E[x]+b = A mu+b $

        $ y-mu_y = A x+b-(A mu+b) = A(x-mu) $

        $ Sigma_y &= E[(y-mu_y)(y-mu_y)^T] \
          &= E[A(x-mu)(x-mu)^T A^T] \
          &= A E[(x-mu)(x-mu)^T] A^T \
          &= A Sigma A^T $
      ],
    ),
  ),
  key-points: (
    key-points(
      label: "affine-interpretation",
      [
        - Translation shifts the Gaussian cloud's mean without changing its covariance.
        - $A$ linearly maps its center and spread; affine closure keeps the transformed cloud Gaussian.
      ],
    ),
  ),
  layout: layout-side(
    left: "affine-setting",
    right: "affine-proof",
    key-points: "affine-interpretation",
    dominant: "affine-proof",
  ),
  reveal: design-reveal([
    *Cumulative; every earlier subpart persists.*
    1. Show affine-setting and the complete mean line of affine-proof.
    2. Add the centered-vector identity; transiently emphasize this new identity.
    3. Add the whole four-line covariance calculation; transiently emphasize this new calculation. Earlier lines return to normal appearance.
    4. Add affine-interpretation below both objects, without extra emphasis. Preserve the complete final state in the handout.

    Object-level reveals cannot express these intra-object states. Slide Authoring owns their faithful lowering.
  ]),
  summary-candidates: (
    summary-visual-candidate(
      "affine-proof",
      reason: [Reuse the two established moment results, retaining their deterministic-map assumption.],
    ),
    summary-key-point-candidate(
      [Translation changes the mean but leaves covariance unchanged.],
      from: "affine-interpretation",
      reason: [Retrospective distinction between shift and linear map.],
    ),
  ),
  rationale: [The setting contains intrinsic dimensions and integrability. Every proof equality is new reasoning. Separate key points interpret the Gaussian cloud. Finite second moments suffice for the moment identities; Gaussian closure supplies the distribution-family conclusion. Transpose applies to the entire centered vector. Production readability remains a downstream check.],
)
