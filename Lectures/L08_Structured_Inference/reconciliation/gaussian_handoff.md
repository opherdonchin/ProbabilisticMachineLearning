# L08: carrying categorical sequence inference into Gaussian time series

**Status:** Lecture Scope / revision; bounded decision record and provisional
handoff only. Instructor direction recorded 2026-10-15; local-source availability
corrected 2026-10-16. On that date the instructor accepted an existing-notebook-first,
package-backed mathematical walkthrough approach. Gaussian transfer remains
conditional on the lecture's categorical focus. No new dataset/model, final
mathematical depth, student workload, smoother objective or whole Scope is selected
here.

## What the instructor has decided

In replacement thread `01a14017-0a80-7150-b7e7-c6511cb25698`, the instructor states:

> PS2 question sheet would be from Oke’s course. We have the materials for that.
> We can probably get the notebook from him. If the lecture is only planning to
> do categorical HMM then I agree that it makes sense for the notebook to extend
> the same logic to Gaussian time series. I don't know what N4SID is.

The current lecture proposal is primarily categorical HMM inference, with a short
Kalman comparison applying L01 Gaussian conditioning. It is not entirely
categorical, and its fourteen-minute Gaussian allocation is not a full Gaussian
filter derivation or smoothing lesson. The new direction supports a notebook
extension; it does not silently enlarge that live allocation or approve a second
complete student HMM lab alongside a complete Gaussian lab.

**Accepted approach, 2026-10-16:** The instructor explains that “we don't really
have to have them redo what's done in a package if we give them a scaffolded
walkthrough of the math or the computational steps that are inside it.” Students
can follow equations, call the prepared package and test whether its results make
sense. Start by tracking the actual existing notebook; modify it as concrete
teaching needs emerge. This accepts Oke's fitting/forecasting workflow as the
starting scaffold, not the agent's seasonal replacement or a requirement to write
an exposed filter. Retain its dimensional-comparison opportunity for evaluation
rather than discard it by default. Final cell selection and mathematical/student
work depths remain provisional.

## The mathematical transfer and what students would practise

In the lecture's HMM, the current state separates earlier observations from the
future. A probability vector summarizes the past. With
`A_ij=P(z_t=j|z_(t−1)=i)` and observation likelihood `lambda_t(j)`, prediction and
conditioning give

$$
 f_t^-(j)=\sum_i A_{ij}f_{t-1}(i),\qquad
 f_t(j)=\frac{\lambda_t(j)f_t^-(j)}{\sum_k\lambda_t(k)f_t^-(k)}.
$$

The notebook can preserve those two operations while changing the message's
representation. In a linear-Gaussian model with specified parameters,

$$
 z_t=Fz_{t-1}+\eta_t,\quad \eta_t\sim N(0,Q),\qquad
 y_t=Hz_t+\epsilon_t,\quad \epsilon_t\sim N(0,R),
$$

assume a Gaussian initial state and mutually independent process/observation
noises across time and from that state. The filtered distribution is represented
by a mean `m` and covariance `P`. The categorical sum becomes an integral over the
previous continuous state. Gaussian closure makes this integral exact:

$$
 m_t^-=Fm_{t-1},\qquad P_t^-=FP_{t-1}F^T+Q.
$$

L01 conditioning then incorporates the new observation. Define the observation
prediction covariance `S_t=HP_t^-H^T+R`, assume it is nonsingular, and set

$$
 G_t=P_t^-H^TS_t^{-1},\qquad
 m_t=m_t^-+G_t(y_t-Hm_t^-),\qquad
 P_t=P_t^--G_tS_tG_t^T.
$$

The provisional treatment is **apply/work** for the carried Gaussian
conditioning result: step through the prediction/conditioning equations and
interpret the covariance and innovation, then connect those operations to the
package's forecast calculation. **State/interpret** the fitting procedure's role;
there is no new commitment to derive or implement N4SID. Proving Gaussian
conditioning again is not required by this transfer. Students can establish
understanding through a scaffolded calculation, a package run and reasoned output
checks without reproducing the package implementation. Exact scalar/matrix depth
and the worked calculations still need a bounded handoff decision; they are not
predefined student code blanks here.

For a fitted model write `psi_hat=(F_hat,H_hat,Q_hat,R_hat)`. Exact Gaussian state
inference is conditional on those values. The package's forecast may represent
`p(y_future | y_train,psi_hat)`; this is different from averaging over a posterior
for `psi` itself. State uncertainty, process/observation variation and parameter
uncertainty therefore need separate interpretation. Sampling predictive paths or
plotting quantiles alone does not demonstrate integration over fitting uncertainty.
The source's `.fit()` plus `.predict()` workflow must be explained and checked at
this role level, without teaching an additional full system-identification method.

