# L01 — bounded squared-loss addition

**Status and authority:** the instructor explicitly requested adding the derivation slides to the live lecture on 2026-10-14. This contract covers that insertion only; the full reconciled Lecture Scope and the rest of the deck's design stages remain unfinished. Coordinator-authored organization under the slide-level-organization skill; downstream design and authoring are delegated separately.

**Existing section:** Linear Gaussian systems. Insert after “Inference often combines conditioning and summarizing” and before “Sensor fusion combines measurements according to their uncertainty”. Keep the existing retrospective section summary. This is an internal proof, not a new section or a recording.

**Entry and endpoint:** students have a conditional distribution, its mean/covariance, expectations and a loss criterion. Establish why its mean is the optimal point estimate under squared Euclidean loss, while the conditional distribution still carries uncertainty. Finite second moments suffice; Gaussianity supplies the mean/covariance already computed.

| Order | Slide title | Teaching move |
|---|---|---|
| 1 | A point estimate needs a loss function | Define the action and conditional squared-error risk. Center the unknown at its conditional mean and expand the loss. |
| 2 | The conditional mean minimizes squared-error risk | Take conditional expectations, eliminate the centered cross-term, identify the covariance trace and minimize the remaining squared distance. Connect the result to the Gaussian posterior. |

Use the deck's notation $z,y$, with $m=E[z\mid y]$, $V=\operatorname{Cov}[z\mid y]$, and $r=z-m$. The unknown vector is $z\in\mathbb R^d$ and any estimate $a\in\mathbb R^d$ is admissible. At fixed observed $y$, the action $a$ is fixed. Show

$$
R(a\mid y)=E[\|z-a\|^2\mid y]=\operatorname{tr}V+\|m-a\|^2.
$$

The minimizer is $a^*(y)=m$ and the minimum risk is $\operatorname{tr}V$. Identify this as conditional expected loss under the model. No universal optimality for other losses or automatic real-data guarantee follows.

**Extent and constraints:** two slides, approximately 2–4 live minutes (unmeasured). The possibility of later reduction or relocation does not remove this time from the live budget. No additional loss catalogue, experiment, notebook revision or quadratic-separation proof. The scalar L2-loss result is Murphy Book 1 §5.1.5.1; the vector decomposition is a course elaboration.

**Implementation handoff:** exact student-visible mathematics and cumulative reveals belong to `squared_loss_slide_design.typ`; authoring lowers those slides into the current deck. Routine layout choices are within the explicit insertion request. Consequential changes to depth, allocation or section endpoint return to the instructor.
