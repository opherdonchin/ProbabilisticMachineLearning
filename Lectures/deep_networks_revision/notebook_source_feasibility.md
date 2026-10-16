# Two neural notebooks: source and feasibility evidence

**Stage/mode:** worked-solution source/feasibility review, 2026-10-16. Input
`a804af6`; isolated branch `test/course-neural-notebook-feasibility`. Sole write
is this report. Read the instructor's complete attached revision mandate and the
existing worked-solution/teaching-notebook skills. The settled change replaces
L10 MCMC with Deep Networks I and expands L11 into Deep Networks II; this review
does not reopen that decision. No original notebook, environment, student work,
course map or skill was edited. Instructor notebooks and primary sources only
were inspected; no student-submission content was read.

**Recommendation:** image representations and probabilistic classification in
L10, followed by recurrent context and probabilistic sequence modeling in L11.
Start from the actual native PyTorch LeNet and character-RNN notebooks identified
below. Use prepared data, fitting/evaluation infrastructure and a supplied trained
checkpoint; students follow the mathematics, make a bounded update/manipulation,
call the model and check its answers. The two spines are **local learned features
→ categorical prediction** and **learned recurrent context → next-character law**.
Keep attention as a substantial worked context-retrieval/causal-masking mechanism
with a cost comparison, without a third transformer training task. This aligns
with the emerging coupled contract exchanged directly with `/root/l06_real_contract`.

**Verdict: feasible-with-risks, now supported by actual-data teacher probes.**
The coordinator subsequently authorized the `notebook_feasibility/` prefix.
[probe.py](notebook_feasibility/probe.py) runs actual Fashion-MNIST and TimeMachine
fits, fixed held-out splits, a declared smoothed Markov baseline and direct Torch/
mathematics checks. [Results](notebook_feasibility/results.json),
[raw stdout](notebook_feasibility/run.txt) and fitted checkpoints are retained.
The source notebooks are not hourly-ready unchanged; hosted Colab, learner-time
and final teaching-notebook checks remain. The CNN is usable but does **not** beat
the supplied small MLP in this fixed pilot. Preserve that finding rather than
advertise architecture superiority. The character RNN improves the common held-out
log score over its fixed count comparator.

## Three genuinely different pairs

| Pair | Distinct one-hour endpoints and source basis | Payoff and what is given up |
|---|---|---|
| **A. Image CNN → character RNN, recommended** | I: apply learned local features/weight sharing and a categorical likelihood on actual images, compare supplied affine/MLP outputs with one prepared CNN. II: use the RNN character source to score held-out prefixes and generate sequences, compared with a supplied smoothed count model; trace how a changed earlier prefix changes the same final-character prediction. | Two different structural assumptions and practical data types; L02 estimator transfer and L05 Torch reuse. Attention can be worked, not separately fitted. Requires data/checkpoint/evaluation preparation, but does not require students to reproduce either training engine. |
| **B. Heteroskedastic MLP → image CNN** | I: complete Gaussian conditional density interpretation with shared mean/scale features and held-out log scores; existing course author probe already runs quickly. II: categorical image prediction with convolution and a fixed-feature/MLP comparator. | Lowest risk for an already investigated distributional-head exercise, strong L12 Gaussian-output preparation. Loses a practical contextual sequence model and direct L02 return; recurrence/attention would be understood live but not used on a sequence task. This is a serious fallback, not an automatic preference because the old exercise exists. |
| **C. Embedded finite-context name MLP → image CNN** | I: extend L02's exact names source to learned character embeddings and a length-three context using Karpathy's actual MLP notebook. II: learn local image features with the CNN source. | Closest literal continuity with L02 and explicit representation learning before shared image features. Still lacks the recurrent/attention sequence competence of A; the finite-context MLP is a higher-order Markov conditional, not a learned unbounded-history summary. Its source needs shortening/clean-kernel repair. |

Pair A addresses the accepted Chapter 16 gap most directly. Pair B is justified
if the available teaching time cannot support contextual sequence reasoning;
choose it for that consequence, not because a synthetic regression fit is fast.
Pair C is useful if direct same-data continuity is more valuable than recurrence
practice. Full encoder–decoder translation transformers are not a credible extra
one-hour fit here: the actual source introduces translation data, tokenization,
encoder/decoder stacks, two attentions, padding masks and a new evaluation metric.
A toy attention tensor is an appropriate mechanism check, not a substitute for a
substantial application endpoint.

