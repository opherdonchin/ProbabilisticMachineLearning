# Independent check of the readable course proposal

The revised explanations are substantially easier to follow. Each lecture now begins with a problem, describes what students will calculate or fit, and explains the cost of the main alternative. A reader can understand the teaching choice without knowing Murphy's later chapters. The mathematical details remain available for authors who prepare the teaching material.

**Verdict: feasible-with-risks; no demonstrated blocking issue.** This is an independent check by `/root/readability_check`, using Section Design's `feasibility-review` mode. I did not write the scopes or shared course proposal. The date is 2026-10-11. I changed only this report and appended the focused new-model evidence to [L04's review](L04_review.md). I did not produce sections, slides or notebooks, approve the course, commit or publish.

The instructor has accepted the simpler L03 restoration method and selected the lighter L04 example. Those choices do not imply acceptance of the later lectures. This report checks clarity and preservation of the proposal; it does not settle the remaining teaching decisions.

## What the readability check found

The [questions](../questions_and_hesitations.md) now describe the practical teaching choices directly. For instance, the L08 question compares learning hidden die choices with forecasting a continuous quantity, rather than expecting the instructor to choose between unexplained algorithm labels. The L06 question explains why missing-value uncertainty matters for estimating covariance. The L12 question explains the two networks, their shared training task and the limits of interpreting learned coordinates.

The scopes' main explanations give method names after describing their job. Mathematical tables and source allocation remain technical, but are labeled as preparation/checking material. The course overview explains how the lessons connect; the notebook record separates central student calculations from the programs authors must supply. The five shared course records describe the same outcomes. The original independent reports remain identifiable as evidence about earlier versions, with coordinator-written reading guides rather than a claim that those guides are new reviews.

Three small clarifications were requested during this check and inspected after their owners repaired them. L03 explicitly retains the general product-to-energy logarithm calculation. L11 says that the Bayesian alternative is a neural network with a distribution over its weights, avoiding confusion with the directed probability graphs taught earlier. The shared L10 descriptions name the probability of a value greater than zero, rather than vaguely calling it a peak's mass. None changes the taught method, required student task or budget.

This is a reviewer judgment about readability, not a test with the instructor or students. The author-facing tables still require mathematical study. That is acceptable because the primary explanations no longer require their specialist labels to understand the recommendation. Future teaching material must explain these calculations using only the knowledge students have reached at that meeting.

## What stayed the same

Nine scopes preserve the earlier curriculum. L04 alone changes the required example and its learning outcome.

| Lecture | Preserved teaching and notebook commitment |
|---|---|
| L03 | Normalize the four-pixel model, derive the local conditional and noise contribution, justify sequential improvements and exhibit a stopping point that is not globally best. Students complete the local calculation inside a supplied restoration program. The chosen simpler method is now instructor-agreed. |
| L05 | Compare three response families, derive one sign/dispersion-correct gradient, apply the three-class gradient, work one complete backward derivative graph and explain batch updates. The first PyTorch lab still fits all three Iris species and checks a manual derivative. |
| L06 | Derive the lower-bound identity and exact-step likelihood argument; retain conditional covariance in expected second moments and update unknown Gaussian parameters. The single missing-data lab and supplied driver are unchanged. |
| L07 | Derive and normalize the scalar Gaussian posterior shortcut under its conditions, use the fixed eight-observation regression, and check grid spacing and range independently. The supplied solver and query/prediction comparisons are preserved. |
| L08 | Derive forward/backward hidden-state calculations, preserve scaling and the whole-history versus separate-state distinction, and give only the compact Gaussian filter comparison. One NumPy sequence implementation, enumeration checks and the direction-sensitive transition check remain required. |
| L09 | Reuse L06's bound, work the diagonal Gaussian limitation, derive the total sample derivative including direct dependence, and retain the corrected Gaussian discrepancy and observation/prior scaling. One diagonal fit, fixed-noise derivative check and exact references remain the lab. |
| L10 | Independent-average variance, balance versus exploration, the full acceptance correction, brief conditional-coordinate cancellation and question-specific dependent error are preserved. Students implement one sampler; starts, rejected repeats and region checks remain central. |
| L11 | Nonlinear mean/positive standard deviation, full Gaussian loss and derivatives, shared derivative contributions, observation-versus-weight uncertainty and mean-loss prior scaling remain. Students run one small fit against a supplied baseline. |
| L12 | Model versus inference, four-coordinate sampled description, 19-coordinate fixed-variance likelihood, coordinate sums then observation averaging, both networks' derivatives, and the information decomposition are preserved. The one fit, prepared comparisons and expected-reconstruction scoring helper remain unchanged. |

