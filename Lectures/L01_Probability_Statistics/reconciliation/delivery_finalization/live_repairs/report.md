# Independent L01 technical-repair recheck

**Result: PASS for the bounded technical repairs.** F01–F05 and advisoriesA01/A02 are resolved in the repaired artifacts. No new mathematical, domain, context, reveal or fit defect was found in the eight affected slides. This is technical validation; it does not approve the whole Lecture Scope, recording contract, publication or teaching time. Micro-label advisoryA03 remains deferred by the coordinator/instructor.

The reviewer did not author these repairs. All recheck writes are restricted to `/tmp/l01-live-delivery-audit/repair_recheck/`; canonical source/artifacts were read and copied only. The original frozen audit record remains intact.

## Exact input versions

- `repaired_slide_deck.typ`: SHA-256 `be9df1cfeb21dbd86d2c459ad31667f553d966bdb6b4d72b96b675a0e0c13dd5`, 87418 bytes.
- `repaired_handout.pdf`: SHA-256 `fc6a97b5dbcbb15027a29b62a996ab722d99678caacccfa7824da1ac0d8aeb13`, 3677689 bytes.
- `repaired_presentation.pdf`: SHA-256 `ae056c522d45cfe099fb92bc0c02e08ce7eaaa3b8469172e7574f3693a87b4cc`, 4244496 bytes.
- `production_report.json`: SHA-256 `4495aa45fb6c45aa86757d5c6088fdd6ea83fa94220444c9914f254deb08a320`, 2691 bytes.

The copied production report records zero warnings and70 handout pages/164 presentation states. This recheck independently ran the math-attachment checker on the copied repaired source: no possible run-on attachments found. The source diff was read and preserved as `source.diff`; it changes only the eight allowed slides. Independent recompilation is not claimed; the coordinator's production build owns that gate.

## Complete comparison and bounded visual coverage

All70 new handout pages and164 new presentation states were rendered with the same Poppler `-scale-to 1200 -png` command as the frozen baseline and compared pixel by pixel against it. The differences are **exactly eight handout pages and19 presentation states**, all inside the23-state repair allowlist. The four scoped states6,18,119,120 are pixel-identical because they precede the changed wording. This is expected, not a coverage omission.

- Changed handout pages: `4,8,25,33,37,41,51,56`.
- Changed presentation states: `7,8,19,62,63,64,65,66,79,83,84,85,94,95,96,97,121,129,130`.
- Reviewed affected states (all23): `6–8,18–19,62–66,79,83–85,94–97,119–121,129–130`.
- All70 handout/final-state pairs are pixel-identical.
- Accepted loss pages64–66 / states151–156 remain pixel-identical to the approved frozen baseline. The larger contextual range p62–68 / s145–162 is also unchanged.

All23 affected presentation states and eight final handouts were visually inspected in eight four-tile sheets with source images1200×675 pixels. Full-size additional checks inspected p37 and s65,s79,s97. The restored p41 proof has all three covariance equalities, with correct matrix grouping and no clipping. Added text, Action-arrow labels and the longer p37/p51 key points fit without collision or cut-off. All234 new individual render images, extracted texts and exact pixel-comparison results remain in this folder.

| Handout page | Title | Reviewed presentation states |
| --- | --- | --- |
| 4 | Models are built out of distributions | 6, 7, 8 |
| 8 | The posterior is a distribution representing uncertainty | 18, 19 |
| 25 | Task taxonomy | 62, 63, 64, 65, 66 |
| 33 | Learning problems become probabilistic queries | 79 |
| 37 | Gaussians: a concrete example | 83, 84, 85 |
| 41 | Affine maps carry Gaussian means and covariances | 94, 95, 96, 97 |
| 51 | One observed coordinate can change both the estimate and its uncertainty | 119, 120, 121 |
| 56 | A linear Gaussian system is a model of state and measurement | 129, 130 |

## Mathematical and production dispositions

- **F01: resolved.** s95 shows centered vector; s96 reveals Cov[y]=E[(Ad)(Ad)^T]=A E[dd^T] A^T; s97 adds AΣA^T, with full result in handout. All four states legible, no lost derivation, correct grouping.
- **F02: resolved.** p37 states σ²>0 and explicitly limits density/inverse formulas to Σ≻0. p56 states Σ_z≻0, Ω≻0. These suffice for the later ordinary inverses and nondegenerate joint/conditional densities. Affine moment identities are unchanged and do not require invertible A.
- **F03: resolved.** Both Action rows now show a_t~π_D(·|x_t) and (x_t,a_t)→(x_(t+1),r_(t+1)) labelled environment. The sampled action is no longer applied as a function. All rows fit; preceding reveal geometry remains coherent.
- **F04: resolved.** Final state explicitly compares conditioning with the marginal; conditional N(1.2,.36) and marginal N(0,1) remain correct and visible. Question and first answer states unchanged.
- **F05: resolved.** p4 now qualifies independent Bernoulli tosses/Binomial count by Given θ. This supplies the correct conditional law and independence assumption used in the conjugate likelihood.
- **A01: resolved.** Posterior narrowing is now explicitly restricted to this displayed example.
- **A02: resolved.** The p41 key point explicitly states preservation of Gaussianity under the displayed affine map; mean/covariance rules then supply the parameters. No new proof is implied.
- **A03: deferred by coordinator/instructor.** Prior micro-label advisory remains separate; no redesign or new blocker is introduced.

The nondegeneracy clarification does not claim that every affine image has nonsingular covariance: p37 specifically qualifies the density/inverse formulas, while p41 retains the unrestricted moment identities. WithΣ_z≻0 andΩ≻0, the LGS joint is nondegenerate and WΣ_zWᵀ+Ω is invertible for any compatible W. The restored proof is Cov[y]=E[(Ad)(Ad)ᵀ]=A E[ddᵀ]Aᵀ=AΣAᵀ; its validity is unchanged by its reveal repair.

The Action repair distinguishes the sampled action from the environment transition without introducing a deterministic dynamics equality. The checkpoint now names conditioning as the source of the mean/variance change. The coin count is explicitly conditional onθ, and posterior narrowing is restricted to the depicted example. These are technical corrections within the existing sequence, not pedagogical scope changes.

## Evidence inventory

- `result.json`: structured outcome, allowlist, actual differences, accepted-loss invariance and finding dispositions.
- `coverage.json`: every affected handout/state and review status.
- `baseline_pixel_comparison.json`: all70+164 exact baseline comparisons and changed bounding boxes.
- `handout_final_state_comparison.json`: all70 handout/final-state comparisons.
- `manifest.json`: exact repaired source/PDF/report hashes; `source.diff`: complete repaired-source delta.
- Copies of repaired source and PDFs; all234 individual PNGs; `affected_sheet_01.jpg` through `affected_sheet_08.jpg`; full extracted handout/presentation text.

No remaining technical issue was identified in the bounded recheck. Scope acceptance, the separate recording and actual instructor/learner timing remain under their owning records and decisions.
