# Established L01 reasoning precedents — raw independent evidence

Assignment: Slide Design, revision analysis; read-only recovery of established arguments, no candidate drafting. Repository branch `test/l01-reasoning-alignment-20261014`, HEAD `15042b872d9d883be31b2f7f1e3bea5067807668`. Inspected AGENTS.md, slide-design skill, shared backpressure, course slide-design conventions, established slide_deck.typ, and the supplied presentation PDF. No repository file changed. No experimental candidate/review file inspected. Logical slides 64–65 (the inserted point-estimate/risk slides; presentation pp. 150–154) are excluded from analysis. Initial broad source read happened to include their source, but they contributed no conclusions or selection criteria.

PDF: `build/slide-review/L01_Probability_Statistics/slide_deck/presentation.pdf` (162 pages; Typst 0.15.0; generated 2026-10-14). References below distinguish logical footer slide numbers from physical PDF page numbers. Full-page renders are `/tmp/l01-precedent-renders/p<N>.png`; they are uncropped. Text inventory `/tmp/l01-presentation.txt` establishes PDF pagination. Selected independent strongest cases: conditional-mean proof, Gaussian-Bayes application, scalar specialization; supplemental checks: affine covariance proof, marginal projection proof, covariance proof, conjugacy, empirical-risk construction, scalar uncertainty comparison.

## 1. Conditional-mean proof: a proposed correction is justified by an independent residual

Logical slide 48/69; PDF pp. 109–112, all four whole pages viewed. Source `Lectures/L01_Probability_Statistics/slide_deck.typ:1982–2037` (definitions 2006–2007; cancellation/independence 2008–2016; final conditional expectations 2017–2021).

Visible sequence:

- p109: left object states `p(x1|x2)=N(x1|mu1|2,Sigma1|2)` and `mu1|2=mu1+Sigma12 Sigma22^-1(x2-mu2)`. The bottom key point interprets observed deviation, cross-covariance, and observed variance. Right proof space is blank.
- p110: right pane headed “Mean proof” introduces `B=Sigma12 Sigma22^-1` and `r=x1-mu1|2=x1-mu1-B(x2-mu2)`. Left target persists.
- p111: beneath those definitions appear `E[r]=0` and `Cov[r,x2]=Sigma12-B Sigma22=0`, then the explicit warrant “(r,x2) is jointly Gaussian: zero cross-covariance gives independence.” Earlier definitions remain visible.
- p112: adds `E[r|x2]=E[r]=0` and `E[x1|x2]=mu1|2`, completing the target claim.

This is an actual inference chain, not merely a list of equivalent-looking equations: choose B to cancel cross-covariance; joint Gaussianity upgrades zero covariance to independence; independence makes the conditional residual mean zero; the proposed affine correction is therefore the conditional expectation. “Jointly Gaussian” and “zero cross-covariance gives independence” are indispensable in-object proof text. Moving that warrant away from the zero covariance line would weaken the visible logic. `B` compresses repeated algebra; `r` supplies one mathematical object that survives all later steps and then the next slide. The key point gives the operation's interpretation; it does not perform the independence argument.

Spatial hierarchy: target on left, proof built downward on right, interpretation below both, small source note between body and key point. Orange vertical mark groups the proof; it does not box every formula. No arrow is needed between every line because vertically cumulative construction and the explicit warrant carry the dependency. The source explicitly sets four repeats and binds reveal behavior to the slide self (1984–1987); actual renders show every step.

Preserve: target/proof distinction, residual construction, prerequisite warrant immediately adjacent to cancellation, retained earlier definitions, conclusion returning to the original target, stable notation across states. Incidental: exact two-column ratio, orange rule position, centering, four clicks rather than another semantically equivalent staging.

Imperfections: the target and interpretation are given before proof, so this is “state then justify,” not discovery; first state contains much empty right-hand space. The residual line is long. `Sigma22` invertibility is implicit rather than locally stated. The Gaussian conditional distribution is asserted; the visible argument specifically establishes its mean, relying on earlier affine Gaussian closure for Gaussianity.

## 2. Gaussian Bayes: retain both premises while explicitly mapping indices to a model

Logical slide 59/69; PDF pp. 135–137, all three whole pages viewed. Source 2444–2497; established premises 2452–2469; mapping/output 2475–2482; interpretation 2492–2494.

Visible sequence:

- p135: top-left “Model and joint Gaussian” carries `(z,y)~N((mu_z,mu_y),[[Sigma_zz,Sigma_zy],[Sigma_yz,Sigma_yy]])`, with `mu_y=W mu_z+b`, `Sigma_zz=Sigma_z`, `Sigma_zy=Sigma_z W^T=Sigma_yz^T`, `Sigma_yy=W Sigma_z W^T+Omega`. Beneath it, “Gaussian conditioning rule” carries both generic block formulas. Right pane says “Apply: x1=z, x2=y” and states `p(z|y)=N(z|mu_z|y,Sigma_z|y)`.
- p136: right adds `mu_z|y=mu_z+Sigma_zy Sigma_yy^-1(y-mu_y)`; bottom adds “The mean responds to observed minus predicted measurement.”
- p137: right adds `Sigma_z|y=Sigma_zz-Sigma_zy Sigma_yy^-1 Sigma_yz`; bottom adds the covariance interpretation.

