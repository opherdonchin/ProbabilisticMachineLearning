# Slide-judgment authoring report

Status: exploratory build/revision against provisional Design D3; not production
authoring, independent validation, instructor approval, or a claim of classroom
effectiveness. Authoring branch `experiment/slide-judgment-authoring-20261015`
starts at `1b6434b`. Design input D1 was clarified as D2 and consolidated as D3 at
`/tmp/pml-slide-judgment-design-20261015/Lectures/L01_Probability_Statistics/reconciliation/slide_judgment/design/provisional_design.md`
(D1 SHA256 `75e558dd1648124893f05add4e6d5b9afefbf38f385b749a9eeb202ffbb5f8cf`;
D2 SHA256 `572c34e3769972c8dcbba24551f9fdf396a8e4d5122c25306b6edb2ad374fd93`;
D3 SHA256 `b45fb4aa9ad36d850241e27d568005764773f44b91c80e2f48ef63f082d97fcc`).
Source hashes for this build appear below.

## Render evidence

`production/risk_variants.typ` implements A and B as complete three-move
sequences, with the decomposition realization repeated unchanged. Its source
hash is `5e7686f113a1faa9cf2c6eafd020fa31ba5064d21a94a12855898de948ee1d3a`.
The 16:9 handout has seven pages: actual63 context, followed by three A pages
and three B pages. Its presentation has thirteen pages/states: actual63 state 1;
A setup states 2–4, decomposition states 5–6, decision state 7; B setup states
8–10, decomposition states 11–12, decision state 13. All 13 states and all
seven handout pages are rendered under `production/rendered/` as
`risk-presentation-01.png` through `risk-presentation-13.png` and
`risk-handout-1.png` through `risk-handout-7.png`. The complete PDFs are
`production/risk_variants_presentation.pdf` and
`production/risk_variants_handout.pdf`.

`production/gaussian_transfer.typ` implements one distinct transfer move and
includes actual58 as its predecessor. Its hash is
`4a3a2bc9b33ba2e7f0a5018c6111884051cec97f621cc11a9c9df28e219d659d`. The
handout has two pages (actual58, actual59); presentation has five states
(actual58 states 1–2, actual59 states 3–5). All are rendered as
`transfer-presentation-1.png` through `transfer-presentation-5.png` and
`transfer-handout-1.png` through `transfer-handout-2.png`; complete PDFs are
`production/gaussian_transfer_presentation.pdf` and
`production/gaussian_transfer_handout.pdf`.

The comparison source pages are `density_experiment/comparison.pdf` pp. 7 and
11. Actual predecessor context and transfer are `slide_deck.pdf` pp. 63 and
58–59 respectively; the instructor-cited actual layout comparison is pp. 58–61.
I inspected all 27 generated page images at slide scale. Design also inspected
the transfer presentation and A handout, then all 13 D1 risk states and the
corrected D3 risk decision state. Organization inspected the A handout and
transfer, all D1 risk states, and the corrected D3 decision state. Other risk
states were unchanged by D3. These were collaborative checks, not independent
validation.

## Mechanical and visual findings

Both sources pass `scripts/check_typst_math_attachments.py`. The four current
handout/presentation PDFs compile with zero final Typst warnings: risk 7/13
pages, transfer 2/5 pages. An intermediate B decision layout exceeded the
available slide height by 11 pt; removing two unnecessary vertical gaps
resolved the warning without shrinking content. A prior math-attachment check
flagged `^T(` run-on candidates; spacing the transpose from its following
parenthesized factor made the intended multiplication explicit, and both final
sources now pass with no hits. The PDF workflow's
`mark_artifact_operation_started.mjs` could not run because this environment
has no Node runtime; it reported `node: command not found`. This did not affect
Typst compilation or rendering, but the PDF-skill marker requirement itself
remains unfulfilled.

