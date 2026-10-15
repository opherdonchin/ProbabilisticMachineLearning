# L02 course reconciliation review

**2026-10-14 · Lecture Scope feasibility-review · provisional evidence, no approval.**

**Verdict: feasible-with-risks.** Preserve the recovered eight-section teaching argument, its mathematical depths, live Gamma rainfall example, and live *The Time Machine* character example. The architecture supports that argument; it does not require turning L02 into a bigram tutorial. The smallest consequential addition is an explicit notebook evaluation contract, queued below. No new lecture scope, sections, slides or notebook are produced by this review.

## Dispatch receipt and boundaries

- **ID / owner:** `L02-RECOVERY` / delegated Lecture Scope specialist `/root/l02_recovery_dispatch`; coordinator `/root`.
- **Mode / base:** feasibility-review/reconciliation evidence; `16423885e4bf6b4b4e8a0f4e642591f9832034f2`.
- **Branch / worktree:** `reconcile/l02-course-review-20261014`; `/tmp/pml-l02-course-review-20261014`.
- **Inputs:** frozen fix `6872177f4223c57119f92036b0b178fd6f31a83f`, titles `81c7c4a62ef7039d395caba73cbcf4a15625cf9d`, rescope `a804af644a7ccb282c2ca113f78f4a2a12b1fc4d`; base architecture/maps; local Murphy PDFs. Exact blobs below.
- **Dependencies:** historical approval recovery and architecture/source inspection only. L01 slide-candidate acceptance is not a prerequisite for this assessment; prospective Gaussian knowledge remains conditional on the accepted L01 route being taught. No class has yet been taught.
- **Only allowed tracked write / deliverable:** this `Lectures/L02_Exponential_Families/reconciliation/course_review.md`. All scopes, designs, notebooks, skills, architecture/maps, AGENTS and other worktrees are read-only. External sessions own L01 slides/skills and L04–L12 scopes/maps; no takeover or duplicate work.
- **Gate:** coordinator checks evidence and allowed diff, then commits if appropriate. Instructor decisions return to owning artifacts through their owners. No self-approval, merge, publication, production or environment change. Report left uncommitted.
- Read canonical lecture-scope, shared backpressure, relevant lecture-development rules and updated coordinator skill. The latter's live SHA256 is `a2e66a82f5bd58b16b38812d6cf53f8d37dbdf739a369edc345b1a2d4203678c`; its course task reservation was read at dispatch. This is an actual delegated review, not a same-context coordinator check; no independent Section Design preview or runtime validation is claimed.

## Existing facts and approval provenance

The strongest recovered argument is **representation → moments → sufficient-statistic likelihood → moment matching**, with maximum entropy answering a separate reverse question about model construction, Gamma showing a nontrivial positive-data fit, and categorical estimation reused row by row for an observed sequence. Its purpose is transferable estimation, not solely text generation.

The fix register records instructor decisions on 2026-10-11 accepting eight sections and **53 section slides plus a separate lecture title**, keeping Gamma live and categorical/Markov learning in Sections 7/8. It records acceptance of a **course-generated first-order *Time Machine* sample** from the validated fitted matrix instead of Murphy Fig. 2.16. Its design is complete but **pending acceptance**; existing production implements Section 1 only and predates that design. Independent Authoring previews are recorded as `feasible-with-risks`; their reported checks are historical evidence, not rerun here. The 84-page design preview is not an 84-slide production deck.

The titles branch register labels its **54-section-slide regeneration proposed**, with no recorded whole-organization approval; it preserves title/retrospective-summary rules, Gaussian modularity and notebook separation. Its proposed extra Gamma move cannot silently displace the accepted fix sequence. The rescope/base register contains repeated corrupted text and an older five-slide Section 2 status; it is not reliable evidence overriding the recovered fix approvals. These distinctions resolve apparent authority conflict without asking the instructor again.

