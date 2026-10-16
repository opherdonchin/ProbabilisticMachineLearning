# Gaussian conditional mean: provisional organization

Status: isolated exploratory revision/build, builder convergence after complete render inspection; independent review and instructor acceptance pending. This replaces only the teaching move of actual L01 slide48; unchanged actual47 and49 provide its entry and subsequent use. It is an interior cluster, not a new section. Existing retrospective section closure remains intact.

## Ordered teaching move

1. **Conditioning shifts the mean by an observed deviation**

   **Intention / goal:** Derive the conditional mean by constructing a centered residual whose cross-covariance with the observed block vanishes. Students must see why joint Gaussianity converts this vanishing cross-covariance into independence, and why independence makes the conditional residual mean zero. The result is the prior mean plus the observed deviation transformed by cross-covariance and observed covariance.

   **Design note:** Preserve one continuous argument through residual construction, zero covariance, the Gaussian independence warrant, and conditional expectation. Retain the defining residual and coefficient where their subsequent uses require them; do not make the independence step a disconnected slogan. The resulting mean must remain recognizable for unchanged49, which writes the residual as x1−μ1|2. The inspected proof-led hierarchy candidate retains the argument and distinguishes the mean result from its warrants. This is the current provisional choice; the result/proof and vertical-proof alternatives remain comparative evidence. A second slide is not presently justified by complete render evidence.

## Contract and explicit assumptions

The accepted live residual route is retained at derive depth. Let B=Σ12Σ22⁻¹ and r=X1−μ1−B(X2−μ2). E[r]=0 and Cov(r,X2)=Σ12−BΣ22=0. Affine Gaussian closure gives joint Gaussianity of (r,X2), so r is independent of X2; hence E[r|X2]=0 and E[X1|X2]=μ1+B(X2−μ2). No covariance-to-independence implication for arbitrary distributions is taught. Joint positive definite covariance is the existing ordinary-density regime, not a new projected theorem. Design owns which established context, routine algebra and qualifications need projection.

Actual47 carries the joint/block notation and affine-rule marginal argument; actual49 reuses independence to derive residual covariance. The present slide must leave that independence and the residual identity available. No covariance derivation or new example is added here. Conditional density may serve subordinate context; covariance is treated on49.

## Upstream change requests

None presently. One slide is a provisional organization choice, not an instructor lock or a timing guarantee. Any substantial live-time change or reduction of depth returns to the coordinator.
