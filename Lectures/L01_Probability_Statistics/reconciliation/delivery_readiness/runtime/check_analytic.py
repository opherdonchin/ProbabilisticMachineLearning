from pathlib import Path
import json, time, sys
import numpy as np
import scipy
from scipy.stats import norm
import matplotlib
matplotlib.use('Agg')
import matplotlib.pyplot as plt

repo=Path('/home/opher/Repositories/ProbabilisticMachineLearning')
out=Path('/tmp/l01-delivery-runtime')
nb=json.loads((repo/'InClass/Solutions/lecture1_missing_data.ipynb').read_text())
print('Python executable:',sys.executable)
print('Versions:', 'numpy',np.__version__,'scipy',scipy.__version__,'matplotlib',matplotlib.__version__)
print('Fresh process; exact unchanged analytic code cells only. No PyMC/pandas substitutes.')
ns={'np':np,'plt':plt,'RANDOM_SEED':2027,'rng':np.random.default_rng(2027)}
figs=[]
def save_show():
 p=out/f'analytic-figure-{len(figs)+1}.png'
 plt.savefig(p,dpi=120)
 plt.close()
 figs.append(str(p))
plt.show=save_show
for i in [5,12,17,20,47,51,53,57,59,65,67,69]:
 print('Executing original cell',i)
 exec(compile(''.join(nb['cells'][i]['source']),f'original-notebook-cell-{i}','exec'),ns)
np.set_printoptions(precision=12)
mu1,mu2,Sigma11,Sigma12,Sigma21,Sigma22=[ns[k] for k in ['mu1','mu2','Sigma11','Sigma12','Sigma21','Sigma22']]
W,b,Omega,m,S,lgs_mean,lgs_cov=[ns[k] for k in ['W','b','Omega','m','S','lgs_mean','lgs_cov']]
x1_true,x2_obs=[ns[k] for k in ['x1_true','x2_obs']]
joint_eig=np.linalg.eigvalsh(ns['Sigma'])
noise_eig=np.linalg.eigvalsh(Omega)
post_eig=np.linalg.eigvalsh(lgs_cov)
assert joint_eig.min()>0 and noise_eig.min()>0 and post_eig.min()>0
print('Joint eigenvalues:',joint_eig)
print('Noise eigenvalues:',noise_eig)
print('Posterior eigenvalues:',post_eig)
print('Hidden truth:',x1_true,'Observed:',x2_obs)
print('W:',W,'b:',b,'Omega:',Omega,sep='\n')
mean_block=mu1+Sigma12@np.linalg.solve(Sigma22,x2_obs-mu2)
cov_block=Sigma11-Sigma12@np.linalg.solve(Sigma22,Sigma21)
errors={
 'marginal mean':np.max(np.abs(m-mu2)),
 'marginal covariance':np.max(np.abs(S-Sigma22)),
 'cross covariance':np.max(np.abs(Sigma11@W.T-Sigma12)),
 'block versus LGS mean':np.max(np.abs(mean_block-lgs_mean)),
 'block versus LGS covariance':np.max(np.abs(cov_block-lgs_cov)),
}
print('Algebraic max absolute errors:',json.dumps(errors,indent=2))
assert max(errors.values())<1e-12
assert np.allclose(x1_true,[-.981,-.275,1.892],atol=.0005)
assert np.allclose(x2_obs,[-.184,-.070,-.078,.919],atol=.0005)
assert np.allclose(lgs_mean,[-.568,.432,.932],atol=.0005)
assert np.allclose(np.sqrt(np.diag(lgs_cov)),.683,atol=.0005)
print('Notebook rounded answer-key values: PASS')

# Author-side controlled check: draw directly from the known exact posterior.
# This does not execute or stand in for the PyMC branch of the notebook.
n_draws=8000
rng=np.random.default_rng(2027)
t0=time.perf_counter()
draws=rng.multivariate_normal(lgs_mean,lgs_cov,size=n_draws)
draw_seconds=time.perf_counter()-t0
sample_mean=draws.mean(axis=0)
sample_cov=np.cov(draws,rowvar=False)
sample_sd=draws.std(axis=0,ddof=1)
mean_mcse=np.sqrt(np.diag(lgs_cov)/n_draws)
mean_z=(sample_mean-lgs_mean)/mean_mcse
expected_cov_se=np.sqrt((np.outer(np.diag(lgs_cov),np.diag(lgs_cov))+lgs_cov**2)/(n_draws-1))
cov_z=(sample_cov-lgs_cov)/expected_cov_se
print('Direct exact-Gaussian draws:',n_draws,'draw_seconds:',draw_seconds)
print('Exact mean:',lgs_mean,'Direct-draw sample mean:',sample_mean,sep='\n')
print('Mean MCSE:',mean_mcse,'Mean discrepancy / MCSE:',mean_z,sep='\n')
print('Exact SD:',np.sqrt(np.diag(lgs_cov)),'Direct sample SD:',sample_sd,sep='\n')
print('Max abs covariance discrepancy:',np.max(np.abs(sample_cov-lgs_cov)))
print('Max abs covariance discrepancy / theoretical covariance sampling SE:',np.max(np.abs(cov_z)))
assert np.max(np.abs(mean_z))<5
assert np.max(np.abs(cov_z))<5
for j in range(3):
 grid=np.linspace(lgs_mean[j]-4*np.sqrt(lgs_cov[j,j]),lgs_mean[j]+4*np.sqrt(lgs_cov[j,j]),200)
 plt.subplot(1,3,j+1)
 plt.hist(draws[:,j],bins=45,density=True,alpha=.5)
 plt.plot(grid,norm.pdf(grid,lgs_mean[j],np.sqrt(lgs_cov[j,j])))
 plt.title(f'x1[{j}]')
plt.gcf().set_size_inches(10,3)
plt.tight_layout()
save_show()
print('Plots:',figs)
print('ANALYTIC CHECK PASS; full notebook/API/local/hosted publication validation not asserted.')
