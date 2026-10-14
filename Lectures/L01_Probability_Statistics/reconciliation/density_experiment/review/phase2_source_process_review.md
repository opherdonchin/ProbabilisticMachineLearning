# Phase 2 — source, contract, and process review

**Recommendation: revise the patch narrowly, then adopt its core responsibilities provisionally.** The experiment supports mathematical selection, explicit density assessment, and owner-led negotiation. It does not establish a generally reliable workflow. Two wording/reporting clarifications would help: distinguish an abbreviated reference proof from a broken projected inference, and explicitly distinguish selected slide outputs from the complete emitted artifact and its warnings. No change to Organization's existing authority contract is needed.

This recommendation does not promote instructions or candidates. The instructor owns that decision. The frozen Phase 1 report remains unchanged; its judgments are not rewritten to agree with builder convergence.

## Evidence and versions

Baseline: `a804af6`; frozen four-file patch: `61acb41`; current candidates: `06f4560`; Phase 1 freeze: `4b9b277`. I read the instructor request, task, input/output manifests, six builder reports, two current organizations, all current design and production sources, the four affected instruction/convention files, unchanged Organization authority, relevant course API, and relevant scope/deck context. I checked the primary source passages and the complete-versus-selected PDF inventories, warnings, and wrapper pages. The optional exposure record contains exact current hashes and additional visual evidence.

Every input hash listed in the manifest, including both books, matches. All six candidate source hashes, report source hashes, and supplied selected PDF hashes match `outputs_manifest.json`. Canonical complete outputs and the supplied selected PDFs are separate artifacts; differing PDF hashes do not imply different mathematics. I did not modify source, specifications, prototypes, instructions, production, scope, or Phase 1.

Neutral mapping: 01 is original actual63–66; 02 is the previous separate squared-loss candidate; 03/04/05 are A2-side/A2-vertical/B3; 06 is original actual47–49; 07/08/09 are independence-result-proof/proof-led/proof-led-hierarchy.

## Mathematical selection, provenance, and accepted depth

### Squared-error argument

The accepted commitment is a short **live derivation** of the vector posterior-mean reconstruction under conditional expected squared Euclidean loss, followed by interpretation of remaining uncertainty. The instructor reopened alignment and process, not this mathematical depth. The two original pages were an implementation, not a permanent count commitment. The scope's 2–4-minute allowance is provisional and unmeasured.

The current design retains the loss/risk definitions, unrestricted vector action, conditional mean and centered residual, pointwise three-term expansion, conditional averaging with a fixed-offset reason, zero centered mean, canceled cross-term, component energy-to-trace calculation, intact risk decomposition, nonnegativity with equality exactly at the mean, optimal action, minimum risk, and Gaussian specialization. Every selected inferential object appears in the current renders. None of the successful capacity claims depends on missing agreed mathematics.

The mathematical condition is finite conditional second moment: `E[||z||² | y] < ∞`. Then `R(a | y) = tr V + ||m − a||²`, and the unique minimizer over the displayed unconstrained action space is `a = m`. Positive covariance is not an additional optimization hypothesis; V is the conditional covariance. The proof is not specific to Gaussianity, but without finite moments a claim about this finite-risk decomposition would fail. Model expected loss is correctly distinguished from empirical future-case performance.

The projection omissions are defensible for the actual setting. Actual63 visibly supplies a conditional Gaussian, so its finite moments are available. Earlier covariance material supplies centered second moments and diagonal variances. Conditional expectation and vector algebra are audience prerequisites. The omitted separate full averaged-expansion line is reconstructable from the retained pointwise premise, averaging cue, two displayed evaluations, and intact destination equation. Omitting the intermediate sum of diagonal covariance entries does not hide a new conceptual step. Deferring V until its use reduces new notation without changing the argument.

This validates the selected explanation in context, not unrestricted use of the displayed theorem for arbitrary posteriors. If the argument is later reused outside this Gaussian setting, Design must reassess whether the finite-moment condition becomes decision-relevant projection. A condition recorded only in instructor-facing scope is not evidence that students have previously seen it.

Verified source: Murphy, *Probabilistic Machine Learning: An Introduction*, online edition **April 18, 2025**, §5.1.5 “Regression problems” and §5.1.5.1 “L2 loss,” printed p.176 / PDF p.206, Eqs.5.32–5.34. The source defines scalar squared loss, expands its conditional risk, and obtains the mean by differentiation; the preceding paragraph describes elementwise extension to vectors. The vector centering/covariance-trace proof is a course elaboration. Current design metadata preserves that provenance; the new loss target production slides omit the old source note but do not falsely attribute this vector proof to Murphy. Whether a concise visible source note should return is a Design choice, not a missing agreed mathematical object.

An additional source/role improvement is real: original actual65 puts newly averaged moments inside a `recall-card`, although actual64 only defined the residual and expanded the pointwise error. The new candidates recall the genuinely established pointwise expansion and treat averaging/moments as new proof work. This is more faithful epistemic grouping, beyond merely using less text.

### Gaussian conditional mean

