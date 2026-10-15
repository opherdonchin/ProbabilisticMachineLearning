# L08 — Recovering hidden states in a sequence: looking forward and backward

**Instructor direction — 2026-10-15:** The instructor supports extending the
categorical-HMM lecture's logic to **Gaussian time series in the notebook**,
conditional on the lecture's categorical focus. The current live proposal below
already includes a short Kalman predict/condition comparison; it does not derive
a complete Gaussian filter or smoother. This is support in principle for a
lecture-to-notebook transfer, not selection of a dataset, Gaussian smoothing depth,
parameter-learning method, student/supplied allocation, workload or full Scope.
The [bounded handoff proposal](reconciliation/gaussian_handoff.md) explains the
mathematical connection and [development register](development_state.md) records
remaining decisions and validation.

The instructor identifies the PS2 question sheet as **Oke's course material** and
says the named forecasting notebook may be obtainable from him. This records
source availability, not a recovered executable notebook or permission to contact
him. N4SID is an additional procedure for identifying state-space model parameters
from data; it is separate from Kalman inference with a specified model. Supplying
specified or previously fitted parameters is a recommendation for bounding the
notebook, not an approved learning allocation.

**Effect on the body below:** The categorical lecture and its short Gaussian
comparison remain the baseline under review. The old assertion that the notebook
must repeat HMM forward/backward implementation is reopened by the Gaussian
transfer direction. Its replacement handoff and any affected live preparation
remain provisional. The old either-HMM-or-full-forecasting comparison does not
rule out a bounded Gaussian-transfer notebook. No RTS smoother, N4SID training,
new full lecture plan, section/slide development or student notebook is authorized
by this narrow record. Existing reviews and author probes retain their original
targets; no whole-Scope or measured teaching-time validation is implied.

**Status:** Rewritten for an instructor familiar with the course through L03–L04. The [course register](../course_architecture_scope/STATUS.md) records the exact current review and instructor-decision status. Lecture times are estimates; future notebooks have not been implemented or run.

Imagine watching a sequence of die rolls without knowing when the casino switches from a fair die to a loaded one. We want the probability of each hidden die choice, given the rolls. A calculation using only rolls seen so far can support a live decision. A calculation using the whole sequence can revise earlier beliefs. This lecture shows how both calculations can be exact without listing every possible history.

The model is called a **hidden Markov model (HMM)**. “Hidden” means the state is unobserved; “Markov” means the next state depends on the current state rather than the whole past. The main new skill is to reuse partial probability calculations along this chain. Students also see a short comparison with a **Kalman filter**, which performs the same predict-then-condition steps when states and observations are Gaussian rather than categorical.

**What earlier lectures supply:** L01 taught Gaussian conditioning. The agreed L02 plan teaches categorical probabilities and transitions when the states are observed. L03 explains how a graph expresses a product of local probabilities. L07 distinguishes probabilities of individual unknowns from the most probable complete explanation. L06 supplies the idea of averaging over hidden quantities; it does not teach sequence algorithms. These later lectures are plans, not delivered coverage: if their prerequisites are missing when L08 is prepared, repair that gap explicitly. The protected delivery record remains B2 §2.3.2/B1 §3.3; L02's agreed section design, rather than its damaged progress metadata, establishes its planned boundary.

**Choice and cost:** Use the die example and a small checked model as the main lecture and notebook. This exposes the actual probability calculation with little data preparation or software setup. The alternative is to make Kalman filtering the main method and build a website-traffic forecasting exercise. That would add model fitting and data preparation, and the named solved forecasting notebook has not been verified. Choosing forecasting would require reducing the HMM work; it cannot be added as a second full lab. General inference on arbitrary graphs is also left out, because it adds decisions about which variables to eliminate and in which order.

The instructor's Oke PS2 question sheet and `lacity.org-website-traffic.csv` were inspected. They name `PS2-Kalman-filter-forecasting`, compare state dimensions and include N4SID, a method for learning state-space dynamics. Access to that named solved notebook remains unverified. Thus the practical forecasting outcome is a real alternative we lose, not an outcome silently preserved by the short Kalman comparison.

