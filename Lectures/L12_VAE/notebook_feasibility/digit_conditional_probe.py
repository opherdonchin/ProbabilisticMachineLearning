"""Conditional alternative only: 8x8 binary handwritten-digit VAE.
This is NOT an approved mobility replacement and changes likelihood/data semantics.
Uses sklearn's packaged UCI digits, so no unpinned download or data copy is needed.
"""
import json,math,pathlib,time
import numpy as np
import sklearn
from sklearn.datasets import load_digits
import torch
from torch import nn

torch.set_num_threads(1)
CONFIG=dict(seed=17,split_seed=20261014,n_train=1397,n_validation=200,n_test=200,
            input=64,hidden=32,latent=4,epochs=100,batch_size=64,lr=.003,beta=1,
            observation='Bernoulli per pixel after fixed threshold original intensity > 8',
            status='conditional unapproved fallback; not MNIST/source convolutional notebook')
x=torch.tensor((load_digits().data>8).astype(np.float32))
inds=np.random.default_rng(CONFIG['split_seed']).permutation(len(x));tr,va,te=inds[:1397],inds[1397:1597],inds[1597:]
class Model(nn.Module):
    def __init__(self):
        super().__init__();self.enc=nn.Sequential(nn.Linear(64,32),nn.ReLU(),nn.Linear(32,8))
        self.dec=nn.Sequential(nn.Linear(4,32),nn.ReLU(),nn.Linear(32,64))
    def forward(self,xb,eps):
        mu,ell=self.enc(xb).chunk(2,-1);z=mu+torch.exp(ell/2)*eps
        return self.dec(z),mu,ell

def terms(xb,logits,mu,ell):
    D=nn.functional.binary_cross_entropy_with_logits(logits,xb,reduction='none').sum(-1)
    R=.5*(mu.square()+torch.exp(ell)-1-ell).sum(-1)
    return D,R
@torch.no_grad()
def evaluate(model,subset):
    g=torch.Generator().manual_seed(901);ds=[]
    for i in range(32):
        logits,mu,ell=model(x[subset],torch.randn(len(subset),4,generator=g));D,R=terms(x[subset],logits,mu,ell);ds.append(D.mean())
    return dict(D=float(torch.stack(ds).mean()),R=float(R.mean()),D_mc_se=float(torch.stack(ds).std()/math.sqrt(32)))
import copy
torch.manual_seed(17);model=Model();opt=torch.optim.Adam(model.parameters(),lr=.003)
start=time.perf_counter();best=float('inf');state=None;epochbest=None
for ep in range(1,101):
    order=tr[torch.randperm(len(tr)).numpy()]
    for pos in range(0,len(tr),64):
        xb=x[order[pos:pos+64]];logits,mu,ell=model(xb,torch.randn(len(xb),4));D,R=terms(xb,logits,mu,ell)
        opt.zero_grad();loss=(D+R).mean();assert torch.isfinite(loss);loss.backward();opt.step()
    if ep%20==0:
        score=evaluate(model,va);v=score['D']+score['R']
        if v<best:best=v;state=copy.deepcopy(model.state_dict());epochbest=ep
model.load_state_dict(state)
result=dict(config=CONFIG,versions=dict(torch=torch.__version__,sklearn=sklearn.__version__),
            selected_epoch=epochbest,training_seconds=time.perf_counter()-start,test=evaluate(model,te),
            parameters=sum(p.numel() for p in model.parameters()),
            caveats=['No visual plausibility or student-time trial; binary support does not imply recognizable handwritten digits.',
                     'Thresholding discards grayscale information; this changes the task and observation likelihood.',
                     'No beta comparison, no claim to preserve the existing 19-feature mobility scope or τ²=.5 Gaussian example.',
                     'No data/checkpoint copies stored; no hosted Colab claim.'])
pathlib.Path(__file__).with_name('digit_conditional_results.json').write_text(json.dumps(result,indent=2)+'\n')
print(json.dumps(result,indent=2))
