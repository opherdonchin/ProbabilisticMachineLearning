# L02 first-order Markov contract — teacher-only technical check

**Completed:** the corpus-independent finite-alphabet probe passed on 2026-10-14.
This establishes a technically consistent scoring and normalization route under
the stated conditions. It does not select or approve a worked solution, student
exercise, corpus, or generated sample. **L02-Q1 remains unanswered:** whether to
require a held-out independent-character comparison and failed-output diagnosis.
Its dependent contract change and final production remain blocked. This check
completed without that decision or successful L01 slide production.

## Dispatch receipt and boundary

| Field | Receipt |
|---|---|
| ID / owner | `L02-MARKOV-CHECK` / `/root/l02_independent_check`, dispatched by `/root` after real L02-Q1 deferral |
| Stage / mode | Existing `worked-solution-authoring` / bounded technical validation of an existing mathematical route; teacher-only feasibility |
| Base | `16423885e4bf6b4b4e8a0f4e642591f9832034f2` |
| Branch / worktree | `verify/l02-markov-contract-20261014` / `/tmp/pml-l02-markov-check-20261014`; clean at receipt, HEAD equals base |
| Frozen lecture input | `origin/fix/l02-retrospective-summaries@6872177f4223c57119f92036b0b178fd6f31a83f`, recovered by exact `git show` rather than relying on this worktree's lecture copies |
| Dependencies | Frozen first-order equations/conditions and read-only repository uv interpreter. Neither Q1, L01 production, a corpus download, nor a package installation is needed |
| Exact allowed writes | `Lectures/L02_Exponential_Families/reconciliation/markov_contract_check.md`; `Lectures/L02_Exponential_Families/reconciliation/markov_contract_probe.py` |
| Deliverable / acceptance gate | One actually executed standard-library probe and this mathematical/runtime receipt; root verifies allowed diff and commits. No merge or content promotion |
| Other owners | L02 recovery owns its `course_review.md`; L03 recovery owns its report. External sessions reserve L01 and L04–L12/shared scope/slide skills, APIs, architecture and maps. All other tracked paths and source worktrees were read-only |

The coordination index read at dispatch still marked this assignment "reserved,
not launched"; this receipt records the subsequent actual launch. It does not
change the index or any other owner's file.

### Exact recovered input objects

All four lecture objects below belong to frozen commit `6872177f4223c57119f92036b0b178fd6f31a83f`.

| Input | Git blob |
|---|---|
| `section_design.md`, Section 8 | `bac0d8a29887f232b2895375019482fce189d706` |
| `slide_organization.md`, Section 8 and separate lecture notebook handoff | `cf3818f2b78cc49061620f7c65db39984a203fcb` |
| `slide_design.typ`, Section 8 first-order factorization, count likelihood, row MLE and scoring constraints | `243cca5f7b35e716ace7f0c41df139f2fff648c7` |
| `development_state.md`, approval/source provenance | `b298acb0f40f05fc5e8281ff5aaaf59b11868306` |

Read the worked-solution skill fully and its handoff template; read the
build-teaching-notebook separation contract fully. They distinguish correct
technical demonstration from later Q&A/student notebook decomposition. Read
the updated coordinator and active reservations at these exact file snapshots:

| File read | SHA-256 |
|---|---|
| `.agents/skills/worked-solution-authoring/SKILL.md` in repository checkout | `8fd6b03d5309dc805454edff2f316c81bdd383e9ec622a20bcdfe34f8b79d352` |
| `.agents/skills/build-teaching-notebook/SKILL.md` in repository checkout | `463a88d0010c96dfa86891a5d8b0240793769def53e941f713a31e288058a406` |
| `/tmp/pml-course-development-20261014/.agents/skills/course-development/SKILL.md` | `a2e66a82f5bd58b16b38812d6cf53f8d37dbdf739a369edc345b1a2d4203678c` |
| `/tmp/pml-course-development-20261014/Lectures/course_development_state.md` | `9d6cf5c3b4f9f87a6e8f9c206b1df27c343ddcbedaea2a7c7e00e4ea3f8c8df6` |

## Mathematical route and author-owned conditions

The frozen Section 8 states/motivates first-order factorization, works/applies
the categorical-row interpretation, and applies categorical estimation to
transition counts. It stops before stationary distributions. Smoothing is an
optional notebook extension; the scoring design explicitly says not to add
smoothing or likelihood-comparison exercises. The teacher-only comparator below
is a technical well-definedness check and does not change that contract.

