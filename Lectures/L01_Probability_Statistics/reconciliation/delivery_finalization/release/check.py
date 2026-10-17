import hashlib
import importlib.metadata
import json
import pathlib
import subprocess
import sys
import zipfile

ROOT = pathlib.Path('/home/opher/Repositories/ProbabilisticMachineLearning')
OUT = pathlib.Path('/tmp/l01-release-readiness')
SOLVED = 'InClass/Solutions/lecture1_missing_data.ipynb'
STUDENT = 'InClass/lecture1_missing_data.ipynb'
EXEC = 'build/notebooks/InClass/Solutions/lecture1_missing_data.executed.ipynb'
PIN = '7304c542dd1b0bfd6762ea08d2cb384ffd7d2e39'

def sha(data):
    return hashlib.sha256(data).hexdigest()

def canonical(data):
    return json.dumps(data, ensure_ascii=False, sort_keys=True, separators=(',', ':')).encode()

def src(cell):
    s = cell['source']
    return ''.join(s) if isinstance(s, list) else s

def source_projection(nb):
    return [{'id': c['id'], 'cell_type': c['cell_type'], 'source': src(c)} for c in nb['cells']]

def saved_projection(nb):
    return [{'id': c['id'], 'execution_count': c.get('execution_count'), 'outputs': c.get('outputs', [])} for c in nb['cells'] if c['cell_type'] == 'code']

def notebook_details(path):
    nb = json.loads(path.read_text())
    codes = [c for c in nb['cells'] if c['cell_type'] == 'code']
    errors = [{'id': c['id'], 'output': o} for c in codes for o in c.get('outputs', []) if o['output_type'] == 'error']
    return {'file_sha256': sha(path.read_bytes()), 'source_projection_sha256': sha(canonical(source_projection(nb))), 'saved_execution_sha256': sha(canonical(saved_projection(nb))), 'cells': len(nb['cells']), 'code_cells': len(codes), 'executed_code_cells': sum(c.get('execution_count') is not None for c in codes), 'execution_counts': [c.get('execution_count') for c in codes], 'errors': errors, 'png_outputs': sum('image/png' in o.get('data', {}) for c in codes for o in c.get('outputs', []))}

if sys.argv[1] == 'before':
    files = [SOLVED, STUDENT, 'pyproject.toml', 'uv.lock', 'scripts/execute_notebook.py', 'scripts/make_self_work_notebook.py', *[str(p.relative_to(ROOT)) for p in (ROOT/'notebook_support').rglob('*') if p.is_file() and 'egg-info' not in str(p) and '__pycache__' not in str(p) and '/build/' not in str(p)]]
    before = {'head': subprocess.check_output(['git', 'rev-parse', 'HEAD'], cwd=ROOT, text=True).strip(), 'files': {f: sha((ROOT/f).read_bytes()) for f in files}, 'solved': notebook_details(ROOT/SOLVED), 'student': notebook_details(ROOT/STUDENT)}
    (OUT/'baseline.json').write_text(json.dumps(before, indent=2)+'\n')
    print(json.dumps(before, indent=2))
else:
    import nbformat
    from jupyter_client.kernelspec import KernelSpecManager
    import course_support.l01
    baseline = json.loads((OUT/'baseline.json').read_text())
    stable = {f: sha((ROOT/f).read_bytes()) == expected for f, expected in baseline['files'].items()}
    solved = json.loads((ROOT/SOLVED).read_text())
    student = json.loads((ROOT/STUDENT).read_text())
    generated = json.loads((OUT/'student.generated.ipynb').read_text())
    executed = json.loads((ROOT/EXEC).read_text())
    for path in (ROOT/SOLVED, ROOT/STUDENT, OUT/'student.generated.ipynb', ROOT/EXEC):
        nbformat.validate(nbformat.read(path, as_version=4))
    old = json.loads((ROOT/'Lectures/L01_Probability_Statistics/reconciliation/delivery_readiness/runtime/support_package/validation.json').read_text())
    old_hashes = {f: {'recorded': expected, 'current': sha((ROOT/f).read_bytes()), 'equal': sha((ROOT/f).read_bytes()) == expected} for f, expected in old['sha256'].items() if f in ('notebook_support/src/course_support/l01.py', 'notebook_support/pyproject.toml', 'pyproject.toml', 'uv.lock', 'scripts/make_self_work_notebook.py')}
    package_files = subprocess.check_output(['git', 'ls-tree', '-r', '--name-only', PIN, 'notebook_support'], cwd=ROOT, text=True).splitlines()
    pinned = {f: sha(subprocess.check_output(['git', 'show', f'{PIN}:{f}'], cwd=ROOT)) == sha((ROOT/f).read_bytes()) for f in package_files}
    wheel = pathlib.Path('/tmp/l01-support-wheel/pml_course_support-0.1.0-py3-none-any.whl')
    with zipfile.ZipFile(wheel) as z:
        metadata = z.read('pml_course_support-0.1.0.dist-info/METADATA').decode()
        wheel_info = {'file': str(wheel), 'sha256': sha(wheel.read_bytes()), 'source_files_match_current': {f: z.read(f'course_support/{f}') == (ROOT/'notebook_support/src/course_support'/f).read_bytes() for f in ('__init__.py', 'l01.py')}, 'requires_dist': [line for line in metadata.splitlines() if line.startswith('Requires-Dist:')], 'requires_python': [line for line in metadata.splitlines() if line.startswith('Requires-Python:')]}
    ks = KernelSpecManager().get_all_specs()
    result = {'unchanged_source_and_dependency_files': stable, 'all_preserved': all(stable.values()), 'solved': notebook_details(ROOT/SOLVED), 'student': notebook_details(ROOT/STUDENT), 'executed': notebook_details(ROOT/EXEC), 'schemas_valid': True, 'executed_sources_equal_solved': source_projection(executed) == source_projection(solved), 'student_source_type_ids_match_generation': source_projection(student) == source_projection(generated), 'generated_outputs_cleared': all(c.get('execution_count') is None and not c.get('outputs', []) for c in generated['cells'] if c['cell_type'] == 'code'), 'original_saved_outputs_preserved': baseline['solved']['saved_execution_sha256'] == notebook_details(ROOT/SOLVED)['saved_execution_sha256'], 'exact_old_evidence_input_comparison': old_hashes, 'all_package_files_equal_pin': pinned, 'reused_wheel': wheel_info, 'environment': {'sys_executable': sys.executable, 'python': sys.version, 'helper_file': course_support.l01.__file__, 'packages': {n: importlib.metadata.version(n) for n in ['numpy', 'scipy', 'matplotlib', 'ipykernel', 'jupyter-client', 'nbclient', 'nbformat', 'pml-course-support']}, 'kernel_specs': ks}}
    (OUT/'validation.json').write_text(json.dumps(result, indent=2)+'\n')
    print(json.dumps(result, indent=2))