<details>
<summary>Source verification and original build record for later authors</summary>

The material below records exactly which sources were inspected. B1 and B2 mean Murphy's first and second books. Section and equation numbers identify source passages; they do not require familiarity with the surrounding chapters. These notes are for checking the later teaching material, rather than for understanding this proposal.

**Stage/mode:** Lecture Scope / BUILD. **Builder:** `/root/build_l05`, 2026-10-11, branch `scope-l03-l12-course-architecture`. **Inputs:** Wave A checkpoint `791e71b`; [architecture contract v2](../course_architecture_scope/architecture_audit.md), blob `12ae5e1608eb2d74c6c70ba857eb5a75ff2114c1`; L06 scope `326267281c6b6775ac9a33d7ed4f022a859fc49b`, L07 scope `f12fba8de7339675d09a771c5f956c8ed93649d8`. The [work order](../course_architecture_scope/WORK_ORDER.md) authorizes autonomous provisional choices; the coordinator owns approval and human questions. This builder owns only this scope, not sections, slides, notebooks or shared records.

**Direct source inspection:** Murphy B2 December 10, 2025 edition, `/tmp/pml-book2.txt`: §9.1; §9.2.1, joint Eq. 9.1 and casino emissions Eqs. 9.2–9.3; §9.2.2 Eqs. 9.5–9.8; §§9.2.3/9.2.3.1 Eqs. 9.9–9.19; §9.2.3.4 normalization; §9.2.5 complexity; §9.2.6/Eqs. 9.39–9.42 path MAP, selective printed pp. 401–409. §9.2.3.3 pair marginals inspected to delimit exclusions. §9.5.1, p. 428, supports a compact elimination interpretation, not its student-network worked example. §8.1.2, pp. 361–362, and §§8.2.2.1–8.2.2.3, pp. 365–367, support Bayesian predict/update and the compact Kalman comparison. B1 adds no required coverage; its Gaussian/Markov background is already available through prior lectures.

