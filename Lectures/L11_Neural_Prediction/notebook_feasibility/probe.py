"""Author feasibility probe, not a student notebook or approved worked solution.
Run with the repository uv Python; writes a compact JSON result beside this file.
All configuration/seeds are fixed in code before reading held-out results.
"""
import copy
import json
import math
import pathlib
import time
import numpy as np
import torch
from torch import nn

TORCH_THREADS = 1
torch.set_num_threads(TORCH_THREADS)
SEEDS = [17, 29, 43]
CONFIG = dict(data_seed=20261014, n_train=320, n_validation=80, n_test=80,
              hidden=32, epochs=800, validation_every=20, lr=0.01,
              sd_floor=0.03, seeds=SEEDS, threads=TORCH_THREADS,
              training='full batch Adam; minimum validation NLL checkpoint')

def nll(y, mean, sd):
    assert y.shape == mean.shape == sd.shape and y.ndim == 2 and y.shape[1] == 1
    return (0.5 * math.log(2 * math.pi) + torch.log(sd)
            + (y - mean).square() / (2 * sd.square())).mean()

class Model(nn.Module):
    def __init__(self, hetero):
        super().__init__()
        self.hidden = nn.Sequential(nn.Linear(1, 32), nn.ReLU())
        self.mean = nn.Linear(32, 1)
        self.scale = nn.Linear(32, 1) if hetero else None
    def forward(self, x):
        h = self.hidden(x)
        mean = self.mean(h)
        return mean, (0.03 + nn.functional.softplus(self.scale(h)) if self.scale else None)

# Local loss and complete softplus-head derivatives; float64 for numerical checking.
y0 = torch.tensor([[1.3], [-0.6], [0.9]], dtype=torch.float64)
m0 = torch.tensor([[0.2], [-0.1], [0.7]], dtype=torch.float64, requires_grad=True)
a0 = torch.tensor([[-1.0], [0.4], [1.0]], dtype=torch.float64, requires_grad=True)
s0 = 0.03 + nn.functional.softplus(a0)
loss0 = nll(y0, m0, s0)
gm, ga = torch.autograd.grad(loss0, (m0, a0))
manual_m = (m0-y0)/s0.square()/len(y0)
manual_a = (1/s0-(y0-m0).square()/s0.pow(3))*torch.sigmoid(a0)/len(y0)
checks = dict(loss_reference_abs_error=float((loss0-torch.distributions.Normal(m0,s0).log_prob(y0).neg().mean()).abs().detach()),
              mean_gradient_max_error=float((gm-manual_m).abs().max().detach()),
              scale_gradient_max_error=float((ga-manual_a).abs().max().detach()),
              float64_gradcheck=bool(torch.autograd.gradcheck(lambda m,a:nll(y0,m,0.03+nn.functional.softplus(a)),(m0,a0))))
# Verify shared hidden adjoint is the sum of both output contributions.
h = torch.tensor([[0.3,0.7],[0.4,0.2]],dtype=torch.float64,requires_grad=True)
wm = torch.tensor([[0.4],[0.2]],dtype=torch.float64)
ws = torch.tensor([[0.8],[-0.4]],dtype=torch.float64)
mm, aa = h@wm, h@ws
ss = .03+nn.functional.softplus(aa)
yb=y0[:2]
full=nll(yb,mm,ss)
gfull=torch.autograd.grad(full,h,retain_graph=True)[0]
gmean=torch.autograd.grad(nll(yb,mm,ss.detach()),h,retain_graph=True)[0]
gscale=torch.autograd.grad(nll(yb,mm.detach(),ss),h)[0]
checks['shared_hidden_gradient_sum_max_error']=float((gfull-gmean-gscale).abs().max())
checks['mean_and_scale_path_norms']=[float(gmean.norm()),float(gscale.norm())]
assert checks['float64_gradcheck'] and max(checks[k] for k in checks if 'error' in k)<1e-12

rng=np.random.default_rng(CONFIG['data_seed'])
x=rng.uniform(-3,3,(480,1))
# Deliberately course-constructed easy interpolation law; not Murphy's source data.
true_mean=np.sin(1.5*x)+0.2*x
true_sd=0.15+0.5/(1+np.exp(-1.5*x))
y=true_mean+true_sd*rng.normal(size=x.shape)
# Train-only normalization, labels stay in their original units.
xcenter=x[:320].mean(0); xscale=x[:320].std(0)
xt=torch.tensor((x-xcenter)/xscale,dtype=torch.float32)
yt=torch.tensor(y,dtype=torch.float32)
train=slice(0,320); valid=slice(320,400); test=slice(400,480)

