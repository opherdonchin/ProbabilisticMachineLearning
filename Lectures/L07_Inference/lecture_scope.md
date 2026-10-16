# L07 — Inference overview: construct and check posterior answers

**Status, 2026-10-16:** Scope revision under the instructor's accepted two-neural-lecture mandate. This funded allocation implements retained sampling competence while replacing the old L10 meeting. The exact Challenger application is already accepted for L09; its use here and the detailed allocation are coordinator recommendations under the autonomous implementation request, not a fabricated whole-scope instructor approval. Earlier reviews validate only their original versions. No class has been taught.

## 1. Intellectual arc

A point fit, a distributional approximation and a numerical estimate of an expectation answer different questions. Start with a recognizable posterior prediction task, derive a local Gaussian approximation, then compare answers with a checked low-dimensional reference and supplied sampler output. The central message is to select computation for the query and check the relevant error, rather than equate a familiar software result with the desired posterior answer.

Students bring Gaussian conditioning, GLM likelihood derivatives and L06's fitting/inference distinction. They have practical PyMC experience but are not assumed to know MH, HMC or NUTS algorithms. Supply an interface/diagnostic refresh. Explain what a sampler targets without deriving its transition construction.

**Budget:** 18 minutes queries and method selection; 10 mode/reference meaning; 28 scalar Laplace derivation plus multidimensional statement; 26 posterior application/comparison; 18 sample-average error and dependent-output interpretation; 12 questions/slippage = **112 live minutes**, separate 60-minute notebook. This replaces the earlier manual grid construction, worked coordinate-transform example and optional Beta/determinant illustrations. State density-MAP coordinate dependence without working that transformation. No new recording or hidden MCMC module. Budgets are unmeasured and need downstream feasibility/timing.

## 2. Mathematical spine

Let $u(\theta)=p(\theta)p(D\mid\theta)$, $Z=\int u$, and $E=-\log u$. Distinguish normalization, mode, moments and posterior predictive probabilities.

* **Apply:** $I=E_p[g(\theta)]$ and $p(y_*\mid x_*,D)=\int p(y_*\mid x_*,\theta)p(\theta\mid D)d\theta$. Parameter spread, predictive uncertainty and numerical error are different objects.
* **Derive:** at an interior stationary mode $\hat\theta$ with $H=E''(\hat\theta)>0$, $E(\theta)\approx E(\hat\theta)+H(\theta-\hat\theta)^2/2$. Hence $q_L=N(\hat\theta,H^{-1})$ and $Z_L=e^{-E(\hat\theta)}\sqrt{2\pi/H}$. This exactly normalizes the quadratic surrogate and only approximates the original integral.
* **State/explain:** in $d$ dimensions replace curvature by a positive-definite Hessian, giving $q_L=N(\hat\theta,H^{-1})$ and $Z_L=e^{-E(\hat\theta)}(2\pi)^{d/2}|H|^{-1/2}$. Dense Hessian storage and factorization generally cost $O(d^2)$ and $O(d^3)$, excluding likelihood evaluations. Near-mode regularity and concentration motivate the approximation; boundaries, skew, flat directions, neglected modes and important tails can spoil task answers. No general error theorem.
* **Work scalar logistic curvature:** $E(\theta)=\theta^2/(2\tau^2)+\sum_i[\log(1+e^{x_i\theta})-y_ix_i\theta]+c$; $E''=\tau^{-2}+\sum_i x_i^2s_i(1-s_i)>0$. Proper Gaussian prior yields a finite unique mode even with separated labels. Use this transparent calculation to explain, rather than implement by hand, the two-coefficient application.
* **Apply reference checks:** supplied quadrature uses normalized integration weights, with separate domain-widening and resolution checks. A normalized plot alone does not certify omitted-tail accuracy. Do not call the numerical reference exact.
* **Derive/apply iid Monte Carlo:** for independent target draws and $E_p[g^2]<\infty$, $\hat I=N^{-1}\sum_s g(\theta_s)$ has $E\hat I=I$ and $\operatorname{Var}(\hat I)=\operatorname{Var}_p(g)/N$. This is an estimator of a query, not a posterior family.
* **State/interpret dependent output:** iid standard errors do not apply directly to correlated draws. Under appropriate stationarity and summable-autocovariance/CLT conditions, the long-run variance for a scalar query is $\gamma_0+2\sum_{k\ge1}\gamma_k$ and standard error is approximately its square root divided by $\sqrt N$. Interpret supplied query-specific ESS/MCSE rather than derive or estimate the full theory by hand. Multiple-chain diagnostics and divergence reports can reveal trouble; passing diagnostics cannot certify all relevant regions were visited. Invariance alone is no finite-run accuracy guarantee.

