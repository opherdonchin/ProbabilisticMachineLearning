"""Isolated author VAE feasibility probe; no source data or checkpoint is committed.
The exact public CSV is fetched to /tmp and verified before any parsing.
Fixed configuration precedes all test evaluation. Run via this worktree's uv Python.
"""
import copy
import csv
import hashlib
import io
import json
import math
import pathlib
import time
import urllib.request
import numpy as np
import torch
from torch import nn

torch.set_num_threads(1)
COMMIT='049cb033a9814c0ec3df99ece5144d07688aa648'
URL=f'https://raw.githubusercontent.com/narslab/mobile-emissions-typology/{COMMIT}/data/tidy/raw-data-cluster.csv'
SHA='05e02113771a0ab550a9e7a0098d099ee348820564b68bcdc6c71a28b24418d6'
FEATURES=['Node Density (/sq km)','Intersection Density (/sq km)',
'Street Density (km/sq km)','Circuity Average','Car Mode Share','Transit Mode Share',
'Bicycle Mode Share','Walking Mode Share','Working from Home Share','Median Household Income',
'Employment Rate (%)','Unemployment Rate (%)','Population Density (/sq km)',
'Built-Up Area Proportion','Cooling Degree Days (°Df)','Heating Degree Days (°Df)',
'Average Temperature (°F)','Precipitation (in)','GDP ($)']
LOG_FEATURES=['GDP ($)','Median Household Income','Population Density (/sq km)',
'Node Density (/sq km)','Cooling Degree Days (°Df)','Heating Degree Days (°Df)',
'Intersection Density (/sq km)','Street Density (km/sq km)']
SHARE_FEATURES=['Car Mode Share','Transit Mode Share','Bicycle Mode Share','Walking Mode Share']
CONFIG=dict(split_seed=20261014,seeds=[17,29,43],betas=[1,4],n_train=245,n_validation=52,n_test=52,
            hidden=32,latent=4,decoder_variance=.5,epochs=300,batch_size=32,lr=.003,
            validation_every=20,validation_mc=16,test_mc=64,threads=1,
            checkpoint='minimum validation D+beta R; matching split and settings for both betas')
cache=pathlib.Path('/tmp/pml-l12-public-source/raw-data-cluster.csv')
cache.parent.mkdir(exist_ok=True)
if not cache.exists(): cache.write_bytes(urllib.request.urlopen(URL).read())
raw_bytes=cache.read_bytes(); assert hashlib.sha256(raw_bytes).hexdigest()==SHA
rows=list(csv.DictReader(io.StringIO(raw_bytes.decode('utf-8-sig'))))
raw=np.array([[float(row[f]) for f in FEATURES] for row in rows])
assert raw.shape==(349,19) and np.isfinite(raw).all()
log_idx=[FEATURES.index(f) for f in LOG_FEATURES]
share_idx=[FEATURES.index(f) for f in SHARE_FEATURES]
five_commute_idx=share_idx+[FEATURES.index('Working from Home Share')]
transformed=raw.copy(); transformed[:,share_idx]/=100
raw_ranges={f:dict(min=float(raw[:,j].min()),max=float(raw[:,j].max())) for j,f in enumerate(FEATURES)}
clipped_counts={f:int((raw[:,FEATURES.index(f)]<0).sum()) for f in LOG_FEATURES}
transformed[:,log_idx]=np.log1p(np.maximum(transformed[:,log_idx],0))
perm=np.random.default_rng(CONFIG['split_seed']).permutation(349)
tr,va,te=perm[:245],perm[245:297],perm[297:]
center=transformed[tr].mean(0); scale=transformed[tr].std(0)
assert (scale>0).all()
standardized=(transformed-center)/scale
X=torch.tensor(standardized,dtype=torch.float32)

def inverse(x):
    t=np.asarray(x)*scale+center
    t=t.copy(); t[:,log_idx]=np.expm1(t[:,log_idx]); t[:,share_idx]*=100
    return t

class VAE(nn.Module):
    def __init__(self):
        super().__init__()
        self.enc=nn.Sequential(nn.Linear(19,32),nn.ReLU())
        self.mu=nn.Linear(32,4); self.logvar=nn.Linear(32,4)
        self.dec=nn.Sequential(nn.Linear(4,32),nn.ReLU(),nn.Linear(32,19))
    def encode(self,x):
        h=self.enc(x); return self.mu(h),self.logvar(h)
    def forward(self,x,eps):
        mu,ell=self.encode(x)
        z=mu+torch.exp(.5*ell)*eps
        return self.dec(z),mu,ell

def terms(x,recon,mu,ell):
    assert recon.shape==x.shape and mu.shape==ell.shape==(len(x),4)
    D=((x-recon).square().sum(-1)+9.5*math.log(math.pi))
    R=.5*(mu.square()+torch.exp(ell)-1-ell).sum(-1)
    return D,R

