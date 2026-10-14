# Independent technical replay: L05 and L06 probes

**Verdict:** `feasible-with-risks` for the specified local finite computations. No material correctness blocker was found in the selected runs. This is an independent technical review, not Lecture Scope approval, a source-arc review, student-workload validation, or hosted-runtime validation. Two bounded author-owned improvements are recorded below.

**Reviewer:** `/root/validate_early_probes`, 2026-10-14. Target worktree `/tmp/pml-l04-l12-reconciliation`, branch `assess-l04-l12-reconciliation-20261014`, baseline HEAD `5e4c86ee3518958157d21d6bcb4c51bcdab3537e`. Only this review artifact was written in the repository. Scripts/results were inspected before the owning investigation reports. Repository instructions, worked-solution/lecture-scope boundaries, backpressure rules, and the cumulative student-knowledge record were read.

## Exact targets and replay evidence

SHA-256 identifies the uncommitted artifacts actually checked, rather than treating the baseline commit as their version.

| Target | SHA-256 |
|---|---|
| L05 `notebook_feasibility/probe_softmax.py` | `1bc41fcf75fb0fa54d47c17e14d2642fc28ad547977ad25f822cba9e91e18e66` |
| L05 author `notebook_feasibility/results.json` | `f615c282af78659b22d6a9155607e122e10fc4bae50818cdfe7f43e5be542e1c` |
| L06 `notebook_feasibility/probe_em.py` | `01cb5fe4f16c46d0d1c9de5f1ebd3f2c83ac0f553a6f9b8b8d52346a5864e82b` |
| L06 author `notebook_feasibility/results.json` | `1113a1b3e317eb92ca0bed15fdb07982c3128b30ac6cd782dd6d33fc1aa37d8d` |
| L05 `scope_investigation.md` | `f78e6340c7ef7367da2d2b964d7d8b26ec7f9836ce1f367cf002feceed880ff1` |
| L06 `scope_investigation.md` | `d8c351851cd68fac47156948502e88bfc3fb09c0b98a2dec786ff6c00d0c2a32` |

Each script was copied into its own directory below `/tmp/pml-early-probe-review-20261014/` and executed in a fresh process with the worktree's `.venv/bin/python`. The author JSON was copied as `author_results.json`; script-generated replay JSON, stdout and stderr stayed outside the repository. Both processes returned exit status 0 with empty stderr. Recursive comparison removing only `elapsed_seconds` found **all remaining fields exactly identical**, including versions, seeds, raw-data/split/mask hashes, traces, scores and counterexamples. This review did not install packages or rerun environment synchronization.

The observed interpreter was Python 3.12.13, NumPy 2.0.2 and scikit-learn 1.9.1; L05 used PyTorch 2.14.0+cpu with one thread and deterministic algorithms, and L06 used SciPy 1.16.3. Raw replay evidence remains at `/tmp/pml-early-probe-review-20261014/replay_comparison.json` and the two per-lecture directories. Additional bounded checks are preserved in `contract_checks.py` and `contract_checks.json` there. Temporary paths are session evidence, not persistent course outputs; the original tracked/proposed scripts and author JSON remain the reproducible record.

## L05 mathematical and evaluation contract

For a batch of size $B$, predictors $X\in\mathbb R^{B\times2}$, parameters $W\in\mathbb R^{3\times2}$ and $b\in\mathbb R^3$, the script evaluates logits $Z=XW^T+b$ and the mean loss

$$L=-B^{-1}\sum_n\log P_{n,y_n},\qquad P=\operatorname{softmax}(Z).$$

The analytic expressions $\nabla_WL=(P-T)^TX/B$ and $\nabla_bL=B^{-1}\sum_n(P_n-T_n)$ match the exact reduction and class axis used by autograd. The check uses nonzero float64 parameters and seven observations, not merely the symmetric zero initialization. Maximum discrepancies across the three required seeds are at most $1.11\times10^{-16}$. Fresh-graph repeated backward correctly demonstrates accumulation; the separate optimizer loop clears before backward. The checked common-logit shift preserves loss. Float32 predictors, integer class targets, `W.T`, bias broadcasting, class axis and gradient-free evaluation are consistent.

