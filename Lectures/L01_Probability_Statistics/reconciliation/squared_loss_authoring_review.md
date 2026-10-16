# L01 squared-loss slide authoring review

**Status:** bounded two-slide insertion implemented in the live Linear Gaussian systems section. This report records the independent Slide Authoring feasibility preview and the author’s build checks; the coordinator’s visual review is separate. The whole L01 scope remains provisional.

**Reviewer and author:** `/root/squared_loss_author`; Slide Design author: `/root/squared_loss_design`; coordinating reviewer: `/root`. Source branch: `rescope-l01-l12-architecture-alignment-20261014`, insertion baseline `18d652d28a9139a9b1ab7189190ead1005d7c236`.

## Feasibility preview

The independent Slide Authoring review checked organization SHA-256 `379104f89672daf556f721cab0ff7d892bf3fd16acfc3ec165f15d48a953ea0d` and provisional design SHA-256 `d850169f77aff0c3e3bdd0367253b471a74c38a658b31313d62bd0c523ad11e3`. Verdict: **feasible with risks**. The current `course.typ` API supports the proposed cards, layout and cumulative reveals. The reviewer noted that the mean minimizes risk when the action set includes all vectors in `RR^d`, and that the second slide’s density needed checking in renders.

The Slide Design repair made the action space visible as “Choose any estimate $a in RR^d$ to reconstruct the unknown vector $z in RR^d$.” The reviewed design is SHA-256 `1f8f1a4719b1c7f233788c1416a36e3cd726beb47ca01beacbb5f6e0cfa74251`. The coordinator accepted the repair and authorized this bounded build. The design’s separate feasibility preview does not substitute for production validation.

## Build and validation

The two slides were added after “Inference often combines conditioning and summarizing” and before “Sensor fusion combines measurements according to their uncertainty,” with the design’s 2-state and 3-state cumulative reveal plans. The full centered-error expansion leads to

$$
R(a|y)=\operatorname{tr}(V)+\|m-a\|^2,
\qquad a^*(y)=m,
\qquad \min_a R(a|y)=\operatorname{tr}(V).
$$

The deck source also received five minimal spacing changes in the three pre-existing summary slides so that the math-attachment checker passes. They separate the data subscript from the following parenthesis in `p_D` and `f_D`; the notation and meaning are unchanged.

- Current deck source SHA-256: `5c4d188124c261ea0a576f4eb46fceeec136076bd3e9f9098305fee73b84006c`.
- The required `python scripts/check_typst_math_attachments.py Lectures/L01_Probability_Statistics/slide_deck.typ` completed with **No possible run-on math attachments found**.
- The targeted command `uv --no-config --cache-dir tmp/uv-cache run scripts/review_slides.py Lectures/L01_Probability_Statistics/slide_deck.typ --slide 'A point estimate needs a loss function' --slide 'The conditional mean minimizes squared-error risk' --slide 'Summary: Two taxonomies, three ingredients' --slide 'Summary: From datasets to learning problems' --slide 'Summary: Probability for machine learning'` completed with **mechanical-pass**, zero warnings, 69 handout pages and 162 presentation pages.
- The raw run manifest is `build/slide-review/L01_Probability_Statistics/slide_deck/report.json`; its source hash matches the deck hash above. Its 13 current preview PNGs were visually inspected: both reveal states and the handout for the first slide; all three reveal states and the handout for the second; and the presentation and handout renders for each of the three affected summaries.
- The regenerated committed handout [slide_deck.pdf](../slide_deck.pdf) is 69 pages, 841.89 × 473.563 pt, SHA-256 `413adedbb3ff072a469753ee5f42f53a4aa8b776c4cf61c4c47c4449b6a96381`.

The second slide’s final state is visually dense because it retains the expected-term derivation, the risk decomposition, both conclusions and the validity statement. In my author check, the risk identity and surrounding text remained readable at normal course size, and the compiler reported no overflow. The coordinator separately inspected all 13 current manifest previews at the source hash above and confirmed there was no literal macro text, overflow, clipping or reveal-order issue. This is a production visual review of the bounded insertion, not approval of the full L01 scope.
