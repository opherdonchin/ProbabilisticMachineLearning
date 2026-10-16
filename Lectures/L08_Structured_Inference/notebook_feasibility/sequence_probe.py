"""Exact NumPy HMM checks and a conditional known-parameter Kalman probe.

Simulated states are course constructed, not observed behavioral labels.
"""
import itertools
import json
import time
from pathlib import Path
import numpy as np

HERE=Path(__file__).resolve().parent


def forward_backward(pi,A,likelihood):
    T,K=likelihood.shape; f=np.zeros((T,K));normalizers=np.zeros(T)
    for t in range(T):
        prior=pi if t==0 else f[t-1]@A
        unnormalized=prior*likelihood[t];normalizers[t]=unnormalized.sum()
        if normalizers[t]<=0:raise ValueError("impossible observation under supplied model")
        f[t]=unnormalized/normalizers[t]
    b=np.ones((T,K))
    for t in range(T-2,-1,-1):b[t]=A@(likelihood[t+1]*b[t+1])/normalizers[t+1]
    gamma=f*b;gamma/=gamma.sum(1,keepdims=True)
    return f,gamma,float(np.log(normalizers).sum()),normalizers


def enumeration(pi,A,B,y):
    paths=np.array(list(itertools.product(range(len(pi)),repeat=len(y))))
    weights=[]
    for path in paths:
        w=pi[path[0]]*B[path[0],y[0]]
        for t in range(1,len(y)):w*=A[path[t-1],path[t]]*B[path[t],y[t]]
        weights.append(w)
    weights=np.array(weights);evidence=weights.sum()
    marg=np.array([[weights[paths[:,t]==k].sum()/evidence for k in range(len(pi))] for t in range(len(y))])
    return marg,evidence,paths[np.argmax(weights)].tolist()


def kalman(y,F=.9,Q=.2,R=.5):
    means=[];vars=[];forecast=[];forecast_var=[];m=0.;p=1.
    for t,value in enumerate(y):
        if t:m=F*m;p=F*F*p+Q
        forecast.append(m);forecast_var.append(p+R)
        gain=p/(p+R);m=m+gain*(value-m);p=(1-gain)*p
        means.append(m);vars.append(p)
    return np.array(means),np.array(vars),np.array(forecast),np.array(forecast_var)


