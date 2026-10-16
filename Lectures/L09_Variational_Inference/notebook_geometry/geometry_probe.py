"""Teacher-only bounded L09 screening, not an approved worked solution/notebook.

Cases fixed before fitting: multinomial one-feature Iris; Challenger flight-level
thermal distress. Gaussian prior N(0,4I), original standardized regressors.
"""
from pathlib import Path
import hashlib, json, platform, time
import numpy as np
import scipy, sklearn, torch
from scipy.optimize import minimize
from scipy.special import logsumexp, ndtri, expit
from scipy.stats import qmc, chi2, multivariate_t
from sklearn.datasets import load_iris
from sklearn.model_selection import train_test_split

HERE=Path(__file__).resolve().parent
DT=torch.float64

def cases():
    iris=load_iris()
    ids=np.arange(150)
    train,test=train_test_split(ids,test_size=.4,random_state=14,stratify=iris.target)
    raw=iris.data[:,0];center=raw[train].mean();scale=raw[train].std()
    X=np.c_[np.ones(len(train)),(raw[train]-center)/scale]
    Xt=np.c_[np.ones(len(test)),(raw[test]-center)/scale]
    Xi=np.vstack([np.c_[np.ones(3),[-2,0,2]],Xt])
    im=dict(name='multinomial_iris',X=X,y=iris.target[train],Q=Xi,K=3,
      metadata=dict(data_sha256=hashlib.sha256(iris.data.tobytes()+iris.target.tobytes()).hexdigest(),
        feature='sepal length cm; single feature predeclared to match L07 problem',train_ids=train.tolist(),test_ids=test.tolist(),
        test_labels=iris.target[test].tolist(),center=float(center),scale=float(scale),reference_class='setosa=0',
        coefficient_order='versicolor intercept,slope; virginica intercept,slope',queries='first 3 standardized x=-2,0,2 then 60 held-out cases'))
    rawpath=HERE/'o-ring-erosion-or-blowby.data'
    data=np.loadtxt(rawpath);T=data[:,2];y=(data[:,1]>0).astype(int)
    center=T.mean();scale=T.std();temps=np.array([31.,53.,60.,70.,81.])
    cm=dict(name='challenger',X=np.c_[np.ones(len(y)),(T-center)/scale],y=y,
      Q=np.c_[np.ones(5),(temps-center)/scale],K=2,
      metadata=dict(data_sha256=hashlib.sha256(rawpath.read_bytes()).hexdigest(),center=float(center),scale=float(scale),
        temperatures=T.tolist(),binary_distress=y.tolist(),n_positive=int(y.sum()),query_temperatures=temps.tolist(),
        outcome='any primary O-ring erosion or blowby on a flight, not catastrophic failure',
        reference_class='no thermal distress',coefficient_order='intercept,slope',split='all 23 historical flights, no holdout evaluation'))
    return [im,cm]

def likelihood(w,c,gradient=False):
    w=np.atleast_2d(w);W=w.reshape(len(w),c['K']-1,c['X'].shape[1])
    z=np.einsum('skp,np->snk',W,c['X'])
    z=np.concatenate([np.zeros((*z.shape[:2],1)),z],axis=-1)
    lse=logsumexp(z,axis=-1);selected=np.take_along_axis(z,c['y'][None,:,None],axis=2)[...,0]
    f=np.sum(lse-selected,axis=1)
    if not gradient:return f
    p=np.exp(z-lse[...,None])
    target=np.eye(c['K'])[c['y']]
    g=np.einsum('snk,np->skp',p[:,:,1:]-target[None,:,1:],c['X']).reshape(len(w),-1)
    return f,g

def posterior_nll(w,c):
    w=np.atleast_2d(w)
    return likelihood(w,c)+np.sum(w*w,axis=1)/8

def predictive(w,c):
    w=np.atleast_2d(w);W=w.reshape(len(w),c['K']-1,c['X'].shape[1])
    z=np.einsum('skp,np->snk',W,c['Q'])
    z=np.concatenate([np.zeros((*z.shape[:2],1)),z],axis=-1)
    return np.exp(z-logsumexp(z,axis=-1)[...,None])

