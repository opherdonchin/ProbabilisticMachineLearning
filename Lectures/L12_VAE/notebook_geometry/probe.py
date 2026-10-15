"""Teacher-only fixed observation geometry probe. No checkpoint/data redistribution.
Run with existing locked Python; writes only this directory's results and /tmp cache.
The two zero replacements are approximations, never claimed invertible on original data.
"""
import ast, copy, csv, hashlib, io, json, math, pathlib, platform, time, urllib.request
import numpy as np
import torch
from torch import nn

torch.set_num_threads(1)
HERE=pathlib.Path(__file__).resolve().parent
ROOT=HERE.parents[2]
BASE=HERE.parent/'notebook_feasibility/probe.py'
# Reuse exactly the recorded model, loss, feature order and configuration definitions.
source=BASE.read_text(); tree=ast.parse(source)
names={'COMMIT','URL','SHA','FEATURES','LOG_FEATURES','SHARE_FEATURES','CONFIG'}
for node in tree.body:
    if isinstance(node,ast.Assign) and any(isinstance(t,ast.Name) and t.id in names for t in node.targets):
        exec(compile(ast.Module(body=[node],type_ignores=[]),str(BASE),'exec'))
    if isinstance(node,(ast.ClassDef,ast.FunctionDef)) and node.name in {'VAE','terms'}:
        exec(compile(ast.Module(body=[node],type_ignores=[]),str(BASE),'exec'))
cache=pathlib.Path('/tmp/pml-l12-public-source/raw-data-cluster.csv');cache.parent.mkdir(exist_ok=True)
if not cache.exists():cache.write_bytes(urllib.request.urlopen(URL).read())
b=cache.read_bytes();assert hashlib.sha256(b).hexdigest()==SHA
rows=list(csv.DictReader(io.StringIO(b.decode('utf-8-sig'))))
raw=np.array([[float(r[f]) for f in FEATURES] for r in rows]);assert raw.shape==(349,19)
perm=np.random.default_rng(CONFIG['split_seed']).permutation(349)
tr,va,te=perm[:245],perm[245:297],perm[297:]
ci=np.array([FEATURES.index(f) for f in SHARE_FEATURES+['Working from Home Share']])
li=np.array([FEATURES.index(f) for f in LOG_FEATURES])
# All remaining dimensions use log(x-lower), including Fahrenheit above absolute zero.
positive=np.array([j for j in range(19) if j not in ci and j not in [1,10,11,13]])
lower=np.zeros(19);lower[3]=1.;lower[16]=-459.67
bounds={10:1.,11:1.,13:100.}

def composition(a):
    c=a[:,ci]/100
    return np.column_stack([c,1-c.sum(1)])

def interior_approximation(a,delta):
    out=a.copy();c=composition(a);zero=c==0
    for i in np.flatnonzero(zero.any(1)):
        k=zero[i].sum();c[i,~zero[i]]*=1-k*delta;c[i,zero[i]]=delta
    out[:,ci]=100*c[:,:5]
    return out