def main():
    tests=[]
    for pi,A,B,y in [(np.array([.5,.5]),np.array([[.8,.2],[.2,.8]]),np.array([[.7,.3],[.3,.7]]),[0,0,1]),
                      (np.array([.3,.7]),np.array([[.93,.07],[.31,.69]]),np.array([[.8,.2],[.25,.75]]),[1,0,1,1,0])]:
        y=np.array(y);f,g,logz,c=forward_backward(pi,A,B[:,y].T)
        oracle,evidence,path=enumeration(pi,A,B,y)
        prefix_error=max(abs(forward_backward(pi,A,B[:,y[:t+1]].T)[0][-1]-f[t]).max() for t in range(len(y)))
        # Each filter vector is independently checked by prefix enumeration.
        filter_error=max(abs(enumeration(pi,A,B,y[:t+1])[0][-1]-f[t]).max() for t in range(len(y)))
        assert np.max(abs(g-oracle))<1e-12 and abs(np.exp(logz)-evidence)<1e-12
        assert filter_error<1e-12 and prefix_error<1e-12 and np.max(abs(f[-1]-g[-1]))<1e-12
        tests.append(dict(pi=pi.tolist(),A=A.tolist(),B=B.tolist(),y=y.tolist(),evidence=evidence,
            max_smoothing_error=float(np.max(abs(g-oracle))),max_filter_error=float(filter_error),
            filtered=f.tolist(),smoothed=g.tolist(),path_MAP=path,marginal_modes=g.argmax(1).tolist()))
    try:forward_backward(np.array([.5,.5]),np.eye(2),np.zeros((1,2)))
    except ValueError:impossible_handled=True
    else:raise AssertionError("impossible observation not rejected")
    pi=np.array([.5,.5]);A=np.array([[.95,.05],[.10,.90]])
    B=np.array([[1/6]*6,[.1,.1,.1,.1,.1,.5]])
    rng=np.random.default_rng(84);T=200;z=np.empty(T,dtype=int);y=np.empty(T,dtype=int)
    for t in range(T):
        z[t]=rng.choice(2,p=pi if t==0 else A[z[t-1]])
        y[t]=rng.choice(6,p=B[z[t]])
    f,g,logz,_=forward_backward(pi,A,B[:,y].T)
    # Independent-state baseline uses the stationary state prior, without sequence messages.
    prior=np.array([2/3,1/3]);naive=B[:,y].T*prior;naive/=naive.sum(1,keepdims=True)
    score=lambda p:float(-np.log(p[np.arange(T),z]).mean())
    encounter=dict(provenance="simulated known fair/loaded die model; seed84; no empirical sensor/behavior claims",T=T,
        model=dict(pi=pi.tolist(),A=A.tolist(),B=B.tolist()),log_evidence=logz,
        log_scores=dict(filter=score(f),smoother=score(g),independent=score(naive)),
        accuracy=dict(filter=float(np.mean(f.argmax(1)==z)),smoother=float(np.mean(g.argmax(1)==z)),independent=float(np.mean(naive.argmax(1)==z))),
        mean_loaded_state_probabilities=dict(filter=float(f[:,1].mean()),smoother=float(g[:,1].mean())),
        final_filter_smoother_error=float(np.max(abs(f[-1]-g[-1]))),truth_transitions=int(np.sum(z[1:]!=z[:-1])))
    scaling=[]
    for K in [2,8,16]:
        transition=np.full((K,K),1/K);prior=np.full(K,1/K)
        for T in [200,2000,20000]:
            likelihood=np.random.default_rng(K+T).uniform(.1,1,(T,K))
            ticks=[]
            for _ in range(3):
                start=time.perf_counter();forward_backward(prior,transition,likelihood);ticks.append(time.perf_counter()-start)
            scaling.append(dict(K=K,T=T,median_seconds=float(np.median(ticks)),dense_message_multiplies=2*(T-1)*K*K,
                stored_float_count=3*T*K+T,log10_enumerated_paths=float(T*np.log10(K))))
    # Kalman versus joint Gaussian conditioning, including process noise/covariances.
    T=8;F=.9;Q=.2;R=.5;cov=np.empty((T,T));cov[0,0]=1
    for t in range(1,T):
        cov[t,:t]=F*cov[t-1,:t];cov[:t,t]=cov[t,:t];cov[t,t]=F*F*cov[t-1,t-1]+Q
    y=np.random.default_rng(81).multivariate_normal(np.zeros(T),cov+R*np.eye(T))
    m,p,pred,predvar=kalman(y,F,Q,R);errors=[]
    for t in range(T):
        Cy=cov[:t+1,:t+1]+R*np.eye(t+1);cross=cov[t,:t+1]
        exact_mean=cross@np.linalg.solve(Cy,y[:t+1]);exact_var=cov[t,t]-cross@np.linalg.solve(Cy,cross)
        errors.append(max(abs(exact_mean-m[t]),abs(exact_var-p[t])))
    assert max(errors)<1e-12
    # Independent matrix-Gaussian prefix-conditioning oracle for the post hoc
    # seasonal alternative (same supplied eight-coordinate model as traffic).
    d=8;T=12;F8=np.zeros((d,d));F8[0,0]=1
    for j in range(1,7):F8[j,j+1]=1
    F8[7,1]=1
    H8=np.r_[1.,1.,np.zeros(6)];Q8=np.zeros((d,d));Q8[0,0]=.001;R8=.09
    unconditional=[np.eye(d)]
    for _ in range(1,T):unconditional.append(F8@unconditional[-1]@F8.T+Q8)
    observation_covariance=np.zeros((T,T))
    for t in range(T):
        for s in range(t+1):
            cross=np.linalg.matrix_power(F8,t-s)@unconditional[s]
            observation_covariance[t,s]=H8@cross@H8
            observation_covariance[s,t]=observation_covariance[t,s]
    observation_covariance+=R8*np.eye(T)
    y8=np.random.default_rng(82).multivariate_normal(np.zeros(T),observation_covariance)
    state=np.zeros(d);P=np.eye(d);matrix_errors=[]
    for t,observed in enumerate(y8):
        if t:state=F8@state;P=F8@P@F8.T+Q8
        v=H8@P@H8+R8;gain=P@H8/v
        state+=gain*(observed-H8@state);P-=np.outer(gain,H8@P);P=(P+P.T)/2
        cross=np.column_stack([np.linalg.matrix_power(F8,t-s)@unconditional[s]@H8 for s in range(t+1)])
        Cy=observation_covariance[:t+1,:t+1]
        oracle_mean=cross@np.linalg.solve(Cy,y8[:t+1])
        oracle_cov=unconditional[t]-cross@np.linalg.solve(Cy,cross.T)
        matrix_errors.append(max(np.max(abs(state-oracle_mean)),np.max(abs(P-oracle_cov))))
    assert max(matrix_errors)<1e-12
    output=dict(status="author-only exact checks/conditional feasibility; no Colab or student-time pass",oracle_tests=tests,
        impossible_observation_handled=impossible_handled,simulated_encounter=encounter,scaling=scaling,
        kalman=dict(provenance="simulated scalar known-parameter linear Gaussian model",F=F,Q=Q,R=R,
        joint_conditioning_max_error=float(max(errors)),one_step_predictive_variance=predvar.tolist()),
        seasonal_matrix_kalman=dict(state_dimension=d,T=T,known_Q_singular=True,
            joint_conditioning_max_error=float(max(matrix_errors)),model="level plus seven rotating seasonal effects; Q_level=.001,R=.09"))
    (HERE/"sequence_results.json").write_text(json.dumps(output,indent=2)+"\n")
    print(json.dumps(dict(oracle_errors=[t["max_smoothing_error"] for t in tests],scores=encounter["log_scores"],kalman_error=max(errors))))


if __name__=="__main__":main()