The agreed section contract requires: Bernoulli work-through; full Gaussian canonical rewrite; careful live derivation of the first log-partition derivative and MLE moment matching; covariance identity stated with derivational sketch; maximum-entropy multiplier proof sketch; Gamma identification/application without optimizer derivation; categorical count/normalize; first-order Markov estimation/scoring/generation. Gaussian Section 2 remains live and modular, with recording only a later option. Transformations and stationary-distribution theory are deferred; smoothing is optional notebook work. Retrospective summaries and a separate lecture-level notebook handoff remain settled.

The notebook audit already calls Karpathy's baby-name bigram notebook an **agreed reference**; the older fix-era audit lists NLL/generation and NumPy as a good reference. **Agreed reference ≠ approved complete adapted notebook.** It is evidence for retaining that reference, not approval of a fully adapted exercise or hosted validation. No L02 course worked solution, solved Q&A notebook or student self-work notebook was found in the frozen fix tree or current base. No L02 runtime test was run.

## Mathematical and practical assessment

For fixed parameter-independent support and justified differentiation under the integral,

$$p(x\mid\eta)=h(x)\exp\{\eta^\top T(x)-A(\eta)\},\qquad \nabla A(\eta)=\mathbb E_\eta T(X),\quad \nabla^2A(\eta)=\operatorname{Cov}_\eta[T(X)].$$

For IID data, $S=\sum_n T(x_n)$ gives $\ell(\eta)=\eta^\top S-NA(\eta)+c(D)$, so a **finite interior MLE** matches $\nabla A(\hat\eta)=S/N$. These results explain an actual computational payoff: one pass through $N$ observations obtains a fixed-size statistic, after which repeated likelihood/gradient queries do not revisit the raw sample. Sufficiency is relative to the specified family; it does not establish that the family fits the task. Zero counts can give probability MLEs on a boundary without finite logits. Those qualifications already appear in the recovered design and are author-owned correctness constraints.

In the Markov case, conditional on starts, $\ell(A)=\sum_{jk}N_{jk}\log A_{jk}$ and $\hat A_{jk}=N_{jk}/N_j$ for $N_j>0$. Start probabilities require their own start counts; unseen rows are unidentified, and transitions must not cross independent sequence boundaries. Counting costs $O(M)$ for $M$ transitions, dense storage is $O(K^2)$ for alphabet size $K$, and scoring a length-$T$ string costs $O(T)$. This saves repeated scans or generic optimization for this fully observed categorical model. The payoff shrinks with large alphabets and longer contexts; first-order context truncation loses long-range dependence. Exact count fitting does not repair that model error or quantify parameter uncertainty.

The Gamma example protects a useful architectural principle: practical competence can be built from a reusable argument applied to **different data structures**, without forcing all mathematics through the final notebook. With shape $\alpha>0$, rate $\beta>0$, and positive data, its statistics $(\log x,x)$ give $\mathbb E[X]=\alpha/\beta$ and $\mathbb E[\log X]=\psi(\alpha)-\log\beta$. It is a substantive nonlinear fit, not another Bernoulli check. A fitted rainfall overlay demonstrates model shape; it alone does not establish predictive performance or adequacy for rainfall processes containing zeros, seasonality or dependence. Positivity/import/refit/plot checks remain outstanding production evidence.

## Two-way reconciliation

