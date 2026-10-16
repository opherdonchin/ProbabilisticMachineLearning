"""Exact Gaussian missing-block inference and other queries of the same joint.

Technical worked solution, before student-question decomposition. Parameters
are supplied, not fitted. Run with the repository's uv environment:
    uv run --locked python \
        InClass/Preparation/lecture1_missing_data_worked_solution.py

Figures are written beside this script under lecture1_missing_data_figures/. All numerical inference
uses analytic Gaussian equations evaluated with linear solves. The controlled
case is supplied reference data; random draws only generate one fresh case.
"""

from pathlib import Path

import matplotlib

matplotlib.use("Agg")  # Supplied script-only setup; notebooks use inline display.
import matplotlib.pyplot as plt
import numpy as np
from scipy.stats import norm


# 0. Supplied setup and plotting infrastructure.
OUTPUT_DIR = Path(__file__).resolve().parent / "lecture1_missing_data_figures"
OUTPUT_DIR.mkdir(parents=True, exist_ok=True)
np.set_printoptions(precision=6, suppress=True)


def save_figure(fig, name):
    """Presentation helper only: write PNG/SVG and close the figure."""
    fig.tight_layout()
    for suffix in ("png", "svg"):
        fig.savefig(OUTPUT_DIR / f"{name}.{suffix}", dpi=160)
    plt.close(fig)


# 1. The original known seven-dimensional joint, unchanged.
# X = [X1; X2], with X1 in R^3 hidden and X2 in R^4 observed.
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

Sigma11 = sigma1**2 * (
    (1 - rho1) * np.eye(n1) + rho1 * np.ones((n1, n1))
)
Sigma22 = sigma2**2 * (
    (1 - rho2) * np.eye(n2) + rho2 * np.ones((n2, n2))
)
Sigma12 = (
    kappa * sigma1 * sigma2 * np.sqrt(rho1 * rho2)
    * np.ones((n1, n2))
)
Sigma21 = Sigma12.T
Sigma = np.block([[Sigma11, Sigma12], [Sigma21, Sigma22]])

assert mu.shape == (7,)
assert Sigma11.shape == (3, 3) and Sigma12.shape == (3, 4)
assert Sigma21.shape == (4, 3) and Sigma22.shape == (4, 4)
assert Sigma.shape == (7, 7)
np.testing.assert_allclose(Sigma, Sigma.T, atol=1e-14, rtol=0)
eigenvalues = np.linalg.eigvalsh(Sigma)
assert np.all(eigenvalues > 0)
print("Joint covariance:\n", Sigma)
print("Joint covariance eigenvalues:", eigenvalues)

sd = np.sqrt(np.diag(Sigma))
Corr = Sigma / np.outer(sd, sd)
np.testing.assert_allclose(Corr[0, 1], rho1)
np.testing.assert_allclose(Corr[3, 4], rho2)
np.testing.assert_allclose(Corr[0, 3], kappa * np.sqrt(rho1 * rho2))
print("Cross-block covariance:", Sigma12[0, 0])
print("Cross-block correlation:", Corr[0, 3])

fig, ax = plt.subplots(figsize=(6.2, 5.2))
im = ax.imshow(Corr, vmin=-1, vmax=1, cmap="coolwarm")
fig.colorbar(im, ax=ax, label="correlation")
labels = [f"x1[{j}]" for j in range(n1)] + [f"x2[{j}]" for j in range(n2)]
ax.set_xticks(range(n), labels, rotation=45, ha="right")
ax.set_yticks(range(n), labels)
ax.axvline(n1 - 0.5, color="black", linewidth=1)
ax.axhline(n1 - 0.5, color="black", linewidth=1)
ax.set_title("Known joint Gaussian: correlation structure")
save_figure(fig, "joint_correlation")

