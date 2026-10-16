"""Bounded teacher-only AIS pilot; no fitting, tuning, or student notebook.

Run with the existing repository uv interpreter. Inputs are frozen L09 evidence.
All particles are independent trajectories; no resampling/adaptation occurs.
"""
from pathlib import Path
import hashlib
import json
import platform
import time

import numpy as np
import scipy
from scipy.special import expit, logsumexp

HERE = Path(__file__).resolve().parent
INPUT = json.loads((HERE / 'frozen_inputs.json').read_text())
SEEDS = list(range(2100, 2124))
LOG2PI = np.log(2 * np.pi)


class Problem:
    def __init__(self, diagnostic=False):
        self.diagnostic = diagnostic
        if diagnostic:
            # One transparent mechanism diagnostic, not a replacement dataset.
            self.mean = np.zeros(2)
            self.L = np.eye(2)
            self.target_mean = np.array([3., 0.])
            self.target_precision = np.diag([1., 4.])
            self.logZ = float(np.log(np.pi))
            self.truth = np.array([3., 1.])  # E[w0], E[(w0-3)^2]
        else:
            meta = INPUT['metadata']
            raw = np.loadtxt(HERE / 'o-ring-erosion-or-blowby.data')
            assert hashlib.sha256((HERE / 'o-ring-erosion-or-blowby.data').read_bytes()).hexdigest() == meta['data_sha256']
            self.X = np.c_[np.ones(len(raw)), (raw[:, 2]-meta['center'])/meta['scale']]
            self.y = (raw[:, 1] > 0).astype(int)
            assert self.y.tolist() == meta['binary_distress']
            self.Q = np.c_[np.ones(5), (np.array(meta['query_temperatures'])-meta['center'])/meta['scale']]
            self.mean = np.array(INPUT['full_q']['mean'])
            self.L = np.linalg.cholesky(INPUT['full_q']['covariance'])
            self.logZ = INPUT['reference']['logZ_unnormalized']
            self.truth = np.array(INPUT['reference']['predictions'])[:, 1]
        self.logdet = float(np.log(np.diag(self.L)).sum())
        self.values = self.gradients = 0

    def target(self, z, gradient=False):
        """log f_z(z)=log f_w(m+Lz)+log|L|, including call counts."""
        self.values += len(z)
        self.gradients += len(z) * gradient
        w = self.mean + z @ self.L.T
        if self.diagnostic:
            delta = w-self.target_mean
            lp = -.5*np.einsum('ni,ij,nj->n', delta, self.target_precision, delta)
            gw = -delta @ self.target_precision
        else:
            eta = w @ self.X.T
            lp = (eta*self.y-np.logaddexp(0, eta)).sum(1) - (w*w).sum(1)/8
            if gradient:
                gw = (self.y-expit(eta)) @ self.X - w/4
        if gradient:
            return lp+self.logdet, gw @ self.L
        return lp+self.logdet

    def query(self, z):
        w = self.mean+z @ self.L.T
        if self.diagnostic:
            return np.c_[w[:, 0], (w[:, 0]-3)**2]
        return expit(w @ self.Q.T)


def logq(z):
    return -.5*(z*z).sum(1)-LOG2PI  # standard 2D Gaussian


def mh_move(problem, z, lf, beta, rng, scale=.9):
    proposed = z+scale*rng.normal(size=z.shape)
    fp = problem.target(proposed)
    loga = beta*(fp-lf)+(1-beta)*(logq(proposed)-logq(z))
    accept = np.log(rng.random(len(z))) < np.minimum(loga, 0.)
    return np.where(accept[:, None], proposed, z), np.where(accept, fp, lf), accept


def leapfrog(problem, z, momentum, gf, beta, step=.3, steps=4):
    # Identity mass in q-whitened coordinates, refreshed N(0,I) momentum.
    pos = z.copy()
    mom = momentum.copy()
    g = beta*gf-(1-beta)*pos
    mom += .5*step*g
    for j in range(steps):
        pos += step*mom
        fp, gp = problem.target(pos, True)
        g = beta*gp-(1-beta)*pos
        mom += (.5 if j == steps-1 else 1.)*step*g
    return pos, -mom, fp, gp


def hmc_move(problem, z, lf, gf, beta, rng):
    momentum = rng.normal(size=z.shape)
    proposed, reversed_momentum, fp, gp = leapfrog(problem, z, momentum, gf, beta)
    loga = beta*(fp-lf)+(1-beta)*(logq(proposed)-logq(z))
    loga += .5*(momentum*momentum).sum(1)-.5*(reversed_momentum*reversed_momentum).sum(1)
    accept = np.log(rng.random(len(z))) < np.minimum(loga, 0.)
    return (np.where(accept[:, None], proposed, z), np.where(accept, fp, lf),
            np.where(accept[:, None], gp, gf), accept)


def run(problem, method, stages, n, seed):
    rng = np.random.default_rng(seed)
    z = rng.normal(size=(n, 2))
    problem.values = problem.gradients = 0
    start = time.perf_counter()
    if method == 'hmc':
        lf, gf = problem.target(z, True)
    else:
        lf = problem.target(z)
    lw = np.zeros(n)
    accepted = proposals = 0
    for j in range(1, stages+1):
        # Weight before moving, using the state at the previous temperature.
        lw += (lf-logq(z))/stages
        if j == stages or method == 'is':
            continue  # final invariant move is optional and omitted
        beta = j/stages
        if method == 'mh':
            z, lf, acc = mh_move(problem, z, lf, beta, rng)
        elif method == 'hmc':
            z, lf, gf, acc = hmc_move(problem, z, lf, gf, beta, rng)
        else:
            raise ValueError(method)
        accepted += int(acc.sum())
        proposals += n
    wn = np.exp(lw-logsumexp(lw))
    estimate = wn @ problem.query(z)
    logZhat = float(logsumexp(lw)-np.log(n))
    return dict(seed=seed, n=n, stages=stages, method=method,
                target_values=problem.values, target_gradients=problem.gradients,
                seconds=time.perf_counter()-start, estimate=estimate.tolist(),
                error=(estimate-problem.truth).tolist(), logZhat=logZhat,
                Zhat_over_Z=float(np.exp(logZhat-problem.logZ)),
                weight_ESS=float(1/(wn @ wn)), max_weight=float(wn.max()),
                acceptance=accepted/proposals if proposals else None)


