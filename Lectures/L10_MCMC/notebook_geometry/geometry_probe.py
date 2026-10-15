"""Author-only real-data VI/MH screening; no notebook or sampler selection.

Run with the existing locked course Python; outputs are confined to this folder.
Centered and noncentered Eight Schools use the SAME prior and likelihood.
No source-supplied sampler output is used as a numerical reference.
"""
from pathlib import Path
import hashlib
import importlib.util
import json
import platform
import resource
import subprocess
import sys
import time
import urllib.request

sys.dont_write_bytecode = True  # Imported baseline probes remain read-only.

import numpy as np
import scipy
from scipy.integrate import quad
from scipy.optimize import minimize
from scipy.special import expit, logsumexp, ndtr
from scipy.stats import norm, qmc
import torch
import torch.nn.functional as F

HERE = Path(__file__).resolve().parent
ROOT = HERE.parents[2]
torch.set_default_dtype(torch.float64)
torch.set_num_threads(1)
spec = importlib.util.spec_from_file_location("old_mh", HERE.parent / "notebook_feasibility/mh_probe.py")
old = importlib.util.module_from_spec(spec)
spec.loader.exec_module(old)
Y = np.array([28, 8, -3, 7, -1, 1, 18, 12.])
SIGMA = np.array([15, 10, 16, 11, 9, 11, 10, 18.])
X = np.array([-.86, -.30, -.05, .73])
DEATHS = np.array([0, 1, 3, 5.])
N = np.full(4, 5.)


def digest(path):
    return hashlib.sha256(Path(path).read_bytes()).hexdigest()


def dump(path, data):
    Path(path).write_text(json.dumps(data, indent=2, allow_nan=False) + "\n")


def logp(z, case):
    z = np.atleast_2d(z)
    if case == "bioassay":
        logits = z[:, :1] + z[:, 1:2] * X
        return (DEATHS * logits - N * np.logaddexp(0, logits)).sum(1) - .5 * (z*z).sum(1)/25
    mu, ell, group = z[:, 0], z[:, 1], z[:, 2:]
    tau = np.exp(ell)
    prior = -.5*(mu/5)**2 + ell - np.logaddexp(0, 2*ell-np.log(25))
    if case == "centered":
        prior += -8*ell - .5*(((group-mu[:, None])/tau[:, None])**2).sum(1)
        theta = group
    else:
        prior += -.5*(group*group).sum(1)
        theta = mu[:, None] + tau[:, None]*group
    return prior - .5*(((Y-theta)/SIGMA)**2).sum(1)


def torch_logp(z, case):
    if case == "bioassay":
        logits = z[:, :1] + z[:, 1:2]*torch.tensor(X)
        return (torch.tensor(DEATHS)*logits-torch.tensor(N)*F.softplus(logits)).sum(1)-.5*z.square().sum(1)/25
    mu, ell, group = z[:, 0], z[:, 1], z[:, 2:]
    tau = ell.exp()
    prior = -.5*(mu/5).square()+ell-F.softplus(2*ell-np.log(25))
    if case == "centered":
        prior = prior-8*ell-.5*((group-mu[:, None])/tau[:, None]).square().sum(1)
        theta = group
    else:
        prior = prior-.5*group.square().sum(1)
        theta = mu[:, None]+tau[:, None]*group
    return prior-.5*((torch.tensor(Y)-theta)/torch.tensor(SIGMA)).square().sum(1)


def initial(case):
    if case == "bioassay":
        return np.array([.5, 6.]), np.diag([.8, 2.5])
    mean = np.r_[4., np.log(3.), np.full(8, 4.) if case == "centered" else np.zeros(8)]
    return mean, np.diag(np.r_[3., .7, np.full(8, 3. if case == "centered" else .8)])


def pack(mean, chol):
    d = len(mean)
    i, j = np.tril_indices(d)
    entries = chol[i, j].copy()
    entries[i == j] = np.log(entries[i == j])
    return np.r_[mean, entries]