The accepted live route constructs `B = Σ12 Σ22⁻¹` and `r = x1 − μ1 − B(x2 − μ2)`, verifies zero mean and cross-covariance, uses **joint Gaussianity** to infer independence, and takes conditional expectation to obtain the mean. All three current alternatives retain that complete chain. Gaussian marginals alone would not license the independence inference. Routine covariance bilinearity and inverse cancellation can reasonably remain implicit; the local affine-closure and Gaussian-independence warrants remain explicit.

Verified source: Murphy, *Probabilistic Machine Learning: Advanced Topics*, online edition **December 10, 2025**, §2.3.1.3 “Marginals and conditionals of an MVN,” printed p.24 / PDF p.58, Eqs.2.75–2.79. Eq.2.78 agrees with the candidate mean and following covariance formula. Its cited proof route, §2.3.1.5 “Derivation: moment form,” printed pp.25–27 / PDF pp.59–61, uses block inverse/exponent factorization. The candidates' “course residual proof” wording accurately identifies their alternate organization of the argument.

The scope explicitly sets the ordinary-density regime `Σ ≻ 0`; this implies the needed principal-block inverses. The actual prior deck uses Gaussian density and Mahalanobis inverses, and establishes block notation and affine moments; it does not explicitly project a positive-definiteness statement. Thus invertibility is a conventional, checked regime assumption rather than a demonstrated prior theorem on screen. That is acceptable for this graduate proof sketch, but the metadata should not equate scope checking with previous student exposure.

Removing the conditional-density header and the pre-proof alias `r = x1 − μ1|2` preserves the mean derivation. The final equation identifies μ1|2, so the alias needed by actual49 is recoverable. Subsequent section material assembles the conditional Gaussian law. The target retains independence for that next use; it does not silently switch the endpoint to a linear predictor justified only by zero covariance.

## Independent render judgment versus convergence

| Candidate | Builders' current position | Frozen Phase 1 assessment and implication |
| --- | --- | --- |
| A2-side / 03 | Preferred loss realization; support beside result avoids a second orientation. | Sound and more concise than the previous candidate, but several right-column conclusions compete. Not my strongest two-slide hierarchy. |
| A2-vertical / 04 | Viable comparator; centered claim levels less distinct. | Clearest two-slide dependency structure: two evaluated ingredients feed the central risk and decision. Same mathematics; a legitimate hierarchy preference difference. |
| B3 / 05 | Viable lower-load alternative with recall/transition cost; estimated extra minute. | Clearest separation of derivation and minimization. The final slide performs a real decision/uncertainty job. Extra time remains an estimate and requires instructor judgment. |
| Independence result-proof / 07 | Sparse result column beside dense proof; repeated target. | Strongest anchored result-and-proof arrangement. Repetition also provides orientation; it is not automatically waste. |
| Independence proof-led / 08 | Direct path, insufficiently distinguished endpoint. | Agreement: complete mathematics, but the result is another similarly weighted row. |
| Independence hierarchy / 09 | Preferred one-slide proof-led realization. | Strongest centered alternative; meaningful endpoint separation. Against 07, target-first versus derivation-first is still a teaching choice. |

The blind review confirms completeness and detects purposeful hierarchy improvements, while disagreeing with some preferences. Neither disagreement nor builder unanimity establishes that one organization is universally best. The two/three-slide loss comparison changes simultaneous demands without reducing the proof; the two A2 layouts isolate geometry while holding content and boundaries fixed. No two-slide Gaussian candidate was built, so it cannot be claimed experimentally inferior.

## Complete artifacts, warnings, and verification failures

| Current realization | Selected handout / presentation pages | Complete emitted handout / presentation pages | Recorded status |
| --- | --- | --- | --- |
| A2-side | 4 / 12 | 4 / 12 | Mechanical pass, no warnings |
| A2-vertical | 4 / 12 | 4 / 12 | Mechanical pass, no warnings |
| B3 | 5 / 12 | 5 / 12 | Mechanical pass, no warnings |
| Each Gaussian alternative | 3 / 12 | 6 / 15 | Review warnings: empty wrapper page 2 |

I inspected the extra title, blank, and section-divider pages at full resolution. Their three-page wrapper is pixel-identical across all three Gaussian alternatives. The empty page is real, with only header/rule/footer, and is correctly acknowledged by Authoring as unresolved. Selected PDFs legitimately exclude front matter, but their good target states do not certify the full standalone artifacts. The warning strings include a misleading `unknown font family` prefix and terminal backspaces; the substantive message is Touying's empty-content warning, not evidence of a named missing font. Current JSON correctly leaves independent `visual_review` pending.

The Git checkpoints substantiate execution problems that were then corrected. I directly inspected the first vertical handout at `5748947`: literal `align(center)` text and colliding takeaway lines accompany its recorded 408.35pt content versus 373.56pt capacity. I inspected the B3 decision states at `f73c76f`: retained placement/grouping changes and malformed presentation mathematics are visible. These incomplete or malformed states are not evidence that the intended mathematics could never fit. The current B3 static final decision is owner-accepted and complete.

