# L06 scope and notebook feasibility investigation

**Status:** `feasible-with-risks`, investigation only, 2026-10-14. Independent delegated Lecture Scope `feasibility-review` by `/root/investigate_l05_l06`, with authorized conditional feasibility scripts. No instructor acceptance, section partition, student notebook or publication. Pending proposals live here; accepted answers belong in [lecture_scope.md](lecture_scope.md), with queue links to the blocks below.

**Target:** isolated worktree `/tmp/pml-l04-l12-reconciliation`, branch `assess-l04-l12-reconciliation-20261014`, baseline `5e4c86ee3518958157d21d6bcb4c51bcdab3537e`; current scope blob `c795841dfe92182c683d2b0e0d105f921814795d`. Architecture `cb111196e44df211e39864be596233a1a3f22aba`; map `12a341b7e8733cdf9fe8154f066648d64e6034c0`; actual map `cf143d8c5427030cf3ac6c6ad05d8ad9cd420fe3`. Prepared prerequisites are not actual teaching; no class has yet been recorded.

## What the exact computational probe establishes

[probe_em.py](notebook_feasibility/probe_em.py) and [results.json](notebook_feasibility/results.json) are new independent evidence, not a student notebook or an approved handoff. They run unregularized Gaussian EM with exact Gaussian conditionals and an exact mean/covariance M-step. Data loading, masks, grouped observed-block solves, initial values, iteration limits and comparison utilities are exposed in source. No probml-utils dependency, numerical optimizer, covariance ridge, eigenvalue clipping or hidden complete-data initialization is used.

For each row, `m_n=E[X_n|o_n,θ_t]` and `C_n` places conditional covariance in the missing–missing block, with zeros elsewhere. The checked update is

$$
R_n=m_nm_n^T+C_n,\qquad
\mu_{t+1}=N^{-1}\sum_n m_n,\qquad
\Sigma_{t+1}=N^{-1}\sum_n R_n-\mu_{t+1}\mu_{t+1}^T.
$$

The objective is the observed marginal likelihood

$$\ell(\mu,\Sigma)=\sum_n\log\mathcal N(o_n\mid\mu_{O_n},\Sigma_{O_nO_n}).$$

The script independently reproduces the current scope's two-coordinate update and likelihood increase. It then tests two conditional application routes: 600 constructed correlated Gaussian four-measurement records, and the bundled diabetes dataset restricted to `bmi,bp,s1,s2`. Rows are split before masking; each entry is hidden independently with probability 0.3, and fully missing rows are excluded by the mask alone. This conditioned mask distribution remains independent of values. The test truth is used only for evaluation; training hidden truth is never used for fitting, initialization or standardization. Real-data centering/scaling uses observed training entries only. Both routes have complete training rows with centered rank four and every pair co-observed.

Six finite runs (seeds 2027, 5, 17 for each route) completed with no objective decrease beyond `10⁻⁸`, positive covariance eigenvalues, and exact-EM stopping at 15–21 iterations. The smallest eigenvalue across Gaussian runs was 0.236; across physiological runs, 0.0736. Each complete comparison run took about 0.12–0.17 seconds after imports. These outcomes remove a local numerical/compute concern for these choices; they do not establish an hour of student work, global optimality, or general finite-sample EM convergence.

### Positive-definiteness: a sufficient scaffold condition

For this example there is a stronger exact argument than simply observing eigenvalues. The same update can be written

$$\Sigma_{t+1}=N^{-1}\sum_n\{C_n+(m_n-\mu_{t+1})(m_n-\mu_{t+1})^T\}.$$

If at least `d+1` completely observed rows are affinely independent in `R^d`, then for every nonzero vector `v` their squared projections about any common mean cannot all vanish. Their contribution makes `vᵀΣ_{t+1}v>0`; the remaining covariance/scatter terms are nonnegative. Starting SPD, this ensures exact updates remain SPD for this scaffold, and principal observed blocks are invertible. All six selected probes have this complete-row rank condition. Floating-point roundoff still requires checks. This condition does not establish unique identification or a finite global maximizer for every observation design.

The script separately checks a structural counterexample: one-dimensional marginals observed in separate rows give the same likelihood for correlations −0.9, 0 and +0.9. Observation patterns can leave dependence unidentified even though each variable has data. Pairwise co-observation is useful design evidence, not a substitute for explaining the likelihood.

## Practical comparison and the guarantee's boundary

All methods use the same train/test rows and hidden test entries. “Ordinary mean imputation” below means fill training blanks with observed column means, fit one Gaussian to that filled matrix, then use its conditional mean for test prediction. A direct column-mean test-imputation baseline is also recorded. “Complete case” fits the Gaussian only on complete training rows, then predicts conditionally. The diagnostic “mean-only iteration” runs EM's conditional means but omits `C_n` from parameter updates; it is not a legitimate exact-EM alternative. The oracle uses known generating parameters only on the synthetic route.

