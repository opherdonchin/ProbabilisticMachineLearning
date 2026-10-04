import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
import pymc as pm
import arviz as az

print("PyMC version:", pm.__version__)

n1 = 3
n2 = 4
n = n1 + n2

mu1 = np.array([-0.5, 0.5, 1.0])
mu2 = np.array([0.0, 0.5, -0.5, 1.0])
mu = np.concatenate([mu1, mu2])

sigma1 = 1.0
sigma2 = 1.2
rho1 = 0.70
rho2 = 0.80
kappa = 0.90

I1 = np.eye(n1)
I2 = np.eye(n2)

J11 = np.ones((n1, n1))
J22 = np.ones((n2, n2))
J12 = np.ones((n1, n2))

Sigma11 = sigma1**2 * (
    (1 - rho1) * I1
    + rho1 * J11
)

Sigma22 = sigma2**2 * (
    (1 - rho2) * I2
    + rho2 * J22
)

Sigma12 = (
    kappa
    * sigma1
    * sigma2
    * np.sqrt(rho1 * rho2)
    * J12
)

Sigma21 = Sigma12.T

Sigma = np.block([
    [Sigma11, Sigma12],
    [Sigma21, Sigma22],
])

print("Sigma =")
print(np.round(Sigma, 3))

eigenvalues = np.linalg.eigvalsh(Sigma)
print("Eigenvalues of Sigma:")
print(np.round(eigenvalues, 4))

sd = np.sqrt(np.diag(Sigma))
Corr = Sigma / np.outer(sd, sd)

print("Correlation matrix:")
print(np.round(Corr, 3))

plt.figure(figsize=(6, 5))
plt.imshow(Corr, vmin=-1, vmax=1)
plt.colorbar(label="correlation")
plt.xticks(range(n))
plt.yticks(range(n))
plt.axvline(n1 - 0.5)
plt.axhline(n1 - 0.5)
plt.title("Correlation structure of the joint Gaussian")
plt.tight_layout()
plt.show()

rng = np.random.default_rng(2027)

x_complete = rng.multivariate_normal(
    mean=mu,
    cov=Sigma,
)

x1_true = x_complete[:n1]
x2_obs = x_complete[n1:]

print("Complete draw:")
print(np.round(x_complete, 3))

print("Hidden block x1:")
print(np.round(x1_true, 3))

print("Observed block x2:")
print(np.round(x2_obs, 3))

x_partial = np.concatenate([
    np.full(n1, np.nan),
    x2_obs,
])

with pm.Model() as model:
    x = pm.MvNormal(
        "x",
        mu=mu,
        cov=Sigma,
        observed=x_partial,
    )

    idata = pm.sample(
        draws=2000,
        tune=1000,
        chains=4,
        random_seed=2027,
        target_accept=0.9,
    )

print(list(idata.posterior.data_vars))

pymc_summary = az.summary(
    idata,
    var_names=["x_unobserved"],
    hdi_prob=0.90,
)

print(pymc_summary)

posterior_samples = (
    idata.posterior["x_unobserved"]
    .values
    .reshape(-1, n1)
)

pymc_mean = posterior_samples.mean(axis=0)
pymc_cov = np.cov(posterior_samples, rowvar=False)
pymc_sd = posterior_samples.std(axis=0, ddof=1)

pymc_90 = np.quantile(
    posterior_samples,
    [0.05, 0.95],
    axis=0,
)

positions = np.arange(n1) + 1

plt.figure(figsize=(8, 4.5))
plt.violinplot(
    [posterior_samples[:, i] for i in range(n1)],
    positions=positions,
    showmeans=True,
    showextrema=False,
)
plt.scatter(
    positions,
    x1_true,
    marker="D",
    s=45,
    label="Hidden true value",
)
plt.xticks(positions, [f"x1[{i}]" for i in range(n1)])
plt.ylabel("value")
plt.title("PyMC posterior")
plt.legend()
plt.tight_layout()
plt.show()

W = np.linalg.solve(
    Sigma11,
    Sigma12,
).T

b = mu2 - W @ mu1

Omega = (
    Sigma22
    - Sigma21
    @ np.linalg.solve(Sigma11, Sigma12)
)

print("W =")
print(np.round(W, 4))

print("b =")
print(np.round(b, 4))

print("Omega =")
print(np.round(Omega, 4))

mu_y_from_lgs = W @ mu1 + b
Sigma12_from_lgs = Sigma11 @ W.T
Sigma22_from_lgs = W @ Sigma11 @ W.T + Omega