Some builder observations remain observations rather than my independently reproduced facts. The B3 old-title handout inspected at `cd1d755` fits its title; it does not itself substantiate the clipping described for a later iteration. Likewise, I did not identify right-edge clipping in Phase 1's selected completed previous-candidate image; its density, rather than clipping, grounds my negative comparison. Exact source/state binding matters even for a seemingly straightforward defect claim.

Repeated literal-code, omitted interpretation, and reveal-geometry errors are **implementation/verification failures**, not mathematical selection defects. The patch already requires complete selected content, actual states, and final-state-first work. More generic prose repeating those requirements would not by itself repair poor execution. The useful response is exact all-state fidelity checking before treating a prototype as capacity evidence. The reports document those owner-led corrections rather than silently restoring qualifications or weakening depth.

## Negotiation and instruction evidence

There is substantive negotiation, not just an exchange of favorable verdicts. Design conditioned omission of the full averaged expansion on a visible premise, averaging operation, and both evaluated moments; Organization accepted that condition. Authoring returned genuinely different spatial and count alternatives. Design replaced a third accumulated interpretation with an evolving takeaway while retaining the moment proof. Organization owned the shorter B3 title. Design and Organization accepted the static final B3 after unstable attempts, explicitly trading a separate Gaussian entry cue for simultaneous comparison. No instructor-required click count was invented.

In the Gaussian case, evidence from A/B prompted a concrete C counteroffer: shorter heading, grouped warrants, distinct larger endpoint, unchanged essential mathematics. Authoring corrected Design's mistaken `fs("m")` suggestion using the actual API: m=0.78em, l=0.84em, xl=0.90em. The implemented result is larger than proof support, rather than shrinking the proof. Design updated its reveal contract to match accepted initial centering. That is a successful division between semantic intent and production calibration.

These events are consistent with the frozen patch's intended behavior: selection belongs to Design; geometry and render evidence belong to Authoring; boundaries/titles/count belong to Organization; actual scope and depth survive. They do not establish that the patch caused the outcome. The unchanged Organization skill already allowed count/boundary negotiation, and the old system already required mathematical and render checking. Fresh teams, coordinator attention, repeated repair, task specificity, and different content are uncontrolled contributors.

## Confirmed neighboring issues, kept outside the bounded targets

Actual47/49 source contains nested proof algebra that does not appear in their emitted states. The repeated 036/041 bodies are therefore not just optional teaching pauses: source/render concordance fails for those old proof objects. In particular, actual49 omits the conditional-residual covariance equality and its covariance calculation despite the accepted live covariance derivation. This is **missing implementation**, not Design's intentional selection under the patch. The bounded Gaussian targets still deliver the residual independence needed next; their success does not certify the unchanged neighboring derivation. The production owner should repair and separately revalidate those neighbors.

The sensor-fusion interpretation also needs a separate source/context correction. With independent measurement noises and a scalar proper prior, the posterior mean is a precision-weighted average of the prior mean and both measurements, not necessarily a point between the two measurements. For example, prior `N(100, 0.01)` and unit-noise observations 0 and 2 give mean `10002/102 ≈ 98.06`, outside [0,2]. Equal sensor noise alone is insufficient. Murphy's §2.3.2.3 “Example: Sensor fusion with known measurement noise,” printed p.30 / PDF p.64, supplies block-diagonal measurement covariance but also describes a midpoint example without specifying its prior regime. That example should not be generalized as an unconditional rule. The course scope already identifies prior/noise assumptions as author corrections. None of this is a defect introduced by the loss candidates.

## Narrow revisions and next owners

1. **Instruction owner/coordinator:** clarify “A readable incomplete explanation can be intentional” as reference-proof abbreviation supported by actual context; it must not mean that a student must invent a new inferential warrant. The surrounding patch already expresses this distinction, so one wording change is enough.
2. **Instruction owner/coordinator:** require the completion report to distinguish selected pages/states from complete emitted PDF counts and unresolved warnings. This adds a concrete artifact distinction exposed by the experiment, not a new mathematical checklist or preferred layout.
3. **Authoring owner:** remove the extra Gaussian standalone blank page and recheck both complete modes before claiming full-artifact readiness. This is execution work, not an instructor mathematical decision.
4. **Instructor, through coordinator:** select the loss arrangement/count with its unmeasured time tradeoff and the Gaussian result-first/proof-first preference. My render recommendation is B3 if its extra boundary is acceptable, otherwise A2-vertical; for the Gaussian, 07 and 09 remain defensible alternatives with different orientation benefits.
5. **Production owner, separately:** repair the old neighboring reveal omissions and sensor-fusion qualification before claiming the complete lecture implements its accepted mathematics. Preserve the experimental comparison evidence.

The experiment is a useful local stress test, with visible mathematical and hierarchy improvements and a functioning correction loop. It has **no matched old-skill specialist control, no statistical replication, no delivery timing, and no student validation**. Adoption can be justified by the responsibilities and concrete evidence, but “reliably produces easy-to-follow slides” remains an unmeasured objective. Stop here for instructor review; no promotion or production edit is authorized by this report.