def unpack(t, d):
    i, j = torch.tril_indices(d, d)
    vals = torch.where(i == j, t[d:].exp(), t[d:])
    chol = torch.zeros((d, d), dtype=t.dtype).index_put((i, j), vals)
    return t[:d], chol


GH, GW = np.polynomial.hermite.hermgauss(64)
GH = torch.tensor(GH*np.sqrt(2))
GW = torch.tensor(GW/np.sqrt(np.pi))


def expected_objective(t, case, high_order=False):
    """-E log u - log|L|: deterministic Gaussian expectation, entropy constants dropped.

    Bioassay likelihood is a sum of scalar softplus expectations. Schools uses
    Gaussian exponential tilting identities, with ONLY the log-Cauchy term
    requiring 1D Gauss-Hermite quadrature. This is an author optimizer diagnostic,
    not an additional student variational algorithm.
    """
    if high_order:
        h,w=np.polynomial.hermite.hermgauss(128)
        gh,gw=torch.tensor(h*np.sqrt(2)),torch.tensor(w/np.sqrt(np.pi))
    else:gh,gw=GH,GW
    d = 2 if case == "bioassay" else 10
    m, L = unpack(t, d)
    C = L@L.T
    entropy = torch.log(torch.diag(L)).sum()
    if case == "bioassay":
        A = torch.tensor(np.column_stack([np.ones(4), X]))
        means = A@m
        variances = (A@C*A).sum(1)
        e_soft = (F.softplus(means[:, None]+variances.sqrt()[:, None]*gh)*gw).sum(1)
        return (torch.tensor(N)*e_soft-torch.tensor(DEATHS)*means).sum()+.5*(m.square().sum()+C.trace())/25-entropy
    mell, vell = m[1], C[1, 1]
    elogprior = -.5*(m[0]**2+C[0, 0])/25+mell
    elogprior -= (F.softplus(2*(mell+vell.sqrt()*gh)-np.log(25))*gw).sum()
    if case == "centered":
        md = m[2:]-m[0]
        vd = torch.diag(C)[2:]+C[0, 0]-2*C[2:, 0]
        cov = C[2:, 1]-C[0, 1]
        elogprior = elogprior-8*mell-.5*torch.exp(-2*mell+2*vell)*(vd+(md-2*cov).square()).sum()
        residual = (torch.tensor(Y)-m[2:]).square()+torch.diag(C)[2:]
    else:
        # E[(y-mu-exp(ell)*eta)^2], including all correlations with ell.
        eg = torch.exp(mell+.5*vell)*(m[2:]+C[2:, 1])
        emug = torch.exp(mell+.5*vell)*((m[0]+C[0, 1])*(m[2:]+C[2:, 1])+C[0, 2:])
        eg2 = torch.exp(2*mell+2*vell)*(torch.diag(C)[2:]+(m[2:]+2*C[2:, 1]).square())
        residual = (torch.tensor(Y)-m[0]).square()+C[0, 0]-2*(torch.tensor(Y)*eg-emug)+eg2
        elogprior = elogprior-.5*(m[2:].square()+torch.diag(C)[2:]).sum()
    elogp = elogprior-.5*(residual/torch.tensor(SIGMA**2)).sum()
    return -elogp-entropy


def objective_np(t, case):
    t = torch.tensor(t, requires_grad=True)
    v = expected_objective(t, case)
    v.backward()
    return float(v.detach()), t.grad.numpy()


def get_params(t, d):
    m, L = unpack(torch.tensor(t), d)
    return m.numpy(), L.numpy()


def query(z, case):
    z = np.atleast_2d(z)
    if case == "bioassay":
        p = expit(z[:, :1]+z[:, 1:2]*np.array([-.3, 0., .3]))
        # Posterior probability toxicity at an observed low dose exceeds 0.2.
        return np.column_stack([z, p, (z[:, 0]-.3*z[:, 1] > np.log(.2/.8)), z[:, 1] > 10])
    mu, ell, g = z[:, 0], z[:, 1], z[:, 2:]
    tau = np.exp(ell)
    theta = g if case == "centered" else mu[:, None]+tau[:, None]*g
    # tau<1 is high pooling; shrinkage weight for school1 and positive school1 effect.
    return np.column_stack([mu, ell, tau, tau<1, SIGMA[0]**2/(SIGMA[0]**2+tau*tau), theta[:, 0], theta[:, 0] > 0])


