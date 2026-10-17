# Packet 02 contemporaneous record

## Question 1.2: current understanding and requested product

I need a numerical covariance and corresponding correlation for one hidden/recorded pair, plus the correlation of two distinct hidden coordinates and of two distinct recorded coordinates. This uses the supplied parameters, rather than estimating correlations from the recorded case. I can reuse the cross-block covariance printed in my previous execution, but I should connect it to the formula.

## Actual answer before checking with code

The cross-block covariance is

$$
\operatorname{Cov}(X_{11},X_{21})
=0.90(1)(1.2)\sqrt{0.70(0.80)}
=1.08\sqrt{0.56}\approx0.808198.
$$

Dividing by the product of marginal standard deviations gives

$$
\operatorname{Corr}(X_{11},X_{21})
=\frac{0.808198}{1(1.2)}
=0.90\sqrt{0.56}\approx0.673498.
$$

For distinct coordinates within the hidden block, covariance is sigma1 squared times rho1, so division by sigma1 squared leaves correlation rho1 = 0.70. Likewise, distinct recorded coordinates have correlation rho2 = 0.80. The diagonal entries correspond to a coordinate with itself and have correlation 1.

The covariance value agrees with the output I already obtained in packet 01. I have not sought help or looked anything up. I will use a short calculation appended to my ordered script to check the numerical correlation.

## Actual execution and interpretation

The complete script ran again from a fresh process using the same uv-cache adjustment and exited with code 0. The full supplied setup and my calculations are retained in `packet_02_execution.log`. The new outputs were:

```text
Cross-block covariance: 0.8081979955431713
Cross-block correlation: 0.6734983296193094
Distinct hidden-coordinate correlation: 0.7
Distinct recorded-coordinate correlation: 0.8
```

These agree with my initial answer; no revision was needed. They establish the supplied model's marginal pairwise association. They explain the relative strengths visible in the correlation plot: the cross-block correlation is slightly below 0.70 and below 0.80. They do not yet give a conditional hidden-block distribution or quantify an estimate's error for this case.

## Experience account

I could repeat this calculation by reading the block formulas and dividing each covariance by its two marginal standard deviations. Here the distinction between covariance and correlation was clear because the recorded-block standard deviation is 1.2. I needed no help, lookup or simulated helper response. As with Question 1.1, this was an immediate calculation for the model, not evidence of observed human effort or timing. Nothing in this packet remains unclear to me. Stopped after Question 1.2.
