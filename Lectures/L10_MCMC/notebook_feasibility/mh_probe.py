"""Finite MH estimates, retained rejections, query errors and exploration stress."""
import importlib.util
import json
import time
from pathlib import Path
import numpy as np
from scipy.special import expit, logsumexp, ndtr

HERE=Path(__file__).resolve().parent
spec=importlib.util.spec_from_file_location("classifier",HERE.parents[1]/"L07_Inference/notebook_feasibility/classifier_probe.py")
c=importlib.util.module_from_spec(spec);spec.loader.exec_module(c)


def mh(logp,start,L,seed,n=15000,burn=3000):
    rng=np.random.default_rng(seed); state=np.array(start,dtype=float);current=logp(state)
    draws=np.empty((n,len(state)));accepted=0;clock=time.perf_counter()
    for i in range(n):
        proposal=state+L@rng.normal(size=len(state));proposed=logp(proposal)
        if np.log(rng.uniform()) < min(0.,proposed-current):
            state=proposal;current=proposed;accepted+=1
        draws[i]=state  # rejected states are observations, too
    return draws[burn:],dict(seed=seed,transitions=n,discard=burn,acceptance=accepted/n,
        repeat_fraction=float(np.mean(np.all(draws[1:]==draws[:-1],axis=1))),seconds=time.perf_counter()-clock)


def diagnostics(values):
    # Nonoverlapping batch MCSE and a heuristic positive adjacent odd-lag-pair
    # ACF cutoff. This is NOT canonical Geyer IPS: it pairs lags1+2,3+4,... and
    # forces tau>=1, so it cannot describe antithetic ESS>N.
    # These estimate stationary asymptotic errors only when exploration/CLT assumptions hold.
    values=np.asarray(values); n=len(values);mean=values.mean();var=values.var(ddof=1)
    if var==0:
        return dict(mean=float(mean),batch_mcse=None,ess=None,warning="constant query; global error unassessed")
    b=int(np.sqrt(n));a=n//b
    batch=values[:a*b].reshape(a,b).mean(1)
    mcse=np.sqrt(batch.var(ddof=1)/a)
    centered=values-mean;size=1<<(2*n-1).bit_length()
    transform=np.fft.rfft(centered,size)
    acov=np.fft.irfft(transform*np.conjugate(transform),size)[:min(n,3001)]/n
    rho=acov/acov[0];pair_sum=0.
    for k in range(1,len(rho)-1,2):
        pair=rho[k]+rho[k+1]
        if pair<=0:break
        pair_sum+=pair
    return dict(mean=float(mean),batch_mcse=float(mcse),ess=float(n/(1+2*pair_sum)),warning="conditional estimate; not convergence proof")


def main():
    X,y,Xt,yt,Q,_=c.model();m,C=c.laplace(X,y)
    ref=json.loads((c.HERE/"classifier_results.json").read_text())["grids"][-1]
    predictions=np.array(ref["predictions"][:5]);reference=np.r_[ref["mean"],predictions]
    runs=[]
    for scale in [.3,1.,3.]:
        for seed,start in zip([11,22,33,44],[m+[-2,-2],m+[2,2],m+[-2,2],m+[2,-2]]):
            draws,record=mh(lambda w:-c.nll(w,X,y),start,scale*np.linalg.cholesky(C),seed)
            vals=np.column_stack([draws,expit(draws@Q.T)])
            stats=[diagnostics(v) for v in vals.T]
            record.update(proposal_scale=scale,start=start.tolist(),queries=stats,
                reference_error=(vals.mean(0)-reference).tolist())
            runs.append(record)
    target=lambda w:logsumexp([np.log(.3)-.5*(w[0]+4)**2,np.log(.7)-.5*(w[0]-4)**2])
    stress=[]
    for scale in [.2,2.5,20.]:
        for start in [-4.,4.]:
            for seed in [17,29]:
                draws,record=mh(target,[start],np.array([[scale]]),seed,n=5000,burn=1000)
                values=draws[:,0];positive=(values>0).astype(float)
                stats=[diagnostics(values),diagnostics(positive)]
                record.update(proposal_sd=scale,start=start,crossings=int(np.sum(positive[1:]!=positive[:-1])),
                    queries=stats,reference_error=[float(values.mean()-1.6),float(positive.mean()-(.3*ndtr(-4)+.7*ndtr(4)))])
                stress.append(record)
    target_mass=np.array([1/3,2/3]);proposal=np.array([[.75,.25],[.5,.5]])
    transition=np.zeros((2,2));wrong=np.zeros((2,2))
    for i in range(2):
        j=1-i;transition[i,j]=proposal[i,j]*min(1.,target_mass[j]*proposal[j,i]/(target_mass[i]*proposal[i,j]))
        wrong[i,j]=proposal[i,j]*min(1.,target_mass[j]/target_mass[i])
        transition[i,i]=1-transition[i,j];wrong[i,i]=1-wrong[i,j]
    balance_error=float(np.max(abs(target_mass@transition-target_mass)));assert balance_error<1e-12
    asymmetric_check=dict(target=target_mass.tolist(),proposal=proposal.tolist(),correct_transition=transition.tolist(),
        invariance_error=balance_error,omitted_proposal_ratio_transition=wrong.tolist(),wrong_invariance_error=float(np.max(abs(target_mass@wrong-target_mass))))
    c.write_json(HERE/"mh_results.json",dict(status="author-only finite-run probe; no convergence guarantee or Colab/student-time pass",asymmetric_check=asymmetric_check,query_order=["intercept","slope","P(Y=1|x=-2)","x=-1","x=0","x=1","x=2"],
        reference=reference.tolist(),classifier_runs=runs,bimodal_runs=stress))
    print(json.dumps(dict(classifier_runs=len(runs),max_abs_classifier_error=float(np.max(abs(np.array([r["reference_error"] for r in runs])))),stress_crossings=[r["crossings"] for r in stress])))


if __name__=="__main__":main()