I compared mathematical objects, treatment depth, required examples, timing, optional cuts, software, and student-versus-supplied work against commit `39446b5d0fc520a690ed612f0845203ed8d02498`. For L08–L12, all mathematical table rows are also byte-for-byte unchanged. For L03/L05–L07, the tables were rewritten and consolidated; their actual calculations and depth were checked individually. This is an equivalence check of nine wording revisions, not nine newly claimed full source reviews.

Live estimates remain 112, 110, 115, 112, 110, 112, 112, 110, 112 and 112 minutes for L03–L12, each including 12 reserved for questions/slippage. Every notebook retains 60 minutes. These remain unmeasured estimates. The delivered ledger prefix is unchanged, and no changed file lies under the protected L01/L02 lecture directories or the established L01 missing-data solution.

## L04: the smaller example is correct when its limitation is explicit

The selected encoder sends two message bits and their parity bit. The four possible transmitted strings are `000`, `011`, `101` and `110`. Every pair differs in two positions. Changing exactly one bit therefore produces an invalid string, which detects a problem. It does not identify the changed position. For received `100`, three original messages are equally plausible under the stated noise model.

I inspected the actual reference notebook and Murphy Book 2's extracted §§5.5/Fig. 5.11 discussion, then independently enumerated all four messages and eight received strings with Python standard-library exact fractions. The source encoder, independent flip probability 0.2, uniform prior and received `100` agree with the proposal. The stronger five-bit code is correctly retained only as reference material.

At flip probability 0.2, the three-bit code retains more information per message than uncoded two-bit transmission, but it uses another transmission and gives the same optimal whole-message guessing error in this model. The revised explanation therefore does not claim a guaranteed accuracy improvement. The numerical checking details later in this report match every new numerical commitment in the scope.


The unchanged information derivation, conditional-information proof support, processing proof sketch and sufficient-statistic interpretation still have the same depth. Only the primary code/table and its decoding guarantee change. The revised table has 32 joint entries instead of 128. The 110-minute live envelope and 60-minute lab remain plausible as a preview, with the original concept/array risks. The revised rough extent range, about 19–24 content-slide equivalents, is consistent with the timing-calibration formula but is not evidence of actual teaching duration.

## Remaining risks and who owns them

There is no required mathematical repair left from this check. The difficult lessons still need rehearsal, and the first PyTorch hour and later refreshes need student trials. Authors must provide the promised drivers, plots, numerical references and comparison fits; reading source code does not validate that scaffolding. The lighter L04 example reduces bookkeeping, but information versus accuracy, ties and zero-probability handling still need careful explanation.

The broader choices remain with the instructor: the combined L05 workload, the main L08 application, the amount of controlled versus realistic data, and suitability/access for L12 mobility data. Formula signs, scaling, transition directions and consistent held-out scoring are author/reviewer responsibilities, not questions for instructor approval.

No reference or future course notebook was executed in this review. No student timing, runtime ranking, convergence or Colab pass is established. Coordinator updates to STATUS and the validation record close the document/version bookkeeping; they are not missing curriculum decisions or independent review blockers.

<details>
<summary>Numerical checking details for the changed L04 example</summary>

| Check | Independent result |
|---|---|
| Posterior for received `100`, in message order 00,01,10,11 | `(16,1,16,16)/49` |
| Posterior for received `000` | `(16,1,1,1)/19` |
| Received-string entropy | `2.9660780975952257` bits |
| Received entropy given the message | `2.165784284662087` bits |
| Information per message, by both entropy and joint-probability formulas | `0.8002938129331385` bits |
| Optimal whole-message guessing error | `9/25 = 0.36` |
| Uncoded information/error | `0.5561438102252754` bits/message; the same error `9/25` |
| Information per transmitted bit, coded/uncoded | `0.26676460431104615` / `0.2780719051126377` bits |
| No flips | Information 2 bits; error 0; only four received strings have positive probability |
| Flip probability one half | Information 0; error `3/4`; posterior uniform |