## Verified local source inventory

Local pyprobml checkout is **`d1ea4122dcf3c2a2c02eb4e05343203b26440827`** at
`/home/opher/Repositories/pyprobml`. All cell indices below are zero-based.
These are inspected source settings; their stored outputs are not new runtime
validation or required course configurations.

| Source / exact SHA256 | Cells, mathematics and actual workload | Reuse and smallest repairs |
|---|---|---|
| `notebooks/book1/14/lenet_torch.ipynb` — `3679f030da4dfb7f350ee30d36341f9e7da475f322aa78f73b3c8eb55c5c377e` | 20 cells. Cell 6 is the complete LeNet: 5×5 convolutions 1→6→16, sigmoid activations, average pooling, 120/84-unit dense layers and ten logits. Shape trace 7; Fashion-MNIST loader 9–10; prepared SGD/cross-entropy driver 17; ten epochs at learning rate .9 in 19. **61,706 parameters**, confirmed locally. | Strong native Torch architecture/math/fit scaffold. Loader needs torchvision, which is absent. Supply frozen, provenance-checked tensor data/loader rather than silently add a package. Source uses test accuracy every epoch: use validation while preparing checkpoints, preserve untouched test evaluation. Remove animation/obsolete `display.set_matplotlib_formats` and notebook install/mkdir machinery from the necessary route. Keep logits paired with cross entropy; do not add a second softmax inside that loss. |
| `notebooks/book1/15/rnn_torch.ipynb` — `8177d1fc9d2d7169ff7c2486f0e68d11b14e2887ce8072b384ac796a80200613` | 42 cells. TimeMachine corpus/vocabulary/loaders 5–8; recurrence equations 9 and explicit recurrence 12; gradient clipping 22, prepared train driver 25/27. Native `nn.RNN` 32 and wrapper 36 replace the manual parameter engine. Source trains both scratch H=512 (28) and native H=256 (40), **500 epochs each**, batch 32, unroll 35, default first 10,000 tokens. Native H=256,V=28 has **80,412 parameters**, confirmed locally. | Reuse native model, recurrence trace, one selected training driver and generation. Supply the rest; do not run two implementations or 1,000 total epochs during student work. Add held-out data and checkpoint selection; source reports training perplexity only. Cell 18 uses **argmax**, despite nearby sampling language: label it greedy or supply actual categorical sampling. Fix HTTPS/status/hash verification and seed Python random as well as Torch/NumPy. |
| `notebooks/book1/15/attention_torch.ipynb` — `f7b10c220756c504e7cdc86c7550b03dd45b4bc99174d9a88273e5706ce892ae` | 20 cells. Padding/length masked softmax 5; concrete tensor checks 7/9; additive attention 11; scaled dot-product attention 17. No fitted sequence task. | A source-backed worked mechanism for query/key/value, normalized weights and masked context. Its valid-length mask is not automatically the causal prediction mask; supply/verify the intended visible prefix. Set dropout zero/evaluation mode for equality checks. Do not treat a heatmap as explanation or model validation. |
| `notebooks/book1/15/multi_head_attention_torch.ipynb` — `471a5701d362234b92a6ee0be95310c1d4c0fda9cf145037d651288a94df72ac` | 15 cells; head reshape 6, masking 8, attention 9, multi-head composition 10, shape example 12–13. No learning objective/data/application. | Optional shape/mechanism reference; not a second notebook endpoint or a reason to assign multi-head plumbing. |
| `notebooks/book1/15/transformers_torch.ipynb` — `ac8e181771aa8b8b874b08bcf1b6bf5696d87d1008a85d2c0e59397609ed6f6a` | 57 cells. Encoder/decoder and positional layers 5–25, English–French data pipeline 27–33, two-layer model 34, 200-epoch fit 40, BLEU/prediction 42–44, heatmaps 46–55. | Source for architecture/context distinctions, not a small causal-name model ready to use unchanged. Turning it into a decoder-only character model is new assembly/validation, not merely calling the source. This is why A uses an existing RNN application with a worked attention comparison. |
| `notebooks/book1/13/mlp_1d_regression_hetero_tfp.ipynb` — `1e685b9e50518ab79a7448d6bfdcc27803596ae58a7ab1de9e1fbee7aeef37a6` | Eight cells. Synthetic data 4, shared backbone/two heads 5, two 500-epoch TensorFlow/TFP fits 6; mean and positive conditional SD. | Existing Torch course probe is a bounded **course-constructed adaptation**, not replication of that larger source. Good fallback/source for a compact Gaussian output comparison, with observation spread distinguished from weight uncertainty. The full old heteroskedastic lecture need not dominate the new sequence. |

