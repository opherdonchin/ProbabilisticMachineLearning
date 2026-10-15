# L02 worked example — count-fitted baby-name bigrams

**Status:** teacher-only technical solution locally executed on 2026-10-15.
This is the worked-solution handoff, not an adapted student notebook or approval
of a complete reconciled Lecture Scope. The instructor's L02-Q1 decision at
`c8e9b2af715a890d236a7ee10202d4ce27a677b7` retains **fit / inspect / score /
generate** as the required endpoint. A held-out independent-character comparison
and failed-output diagnosis remain optional. The one-hour student allocation and
hosted Colab run have not been validated.

## Learning target

Fit an observed first-order character sequence model by applying categorical MLE
to each preceding-character row. Inspect actual transition counts/probabilities,
score complete names, and generate complete names from the same fitted rows.
This operationalizes sufficient-statistic estimation on real sequence data;
generation illustrates the fitted conditionals without establishing predictive
quality or realistic-name adequacy.

## Relevant lecture material

- Lecture / section: L02 Sections 7–8, categorical count-normalize estimation and
  first-order Markov estimation/scoring/generation; frozen design
  `6872177f4223c57119f92036b0b178fd6f31a83f` and the accepted notebook boundary above.
- Equations / notation: rows are preceding symbols, columns next symbols;
  $N_{jk}$ counts transitions within individual names, $N_j=\sum_kN_{jk}$, and
  $\widehat A_{jk}=N_{jk}/N_j$ for $N_j>0$. Conditional-on-start log likelihood is
  $\ell(A)=\sum_{j,k:N_{jk}>0}N_{jk}\log A_{jk}$.
- Concepts that must remain aligned: observed transition counts are sufficient
  for the tied categorical rows; no gradient optimizer is needed. An observed
  row with a zero cell has a boundary MLE, whereas a wholly unobserved row is
  unidentified. Neither situation implies a finite natural/logit coordinate.

The lecture's initial-state factor is resolved here by **fixing** the start to
`.`. For a name $x_1\ldots x_L$,

$$
p(x_1\ldots x_L\mid X_0=\texttt{.},\widehat A)
=\widehat A_{\texttt{.},x_1}
 \left(\prod_{t=2}^L\widehat A_{x_{t-1},x_t}\right)
 \widehat A_{x_L,\texttt{.}}.
$$

The terminal draw stops the sequence. This is a probability of the complete
variable-length name, including termination; it is not a probability conditional
on its length. The initial distribution is a point mass on the start context,
not estimated from ordinary transition counts. `.` is reused for start/end in
the reference's convention; no terminal-to-start transition is counted.

## Starting information

- Given quantities: an immutable, hash-verified text file from Karpathy's
  `makemore` repository; NumPy and standard-library functionality.
- Observed quantities: 32,033 lowercase name lines containing 196,113 letters;
  lengths 2–15; alphabet `abcdefghijklmnopqrstuvwxyz`. Each line receives equal
  weight. Birth counts, sex labels and a sampling design are not present in
  this file, so the result models these rows rather than birth frequencies.
- Unknown / latent quantities: the transition matrix $A$ is unknown and fitted;
  there are no hidden states, missing characters or latent-variable inference.
- Deliberately fixed quantities: first-order context, alphabet inferred from the
  observed names, fixed start/terminal convention, unsmoothed estimator, all
  source rows used for fitting, PCG64 seed `2147483647`, generation guard of 80
  letters. A cached download lives outside the repository.

## Solution sequence

1. Read and verify the pinned data; establish its alphabet, rows and boundaries.
2. Count every `.name.` transition separately within each name into $N$; verify
   starts, ends, total transitions and an independent count representation.
3. Form row totals and divide each observed row to obtain the raw MLE. Preserve
   unidentified rows as undefined and stop with a clear error if encountered.
4. Inspect the actual row totals and the five largest count/probability entries
   after `.`, `a` and `q`. The arrays remain available for teacher inspection.
5. Compute grouped training log likelihood and check it against a separate direct
   per-name log-factor sum. Score four named strings with product/log agreement.
