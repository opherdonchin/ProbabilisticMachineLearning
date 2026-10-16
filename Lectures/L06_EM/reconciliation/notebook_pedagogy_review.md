# Notebook pedagogy alignment: L06 review and solved Q&A specimen

**Finding:** the written notebook skill already requires mathematical and
technical development through small coherent questions. A Scope at the level
of computational goals is appropriate; its coarse granularity or absence of
numbered Q&A is not a defect. The instructor's latest clarification identifies
a different concern: designing those goals as independent coding assignments,
with theory and interpretation appended, can leave a weak or overextended
spine for integrated guided learning. The needed correction is a focused,
connected computational and intellectual argument, with realistic extent for
developing each move. A short solved specimen can test that argument downstream;
it is not a prerequisite for discussing or assessing Scope. No evidence requires
replacing the skill, asking the instructor to restate the approach, or replacing
the validated computation with simpler code.

This report and its eight-question specimen are **proposed alignment evidence**,
not an approved teaching exemplar, a full notebook, a finalized L06 handoff or a
learner-time validation. The instructor has selected real measurements with
artificial missingness as the primary route and has not required an additional
synthetic student activity. Baseline priority and full Scope acceptance remain
separate. No proposed question below resolves those choices by implication.

Reviewer `/root/l10_ais_technical_review`, 2026-10-16; notebook-authoring / bounded
review and specimen task. This is a **general subagent following the notebook
skill**, not a dedicated notebook execution profile. Review worktree
`/tmp/pml-notebook-pedagogy-review-20261016`, input
`61f113e13a29f7dd9b0496e5d9b1d4fd7415aaad`. Only this report is written in the
worktree. No student notebook, shared skill, source fix, environment change,
merge or publication was performed. Peer ownership is preserved.

## What exists, and what it establishes

The current `teaching-notebook-authoring/SKILL.md` was read in full, together
with `references/student-knowledge.md` and `references/notebook-tags.md`.
Their bytes match the integration checkout. The skill explicitly requires:

- questions about lecture equations, mathematical objects, symbol-to-code
  mappings, applications and equivalent formulations;
- full answers immediately following locally specified questions;
- coherent conceptual/computational units rather than syntax fragments;
- supplied infrastructure, with central method understanding still exposed;
- a notebook-specific knowledge report that determines scaffolding;
- preservation of a validated worked solution and native package operations;
- mechanical derivation of the student version from the solved Q&A source.

Its instruction 14 says not to require a derivation merely because one exists;
it also allows a derivation when it is an explicit learning objective. This does
not require an exposition-only mathematical block before an opaque fitting call.
For L06, a short application identity such as
$E[XX^T\mid o]=mm^T+C$ can be developed where it explains the sufficient
statistic actually being calculated. A full new proof of EM's convergence or a
second derivation of Gaussian conditioning is unnecessary. The instructor's
latest steering supplies the desired theoretical/technical emphasis; it does
not require wholesale skill revision.

I read the **actual integration-checkout**
`InClass/Solutions/lecture1_missing_data.ipynb` (80 cells, 21 tagged student
questions), rather than treating an outline or report as the notebook. Concrete
examples, using zero-based cell numbers:

| Existing draft evidence | What it demonstrates |
|---|---|
| Cells 24-27 | Reproduce the task schema, then map its variables to the concrete conditional target. |
| Cells 31-41 | Explain or document package behavior, construct the model and inspect its returned object; calling PyMC coexists with technical understanding. |
| Cells 48-53 | Rearrange the supplied conditional mean to obtain $W,b$, then calculate them with a solve. This is local mathematical reasoning, not just a package call. |
| Cells 54-60 | Identify conditional covariance, calculate it, and verify that the rewritten model reproduces the original marginal. |
| Cells 63-76 | Apply exact posterior equations and compare the same quantities with the package output. |

These are useful **inherited draft examples**, not evidence of instructor
approval or a mature, behaviorally validated authoring process. The accompanying
`lecture1_missing_data_authoring_report.md` Section 7 explicitly calls it an
“authoring-complete draft, not yet a publication-validated course notebook.”
It leaves runtime types, names, plotting and numerical agreement for execution.
The inherited report also uses an earlier notebook filename. Git/file existence
and file timestamps do not establish that the instructor saw or endorsed it.
I have not run or certified its PyMC API claims, and no such certification is
needed to inspect its instructional sequence.