| Existing component and status | Educational job / architecture agreement or tension | Minimal disposition and consequences |
|---|---|---|
| Agreed representation, Gaussian rewrite, moments and MLE | Architecture explicitly retains sufficient statistics, log-partition moments and moment matching; supports later GLM and EM arguments | **Keep.** No new depth choice; L01 need supply density/covariance, not precision already taught. Section 2 itself introduces precision. |
| Agreed maximum-entropy proof sketch | Provides the reverse model-construction argument, distinct from estimation; architecture names it explicitly | **Keep.** Use the recovered finite-support/interior construction; no new KL course prerequisite or convex-duality expansion. |
| Agreed live Gamma rainfall application | Broadens transfer beyond categorical counting; architecture's data-type competence accommodates it despite its short L02 exemplar paragraph | **Keep.** No architecture amendment needed. Validate empirical assets later; do not remove or record it automatically. |
| Agreed live Time Machine first-order model and generated sample | Fit/score/generate cycle agrees; model limitations give meaningful diagnosis | **Keep.** Fig. 2.16 is a different order/corpus; reconstruct declared first-order output. Live design explicitly excludes adding smoothing or likelihood-comparison exercises. |
| Existing baby-name notebook reference; adaptation absent | Architecture/map now expressly require held-out score, independent-character comparison and a failed-output diagnosis; those exact required outcomes are not documented in the agreed handoff | **Clarify/add notebook evaluation only after L02-Q1.** No corpus reselection needed. A one-hour adaptation remains unvalidated. |
| Live envelope 100–120 minutes; separate one-hour notebook | Summed section estimates are 97–115 minutes; mathematical Sections 3–5 are dense | **Keep provisionally.** No measured rehearsal exists. 53 section slides are an extent signal, not timing validation; no automatic recording choice. |

### L02-Q1 — Notebook evaluation contract

**Stable ID:** `L02-Q1` · **Status:** resolved, existing endpoint retained · **Owner:** instructor via Lecture Scope coordinator. **Resolution (current discussion, 2026-10-15):** “I think the notebook will be sufficient without the expansion.” The accepted boundary is recorded in Section 8's Notebook handoff and `development_state.md` on `resume/l02-notebook-contract-20261015`, commit `c8e9b2a`. Fit/inspect/score/generate remains required; baseline comparison and failed-output diagnosis optional. The original question, alternatives and recovery evidence below remain the reviewed proposal, not pending approval or the accepted contract. Worked-solution resumption and source-plan synchronization are coordinated through the course index; this answer does not approve the full Scope, design or student notebook.

**Question:** Keeping the existing baby-name bigram reference and the approved live Time Machine example, should the one-hour notebook require held-out log-score comparison with an independent-character baseline and diagnosis of a failed/implausible output?

- **A — Require the bounded evaluation (recommended).** Authors supply a fixed training/test split, boundary handling, plotting and scoring helpers. Students fit count-normalized rows, compute/interpret mean held-out negative log score, compare the baseline, generate examples and explain a failure. Adds practical judgment promised by the architecture; reduces time for optional smoothing/extra implementation.
- **B — Retain the earlier fit/inspect/score/generate endpoint.** Preserve the agreed mathematical application and minimize notebook expansion; comparison and failure diagnosis remain optional. The architecture/map owners must revise their L02 required-evaluation wording rather than count an optional inspection as delivered competence. This loses the controlled check that modeling conditional dependence improves the requested predictive task.

**Decision-relevant issue:** if a held-out transition has zero training count, the unsmoothed fitted model assigns probability zero and its negative log score is infinite. That is a meaningful sparse-data failure, not a software exception to hide. If a finite comparison is intended, authoring must provide an explicitly declared smoothed comparator or a justified evaluation convention, distinguish it from the raw MLE, and account for the extra concept/workload. Technical preflight and mathematical labeling are author-owned; no separate approval of correct formulas is requested.

**Evidence:** fix Section Design §8 and lecture-level handoff; fix Slide Design sequence-scoring constraints excluding live smoothing/comparison; base notebook-reference audit's agreed baby-name reference; base architecture L02 and curriculum-map L02's explicit held-out/baseline/failure wording. Exact refs/blobs are below. The reference choice is preserved, not re-asked. Neither a source notebook's presence nor the new map wording proves approval of the adapted required endpoint.

**Exactly awaiting answer:** required notebook evaluation outcome, its one-hour allocation and the corresponding reconciled Lecture Scope notebook handoff. No notebook build is currently authorized. No live-section change, source check, empirical asset preflight or historical approval recovery waits on this answer.

**Eventual answer destination:** L02's owning reconciled Lecture Scope notebook-handoff/lecture-contract fields and lecture-local `development_state.md` via their owner; accepted prospective allocation changes go to `curriculum_map.typ` through its reserved owner. If B is selected, architecture L02 wording also returns to its reserved owner. This report only owns the unresolved question; it does not create or edit those artifacts.