Every channel row, the joint table and the received marginal normalized exactly. Every single flip violated parity. Posterior calculations only used observations with positive marginal probability; impossible observations at zero noise remain explicitly undefined. Ties are genuine and the scope warns against treating a first-index selection as uniqueness. The optional five-bit construction's minimum distance is three; unique one-error correction belongs to that stronger construction.


</details>

## Exact checking inputs and versions

The baseline is commit `39446b5d0fc520a690ed612f0845203ed8d02498`. The following Git blob identifiers distinguish the original proposal from the final readable targets. Small clarity fixes and status wording were checked before this closing snapshot. “Before” and “after” refer to this final target check, not the earlier collaborative editing period.

| Scope path | Original baseline blob | Final target before check | Final target after check |
|---|---|---|---|
| `Lectures/L03_Graphical_Models/lecture_scope.md` | `f4ab82808c1cc6b4b32c38588c6c2e969483b036` | `cccc6f319d5d1046b14efb4078ba55a37e414268` | `cccc6f319d5d1046b14efb4078ba55a37e414268` |
| `Lectures/L04_Information_Theory/lecture_scope.md` | `6b008770631926f61e51d838a126651c2200466e` | `2299ca6e5a0ab901da3fbb8e85cfb5546910f1c4` | `2299ca6e5a0ab901da3fbb8e85cfb5546910f1c4` |
| `Lectures/L05_GLM_Optimization/lecture_scope.md` | `6f7200e2383a2136687fe03cbb8b35b67f76d696` | `84629e7171a371676ac6dbf1e3fabd34de907b95` | `84629e7171a371676ac6dbf1e3fabd34de907b95` |
| `Lectures/L06_EM/lecture_scope.md` | `c29aefd80dbd192a6a4da4b79e5e299df343875a` | `b492462f2f2e9602b6ef917d0f47a52f23f1bdab` | `b492462f2f2e9602b6ef917d0f47a52f23f1bdab` |
| `Lectures/L07_Inference/lecture_scope.md` | `80eacfd8c3e7e3bb4eb00d9bb23ccdb1c2ddcb0a` | `99de6f1ea4292d5006bbe70184a480fe231a1e5a` | `99de6f1ea4292d5006bbe70184a480fe231a1e5a` |
| `Lectures/L08_Structured_Inference/lecture_scope.md` | `4ae9853bf48899edeab65a1c2b503dfad0c1f990` | `1c92cf00a125c33b1142cbd0696a1221a766ea36` | `1c92cf00a125c33b1142cbd0696a1221a766ea36` |
| `Lectures/L09_Variational_Inference/lecture_scope.md` | `7072832dfbf350454d66a0440abea8201bf530e0` | `dd7665143dbbcd5af443e6ca54c1a6a4baa9f3fa` | `dd7665143dbbcd5af443e6ca54c1a6a4baa9f3fa` |
| `Lectures/L10_MCMC/lecture_scope.md` | `55359f7aeeeb5eb838915386ca5222981f8236c5` | `884a24c67187557546c74d0e3935f08fc67edd93` | `884a24c67187557546c74d0e3935f08fc67edd93` |
| `Lectures/L11_Neural_Prediction/lecture_scope.md` | `c9c3298efa4e11a0baedaa6bd06d72aba64ee86d` | `f76ea83091b02831b7c5959e02ebe8f8ab55fc25` | `f76ea83091b02831b7c5959e02ebe8f8ab55fc25` |
| `Lectures/L12_VAE/lecture_scope.md` | `ae38514fa2daf5502c411a3c5528cfa6a2becbdc` | `67fdd3cd474b3bbf1e5ca7e931c169ebef737eeb` | `67fdd3cd474b3bbf1e5ca7e931c169ebef737eeb` |

The independent original L03–L12 review files and the whole-course adversarial review from the baseline survive as contiguous unchanged bytes inside the current files. The new reading guides are separate coordinator text. They do not alter reviewer identities, targets or verdicts and cannot certify the changed L04 model. The new targeted evidence appended to L04 is this reviewer's work.

Other actual inputs are listed below. Shared teaching descriptions were read in full; final status/compilation bookkeeping remains the coordinator's responsibility.