Every table entry averages squared error over hidden test entries. Physiological errors are in **observed-training standardized coordinates**, dimensionless with raw-coordinate weights `s_j⁻²`; they are not errors in BMI, pressure or cholesterol units. The synthetic route retains its declared unit-variance coordinate convention. Observed likelihood comparisons are meaningful here only within the same split, mask and transformation; absolute levels across routes or changing observed dimensions are not comparable. This reporting clarification addresses EARLY-02 in the [raw technical review](../course_architecture_scope/reconciliation/reviews/early_probe_validation.md), without changing results or the proposed task.

| Route / seed | Exact-EM test MSE | Complete-case fit test MSE | Mean-imputed fit test MSE | Direct column-mean test MSE | Mean-only diagnostic test MSE |
|---|---:|---:|---:|---:|---:|
| Gaussian / 2027 | 0.5433 | 0.5631 | 0.5544 | 0.9002 | 0.5765 |
| Gaussian / 5 | 0.5282 | 0.5526 | 0.5701 | 1.0167 | 0.5588 |
| Gaussian / 17 | 0.5072 | 0.5237 | 0.5448 | 0.9849 | 0.5492 |
| Physiological / 2027 | 0.6473 | 0.6535 | 0.6771 | 0.9552 | 0.6515 |
| Physiological / 5 | 0.6003 | 0.5923 | 0.6258 | 1.0355 | 0.6585 |
| Physiological / 17 | 0.5842 | 0.5860 | 0.6585 | 0.9629 | 0.6274 |

Physiological seed 5 is useful evidence: EM has higher observed training likelihood (−1016.912 versus complete-case −1025.338) but slightly worse held-out reconstruction MSE (0.6003 versus 0.5923). Do not choose a seed to conceal that distinction. On synthetic seeds 5/17, finite-sample fitted EM also happens to have lower realized MSE than the oracle; the true conditional mean minimizes population squared risk, not every realized test sample's error.

The mean-only iteration decreases observed likelihood on 34–73 steps in the physiological runs, and 41–53 steps in Gaussian runs, while remaining numerically SPD in these finite runs. This is an explicit failure of the omitted-covariance method to inherit exact-EM monotonicity. Its conditional variances are also too small in these cases: empirical 95% marginal interval coverage is about 0.84–0.87 for Gaussian runs, compared with 0.950–0.955 for exact EM. These are diagnostics, not new required interval exercises. Real-data exact-EM interval coverage is 0.91–0.94; this warns against treating its Gaussian conditional distribution as certified biomedical uncertainty.

The validity regime is independent Gaussian rows with ignorable designed masking, adequate informative observation patterns and tractable conditional moments. Computational payoff is fitting unknown population parameters without optimizing a log integral directly: grouped masks share small observed-block factorizations; conditional means/second moments and Gaussian M-step are cheap at low dimension. Dense ungrouped implementation can cost roughly `O(Nd³)` per iteration, whereas grouping reduces repeated factorizations to the number of mask patterns; the number of possible patterns still grows as `2^d`. Task error is separate: likelihood improvement concerns fitted observed-data density; reconstruction may worsen on held-out realizations; parameter uncertainty and MNAR bias are not integrated away.

## Synthetic versus recognizable measurement data