**Independent work:** source correctness checks and a corpus-independent categorical/Markov technical preflight can proceed without an answer. One small follow-up is specified below; it requires a separate checked dispatch envelope.

## Source records and remaining author-owned work

**Verified local editions:** Murphy, *Probabilistic Machine Learning: Advanced Topics* (MIT Press 2023), online version **December 10, 2025**, `Resources/book2-1.pdf`; and *Probabilistic Machine Learning: An Introduction* (MIT Press 2022), online version **April 18, 2025**, `Resources/book1.pdf`. These local PDFs were read only. Book 2 SHA256: `54d6bfa8cc4a367bb553bea1c5127ca63696a9655b2ca1f6137a8584dccfdbaf`; Book 1: `89749245bc8065d7575f990815c621a091de3facca1585168fc0369542742dcf`.

**Focused verified route:** Book 2 §2.4.1 “Definition” (printed p.34), §2.4.2.5 “Multivariate Gaussian” (pp.38–39, Eqs.2.198–2.213), §2.4.3 “Log partition function is cumulant generating function” (pp.39–41, Eqs.2.216–2.230), §2.4.4 “Canonical (natural) vs mean (moment) parameters” (p.41), §2.4.5 “MLE for the exponential family” (p.42, Eqs.2.242–2.249), and §2.4.7 “Maximum entropy derivation of the exponential family” (pp.43–44). Follow the data/normalization separation, derivative-to-moment identity, finite-interior estimation condition and separate constrained-distribution argument. For sequence application use §§2.6.1–2.6.3 “Parameterization”, “Application: language modeling”, “Parameter estimation” (pp.47–51), especially Eqs.2.274–2.278 and Fig.2.17's caption. Book 1 §3.4 “The exponential family” (pp.93–97) supports the form; §4.2.4 “Example: MLE for the categorical distribution” (p.111, Eqs.4.26–4.31) supplies the constrained count-normalize calculation.

**Identifiable raw source caveats; author-owned, not approval questions:**

1. Book 2 Eq.2.244 prints $p(D\mid\eta)=p(T(D)\mid\eta)$. Sufficiency does not equate these probabilities/densities on different sample spaces. Use factorization $p(D\mid\eta)=h_D(D)g_\eta(S(D))$, or parameter-likelihood equivalence up to a data-dependent factor. The recovered design uses the proper likelihood reduction.
2. The sentence after Eq.2.245 infers a unique global maximum from concavity alone. Existence, finite interior location and identifiability/minimality are additional issues; all-zero/all-one Bernoulli observations supply boundary counterexamples. The recovered design already qualifies the moment-matching result and categorical logits.
3. Book 2 §2.6.3.3 labels Eq.2.279 $(N_{jk}+\alpha)/(N_j+K\alpha)$ as MAP for a $\operatorname{Dir}(\alpha\mathbf1)$ prior. That is the posterior mean. An interior MAP is $(N_{jk}+\alpha-1)/(N_j+K(\alpha-1))$ when each posterior component exceeds one; alternatively the displayed rule is an interior MAP for prior concentrations $\alpha+1$. This only affects the optional smoothing extension. Do not equate these estimators.
4. Fig.2.16's caption verifies **10-gram King James Bible** output; Fig.2.17 verifies **Time Machine bigram counts and row normalization**. The accepted course-generated first-order sample repair is necessary and source-supported. Exact empirical cell values, corpus version, preprocessing and generated output remain unverified here.

**Outstanding empirical/workflow checks:** Gamma fit numbers, original MIT/Western raw files and local refit were not independently fetched or executed in this bounded recovery; their links and reported fit are historical design briefs, not verified results of this review. The recovered register also flags `Resources/lecture_02_reading_packet.pdf` as wrong-topic; packet reconciliation remains an author-owned delivery task. No compile, render, rehearsal, local notebook execution or hosted Colab run is claimed. No generated artifact was changed.

## One independent follow-up

