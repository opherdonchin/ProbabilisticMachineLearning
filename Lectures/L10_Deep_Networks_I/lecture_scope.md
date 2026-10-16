# L10 — Learned representations and local structure

**Status:** Author-built five-part Scope under the instructor's accepted two-lecture deep-network mandate, 2026-10-16; a separate Section Design/source-arc preview returned **feasible with advisory risks**, with required acceptance and downstream validation still outstanding. The architecture decision is approved; this complete Scope is not yet instructor-approved or downstream-validated. The [development register](development_state.md) owns status; the [sequence contract](../deep_networks_revision/sequence_contract.md) identifies the selected division and cross-course substitutions. No class delivery, runtime readiness or learner timing is claimed.

**Central teaching choice:** Develop learned compositional representations and the structural restriction of convolution through an image-prediction task. The notebook starts from an actual PyTorch LeNet/Fashion-MNIST notebook, with supplied infrastructure and a scaffolded theoretical/technical walkthrough. It is not another affine-classification implementation. The former heteroskedastic-regression lecture remains reusable source evidence; it does not dictate either new lecture's purpose.

## 1. Intellectual arc

### Starting boundary and source argument

Students bring Bayesian likelihood/prior/posterior reasoning, Gaussian and categorical distributions, and L05's affine logits, likelihood gradients, branching reverse-mode differentiation and first PyTorch training loop. L03 supplies probabilistic factorization, not a neural computational architecture. L09's variational work precedes L10 but does not make image tensors or convolution familiar. These are prospective dependencies; no prepared lecture is thereby delivered knowledge.

Murphy Book 2 Ch.16 begins with differentiable computations, gives reusable building blocks, and combines them into models suited to different structures. Book 1 §13.1 explains the move from hand-selected to learned features, while §14.1/§14.2.1 explains why unstructured dense weights fail to use spatial repetition. This lecture selects that composition-to-locality argument. L11 receives its numerical/probabilistic language and develops context-dependent representations. We omit the implicit-layer and architecture catalogues rather than claim all of Ch.16 here.

**Problem encounter:** An image contains local patterns whose relevance need not depend on one exact pixel location. Predicting its clothing category calls for useful probabilities on held-out images. An unrestricted dense map can represent such behavior but does not impose shared local detectors. At small images/limited data, a structured model can reduce parameters and reuse features; its benefit must be evaluated, not inferred from a parameter count alone.

### A. From fixed predictors to learned composition — 25 minutes

**Transition in:** L05 already supplies a valid categorical likelihood. Its affine predictor has limited input-dependent features; changing the likelihood is not the remedy for this limitation.

**Question:** What changes when the feature map is itself learned and composed? **Sources:** B1 §§13.1–13.2.3/13.2.5, pp.425–429, 434–435; B2 §§16.1/16.2.1–16.2.2/16.3.1, pp.631–633, 641–642.

Write a categorical conditional with a learned hidden map; work dimensions and affine collapse. Work a short nonlinear composition and explain learned intermediate representations as task-trained numerical features, not identified scientific causes. State the multilayer recurrence and show why composition can reuse a feature rather than relearn every occurrence independently. No universal-approximation proof or guarantee that greater depth improves a finite fit.

**Retrospective summary:** The probability model and its learned numerical representation have distinct roles. Nonlinear composition expands the feature repertoire; purely affine stacking does not.

### B. Impose locality and reuse across space — 35 minutes

**Transition in:** A dense feature map treats spatial positions as unrelated parameters. Images provide a reason to restrict that map.

**Question:** What do locality and weight sharing buy, and what do they assume? **Sources:** B2 §16.2.3, pp.633–635/§16.3.2 p.642; B1 §§14.1–14.2.1.3, pp.467–471; selected padding/stride/channel discussion pp.471–475; §14.2.2 pp.475–476.

Derive a convolutional output and represent the same operation as a sparse matrix with repeated entries. Work parameter counts and accumulation into shared weights. Prove shift equivariance for an explicitly declared translation/boundary regime. Explain why striding/cropping can break the unrestricted identity and why feature equivariance is different from classifier invariance. Derive receptive-field growth for a simple stride-one stack; interpret hierarchical local composition. Pooling is a chosen aggregation, not a theorem of arbitrary translation robustness. Work one finite-image trace with the actual notebook's declared padding/pooling.

