# L11 — Context, memory and attention

**Status:** Author-built five-part Scope under the instructor's accepted two-lecture deep-network mandate, 2026-10-16; a separate Section Design/source-arc preview returned **feasible with advisory risks**, with required acceptance and downstream validation still outstanding. This replaces the former L11's single heteroskedastic-regression purpose. Architectural revision is approved; this detailed Scope is not yet instructor-approved or downstream-validated. See the [development register](development_state.md), paired [L10 Scope](../L10_Deep_Networks_I/lecture_scope.md) and [sequence contract](../deep_networks_revision/sequence_contract.md). No executed student artifact or measured learner time is claimed.

**Central teaching choice:** Develop representations that depend on context through a discrete-sequence prediction task. Recurrent state and attention are different mechanisms for conveying information, with mathematical/computational consequences. Use one source-backed character RNN notebook; work attention substantially in the lecture without appending another architecture-training notebook. This is not a survey of named sequence architectures.

## 1. Intellectual arc

### Starting boundary and source argument

L02 supplies categorical counts, conditional next-character probabilities and learned first-order Markov sequence generation. L05 supplies logits, likelihood gradients and PyTorch; L10 supplies learned composition, sharing, matrix/feature shapes, residual-path and probabilistic-output meanings. L08's HMM is a random-state model with exact posterior messages; a deterministic recurrent representation is a different mathematical object. L09 supplies the variational objective/pathwise derivative and the abstract purpose of a shared inference map. None implies independent fluency with recurrent batching or attention APIs.

Murphy B2 §16.2.7/§16.2.8 describes input-dependent attention and stateful computation, then §§16.3.4–16.3.5 relates them to sequence models. B1 Ch.15 supplies the autoregressive likelihood, recurrence/training details, differentiable lookup and positional information. The selected arc develops a task requiring an interpretable representation of prefix context, then compares compression into a state with direct query-dependent retrieval. L12 applies a neural map to per-case inference; it does not inherit a second language-model implementation.

**Learning problem:** assign probabilities to characters/sequences and generate continuations from text experience. A bigram count table ignores all but the immediately previous observed character. Longer count tables grow rapidly and do not naturally share patterns across contexts. A neural context representation trades structural bias, parameter reuse, data requirements and computation. Held-out token log score is the principal comparison; plausible-looking continuations alone do not establish predictive performance.

### A. Replace a short observed context by a learned state — 30 minutes

**Transition in:** L02's model already defines a valid sequence probability. The task now exposes a restriction of its context representation, rather than a defect in probability factorization.

**Question:** how can reusable learned features depend on a prefix? **Sources:** B2 §§16.2.8/16.3.4, pp.639, 645; B1 §15.2.1, pp.503–505/§15.2.4 pp.509–510; L02 model carried forward.

Derive the autoregressive likelihood and work one recurrent update/logit/next-character distribution. Explain parameter sharing over time and distinguish context representation from output law. Compare observed-state first-order Markov dependence with a recurrent hidden summary of an entire prefix. This does not guarantee indefinite effective memory. Distinguish teacher-forced scoring of an observed sequence from feeding generated characters back into the model. Locate all randomness: in this model the state update is deterministic and the output draw is stochastic.

**Retrospective summary:** The same categorical likelihood can use a learned prefix representation. Recurrence shares a state update across time; scoring observed sequences and generating new ones use different inputs to that update.

### B. Differentiate through shared temporal computation — 20 minutes

**Transition in:** A recurrent probability law is useful only if its repeated parameters can be trained and its context limitations understood.

**Question:** how do gradient paths and state handling change? **Sources:** B1 §§15.2.5–15.2.6 pp.510–512, with source caution below; reuse L05 AD/L10 shared parameters. B2 §16.2.4 residual role recalled only.

Work a short reverse-time adjoint recurrence and sum gradient contributions to the shared state matrix. Explain products of Jacobians and long-range sensitivity, without a general RNN convergence theorem. State clipping and the idea of gating; do not derive LSTM/GRU equations. A supplied driver may truncate gradient history while carrying a state; that is not an exact full-sequence gradient. Explain reset at independent sequences and prevent evaluation from accidentally consuming future/test information. Practical batching/detachment code is supplied, not a software exercise.

**Retrospective summary:** Reverse-mode differentiation reuses the unrolled numerical graph, with contributions from each use of shared weights. Long dependency paths and truncation affect what can be learned; a recurrent architecture is not a guarantee of effective long memory.

### C. Retrieve relevant context with attention — 30 minutes

**Transition in:** A fixed state compresses prefix information through repeated updates. A different computational structure can retain positions and retrieve a combination for each query.