**`L02-MARKOV-CHECK` — corpus-independent normalization/scoring preflight.** Use a tiny asymmetric categorical transition matrix and separate start convention to verify row normalization, all short-string probabilities summing to one, equivalence of product/log scoring, no cross-sequence counts, zero-support behavior, and a declared independent-character comparator. Report the raw evidence without selecting a corpus, requiring an exercise, choosing smoothing or building a notebook. This tests implementation feasibility without awaiting L02-Q1; it cannot approve the endpoint or validate a corpus/one-hour notebook. The coordinator reports that this follow-up has now been dispatched separately to `/root/l02_independent_check` on `verify/l02-markov-contract-20261014`; this reviewer did not execute or pre-accept its result.

**Next owner:** coordinator collects this recovery and the independent check, presents L02-Q1 under deferred review when appropriate, and returns any accepted handoff change to the scope owner. A complete reconciled five-part scope still needs its normal feasibility/acceptance gates. No new live-content or recording question is justified by this review alone.

## Exact artifact evidence

Frozen references are inputs, not a claim that newest content wins. The coordinator checked remote heads before dispatch; this specialist performed no fetch or checkout switching.

| Revision | Path | Exact blob |
|---|---|---|
| base / rescope | `course_architecture.typ` | `cb111196e44df211e39864be596233a1a3f22aba` |
| base / rescope | `curriculum_map.typ` | `63fb5cea0a7b0a4c908c8f803e550d087d20a412` |
| base | `curriculum_map_actual.typ` | `cf143d8c5427030cf3ac6c6ad05d8ad9cd420fe3` |
| base | `Lectures/START_SCOPING.md` | `00d180523fd61217364286eb4cc25e7362678433` |
| base | `Lectures/notebook_reference_audit.md` | `a308884fab4599eb237e28c353788c94fe68d90e` |
| fix | `Lectures/notebook_reference_audit.md` | `a078cb1882389c5f0168ce19df061352f6005bbd` |
| fix | L02 `development_state.md` | `b298acb0f40f05fc5e8281ff5aaaf59b11868306` |
| fix | L02 `section_design.md` | `bac0d8a29887f232b2895375019482fce189d706` |
| fix | L02 `slide_organization.md` | `cf3818f2b78cc49061620f7c65db39984a203fcb` |
| fix | L02 `slide_design.typ` | `243cca5f7b35e716ace7f0c41df139f2fff648c7` |
| fix | L02 `slide_deck.typ` | `0f3169065463cc62121e72db95e513d5496cba90` |
| fix | L02 `slide_design_review.pdf` (presence/status only) | `65a1cac3224594e455e8291b598030e9859ce4ca` |
| titles | L02 `development_state.md` | `4677ea2812eb721f08f26cdab6bdeec78763dd7f` |
| titles / rescope | L02 `section_design.md` | `bbf78a13db05224a839d0b2f8bda4c7a5bd0c764` |
| titles | L02 `slide_organization.md` | `9a9d36c8f660f6e0cb69f1cae7f967495a2870ab` |
| rescope | L02 `development_state.md` (corrupted older index) | `e59fb6187997e39c4d77533a035cd887796f9d98` |

Here **base** = `16423885e4bf6b4b4e8a0f4e642591f9832034f2`, **fix** = `6872177f4223c57119f92036b0b178fd6f31a83f`, **titles** = `81c7c4a62ef7039d395caba73cbcf4a15625cf9d`, **rescope** = `a804af644a7ccb282c2ca113f78f4a2a12b1fc4d`; L02 paths expand under `Lectures/L02_Exponential_Families/`.

Canonical process inputs at base: AGENTS `e3a496270dbce5f70d1fcf7d5cc698817dde7db4`; lecture-scope skill `18457eca39c51f673ad3765505776ca7bd18a4a9`; shared backpressure `1f064971a7c5930d68e7859e42355a774b4de340`; lecture-development skill `e01f5f8ab4b8fc82c9bfa60aa1c41c2b427e97a5`. The live coordinator skill/state are separately identified in the receipt; no acceptance of skill or lecture candidates is inferred.