**Retrospective summary:** Convolution imposes local shared computation, reduces free parameters and transforms spatial features predictably under stated shifts. Depth grows the information available to a feature; neither property alone establishes predictive success.

### C. Train the composed computation without changing its meaning — 20 minutes

**Transition in:** Shared features define a model class; their parameters still have to be learned from the observations.

**Question:** How does familiar differentiation extend, and what limits training? **Sources:** B2 §§16.2.4–16.2.5, pp.635–636; B1 selected §13.4, pp.446–454; §§13.5.1–13.5.2 p.455. Reuse L05's chain rule and optimizer distinction.

Apply reverse-mode accumulation through the actual composition and show a shared filter receives contributions from all its uses. Derive the local residual Jacobian identity and explain direct gradient paths; it is not a guarantee against all training failures. State initialization/activation scale and normalization roles without a method catalogue. Explain nonconvexity, validation stopping and overfitting. The main notebook supplies these mechanics; students need to interpret them, not reconstruct a training framework. Contrast sigmoid saturation with ReLU only to illuminate the derivative; no activation sweep.

**Retrospective summary:** Backpropagation follows a shared numerical graph, while optimization and generalization remain separate problems. Residual paths and sensible scaling help training under particular conditions; completed updates do not certify a good predictor.

### D. Judge a probabilistic image model and generalize its output role — 20 minutes

**Transition in:** Low training loss and feature plots are not the desired end product; the task requires probabilities that work on new images.

**Question:** What evidence supports using the structured predictor? **Sources:** B2 §§16.1/16.3.1–16.3.2, pp.631, 641–642; L04/L05 scoring reused; B1 §13.2.4.4 pp.433–434 as a short different-output connection.

Compare held-out NLL and classification error with supplied dense predictions; interpret examples and a controlled shift diagnostic under the declared regime. Parameter counts and feature maps explain the design but do not prove its advantage. Show that the same kind of learned map can instead supply a Gaussian mean and positive scale; no complete heteroskedastic-loss derivative or second fit. Keep predicted observation variability and posterior uncertainty about parameters distinct. Briefly locate numerical computation graphs relative to L03's random-variable graph; edges have different meanings.

**Retrospective summary:** Structural assumptions earn their place through task performance and interpretable failure analysis. A neural map can supply different likelihood parameters, while a fitted network remains a point-parameter model unless parameter uncertainty is explicitly modeled.

**Extent:** 100 substantive +12 reserve = **112 live minutes**, plus a **60-minute notebook**. Tight and unmeasured. These responsibilities are provisional macro-level allocations, not final section boundaries. First remove the optional residual numerical repetition, additional feature panels and extra shift cases; retain the composition, tied-weight, equivariance/regime and task-evaluation arguments. No required recording and no unbudgeted survey. The timing reference's 61-content-slide L01 calibration is a rough anchor; current L01 reconciliation reports 69 handout pages, so its older 70-page count must not be mistaken for rehearsal evidence. Actual derivation/interaction burden controls subsequent checks.

**Alternatives evaluated:** A heteroskedastic-first lecture preserves excellent conditional-density mathematics but repeats the previously diagnosed contraction of the architecture argument. An MLP-only image exercise does not show locality/sharing in use. A catalogue of CNN families adds names without the mathematical reason for choosing them. The selected small CNN gives one substantial structural move and preserves room for L11's different context problem.

## 2. Mathematical spine

Let x be an image/vector, h a deterministic feature representation, y its category and θ all fitted parameters. h is not an unobserved random latent state requiring posterior inference. Natural logs define NLL. For convolution, K is a kernel, c/d index input/output channels, and i,j denote positions; all shapes and boundaries must be stated before a calculation.

