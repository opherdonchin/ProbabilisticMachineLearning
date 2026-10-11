# L04 — Information theory: dependence and communication

**Status:** provisional five-part Lecture Scope; independent Section Design feasibility review and cross-course reconciliation pending. No agent or instructor approval is asserted. Scope build dated 2026-10-11, thread `/root/build_l04`, branch `scope-l03-l12-course-architecture`.

**Authority and revision basis:** [autonomous work order](../course_architecture_scope/WORK_ORDER.md); cross-course contract v1 in [architecture audit](../course_architecture_scope/architecture_audit.md), Git blob `882a9b2e76134d4952b218492a3564e117f6d6b4`; starting repository HEAD `906ce71dd9c8e29f3dede51ec809442a885354c9` (contract subsequently committed by coordinator at `374bc6d`). The batch authority replaces instructor checkpoints with evidence-grounded provisional choices and a later consolidated questions report. Only this scope is owned by this builder. No sections, slides, figures, notebook implementation, ledger changes or runtime validation are produced here.

## Starting boundary and route selection

- **Actual L01:** inspected `L01_Probability_Statistics/slide_deck.typ`, including Gaussian conditioning, the scalar/vector linear Gaussian update, uncertainty weighting and retrospective summaries. The protected ledger records Book 2 through §2.3.2 and Book 1 through §3.3. The source also contains a sensor-fusion illustration; the ledger marks substantive sensor-fusion coverage unreached. Treat that illustration as available intuition, not permission to claim new delivered coverage.
- **Actual L01 lab:** inspected `InClass/Solutions/lecture1_missing_data.ipynb` (SHA256 `f114516ca6a9c0823c14da0a734822a8901e4fdccf237481d47d0e3a61f80a8c`). It hides three coordinates of a known seven-dimensional Gaussian, samples the conditional with PyMC and compares with the exact LGS posterior using NumPy solves. Students can distinguish a posterior distribution from a point summary, marginalize and condition, and use supplied plotting infrastructure. This is not evidence of a completed EM or finite-coding lab.
- **Protected L02 planned boundary:** inspected `L02_Exponential_Families/section_design.md`: exponential-family representation, log-partition moments, MLE moment matching, maximum-entropy proof sketch, Gamma fit, categorical counts and Markov-chain learning through Book 2 §2.6.3. L02 is agreed but not recorded as delivered. Its malformed/stale `development_state.md` is not adopted as approval evidence. Entropy and KL were treated as prior-course review in L02; L04 consolidates their operational meaning without repeating the maximum-entropy derivation.
- **L03 dependency:** contract v1 supplies graph factorization and conditional independence; no L03 delivery is claimed. L04 requires only the readable Markov-chain condition `X ⟂ Z | Y`, not graphical separation proofs, MRF inference or any learned graph. If L03's eventual scope changes, a short factorization reminder can supply this condition locally.
- **Book roles:** Book 2 Ch. 5 is primary. Book 1 §§6.1.1–6.1.4, 6.2.1–6.2.2, 6.3.1–6.3.4 and 6.3.8–6.3.9 supply accessible finite-sum and conditional-information scaffolding. The current syllabus and preliminary briefs reserve L04 for information and one coding application, L05 for GLMs/optimization, and L12 for rate-distortion. Their blanket §5.2.1–5.2.4 citations must be narrowed: differential entropy and typical sets are not substantive L04 commitments.
- **Notation:** use uppercase random variables and lowercase realizations, `D_KL(p || q)` and `I(X;Y)`. All live finite information calculations use base-2 logarithms, in bits; later likelihood/ELBO work uses natural logs, in nats. State the conversion once. `M` denotes a two-bit message, `C=c(M)` its five-bit codeword, `Y` the received five-bit vector, and `Z` a processed observation. Do not confuse codeword entropy, message entropy or entropy per channel use.

The instructor has already fixed information theory's identity/order and asked for a substantive computational endpoint. The following routes remain visible as genuine alternatives, rather than reopening that architecture.