def summarize(rows, truth):
    estimates = np.array([r['estimate'] for r in rows])
    errors = estimates-truth
    ratios = np.array([r['Zhat_over_Z'] for r in rows])
    return dict(replicates=len(rows), query_bias=errors.mean(0).tolist(),
                query_SD=estimates.std(0, ddof=1).tolist(),
                query_RMSE=np.sqrt((errors*errors).mean(0)).tolist(),
                median_max_absolute_query_error=float(np.median(abs(errors).max(1))),
                Z_ratio_mean=float(ratios.mean()), Z_ratio_SD=float(ratios.std(ddof=1)),
                Z_relative_RMSE=float(np.sqrt(((ratios-1)**2).mean())),
                median_weight_ESS=float(np.median([r['weight_ESS'] for r in rows])),
                mean_acceptance=float(np.mean([r['acceptance'] for r in rows])) if rows[0]['acceptance'] is not None else None,
                mean_seconds=float(np.mean([r['seconds'] for r in rows])),
                density_evaluations=rows[0]['target_values'],
                gradient_evaluations=rows[0]['target_gradients'], trajectories=rows[0]['n'])


def checks():
    p = Problem()
    rng = np.random.default_rng(790)
    z = rng.normal(size=(12, 2)); v = rng.normal(size=z.shape)
    lf, gf = p.target(z, True)
    numeric = np.empty_like(z)
    for j in range(2):
        h = np.zeros_like(z); h[:, j] = 1e-5
        numeric[:, j] = (p.target(z+h)-p.target(z-h))/2e-5
    gradient_error = float(abs(gf-numeric).max())
    forward, momentum, fp, gp = leapfrog(p, z, v, gf, .4)
    back, backmom, _, _ = leapfrog(p, forward, momentum, gp, .4)
    reversal_error = float(max(abs(back-z).max(), abs(backmom-v).max()))
    # Identity transitions must telescope exactly to direct IS on the same draw.
    direct = lf-logq(z)
    accumulated = sum((lf-logq(z))/17 for _ in range(17))
    telescope_error = float(abs(accumulated-direct).max())
    # Most importantly, show the printed move-then-weight form fails for a
    # one-stage exact independent draw from the target: E_p[f/q] != Z.
    # q=N(0,1), f=e^{-(x-1)^2/2}; E_p[f/q]/Z=e, analytically.
    wrong_order_analytic_ratio = float(np.e)
    # q=f/Z diagnostic: constant weights and exact normalizer, any schedule.
    zz = rng.normal(size=(19, 2))
    lf_equal = logq(zz)+2.3
    equal_error = float(abs(sum((lf_equal-logq(zz))/9 for _ in range(9))-2.3).max())
    assert gradient_error < 1e-7 and reversal_error < 1e-12 and telescope_error < 1e-12 and equal_error < 1e-12
    return dict(gradient_finite_difference_max_error=gradient_error,
                leapfrog_momentum_flip_involution_max_error=reversal_error,
                no_move_weight_telescope_max_error=telescope_error,
                equal_distribution_constant_weight_max_error=equal_error,
                printed_move_then_weight_one_step_expected_Z_ratio=wrong_order_analytic_ratio,
                inherited_q_covariance_eigenvalues=np.linalg.eigvalsh(INPUT['full_q']['covariance']).tolist(),
                gaussian_direct_IS_analytic_Z_relative_SD_at_N32768=float(np.sqrt((np.exp(9)/(np.sqrt(.25)*np.sqrt(1.75))-1)/32768)))


def main():
    output = dict(status='bounded technical pilot; no learner-time or Colab validation',
                  seeds=SEEDS, runtime=dict(python=platform.python_version(), numpy=np.__version__, scipy=scipy.__version__),
                  checks=checks(), problems={})
    # Fixed before running: two budgets and two bridge lengths; no tuning search.
    for name, diagnostic in [('challenger', False), ('gaussian_mechanism', True)]:
        p = Problem(diagnostic)
        records = []
        summaries = []
        budgets = [4096, 32768] if not diagnostic else [32768]
        configs = [('is', 1), ('mh', 8), ('mh', 32), ('hmc', 8), ('hmc', 32)]
        for budget in budgets:
            for method, stages in configs:
                per_particle = 1 if method == 'is' else stages if method == 'mh' else 1+4*(stages-1)
                n = budget//per_particle
                rows = [run(p, method, stages, n, seed) for seed in SEEDS]
                for r in rows:
                    r['nominal_density_budget'] = budget
                records.extend(rows)
                s = dict(budget=budget, method=method, stages=stages, **summarize(rows, p.truth))
                summaries.append(s)
                print(name, budget, method, stages, 'RMSE', s['query_RMSE'], 'Z rel RMSE', s['Z_relative_RMSE'], flush=True)
        output['problems'][name] = dict(truth=p.truth.tolist(), logZ=p.logZ, summaries=summaries, raw_replicates=records)
    (HERE/'results.json').write_text(json.dumps(output, indent=2, allow_nan=False)+'\n')
    print('algorithm checks', output['checks'], flush=True)


if __name__ == '__main__':
    main()