# 2. Supply the original controlled case as fixed reference data.
# Origin: first np.random.default_rng(2027).multivariate_normal(mu, Sigma)
# draw on the reference NumPy 2.0.2 runtime. Repeated covariance eigenvalues
# permit SVD/eigenvector bases to differ across platforms, so regenerating that
# seeded draw is not a portable way to supply the same numerical case.
# Keep truth only for later reference/evaluation; inference sees x2_obs.
x_complete = np.array([
    -0.9809265055186939,
    -0.275006600480288,
    1.8920470230380393,
    -0.18413093623310994,
    -0.06973754657319287,
    -0.07777903828206933,
    0.9191872262734604,
])
x1_true = x_complete[:n1].copy()
x2_obs = x_complete[n1:].copy()
print("\nHidden simulation truth (evaluation only):", x1_true)
print("Observed block:", x2_obs)

# These reference values come from the original notebook's seed-2027 case.
np.testing.assert_allclose(
    x_complete,
    [-0.981, -0.275, 1.892, -0.184, -0.070, -0.078, 0.919],
    atol=5e-4, rtol=0,
)

# 3. Hidden-case query: p(x1 | x2_obs, mu, Sigma).
# Lecture equations:
#   conditional_mean = mu1 + Sigma12 Sigma22^{-1} (x2_obs - mu2)
#   conditional_cov  = Sigma11 - Sigma12 Sigma22^{-1} Sigma21
# np.linalg.solve(A, b) computes A^{-1}b without constructing the inverse.
# One-dimensional NumPy arrays represent vectors; @ is matrix multiplication.
innovation = x2_obs - mu2
conditional_mean = mu1 + Sigma12 @ np.linalg.solve(Sigma22, innovation)
conditional_cov = Sigma11 - Sigma12 @ np.linalg.solve(Sigma22, Sigma21)
conditional_sd = np.sqrt(np.diag(conditional_cov))
assert conditional_mean.shape == (3,) and conditional_cov.shape == (3, 3)
np.testing.assert_allclose(conditional_cov, conditional_cov.T, atol=1e-14, rtol=0)
assert np.all(np.linalg.eigvalsh(conditional_cov) > 0)
assert np.all(np.linalg.eigvalsh(Sigma11 - conditional_cov) > -1e-12)
np.testing.assert_allclose(
    conditional_mean, [-0.568, 0.432, 0.932], atol=5e-4, rtol=0,
)
np.testing.assert_allclose(
    conditional_sd, np.full(n1, 0.683), atol=5e-4, rtol=0,
)
print("\nExact conditional mean:", conditional_mean)
print("Exact conditional covariance:\n", conditional_cov)
print("Exact conditional SD:", conditional_sd)

# Analytic central marginal 90% intervals; not a simultaneous 90% region.
# norm.ppf(0.95) is the standard normal's 95th percentile, about 1.64485.
z90 = norm.ppf(0.95)
conditional_90_low = conditional_mean - z90 * conditional_sd
conditional_90_high = conditional_mean + z90 * conditional_sd
prior_sd = np.sqrt(np.diag(Sigma11))
print("Conditional marginal 90% lower endpoints:", conditional_90_low)
print("Conditional marginal 90% upper endpoints:", conditional_90_high)
conditional_corr = conditional_cov / np.outer(conditional_sd, conditional_sd)
print("Conditional correlation (intervals alone do not show dependence):\n", conditional_corr)

positions = np.arange(n1)
fig, ax = plt.subplots(figsize=(8, 4.7))
ax.errorbar(
    positions - 0.08, mu1, yerr=z90 * prior_sd,
    fmt="s", capsize=4, color="gray", label="Unconditional mean + marginal 90% interval",
)
ax.errorbar(
    positions + 0.08, conditional_mean, yerr=z90 * conditional_sd,
    fmt="o", capsize=4, color="tab:blue", label="Conditional mean + marginal 90% interval",
)
ax.scatter(positions, x1_true, marker="D", color="tab:orange", s=40,
           label="Hidden simulation truth (reference only)", zorder=3)
