# Slide judgment: organization contract

Status: isolated exploratory revision, 2026-10-15. This is a learning artifact,
not an approved organization or a replacement for production. Task envelope:
`brief.md` at base `1b6434b`. The instructor's preference for B3 supersedes the
frozen density experiment's A2 recommendation; its mathematics remains evidence.

## Preserved teaching sequence

The immediate predecessor establishes a conditional Gaussian posterior and its
mean as a summary. This insertion justifies choosing that mean under squared
Euclidean loss. It does not derive Gaussian conditioning again.

1. **Choose a reconstruction by its conditional squared-error risk.** Given an
   observation y, choose a in R^d to reconstruct random z in R^d. Define
   L(a,z)=||z−a||² and R(a|y)=E[L(a,z)|y]. Set m=E[z|y], r=z−m; derive
   z−a=r+(m−a) and its three-term squared expansion. The teaching endpoint is
   the distinction between random residual r and fixed displacement m−a,
   conditional on y. Design relationship: criterion and centering support the
   expansion; they are not unrelated peer facts.
2. **Centering separates residual uncertainty from estimation error.** Apply
   E[·|y] to that expansion. Show E[r|y]=0, the cross-term's cancellation by
   fixedness, and E[||r||²|y]=sum_j E[r_j²|y]=tr V, where V=Cov[z|y]. Derive the
   intact R(a|y)=tr V+||m−a||². The slide's job is the averaging argument;
   the optimizer is reserved for the following teaching move.
3. **The posterior mean minimizes squared-error risk.** Use the established
   decomposition and ||m−a||²≥0, with equality iff a=m, to establish the unique
   action a*(y)=m=E[z|y] and min_a R(a|y)=tr V. Apply to the Gaussian posterior:
   a*=mu_(z|y), minimum risk tr Sigma_(z|y). Design relationship: Gaussian use is
   a specialization of the general result, not a second proof or an assumption
   needed to prove mean optimality.

All three remain live derivation/application moves at the accepted depth. Finite
conditional second moments suffice where the conditional moments exist;
Gaussianity is unnecessary for the risk proof. The minimized quantity is model
conditional risk, not an empirical reconstruction guarantee. The existing section
retrospective remains in place. These internal slides do not acquire a new
handoff or section-ending role. No measured timing or count revision is proposed.

## Two agreed provisional realizations

**A, named mathematical roles.** Setup names the criterion and centered error as
supporting objects feeding the full expansion. Decision distinguishes established
risk, optimizing action/minimum, and Gaussian specialization. Spatial grouping
should expose these dependencies; neither columns nor border style is itself the
hypothesis. Cost: multiple named groups may suggest peer status unless the
inference is explicit. Evidence against A: a viewer can locate formulas but cannot
read why one group licenses the next without searching among groups.

**B, continuous transformation.** Setup follows criterion → centering → expansion
as a visible operation path. Decision reads the intact decomposition through its
two term roles (independent of a; zero exactly at a=m), derives action and minimum
together, and aligns Gaussian specialization to those consequences. Cost: a long
spine may recreate undifferentiated stacking or overload the central axis.
Evidence against B: students must infer which transformation is licensed, or
Gaussian use appears to be another step required for the general optimum.

Both preserve the same complete mathematics, titles/order and three-slide
argument. Design owns visible wording, semantic grouping and reveals; Authoring
owns exact geometry and readable implementation. Organization accepts both as
faithful hypotheses. All reveal/handout states were inspected; the final B
underbrace attaches nonnegativity and equality iff a=m to the actual squared
norm. Design explicitly accepted that wording as equivalent to a separate
inequality line. Actual evidence supports coherent realization of both hypotheses;
instructor judgment remains open.

## Distinct transfer: apply Gaussian conditioning to joint blocks

Use actual deck slide/PDF page59, “Bayes’ rule for Gaussians,” with actual58 as its
predecessor. Its job is substitution/application, not optimization: retain the
joint Gaussian and its model-specific blocks, general conditioning mean and
covariance formulas, explicit x1=z, x2=y mapping, posterior Gaussian p(z|y), and
both resulting posterior parameters. No new derivation, source attribution or
mathematical assumptions are introduced. Invertibility conditions stay as in the
accepted material; no singular-case generalization is implied.

A may expose named inputs/rule/output. B may expose substitution as the operation
connecting them. The proposed transferable judgment is to expose the actual
mathematical relation; fixed/variable labels from risk minimization do not
transfer to conditioning. Merely copying the decision slide's geometry would
fail this test. Transfer acceptance concerns teachability within the existing
move, not superiority to the instructor's original slide.

## Open decisions

Instructor acceptance of either realization, relative mathematical-object/operation
emphasis, and useful prominence of the Gaussian specialization remain open.
Source records, observed renders and peer exchange are in `organization_report.md`.
No Scope/Section Design change request is needed for this bounded experiment.