For fixed state/observation dimensions, repeated queries advance a fixed-size
belief rather than recondition the growing joint distribution of the whole
history. Computation grows linearly with sequence length; dimension and matrix
structure still determine per-step cost. Exact Gaussian inference requires the
stated model, not merely a sparse graph. It does not establish adequate forecasts,
correct noise assumptions, interpretable latent coordinates or learned-parameter
certainty. Use a linear solve for the gain in implementation; this document
creates no new code or numerical validation.

## Optional backward extension and distinct performance questions

A **supplied RTS smoother** could extend the analogy from forward to backward
information: compare `p(z_t|y_(1:t))` with `p(z_t|y_(1:T))`. RTS means
Rauch–Tung–Striebel, the Gaussian backward-smoothing procedure. This is a new
optional proposal requiring source/numerical and student-work feasibility checks;
it is absent from the existing traffic probe and Oke's forecasting notebooks.
A supplied smoother can support understanding through a scaffolded account of
its equations and output checks; a student implementation is not required in
principle. Its actual mathematical treatment and purpose remain undecided.
Retain filtering/forecasting as a coherent bounded endpoint if the backward
extension adds too much unfamiliar work; its inclusion remains open.

Forecasting asks for `p(y_(t+h)|y_(1:t))` before those future observations arrive.
Smoothing uses future observations to revise an earlier hidden state. A smoother
cannot be evaluated as an improved forecast using information unavailable at the
forecast origin. Rolling one-day forecasts assimilate each day's observation
before forecasting the next; a single-origin ninety-day forecast does not.
Synthetic latent truth can check state reconstruction, while real traffic alone
does not reveal a true latent level. Observation scores, forecast horizons and
information sets therefore need explicit definitions in the eventual exercise.

## Oke's source and the additional N4SID choice

The inspected external question sheet is:

`/home/opher/OneDrive/CurrentSemester/Teaching/Advanced Bayesian Statistics/Oke Advanced Probability Course/spring-2026/PS2/PS2-Questions/CEE790A-PS2.tex`