| Input | Git blob read |
|---|---|
| `AGENTS.md` | `618e90cb6dff05e6c9bc409341d1b9d10dac092d` |
| `.agents/skills/section-design/SKILL.md` | `82bed56b005379bf75fda242c27b7289ab6cdb8b` |
| `.agents/skills/shared/backpressure.md` | `dd0163a5fc2ca80b0dcf7db94638ce9868b47888` |
| `syllabus_plan.typ` | `1e141d328d345cf0e03c5aae6753b0ee2f9728bb` |
| `advanced_statistics_2027_1_syllabus.typ` | `118284f52e1b1366eb5a9000049fa4fcb166caac` |
| `Lectures/material_ledger.md` | `8c6e4d1985d8246147e6962ca597f304ca00d64f` |
| `Lectures/notebook_reference_audit.md` | `54355005a1a0268ecd082dbcd890666fbb7717d0` |
| `Lectures/syllabus_planning_decisions.md` | `cbb157866ea7a4140bbf73da5a4496b48611607b` |
| `Lectures/course_architecture_scope/architecture_audit.md` | `bdc5a6da814a2100c8bf214f3999d48aa1b0188d` |
| `Lectures/course_architecture_scope/questions_and_hesitations.md` | `012103cd7347bc075e79655a43f0a63506906f94` |
| `Lectures/course_architecture_scope/source_inspection.md` | `ca8f05f5607c593f9803d32952f72594390e2458` |
| `.agents/skills/lecture-scope/references/timing-calibration.md` | `9ac4b93e408800e985891291a2fa9d836788953a` |

The actual local computational source was `/home/opher/Repositories/pyprobml/notebooks/book2/05/error_correcting_code_demo.ipynb`, SHA-256 `b557bf8b97488541d1f11b88a6b92ad172b0f4d7501de8c92fe00f634ba04cd1`, at the registered pyprobml revision `d1ea4122dcf3c2a2c02eb4e05343203b26440827`. The inspected textbook passage was `/tmp/pml-book2.txt`, printed pp. 251–252, from the registered December 10, 2025 edition. Its prose and notebook supply the parity model; the numerical information/error comparison is independently checked course arithmetic. This inspection did not install or run the notebook's dependencies.

## Independent precision and source check — 2026-10-12

**Verdict: feasible-with-risks; no material mathematical or source blocker found.** This is `/root/precision_review`'s independent, bounded Section Design `feasibility-review` of the instructor-facing precision revision. I did not author or approve the scopes, develop sections, run notebooks, make a timing claim, or change any source or shared course document. The pre-existing review above was preserved byte for byte; this section alone was appended. The target is the exact document snapshot identified below, on branch `scope-l03-l12-course-architecture` at baseline commit `4b886903925c25dc52434c962789c367db3d6ec6`. The ten scope files are unchanged from that baseline.

The revision now gives the mathematically mature instructor enough to judge the main choices without assuming familiarity with the later algorithms. The early questions state what students derive, work, state, or apply, identify the output or guarantee at issue, and explain what an alternative would displace. The overview keeps the same dependencies and omissions; the ledger, notebook task descriptions and two Typst syllabi describe the same ten lecture outcomes. L03 coordinate maximization and L04 three-bit parity remain the only newly agreed choices. L05–L12 choices remain provisional, and L02 remains agreed rather than delivered.

I checked the decision-sensitive claims against the unchanged scopes and the actual extracted Murphy texts. In L05, the mean-loss derivative has the correct negative-log-likelihood sign and fixed-dispersion factor; Book 2 §15.1.3 Eq. 15.35 is a log-likelihood derivative at unit dispersion. The scalar canonical GLM coordinate `η` is not asserted to be the full natural coefficient when dispersion is explicit, and the separate softmax gradient is not derived by inserting a vector into the scalar formula. In L06, the entropy-including bound, exact E-step tightness and conditional second moment retain the conditions needed for the likelihood and covariance claims. In L07–L08, positive curvature supports a local Gaussian rather than global accuracy, while HMM forward/backward summation and the limited Kalman comparison match their different scope depths. In L09, the diagonal reverse-KL optimum and total pathwise derivative include the direct integrand term and interchange conditions; the printed Book 2 §10.2.1 sign/constant errors remain explicitly corrected in the source record. In L10, detailed balance supports invariance but no finite-run mixing certificate. L11 distinguishes observation noise at fitted weights from a posterior over weights. In L12, the rate identity uses the stated joint `q(x,z)=p_D(x)q_φ(z|x)`; the fixed prior, event sums, decoder variance `τ²=1/2`, and source-to-course `β=4` to `β=19` conversion are consistent with the selected loss convention. These checks found no enlarged teaching obligation or unsupported guarantee.