6. Verify a real zero-count transition has zero complete-name probability and
   log score $-\infty$. An out-of-alphabet character is outside this model's
   declared sample space; an adapted scoring API must reject it explicitly.
7. Check termination in this fitted model, then sample 12 names with the declared
   RNG and a transparent cap. A capped prefix must be labeled censored, never
   silently converted into an ended name.

## New computational tools or APIs

These are possible notebook scaffolding obligations, not new mathematical goals:

- Dictionaries for character/index correspondence and integer NumPy indexing.
- `zip` on offset sequences for adjacent pairs; `Counter` is only an author check.
- `sum(axis=1, keepdims=True)` and broadcasting for **row** normalization.
- Boolean masks and `np.log` for positive-count likelihood terms, avoiding
  numerical `0 * log(0)`; explicit $\log0=-\infty$ for scores.
- `np.random.Generator(np.random.PCG64(seed)).choice(..., p=row)` for a categorical
  draw. NumPy's seeded output differs from Torch's even for the same seed.
- Hash verification and downloading are supplied infrastructure. The linear
  solve used to check termination is author validation, not required student work.

## Reference implementation

- File: `InClass/Preparation/lecture2_bigram_worked_solution.py`.
- Entry: run the script; `main()` contains the mathematical flow and returns the
  fitted arrays/values for teacher inspection. `read_names()` hides only I/O.
- Default fetch: immutable URL
  `https://raw.githubusercontent.com/karpathy/makemore/8f79bd0126eaef5eb82d346c9f85ae20ea1c476a/names.txt`.
- Default cache:
  `/tmp/pml-l02-bigram/names-8f79bd0126eaef5eb82d346c9f85ae20ea1c476a.txt`.
  An existing copy can be passed via `--names-path`; the same hash is mandatory.
- Data SHA256:
  `0a30b5557f192f32ab962680889aac5f6fda0f4cecf40a6d0b5694f58ea8cc4d`.
