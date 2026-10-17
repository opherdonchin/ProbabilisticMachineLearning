# L01-R01 recording: restart from its teaching purpose

**Status:** active handoff for instructor-led replanning, 2026-10-18. The instructor asked to stop slide revision and review this recording again at Section Design and Slide-Level Organization, with a clearer concept of its purpose. This file records the evidence and open decisions; it is not an approved replacement scope, section design, or slide organization. No candidate design or production edit should follow from it automatically.

**Repository location:** branch `lecture/l01-delivery-readiness`. The isolated rule-guided candidate is in [candidate/](candidate/); the canonical live lecture and recording remain in their existing locations. This handoff is being published separately from the latest local candidate edits, so an online checkout may show an earlier candidate snapshot. The local revised `slide_deck.typ` is a 17-slide/32-state source implementation, compiled in memory, but **not instructor accepted**. The stored candidate PDFs and browser preview show a preceding composition. The instructor requested no PDF regeneration while reviewing the source. The evidence and conclusions needed for the planning restart are recorded here without depending on that local source version.

## What the live lecture actually establishes

The [live L01 deck](../../slide_deck.typ) gives the Gaussian marginal
\(p(x_2)=\mathcal N(x_2\mid\mu_2,\Sigma_{22})\) on handout p.47. On pp.48–49 it defines
\[
B=\Sigma_{12}\Sigma_{22}^{-1},\qquad
r=x_1-\mu_1-B(x_2-\mu_2),\qquad
S=\Sigma_{11}-\Sigma_{12}\Sigma_{22}^{-1}\Sigma_{21},
\]
shows \(\operatorname{Cov}(r,x_2)=0\), uses joint Gaussianity to obtain residual independence, and **proves**
\[
p(x_1\mid x_2)=
\mathcal N\bigl(x_1\mid\mu_1+B(x_2-\mu_2),S\bigr).
\]
Page 52 names \(S\) as the residual covariance **and explicitly displays**
\(\operatorname{Cov}((r,x_2))=\operatorname{diag}(S,\Sigma_{22})\).
Our earlier review incorrectly said that this matrix was absent from the live slide. Centering \(x_2\) as \(u=x_2-\mu_2\) does not change that covariance.

Consequently the conditional and marginal results plus
\(p(x_1,x_2)=p(x_1\mid x_2)p(x_2)\) already give the **full normalized Gaussian factorization as an identity**. The live p.53 writes the density chain rule and *states*, without a derivation, the joint quadratic separation
\[
(x-\mu)^T\Sigma^{-1}(x-\mu)
=r^TS^{-1}r+(x_2-\mu_2)^T\Sigma_{22}^{-1}(x_2-\mu_2).
\]
It does not derive the matching determinant identity
\(\det\Sigma=\det S\det\Sigma_{22}\) from the block transformation. These are the genuine gaps in the **direct joint-density calculation**, not gaps in the validity or normalization of the conditional law.

## What the present candidate does, and where its framing fails

The [candidate source](candidate/slide_deck.typ) currently spends slide 2 recalling the conditional theorem and announcing a derivation of the “full joint-density factorization.” Slide 3 writes \(p=C\exp(-Q/2)\). Slides 4–6 introduce \(T=\begin{pmatrix}I&-B\\0&I\end{pmatrix}\) and verify by row/column multiplication the block-diagonal covariance **already displayed live**. Slides 7–10 establish positivity, the inverse transformation, and the inverse quadratic setup. Slide 11 derives the quadratic identity stated on live p.53. Slides 12–13 derive the determinant and Gaussian coefficient split; slide 14 substitutes both into the joint-density formula. Slides 15–16 integrate/divide to recover the marginal and conditional already established live; slide 17 revisits the zero-cross-covariance independence case.

The valid new contribution is a **second derivation, directly from the original normalized joint-density formula**: the same residual-coordinate transformation explains both the exponent and the normalizing coefficient. It is not a new proof that the conditional law exists or is Gaussian in any sense that students lacked after the live lecture. Slide 2 does not say that the live conditional and marginal already imply the normalized product. Slides 5–6 do not identify the displayed covariance as previously shown live. Slides 15–17 can therefore make a known conclusion feel like a newly discovered result. This is an intellectual-organization problem, not something a local layout rule can repair.

The candidate improved several real design defects: slide 2 groups the recalled If/Then theorem; slide 3 shows full density before \(Q,C\); slide 4 motivates \(T\) as the live residual subtraction; formulas, operations, and local reasons are grouped. The instructor explicitly removed a separate displayed proof of \(\Sigma_{22}\succ0\), preferring a concise key point. These gains are reusable if the recording survives replanning. They do **not** constitute approval of the 17-slide route. The [rule ledger](candidate/rule_application_ledger.md) preserves exact feedback and design diagnoses. An earlier source-provenance error about live p.52 was corrected in the current candidate records.

### Design lessons worth carrying into a new organization