**Question:** how does a network select information using the current context? **Sources:** B2 §16.2.7 pp.637–639/§16.3.5 pp.645–646; B1 §§15.4.1/15.4.3 pp.519–522, §§15.5.1–15.5.3 pp.526–529.

Derive normalized query-key scores and work a small retrieved value. Write row-wise matrix attention with explicit dimensions. Show a causal mask excludes unavailable future positions; compare legitimate next-token prediction with accidental target leakage. Explain keys, queries, values and learned projections versus dynamically changing attention weights. Work why unpositioned, unmasked self-attention is permutation equivariant, and explain how position information supplies order. State multiple heads as differently projected retrievals, not an unexplained source of extra predictive power. No full positional-sinusoid derivation or multihead parameter calculus.

**Retrospective summary:** Attention forms input-dependent combinations of stored values. Its mask and position information determine what context is available and how order can influence the representation.

### D. Choose a computational structure for the required context — 12 minutes

**Transition in:** Recurrent compression and attention retrieval answer a related representation problem with different computational commitments.

**Question:** which tradeoffs matter for this data/query/scale? **Sources:** B1 §§15.5.4–15.5.5 pp.529–532; B2 §16.3.5 pp.645–646; L10 convolution carried forward.

Compare local receptive fields, sequential recurrent state and dense attention's context interactions. State operation/storage orders in a fixed-width regime and distinguish training parallelism from autoregressive deployment/caching. Locate attention, residual/normalization and position-wise MLP blocks in a transformer without teaching a second model-fitting pipeline. Interpret an RNN/bigram held-out comparison and its limitations; do not manufacture a claim that one small corpus proves a universal architectural ranking. A more elaborate architecture can fail to earn its cost.

**Retrospective summary:** Architecture determines information paths, parameter sharing and resource costs. The choice depends on needed context and data/compute limits; greater expressiveness alone does not select a winner.

### E. Distinguish model networks from inference networks — 8 minutes

**Transition in:** We have used numerical maps to define conditional probabilities. L09's shared inference map gives the same machinery a different role.

**Question:** what changes when the network helps answer an inference query? **Sources:** B2 §16.1 p.631/§10.1.5 p.445; L09's revised shared-map explanation.

Contrast parameters of `p_theta(y|x)` with parameters of `q_phi(z|x)` approximating a specified posterior. The joint model can be non-neural. Explain training versus repeated-query saving and possible approximation/fitting error. A representation may be deterministic while defining the parameters of a random variable's distribution. Do not train an encoder or derive the VAE objective here.

**Retrospective summary:** Neural computation can construct a probability model or approximate an inference operation. Its role comes from the specified model/query and objective, not from the network's name or shape.

**Extent:** 100 substantive +12 reserve = **112 live minutes**, plus **60 notebook minutes**. Tight and unmeasured. These are macro responsibilities, not a section partition. First remove gating recognition beyond its purpose, repeated generation examples and transformer-family history; protect one recurrent/probability calculation, one backward/shared-weight calculation, worked masked attention and the role distinction. No required recording or extra transformer lab. Use actual feature/derivation workload in downstream timing; L01's provisional slide calibration does not establish the pace of new sequence notation.

**Alternatives evaluated:** A full transformer language-model lab would require another implementation/data/checkpoint chain beyond the source's current readiness. A recurrent-only lecture would give a useful application but insufficient attention to modern input-dependent context computation. A CNN/RNN/transformer catalogue loses the shared question and worked mathematics. The selected one-RNN application plus substantial attention comparison preserves both depth and informed selection.

## 2. Mathematical spine

Use y_t for a character, e(y_t) for its one-hot vector or declared embedding, h_t for a deterministic state and θ for point-fitted model parameters. T is sequence length, B a batch size and V vocabulary size; B_x denotes the input-weight matrix. z is reserved for the unknown in the inference-network comparison. Natural-log sequence NLL is normalized by the stated number of predicted tokens, excluding any padding; do not silently change between sums and means.