def laplace(c):
    d=(c['K']-1)*c['X'].shape[1]
    def fg(w):
        f,g=likelihood(w,c,True)
        return float(f[0]+w@w/8),g[0]+w/4
    start=time.perf_counter()
    fit=minimize(fg,np.zeros(d),jac=True,method='BFGS',options={'gtol':1e-10})
    p=predictive_model(fit.x,c)
    H=np.eye(d)/4
    for x,pi in zip(c['X'],p):
        a=pi[1:];H+=np.kron(np.diag(a)-np.outer(a,a),np.outer(x,x))
    C=np.linalg.inv(H)
    return fit.x,C,dict(success=bool(fit.success),message=str(fit.message),grad_norm=float(np.linalg.norm(fit.jac)),seconds=time.perf_counter()-start,hessian_min_eigenvalue=float(np.linalg.eigvalsh(H).min()))

def predictive_model(w,c):
    cc=dict(c,Q=c['X']);return predictive(w,cc)[0]

def pack(m,L,full):
    d=len(m);return np.r_[m,np.log(np.diag(L)),L[np.tril_indices(d,-1)] if full else []]

def unpack(t,d,full):
    L=np.diag(np.exp(t[d:2*d]));
    if full:L[np.tril_indices(d,-1)]=t[2*d:]
    return t[:d],L

def objective(t,e,weight,c,full):
    d=e.shape[1];m,L=unpack(t,d,full);w=m+e@L.T
    f,G=likelihood(w,c,True)
    KL=.5*((m@m+np.sum(L*L))/4-d+d*np.log(4)-2*np.log(np.diag(L)).sum())
    gm=weight@G+m/4;gL=(weight[:,None]*G).T@e+L/4-np.linalg.inv(L).T
    g=np.r_[gm,np.diag(gL)*np.diag(L),gL[np.tril_indices(d,-1)] if full else []]
    return float(weight@f+KL),g

def nodes(d,power=13,seed=771):
    if d==2:
        a,b=np.polynomial.hermite.hermgauss(40)
        x,y=np.meshgrid(a,a,indexing='ij')
        return np.c_[x.ravel(),y.ravel()]*np.sqrt(2),np.outer(b,b).ravel()/np.pi
    e=ndtri(qmc.Sobol(d,scramble=True,seed=seed).random_base2(power));e=np.vstack([e,-e])
    return e,np.full(len(e),1/len(e))

def gaussian_summary(m,C,c,seed=998,power=17):
    d=len(m);e=ndtri(qmc.Sobol(d,scramble=True,seed=seed).random_base2(power))
    pred=np.zeros((len(c['Q']),c['K']));start=time.perf_counter()
    for chunk in np.array_split(e,32):pred+=predictive(m+chunk@np.linalg.cholesky(C).T,c).sum(0)/len(e)
    return dict(mean=m.tolist(),covariance=C.tolist(),predictions=pred.tolist(),query_seconds=time.perf_counter()-start,n_query_draws=len(e))

