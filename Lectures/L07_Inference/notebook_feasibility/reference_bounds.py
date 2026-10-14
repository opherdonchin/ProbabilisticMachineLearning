"""Scope-neutral tail-envelope check for the frozen classifier reference.

Analytic inequalities are rigorous in exact arithmetic. Numerical evaluation is
ordinary float64, not interval/directed-rounding certification. Trapezoidal mesh
error remains unproved. This script writes only its own new results.
"""
import json
from pathlib import Path

import numpy as np
from scipy.special import expit, ndtr

import classifier_probe as classifier

HERE=Path(__file__).resolve().parent


def gradient(w,X,y):
    return X.T@(expit(X@w)-y)+w/4


def outside_box_gaussian(mu,C,radius):
    """Union upper bound works with any correlations; independent exact value too."""
    sigma=np.sqrt(np.diag(C))
    component=ndtr((-radius-mu)/sigma)+ndtr((mu-radius)/sigma)
    union=min(1.,float(component.sum()))
    independent=None
    if np.array_equal(C,np.diag(np.diag(C))):
        independent=float(-np.expm1(np.log1p(-component).sum()))
    # P(Z>t) <= phi(t)/t for t>0. This second formula uses no Normal CDF;
    # sums both tails and all coordinates, so is a conservative union bound.
    thresholds=np.r_[(radius-mu)/sigma,(radius+mu)/sigma]
    mills=np.array([1. if t<=0 else min(1.,np.exp(-.5*t*t)/np.sqrt(2*np.pi)/t)
                    for t in thresholds])
    return dict(coordinate_tail_probabilities=component.tolist(),
        gaussian_outside_union_bound=union,gaussian_outside_independent=independent,
        gaussian_outside_mills_union_bound=min(1.,float(mills.sum())))


def envelope_at_anchor(anchor,X,y,B,A,radii):
    g=gradient(anchor,X,y);U=float(classifier.nll(anchor,X,y));d=len(anchor)
    Binv=np.linalg.inv(B);Ainv=np.linalg.inv(A)
    muB=anchor-Binv@g;muA=anchor-Ainv@g
    logZA=-U+.5*g@Ainv@g+d/2*np.log(2*np.pi)-.5*np.linalg.slogdet(A)[1]
    logZB=-U+.5*g@Binv@g+d/2*np.log(2*np.pi)-.5*np.linalg.slogdet(B)[1]
    logC=logZB-logZA
    residual_correction=.5*g@(Binv-Ainv)@g
    assert residual_correction>=-1e-12
    assert abs(logC-(.5*(np.linalg.slogdet(A)[1]-np.linalg.slogdet(B)[1])+residual_correction))<1e-12
    ratio=float(np.exp(logC));boxes=[]
    for radius in radii:
        gaussian=outside_box_gaussian(muB,Binv,radius)
        union=gaussian["gaussian_outside_union_bound"]
        tail=min(1.,ratio*union)
        mills_tail=min(1.,ratio*gaussian["gaussian_outside_mills_union_bound"])
        independent=gaussian["gaussian_outside_independent"]
        # Optional unbounded coordinate-mean bound is separate from bounded
        # sigmoid queries. Cauchy-Schwarz under the Gaussian envelope gives
        # integral_outside |w_j| p(w) <= C sqrt(E_B[w_j^2] P_B(outside)).
        moment_tail=ratio*np.sqrt((muB**2+np.diag(Binv))*union)
        # |E_p w_j - E_p[w_j | inside]| <= moment_tail + r * tailmass.
        conditional_mean_error=moment_tail+radius*tail
        boxes.append(dict(radius=radius,**gaussian,
            normalized_target_tail_union_bound=tail,
            normalized_target_tail_independent_bound=None if independent is None else min(1.,ratio*independent),
            normalized_target_tail_mills_bound=mills_tail,
            bounded_sigmoid_tail_only_error_bound=tail,
            coordinate_absolute_tail_moment_bound=moment_tail.tolist(),
            coordinate_conditional_mean_truncation_error_bound=conditional_mean_error.tolist()))
    return dict(anchor=anchor.tolist(),gradient=g.tolist(),gradient_norm=float(np.linalg.norm(g)),
        energy_at_anchor=U,lower_energy_precision=B.tolist(),upper_energy_precision=A.tolist(),
        upper_density_envelope_mean=muB.tolist(),lower_density_envelope_mean=muA.tolist(),
        upper_density_envelope_covariance=Binv.tolist(),lower_density_envelope_covariance=Ainv.tolist(),
        log_normalizer_lower_bound=float(logZA),log_normalizer_upper_bound=float(logZB),
        normalizer_envelope_ratio=ratio,log_gradient_residual_ratio_correction=float(residual_correction),boxes=boxes)