The visible intellectual operation is substitution of a concrete model's blocks into an already-proved rule. Two premises remain simultaneously available. The short “Apply” heading contains the exact identification that licenses the new formula; it is not a generic decorative label. Generic notation 1/2 and model notation z/y coexist deliberately so students can inspect the correspondence without reconstructing previous slides mentally. The left side is prior knowledge even though it uses ordinary proof cards rather than an explicit recall-card. Semantic prior/new hierarchy therefore cannot be inferred from a component name alone.

Preserve: both source premises, explicit variable mapping, same block order, staged mean then covariance, each interpreted as it appears, final state retaining comparison. Incidental: premises stacked left and result right; another layout could preserve the same dependency and simultaneity.

Imperfections: left source equations are smaller than right results; the first key point is an instruction to apply a rule rather than a declarative result. A new design should not mechanically copy that sentence style. Joint-model independence assumptions are inherited, not restated on this slide. Algebra is application-level, not a new proof of conditioning.

## 3. Scalar Gaussian update: compute ingredients, then assemble the operation

Logical slide 61/69; PDF pp. 141–143, all three whole pages viewed. Source 2542–2610; carried update 2551–2558; scalar assumptions 2561–2569; calculated ingredients 2580–2589; assembly 2593–2608.

Visible sequence:

- p141: smaller rounded “Carried forward” card top-left contains `mu_z|y=mu_z+K(y-mu_y)` and `K=Sigma_zy Sigma_yy^-1`. Main top-right “Scalar specialization” shows `y,z in R`, `W=1,b=0`, variance notation, `z~N(mu_z,sigma_z^2)`, `y=z+epsilon`, `epsilon~N(0,sigma_epsilon^2)`, and independence of epsilon and z.
- p142: three aligned middle objects compute `mu_y=E[z+epsilon]=mu_z`, `Sigma_zy=Cov[z,z+epsilon]=sigma_z^2`, and `Sigma_yy=Var[z+epsilon]=sigma_z^2+sigma_epsilon^2`. Their short headings identify the quantity being computed, not a general lesson.
- p143: full-width lower equation assembles `K=sigma_z^2/(sigma_z^2+sigma_epsilon^2) -> mu_z|y=mu_z+K(y-mu_z)`. Only then appears “The scalar gain is prior state variance divided by total measurement variance.”

The flow is inputs/assumptions -> sufficient computed ingredients -> substitution into an established operation -> interpretation. The triad is justified because three peer quantities are needed to assemble one result; it is not three independent takeaways. The upper recall can be lighter because its formula was already taught. The independence clause remains in the inspected model because it justifies both dropping the covariance term and adding variances. The arrow has a specific assembly role. Bottom interpretation names numerator and denominator after their provenance has been made visible.

Preserve: inherited update separated from new scalar assumptions; all ingredient computations together; result assembled from those ingredients; interpretation after assembly; independence local to model. Incidental: exactly three columns, rounded recall border, width percentages, exact vertical spacing.

Imperfections: ingredient equations are relatively small; the final gain fraction is smaller still. The algebra inside each expectation/covariance is compressed. Source note and new result occupy nearby lower regions, but hierarchy remains clear in the complete render.

## 4. Affine covariance and marginal projection: good source argument, incomplete supplied reveal artifact

Affine logical 41/69, PDF 94–97; source 1768–1805. All pages viewed. Persistent left equations are `y=Ax+b`, `E[y]=A mu+b`, `Cov[y]=A Sigma A^T`. p95 introduces right “Covariance proof”: “Center: d=x-mu,” `y=A(d+mu)+b=Ad+(A mu+b)`, `y-E[y]=Ad`. This exposes why b disappears: centering eliminates the deterministic shift, so covariance depends on transformed variation. The first key point appears with that step. Source then intends `Cov[y]=E[(Ad)(Ad)^T]=A E[dd^T]A^T=A Sigma A^T`. However p96 and p97 do not visibly show this covariance expansion. p97 shows the second interpretation while the proof stays at the centered residual. This is a genuine gap in the supplied artifact, not evidence that equations alone suffice. The proof grouping moves slightly as later key-point space appears; exact coordinates are not stable pedagogical commitments.

