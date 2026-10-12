# L10 source-arc review — Monte Carlo integration, valid Markov transitions and useful samples

**Review mode:** same-context source-arc comparison; no independent agent, no changes to lecture scope. **Primary sources:** Murphy Book 2 Chapters 11, *Monte Carlo methods*, and 12, *Markov chain Monte Carlo*.

## 1. Reconstruct Murphy's development

**Chapter 11** begins with the numerical question `E_p[g(X)]`: why represent an integral by sampled values? It establishes estimator accuracy and why independent draws from a target may be hard to obtain; rejection sampling, importance weighting and variance reduction are alternative mechanisms for making Monte Carlo work.

**Chapter 12** then identifies the higher-dimensional problem: direct/independent target sampling is frequently impractical, so construct a transition whose *stationary distribution* is the desired target. The source moves from Metropolis–Hastings (general proposal correction, §12.2) to conditional-coordinate Gibbs updates (§12.3), auxiliary methods (§12.4), geometry-informed HMC (§12.5), and the independent issue of convergence/mixing (§12.6), with later specialist extensions. The argument is **approximate an integral with draws → construct valid dependent draws → improve their exploration → evaluate estimator error**. Validity, mixing and the numerical *query* are separate parts of the same story.

## 2. Scope's chosen line

The [L10 scope](../../L10_MCMC/lecture_scope.md) first derives independent Monte Carlo variance, then distinguishes invariance/detailed balance from convergence speed, derives the general Hastings correction and explains rejected repeated states, recognizes Gibbs and HMC, and finally derives dependent-estimator variance and explains query-specific ESS. The notebook implements a NumPy MH sampler on a bimodal target and compares proposal scales and dispersed starts against known expectations.

This is **substantively faithful** to the core Chapters 11–12 progression, despite omitting important other samplers. It is *not* merely an MH recipe: estimator error and chain validity are distinct central themes, and conditional-update Gibbs has a different source of valid transitions.

## 3. Fidelity, deviation and stakes

**Verdict: faithful selective arc with a potentially consequential breadth cut.** The source trajectory survives well until §12.5. HMC, however, is only five minutes' recognition even though students have prior practical experience using NUTS and Murphy devotes an important, separate family of methods to exploiting gradients in parameter space. Students may graduate understanding an elementary random-walk sampler's correctness better than they understand the central technique in their familiar scientific software.

This is **not automatically a source-arc failure**: the conceptual *claim* that better proposals exploit geometry can be taught by contrast without deriving leapfrog integrators. But the scope should make that question an explicit turn in the argument instead of an appended “name HMC” at the end. Similarly, independent proposal methods (§§11.4–11.5) are only mentioned, which is legitimate if the students understand what direct independent sampling would buy and why the selected problem warrants a chain.

There is also an ordering issue: the scope front-loads stationarity, irreducibility, aperiodicity and continuous Harris-recurrence recognition *before* the main MH construction. The mathematical statements may be correct, but that ordering risks a long abstract detour without answering the chapter's main computational question.

## 4. Minimum arc repair

Preserve the exact MH derivation, stationary-versus-finite-run distinction, and multimodal notebook. Make the motivating dilemma explicit: *we can approximate expectations using independent samples, but what if the only tractable procedure is a dependent sequence?* Introduce MH construction soon after defining stationary target and detailed balance. Develop the finer convergence qualifications and query-dependent ESS **after** students have seen what the sampler actually does, unless a compelling didactic reason favors the current order.

Make a short **proposal-design comparison** do intellectual work: random-walk proposals depend on local scale; Gibbs leverages conditional structure; HMC leverages gradients and extended-state dynamics. At recognition depth this can explain *why newer samplers exist* without claiming the HMC mechanics have been taught thoroughly. If a genuine HMC derivation is an instructor goal, it requires a conscious replacement of part of the chain-conditions or ESS proof, **not** an unbudgeted extra topic.

## 5. Value, extent and course placement

L10 is close to Murphy's organizing question, but the distribution of mathematical time could be refined. Its ~110 live minutes and one-hour lab are tight; a stronger story may actually **reduce** load by subordinating theorem vocabulary to the sampler's use. Protect the important contrast with L09: VI chooses a tractable *distribution*, MCMC aims to produce draws from the *target* but must confront finite mixing and estimator uncertainty.

Explicit omissions remain acceptable: rejection/importance-sampling implementations, full HMC/NUTS integration, tempering and specialized samplers. Do not present a five-minute HMC reference as comprehensive coverage of §12.5.

**Disposition:** source spine largely preserved. **Recommend modest arc/sequence refinement**, and flag HMC depth as an instructor-level tradeoff rather than an automatic missing-chapter checklist.