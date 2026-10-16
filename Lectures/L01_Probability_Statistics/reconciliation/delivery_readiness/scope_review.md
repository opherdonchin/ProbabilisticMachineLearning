**Verdict: feasible-with-risks.** Source-level confidence is high; student competence and classroom timing remain unvalidated. Checked `main@8889ac0`, deck blob `34f8b21d2e6720002a22b95570d41227e019d33c`, scope blob `2de058d9110d1b76cdf7c2143bb5373d20de6d65`. No repository files changed.

**Recommended instructor decision:** preserve the developed route and add one brief checkpoint within the existing bivariate example, funded by shortening a repeated taxonomy recap. This is an advisory Scope-owned outcome/emphasis choice; implementation belongs downstream. It does not block independent production or runtime checks.

**L01-JOINT-QUERY: strongest case for unchanged material**

The content is already present and cumulative:

- **“A probabilistic perspective,” p20**, source839–875: supplied class likelihood and prior become \(p(y=c\mid x,\theta)\), followed by the MAP class decision. Earlier empirical-risk slides separately show fitting \(\theta\) (759–798).
- **“Learning problems become probabilistic queries,” p33**, 1444–1487: available variables, requested query and future-case performance are explicit.
- **“The three operations in multivariate Gaussian systems,” p38**, 1624–1683: one joint supports expectation, marginalization and conditioning, with visual comparisons.
- **“A linear Gaussian system is a model of state and measurement,” p56**, 2283–2318: explicitly provides the joint factorization and says \(\mu_z,\Sigma_z,W,b,\Omega\) are given.
- **“One linear Gaussian system supports different questions,” p57**, 2325–2378: explicitly connects hidden-state uncertainty, an estimate and pre-observation measurement prediction to conditioning, expectation and marginalization.
- **“Inference often combines conditioning and summarizing,” p63**, 2689–2719, and **“The same model can also predict measurements,” p67**, 2870–2913, carry those distinctions into actual formulas.

An unchanged deck can therefore support a competent spoken explanation. There is no evidence justifying a new survey or substantial reordering.

**Why a small strengthening is preferable**

The live source supplies those translations to students. It does not contain a learner-facing checkpoint requiring them to produce the complete task → variables/joint → query → operation translation. The numerical bivariate example, **“One observed coordinate can change both the estimate and its uncertainty,” p51**, 2128–2147, reveals the calculation rather than eliciting that choice.

Consequently, the defensible concern is **insufficient evidence of student application**, not missing explanation or demonstrated student failure. Historical persona reviews are simulated readings, not classroom outcomes.

**Concrete reviewable checkpoint proposal**

Reuse the existing course numerical example:

> Two standardized measurements have supplied joint distribution  
> \[
> (X_1,X_2)\sim\mathcal N\!\left(0,
> \begin{bmatrix}1&0.8\\0.8&1\end{bmatrix}\right).
> \]
> For one case, \(X_2=1.5\) is recorded and \(X_1\) is missing. Identify what is fixed, observed and unknown. Write the distribution needed to report uncertainty about \(X_1\), and name the operation that gives it. How does the query change when \(X_2\) has not been observed? Are we estimating \(\mu\) or \(\Sigma\) here?

Expected answers:

\[
p(X_1\mid X_2=1.5)=\mathcal N(1.2,0.36)
\]

by conditioning, versus \(p(X_1)=\mathcal N(0,1)\) by marginalization. Parameters are supplied; \(X_1\) is the unknown variable. No parameter fitting occurs. This practices identifying and applying the correct query within a given model; it does **not** establish competence at selecting Gaussian assumptions for a new application.

**Exact funding passage:** shorten the second verbal walkthrough of the four Task/Performance cells on p33, source1458–1479. They repeat p25 **“Task taxonomy,”** 1051–1077; the source itself labels the p33 grid a recap (1448–1449). Retain p33’s distinct keypoints1485–1487 and preserve **Experience taxonomy** and experience/task combinations. A **2–3-minute allowance is provisional**, not measured recoverable time.

**L01-GAUSSIAN-TIME**

Current source inventory is **69 handout pages: one title, seven dividers and 61 content slides**:

| Current sequence | Content slides |
|---|---:|
| Familiar modeling language | 7 |
| Statistics → ML problems | 12 |
| Experience/task classes | 4 |
| Datasets → learning problems, including operations summary | 7 |
| Gaussian geometry | 8 |
| Gaussian marginals/conditionals | 9 |
| LGS, loss derivation and final anchors | 14 |

Thus 30 content slides precede Gaussian geometry, and 31 follow including the final anchors. Counts await the Authoring specialist’s emitted-output verification.

The timing calibration’s **70 pages/eight dividers** is stale. Its instructor judgment that L01 looked approximately right is useful qualitative evidence; the **60–80 slides in three hours** experience cannot certify this deck’s **two-hour lecture plus one-hour notebook** arrangement.

The old coverage specification’s 55–65 plus 55–65 minutes gives a 110–130-minute range, establishing crowding risk rather than observed overrun. It also promises an estimation bridge absent from the actual deck; it must not determine the rehearsal sequence. Scope101 explicitly records no measured delivery time.

**Practical rehearsal route:** run the actual presentation states aloud with normal derivations, pauses and the proposed checkpoint; record elapsed times at existing section boundaries and separately for the residual argument, live squared-loss proof, scalar update and sensor fusion. Include discussion allowance and verify that uncertainty interpretation and forward marginalization are explained before the notebook handoff. An instructor rehearsal is rehearsal evidence; an agent read-through is only an estimate. Compress repeated framing only if the timed evidence warrants it.

Preserve settled live proof depths, the separate full block-elimination recording, and accepted setup-page2/decision-page7 preferences. Neither assessment warrants moving additional live mathematics to recording.