Oke instructor references live under
`/home/opher/OneDrive/CurrentSemester/Teaching/Advanced Bayesian Statistics/Oke Advanced Probability Course/spring-2026/Lectures/Deep-Neural-Networks/`.
The four relevant notebooks were read fully; student-named assignment files were
not opened.

| Oke reference / SHA256 | Actual route and source-specific issues |
|---|---|
| `L3a-Neural-Networks-For-Structured-Data-I/L3a-Regression-ANN.ipynb` — `00192878d99c35d44eb39c7d9c1777aa31f9ae287484b22d2c0faae318bd2182` | 21 cells, metadata Python 3.11.5. California housing; dense 16/64/32 predictor 11, MSE/SGD 13, 30-epoch fit 14, residual/prediction plots 17–20. Cell 3 scales the data but cell 4 reloads unscaled frames before the split: preprocessing shown is not the model input actually used. Keras/TensorFlow, pandas and seaborn are absent. Useful workflow precedent, not probability-scale regression or a checked modern Torch solution. |
| `L3b-Neural-Networks-For-Structured-Data-II/M7a-Regression-ANN.ipynb` — `ded69c42b36e443b6a6c4bf24c14d638362b8dde42337757511f043221f82498` | 18 cells, Python 3.10.1. Same housing, 64/64/32 MLP; MAE/SGD 9, 30 epochs 11. Cell 3 scales **before** train/test separation, leaking held-out feature information. Fit transforms using training data only. MAE corresponds to a Laplace-location objective at fixed scale, not a Gaussian likelihood unless the objective is changed explicitly. |
| `L3c-Neural-Networks-For-Images/L3c-CNN-MNIST.ipynb` — `10717a25399e32093f2f76df351079a2ec3a150560c35cfee6e92feb3ffdbb2b` | 22 cells, Python 3.5.6. Actual MNIST loader 5; preparation 7–9; two 32-channel convolutions, pooling, 128-unit classifier/dropout 13; 12 epochs 17; classification evaluation 18. Old Keras imports, one-hot utility and history keys `acc/val_acc` need current-library repair. Test data supplied as epoch validation; change selection/evaluation separation. Strong original image-workflow precedent, but native Torch LeNet avoids a TensorFlow migration. |
| `L3d-Neural-Networks-For-Sequences/L3d-RNN.ipynb` — `976de167d97e028b41b25eefcaf871a00617198758736744f0a1d0e31db8da1f` | 30 cells, Python 3.5.6. Boston temperature with twelve supplied lags, LSTM8→scalar output 16, MSE/Adam, **1,000 epochs** 20. `reset_weights(model)` occurs in 15 before `model` is defined in a clean kernel. EarlyStopping is constructed 19 but never passed to fit20, contradicting the restoration claim24. Test set used as validation. This is conditional lagged regression, **not** categorical autoregressive language generation; porting it would not directly instantiate the accepted L02 return. |

## Literal same-data representation alternative

Karpathy's actual [makemore MLP notebook](https://github.com/karpathy/nn-zero-to-hero/blob/c6a5a3eeaa2688a1b56f019cafe38ba845ad16a3/lectures/makemore/makemore_part2_mlp.ipynb)
was retrieved read-only: file commit `c6a5a3eeaa2688a1b56f019cafe38ba845ad16a3`,
SHA256 `fc8c2f33363ec20985885ef78b0fc938d5be5e0a567762c7b3f4071a48254003`,
36 cells. Whole-name train/dev/test preparation 6, embeddings 7–8/22, concatenated
three-character context and nonlinear features 9–15/22, categorical loss/fit27,
validation30 and actual multinomial generation34 are useful for Pair C.
It runs **200,000** minibatch updates by default. The early scratch loss19 indexes
32 rows against the whole `Y`; it is not a clean-kernel valid route after cell4's
full dataset. Supply one coherent source subset and safe cross entropy; do not
execute that obsolete scratch transition unchanged. Fitting/checkpoints can be
prepared, and the shared-character embedding has a clear mathematical role. This
is a finite-context neural Markov model, not a recurrence demonstration or an
attention model.

