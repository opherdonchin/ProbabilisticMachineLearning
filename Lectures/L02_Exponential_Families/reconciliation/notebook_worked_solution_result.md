# L02 baby-name bigram worked solution — teacher-only result

## Task envelope recorded before implementation

| Field | Receipt |
|---|---|
| ID / owner | `L02-WORKED-SOLUTION` / delegated agent `/root/l02_worked_solution`; coordinator `/root` |
| Stage / mode | Existing `worked-solution-authoring`, build of one bounded technical example; no student Q&A authoring |
| Base / target | `c8e9b2af715a890d236a7ee10202d4ce27a677b7`, branch `resume/l02-notebook-contract-20261015`, worktree `/tmp/pml-l02-notebook-contract-20261015` |
| Accepted input | Section 8 notebook handoff and `development_state.md` at the base: instructor's 2026-10-15 L02-Q1 answer, “I think the notebook will be sufficient without the expansion.” Required fit / inspect / score / generate; held-out independent-character comparison and failed-output diagnosis optional |
| Frozen dependencies | Section/slide design at `6872177f4223c57119f92036b0b178fd6f31a83f`; source recovery `9e02665:Lectures/L02_Exponential_Families/reconciliation/course_review.md`; prior corpus-independent probe `dbaa1cdb638b60bceadc0352c43382703c085471` is evidence only, not validation of this real-data example |
| Skills actually read | Existing worked-solution skill and handoff template, build-teaching-notebook separation contract, lecture-development, course-development and shared backpressure under `/tmp/pml-course-development-20261014/.agents/skills/` |
| Exact allowed tracked writes | `InClass/Preparation/lecture2_bigram_worked_solution.py`; `InClass/Preparation/lecture2_bigram_worked_solution_handoff.md`; this report. Optional `InClass/Preparation/figures/lecture2_bigram_counts.svg` only if useful; no figure currently planned |
| Runtime / data boundary | Read-only repository uv environment; no dependency installation or `.venv` changes. Pinned external data cached only under `/tmp`; no raw dataset committed |
| Expected result / gate | Executed NumPy/stdlib count-MLE example with explicit boundaries, in-sample scores, deterministic generation, actual-data mathematical checks, exact sources/results and structured handoff. Coordinator verifies allowed diff and commits; specialist leaves changes uncommitted |
| Reserved owners / exclusions | Other sessions reserve L01 and L04–L12 work. Root owns L02 contracts/register and routes architecture/maps. No skill, lecture, production, curriculum, whole-Scope approval, student-notebook, hosted-validation or publication change is authorized here |

Read-only source/runtime preparation preceded the recorded-decision handoff. Root
then supplied the exact implementation base and authorized these writes. Results
below distinguish executed local validation from outstanding notebook work.

## Result and acceptance boundary

**Completed:** one teacher-only real-data worked solution and structured handoff,
locally executed in the existing repository uv environment on 2026-10-15. The
required fit / inspect / score / generate route uses raw count MLE, with no
held-out/baseline/failure-diagnosis expansion. The count matrix and fitted rows
are exposed directly, not hidden behind fitting helpers. Inspection is a labeled
table; no optional figure was needed or generated.

Files produced:

- `InClass/Preparation/lecture2_bigram_worked_solution.py` — executable solution;
  SHA256 `529271e28be6d3b874a64f514a22d70c7df5e1d82c9d6d7d254a132c4a0d118f`.
- `InClass/Preparation/lecture2_bigram_worked_solution_handoff.md` — existing
  template's learning target, mathematics, inputs, flow, APIs, expected results,
  checks, manipulations, exclusions and outstanding validation; SHA256
  `46dd7abc42e32f7f9c44f0dc943b87d08f4d59e2ee100f91462fed31c36daab4`.
- This result report — dispatch and exact source/runtime evidence.

No whole-Scope, Q&A/self-work notebook, lecture-production or publication
acceptance is inferred. No class activity is recorded. Specialist changes remain
uncommitted for the coordinator's boundary review and commit. The technical
author and checker here are the same specialist; a separate feasibility or
pedagogical review has not run.

## Verified primary sources and exact versions

Source bytes were retrieved read-only during preparation, before implementation
was authorized. Immutable data were then fetched to `/tmp` by the actual script.
GitHub API file-commit records identified the pins; raw file bytes supplied the
hashes. No reference notebook, skill or lecture source was copied into this tree.