print("Original mu2:")
print(np.round(mu2, 4))

print("LGS-implied mean of y:")
print(np.round(mu_y_from_lgs, 4))

print("Maximum absolute difference in Sigma12:")
print(np.max(np.abs(Sigma12 - Sigma12_from_lgs)))

print("Maximum absolute difference in Sigma22:")
print(np.max(np.abs(Sigma22 - Sigma22_from_lgs)))

m = W @ mu1 + b

S = (
    W
    @ Sigma11
    @ W.T
    + Omega
)

innovation = x2_obs - m

lgs_mean = (
    mu1
    + Sigma11
    @ W.T
    @ np.linalg.solve(S, innovation)
)

lgs_cov = (
    Sigma11
    - Sigma11
    @ W.T
    @ np.linalg.solve(S, W @ Sigma11)
)

lgs_sd = np.sqrt(np.diag(lgs_cov))

z90 = 1.6448536269514722

lgs_90_low = lgs_mean - z90 * lgs_sd
lgs_90_high = lgs_mean + z90 * lgs_sd

lgs_plot_samples = rng.multivariate_normal(
    mean=lgs_mean,
    cov=lgs_cov,
    size=posterior_samples.shape[0],
)

plt.figure(figsize=(8, 4.5))
plt.violinplot(
    [lgs_plot_samples[:, i] for i in range(n1)],
    positions=positions,
    showmeans=True,
    showextrema=False,
)
plt.scatter(
    positions,
    x1_true,
    marker="D",
    s=45,
    label="Hidden true value",
)
plt.xticks(positions, [f"x1[{i}]" for i in range(n1)])
plt.ylabel("value")
plt.title("Exact linear-Gaussian posterior")
plt.legend()
plt.tight_layout()
plt.show()

comparison = pd.DataFrame({
    "hidden_truth": x1_true,
    "PyMC_mean": pymc_mean,
    "LGS_mean": lgs_mean,
    "PyMC_sd": pymc_sd,
    "LGS_sd": lgs_sd,
    "PyMC_90_low": pymc_90[0],
    "PyMC_90_high": pymc_90[1],
    "LGS_90_low": lgs_90_low,
    "LGS_90_high": lgs_90_high,
})

comparison.index = [f"x1[{i}]" for i in range(n1)]

print(comparison.round(3))

mean_difference = pymc_mean - lgs_mean
cov_difference = pymc_cov - lgs_cov

print("PyMC mean - exact LGS mean:")
print(np.round(mean_difference, 5))

print("Maximum absolute mean difference:")
print(np.max(np.abs(mean_difference)))

print("Maximum absolute covariance difference:")
print(np.max(np.abs(cov_difference)))

pymc_lower_error = pymc_mean - pymc_90[0]
pymc_upper_error = pymc_90[1] - pymc_mean

lgs_lower_error = lgs_mean - lgs_90_low
lgs_upper_error = lgs_90_high - lgs_mean

plot_positions = np.arange(n1)
offset = 0.07

plt.figure(figsize=(8, 4.5))

plt.errorbar(
    plot_positions - offset,
    pymc_mean,
    yerr=np.vstack([
        pymc_lower_error,
        pymc_upper_error,
    ]),
    fmt="o",
    capsize=4,
    label="PyMC",
)

plt.errorbar(
    plot_positions + offset,
    lgs_mean,
    yerr=np.vstack([
        lgs_lower_error,
        lgs_upper_error,
    ]),
    fmt="o",
    capsize=4,
    label="Linear Gaussian",
)

plt.scatter(
    plot_positions,
    x1_true,
    marker="D",
    s=45,
    label="Hidden true value",
)

plt.xticks(
    plot_positions,
    [f"x1[{i}]" for i in range(n1)],
)
plt.ylabel("value")
plt.title("Posterior comparison")
plt.legend()
plt.tight_layout()
plt.show()

pymc_corr = (
    pymc_cov
    / np.outer(
        np.sqrt(np.diag(pymc_cov)),
        np.sqrt(np.diag(pymc_cov)),
    )
)

lgs_corr = (
    lgs_cov
    / np.outer(
        np.sqrt(np.diag(lgs_cov)),
        np.sqrt(np.diag(lgs_cov)),
    )
)

print("PyMC posterior correlation:")
print(np.round(pymc_corr, 3))

print("Exact linear-Gaussian posterior correlation:")
print(np.round(lgs_corr, 3))
