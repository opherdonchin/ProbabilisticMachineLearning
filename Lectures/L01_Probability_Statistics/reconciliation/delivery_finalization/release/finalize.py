import datetime
import hashlib
import importlib.util
import json
from pathlib import Path
import shutil
import subprocess

ROOT = Path('/home/opher/Repositories/ProbabilisticMachineLearning')
OUT = Path('/tmp/l01-release-readiness')
EXEC = ROOT/'build/notebooks/InClass/Solutions/lecture1_missing_data.executed.ipynb'
sha = lambda data: hashlib.sha256(data).hexdigest()
norm = lambda cell: (cell['id'], cell['cell_type'], ''.join(cell['source']) if isinstance(cell['source'], list) else cell['source'])
solved = json.loads((ROOT/'InClass/Solutions/lecture1_missing_data.ipynb').read_text())
approved = json.loads(subprocess.check_output(['git', 'show', 'e5c52f6:InClass/Solutions/lecture1_missing_data.ipynb'], cwd=ROOT))
executed = json.loads(EXEC.read_text())
data = {'code_cell_results': [{'cell_index': i, 'id': c['id'], 'execution_count': c['execution_count'], 'success': c['execution_count'] is not None and not any(o['output_type'] == 'error' for o in c['outputs']), 'source_sha256': sha(norm(c)[2].encode()), 'outputs_sha256': sha(json.dumps(c['outputs'], sort_keys=True, ensure_ascii=False, separators=(',', ':')).encode()), 'output_types': [o['output_type'] for o in c['outputs']]} for i, c in enumerate(executed['cells']) if c['cell_type'] == 'code'], 'approved_e5c52f6_source_type_id_match': [norm(c) for c in approved['cells']] == [norm(c) for c in solved['cells']], 'current_uv_python_has_pip': importlib.util.find_spec('pip') is not None, 'tracked_changes_from_assigned_baseline': subprocess.check_output(['git', 'status', '--short'], cwd=ROOT, text=True)}
(OUT/'cell-results.json').write_text(json.dumps(data, indent=2)+'\n')
shutil.copyfile(EXEC, OUT/'lecture1_missing_data.executed.ipynb')
for f in ('wheel_build.txt', 'isolated_git_install.txt'):
    shutil.copyfile(ROOT/'Lectures/L01_Probability_Statistics/reconciliation/delivery_readiness/runtime/support_package'/f, OUT/f'reused-{f}')
shutil.copyfile('/tmp/l01-support-wheel/pml_course_support-0.1.0-py3-none-any.whl', OUT/'pml_course_support-0.1.0-py3-none-any.whl')
files = {str(p.relative_to(OUT)): {'sha256': sha(p.read_bytes()), 'bytes': p.stat().st_size} for p in sorted(OUT.rglob('*')) if p.is_file() and 'uv-cache' not in p.parts and p.name != 'manifest.json'}
(OUT/'manifest.json').write_text(json.dumps({'created_at_utc': datetime.datetime.now(datetime.timezone.utc).isoformat(), 'baseline_commit': '196e5e56a75f833e8a06f7077b951865487d61cd', 'scope': 'Read-only release validation; current source unchanged. uv cache excluded.', 'files': files}, indent=2)+'\n')
print(json.dumps({'all_23_success': all(c['success'] for c in data['code_cell_results']), 'approved_source_match': data['approved_e5c52f6_source_type_id_match'], 'has_pip': data['current_uv_python_has_pip'], 'manifest_files': len(files)}, indent=2))