| Route | Organizing question, endpoint and sources | Tradeoff and disposition |
|---|---|---|
| **Channel-first finite inference, selected** | How much information survives a noisy communication channel, and what can a decoder recover? B2 §§5.1.3, 5.2.1, 5.2.4, 5.3.1–5.3.4, 5.4.1 and 5.5; finite NumPy posterior/MI lab. | One concrete problem joins uncertainty, dependence, DPI and Bayes. A course-constructed minimum-distance-three code preserves a real single-error-correction outcome; the reference's shorter XOR example is a brief contrast. Tight but coherent; no extra software ecosystem. |
| Source-coding-first | How does a better probability model shorten a lossless description? B2 §§5.1.6, 5.2.1, 5.2.4, 5.4.1; prefix-code length/mismatch lab. | Strong L02 text-model continuity and a smaller computational burden. It makes channel decoding an illustration and weakens the instructor-endorsed communication outcome. Keep as a consequential fallback, not a second lab. |
| Representation-first | Which transformations retain information relevant to a task? B2 §§5.3.1–5.3.4, with §5.6 context; finite coarse-graining lab. | Strong L03 and L12 connections, but risks a theory catalogue and premature IB/rate-distortion obligations. Retain DPI/sufficiency as one bounded bridge within the selected route; do not choose this as the main endpoint. |

All routes can reuse prior probability without new optimization theory. Channel-first supplies the strongest operational endpoint under the protected architecture. The source-coding theorem proof, full IB and large-code inference would each consume time needed for that endpoint; none is assigned to a required recording. These alternatives and the final coding adaptation are provisional agent choices, not instructor decisions.

## 1. Intellectual arc

The milestones below are macro-level responsibilities, **not finalized sections or an exact section partition**. Downstream Section Design may split or combine them within the coverage, depth and live-time envelope. Every resulting section must end with a retrospective summary; connections belong at the beginning of the receiving section. The notebook interface is a separate lecture-level item.

### Information measures connect uncertainty, model mismatch and description length

**Transition in:** L02 used entropy/KL and sufficient statistics to choose and fit distributions. Begin by asking what these quantities measure operationally when outcomes are finite and probability models disagree.

**Purpose:** distinguish uncertainty in a source from excess cost caused by a mismatched model.

**Sources:** B2 §§5.1.2–5.1.3 selectively, 5.1.6, 5.2.1, 5.2.4 and 5.4.1; B1 §§6.1.1–6.1.2 and 6.2.1–6.2.2; MIT source-coding bound cited below.

**Core:** recall discrete entropy and binary entropy; motivate `−log₂ p(x)` as ideal information length. Establish cross-entropy and `D_KL(p||q)=H_ce(p,q)−H(p)`, direction/support conventions and nonnegativity. Work one Bernoulli mismatch. Apply the finite empirical-cross-entropy identity to connect L02 categorical counts with likelihood fitting, without developing GLMs. State optimal prefix-code bounds and the block-length interpretation. Explain that actual integer code lengths need not equal ideal fractional lengths; source coding removes redundancy, whereas channel coding spends it.

**Extent / delivery:** about **24 minutes, Live**, including approximately four minutes for the source-coding comparison. Entropy/KL definitions are consolidation; the operational distinction and exact probability bookkeeping receive the time. No Huffman construction or AEP proof.

**Retrospective summary:** entropy measures source uncertainty; cross-entropy measures ideal description/log-score cost under a chosen model; KL measures its excess over the source entropy. Lossless prefix-code length is bounded by entropy, with finite integer overhead.

### Mutual information quantifies dependence through uncertainty reduction

**Transition in:** entropy describes one distribution and KL compares two. To quantify dependence, compare a joint distribution with the product of its own marginals.

**Purpose:** make the KL definition and the conditional-entropy meaning of MI visibly the same object.

**Sources:** B2 §§5.3.1–5.3.2, Eqs. (5.109)–(5.113); B1 §§6.1.3–6.1.4 and 6.3.1–6.3.3.

**Core:** finite joint/marginal tables and averaged conditional entropy; entropy chain rule; derive `I(X;Y)=D_KL(p_xy||p_x p_y)=H(Y)−H(Y|X)` by expanding logarithms and summing. Obtain the symmetric expression by exchanging variables; state the joint-entropy form as a consequence. Work a uniform binary message through a binary symmetric channel, giving `I=1−h₂(α)` before the later vector channel. Emphasize nonnegativity, symmetry, independence iff zero and average uncertainty reduction rather than a claim about every realized observation.

**Extent / delivery:** about **22 minutes, Live**. One identity derivation and one small channel computation; no MI-estimator or correlation-measure survey.

**Retrospective summary:** MI is the discrepancy between dependence and independence, equivalently the average uncertainty removed by observation. For a uniform bit through a flip channel it is `1−h₂(α)` bits.

### Processing can discard information; sufficiency identifies an equality case