**Inspected computational reference:** [casino_hmm.ipynb](https://github.com/probml/pyprobml/blob/d1ea4122dcf3c2a2c02eb4e05343203b26440827/notebooks/misc/casino_hmm.ipynb), local pyprobml checkout `d1ea4122dcf3c2a2c02eb4e05343203b26440827`, SHA256 `975e90d6d095eed5e087121acd9094f57a176e270d76c6ebdbfcf6d312a18ed1`. Its ten cells construct/simulate a known categorical HMM and call Dynamax smoothing/MAP helpers; imports include JAX, Optax, Dynamax, Graphviz and probml-utils. This is application/model provenance, **not an exposed or validated NumPy worked solution**. No reference notebook was executed.

**Original upstream version references:** L06 scope `326267281c6b6775ac9a33d7ed4f022a859fc49b`; L07 scope `f12fba8de7339675d09a771c5f956c8ed93649d8`.

</details>

## 1. Intellectual arc — what the lecture explains, in order

These are the lecture's main jobs, rather than final section boundaries. Later section design can split or combine them without changing the promised mathematics, outcomes or time. Explain necessary connections at the start of the receiving section. End every section with a summary of what it has taught. Notebook instructions remain a separate item. All required material is taught live; no recording is a prerequisite.

### A. Reuse calculations for histories ending in the same state — 15 minutes

Begin with the die-switching problem. Specify the initial die probabilities, the probabilities of switching dice, and the roll probabilities for each die. Parameters are known: we infer the hidden choices, not learn a new model.

Write the probability of one complete hidden history as a product. To find the probability of the observed rolls, we would ordinarily add over all `K^T` histories, where K is the number of states and T the sequence length. Group histories by the state where they currently end. Histories in the same group can share the next calculation. This is **dynamic programming**: save a partial answer and reuse it rather than recomputing it for each complete history. A saved partial probability calculation is called a **message**.

Distinguish four questions: the current state's probability using observations so far (**filtering**); an earlier state's probability using all observations (**smoothing**); the probability of the observation sequence (**evidence**); and the single most probable complete state history (**path MAP**, or maximum a posteriori path). Briefly connect the reuse of partial sums to eliminating hidden variables in a graph. Do not teach a general elimination-order algorithm or a second graph example.

**End summary:** Local transition and observation factors let histories ending in the same state share their prefix calculation.

### B. Update the current-state probabilities as observations arrive — 27 minutes

Start from the grouped histories. Derive how each possible old state contributes to each possible new state, then multiply by the new observation's likelihood. Work all three steps of the small model in Part 4.

First use raw joint probabilities of state and observations. Then divide by their sum to obtain state probabilities that add to one. Save each dividing constant `c_t`: it is the probability of the new observation given earlier observations. Multiplying these constants gives the whole sequence's probability; adding their logarithms gives its log probability. Initialize using the stated initial distribution, without inventing a transition from a time-zero state.

This calculation sees no future observations. It is not a procedure for estimating transition probabilities, and it is not the expectation-maximization training method from L06.

**End summary:** Forward updates add contributions from old states, incorporate the new observation, and normalize. The saved normalization constants recover the sequence probability.

### C. Use later observations to revise earlier probabilities — 27 minutes

A roll later in the sequence can change our belief about which die was used earlier. Derive a backward calculation: for each state at time t, ask how likely all later observations would be if that state were known. At the final time there are no later observations, so this likelihood is one.

Combine that future likelihood with the filtered probabilities from the forward calculation. Explain why the observation at time t enters only once. Work the backward values and one combined state probability on the same small model. A backward likelihood is not itself a probability distribution across current states.

Give the consistently scaled backward formula using the saved `c_{t+1}` constants. With this convention the product of forward beliefs and backward messages already sums to one in exact arithmetic. Do not add a second smoother, adjacent-state-pair derivation, model-training update or sampling pass.

**End summary:** The backward calculation summarizes later evidence; combining it with the forward beliefs gives each state's exact probability using the full sequence.

### D. A likely state at each time is not necessarily the likeliest history — 17 minutes

Use the same example to compare the most probable state separately at each time with the most probable complete history. They give different answers. The first minimizes the expected number of time-by-time mistakes; the second minimizes the chance of getting the whole history wrong.

Briefly state **Viterbi's algorithm**, which replaces sums by maxima and saves pointers to reconstruct the winning history. Its mechanics are optional; do not add a deep derivation or student implementation. For a selected block of unknown states, define the best block after adding over the other states. Adding and maximizing generally cannot be swapped.

Count the work: dense forward/backward calculations take `O(TK²)` time and store `O(TK)` beliefs, instead of enumerating `K^T` histories. Explain why products of many small probabilities can round to zero, and how saved scaling or the log-sum-exp calculation from L05 helps. A zero normalization constant means an impossible observation sequence under the model; do not divide by it or promise that scaling cures every numerical problem.

**End summary:** Summing histories and selecting a history answer different questions. Reusing partial calculations avoids exponential work, and scaling preserves meaningful probabilities on long sequences.

### E. Recognize the same update pattern for Gaussian states — 14 minutes

Return to L01's Gaussian conditioning. In a linear-Gaussian state model, prediction carries the current mean and covariance through the dynamics and adds process-noise uncertainty. Conditioning on a new measurement corrects that prediction using the discrepancy between predicted and observed measurement, called the **innovation**.

State the known-parameter model with independent Gaussian process and measurement noise, without controls or biases. Apply L01 to the mean/covariance formulas and work the scalar update in Part 4. Explain the **gain** as the uncertainty-dependent weight on the measurement correction, and state the one-step observation distribution and its contribution to evidence.

This is a compact comparison, not a second implementation. It does not learn the dynamics or noise, build a real-data forecasting pipeline, prove matrix conditioning again, or revise past Gaussian states with a Kalman smoother.

**End summary:** Under the linear-Gaussian assumptions, prediction and measurement conditioning preserve Gaussian beliefs and give an exact filter.

### Time estimate and what to shorten first

The five parts take `15+27+27+17+14=100` substantive minutes, plus **12 minutes for questions, transitions and slippage: 112 minutes live**, with a separate 60-minute lab. This is tight and unmeasured, with medium-low confidence. The two main new derivations are forward and backward inference; the Kalman comparison applies earlier Gaussian results.

First remove optional Viterbi mechanics/backpointer illustration, saving about 3–4 minutes, while preserving the checked history-versus-state example. Then shorten the Kalman matrix formula list while preserving its stated result and scalar calculation, saving about 3 minutes. Preserve both message derivations, scaling and uncertainty interpretation. If those cuts are insufficient, the scope needs a new decision rather than faster assumed delivery.

For later authors, the provisional extent counts are `K=5` main parts, `P≈8–10` substantive source pages, `E_new≈10–12` new equation/result families, `E_carry≈16–22` repeated supporting equation blocks, `E_deriv≈8–11` intermediate algebra blocks and `V≈5–6` visual groups. The course's rough model gives 21–25 content-slide equivalents. This is neither a slide target nor measured timing; indexed calculations may take much longer than that model predicts. L01's 61 content slides/70 rendered pages and 29-slide Gaussian portion are comparison anchors only. Check the actual recurrence/example explanation during section design and rehearsal.

## 2. Mathematical spine — the results students will use

The equations below make the forward and backward calculations precise. `z_t` is the hidden state at time t; `y_t` is the observation. There are K possible states, numbered `0,…,K−1`. `π_j` is the initial probability of state j. `A_ij` is the probability of moving from i to j; each row of A sums to one. `λ_t(j)` is how likely observation `y_t` is in state j.

Use column vectors: prediction is `Aᵀf_{t−1}`. `f` denotes normalized forward state probabilities; `a` denotes raw joint probabilities. Murphy uses `α` and `α′` for these. `β` is the raw likelihood of future observations; `b` is its scaled form; `γ` is the state probability after using the whole sequence. `⊙` means element-by-element multiplication. `LSE` means log-sum-exp, a stable way to take the logarithm of a sum. Natural logarithms give evidence in nats.

In the Gaussian comparison, **LGSSM** means linear-Gaussian state-space model. F is the state-transition matrix, H maps states to measurements, Q and R are process and measurement noise covariances, m and P are belief mean and covariance, S is the predicted measurement covariance and G is the gain. Assume S is nonsingular; later code should solve a linear system rather than explicitly invert it.

In the table, **Derive** means work through the calculation; **Work** means carry out an example; **State** means give the result without proving it; **Apply** means use a result established earlier. These depths are unchanged by the wording revision.

| Object/result | Depth, delivery and role |
|---|---|
| `p(z,y)=π_{z_1}∏_{t=2}^T A_{z_{t−1},z_t}∏_{t=1}^T λ_t(z_t)`; `p(y)=Σ_z p(z,y)` | **State + Work**, Live; factorization/finite sums carried, hidden-path structure new. Parameters known. |
| `a_1(j)=π_jλ_1(j)`; `a_t(j)=λ_t(j)Σ_i A_ij a_{t−1}(i)` | **Derive + Work**, Live; grouped prefix sums and evidence `Σ_j a_T(j)`. |
| `u_1=π⊙λ_1`, `c_1=Σu_1`, `f_1=u_1/c_1`; for `t≥2`, `u_t=λ_t⊙(Aᵀf_{t−1})`, `c_t=Σu_t`, `f_t=u_t/c_t` | **Derive + Work**, Live. `f_t=p(z_t\|y_{1:t})`, `c_t=p(y_t\|y_{1:t−1})`; evidence `∏c_t`, log evidence `Σlog c_t`. |
| `β_T(i)=1`; `β_t(i)=Σ_j A_ijλ_{t+1}(j)β_{t+1}(j)` | **Derive + Work**, Live; future likelihood, not normalized state probabilities. |
| `γ_t(j)=p(z_t=j\|y_{1:T})=normalize(f_t(j)β_t(j))` | **Derive + Work**, Live; use independence of past/future given `z_t`, no duplicated `λ_t`. |
| `b_T=1`; `b_t(i)=Σ_j A_ijλ_{t+1}(j)b_{t+1}(j)/c_{t+1}`; `γ_t=f_t⊙b_t` | **State + Explain + Apply**, Live/Notebook. `b_t=β_t/∏_{s=t+1}^T c_s`, so products sum to one in exact arithmetic; explicit final normalization can absorb rounding. Independently normalized backward messages require renormalizing the product. |
| Log-forward update: `v_t(j)=logλ_t(j)+LSE_i(logA_ij+log f_{t−1}(i))`; `log c_t=LSE_j v_t(j)`; `log f_t=v_t−log c_t` | **State + Explain**, Live short alternative, L05 LSE carried. Initialize with `logπ+logλ_1`; structural zeros use `−∞`. Core lab uses scaled probabilities, not a second log-domain implementation. |
| `argmax_z p(z,y)` versus `argmax_j γ_t(j)`; block marginal MAP `argmax_{z_Q}Σ_{z_{−Q}}p(z,y)` | **Work** tiny counterexample; block definition **State**, Live. Pointwise modes minimize expected per-time 0–1 error, path MAP minimizes whole-path 0–1 error. |
| Viterbi `δ_1=π⊙λ_1`, `δ_t(j)=λ_t(j)max_i[A_ijδ_{t−1}(i)]`, backpointers | **State/Explain briefly**, Live optional mechanics; no second deep derivation/implementation. Summation-based inference remains protected. |
| Dense forward/backward `O(TK²)` time; stored `O(TK)` beliefs, `O(K)` streaming filter work memory excluding model | **Explain** by recurrence dimensions, Live. Enumeration has `K^T` paths; arbitrary graph orderings can create larger factors. No treewidth proof/sparse/FFT/parallel algorithms. |
| LGSSM `z_t=Fz_{t−1}+ε_t`, `ε_t~N(0,Q)`; `y_t=Hz_t+ν_t`, `ν_t~N(0,R)` | **State + Motivate**, Live; independent noises and initial Gaussian, known parameters. |
| `m⁻=Fm`, `P⁻=FPFᵀ+Q`; `S=HP⁻Hᵀ+R`, `G=P⁻HᵀS⁻¹`; `m⁺=m⁻+G(y−Hm⁻)`, `P⁺=P⁻−GSGᵀ`; observation predictive `N(Hm⁻,S)` | **Apply + scalar Work**, Live compact; L01 conditioning carried, dynamics prediction new. Use a solve for gain in production; assume required nonsingular innovation covariance. No new derivation or numerical filter code. |

## 3. Notebook handoff — what students do and what is supplied

**Student endpoint:** Write one checked NumPy implementation of the forward and backward calculations, then interpret the effect of later observations. The lecture provides both derived recurrences; students already know categorical/Markov probabilities and basic NumPy. No recording, PyTorch, JAX, Dynamax or Graphviz setup is needed.

**Supplied:** arrays and settings, simulated or fixed observations, a routine that lists all histories for the tiny model, plotting code, and shape/checking helpers. **Students complete:** scaled forward updates and evidence, backward updates and smoothed state probabilities. Compare evidence and every time's probabilities with exhaustive enumeration.

For the longer die sequence, supply `π=(.5,.5)`, `A=((.95,.05),(.10,.90))`, fair-die probabilities `1/6` for each face, and loaded-die probabilities `(.1,.1,.1,.1,.1,.5)`. About 100–200 rolls are provisionally sufficient. These are the inspected reference's model probabilities, but we do not promise its exact random sequence, empirical fractions or a particular runtime.

The 60-minute budget is: 8 minutes interpreting the model and array shapes; 15 completing forward updates/evidence; 14 completing backward updates/smoothing; 10 checking against enumeration and normalization; 8 interpreting the supplied long-sequence plot and sequence probability; 5 reserve.

Required checks: every smoothed vector sums to one; smoothing at the final time equals filtering; appending future observations leaves earlier filtering unchanged; enumeration and both recurrences agree; an all-zero observation-likelihood vector produces an explicit impossible-observation response. The larger plot illustrates behavior, not a guarantee that smoothing improves every classification or lowers uncertainty for every realized observation.

There is no parameter fitting, Viterbi implementation, Kalman lab, benchmarking exercise or second log-domain implementation. An optional rerun changing transition persistence is outside the core budget and is the first extra to remove. If debugging takes longer, shorten the larger-plot discussion while preserving a complete checked algorithm.

The reference notebook hides these calculations in additional libraries. The course NumPy worked solution has not been authored or executed. Later work must check the implementation, student workload, clean local uv execution and a hosted Colab run before publication.

## 4. Concrete examples and their sources

The three examples have separate jobs: a three-observation model checks every probability exactly; the casino interpretation makes filtering and smoothing concrete; one scalar Gaussian update explains the short Kalman comparison. “Oracle” below means an independently computable exact reference, not another inference method students must learn. MAP means maximum a posteriori, or most probable value/history.

**Required tiny oracle — Work, Live/Notebook, course-constructed:** `K=2,T=3`, `π=(1/2,1/2)`, `A=((4/5,1/5),(1/5,4/5))`, emissions `B=((7/10,3/10),(3/10,7/10))` for observation symbols 0/1, observed sequence `(0,0,1)`. All factors are positive/normalized. Exhaustive rational arithmetic over eight paths verifies these joint weights:

| Path | 000 | 001 | 010 | 011 | 100 | 101 | 110 | 111 |
|---|---:|---:|---:|---:|---:|---:|---:|---:|
| `p(z,y)` | .04704 | .02744 | .00126 | .01176 | .00504 | .00294 | .00216 | .02016 |

Evidence is `589/5000=.1178`; normalizers are `(.5,.548,589/1370)`, whose product matches enumeration. Filtered beliefs are `(.7,.3)`, `(217/274,57/274)`, `(555/1178,623/1178)`. Smoothed beliefs are `(875/1178,303/1178)`, `(.7,.3)`, `(555/1178,623/1178)`. For example, scaled backward at time 2 is `(137/155,137/95)`; multiplying by the time 2 filtered vector yields `(.7,.3)`. Joint path MAP is uniquely `000`, while pointwise marginal modes are `001`. This demonstrates summation/decision distinctions without deriving another algorithm. Values were checked by separate enumeration and recurrence arithmetic in a builder scratch calculation, not by executing a student notebook.

**Casino interpretation — Brief Live, Apply Notebook:** fair/loaded die emissions follow B2 §§9.2.1.1 and the inspected reference. The supplied course sequence/model harness is an adaptation, not Murphy's exact Fig. 9.3 realization. Hidden truth supports interpretation, not proof of posterior correctness. One filtering/smoothing visual group is selected.

**Scalar Kalman update — Work briefly, Live, course-constructed:** previous belief `N(0,1)`, `F=H=1`, `Q=1`, `R=2`, new observation 2. Prediction gives mean 0/variance 2; observation variance 4, gain 1/2; posterior mean 1/variance 1. This applies L01's uncertainty-weighted conditioning and shows process noise increasing prediction uncertainty. No second dataset or implementation.

Approximately 5–6 selected semantic groups cover chain factors, prefix reuse, message tables, filtering/smoothing, path-versus-marginal decisions and Gaussian predict/update. Available B2 Figs. 9.1–9.5 provide context; no exact asset reproduction, figure generation or slide layout is committed.

## 5. Lecture contract — what this proposal commits to

**Starting knowledge:** Gaussian conditioning from L01; planned categorical transitions from L02; graphical probability factorization from L03; and the different probability queries introduced in L07. Students use Python/NumPy. The lecture assumes no HMM training method.

**Main question:** How can we recover hidden-state probabilities along a sequence without listing every possible history? **Lecture endpoint:** derive forward and backward calculations, recover normalized probabilities and sequence evidence, distinguish individual-state choices from complete-history choices, count the computational work, and apply one scalar Gaussian filtering update. **Notebook endpoint:** one checked HMM implementation and an interpretation of filtering versus smoothing. The estimated commitment is 112 live minutes plus 60 lab minutes, with no required recording.

The core source is Murphy B2 §§9.2.1–9.2.3.1, with normalization in §9.2.3.4 and complexity in §9.2.5. The short Gaussian comparison uses §8.1.2 and selected §8.2.2 results. This does not amount to teaching all of Chapters 8–9.

**What is left out, and the lost capability:** Students do not learn to fit HMM parameters from hidden data (Baum–Welch/EM), calculate adjacent-state-pair probabilities, or run additional smoothing and sampling algorithms. They do not learn general inference on trees or multiply connected graphs, or how to choose an elimination order. They cannot claim a real forecasting workflow, learned state-space dynamics, Gaussian smoothing, or nonlinear Gaussian-filter extensions. These are deliberate limits rather than promised recordings. L09/L10 own approximate posterior methods; L06 supplies the general training principle but does not own a full HMM-training derivation.

**Choice requiring oversight:** The HMM lab replaces the earlier preferred website-traffic forecasting outcome. Its gain is a transparent, fully checkable probability algorithm; its cost is losing that empirical application. To retain forecasting, select Kalman as primary and reduce the HMM depth/lab. The notation is another risk: normalized probabilities and backward likelihoods must stay clearly distinguished. Use the single small model throughout and apply the first cuts above if needed. Later notebook authoring must pilot the NumPy scaffold; inspection of a source notebook is not execution evidence.

**Record updates:** Keep the protected L01/L02 artifacts and delivered ledger history unchanged. Record only this selective future chain-inference allocation, rather than broad Kalman smoothing or Viterbi promises. B1 supplies background but no new required coverage.

<details>
<summary>Exact source allocation for checking the syllabus and material ledger</summary>

This table preserves the reviewed source boundaries. The plain-language explanation above states what the omissions mean for students. A method named as omitted is not promised elsewhere unless a receiving lecture is explicitly named.

| Allocation | Commitment |
|---|---|
| Core/Live deep | B2 §§9.2.1–9.2.3.1, normalization §9.2.3.4, complexity §9.2.5; one exact oracle. |
| Short bridge | §9.1 dynamic-programming framing; §9.5.1 chain elimination interpretation; §9.2.6 path-MAP recognition; §8.1.2 / selected §8.2.2 predict/update application. |
| Notebook owned | NumPy recurrence implementation, scaling/likelihood checks, tiny enumeration comparison and supplied casino interpretation. |
| Optional | Viterbi recurrence mechanics/backpointers; persistence sensitivity outside core lab. |
| Deferred to named owners | Approximate posterior algorithms L09/L10; their Ising/model examples reuse L03. HMM EM has no assigned full derivation; L06 supplies only its general principle. |
| Deliberately omitted | HMM EM/Baum–Welch, two-slice derivation, alternate smoothing/sampling passes, tree/JTA/loopy BP, general ordering/treewidth algorithms, FFT/parallel message algorithms, Kalman smoothing/RTS/EKF/UKF, system identification and real-data forecasting lab. These are not blanket Chapter 8–9 coverage or hidden recording debts. |

</details>

**Next owner:** The instructor reviews the proposal's choices and explanations. Detailed section design follows acceptance. If later writing or rehearsal cannot meet the stated commitments, return the affected choice to Lecture Scope. The [registry](../course_architecture_scope/STATUS.md) holds review evidence. This document does not establish notebook runtime, Colab readiness or measured teaching time.
