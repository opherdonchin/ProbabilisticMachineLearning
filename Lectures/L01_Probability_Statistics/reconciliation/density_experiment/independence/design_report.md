# Gaussian independence: Design evidence and return

Mode: isolated exploratory revision/build. Owning output: `design.typ`, importing the frozen worktree's `Lectures/design.typ`. Scope: actual48 only. The builders provisionally prefer Authoring's C, `production/independence-proof-led-hierarchy.typ`, SHA256 `a3e8221d31d5a87492d2ac1f4a700bca33328c8819c9abb02eae6e131d9dcf06`. Organization retains the original title and one slide. No independent review, instructor acceptance, production readiness, classroom effectiveness or timing validation is claimed. Parent checkout, source deck, Scope, maps, notebooks, APIs and skills were read-only.

Final design SHA256: `33d5d17a1ec90c047337fc3bc46d027144a89b7952d2812b0992c5b501a3c758`.

## Inputs and versions

Frozen instructions: commit `61acb414c5956202add5f7ddbdbbdbfaadc5f304`; baseline `a804af644a7ccb282c2ca113f78f4a2a12b1fc4d`. Worktree HEAD on entry and at convergence was `f73c76ff324ff501122b111a74a16430da110cdd`; this does not change the frozen instructions. All shell commands used `/tmp/pml-l01-density-20261014` as workdir. Loaded the worktree's absolute Slide Design, backpressure and convergence skill paths, plus course conventions/design API. Read the applicable absolute Typst skill and its local math reference. `typstyle` was unavailable. Source and instruction hashes matched the input manifest where listed.

| Input | SHA256 |
|---|---|
| AGENTS.md | `2786f4cd51cf8413e6e03f881b49aa1e5a41fd010c6d6fc2995f60918fdf919f` |
| Slide Design skill | `2b4252cca1fd9fc11827cef8c39aec16a0fd22a71f652f183b3535369b9edd80` |
| Shared backpressure | `5fe6ba181dfd5f67b459c16c13215d01f1f4bade7e2f9da52f5161ae72d6122d` |
| Shared convergence | `3255d69b04613c2930a350f2f21bb5cf2ebbf062991ce6ddcf54e2779a4b47d3` |
| Slide Design conventions | `3f08006ca31e4d4bf113a7598d13116f6b02c0a4dcb7f9078d83b676319ab938` |
| Lectures/design.typ | `b839a0779d0533ac766566fa4d70dc7d768726c24dacc6e95d6cfd68b9e5a1b0` |
| Applicable Typst skill | `4ae40b8d0514bf172dc0fabd3f4c092ce23f5d37e805c774d8d6f19d97bb3379` |
| instructor_request.md | `5379e66bd24759e562a0dbf085b50b3b694afff656b99c1ed8eb10af53bad546` |
| Common task.md | `b3910526455e88fbf9c7f8aa7cbdf27a4410d7f1b0b7ba23e8fadadb3d48bea2` |
| Original slide_deck.typ | `5c4d188124c261ea0a576f4eb46fceeec136076bd3e9f9098305fee73b84006c` |
| Original slide_deck.pdf | `413adedbb3ff072a469753ee5f42f53a4aa8b776c4cf61c4c47c4449b6a96381` |
| Relevant lecture_scope.md | `5013bf9aa09440d52caeda9c17b2807d4b10f79915e1ef20a245c3ec68207db2` |

Read the current instructor request and only common/independence task contracts. Did not read loss outputs, loss reports or historical fault lists. Relevant Scope passages retain live derivation of the independent residual; positive definite joint covariance is the ordinary-density regime. The projection is a proof sketch, not a fully qualified theorem.

Checked the local primary source: Murphy, *Advanced Topics*, December 10, 2025 online edition, printed p.24, §2.3.1.3 “Marginals and conditionals of an MVN,” Eq.2.78. The formula agrees with the candidate. The source directs its proof to §2.3.1.5; the residual argument is a course reorganization, explicitly identified in the candidate source note. Also inspected *An Introduction*, April 18, 2025 edition, §3.1.3's warning that zero correlation does not imply independence. The projected Gaussian implication is specifically joint Gaussianity; Gaussian marginals alone would not suffice. Exact local book identities are in `inputs/manifest.json` (Book2 hash `54d6bfa8cc4a367bb553bea1c5127ca63696a9655b2ca1f6137a8584dccfdbaf`, Book1 `89749245bc8065d7575f990815c621a091de3facca1585168fc0369542742dcf`).

## Selected explanation and actual prior context

Original48 is already mathematically substantive. Its final state shows the residual, zero mean, cross-covariance calculation, joint Gaussian warrant, conditional residual expectation and mean result. Revision was not prompted by a missing independence reason. Its result-left/proof-right relationship is useful, but the proof occupies a narrower crowded region while the left result region is mostly empty.

