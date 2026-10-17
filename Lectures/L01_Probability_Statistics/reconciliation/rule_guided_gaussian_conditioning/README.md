# Rule-guided Gaussian-conditioning experiment

Status: complete autonomous first candidate, frozen for instructor evaluation:
**17 handout slides / 33 presentation states**. This experiment does not replace
the canonical recording or carry instructor approval.

The current [user request](user_request.txt) overrides the two supplied briefs'
consultation pauses: finish a complete candidate autonomously, document meaningful
decisions, perform normal technical and visual validation, then stop for instructor
evaluation. R01–R15 remain guidance for constructing the explanation, not a score
or evidence that students will find it clear.

## Candidate and design decisions

- [Offline slide browser](candidate/preview.html), with controls for each reveal.
- [Handout PDF](candidate/slide_deck.pdf) and [presentation PDF](candidate/slide_deck_presentation.pdf).
- [Argument map](candidate/argument_map.md), [slide organization](candidate/slide_organization.md), and [design source](candidate/slide_design.typ).
- [Selective rule-application ledger](candidate/rule_application_ledger.md).
- [Executable deck source](candidate/slide_deck.typ).

The argument begins with the conditional-density query and the full joint
density. Block row and column elimination expose the residual covariance. Its
positivity and the reversible coordinate map justify the inverse calculation,
which separates the quadratic. The same elimination gives the determinant
identity. Splitting the dimension and determinant factors then produces two
normalized Gaussian densities. Integration identifies the marginal; division
gives the conditional. The final zero-cross-covariance case checks the result.

The most consequential choices are to derive the subtraction coefficient from
the block it cancels, retain the observed covariance's original name, reuse one
transformation for the inverse and determinant arguments, and keep the full
normalizing constants and probability-law identification visible. The ledger
records alternatives and rule tensions at the affected slides. In particular,
the design rejects a prefabricated block-inverse lemma, extra aliases for the
observed covariance and diagonal matrix, and an unexplained jump from kernels
to normalized probability laws. Measured overflow led to splitting inverse
substitution from block multiplication; formula clearance was preserved.

## Provenance and boundaries

The experiment began on a clean `lecture/l01-delivery-readiness` checkout at
`74adf46210355917007898d51dd9f3d16748e263`. A successful `git fetch origin`
confirmed that the remote branch had the identical tip; no integration or reset
was needed. The two experiment documents were already present at that commit.

The instructor authorized the fixed mathematical purpose and depth, autonomous
candidate generation and isolated validation. The particular sequence and visual
choices are the designers' judgments. Design and authoring used separate agents
with the existing specialist skills and direct communication; their agreement is
not instructor acceptance. The coordinator checked the source and resulting
mathematics. This is not a blinded design experiment: the current recording and
prior course context were available as required inputs.

[Source provenance](source_provenance.md) distinguishes Murphy's moment-form
derivation from course completions. The general proof is checked from the visible
candidate; [finite numerical checks](mathematics_checks.json) separately exercise
matrix, quadratic and fully normalized density identities. They do not establish
the general proof or instructional effectiveness.

Canonical lecture/recording sources, PDFs, notebooks, shared conventions and
skills are protected by the [isolation manifest](isolation_manifest.json).
After the baseline was frozen, the instructor explicitly authorized committing
and pushing these experimental products on `lecture/l01-delivery-readiness` so
another chat could inspect them during instructor-led revision. This authorizes
remote review access; it does not approve the exposition or authorize a merge,
canonical replacement, course release, recording capture or permanent workflow
change. Timing and learner comprehension remain unmeasured.

## Validation and stopping point

Both modes compile with zero Typst warnings. The mathematical-attachment check
passes. The repository's [raw render report](candidate/validation/render_report.json)
binds the complete 17/33-page run to the source. Every completed slide and every
presentation state was inspected as an actual page raster; the longer formulas
were also enlarged. All final presentation states match their handouts. The
[authoring report](candidate/validation/authoring_report.md),
[mathematical check](mathematical_validation.md), and ledger distinguish those
checks from claims about teaching quality.

The [receipt](receipt.json) records frozen artifact hashes, source identities,
the numerical checks and the unchanged-file isolation check. Initial lowering
defects and the one capacity-driven restructuring are recorded in the ledger;
they were corrected before this baseline was frozen.

No mathematical or compile defect remains identified by these checks. The
orientation's assumption text wraps over two lines; several recall objects and
the density ratio are visually subordinate to the main calculations. Whether
that hierarchy and the chosen segmentation work at recording pace remains
unmeasured. No student trial, timed rehearsal or instructor acceptance is
claimed. `typstyle` is unavailable. The offline browser's JavaScript syntax and
embedded page/mapping data were checked; interactive browser execution could not
be tested because no computer-use browser surface was enabled. The PDFs and
their actual rasters were inspected directly.

The instructor's next step is to evaluate this baseline. Work stops here; no
further redesign is started in anticipation of that feedback.
