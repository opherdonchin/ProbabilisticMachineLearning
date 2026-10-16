"""Optional read-only empirical alternative probe. Pass instructor CSV path.

No original CSV copied. Daily aggregate is ephemeral; only source hash, checks
and pilot metrics are retained. Author-supplied local-level model, not N4SID.
"""
import argparse
import csv
from collections import defaultdict
from datetime import date, timedelta
import hashlib
import json
import time
from pathlib import Path
import numpy as np

HERE=Path(__file__).resolve().parent


def main():
    parser=argparse.ArgumentParser();parser.add_argument("csv",type=Path);args=parser.parse_args()
    start=time.perf_counter();digest=hashlib.sha256()
    with args.csv.open("rb") as source:
        for chunk in iter(lambda:source.read(1024*1024),b""):digest.update(chunk)
    totals=defaultdict(int);rows=0
    with args.csv.open(newline="") as source:
        for row in csv.DictReader(source):
            rows+=1
            totals[(row["Date"][:10],row["Device Category"])]+=int(row["Sessions"])
    observed_dates=sorted({d for d,_ in totals});devices=sorted({k for _,k in totals})
    first=date.fromisoformat(observed_dates[0]);last=date.fromisoformat(observed_dates[-1])
    dates=[(first+timedelta(days=i)).isoformat() for i in range((last-first).days+1)]
    missing={k:sum((d,k) not in totals for d in dates) for k in devices}
    # Freeze desktop and the first90 2019 holdout BEFORE inspecting task outcomes.
    assert missing["desktop"]==0
    values=np.array([totals[(d,"desktop")] for d in dates]);assert (values>=0).all()
    raw=np.log1p(values);train=np.array([d<"2019-01-01" for d in dates])
    test=np.array(["2019-01-01"<=d<"2019-04-01" for d in dates])
    center=raw[train].mean();scale=raw[train].std();y=(raw-center)/scale
    Q=.01;R=.09;m=0.;p=1.;mean=[];variance=[]
    for t,value in enumerate(y):
        if t:p+=Q
        mean.append(m);variance.append(p+R)  # score before this day's observation
        gain=p/(p+R);m+=gain*(value-m);p=(1-gain)*p
    mean=np.array(mean);variance=np.array(variance)
    naive=np.r_[y[0],y[:-1]];seasonal=np.r_[y[:7],y[:-7]]
    nll=.5*(np.log(2*np.pi*variance)+(y-mean)**2/variance)
    # Post hoc conditional alternative after scalar/weekly-baseline results:
    # known weekly seasonal LG model, one level plus
    # seven rotating seasonal coordinates. No parameter search or N4SID fitting.
    F=np.zeros((8,8));F[0,0]=1
    for j in range(1,7):F[j,j+1]=1
    F[7,1]=1
    H=np.r_[1.,1.,np.zeros(6)];process=np.zeros((8,8));process[0,0]=.001
    state=np.zeros(8);covariance=np.eye(8);seasonal_mean=[];seasonal_var=[]
    cutoff_state=None;cutoff_cov=None
    for t,value in enumerate(y):
        if t:state=F@state;covariance=F@covariance@F.T+process
        forecast=float(H@state);v=float(H@covariance@H+R)
        seasonal_mean.append(forecast);seasonal_var.append(v)
        K=covariance@H/v;state+=K*(value-forecast)
        covariance-=np.outer(K,H@covariance);covariance=(covariance+covariance.T)/2
        assert np.linalg.eigvalsh(covariance).min()>-1e-12
        if dates[t]=="2018-12-31":cutoff_state=state.copy();cutoff_cov=covariance.copy()
    seasonal_mean=np.array(seasonal_mean);seasonal_var=np.array(seasonal_var)
    seasonal_nll=.5*(np.log(2*np.pi*seasonal_var)+(y-seasonal_mean)**2/seasonal_var)
    openloop=[];openloop_variance=[]
    for _ in range(int(test.sum())):
        cutoff_state=F@cutoff_state;cutoff_cov=F@cutoff_cov@F.T+process
        openloop.append(float(H@cutoff_state));openloop_variance.append(float(H@cutoff_cov@H+R))
    openloop=np.array(openloop);openloop_variance=np.array(openloop_variance)
    def rmse(v):return float(np.sqrt(np.mean((y[test]-v[test])**2)))
    output=dict(status="conditional empirical author pilot; supplied settings; not learned Oke/N4SID or approved assignment",
        source_sha256=digest.hexdigest(),raw_rows=rows,date_range=[dates[0],dates[-1]],
        daily_rows=len(dates),devices=devices,missing_daily_device_cells=missing,
        prep_seconds=time.perf_counter()-start,task="rolling one-day-ahead desktop log1p-session prediction (not 90-day open-loop forecasting)",
        transform=dict(training_end="2018-12-31",center=float(center),scale=float(scale)),
        model=dict(F=1,H=1,Q=Q,R=R,initial_mean=0,initial_variance=1,settings="author-supplied; no validation tuning"),
        holdout=dict(days=int(test.sum()),standardized_log_RMSE=dict(kalman=rmse(mean),last_observation=rmse(naive),weekly_seasonal=rmse(seasonal)),
        gaussian_log_score=float(nll[test].mean()),normal90_interval_coverage=float(np.mean(abs(y[test]-mean[test])<=1.6448536269514722*np.sqrt(variance[test])))),
        seasonal_known_parameter_alternative=dict(F=F.tolist(),H=H.tolist(),Q=process.tolist(),R=R,
        initial_mean=[0.]*8,initial_covariance=np.eye(8).tolist(),settings="post hoc calendar-model exploration after scalar results; single supplied setting; not N4SID or final model selection evidence",
        rolling_log_RMSE=rmse(seasonal_mean),rolling_log_score=float(seasonal_nll[test].mean()),
        rolling_normal90_coverage=float(np.mean(abs(y[test]-seasonal_mean[test])<=1.6448536269514722*np.sqrt(seasonal_var[test]))),
        openloop90_log_RMSE=float(np.sqrt(np.mean((y[test]-openloop)**2))),
        openloop90_normal90_coverage=float(np.mean(abs(y[test]-openloop)<=1.6448536269514722*np.sqrt(openloop_variance)))))
    (HERE/"traffic_results.json").write_text(json.dumps(output,indent=2)+"\n")
    print(json.dumps(output))


if __name__=="__main__":main()
