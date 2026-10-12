# Recommended amendments to the Lecture Scope authoring skill

**Status: proposal for instructor approval; canonical skill NOT edited.** Prepared 2026-10-12 after direct comparison of Murphy Book 2 Chs. 5–12, 15–16 and 21 against the committed L04–L12 scopes, and examination of the original L03 route replacement. The current [.agents/skills/lecture-scope/SKILL.md](../../.agents/skills/lecture-scope/SKILL.md) already contains substantial corrective material added after L03. **Do not reintroduce or duplicate those rules.** The proposed changes below are a *small set of stronger, inspectable gates*, not a wholesale skill rewrite.

## What the current skill already gets right

1. **Authority recovery:** It explicitly requires inspecting existing scopes/development registers and other branches, and preserving instructor-agreed work. The original batch failed before this repair; the latest L03 restoration is evidence of recovery. Retain these rules unchanged.
2. **Source and previous-course reasoning:** “Establish the intellectual starting point” now says to reconstruct the argument of both the source and preceding lecture, not merely their topic inventory. The “Generate genuinely different forward paths” section now requires a serious source-faithful option **with the same notebook**, avoiding the false choice between theory and application. Keep this.
3. **Arc distinct from notebook and section design:** §6a already says the arc is not the notebook workflow, and examples need explicit functions. It warns against collapsing the argument into timed milestones. Preserve it.
4. **Review and approval boundaries:** Section Design feasibility review and instructor authority are already defined. We should **supplement** feasibility with source-arc justification, not replace or pretend that feasible implies faithful.

What the present skill does **not yet force to become inspectable**: a stable source-first comparison artifact; identification of *lost conceptual transitions*, not only omitted sections; a reviewer who reconstructs the source arc without inheriting the builder's chosen route; and a source-arc verdict independent of timing/constructibility. These missing enforcement points explain why a mathematically feasible, useful-but-narrow L03 could initially pass review.

## Change 1 — Create a short source-arc map *before* generating alternatives

**Insert after** “### Establish the intellectual starting point, not only prerequisites” and before “## 2. Solicit instructor goals”.

Suggested canonical language:

> **Source-arc map (required when a lecture follows or materially reorganizes a textbook chapter):** Before selecting a worked application or lab endpoint, write a concise account of the relevant textbook's argument. Name (a) its motivating question, (b) the minimum dependency chain of mathematical ideas, (c) what conceptual transition each load-bearing section supplies, and (d) the intellectual capability the reader gains at the end. Distinguish this backbone from illustrative examples, optional excursions and chapter-wide topic catalogues. Reconstruct only the selected source territory, including neighboring passages when needed to understand why it is organized that way; no expectation of comprehensive book coverage.
>
> When the lecture combines multiple chapters or splits one chapter across lectures, construct the *combined* source-arc map and identify which other lecture owns any postponed conceptual transition. Reading a table of contents, collecting section numbers and listing prerequisites do not satisfy this requirement.
>
> **Anti-anchoring check:** First write the source-arc map without adopting the desired notebook's sequence or the current proposed lecture as an organizing template. Then return to the instructor's established aims and applications. A notebook may motivate the arc, but the choice of an easily checkable or short notebook cannot by itself establish the lecture's intellectual question.

**Why:** prevents application-led reconstruction of a mathematical chapter as happened in original L03; prevents independent optimization of a lesson title that loses the source's central development.

## Change 2 — Require an explicit *arc correspondence and deviation decision*

**Insert after** the second paragraph in “## 4. Evaluate the alternatives”.

Suggested canonical language:

> **Source-arc correspondence for each serious candidate:** Identify the source's *essential conceptual transitions* and indicate whether each is (i) developed here, (ii) recognized/bridged here at lesser depth, (iii) developed in another named lecture, or (iv) deliberately omitted. Record important **relationships between topics**, not just coverage destinations. Where the proposed order or endpoint differs from the source, say **what new argument replaces it**, what educational benefit that argument offers these students, and what source insight may become harder to appreciate.
>
> Compare at least one credible route preserving the source's organizing argument and one route optimized for course-specific aims **when they differ materially**, keeping the same notebook option if possible. It is legitimate to select the second; it is not legitimate to leave the difference unexamined. Do **not** apply a book-order quota, penalize all deviations, or require that every subsection be represented.

**Why:** a proposed lecture could meet all current coverage/timing checks yet remove the reason Murphy developed the subject. Explicit transition disposition makes this a visible teaching decision.

## Change 3 — Put the comparative argument in the final Scope, not merely the agent's scratchpad

**Insert at the beginning of** “## 6a. Intellectual arc”, after “Build this first.”

Suggested canonical language:

> **Mandatory compact opening:** State the lecture's driving mathematical question and destination, and in a brief paragraph describe the corresponding source-text argument. Then explain what the chosen lecture arc preserves, reorders, delegates or drops *and why*. For an intentional synthesis of several chapters, state the new combined argument. Keep this as explanatory prose, not a list of chapter headings or a slide outline. The detailed milestone/time table follows this argument; it must not substitute for it.
>
> **Counterfactual notebook test:** Ask whether this intellectual arc would remain a worthwhile mathematical development if the selected notebook/application were exchanged for another application of the same ideas. If not, explicitly justify the application-led endpoint rather than assuming its practical attractiveness establishes the intellectual destination.