def stochastic_torch(c,full,seed,m0,C0,monitor_nodes):
    d=len(m0);initial=pack(m0,np.linalg.cholesky(C0) if full else np.diag(np.sqrt(np.diag(C0))),full)
    t=torch.tensor(initial,dtype=DT,requires_grad=True);X=torch.tensor(c['X'],dtype=DT);y=torch.tensor(c['y'])
    idx=np.tril_indices(d,-1);r=torch.tensor(idx[0]);col=torch.tensor(idx[1])
    rng=np.random.default_rng(seed);optimizer=torch.optim.Adam([t],lr=.02);monitor=[];start=time.perf_counter()
    for i in range(1,4001):
        for group in optimizer.param_groups:group['lr']=.02 if i<=2000 else .005
        optimizer.zero_grad();L=torch.diag(torch.exp(t[d:2*d]))
        if full:
            low=torch.zeros((d,d),dtype=DT);low[r,col]=t[2*d:];L=L+low
        e=torch.tensor(rng.normal(size=(64,d)),dtype=DT);w=t[:d]+e@L.T
        z=torch.einsum('skp,np->snk',w.reshape(64,c['K']-1,X.shape[1]),X)
        z=torch.cat([torch.zeros((64,len(y),1),dtype=DT),z],axis=-1)
        nll=(torch.logsumexp(z,dim=-1)-z.gather(-1,y[None,:,None].expand(64,-1,1)).squeeze(-1)).sum(1).mean()
        KL=.5*((t[:d].square().sum()+L.square().sum())/4-d+d*np.log(4)-2*t[d:2*d].sum())
        (nll+KL).backward();assert torch.isfinite(t.grad).all();optimizer.step()
        if i%1000==0:monitor.append([i,objective(t.detach().numpy(),*monitor_nodes,c,full)[0]])
    theta=t.detach().numpy();m,L=unpack(theta,d,full)
    return theta,dict(seed=seed,seconds=time.perf_counter()-start,monitor=monitor,backend='actual torch pathwise backward + Adam, fresh 64 draws/update',**gaussian_summary(m,L@L.T,c,power=15))

def importance_reference(c,m,C,power,seed):
    d=len(m);u=qmc.Sobol(d+1,scramble=True,seed=seed).random_base2(power)
    # t5 with inflated Laplace scale ensures proposal has polynomial tails; no VI fit used.
    w=m+ndtri(u[:,:d])@np.linalg.cholesky(1.5*C).T/np.sqrt(chi2.ppf(u[:,d],5)/5)[:,None]
    logw=np.empty(len(w));predparts=[];start=time.perf_counter()
    for sl in np.array_split(np.arange(len(w)),64):
        logw[sl]=-posterior_nll(w[sl],c)-multivariate_t.logpdf(w[sl],loc=m,shape=1.5*C,df=5)
    scale=logw.max();weights=np.exp(logw-scale);Z=weights.mean()*np.exp(scale);weights/=weights.sum()
    mean=weights@w;cov=(w-mean).T@(weights[:,None]*(w-mean));skew=weights@((w-mean)/np.sqrt(np.diag(cov)))**3
    pred=np.zeros((len(c['Q']),c['K']))
    for sl in np.array_split(np.arange(len(w)),64):pred+=np.einsum('s,snk->nk',weights[sl],predictive(w[sl],c))
    return dict(seed=seed,power=power,n=len(w),logZ_unnormalized=float(np.log(Z)),mean=mean.tolist(),covariance=cov.tolist(),marginal_skewness=skew.tolist(),predictions=pred.tolist(),weight_ESS=float(1/(weights@weights)),max_normalized_weight=float(weights.max()),seconds=time.perf_counter()-start)

def challenger_grid(c,radius,step):
    axis=np.linspace(-radius,radius,round(2*radius/step)+1);a,b=np.meshgrid(axis,axis,indexing='ij');w=np.c_[a.ravel(),b.ravel()]
    edge=np.ones(len(axis));edge[[0,-1]]=.5;trap=np.outer(edge,edge).ravel();logp=np.empty(len(w));pred=np.zeros((len(c['Q']),2));start=time.perf_counter()
    for sl in np.array_split(np.arange(len(w)),128):logp[sl]=-posterior_nll(w[sl],c)
    mass=np.exp(logp-logp.max())*trap;normalizer=mass.sum()*step**2*np.exp(logp.max());mass/=mass.sum()
    mean=mass@w;cov=(w-mean).T@(mass[:,None]*(w-mean));skew=mass@((w-mean)/np.sqrt(np.diag(cov)))**3
    for sl in np.array_split(np.arange(len(w)),128):pred+=np.einsum('s,snk->nk',mass[sl],predictive(w[sl],c))
    return dict(radius=radius,step=step,n=len(w),logZ_unnormalized=float(np.log(normalizer)),mean=mean.tolist(),covariance=cov.tolist(),marginal_skewness=skew.tolist(),predictions=pred.tolist(),outer_unit_mass=float(mass[np.max(abs(w),axis=1)>radius-1].sum()),seconds=time.perf_counter()-start)