| Object/result | Depth and role |
|---|---|
| `p(y\|x)=Cat(y;softmax(W h_phi(x)+b))`; `h^(l+1)=varphi_l(W_l h^l+b_l)` | **Motivate/work**, Live A; learned feature versus output-law distinction. General depth recurrence **state**. |
| `W2(W1x+b1)+b2=(W2W1)x+W2b1+b2` | **Derive/work**, A; affine depth does not increase this function class. |
| `ReLU(x)+ReLU(-x)=abs(x)` | **Work**, A; concise course-created nonlinear example. The source notebook's sigmoid backbone is a different declared activation, not mislabeled ReLU. |
| `a_ijd=b_d+sum_uvc K_uvcd h_(i+u,j+v,c)` | **Derive/work**, B; cross-correlation convention called convolution in deep learning. Sparse/tied-matrix representation **work**. |
| Dense `D_in D_out+D_out` versus convolution `k_h k_w C_in C_out+C_out` | **Work/interpret**, B; compare declared output shapes, not unmatched parameter counts. Parameter reduction is not a sample-complexity theorem. |
| `C_K(T_delta X)=T_delta C_K(X)` on the full lattice (or declared periodic counterpart) | **Prove**, B by substitution; pointwise nonlinearities commute with the same shift. State finite-boundary and subsampling qualifications. No unconditional classifier-invariance promise. |
| Receptive field side length `r_L=1+L(k-1)` | **Derive/work**, B for equal-kernel, stride-one, no-dilation layers; general cases only interpreted using supplied dimensions. |
| `partial L/partial K_uvcd=sum_ij delta_ijd h_(i+u,j+v,c)` | **Apply/work**, B/C, where delta differentiates loss with respect to preactivation. Sharing adds contributions from every use, with the declared batch/loss normalization. |
| `J_(x+F(x))=I+J_F(x)` | **Derive/explain**, C; residual direct path, no general stability proof. |
| Mean categorical NLL, validation versus untouched test score; SGD/AD distinction | **Recall/apply**, C/D from L04/L05. `CrossEntropyLoss` receives logits rather than an already-softmaxed probability vector. |
| Gaussian alternative `N(y;mu_phi(x),sigma_phi(x)^2)`, `sigma=epsilon+softplus(a)` | **State/explain**, D only. Different likelihood output, no mean/scale derivative chain or second regression application. |

The validity regime is a meaningful spatial-locality/shared-feature assumption and sufficient representative training data. Dense convolution costs roughly `H_out W_out k_h k_w C_in C_out` arithmetic per layer; shared parameters reduce storage but do not remove spatial computation. Evaluate held-out probability/error and failure under declared perturbations. Approximation-family posterior error, numerical training error and observation-model mismatch are different questions.

## 3. Notebook handoff

**Anchor:** actual pinned pyprobml `notebooks/book1/14/lenet_torch.ipynb`. Fashion-MNIST supplies 28×28 grayscale clothing images and ten labels. Reuse its workflow initially, with supplied tensor data, model/driver and dense baseline. Do not substitute another image dataset while claiming source replication. Exact subset/split/checkpoint settings are author decisions to freeze and validate.

**Lecture has established:** composition, local/shared operations, valid categorical outputs, parameter-count/computation distinctions, equivariance qualifications, and evaluation against the actual task.

**New notebook work:** connect an image patch and tied matrix entries to package filter output; follow the source model's representation shapes and pooling; relate training signals to shared parameters; make bounded prepared updates; compare held-out probabilities/errors with a supplied dense predictor; interpret a controlled spatial check and representative successes/failures. The computational spine is **image → shared feature computation → composed representation → categorical prediction → held-out judgment**. Detailed solved Q&A develops theory, technical operations and interpretation together; coding is not the presumed independent core.

The actual source model uses **Sigmoid and AvgPool**, with two convolutional layers followed by dense layers and ten logits. Explain the operations actually run. A bounded-fit adaptation may select ReLU or a smaller validated configuration, but it must label the source change and validate it; neither source activation nor source training duration is frozen as a course requirement. ReLU can remain the small live illustration without falsely describing the original source model. Data/reshape utilities, initialization, stable loss/optimizer calls, plots, baseline fits and checkpoint production are supplied; package calls do not make their mathematical meaning optional. Students need not reproduce an optimizer or implement convolution loops.

**60-minute planning allocation:** 10 task/data/logit refresh; 20 linked representation/sharing reasoning; 10 bounded updates/checks; 15 held-out interpretation; 5 reserve. No two full student fits or architecture/activation search. A checked trained checkpoint supports interpretation after bounded updates if from-scratch learning is too slow. Report the short run honestly rather than calling it converged.

