# L01 existing-material assessment — raw specialist evidence

**Reviewer:** delegated Lecture Scope specialist `/root/l01_existing_argument`.
**Mode and boundary:** feasibility-review; evidence reconstruction for initial L01 reconciliation, not new scope drafting.
**Working branch:** `rescope-l01-l12-architecture-alignment-20261014`.
**Reviewed HEAD:** `692d10372f4e1cd091ae1e2977402900148f33c7`.
**Evidence status:** conceptual source inspection only. No notebook execution, rendered-deck visual revalidation, student trial, measured timing, or instructor scope approval occurred in this review. Existing material was reconstructed before reading the architecture. Historical persona reports were read afterward as separate evidence.

| Artifact | Exact reviewed content identifier |
| --- | --- |
| `Lectures/L01_Probability_Statistics/slide_deck.typ` | `235b8eeb48ec9075d2bcea82b6a377c0a45b6a79` |
| `Lectures/L01_Probability_Statistics/lecture_01_coverage_spec.typ` | `c4457bc4fdb11df14de54658f20e487030766328` |
| `InClass/Solutions/lecture1_missing_data.ipynb` | `ab441941c8b526151a927bfbcf292bd9bc629ce5` |
| `InClass/Preparation/lecture1_missing_data_worked_solution.py` | `d605e135b732856060a98e7a6f5bb08bd35f8672` |
| `InClass/Preparation/lecture1_missing_data_authoring_report.md` | `1c710e379317d8b7955924dc9f9110c341a1101d` |
| Historical persona review target commit | `e518d93f9566645da2eeff96e56662960f66d5a4` |
| Historical persona review target deck blob | `69886a29870e4edd9d3fdde79c252b3e0037de54` |

The report below preserves the specialist's final analysis. Its proposed question is returned to the coordinator, not posed as a separate instructor interaction.

---

L01’s existing argument is worth preserving. Its strongest achievement is **turning a joint Gaussian into a reusable inference method**, with visible mathematical reuse rather than a catalogue of formulas. This was an independent, read-only reconstruction of current source before reading the architecture; it was not a notebook execution, visual revalidation, or scope approval.

**What the existing lecture accomplishes**

- The opening reactivates Bayesian modeling through the Beta–Bernoulli example, then distinguishes a learning problem’s task, experience and performance. Iris supplies concrete measurements, labels, empirical loss and a probabilistic classifier.
- The mathematical chain is particularly strong: **“The three operations in multivariate Gaussian systems”** → covariance geometry and affine maps → block marginalization → an independent Gaussian residual → conditional covariance/Schur complement → construction of the LGS joint distribution → the gain update and uncertainty regimes.
- **“Inference often combines conditioning and summarizing”** protects the distinction between a posterior distribution and its mean. **“The same model can also predict measurements”** establishes a genuine forward/inverse comparison using the same model.
- Sensor fusion gives covariance an engineering purpose: precision can differ by direction. This is stronger than teaching only missing-value substitution.

These claims come from `Lectures/L01_Probability_Statistics/slide_deck.typ`, especially lines 1624, 1768, 1934, 1982, 2038, 2155, 2385, 2501, 2689 and 2773 at the reviewed revision.

**What students actually practise in the notebook**

`InClass/Solutions/lecture1_missing_data.ipynb` contains 80 cells and 21 question cells. References below use zero-based cell indices.

It supplies one synthetic seven-dimensional Gaussian, hides three coordinates of **one simulated observation**, and holds all parameters known. Students identify the target $p(x_1\mid x_2,\mu,\Sigma)$ (cells 24–27), invoke PyMC missing-data sampling (31–41), and translate the joint Gaussian into

$$
z=x_1,\quad y=x_2,\quad
W=\Sigma_{21}\Sigma_{11}^{-1},\quad
b=\mu_2-W\mu_1,\quad
\Omega=\Sigma_{22}-\Sigma_{21}\Sigma_{11}^{-1}\Sigma_{12}.
$$

They implement that translation using linear solves, check the observed marginal (45–60), apply exact LGS conditioning (63–67), and compare sampled versus exact means and SDs (74–76).

The strongest practical competence is therefore **formulating and computing a Gaussian missing-block posterior, translating equivalent representations, and checking sampled summaries against an exact reference**. The guided questions, supplied simulation/plotting infrastructure and explicit notation checkpoint are effective pedagogy.

Its practical boundary is narrower than “evaluate an imputation method”: there is no parameter learning, repeated reconstruction experiment, explicit reconstruction loss, comparison against unconditional-mean imputation, or investigation of misspecification. Plotting one hidden truth does not establish imputation accuracy or calibration. The PyMC/exact comparison primarily tests inference computation, not whether the model answers a substantive measurement task well.

**Main weaknesses and reciprocal architecture implications**