def main():
    torch.set_num_threads(1);allresults={}
    for c in cases():
        print('case',c['name'],flush=True);d=(c['K']-1)*c['X'].shape[1]
        m,C,lapdiag=laplace(c);en=nodes(d);fits={};checks=[]
        for full in [False,True]:
            initial=pack(m,np.linalg.cholesky(C) if full else np.diag(np.sqrt(np.diag(C))),full)
            eps=np.random.default_rng(66).normal(size=(11,d));weights=np.full(11,1/11)
            v,g=objective(initial,eps,weights,c,full);numeric=[]
            for j in range(len(initial)):
                h=np.zeros_like(initial);h[j]=1e-5
                numeric.append((objective(initial+h,eps,weights,c,full)[0]-objective(initial-h,eps,weights,c,full)[0])/2e-5)
            checks.append(dict(full=full,fixed_noise_fd_max_error=float(np.max(abs(g-numeric)))))
            start=time.perf_counter();opts=[]
            for offset in [0.,.15]:
                opt=minimize(lambda t:objective(t,*en,c,full),initial+offset,jac=True,method='BFGS',options={'gtol':1e-7,'maxiter':200})
                opts.append(opt)
            opt=min(opts,key=lambda x:x.fun);om,oL=unpack(opt.x,d,full)
            high=nodes(d,power=16,seed=772)
            diag=dict(objective=float(opt.fun),independent_higher_resolution_objective=objective(opt.x,*high,c,full)[0],gradient_norm=float(np.linalg.norm(opt.jac)),optimization_messages=[str(o.message) for o in opts],two_start_objective_difference=float(abs(opts[0].fun-opts[1].fun)),seconds=time.perf_counter()-start,theta=opt.x.tolist(),**gaussian_summary(om,oL@oL.T,c))
            runs=[]
            for seed in [10,20,30]:
                theta,run=stochastic_torch(c,full,seed,m,C,en);run['diagnostic_objective_gap']=objective(theta,*en,c,full)[0]-opt.fun;runs.append(run)
            fits['full' if full else 'diagonal']=dict(diagnostic_fit=diag,stochastic_runs=runs)
            print(c['name'],'full',full,'objective',opt.fun,'grad',np.linalg.norm(opt.jac),flush=True)
        refs=[]
        for power in [16,18]:
            for seed in [101,102,103]:refs.append(importance_reference(c,m,C,power,seed))
        grids=[]
        if d==2:
            for radius,step in [(8,.04),(10,.04),(10,.02)]:grids.append(challenger_grid(c,radius,step))
        refpred=np.array(grids[-1]['predictions'] if grids else refs[-1]['predictions'])
        lapsummary=gaussian_summary(m,C,c);lapsummary.update(lapdiag);lapsummary['diagnostic_negative_ELBO']=objective(pack(m,np.linalg.cholesky(C),True),*en,c,True)[0]
        for fit in [lapsummary]+[r for f in fits.values() for r in [f['diagnostic_fit']]+f['stochastic_runs']]:
            fit['max_predictive_probability_error']=float(np.max(abs(np.array(fit['predictions'])-refpred)))
        out=dict(status='teacher-only screening; no selection, learner pilot or Colab check',metadata=c['metadata'],dimension=d,prior='N(0,4I) on standardized-regressor coefficients',laplace=lapsummary,fits=fits,fixed_noise_checks=checks,importance_references=refs,grids=grids)
        allresults[c['name']]=out
        (HERE/(c['name']+'_results.json')).write_text(json.dumps(out,indent=2,allow_nan=False)+'\n')
        print('DONE',c['name'],'Laplace',lapsummary['max_predictive_probability_error'],'fullVI',fits['full']['diagnostic_fit']['max_predictive_probability_error'],flush=True)
    versions=dict(python=platform.python_version(),numpy=np.__version__,scipy=scipy.__version__,sklearn=sklearn.__version__,torch=torch.__version__)
    (HERE/'runtime.json').write_text(json.dumps(versions,indent=2)+'\n')

if __name__=='__main__':main()