The L06 Scope and `scope_investigation.md` already identify two nontrivial
mathematical/computational transitions: constructing a row's expected vector
and outer product **with conditional covariance**, then assembling the Gaussian
parameter update. Their summary “inspect one row, use aggregation, run driver”
is legitimate computational-goal-level Scope language. The review question is
whether these are connected moves in a sufficiently focused learning argument,
and whether its extent allows guided mathematical and technical development,
rather than assuming that supplying code removes the learning work. There is
no L06 solved Q&A notebook in this input to audit. Thus this review identifies
a planning/framing risk and proposes a spine; it does not establish failure of
an existing L06 teaching notebook. The old synthetic handoff/oracle wording must
follow the accepted real-data revision in its owning Scope; it is not authority
to add a synthetic student activity here.

## Proposed L06 spine and the specimen's role

**Proposed spine, for alignment rather than approval:** conditional inference
at the current parameters supplies the **expected sufficient statistics**;
preserving their conditional covariance makes a valid **population parameter
update** possible; iterating that computation changes the fitted distribution,
whose objective and reconstruction implications must then be distinguished.

The recognizable problem remains learning a joint measurement model from
incomplete physiological records so that visible measurements inform hidden
ones. Each move develops theory and computation together:

| Connected move | What must become understood | How the existing specimen serves it |
|---|---|---|
| Condition at current parameters | The Gaussian conditional uses a temporary fixed parameter value inside a parameter-learning algorithm. Its mean and covariance are both outputs. | Q1 fixes the target/object roles; Q2 applies the same conditional to an actual physiological row. |
| Form expected sufficient statistics | A conditional mean does not determine an expected outer product: $R_n=m_nm_n^T+C_n$. This is the essential uncertainty-preservation step. | Q3 develops the identity and calculates missing contributions; Q4 checks that the prepared helper returns precisely these objects. |
| Update population parameters | Averaging those first/second moments gives the next Gaussian mean/covariance for all rows, including partly observed ones. | Q5 connects moment matching to the aggregate update. Q6 checks that the update improves the actual observed objective and applies the lecture's tight-bound argument. |
| Iterate and reinterpret the fit | The driver repeats these same moves; its output is a point fit, with a likelihood guarantee that differs from prediction quality. | Q7 reads the supplied iteration through the already understood computations. Q8 gives a possible bounded reconstruction comparison. |

This protects two substantial intellectual transitions—conditional covariance
to expected second moment, and expected statistics to learned parameters—without
requiring students to reproduce all driver/indexing infrastructure. It also
prevents the notebook from ending at a checked row calculation: the row must
contribute to a fitted population model and its reconstruction use.

The eight-question count is not itself evidence for or against feasibility.
Q2-Q5 contain matrix/object reasoning and local computations that require real
learning time even with complete package scaffolding. Q6 should apply the
lecture's bound argument at this update, rather than repeat its full derivation.
The existing 60-minute allocation is unmeasured; guided development must be
budgeted inside it, not treated as free time released by supplying a driver.
This report establishes no revised timing or full Scope commitment.

Extra comparisons can diffuse the spine. The row-level mean-only omission in
Q3 directly explains the sufficient-statistic correction; a separate iterative
mean-only algorithm, interval-coverage exercise, initialization study, and
multiple equally weighted practical baselines would each add another activity.
They should not all become coequal student responsibilities because the probe
has already calculated them. Q8 is an illustrative place for a tightly bounded
test comparison, not approval of every listed baseline or a second evaluation
curriculum. The ordinary-baseline priority remains an instructor-owned Scope
choice. The accepted real-data route needs no additional synthetic/oracle
student activity; its lack of known population truth can be stated while local
algebraic checks remain available on the same real row.

## Notebook-specific knowledge report for this specimen

### Assume familiar

Conditional probability, expectation/variance, Bayesian reasoning, basic
covariance, arrays/indexing and `@`. Students can distinguish a parameter from
an observed quantity when the present objects are specified. No generic Python
or Bayesian-sampling quiz is needed.

### Previously encountered — scaffold when needed

Gaussian covariance blocks and conditioning, matrix shapes and linear solves
from L01; sufficient-statistic moment fitting from planned L02; likelihood/KL
and parameter optimization from planned L04/L05. These are prospective receiving
conditions, not a claim that those classes have been taught. Reproduce the
needed equations and provide the block-selection idiom. The cumulative record
does not justify assuming effortless fluency in `np.ix_`, batching missingness
patterns, outer-product aggregation or numerical density utilities.

### New in this lecture/notebook