class Geometry:
    def __init__(self,kind,delta=None):
        self.kind=kind;self.delta=delta
        self.observed=raw.copy() if kind=='baseline' else interior_approximation(raw,delta)
        t=self.forward(self.observed)
        self.center=t[tr].mean(0);self.scale=t[tr].std(0)
        self.standardized=(t-self.center)/self.scale
        assert np.isfinite(self.standardized).all() and (self.scale>0).all()
    def forward(self,a):
        t=a.copy()
        if self.kind=='baseline':
            t[:,[FEATURES.index(f) for f in SHARE_FEATURES]]/=100
            t[:,li]=np.log1p(t[:,li]);return t
        assert (a[:,positive]>lower[positive]).all()
        t[:,positive]=np.log(a[:,positive]-lower[positive])
        for j,B in bounds.items():t[:,j]=np.log(a[:,j])-np.log(B-a[:,j])
        # Triangular conditional bounds preserve two further necessary joint constraints.
        assert (a[:,1]<a[:,0]).all() and (a[:,10]+a[:,11]<1).all()
        t[:,1]=np.log(a[:,1])-np.log(a[:,0]-a[:,1])
        t[:,10]=np.log(a[:,10])-np.log(1-a[:,11]-a[:,10])
        c=composition(a);assert (c>0).all()
        t[:,ci]=np.log(c[:,:5])-np.log(c[:,5,None]);return t
    def inverse(self,u):
        t=np.asarray(u,dtype=np.float64)*self.scale+self.center;a=t.copy()
        if self.kind=='baseline':
            a[:,li]=np.expm1(t[:,li]);a[:,[FEATURES.index(f) for f in SHARE_FEATURES]]*=100;return a
        a[:,positive]=np.exp(t[:,positive])+lower[positive]
        for j,B in bounds.items():a[:,j]=B*np.exp(-np.logaddexp(0,-t[:,j]))
        a[:,1]=a[:,0]*np.exp(-np.logaddexp(0,-t[:,1]))
        a[:,10]=(1-a[:,11])*np.exp(-np.logaddexp(0,-t[:,10]))
        logits=np.column_stack([t[:,ci],np.zeros(len(t))]);logits-=logits.max(1,keepdims=True)
        c=np.exp(logits);c/=c.sum(1,keepdims=True);a[:,ci]=100*c[:,:5];return a
    def logjac(self,a):
        if self.kind=='baseline':return -np.log1p(a[:,li]).sum(1)-4*math.log(100)-np.log(self.scale).sum()
        c=composition(a);assert (c>0).all()
        ans=-np.log(a[:,positive]-lower[positive]).sum(1)
        for j,B in bounds.items():ans+=math.log(B)-np.log(a[:,j])-np.log(B-a[:,j])
        ans+=np.log(a[:,0])-np.log(a[:,1])-np.log(a[:,0]-a[:,1])
        ans+=np.log(1-a[:,11])+np.log(1-a[:,10])-np.log(1-a[:,11]-a[:,10])
        return ans-5*math.log(100)-np.log(c).sum(1)-np.log(self.scale).sum()

def support(a):
    c=composition(a)
    return dict(n=len(a),nonfinite_fraction=float((~np.isfinite(a)).any(1).mean()),
       positive_or_shifted_bound_failure_fraction=float((a[:,positive]<=lower[positive]).any(1).mean()),
       individual_fraction_bound_failure_fraction=float(np.column_stack([(a[:,j]<=0)|(a[:,j]>=B) for j,B in bounds.items()]).any(1).mean()),
       commute_joint_support_failure_fraction=float(((c<0).any(1)|(c>1).any(1)).mean()),
       circuity_below_one_fraction=float((a[:,3]<1).mean()),
       intersection_density_above_node_density_fraction=float((a[:,1]>a[:,0]).mean()),
       employment_plus_unemployment_above_one_fraction=float((a[:,10]+a[:,11]>1).mean()))

rawsd=raw[tr].std(0)
selected=[1,3,5,6,13,14,15,16,17,18]
def summaries(a):
    c=composition(a);corr=np.corrcoef(a,rowvar=False);realcorr=np.corrcoef(raw[tr],rowvar=False)
    mask=~np.eye(19,dtype=bool)
    d=((a[:,None,:]-raw[tr][None,:,:])/rawsd)**2
    # Climate relation is a diagnostic, not imposed as exact for heterogeneous source aggregation.
    residual=a[:,14]-a[:,15]-366*(a[:,16]-65)
    return dict(support=support(a),
       selected_q05_q50_q95={FEATURES[j]:np.quantile(a[:,j],[.05,.5,.95]).tolist() for j in selected},
       omitted_commute_share_q05_q50_q95=np.quantile(c[:,5],[.05,.5,.95]).tolist(),
       correlation_offdiagonal_rmse=float(np.sqrt(np.mean((corr-realcorr)[mask]**2))),
       nearest_training_raw_sd_distance_q50_q95=np.quantile(np.sqrt(d.sum(-1).min(1)),[.5,.95]).tolist(),
       any_feature_outside_training_range_fraction=float(((a<raw[tr].min(0))|(a>raw[tr].max(0))).any(1).mean()),
       annual_climate_residual_degree_days_q05_q50_q95=np.quantile(residual,[.05,.5,.95]).tolist())

@torch.no_grad()
def evaluate(model,X,inds,draws,seed):
    x=X[inds];mu,ell=model.encode(x);g=torch.Generator().manual_seed(seed)
    eps=torch.randn(draws,len(inds),4,generator=g);z=mu[None]+torch.exp(.5*ell)[None]*eps
    rec=model.dec(z.reshape(-1,4)).reshape(draws,len(inds),19)
    D=(x[None]-rec).square().sum(-1)+9.5*math.log(math.pi)
    r=.5*(mu.square()+torch.exp(ell)-1-ell)
    dm=(x-model.dec(mu)).square().sum(-1)+9.5*math.log(math.pi)
    return dict(D=float(D.mean()),D_mc_se=float(D.mean(-1).std(unbiased=True)/math.sqrt(draws)),
                R=float(r.sum(-1).mean()),per_latent_rate=r.mean(0).tolist(),mean_code_D=float(dm.mean()))