Let the finite alphabet be \(\mathcal A\), the declared length be \(T\ge1\),
\(\pi_j=P(X_1=j)\), and \(A_{jk}=P(X_t=k\mid X_{t-1}=j)\). The transition
matrix is time homogeneous: \(A_{jk}\ge0\), \(\sum_k A_{jk}=1\). With normalized
\(\pi\), the joint model on the fixed sample space \(\mathcal A^T\) is

\[
p(x_{1:T}\mid\pi,A)=\pi_{x_1}\prod_{t=2}^T A_{x_{t-1},x_t}.
\]

For a declared starting symbol \(s\), the continuation model is instead on
\(\mathcal A^{T-1}\), with the prefix \(x_1=s\) fixed:

\[
p(x_{2:T}\mid X_1=s,A)=\prod_{t=2}^T A_{x_{t-1},x_t}.
\]

The first factor is omitted, rather than accidentally scoring \(T\) independent
choices after a fixed start. At \(T=1\), the empty continuation has probability
one. If \(\pi_s>0\), this is the conditional derived from the joint by dividing
by \(\pi_s\). If \(\pi_s=0\), the joint alone does not determine conditioning
on that null event; an externally fixed-start transition experiment must be
declared separately. Neither convention estimates \(\pi\) from transition
counts.

Row normalization gives total mass one for every fixed finite length: summing
over \(x_T\) removes the last transition factor because its row sums to one;
repeat to obtain \(\sum_{x_1}\pi_{x_1}=1\), or one for a fixed start. Enumeration
below is an exact short-length oracle for this argument, not a claim based on
Monte Carlo frequencies.

For independent observed sequences, transition counts sum **within** each
sequence, never across their boundaries. The conditional likelihood of their
transitions groups as \(\prod_{j,k}A_{jk}^{N_{jk}}\), with the log form
\(\sum_{j,k}N_{jk}\log A_{jk}\). Terms with \(N_{jk}=0\) contribute zero even
when \(A_{jk}=0\); they are omitted rather than numerically evaluating
\(0\times(-\infty)\). The unsmoothed row MLE is
\(\widehat A_{jk}=N_{jk}/N_j\) for \(N_j=\sum_kN_{jk}>0\).

A zero-count row is unidentified, not an all-zero categorical distribution and
not a reason to silently add pseudocounts. For a full joint over all strings,
every row reachable before the last position must be defined. A score also
needs a declared alphabet and all factors on that string; an out-of-alphabet
character is not assigned probability by these equations. Initial/terminal
symbols, text segmentation, alphabet/preprocessing, and empty-sequence treatment
are author-owned model/sample-space conditions. This probe uses fixed lengths,
no terminal token or model of length, and no empty joint sequence.

For scoring, \(\log p=\log\pi_{x_1}+\sum_{t=2}^T\log A_{x_{t-1},x_t}\), with
the extended-real convention \(\log0=-\infty\). A zero initial or transition
factor makes the product zero and the log score \(-\infty\); it is not a finite
error to repair by hidden smoothing. A held-out average log score containing
such a string is likewise \(-\infty\), so any eventual evaluation must disclose
support and start conventions. This observation does not choose Q1's exercise
requirement.

### Same-space independent-character comparator

For declared normalized categorical probabilities \(q\), the independent model
on the **same** \(\mathcal A^T\) is \(q(x_{1:T})=\prod_{t=1}^Tq_{x_t}\).
Its fixed-start continuation on the same \(\mathcal A^{T-1}\) is
\(q(x_{2:T}\mid X_1=s)=\prod_{t=2}^Tq_{x_t}\), when \(q_s>0\).
Thus both comparisons use the same number of random characters, alphabet and
length/start convention. Joint comparisons can reflect differing initial
distributions; conditional comparisons omit both initial factors. This supplies
a mathematically well-defined comparator, not a held-out experiment or evidence
that one model predicts better.

## Probe, exact values and actual execution

The probe's only inputs are explicit **course-constructed** values:

\[
\mathcal A=(a,b),\quad
N=\begin{pmatrix}3&1\\2&0\end{pmatrix},\quad
\widehat A=\begin{pmatrix}3/4&1/4\\1&0\end{pmatrix},\quad
\pi=(2/3,1/3),\quad q=(3/5,2/5).
\]