Conditional expectations evaluated at a fixed current parameter value inside
parameter estimation; placing uncertainty only in the missing-missing block;
the second-moment correction and its M-step role; separating observed-likelihood
improvement from reconstruction error. Train-only preprocessing, artificial
masking, grouped helpers and stopping logic are supplied with their purpose and
interface visible. The specimen introduces `np.outer` and explains that the
helper's returned second moment is a **sum**, not a covariance or average.

## Proposed solved Q&A excerpt

This is a passage within a prospective notebook, after dataset introduction.
It demonstrates the proposed granularity; it does not specify the complete
notebook, its exact activity count or its duration. Labels indicate eventual
cell roles. Each question is followed immediately by its complete answer.

**[GIVEN] Problem, data and computation available here.** We fit
$X_n\sim N_4(\mu,\Sigma)$ to physiological measurements in coordinate order
`[bmi, bp, s1, s2]`. These are BMI, average blood pressure, and two serum
measurements. The disease-progression target is unused. The [official dataset
documentation](https://scikit-learn.org/stable/datasets/toy_dataset.html#diabetes-dataset)
and [`load_diabetes` documentation](https://scikit-learn.org/stable/modules/generated/sklearn.datasets.load_diabetes.html)
identify the source and raw-data option; a Gaussian model is an assumption, not
a known biomedical distribution.

Prepared setup uses `load_diabetes(scaled=False)`, the existing probe's seed
2027, a two-thirds row split, independent 30% artificial hiding, and exclusion
of fully hidden rows by the mask alone. Center/scale come only from visible
training values. This gives 294 training and 146 retained test rows. `train`
contains standardized visible entries and `np.nan` for hidden ones. Hidden
test truth is available only to the evaluation utility. Loading, masking,
plotting and mask grouping are supplied infrastructure.

The prepared helpers are the existing validated probe functions, unchanged:

```python
# GIVEN interfaces; setup makes these names available.
# moments(visible, mu, Sigma) -> (E, sum_R)
# E[n] = E[X_n | visible row n, mu, Sigma]; sum_R = sum_n E[X_n X_n.T | ...]
# likelihood(visible, mu, Sigma) -> sum of observed-block log Gaussian densities
# fit(visible) -> (mu_hat, Sigma_hat, diagnostics), with exact EM updates
```

For one local calculation, setup supplies the checkpoint after five exact EM
updates from the probe's diagonal initial covariance. Parameters remain fixed
through the following E-step. Here are their actual numerical values:

```python
# GIVEN. Full-precision checkpoint, in standardized coordinates.
import numpy as np
mu_t = np.array([-0.0005475877871852808, 0.0015722839280024625,
                 -0.007726272503586001, -0.015785706146826197])
Sigma_t = np.array([
 [1.00407525267428,   0.3239013285706505, 0.22427756772301147, 0.23612383121901656],
 [0.3239013285706505, 0.9966349502927581, 0.2322233620023661,  0.22953636725818538],
 [0.22427756772301147,0.2322233620023661, 1.0085364551565454,  0.8906240054089262],
 [0.23612383121901656,0.22953636725818538,0.8906240054089262,  0.9961033041923604],
])
row = np.array([np.nan, -0.9110699489923084, -1.605087818063921, np.nan])
O = np.array([1, 2])  # observed bp and s1
M = np.array([0, 3])  # missing bmi and s2
```

This is training row 17 in the fixed shuffled order, original dataset row 191
(both zero-based). Its visible raw measurements were `bp=82`, `s1=131`.
The hidden raw measurements are deliberately not displayed or used here.

### Q1 — What is inferred, and what is fitted? (`exercise-question`)

Answer in mathematics and a sentence. At fixed $\theta_t=(\mu_t,\Sigma_t)$,
what conditional distribution concerns the missing BMI and s2 of this row?
What likelihood is EM ultimately maximizing over $\theta$ for the incomplete
training matrix? Does an E-step produce a posterior over $\theta$?

**Answer (`solution`).** The row's E-step uses
$p(X_M\mid X_O=o,\theta_t)$. Fitting maximizes

$$
\ell(\theta)=\sum_n\log\mathcal N(o_n\mid\mu_{O_n},\Sigma_{O_nO_n}).
$$

The current parameters are held fixed while conditioning on missing entries.
EM updates a point estimate of them; it does not calculate their Bayesian
posterior. The unknown population parameters distinguish this problem from
L01's known-parameter missing-value calculation.

### Q2 — Calculate the conditional Gaussian for this actual row (`exercise-question`)

The lecture gives

$$
a=\mu_M+\Sigma_{MO}\Sigma_{OO}^{-1}(o-\mu_O),\qquad
V=\Sigma_{MM}-\Sigma_{MO}\Sigma_{OO}^{-1}\Sigma_{OM}.
$$

Write and run code to calculate $a,V$ at the supplied checkpoint. A Cartesian
block selection is supplied: `Sigma_t[np.ix_(M, O)]` selects rows `M`, columns
`O`; `np.ix_(O,O)` selects the square observed block. Use `np.linalg.solve`
instead of forming an inverse. State which missing quantity each entry of $a$
belongs to, and whether $V$ has to contain zeros because the row is incomplete.

**Answer (`solution`).**

```python
Sigma_MO = Sigma_t[np.ix_(M, O)]
B = np.linalg.solve(Sigma_t[np.ix_(O, O)], Sigma_MO.T).T
a = mu_t[M] + B @ (row[O] - mu_t[O])
V = Sigma_t[np.ix_(M, M)] - B @ Sigma_MO.T
print(a)
print(V)
```

It gives $a\simeq(-.513044,-1.440524)$ in `[bmi,s2]` order and

$$
V\simeq\begin{pmatrix}.875608&.031006\\.031006&.208972\end{pmatrix}.
$$

These missing values retain uncertainty and dependence under the model.
Nothing requires zero entries in this missing-block covariance. They are
conditional model estimates in standardized units, not observed physiology.

### Q3 — Why is filling the conditional mean insufficient? (`exercise-question`)

Use the definition
$\operatorname{Cov}(X\mid o,\theta_t)=E[(X-m)(X-m)^T\mid o,\theta_t]$
with $m=E[X\mid o,\theta_t]$ to obtain the row's expected outer product.
Explain where its covariance correction is nonzero. Then calculate the
`bmi,bmi` and `bmi,s2` entries that mean filling alone would lose.

**Answer (`solution`).** Expanding the covariance and using $E[X\mid o]=m$
gives $C=E[XX^T\mid o]-mm^T$, hence

$$R=E[XX^T\mid o,\theta_t]=mm^T+C.$$

Observed entries are fixed after conditioning, so their conditional variances
and their conditional cross-covariances with everything are zero. Embed $V$
only in $C_{MM}$, preserving original coordinate order:

```python
m = row.copy()
m[M] = a
C = np.zeros((4, 4))
C[np.ix_(M, M)] = V
R = np.outer(m, m) + C  # np.outer forms m m.T for one vector
print(R[0, 0], R[0, 3])
print(C[0, 0], C[0, 3])
```

The expected entries are approximately `1.138822, 0.770058`; conditional-mean
filling gives approximately `.263214, .739052`, omitting `.875608, .031006`.
Thus the correction concerns the sufficient statistic itself. It is not merely
an error bar added after parameter fitting.

### Q4 — Check the prepared E-step against the mathematics (`exercise-question`)

The supplied `moments` interface above returns expected full rows and a **sum
of expected outer products**. Call it on `row[None, :]` (a one-row matrix).
Check both returned objects against your $m,R$. Use `np.allclose`, which tests
entrywise numerical agreement within tolerances. Why is checking the mean
alone unable to detect the covariance-dropping mistake?

**Answer (`solution`).**

```python
E_row, sum_R_row = moments(row[None, :], mu_t, Sigma_t)
print(np.allclose(E_row[0], m))
print(np.allclose(sum_R_row, R))
print(np.allclose(sum_R_row - np.outer(E_row[0], E_row[0]), C))
```

All three checks return `True`. Since there is one row, the helper's sum is
that row's $R$. A helper that returned $mm^T$ could have exactly the right
conditional mean while being wrong for the M-step. The third check identifies
the missing uncertainty in its original-coordinate blocks.

### Q5 — Assemble one parameter update from expected statistics (`exercise-question`)

Lecture moment matching supplies
$\mu_{t+1}=N^{-1}\sum_nm_n$ and
$\Sigma_{t+1}=N^{-1}\sum_nE[(X_n-\mu_{t+1})(X_n-\mu_{t+1})^T\mid o_n,\theta_t]$.
Use $N^{-1}\sum_nm_n=\mu_{t+1}$ to rewrite the covariance in terms of
$\sum_nR_n$. Then call `moments(train, mu_t, Sigma_t)` and calculate one
update. Why is its divisor $N=294$, rather than the complete-row count?

**Answer (`solution`).** Expanding the centered outer product gives two cross
terms; their average is $-2\mu_{t+1}\mu_{t+1}^T$. Adding back the final mean
outer product leaves

$$\Sigma_{t+1}=N^{-1}\sum_nR_n-\mu_{t+1}\mu_{t+1}^T.$$

```python
E, sum_R = moments(train, mu_t, Sigma_t)
N = len(train)
mu_next = E.mean(axis=0)
Sigma_next = sum_R / N - np.outer(mu_next, mu_next)
```

All rows contribute expected complete-data sufficient statistics, including
partly observed rows; this is not a complete-case fit. Here
$\mu_{t+1}\simeq(-.000367,.001548,-.008496,-.016177)$ and
$\Sigma_{t+1}[2,3]\simeq.902397$ (previously `.890624`). More covariance
entries may be inspected in supplied output; no new matrix-calculus proof is
needed to apply this update.

### Q6 — Check the actual objective and its guarantee (`exercise-question`)

Compute the observed training log likelihood before and after your update with
the supplied `likelihood` utility. Explain the increase using the lecture's
inequality: $F(q,\theta)\leq\ell(\theta)$, with equality at
$q_t=p(z\mid o,\theta_t)$. Which distribution must stay fixed while the
M-step improves $F$? Would decreasing reconstruction error establish this
inequality instead?

**Answer (`solution`).**

```python
ll_before = likelihood(train, mu_t, Sigma_t)
ll_after = likelihood(train, mu_next, Sigma_next)
print(ll_before, ll_after, ll_after - ll_before)
```

The values are approximately `-1060.597516, -1059.283886`, an increase of
`1.313631` nats. Hold $q_t$ fixed during parameter improvement:

$$
\ell(\theta_{t+1})\geq F(q_t,\theta_{t+1})
\geq F(q_t,\theta_t)=\ell(\theta_t).
$$

The exact conditional moments and exact M-step justify these relations.
Recomputing a different $q$ arbitrarily during that maximization would not be
the same fixed-surrogate argument. Hidden-value reconstruction error is a
different quantity and does not establish this chain.

### Q7 — Run the prepared driver and identify what it certifies (`exercise-question`)

The supplied `fit` repeatedly performs the moment calculations and update you
just checked, starting from observed-column means and diagonal observed-column
variances. It symmetrizes covariance for roundoff, adds no ridge, and stops when
the absolute observed-likelihood change divided by $N$ is below $10^{-7}$,
or after 80 updates. Call it on `train`. Read its iteration count, sampled
likelihood trace and minimum increment. Does this demonstrate a unique global
maximum or an exact posterior over fitted parameters?

**Answer (`solution`).**

```python
mu_hat, Sigma_hat, diagnostics = fit(train)
print(diagnostics['iterations'])
print(diagnostics['observed_train_ll_trace_every_5_steps'])
print(diagnostics['min_ll_increment'])
```

It takes 15 updates. At steps `0,5,10,15`, the logged likelihoods are
approximately `-1213.192446, -1060.597516, -1058.803946, -1058.801819`;
the minimum increment is `1.70356e-5`. These checks support successful finite
execution and the expected objective behavior for this run. Small changes do
not prove a unique/global optimum, and the fitted parameter pair remains a
point estimate. The prepared driver automates computations whose objects and
local behavior we have already checked.

### Q8 — What does the fitted model accomplish on hidden test entries? (`exercise-question`)

**[GIVEN]** A supplied evaluation cell conditions on each test row's visible
entries under $(\hat\mu,\hat\Sigma)$ and compares its conditional mean with
the artificially hidden values. It uses the same test mask for all methods;
errors are averaged over hidden entries in observed-training-standardized
coordinates. Seed 2027 gives EM MSE `.647348`; direct column-mean filling
`.955156`; complete-case Gaussian fitting followed by conditional prediction
`.653506`. Seed 5, from the already supplied author evidence, gives EM `.600329`
and complete-case `.592334`, despite EM's higher observed training likelihood.

Explain what quantity each method predicts, one useful advantage shown in seed
2027, and why seed 5 does not refute the exact EM objective argument. Do these
numbers establish calibrated biomedical uncertainty?

**Answer (`solution`).** EM and complete-case fitting use the same form of
Gaussian conditional mean with differently learned parameters. Column-mean
filling ignores the other visible measurements. In seed 2027 the fitted
conditional model reduces hidden-entry squared error relative to that simple
baseline; its difference from complete-case fitting is modest. The exact
objective argument concerns observed training likelihood, not the ordering of
finite held-out squared errors. Seed 5 illustrates precisely that distinction.
These dimensionless errors reflect a particular split, artificial mask and
Gaussian approximation. They establish neither a true clinical missingness
mechanism nor calibration, and conditioning on fitted parameters omits parameter
uncertainty. This proposed interpretation question does not approve the still
separate required-baseline allocation.

## Checking record and smallest process correction

The numerical specimen uses the existing real-data probe unchanged. A scratch
script loads only its imports/function definitions with `ast` (avoiding the
module's output-writing full-probe tail), reproduces seed 2027 preprocessing,
calculates the five-update checkpoint, checks one row's helper output and
performs one existing real-data fit. It does not run the synthetic route or a
new multi-seed probe. The final likelihood trace exactly matches the committed
result; all four final evaluation metrics agree within `1e-12`; the training
mask hash matches exactly. Runtime: NumPy `2.0.2`, SciPy `1.16.3`, sklearn
`1.9.1`, existing repository uv interpreter, no installations.

Reproduction command:

```text
OPENBLAS_NUM_THREADS=1 OMP_NUM_THREADS=1 /home/opher/Repositories/ProbabilisticMachineLearning/.venv/bin/python -B /tmp/pml_l06_pedagogy_specimen.py > /tmp/pml_l06_pedagogy_specimen.json
```

Exact checking identities (SHA256):

| Record | Digest |
|---|---|
| Current L01 solved draft | `f114516ca6a9c0823c14da0a734822a8901e4fdccf237481d47d0e3a61f80a8c` |
| Current L01 authoring report | `fa853b0ad7885f2a62f3343a9bcd4b32e2c908241bf3e10122af0ff7328a91b9` |
| Teaching-notebook skill | `90b47dc1555083b2e0d84b4d4282e3558d5dbb6c42663229b102d01b257ae5b6` |
| Student-knowledge record | `3b2d7d0a2db115e87577c168a025306cebdb4a852a6550b537a56418af7f6ce9` |
| Notebook-tag reference | `c3fa668da05f0aebc57adbbbe17292d084be90ec3e688f8c7e8293cc57d8d870` |
| L06 `probe_em.py` | `01cb5fe4f16c46d0d1c9de5f1ebd3f2c83ac0f553a6f9b8b8d52346a5864e82b` |
| L06 `results.json` | `1113a1b3e317eb92ca0bed15fdb07982c3128b30ac6cd782dd6d33fc1aa37d8d` |
| Seed-2027 shuffled raw measurement matrix | `d052f39550acee840558061a5cda168cfd95a69965f981a2f6fe6af7ddd7bd4f` |
| Seed-2027 training mask | `0e83a6b497f5372d7ab2d1098fb60cfb737cbb31cf6dadbf080b6e3168343713` |
| Scratch `/tmp/pml_l06_pedagogy_specimen.py` | `93c248bc909b851aa71b6e7efacb807a39316a8a14496d5a30e4494897273608` |
| Raw `/tmp/pml_l06_pedagogy_specimen.json` | `de5501d4281613fc9102f07da8d9301a5cdc1c3ed2d043a66630bdd69b3e7c06` |

The raw scratch JSON preserves full center/scale, row/mask/indices, checkpoint,
conditional mean/covariance, embedded moments, next update, likelihoods,
diagnostics and evaluation values. Integration checkout HEAD at inspection was
`a804af644a7ccb282c2ca113f78f4a2a12b1fc4d`; its relevant source hashes above
identify the actual inputs independently of unrelated checkout activity.

**Coordinator-owned correction:** retain computational-goal-level Scope, but
state the connected intellectual/computational spine and the extent of guided
development it requires. Judge each proposed activity by its contribution to
that spine, rather than treating independent implementation as the main task
and theory/interpretation as additions. Use a short solved excerpt when useful
to test whether the proposed guided development actually connects the moves;
do not demand Q&A production before Scope assessment. Preserve the existing
computation. Prepared package/driver calls can remain, with their relevant
objects, equations and local checks made inspectable. No rule requires students
to reconstruct all internals.

**Author-owned next step, after alignment:** use the accepted worked solution
and existing notebook as the starting point, then develop the complete solved
Q&A sequence under the current skill. Audit local answerability, preserved
results and knowledge assumptions, and generate the self-work notebook
mechanically. If instructor feedback on a concrete excerpt exposes a specific
skill conflict, identify that conflict before proposing a narrow revision.
There is no basis yet to claim that a skill rewrite, dedicated-profile creation,
or one-hour workload has been validated. Local and hosted Colab publication
checks remain separate, later gates.
