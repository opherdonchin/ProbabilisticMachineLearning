# Execution corrections and limitations

The first launch of `geometry_probe.py` was interrupted with Ctrl-C (exit130) before producing any fitted-case result. It contained an unnecessary advanced-indexed `p[:,:,y] *= 1` no-op in the analytical likelihood-gradient helper, expanding work/memory without changing values. That line was removed. The committed source and all committed numerical outputs come from the complete second launch, which exited0. The interrupted launch produced only `case multinomial_iris`; no partial fit was used or candidate discarded from it.

The successful source also records BFGS optimizer messages, two-start values and gradient residuals. A strict `success=False` caused by precision loss is not hidden or automatically interpreted as a failed posterior fit; final gradients and independent objective checks are exposed. The author audit runs separate fixed-noise finite differences and PyTorch/analytic checks.

Gaussian families only were fitted. This is explicit bounded-screen scope, not a conclusion that non-Gaussian VI is unavailable. Multinomial Iris's failure to demonstrate a major consequential classifier change is negative evidence and remains in the report/raw data. No alternate priors, nonlinear transforms, feature searches or data subsets were tried to make it fail.

All hosted Colab, student workload and final pedagogical-authoring checks remain unperformed.
