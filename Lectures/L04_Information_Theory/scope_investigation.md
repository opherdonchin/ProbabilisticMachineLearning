# L04 — pending live-emphasis investigation

This Scope-owned file holds the unresolved proposal and its evidence. The accepted Iris endpoint is recorded in [lecture_scope.md](lecture_scope.md); an eventual instructor answer belongs there. The instructor review queue links to this record and does not duplicate it.

## Q-L04-LIVE — live connection to forecast evaluation

**Status:** awaiting instructor review, under the 2026-10-14 instruction to investigate in parallel and defer consultation. The previous invitation to answer this question is withdrawn as an immediate workflow gate; no answer or approval is inferred.

**Question:** should the retained communication-led live route provide a brief explicit forecast/representation bridge, or should the Iris notebook supply that connection?

**Options:**

- Add a bounded live bridge using the existing binary cross-entropy example as probability-forecast evaluation and the existing MI/DPI interpretation as a representation limit. Show that identical predicted labels can yield different log scores. Provisionally fund 2–3 minutes by shortening the correction-criterion and sufficient-statistic elaboration, keeping the tied parity posterior, MI derivation and processing proof sketch.
- Retain the live argument and 24/22/16/36-minute allocations, with the supplied conditional-scoring explanation in the notebook. This preserves the richest current communication interpretation while giving less live practice recognizing an ML forecast.

**Recommendation:** the brief bridge strengthens transfer to the selected notebook and L05 probability evaluation. Its funding is an estimated tradeoff, not validated spare time. It adds no classifier fit or separate calibration theorem. Either route has the same selected student endpoint.

**Evidence:** [current scope](lecture_scope.md), especially Parts 1 and 3; independent [source review](reviews/iris_source_review.md), item 5 and bounded recheck; [Section Design preview](reviews/iris_feasibility_review.md), issue 1. Both judge the retained route mathematically feasible with risks and classify a live rebalance as an instructor-owned choice. Source §5.2.4 establishes cross-entropy/KL; §14.2.1 supports the supplied conditional scoring application. The exact reviewed scopes are preserved in commits `68b6647` and `8c338d6`.

**Exactly affected work awaiting decision:** changes to L04's live intellectual emphasis/time allocation and acceptance of that live contract; final Section Design construction and slide development relying on it. Full L04 scope acceptance remains pending. Neither choice blocks the already selected Iris data/forecast/scoring feasibility research, independent source checks, or any L05–L12 scope/notebook investigation.

**Independent work completed:** targeted Iris handoff, source-first review, Section Design preview and correctness clarifications; the notebook remains unimplemented and unpiloted. **Work safe to continue:** preparation/source/technical feasibility checks for the selected notebook, conditional evaluation of the two live interpretations, and later-lecture research. No conditional branch is an accepted scope or authorization to publish.

**Answer provenance:** none yet. When the instructor requests review and answers, update the affected authoritative scope commitments, record the answer/provenance, close this item by a link, and unblock only the affected work.

## Independent selected-endpoint feasibility

The coordinator completed [probe_evaluation.py](notebook_feasibility/probe_evaluation.py) in a clean process of the isolated locked uv environment. It prepares three-class probability forecasts on a fixed 105/45 stratified Iris split, seed2027, with petal length/width standardized from training cases only. The teacher-only logistic fit uses regularization `C=1` and is candidate supplied infrastructure, not a selected student algorithm or the same fit as L05's unregularized stochastic-training probe. Training/test row hashes and raw feature hashes match the L05 candidate split, so an eventual common data convention is feasible without presuming its approval. The [native logistic API](https://scikit-learn.org/stable/modules/generated/sklearn.linear_model.LogisticRegression.html) and [bundled Iris data](https://scikit-learn.org/stable/modules/generated/sklearn.datasets.load_iris.html) were checked against the installed1.9.1 documentation; these APIs need not appear in student work.

The [compact results](notebook_feasibility/results.json) give identical accuracy `43/45` for the prepared forecast and fixed logit multipliers `.25`/`4`, but mean log losses `0.1500`/`0.5493`/`0.0560` nats. The training-frequency baseline has accuracy `1/3` and log loss `ln3`. This tests the selected score/accuracy distinction without fitting a second student model. Greater confidence happens to improve this split's score; it is neither a universal claim nor evidence that the transformation is population-calibrated. The transformations were fixed before inspecting test scores; no winner is selected as the course forecast.

Scoring uses normalized log probabilities from logits, so the reference does not mistake floating-point softmax underflow for structural zero probability. The top-label reliability summaries have fixed bins, support counts and only descriptive confidence/correctness claims. The constructed finite law supplies `p(Y,R,Z)=p(Y,R)k(Z\mid R)` for deterministic coarsening, with `I(Y;R)=0.499884` bits and `I(Y;Z)=0.180191` bits. Relabeling the processed code preserves its information; a constant code gives zero. Those are exact finite-law calculations, not estimates of Iris population MI. Students would inspect supplied information calculations, not implement another estimator.

This scope-neutral probe adds no live emphasis, forecast-training requirement, new student library or approval. It establishes local computational feasibility of the selected endpoint while Q-L04-LIVE remains deferred. Conditional scoring/calibration interpretation still needs a learner-time pilot, and there is no student notebook or hosted Colab run. More teacher-preparation variants are unnecessary before a chosen detailed handoff; the final forecast package should be validated rather than copied automatically from this probe.
