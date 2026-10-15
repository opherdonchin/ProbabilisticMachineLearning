# AIS pilot: separate seeded technical review

**Verdict: feasible-with-risks; no blocking algorithm or numerical defect found.**
The implemented AIS estimator has the correct path law, weight order and returned
state. The recorded results support the limited empirical conclusion: on the
frozen Challenger posterior, direct importance sampling gives smaller observed
query error at these density-call budgets; the supplied Gaussian diagnostic
illustrates a setting in which HMC moves help AIS. Neither result establishes a
general efficiency ordering. Two small source/timing descriptions need author-owned
clarification before reuse. They require neither new experiments nor an instructor
decision about technical correctness.

Reviewer `/root/l10_ais_technical_review`, 2026-10-16. Exact tested revision:
`50569027ffe14a63f93665978f917f92584f1452`, branch
`review/l10-ais-technical-20261016`, worktree
`/tmp/pml-l10-ais-review-20261016`. This is a **separate seeded review**, explicitly
informed by the builder's findings and source-error allegations; it is not a blind
review or independent discovery of those findings. Only this report is written
in the worktree. No pilot code/results, inputs, environment, Scope or production
artifacts were changed. The coordinator's 2026-10-16 envelope in
`/tmp/pml-course-development-20261014/Lectures/course_development_state.md`, the
worked-solution-authoring skill and shared backpressure protocol govern this task.

## Algorithm and assumptions

Write the unnormalized intermediate density as

$$
f_t(x)=q(x)^{1-\beta_t}f(x)^{\beta_t},\qquad
0=\beta_0<\cdots<\beta_T=1,
$$

where the base $q$ is normalized. The script draws $X_0\sim q$, accumulates
$W_t=W_{t-1}f_t(X_{t-1})/f_{t-1}(X_{t-1})$, then applies a transition preserving
$f_t/Z_t$ if $t<T$. Its query uses **the returned $X_{T-1}$ with $W_T$**. Omitting
the last move is correct; there is no missing final equilibration step. The last
weight changes the weighted endpoint law to the final target.

For any target-integrable $h$, weighted induction gives

$$
E[W_T h(X_{T-1})]=\int f(x)h(x)\,dx.
$$

At an intermediate step, multiplication changes the weighted measure from
$f_{t-1}$ to $f_t$; invariance preserves that measure under the subsequent move.
This proves unbiasedness of the normalizer estimate $N^{-1}\sum_iW_i$ and of
the weighted numerator. It does not make their ratio unbiased, nor make unweighted
endpoints posterior draws. With independent trajectories, finite first moments
and positive finite $Z$, the laws of large numbers give consistency of the ratio.
Stationarity of the actual evolving trajectory at every intermediate temperature,
mixing before advancing the schedule, and ergodicity of every intermediate kernel
are unnecessary for this identity. They can matter greatly for finite-budget
performance.

Here support and first-moment assumptions hold: both $q$ and $f$ are strictly
positive on $\mathbb R^2$, and the logistic likelihood is bounded above by one
under a proper Gaussian prior. The schedule and kernel parameters are fixed.
The symmetric random-walk MH transition uses the correct intermediate log-density
difference and retains rejections. The HMC transition refreshes standard Normal
momentum in fixed whitened coordinates, uses reversible, volume-preserving
leapfrog with final momentum flip, and includes the Hamiltonian MH correction.
Its cached target gradient is combined with the current temperature and Gaussian
base gradient correctly. These establish invariant ideal-arithmetic kernels;
the finite-difference and reversal replays corroborate their implementation.

The fixed transformation $w=m+Lz$ includes $\log|L|$ in the target, while
`logq(z)` is the normalized two-dimensional standard Normal. Thus its normalizer
is the same $\int f(w)\,dw$ as the L09 reference. The omitted original prior
constant is $1/(8\pi)$, so marginal log evidence requires subtracting
$\log(8\pi)$ from the log-normalizer. The script reports `logZhat`, but
**the unbiased quantity is `exp(logZhat)`, not `logZhat`**. The current report
does not incorrectly claim log-unbiasedness; keep this distinction in later
student material.

## Source verification

I checked the actual Murphy PDF against its recorded SHA256
`54d6bfa8cc4a367bb553bea1c5127ca63696a9655b2ca1f6137a8584dccfdbaf`,
read the corresponding extraction and visually inspected complete printed
pp.493-494 (PDF pages 527-528). Edition: *Probabilistic Machine Learning:
Advanced Topics*, MIT Press 2023, online version December 10, 2025.
The relevant source defects are printed, rather than extraction artifacts:

- The transition paragraph specifies invariance of $p_0$ instead of each
  kernel's own $p_j$.
- Its generation paragraph moves from the initial base draw before the first
  displayed weight ratio is evaluated. These instructions and Eq.11.45 do
  not define valid AIS in general. For the stated one-step target-refresh
  counterexample, $f/(qZ)=\exp(X-1/2)$ under $X\sim N(1,1)$, so the expected
  normalizer ratio is $e$, rather than one. New deterministic integration
  returned `2.7182818284590455` (difference from $e$: `4.44e-16`).