LABELS = {
    "bioassay": ["E alpha", "E beta", "predict(-.3)", "predict(0)", "predict(.3)", "P(p(-.3)>.2)", "P(beta>10)"],
    "schools": ["E mu", "E logtau", "E tau", "P(tau<1)", "E shrinkage_school1", "E theta1", "P(theta1>0)"]}


def gaussian_queries(m, L, case, seed=913):
    # Smooth queries use 2^17 scrambled Sobol draws; repeat seeds quantify query integration.
    z = norm.ppf(qmc.Sobol(len(m), scramble=True, seed=seed).random_base2(17))@L.T+m
    values = query(z, case).mean(0)
    # Exact univariate Normal probabilities/means remove avoidable indicator MC noise.
    C = L@L.T
    if case == "bioassay":
        values[:2] = m
        a = np.array([1., -.3])
        values[5] = ndtr((a@m-np.log(.2/.8))/np.sqrt(a@C@a))
        values[6] = ndtr((m[1]-10)/np.sqrt(C[1, 1]))
    else:
        values[:3] = [m[0], m[1], np.exp(m[1]+C[1, 1]/2)]
        values[3] = ndtr(-m[1]/np.sqrt(C[1, 1]))
        if case == "centered":
            values[5:7] = [m[2], ndtr(m[2]/np.sqrt(C[2, 2]))]
    return values


def vi_fit(case):
    d = 2 if case == "bioassay" else 10
    start = pack(*initial(case))
    # Three dispersed deterministic starts assess local optimizer sensitivity.
    opts = []
    for shift in [-.4, 0., .4]:
        s = start.copy(); s[:d] += shift
        clock = time.perf_counter()
        r = minimize(lambda t: objective_np(t, case), s, jac=True, method="BFGS", options={"gtol":1e-7,"maxiter":1500})
        m, L = get_params(r.x, d)
        opts.append(dict(success=bool(r.success), message=str(r.message), objective=float(r.fun), grad_norm=float(np.linalg.norm(r.jac)),
                         seconds=time.perf_counter()-clock, shift=shift, parameters=r.x.tolist(), mean=m.tolist(), covariance=(L@L.T).tolist(),
                         queries=gaussian_queries(m, L, case).tolist()))
    optimum = min(opts, key=lambda r:r["objective"])
    # Actual stochastic pathwise VI using fresh noise, three independent seeds.
    runs = []
    for seed in [101,202,303]:
        torch.manual_seed(seed)
        t = torch.tensor(start, requires_grad=True)
        optimizer = torch.optim.Adam([t], lr=.018)
        clock = time.perf_counter()
        checkpoints = []
        for step in range(1,6001):
            if step == 3001:
                optimizer.param_groups[0]["lr"] = .004
            m, L = unpack(t, d)
            eps = torch.randn(128, d)
            loss = -torch_logp(m+eps@L.T, case).mean()-torch.log(torch.diag(L)).sum()
            optimizer.zero_grad();loss.backward();optimizer.step()
            if step in [1,1000,3000,6000]:
                checkpoints.append([step, float(expected_objective(t, case).detach())])
        theta = t.detach().numpy(); m,L=get_params(theta,d)
        val, grad = objective_np(theta,case)
        runs.append(dict(seed=seed, steps=6000,batch=128,seconds=time.perf_counter()-clock,objective=val,objective_gap=val-optimum["objective"],
                         gradient_norm=float(np.linalg.norm(grad)),mean=m.tolist(),covariance=(L@L.T).tolist(),queries=gaussian_queries(m,L,case).tolist(),
                         objective_checkpoints=checkpoints))
    tbest=torch.tensor(optimum["parameters"])
    quadrature_difference=float((expected_objective(tbest,case,True)-expected_objective(tbest,case)).detach())
    return dict(family="full covariance Gaussian reverse-KL; coordinates explicitly case-dependent", author_deterministic_fits=opts, stochastic_fits=runs,
                gh128_minus_gh64_objective_at_best_fit=quadrature_difference,
                optimizer_qualification="Best observed stationary BFGS solution across three starts, not a proven global optimum; stochastic gaps use that solution."), get_params(np.array(optimum["parameters"]),d)


