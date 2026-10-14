# L01 — bounded squared-loss addition

**Status and authority:** provisional experimental repair, revision 2 (2026-10-14). The instructor explicitly requested adding the derivation slides to the live lecture and subsequently rejected both the original production and the after-candidates' design alignment. The accepted mathematical depth remains intact; this revision clarifies the paired teaching sequence in response to those failures. It does not approve a replacement design or production deck. This contract covers that insertion only; the full reconciled Lecture Scope and the rest of the deck's design stages remain unfinished. Organization revision under the slide-level-organization skill; downstream design and authoring are delegated separately. No full Section Design or Lecture Scope approval is implied.

**Existing section:** Linear Gaussian systems. Insert after “Inference often combines conditioning and summarizing” and before “Sensor fusion combines measurements according to their uncertainty”. Keep the existing retrospective section summary. This is an internal proof, not a new section or a recording.

**Actual entry and endpoint:** the preceding slide establishes the conditional Gaussian $p(z\mid y)$, its mean summary $\hat z=E[z\mid y]=\mu_{z\mid y}$, and the distinction between that summary and the whole posterior. Mean/covariance and expectations are available; squared-loss risk and the optimality of that summary are not established by that slide. Introduce the criterion for choosing an action, then prove why the conditional mean is the optimal point estimate under squared Euclidean loss, while the conditional distribution still carries uncertainty. Finite conditional second moments suffice; Gaussianity supplies the mean/covariance already computed.

| Order | Slide title | Teaching move |
|---|---|---|
| 1 | A point estimate needs a loss function | Connect the preceding mean summary to the problem of choosing a reconstruction action. Define squared loss and conditional risk, introduce the shared abbreviations once, and center the pointwise error at the conditional mean. End with the complete pointwise expansion, without averaging or claiming optimality. |
| 2 | The conditional mean minimizes squared-error risk | Carry the actual pointwise expansion forward. Take conditional expectation as new reasoning, evaluate the centered cross-term and residual energy, derive the intact risk identity, and use its nonnegative squared-distance term to establish the unique optimum and minimum risk. Relate this result to the already identified Gaussian mean. |

**Slide 1 intention and carry-forward constraint:** a summary extracted from a posterior is not yet a justified choice of action. Let $z\in\mathbb R^d$ be the unknown vector and $a\in\mathbb R^d$ an arbitrary reconstruction after observing $y$. Introduce $L(a,z)=\|z-a\|^2$ and $R(a\mid y)=E[L(a,z)\mid y]$; make the connection between this criterion and the action explicit. At fixed observed $y$, $a$ is fixed and uncertainty remains in $z$. State the finite conditional second-moment condition before it is used.

Use the deck's notation $z,y$. Introduce $m=E[z\mid y]$, $V=\operatorname{Cov}[z\mid y]$, and $r=z-m$ once on this slide. Explicitly identify the already established Gaussian correspondence $m=\mu_{z\mid y}$ and $V=\Sigma_{z\mid y}$ there; the definitions of $m,V$ are general conditional moments, not a Gaussian assumption. Do not defer this correspondence until students have already needed it on the following slide. Establish the pointwise decomposition

$$
z-a=r+(m-a),\qquad
\|z-a\|^2=\|r\|^2+2r^T(m-a)+\|m-a\|^2.
$$

The criterion interpretation belongs with the loss/risk definitions; the centering move prepares the three terms for conditional averaging. Make both relationships recoverable rather than making an interpretation of the criterion appear to be a consequence of the centered algebra. Do not cancel the cross-term or prove the minimizer here.

**Slide 2 intention and dependency constraint:** recall consists only of the definitions, conditions and pointwise expansion actually established on slide 1. Applying conditional expectation to that expansion is the first new proof operation, not recall:

$$
R(a\mid y)=E[\|r\|^2\mid y]+2E[r^T(m-a)\mid y]+\|m-a\|^2.
$$

Show why $E[r\mid y]=E[z\mid y]-m=0$ and why the fixed-$y$ action permits
$E[r^T(m-a)\mid y]=E[r\mid y]^T(m-a)=0$. Evaluate the other moment as
$E[\|r\|^2\mid y]=\sum_{j=1}^d E[r_j^2\mid y]=\sum_{j=1}^d V_{jj}=\operatorname{tr}V$.
These are new evaluations of the terms in the averaged expansion. Their relationship to that expansion must remain readable. Substitute them to obtain the load-bearing, intact identity

$$
R(a\mid y)=E[\|z-a\|^2\mid y]=\operatorname{tr}V+\|m-a\|^2.
$$

The squared distance is nonnegative and vanishes only at $a=m$, so the unique minimizer is $a^*(y)=m$ and the minimum risk is $\operatorname{tr}V$. Connect each conclusion to the term that establishes it: covariance trace is the remaining model expected squared error; displacement from the mean adds squared distance. Return to the preceding slide's Gaussian mean summary using the correspondence already established on slide 1. The proof uses finite conditional second moments, not Gaussianity. Identify the criterion as conditional expected loss under the model. No universal optimality for other losses or automatic real-data guarantee follows.

**Extent and constraints:** two slides, approximately 2–4 live minutes (unmeasured). The possibility of later reduction or relocation does not remove this time from the live budget. No additional loss catalogue, experiment, notebook revision or quadratic-separation proof. The scalar L2-loss result is Murphy Book 1 §5.1.5.1; the vector decomposition is a course elaboration.

**Implementation handoff:** exact student-visible mathematics, semantic grouping, hierarchy and cumulative reveal states belong to `squared_loss_slide_design.typ`; authoring lowers those slides into the current deck. The design must distinguish genuine carry-forward from new reasoning and make each new operation and its conclusion legible. Keep necessary earlier context available, preserve the intact risk identity, and avoid replacing competing headings with an undifferentiated equation sequence. These are teaching relationships, not a finished layout or reveal geometry. Routine layout choices are within the explicit insertion request. Consequential changes to depth, allocation or section endpoint return to the instructor.

**Open issues and validation:** no title, order, slide-count, notation, proof-depth or section-boundary change is proposed. The replacement design remains provisional. Review the actual pair after the preceding slide, every reveal and both final states for established-before-use notation, honest recall provenance, action status, mathematical/conclusion relationships and readable proof hierarchy. Retain the existing retrospective section summary. The 2–4 minute allocation remains an unmeasured estimate; check it after the coherent paired repair rather than silently reducing proof depth.
