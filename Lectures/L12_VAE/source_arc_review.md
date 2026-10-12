# L12 source-arc review — deep generative modeling, amortized inference and information rate

**Review mode:** source-arc comparison in this ChatGPT context, not an independent specialist thread; source lecture unchanged. **Sources:** Murphy Book 2 Chapter 21, *Variational autoencoders*, and selected §§5.4.2, 10.1.5.

## 1. Murphy's chapter argument

**Chapter 21 introduces a deep latent-variable generative model**: draw hidden `z`, use a neural decoder to parameterize an observation distribution `p_theta(x|z)`. Unlike an ordinary discriminative network, the generative task requires integration over latent z for both likelihood and posterior. That integration is generally intractable (§21.1). The VAE answer is to train an **amortized recognition/encoder distribution** `q_phi(z|x)` alongside the decoder, maximizing a variational lower bound (§21.2). This uses earlier chapters' graphical modeling, VI and differentiable stochastic optimization. §21.3 explores alternative objectives and representations, §21.4 explains uninformative codes/posterior collapse, and later sections expand latent structure and code types.

The central source development is **generative model → intractable posterior/marginal → shared variational inference → joint learning → objective/representation failure modes**. Rate-distortion/IB offers an interpretation of one penalty, but does not replace the probabilistic generative-model question.

## 2. Scope's arc

The [L12 scope](../../L12_VAE/lecture_scope.md) begins with a four-dimensional latent code for 19 standardized metropolitan features, distinguishes decoder from encoder and generation from reconstruction, obtains the event-summed Gaussian NLL and diagonal Normal prior KL, applies L09's reparameterization, and derives
`R=E_x KL(q_phi(z|x)||p(z))=I_q(X;Z)+KL(q_phi(z)||p(z))`.
It interprets beta, posterior collapse and nonidentifiability, with a compact mobility VAE notebook and controlled beta comparisons.

These are serious probabilistic commitments. In particular, insisting that rate is **not simply MI**, and that code features are not automatically identified causal factors, makes the information-theory return responsible rather than decorative.

## 3. Fidelity and deliberate departures

**Judgment: justified selective synthesis, source arc retained.** The basic Chapter 21 progression survives strongly, and linking to L04 §5.4.2 is a legitimate elective additional arc. The mathematical reuse from L06 bound, L09 random-gradient differentiation and L11 neural conditional distributions exemplifies what the course was designed to accomplish.

The main possible skew is that **rate-distortion becomes the climax while generative modeling is treated as a reconstruction exercise**. A VAE is not merely a stochastic dimensionality-reduction tool; `p_theta(x)=int p(z)p_theta(x|z) dz` is a generative model, so the decoder's prior-predictive samples, calibrated likelihood assumptions and learned data distribution matter. Reconstructed data `x→q(z|x)→p(x|z)` are drawn from a different path from generated data `z→p(x|z)`.

The scope states this distinction but the notebook focuses on encoder/decoder reconstructions and descriptive factors. If the lecture is intended to preserve *generative* ML rather than just representation-learning objectives, students should see one unambiguous **prior-generation example** and know its interpretive limitations, without an additional architecture or training run.

## 4. Smallest repair

Protect the initial latent-generative joint model and unknown-integral argument as the actual intellectual destination. Make the passage from **non-amortized VI (L09) to amortized inference (L12)** explicit: inference per input becomes a learned shared encoder, whose approximation quality depends both on family expressivity and network/optimization constraints. Then present the KL/rate decomposition as a critical **interpretation and limitation of learned codes** after the generative/inference roles are clear.

Add *one* bounded output in live explanation or supplied notebook visualization that compares **prior generation** with reconstructions. It need not be a second student training task. Preserve the expectation-over-q distortion definition, different beta convention from the original mobility source, held-out evaluation and prohibition on causal interpretations.

Do not add all of InfoVAE, supervised IB, hierarchical VAEs or actual file coding. Their source sections are intentionally omitted; their absence is not a gap in this selective route.

## 5. Feasibility / cross-course ownership

L12 is already tight (~112 live minutes plus a 60-minute lab). The prior-generation contrast should **replace** a secondary interpretation or optional collapse remedy rather than expand the lecture. For a tabular Gaussian decoder, recognize that generating plausible standardized vectors is not the same as physically valid urban measurements.

**Disposition:** strong source-arc match, **small generative-versus-reconstructive emphasis repair recommended**; no broad rebuild or new subsection obligations. An additional empirical domain choice is an independent curriculum decision, not an arc-fidelity failure.