SHA256 `838540ec8b1ff0d0718b34820046dfb69bfb1de44f74d3bfcb1be0f27c13da2e`.
Problem 3, lines 301–310, names `PS2-Kalman-filter-forecasting`, cites the
[Forecastegy tutorial](https://forecastegy.com/posts/kalman-filter-for-time-series-forecasting-in-python/),
and asks for three device-series plots, validation error for at least five state
dimensions, and forecasting after truncating training before the late-2018 spike.
This is reference material from Oke's course, not earlier delivered work in the
current course.

**Correction of the limited earlier search, 2026-10-16:** Both actual notebooks
are directly under the parent `PS2/` directory, alongside the CSV:

| Actual source, relative to the local Oke `spring-2026/` course root | Cells | SHA256 |
|---|---:|---|
| `PS2/PS2-kalman-forecasting.ipynb` | 13 | `8d1b9d23e1caefff7e53bfd134879b3e56da871b01da728067bc6fd3949e0dd2` |
| `PS2/PS2-kalman-forecasting-solution.ipynb` | 33 | `44e877e75bdc2b04a2ad5d067785d38e8f7942d80731b46ca1770404f05fb79c` |

The actual filenames differ from the question sheet's
`PS2-Kalman-filter-forecasting` spelling. Earlier absence reports describe searches
only in `PS2-Questions/` and `PS2-Solutions/`; extending that result to the whole
available course was incorrect. The original reports remain unmodified as raw
review evidence; this current source-status record corrects their inference.
We already have the required template and solution locally. No contact to Oke is
needed to recover these files, and no message was authorized or sent. The root
is the substantial local OneDrive course copy identified above; no live Dropbox
inventory/completeness check has been performed. No student submissions were read.

**What the notebooks actually teach:** Both aggregate sessions by date and device,
append two tablet zero-fill rows, and form desktop/tablet/mobile time series.
The principal split trains before 2019-01-01 and predicts the first ninety days
of 2019. Template cells 6–7 build Darts series, call
`KalmanForecaster(dim_x=100).fit(...)`, then `predict(h, num_samples=100)`;
5%, median and 95% forecasts are extracted. The question sheet identifies the
fitting backend as N4SID; these notebook cells delegate fitting to `.fit()`. Solution cells 16–23 compare dimensions 50, 100, 200, 300, 400 and 500,
including desktop-specific MAE; the template/solution also display forecast plots
and labeled quantile-loss comparisons. This is an existing fitted-model
forecasting workflow that supplies package calculations. The accepted approach
is to add the necessary mathematical/computational walkthrough and result checks,
not to replace these calls with a new student implementation by default. It
contains no backward smoother. Reading it does not validate runtime or learner
extent. The source availability gap is closed; exact adaptation for the inference
transfer still needs review.

The related lecture source is also available at
`Lectures/M2-Inference-Algorithms/M2a-Gaussian-Filtering-and-Smoothing/M2a-Gaussian-Filtering-Smoothing.tex`
under that same course root, SHA256
`c6c7a3c68b2e177a406f34cf493b2880b7411fc6eac75a2db49a55c7b56785bd`.
Inspection finds general filtering/smoothing goals, Bayes filtering, Gaussian
predict/update and posterior-predictive equations. RTS appears only in the
outlook's further-topics list (lines 518–527); it is not a derived smoother in
that lecture. These external teaching materials do not establish coverage in
the current PML course.

**Author-owned source repairs before reuse:** Cell indices below are zero-based;
these are correctness issues to fix and verify, not new instructor approvals.

- Template cell 10 calls MAPE with median prediction first and observations
  second. MAPE is asymmetric; the observed sessions must be `y_true`. See the
  [official MAPE API](https://scikit-learn.org/stable/modules/generated/sklearn.metrics.mean_absolute_percentage_error.html).
  The solution's reversed MAE argument order does not change MAE, which is symmetric.
- Template cell 11 and solution cell 24 label losses at quantiles `.05`, `.5`
  and `.95`, but omit `alpha=q` from `mean_pinball_loss`. Its
  [documented default is `.5`](https://scikit-learn.org/stable/modules/generated/sklearn.metrics.mean_pinball_loss.html),
  so the tail-quantile labels currently do not identify the loss actually computed.
- Question-sheet Problem 3(e), line 310, asks about the late-2018 spike. Solution
  cell 27 instead trains before **2017-11-01** and evaluates from that date to
  **2018-01-31**; cell 29 reuses the earlier `h=90`. The solution's period therefore
  does not answer the dated question as written. Verify the intended event/window
  against the data before adapting that exercise.

No source notebook was edited or executed here. Stored outputs are not evidence
of a clean run on the current environment; package/API compatibility, preparation,
corrected scoring and eventual hosted Colab execution remain author validation.

**N4SID** is a numerical subspace system-identification procedure: it estimates a
linear state-space model from observed time-series data, with the state dimension
chosen externally. Kalman filtering then infers latent states using that model.
Learning dynamics/noise and selecting dimension are additional operations beyond
conditional Gaussian inference, but students can use them through prepared code
while explaining their purpose. Preserve the source fitting calls and dimension
comparison as the starting scaffold; neither a student N4SID implementation nor
a replacement fixed-parameter model is required by default. More detailed fitting
theory or a substantial dimension search would need its own depth/workload
decision. This distinction bounds the mathematical lesson without discarding the
existing notebook's practical workflow.

## Provisional source-to-learning map

The following map uses the exact template/solution hashes above; cell numbers are
zero-based. It is a handoff proposal, not a drafted Q&A notebook, approved schedule
or commitment to retain every row/cell. Prepared code remains the computational
engine; the walkthrough supplies the reasoning needed to interpret and challenge
its answers.

| Actual source cells | Mathematical/computational reasoning and proposed depth | Prepared package calculation | Interpretation or check |
|---|---|---|---|
| Template 3, 6; solution 3, 14 | **Work/interpret:** define a daily observation and its device, units, calendar frequency and missing-day convention. | Existing aggregation and Darts `TimeSeries.from_group_dataframe`. | Check that a missing count is not silently treated as an observed zero; review the two added tablet rows and date alignment. |
| Template 4; solution 9, 12–13 | **Work:** identify training observations, forecast origin, validation window and horizon. | Existing pre-2019 split and computed `h`. | Confirm ninety future daily timestamps and the information available at the origin. This is not rolling one-day assimilation. |
| Template 7; solution 16 | **State/interpret:** fitted state dimension and dynamics/noise parameter roles; fitting versus conditional state inference. No N4SID derivation is required by this proposal. | Existing `KalmanForecaster(...).fit(series)`. | Identify what was learned from training data; distinguish latent-state covariance from uncertainty about fitted parameters. |
| Template 7; solution 16 | **Apply/work:** trace Gaussian predict/condition mathematics and propagation beyond the forecast origin, reusing L01 conditioning. Exact scalar/matrix extent remains open. | Existing `predict(h, num_samples=100)` and quantile extraction. | Explain what the median and interval summarize, how uncertainty evolves across the horizon, and why future observed validation values cannot enter this forecast. |
| Solution 17, 21–23 | **Work/interpret:** connect dimension to model flexibility, fitting/forecast cost and predictive error. | Existing fits for dimensions 50, 100, 200, 300, 400 and 500; category-specific error extraction. | Interpret the validation curve instead of treating dimension as a universal accuracy ranking; if selecting by it, reserve independent evaluation. Exact retained comparison extent is provisional. |
| Template 10–12; solution 24–25 | **Apply/work:** distinguish point loss, quantile loss and interval behavior; connect score to forecast query. | Existing prediction merge, corrected score calls and plotting. | Check timestamp/device correspondence, prediction-versus-observation order, `alpha=q`, and whether interval/failure behavior makes sense. Stored plots do not replace checks. |
| Solution 27–32; question 3(e) | **Work/interpret if retained:** explain what pre-event training can and cannot forecast. | Existing pre-spike fit/predict/plot scaffold after the dated-window defect is resolved. | Reconcile 2017/2018 source mismatch first; an unmodeled future event need not be predictable from preceding traffic. This row adds no new chosen event or model. |

This preserves the practical fitted-model workflow while allowing the mathematics
to remain explicit. A later author can insert focused reasoning/checks around the
existing calls and adjust the retained cells when the lesson takes concrete shape.
No own-code implementation, new model, supplied smoother, exact comparison count
or final one-hour schedule is inferred from this map. The source repairs recorded
above remain author-owned implementation work; no source notebook is edited here.

## What the existing investigation actually establishes

[The author investigation](../scope_investigation.md) identifies its investigator
as `/root/investigate_l07_l10`, 2026-10-14. It checked HMM recurrences against
exhaustive sums and scalar/matrix Gaussian filtering against joint-Gaussian
conditioning. These are author correctness checks, not completed teaching
notebooks, student-time trials or hosted Colab passes.

For traffic, the investigator aggregated the existing Los Angeles CSV and used
supplied settings on desktop standardized `log1p` sessions. A scalar local-level
model performed poorly against a seven-day naive forecast. The same agent then
tried one supplied model with a random-walk level plus seven rotating weekday
effects, after inspecting that evaluation period. This is an exploratory response
to a model failure, not independent test evidence or N4SID training. The transition
and noise parameters are fixed; the state posterior still updates from data.
Its rolling and open-loop results answer different forecast questions. Exact code,
settings, hashes and numerical results remain in
[traffic_probe.py](../notebook_feasibility/traffic_probe.py) and
[traffic_results.json](../notebook_feasibility/traffic_results.json); this record
does not repeat or extend that experiment. It contains no RTS/backward smoother,
parameter-search validation or measured student feasibility. A future selected
model needs a fresh frozen evaluation protocol before a general performance
claim; no dataset/model is selected here.

## Focused reading and decisions still open

Murphy, *Probabilistic Machine Learning: Advanced Topics*, online December 10,
2025: §§9.2.2–9.2.3.1 **The forwards algorithm / The forwards-backwards algorithm /
Backwards recursion** (pp.403–407) establish categorical messages; §8.1.2
**Bayesian filtering equations** (pp.361–362) displays the common integral/Bayes
update; §§8.2.2.1–8.2.2.3 **Predict step / Update step / Posterior predictive**
(pp.365–367) show Gaussian closure and observation scoring. If a backward
extension is retained, inspect §8.2.3 **The Kalman (RTS) smoother** and
§8.2.3.1 **Algorithm** (p.370) before deciding its depth. These verified passages
support the transfer; no whole-chapter coverage is implied.

The coordinator returns only consequential choices to the instructor: exact live
Gaussian preparation and scalar versus matrix walkthrough depth; precise worked
reasoning and output checks around the existing fitting/forecast calls; retained
dimension-comparison extent; filtering/forecasting alone versus a backward
comparison; and application/data/query/performance choices. The existing source
workflow is the accepted starting point, not a completed final allocation. The
current one-hour notebook envelope remains a constraint, not a demonstrated
schedule. Scope reconciliation and its affected feasibility preview must precede
whole-Scope approval and production. No section/slide/notebook code, new pilot,
architecture/map/environment/shared-skill changes, merge or publishing here.