| Source | Immutable version / SHA256 | Verified use |
|---|---|---|
| [Karpathy bigram notebook](https://github.com/karpathy/nn-zero-to-hero/blob/56eda75ed81390151aa72466f1b78022ad2eb574/lectures/makemore/makemore_part1_bigrams.ipynb) | File commit `56eda75ed81390151aa72466f1b78022ad2eb574` (2022-09-08); 389057 bytes; `db2f139409bad2966baac06581b6ca8ec9a03668df50dd073577fd98b3be0045` | Cells 0, 8, 10, 13–14, 23–26 establish line data, 27-symbol `.name.` counts, row probabilities, sampling and log likelihood. Cell 23 adds one; later cells train a neural model. Those portions are deliberately excluded from the raw-MLE adaptation |
| [Karpathy names data](https://github.com/karpathy/makemore/blob/8f79bd0126eaef5eb82d346c9f85ae20ea1c476a/names.txt) | File commit `8f79bd0126eaef5eb82d346c9f85ae20ea1c476a` (2022-06-09); 228145 bytes; `0a30b5557f192f32ab962680889aac5f6fda0f4cecf40a6d0b5694f58ea8cc4d` | 32033 name lines, 196113 letters, lengths 2–15, lowercase ASCII alphabet a–z |
| [makemore README](https://github.com/karpathy/makemore/blob/988aa59e4d8fefa526d06f3b453ad116258398d4/README.md) | File commit `988aa59e4d8fefa526d06f3b453ad116258398d4`; `4a1bbf7ad7e3428dffe774d9b65497b394101082066428b8daf87d6361140acd` | Identifies the supplied names as derived from SSA's 2018 baby-name data. This attribution is the repository's statement; this task did not reconstruct its original SSA preprocessing or verify population representativeness |

Exact process resources read from the reserved course-development worktree:

| Resource | SHA256 |
|---|---|
| `worked-solution-authoring/SKILL.md` | `8fd6b03d5309dc805454edff2f316c81bdd383e9ec622a20bcdfe34f8b79d352` |
| `worked-solution-authoring/references/handoff-template.md` | `99aadea0b03efc1647e1c7540cdde574481f418ab3e995a7a01c56175a4c8c39` |
| `course-development/SKILL.md` | `a2e66a82f5bd58b16b38812d6cf53f8d37dbdf739a369edc345b1a2d4203678c` |
| `lecture-development/SKILL.md` | `3f5d6507dde8710a0aaeef56545db8883d055dd9e017aca4618dd6be8f7e94bb` |

The root prefix is `/tmp/pml-course-development-20261014/.agents/skills/`.
The build-teaching-notebook separation contract and shared backpressure were also
read; their instructions were not modified or copied.

## Mathematical contract and what was actually checked

The fixed initial context is `.`, reused as the END symbol at a different
occurrence. Each name is augmented separately as `.name.`. No transition crosses
two input rows; no terminal-to-start transition is invented. Empty names are not
observed, and the fitted `.→.` probability is zero. Each source line is weighted
once; birth counts are not present in the data file.

For the resulting counts, the categorical conditional log likelihood is

$$
\ell(A)=\sum_{j,k:N_{jk}>0}N_{jk}\log A_{jk},\qquad
\widehat A_{jk}=N_{jk}/N_j\quad(N_j=\sum_kN_{jk}>0).
$$

Positive-count terms implement the conventional $0\log0=0$ likelihood
contribution without numerical `NaN`. Zero-count rows are unidentified: code
leaves them undefined and raises rather than supplying a hidden prior. All
observed symbols in this actual dataset have an observed outgoing row because
END is counted, so this exception was not needed during the real-data run.
Zero cells in identified rows remain zero.

With the model fixed, the complete-name score multiplies the start-to-first,
interior and last-to-END factors; the log score sums their natural logarithms.
The denominator in mean NLL is $L+1$ transitions for a name of $L$ letters.
This is a variable-length complete-name probability, not a length-conditioned
string score. Training likelihood is a fit summary; it is not evidence of
held-out predictive performance. The first-order model discards longer context
and does not provide parameter uncertainty. A new character outside a–z is
outside this declared sample space, rather than an extra zero-probability row.

**Actual termination check:** every fitted letter row has positive END
probability. Let
$\delta=\min_{j\ne\texttt{.}}\widehat A_{j,\texttt{.}}
=0.024482758620689655>0$. After a letter, surviving $m$ further draws is bounded
by $(1-\delta)^m\to0$. Thus generation terminates almost surely for these fitted
rows. Solving $(I-Q)b=r$ numerically gave letter-state termination probabilities
within `1e-12` of one and start-weighted finite-name mass
`1.000000000000000`. The 80-letter cap is only an execution guard; censored
prefixes would be explicitly labeled and are not silently treated as complete
names. This is distinct from claiming that row normalization alone guarantees
variable-length normalization, or that a cap proves it.

Counting costs $O(M)$ for $M$ boundary-aware transitions, with $O(K^2)$ parameter
storage. Repeated grouped likelihood queries use the counts instead of scanning
raw data; scoring one name uses $O(L)$ factors. The demonstration retains the
raw names for direct checks, so its actual total memory is $O(M+K^2)$. These
computational savings do not validate the first-order assumptions.

## Exact clean execution and raw output

Working directory: `/tmp/pml-l02-notebook-contract-20261015`.
The existing repository environment was used read-only: no sync, installation,
lockfile update, `.venv` change or system-Python dependency installation.
`-B` suppresses Python bytecode files; uv's cache location is outside the tree.

```bash
UV_CACHE_DIR=/tmp/pml-l02-uv-cache uv run --no-sync --project /home/opher/Repositories/ProbabilisticMachineLearning python -B /tmp/pml-l02-notebook-contract-20261015/InClass/Preparation/lecture2_bigram_worked_solution.py
```

Exit status **0**. The following output is retained as raw execution evidence:

```text
Python 3.12.13; NumPy 2.0.2
Data: /tmp/pml-l02-bigram/names-8f79bd0126eaef5eb82d346c9f85ae20ea1c476a.txt; sha256=0a30b5557f192f32ab962680889aac5f6fda0f4cecf40a6d0b5694f58ea8cc4d
Names=32033; letters=196113; length range=2..15
Alphabet=.abcdefghijklmnopqrstuvwxyz; matrix shape=(27, 27); transitions=228146
Row totals: .:32033, a:33885, b:2645, c:3532, d:5496, e:20423, f:905, g:1927, h:7616, i:17701, j:2900, k:5040, l:13958, m:6642, n:18327, o:7934, p:1026, q:272, r:12700, s:8106, t:5570, u:3135, v:2573, w:929, x:697, y:9776, z:2398
Rows = previous symbol; columns = next symbol. '.' means END in a column.
After '.' (N_j=32033): 'a': count=4410, p=0.13767053; 'k': count=2963, p=0.09249836; 'm': count=2538, p=0.07923079; 'j': count=2422, p=0.07560953; 's': count=2055, p=0.06415259
After 'a' (N_j=33885): '.': count=6640, p=0.19595691; 'n': count=5438, p=0.16048399; 'r': count=3264, p=0.09632581; 'l': count=2528, p=0.07460528; 'h': count=2332, p=0.06882101
After 'q' (N_j=272): 'u': count=206, p=0.75735294; '.': count=28, p=0.10294118; 'a': count=13, p=0.04779412; 'i': count=13, p=0.04779412; 'w': count=3, p=0.01102941
Training log likelihood=-559873.5896427280 nats
Training mean negative log score=2.4540144892 nats/transition (includes start/end)
These are in-sample fit summaries, not held-out predictive performance.
Name='emma': p=3.47821378599e-06; log score=-12.5689916758 nats; mean NLL=2.5137983352 nats/transition
Name='olivia': p=2.48313463344e-08; log score=-17.5111590168 nats; mean NLL=2.5015941453 nats/transition
Name='andrej': p=5.76839145948e-10; log score=-21.2734576648 nats; mean NLL=3.0390653807 nats/transition
Name='zzyzx': p=2.61182991746e-11; log score=-24.3683849295 nats; mean NLL=4.0613974882 nats/transition
Support check: 'bf' contains unobserved 'bf'; p=0; log score=-inf
An out-of-alphabet character is outside this model's sample space; reject it rather than index a row.
Minimum letter-to-END probability=0.0244827586; finite-name mass=1.000000000000000
Generated names: PCG64 seed=2147483647; cap=80 letters
  'dulike' [END]
  'zoshan' [END]
  'car' [END]
  'ssloysthierana' [END]
  'alah' [END]
  'jamay' [END]
  'bey' [END]
  'm' [END]
  'aucerve' [END]
  'imieemmy' [END]
  'ciei' [END]
  'xavene' [END]
PASS: pinned data, independent counts, boundaries, row MLE, likelihood equivalence, support and termination.
```

## Additional actual-data checks

A second clean Python process imported this script with `importlib.util`, ran
`main(DEFAULT_DATA_PATH)` twice with captured stdout and checked:

1. Byte-identical cached stdout and generated outputs.
2. Four complete-name probabilities against exact `fractions.Fraction` products
   of the fitted integer count ratios, relative tolerance `2e-15`.
3. Likelihood loss for normalized candidate rows
   $A^{(\epsilon)}=(1-\epsilon)\widehat A+\epsilon\mathbf1/K$ at
   $\epsilon\in\{0.001,0.01,0.1\}$. These are teacher-only optimizer checks,
   not a new student model-comparison task or held-out baseline.
4. Count support, maximum row/count residuals, and actual END status of samples.

The exact supplementary command used returned arrays and generated no files:

```bash
UV_CACHE_DIR=/tmp/pml-l02-uv-cache uv run --no-sync --project /home/opher/Repositories/ProbabilisticMachineLearning python -B - <<'PY'
import contextlib,hashlib,importlib.util,io,math
from fractions import Fraction
from pathlib import Path
import numpy as np
path=Path('/tmp/pml-l02-notebook-contract-20261015/InClass/Preparation/lecture2_bigram_worked_solution.py')
spec=importlib.util.spec_from_file_location('l02',path); module=importlib.util.module_from_spec(spec); spec.loader.exec_module(module)
outputs=[]; results=[]
for _ in range(2):
    buf=io.StringIO()
    with contextlib.redirect_stdout(buf): result=module.main(module.DEFAULT_DATA_PATH)
    outputs.append(buf.getvalue());results.append(result)
assert outputs[0]==outputs[1]
r=results[0];N=r['N'];A=r['A_hat'];counts=r['N_j'];stoi={s:i for i,s in enumerate(r['alphabet'])}
print('cached_repeat_stdout_sha256',hashlib.sha256(outputs[0].encode()).hexdigest())
print('repeat_generated_identical',results[0]['generated']==results[1]['generated'])
print('positive_cells',int((N>0).sum()),'zero_cells',int((N==0).sum()))
print('max_row_sum_error',float(np.max(np.abs(A.sum(1)-1))))
print('max_fitted_count_error',float(np.max(np.abs(counts*A-N))))
for word in ['emma','olivia','andrej','zzyzx']:
    exact=Fraction(1)
    factors=[]
    for p,f in zip('.'+word,word+'.'):
        j,k=stoi[p],stoi[f];exact*=Fraction(int(N[j,k]),int(counts[j,0]));factors.append(A[j,k])
    assert math.isclose(float(exact),math.prod(factors),rel_tol=2e-15)
print('exact_fraction_score_checks',4)
positive=N>0
for epsilon in [0.001,0.01,0.1]:
    candidate=(1-epsilon)*A+epsilon/len(A)
    ll=float(np.sum(N[positive]*np.log(candidate[positive])))
    deficit=r['train_log_likelihood']-ll
    assert deficit>0
    print('row_simplex_perturbation',epsilon,'log_likelihood_loss_nats',format(deficit,'.12f'))
assert all(ended for _,ended in r['generated'])
print('generated',len(r['generated']),'ended',sum(ended for _,ended in r['generated']))
print('PASS independent teacher checks: repeated clean calls, exact scores, row-simplex perturbations')
PY
```

Exit status **0**. Raw output:

```text
cached_repeat_stdout_sha256 64225fb16d2e3c0545e613e82eb75574a8590707aaa9b8b0e2a85a210d5f1f93
repeat_generated_identical True
positive_cells 627 zero_cells 102
max_row_sum_error 1.1102230246251565e-16
max_fitted_count_error 2.2737367544323206e-13
exact_fraction_score_checks 4
row_simplex_perturbation 0.001 log_likelihood_loss_nats 11.632812811062
row_simplex_perturbation 0.01 log_likelihood_loss_nats 205.855119023356
row_simplex_perturbation 0.1 log_likelihood_loss_nats 5111.271242291434
generated 12 ended 12
PASS independent teacher checks: repeated clean calls, exact scores, row-simplex perturbations
```

The principal checks also live in the reference script itself, including the
entire-corpus direct likelihood agreement (absolute tolerance `1e-6` nats),
independent pair counts, boundary checks, row normalization and absorption
cross-check. The earlier toy probe was read as source evidence and was not
substituted for this practical execution.

## Remaining work and next owner

- Coordinator: verify the three-file write boundary, review the result and commit.
  Root owns the accepted contract/register and the separately routed architecture
  / planned-map wording synchronization; this specialist has not edited them.
- Teaching-notebook authoring, only when separately authorized: decompose the
  validated flow using the cumulative student-knowledge record, scaffold unfamiliar
  APIs, and derive self-work mechanically from the solved Q&A source. The current
  code is teacher-facing and does not establish one-hour student feasibility.
- Runtime owner: eventual local clean-kernel notebook execution **and** fresh
  hosted Colab `2026.07` CPU Restart/Run All. Neither is claimed here. The pinned
  data must be fetched or uploaded into the hosted `/content` filesystem.
- Optional smoothing, if later selected, must correct Murphy Book 2 Eq.2.279's
  posterior-mean/MAP labeling rather than propagate it; no such estimator was
  needed to complete this agreed endpoint.

No unresolved technical blocker or new instructor decision was found within
this bounded teacher-only task. The pending items are downstream validations
and acceptance boundaries, not requests to expand the required endpoint.