def schools_reference():
    # Integrate theta analytically: y_j|mu,tau ~ N(mu,sigma_j^2+tau^2).
    # Then integrate mu analytically using its N(0,25) prior. Only tau remains.
    def scalar(ell):
        tau = np.exp(ell);v = SIGMA**2+tau*tau
        prec = 1/25+(1/v).sum();vm = 1/prec;mm = vm*(Y/v).sum()
        lp = -.5*np.log(v).sum()-.5*(Y*Y/v).sum()+.5*mm*mm/ vm+.5*np.log(vm)
        lp += ell-np.logaddexp(0,2*ell-np.log(25))
        return lp,mm,vm
    mode = minimize(lambda e:-scalar(float(e[0]))[0], [1.]).x[0]
    offset = scalar(mode)[0]
    def values(ell):
        lp,mm,vm = scalar(ell);tau=np.exp(ell)
        w=SIGMA[0]**2/(SIGMA[0]**2+tau*tau)
        mt=w*mm+(1-w)*Y[0]
        vt=1/(1/SIGMA[0]**2+1/(tau*tau))+w*w*vm
        return np.array([mm,ell,tau,float(ell<0),w,mt,ndtr(mt/np.sqrt(vt))])
    records=[]
    for lo,hi,tol in [(-16,6,1e-9),(-24,8,1e-11)]:
        clock=time.perf_counter()
        Z,err=quad(lambda e:np.exp(scalar(e)[0]-offset),lo,hi,epsabs=tol,epsrel=tol,points=[0],limit=400)
        nums=[quad(lambda e:np.exp(scalar(e)[0]-offset)*values(e)[j],lo,hi,epsabs=tol,epsrel=tol,points=[0],limit=400) for j in range(7)]
        records.append(dict(logtau_domain=[lo,hi],eps=tol,normalizer_scaled=Z,quad_error_scaled=err,queries=[n[0]/Z for n in nums],
                            numerator_quad_errors=[n[1]/Z for n in nums],seconds=time.perf_counter()-clock))
    # Independent direct 2D tensor trapezoid in mu,logtau, including normalized
    # conditional theta1 query. Domain/mesh refined; no copied HMC "truth".
    grids=[]
    for n in [501,1001]:
        mus=np.linspace(-35,35,n);ells=np.linspace(-20,7,n)
        MU,ELL=np.meshgrid(mus,ells,indexing="ij");TAU=np.exp(ELL)
        lp=-.5*(MU/5)**2+ELL-np.logaddexp(0,2*ELL-np.log(25))
        for y,s in zip(Y,SIGMA):
            v=s*s+TAU*TAU
            lp+=-.5*np.log(v)-.5*(y-MU)**2/v
        mass=np.exp(lp-lp.max());mass[[0,-1],:]*=.5;mass[:,[0,-1]]*=.5;mass/=mass.sum()
        w=SIGMA[0]**2/(SIGMA[0]**2+TAU*TAU);mt=w*MU+(1-w)*Y[0]
        vt=1/(1/SIGMA[0]**2+1/(TAU*TAU))
        # discontinuous tau<1 handled by 1D adaptive reference, not this mesh.
        qs=[MU,ELL,TAU,(TAU<1),w,mt,ndtr(mt/np.sqrt(vt))]
        grids.append(dict(shape=[n,n],queries=[float((mass*v).sum()) for v in qs]))
    density_x=np.linspace(-8,4,301)
    density_y=[float(np.exp(scalar(e)[0]-offset)/records[-1]["normalizer_scaled"]) for e in density_x]
    return dict(adaptive_1d=records,independent_2d_grids=grids,reference=records[-1]["queries"],logtau_density=dict(x=density_x.tolist(),y=density_y),
                qualification="Float64 adaptive quadrature plus domain/tolerance and independent mesh checks; not interval-certified. tau<1 grid discontinuity excluded from mesh accuracy claims.")


