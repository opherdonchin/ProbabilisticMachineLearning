# L01 — bounded squared-loss organization

**Status:** O4/D2 proposed isolated candidate, 2026-10-14. Fresh separate review completed: feasible-with-risks, with no material mathematical or design-fidelity issue and advisory cumulative-density/pacing concerns. Instructor acceptance pending. The instructor accepts the full vector proof live, but has rejected the existing insertion's design. This organization records the selected coupled candidate, not promotion to the live lecture. The live slide source/PDF still contain the rejected old insertion. Baseline `0967e4fc20fd4f93a58692bbc0c74f5917fbf18b` preserves the prior organization in Git. Final disposition belongs to the forthcoming [coupled test record](slide_coupled_test.md).

**Boundary and entry:** an internal cluster in Linear Gaussian systems, after actual page63, “Inference often combines conditioning and summarizing”, and before actual page66, “Sensor fusion combines measurements according to their uncertainty”. Page63 establishes the conditional Gaussian and mean summary, but neither a loss criterion nor optimality. Conditional expectations, mean/covariance, the Gaussian conditioning result (page48), Gaussian Bayes (page59), and scalar application (page61) are available. Preserve the existing retrospective section summary. The separate quadratic-separation recording is unchanged.

## Selected organization

1. **A point estimate needs a loss function.** Supply the criterion for choosing a reconstruction from the posterior: choose an unrestricted action $a$ to minimize conditional expected squared error $R(a\mid y)$, without yet identifying the optimum. At fixed observed $y$, introduce the action, squared loss, conditional risk, moments and centered residual; end with the complete pointwise squared expansion. Distinguish the random residual $r=z-m$ from fixed displacement $m-a$. This is pointwise algebra, without averaging or claiming optimality.
2. **The conditional mean uniquely minimizes squared-error risk.** Take conditional expectation of the actual expansion as new reasoning, evaluate the centered cross-term and residual energy, and assemble the intact risk identity. Use nonnegativity and its equality case to establish the unique optimum and minimum risk, then return to the previously computed Gaussian mean. The proof licenses the decision; the covariance trace describes remaining model expected squared error.

## Mathematical and teaching constraints

At a fixed observed $y$, assume $E[\|z\|^2\mid y]<\infty$. The unknown is $z\in\mathbb R^d$; the unrestricted chosen reconstruction $a\in\mathbb R^d$ is fixed at this observation. Define

$$
L(a,z)=\|z-a\|^2,\qquad R(a\mid y)=E[L(a,z)\mid y].
$$

Introduce $m=E[z\mid y]$, $V=\operatorname{Cov}[z\mid y]$, and $r=z-m$ before reuse. Identify the already established Gaussian correspondence $m=\mu_{z\mid y}$, $V=\Sigma_{z\mid y}$ immediately, while preserving the general meaning of the moments. Establish

$$
z-a=r+(m-a),\qquad
\|z-a\|^2=\|r\|^2+2r^T(m-a)+\|m-a\|^2.
$$

On the second slide, averaging is new work rather than recall:

$$
R(a\mid y)=E[\|r\|^2\mid y]+2E[r^T(m-a)\mid y]+\|m-a\|^2.
$$

Show the local licenses for evaluation:

$$
E[r\mid y]=E[z\mid y]-m=0,\qquad
E[r^T(m-a)\mid y]=E[r\mid y]^T(m-a)=0,
$$

where fixed $m-a$ permits factorization, and

$$
V=E[rr^T\mid y],\qquad
E[\|r\|^2\mid y]=\sum_{j=1}^d E[r_j^2\mid y]
=\sum_{j=1}^d V_{jj}=\operatorname{tr}V.
$$

The intact load-bearing identity is

$$
R(a\mid y)=\operatorname{tr}V+\|m-a\|^2.
$$

Since the squared distance is nonnegative, with equality only when $a=m$, establish the unique $a^*(y)=m$ and $\min_{a\in\mathbb R^d}R(a\mid y)=\operatorname{tr}V$. Apply the earlier Gaussian correspondence to recover $a^*(y)=\hat z=\mu_{z\mid y}$ and minimum risk $\operatorname{tr}\Sigma_{z\mid y}$. Finite conditional second moments suffice without Gaussianity. This is conditional model expected loss, not an empirical performance guarantee. The scalar result is recorded from Murphy Book1 §5.1.5.1; the vector decomposition is a course elaboration.

## Design direction and extent

The first slide's criterion/action state precedes the new centering definitions and immediate Gaussian mapping; the final beat is the pointwise expansion. Task framing belongs with the criterion interpretation, while intrinsic fixed-y action status remains available to license averaging. The selected second-slide realization retains the established pointwise premise, visibly introduces averaging, and keeps local moment proofs adjacent to the intact identity and subsequent choice. Proof supports remain inspectable while conclusions appear. Exact student-visible groups/reveals belong to Design and geometry to Authoring.

The two-slide choice follows comparison of complete actual adjacent proof/result and three-slide prototypes. It is provisional and may reopen on new evidence. Current first/second slides have three/five presentation states. The prior2–4 minute estimate remains unmeasured; no substantive teaching-time, depth, live/recorded boundary or section endpoint change has been enacted. Prototype fit and guided builder agreement do not establish classroom pacing or instructor acceptance.

**Current candidate alignment:** reviewed scratch Design SHA-256 `f9c373733c6a181684e1dffadffe9473282407fe0c81a930e9f5a73c7e7b539d`; reviewed full scratch source SHA-256 `74d34ddba30899feb971e229270276e43ee559b9699c3ccfff231aacba159131`. The standalone four-slide candidate package `squared_loss_candidate.typ` includes the unchanged neighbors and the same two candidate bodies; it is separate from the live deck. Raw offers, corrections and observed evidence are retained in the coordinator's coupled test record and the scratch Organization report. Fresh separate review is complete with the feasible-with-risks assessment above; instructor acceptance remains pending. Current owning artifact versions and final disposition belong to the coupled test record. No upstream change is proposed.