## Data availability and continuity, not invented preparation

- **Fashion-MNIST:** actual official files are now downloaded to
  `/tmp/pml-neural-probe-data`, using immutable GitHub source commit
  `789103ddf3ef47449683debad30061320a3acddf`; compressed-file MD5 values match
  the official README. Complete URLs/SHA256 values and frozen original subset
  indices/tensor hashes are in the raw result. Prepared standard-library gzip/
  IDX parsing avoids adding torchvision. The pilot takes 600 training and 100
  validation images per class from the official training set, and 200 test images
  per class from its separate test set: **6,000 / 1,000 / 2,000**, fixed seed312.
  Only `/255` rescaling is used. No test image is used in fitting or checkpoint
  selection. Source datasets remain distinct: Oke uses MNIST digits; this actual
  source-adapted probe uses **Fashion-MNIST clothing**.
- **Built-in digits:** sklearn `load_digits()` is available without downloads:
  1,797 images, 8×8, intensities 0–16. This is an offline fallback/diagnostic,
  not MNIST. Adapting a 28×28 network requires an explicit input/topology decision;
  an upsampled operator timing below does not validate this as the application.
- **TimeMachine:** HTTPS source
  `https://d2l-data.s3-accelerate.amazonaws.com/timemachine.txt` was accessible;
  178,979 bytes, SHA1 `090b5e7e70c295757f55df93cb0a180b9691891a` matches the
  notebook, SHA256 `8424dbd9532ac81f7e5f0b6add90e6952baea29158309d7d1bf3884f4e12c516`.
  Acquisition initially checked bytes in memory; the actual probe now caches the
  same verified file outside Git. The source removes nonletters,
  lowercases and concatenates lines; its text stream, alphabet and boundaries
  need a frozen declared preprocessing/split. It defaults to the first 10,000
  tokens and constructs vocabulary on the full processed text. Choose a declared
  vocabulary and held-out split before fitting; do not randomly split overlapping
  context windows or report training perplexity as generalization. The probe
  declares lowercase ASCII plus space and an unused `<unk>` slot, then takes
  **first20,000 train / next5,000 validation / next5,000 test characters** from
  the processed stream. It resets state at each split, carries state only within
  that split, and detaches training state every35 steps.
- **Names:** L02's already cached pinned file exists at
  `/tmp/pml-l02-bigram/names-8f79bd0126eaef5eb82d346c9f85ae20ea1c476a.txt`:
  228,145 bytes, SHA256 `0a30b5557f192f32ab962680889aac5f6fda0f4cecf40a6d0b5694f58ea8cc4d`.
  The accepted L02 result at **`22ecb91`** uses 32,033 names with explicit start/END,
  raw count MLE, in-sample scoring and true categorical generation. It does not
  establish a held-out neural benchmark. Pair A returns to this **method**, not
  the same corpus. A supplied TimeMachine count comparator needs its own declared
  alphabet/boundaries and fixed smoothing/interpolation to avoid infinite held-out
  log loss on unseen transitions; label that new evaluation convention rather
  than pretending it is the unchanged unsmoothed L02 estimator. No smoothing search
  or new student estimator project is needed.
- **Boston lagged temperature:** source CSV is locally available, 109,381 bytes,
  SHA256 `2850068ebd205d1518b5608e07fd01ec4065022638fbb98f31454f66922f7ea2`.
  It supplies `TAVG` plus twelve lags. Its availability does not make that
  conditional-regression problem equivalent to the chosen character task.
- **Housing:** `fetch_california_housing` needs an unverified network/cache route;
  the inspected local sklearn cache contains Olivetti faces, not an established
  California-housing copy. It is not needed for Pair A.

## Two focused computational spines and checks