def bio_reference():
    records=[]
    for extent,n in [(25.,1001),(32.,1601)]:
        a=np.linspace(-extent,extent,n);b=np.linspace(-extent,extent,n)
        A,B=np.meshgrid(a,b,indexing="ij");z=np.column_stack([A.ravel(),B.ravel()])
        clock=time.perf_counter();lp=logp(z,"bioassay").reshape(n,n)
        raw=np.exp(lp-lp.max());raw[[0,-1],:]*=.5;raw[:,[0,-1]]*=.5
        Z=raw.sum()*(2*extent/(n-1))**2
        mass=raw/raw.sum();qs=query(z,"bioassay").reshape(n,n,-1)
        vals=(qs*mass[:,:,None]).sum((0,1))
        records.append(dict(domain=[-extent,extent],shape=[n,n],queries=vals.tolist(),normalizer_scaled=Z,
                            outer_strip_mass=float(mass[:10,:].sum()+mass[-10:,:].sum()+mass[:, :10].sum()+mass[:, -10:].sum()),
                            seconds=time.perf_counter()-clock,main_array_bytes=int(z.nbytes+qs.nbytes+raw.nbytes+mass.nbytes)))
    # Smooth bounded toxicity-threshold event integrated by conditional alpha
    # quadrature, split along alpha=logit(.2)+.3 beta to remove mesh staircasing.
    mode=minimize(lambda z:-logp(z,"bioassay")[0],[.5,6.]).x
    offset=logp(mode,"bioassay")[0]
    def inner(b,event=False):
        lo=np.log(.2/.8)+.3*b if event else -40.
        return quad(lambda a:np.exp(logp([a,b],"bioassay")[0]-offset),lo,40,epsabs=1e-9,epsrel=1e-9)[0]
    Z,ze=quad(lambda b:inner(b),-40,40,epsabs=1e-8,epsrel=1e-8)
    ev,ee=quad(lambda b:inner(b,True),-40,40,epsabs=1e-8,epsrel=1e-8)
    tail,te=quad(lambda b:inner(b),10,40,epsabs=1e-8,epsrel=1e-8)
    ref=np.array(records[-1]["queries"]);ref[5:7]=[ev/Z,tail/Z]
    return dict(grids=records,beta_density=dict(x=b.tolist(),y=(mass.sum(0)/(b[1]-b[0])).tolist()),
                adaptive_event_checks=dict(domain=[-40,40],queries=[ev/Z,tail/Z],scaled_errors=[ze,ee,te]),reference=ref.tolist(),
                qualification="Refined float64 finite-domain grid; adaptive integration of discontinuous events. Outer-strip mass and prior tails are checks, not formal relative posterior-tail bounds.")