Laplace is not introduced as a KL optimizer. Sampling from its Gaussian computes approximate-posterior expectations; target sampler output estimates a different distributional integral. L08 exact structure and L09 distributional optimization retain their own mathematical arguments.

## 3. Notebook handoff

Use the accepted Challenger logistic model: all 23 flight-level records, any erosion **or** blowby as binary thermal distress, standardized temperature plus intercept, $w\sim N(0,4I_2)$. The response is not catastrophic failure. This small posterior makes checking practical; it does not itself prove a large-scale computational advantage or justify a launch decision. Fixed preprocessing, prior and query are supplied before results are inspected.

The focused spine is **posterior query → local proxy → sampled average → checked comparison**. Scaffold equations, software calls and interpretation in local steps. Supply model/data provenance, mode/Hessian helper, posterior-reference calculations, sampler interface, chain extraction, plots and diagnostic summaries. Students apply the local Gaussian, average conditional probabilities from draws, distinguish posterior spread from MCSE, and judge the specified comparison. No independent PyMC program or MH implementation.

**One-hour allocation:** 10 task/prior/interface refresh; 15 Laplace/reference operations; 15 sampled-query/diagnostic operations; 15 comparison and error interpretation; 5 reserve. Run bounded chains/updates and use verified longer-run output if needed for meaningful interpretation. A short student run is not called converged. A clean worked solution, package availability, workload check, local uv and hosted Colab execution remain required before publication. Current lock does not supply PyMC/ArviZ; the provided interface must be reconciled with pinned runtime/dependencies rather than assume imports work.

## 4. Concrete examples and verified reading route

The scalar logistic derivation is course-constructed; retain eight illustrative observations $x=(-2,-1.5,-1,-0.5,0.5,1,1.5,2)$ and $y=(0,0,0,0,1,1,1,1)$ with $\tau=2$ as a bounded live calculation, not a second student fitting project. The practical Challenger data/model/provenance and checked reference are owned by [L09 scope](../L09_Variational_Inference/lecture_scope.md); consult the exact source records in that lecture directory.

Murphy Book 2, December 10, 2025: §§7.1–7.3 for the taxonomy of inference queries; selected §§7.4.1–7.4.3 for mode, numerical integration and Laplace; §§11.2–11.2.2 for sample averages and iid error; selected §12.6.3 for dependent-output diagnostic interpretation. Read for distinct target/proxy/estimator objects and each method's assumptions. These readings do not promise a Chapter 12 algorithm course.

## 5. Lecture contract and boundaries

Students should formulate a posterior predictive query, derive scalar Laplace, explain the multidimensional construction and limitations, compute a sampled expectation, and distinguish proxy error, finite numerical error and model mismatch on a real small posterior. They practise the application through supplied software, not sampler construction.

Retained sampling depth is deliberately bounded. Omitted: general MH correction/detailed-balance proof, Gibbs-as-MH, proposal tuning, chain convergence/mixing proofs, HMC/NUTS mechanics and importance/AIS algorithms. Prior PyMC familiarity is not algorithm competence. The old L10/AIS plan remains in Git history and creates no future obligation. L09 reuses comparison outputs and the checked reference; L10 and L11 develop neural representations. Later section designs must end with retrospective summaries; notebook instructions remain a separate lecture-level item. New feasibility and detailed approval gates remain explicit.