Each minibatch consists of independent uniform draws with replacement from the **training** rows, giving an unbiased gradient of their empirical mean objective. This is the stated sampling regime; it is not a shuffled epoch. At 800 updates the 32-case route makes 25,600 example visits and the supplied full-batch route makes 84,000. Neither identical updates nor this tiny Iris task establishes equivalent compute or a useful large-data speed advantage. The investigation report states that boundary correctly.

The 105/45 split precedes train-only centering/scaling. Training labels alone produce the class-frequency baseline. Balanced counts make it uniform; `argmax` breaks the prediction tie in favor of class 0 and therefore yields error $2/3$ on the balanced held-out set. NLL is independent of that predicted-label tie. Required-seed held-out NLLs were 0.104763329, 0.138354644 and 0.146493673 nats; errors were 2/45, 4/45 and 3/45, respectively. These are reproducible finite split outcomes, not uncertainty estimates for generalization.

The large-step diagnostic preserves the useful counterexample: learning rate 10 gives held-out NLL 0.168417841 despite a lower final training objective. It is not a divergence example or a universal learning-rate rule. The report accurately separates objective, prediction and optimizer and does not promise stochastic monotonicity, calibration, or a unique finite softmax MLE. Stable training loss and probability-space scoring have different numerical limits; see EARLY-01.

## L06 mathematical and evaluation contract

For row $n$, observed coordinates $O_n$ and missing coordinates $M_n$, the script computes the exact Gaussian conditional mean $m_n$ in original coordinate order and conditional covariance $C_n$ with support only in its missing–missing block. Observed entries are fixed under conditioning, so their conditional covariance and observed–missing conditional cross-covariance are zero. It aggregates

$$R_n=\mathbb E[X_nX_n^T\mid o_n,\theta_t]=m_nm_n^T+C_n,$$
$$\mu_{t+1}=N^{-1}\sum_nm_n,\qquad
\Sigma_{t+1}=N^{-1}\sum_nR_n-\mu_{t+1}\mu_{t+1}^T.$$

Grouping equal masks shares conditional solves and multiplies each pattern's covariance by its row count. There is no ridge, clipping, optimizer or hidden-truth initialization; symmetrization removes roundoff asymmetry only. An independent three-coordinate case with two missing coordinates and a second noncontiguous missing pattern matched independently prescribed first/second moments exactly. An independently calculated observed-block Gaussian log density matched `likelihood` exactly. Thus the monitored objective is the sum of observed marginal log densities, not complete-data or imputed-data likelihood.

The tiny scope example reproduced $\mu'=(1/3,1/3)$ and

$$\Sigma'=\begin{pmatrix}14/9&8/9\\8/9&41/36\end{pmatrix},\qquad
\ell_{\mathrm{old}}=-7.640343927,\quad\ell_{\mathrm{new}}=-7.137887260.$$

All six exact-EM runs stopped after 15–21 steps, had positive likelihood increments, and retained positive covariance eigenvalues. The complete-case centered rank is four in every selected run. The report's sufficient SPD scaffold is correct: in

