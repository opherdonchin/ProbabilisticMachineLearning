# L01 notebook balance audit

Analysis date: 2026-10-17. This is an assessment and proposal, not an approved notebook revision or evidence of student completion time. No notebook sources or execution outputs were changed.

## Sources and classification

Current [L01 solved notebook](../../../../InClass/Solutions/lecture1_missing_data.ipynb), SHA-256 `f8346d9857a7a9ebf09b4053bb24e3a1ee29004fb420c3a6fc32d66b6dfebb62`. All twelve [Sleep solved notebooks](https://github.com/opherdonchin/BayesShortCourse/blob/078547f6fdf601a5b81d791fe8b7d2a2c848e811/sleep/solved), compared against their corresponding [student versions](https://github.com/opherdonchin/BayesShortCourse/blob/078547f6fdf601a5b81d791fe8b7d2a2c848e811/sleep), at repository commit `078547f6fdf601a5b81d791fe8b7d2a2c848e811`. Individual source blob hashes appear below. The [Short Course README](https://github.com/opherdonchin/BayesShortCourse/blob/078547f6fdf601a5b81d791fe8b7d2a2c848e811/sleep/solved/README.md) describes the scientific sequence and supplied setup.

The three roles follow our current notebook conventions:

- **Explanation:** conceptual/technical teaching, orientation, summaries and scientific context supplied to students.
- **Code:** supplied executable code plus its brief implementation instructions. Code written as a student's answer belongs to Questions.
- **Questions:** actual student prompts plus their complete worked answers. This includes mathematical and conceptual text inside answers, consistently for both courses.

Excluded: heading-only structural dividers, stored execution outputs, plots, Colab badges and inline answer markers. An actionable prompt written entirely as a heading still counts. Counting outputs would make plotting choices and saved execution state dominate the result.

L01 has 146 total cells, of which 55 are structural and 91 substantive: 27 Explanation, 28 Code, 36 Questions. The last group is eighteen question/answer pairs. The Code group is fourteen supplied code cells and fourteen preceding notes.

For Sleep 01–05, actual question/solution tags identify student work. Supplied `given-answer` items count as Explanation or Code according to purpose, even when numbered as questions. Other supplied conceptual content was classified by reading it, not by assuming `given` means code. In Sleep 06–12, there are no such tags. Matching numbered questions to student versions establishes the start of answer regions: all expanded worked-answer cells belong to Questions. Notebook 06 has five broad questions and 07–12 have four each; their solved answers expand into multiple cells. Consequently, the older collection does not uniformly have one answer cell per question. Notebook 10's third question has wording drift between versions but retains the same numbered title; this does not change its category.

A few supplied paragraphs combine technical documentation and conceptual content. Each is assigned its primary role; the per-cell CSV makes those judgments inspectable. This is a small interpretive uncertainty, not a claim of exact pedagogical measurement.

## Content length

Percentages below use non-whitespace source characters after removing structural cells, answer markers, heading prefixes, badges and Markdown link targets. Equations and code remain. This is a reproducible size measure, **not reading time, cognitive effort, screen area or learning**. LaTeX syntax remains part of equation source; cell counts provide an independent view.

| Notebook | Explanation | Code to run | Questions + answers |
|---|---:|---:|---:|
| L01 missing data | 47.7% | 21.6% | 30.7% |
| [01_linear_baseline](https://github.com/opherdonchin/BayesShortCourse/blob/078547f6fdf601a5b81d791fe8b7d2a2c848e811/sleep/solved/01_linear_baseline.ipynb) | 17.2% | 27.0% | 55.8% |
| [02_informative_slope_prior](https://github.com/opherdonchin/BayesShortCourse/blob/078547f6fdf601a5b81d791fe8b7d2a2c848e811/sleep/solved/02_informative_slope_prior.ipynb) | 21.3% | 30.2% | 48.5% |
| [03_heavy_tailed_slope_prior](https://github.com/opherdonchin/BayesShortCourse/blob/078547f6fdf601a5b81d791fe8b7d2a2c848e811/sleep/solved/03_heavy_tailed_slope_prior.ipynb) | 18.5% | 31.6% | 49.9% |
| [04_varying_intercept](https://github.com/opherdonchin/BayesShortCourse/blob/078547f6fdf601a5b81d791fe8b7d2a2c848e811/sleep/solved/04_varying_intercept.ipynb) | 16.3% | 15.3% | 68.3% |
| [05_varying_intercept_slope](https://github.com/opherdonchin/BayesShortCourse/blob/078547f6fdf601a5b81d791fe8b7d2a2c848e811/sleep/solved/05_varying_intercept_slope.ipynb) | 12.6% | 41.3% | 46.1% |
| [06_lognormal_regression](https://github.com/opherdonchin/BayesShortCourse/blob/078547f6fdf601a5b81d791fe8b7d2a2c848e811/sleep/solved/06_lognormal_regression.ipynb) | 8.6% | 36.4% | 55.0% |
| [07_lognormal_varying_intercept_slope](https://github.com/opherdonchin/BayesShortCourse/blob/078547f6fdf601a5b81d791fe8b7d2a2c848e811/sleep/solved/07_lognormal_varying_intercept_slope.ipynb) | 7.9% | 37.0% | 55.0% |
| [08_lognormal_distributional](https://github.com/opherdonchin/BayesShortCourse/blob/078547f6fdf601a5b81d791fe8b7d2a2c848e811/sleep/solved/08_lognormal_distributional.ipynb) | 7.3% | 33.9% | 58.8% |
| [09_exgaussian_distributional](https://github.com/opherdonchin/BayesShortCourse/blob/078547f6fdf601a5b81d791fe8b7d2a2c848e811/sleep/solved/09_exgaussian_distributional.ipynb) | 7.8% | 33.9% | 58.3% |
| [10_exgaussian_default_priors](https://github.com/opherdonchin/BayesShortCourse/blob/078547f6fdf601a5b81d791fe8b7d2a2c848e811/sleep/solved/10_exgaussian_default_priors.ipynb) | 7.9% | 32.9% | 59.2% |
| [11_exgaussian_flat_priors](https://github.com/opherdonchin/BayesShortCourse/blob/078547f6fdf601a5b81d791fe8b7d2a2c848e811/sleep/solved/11_exgaussian_flat_priors.ipynb) | 9.1% | 38.3% | 52.6% |
| [12_robust_student_t_and_loo](https://github.com/opherdonchin/BayesShortCourse/blob/078547f6fdf601a5b81d791fe8b7d2a2c848e811/sleep/solved/12_robust_student_t_and_loo.ipynb) | 8.7% | 36.9% | 54.4% |
| Sleep pooled | 12.7% | 31.5% | 55.8% |

The pooled row adds all content before calculating percentages. Giving each notebook equal weight instead gives 11.9% Explanation, 32.9% Code, 55.2% Questions; the substantive conclusion is unchanged.

L01 minus pooled Sleep: **+35.0 percentage points Explanation; −9.9 Code; −25.0 Questions.** Question-related content is about 1.8 times as large a share in Sleep. The first Sleep notebook alone gives 17.2/27.0/55.8%, so this is not merely an introductory-versus-later-notebook contrast.

## Substantive cells

| Notebook | Explanation | Code to run | Questions + answers |
|---|---:|---:|---:|
| L01 missing data | 29.7% | 30.8% | 39.6% |
| [01_linear_baseline](https://github.com/opherdonchin/BayesShortCourse/blob/078547f6fdf601a5b81d791fe8b7d2a2c848e811/sleep/solved/01_linear_baseline.ipynb) | 10.3% | 13.1% | 76.6% |
| [02_informative_slope_prior](https://github.com/opherdonchin/BayesShortCourse/blob/078547f6fdf601a5b81d791fe8b7d2a2c848e811/sleep/solved/02_informative_slope_prior.ipynb) | 12.7% | 21.8% | 65.5% |
| [03_heavy_tailed_slope_prior](https://github.com/opherdonchin/BayesShortCourse/blob/078547f6fdf601a5b81d791fe8b7d2a2c848e811/sleep/solved/03_heavy_tailed_slope_prior.ipynb) | 12.8% | 21.3% | 66.0% |
| [04_varying_intercept](https://github.com/opherdonchin/BayesShortCourse/blob/078547f6fdf601a5b81d791fe8b7d2a2c848e811/sleep/solved/04_varying_intercept.ipynb) | 5.5% | 5.0% | 89.5% |
| [05_varying_intercept_slope](https://github.com/opherdonchin/BayesShortCourse/blob/078547f6fdf601a5b81d791fe8b7d2a2c848e811/sleep/solved/05_varying_intercept_slope.ipynb) | 6.6% | 27.5% | 65.9% |
| [06_lognormal_regression](https://github.com/opherdonchin/BayesShortCourse/blob/078547f6fdf601a5b81d791fe8b7d2a2c848e811/sleep/solved/06_lognormal_regression.ipynb) | 5.7% | 28.6% | 65.7% |
| [07_lognormal_varying_intercept_slope](https://github.com/opherdonchin/BayesShortCourse/blob/078547f6fdf601a5b81d791fe8b7d2a2c848e811/sleep/solved/07_lognormal_varying_intercept_slope.ipynb) | 5.7% | 31.4% | 62.9% |
| [08_lognormal_distributional](https://github.com/opherdonchin/BayesShortCourse/blob/078547f6fdf601a5b81d791fe8b7d2a2c848e811/sleep/solved/08_lognormal_distributional.ipynb) | 5.7% | 31.4% | 62.9% |
| [09_exgaussian_distributional](https://github.com/opherdonchin/BayesShortCourse/blob/078547f6fdf601a5b81d791fe8b7d2a2c848e811/sleep/solved/09_exgaussian_distributional.ipynb) | 6.1% | 33.3% | 60.6% |
| [10_exgaussian_default_priors](https://github.com/opherdonchin/BayesShortCourse/blob/078547f6fdf601a5b81d791fe8b7d2a2c848e811/sleep/solved/10_exgaussian_default_priors.ipynb) | 5.9% | 32.4% | 61.8% |
| [11_exgaussian_flat_priors](https://github.com/opherdonchin/BayesShortCourse/blob/078547f6fdf601a5b81d791fe8b7d2a2c848e811/sleep/solved/11_exgaussian_flat_priors.ipynb) | 7.7% | 42.3% | 50.0% |
| [12_robust_student_t_and_loo](https://github.com/opherdonchin/BayesShortCourse/blob/078547f6fdf601a5b81d791fe8b7d2a2c848e811/sleep/solved/12_robust_student_t_and_loo.ipynb) | 7.1% | 39.3% | 53.6% |
| Sleep pooled | 7.6% | 20.6% | 71.7% |

By this measure L01 has 32.1 percentage points less question-related material than pooled Sleep. Equal notebook weighting gives Sleep 7.6/27.3/65.1%; the large varying-intercept notebook has considerable influence on pooled cell counts. There is no reason to copy its syntax-level question granularity just to increase our percentage.

## Setup and orientation sensitivity

| Comparison | Explanation | Code | Questions |
|---|---:|---:|---:|
| L01 excluding its five orientation cells, content length | 39.6% | 24.9% | 35.5% |
| L01 main teaching sequence, content length | 40.3% | 18.7% | 41.0% |
| Sleep main teaching sequences pooled, content length | 9.1% | 5.3% | 85.6% |
| Sleep 01–05 teaching sequences pooled, content length | 15.4% | 8.9% | 75.8% |

“Main teaching sequence” begins at L01 section 1, following model setup, or Sleep's first model/question section. This removes orientation, imports, data loading/model setup and plotting helpers before that point. It retains any supplied code or explanation introduced later. This cut is a sensitivity analysis, not a new preferred denominator.

L01 orientation contributes about 13.4% of its source length. Its inclusion is justified for a first notebook, but removing it still leaves a 20.3-point question-content gap from the whole Sleep collection. Sleep also repeats lengthy plotting helpers; L01 imports its helpers. That explains why Code has fewer source characters in L01 despite occupying more substantive cells.

The teaching-body percentages for Sleep 06–12 are mechanically 100% Questions because their scientific material is organized entirely as broad prompts followed by worked answers. That does not mean students spend 100% of their time reasoning independently, nor that all explanation inside those answers would be absent from a live class. The 01–05 sensitivity establishes that the difference persists in the more finely divided format too.

## Teaching judgment and proposed direction

The important finding is the gap in work students must formulate and explain. L01 already makes students implement all core conditional/LGS computations. It should retain the orientation, known-model setup, mathematical identities, unfamiliar numerical techniques and supplied plots/checks. This comparison does not establish that those supports are unnecessary or that eighteen questions are insufficient.

However, several explanations provide the conclusion or implementation before asking for it:

- Before Question 3.3, the squared-loss explanation already distinguishes conditional expected risk from one realized squared error. The question then largely rehearses that explanation.
- Before Question 4.3, the transpose/solve explanation gives the exact `np.linalg.solve(Sigma11, Sigma12).T` expression students are asked to produce. The mathematical transpose identity is useful scaffolding; supplying the full implementation leaves less translation for students.
- The forward-marginal explanation explicitly identifies both covariance contributions before Question 5.1 asks students to identify them in comments. That rehearsal can be intentional, but should not be mistaken for a fresh application.

A focused revision could retain the same mathematical route and most or all eighteen questions, shorten repeated explanations, and place selected worked interpretations in their solved answers after students attempt them. Keep introductory scaffolding where the operation itself is new. Preserve retrospective summaries, while removing unnecessary repetition within them. Consolidate supplied checks and their documentation where doing so helps the student follow the argument; their mathematical guarantees should stay explicit.

The follow-up instructor discussion establishes a better decision criterion than a numerical target: choose explanations, supplied code and scaffolded questions according to the intellectual work students should practise, with enough support for successful progress. Supply premises and ask for consequential connections. A supplied criterion followed by an application question can be effective scaffolding; preceding explanation does not itself make a question redundant. The examples above are candidates for this judgment, not established defects. Content ratios describe the allocation but cannot determine the right one or establish learner time. The [authoring criteria](../../../../.agents/skills/teaching-notebook-authoring/SKILL.md) and [delegated review process](../../../../.agents/skills/teaching-notebook-authoring/references/delegated-review.md) operationalize this distinction.

Recommendation: retain the three-category scheme and make a targeted revision of explanation/answer placement. Do not add material simply to increase the question percentage, remove mathematical support indiscriminately, or turn routine plotting and setup into student exercises. No such revision is implemented by this audit.

## Checking records

[Per-cell classifications and source sizes](cell_classification.csv) identify each assignment. [Numeric totals](metrics.json) retain denominators and unrounded-category totals. Original notebook mirrors were used in temporary storage only; this report records the sources without adding duplicate notebooks to the repository.

| Sleep file | Git blob |
|---|---|
| 01_linear_baseline.ipynb | `3755f0559d23f6150e4d1b01f32a2e56c33d6876` |
| 02_informative_slope_prior.ipynb | `6c8717fab32d8aab03998d5829ef7aa308cbc95c` |
| 03_heavy_tailed_slope_prior.ipynb | `6aa0146214d5c1209bc462241272d9e07ef8e3e5` |
| 04_varying_intercept.ipynb | `5851ae4bbfefa4cb99be3202a4bbb6d5fdbe3fa2` |
| 05_varying_intercept_slope.ipynb | `4e20d1c63b8fc3019a9af4037e0a05116a0775bd` |
| 06_lognormal_regression.ipynb | `f57ee62c0191132d8eb6497dcdff121048b0542d` |
| 07_lognormal_varying_intercept_slope.ipynb | `b5fd3e6b405e63a0949b0a12ca9dcc73d22c3a1b` |
| 08_lognormal_distributional.ipynb | `2b4d6c4467ae231af9fda9a727c0967eb5af0c1a` |
| 09_exgaussian_distributional.ipynb | `feb49e5a20d95ec18af11edc5ac7df807e30e369` |
| 10_exgaussian_default_priors.ipynb | `2719f0877610c0c7e8ec8dc53de6f7e688bbe6af` |
| 11_exgaussian_flat_priors.ipynb | `f022b1ace952c4e31e55214c0549702cef04eca8` |
| 12_robust_student_t_and_loo.ipynb | `2f21cbf6bf87aac48a658d00f4e4ca8a14c180c8` |