**Design fidelity:** A and B use the agreed titles, order, complete equations,
key points and reveals. Both retain the full pointwise expansion, both
conditional moment evaluations, the intact risk identity, the equality case,
the general minimizer and minimum, and the Gaussian specialization. The setup
contains the same observed quantity and vector domains in each realization.
Gaussianity remains an application of the general optimum. The transfer retains
all actual59 model-specific block values, the generic conditioning rule, the
explicit `x_1=z, x_2=y` mapping, posterior density, mean and covariance; actual58
provides context and is not represented as part of the transfer's teaching
burden. No selected equation or interpretation is omitted.

**Comparative alignment:** A makes the named criterion, centered error,
minimizing action and Gaussian application easy to locate. Its framed regions
can make criterion and center seem like peers, and the Gaussian label receives
substantial emphasis; instructor preference on that hierarchy remains open.
B gives a continuous criterion → centering → expansion path. On the decision
slide, labels attached to the two terms expose which part depends on the action;
the aligned minimum/action consequences and Gaussian pair then read across those
terms. The attached “nonnegative; zero iff a=m” brace preserves the positivity
and equality claim in its term-local role. A gives the Gaussian application more
emphasis than B; whether either hierarchy matches the instructor’s preference
is open. B’s repeated vertical setup still risks becoming a long undifferentiated
spine. The two layouts therefore supply different explanatory paths at the same
content and scale; the renders do not establish that either is accepted or more
effective in class.

On actual59, named model blocks and the conditioning rule support a distinct
`Apply` mapping into posterior outputs. The transfer supports the reusable
judgment “show the relation that carries the argument,” while the fixed-versus-
action-dependent term labels from risk minimization do not transfer. The same
columns/cards as A are not themselves the transferable principle. This one
bounded application does not establish a universal layout rule.

## Peer exchange and learning for Authoring

Organization and Design agreed on A versus B and the p59 transfer contract;
Organization confirmed the transfer must retain every p59 formula so deletion
does not confound the composition test. Design identified an A setup wrap and a
split risk equality, missing domains in B, and a reversed B action/minimum
mapping. Organization independently noted the latter two issues and asked that
the lower decision row state that both consequences hold at the minimizing
action. I corrected the A criterion to compact `Observed y; z,a ∈ R^d` plus
separate intact loss and risk rows, added the same context to B, aligned minimum
risk under the residual term and action under the displacement term, and retained
“Consequences at the minimizing action.” After inspecting all B states, Design
and Organization found that B’s labels were still in remote columns below the
equality and that the isolated `tr V` was repeated. D2 attaches “independent of
a” and “nonnegative; zero iff a=m” directly under the two right-hand terms with
mathematical underbraces (Typst’s [documented underbrace annotation](https://typst.app/docs/reference/math/underover/)), removes the repeated standalone term, retains the
aligned general/Gaussian consequence rows, and subordinates the Gaussian label.
Design accepted the resulting p13 and handout page 7; Organization reports no
structural pressure. This exchange demonstrates why source review and exact
object-to-region mapping should precede fit claims: equations can all be present
while domain context, grouping, or correspondence is still wrong.

Potential small instruction clarification for future exploratory authoring:
require a source hash and a compact object-to-region/reveal map in the report,
along with exact handout and presentation counts and predecessor context. The
current convergence and authoring instructions already require actual states,
fidelity and comparative evidence, so this experiment does not justify a shared
skill or API change by itself. No production API, convention or live lecture
source changed.

## Open instructor-owned decisions for the coordinator

- Whether named supporting regions should appear peer-like, and how strongly the
  Gaussian application should be visually subordinate.
- Whether B's explicit term-to-consequence alignment improves the intended
  decision argument enough to offset its longer vertical reading path.
- Whether the named-role or continuous-operation explanation better matches the
  instructor's preferred visual judgment. This remains a preference question;
  neither the authors nor these renders settle it.

No count, scope, timing, course-boundary or notebook decision is reopened here.
