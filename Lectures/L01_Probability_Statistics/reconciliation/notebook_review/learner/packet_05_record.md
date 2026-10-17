# Packet 05 contemporaneous record

## Question 2.2: current understanding before execution

I need the covariance V of the hidden-block conditional distribution. The formula subtracts a (3,3) matrix from Sigma11. The solve uses Sigma22 (4,4) and Sigma21 (4,3): it should solve for three columns at once, producing (4,3). Multiplication on the left by Sigma12 (3,4) should then give (3,3). I can use the supplied matrix-right-hand-side explanation rather than inventing a loop over columns.

## Actual first code answer

```python
solved_cross_cov = np.linalg.solve(Sigma22, Sigma21)
# The solve result is (4,3); Sigma12 (3,4) @ solved_cross_cov (4,3) gives (3,3).
conditional_cov = Sigma11 - Sigma12 @ solved_cross_cov
print("Conditional covariance:")
print(conditional_cov)
print("Conditional covariance shape:", conditional_cov.shape)
```

I will append this to the earlier ordered script, rename that script to describe its cumulative role, and run it from the beginning. No help request or lookup was needed for this attempt.

## Actual output and interpretation

`cumulative_attempt.py` ran from a fresh process with the prior uv-cache adjustment and exited with code 0. The full supplied code, my calculations, and actual output are in `final_execution.log`. Question 2.2 printed:

```text
Conditional covariance:
[[0.466353 0.166353 0.166353]
 [0.166353 0.466353 0.166353]
 [0.166353 0.166353 0.466353]]
Conditional covariance shape: (3, 3)
```

The matrix has the expected size for uncertainty about three hidden coordinates. Its diagonal variances are smaller than the prior hidden variances of 1, while its off-diagonal entries remain positive. Conditioning on recorded measurements reduces the uncertainty here without making the hidden coordinates known exactly. Unlike the conditional mean calculation, this expression contains no `x2_obs`; for this fixed Gaussian model the conditional covariance is the same for any recorded values. I have not performed an independent positive-definiteness check or any withheld-value comparison. There was no code correction or help request.

## End of released material

Stopped after Question 2.2. No answer key or later notebook material was viewed. The final cumulative executable file is `cumulative_attempt.py`; earlier per-packet records and execution logs remain preserved.