ax.set_xticks(positions, [f"x1[{j}]" for j in range(n1)])
ax.set_ylabel("value")
ax.set_title("Hidden block: distributional uncertainty and a point summary")
ax.legend(fontsize=8, loc="lower right")
save_figure(fig, "hidden_block_uncertainty")

# 4. Squared-loss action: apply the live vector risk identity.
# Given y, m = E[Z|y], V = Cov(Z|y), and any chosen action a in R^3:
#   R(a|y) = E[||Z-a||^2 | y] = tr(V) + ||m-a||^2.
# This requires finite conditional second moments, not Gaussianity.
# Author checking comparison: the already supplied mu1 ignores this case's
# observations. The core student result is action_mean with risk tr(V); these
# two additional arithmetic lines do not commission a baseline study.
action_mean = conditional_mean
action_unconditional = mu1
remaining_uncertainty = np.trace(conditional_cov)
excess_risk_mean = np.sum((conditional_mean - action_mean)**2)
excess_risk_unconditional = np.sum((conditional_mean - action_unconditional)**2)
risk_mean = remaining_uncertainty + excess_risk_mean
risk_unconditional = remaining_uncertainty + excess_risk_unconditional
np.testing.assert_allclose(risk_mean, 1.399058823529412, atol=1e-12, rtol=0)
np.testing.assert_allclose(
    risk_unconditional - risk_mean, excess_risk_unconditional, atol=1e-14, rtol=0,
)
# Verify the vector identity against a sum of scalar marginal second moments.
np.testing.assert_allclose(
    risk_unconditional,
    np.sum(np.diag(conditional_cov) + (conditional_mean - mu1)**2),
    atol=1e-14, rtol=0,
)
print("\nSquared-loss action                conditional risk    excess risk")
print(f"Conditional mean                  {risk_mean:16.9f} {excess_risk_mean:14.9f}")
print(f"Supplied unconditional mean       {risk_unconditional:16.9f} {excess_risk_unconditional:14.9f}")

# Only now use the hidden simulation truth to compute realized errors.
# Model expected risk is an average over the conditional distribution; its
# ordering does not guarantee the same ordering for every realized hidden value.
realized_error_mean = np.sum((x1_true - action_mean)**2)
realized_error_unconditional = np.sum((x1_true - action_unconditional)**2)
print("Realized squared error, conditional-mean action:", realized_error_mean)
print("Realized squared error, unconditional-mean action:", realized_error_unconditional)
print("These two realized errors do not establish a per-case guarantee.")

# 5. Translate the same joint into the lecture's linear Gaussian system.
# z = x1, y = x2; z ~ N(mu_z, Sigma_z), y = Wz + b + epsilon,
# epsilon ~ N(0, Omega), independent of z.
mu_z = mu1
Sigma_z = Sigma11
y = x2_obs
# E[x2|x1] = mu2 + Sigma21 Sigma11^{-1}(x1-mu1) = Wz+b.
# Transposing the solve implements the right-side inverse using symmetry.
W = np.linalg.solve(Sigma11, Sigma12).T
b = mu2 - W @ mu1
Omega = Sigma22 - Sigma21 @ np.linalg.solve(Sigma11, Sigma12)
assert W.shape == (4, 3) and b.shape == (4,) and Omega.shape == (4, 4)
np.testing.assert_allclose(Omega, Omega.T, atol=1e-14, rtol=0)
assert np.all(np.linalg.eigvalsh(Omega) > 0)
print("\nLGS W:\n", W)
print("LGS b:", b)
print("LGS Omega:\n", Omega)

# Exact forward moments, also needed inside the lecture's inverse update.
mu_y = W @ mu_z + b
Sigma_zy = Sigma_z @ W.T
Sigma_yy = W @ Sigma_z @ W.T + Omega
np.testing.assert_allclose(mu_y, mu2, atol=1e-14, rtol=0)
np.testing.assert_allclose(Sigma_zy, Sigma12, atol=1e-14, rtol=0)
np.testing.assert_allclose(Sigma_yy, Sigma22, atol=1e-14, rtol=0)