**Transition in:** once information is quantified, ask whether manipulating an observation can create more information about its source. Use the L03 condition `X ⟂ Z | Y` to specify what “processing” means.

**Purpose:** establish DPI as a precise constraint and give a bounded connection to L02 sufficient statistics.

**Sources:** B2 §§5.3.3–5.3.4, Theorem 5.3.1 and Eqs. (5.114)–(5.117); B1 §§6.3.4, 6.3.8–6.3.9.

**Core:** state conditional MI as an average conditional KL, so it is nonnegative; state its two chain-rule decompositions and sketch the DPI proof by setting `I(X;Z|Y)=0`. Work a deterministic erasure/coarsening of a binary observation and contrast it with invertible recoding. Explain sufficiency for inferring a random parameter as `θ ⟂ D | S(D)` and consequent MI equality, using Bernoulli counts only as a recall example. Do not claim literal reconstruction of the original realized data from the statistic: sufficiency preserves the parameter-relevant conditional information, not every detail of a sample.

**Extent / delivery:** about **16 minutes, Live**. Conditional MI is only proof support. Minimal sufficiency, factorization-theorem proof and representation optimization are outside this milestone.

**Retrospective summary:** processing an observation alone cannot increase its information about a source; equality can hold when a statistic preserves all information relevant to the inferential target.

### A finite redundant code turns information into posterior decoding

**Transition in:** DPI constrains what a receiver can extract from an observation. Encoding occurs **before** noise and changes the observation available: compare the extra channel use/redundancy cost with the resulting posterior and information.

**Purpose:** carry one exact finite model from message and encoding through noise to a normalized posterior, unique single-error decoding and explicit multi-error ambiguity.

**Sources:** B2 §5.5, Eq. (5.164), Fig. 5.11 and the inspected `error_correcting_code_demo.ipynb` for the channel/inference architecture. The selected five-bit code, distance calculation, numbers and comparison are **course-constructed**, not Murphy's code or figure.

**Core:** construct the four codewords specified in Part 4; independent bit flips; joint/marginal normalization and Bayes. Verify minimum distance three and give the short triangle-inequality reason for unique nearest decoding after at most one flip. With uniform prior and `0<α<1/2`, likelihood decreases with Hamming distance, so nearest-codeword decoding is joint MAP. Work the received word `00001` at `α=0.2`; compare with the tied modes for `00110`. Distinguish the full posterior, a joint MAP decision and its tie policy. Compute `H(Y|M)=5h₂(α)` and apply MI through the finite `p(Y)` table; one aggregate value is enough live, with full enumeration in the lab. State code rate `2/5` message bits per channel use and compare with uncoded transmission without implying a capacity-achieving code.

**Extent / delivery:** about **36 minutes, Live**. A two-minute textbook-XOR contrast is optional within this allocation. No full code-design theory, channel-coding theorem, large graphical-model inference or second worked coding application.

**Retrospective summary:** the chosen redundancy separates codewords enough to correct every single-bit corruption under the specified MAP model. Multiple errors can remain ambiguous; posterior information, block error and bits per channel use describe different aspects of this finite communication system.

### Extent, reserve and first cut

Planned substantive live work is **98 minutes** (`24+22+16+36`); add **12 minutes reserve**, yielding a **110-minute** meeting plan, within the 100–120-minute envelope. Reserve covers questions, transitions and slippage; it is not another promised topic. The separate lab is 60 minutes. All mathematics remains Live; **no required recording** and no recording candidate is needed to make the budget balance.

**Judgment: tight, plausible; timing unmeasured, confidence medium-low.** The codeword-distance argument, MI identity and DPI sketch are the concentrated novel steps. L01's 61 content slides / 70 rendered pages and its 29-slide Gaussian mathematical span are only comparative anchors; no rigid slide/minute rate is assumed. L02's 100–120-minute plan is agreed, not measured delivery.

Provisional calibration features: `K=4` conceptual milestones, `P≈9–11` substantive primary/support page-equivalents (not the entire pp. 219–252 span), `E_new≈11–14`, `E_carry≈14–22`, `E_deriv≈8–12`, `V≈5–7`. New families include joint/conditional entropy, MI, proof-support conditional MI, DPI, sufficiency equality, source-length bounds, channel model, finite posterior, distance/decoding guarantee, rate and vector-channel information; recalled entropy/KL and repeated Bayes formulas are carried support. The skill's prototype gives a rough **20–26 content-slide-equivalent signal**, not a slide-count commitment. Its coefficients lack out-of-sample validation and underrepresent time spent interpreting probability tables and correcting normalization mistakes; it cannot certify a 110-minute teaching time.

