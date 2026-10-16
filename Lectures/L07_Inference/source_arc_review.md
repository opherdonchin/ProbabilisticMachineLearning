# L07 source-arc review — inference as a family of computational questions

**Review mode:** source-arc fidelity, same-context analysis, not an independent Codex agent; this file is review evidence and leaves the source scope unchanged. **Book:** Murphy Book 2, Chapter 7, *Inference algorithms: an overview* (December 10, 2025 edition).

## 1. Murphy's actual argument

The **opening of Chapter 7 (§7.1)** frames probabilistic ML as treating unknowns—predictions, hidden states and parameters—as random variables. The key computational obstruction is the *normalization/marginalization integral*, and even after obtaining the posterior we need distinct integrals for means, covariance, predictive distributions, expected losses and other queries. §7.2 distinguishes patterns of unknown variables (e.g. global parameters versus local hidden states). §7.3 explains when exact computation is possible; §7.4 maps major approximation strategies, including simple point estimates, Laplace, variational distributions, Monte Carlo and other methods; §7.5 asks how an approximate answer is checked.

Thus Chapter 7 is not principally a Laplace chapter. Its contribution is the **question/structure/computation taxonomy** that organizes the subsequent inference chapters. Laplace (§7.4.3) is one instance demonstrating the tradeoff between a tractable representation and the original posterior.

## 2. The scope's argument

The [proposed L07](lecture_scope.md) begins with different posterior queries (normalization, MAP, means and prediction), then makes grid quadrature honest about resolution and tails, derives scalar Laplace from Taylor curvature, and checks the approximation on one proper-prior logistic posterior. It handles parameterization dependence of density modes and prediction versus plug-in. The notebook asks students to construct and *challenge* a numerical reference, not merely fit a Gaussian.

This is good mathematical pedagogy. The selection is **locally coherent** and the calculation yields a distinctive skill. But about three quarters of the planned lecture arc runs toward one approximation and its limitations, while the methods it is supposed to contextualize (structured exact inference, VI, MCMC) appear only as names in the closure.

## 3. Arc fidelity

**Verdict: partial fidelity / structural contraction; priority HIGH.** A well-designed *Laplace lecture* has replaced much of Murphy's *inference-method overview* without making that curricular redefinition explicit. The student's mathematical depth in Laplace is a real gain, not an error. Yet the proposed subject title retains the broad promise of inference as computational method selection.

A scope that omits other methods' derivations can still preserve Murphy's arc if the **joint-model structure and query** visibly motivate how to choose the family of computational strategies. Presently the source-to-method transitions are compressed. Without an early worked contrast, L08–L10 may look like unrelated technical lectures rather than alternative answers to the same inference question. The scalar grid/Laplace example also under-represents §7.2's global/local hidden-variable distinction that becomes critical for EM, sequences and VAEs.

## 4. Recommended minimum architectural repair

Do not demand broad algorithm details or sacrifice the carefully checked Laplace notebook. Reserve a meaningful **opening intellectual movement** that contrasts at least three *questions/structures*: (i) a single global coefficient posterior requiring integration; (ii) a chain of local latent variables admitting dynamic programming (L08); and (iii) an otherwise intractable posterior to be approximated by q (L09) or samples (L10). State the integrals / sums rather than explain the downstream algorithms. Ask what output the method is meant to produce: point, marginal, joint path, expectation, predictive.

Then teach the same Laplace derivation as **a test case for the general approximation strategy**: replace an integrand by a local quadratic and check the impact on a specified query. End by returning to the taxonomy *retrospectively*: students now understand one approximation well, not all families.

This implies either trimming the mode-coordinate-change example or some extra quadrature exposition, or treating one of those as optional, rather than simply adding 10–15 minutes to an already tight lesson. The opening should be mathematical and active, not a decorative “today we cover” slide. Section Design may choose the exact segmentation.

## 5. Book fidelity, downstream consequences, risks

- **Preserve deeply:** §§7.4.2–7.4.3 grid/Laplace and §7.5 checking; these are excellent.
- **Develop at comparison depth:** §§7.1–7.3 query types, global/local hidden structure and exact-vs-approximate choices.
- **Recognize only, without claiming coverage:** alternative §7.4 methods, assigned to L08–L10.
- **Do not add:** another full inference algorithm, SMC or multi-parameter Laplace lab.

**Human decision:** Is L07 primarily the intellectual **map of inference** with Laplace as a worked example, or a dedicated **Laplace and checking** lecture? Either is defensible; the first better preserves Murphy's Chapter 7 role and makes the semester more coherent. Current scope should not be “approved unchanged” solely because its Laplace mathematics is feasible.

**Disposition:** **targeted intellectual-arc revision recommended before section design**, high priority. Feasibility remains conditional on preserving a deep Laplace result and cutting existing lower-priority material rather than increasing live time.