The physiological alternative uses a bundled, network-free dataset: [scikit-learn's load_diabetes documentation](https://scikit-learn.org/stable/modules/generated/sklearn.datasets.load_diabetes.html) records 442 cases and the raw-data option. Its default centering/scaling is performed before a course split, so `scaled=False` plus observed-train preprocessing is essential. The locally bundled `DESCR` identifies BMI, average blood pressure, total cholesterol and LDL for the selected four columns. It warns that some original feature meanings are incompletely documented; the uncertain `s5/ltg` variable is excluded. No disease-progression target is used, and no actual missingness mechanism is claimed: masks are course-created.

This is recognizably a population measurement-fitting task, but raw physiological measurements are bounded/skewed and need not be jointly Gaussian. Observed-train marginal skew estimates are approximately −0.02 to 0.66 in these probes; neither skew nor interval coverage is a full model check. The synthetic route provides exact generating truth, clean oracle expectations and a controlled validity regime. The physiological route makes assumptions and practical baselines more consequential, while surrendering a true-parameter oracle. Both are executable; neither has been chosen.

## Student knowledge and one-hour feasibility

The [knowledge record](../../.agents/skills/teaching-notebook-authoring/references/student-knowledge.md) gives familiar conditional probability, basic covariance, NumPy and Bayesian hierarchies; Gaussian blocks, solves and nontrivial matrix shapes have been encountered in prepared L01 work and still need scaffolding. L02 Gaussian sufficient-statistic/moment fitting and L04 KL are planned mathematical prerequisites. L05 contributes an objective/parameter-fitting distinction, not an EM proof or latent-variable posterior algorithm.

New student actions are assembling `m` in original coordinate order, putting `V` only into missing–missing covariance blocks, forming `R=mmᵀ+C`, averaging first/second moments with denominator `N`, and interpreting a likelihood trace separately from reconstruction. Advanced Boolean/Cartesian indexing, grouping mask patterns, numerical log densities, stopping conditions, train-only scaling and baseline fitting are author-supplied infrastructure. NumPy/SciPy avoid a new major ecosystem; SciPy density utilities are supplied rather than assumed familiar. Students should write a row's expected statistics and the aggregate update, not recreate the full mask/likelihood driver.

The current `8+16+12+10+9+5=60` allocation remains plausible but unpiloted. A compact implementation still contains two substantial student responsibilities—row second moments and aggregate covariance—and several comparisons can exceed nine minutes if students implement them. Supply baseline fits and their output table. Keeping the exact two-coordinate check as a visible small calculation helps students interpret the larger driver. Any learner-time estimate remains provisional; local subsecond compute is not learner validation.

## Sources and recovered commitments

Read [current source-arc review](source_arc_review.md), [raw earlier preview](../course_architecture_scope/reviews/L06_review.md), and [integrated L04–L06 review](../course_architecture_scope/reconciliation/reviews/L04_L06_assessment.md). Directly re-inspected Murphy Book 2, December 10, 2025 edition, §6.5.1 **The general algorithm**, p. 287, Eqs. 6.123–6.124; §§6.5.3.1–6.5.3.3 **Lower bound / E step / M step**, pp. 290–291; §§6.5.4.1–6.5.4.4 **E step / M step / Initialization / Example**, pp. 292–293. Look for the tight lower-surrogate chain, why fixed-q entropy drops from the M-step, and why the missing–missing second moment contains `V_n`. PDF SHA-256 `54d6bfa8cc4a367bb553bea1c5127ca63696a9655b2ca1f6137a8584dccfdbaf`.

Pertinent source cautions remain: Eq. 6.156's `−2μE[Y]ᵀ` can be harmless under the trace but is not a symmetric matrix expansion; the scope's two cross terms are correct. The book changes the role of `Q` between entropy-containing bound and expected complete-data likelihood; preserve `F=Q+H(q)` in our notation. The source's generic discussion must not turn monotonicity into a guarantee of global/unique optimum. The current Bayesian opening is instructor-requested and must survive any repair.

Recovered commit `dd4f2c5053f29590845ae42a6331d245d773218c` has a q-free MM state/apply proposal, L06 scope blob `a965c108dd990f8cf29935af8f789c1369cea52e`. Raw directly inspected post-source review is `Lectures/course_architecture_scope/source_arc_agent_reviews/L06_post.md`, blob `014a577e4ca09aa85d346b89561758940fe3346b`; independent preview `L06_section.md`, blob `2648612f91ad32ae535ee755109f3826ddf13522`. The old scope lacked the current Bayesian opening; favorable historical reviews therefore do not establish current-target acceptance.

<a id="l06-data-endpoint"></a>
## Pending L06-DATA-ENDPOINT — primary population-measurement application

**Owner/status:** Lecture Scope/instructor; awaiting decision only for application/notebook-handoff selection.

**Question:** Should required student EM practice retain the controlled synthetic Gaussian measurements, use a prepared real physiological measurement subset, or keep synthetic student work with a supplied real-data interpretation comparison?

**Options:** (A) synthetic primary: known Gaussian truth and oracle diagnostic, ordinary practical baselines; (B) physiological primary: four prepared diabetes measurements with artificial MCAR masking and supplied checks, no true-parameter oracle; (C) synthetic primary plus a brief supplied physiological table in the existing interpretation allocation. A new mixture/MRI lab would replace the current endpoint and require broader feasibility work; it is not an extra activity inside this hour.

**Recommendation:** C if its real-data table can be interpreted within the existing baseline time; otherwise A with an explicit measurement task and practical baselines. Preserve synthetic expected-statistic practice and exact guarantee, and use the supplied real-data counterexample to show that likelihood increase and reconstruction success are separate. B is executable, but model mismatch and preprocessing add interpretive burden while removing the oracle.

**Evidence:** both routes and three seeds pass exact finite-run checks above; physiological seed 5 reverses EM/complete-case reconstruction ranking; raw-data preprocessing/source limitations are documented. This is a proposed emphasis, not a selected dataset.

**Exactly awaiting decision:** definitive dataset/handoff, whether a real-data comparison is required, the oracle's required status, and source-specific application descriptions in downstream production. **Completed independent work:** both finite routes, leakage-safe preprocessing, baseline outcomes, SPD sufficient condition and structural counterexample. **Still safe:** source/algorithm validation, conditional workload analysis, L09/L12 ELBO investigations. Neither later lecture needs this dataset choice to begin.

<a id="l06-baseline-priority"></a>
## Pending L06-BASELINE-PRIORITY — practical alternatives versus diagnostic variants

**Owner/status:** Lecture Scope/instructor; awaiting decision only for required comparison priority.

**Question:** Should the nine-minute comparison budget prioritize ordinary column-mean/complete-case alternatives, retaining the mean-only and oracle results as supplied mechanism diagnostics?

**Options:** (A) students interpret exact EM against supplied ordinary practical baselines; mean-only covariance/likelihood failure and synthetic oracle are short supplied diagnostics; (B) retain current mean-only/oracle priorities, with practical alternatives optional; (C) give all baselines equal student-implementation status, adding substantial workload.

**Recommendation:** A. It satisfies the architecture's practical judgment without replacing the mathematical lesson. One table can include more methods than students implement, but all-method implementation is not credible inside nine minutes. The mean-only diagnostic isolates lost uncertainty; it cannot substitute for a method someone would ordinarily try.

**Evidence:** result table, observed-likelihood decreases and interval diagnostics above; [current handoff](lecture_scope.md#3-notebook-handoff--fit-unknown-gaussian-parameters) names mean-only/oracle, whereas architecture/map promise ordinary alternatives. No second EM algorithm or library is necessary.

**Exactly awaiting decision:** required baseline student interpretation and implementation depth, revised comparison allocation and contract. **Completed independent work:** all comparators, identical evaluation data, exact diagnostic boundaries. **Still safe:** mathematical proof/moment checks, conditional dataset evaluation, later inference feasibility. This answer can be reviewed together with the dataset choice but neither has been inferred.

<a id="l06-mm-depth"></a>
## Pending L06-MM-DEPTH — explicit reusable surrogate principle

**Owner/status:** Lecture Scope/instructor; awaiting decision only for generalization depth and mixture-time substitution.

**Question:** Should L06 explicitly state/apply generic minorize–maximize conditions rather than only name MM after the EM proof?

**Options:** (A) state a q-free lower surrogate `B_t(θ)≤ℓ(θ)` for every feasible θ, touching `B_t(θ_t)=ℓ(θ_t)`, and a demonstrated improvement `B_t(θ_{t+1})≥B_t(θ_t)`; identify EM's `B_t=F(q^t,·)` using the same proved chain; (B) keep EM-only derivation and brief MM recognition. A second nonprobabilistic example or arbitrary-surrogate construction is a larger excluded endpoint.

**Recommendation:** A at **state/apply**, replacing an estimated three minutes of mixture numerics within the 112-minute envelope. It exposes the reusable computation argument and explains precisely why covariance-dropping, non-touching approximations and arbitrary optimization steps do not automatically inherit monotonicity. No second proof or notebook task is proposed.

**Evidence:** directly verified §6.5.1 conditions, recovered post/Section Design reviews and the mean-only numerical counterexample. The old preview found the substitution plausible but warned that its three-minute donor remained unmeasured.

**Exactly awaiting decision:** required generic-MM treatment depth and reduced mixture numerical emphasis, consequent scope/source-allocation wording and downstream explanations. **Completed independent work:** source conditions and conditional improvement/failure checks. **Still safe:** exact EM/expected-statistic validation, practical task investigation and L09/L12 work based on the already-promised ELBO identity. Neither option licenses a downstream reproof or extra recording.

## Remaining gates and independent continuation

Author-owned repairs are the standalone exposed driver, full-rank complete rows, SPD/likelihood checks, mask-independent exclusions, observed-train preprocessing and accurate baseline names. The three pending blocks concern instructional commitments; none is self-approved. Required remaining gates are learner workload pilot, live rehearsal, current-target scope/Section Design review after accepted changes, then validated worked solution and Q&A authoring, clean local execution and a fresh hosted Colab run. No hosted test or notebook compatibility is claimed.

The assigned source, exact-step, baseline, conditional-data and workload investigations are complete. Further clinical validity claims or a new MRI/mixture endpoint would require new bounded source/application work. The present independent investigations and later lectures are not globally blocked by these pending choices.