- Primary reference: [Karpathy's bigram notebook](https://github.com/karpathy/nn-zero-to-hero/blob/56eda75ed81390151aa72466f1b78022ad2eb574/lectures/makemore/makemore_part1_bigrams.ipynb).
  Notebook SHA256:
  `db2f139409bad2966baac06581b6ca8ec9a03668df50dd073577fd98b3be0045`.
  Its count model motivates the adaptation; its add-one smoothing, Torch runtime
  and neural/gradient model are not part of this solution.

## Expected outputs

### Numerical

- Matrix shape `(27, 27)`, 228,146 transitions, 627 positive cells and 102 zeros.
  There are 32,033 start transitions and 32,033 terminal transitions;
  $N_{\texttt{.},\texttt{.}}=0$.
- Example: $N_{\texttt{q},\texttt{u}}=206$, $N_{\texttt{q}}=272$, giving
  $\widehat A_{\texttt{q},\texttt{u}}=0.7573529411764706$.
- Training log likelihood: **−559873.5896427280 nats**. Training mean negative log
  score: **2.4540144892 nats per transition**, including start/end factors. This
  denominator is 228,146, not the number of names or interior bigrams.
- Complete-name scores:

| Name | Probability | Log score (nats) |
|---|---:|---:|
| `emma` | `3.47821378599e-06` | `-12.5689916758` |
| `olivia` | `2.48313463344e-08` | `-17.5111590168` |
| `andrej` | `5.76839145948e-10` | `-21.2734576648` |
| `zzyzx` | `2.61182991746e-11` | `-24.3683849295` |

- Actual support check: `bf` has zero model probability because the `b→f`
  transition is unobserved; its log score is $-\infty$. No epsilon is inserted.
- Actual generated output, in order, all terminated:
  `dulike`, `zoshan`, `car`, `ssloysthierana`, `alah`, `jamay`, `bey`, `m`,
  `aucerve`, `imieemmy`, `ciei`, `xavene`.

### Figures

No generated figure is required for this bounded worked solution. Labeled count /
probability rows provide inspection; the full arrays are exposed for a later
notebook presentation choice. No stale or unverified figure is supplied.

## Validated equivalences or checks

- The entire matrix equals independently accumulated bigram counts; all starts
  and ends are preserved and no name boundaries are crossed.
- Maximum row-sum error: `1.1102230246251565e-16`; maximum reconstructed-count error
  in $N_j\widehat A_{jk}=N_{jk}$: `2.2737367544323206e-13`.
- Grouped likelihood equals the direct sum across every name within absolute
  tolerance `1e-6` nats. Four example probabilities also match exact rational
  products of integer counts within relative tolerance `2e-15`.
- Three positive simplex perturbations of the MLE all reduced the training log
  likelihood. This is a numerical check, not a substitute for categorical MLE's
  constrained optimization argument.
- Two repeated cached executions produced identical output and generated names.
- Every actual letter row has positive terminal probability. With
  $\delta=\min_{j\ne\texttt{.}}\widehat A_{j,\texttt{.}}
  =0.024482758620689655>0$, survival for $m$ further draws after a letter is at
  most $(1-\delta)^m\to0$. Thus these fitted rows terminate almost surely. A
  cross-check solves $(I-Q)b=r$, where $Q$ contains letter-to-letter transitions
  and $r$ the terminal column: $b\approx\mathbf1$ and start-weighted finite-name
  mass is `1.000000000000000` (tolerance `1e-12`). The cap does not prove this.

Counting takes $O(M)$ for $M$ boundary-aware transitions and the dense parameter
table costs $O(K^2)$ storage. Repeated grouped likelihood queries use the counts
rather than revisiting all names; scoring a name takes $O(L)$ factors. This
script additionally retains the raw name list for direct checks, so its total
memory is $O(M+K^2)$. First-order conditioning discards longer context, and fitting
does not estimate uncertainty or establish held-out accuracy.

## Useful manipulations

1. **Permute whole name rows.** The fitted counts, scores and seeded generated
   output should be unchanged. This tests that independent sequence boundaries
   are preserved rather than names concatenated into a single text stream.
2. **Alter a name's internal order.** Counts for affected adjacent pairs change;
   fitting depends on these transitions rather than only single-character totals.
3. **Score a string containing an unobserved transition.** The raw MLE gives
   probability zero and log score $-\infty$; a finite result would require a
   different declared estimator. This is an optional mechanism manipulation,
   not a required held-out comparison or failed-output diagnosis exercise.

## Deliberate exclusions

- No required hold-out split, independent-character baseline, failed-output
  diagnosis, new comparison exercise, neural model, gradient fitting, stationary
  distribution treatment or smoothing estimator.
- No claim that generated names are new, realistic, representative of births,
  or evidence of predictive success. Sample strings are unedited outputs.
- No new student Q&A, student self-work notebook, lecture slides or speaker notes.
- Optional Dirichlet work must distinguish posterior mean from MAP: for a
  symmetric $\operatorname{Dir}(\alpha\mathbf1)$ prior the rule
  $(N_{jk}+\alpha)/(N_j+K\alpha)$ is the **posterior mean**. Murphy Book 2
  §2.6.3.3 Eq.2.279 labels it MAP; that label must not be copied. An interior MAP
  instead subtracts one from each posterior concentration, when all exceed one.

## Runtime or technical caveats

The script passed in the existing repository uv environment, Python 3.12.13 /
NumPy 2.0.2, with no package installation or environment change. Exact run and
raw results are recorded in
`Lectures/L02_Exponential_Families/reconciliation/notebook_worked_solution_result.md`.
No notebook has been executed; hosted Colab 2026.07 CPU validation, clean
Restart/Run All of the eventual notebook, student-hour feasibility and student
API scaffolding remain outstanding. External data must be fetched or uploaded
into the hosted runtime; the local `/tmp` cache is not available there.

## Notes for pedagogical decomposition

Preserve the accepted endpoint and supplied I/O/setup. Keep the count loop,
row-normalization axis, selected probability factors and log-score denominator
visible. Distinguish the likelihood function from a fixed-model score; the
reported training average is not out-of-sample evidence. Preserve the fixed
start and explicit END factors consistently in fit, score and generation.
Termination proof/linear algebra and extra author checks can stay teacher-facing;
no additional student treatment is approved by their validation. The solved Q&A
will own pedagogy if separately authorized; the self-work notebook must then be
mechanically derived rather than authored independently.