These are proposed scope/handoff endpoints, not a question sequence or a coding
assignment. Prepared calls and supplied checkpoints are compatible with genuine
mathematical/technical work.

**I — local learned representations parameterize a categorical prediction.**
Starting from L05 logits `Wx+b`, work through a learned composition
`p_theta(y|x)=softmax(W h_theta(x)+b)`. Use the CNN's repeated local kernel to
express a structural assumption, count shared parameters and trace receptive
fields/activations for a selected image. Call the prepared model/driver and
compare held-out log score, error/confusion and one specified shift/feature
manipulation against supplied affine/MLP results on the **same** split.
Convolutional feature maps are translation-equivariant only under the appropriate
stride/padding/interior assumptions; pooling, finite boundaries and a dense head
do not establish general classifier invariance. Parameter sharing saves parameters
relative to a fully connected local mapping; it does not guarantee lower runtime
or higher accuracy. A deliberately small fixed pixel permutation can expose the
locality assumption, but only if it replaces another comparison rather than
creating a second independent training project. A single fixed weight fit gives
conditional class probabilities, not posterior uncertainty over weights.

**II — context is a learned computational state, not an unobserved Markov cause.**
Use

$$
 h_t=\tanh(W_x x_t+W_h h_{t-1}+b_h),\qquad
 p_theta(y_{t+1}|y_{1:t})=\operatorname{softmax}(W_o h_t+b_o).
$$

The RNN hidden state is deterministic given the prefix and fixed parameters,
unlike L08's uncertain hidden-state model. Trace one or two recurrence steps and
how the categorical loss accumulates; map them to native `nn.RNN`, then call the
prepared scoring/generation driver. On one fixed held-out split compare the count
baseline and selected trained RNN by mean next-character NLL/perplexity, using the
same scored tokens and context information. Compare two prefixes ending in the
same character but with different earlier context to expose what a bigram cannot
use. Explain teacher-forced scoring versus free-running categorical generation;
greedy text is a separate decoding rule and visually pleasant output is not the
performance metric. Supply loader, state resets/detachment, checkpoint and scores;
a bounded update exposes training without asking for convergence or writing an
entire recurrent engine. Split/block handling must prevent hidden-state leakage
across unrelated held-out segments.

Attention's complementary worked mechanism is

$$
 \operatorname{softmax}(QK^T/\sqrt{d_k}+M)V,
$$

with `M` forbidding future/padded positions as appropriate. Compare retained
recurrent state with direct retrieval from stored contextual representations,
including serial recurrence versus quadratic full-attention score storage for a
length-T sequence. These are conditional cost/representation comparisons, not a
proof that either method is universally faster or more accurate. The toy source's
padding mask is not evidence of a correctly trained causal model. Do not add a
transformer fit merely to attach a modern name to the notebook.

The approximate **60-minute** responsibility envelope for each is orientation and
one linked mathematical/shape trace, a prepared call/bounded update, then
same-task output checks and interpretation. This protects a single spine with
integrated theory and computation. It is not a validated minute-by-minute schedule;
full source training loops, implementation of all primitives and multiple fresh
student fits are outside that plausible hour. Source/checkpoint preparation is
author work. Later timing must include actual learner reasoning and result
inspection, not simply the driver execution time.

## Surrounding contracts and student state

Read accepted L02 worked result **22ecb91**, L09 Challenger application/scope
**39dd5dc**, and L12 city direction/scope **80b047e**, not just the older maps.
L09 accepts the 23-flight thermal-distress model; its diagonal-student/full-supplied
VI split is still provisional. Neither proposed neural notebook requires an MCMC
algorithm or substitutes a point network for that weight posterior. L09's ELBO/
pathwise work supports later VAE training; it is not already practical competence
in recurrent or convolutional architectures.

L12 retains the city preference and its accepted zero replacement, reconstruction
versus full prior generation and model-criticism endpoint. Do not silently replace
it by an MNIST VAE because the preceding notebook uses images. Two neural
notebooks can supply composition, distributional outputs, shared parameters,
conditional scoring and point-fit-versus-posterior distinctions. They do **not**
by themselves teach the Gaussian encoder/decoder scale convention, joint ELBO
optimization or the rate-versus-mutual-information decomposition. A bounded
Gaussian-output mathematical example in the lectures can prepare those heads
without retaining the entire old heteroskedastic notebook as a third fit.