$$\Sigma'=N^{-1}\sum_n\{C_n+(m_n-\mu')(m_n-\mu')^T\},$$

affinely spanning fully observed rows make the scatter contribution strictly positive in every nonzero direction, while remaining terms are positive semidefinite. With SPD initialization, this proves exact-arithmetic SPD retention for that scaffold. The code records rather than enforces this rank condition; a later user-changeable notebook should check it before relying on the scaffold. Pairwise co-observation alone would not establish this argument or unique identification.

Rows are split before artificial independent entry masking. Excluding fully missing rows depends solely on the mask. Conditioning on that event preserves mask/value independence, although retained mask coordinates are no longer independent Bernoulli variables. Evaluation consequently concerns retained rows with at least one observed coordinate. It cannot establish performance for predicting completely unobserved rows or for naturally occurring nonignorable missingness. Complete-case selection is also value-independent here. The report makes this boundary explicit.

Real-data loading uses `scaled=False`; only observed training entries determine center and scale. Training hidden truth is retained for bookkeeping but never enters initialization, fitting or scaling. Test hidden truth is used only for evaluation. All comparators share rows, masks and held-out missing entries. Complete-case and mean-filled Gaussian fits then use conditional prediction; direct column-mean imputation is separately named. The known-parameter oracle exists only on the synthetic route, which is not transformed after generation. An additional affine-equivariance check confirms the conditional-mean transform; if future synthetic preprocessing is added, transform both oracle parameters and truths with the same training-derived map.

The mean-only diagnostic deliberately omits $C_n$ and must remain identified as an incorrect exact-EM substitute. It has 41–53 decreasing observed-likelihood steps on Gaussian seeds and 34–73 on physiological seeds. SPD in these particular diagnostic runs does not give it exact-EM monotonicity. The disconnected-pattern counterexample is preserved: correlations $-0.9,0,+0.9$ all give observed log likelihood $-5.675754133$ when no row observes both coordinates.

Physiological seed 5 must also remain visible: exact EM has better training log likelihood than complete-case fitting ($-1016.911763$ versus $-1025.337641$), but worse hidden-test-entry MSE (0.600328793 versus 0.592333710). Synthetic seeds 5 and 17 have smaller realized fitted-EM MSE than the known-parameter oracle; this does not contradict population optimality of the true conditional mean. Marginal plug-in interval coverage is a finite diagnostic, not a joint interval, parameter-uncertainty calculation, or clinical validation. EARLY-02 clarifies metric units without changing these outputs.

## Stable issues and ownership

**EARLY-01 — downstream-owned advisory, worked-solution/evaluation author.** `probe_softmax.py:22–27` computes NLL as `-log(softmax_probability)` in float32. For logits $(0,-1000,-1)$ and target class 1, the probability underflows to zero and this score is infinite, while the stable cross-entropy is finite (1000.313232421875). Finite probabilities alone do not rule out zero target probability. The selected runs remain finite and correct; the report's stable-loss statement applies to training. **Smallest repair:** compute classifier NLL directly from logits using stable cross-entropy/log-softmax while retaining probabilities for plotting/class predictions; keep baseline log scoring explicit. No instructor choice is required, and no change to the current numerical evidence or endpoint is implied.

**EARLY-02 — downstream-owned advisory, worked-solution/report author.** The physiological MSE in `probe_em.py:107,145–147` averages squared errors over missing entries after division by each feature's observed-training standard deviation. It is dimensionless and gives raw-coordinate squared errors weights $s_j^{-2}$; it is not BMI/pressure/cholesterol error in their physical units. Likewise observed test mean log likelihood is per retained row in transformed coordinates and depends on observed dimension/mask; its absolute level is not directly comparable across routes or splits. **Smallest repair:** label the table and later figures “mean squared error over hidden entries in observed-training standardized coordinates,” and restrict likelihood comparisons to the same split, masks and transform. Retain the synthetic route's declared unit-variance coordinate convention. This is mathematical reporting correctness, not a request for instructor approval or a new experiment.

No blocking author-correctness issue remains for the specified probes. The two advisories should be handled before turning their utilities/results into a final worked solution; they do not require another broad scope review.

## Claims and pending decisions

The owning investigation reports were read only after code inspection and replay. Their finite numerical claims, sufficient SPD argument, nonidentification example, leakage statements, practical counterexamples and explicit limitations agree with the inspected evidence. Book edition/page/source-record claims were not independently re-audited in this bounded technical review. Local elapsed times remain compute observations; no student completion time or hosted compatibility follows.

L05 coefficient-meaning and evaluation-priority choices, and L06 dataset endpoint, baseline-priority and generic-MM depth choices change instructional commitments. They are pedagogical decisions owned by Scope/instructor. Correct gradients, second moments, SPD checks, leakage prevention, stable scoring and accurate metric units are author/reviewer responsibilities and should not be deferred as approval questions. The cumulative knowledge file does not establish later PyTorch or advanced masking/indexing fluency; the reports correctly leave onboarding/scaffolding and learner pilots outstanding. This review grants neither scope acceptance nor permission to remove required student actions. No notebook, clean hosted Colab run, general-runtime claim, clinical claim or actual-delivery record was produced.

## Bounded L04 selected-endpoint addendum

**Target/status:** a subsequent, separately requested technical check of the already selected Iris endpoint, dated 2026-10-14. It does not reopen that selection or resolve Q-L04-LIVE. The checked SHA-256 values are `08c04285279658e157ed33ed560e055ac0ed9a26e2779df6a0971fb05f5ca5aa` for L04 `notebook_feasibility/probe_evaluation.py`, `08d79a11d757882cc00fde32afa3a0bea24006f5c3e8e6ce9d84fdfa3b2e0482` for its author `results.json`, and `1c6909798772deb1f6555c5ebe50a0297588fd9dc98133a51f2207c0c4202a72` for `scope_investigation.md`. Verdict: selected finite computations pass, with the bounded downstream advisory EARLY-03 below.

The script/result were copied into `/tmp/pml-early-probe-review-20261014/L04/` and replayed with `.venv/bin/python` in a fresh process. Exit status was 0 and stderr empty; **every JSON field was exactly equal** to the copied author result. Versions matched L06's Python/NumPy/SciPy/scikit-learn versions above. Replay stdout/stderr, original/replayed JSON and the additional numerical comparison are in that temporary directory; `contract_checks.json` preserves the latter. Author files were not mutated.

The fixed stratified 105/45 split, raw petal-feature hash, train/test row hashes, training center and training scale all exactly match the L05 seed-2027 candidate. Class indices 0, 1, 2 are explicitly checked against the fitted model and mapped to setosa, versicolor and virginica. The frequency baseline uses training labels only, yields $\ln3$ nats, and resolves its prediction tie with class 0. Forecast construction is teacher-supplied infrastructure: L04's regularized scikit-learn logistic fit with `C=1` is **not** L05's unregularized SGD result, despite identical data conventions. The report preserves that distinction; it makes no new student training-library requirement or claim that a common forecast has already been selected across lectures.

Normalized log probabilities are $\log P_{nk}=Z_{nk}-\operatorname{logsumexp}_jZ_{nj}$. Directly gathering the true-class log probability gives the correct NLL and conversion from nats to bits. Positive multipliers 0.25 and 4 preserve every row's class ordering, including ties, while changing forecast concentration. All three forecasts therefore retain accuracy $43/45$, with respective mean NLL 0.149968722, 0.549285666 and 0.055988189 nats. These fixed transformations distinguish predicted-label accuracy from probability scoring; their ranking on 45 held-out cases does not select a method winner or establish population calibration. EARLY-03 concerns an auxiliary assertion, not these selected scores.

The top-label summaries use fixed edges $0,0.2,\ldots,1$; the last bin includes confidence 1, empty bins are explicit, and bin counts sum to 45. Confidence means and observed correctness refer to the same cases in each bin. They are descriptive summaries of this split, rather than estimates with uncertainty guarantees, a fitted calibration map, or an assessment of every class probability. No test-label-dependent tuning appears in the preparation code.

The information calculation uses one explicit course-constructed law, $p(y,r,z)=p(y,r)k(z\mid r)$, with uniform $R$ on four codes and a deterministic merge into two codes. Nonnegative probabilities sum to 1, and the factorization establishes $Y\perp Z\mid R$, including zero-kernel events. An independent entropy decomposition gave $I(Y;R)=0.499884336$ bits and $I(Y;Z)=0.180190918$ bits (maximum disagreement $4.44\times10^{-16}$); both are bounded by $H(Y)=1.584068055$ bits. Reversing processed-code labels leaves MI unchanged, and mapping all codes to a constant gives exactly zero. This verifies the finite-law DPI example; it is not an Iris population-MI estimator. Scoring/MI mathematical work can use supplied forecasts and information tables without requiring students to author this preparation script.

**EARLY-03 — downstream-owned advisory, L04 worked-solution/evaluation author.** `scores()` correctly scores normalized log probabilities, but its unconditional check against `-log(exp(log_p))` fails if exponentiation underflows. The preserved counterexample uses logits $(0,-1000,-1)$ and target class 1: direct normalized-logit NLL is finite (1000.3132616875182), but the probability-space assertion rejects it because the target probability rounds to zero. This does not affect the selected run. **Smallest repair:** remove that probability-space verification or apply it only when the target probabilities are representably positive; retain normalized-logit scoring as the reference. No instructor decision, scope change, extra learner activity or broad review is needed.

The new L04 report's selected numerical and constructed-law claims agree with this evidence, subject to EARLY-03's robustness qualification. Its teacher-preparation/source links were not separately re-audited. The existing live-emphasis decision remains deferred, and student-time/hosted-runtime gates remain untested. This addendum adds no approval or actual-teaching record.

### Focused EARLY-03 repair replay

The pre-repair targets and raw finding above are recoverable in commit `358fb4586de0356a3dba8236eb1bf65e5c927d64`. The subsequent author repair was checked at script SHA-256 `2a6d296a0ef91ce5a34aeee361ad3c3e31afa40ecbac61fd4ed57bbec70a354b`, author JSON `629ee3226ed3ea3cb495451025f2c3e2b48b4e84189e92c59027ffe8259dfee9`, and L04 investigation `bb02afd7a1fb697b99e3d16fbe6917cb237ccfbf2f3b1554bbdb5de04ae97f25`. Only the review was edited by this reviewer. Scratch replay and comparison evidence are in `/tmp/pml-early-probe-review-20261014/L04_repaired/`, including `repair_check.json`.

Fresh-process replay returned status 0 with empty stderr and exactly reproduced the new author JSON. Every pre-existing top-level field equals the version in `358fb45` exactly; the only new field is `numerical_diagnostic`. The original logits $(0,-1000,-1)$ now score successfully at 1000.3132616875182 nats while exponentiation gives floating-point zero. A **structural** target probability of zero instead has log probability $-\infty$ and genuinely infinite loss; it is outside this helper's explicit finite-logit input contract. The new diagnostic accurately states this distinction without changing selected forecasts or scores.

**EARLY-03 disposition at this exact repair:** the zero-underflow case is fixed; the advisory has a remaining positive-subnormal edge. Checking probability/log agreement whenever `selected_p > 0` includes probabilities whose rounding error is large on a relative scale. With logits $(0,-744,-1)$ and target class 1, direct NLL is finite (744.3132616875182), exponentiation gives `5e-324`, and the assertion still rejects the score. **Smallest remaining repair:** restrict the auxiliary check to normal-range probabilities (`selected_p >= np.finfo(p.dtype).tiny`) or remove it; retain the logit-space score for all finite logits. This is the same bounded author-owned numerical issue, not a new scope or workload decision. Selected runs remain correct, and no broad review was reopened.

### Final bounded repair verification: EARLY-01–03 resolved

The final author corrections were inspected and replayed without modifying their files. This entry preserves the earlier raw findings and interim check above, while recording their **resolved** status at these exact live versions:

| Final target | SHA-256 |
|---|---|
| L04 `notebook_feasibility/probe_evaluation.py` | `dd35f2a0ec9bb9d7b9360114c7e09ba3418f0522fbd3ab09e3758be56311f4c3` |
| L04 author `notebook_feasibility/results.json` | `6746d25174c749f722935fb8d451105875cc3d3ef3d1785c7ee2f6ce38024e5d` |
| L04 `scope_investigation.md` | `d98267d244818b0371700ffebe467692a6a357fc93f600ba420da1a9702f85b1` |
| L05 `notebook_feasibility/probe_softmax.py` | `5d1d870e3ac665d350fb6a48923cfa4361a82b152fcb6d9c1bda20e5b3dd7ffb` |
| L05 author `notebook_feasibility/results.json` | `8d02e549158edc8e07c42010dda77b733e11c3065c5048b89eeb7171ae59e9c5` |
| L05 `scope_investigation.md` | `ebd92d2a982410cfa4fc81225f0a910a6d935499476d8d1f4877b7f6a2b2dc91` |
| L06 `notebook_feasibility/probe_em.py` | `01cb5fe4f16c46d0d1c9de5f1ebd3f2c83ac0f553a6f9b8b8d52346a5864e82b` |
| L06 author `notebook_feasibility/results.json` | `1113a1b3e317eb92ca0bed15fdb07982c3128b30ac6cd782dd6d33fc1aa37d8d` |
| L06 `scope_investigation.md` | `3a56312c0689f932028af2051356c054b77435c4df41d9ee7836b841ea44d0ed` |

Fresh-process L04 and L05 replays used isolated `final_L04/` and `final_L05/` directories under `/tmp/pml-early-probe-review-20261014/`, with the same worktree `.venv/bin/python`. Both exited 0 with empty stderr, and every current author-JSON field matched exactly excluding only L05 elapsed times. Original results were read directly from commit `358fb4586de0356a3dba8236eb1bf65e5c927d64`. The recursive comparison and exact differences are preserved in `/tmp/pml-early-probe-review-20261014/final_repair_comparison.json`; original/current/replayed JSON and stdout/stderr remain in the two scratch directories.

**EARLY-03 resolved:** L04 removed the probability-domain assertion entirely and now treats direct normalized-logit loss as authoritative. Both preserved examples are accepted: 1000.3132616875182 nats for the zero-underflow case and 744.3132616875182 nats for the positive-subnormal case. Every pre-existing L04 result field remains exactly equal to `358fb45`; only the numerical diagnostic is added. Structural target zero retains a genuinely infinite mathematical loss and remains outside the supplied helper's finite-log-probability contract.

**EARLY-01 resolved:** L05 now gathers `torch.log_softmax` output for classifier NLL; the frequency baseline supplies explicit log frequencies. Inspection of the diff confirms that model, split, standardization, initialization, learning rates, minibatches, training objectives and random-stream operations are unchanged. The deterministic added numerical diagnostic does not draw random numbers. Against `358fb45`, every old non-time field is identical except four mean-NLL values: seed-2027 test, seed-17 train/test, and large-step test. Each absolute change is exactly $1.4901161193847656\times10^{-8}$ nats, well below the permitted $10^{-6}$ evaluation-roundoff bound. All label errors, baselines, objective traces, gradient checks, configurations and hashes are identical. The added float32 extreme-logit diagnostic reports finite NLL 1000.313232421875 despite exponentiation to zero. There is no larger unexplained change.

**EARLY-02 resolved:** L06 now explicitly states that physiological MSE averages hidden test entries in observed-training standardized coordinates, with dimensionless raw-coordinate weights $s_j^{-2}$; it retains the synthetic unit-variance convention and limits likelihood comparisons to the same split, mask and transform. Its computational source and JSON hashes are unchanged, so no repeat EM run was needed for this reporting-only correction.

No stable issue from this bounded technical review remains open at these versions. The mathematical/evaluation counterexamples, source history and original review evidence remain preserved. This resolution closes author-correctness advisories only: pedagogical approvals, learner pilots, actual delivery and hosted notebook validation retain their previously stated boundaries. No broad source/scope audit was repeated.
