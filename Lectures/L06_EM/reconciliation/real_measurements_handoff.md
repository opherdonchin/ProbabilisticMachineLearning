# L06 real-measurement notebook decision

**Status:** Bounded Lecture Scope revision; instructor direction recorded on 2026-10-16. This is a current handoff, not a full notebook specification, whole-scope approval or readiness certificate. The owning [lecture scope](../lecture_scope.md#3-notebook-handoff--fit-unknown-gaussian-parameters) contains the controlling notebook commitment.

## Instructor provenance and exact extent

The instructor said:

> Real measurements with artificial missingness should probably be the notebook. I don't think we need 'a small supplied synthetic check' necessarily. Again, notebooks should be properly scaffolded, including developing both theoretical and technical understanding through small steps. I think there is a gap in how we are thinking notebooks will look like.

This selects the real-measurement/artificial-missingness direction and removes any requirement for a synthetic student check. It does not fix the exact dataset, selected columns, train/evaluation split, mask, seed, preprocessing, comparison set or question sequence. The coordinator had proposed BMI, blood pressure and two cholesterol measurements from the diabetes dataset; those remain a candidate implementation. Missingness is course-created, not evidence about clinical missingness. There is no approval to infer disease progression or undertake a new clinical task.

The preceding instructor clarification also permits a scaffolded walkthrough of the mathematics or computational steps inside prepared software, followed by calling that software and checking its output against the equations. Understanding does not require reimplementing the package, and supplied code does not replace the questions that develop understanding.

## Required handoff and preserved mathematics

Students should develop, through small theoretical and technical steps, how partly observed rows yield conditional first and second moments, how those statistics fit unknown Gaussian parameters, and how the fitted model reconstructs hidden measurements. The mandatory distinction is between `E[XXᵀ|o]` and `E[X|o]E[X|o]ᵀ`: their difference is conditional covariance. The likelihood-improvement proof remains a live lecture commitment under exact, improving E/M-step conditions. Neither its proof nor an observed increasing trace guarantees global optimality or improvement of each held-out reconstruction.

The live Bayesian opening, known-parameter-to-unknown-parameter transition, expected-moment calculation, exact-EM guarantee, brief mixture recognition and 112-minute live envelope are unchanged. EM fits a point parameter value; subsequent conditional uncertainty does not integrate a Bayesian parameter posterior. The notebook extends to real measurements under a Gaussian modeling approximation. The 60-minute notebook envelope remains provisional, with its actual Q&A workload unvalidated.

A prepared driver or package is compatible with these aims. The notebook must make its mathematical and computational steps intelligible through the solved Q&A sequence; “run the driver and inspect a plot” is insufficient. This handoff does not prescribe final question granularity or require students to write the algorithm merely because it can be coded compactly.

## Evidence, checks and remaining work

The earlier [investigation](../scope_investigation.md) and [finite results](../notebook_feasibility/results.json) remain source evidence for tested alternatives and author checks. Their synthetic-primary recommendation predates this instructor direction and does not control the current handoff. Their specific masks, seeds and preprocessing are evidence, not silently selected student settings. Preserve those records as identifiable research evidence.

Author/reviewer responsibilities include source accuracy, nonleaking preprocessing and initialization, mask information, positive-definite covariance behavior, objective fidelity and clean execution. Constructed numerical/reference checks can support those duties without becoming required synthetic student work. A real-data Gaussian fit has no known generating-parameter oracle. Do not claim calibrated clinical uncertainty from Gaussian closure alone.

Required comparison priorities remain a separate open choice; neither a new baseline set nor equal implementation of several comparisons is approved here. Notebook-authoring review should first reconcile the current notebook skills and concrete solved-notebook precedents with the instructor's correction. Then a validated worked solution can support a fine-grained Q&A proposal, retaining the primary real-data task. No full notebook, questions, code, dependency changes, slides, maps, merge or publication is part of this revision.