Marginal logical 47/69, PDF 105–108; source 1934–1980. All pages viewed. Left gives `p(x1)=integral p(x1,x2) dx2=N(x1|mu1,Sigma11)`; p106 right “Marginal proof” says “Select x1: P=[I,0], x1=Px,” then “By the affine rule: x1~N(P mu,P Sigma P^T).” These words identify the operation and its warrant. Source intends later `P mu=mu1`, projection multiplication, and `P Sigma P^T=Sigma11`; those lines are absent in supplied p107/p108. p108 does add symmetric marginal p(x2) and the cross-covariance key point. Thus the strongest generalizable relation is marginalization implemented as coordinate selection and reuse of affine closure, not literal replication of this incomplete reveal.

Conditional covariance logical 49/69, PDF 113–116; source 2038–2092. All pages viewed. Right pane explicitly recalls “From the mean proof: r and x2 are independent.” Source then intends: given x2 the conditional mean is constant; `Sigma1|2=Cov[x1|x2]=Cov[r]`; `Sigma11=B Sigma22 B^T+Cov[r]`; solve for residual covariance. Those decisive new lines do not appear in p115/p116. This still supplies strong continuity evidence: a residual proved on the previous slide is reused as the object needed for covariance. It does not supply a complete visible derivation precedent in this PDF.

I have not diagnosed or fixed these render discrepancies. They may be nested-reveal implementation behavior; the conditional-mean source explicitly handles nested reveals whereas these slides do not. This is an observation, not a conclusive code diagnosis.

## 5. Early and interpretive cross-checks: not every mathematical slide uses the same architecture

Conjugacy logical 7/69, PDF 15–17; source 246–305. All pages viewed. Upper-left recall contains model and Bayes proportionality. The main object labels “Prior,” “Likelihood,” and later “Posterior” alongside matching expressions; the bottom definition of conjugacy appears after posterior. The operation and family preservation can be read from the object. It does not show exponent multiplication/collection, so it is an application/recognition precedent, not a proof template. Its sentence “Applying Bayes' rule to our model” is more framing text than indispensable intrinsic mathematics; it is an existing imperfection relative to current conventions.

Empirical risk logical 18/69, PDF 44 and 47 viewed; source 759–799 inspected. Pointwise loss `L(x,y;theta)=ell(y,f(x;theta))` -> sample average `L(theta)=N^-1 sum L(x_n,y_n;theta)` -> minimizer `hat(theta)=argmin_theta L(theta)`. Each step has a matching bottom interpretation in source; complete render keeps all three equations. Here simple ordered equations carry the operation because the operators average and argmin are the new actions, and the key points name their roles. This is intellectually relevant to how an objective yields a chosen parameter, unlike a visually tidy slide about taxonomy. The final empirical-distribution note adds a distinct abstraction; it is not needed for the dominant visible chain.

Relative uncertainty logical 62/69, PDF 144 and 147 viewed; source 2614–2687. Formula persists at top. Final three cases align variance condition -> gain value -> posterior marker position -> “Trust the measurement / Split the difference / Trust the prior.” The marker makes gain's effect visible as movement between prior mean and observation; final simultaneity permits comparison. Spatial position is mathematically meaningful here, unlike arbitrary card geometry. The finite schematic tracks are approximate, not quantitative plots. This checks that interpretation can be embodied in a visible relation as well as prose.

## Generalizable relations, without a new slide plan

1. A mathematical argument needs visible licenses for its steps: centering, affine closure, a variable mapping, Gaussian independence, or scalar independence. Short in-object words often supply these. An equation list loses the argument if those relations are removed.
2. Established context stays available while the new operation is performed. It may appear as a muted recall card, a normal pane containing earlier rules, a target formula, or definitions retained within a cumulative proof. Recall styling is one mechanism, not the definition of the relationship.
3. The original target and the final consequence should be visibly connected. Conditional mean returns from a constructed residual to `E[x1|x2]`; scalar update assembles K then applies it; Gaussian Bayes maps generic indices to concrete variables. This closure gives direction to the mathematics.
4. Key points usually interpret what the displayed operation establishes. They do not replace the proof warrant, and merely appending generic takeaways to unrelated equations would not recover course reasoning.
5. Reveals group semantic steps rather than individual symbols. Definitions -> cancellation and its warrant -> conditional conclusion; scalar inputs -> three ingredients -> assembly. Retention makes each new inference auditable. The final comparison/result must remain coherent.
6. Semantic hierarchy is prior premise/new derivation/interpretation, not a mandate for a particular grid. Some layouts are two columns, some are a vertical equation chain, some combine top context with a middle triad and lower result. Borders and orange rules group; they do not create the inferential relation.

Limitations: no source-book pages reread, so literal Murphy source notes are recorded as deck provenance rather than independently verified attribution. No candidate evaluated; no redesign approved. Missing nested proof reveals prevent treating affine/marginal/covariance presentations as complete demonstrations. Three strongest fully visible sequences above support the conclusions independently. Instructor-owned decisions remain with the coordinator; no change to title/order/count/depth/scope or production is proposed here.