| Object/result | Depth and role |
|---|---|
| `p(y_1:T)=product_t p(y_t\|y_<t)`; bigram uses `p(y_t\|y_(t-1))` | **Derive/work**, A; chain rule versus first-order restriction. Scoring/generation are different queries/operations on the same model. |
| `a_t=A h_(t-1)+B_x e(y_(t-1))+b`; `h_t=tanh(a_t)`; `o_t=C h_t+c`; `p_t=softmax(o_t)` | **Work/apply**, A; explicit shapes and shared parameters. Source package has two additive bias vectors, equivalent to one summed b for this mathematical expression. |
| `L=T^-1 sum_t -log p_t[y_t]`; perplexity `exp(L)` | **Derive/apply**, A/Notebook; token convention explicit; categorical gradient from L05 reused. |
| `delta_t=v_t+J_(t+1)^T delta_(t+1)`, `v_t=C^T(p_t-e(y_t))/T`, `J_(t+1)=diag(tanh'(a_(t+1)))A` | **Derive/work bounded**, B; delta is total derivative of L with respect to h_t. Terminal future contribution is zero. Reverse-time traversal, not a new independent forward sensitivity computation for every endpoint. |
| `partial L/partial A=sum_t [delta_t odot tanh'(a_t)] h_(t-1)^T` | **Apply/work**, B; all time uses contribute to shared parameters. Explain Jacobian-product sensitivity and truncated-history distinction, no spectral/mixing theorem. |
| `alpha_i(q)=softmax_i(q^T k_i/sqrt(d_k))`; `Attn=sum_i alpha_i v_i` | **Derive/work**, C; convex retrieval weights are not probabilities of a proved latent alignment. |
| `Q=XW_Q`, `K=XW_K`, `V=XW_V`; `H=rowsoftmax(QK^T/sqrt(d_k)+M)V` | **Work/apply**, C; declared matrix shapes, causal future-mask entries excluded. Stable mask/softmax implementation supplied. |
| Unmasked/unpositioned `Attn(PX)=P Attn(X)` for a position-permutation P | **Work/explain**, C using row-softmax equivariance; this is not invariance of each position or an order-aware model. Mask/positions change the regime of this identity. |
| Dense attention `O(T²d+Td²)` work, `O(T²)` attention storage; fixed-width recurrent `O(Td²)` work | **State/compare**, D; exclude constant factors and input/vocabulary projections when using the simplified orders. State sequential dependency and cache/context qualifications. |
| Model `p_theta(y\|x)` versus inference `q_phi(z\|x)=Q(z;r_phi(x))` | **State/explain**, E; q approximates a specified posterior and need not define the joint model. No parameter-posterior claim from fitted neural weights. |

Validity is appropriate context/order/causality assumptions with informative training text. Computational payoff is learned parameter reuse instead of independent context tables, with differing memory/information paths across architectures. Task error is held-out token probability and continuation behavior. Neither a lower training loss nor an attractive text sample establishes effective long-range dependence or out-of-domain language ability.

## 3. Notebook handoff

**Anchor:** actual pinned pyprobml `notebooks/book1/15/rnn_torch.ipynb`, Time Machine character language model. Reuse its recurrence/package workflow, not its entire scratch implementation or 500-epoch training sequence. Returning L02's bigram estimator on this corpus is method transfer, not reuse of its names dataset.

**Lecture has established:** sequence likelihood, recurrent state meaning, shared weights/unrolled differentiation, teacher forcing, output sampling versus scoring, and a worked attention alternative.

**Computational argument:** **prefix → deterministic context state → next-token probability → sequence score → generated continuation and held-out judgment**. The solved Q&A develops mathematical, technical and interpretive understanding in linked small steps. Supply source loading/normalization, vocabulary, boundary-aware split, fixed smoothed bigram baseline, reset/detachment utilities, model wrapper, optimizer and verified checkpoints. No independent general text-data loader, RNN loop or optimizer assignment is implied.

Students follow one recurrent state update and relate it to `nn.RNN` output; predict how two different prefixes can alter next-character probabilities; inspect selected sequence NLL terms; make bounded prepared updates; compare held-out log score with the supplied count baseline; then distinguish a categorical continuation from source-style argmax decoding. This is one model-training encounter. An additional attention lookup activity belongs only if it replaces another task and fits the measured hour; no transformer fitting.

The source uses one-hot input reshaped `(T,B,V)` and flattens recurrent outputs for the categorical loss. Introduce those shapes locally rather than assume new tensor axes are trivial. Its source hidden size256 is not a course requirement: a bounded validated smaller configuration may be selected with the adaptation labeled. Training-only vocabulary or a fixed declared alphabet and explicit unknown-token handling must prevent look-ahead. A smoothed count baseline is a supplied evaluation convention; raw L02 count MLE can assign zero held-out probability, and must not silently be renamed as the smoothed estimator.

**60-minute planning allocation:** 10 task/split/shape refresh; 20 linked recurrence/likelihood reasoning; 10 bounded updates/checkpoint checks; 15 held-out comparison and generation interpretation; 5 reserve. Prepared checkpoints preserve substantive interpretation if short updates are not enough to learn the task. They do not make short student training a convergence claim. Default to existing software after explaining the operation, then check whether its output makes sense.

**Author gates:** fix the source generation18 argmax/sampling distinction; add a true held-out split and perplexity (source reports training performance); reset/carry/detach state according to actual independent/contiguous sequences; prevent windows crossing split boundaries and evaluation from receiving future targets. Freeze baseline smoothing, vocabulary, model capacity and selection budget before viewing final test performance. Validate checkpoint reproducibility and generation/scoring semantics, then solved/student notebooks, actual learner workload, local uv and hosted Colab. Cheap update timings are not a complete fit or notebook validation. No improvement over bigram or long-memory success is promised without evidence.

