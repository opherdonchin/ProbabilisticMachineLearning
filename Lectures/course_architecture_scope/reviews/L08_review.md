# L08 review: explanation for the instructor

This reading guide was written by the coordinator. The original independent review is preserved verbatim below; it identifies its own reviewer, exact earlier scope version and checks. [STATUS](../STATUS.md) identifies the current readable scope and any subsequent revision check. Rewriting a guide is not a new independent approval.

**What was assessed:** Sequences: infer hidden states using repeated calculations. The reviewer asked whether the mathematics, student prerequisites and one-hour task could fit the proposed meeting.

**What the original review concluded:** The proposal was feasible with risks, meaning no demonstrated mathematical or structural obstacle was found, but time and supplied-code requirements remained uncertain. No student notebook or teaching trial was validated.

**What matters for the teaching choice:** The hidden-state sequence calculation is feasible with supplied simulation and checking tools. A symmetric example can hide a wrong transition direction, so a second asymmetric test must be supplied. A best whole history can differ from the separate most likely states; continuous forecasting is not also a full lab.

## Original independent review and later technical check records

# L08 independent Section Design feasibility preview

**Role/mode:** Section Design specialist, `feasibility-review` only. **Reviewer thread:** `/root/review_l03`, distinct from Scope builder `/root/build_l05`. **Date:** 2026-10-11. **Branch:** `scope-l03-l12-course-architecture`.

**Exact target:** `Lectures/L08_Structured_Inference/lecture_scope.md`, Git blob `b7a2de325c364bcde8230c33aaba2a5cd6b8596a`. Its working-file hash matched before reading, after source/mathematical checks and at final report persistence. **Inputs checked:** contract v2 blob `12ae5e1608eb2d74c6c70ba857eb5a75ff2114c1`; L06 blob `326267281c6b6775ac9a33d7ed4f022a859fc49b`; L07 blob `f12fba8de7339675d09a771c5f956c8ed93649d8`, with their independent review reports.

**Verdict: feasible-with-risks; no demonstrated blocking Scope issue.** Mathematical confidence is high for the stated finite recurrences and named examples. Timing confidence is medium-low. This preview grants no approval and does not validate timing, implementation or publication readiness. I read the full five-part target, relevant reviewed upstream contracts and source passages; wrote only this raw report; preserved L03/L04 raw reviews; generated no section partition, slides or notebook implementation; and did not commit.

## Constructibility and cumulative state

The scope has a coherent new intellectual job: use chain structure to evaluate exact posterior sums that naive path enumeration would make exponential. L02's observed-state Markov probabilities and L03's factors supply the model language; L04 supplies tiny finite enumeration practice; L07 supplies query distinctions without the exact algorithm. L06 provides latent-expectation context but is not an HMM prerequisite beyond that context. None of these future scopes is delivered-course evidence. Protected L01's actual Gaussian conditioning and supplied NumPy solve exercises support the compact Kalman comparison; they do not already teach sequential dynamics.

The dependency order is sound: HMM joint → grouped prefix sums → forward filtering and evidence → future-likelihood recursion → smoothing → decision and numerical distinctions. The raw/normalized distinction is explained rather than left as an inconsistent symbol convention. All core mathematics is live; no EM, VI, MCMC or new library stack is needed. Recognition of chain elimination is sufficient; a general elimination-order example would add a separate responsibility and is expressly excluded.

The plan totals 100 substantive minutes plus 12 reserve = 112, within the envelope but tight. Forward/evidence and backward/smoothing consume 54 minutes and are the two substantial new derivational chains. The tiny oracle is reused for successive meanings, not replaced by a catalogue. Kalman remains a 14-minute application of L01 conditioning plus dynamics prediction, with one scalar calculation; it can fit if not developed as a second full algorithm. The calibration ranges give approximately 21.4–25 content-slide equivalents; that arithmetic agrees with the scope but does not measure indexed-recursion teaching time. I would not add two-slice marginals, HMM EM, a log-domain student implementation or a forecasting pipeline.