def fit(geo,seed,beta):
    X=torch.tensor(geo.standardized,dtype=torch.float32)
    torch.manual_seed(seed);model=VAE();opt=torch.optim.Adam(model.parameters(),lr=.003)
    best=float('inf');state=None;chosen=None;start=time.perf_counter()
    for ep in range(1,301):
        order=tr[torch.randperm(len(tr)).numpy()]
        for pos in range(0,len(tr),32):
            xb=X[order[pos:pos+32]];rec,mu,ell=model(xb,torch.randn(len(xb),4));D,R=terms(xb,rec,mu,ell)
            loss=(D+beta*R).mean();assert torch.isfinite(loss)
            opt.zero_grad();loss.backward();opt.step()
        if ep%20==0:
            s=evaluate(model,X,va,16,901);criterion=s['D']+beta*s['R']
            if criterion<best:best=criterion;state=copy.deepcopy(model.state_dict());chosen=ep
    model.load_state_dict(state);seconds=time.perf_counter()-start
    test=evaluate(model,X,te,64,902)
    test['raw_units_expected_decoder_NLL']=test['D']-float(geo.logjac(raw[te]).mean())
    test['raw_units_negative_ELBO']=test['raw_units_expected_decoder_NLL']+test['R']
    # Test has no zero rows; density bookkeeping is exact there for each model.
    with torch.no_grad():
        g=torch.Generator().manual_seed(904);z=torch.randn(2000,4,generator=g)
        um=model.dec(z);uo=um+math.sqrt(.5)*torch.randn(2000,19,generator=g)
        tm,tl=model.encode(X[te]);rec=model.dec(tm).numpy();back=geo.inverse(rec)
        # Mean observation conditional on z=encoder mean, distinct from posterior averaging.
        g2=torch.Generator().manual_seed(905)
        noise=torch.randn(1024,len(te),19,generator=g2).numpy()*math.sqrt(.5)
        draws=geo.inverse((rec[None]+noise).reshape(-1,19)).reshape(1024,len(te),19)
        mcmean=draws.mean(0)
    recon=dict(mean_code_backtransform_raw_sd_RMSE=float(np.sqrt(np.mean(((back-raw[te])/rawsd)**2))),
       conditional_observation_MC_mean_raw_sd_RMSE=float(np.sqrt(np.mean(((mcmean-raw[te])/rawsd)**2))),
       mean_code_backtransform_per_feature_raw_sd_RMSE=np.sqrt(np.mean(((back-raw[te])/rawsd)**2,axis=0)).tolist(),
       conditional_MC_mean_vs_backtransform_raw_sd_RMS_difference=float(np.sqrt(np.mean(((mcmean-back)/rawsd)**2))),
       conditional_MC_mean_vs_backtransform_selected_median_difference={FEATURES[j]:float(np.median(mcmean[:,j]-back[:,j])) for j in selected})
    return dict(kind=geo.kind,zero_replacement_delta=geo.delta,seed=seed,beta=beta,selected_epoch=chosen,
       training_seconds=seconds,validation_selected_objective=best,test=test,reconstruction=recon,
       prior_decoder_mean_backtransforms=summaries(geo.inverse(um.numpy())),
       prior_full_observations=summaries(geo.inverse(uo.numpy())))

geos=[Geometry('baseline'),Geometry('fixed_transform',1e-5)]
g=geos[1]
# Independent Jacobian check of the complete 19-dimensional standardized map.
x=torch.tensor(g.observed[0],dtype=torch.float64,requires_grad=True)
def torchmap(x):
    y=x.clone();y[positive]=torch.log(x[positive]-torch.tensor(lower[positive]))
    for j,B in bounds.items():y[j]=torch.log(x[j])-torch.log(B-x[j])
    y[1]=torch.log(x[1])-torch.log(x[0]-x[1])
    y[10]=torch.log(x[10])-torch.log(1-x[11]-x[10])
    c=x[ci]/100;res=1-c.sum();y[ci]=torch.log(c)-torch.log(res)
    return (y-torch.tensor(g.center))/torch.tensor(g.scale)