def mh_runs(case, scale, L, reference, n=50000, burn=10000):
    d=2 if case=="bioassay" else 10
    if d==2:
        starts=[[0.,1.],[2.,12.],[-2.,3.],[4.,18.]]
    else:
        starts=[]
        for mu,tau,g in [(0.,.1,-.5),(8.,1.,.5),(-5.,10.,-.3),(5.,20.,.3)]:
            group=np.full(8,mu+tau*g) if case=="centered" else np.full(8,g)
            starts.append(np.r_[mu,np.log(tau),group].tolist())
    records=[];traces=[];arrays=[]
    for seed,start in zip([11,22,33,44],starts):
        draws,record=old.mh(lambda z:logp(z,case)[0],start,L*scale,seed,n=n,burn=burn)
        assert abs(record["repeat_fraction"]-(1-record["acceptance"])) < 2/n
        vals=query(draws,case);stats=[];constant_guard=[]
        for j,v in enumerate(vals.T):
            raw=old.diagnostics(v)
            if np.ptp(v)==0:
                # A constant array's computed variance can be tiny but nonzero
                # through summation rounding. Never report spurious precision.
                constant_guard.append(dict(query_index=j,legacy_output=raw,repair="range==0: MCSE and ESS unassessed"))
                raw=dict(mean=float(v[0]),batch_mcse=None,ess=None,warning="constant query; global error unassessed")
            stats.append(raw)
        # Distinct batch lengths test sensitivity to slow dependence.
        batchses=[]
        for size in [100,500,1000]:
            nb=len(vals)//size;means=vals[:nb*size].reshape(nb,size,-1).mean(1)
            ses=np.sqrt(means.var(0,ddof=1)/nb)
            batchses.append(dict(length=size,mcse=[None if np.ptp(vals[:,j])==0 else float(se) for j,se in enumerate(ses)]))
        region=(draws[:,1]<0) if d==10 else (draws[:,1]>10)
        record.update(case=case,start=start,proposal_scale=scale,proposal_cholesky=(L*scale).tolist(),
                      queries=stats,reference_error=(vals.mean(0)-reference).tolist(),batch_sensitivity=batchses,constant_query_guard_evidence=constant_guard,
                      retained_draw_bytes=int(draws.nbytes),query_array_bytes=int(vals.nbytes),
                      region_crossings=int(np.sum(region[1:]!=region[:-1])),region_fraction=float(region.mean()),
                      coordinate_min=draws.min(0).tolist(),coordinate_max=draws.max(0).tolist(),
                      first_half_queries=vals[:len(vals)//2].mean(0).tolist(),second_half_queries=vals[len(vals)//2:].mean(0).tolist())
        records.append(record);arrays.append(vals)
        indices=np.linspace(0,len(draws)-1,200,dtype=int)
        traces.append(dict(seed=seed,retained_index=indices.tolist(),coordinates=draws[indices].tolist(),query_values=vals[indices].tolist()))
    # Ordinary split Rhat supplied as another qualified check, not rank-normalized
    # folded Rhat or convergence proof. New diagnostics implementation not assigned.
    halves=np.concatenate([np.stack(arrays)[:,:len(arrays[0])//2],np.stack(arrays)[:,len(arrays[0])//2:]],axis=0)
    length=halves.shape[1];W=halves.var(1,ddof=1).mean(0);B=length*halves.mean(1).var(0,ddof=1)
    rhat=np.sqrt(((length-1)/length*W+B/length)/W)
    return dict(runs=records,ordinary_split_rhat=rhat.tolist(),diagnostic_warning="Batch MCSE/heuristic positive odd-lag-pair ESS/split Rhat are conditional estimates; no global exploration or CLT certificate; no rank-normalized diagnostic library."),traces


def checks():
    records=[]
    for case in ["bioassay","centered","noncentered"]:
        m,L=initial(case);t=pack(m,L);val,grad=objective_np(t,case)
        numeric=[]
        for j in range(len(t)):
            e=np.zeros_like(t);e[j]=1e-5
            numeric.append((objective_np(t+e,case)[0]-objective_np(t-e,case)[0])/2e-5)
        maxerr=float(np.max(np.abs(grad-numeric)));assert maxerr<2e-6
        eps=norm.ppf(qmc.Sobol(len(m),scramble=True,seed=77).random_base2(18))
        z=m+eps@L.T
        torcherr=float(np.max(np.abs(torch_logp(torch.tensor(z[:17]),case).numpy()-logp(z[:17],case))))
        assert torcherr<1e-10
        stochastic=float(-logp(z,case).mean()-np.log(np.diag(L)).sum())
        iid=m+np.random.default_rng(773).normal(size=(262144,len(m)))@L.T
        iidvals=-logp(iid,case)-np.log(np.diag(L)).sum()
        iidse=float(iidvals.std(ddof=1)/np.sqrt(len(iidvals)))
        iiderr=float(iidvals.mean()-val)
        assert abs(iiderr)<6*iidse
        records.append(dict(case=case,gradient_max_error=maxerr,numpy_torch_logp_error=torcherr,
                            deterministic_objective=val,sobol_objective=stochastic,expectation_check_difference=stochastic-val,
                            independent_iid_expectation_error=iiderr,independent_iid_se=iidse))
    m,L=initial("noncentered");z=m+np.random.default_rng(4).normal(size=(23,10))@L.T
    cp=z.copy();cp[:,2:]=z[:,:1]+np.exp(z[:,1:2])*z[:,2:]
    jacerr=float(np.max(abs(logp(z,"noncentered")-logp(cp,"centered")-8*z[:,1])))
    assert jacerr<1e-10
    return dict(gaussian_objective_checks=records,centered_noncentered_log_jacobian_error=jacerr)


def manifest():
    sources=[("eight_schools_data", "https://mc-stan.org/rstan/articles/rstan.html"),
             ("eight_schools_model", "https://mc-stan.org/learn-stan/case-studies/divergences_and_bias.html"),
             ("bioassay_data_model", "https://arviz-devs.github.io/bayesian-workflow/bioassay/bioassay.html")]
    records=[]
    cache=Path("/tmp/pml-l10-geometry-source-cache");cache.mkdir(exist_ok=True)
    for key,url in sources:
        p=cache/(key+".html")
        if not p.exists():
            p.write_bytes(urllib.request.urlopen(url).read())
        records.append(dict(key=key,url=url,sha256=digest(p),bytes=p.stat().st_size,cache_path=str(p),retrieved="2026-10-15"))
    inputs=["AGENTS.md","course_architecture.typ","curriculum_map.typ","curriculum_map_actual.typ","pyproject.toml","uv.lock",
            "Lectures/course_architecture_scope/reconciliation/notebook_geometry/decision_and_tasks.md",
            "Lectures/L10_MCMC/lecture_scope.md","Lectures/L10_MCMC/scope_investigation.md","Lectures/L10_MCMC/source_arc_review.md",
            "Lectures/L10_MCMC/notebook_feasibility/mh_probe.py","Lectures/L10_MCMC/notebook_feasibility/mh_results.json",
            "Lectures/L09_Variational_Inference/lecture_scope.md","Lectures/L09_Variational_Inference/scope_investigation.md",
            "Lectures/L09_Variational_Inference/source_arc_review.md","Lectures/L09_Variational_Inference/notebook_feasibility/pathwise_probe.py",
            "Lectures/L07_Inference/lecture_scope.md","Lectures/L07_Inference/scope_investigation.md","Lectures/L07_Inference/source_arc_review.md",
            ".agents/skills/lecture-scope/SKILL.md",".agents/skills/lecture-scope/references/timing-calibration.md",
            ".agents/skills/worked-solution-authoring/SKILL.md",".agents/skills/teaching-notebook-authoring/references/student-knowledge.md",
            ".agents/skills/shared/backpressure.md"]
    data=dict(eight_schools=dict(y=Y.tolist(),standard_errors=SIGMA.tolist()),bioassay=dict(logdose=X.tolist(),n=N.tolist(),deaths=DEATHS.tolist()))
    return dict(base_commit=subprocess.check_output(["git","rev-parse","HEAD"],cwd=ROOT,text=True).strip(),
                inputs={p:digest(ROOT/p) for p in inputs},sources=records,data=data,
                data_sha256=hashlib.sha256(json.dumps(data,sort_keys=True).encode()).hexdigest(),probe_sha256=digest(__file__),
                book2_text_sha256=digest("/tmp/pml-book2.txt"),book1_text_sha256=digest("/tmp/pml-book1.txt"),
                environment=dict(python=platform.python_version(),numpy=np.__version__,scipy=scipy.__version__,torch=torch.__version__,platform=platform.platform()),
                run_command="PYTHONDONTWRITEBYTECODE=1 MPLCONFIGDIR=/tmp/pml-l10-mpl /tmp/pml-l04-l12-reconciliation/.venv/bin/python Lectures/L10_MCMC/notebook_geometry/geometry_probe.py")


def plot(results,traces):
    import matplotlib
    matplotlib.use("Agg")
    import matplotlib.pyplot as plt
    fig,axs=plt.subplots(2,3,figsize=(13,7))
    for ax,case in zip(axs[0],["bioassay","centered","noncentered"]):
        vi=results[case]["vi"];d=2 if case=="bioassay" else 10
        r=min(vi["author_deterministic_fits"],key=lambda a:a["objective"])
        sd=np.sqrt(np.array(r["covariance"])[1,1]);mean=r["mean"][1]
        rng=np.linspace(-8,4,250) if d==10 else np.linspace(-4,20,250)
        ax.plot(rng,norm.pdf(rng,mean,sd),label="full Gaussian VI")
        reference=results["references"]["bioassay" if d==2 else "schools"]
        density=reference["beta_density" if d==2 else "logtau_density"]
        ax.plot(density["x"],density["y"],color="black",ls="--",label="quadrature reference")
        for entry in traces[case+"_main"]:
            coord=np.array(entry["coordinates"])[:,1]
            ax.hist(coord,bins=30,density=True,histtype="step",alpha=.5)
        ax.set(title=case,xlabel="beta" if d==2 else "log tau",ylabel="density");ax.legend(fontsize=8)
        ax.set_xlim(rng[0],rng[-1])
    for ax,case in zip(axs[1],["bioassay","centered","noncentered"]):
        d=2 if case=="bioassay" else 10
        for entry in traces[case+"_main"]:
            ax.plot(entry["retained_index"],np.array(entry["coordinates"])[:,1],lw=.7,label=str(entry["seed"]))
        ax.set(xlabel="retained transition index (200-point visual subsample)",ylabel="beta" if d==2 else "log tau")
    fig.suptitle("Author screening: sparse traces are visual aids; full chains determine recorded diagnostics")
    fig.tight_layout();fig.savefig(HERE/"screening.png",dpi=150);plt.close(fig)


def main():
    clock=time.perf_counter();results=dict(status="Author-only bounded screening; no chosen family/model, student workload or hosted-Colab pass",checks=checks())
    dump(HERE/"source_manifest.json",manifest())
    refs={"bioassay":bio_reference(),"schools":schools_reference()};results["references"]=refs
    traces={}
    for case in ["bioassay","centered","noncentered"]:
        vi,(m,L)=vi_fit(case)
        reference=np.array(refs["bioassay" if case=="bioassay" else "schools"]["reference"])
        for key in ["author_deterministic_fits","stochastic_fits"]:
            for r in vi[key]:r["reference_error"]=(np.array(r["queries"])-reference).tolist()
        results[case]=dict(vi=vi,query_order=LABELS["bioassay" if case=="bioassay" else "schools"])
        # Use the fitted Gaussian as a supplied fixed proposal preconditioner;
        # different logscale proposal width avoids treating its narrow ell as optimal.
        if case=="noncentered":
            proposal=np.diag(np.r_[3.,1.,np.full(8,.8)])
        else:proposal=L
        main,tr=mh_runs(case,1. if case=="bioassay" else .65,proposal,reference)
        results[case]["mh_main"]=main;traces[case+"_main"]=tr
        if case=="bioassay":
            small,tr=mh_runs(case,.08,proposal,reference,n=10000,burn=2000)
            results[case]["mh_small_proposal"]=small;traces[case+"_small"]=tr
        results[case]["gaussian_query_repeat_difference"]=(gaussian_queries(m,L,case,914)-gaussian_queries(m,L,case,913)).tolist()
        dump(HERE/"probe_results.json",results);dump(HERE/"trace_subsamples.json",traces)
        print(case, "VI errors",np.round(vi["author_deterministic_fits"][1]["reference_error"],4),
              "MH errors",np.round([r["reference_error"] for r in main["runs"]],4),flush=True)
    results["total_seconds"]=time.perf_counter()-clock
    results["max_resident_kib"]=resource.getrusage(resource.RUSAGE_SELF).ru_maxrss
    results["diagnostic_implementation_sha256"]=digest(HERE.parent/"notebook_feasibility/mh_probe.py")
    dump(HERE/"probe_results.json",results);plot(results,traces)
    print("completed",results["total_seconds"],flush=True)


if __name__=="__main__":
    main()
