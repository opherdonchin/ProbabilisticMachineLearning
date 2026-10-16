"""Actual stochastic pathwise VI; diagnostic deterministic monitoring only."""
import importlib.util
import json
import time
from pathlib import Path
import numpy as np
import torch
from scipy.optimize import minimize
from scipy.special import expit

HERE=Path(__file__).resolve().parent
spec=importlib.util.spec_from_file_location("classifier",HERE.parents[1]/"L07_Inference/notebook_feasibility/classifier_probe.py")
c=importlib.util.module_from_spec(spec); spec.loader.exec_module(c)


def unpack(theta,full):
    m=theta[:2]
    L=np.diag(np.exp(theta[2:4]))
    if full: L[1,0]=theta[4]
    return m,L


def objective(theta,eps,weights,X,y,full):
    m,L=unpack(theta,full)
    W=m+eps@L.T
    z=W@X.T
    # Sum all 60 data likelihood terms, average over weight draws; prior KL once.
    negll=np.sum(np.logaddexp(0,z)-y*z,axis=1)
    KL=.5*((m@m+np.sum(L*L))/4-2+2*np.log(4)-2*np.log(np.diag(L)).sum())
    G=(expit(z)-y)@X
    gm=weights@G+m/4
    gL=(weights[:,None]*G).T@eps+L/4-np.linalg.inv(L).T
    g=np.r_[gm,np.diag(gL)*np.diag(L)]
    if full: g=np.r_[g,gL[1,0]]
    return float(weights@negll+KL),g


def train(seed,full,X,y):
    rng=np.random.default_rng(seed)
    theta=np.r_[np.zeros(2),[-.5,-.5], [0.] if full else []]
    first=np.zeros_like(theta); second=first.copy()
    monitor=[]; egh,wgh=c.gh_nodes()
    start=time.perf_counter()
    for i in range(1,4001):
        eps=rng.normal(size=(64,2))
        _,g=objective(theta,eps,np.full(64,1/64),X,y,full)
        first=.9*first+.1*g; second=.999*second+.001*g*g
        rate=.025 if i<=2000 else .008
        theta-=rate*(first/(1-.9**i))/(np.sqrt(second/(1-.999**i))+1e-8)
        if i%500==0: monitor.append([i,objective(theta,egh,wgh,X,y,full)[0]])
    m,L=unpack(theta,full)
    return theta,dict(seed=seed,mean=m.tolist(),covariance=(L@L.T).tolist(),
        monitor=monitor,seconds=time.perf_counter()-start)


def train_torch(seed,X,y):
    # Same fresh NumPy-generated eps each update as manual train(), but every
    # objective/parameter derivative and Adam update is actually in PyTorch.
    rng=np.random.default_rng(seed)
    theta=torch.tensor([0.,0.,-.5,-.5],dtype=torch.float64,requires_grad=True)
    Xt=torch.tensor(X,dtype=torch.float64);yt=torch.tensor(y,dtype=torch.float64)
    optimizer=torch.optim.Adam([theta],lr=.025)
    egh,wgh=c.gh_nodes();monitor=[];start=time.perf_counter()
    for i in range(1,4001):
        for group in optimizer.param_groups:group["lr"]=.025 if i<=2000 else .008
        optimizer.zero_grad()
        eps=torch.tensor(rng.normal(size=(64,2)),dtype=torch.float64)
        W=theta[:2]+torch.exp(theta[2:])*eps
        z=W@Xt.T
        negll=(torch.nn.functional.softplus(z)-yt*z).sum(1).mean()
        KL=.5*((theta[:2].square().sum()+torch.exp(2*theta[2:]).sum())/4-2+2*np.log(4)-2*theta[2:].sum())
        (negll+KL).backward()
        assert theta.grad is not None and torch.isfinite(theta.grad).all()
        optimizer.step()
        if i%500==0:
            monitor.append([i,objective(theta.detach().numpy(),egh,wgh,X,y,False)[0]])
    result=theta.detach().numpy();m,L=unpack(result,False)
    return result,dict(seed=seed,mean=m.tolist(),covariance=(L@L.T).tolist(),monitor=monitor,
        seconds=time.perf_counter()-start,backend="actual PyTorch float64 reparameterized objective/backward/Adam")


