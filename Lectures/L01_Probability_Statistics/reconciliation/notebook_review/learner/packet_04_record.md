# Packet 04 contemporaneous record

## Question 2.1: current understanding before execution

I need the mean of the three hidden measurements conditional on the four recorded ones. The mean starts at mu1 and changes according to the difference between x2_obs and its expected value mu2. The supplied equation tells me exactly which covariance blocks to use. I should solve Sigma22 times a vector equals innovation, then multiply the result on the left by Sigma12. I should not reverse the order or form a numerical inverse.

The provided explanation of `solve(A, B)` is enough for this use, although this is an API I would normally check carefully. Sigma22 is (4,4), so the vector that solves its equation has shape (4,). Sigma12 is (3,4), and multiplying it by that vector should produce a (3,) correction to mu1.

## Actual first code answer

```python
innovation = x2_obs - mu2
solved_innovation = np.linalg.solve(Sigma22, innovation)
# Sigma12 (3,4) @ solved_innovation (4,) contracts the four entries to give (3,).
conditional_mean = mu1 + Sigma12 @ solved_innovation
print("Conditional mean:", conditional_mean)
print("Conditional mean shape:", conditional_mean.shape)
```

I will append this answer to the existing ordered script and execute all earlier supplied code and answers from a fresh process. No help request or lookup has been needed.

## Actual output and interpretation

The ordered script exited with code 0. The full actual output and code are saved in `packet_04_execution.log`. The new answer printed:

```text
Conditional mean: [-0.568086  0.431914  0.931914]
Conditional mean shape: (3,)
```

This has the expected shape and is the conditional mean m in the supplied Gaussian formula. Compared with mu1 = [-0.5, 0.5, 1.0], every coordinate shifts downward by approximately 0.068086. The equal shifts are plausible because all rows of Sigma12 are identical. I have used only the recorded block in this calculation, not the withheld case values.

This computes one part of the conditional distribution. It does not yet supply its covariance or intervals, and it does not tell me that the withheld measurements equal these means. I know the lecture connected squared loss to conditional expectation, but this question only asks me to compute the conditional mean; I have not evaluated a reconstruction loss here.

## Experience account and help

I could follow the equation by breaking it into the innovation, one linear solve, and one matrix-vector multiplication. The explicit explanation of `solve` made this approachable without looking up the API. I checked the dimensions before executing; no runtime error occurred and no code revision was needed. I can explain that the solved vector is an intermediate quantity whose product with Sigma22 reproduces the innovation; it is not itself the hidden conditional mean. There was no help request or simulated helper response. The calculation was immediate for the model given the supplied API explanation; no learner struggle or human timing is claimed. Stopped after Question 2.1.