The selected chain remains:

\(B=\Sigma_{12}\Sigma_{22}^{-1}\), \(r=x_1-\mu_1-B(x_2-\mu_2)\), \(E[r]=0\);
\(\operatorname{Cov}(r,x_2)=\Sigma_{12}-B\Sigma_{22}=0\);
affine closure gives jointly Gaussian \((r,x_2)\), so the vanishing cross-covariance gives independence;
\(E[r\mid x_2]=E[r]=0\), hence \(E[x_1\mid x_2]=\mu_1+B(x_2-\mu_2)=\mu_{1\mid2}\).

The Gaussian warrant and conditional expectation are new reasoning and remain ordinary proof objects. The centering statement remains visible because the final conditional expectation uses it. Covariance bilinearity and inverse cancellation need not be expanded for the established probability/linear-algebra context. Actual47 visibly applies the affine rule; actual39 warns against a general covariance-independence rule. C names affine closure locally rather than assuming readers infer why the transformed pair remains Gaussian.

Omitted from projection: the conditional-density header and the alias `r=x1−μ1|2` before proving the mean. Actual49 treats covariance and reuses the independent residual; C's final mean equality makes that alias recoverable. Later section material assembles the conditional Gaussian law. This preserves derive depth and the live residual endpoint. Technical invertibility/positive-definiteness conditions remain the established scope regime. No new example, covariance proof or theorem proof is introduced here.

## Raw material exchange and corrections

Design's first offer to Organization:

> Design initial evidence: original48 has a substantive one-slide argument, with result at left/proof at right and bottom interpretation. Main burden is right-side stack, not lack of Gaussianity warrant. I favor preserving one teaching move provisionally while offering a proof-led spatial alternative. Essential chain: B=Σ12Σ22^-1; r=x1−μ1−B(x2−μ2); E[r]=0; Cov(r,x2)=Σ12−BΣ22=0; affine closure→(r,x2) jointly Gaussian; hence r ⟂ x2; E[x1|x2]=μ1+B(x2−μ2). Conditional density can be subordinate context here (following49 treats covariance). Will negotiate after authoring evidence; please return your boundary/count assessment.

Organization's response:

> Agree provisional one move/count1. Neighbor47 establishes affine selection; neighbor49 explicitly reuses independent r. Existing48 argument is substantively sound and useful result/proof relationship, not justification-free. Organization proposes same title and one continuous residual→Cov0→jointGaussian→independence→conditionalMean move. Test proof-led spatial alternative alongside existing result/proof grouping; split only if render reveals attention competition at normal scale. Design can omit circular-looking r=x1−μ1|2 alias until mean established, retaining r=x1−μ1−B(x2−μ2), and restore alias/result for49. Gaussian warrant must be an explicit local link. No extra summary: bounded interior cluster; existing section retrospective unchanged.

Design supplied Authoring the exact equations above, separate bottom interpretation (“The observed deviation x2−μ2 shifts the mean through B=Σ12Σ22^-1.”), and source-note wording identifying the course residual proof. A repeated the mean as left result beside proof; B introduced the result at the end of one full-width proof. Both retained all inferential links.

After inspecting both actual handouts, Design's C counteroffer:

> Inspected A/B handouts. A keeps stronger result/proof distinction but duplicates the mean and balances sparse left against heavy right. B avoids duplication yet long proof heading and7 equal-weight rows don't identify endpoint. C semantic counteroffer accepted: B fullwidth path, group (i) B,r,E0 as centered-residual definition/check, (ii) Cov0 then affine closure/jointGaussian → independence, (iii) E[r|x2]=0 then conditionalMean at normal object fs('m') with a visible grouping gap. Short title 'Centered residual' instead of long heading; end result its own region or unheaded main equation. Keep all selected math; avoid three peer headings. Spatial distances should group licenses/conclusions. This is hierarchy repair, not more whitespace as goal. Four meaningful states remains plausible.

Correction to that scale suggestion: the course API's `fs('m')` is smaller than proof `fs('l')`; Authoring correctly realized the requested larger result with `fs('xl')` (0.90em) versus `fs('l')` proof support (0.84em), without shrinking proof. Design accepts the implemented hierarchy rather than the mistaken token suggestion. C grouped E[r]=0 in state1 with its centered residual; initial Design offered it in state2. Design accepted that concrete grouping and updated its own reveal contract.

Authoring's realization return:

> Candidate C realizes your hierarchy counteroffer in a new file; A/B remain unchanged. Full-width 'Centered residual' card groups B,r,E[r]=0; state2 adds covariance; state3 adds joint Gaussian then independence; state4 adds E[r|x2]=0, then a larger separate unheaded equation for E[x1|x2]=.... Handout shows complete argument and larger result. Target handout and all 4 states are under `build/slide-review/production/independence-proof-led-hierarchy/`; source `.../independence-proof-led-hierarchy.typ`. Please inspect C and return acceptance/counteroffer. I also inspected C's unchanged neighbor handouts and all 4 states; actual47 and49 bodies are unchanged, and state progression remains authentic.

After inspecting all C states, Design accepted it provisionally. Organization independently within the builder exchange returned:

> Inspected C a3e8221d… handout+all4 target states. Realized setup E[r]=0→Cov0→adjacent affineGaussian/independence→conditionalResidualMean plus distinct unheaded larger mean below. Visible dependencies survive all reveal stages with prior lines retained; result is clearly identifiable. Organization prefers C over A/B provisionally and retains title/count1. Remaining centering/similar-weight proof lines no longer force boundary change; three successive proof warrants still demand explanation, not a classroom-tested result. Confirm current Design choice so I can return convergence report.

Material offers and decisions were copied to the coordinator during the exchange. No meaningful source was overwritten: A/B/C remain distinct live comparison alternatives in Authoring's ownership.

## Actual images inspected and comparison

Design inspected the frozen `inputs/original_independence/actual-{47,48,49}-handout.png`, original target `slide-2-state-{1,2,3,4}.png`, and `inputs/precedents/actual-{39,59,61}-handout.png`. Inspected the original47–49 and affine-rule source bodies. The precedents supplied concrete course evidence:39 puts covariance mathematics above separate interpretation;59 relates reusable blocks to application;61 groups component calculations feeding a shared result. These are relationship/scale precedents, not mandatory geometries.

For each A/B/C, inspected the actual target handout and presentation1–4 PNGs, 1263×711 pixels, in `build/slide-review/production/{independence-result-proof,independence-proof-led,independence-proof-led-hierarchy}/`, all with target stem `conditioning-shifts-the-mean-by-an-observed-deviation-45ab94fd`. Also inspected all three A4 design-render pages at `build/independence-design-{1,2,3}.png`. The A4 specification itself does not establish slide readability.

| Realization | Design judgment from the complete states |
|---|---|
| Original48 | Sufficient visible argument; useful result/proof split; heavy narrow proof stack. |
| A, hash `ca8cf2462a4a4d6afe73c4578d470afdab7efdb55fea562be476eebb8bc052ad` | Explicit affine warrant and leaner framing, but sparse left beside crowded right; the mean is repeated. |
| B, hash `c8f4a299e78372450834f96849976c4a559ca2a0aa3ed19d315133266df57a21` | Direct proof order, no repeated result, but long proof heading and same-weight proof/result rows flatten hierarchy. |
| C, hash `a3e8221d31d5a87492d2ac1f4a700bca33328c8819c9abb02eae6e131d9dcf06` | Short local heading and separate larger endpoint preserve proof order and expose its result. Gaussian license remains adjacent to independence; conditional expectation bridges proof to result. |

C's meaningful states:1 introduces B, r and E[r]=0;2 adds the covariance cancellation;3 adds affine closure/joint Gaussianity and independence;4 adds the conditional residual expectation and separate larger mean result. All prior lines persist. Key point stays in the separate bottom interpretation region. No proof symbol, warrant or conditional-expectation step was removed to achieve capacity. The support still contains similarly weighted centered lines: the improvement is a clearer endpoint and linear dependency path, not demonstrated ease of reading every intermediate line. One slide remains defensible; no render evidence required a split.

## Checks, limits and next owner

The design compiled and the canonical math-attachment check returned no possible run-on attachments. A4 pages and actual slide equations were visually inspected for grouping. Authoring's C report binds the render to its cited source hash, emits four target states and reports `review-warnings`; its warning concerns an empty wrapper section page, not the selected target. Authoring owns production validation details. Source bodies of neighbors were preserved by Authoring; Organization reported an original neighboring-render/source reveal discrepancy outside48. Design does not repair or certify those neighbors. The coordinator should retain original frozen neighbors as the comparison authority.

This is a guided coupled builder comparison, not an independent evaluation or a matched old/new-skill control. Timing, classroom attention and general reliability remain unmeasured. The new instructions prompted useful content selection and a concrete hierarchy counteroffer after A/B evidence; C alone cannot establish their effectiveness across lectures. Independent image-only review should judge the chosen states and original neighbors before the instructor decides adoption or another revision. There is no new instructor-owned mathematical/depth decision inside this bounded case; promotion and instruction-patch adoption remain with the instructor.