def check_quadratic_bounds(anchor,X,y,B,A):
    rng=np.random.default_rng(714)
    points=np.vstack([anchor,rng.normal(size=(600,2))*8,
        np.array([[a,b] for a in [-10.,0.,10.] for b in [-10.,0.,10.]]),
        anchor+rng.normal(size=(100,2))*.01])
    delta=points-anchor;g=gradient(anchor,X,y);U=float(classifier.nll(anchor,X,y))
    base=U+delta@g
    lower=base+.5*np.einsum("ni,ij,nj->n",delta,B,delta)
    upper=base+.5*np.einsum("ni,ij,nj->n",delta,A,delta)
    actual=classifier.nll(points,X,y)
    lower_slack=actual-lower;upper_slack=upper-actual
    assert lower_slack.min()>-1e-10 and upper_slack.min()>-1e-10
    gradient_numeric=[]
    for j in range(2):
        step=np.zeros(2);step[j]=1e-4
        gradient_numeric.append((classifier.nll(anchor+step,X,y)-classifier.nll(anchor-step,X,y))/(2e-4))
    finite_gradient_error=float(np.max(abs(g-np.array(gradient_numeric))))
    assert finite_gradient_error<1e-7
    muB=anchor-np.linalg.solve(B,g);muA=anchor-np.linalg.solve(A,g)
    completedB=U-.5*g@np.linalg.solve(B,g)+.5*np.einsum("ni,ij,nj->n",points-muB,B,points-muB)
    completedA=U-.5*g@np.linalg.solve(A,g)+.5*np.einsum("ni,ij,nj->n",points-muA,A,points-muA)
    completion_error=max(np.max(abs(lower-completedB)),np.max(abs(upper-completedA)))
    assert completion_error<1e-9
    minimum_hessian_slack=1e9
    for w in points:
        p=expit(X@w);H=B+X.T@(p[:,None]*(1-p[:,None])*X)
        minimum_hessian_slack=min(minimum_hessian_slack,
            float(np.linalg.eigvalsh(H-B).min()),float(np.linalg.eigvalsh(A-H).min()))
    assert minimum_hessian_slack>-1e-10
    return dict(points_checked=len(points),minimum_lower_energy_slack=float(lower_slack.min()),
        minimum_upper_energy_slack=float(upper_slack.min()),gradient_finite_difference_max_error=finite_gradient_error,
        square_completion_max_error=float(completion_error),minimum_sampled_hessian_slack=minimum_hessian_slack,
        meaning="numerical consistency tests complement structural analytic inequalities; do not prove them by sampling")


def numerical_normalizer_diagnostic(X,y,anchor,radius=10.,step=.04):
    # An observed trapezoidal sum is only a sanity check against the envelope.
    axis=np.linspace(-radius,radius,round(2*radius/step)+1)
    a,b=np.meshgrid(axis,axis,indexing="ij");points=np.column_stack([a.ravel(),b.ravel()])
    weights=np.ones(len(axis));weights[[0,-1]]=.5
    scaled=np.exp(-classifier.nll(points,X,y)+classifier.nll(anchor,X,y))
    logZ=np.log(np.outer(weights,weights).ravel()@scaled*step**2)-classifier.nll(anchor,X,y)
    return dict(radius=radius,step=step,log_normalizer_trapezoidal=float(logZ),
                status="uncertified finite-box numerical diagnostic; no mesh-error bound")


def main():
    X,y,_,_,_,metadata=classifier.model()
    original=json.loads((HERE/"classifier_results.json").read_text())
    assert metadata==original["metadata"]
    anchor=np.array(original["laplace"]["mean"]);B=np.eye(2)/4;A=B+X.T@X/4
    anchors=[anchor,anchor+np.array([.01,-.01])]
    envelopes=[envelope_at_anchor(m,X,y,B,A,[8.,10.]) for m in anchors]
    checks=[check_quadratic_bounds(m,X,y,B,A) for m in anchors]
    normalizer=numerical_normalizer_diagnostic(X,y,anchor)
    assert envelopes[0]["log_normalizer_lower_bound"]<normalizer["log_normalizer_trapezoidal"]<envelopes[0]["log_normalizer_upper_bound"]
    for envelope in envelopes:
        for box in envelope["boxes"]:
            assert box["normalized_target_tail_mills_bound"]>=box["normalized_target_tail_union_bound"]-1e-12
            if box["normalized_target_tail_independent_bound"] is not None:
                assert box["normalized_target_tail_union_bound"]>=box["normalized_target_tail_independent_bound"]-1e-12
    result=dict(status="rigorous analytic tail envelope; ordinary float64 evaluation, not directed-rounding machine certification; mesh error unproved",
        task="author reference-quality check only; no new lecture/student-work commitments",
        data_sha256=metadata["iris_array_sha256"],analytic_model_dimension=2,anchors=envelopes,
        consistency_checks=checks,numerical_normalizer_diagnostic=normalizer,
        warning="bounded-query truncation bound cannot be used directly for unbounded coefficient moments")
    classifier.write_json(HERE/"reference_bounds_results.json",result)
    print(json.dumps(dict(mode_gradient_norm=envelopes[0]["gradient_norm"],
        mode_box_tail_bounds=[{k:box[k] for k in ["radius","normalized_target_tail_union_bound","normalized_target_tail_mills_bound"]} for box in envelopes[0]["boxes"]],
        displaced_anchor_gradient_norm=envelopes[1]["gradient_norm"])))


if __name__=="__main__":main()
