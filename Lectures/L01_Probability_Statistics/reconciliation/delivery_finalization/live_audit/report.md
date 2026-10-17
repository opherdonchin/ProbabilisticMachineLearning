# Independent whole-L01 live-deck audit — frozen baseline

Read-only audit by a reviewer who did not author the candidate. Ownership is only `/tmp/l01-live-delivery-audit/`. No repository files were edited, no Git/remote operations were performed, no notebook pedagogy was reopened, and no teaching-time estimate was invented. The coordinator was notified of concrete technical findings during the pass. This report covers the frozen baseline; later repair validation must be recorded separately.

## Frozen inputs and scope

- Source: `frozen_slide_deck.typ`, SHA-256 `b13a173b6432f901a9f1bfad9c4aa08163f6a9b506fe01ed50e6cec07c0730cc`.
- Handout: `frozen_slide_deck.pdf`, 70 pages, SHA-256 `2d12a7a69f6db9aa4813f2bc07b658d4e41fd7ef655aeca2a25718b1fb758a84`.
- Presentation: `frozen_presentation.pdf`, 164 states, SHA-256 `55cc7647c780261663764b9d5b08133916f8c69ad5385505c44415184c3cb681`.
- Read current `development_state.md`, full source, Scope's accepted direction and live/recorded mathematical contracts, Slide Authoring skill and production conventions. Preserved the accepted live loss proof and notebook boundaries.
- Reviewed mathematical objects, notation, assumptions, local reasoning, figure/source attribution, all reveal states and handout finals, assets, links, legibility and transitions. Whole-Scope approval, recording production, notebook runtime and rehearsal are separate gates.

## Result

The baseline has one high-priority production defect: **the p41 covariance proof is dropped from every rendered state despite being present in source**. Four additional bounded technical corrections are candidates for coordinator adjudication: a missing nondegeneracy assumption; the ill-typed Action transition equation; the marginal-state comparison wording; and conditioning/independence qualifiers for the Binomial count. These can be repaired without changing approved proof depth or the teaching sequence. Three advisories are separated below and should not be treated as authority to redesign.

## Complete coverage and exact inventory

All 70 handout pages and all 164 presentation states were inspected as raster contact-sheet tiles. Images were rendered at maximum dimension1200 pixels; contact sheets use six tiles at up to796×449 pixels. Full-size targeted inspection included handout p25,p32,p41,p51,p58 and presentation s96–97; the book raster spot checks are indexed below. Text extraction and source inspection supplied equation-level evidence. The source attachment checker found no possible run-on math attachments.

`coverage.json` maps every handout page/title to its exact presentation states. The complete state list is exactly1…164 with no omissions or duplicates. `handout_final_state_comparison.json` records that every handout page is pixel-identical to its final presentation state at the same render dimensions. Thus the handout and presentation do not disagree; both share the p41 omission. The only pair of identical adjacent presentation states is95/96, preserved in `duplicate_states.json`.

| Section (divider included) | Handout pages | Presentation states |
| --- | --- | --- |
| 1. A familiar modeling language | 2–9 | 2–20 |
| 2. From statistics to machine-learning problems | 10–22 | 21–56 |
| 3. Classes of machine learning problems | 23–27 | 57–68 |
| 4. From datasets to learning problems | 28–35 | 69–81 |
| 5. Joint Gaussian distributions and geometry | 36–44 | 82–101 |
| 6. Marginals and conditionals of a Gaussian | 45–54 | 102–127 |
| 7. Linear Gaussian systems | 55–70 | 128–164 |

The title occupies handout p1 / presentation s1. Section7's retrospective section summary is p69/s163; p70/s164 is a retrospective lecture-level visual-anchor summary. All other sections end in retrospective summaries; no exit teaser was found. These ranges are an inventory, not a timing calculation.

## Findings and smallest repairs

### F01 — high: The authored covariance derivation is absent from the rendered handout and all presentation states.

**Location:** handout [41]; presentation [94, 95, 96, 97]; frozen source lines [1768, 1805]. **Kind:** production/reveal defect.

Source has Cov[y]=E[(Ad)(Ad)^T]=A E[dd^T] A^T=AΣA^T, but p41/s95–97 end at y−E[y]=Ad. s95 and s96 are pixel-identical.

**Smallest candidate:** Bind the nested reveals to an explicit four-state slide callback, retaining the authored derivation and all four states; inspect both modes. **Owner:** Slide Authoring. **Status:** baseline defect; root notified and preparing repair.

### F02 — medium: The nondegenerate Gaussian density/inverse sequence never states positive-definite covariance or positive scalar variance.

**Location:** handout [37, 40, 42, 48, 49, 50, 53]; presentation [83, 84, 85, 92, 93, 98, 99, 109, 110, 111, 112, 113, 114, 115, 116, 117, 118, 125, 126]; frozen source lines [1594, 1620]. **Kind:** missing mathematical domain assumption.

The deck gives Σ∈R^(D×D), then |Σ|^(-1/2), Σ^(-1), Σ22^(-1), and S^(-1). A covariance matrix may be merely positive semidefinite; these expressions need additional assumptions.

