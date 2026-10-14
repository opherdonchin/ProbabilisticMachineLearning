"""Author-only fixed-task probe; not a course notebook or an approved model.

Run from any cwd with the course uv interpreter. Results are written next to
this script. L09 and L10 import this model to preserve exactly the same task.
"""
import hashlib
import json
import platform
import time
from pathlib import Path

import numpy as np
import scipy
import sklearn
from scipy.optimize import minimize
from scipy.special import expit
from sklearn.datasets import load_iris
from sklearn.model_selection import train_test_split

HERE = Path(__file__).resolve().parent


def model():
    iris = load_iris()
    ids = np.flatnonzero(iris.target > 0)
    train, test = train_test_split(ids, test_size=.4, random_state=14,
                                   stratify=iris.target[ids])
    raw = iris.data[:, 0]
    center, scale = raw[train].mean(), raw[train].std()
    X = np.column_stack([np.ones(len(train)), (raw[train]-center)/scale])
    Xt = np.column_stack([np.ones(len(test)), (raw[test]-center)/scale])
    y = (iris.target[train] == 2).astype(float)
    yt = (iris.target[test] == 2).astype(float)
    Q = np.column_stack([np.ones(5), [-2., -1., 0., 1., 2.]])
    return X, y, Xt, yt, Q, dict(train_ids=train.tolist(), test_ids=test.tolist(),
        feature="sepal length (cm)", labels="versicolor=0, virginica=1",
        center=float(center), scale=float(scale), prior_covariance=(4*np.eye(2)).tolist(),
        iris_array_sha256=hashlib.sha256(iris.data.tobytes()+iris.target.tobytes()).hexdigest())


def nll(w, X, y):
    z = np.asarray(w) @ X.T
    return np.sum(np.logaddexp(0, z)-y*z, axis=-1)+np.sum(np.asarray(w)**2, axis=-1)/8


def laplace(X, y):
    def grad(w):
        return X.T@(expit(X@w)-y)+w/4
    fit = minimize(lambda w:nll(w,X,y), np.zeros(2), jac=grad, method="BFGS",
                   options={"gtol":1e-10})
    p=expit(X@fit.x)
    H=np.eye(2)/4+X.T@(p[:,None]*(1-p[:,None])*X)
    assert np.linalg.norm(grad(fit.x)) < 1e-6
    return fit.x, np.linalg.inv(H)


def gh_nodes(n=32):
    nodes, weights=np.polynomial.hermite.hermgauss(n)
    a,b=np.meshgrid(nodes,nodes,indexing="ij")
    return np.column_stack([a.ravel(),b.ravel()])*np.sqrt(2), np.outer(weights,weights).ravel()/np.pi


def gaussian_queries(m,C,queries,n=32):
    eps,weight=gh_nodes(n)
    return weight@expit((m+eps@np.linalg.cholesky(C).T)@queries.T)


def grid(X,y,queries,radius,step):
    axis=np.linspace(-radius,radius,round(2*radius/step)+1)
    a,b=np.meshgrid(axis,axis,indexing="ij")
    w=np.column_stack([a.ravel(),b.ravel()])
    logp=-nll(w,X,y)
    edge=np.ones(len(axis)); edge[[0,-1]]=.5
    mass=np.exp(logp-logp.max())*np.outer(edge,edge).ravel()
    mass/=mass.sum()
    mean=mass@w
    cov=(w-mean).T@(mass[:,None]*(w-mean))
    return dict(radius=radius,step=step,mean=mean.tolist(),covariance=cov.tolist(),
        predictions=(mass@expit(w@queries.T)).tolist(),
        outer_unit_mass=float(mass[(np.max(abs(w),axis=1)>radius-1)].sum()),
        grid_points=len(w))


def write_json(path,value):
    path.write_text(json.dumps(value,indent=2,allow_nan=False)+"\n")


def main():
    start=time.perf_counter()
    X,y,Xt,yt,Q,metadata=model()
    allq=np.vstack([Q,Xt])
    m,C=laplace(X,y)
    grids=[grid(X,y,allq,8,.08),grid(X,y,allq,10,.08),grid(X,y,allq,10,.04)]
    ref=np.array(grids[-1]["predictions"])
    pred=gaussian_queries(m,C,allq)
    point=expit(allq@m)
    score=lambda r:float(np.mean(np.logaddexp(0,np.log(r/(1-r)))-yt*np.log(r/(1-r))))
    results=dict(status="author-only feasibility; no Colab or student-time pass",metadata=metadata,
        queries=Q.tolist(),versions=dict(python=platform.python_version(),numpy=np.__version__,
        scipy=scipy.__version__,sklearn=sklearn.__version__),grids=grids,
        grid_domain_max_prediction_change=float(np.max(abs(np.array(grids[0]["predictions"])-np.array(grids[1]["predictions"])))),
        grid_mesh_max_prediction_change=float(np.max(abs(np.array(grids[1]["predictions"])-ref))),
        laplace=dict(mean=m.tolist(),covariance=C.tolist(),predictions=pred.tolist(),
            gh24_32_max_change=float(np.max(abs(gaussian_queries(m,C,allq,24)-pred))),
            max_prediction_error=float(np.max(abs(pred-ref)))),
        point_predictions=point.tolist(),holdout_log_loss=dict(reference=score(ref[5:]),
            laplace=score(pred[5:]),point=score(point[5:]),frequency=float(-np.log(.5))),
        seconds=time.perf_counter()-start)
    assert results["grid_mesh_max_prediction_change"] < 1e-5
    assert results["grid_domain_max_prediction_change"] < 1e-5
    write_json(HERE/"classifier_results.json",results)
    print(json.dumps({k:results[k] for k in ["grid_domain_max_prediction_change","grid_mesh_max_prediction_change","holdout_log_loss","seconds"]}))


if __name__=="__main__":
    main()