**First cut if an actual downstream draft overruns:** remove the optional two-minute XOR contrast and shorten the Bernoulli-count sufficiency recall to a statement (about two minutes). If more relief is necessary, return Scope backpressure proposing that the full five-bit numerical MI aggregation become lab-owned while retaining live `H(Y|M)=5h₂(α)`, the MI identity and interpretation (about four to six minutes). Do not silently remove the unique-correction endpoint, MI derivation or DPI proof sketch, or hide the code-rate cost. Reassess timing when actual section responsibilities, equation novelty and tables exist, then through a partial rehearsal. A preview cannot substitute for that evidence.

## 2. Mathematical spine

Treatment labels apply to exactly the stated finite/discrete objects. A formula repeated to make a computation legible remains carried support.

| Object / result | Intellectual role and downstream need | Treatment depth and delivery |
|---|---|---|
| `H(p)=−Σp log₂p`, `h₂(α)`, `0≤H(X)≤log₂|X|` | Uncertainty and channel-noise baseline; connects L02 maximum entropy without reproving it | **Motivate + Work**, bounds **State**; Live, definitions recalled |
| `H_ce(p,q)=−Σp log₂q`; `D_KL(p||q)=Σp log₂(p/q)=H_ce−H` | Separate source uncertainty from model mismatch; later NLL and VI objectives | Identity **Derive**, binary example **Work**, nonnegativity/support/asymmetry **State + Explain**; Live. `0 log 0=0`; positive `p` with zero `q` gives infinite KL |
| Finite empirical cross-entropy `−N⁻¹Σlog₂q(x_n)` | Recognize categorical MLE from L02; bridge to L05 log loss | **Apply**, Live, brief. Do not identify empirical point-mass KL with a smooth continuous density's finite KL |
| Optimal binary prefix-code expected length `H(X)≤L_min<H(X)+1`; IID block per-symbol `H(X)≤L_min,n/n<H(X)+1/n` | Operational bound, distinct from five-bit channel-code rate | **State + Explain**, Live, no proof/algorithm; B2 §5.4.1 lower bound, MIT primary source for finite upper bound |
| `H(Y|X)=−Σp(x,y)log₂p(y|x)` and `H(X,Y)=H(X)+H(Y|X)` | Averaging and normalization required by MI and lab | Definition **State + Work**, chain rule **Derive briefly**; Live |
| `I(X;Y)=D_KL(p_xy||p_xp_y)=H(Y)−H(Y|X)` | Main retained identity; later L12 information interpretation | **Derive** one expansion carefully; symmetry/joint-entropy equivalents **State as consequences**; uniform BSC **Work**, Live |
| `I(X;Y|Z)=Σ_z p(z)D_KL(p_xy|z||p_x|z p_y|z)≥0`; two MI chain decompositions | Load-bearing support for DPI | Definition/nonnegativity/chain rule **State + Explain**; Live, only sufficient detail to follow proof, no separate catalogue |
| `X ⟂ Z|Y ⇒ I(X;Z)≤I(X;Y)` | Limits postprocessing, reused as a constraint in L12 | **Proof sketch** through two chain decompositions; one coarsening **Work**, Live |
| `θ ⟂ D|S(D) ⇒ I(θ;S(D))=I(θ;D)` under the stated joint prior/data model | Interpret parameter-relevant sufficiency from L02 | **Motivate + State + Apply** to recalled counts; Live short bridge. No minimal-sufficiency proof |
| `p(y|m)=α^{d_H(y,c(m))}(1−α)^{5−d_H(y,c(m))}`; `p(m,y)=p(m)p(y|m)`; `p(y)=Σ_m p(m,y)` | Specifies the exact enumeration; reuses L03 factorization and L01 marginalization | **Work**, Live; full 4×32 table and numerical normalization **Notebook** |
| `p(m|y)=p(m,y)/p(y)`; `argmax_m p(m|y)` | A decision follows conditioning, rather than replacing the posterior | **Work** unique and tied observations; uniform prior + `0<α<1/2` nearest-distance equivalence **Derive briefly**, Live. Joint MAP loss is message-block 0–1 error; bitwise marginal decisions are a different rule |
| Pairwise distance matrix, `d_min=3`; if `d_H(y,c(m))≤1`, every other distance is at least 2 | Guarantees the concrete correction outcome | **Work + Proof sketch** via triangle inequality; Live. Not a theorem about all corruption patterns |
| `H(M)=H(C)=2`, `H(Y|M)=5h₂(α)`, `I(M;Y)=H(Y)−5h₂(α)` | Distinguish information from redundant vector length | Conditional entropy **Derive** from independent noise; MI **Apply**, Live; complete marginals/curves **Notebook** |
| `P_error*=1−Σ_y max_m p(m,y)`; rate `R=2/5` | Exact block-error accounting including ties and resource cost | Error identity **State + Explain**, full evaluation **Notebook**; rate **Work**, Live. Do not derive channel capacity or infer error from MI alone |

