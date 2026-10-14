# L01 — slide-skill investigation and experiment

**Instructor request:** investigate the process before repairing slides 64–65 or redeveloping the deck. Mathematical/visual objects should usually be light on text, with necessary explanation in key points. This document is the coordinator's reading route and experimental record; the linked reports preserve raw review evidence.

**Status:** slide-64 calibration passed; first frozen-skill slide-65 transfer needs revision. Comparative composition passed, but exact mathematical typesetting and designated key-point lowering did not. A second refinement and development repair follow; slide 65 is no longer an untouched validation case. The actual deck/PDF, scope commitments, notebooks and recording remain unchanged. Experimental outputs are not instructor-approved slides.

## What happened

The design chose text-heavy objects and treated new expectation calculations as recall. Authoring then flattened typed key points into the object, despite existing role-preservation instructions. The generic design grid permitted that flattening but did not require it. Feasibility tested constructibility; final review accepted unclipped, readable output without testing its role division against neighboring slides. The coordinator conflated those outcomes with alignment. The later critical reviewer was given suspected defects, so its agreement was not blind discovery.

The instructor's light-on-text preference was weakly stated in the old conventions; role preservation and backpressure were already explicit. The failure therefore includes both an insufficiently concrete generative contract and failure to apply existing requirements. No evidence establishes model choice, reasoning effort or an inherently inadequate two-slide extent as its cause. The earlier and new residuals are the same construction under renamed variables; a substantive notation collision was not demonstrated.

Read the [raw process audit](slide_skill_process_audit.md) for artifact lines, historical prompt excerpts, causal qualifications and experimental risks. Those line references target the `4b69e7e` baseline.

## Change being tested

The course convention now explicitly assigns mathematical objects and explanatory key points distinct roles, while permitting intrinsic labels, necessary mathematical conditions and text that is itself an inspected object. There is no word budget or permission to omit mathematics. Slide Design derives that role contract from actual established renders before layout and distinguishes new proof from genuine recall. Slide Authoring preserves roles even when a generic grid mixes labels and returns conflicting placement as backpressure. Coordination separates feasibility, fidelity, alignment and mechanical validity and records whether a review was separate, blind or seeded.

No shared design/production API, model profile or lecture mathematics changed. The existing stack/side key-point slots and `content-block` API suffice for this test. A structural API extension remains a hypothesis, not an implemented repair.

## Fixed test and exposure controls

Slide 64 is calibration; slide 65 is transfer validation after skill versions are frozen. The generating agents receive the functional mathematics, current skills and selected course neighbors, without the known defect catalogue, a corrected composition, prior trial outputs or builder defense. Slide-65 agents do not receive the corrected slide-64 design or render; their prior mathematical knowledge is provided explicitly. This tests transfer of the role convention, not statistical independence from the lecture's prerequisites.

Observed criteria, fixed before revised trials: coherent mathematical object; explanation in a distinct key-point region except justified intrinsic annotations; faithful typed-role lowering; genuinely established recall; complete equations/assumptions; legible final and reveal states; comparative continuity with supplied proof/neighbor renders. Successful compile or a count of inspected images does not establish those criteria.

## Evidence so far

| Trial | Actual result and limitation |
|---|---|
| Unchanged-skill slide-64 replay | Fresh designer produced sentence-length framing and explanatory headings inside objects; fresh author accepted them without backpressure. Full norm expansion was explicitly clarified during the trial. Designer accidentally saw a tail of the old slide-65 source; this is a limited-exposure replay, not a fully blind controlled baseline. |
| Fresh review of original pages 64–65 | Reviewer received standards and neighbors, without expected defects or old reviews. Independently requested presentation changes while preserving the mathematics; handout-only evidence. [Raw report](slide_skill_review_control.md). |
| Revised authoring skill on the same replay design | Fresh author reviewer raised role-placement backpressure without a supplied fault list, while finding the mathematics/API feasible. It did not build or certify production. [Raw report](slide_skill_authoring_boundary_review.md). |
| Revised-skill slide-64 calibration | Fresh designer and fresh author preserved mathematical objects, genuine recall and a distinct key-point region. One handout/three reveals compiled with zero warnings; author/coordinator inspected all four states. A further fresh reviewer found it ready against the fixed criteria. Minor advisory: the key-point rule is visible before its text. [Raw comparative report](slide_skill_calibration_review.md). |
| Frozen-skill slide-65 transfer | Fresh designer/author produced a lighter object, separate interpretation and coherent four-state proof, with zero compilation warnings. Fresh review nevertheless returned revision-needed: `E[||...` parsed as a double-bracket shorthand rather than expectation plus norm, three design-only transpose attachments changed exponent grouping, and interpretation bypassed its designated semantic component despite rendering correctly. [Raw review](slide_skill_transfer_review.md). This is not a successful full validation. |

## Exact versions

| Input | Before SHA-256 | First refinement SHA-256 |
|---|---|---|
| Slide Design skill | `fe6d991d02811212c11a90fec501fae1ae608264823da7b88bcf3de5cd8cdc31` | `e26604d81995042ac4200e7d9987757e79e0719e837c9208f30be763f3083223` |
| Slide Authoring skill | `c6bd5c33367cc24f268d2adcad9d65f92d2e3349abc895344c2f45ef63aaf921` | `fad4293e3d4204f012eddb8fb2adb98e72af067f704cc13ed077c60c489abe88` |
| Lecture Development skill | `2bdfb9ef12e95f33d49095b06860031046808e7ec0687e0f3f7e86be457f5737` | `1ed3a7e5167b270663463e7c36027954d23904ee5e09a21aabdbd3adddae81fe` |
| Slide Design conventions | `de8f64d104e366b23c502421cea61369f0829360b246c710fda9977ecee3ecdb` | `1bb2a41252f9439e908f428c6eede960c5062e9734d105b72da57516a65137a9` |

Before files are recoverable at `4b69e7e`. `quick_validate.py` passed all three refined skills' structural checks; this validates frontmatter/scaffolding, not instructional behavior.

Replay design SHA-256 `5114e433af67cc1995f020299530ea903ab3e950283a191f4e53dbe2683917d1`; replay authored source `d3fca44c59dc91056fedb770486a66ae94d8d3b4e3a2fa5a81bc9c06b0d69d86`. Calibration design SHA-256 `5ccf01bbbbbd95dfb586b7de960477659b932de5e7570ce172fcc44eab5cec0f`; authored source `b5cb1af08b2a5d98861b0c03b705df634e14f67d934f7cb7e95a4f353e2e2716`. First transfer design `86e79f7451d46fd37bee973eece7fcc4725e1e4acbcbfc7e8595d280b46eaa8a`, authored source `58af0d8ac6c5f7294ec4c3a9767ec17272457e0c9e92ead8f47019a94ad5f6c5`.

Scratch trials currently live below untracked `tmp/l01-skill-test/`; renders/manifests are below ignored `build/slide-review/`. They will be preserved in Git evidence before being removed from the current source tree, with local review copies under ignored `build/`. These are experiment outputs, not additional current lecture sources.

The revised-author boundary test used feasibility-review mode, whereas the baseline author built the candidate. That difference limits attribution of changed behavior to skill wording alone. The baseline source exposure and later norm-expansion clarification also prevent a strict controlled before/after claim. The refined skills and unseeded comparative procedure are tested together; small trial counts do not establish course-wide reliability. If the held-out slide fails, its later repair must be recorded as development, not relabeled an untouched successful validation.
