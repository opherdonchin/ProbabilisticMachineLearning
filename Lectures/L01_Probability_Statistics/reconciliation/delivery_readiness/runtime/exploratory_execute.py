from pathlib import Path
import nbformat, traceback, sys, time
from nbclient import NotebookClient

out=Path('/tmp/l01-delivery-runtime')
project=out/'exploratory'
source=project/'lecture1_missing_data.exploratory.ipynb'
nb=nbformat.read(source,as_version=4)
nb.cells.append(nbformat.v4.new_code_cell('''# AUTHOR-ONLY diagnostic; appended after all unchanged original computations.
import importlib.metadata as md
import inspect
print("EXPLORATORY PACKAGE VERSIONS")
for package in ["numpy","scipy","matplotlib","pandas","pymc","pytensor","arviz-base","arviz-stats","xarray","nbclient","nbformat","ipykernel"]:
    print(package, md.version(package))
print("RESULT TYPE", type(idata))
print("POSTERIOR VARIABLES", list(idata["posterior"].data_vars))
print("POSTERIOR SIZES", dict(idata["posterior"].sizes))
print("SUMMARY COLUMNS", list(pymc_summary.columns))
print("SUMMARY INDEX", list(pymc_summary.index))
print("EXTRACT TYPE", type(x1_posterior), "DIMS", x1_posterior.dims, "SHAPE", x1_posterior.shape)
print("PLOT SAMPLE SHAPE", posterior_samples.shape)
print("ACTUAL SAMPLER STAT VARIABLES", list(idata["sample_stats"].data_vars))
if "diverging" in idata["sample_stats"].data_vars:
    print("DIVERGENCES", int(idata["sample_stats"]["diverging"].sum()))
print("SUMMARY SIGNATURE", inspect.signature(azs.summary))
author_summary = azs.summary(idata, var_names=["x_unobserved"], kind="all")
print("AUTHOR FULL SUMMARY")
print(author_summary.to_string())
print("ACTUAL MEAN DIFFERENCE", pymc_summary["mean"].to_numpy() - lgs_mean)
print("ACTUAL SD DIFFERENCE", pymc_summary["sd"].to_numpy() - lgs_sd)
print("ACTUAL COVARIANCE DIFFERENCE", np.cov(posterior_samples,rowvar=False) - lgs_cov)
print("FULL ORIGINAL COMPUTATION COMPLETED; environment is exploratory scratch uv, not repository lock or hosted Colab.")
''',metadata={'tags':['author-only-diagnostic']}))

client=NotebookClient(nb,timeout=180,kernel_name='l01-exploratory',resources={'metadata':{'path':str(project)}},on_cell_start=lambda cell,cell_index: print(f'CELL START {cell_index}',flush=True),on_cell_executed=lambda cell,cell_index,execute_reply: print(f'CELL DONE {cell_index}',flush=True))
start=time.perf_counter()
try:
 client.execute()
 status='PASS'
except Exception:
 status='FAIL'
 traceback.print_exc()
finally:
 destination=out/'exploratory.executed.ipynb'
 nbformat.write(nb,destination)
 with (out/'exploratory-cell-outputs.log').open('w') as f:
  for i,c in enumerate(nb.cells):
   if c.cell_type=='code':
    f.write(f'CELL {i} EXECUTION {c.execution_count}\n')
    for o in c.outputs:
     if o.output_type=='stream': f.write(o.text+'\n')
     elif o.output_type=='error': f.write('\n'.join(o.traceback)+'\n')
     elif 'text/plain' in o.get('data',{}):f.write(o.data['text/plain']+'\n')
 print('STATUS',status,'SECONDS',time.perf_counter()-start,'RECORD',destination,flush=True)
if status!='PASS':sys.exit(1)