# Independent event-sum, exact KL, and complete reparameterized derivative checks.
torch.manual_seed(101)
x0=torch.randn(2,19,dtype=torch.float64)
m0=torch.randn(2,4,dtype=torch.float64,requires_grad=True)
e0=torch.randn(2,4,dtype=torch.float64,requires_grad=True)
w0=torch.randn(4,19,dtype=torch.float64,requires_grad=True)
noise=torch.randn(2,4,dtype=torch.float64)
def local_loss(m,e,w):
    z=m+torch.exp(.5*e)*noise
    return sum(t.mean() for t in terms(x0,z@w,m,e))
z0=m0+torch.exp(.5*e0)*noise
D0,R0=terms(x0,z0@w0,m0,e0)
refD=-torch.distributions.Normal(z0@w0,math.sqrt(.5)).log_prob(x0).sum(-1)
refR=torch.distributions.kl_divergence(torch.distributions.Normal(m0,torch.exp(.5*e0)),torch.distributions.Normal(torch.zeros_like(m0),torch.ones_like(m0))).sum(-1)
klgrad=torch.autograd.grad(R0.mean(),(m0,e0),retain_graph=True)
checks=dict(event_nll_reference_max_error=float((D0-refD).abs().max().detach()),
            kl_reference_max_error=float((R0-refR).abs().max().detach()),
            kl_mean_gradient_max_error=float((klgrad[0]-m0/2).abs().max().detach()),
            kl_logvariance_gradient_max_error=float((klgrad[1]-.25*(torch.exp(e0)-1)).abs().max().detach()),
            fixed_noise_pathwise_gradcheck=bool(torch.autograd.gradcheck(local_loss,(m0,e0,w0))))
checkmodel=VAE(); rx,mm,ee=checkmodel(X[tr[:5]],torch.ones(5,4))
DD,RR=terms(X[tr[:5]],rx,mm,ee); (DD+RR).mean().backward()
checks['network_gradient_norms']={name:float(p.grad.norm()) for name,p in checkmodel.named_parameters()}
assert checks['fixed_noise_pathwise_gradcheck'] and max(v for k,v in checks.items() if 'error' in k)<1e-12
assert all(np.isfinite(v) and v>0 for v in checks['network_gradient_norms'].values())

@torch.no_grad()
def evaluate(model,inds,draws,seed):
    x=X[inds]; mu,ell=model.encode(x)
    g=torch.Generator().manual_seed(seed)
    eps=torch.randn(draws,len(inds),4,generator=g)
    z=mu[None]+torch.exp(.5*ell)[None]*eps
    rec=model.dec(z.reshape(-1,4)).reshape(draws,len(inds),19)
    D=((x[None]-rec).square().sum(-1)+9.5*math.log(math.pi))
    R=.5*(mu.square()+torch.exp(ell)-1-ell)
    # MC SE for average held-out D conditional on these test cases/weights.
    d_draw=D.mean(-1)
    deterministic=(x-model.dec(mu)).square().sum(-1)+9.5*math.log(math.pi)
    return dict(D=float(D.mean()),R=float(R.sum(-1).mean()),
                D_mc_se=float(d_draw.std(unbiased=True)/math.sqrt(draws)),
                mean_code_reconstruction_nll=float(deterministic.mean()),
                per_latent_rate=[float(v) for v in R.mean(0)],
                encoder_mean_sd=[float(v) for v in mu.std(0)])

def support_summary(samples):
    rr=inverse(samples)
    violated=np.zeros_like(rr,dtype=bool)
    # Explicit known scalar bounds only; this does not establish joint realism.
    for j,f in enumerate(FEATURES):
        if f in LOG_FEATURES or f=='Precipitation (in)': violated[:,j]|=rr[:,j]<0
        if f in SHARE_FEATURES or f in ['Working from Home Share','Built-Up Area Proportion']:
            violated[:,j]|=(rr[:,j]<0)|(rr[:,j]>100)
        if f in ['Employment Rate (%)','Unemployment Rate (%)']:
            violated[:,j]|=(rr[:,j]<0)|(rr[:,j]>1)
    return dict(n=len(rr),any_scalar_bound_violation_fraction=float(violated.any(1).mean()),
                scalar_violation_fractions={f:float(violated[:,j].mean()) for j,f in enumerate(FEATURES) if violated[:,j].any()},
                four_commute_share_sum_over_100_fraction=float((rr[:,share_idx].sum(1)>100).mean()),
                five_commute_share_sum_over_100_fraction=float((rr[:,five_commute_idx].sum(1)>100).mean()),
                nonfinite_fraction=float((~np.isfinite(rr)).any(1).mean()))

