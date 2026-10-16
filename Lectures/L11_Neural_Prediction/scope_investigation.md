# L11 scope investigation: bounded neural conditional prediction

**Stage/mode:** Lecture Scope / feasibility-review, with explicitly authorized isolated author probes. **Specialist:** `/root/investigate_l11_l12`, 2026-10-14. **Target:** `lecture_scope.md` at worktree baseline `5e4c86ee3518958157d21d6bcb4c51bcdab3537e`; no scope, map, skill or L01 changes. Target scope blob `629e38893497e4b2cf18e4fcf58d225177c00f88`. **Verdict:** feasible with risks. Scope acceptance and the specific choices below remain pending; author CPU execution is evidence about the candidate, not approval or a completed teaching notebook.

The compact PyTorch model now has actual execution evidence. Across three fixed initialization seeds it learns both a curved conditional mean and changing conditional spread, while an affine baseline and a nonlinear fixed-scale baseline expose different deficiencies. The training computation is comfortably bounded on this machine. The open educational issue is what students should compare and what explanation connects this model to L12, rather than whether this small network can execute.

## What students would become competent to do

At the current proposed depth, students **work/apply** a composed nonlinear predictor, **derive** the complete Gaussian NLL and local mean/scale derivatives, **apply** reverse-mode AD through two heads, and **work** held-out prediction checks. They complete mean and positive-scale outputs and a batch-mean NLL, run one supplied driver, and interpret predictions. They are not being asked to design architectures, tune several models or infer a posterior over weights.

For a fitted weight vector ψ,

$$
p_\psi(y\mid x)=N(y;\mu_\psi(x),\sigma_\psi(x)^2),\quad
\sigma_\psi(x)=0.03+\operatorname{softplus}(a_\psi(x)),
$$

$$
\ell=\tfrac12\log(2\pi)+\log\sigma+\frac{(y-\mu)^2}{2\sigma^2},\qquad
\frac{\partial\ell}{\partial a}
=\left(\frac1\sigma-\frac{(y-\mu)^2}{\sigma^3}\right)\operatorname{sigmoid}(a).
$$

The positive floor is a model/numerical constraint. Gaussian log score rewards appropriate width as well as mean fit; omitting `log σ` changes the target. The intended validity regime is interpolation under approximately Gaussian conditional residuals with enough relevant training cases. Flexible mean/scale evaluation has a computational payoff after fitting, but its training is more costly and statistically less constrained than affine regression. This probe does not demonstrate extrapolation, robustness to another data law, or a calibration guarantee.

## New reproducible author evidence

[Probe](notebook_feasibility/probe.py) and [exact compact results](notebook_feasibility/results.json) use the isolated worktree uv Python after `uv sync --locked`, PyTorch `2.14.0+cpu`, NumPy `2.0.2`, and one CPU thread. An initial identical run used the main environment read-only; the retained results were regenerated in the isolated environment. No dependency/lock change occurred.

Reproduce from the isolated worktree root with `.venv/bin/python Lectures/L11_Neural_Prediction/notebook_feasibility/probe.py`. The script fixes every configuration in code and regenerates only its owned JSON. Shared source dependencies checked here are architecture blob `cb111196e44df211e39864be596233a1a3f22aba`, proposed map blob `12a341b7e8733cdf9fe8154f066648d64e6034c0`, and cumulative student-knowledge blob `3fc6cd92b3c43b56c5ce4ca5a7d2963a2eb79942`; no material has been taught in the actual map.

The explicit course-constructed law is `X~Uniform[-3,3]`, `μ(X)=sin(1.5X)+0.2X`, `σ(X)=0.15+0.5 sigmoid(1.5X)`. This is an intentionally simpler bounded interpolation diagnostic, **not a replication of Murphy's larger TensorFlow/TFP example**. The scope does not prescribe that source law. A fixed data seed generates 320 training and 160 held-out observations; the latter are explicitly divided into 80 validation and 80 untouched test cases. Input normalization uses training rows only; targets retain original units. The 32-ReLU-unit two-head model has 130 parameters and matching `B×1` target/mean/scale tensors.