## Material concerns and minimum treatments

### R1 — Indexed message conventions and the two deep passes need protected time

**Owner/severity:** Lecture Scope, **advisory**; actual boundaries/local distribution later belong to Section Design. **Evidence:** Students must distinguish raw `a`, filtered `f`, unscaled future likelihood `beta`, scaled `b`, predictive `c` and smoothed `gamma`. Two 27-minute allocations include derivation, three-time examples and interpretation; scaled backward is a further convention change even though only State/Explain/Apply depth is promised. A backward likelihood can exceed one after scaling and is not a state distribution.

**Provisional treatment:** Keep the explicit convention and one oracle. Derive the raw probabilistic meanings, then explain saved scaling without treating it as another independent smoother. **Minimum repair:** No mandatory Scope change now. Preserve the core 54-minute reasoning and rehearse the recurrence/example path before claiming the plan validated; use the declared optional cuts if necessary. **Consequence:** Section Design can redistribute time within the live envelope. Any loss of forward/backward derivation, evidence recovery or the exact oracle requires Scope backpressure, rather than silent acceleration.

### R2 — The source's unique-MAP equivalence claim must not re-enter explanations

**Owner/severity:** Source-faithful Slide Design/notebook exposition, **downstream-owned**. **Evidence:** B2 §9.2.6.2 states that a unique Viterbi path agrees with pointwise smoothed modes. That assertion is false in general. The scope's positive, untied example proves it: unique joint path MAP is `000`, while all pointwise modes are uniquely `001`. The error is not just inconsistent tie breaking.

**Provisional treatment:** Preserve the scope's correct course-constructed counterexample and distinct whole-path/per-time 0–1 loss interpretations. **Minimum repair:** Carry an explicit source caution into downstream work; do not quote the paragraph as a theorem or weaken the example to a tie-only warning. No Scope mathematical repair is required. **Consequence:** Viterbi mechanics may be removed without losing this important distinction. Recognizing max-product does not establish a second student implementation or full optimization proof.

### R3 — The symmetric tiny oracle cannot catch a transition-orientation error

**Owner/severity:** Worked-solution/notebook authoring, **downstream-owned**. **Evidence:** The course oracle has symmetric `A=((.8,.2),(.2,.8))`. Consequently an accidental use of `A f` in place of `A^T f`, or reversed transition indexing, is invisible on this exact case. The actual casino matrix is asymmetric, but its required longer output is interpreted visually and has no exhaustive reference target. Normalized beliefs alone do not demonstrate use of the intended model.

**Provisional treatment:** Retain the named oracle and all of its verified live values. **Minimum repair:** Add a supplied asymmetric-transition enumeration assertion to the later harness, checking evidence and each smoothed marginal against the same model's exhaustive weights. This need not become a second live example or student-owned derivation; the existing supplied tiny enumerator can perform the check. **Consequence:** Improves algorithm verification without changing the endpoint, source allocation or student workload. The displayed symmetric oracle remains a good teaching example but is insufficient as the sole implementation test.

### R4 — Scaled probabilities require zero-support and numerical-failure distinctions

**Owner/severity:** Notebook authoring and numerical explanation, **downstream-owned**. **Evidence:** In exact nonnegative arithmetic, `c_t=0` means that the observed prefix has zero probability. In floating point, a computed zero may also result from underflow or invalid input. Scaling avoids accumulation of tiny whole-sequence products but does not ensure every tiny emission or scaled backward value is representable. The scope correctly limits its stability claim, but the impossible-observation response must not misdiagnose all numerical failures as model impossibility.

**Provisional treatment:** Use the moderate-probability finite examples and supplied exact-zero observation case; recover log evidence from saved `c`, not from a final underflowed product. **Minimum repair:** Label the zero-support implication as exact arithmetic and distinguish an intentional all-zero likelihood vector from finite-precision failure in the worked-solution checks. Supply a clear error response and final smoothing normalization tolerance. **Consequence:** No second log-domain implementation is required in the core hour. Log-sum-exp remains a brief alternative, and rare-event/general continuous-emission robustness is not promised by this lab.