# Apply the same conditioning equations in LGS notation; no new target law.
lgs_mean = mu_z + Sigma_zy @ np.linalg.solve(Sigma_yy, y - mu_y)
lgs_cov = Sigma_z - Sigma_zy @ np.linalg.solve(Sigma_yy, Sigma_zy.T)
mean_equivalence_error = np.max(np.abs(lgs_mean - conditional_mean))
cov_equivalence_error = np.max(np.abs(lgs_cov - conditional_cov))
np.testing.assert_allclose(lgs_mean, conditional_mean, atol=1e-12, rtol=0)
np.testing.assert_allclose(lgs_cov, conditional_cov, atol=1e-12, rtol=0)
print("Maximum block/LGS conditional mean difference:", mean_equivalence_error)
print("Maximum block/LGS conditional covariance difference:", cov_equivalence_error)

# 6. Different query: p(y_new), before observing a fresh case.
# Marginalizing the state gives N(mu_y, Sigma_yy) under the same known parameters.
# This is not p(y|z_known), and the old y does not enter these forward moments.
print("\nForward measurement mean:", mu_y)
print("Forward measurement covariance:\n", Sigma_yy)

# 7. Short generation activity from the same LGS/joint, not hidden-case inference.
# Draw one state from the unconditional state law, then independent noise,
# and form the measurement using the lecture's vector equation directly.
# This draw illustrates generation, not an estimate of the forward moments.
# Its separate seed does not determine the supplied reference case above.
# Fresh draw values may differ across platforms; no fixed answer key uses them.
FRESH_RANDOM_SEED = 2028
rng_new = np.random.default_rng(FRESH_RANDOM_SEED)
z_new = rng_new.multivariate_normal(mu_z, Sigma_z)
epsilon_new = rng_new.multivariate_normal(np.zeros(n2), Omega)
y_new = W @ z_new + b + epsilon_new
assert z_new.shape == (3,) and y_new.shape == (4,)
assert epsilon_new.shape == (4,)
print("Fresh generated state:", z_new)
print("Fresh generated measurement:", y_new)

# Author validation only: validate the generator's population joint via its
# affine map, rather than suggesting a draw validates a covariance empirically.
base_cov = np.block([
    [Sigma_z, np.zeros((n1, n2))],
    [np.zeros((n2, n1)), Omega],
])
affine_map = np.block([
    [np.eye(n1), np.zeros((n1, n2))],
    [W, np.eye(n2)],
])
generated_joint_cov = affine_map @ base_cov @ affine_map.T
generated_joint_mean = np.concatenate([mu_z, mu_y])
np.testing.assert_allclose(generated_joint_cov, Sigma, atol=1e-12, rtol=0)
np.testing.assert_allclose(generated_joint_mean, mu, atol=1e-12, rtol=0)

positions_y = np.arange(n2)
fig, ax = plt.subplots(figsize=(8, 5.7))
ax.errorbar(
    positions_y, mu_y, yerr=z90 * np.sqrt(np.diag(Sigma_yy)),
    fmt="o", capsize=5, color="black", label="Forward mean + marginal 90% interval",
)
ax.scatter(positions_y + 0.06, y_new, marker="x", s=45,
           color="tab:blue", label="One fresh generated case", zorder=3)
ax.scatter(positions_y, y, marker="D", color="tab:orange", s=35,
           label="Original recorded case (reference only)", zorder=3)
ax.set_xticks(positions_y, [f"y[{j}]" for j in range(n2)])
ax.set_ylabel("value")
ax.set_title("Before observing a fresh case: the forward measurement law")
ax.legend(fontsize=8, loc="upper center", bbox_to_anchor=(0.5, -0.10))
save_figure(fig, "forward_measurements")

print("\nVALIDATION PASSED: shapes, SPD, original numbers, block/LGS conditional,")
print("risk decomposition, exact forward moments, and generator population joint.")
print("Figures written to:", OUTPUT_DIR)
print("Local clean-process validation only; hosted Colab readiness remains unchecked.")