The configuration was fixed before inspecting test results: 800 full-batch Adam steps at 0.01, validation every 20 steps, minimum validation NLL checkpoint, initialization seeds 17/29/43. Adam is supplied driver machinery, not additional optimizer theory; it does not establish the ordinary-SGD prior/shrinkage equivalence. The fixed-scale nonlinear baseline fits its mean by MSE and estimates its scale from training residuals. The affine Gaussian baseline is the training-only closed-form MLE. No test score selects a setting or checkpoint.

| Supplied/completed candidate | Test mean NLL | Test mean squared error | Fit wall time, excluding imports |
|---|---:|---:|---:|
| Affine mean, fixed scale | 1.1844 | 0.6213 | Closed-form linear solve |
| Nonlinear mean, fixed scale; three seeds | 0.5515–0.5657 | 0.1762–0.1813 | Approximately 0.19–0.21 s per 800-step fit |
| Nonlinear mean and positive scale; three seeds | 0.3860–0.3982 | 0.1737–0.1788 | Approximately 0.28–0.31 s per 800-step fit |

Both nonlinear candidates improve the mean compared with the line. The extra scale head improves log score substantially, while MSE differs little. That contrast is the intended practical interpretation; one cannot replace it with a claim that a better log score necessarily gives a better mean predictor.

All float64 loss/derivative checks pass: distribution-reference NLL error `4.44e−16`; analytical mean and raw-softplus derivatives agree with AD within `5.56e−17`; numerical gradcheck passes; the shared hidden adjoint agrees with the sum of mean-path and scale-path contributions within `5.56e−17`, and both paths are nonzero. These are author responsibilities, not instructor decisions.

The test low-/high-input groups each have 40 cases. Fixed-scale nonlinear coverage is 0.975 versus 0.825–0.85; heteroskedastic coverage is 0.90–0.925 versus 0.925–0.95 across seeds. The results include Wilson intervals, including at empirical coverage one. These coarse counts illustrate different interval behavior; they do not verify population 95% calibration. They are conditional on one generated dataset, not independent dataset replications.

A single point fit predicts observation spread. A Bayesian weight posterior would also contribute

$$
\operatorname{Var}(Y_*\mid x_*,\mathcal D)
=E[\sigma_\psi(x_*)^2\mid\mathcal D]
+\operatorname{Var}[\mu_\psi(x_*)\mid\mathcal D].
$$

The probe computes neither weight posterior nor second term. A Gaussian-prior penalty scaled as `‖w‖²/(2Nτ²)` under mean NLL also gives a point estimate, not that uncertainty.

## Prerequisites and conditional cross-lecture implications

L04 supplies probability log scores. L05 must supply a complete branching AD example and the tensor/loss/gradient-reset/update loop; this is prior encounter rather than independent PyTorch fluency. L09 supplies approximation/predictive-integration distinctions and its Gaussian sampling derivative. L10 is useful numerical-error context but neither HMC nor a sampler is required here. L11 supplies the scalar Gaussian likelihood and constrained outputs which L12 reuses.

The cumulative knowledge file currently records only entry/L01 state; later scoped material is a **conditional future dependency**, not delivered knowledge. Assume probability/Bayesian reasoning, NumPy indexing and matrix multiplication familiar. Scaffold previously encountered shapes and the PyTorch loop after a NumPy-based L10. Treat the two-head model, actual softplus chain, interval interpretation and optional model-versus-inference role as new. All preprocessing, comparison fits, model wrapper, plot and driver code should remain supplied. The probe's runtime does not prove that the 15-minute assembly/12-minute checks-and-run task is achievable by students.

## Instructor-owned questions, deferred review

### L11-NETWORK-ROLE — funded model/inference bridge

**Status:** awaiting instructor decision; owner Lecture Scope. Eventual accepted answer belongs in [lecture_scope.md](lecture_scope.md), not in the review queue.

