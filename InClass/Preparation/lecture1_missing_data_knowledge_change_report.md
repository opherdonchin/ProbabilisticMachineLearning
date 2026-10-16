# L01 notebook knowledge-state change proposal

These are prospective changes following successful teaching and student completion. No course activity is recorded as already delivered, and actual cumulative knowledge has not been advanced. The coordinator separately reconciled the reference file's prospective L01 authoring contract with the exact-only route.

### Assume familiar

Keep the existing baseline: probability/Bayesian reasoning, expectation, basic covariance/correlation, mathematical matrix algebra, basic Python, NumPy arrays/indexing/arithmetic, `@`, and basic plotting. **No promotions** are proposed after one notebook.

### Previously encountered — scaffold when needed

After actual completion, propose recording the following as encountered rather than fluently mastered:

- Partitioned Gaussian block notation; exact conditional mean/covariance and their shapes; conditional covariance as a Schur complement.
- Applying `np.linalg.solve` with vector and matrix right-hand sides, and the symmetry/transpose route for a right-side inverse product.
- `np.diag`/square roots for marginal SDs, normal quantiles for central individual intervals, and the distinction from simultaneous coverage.
- Exact conditional law versus chosen action; vector squared-loss identity, conditional-mean action, `np.trace` minimum conditional model risk, and expected versus realized loss.
- Explicit `X1,X2` to `Z,Y` notation translation; identifying/implementing `W,b,Omega`; LGS forward marginal moments; reconstructing the same old-case conditional as a supplied check rather than another method.
- Fresh unconditional state plus independent noise plus direct vector measurement construction with `rng_new.multivariate_normal`; generation versus old-case inference and fresh before-observation query.

`np.block` and `np.allclose` are shown/explained in supplied material, not independently practiced. Keep scaffolding when later asking students to write them. Covariance eigenvalue tests, assertion APIs and affine-generator verification are supplied author checks, not independent student competencies.

### New in this lecture/notebook

The following remain unestablished by this notebook: model-parameter fitting, missingness-mechanism modeling, empirical model validation/population performance, simultaneous probability regions, physical or causal interpretation of the covariance-derived LGS, batching/advanced broadcasting, covariance spectral-analysis fluency, inference-library version/container APIs. Do not promote removed package workflows from an older draft.

The coordinator removed sampler-specific planned L01 exposure from the cumulative reference, preserving course-entry package experience; do not claim those constructs were taught because an earlier draft listed them. This report proposes the transition, while the instructor/coordinator retains the timing and record of actual teaching.

## Student-orientation/support revision

The instructor identifies this as students' first course notebook. Introduce cell execution, question/answer cells and the visible Explanation to read / Code to run / Questions to answer roles, Markdown/code placeholders, runtime state/order, AI-assisted checking, saving and final clean execution explicitly. After actual practice these may be recorded as encountered, with continued support. The supplied plotting-package import/install and optional `help`/source inspection do not establish package-management fluency. This adds no mathematical exercise or actual knowledge promotion; reading time is additional and unmeasured.