def main():
    torch.set_num_threads(1)
    X,y,Xt,yt,Q,_=c.model(); allq=np.vstack([Q,Xt])
    eps=np.random.default_rng(9).normal(size=(11,2)); weight=np.full(11,1/11)
    checks=[]; fits={}
    egh,wgh=c.gh_nodes()
    reference=json.loads((c.HERE/"classifier_results.json").read_text())
    ref=np.array(reference["grids"][-1]["predictions"])
    for full in [False,True]:
        initial=np.r_[[.1,-.2],[-.4,-.3],[.15] if full else []]
        value,g=objective(initial,eps,weight,X,y,full)
        numeric=[]
        for j in range(len(initial)):
            shift=np.zeros_like(initial);shift[j]=1e-5
            numeric.append((objective(initial+shift,eps,weight,X,y,full)[0]-objective(initial-shift,eps,weight,X,y,full)[0])/2e-5)
        error=float(np.max(abs(g-numeric)));assert error<1e-6
        t=torch.tensor(initial,dtype=torch.float64,requires_grad=True)
        Lt=torch.diag(torch.exp(t[2:4]))
        if full:
            Lt=Lt+torch.stack([t[4]*0,t[4]*0,t[4],t[4]*0]).reshape(2,2)
        W=t[:2]+torch.tensor(eps)@Lt.T
        z=W@torch.tensor(X).T
        negll=(torch.nn.functional.softplus(z)-torch.tensor(y)*z).sum(1).mean()
        KL=.5*((t[:2].square().sum()+Lt.square().sum())/4-2+2*np.log(4)-2*t[2:4].sum())
        (negll+KL).backward()
        autograd_error=float(np.max(abs(t.grad.numpy()-g)));assert autograd_error<1e-10
        checks.append(dict(full=full,max_fixed_noise_gradient_error=error,manual_autograd_error=autograd_error))
        # Deterministic optimum is a supplied author reference, never stochastic training.
        optimum=minimize(lambda t:objective(t,egh,wgh,X,y,full),initial,jac=True,method="BFGS",options={"gtol":1e-8})
        assert np.linalg.norm(optimum.jac)<1e-5
        runs=[]
        for seed in [10,20,30]:
            theta,run=train(seed,full,X,y)
            m,L=unpack(theta,full);pred=c.gaussian_queries(m,L@L.T,allq)
            run.update(objective_gap=objective(theta,egh,wgh,X,y,full)[0]-optimum.fun,
                predictions=pred.tolist(),max_prediction_error=float(np.max(abs(pred-ref))))
            runs.append(run)
        m,L=unpack(optimum.x,full)
        fits["full" if full else "diagonal"]=dict(runs=runs,diagnostic_optimum=dict(objective=float(optimum.fun),
            mean=m.tolist(),covariance=(L@L.T).tolist(),predictions=c.gaussian_queries(m,L@L.T,allq).tolist()))
    torch_runs=[]
    for seed in [10,20,30]:
        theta,run=train_torch(seed,X,y);m,L=unpack(theta,False)
        pred=c.gaussian_queries(m,L@L.T,allq)
        manual=next(r for r in fits["diagonal"]["runs"] if r["seed"]==seed)
        run.update(predictions=pred.tolist(),max_prediction_error=float(np.max(abs(pred-ref))),
            objective_gap=objective(theta,egh,wgh,X,y,False)[0]-fits["diagonal"]["diagnostic_optimum"]["objective"],
            manual_mean_max_difference=float(np.max(abs(m-np.array(manual["mean"])))),
            manual_cov_max_difference=float(np.max(abs(L@L.T-np.array(manual["covariance"])))),
            manual_prediction_max_difference=float(np.max(abs(pred-np.array(manual["predictions"])))))
        torch_runs.append(run)
    S=np.array([[.5,.4],[.4,.5]]);D=np.diag(1/np.diag(np.linalg.inv(S)))
    diagnostic=dict(target_covariance=S.tolist(),best_diagonal_covariance=D.tolist(),
        minimum_reverse_KL=float(.5*np.log(np.linalg.det(S)/np.linalg.det(D))),
        sum_variances=[float(np.ones(2)@S@np.ones(2)),float(np.ones(2)@D@np.ones(2))],
        difference_variances=[float(np.array([1,-1])@S@np.array([1,-1])),float(np.array([1,-1])@D@np.array([1,-1]))])
    # Actual stochastic optimizer on the separately identifiable Gaussian target.
    precision=np.linalg.inv(S);gaussian_runs=[]
    for seed in [10,20,30]:
        rng=np.random.default_rng(seed);theta=np.array([.6,-.6,-.3,-.3]);a=np.zeros(4);b=np.zeros(4)
        for i in range(1,3001):
            eps=rng.normal(size=(64,2));sigma=np.exp(theta[2:]);W=theta[:2]+sigma*eps
            G=W@precision
            grad=np.r_[G.mean(0),(G*eps*sigma).mean(0)-1]
            a=.9*a+.1*grad;b=.999*b+.001*grad*grad
            rate=.02 if i<=1500 else .006
            theta-=rate*(a/(1-.9**i))/(np.sqrt(b/(1-.999**i))+1e-8)
        m=theta[:2];cov=np.diag(np.exp(2*theta[2:]));kl=.5*(np.trace(precision@cov)+m@precision@m-2+np.log(np.linalg.det(S)/np.linalg.det(cov)))
        gaussian_runs.append(dict(seed=seed,mean=m.tolist(),covariance=cov.tolist(),reverse_KL=float(kl),optimizer_gap=float(kl-diagnostic["minimum_reverse_KL"])))
    diagnostic["actual_stochastic_fits"]=gaussian_runs
    c.write_json(HERE/"pathwise_results.json",dict(status="actual stochastic VI; author-only; no Colab/student-time pass",torch_version=torch.__version__,fixed_noise_checks=checks,fits=fits,torch_diagonal_runs=torch_runs,exact_gaussian_diagnostic=diagnostic))
    print(json.dumps(dict(checks=checks,objective_gaps={k:[r["objective_gap"] for r in v["runs"]] for k,v in fits.items()})))


if __name__=="__main__":main()