**Question:** Should L11 adopt the recovered five-minute explanation of numeric computation graphs and the two probabilistic neural roles, funded by removing required SGD-shrinkage/adaptive-penalty mechanics?

**Options:** (A) adopt the exact funded exchange; (B) retain the current conditional-regression route and let L12 first introduce inference networks; (C) reopen a broader neural-architecture route, which needs a new extent assessment and displaces current commitments.

**Recommendation:** A. A composed numeric graph can output parameters of `p_θ(y|x)` or of `q_φ(z|x)≈p(z|x)`; the second role is the prerequisite bridge into L12, not another L11 fit. Preserve the full Gaussian NLL/scale, point/noise uncertainty distinction and short prior-scaling derivation.

**Evidence:** recovered proposal commit `dd4f2c5053f29590845ae42a6331d245d773218c`, L11 scope blob `380d611c034f0edcc50d732b52f22732fc22f19d`; its independently authored `source_arc_agent_reviews/L11_post.md` and `L11_section.md` both support the bounded repair while explicitly withholding instructor approval. Allocations A/B/E become 24/33/7 rather than 22/30/12, preserving 100 substantive +12 reserve. Murphy B2 December 10, 2025 §16.1 *Introduction*, p.631 directly explains both roles. The CPU model independently confirms that the existing shared-head graph is sufficient as the worked object; no new architecture is needed.

**Exactly waiting:** final adoption/revision of L11 arc/spine/contract and downstream section design for the graph/two-role/prior-mechanics responsibilities. L12's receiving explanation must be conditional on that choice. **Safe work completed/remains:** conditional source/extent assessment, Gaussian model/gradient/run probes and L12 joint-training investigation completed; neither L11 notebook correctness research nor L12 loss/source feasibility waits. No proposed exchange has been accepted or implemented.

### L11-AFFINE-BASELINE — practical comparison endpoint

**Status:** awaiting instructor decision; owner Lecture Scope. Eventual answer belongs in [lecture_scope.md](lecture_scope.md).

**Question:** Should the notebook require inspection of one supplied affine Gaussian comparator in addition to the existing supplied fixed-scale nonlinear comparator, preserving one student fit?

**Options:** (A) include both prepared comparators and use a compact common score/interval display; (B) keep only the fixed-scale nonlinear comparator and explicitly narrow the map's simpler-function comparison; (C) replace the fixed-scale nonlinear comparator by the affine one, losing the isolated scale-head contrast.

**Recommendation:** A. The line tests nonlinear mean flexibility; the nonlinear fixed-scale model isolates the scale extension. Neither adds a second student fit. Use the existing comparison/interpretation allocation rather than promising extra discussion time; later pilot must confirm this fits.

**Evidence:** current map promises simpler-function and fixed-scale comparisons, whereas scope Part 3 supplies only the latter. The fixed split shows affine MSE 0.6213 versus nonlinear ≈0.174–0.181; heteroskedastic NLL ≈0.386–0.398 versus fixed-scale nonlinear ≈0.551–0.566. The two contrasts test different capabilities.

**Exactly waiting:** adoption of the affine-comparison notebook commitment and the corresponding scope/map alignment. **Safe work completed/remains:** both candidate baseline calculations and their fairness/shape checks are completed; the single student-fit candidate and conditional interpretation route can continue to be validated. No accepted baseline choice has been silently replaced.

## Remaining gates and independent work disposition

No further bounded CPU/source investigation is necessary to answer these two choices. The coordinator can independently review the scripts/results and integrate cross-lecture dependencies while awaiting instructor review. Following accepted choices, the worked-solution owner must prepare the actual reference implementation/checkpoint/display, test clean local uv execution and fresh hosted Colab, and conduct the student-workload pilot; Section Design must test extent. None is claimed here, and none authorizes generic PyTorch fluency or changes shared skills. Each future section still ends retrospectively.