J=torch.autograd.functional.jacobian(torchmap,x)
_,ld=torch.linalg.slogdet(J)
checks=dict(jacobian_autodiff_abs_error=abs(float(ld)-float(g.logjac(g.observed[:1])[0])),
            original_zero_rows=np.flatnonzero((raw[:,ci]==0).any(1)).tolist(),
            test_has_only_interior_compositions=bool((composition(raw[te])>0).all()),
            approximated_rows_by_split={n:[int(i) for i in ids if i in [11,94]] for n,ids in [('train',tr),('validation',va),('test',te)]})
for geo in geos:
    back=geo.inverse(geo.standardized)
    checks[geo.kind+'_roundtrip_max_relative_error']=float(np.max(np.abs(back-geo.observed)/np.maximum(1,np.abs(geo.observed))))
    checks[geo.kind+'_train_center_max_abs']=float(abs(geo.standardized[tr].mean(0)).max())
    checks[geo.kind+'_train_scale_max_error']=float(abs(geo.standardized[tr].std(0)-1).max())
assert checks['jacobian_autodiff_abs_error']<1e-10
assert max(v for k,v in checks.items() if 'roundtrip' in k)<1e-12
results=dict(status='teacher-only computational feasibility; no student or Colab claim',
 source=dict(url=URL,sha256=SHA,base_probe_sha256=hashlib.sha256(BASE.read_bytes()).hexdigest(),
             input_sha256={p:hashlib.sha256((ROOT/p).read_bytes()).hexdigest() for p in ['course_architecture.typ','curriculum_map.typ','curriculum_map_actual.typ','Lectures/L12_VAE/lecture_scope.md','Lectures/L12_VAE/scope_investigation.md','Lectures/L12_VAE/notebook_feasibility/source_units.json','.agents/skills/teaching-notebook-authoring/references/student-knowledge.md','pyproject.toml','uv.lock']},
             config_sha256=hashlib.sha256(json.dumps(CONFIG,sort_keys=True).encode()).hexdigest(),
             this_probe_sha256=hashlib.sha256(pathlib.Path(__file__).read_bytes()).hexdigest(),
             split_indices_sha256=hashlib.sha256(perm.astype('<i8').tobytes()).hexdigest()),
 config=CONFIG,versions=dict(torch=torch.__version__,numpy=np.__version__,python=platform.python_version()),checks=checks,
 approximation=dict(delta=1e-5,sensitivity_delta=1e-4,affected_rows=[dict(index=int(i),msa=rows[i]['msa'],
   original=raw[i,ci].tolist(),replaced=g.observed[i,ci].tolist()) for i in [11,94]],
   rule='Replace zero composition part by delta and multiply all nonzero parts, including residual, by (1-number_of_zeros*delta). Only two rows altered; no rows removed.'),
 raw_ranges={f:[float(raw[:,j].min()),float(raw[:,j].max())] for j,f in enumerate(FEATURES)},
 transforms=[dict(kind=geo.kind,delta=geo.delta,center=geo.center.tolist(),scale=geo.scale.tolist(),
                   mean_test_logjac=float(geo.logjac(raw[te]).mean())) for geo in geos],
 real_training=summaries(raw[tr]),real_test=summaries(raw[te]),fits=[])
for geo in geos:
    for seed in CONFIG['seeds']:
        for beta in CONFIG['betas']:
            f=fit(geo,seed,beta);results['fits'].append(f)
            print(geo.kind,geo.delta,seed,beta,'D/R',f['test']['D'],f['test']['R'],flush=True)
# One declared sensitivity at each beta, seed 17; no model selection from this comparison.
geo=Geometry('fixed_transform',1e-4)
results['sensitivity_transform']=dict(delta=geo.delta,center=geo.center.tolist(),scale=geo.scale.tolist())
for beta in CONFIG['betas']:results['fits'].append(fit(geo,17,beta))
# Exact baseline reproduction excluding timings and new diagnostics.
old=json.loads((HERE.parent/'notebook_feasibility/results.json').read_text())
results['checks']['baseline_max_D_R_difference_from_committed_probe']=max(abs(a['test'][k]-b['test'][k]) for a,b in zip(results['fits'][:6],old['fits']) for k in ['D','R'])
assert results['checks']['baseline_max_D_R_difference_from_committed_probe']==0
for f in results['fits']:
    if f['kind']=='fixed_transform':
        for group in ['prior_decoder_mean_backtransforms','prior_full_observations']:
            assert all(v==0 for k,v in f[group]['support'].items() if k!='n')
(HERE/'results.json').write_text(json.dumps(results,indent=2)+'\n')
print('All checks passed; wrote',HERE/'results.json')