For X=(U,U), U~N(0,1), Σ=[[1,1],[1,1]] is a valid Gaussian covariance but has determinant zero and no ordinary inverse.

**Smallest candidate:** State at Gaussian entry that density/inverse formulas assume nondegenerate Gaussians, Σ≻0 (scalar σ²>0); retain unrestricted affine moment identities, whose output covariance can be singular. For the later LGS inverse formulas, state positive-definite prior/noise covariances or otherwise ensure the relevant measurement covariance is invertible. **Owner:** technical author/reviewer. **Status:** candidate for root adjudication.

### F03 — medium: The Action task row applies the sampled action as a state-to-state/reward function.

**Location:** handout [25, 33]; presentation [65, 66, 79]; frozen source lines [1076, 1478]. **Kind:** notation/type defect.

The chain ends (x_(t+1),r_(t+1))=a_t(x_t), while a_* is drawn from π_D. No definition makes the action itself a function of the state producing the environment outcome.

**Smallest candidate:** Keep the same action row and replace that equality with a labelled environment transition (x_t,a_t) → (x_(t+1),r_(t+1)), or state the transition kernel. Keep indices consistent. **Owner:** technical author; organization unchanged. **Status:** candidate for root adjudication.

### F04 — low: The final marginal-state interpretation repeats the conditional mean/variance change without naming the comparison.

**Location:** handout [51]; presentation [121]; frozen source lines [2192, 2195]. **Kind:** context/claim ambiguity.

State121 first says X2 unobserved and marginalize to p(X1), then says the mean rises 0→1.2 and variance falls1→0.36. Those changes describe conditioning, not the immediately discussed marginal. The two displayed laws themselves are correct.

**Smallest candidate:** Prefix the repeated bullet with “Compared with the marginal, conditioning…” or remove this duplicate bullet only after preserving the conditional interpretation in state120. **Owner:** technical copy/context correction. **Status:** candidate for root adjudication.

### F05 — low-to-medium: The introduction calls the count N1 Binomial without conditioning on the random bias θ, and does not explicitly state conditional independence of the tosses.

**Location:** handout [3, 4, 7]; presentation [3, 4, 5, 6, 7, 8, 15, 16, 17]; frozen source lines [39, 150]. **Kind:** missing conditional qualifier.

θ has a Beta prior. Under conditional iid tosses, N1|θ~Binomial(N,θ); marginally N1 has the Beta–Binomial prior-predictive law. The conjugate likelihood is valid under the conditional-independence assumption.

**Smallest candidate:** Qualify the p4 bullet “Given θ: independent Bernoulli tosses; Binomial for the count N1.” No new derivation or slide needed. **Owner:** technical author/reviewer. **Status:** candidate for root adjudication.

F01 raw evidence is directly available in `handout-41.png`, `state-094.png` through `state-097.png`, the corresponding extracted text, and frozen source lines1768–1805. In particular, this frozen output does not support the register's historical statement that p41 was complete. No independent inference about the historical renderer/version is made.

## Advisories (not delivery-blocking findings)

- **A01 (precision advisory; p[8]):** The posterior-uncertainty reduction is true in the displayed Beta(2,2)→Beta(9,5) example. As a universal Bayesian claim it is false for a particular observation. Add “In this example” if a copy repair is made; no need for a new counterexample slide.
- **A02 (local explanatory warrant advisory; p[41, 47, 48, 58]):** p41 displays moment transformations, not the explicit affine-Gaussian closure law later used in p47 and p48. The law is true, but moments alone do not establish Gaussianity. A short “If x~N(μ,Σ), Ax+b~N(Aμ+b,AΣAᵀ)” states the required warrant without adding a proof. Treat as explanatory completeness, not an incorrect moment identity.
- **A03 (legibility advisory; p[4, 16, 27, 29, 34, 70]):** Figure micro-labels, the Iris table, dataset ages and miniature summary formulas are small relative to normal body text. They remain recognizable illustrations at1200-pixel rendering, with no clipping. If students must read individual table entries or summary equations from a projector, enlarge the specific object; their intended illustrative/retrospective role is an instructor/design choice. No classroom viewing test was performed.

No new sequence change, section split, proof relocation, taxonomy reduction, loss-layout comparison or notebook change is proposed. The instructor owns the two-hour fit, practice emphasis, recording contract and any consequential changes of depth. The audit offers no measured human timing.

## Source checks and mathematical positive evidence

Exact book references were checked against the **local PDF editions**, not guessed from memory. Book1 is *Probabilistic Machine Learning: An Introduction*, online edition April18,2025. Book2 is *Probabilistic Machine Learning: Advanced Topics*, online edition December10,2025. PDF physical pages differ from printed pages; the following coordinates distinguish them.