The comparator corresponds to separately constructed unigram counts \((3,2)\).
These values are not claims about Murphy, *The Time Machine*, baby names, or any
source dataset; neither \(\pi\) nor \(q\) is derived from the toy transition
counts. No random sampling is needed. `fractions.Fraction` and complete
`itertools.product` enumeration provide exact mass/score oracles. Floating
`math.log`/`math.exp` are checked against the exact products at relative tolerance
\(10^{-12}\); zero factors are handled explicitly.

- Implementation: [`markov_contract_probe.py`](markov_contract_probe.py).
- Probe SHA-256: `04c7762a460bcdebca8fc8139ecbdbd443f511809b961f32673702563cdbbf8e`.
- Interpreter invoked: `/home/opher/Repositories/ProbabilisticMachineLearning/.venv/bin/python`, read-only use of repository uv environment, Python `3.12.13`.
- Resolved interpreter: `/home/opher/.local/share/uv/python/cpython-3.12.13-linux-x86_64-gnu/bin/python3.12`.
- Resolved executable SHA-256: `021044895e95be79dc2f110367607e684119afbc8ce75f6f0eec94844e0acec7`.
- Dependencies: Python standard library only; no environment/package changes.
- Working directory: `/tmp/pml-l02-markov-check-20261014`.
- Exact command, exit status **0**:

```sh
/home/opher/Repositories/ProbabilisticMachineLearning/.venv/bin/python Lectures/L02_Exponential_Families/reconciliation/markov_contract_probe.py
```

Identifiable raw stdout from that execution:

```text
teacher-only; course-constructed; alphabet=(a,b); no smoothing
counts=((3,1),(2,0)); A=((3/4,1/4),(1,0)); pi=(2/3,1/3); q=(3/5,2/5)
exact row sums: (1,1)
T strings Markov_joint IID_joint Markov_given_a Markov_given_b IID_given_a IID_given_b
1 2 1 1 1 1 1 1
2 4 1 1 1 1 1 1
3 8 1 1 1 1 1 1
4 16 1 1 1 1 1 1
product/log agreement: 18 positive strings; 12 zero strings have -inf log score
aba: Markov joint=1/6, given a=1/4; IID joint=18/125, given a=6/25
ab/ba: Markov=1/6,1/3; IID=6/25,6/25
bb: Markov=0, log=-inf; IID=4/25
separate pi=(1,0): joint b=0, log=-inf; conditioning on b is not a joint-derived conditional
zero-count row rejected: row b unidentified: zero count total
boundaries: separate ab and ba yield counts=((0,1),(1,0)); no cross-boundary b->b
PASS: exact finite-length mass, declared starts, row constraints, extended-real scores, IID comparator
```

The `ab`/`ba` result illustrates order sensitivity for these declared parameters;
it does not say every Markov model distinguishes every permutation. The `bb`
result exposes unsmoothed support loss. The zero-count-row rejection and separate
sequence boundary calculation are author-correctness checks, not additional
student teaching commitments. No source claim was independently checked here;
source audits remain in the separately owned L02 recovery report.

## Bounded handoff and remaining gates

The method-level target is to validate the frozen count-and-normalize route's
probability semantics and score semantics before any chosen worked example uses
it. Given toy counts and separately fixed \(\pi,q\), the solution sequence is:
normalize observed rows; enumerate short fixed-length strings; compare exact
mass and exact products with log scores; expose zero support and start/boundary
conditions. There are no figures, new student APIs, latent variables, corpus
estimates, final exercises or generated samples in this handoff. It is bounded
technical evidence, not the authoritative completed worked solution for a
teaching notebook.

This establishes that the frozen first-order equations can be implemented
consistently and that an independent-character comparator can inhabit the same
declared sample space. It does not establish preprocessing correctness on a
chosen corpus, data coverage of every needed row, predictive performance,
meaningful generated text, practical student familiarity, or one-hour exercise
feasibility. No local notebook run or hosted Colab run has occurred or is claimed.

A subsequently authorized chosen worked solution still needs exact data and
boundary/alphabet/start records, its complete end-to-end outputs and source
validation, then a worked-solution handoff. Q1-dependent evaluation requirements
must wait for the instructor decision. Teaching-notebook decomposition, the
student-hour check, a clean local uv notebook execution and a fresh hosted Colab
run are separate remaining gates before publication. A script pass cannot
substitute for those checks, and unfinished L01 slides do not invalidate these
corpus-independent results.

**One next permissible action:** root reviews this two-file diff and execution
receipt and commits the bounded evidence. L02-Q1 stays in its existing deferred
queue; this task raises no new consequential instructor choice.
