"""L01 plots: supplied formatting, with all model quantities passed explicitly.

The helpers display and return Matplotlib figures. They neither fit a model nor
compute Gaussian conditioning, a decision rule, risk, or generated observations.
The helpers do not access notebook variables, use random state, read or write
files, or change the plotting backend.
"""

import matplotlib.pyplot as plt
import numpy as np

__all__ = [
    "plot_joint_correlation",
    "plot_hidden_uncertainty",
    "plot_forward_measurements",
]


def plot_joint_correlation(cov, n_hidden):
    """Show the correlation matrix of a supplied joint covariance.

    ``cov`` has shape ``(n_hidden + n_observed, n_hidden + n_observed)``
    with the hidden block first and strictly positive marginal variances.
    ``n_hidden`` specifies the block boundary. The conversion to correlation
    is only for display; it does not change the model or perform inference.
    """
    cov = np.asarray(cov)
    n_observed = cov.shape[0] - n_hidden
    sd = np.sqrt(np.diag(cov))
    corr = cov / np.outer(sd, sd)
    fig, ax = plt.subplots(figsize=(6.2, 5.2))
    im = ax.imshow(corr, vmin=-1, vmax=1, cmap="coolwarm")
    fig.colorbar(im, ax=ax, label="correlation")
    labels = [f"x1[{j}]" for j in range(n_hidden)] + [
        f"x2[{j}]" for j in range(n_observed)
    ]
    ax.set_xticks(range(n_hidden + n_observed), labels, rotation=45, ha="right")
    ax.set_yticks(range(n_hidden + n_observed), labels)
    ax.axvline(n_hidden - 0.5, color="black", linewidth=1)
    ax.axhline(n_hidden - 0.5, color="black", linewidth=1)
    ax.set_title("Known joint Gaussian: correlation structure")
    fig.tight_layout()
    plt.show()
    return fig


def plot_hidden_uncertainty(
    prior_mean, prior_cov, conditional_mean, conditional_sd, truth, *, interval_quantile
):
    """Compare supplied unconditional and conditional marginal summaries.

    All vectors have shape ``(n_hidden,)``; ``prior_cov`` has shape
    ``(n_hidden, n_hidden)``. Pass the standard-normal 95th percentile
    (``norm.ppf(0.95)``) as ``interval_quantile`` to draw the labelled central
    90% intervals. These are individual marginal intervals, not a joint 90%
    region. ``truth`` is a simulated reference shown after inference, never an
    input to a conditional calculation. No conditional moments are calculated.
    """
    prior_mean = np.asarray(prior_mean)
    conditional_mean = np.asarray(conditional_mean)
    conditional_sd = np.asarray(conditional_sd)
    positions = np.arange(prior_mean.size)
    fig, ax = plt.subplots(figsize=(8, 5.5))
    ax.errorbar(
        positions - 0.08, prior_mean,
        yerr=interval_quantile * np.sqrt(np.diag(prior_cov)),
        fmt="s", capsize=4, color="gray",
        label="Unconditional mean + individual 90% interval",
    )
    ax.errorbar(
        positions + 0.08, conditional_mean,
        yerr=interval_quantile * conditional_sd,
        fmt="o", capsize=4, color="tab:blue",
        label="Conditional mean + individual 90% interval",
    )
    ax.scatter(
        positions, truth, marker="D", color="tab:orange", s=40,
        label="Hidden simulation truth (reference only)", zorder=3,
    )
    ax.set_xticks(positions, [f"x1[{j}]" for j in range(prior_mean.size)])
    ax.set_ylabel("value")
    ax.set_title("Hidden block: exact marginal uncertainty")
    ax.legend(fontsize=8, loc="upper center", bbox_to_anchor=(0.5, -0.10))
    fig.tight_layout()
    plt.show()
    return fig


def plot_forward_measurements(mean, cov, generated, recorded, *, interval_quantile):
    """Show a supplied forward Gaussian law and two reference observations.

    ``mean``, ``generated`` and ``recorded`` have shape ``(n_observed,)``;
    ``cov`` has shape ``(n_observed, n_observed)``. Pass ``norm.ppf(0.95)`` as
    ``interval_quantile`` for the labelled central 90% marginal intervals,
    which are not a joint 90% region. The helper does not compute the forward
    moments, generate a case, condition on ``recorded``, or estimate parameters.
    """
    mean = np.asarray(mean)
    positions = np.arange(mean.size)
    fig, ax = plt.subplots(figsize=(8, 5.7))
    ax.errorbar(
        positions, mean, yerr=interval_quantile * np.sqrt(np.diag(cov)),
        fmt="o", capsize=5, color="black",
        label="Forward mean + individual 90% interval",
    )
    ax.scatter(
        positions + 0.06, generated, marker="x", s=45,
        color="tab:blue", label="One fresh generated case", zorder=3,
    )
    ax.scatter(
        positions, recorded, marker="D", s=35, color="tab:orange",
        label="Original recorded case (reference only)", zorder=3,
    )
    ax.set_xticks(positions, [f"y[{j}]" for j in range(mean.size)])
    ax.set_ylabel("value")
    ax.set_title("Before observing a fresh case: the forward measurement law")
    ax.legend(fontsize=8, loc="upper center", bbox_to_anchor=(0.5, -0.10))
    fig.tight_layout()
    plt.show()
    return fig
