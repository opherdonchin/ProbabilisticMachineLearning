# L11 source-arc review — from differentiable circuits to expressive probabilistic models

**Review mode:** same-context source-arc review, not a separate Codex subagent; no modification of scope or skill. **Primary source:** Murphy Book 2 Chapter 16, *Deep neural networks*.

## 1. Murphy's organizing argument

**Chapter 16 begins by defining a neural network as a differentiable *computation graph***, not as heteroskedastic regression. Section 16.1 makes a two-way ML connection. First, networks can supply **expressive functions inside probabilistic distributions**—conditional predictors or components of a generative model. Second, networks can serve as **amortized inference mechanisms** to approximate posteriors even when the probabilistic model itself is not neural. Section 16.2 introduces composable differentiable building blocks; §16.3 exhibits architectural examples built from those blocks. The chapter ties these constructions back to Chapter 6 autodiff/optimization.

This is a coherent source argument: **compositional differentiable computations → flexible function families/architectures → use them both to model probabilities and to approximate inference**. The notion of compositional structure and reuse matters; it is not principally a taxonomy of architectures but neither is it just “replace a line by an MLP.”

## 2. Proposed lecture argument

The [L11 scope](lecture_scope.md) starts with linear predictors, shows that stacked affine maps collapse into one affine map without nonlinearities, constructs a shallow MLP and derives a Gaussian mean/positive-scale head and heteroskedastic NLL. It uses prior backprop to train, distinguishes aleatoric conditional noise from uncertainty in network weights, and derives a Gaussian-weight-prior penalty. A synthetic nonlinear Gaussian regression notebook fits the chosen network.

This is mathematically coherent and particularly suitable for a Bayesian-trained MSc cohort: it demonstrates what it means for a **neural model to parameterize a distribution**. It avoids repeating an Iris classification fit. But heteroskedastic noise and regularization occupy most of the planned live argument, whereas Murphy's broader question of differentiable architecture/representation is compressed to an early shallow-network step.

## 3. Fidelity and cost

**Verdict: substantial source-arc contraction; priority HIGH.** This is not a technically bad lecture; it is a strong **probabilistic regression lecture using one network**. It could leave the mistaken impression that deep learning's essential intellectual development is learning a nonlinear mean and variance, rather than learning complex *compositional functions* and reusable representations. The *second role* of neural networks in Murphy's introduction—as inference networks—is almost invisible until L12, where the encoder suddenly appears as a neural mechanism.

An architecture zoo is not the missing piece. The conceptual relation **compositional function class ↔ differentiability ↔ probabilistic parameterization ↔ amortized inference** is. A lecture can represent that without detailed CNN/Transformer algorithms. The current single hidden layer does not strongly demonstrate why *depth* or architecture matters, nor what changes across contexts (image, sequence, tabular) when we compose different blocks.

The prior/L2 penalty and aleatoric-versus-epistemic distinction are valuable scientific modeling themes, but their detailed derivations compete with explaining networks as generalized building blocks. They are not the main source argument of Chapter 16.

## 4. Recommended targeted change

Preserve the heteroskedastic lab; it is a strong genuine probabilistic skill. **Re-center the live arc**:
1. Begin with the construction of flexible differentiable maps from reusable blocks, relating layers, nonlinearities, parameters and graph-based backprop to L05.
2. Show that an expressive map can output the parameters of **any chosen conditional distribution** (categorical from L05, Gaussian mean/scale here): network architecture and observation model are two distinct design choices.
3. Develop the Gaussian NLL and two-head model as the full worked application; let this demonstrate rather than define probabilistic neural modeling.
4. State two roles of networks explicitly: `p_theta(y|x)` parameterization and `q_phi(z|x)` *inference-network* parameterization, where the latter is taken up in L12. Explain what “amortized” saves without doing the VAE proof.
5. End with a disciplined classification of what the chosen MLP does *not* establish: other architectures, parameter posterior uncertainty, out-of-distribution behavior.

This is a **reallocation of current live intellectual responsibilities**; to create room, move the full weight-decay/MAP scaling calculation to a short worked connection or an optional exercise, and trim lengthy noise-vs-weight-uncertainty discussion to a precise mathematical contrast. Do not add CNN, RNN and attention derivations in the same two-hour meeting.

## 5. Implications for course coherence

The deeper issue is a **weak bridge from L05 to L12**. Without explicit general neural-architecture and inference-network notions in L11, L12's amortized encoder looks like an arbitrary new gadget, not a natural application of §16.1's second route. Fixing this benefits the entire semester and restores a recognizable Murphy arc with no new notebook.

The live 112-minute estimate remains tight, particularly the detailed Gaussian variance-head gradients and interpretive diagnostics. Numerical PyTorch model training has not been tested. A genuine deep-network architecture survey or an L11 epistemic-uncertainty lecture would require an explicit alternative scope, not a small patch.

**Disposition:** **source-arc revision before section design strongly recommended**. This is a change in emphasis/argument, not simply a request to mention more Book 2 pages.