**Author gates:** current lock lacks torchvision, which the source loader imports; resolve a supplied verified loader/tensor route or explicitly update the environment at the proper stage. The source driver reinitializes weights on each call, so it cannot resume a supplied checkpoint unchanged. It monitors the named test iterator each epoch; separate course validation from untouched final evaluation. Its progress expression assumes enough minibatches and needs a safe small-subset implementation. Validate actual Fashion-MNIST acquisition, splits, model/baseline checkpoints and mathematical output checks; operator timing on other images is not dataset outcome evidence. Then complete solved/student derivation, learner-workload check, clean local uv and hosted Colab execution. No such readiness is claimed here.

## 4. Concrete examples and source records

- **Affine collapse and absolute value, Work/Live:** course-created calculations above, not Murphy-attributed numbers. They isolate why nonlinear representation matters.
- **Shared local filter, Work/Live and notebook:** B1 §14.2.1.2 Eqs.14.6–14.7 uses a 3×3 image and 2×2 kernel; §14.2.1.3 Eqs.14.8–14.9 shows the tied matrix. Recheck exact entries when authoring; use the current source rather than inventing an attributed image.
- **Translation/receptive field, Work/Live:** course derivation with explicitly declared boundary/stride. B2 §16.2.3 motivates equivariance. B1 Ch.14 sometimes calls convolution invariant; correct that shorthand rather than inheriting it.
- **Fashion-MNIST classifier, Work/Notebook, Compare/Live:** source model, valid ten-category likelihood and supplied comparison. No accuracy advantage, calibrated probabilities or semantic feature discovery is promised before validation.
- **Residual Jacobian and Gaussian-output contrast, Brief/Live:** source-supported mechanisms with course-selected derivational depth; no second lab.

**Verified editions:** Murphy B2 online **December 10, 2025**; B1 online **April 18, 2025**. Focused reading: B1 §§13.1/13.2.2/13.2.5 for learned composition; §§14.1–14.2.1.3 for why local tied matrices help; B2 §16.1/§16.2.3/§16.3.2 for the larger computational/probabilistic role. B1's useful representation/depth intuition does not establish a universal depth/generalization theorem.

**Exact computational source:** pyprobml checkout `d1ea4122dcf3c2a2c02eb4e05343203b26440827`; `notebooks/book1/14/lenet_torch.ipynb`, SHA-256 `3679f030da4dfb7f350ee30d36341f9e7da475f322aa78f73b3c8eb55c5c377e`; directly inspected model6, shapes7, loader9–10, driver17 and ten-epoch call19. The model has 61,706 parameters. Source inspection and a separate cheap operator probe are not a clean student-notebook run.

## 5. Lecture contract

**Start:** L05 affine probabilistic prediction and numerical AD/PyTorch; L03 probabilistic graphs, with the numerical/probabilistic distinction explained in this lecture; entry calculus/linear algebra. **Question:** how do learned composition and local shared computation turn spatial structure into a usable probabilistic predictor? **Live endpoint:** derive/work the learned-feature and tied-filter constructions, prove their qualified shift behavior, explain depth/receptive fields and training, and judge task-relevant predictions. **Notebook endpoint:** one guided source-backed CNN workflow, bounded training and meaningful held-out comparison. **Delivery:** 112 live +60 notebook minutes; no required recording.

Students can explain what a representation computes, distinguish output likelihood from architecture, work sharing/shape/parameter and gradient consequences, and challenge performance claims. They do not gain a comprehensive vision toolkit, posterior uncertainty over weights, an architecture-search method or robustness guarantees. CNN-family history, object detection, segmentation, implicit layers, neural Bayesian nonparametrics and full heteroskedastic training are omitted. These omissions are not L11/L12 debt.

**Next owner:** bounded independent feasibility/source-arc review, then coordinator disposition and required acceptance before Section Design. Preserve retrospective section endings; put connections at the beginning of the receiving responsibility. Timing, geometry and student workload may produce later stage-owned backpressure; do not silently add a survey or weaken the central mathematics to fit.