def fit(seed,beta):
    torch.manual_seed(seed); model=VAE(); opt=torch.optim.Adam(model.parameters(),lr=.003)
    best=float('inf'); state=None; chosen=None
    start=time.perf_counter()
    for ep in range(1,301):
        order=tr[torch.randperm(len(tr)).numpy()]
        for pos in range(0,len(tr),32):
            xb=X[order[pos:pos+32]]; noise=torch.randn(len(xb),4)
            rec,mu,ell=model(xb,noise); D,R=terms(xb,rec,mu,ell)
            loss=(D+beta*R).mean(); assert torch.isfinite(loss)
            opt.zero_grad(); loss.backward(); opt.step()
        if ep%20==0:
            score=evaluate(model,va,16,901)
            criterion=score['D']+beta*score['R']
            if criterion<best: best=criterion; state=copy.deepcopy(model.state_dict()); chosen=ep
    model.load_state_dict(state)
    test=evaluate(model,te,64,902)
    train=evaluate(model,tr,64,903)
    with torch.no_grad():
        g=torch.Generator().manual_seed(904)
        prior_z=torch.randn(2000,4,generator=g)
        prior_mean=model.dec(prior_z)
        prior_observation=prior_mean+math.sqrt(.5)*torch.randn(2000,19,generator=g)
        tm,tl=model.encode(X[te]); rec_mean=model.dec(tm)
        # Hold fixed z and average Gaussian noise second moment to verify observation variance.
        decoder_noise=prior_observation-prior_mean
    return dict(seed=seed,beta=beta,selected_epoch=chosen,validation_selected_objective=best,
                training_seconds=time.perf_counter()-start,train=train,test=test,
                prior_decoder_means_support=support_summary(prior_mean.numpy()),
                prior_full_observations_support=support_summary(prior_observation.numpy()),
                mean_code_reconstruction_support=support_summary(rec_mean.numpy()),
                decoder_noise_empirical_mean_square=float(decoder_noise.square().mean()),
                parameters=sum(p.numel() for p in model.parameters()))

# Rank-four PCA is a supplied deterministic comparison, not an ELBO/rate comparator.
_,_,vt=np.linalg.svd(standardized[tr],full_matrices=False)
components=vt[:4].T
pca_reconstruction=standardized[te]@components@components.T
pca_d=float(((standardized[te]-pca_reconstruction)**2).sum(1).mean()+9.5*math.log(math.pi))
constant_d=float((standardized[te]**2).sum(1).mean()+9.5*math.log(math.pi))
results=dict(config=CONFIG,source=dict(url=URL,sha256=SHA,rows=349,total_columns=len(rows[0]),selected_features=FEATURES),
             versions=dict(torch=torch.__version__,numpy=np.__version__),checks=checks,
             transformations=dict(log1p_clipped_below_zero=LOG_FEATURES,mode_percent_divided_100=SHARE_FEATURES,
                                  observed_negative_values_clipped=clipped_counts,raw_ranges=raw_ranges,
                                  observed_five_commute_share_sum_range=[float(raw[:,five_commute_idx].sum(1).min()),float(raw[:,five_commute_idx].sum(1).max())],
                                  corrected_source_units={'Employment Rate (%)':'fraction [0,1]','Unemployment Rate (%)':'fraction [0,1]','Built-Up Area Proportion':'percent [0,100]'},
                                  raw_inverse_roundtrip_max_abs_error=float(np.abs(inverse(standardized)-raw).max()),
                                  raw_inverse_roundtrip_max_relative_error=float((np.abs(inverse(standardized)-raw)/np.maximum(1,np.abs(raw))).max()),
                                  train_standardized_mean_max_abs=float(np.abs(standardized[tr].mean(0)).max()),
                                  heldout_standardized_mean_max_abs=float(np.abs(standardized[te].mean(0)).max()),
                                  log_inverse_is_global_bijection=False),
             supplied_deterministic_comparisons=dict(train_mean_nll=constant_d,rank4_pca_mean_reconstruction_nll=pca_d),fits=[])
for seed in CONFIG['seeds']:
    for beta in CONFIG['betas']: results['fits'].append(fit(seed,beta))
results['limits']=['No population MI estimator: reported R is sample average encoder-to-prior KL.',
                   'Expected held-out D differs from decoder-at-encoder-mean reconstruction score.',
                   'Conditional fixed split and three seeds; no independent spatial/external validation.',
                   'Prior outputs are standardized-space Gaussian model cases, not physically validated MSAs.',
                   'No data/checkpoints redistributed; CPU probe is not Colab/student timing or final worked solution.']
pathlib.Path(__file__).with_name('results.json').write_text(json.dumps(results,indent=2)+'\n')
print(json.dumps(dict(checks=checks,transformations=results['transformations'],comparisons=results['supplied_deterministic_comparisons'],
                     fits=[{k:f[k] for k in ['seed','beta','selected_epoch','training_seconds','test','prior_full_observations_support']} for f in results['fits']]),indent=2))