@torch.no_grad()
def summary(mean,sd):
    mean,sd=np.asarray(mean),np.asarray(sd)
    assert mean.shape==sd.shape==(80,1)
    yy=y[test]
    lo=x[test,0]<0; hi=~lo
    covered=np.abs(yy-mean)<=1.96*sd
    regions={}
    for name,mask in [('x<0',lo),('x>=0',hi)]:
        p=float(covered[mask].mean()); n=int(mask.sum())
        den=1+1.96**2/n
        wc=(p+1.96**2/(2*n))/den
        wh=1.96*math.sqrt(p*(1-p)/n+1.96**2/(4*n*n))/den
        regions[name]=dict(n=n,coverage=p,wilson95=[wc-wh,wc+wh],mean_sd=float(sd[mask].mean()))
    return dict(nll=float((.5*math.log(2*math.pi)+np.log(sd)+(yy-mean)**2/(2*sd**2)).mean()),
                mse=float(((yy-mean)**2).mean()),mean_function_rmse=float(np.sqrt(((true_mean[test]-mean)**2).mean())),
                sd_function_rmse=float(np.sqrt(((true_sd[test]-sd)**2).mean())),
                min_sd=float(sd.min()),coverage=float(covered.mean()),regional=regions)

def fit(seed,hetero):
    torch.manual_seed(seed)
    model=Model(hetero)
    opt=torch.optim.Adam(model.parameters(),lr=CONFIG['lr'])
    best=float('inf'); best_state=None; best_epoch=None
    start=time.perf_counter()
    for epoch in range(1,801):
        mm,ss=model(xt[train]); opt.zero_grad()
        # Fixed-scale model's mean fit is exactly MSE-equivalent.
        loss=nll(yt[train],mm,ss) if hetero else (yt[train]-mm).square().mean()
        assert torch.isfinite(loss)
        loss.backward(); opt.step()
        if epoch%20==0:
            with torch.no_grad():
                if not hetero:
                    fixed_sd=(yt[train]-model(xt[train])[0]).square().mean().sqrt().clamp_min(.03)
                vm,vs=model(xt[valid])
                score=float(nll(yt[valid],vm,vs if hetero else fixed_sd.expand_as(vm)))
            if score<best:
                best=score; best_state=copy.deepcopy(model.state_dict()); best_epoch=epoch
    model.load_state_dict(best_state)
    with torch.no_grad():
        if not hetero: fixed_sd=(yt[train]-model(xt[train])[0]).square().mean().sqrt().clamp_min(.03)
        mm,ss=model(xt[test]); ss=ss if hetero else fixed_sd.expand_as(mm)
    return dict(seed=seed,selected_epoch=best_epoch,validation_nll=best,training_seconds=time.perf_counter()-start,
                metrics=summary(mm.numpy(),ss.numpy()),parameters=sum(p.numel() for p in model.parameters()))

# Supplied affine baseline: closed-form training-only MLE, fixed Gaussian scale.
affine_X=np.c_[np.ones(480),((x-xcenter)/xscale)[:,0]]
coef=np.linalg.lstsq(affine_X[train],y[train],rcond=None)[0]
affine_sd=np.sqrt(((y[train]-affine_X[train]@coef)**2).mean())
results=dict(config=CONFIG,versions=dict(torch=torch.__version__,numpy=np.__version__),checks=checks,
             generating_law=dict(mean='sin(1.5*x)+0.2*x',sd='0.15+0.5*sigmoid(1.5*x)',x='iid uniform[-3,3]'),
             affine=summary(affine_X[test]@coef,np.full((80,1),affine_sd)),
             oracle=summary(true_mean[test],true_sd[test]),heteroskedastic=[],fixed_scale_nonlinear=[])
for seed in SEEDS:
    results['heteroskedastic'].append(fit(seed,True))
    results['fixed_scale_nonlinear'].append(fit(seed,False))
results['limits']=['Same fixed data split across three initialization seeds; no independent dataset replication.',
                   'Configuration not selected by test outcomes; validation checkpoint selection uses no test observations.',
                   'Coarse coverage estimates have large binomial uncertainty and are not a calibration guarantee.',
                   'Fixed weight predictions model conditional variation; no weight posterior was fitted.',
                   'CPU probe only: no Colab, student timing or final worked solution claim.']
path=pathlib.Path(__file__).with_name('results.json')
path.write_text(json.dumps(results,indent=2)+'\n')
print(json.dumps({k:results[k] for k in ['checks','affine','heteroskedastic','fixed_scale_nonlinear']},indent=2))
