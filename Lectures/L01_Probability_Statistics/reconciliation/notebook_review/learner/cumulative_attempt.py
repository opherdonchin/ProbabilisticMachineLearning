from pathlib import Path
import re
import sys

import matplotlib
matplotlib.use("Agg")
from IPython.core.interactiveshell import InteractiveShell

packet = Path("/tmp/l01-notebook-review-pilot/packet_01.md").read_text()
cells = re.findall(r"```python\n(.*?)\n```", packet, re.S)
shell = InteractiveShell.instance()
for index, code in enumerate(cells, start=1):
    print(f"\n--- Supplied code block {index} ---", flush=True)
    print(code, flush=True)
    result = shell.run_cell(code, store_history=False)
    if result.error_before_exec or result.error_in_exec:
        print(f"STOPPED: supplied code block {index} failed.", flush=True)
        sys.exit(1)

import matplotlib.pyplot as plt
for number in plt.get_fignums():
    destination = Path("/tmp/l01-notebook-review-pilot/attempt") / f"packet_01_plot_{number}.png"
    plt.figure(number).savefig(destination, bbox_inches="tight")
    print(f"Saved plot: {destination}", flush=True)

print("\nQuestion 1.1 shape check from executed arrays:")
for name in ("Sigma11", "Sigma12", "Sigma21", "Sigma22", "Sigma"):
    print(name, shell.user_ns[name].shape)
print("One cross-block covariance:", shell.user_ns["Sigma12"][0, 0])

print("\nQuestion 1.2 calculations:")
ns = shell.user_ns
cross_covariance = ns["kappa"] * ns["sigma1"] * ns["sigma2"] * ns["np"].sqrt(ns["rho1"] * ns["rho2"])
cross_correlation = cross_covariance / (ns["sigma1"] * ns["sigma2"])
print("Cross-block covariance:", cross_covariance)
print("Cross-block correlation:", cross_correlation)
print("Distinct hidden-coordinate correlation:", ns["rho1"])
print("Distinct recorded-coordinate correlation:", ns["rho2"])

print("\nQuestion 2.1 answer:", flush=True)
answer_21 = '''innovation = x2_obs - mu2
solved_innovation = np.linalg.solve(Sigma22, innovation)
# Sigma12 (3,4) @ solved_innovation (4,) contracts the four entries to give (3,).
conditional_mean = mu1 + Sigma12 @ solved_innovation
print("Conditional mean:", conditional_mean)
print("Conditional mean shape:", conditional_mean.shape)
'''
print(answer_21, flush=True)
result = shell.run_cell(answer_21, store_history=False)
if result.error_before_exec or result.error_in_exec:
    print("STOPPED: Question 2.1 failed.", flush=True)
    sys.exit(1)

print("\nQuestion 2.2 answer:", flush=True)
answer_22 = '''solved_cross_cov = np.linalg.solve(Sigma22, Sigma21)
# The solve result is (4,3); Sigma12 (3,4) @ solved_cross_cov (4,3) gives (3,3).
conditional_cov = Sigma11 - Sigma12 @ solved_cross_cov
print("Conditional covariance:")
print(conditional_cov)
print("Conditional covariance shape:", conditional_cov.shape)
'''
print(answer_22, flush=True)
result = shell.run_cell(answer_22, store_history=False)
if result.error_before_exec or result.error_in_exec:
    print("STOPPED: Question 2.2 failed.", flush=True)
    sys.exit(1)
