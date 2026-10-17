# L01 delivery finalization

The accepted notebook and live loss sequence are preserved. The complete live deck has been independently audited and its clear technical defects repaired; current local notebook execution and student derivation pass. The separate recording has been rewritten and checked under the instructor's subsequent review, with its full proof preserved. Whole Scope acceptance, measured teaching/learner time, recording acceptance/capture and public/hosted release remain separate.

The instructor authorized the original three unattended workstreams with “Go ahead” on 2026-10-17. Their baseline was `lecture/l01-delivery-readiness@196e5e5`; the instructor notebook run was first preserved in `e5fb7e9`. They subsequently requested a complete recording revision from `ea3c267`, established its one-section format and identified recurring formula-spacing problems. [The manifest](manifest.json) binds exact versions and assignment provenance. Current specialists use disjoint files in the same worktree; root owns shared conventions, numbering, integration and current status. No export, merge, publication, additional learner simulation or notebook restructuring was performed.

## Live lecture: audit and repairs complete

Use the current [70-page handout](../../slide_deck.pdf). The presentation is [164 reveal states](../../../../build/slide-review/L01_Probability_Statistics/delivery/slide_deck_presentation.pdf). Both compile with zero warnings; the attachment checker passes.

A reviewer separate from the repair author inspected the entire frozen deck: all 70 handouts and 164 states. The [raw audit](live_audit/report.md) identified a missing rendered affine-covariance proof, unstated nondegeneracy assumptions, Action notation applying an action as a function, an ambiguous conditioning comparison and an unqualified Binomial-count statement. Two related qualifiers clarify example-specific posterior narrowing and affine Gaussian closure. The smallest repairs preserve slide order, proof depth and count; no shared theme or figure changed.

The [independent repair recheck](live_repairs/report.md) passes all findings F01–F05 and advisories A01/A02. All 23 scoped states and eight handouts were inspected. Exactly eight handouts and nineteen states changed; four scoped states precede the changed text and remain identical. All other renders, including the accepted loss sequence and its wider context, are pixel-identical to the frozen baseline. All 70 handouts match their final presentation states. Exact hashes, full comparison results, source delta and the restored proof images remain in `live_repairs/`.

The raw audit’s small-label advisory A03 remains for projector rehearsal: pp4,16,27,29,34,70 contain illustrative/table/summary details smaller than body text. No clipping was found; whether individual entries must be readable is a teaching/design judgment. It is not a new technical blocker. [The rehearsal worksheet](rehearsal.md) gives actual page/state ranges and blank timing fields. No timing result is inferred from source counts.

The live deck now uses **L01** and the existing L02 source uses **L02**. Both modes compile without warnings. L01's 70-page handout and 164-state presentation retain pixel-identical content and footers below y=55pt (the ordinary body begins at 60pt), excluding the title page, compared with the prior numbered version. Only lecture-identification chrome changes. The manifest records this check; no live proof or notebook was restyled.

## Separate recording: L01-R01

**Current exposition status:** the instructor subsequently found the rewritten
opening hard to follow and reopened its mathematical design. The bounded
[fresh-reader trial](../exposition_trial/trial.md) also returned a favorable
review of that opening while identifying no conceptual repair. That negative
result for the proposed review mechanism is preserved; it does not resolve the
instructor's concerns. Technical checks below remain valid for their exact
artifacts. No further recording candidate or workflow change was made.

The instructor requested a complete explanatory revision after reviewing the first realization. Their format decision is now recorded in AGENTS and the course conventions: one continuous recording section, no section-heading or section-summary slides. The title is followed by a **From the lecture / To prove here** orientation with key starting conditions. This changes the presentation, not the required/examinable proof depth or the live residual/loss boundary.