For L12, preserve entropy/KL/MI definitions, the MI identity and DPI as established reusable tools. Rate-distortion's optimization and VAE aggregate-KL/MI decomposition are **not established here** and must be taught by L12. L06/L09 may reuse nonnegative KL without treating this scope as a proof of an ELBO.

## 3. Notebook handoff — a scaffolded 60-minute finite channel lab

**Anchor:** B2 §5.5 probabilistic decoding and the inspected [pyprobml reference at commit `d1ea4122`](https://github.com/probml/pyprobml/blob/d1ea4122dcf3c2a2c02eb4e05343203b26440827/notebooks/book2/05/error_correcting_code_demo.ipynb). Its SHA256 is `b557bf8b97488541d1f11b88a6b92ad172b0f4d7501de8c92fe00f634ba04cd1`.

The reference source has uniform `X1,X2`, `X3=X1 XOR X2`, three independent flip CPDs at noise 0.2 and observation `Y=(1,0,0)`. It uses `probml_utils`, `probml_utils.pgmpy_utils`, `pgmpy.models.BayesianModel`, `TabularCPD` and `VariableElimination`, with notebook installation cells. It computes marginals/joint posterior and a graph. This is **source inspection only**; neither that notebook nor a course adaptation was run. Those package choices/API/install cells are not course requirements. Adapt the probability model to one explicit NumPy enumeration with Matplotlib, using the five-bit construction below. No pgmpy, JAX, external dataset or new inference package is required.

**Lecture entry contract:** students know the message/codeword distinction, fixed uniform prior, independent flip likelihood, normalization, the MI identity, DPI, the five-bit code and its one-error guarantee, and joint MAP/tie meaning. No required recording. They already have NumPy array and supplied-plot experience from L01; broadcasting across a table is scaffolded rather than presumed.

**Distinct new lab work:** enumerate every received word and all 128 message/observation pairs; construct and check the channel, joint and marginal tables; compute MI independently by KL and entropy expressions; evaluate posterior decoding and the exact expected message-block error over the whole channel. Vary `α` across `[0,0.5]`, compare coded and uncoded transmission, and relate those curves to rate. The lab extends the few live observations to a complete model, rather than copying a live derivation.

**60-minute workload envelope:** approximately 10 minutes orienting supplied message/word arrays and array axes, 15 minutes completing probability tables and normalization checks, 15 minutes information quantities/posterior decisions including ties, 15 minutes supplied noise sweep and uncoded comparison, and 5 minutes interpreting the result. This is a workload estimate, not authored notebook questions or timed execution. Bit-string generation, plotting and the sweep harness are given; students complete small mathematical operations rather than an entire software pipeline. A separate simulation is optional and excluded from the core hour.

**Required numerical/mathematical checks:** row sums of `p(y|m)` equal one; joint and received marginals normalize; posterior columns normalize only where `p(y)>0`; both MI calculations agree and remain between 0 and 2 bits. At `α=0`, only four received words have positive probability; impossible observations have no defined posterior and must not be silently normalized. At `α=0.5`, every posterior is uniform, MI is zero and block-MAP error is `3/4`. At `α=0.2`, the exact reference targets in Part 4 apply. A set of tied maximizers must be exposed; use a stated deterministic or uniform-random tie policy for simulated decisions. Exact Bayes success uses `Σ_y max_m p(m,y)`, so equally optimal tie choices yield the same aggregate block risk. A first-index `argmax` is not evidence of a unique solution.

**Endpoint:** students can construct an exact finite communication model, quantify how much message information it retains, and measure what its posterior decoder can recover, including failures and redundancy cost. Compare two uncoded uses with five coded uses explicitly; information per message and per channel use must both be labeled. The five-bit code is an educational finite code, not asserted optimal. The two-to-three-bit reference is not a second student implementation.

**Validation limit:** clean local uv and hosted course-target Colab execution, numerical curve checks and a student-workload trial remain future notebook-authoring obligations. No Colab compatibility or one-hour runtime is inferred from inspected source or the small table size.

## 4. Concrete examples and exact model commitments

### A. Binary uncertainty and model mismatch — Work through, Live

Course-chosen numbers applied to B2 §§5.2.1/5.2.4 and B1 §§6.1.1/6.2.2: `p=(0.8,0.2)`, `q=(0.5,0.5)`. Entropy is `h₂(0.2)≈0.721928` bits, cross-entropy is 1 bit and forward KL is `≈0.278072` bits. The uniform bit through a BSC uses the same noise value but a different probability model; label that change explicitly. There its MI is `1−h₂(0.2)≈0.278072` bits, not a general equality between a source's KL and a channel's MI.

### B. A processing constraint — Brief Work / Compare, Live

Course-constructed: `X` uniform binary, `Y=X XOR E`, `E~Bernoulli(α)`. Compare invertible recoding `Z=1−Y`, which retains `I(X;Y)`, with `Z=0` constant, which has zero MI. These finite extremes clarify DPI without another probability-table application. Bernoulli counts from L02 are a brief parameter-sufficiency recall, not a fresh maximum-entropy or likelihood proof.

### C. The one operational endpoint — Work through, Live and Notebook

**Course-constructed adaptation:** let `M=(M1,M2)` be uniform over `00,01,10,11`; transmit

`c(M)=(M1,M2,M1,M2,M1 XOR M2)`.

Repetition coordinates are deterministic redundant checks as well as the final XOR parity bit. The code is chosen for transparently inspectable minimum distance, not coding efficiency. It is not the three-bit Murphy construction.

| Message | Codeword |
|---|---|
| `00` | `00000` |
| `01` | `01011` |
| `10` | `10101` |
| `11` | `11110` |

In this order the Hamming-distance matrix is

`[[0,3,3,4], [3,0,4,3], [3,4,0,3], [4,3,3,0]]`.

For each coordinate, independently, `Yi=Ci XOR Ei`, `Ei~Bernoulli(α)`. Core decoding assumes uniform prior and `0<α<0.5`; boundary limits `0` and `0.5` are checked separately. No burst noise or learned channel. The likelihood is the spine's five-bit Hamming formula. It normalizes because summing over all error patterns gives `(α+(1−α))^5=1`; with `p(m)=1/4` the joint also sums to one. The encoder is injective, so `H(C)=H(M)=2` despite a five-bit representation. Minimum distance three plus a radius-one error guarantees the original word is uniquely nearest, hence uniquely MAP in this model. It does not guarantee error-free decoding when two or more bits flip.

**Unique live observation at `α=1/5`:** `y=00001` has distances `(1,2,2,5)`. Likelihoods in message order are `(256,64,64,1)/3125`; `p(y)=77/2500`. The normalized posterior is `(256,64,64,1)/385`; joint MAP is uniquely `M=00`, with posterior probability about `0.665`. It corrects a one-bit corruption of `00000` while retaining uncertainty about alternatives.

**Ambiguous live observation at `α=1/5`:** `y=00110` has distances `(2,3,3,2)` and posterior `(2/5,1/10,1/10,2/5)`. Messages `00` and `11` are tied joint MAP hypotheses. Selecting one cannot be described as discovering the unique original message. No claim that all multi-error observations tie: some yield a wrong unique mode.

**Whole-model lab reference values at `α=1/5`:** enumerating 32 observations gives `H(Y)≈4.733070`, `H(Y|M)=5h₂(0.2)≈3.609640`, `I(M;Y)≈1.123429` and `H(M|Y)≈0.876571`, all in bits per message block. Exact optimal block-error probability is `693/3125=0.22176`. Uncoded two-bit transmission at the same independent noise has MI `2[1−h₂(0.2)]≈0.556144` bits per message and block error `1−(1−0.2)^2=0.36`. This improvement uses five rather than two channel uses: coded MI per use is about `0.224686`, versus uncoded `0.278072`; coded rate is `0.4` message bits/use versus uncoded 1. These are finite-model results, not a channel capacity theorem.

The source-level model and all exact numerical targets were checked with a scratch finite enumeration using Python standard-library rational arithmetic: all four channel rows normalized; the joint normalized; all 20 single-bit corruption cases had the correct unique nearest codeword; the stated posteriors and exact risk followed from the table. This builder check verifies the **mathematical commitments**, not an independent feasibility review, a student notebook implementation or teaching duration.

### D. Textbook parity limitation — optional Brief contrast, Live

B2 §5.5 / Fig. 5.11 and the inspected reference use `c(m)=(m1,m2,m1 XOR m2)`, with words `000,011,101,110`. Their minimum distance is two. For `y=100`, `α=0.2`, posterior masses are `16/49` each for `000,101,110` and `1/49` for `011`. This is the source's three-mode inference example; a single parity check can detect an odd number of flips without determining which bit flipped. If used, keep it to the reason the course selected a stronger redundant code. It is not a second full coding endpoint. Do not copy the source text's incomplete list of invalid codewords: support is exactly the four words above.

**Visual/source selection:** B2 Figs. 5.4, 5.6 and 5.11 are available references for binary entropy, information relationships and the original three-bit model; none is committed for direct reproduction. Selected semantic groups for later design are binary uncertainty/mismatch, the dependence/processing relation, the four-word distance structure, unique-versus-tied posterior comparison and information/rate interpretation, about 5–7 groups after grouping. No figure is generated and the course five-bit graph/words must be labeled course-constructed.

## 5. Lecture contract

**Starting assumptions:** rigorous probability and undergraduate Bayesian modeling; L01 joint/marginal/conditional operations and posterior interpretation; L02 agreed categorical/sufficient-statistic and entropy/KL background; L03's basic conditional-independence reading. No coding-theory, message-passing or optimization-algorithm prerequisite.

**Central question:** how do uncertainty and dependence quantify communication, and how does deliberately added redundancy alter what can be inferred after noise?

**Lecture endpoint:** students can derive the basic MI identity, follow the DPI proof sketch, interpret source-coding bounds, and normalize a finite coded-channel posterior that has both guaranteed unique single-error decoding and explicit ambiguity beyond that guarantee.

**Notebook endpoint:** complete finite-channel enumeration and noise-dependent information/block-error comparison, with normalization, tie and resource accounting. Separate 60-minute scaffolded NumPy lab. No required recording.

**Supported learning outcomes:**

1. Distinguish entropy, cross-entropy and directed KL, with correct support and units.
2. Derive MI's uncertainty-reduction identity and explain its independence criterion.
3. Explain DPI under its conditional-independence assumption and recognize parameter-relevant sufficiency as an equality case.
4. Compute a normalized message posterior and justify this code's one-error correction; distinguish MAP ties from unique decisions.
5. Use complete enumeration to compare information, optimal block error and channel-use cost without confusing these quantities.

### Coverage, deliberate omissions and later ownership

| Category | Commitment / ledger implication after reconciliation |
|---|---|
| **Core / Live deep** | B2 entropy/KL/cross-entropy selected finite definitions and relation (§§5.1.2–5.1.3 selectively, 5.2.1, 5.2.4); MI identity (§§5.3.1–5.3.2); DPI sketch (§5.3.3); finite channel posterior/distance example (§5.5, adaptation clearly labeled). |
| **Short bridge / Live** | Finite empirical cross-entropy/MLE (§5.1.6 selected); source-code length bounds (§5.4.1); parameter sufficiency (§5.3.4); code rate. No claim of full subsection coverage where only one result is used. |
| **Notebook owned** | Complete 4×32 enumeration, two MI calculations, exact optimal block error, boundary cases and noise sweep on the single selected five-bit channel; B2 §5.5 extended computationally. |
| **Optional, not promised coverage** | Two-minute source XOR contrast. A simulation extension is optional lab work, outside the required hour. |
| **Deferred to L12** | B2 §5.4.2 rate-distortion formulation/derivation and VAE interpretation; §5.6 only a possible supervised-IB comparison there, not a full promised treatment. L04 may name lossy compression in the source/channel distinction, but this is not coverage. |
| **Omitted by course decision** | KL uniqueness axioms/full proof, KL compression lemma/PAC-Bayes/Fisher/Bregman development (§§5.1.1–5.1.2 full treatment, 5.1.5, 5.1.9–5.1.10); Bayesian variational principle (§5.1.7) and KL/exponential-family geometry (§5.1.8); differential entropy/typical-set/AEP development (§§5.2.2–5.2.3); MI catalogues/variational bounds/relevance networks (§§5.3.5–5.3.7); bits back (§5.4.3); full source/channel coding theorem proofs or coding-algorithm survey; large-code message passing (§9.4.8); algorithmic information; full IB (§5.6). Generic VI/ELBO mathematics is L06/L09-owned, not silently included here. |

This is proposed allocation, not delivered coverage. L01's recorded curriculum boundary and L02's agreed teaching remain intact. Once the coordinator approves the reviewed scope at agent level, revise the planned syllabus/ledger to identify the selected §5.5 adaptation and remove any implication that all entropy subsections, rate-distortion or IB have been taught. A Ch. 5 progression boundary is not a statement that every intervening subsection is covered. Book 1 Ch. 6 is selective backfill, not a new contiguous Book 1 boundary.

### Consequential questions and bounded residual risks for the coordinator

- **Priority medium — chosen practical outcome:** provisionally replace the reference's two-to-three-bit parity demonstration with the transparent two-to-five-bit minimum-distance-three code. This costs a larger 4×32 table but makes true single-error correction possible. Alternative: keep the source's smaller example and explicitly narrow the outcome to detection/ambiguous posterior decoding; that would weaken the protected practical outcome. Coordinator instructed the five-bit choice during this build. Confirm it with the instructor in the consolidated report; no request interrupts this batch.
- **Priority medium — live mathematics versus finite-table interpretation:** preserve MI derivation, DPI sketch and correction/posterior reasoning. If measured extent exceeds the envelope, first remove optional contrast/extended sufficiency recall, then consider moving full numerical MI aggregation to the lab. Changing core depths or the endpoint requires Scope-owned revision and a targeted review, not a downstream speed assumption.
- **Priority low — sufficiency bridge:** the MI equality is stated under an explicit random-parameter joint model. Students' frequentist sufficiency background may need a short explanation of this framing; do not turn it into new measure-theoretic or minimal-sufficiency theory.
- **Notebook-owned residual risk:** the reference source installs pgmpy/probml utilities and is not a turnkey student lab. The NumPy adaptation, axes/scaffolding, handling of zero-probability observations and simulated ties must be validated and workload-timed later. The mathematical checks here reduce correctness uncertainty but do not remove the authoring/runtime burden.

**Review request to coordinator:** can a coherent sequence carry students from the stated prior state to the lecture/lab endpoints with these exact treatment depths, finite examples and 110-minute plan? Please commission the independent Section Design feasibility preview without constructing a section partition or slides. Builder stops editing after handoff; status remains provisional until independent findings and global reconciliation are resolved.

### Source register

- Murphy Book 2, *Probabilistic Machine Learning: Advanced Topics*, inspected local online edition dated December 10, 2025: Ch. 5 TOC and actual §§5.1.2–5.1.3, 5.1.5–5.1.6, 5.2, 5.3.1–5.3.4, 5.4.1–5.4.2 and 5.5–5.6 passages. Exact MI/DPI and original coding labels above were checked in the extracted `/tmp/pml-book2.txt`; scratch path is not a course dependency. Other omitted subsection names were checked against the TOC.
- Murphy Book 1, inspected local April 18, 2025 online edition: §§6.1.1–6.1.4, 6.2.1–6.2.4, 6.3.1–6.3.4 and 6.3.8–6.3.9. Finite entropy/conditional-MI notation and DPI argument checked in `/tmp/pml-book1.txt`.
- The compact finite-prefix-code upper bound supplements Murphy's lower-bound discussion: [MIT 6.450, Lecture 3, optimal prefix-code and IID-block bounds, PDF pp. 3 and 13](https://ocw.mit.edu/courses/6-450-principles-of-digital-communication-i-fall-2009/f57623d4056984d18685fdb37cea01d6_MIT6_450F09_slide03.pdf), inspected 2026-10-11. It supports the stated `H≤L_min<H+1` and per-symbol block bounds; its Huffman/AEP material is not added to the scope.
- Course artifacts inspected: protected L01 deck/imputation notebook; protected L02 section design and development state; [material ledger](../material_ledger.md), [preliminary briefs](../curriculum_scope_previews.md), [notebook-reference audit](../notebook_reference_audit.md), `syllabus_plan.typ`, `advanced_statistics_2027_1_syllabus.typ` and `syllabus_planning_decisions.md`.
- Reference notebook local repository HEAD `d1ea4122dcf3c2a2c02eb4e05343203b26440827`; exact notebook hash and package limitations above, consistent with the coordinator's [source inspection register](../course_architecture_scope/source_inspection.md). No executed reference, implemented lab or hosted-runtime claim.