| Deck content | Local verified source | Evidence/result |
| --- | --- | --- |
| Iris photos/table/pair plot, p16–17 | Book1 physical32/34, printed2/4, Fig1.1/Table1.1/Fig1.3 | Species/panel order, four measurements and all displayed table values match. Pair-plot diagonal/off-diagonal claims match caption. Raster source pages32,34 inspected. |
| MNIST/CIFAR/IMDB, p29–32 | Book1 physical49/50/52, printed19/20/22, Fig1.12a/Fig1.13b/Table1.3 | Correct figure/table IDs, image shapes, label cardinalities and snippets. The on-slide age calculations are approximately correct for2026. |
| Covariance/correlation/affine moments, p39–41 | Book1 physical107–108, printed77–78, §3.1.1–3.1.2, Eqs3.1–3.7 | Mathematical formulas and matrix block symmetry correct. Eq3.5 is a covariance identity, not itself a Gaussian closure theorem. |
| Gaussian density/Mahalanobis/contours, p37,p42–44 | Book2 physical56–57, printed22–23, §2.3.1.1, Eqs2.71–2.73/Fig2.8 | Formulas match. Course contour figure is visibly an adaptation (different numbers/orientation), labelled course rendering; no exact source numerical equality is claimed. Raster Fig2.8 inspected. |
| Gaussian marginal/conditional, p46–54 | Book2 physical58–61, printed24–27, §2.3.1.3 and §2.3.1.5, Eqs2.75–2.79/2.91/2.94–2.103; Book1 physical115, printed85, §3.2.4 | Marginal coordinate-selection product, residual mean/independence argument, covariance subtraction, Schur-complement orientation and quadratic-separation identity are correct under the stated missing nondegeneracy condition. p47–49 have their complete reasoning/reveals. |
| Bivariate checkpoint, p51 | Course-constructed adaptation, correctly labelled; Book2 Eq2.78 / Book1 §3.2.4 support method | For suppliedρ=.8 and observation1.5, conditional mean1.2 and variance.36; marginal N(0,1). No parameter fitting is implied. |
| LGS joint/update/scalar/forward, p56–62,p68 | Book2 physical62–63, printed28–29, §2.3.2–2.3.2.2, Eqs2.118–2.129 | Joint blocks, cross-covariance orientation, gain, scalar denominator and forward covariance correct. Independence of noise and state is explicitly present. |
| Conditional squared loss, p64–66 | Book1 physical206, printed176, §5.1.5.1, Eqs5.32–5.34 plus labelled course vector elaboration | Finite conditional second moment, cross-term zero, trace covariance, unique unconstrained conditional-mean minimizer and minimum risk correct. No reveal-dropped equation found; accepted layout not reopened. |
| Sensor fusion, p67,p69,p70 | Book2 physical64, printed30, §2.3.2.3/Fig2.10 | Course-owned qualitative schematic is explicitly labelled weak-prior-limit; independent sensor noise and finite-prior qualification are visible before later qualitative claims. The book's unqualified midpoint prose must not be read as a finite-prior theorem. Raster Fig2.10 inspected. |

Source-page text extracts are preserved as `book1_pdfpage_*.txt` / `book2_pdfpage_*.txt`, with full text extractions and selected source-page PNGs. Source figure provenance records `figures/book1_section12_sources.md` and `figures/historical_sources.md` were read. Fisher/Rosenblatt crops visibly retain Fig1 labels and match their declared works; the original historical scans were not independently fetched, so this audit does not certify those scans' full-page provenance. The deck's Mitchell quotation is attributed to Mitchell1997; this pass did not independently inspect the full Mitchell text. No historical-source claim was replaced with a guessed Murphy citation.

## Assets, links, layout and mechanical limits

- All34 literal image/figure-path references resolve; `asset_inventory.json` records file hashes. Every referenced asset appears in the reviewed renders; no missing-glyph box, broken asset, obvious clipping, overlapped equation or cut-off footer was found. p58's compact joint block was checked full-size and its rows remain separated.
- `pdfinfo -url` reports no external PDF URI annotations, so there are no active in-deck external links to check. Source-note notebook names are plain provenance text. Website availability is outside this link inventory.
- Apart from F01, reveal sequences expose the expected constructions and final statements. p13's replacement notes are intentionally absent from its final handout; p25's four task descriptions intentionally become its recap at state5; p51's question/answer replacement is intentional. These are not missing final-state reasoning defects.
- Ordinary formulas, headings and key points are legible in the checked render. Small illustrative micro-labels are the bounded A03 advisory. There was no projector/room test or human rehearsal.
- Command: `python scripts/check_typst_math_attachments.py /tmp/l01-live-delivery-audit/frozen_slide_deck.typ` → `No possible run-on math attachments found.` Rendering used Poppler `pdftoppm -scale-to 1200 -png`; extraction used `pdftotext -layout` and `-bbox`. The supplied frozen PDFs were audited; an independent recompilation was not needed for this read-only pass and is not claimed. Root production validation remains the compilation gate.

## Evidence files

`manifest.json`, `coverage.json`, `sections.json`, `findings.json`, `asset_inventory.json`, `handout_final_state_comparison.json`, `duplicate_states.json`, frozen source/PDF copies, full extracted text, all234 individual PNGs,12 handout contact sheets and28 presentation contact sheets retain exact review evidence. Later root repair checks should be appended in a separate recheck report so this baseline finding record remains recoverable.
