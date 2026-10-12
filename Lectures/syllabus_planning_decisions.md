# Current teaching decisions

The instructor agreed to the 13-meeting, Book-2-first course order in PR #8. During the subsequent question review, the instructor agreed to a simpler L03 image algorithm and selected the lighter L04 parity-bit example. The instructor paused further decisions to request clearer explanations, then specified that those explanations must retain mathematical sophistication and precision, with focused book readings where needed. This accepts those two choices, not every later lecture.

Book 2 remains the main source. Book 1 supplies selected explanations or examples. L01's delivered material and L02's agreed sections remain unchanged; L13 remains project presentations. We are developing scopes, not slides or student notebooks.

## What is selected or still proposed

| Meeting | Choice and consequence |
|---|---|
| L03 | The instructor agreed to this simpler method. It differs from Murphy’s algorithm and does not promise the best possible image or posterior uncertainty. |
| L04 | The instructor chose the lighter example. One changed bit is detected but cannot always be located or corrected. The stronger code is reference material. |
| L05 | First PyTorch use makes this meeting tight. Data preparation and plotting are supplied; the lecture does not teach a large software framework. |
| L06 | This replaces the candidate MRI tissue-classification lab. Class-assignment probabilities are explained briefly; a second mixture-model fit is not required. |
| L07 | The small example is chosen for checkability. A finite grid is also an approximation, not an automatically exact answer. |
| L08 | The main lab is discrete hidden-state inference. The previously preferred continuous Kalman forecasting lab is not included. |
| L09 | Uses controlled data and known noise. The real economic-data example and sampling comparison are replaced; no new Pyro software is required. |
| L10 | Helper diagnostics are supplied. Gibbs updates are explained briefly. Hamiltonian Monte Carlo uses derivatives for directed moves but is not fully derived or implemented. |
| L11 | Intervals describe observation noise conditional on fitted weights. They do not include a Bayesian posterior over weights. One CPU fit and prepared fallback still need testing. |
| L12 | Uses 19 measurements and four hidden coordinates. Data access, prepared comparisons and CPU runtime remain untested. Patterns are descriptive, not identified causal factors. |

The lecture scopes keep their reviewed mathematical commitments. The current communication revision brings decision-relevant equations, assumptions, formal method names and focused reading guidance into the instructor discussion. L04 is the one change to the required example: a three-bit parity model replaces the five-bit error-correcting construction. The simpler code detects a single-bit change but cannot always locate or correct it; the stronger result is reference material. Its numerical model and independent targeted review were updated; the current precision revision does not change that selected example.

## What the instructor needs to assess

The [teaching choices](course_architecture_scope/questions_and_hesitations.md) define the mathematical contrasts, state derive/state/apply depth, explain alternatives and their costs, and identify verified readings for the remaining decisions: the first PyTorch meeting, hidden categories versus Kalman forecasting, simple checkable data versus realistic applications, and mobility modeling/access. Technical correctness and software checks are the authors' responsibilities and are not presented as approval questions.

The [course explanation](course_architecture_scope/architecture_audit.md) shows how the lectures build on one another and what is omitted. The [review register](course_architecture_scope/STATUS.md) gives exact scope versions and reviewer identities. Original review reports are retained for evidence, with plain-language summaries before their technical records. Previous approval of a five-bit L04 model is not approval of the new three-bit model.

The [plan](../syllabus_plan.typ), [syllabus](../advanced_statistics_2027_1_syllabus.typ), [ledger](material_ledger.md) and [notebook checks](notebook_reference_audit.md) must describe these same activities. Future notebooks require supplied helpers and one central student implementation per hour. PyTorch is the only new required software library; we do not copy source dependencies automatically.

Lecture/lab times are estimates. Data packaging, helper code, prepared comparisons, student trials and clean local/Google Colab runs are later work. No merge or student release is authorized by readability revision or feasibility review.