### R5 — The 60-minute lab is feasible only with an exposed, constrained scaffold

**Owner/severity:** Worked-solution/notebook authoring, **downstream-owned**, with Scope risk if a pilot fails. **Evidence:** The hour allocates 15 minutes to scaled forward/evidence, 14 to backward/smoothing and 10 to oracle checks, with only five reserve. L01 supports small array operations; it does not establish independent implementation of indexed dynamic programs. The reference's actual ten cells call Dynamax inference helpers, so they do not provide exposed NumPy recurrences or establish the workload.

**Provisional treatment:** Accept arrays, shapes/assertions, tiny enumerator, sequence generator and plotting as supplied infrastructure; students fill the intended recurrence operations rather than build a general HMM package. **Minimum repair:** Pilot the specific scaffold and freeze a manageable sequence/seed. Keep oracle checks and both complete passes; shorten the supplied long-plot discussion if debugging dominates. The optional persistence sensitivity is already outside the hour and cannot be claimed as recovered core time. **Consequence:** No JAX/Dynamax, parameter fitting, Viterbi code or Kalman lab should be inherited. If complete checked recurrence work still cannot fit with helpers, return endpoint/time pressure to Scope.

### R6 — HMM depth replaces a preferred forecasting outcome and narrows shared promises

**Owner/severity:** Coordinator/Lecture Scope, **advisory consequential practical-choice question**. **Evidence:** Contract v2 provisionally selects HMM as the deep exact method; current syllabi/notebook audit still prefer Kalman website-session forecasting and mention Gaussian smoothing/Viterbi broadly. Oke source inspection locates questions/data but leaves the named solved forecasting notebook unverified. The proposed HMM application does not preserve real-data forecasting or system identification, and the scope honestly says so.

**Provisional treatment:** Retain HMM as a reasonable reversible proposal under the delegated batch authority; Kalman stays compact application, not a second practical outcome. **Minimum repair:** Record the lost forecasting outcome in the consolidated instructor questions and synchronize shared future allocations with HMM implementation, selected Kalman predict/update and optional Viterbi mechanics. Do not imply full Chapters 8–9, Kalman smoothing or a verified Oke solution. **Consequence:** Choosing forecasting later would require reallocating primary mathematical/lab ownership and a targeted review, rather than adding another implementation. Actual delivered L01 ledger history remains unchanged.

## Independent mathematical and source checks