- **Assume familiar:** probability, categorical/Gaussian likelihoods, matrix
  operations and the declared L01 background.
- **Previously encountered — scaffold when needed:** planned L05 Torch tensor/
  loss/backward/update loop; L02 count transitions/scoring/generation; L09 sampled
  objectives and probability-family interpretation. These future commitments are
  preparation, not delivered or fluent knowledge.
- **New in these notebooks:** channel/spatial axes, weight-sharing/receptive-field
  calculations, source model/eval mode and learned-feature inspection; recurrent
  batch/time/state axes, state reset/detach, teacher forcing and categorical decoding;
  contextual causal masking if worked. Supply data/driver/checkpoint plumbing.

## Actual runtime evidence and its limits

The existing repository uv Python imports Torch **2.14.0+cpu**, NumPy **2.0.2** and
sklearn **1.9.1**, Python **3.12.13**, CUDA unavailable. Import inspection finds
**no torchvision, TensorFlow or pandas**. Requests is available. No `uv sync`,
installation or dependency/lock change was performed. Current native behavior was
checked against official [RNN](https://docs.pytorch.org/docs/2.14/generated/torch.nn.RNN.html),
[Conv2d](https://docs.pytorch.org/docs/2.14/generated/torch.nn.Conv2d.html), and
[scaled-dot-product attention](https://docs.pytorch.org/docs/2.14/generated/torch.nn.functional.scaled_dot_product_attention.html)
references; attention boolean-mask conventions must be checked for the chosen API
rather than transferred between APIs by intuition. The available
[sklearn digits](https://scikit-learn.org/stable/modules/generated/sklearn.datasets.load_digits.html)
loader was executed, establishing its local dimensions/range above.

The authorized actual-data probe uses fixed configurations decided before its
results were read. Its source adaptations are explicit: the LeNet topology keeps
its two convolutions/average pools/dense sizes but uses ReLU instead of sigmoid;
all image models use a supplied Adam `.001` driver, 25epochs and best validation
NLL checkpoint. The small MLP has one64-unit hidden layer; the affine model
supplies the fixed-feature comparator. There is no architecture/optimizer search
or repeated fit after inspecting test results.

| Actual Fashion-MNIST model | Parameters | Best validation epoch | Test NLL | Test accuracy | Fit time, one CPU thread |
|---|---:|---:|---:|---:|---:|
| Affine logits | 7,850 | 25 | `.528914` | `.8205` | `.410s` |
| 64-unit MLP | 50,890 | 25 | `.491203` | `.8315` | `.688s` |
| LeNet-shaped ReLU CNN | 61,706 | 24 | `.492644` | `.8130` | `9.924s` |

The MLP and CNN have similar NLL; the CNN is slower and has more parameters in
this particular comparison. Sharing is still a precise structural constraint
relative to an unshared local map, and its scalar computation/equivariance can
be checked directly. This pilot does not establish that the chosen CNN is the
best model for the split or the low-data budget. A source-backed lesson can
interpret that limitation alongside the representation mathematics. No claim of
universal accuracy, parameter or compute advantage is supported.

For TimeMachine the native source wrapper is retained with **H64** rather than
H256: **7,836 parameters**, batch32, unroll35, SGD1 and norm clipping1. The fixed
budget is200epochs, validation everyten; best validation checkpoint is epoch40.
Fitting plus validation took **5.719s** locally, excluding imports/acquisition.
Test was scored after selection, on the same4,999 transitions for both methods.

| Actual TimeMachine method | Test mean NLL | Perplexity |
|---|---:|---:|
| Count conditional with fixed additive alpha `.1` | `2.377625` | `10.779274` |
| Selected character RNN | `2.175432` | `8.805991` |

The unsmoothed count MLE gives zero support to **17** test transitions and thus
infinite mean NLL. Its finite smoothed comparator is explicitly a new evaluation
convention, not falsely reported as raw L02 MLE. Alpha was fixed, not selected
on test or searched. This is one chronological text slice and one neural seed,
not a general language-model benchmark. Perplexity improvement does not make
free-running prose fluent: the actual sampled continuation contains malformed
words, and greedy decoding repeats `...said the machen the time traveller...`.
Both behaviors are retained in the result as concrete interpretation material.

Direct mathematical checks from the same author run:

```text
CNN selected scalar cross-correlation vs package: max error 0
CNN first-layer interior shift equivariance: max error 0
cross entropy vs mean selected negative log-softmax: error 0
categorical probability row sum: error 1.79e-7 (float32)
whole CNN classifier shift: max probability change .034596 (not invariant)
RNN two-step manual/native recurrence: max error 1.78e-15 (float64)
same-last-character/different-prefix RNN: max probability difference .260772
same-last-character bigram: difference 0
causal attention manual/native: max error 8.89e-16
changing future Q/K/V: earlier causal outputs unchanged (error 0)
```

These validate a scalar convolution against the trained kernel, the two actual
PyTorch recurrent biases, causal-mask visibility and probability/loss semantics.
The attention calculation is a worked operator example, **not a trained transformer**.
No hidden layer is claimed to be a Bayesian latent posterior. The scalar/shift
check uses fixed test inputs after fitting and does not select or retune a model.

Reproduce with the existing course environment, without dependency changes:

```bash
/home/opher/Repositories/ProbabilisticMachineLearning/.venv/bin/python -B \
  Lectures/deep_networks_revision/notebook_feasibility/probe.py
```

The cache is outside Git; the script verifies source dataset MD5/SHA1 on every
run and records SHA256/tensor/subset identities. It regenerates only its owned
results/checkpoints. Raw Fashion files are not committed. Teacher checkpoints
`fashion_affine.pt`, `fashion_mlp.pt`, `fashion_cnn.pt` and `timemachine_rnn.pt`
are small state-dictionary artifacts, enabling a future prepared driver without
repeated classroom fitting. A second clean Python process reloaded all four
artifacts with `torch.load(..., weights_only=True)` and strictly loaded each state
dictionary into its declared model; the recorded native output shapes were:

```text
reload affine (2, 10)
reload mlp (2, 10)
reload cnn (2, 10)
reload rnn (3, 28) (1, 1, 64)
PASS four checkpoint weights_only reload and native shape checks
```

This is source-adapted worked evidence, not execution
of the unchanged Oke/pyprobml notebooks. One local fit is not a student timing
trial, distribution-shift guarantee or hosted Colab pass.

The previous heteroskedastic course probe remains separate exact evidence at
Git commit `0bdda8e`, path `Lectures/L11_Neural_Prediction/notebook_feasibility/`:
its course-constructed 130-parameter two-head model fits in about .28–.31s per
800 steps in its recorded one-thread run. That is useful Pair B feasibility, not
newly reproduced here and not a reason to shrink Chapter 16 to that example.

## Focused book route and next author work

Murphy, *Probabilistic Machine Learning: Advanced Topics*, online December 10,
2025, is primary: §16.1 **Introduction** (p.631) supplies networks as model and
inference components; §§16.2.1–16.2.3 **Linear layers / Nonlinearities /
Convolutional layers** (pp.632–635) and §16.3.1 **Multilayer perceptrons** /
§16.3.2 **Convolutional neural networks** (pp.641–642) support the image argument;
§16.2.7 **Attention layers** (pp.637–639), §16.2.8 **Recurrent layers** (p.639),
§16.3.4 **Recurrent neural networks** and §16.3.5 **Transformers** (pp.645–646)
support contextual computation. These are selective arguments, not a requirement
to turn every intervening layer family into an exercise. Book 1 Chapter14/15
provide the fuller practical source context when needed.

Next work, once the paired scope contract selects the route: use this frozen
image subset/loader, baselines/checkpoints and RNN/count evidence to assemble the
coherent teacher walkthrough; review exact scoring/visibility and the retained
model-comparison workload, preserve the CNN limitation, then run the resulting
notebook solutions cleanly locally and on hosted Colab before pedagogy production.
No repeat dataset or architecture search is needed to establish the bounded
computational foundation. Keep
all arbitrary setup and expensive repeated fitting supplied. No new experiment
catalogue, architecture search, new dataset or environment change is requested by
this report. The actual early evidence was exchanged with the contract owner;
this source report is input to scope decisions, not approval of a full Scope or
of final student notebooks.
