"""Author checks and plots for fixed L09 candidates; no model/family search."""
import hashlib,json,time
from pathlib import Path
import numpy as np
import torch
import matplotlib
matplotlib.use('Agg')
import matplotlib.pyplot as plt
from scipy.special import expit,ndtr
from scipy.stats import norm,chi2
import geometry_probe as g

HERE=Path(__file__).resolve().parent

def torch_check(c,full,t0,eps):
    d=eps.shape[1];t=torch.tensor(t0,dtype=torch.float64,requires_grad=True)
    L=torch.diag(torch.exp(t[d:2*d]));idx=np.tril_indices(d,-1)
    if full:
        low=torch.zeros((d,d),dtype=torch.float64);low[torch.tensor(idx[0]),torch.tensor(idx[1])]=t[2*d:];L=L+low
    w=t[:d]+torch.tensor(eps)@L.T
    X=torch.tensor(c['X']);y=torch.tensor(c['y']);z=torch.einsum('skp,np->snk',w.reshape(len(eps),c['K']-1,X.shape[1]),X)
    z=torch.cat([torch.zeros((len(eps),len(y),1),dtype=torch.float64),z],dim=-1)
    loss=(torch.logsumexp(z,dim=-1)-z.gather(-1,y[None,:,None].expand(len(eps),-1,1)).squeeze(-1)).sum(1).mean()
    kl=.5*((t[:d].square().sum()+L.square().sum())/4-d+d*np.log(4)-2*t[d:2*d].sum())
    (loss+kl).backward();value,grad=g.objective(t0,eps,np.full(len(eps),1/len(eps)),c,full)
    return dict(full=full,value_difference=float(abs(float((loss+kl).detach())-value)),manual_autograd_max_difference=float(np.max(abs(t.grad.numpy()-grad))))

def gauss_predictions(m,C,c,n):
    a,b=np.polynomial.hermite.hermgauss(n)
    vals=[]
    for x in c['Q']:
        sd=np.sqrt(x@C@x);vals.append(np.sum(b*expit(x@m+np.sqrt(2)*sd*a))/np.sqrt(np.pi))
    return np.array(vals)