- Eq.11.46 visibly skips from reverse $T_0$ to reverse $T_2$.
  Eq.11.49 visibly pairs $T_2$ with $(v_2,v_1)$ before ending with
  $T_0(v_1,v_0)$: this skips $T_1$ in the displayed transition sequence.
  Eq.11.50 reverses its final conditional direction.
- The sentence following Eq.11.51 swaps the earlier prior/posterior roles.
  The displayed mean weight estimates $Z_0/Z_n$ in that section's convention.
  Taking its reciprocal is a different estimator, generally biased at finite
  sample size; relabeling the mean does not reverse the ratio.

**S1, author-owned advisory repair:** `source_check.md` item 3 currently describes
Eq.11.49 as finishing with an inconsistent $T_0$. The skipped/misaligned factor
should be located explicitly as above. A final target-preserving $T_0$ is not
inherently forbidden: an optional correctly weighted final move is valid. Retain
the overall finding that these products cannot be copied literally, while
avoiding an implication that the symbol $T_0$ itself proves the defect. This is
a precision repair to the source record, with no code/result change.

The primary cross-check was Neal, *Annealed Importance Sampling*, Technical
Report 9805, September 1998 revision, **Section 2, printed pp.4-5, Eqs.3-10**.
I visually inspected those complete pages in the recorded PDF, SHA256
`29ab10a694ad5062ab141bf8e60d4e03e8555af62e960e32b4ccc5639257340f`.
Its base draw $x_{n-1}\sim p_n$, subsequent use of $T_{n-1}$ to produce
$x_{n-2}$, and weight-state pairing agree with the pilot after reindexing.
Neal expressly requires each transition's own invariant law and does not require
each intermediate transition to be ergodic. The [author's source page](https://glizen.com/radfordneal/ais.abstract.html)
confirms the revision and 2001 journal publication; the [primary PDF](https://glizen.com/radfordneal/ftp/ais-rev.pdf)
is the focused reading route. The pilot's HMC algebra was checked directly;
this review did not re-audit every inherited Murphy HMC erratum.

## Tail qualification and task-query implications

The builder's direct-IS infinite-second-moment conclusion is correct. For finite
logistic design rows $x_i$, each log likelihood term lies between
$-\log2-|x_i^Tw|$ and zero. Consequently

$$
\log f(w)=-\|w\|^2/8+O(\|w\|),\qquad
\log\{f(w)^2/q(w)\}=w^TAw+O(\|w\|),\quad
A=\tfrac12C^{-1}-\tfrac14I.
$$

The inherited covariance has eigenvalues
`0.2602827607142514, 0.4649735004311616`; the eigenvalues of $A$ are
`0.8253300984601465, 1.6709877697160267`. Since $A$ is positive definite,
a positive quadratic lower bound eventually dominates the likelihood's negative
linear bound. The integral $\int f^2/q$ diverges. Thus ordinary direct-IS
normalizer estimates have infinite variance for every finite positive particle
count, despite support coverage and finite means. The apparent stability of
these 24 repetitions cannot establish a finite normalizer RMSE in the population.
The report correctly calls its values **empirical finite-replicate RMSEs**.

For the five sigmoid queries, self-normalized estimates stay in $[0,1]$, so each
fixed-$N$ query estimate has finite variance and mean squared error. First-moment
conditions give consistency. This does not restore the usual square-root-$N$
finite-variance CLT: on an open tail cone each nonconstant sigmoid tends to zero
or one, whereas its posterior mean is strictly between them. Hence the usual
CLT numerator integral $\int f^2(h-E_ph)^2/q$ also diverges here. Retain the
distinction between bounded finite-$N$ query error and an unavailable ordinary
asymptotic variance formula. No AIS finite-variance result has been proved by
this pilot, and none should be inferred from its high weight-ESS fractions.

For the Gaussian mechanism, the stated analytic relative second moment is
$E_q[(W/Z)^2]=e^9/(\sqrt{.25}\sqrt{1.75})$, giving relative normalizer SD
`0.6114176348643307` at `N=32768`. It is specifically the second moment of
**normalized** weights; the unnormalized $E[W^2]$ includes $Z^2=\pi^2$.
The report uses it correctly in the relative-SD formula. Its warning that 24
replicates can miss rare large weights is warranted.

## Provenance, cost and empirical conclusions

The source-input hashes, frozen values and current L09 handoff support the stated
continuity: the proposal is the **supplied full-family diagnostic fit**, not
the student's proposed diagonal fit or a newly optimized AIS proposal. I read
L09's `challenger_handoff_review.md` at `39dd5dc` and the previous numerical
review at `dcf2a81`. Their model, response, prior, standardized coordinates and
bounded query references match the pilot. The original 23-row erosion-or-blowby
data and all four imported L09 input hashes match. No held-out prediction,
calibration, catastrophic-failure probability or operational accuracy requirement
is established. Numerical-reference agreement remains qualified float64 evidence,
not interval certification of arbitrary moments/tails. This review reused that
reference rather than rerunning its grid.

A separate direct JSON comparison also returned `True` for the imported metadata,
full and diagonal `fits[family]['diagnostic_fit']` objects, the selected stored
grid reference, tail-bound qualification and proxy-query quadrature objects.
The stochastic-fit runs are not the imported proposals.

Density-call arithmetic is correct: IS costs $N$ target values, MH-AIS costs
$NT$, and four-step HMC-AIS costs $N[1+4(T-1)]$ values and the same number of
gradients. Floor division explains the small unused budgets. Cached quantities
are reused correctly. The accounting makes gradients visible rather than
equating their work with scalar evaluations; no cross-method equal-wall-time
benchmark follows. A common inherited fit is an appropriate conditional input
for this comparison, but not an end-to-end claim that fitting is free.

**C1, author-owned advisory repair:** `run()` draws the initial $N$ base samples
before starting its timer. Accordingly wall time includes target/query/move work
but excludes initial base generation (and object construction/loading). State
this explicitly wherever timings are described as run costs. Direct IS uses
many more initial draws, so this omission is relevant to a precise time comparison.
The present conclusions use density budgets and already disclaim machine/batching
effects; no timing rerun is necessary for those conclusions.

All 15 stored summary groups recompute exactly from the raw repetitions. At the
larger budget the reported 60-degree RMSEs, `.00130` for IS versus
`.00293/.00581/.00452/.01015` for the four AIS choices, accurately describe this
experiment. ESS **fraction** improves while absolute independent trajectory count
falls sharply. The Gaussian diagnostic's HMC-AIS improvements are also present
in the raw data. They establish a mechanism example at fixed settings, not
practical competence on another learning problem or an AIS guarantee. No adverse
run was hidden in these summaries. The report's conditional application/payoff
conclusion is technically defensible and should survive condensation.

## Selective replay record and remaining boundary

Execution used the existing repository interpreter with no installation:

```text
OPENBLAS_NUM_THREADS=1 OMP_NUM_THREADS=1 /home/opher/Repositories/ProbabilisticMachineLearning/.venv/bin/python -B /tmp/pml_ais_seeded_review_replay.py > /tmp/pml_ais_seeded_review_replay.json
```

The script imports the checked source without calling its file-writing `main`.
No full experimental grid, new configuration search or new model was run.
For each problem the following selected larger-budget runs reproduced every
numeric estimate, acceptance statistic, weight statistic and call count exactly;
wall times were deliberately excluded from matching:

| Problem | Method/stages | Seed | Trajectories | Values/gradients | Largest numeric difference |
|---|---|---:|---:|---:|---:|
| Challenger | IS/1 | 2100 | 32768 | 32768/0 | 0 |
| Challenger | MH/8 | 2111 | 4096 | 32768/0 | 0 |
| Challenger | HMC/8 | 2100 | 1129 | 32741/32741 | 0 |
| Challenger | HMC/32 | 2111 | 262 | 32750/32750 | 0 |
| Gaussian mechanism | IS/1 | 2100 | 32768 | 32768/0 | 0 |
| Gaussian mechanism | MH/8 | 2111 | 4096 | 32768/0 | 0 |
| Gaussian mechanism | HMC/8 | 2100 | 1129 | 32741/32741 | 0 |
| Gaussian mechanism | HMC/32 | 2111 | 262 | 32750/32750 | 0 |

Other raw check outcomes: 15 input/artifact/source hash checks passed;
summary recomputation maximum difference `0`; transformed density identity maximum
difference `2.22e-16`; gradient finite differences `2.16e-10`; momentum-flipped
leapfrog involution `2.22e-16`; identity-move telescoping `3.55e-15`;
equal-base/target constant-weight error `0`. The one-step source counterexample
was independently integrated as described above. Scratch evidence identities:

- Replay script `/tmp/pml_ais_seeded_review_replay.py`, SHA256
  `b1c11767a6fcb86029177f7d5a36e4abe75d484680825c66e1ca1059414a109e`.
- Raw replay JSON `/tmp/pml_ais_seeded_review_replay.json`, SHA256
  `1e1608a7759618f0b42d3af2632642a7bd1a247733e238dbf10a551d04c320b5`.
- Checked `ais_pilot.py`, SHA256
  `1b2a385b1bc926f7e8e404bf880327c2fcec4d70e88e5fe41a7b733c027b0cc0`.
- Checked and unchanged `results.json`, SHA256
  `919cb2fbe57c4ab9c4a04870d67caeee5a812bdc2ee0f25bb4a6fc2d82a434a7`.

S1 and C1 are local author repairs. The application choice and whether a
conditional-payoff example meets the desired educational endpoint remain Scope
questions already identified by the builder, rather than newly discovered
correctness blockers. This review grants no application selection, final family
allocation, learner-time evidence, solved-Q&A/student notebook approval, hosted
Colab validation or publication readiness. No full fresh experimental grid,
rare-event convergence study, timing benchmark, independent VI fit or numerical
reference rebuild was performed.