Two notation gaps were found and repaired by the document owner before this snapshot: L06 now defines `q_n` and the summed bound `F`, and L12 defines the joint distribution under which `I_q(X;Z)` is computed. I re-read those repairs. Focused reading titles and the described purpose of Book 2 §§4.3.6.1, 4.3.8, 5.5, 6.2.2.2, 6.3.5.2, 6.5.3.1–3, 6.5.4.1–2, 7.4.3, 8.2.2.1–2, 9.2.2–3, 10.1.2, 10.3.1, 12.2.2, 12.5.2.3, 12.5.3, 12.6.1, 15.1.3, 15.3.2, 16.3.1, 17.3.10, 21.2.1–2, 21.3.1.1 and 21.4, plus the cited Book 1 §§6.2.6, 6.3.2, 8.7.3.1–2, 10.5.1, 13.2.4.4 and 13.3.1, were checked in the local texts. This was selective verification of the new reading promises, not a fresh review of every scope or example. The source text snapshots were `/tmp/pml-book2.txt` SHA-256 `1d77150146caf0f7e44b88b20370292abe5b6bfc506ce92fe26509a7bdb131b6` and `/tmp/pml-book1.txt` SHA-256 `69291936872f6ced92a874015ed7b2d0d27962307bf84da5c5ca9b0fa2c9eb20`.

**Remaining advisory risks:** the first PyTorch meeting, HMM sequence calculations, VI derivatives and VAE two-network training have estimated rather than measured teaching/lab time. The proposed helper programs, reference computations, portable mobility data and hosted Colab runs remain future authoring/release checks. Section Design can decide internal pacing within each unchanged scope; a required depth or application that fails a real rehearsal belongs back with Lecture Scope and, if consequential, the instructor. No such change is established by this preview.

### Exact snapshot read for this check

Git blob IDs below identify the post-repair human documents actually inspected; the earlier review's own pre-append blob was `92b36de1c873bb61cf78f2642e9bd62cd308420f`. The coordinator may subsequently update STATUS or validation bookkeeping without changing this mathematical verdict.

| Input | Git blob read |
|---|---|
| `AGENTS.md` | `b8721210d29a2c0329cd356e583085736c5e7efd` |
| `.agents/skills/section-design/SKILL.md` | `d9656a21138a547555e6996a3131705040383d34` |
| `.agents/skills/shared/backpressure.md` | `dd0163a5fc2ca80b0dcf7db94638ce9868b47888` |
| `Lectures/course_architecture_scope/questions_and_hesitations.md` | `7c8b69e00b9d12185faba73b2df8a7aeda6bb0ac` |
| `Lectures/course_architecture_scope/architecture_audit.md` | `f3e3d72677929370e9a19b1c2798f1492f3eeb06` |
| `Lectures/course_architecture_scope/source_inspection.md` | `ca8f05f5607c593f9803d32952f72594390e2458` |
| `Lectures/material_ledger.md` | `8db399dec62c8bb186d3cfe8d41817759f2bcdae` |
| `Lectures/notebook_reference_audit.md` | `d6af1654dc2fbb8d1477852ea9c9d19d44a2e7b1` |
| `Lectures/syllabus_planning_decisions.md` | `e0a42ee9d87e8c953a27c1d09b74a4e3ee1bdea7` |
| `syllabus_plan.typ` | `4c78b5960a0b5c821201eac91d2eda50db0644ff` |
| `advanced_statistics_2027_1_syllabus.typ` | `a297079f541945c93e0243d6b4ef8c8fe2aeeb49` |

All ten `lecture_scope.md` files have no diff from the named baseline. Their inspected blobs, in L03–L12 order, are `cccc6f319d5d1046b14efb4078ba55a37e414268`, `2299ca6e5a0ab901da3fbb8e85cfb5546910f1c4`, `84629e7171a371676ac6dbf1e3fabd34de907b95`, `b492462f2f2e9602b6ef917d0f47a52f23f1bdab`, `99de6f1ea4292d5006bbe70184a480fe231a1e5a`, `1c92cf00a125c33b1142cbd0696a1221a766ea36`, `dd7665143dbbcd5af443e6ca54c1a6a4baa9f3fa`, `884a24c67187557546c74d0e3935f08fc67edd93`, `f76ea83091b02831b7c5959e02ebe8f8ab55fc25`, and `67fdd3cd474b3bbf1e5ca7e931c169ebef737eeb`.
