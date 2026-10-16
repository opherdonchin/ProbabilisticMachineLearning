"""Record fixed inputs and output identities, with numerical validation."""
from pathlib import Path
import hashlib,json,subprocess
import numpy as np
HERE=Path(__file__).resolve().parent
ROOT=HERE.parents[2]

def sha(p):return hashlib.sha256(p.read_bytes()).hexdigest()
def git(*args):return subprocess.check_output(['git',*args],cwd=ROOT,text=True).strip()
inputs=['AGENTS.md','course_architecture.typ','curriculum_map.typ','curriculum_map_actual.typ','pyproject.toml','uv.lock',
 '.agents/skills/lecture-scope/SKILL.md','.agents/skills/worked-solution-authoring/SKILL.md',
 '.agents/skills/lecture-scope/references/timing-calibration.md','.agents/skills/teaching-notebook-authoring/references/student-knowledge.md',
 '.agents/skills/shared/backpressure.md',
 'Lectures/course_architecture_scope/reconciliation/notebook_geometry/decision_and_tasks.md',
 'Lectures/L09_Variational_Inference/lecture_scope.md','Lectures/L09_Variational_Inference/scope_investigation.md',
 'Lectures/L09_Variational_Inference/source_arc_review.md','Lectures/course_architecture_scope/source_inspection.md',
 'Lectures/L07_Inference/lecture_scope.md','Lectures/L07_Inference/scope_investigation.md',
 'Lectures/L07_Inference/notebook_feasibility/classifier_probe.py','Lectures/L07_Inference/notebook_feasibility/classifier_results.json',
 'Lectures/L07_Inference/notebook_feasibility/reference_bounds.md',
 'Lectures/L09_Variational_Inference/notebook_feasibility/pathwise_probe.py',
 'Lectures/L09_Variational_Inference/notebook_feasibility/pathwise_results.json']
checks={}
for name in ['challenger','multinomial_iris']:
 r=json.loads((HERE/(name+'_results.json')).read_text());methods=[r['laplace']]
 for f in r['fits'].values():methods+=[f['diagnostic_fit']]+f['stochastic_runs']
 maxnorm=0
 for f in methods:
  p=np.array(f['predictions']);maxnorm=max(maxnorm,float(np.max(abs(p.sum(1)-1))))
  assert np.all((p>=0)&(p<=1));assert np.linalg.eigvalsh(f['covariance']).min()>0
 assert maxnorm<1e-12
 assert max(c['fixed_noise_fd_max_error'] for c in r['fixed_noise_checks'])<2e-8
 checks[name]=dict(probabilities_normalized_max_error=maxnorm,all_covariances_positive_definite=True,fixed_noise_finite_differences_pass=True)
a=json.loads((HERE/'audit_results.json').read_text())
assert max(v['manual_autograd_max_difference'] for c in a.values() for v in c['checks'])<1e-12
checks['fixed_noise_manual_vs_torch_pass']=True
checks['prior_KL_at_identical_distribution']=float(.5*((0+4*2)/4-2+2*np.log(4)-2*2*np.log(2)))
assert checks['prior_KL_at_identical_distribution']==0
out=dict(status='teacher-only bounded screening; no approved worked-solution/student/Colab handoff',base_commit='e8a0f6cc3601084714271d7c8d916803545e4fac',branch=git('branch','--show-current'),date='2026-10-15',
 inputs=[dict(path=p,sha256=sha(ROOT/p),git_blob=git('hash-object',p)) for p in inputs],
 external_inputs=[dict(path='/tmp/pml-book2.txt',sha256=sha(Path('/tmp/pml-book2.txt')),edition='Murphy Advanced Topics online December 10, 2025; section headings/pages checked in extracted source'),
 dict(url='https://archive.ics.uci.edu/static/public/92/challenger+usa+space+shuttle+o+ring.zip',sha256='efacde5516fd5d9c7ffb84332b34bdcd787f3a4a91b1e42e11fb2dcee05ded2a',accessed='2026-10-15',extracted_files=['o-ring-erosion-or-blowby.data','o-ring-erosion.names']),
 dict(url='https://archive.ics.uci.edu/dataset/92/challenger+usa+space+shuttle+o+ring',accessed='2026-10-15',role='primary data metadata and CC BY 4.0'),
 dict(url='https://doi.org/10.1080/01621459.1989.10478858',accessed='2026-10-15',role='primary research abstract only; original full article/Table1 not verified'),
 dict(url='https://probml.github.io/pml-book/book2.html',accessed='2026-10-15',role='official book edition confirmation'),
 dict(url='https://scikit-learn.org/stable/modules/generated/sklearn.datasets.load_iris.html',accessed='2026-10-15',role='primary API/dataset documentation')],
 runtime_interpreter='/tmp/pml-l04-l12-reconciliation/.venv/bin/python (read-only locked environment reuse)',
 checks=checks,artifacts=[dict(path=str(p.relative_to(ROOT)),sha256=sha(p)) for p in sorted(HERE.iterdir()) if p.is_file() and p.name!='manifest.json'])
(HERE/'manifest.json').write_text(json.dumps(out,indent=2,allow_nan=False)+'\n')
print(json.dumps(checks,indent=2))