1. **Scope-owned, advisory:** The hinge between the learning-problem framework and Gaussian inference is underdeveloped. “Learning problems become probabilistic queries” mostly repeats taxonomy expressions; “Summary: Probability for machine learning” introduces the joint/operation framework before concretely enacting it. Minimal repair: carry one measurement problem through observed/unknown variables, conditional distribution, point output and evaluation criterion. Preserve useful task/experience distinctions; reconsider repeated symbolic taxonomy before cutting the Gaussian argument.

2. **Scope/architecture-owned, advisory:** The architecture’s incomplete/noisy-measurement opening usefully strengthens this hinge. But converting L01 into a missing-data-only lecture would lose a valuable existing principle: **one generative model supports forward prediction, inverse inference and different summaries**. Retain that broader LGS endpoint unless the instructor explicitly selects a narrower practical emphasis. Missing-data practice can serve that argument without becoming its intellectual purpose.

3. **Notebook-handoff-owned, advisory:** A modest supplied batch experiment could distinguish computational agreement from task performance. For Gaussian truth and squared reconstruction loss, the conditional mean minimizes conditional expected loss; comparing it against the unconditional mean gives the covariance reduction a practical meaning. This need not require an elaborate new dataset. Whether this replaces part of the PyMC/API work is an instructor decision.

4. **Documentation drift:** `Lectures/L01_Probability_Statistics/lecture_01_coverage_spec.typ` proposes a moments/estimators/MLE/MAP bridge and book-based imputation with an optional estimated-parameter extension. The present deck has no estimator/MLE/MAP unit, and the notebook uses a course-constructed PyMC/LGS comparison. Do not treat those unimplemented commitments as established student knowledge.

**Technical concerns confirmed in current source**

- The expanded marginal covariance product at slide **“Marginalization keeps the matching blocks”**, around line 1963, retains $P=[I\;0]$ while displaying only the top covariance block row as the middle matrix: dimensions do not conform.
- Sensor fusion around line 2726 omits conditional independence of sensor errors and the prior assumption needed for the displayed sensor-only geometry. With a finite informative prior, the posterior mean depends on all three precision-weighted sources.
- The coin slide’s unqualified uncertainty-reduction wording should be scoped to its displayed example; Gaussian covariance reduction is a special, stronger result.
- Notebook cell 76 attributes all sampled/exact differences to Monte Carlo error, although sampling diagnostics are explicitly excluded in cell 40. This is an expected outcome, not a demonstrated guarantee.

**Review and validation provenance**

All five persona reports reviewed rendered slides at commit `e518d93…`, deck blob `69886a2…`; current deck blob is `235b8ee…` after production refactoring. They independently support the strong Gaussian construction and identify the hinge, notation hierarchy, sensor assumptions and marginal-product issue. They are simulated reader evidence, not measured classroom outcomes. The later course-spine review calls L01 “delivered,” which conflicts with current authoritative records: no class has been taught.

The authoring report explicitly labels the notebook an authoring-complete, publication-unvalidated draft. Saved outputs show installation/import failures in cells 2–3; all substantive computational cells are unexecuted. These historical outputs do not diagnose the present environment. Hosted Colab, clean local execution and one-hour feasibility remain unverified.

**Recommended starting discussion**

Begin with the intended competence endpoint, preserving the Gaussian mathematical chain provisionally. A consequential question is:

> Should L01’s practical endpoint remain computing and cross-checking a supplied Gaussian posterior, or should students also judge reconstruction performance against a baseline—accepting that this may replace some taxonomy or PyMC/API work to keep the hour bounded?

## Exact source-evidence supplements

- Notebook saved cell 2 has execution count 1 and reports `/home/opher/Repositories/ProbabilisticMachineLearning/.venv/bin/python: No module named pip`. Saved cell 3 has execution count 2 and a `ModuleNotFoundError: No module named 'pandas'`. No substantive inference cells carry execution counts or outputs. These were inspected from JSON, not produced by this review.
- Notebook display equations predominantly use `\\[ ... \\]`, contrary to current repository notebook Markdown policy. This is a technical authoring repair, not an instructor-owned scope decision.
- The five historical reports are `review/reports/amir_cohen.md`, `eitan_mizrahi.md`, `maya_shalev.md`, `noa_ben_ami.md` and `yael_harari.md` under the L01 directory. Their protocol required sequential reading of rendered pages and prohibited reading the source or other persona reports. Each identifies the same historical commit and reports 67 rendered pages. Their independent-reader process is historical provenance, not a new independent validation at the current blob.
- `Lectures/course_architecture_scope/l01_framework_course_spine_review.md` labels its review same-context and identifies current deck blob `235b8eeb48ec9075d2bcea82b6a377c0a45b6a79`; its use of “delivered” is superseded by current no-teaching-yet records.
- The timing-calibration reference records the instructor's judgment that L01 is about the right length. Its page/section-count table is a provisional older calibration and does not establish the present deck's measured duration. Neither mathematical density nor persona fatigue justifies claiming L01 is too long without timing evidence.
- No separate approved five-part L01 Lecture Scope or Section Design was supplied by the kickoff inventory. The coverage specification and authored artifacts are evidence of prior intent and implementation, not blanket approval of a newly revised scope.