## 4. Concrete examples and source records

- **Bigram versus prefix-dependent prediction, Work/Live:** reuse L02's probability factorization/count estimator. The Time Machine corpus is a new domain, with the evaluation convention supplied explicitly.
- **Short recurrent trace, Work/Live and notebook:** source recurrence cell12 supplies the numerical structure; package cell36 wraps `nn.RNN`. Use actual declared parameter values/dimensions when building the worked solution, not attributed invented source outputs.
- **Short shared-weight backward calculation, Work/Live:** course elaboration of B1 §15.2.5, not a full RNN framework or convergence proof. Standard reverse-mode BPTT is not necessarily quadratic in T; the source's expanded forward-sensitivity discussion must not be copied as that claim.
- **One query/key/value and a causal mask, Work/Live:** B2 §16.2.7/B1 §15.4.1 provides the operation. Course authors choose and verify small numbers; until then no exact weight values or source-figure edge claims are committed.
- **Permutation/order comparison, Work/Live:** course algebra supporting the source's positional discussion. Correct B1's loose invariance wording; source B2's sentence about chaining attention layers is not the definition of self-attention. Self-attention derives Q,K,V from the same sequence representation.
- **Time Machine inference/generation, Work/Notebook, Compare/Live:** measured held-out scoring and categorical/greedy continuations; no externally validated language-quality claim.

**Focused sources:** Murphy B2 online **December 10, 2025**, §16.2.7 **Attention layers**, pp.637–639; §16.2.8 **Recurrent layers**, p.639; §16.3.4 **Recurrent neural networks (RNNs)**, p.645; §16.3.5 **Transformers**, pp.645–646; §16.1 **Introduction**, p.631 for roles. B1 online **April 18, 2025**, §15.2.1 **Vec2Seq (sequence generation)** pp.503–505, §§15.2.4–15.2.6 **Teacher forcing / Backpropagation through time / Vanishing and exploding gradients**, pp.509–512; §15.4.1 **Attention as soft dictionary lookup** pp.519–520, §15.4.3 **Parametric attention** pp.521–522; selected §§15.5.1–15.5.5 pp.526–532. Read for context paths, likelihood and data dependence, not a catalogue to reproduce.

**Exact computational source:** pyprobml checkout `d1ea4122dcf3c2a2c02eb4e05343203b26440827`; `notebooks/book1/15/rnn_torch.ipynb`, SHA-256 `8177d1fc9d2d7169ff7c2486f0e68d11b14e2887ce8072b384ac796a80200613`; directly inspected corpus5–8, scratch12, generation18, drivers25/27, package32/36 and 500-epoch call40. Source corpus declares SHA1 `090b5e7e70c295757f55df93cb0a180b9691891a`; the separate source specialist verified its accessible bytes, SHA-256 `8424dbd9532ac81f7e5f0b6add90e6952baea29158309d7d1bf3884f4e12c516`. Original HTTP download/interface is not silently a course-runtime guarantee. Source inspection/operator evidence is separate from final course runs.

## 5. Lecture contract

**Start:** categorical sequence modeling from L02, L05 differentiation/PyTorch, L10 learned composition/sharing, L09's abstract inference-map purpose. **Question:** how should a learned representation retain and retrieve sequence context for probability prediction? **Live endpoint:** derive/work recurrent likelihood and shared temporal computation, work causal attention and order, compare computational structures, and explain neural model versus inference roles. **Notebook endpoint:** one guided character-RNN scoring/generation workflow against a supplied count baseline. **Delivery:**112 live +60 notebook minutes; no required recording.

Students can interpret context states, score sequences, distinguish teacher forcing and generation, work a masked retrieval and select architectures with stated context/cost limitations. They do not gain a full transformer implementation, a modern LLM training toolkit, LSTM/GRU gate expertise, posterior uncertainty over network parameters or a general long-memory guarantee. Graph/hypernetwork/implicit-layer catalogues, attention-visualization explanations of causality, Bayesian nonparametrics and extra architecture searches are omitted. L12 receives neural distribution-parameterization and inference-map understanding; it owns the VAE model/objective and random latent codes.

**Next owner:** bounded independent feasibility/source-arc review, coordinator disposition and required acceptance before Section Design. Preserve retrospective section summaries and put connections at receiving beginnings. If actual notation/workload makes the two worked mechanisms infeasible, report the specific contract pressure rather than reduce the lecture to an architecture list or add an unbudgeted second notebook.