- Applied previously read AGENTS, Section Design, backpressure, timing and full WORK_ORDER instructions. Reconciled contract v2 and the exact reviewed L06/L07 blobs. Reused protected L01 source/all-cell missing-data notebook and L02/ledger inspection from this thread; nothing from those artifacts was changed.
- Directly inspected B2 December 10, 2025 extracted passages: §9.1 dynamic programming; §9.2.1/Eq. 9.1 HMM factorization and §9.2.1.1 casino emissions; §9.2.2/Eqs. 9.5–9.8 normalized filtering; §9.2.3 and §9.2.3.1/Eqs. 9.9–9.19 future likelihood and combination; §9.2.3.4 raw-versus-normalized forward form; §9.2.5 complexity; §9.2.6 and its actual recurrence/backpointer paragraph. §9.5.1 supports distributing sums into products, without requiring its student-network example.
- Directly inspected §8.1.2/Eqs. 8.4–8.7 predict/update and evidence and §§8.2.2.1–8.2.2.3/Eqs. 8.22–8.36 Kalman moments, gain/innovation and predictive Normal. The scope's bias/control-free known-parameter formulas are valid specializations; nonsingular innovation covariance is stated. B1 creates no new required source commitment here.
- Read the complete actual local `notebooks/misc/casino_hmm.ipynb`: ten cells, SHA-256 `975e90d6d095eed5e087121acd9094f57a176e270d76c6ebdbfcf6d312a18ed1`, pyprobml HEAD independently confirmed `d1ea4122dcf3c2a2c02eb4e05343203b26440827`. It sets the stated initial/transition/emission probabilities, simulates 300 steps with JAX and calls `hmm.smoother`/`hmm.most_likely_states`. Imports/install paths include Dynamax, JAX, Optax, Graphviz and probml-utils. No exact realization, printed empirical fraction or helper output is adopted as a required result.
- Read the source-inspection register and current syllabus/notebook entries concerning Oke forecasting. The named solved source remains unverified; this review did not execute or newly certify that application and did not inspect student submissions.
- Independently derived the saved-scaling identity: `a_t=f_t product_{s<=t} c_s`, so evidence is `product c_s`; `b_t=beta_t/product_{s>t}c_s` gives the backward division by **`c_(t+1)`**, not `c_t`, and `f_t*b_t` equals the smoothed vector in exact arithmetic. Independently normalizing backward messages would require normalizing the final product; the scope distinguishes these choices.
- Standard-library rational arithmetic over all eight course paths independently gave weights `.04704,.02744,.00126,.01176,.00504,.00294,.00216,.02016` and evidence `589/5000`. Forward values, saved normalizers and smoothed marginals all reproduce the scope exactly. `c=(1/2,137/250,589/1370)` has product `589/5000`; sum log normalizers equals log evidence, approximately `-2.138767007764651` nats.
- Unscaled backward vectors are `(1/4,101/500)`, `(19/50,31/50)`, `(1,1)`; scaled vectors are `(625/589,505/589)`, `(137/155,137/95)`, `(1,1)`. Their products with filtered vectors yield `(875/1178,303/1178)`, `(7/10,3/10)`, `(555/1178,623/1178)`, each summing to one. This also confirms terminal smoothing equals filtering and that local evidence is included once.
- Exhaustive weights give unique MAP path `000` with posterior `1176/2945`; pointwise modes are `001`, whose path posterior is `686/2945`. No ties explain the disagreement. The example is explicitly course-constructed, not an attributed Murphy worked case.
- Dense recurrences use `K` sums of `K` terms per step, hence `O(TK^2)`; storing time beliefs costs `O(TK)` beyond the model, while streaming filtering can use `O(K)` work memory. The scope does not promise arbitrary graphs have this complexity. The scalar Kalman example independently gives predicted variance 2, innovation variance 4, gain 1/2, updated mean 1 and variance 1.

## Most useful cut, invariants and limits

**First cut:** remove optional Viterbi recurrence/backpointer mechanics, retaining the verified path-versus-marginal counterexample and decision distinction. Estimated saving is 3–4 minutes only if those mechanics were actually developed. Next shorten the Kalman matrix catalogue to a stated result and scalar application, about three minutes. Do not turn the saved time into another smoother or algorithm. Further removal of the Kalman responsibility or changes to deep recurrence treatment require Scope-owned revision. At a strict 100-minute cap this preview does not certify all unchanged commitments.

The scope makes substantive progress beyond prior finite enumeration and Gaussian conditioning, with no material duplication at the specified depths. Retroactive summaries remain final and the notebook handoff stays separate; actual section boundaries and slide granularity remain downstream-owned.

Lingering risks are indexed-notation load, actual L02/L03 delivery, asymmetric-transition verification, floating-point behavior and student completion time. No source/course notebook, local uv or hosted Colab run, HMM runtime benchmark, long-sequence inference, general numerical-stability test, student pilot or lecture rehearsal was performed. Scratch rational checks validate only the named mathematical commitments. No full future L09/L10 reconciliation was done; the coordinator's final architecture audit still owns that gate.

**Disposition:** no blocking Scope repair required before continued reconciliation. Preserve advisory practical/timing risks and downstream validation obligations. This is not agent/instructor approval or validated Section Design; later execution backpressure remains possible.