def main():
    result={};cs=g.cases()
    for c in cs:
        r=json.loads((HERE/(c['name']+'_results.json')).read_text());d=r['dimension'];checks=[]
        for full in [False,True]:
            initial=np.r_[np.linspace(-.2,.3,d),np.full(d,-.4),np.full(d*(d-1)//2,.1) if full else []]
            eps=np.random.default_rng(66).normal(size=(11,d));checks.append(torch_check(c,full,initial,eps))
        ref=r['grids'][-1] if r['grids'] else r['importance_references'][-1]
        logevidence=ref['logZ_unnormalized']-d/2*np.log(8*np.pi)
        methods={'Laplace':r['laplace'],'diagonal VI':r['fits']['diagonal']['diagnostic_fit'],'full VI':r['fits']['full']['diagnostic_fit']}
        summary={}
        for name,f in methods.items():
            obj=f.get('objective',f.get('diagnostic_negative_ELBO'));C=np.array(f['covariance']);S=np.array(ref['covariance'])
            summary[name]=dict(approximate_reverse_KL=float(obj+logevidence),marginal_SD_relative_errors=(np.sqrt(np.diag(C)/np.diag(S))-1).tolist(),
                stochastic_errors=[s['max_predictive_probability_error'] for s in r['fits'].get(name.replace(' VI',''),{}).get('stochastic_runs',[])])
        if c['K']==3:
            y=np.array(c['metadata']['test_labels']);refp=np.array(ref['predictions'])[3:]
            score={}
            for name,f in methods.items():
                p=np.array(f['predictions'])[3:];score[name]=dict(heldout_log_loss=float(np.mean(-np.log(p[np.arange(len(y)),y]))),classification_error=float(np.mean(p.argmax(1)!=y)),class_decisions_differ_from_reference=int(np.sum(p.argmax(1)!=refp.argmax(1))))
            score['reference']=dict(heldout_log_loss=float(np.mean(-np.log(refp[np.arange(len(y)),y]))),classification_error=float(np.mean(refp.argmax(1)!=y)))
        else:score=None
        result[c['name']]=dict(checks=checks,method_summary=summary,heldout_scores=score,
            reference_prediction_spread_last3=float(np.ptp([a['predictions'] for a in r['importance_references'][-3:]],axis=0).max()),
            reference_qmc_power_change_max=float(np.max(abs(np.mean([a['predictions'] for a in r['importance_references'][:3]],axis=0)-np.mean([a['predictions'] for a in r['importance_references'][-3:]],axis=0)))))
    c=cs[1];r=json.loads((HERE/'challenger_results.json').read_text())
    grids=[g.challenger_grid(c,14,.04),g.challenger_grid(c,14,.02)]
    result['challenger']['extended_grids']=grids
    m=np.array(r['laplace']['mean']);f=float(g.posterior_nll(m,c)[0]);_,likgrad=g.likelihood(m,c,True);grad=likgrad[0]+m/4
    # Gaussian-prior logistic negative log posterior is globally 1/4 strongly convex.
    # Complete the square at approximate mode, retaining its nonzero gradient.
    envelope_center=m-4*grad;R=14
    tail=1-np.prod(ndtr((R-envelope_center)/2)-ndtr((-R-envelope_center)/2))
    ratio=np.exp(-f+2*(grad@grad)+np.log(8*np.pi)-grids[-1]['logZ_unnormalized'])
    result['challenger']['tail_bound']=dict(radius=R,strong_convexity=.25,mode_gradient_norm=float(np.linalg.norm(grad)),envelope_center=envelope_center.tolist(),envelope_integral_over_box_mass_ratio=float(ratio),
        envelope_tail_probability=float(tail),posterior_outside_box_upper_bound=float(ratio*tail),qualification='analytic envelope inequality evaluated float64, denominator numerical grid integral; not interval-certified; mesh still separate')
    integration={}
    for name,fit in {'Laplace':r['laplace'],'full VI':r['fits']['full']['diagnostic_fit'],'diagonal VI':r['fits']['diagonal']['diagnostic_fit']}.items():
        m=np.array(fit['mean']);C=np.array(fit['covariance']);preds={n:gauss_predictions(m,C,c,n) for n in [80,160,240]}
        integration[name]=dict(gh240_predictions=preds[240].tolist(),gh160_240_max_difference=float(np.max(abs(preds[160]-preds[240]))),qmc_vs_gh240_max_difference=float(np.max(abs(np.array(fit['predictions'])[:,1]-preds[240]))))
    result['challenger']['gaussian_prediction_integration']=integration
    # Figure uses normalized reference density and explicit 90% density contours.
    ax0=np.linspace(-3.8,.8,260);ax1=np.linspace(-4.8,.6,260);a,b=np.meshgrid(ax0,ax1,indexing='ij');w=np.c_[a.ravel(),b.ravel()]
    p=np.exp(-g.posterior_nll(w,c)-grids[-1]['logZ_unnormalized']).reshape(a.shape)
    levels=[]
    area=(ax0[1]-ax0[0])*(ax1[1]-ax1[0]);sort=np.sort(p.ravel())[::-1];mass=np.cumsum(sort)*area
    for prob in [.9]:levels.append(sort[np.searchsorted(mass,prob)])
    fig,axes=plt.subplots(1,3,figsize=(13.5,4))
    axes[0].contour(a,b,p,levels=levels,colors=['black'],linewidths=2)
    colors={'Laplace':'#3b69aa','full VI':'#dc7433','diagonal VI':'#4d9564'}
    angle=np.linspace(0,2*np.pi,400);unit=np.c_[np.cos(angle),np.sin(angle)]*np.sqrt(chi2.ppf(.9,2))
    for name,fit in {'Laplace':r['laplace'],'full VI':r['fits']['full']['diagnostic_fit']}.items():
        xy=np.array(fit['mean'])+unit@np.linalg.cholesky(fit['covariance']).T
        axes[0].plot(xy[:,0],xy[:,1],label=name,color=colors[name])
    axes[0].plot([],[],color='black',label='reference');axes[0].set(xlabel='intercept',ylabel='temperature slope',title='90% posterior density contours');axes[0].legend(frameon=False)
    # Marginal density, integrating original-coordinate intercept over wider box.
    x=np.linspace(-14,14,701);ys=np.linspace(-5,1,301);a,b=np.meshgrid(x,ys,indexing='ij');ww=np.c_[a.ravel(),b.ravel()]
    dens=np.exp(-g.posterior_nll(ww,c)-grids[-1]['logZ_unnormalized']).reshape(a.shape);marginal=np.trapezoid(dens,x=x,axis=0)
    axes[1].plot(ys,marginal,color='black',label='reference')
    for name,fit in {'Laplace':r['laplace'],'full VI':r['fits']['full']['diagnostic_fit']}.items():
        axes[1].plot(ys,norm.pdf(ys,fit['mean'][1],np.sqrt(fit['covariance'][1][1])),color=colors[name],label=name)
    axes[1].set(xlabel='temperature slope',ylabel='density',title='Gaussian fits retain residual shape error')
    temps=c['metadata']['query_temperatures'];ref=np.array(grids[-1]['predictions'])[:,1]
    for name,fit in {'Laplace':r['laplace'],'full VI':r['fits']['full']['diagnostic_fit'],'diagonal VI':r['fits']['diagonal']['diagnostic_fit']}.items():
        axes[2].plot(temps,100*(np.array(fit['predictions'])[:,1]-ref),marker='o',color=colors[name],label=name)
    axes[2].axhline(0,color='black',lw=.7);axes[2].axvspan(31,53,color='gray',alpha=.12);axes[2].set(xlabel='temperature °F (shading = extrapolation)',ylabel='prediction error (percentage points)',title='Error in probability of any thermal distress');axes[2].legend(frameon=False)
    fig.tight_layout();fig.savefig(HERE/'challenger_geometry.svg');fig.savefig(HERE/'challenger_geometry.png',dpi=130);plt.close(fig)
    (HERE/'audit_results.json').write_text(json.dumps(result,indent=2,allow_nan=False)+'\n')
    print(json.dumps(result,indent=2))

if __name__=='__main__':main()