The revised [brief](../../recordings/quadratic_separation/recording_brief.md), [Section Design](../../recordings/quadratic_separation/section_design.md), [Organization](../../recordings/quadratic_separation/slide_organization.md) and [Design](../../recordings/quadratic_separation/slide_design.typ) specify the same continuous argument. The opening displays the joint density and identifies its quadratic and coefficient before transforming either. It explains why cancelling cross covariance helps obtain two quadratic terms and why the observed-block inverse is needed. Residual coordinates acquire meaning before the block products; operation labels and local reasons accompany the algebra. The full positive-definiteness, inverse, quadratic, determinant/dimension, integration and division arguments remain.

The layout uses plain proof regions, purposeful comparisons and generously spaced display-equation rows. [The spacing investigation](formula_spacing.md) explains why inline formula rows, paragraph leading and weak edge padding gave inconsistent results. The shared equation-row helper reserves full display heights and rejects prose rows. The course conventions make the new spacing practice persistent; the live proofs and notebook are not globally reformatted.

Use the current [handout](../../recordings/quadratic_separation/slide_deck.pdf) and [presentation](../../recordings/quadratic_separation/production_validation/slide_deck_presentation.pdf). The [current production report](../../recordings/quadratic_separation/production_validation/authoring_report.md) owns exact versions, counts, warnings and all-state visual checks. The current deck has 18 handout pages and 42 reveal states, with no compiler/font/overflow warnings. The [separate sequence/reveal review](recording_sequence_review/report.md) passes all handouts and states, including exact final-state content parity and no lost formulas. That reviewer authored Section/Organization, knew the instructor's concerns, and authored neither Design nor production. This is a targeted separate review, not a blind independent discovery.

The unchanged [connected derivation](../../recordings/quadratic_separation/math_derivation.md) retains exact source records. The original [independent mathematics review](recording_math/report.md) remains evidence for that proof and the Murphy passages. The earlier [rendered review](recording_rendered/report.md) and Design handoff retain their exact old snapshots; their 20/47-page/state verdict is not transferred to the rewritten deck. The current production report and review bind the revised realization.

The 20–30-minute range is still an unmeasured planning estimate. Final instructor acceptance, rehearsal and video capture remain open. No speaker notes, video, viewing monitoring or publication is claimed.

## Notebook: accepted content, local success, release still pending

The canonical [solved](../../../../InClass/Solutions/lecture1_missing_data.ipynb) and [student](../../../../InClass/lecture1_missing_data.ipynb) notebooks are byte-for-byte unchanged from the approved input to this work. Your saved partial execution remains intact. The [independent current check](release/report.md) records `uv sync --locked`, a clean top-to-bottom run of all 23 code cells, zero errors, three plots, valid schemas and a fresh mechanically generated student source matching all 146 cell types/IDs and sources. Scientific dependencies and package pins did not change.

[Prepared local distribution copies](release/integration.md) include a clean student template, a completely executed solution and the already checked helper wheel under ignored `build/l01-release/`. These checking copies do not replace your working files or establish hosted success.

Anonymous public checks found the helper commit unavailable, current student notebook URLs unavailable, and an older solved notebook on public `main`. The existing helper pin and wheel match current source; no speculative package correction is needed. The exact [release/Colab handoff](release/report.md#remaining-release-steps-and-runnable-handoff) explains what to publish after remote-export authorization, how to verify anonymous access and how to run a fresh hosted Colab 2026.07 CPU session through the official VS Code extension. A public feature branch and a merge into `main` are distinct. No hosted run or remote write was performed here.

## Instructor return

The next ready teaching item is **L01-RECORDING-CONTRACT**, owned by the [recording brief](../../recordings/quadratic_separation/recording_brief.md#l01-recording-contract--ready-for-instructor-review). Review the revised concrete explanation in chat; its purpose/examinable status, one-section format and live proof boundary are already settled. Complete Scope acceptance and the timing rehearsal remain separate. The current [handoff](../../NEXT_SESSION.md) and [lecture state](../../development_state.md) replace stale next-action prose while retaining links to identifiable raw evidence.

No class has been taught; the actual curriculum map is unchanged. No notebook pedagogical review, proof relocation, architecture change, remote publication or merge is inferred from these technical results.