- Establish the student's actual entry state and the new mathematical purpose **before** slide layout. The rule-guided pass initially treated known \(B,S\) and the conditional law as discoveries. Local algebra cues could not repair that mistaken teaching specification.
- Put a genuine carried-over result in a labeled recall object with accurate provenance. Keep an If premise beside its condition and a Then claim beside its fixed observation; visually group the Gaussian law with its mean and covariance rather than giving three unstructured equations equal weight.
- Use left-aligned body prose and mathematics. Group related formulas, keep cross-group space larger than within-group space, and avoid both bare formula stacks and large gaps between a cue and its object. Break long prose at a meaningful mathematical clause.
- Make each derivation step show the expression being changed, the operation, and its local warrant. At phase changes, carry the actual density, quadratic \(Q\), or coefficient \(C\), so students see why the next calculation matters. A future-looking key point is a poor substitute for a present connection.
- Keep key points as concise present-tense interpretations, not duplicate formula narration. In a recorded proof, reveals should add reasoning units. Preserve generous formula clearance. The recording remains one continuous section without a divider or summary slide.

These are useful design constraints, not reasons by themselves to keep a recording whose intellectual purpose is unsettled. The instructor's correction of the \(\Sigma_{22}\) proof depth is explicit; other proof-depth changes need their own decision.

## Decision that precedes further slide work

The [canonical recording brief](../../recordings/quadratic_separation/recording_brief.md) and [Section Design](../../recordings/quadratic_separation/section_design.md) record an accepted separate recording allocation and full block-elimination/density proof, with its presentation still provisional. The instructor's current request reopens **how this recording is justified and organized**. Do not silently discard the accepted mathematical content or treat its previous allocation as a sufficient pedagogical rationale. If the best revised concept changes the endpoint, proof depth, examinable material, or whether a recording is warranted, return that as explicit Lecture Scope pressure for an instructor decision.

The next coordinator should first compare credible purposes, such as:

1. **Direct density proof as a reusable method.** Teach why residual coordinates diagonalize the covariance and how that yields the inverse quadratic *and* exact determinant coefficient. State plainly that the conditional law and factorization were already available by the live proof and chain rule. Evaluate whether each preparatory proof and the final re-identification are needed to learn this technique.
2. **Focused completion of live p.53.** Center the recording on the asserted quadratic identity and its normalization companion, using the displayed live covariance as an input. This may require changing the previously assigned depth of block elimination, integration, and division; flag those as scope decisions rather than making silent cuts.
3. **No separate recording, or a different task-relevant purpose.** If the density calculation adds too little practical or mathematical competence for its likely duration, explain the cost of removing/moving its required and examinable content. Do not assume this option is approved.

For each option, state what students already know, the new mathematical operation they would learn, what they would practise or be expected to reproduce, and why that matters for a supplied-joint-Gaussian missing-data query. Distinguish mathematical correctness from pedagogical payoff. The current 17 slides and the earlier 20–30-minute estimate are **not measured teaching duration**.

## Restart workflow and boundaries

Use [lecture-development](../../../../.agents/skills/lecture-development/SKILL.md) as the instructor-facing coordinator, with [Section Design](../../../../.agents/skills/section-design/SKILL.md) in `revision` mode first. Read the live pp.47–53, [recording brief](../../recordings/quadratic_separation/recording_brief.md), [existing Section Design](../../recordings/quadratic_separation/section_design.md), [existing Slide Organization](../../recordings/quadratic_separation/slide_organization.md), [mathematical derivation](../../recordings/quadratic_separation/math_derivation.md), this candidate's [organization](candidate/slide_organization.md) and [argument map](candidate/argument_map.md). Use the [source record](source_provenance.md) and [isolation manifest](isolation_manifest.json) for provenance and protected paths. The current candidate is evidence to critique, not a template to preserve.

Give the instructor **one consequential decision at a time**, with a concrete mathematical and teaching tradeoff. Once the recording's purpose/section contract is agreed, dispatch Slide-Level Organization in `revision` mode for a genuinely new sequence. Only then consider Slide Design and Authoring. Keep the live deck, canonical recording, shared skills and conventions unchanged during this isolated review. Do not merge, publish, or capture a recording without the relevant explicit authorizations. Do not regenerate PDFs during source review unless the instructor changes that instruction.

## Prompt for a repository-enabled follow-up conversation

> Open `Lectures/L01_Probability_Statistics/reconciliation/rule_guided_gaussian_conditioning/recording_replan_brief.md` on `lecture/l01-delivery-readiness`. Act as the Lecture Development Coordinator, using the repository's lecture-development skill. Stop the current slide-design/authoring revision. Reconcile the live L01 proof on handout pp.47–53 with the canonical recording brief and Section Design; use this handoff's candidate map as evidence, since the latest 17-slide source revision may be local rather than on the online branch. The live lecture already proves the conditional law, gives the marginal, and displays the block-diagonal residual covariance; its p.53 only states the quadratic split. The normalized factorization already follows by the density chain rule. Review the recording's *purpose and section contract* in Section Design `revision` mode before revising Slide-Level Organization. Compare credible purposes for a direct joint-density/block-elimination recording, including its mathematical payoff, what students would practise, and its overlap with the live proof. Treat changes to the previously accepted required/examinable content as explicit scope pressure. Present one consequential instructor decision at a time, with provenance separating instructor decisions from specialist proposals. Do not edit the live or canonical recording decks, advance to Slide Design/Authoring, regenerate PDFs, merge, or publish during this planning review.