**Why:** the L03 batch scope's passage from MRF factors directly to image restoration was viable as a task, but the graph-representation argument vanished. The counterfactual is a diagnostic, not a ban on purposeful application-led lectures.

## Change 4 — Add a distinct *source-arc* preview, separate from implementation feasibility

**Insert immediately before** “## Section Design feasibility review before approval”.

Suggested canonical language:

> **Source-arc fidelity preview:** Before treating a new or substantially revised scope as approved, commission a reviewer who independently reconstructs the relevant textbook's intellectual argument **before reading the builder's selected arc**, as far as agent isolation permits. That reviewer then evaluates: (1) recognizable source backbone, (2) explicit and justified deviations, (3) whether essential transitions have simply been dropped or are owned in a named other lecture, and (4) the value of the *new* arc for this course. Classify the result as:
>
> - **Faithful selection:** smaller coverage, but the intellectual argument survives;
> - **Justified reorganization:** a different coherent argument is preferable given course aims;
> - **Unjustified displacement:** the notebook or one narrow algorithm displaced the central source argument without a compelling reason;
> - **Fragmentation:** retained subjects do not develop a coherent argument.
>
> A faithful selection or justified reorganization may pass; the other two require an explicit scope repair or instructor decision before approval. Do not treat this as a demand to mimic Murphy's order or recover omitted applications. Give the **smallest arc-level repair**, not a mandate to broaden every topic. The existing Section Design feasibility review then tests constructibility/time—not source fidelity alone.
>
> When independent agents cannot launch, report a same-context review honestly and withhold the **independent-review** claim. In a multi-lecture project, also perform one course-wide source-arc review to check whether deferred transitions have a real owner, rather than appearing on ten unrelated “later” lists.

**Why:** the original process judged teachability and mathematical correctness more effectively than the *choice of argument*. A separate, explicit source-first gate would detect that.

**Cost:** one brief source reconstruction + one focused review per new or substantially changed scope. For a small technical revision to an accepted scope, use a targeted review only; do not recertify every unaffected lecture.

## Change 5 — Harden the cross-lecture gate around *conceptual transitions*

**Extend** “# Cross-lecture coherence” by this paragraph:

> **Argument continuity across lectures:** In addition to allocating topic ownership, verify the shared *questions and mathematical transitions*. For every postponed essential source development, identify the receiving lecture and the job it performs there; the recipient must have available time and prerequisites. Distinguish “used later” from “explained later” and “only named later”. Some chapters provide a curriculum-wide arc (e.g., EM bound → VI objective → VAE amortization), so a lecture may legitimately stop mid-source if a later lecture completes that argument. Flag orphan transitions even if every individual lecture is feasible and every ledger row has a destination.

**Why:** avoids *paper coverage* where all missing ideas are merely named elsewhere, and protects intentional multi-chapter redistribution like §6.5/Ch. 10/Ch. 21.

## Completion gate and minimal review-contract coordination

Append to “# Completion criteria”:

> - the source-arc correspondence and material deviations are visible in the assembled scope;
> - a source-first source-arc review has classified the chosen route and resolved unjustified displacement/fragmentation issues;
> - when a chapter argument is spread across lectures, the shared conceptual transitions have explicit teaching owners and are revalidated as a course argument, not only a coverage map.

**Optional small downstream edit (separate approval):** add one line to .agents/skills/section-design/SKILL.md feasibility-review mode: “Check whether the proposed *sections could realize the instructor-approved intellectual argument*, not merely the already chosen example and time allocation; when a source-arc issue is found, route it to Lecture Scope rather than silently restructuring it.” Avoid duplicating a new full source-review workflow inside Section Design.

## Do not change

- Do **not** require the exact sequence of Murphy sections or full coverage.
- Do **not** make the source-arc reconstruction a slide-by-slide outline, or overload the resulting scope with whole-chapter commentary.
- Do **not** turn the author's private argument reconstruction into an instructor quiz.
- Do **not** let a reviewer overrule already-agreed instructor routes merely because they differ from Murphy: raise the tension, retain provenance, and ask for a genuinely new decision only if required.
- Do **not** treat difficulty, theoretical breadth or practice hours as mutually exclusive by default.
- Do **not** edit the canonical SKILL.md before the instructor reviews this recommendation. The separate VS Code prompt below is prepared for *later authorized* adoption.

## Assessment of how this would have affected original L03

These five changes would have made it harder for an original L03 reviewer to pass an application-centered Ising image sequence merely because the local-posterior derivation and NumPy task were coherent. The source-first Chapter 4 reconstruction would emphasize **DAG and undirected representations of joint distributions and their independence semantics**, and a correspondence table would show that these major transitions had no developed home. A counterfactual using the *same image-restoration notebook* but a mathematical graphical-model lecture would have exposed a stronger candidate. Independent arc review would then reject **unjustified displacement** without condemning the imaging example itself.

There is an independent **authority failure** as well: the batch missed the pre-existing instructor-agreed L03 on another branch. The skill's **current** “Recover existing agreements before building” section already directly addresses that, so no duplicate authority-recovery amendment is recommended.

**Recommendation:** approve Changes 1–5 as a coherent package; optional one-line Section Design update separately. Then use the existing nine source-arc reviews and the VS Code prompt to revise only affected scopes, with new truly independent specialist review and explicit old/new mathematical arc comparisons.
