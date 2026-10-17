"""Exact rational specializations of the reviewed identities; not a general proof."""
from fractions import Fraction as F
import hashlib
import json
from pathlib import Path
import shutil

OUT = Path('/tmp/l01-recording-math-review')
SRC = Path('/tmp/pml-l01-recording/Lectures/L01_Probability_Statistics/recordings/quadratic_separation')
ROOT = Path('/home/opher/Repositories/ProbabilisticMachineLearning')

def eye(n): return [[F(i == j) for j in range(n)] for i in range(n)]
def tr(a): return [list(x) for x in zip(*a)]
def mul(a,b): return [[sum(x*y for x,y in zip(row,col)) for col in tr(b)] for row in a]
def sub(a,b): return [[x-y for x,y in zip(r,s)] for r,s in zip(a,b)]
def inv(a):
    n=len(a); b=[r[:] + s for r,s in zip(a,eye(n))]
    for i in range(n):
        k=next(k for k in range(i,n) if b[k][i]); b[i],b[k]=b[k],b[i]
        p=b[i][i]; b[i]=[x/p for x in b[i]]
        for j in range(n):
            if j != i:
                p=b[j][i]; b[j]=[x-p*y for x,y in zip(b[j],b[i])]
    return [r[n:] for r in b]
def det(a):
    b=[r[:] for r in a]; result=F(1)
    for i in range(len(b)):
        k=next(k for k in range(i,len(b)) if b[k][i]);
        if i != k: b[i],b[k]=b[k],b[i]; result=-result
        p=b[i][i]; result*=p
        for j in range(i+1,len(b)):
            q=b[j][i]/p; b[j]=[x-q*y for x,y in zip(b[j],b[i])]
    return result
def quad(x,a): return mul(mul(tr(x),a),x)[0][0]

results=[]
for n,m in [(2,3),(3,2),(1,1)]:
    d=n+m
    a=[[F(((i+1)*7+(j+1)*3+i*j)%11-5) for j in range(d)] for i in range(d)]
    sigma=[[v+F(i==j) for j,v in enumerate(row)] for i,row in enumerate(mul(a,tr(a)))]
    h=[r[n:] for r in sigma[n:]]; f=[r[n:] for r in sigma[:n]]; e=[r[:n] for r in sigma[:n]]
    b=mul(f,inv(h)); s=sub(e,mul(mul(b,h),tr(b)))
    t=eye(d); ti=eye(d)
    for i in range(n):
        for j in range(m): t[i][n+j]=-b[i][j]; ti[i][n+j]=b[i][j]
    diagonal=[[s[i][j] if i<n and j<n else h[i-n][j-n] if i>=n and j>=n else F(0) for j in range(d)] for i in range(d)]
    dinv=inv(diagonal); sinv=inv(s); hinv=inv(h)
    expanded=[r + [-v for v in sr] for r,sr in zip(sinv,mul(sinv,b))]
    lower_left=[[-v for v in r] for r in mul(tr(b),sinv)]
    correction=mul(mul(tr(b),sinv),b)
    lower_right=[[x+y for x,y in zip(r,sr)] for r,sr in zip(hinv,correction)]
    expanded += [r+sr for r,sr in zip(lower_left,lower_right)]
    v=[[F(2*i-3, i+1)] for i in range(d)]; tv=mul(t,v)
    q1=quad(v,inv(sigma)); q2=quad(tv[:n],sinv)+quad(tv[n:],hinv)
    results.append({'dimensions':[n,m], 'T_inverse_both_orders':mul(t,ti)==eye(d) and mul(ti,t)==eye(d), 'covariance_congruence':mul(mul(t,sigma),tr(t))==diagonal, 'inverse_congruence':mul(mul(tr(t),dinv),t)==inv(sigma), 'expanded_inverse':expanded==inv(sigma), 'quadratic_identity':q1==q2, 'determinant_identity':det(sigma)==det(s)*det(h), 'det_T':str(det(t)), 'S_positive_leading_minors':[str(det([r[:k] for r in s[:k]])) for k in range(1,n+1)], 'H_positive_leading_minors':[str(det([r[:k] for r in h[:k]])) for k in range(1,m+1)], 'Sigma':[[str(v) for v in row] for row in sigma], 'S':[[str(v) for v in row] for row in s], 'B':[[str(v) for v in row] for row in b], 'quadratic_value':str(q1)})
scalar={'rho':str(F(4,5)), 'H':'1', 'B':str(F(4,5)), 'S':str(1-F(4,5)**2), 'x2':str(F(3,2)), 'conditional_mean':str(F(4,5)*F(3,2)), 'observed_quadratic':str(F(3,2)**2)}
(OUT/'algebra-results.json').write_text(json.dumps({'method':'Exact fractions; deterministic finite specializations supplement a manual general proof audit.', 'cases':results, 'course_scalar':scalar},indent=2)+'\n')
(OUT/'inputs').mkdir(exist_ok=True)
hashes={}
for name in ['recording_brief.md','section_design.md','math_derivation.md','slide_organization.md']:
    p=SRC/name; data=p.read_bytes(); (OUT/'inputs'/name).write_bytes(data); hashes[str(p)]=hashlib.sha256(data).hexdigest()
for name in ['book2-1.pdf','book1.pdf']:
    p=ROOT/'Resources'/name; hashes[str(p)]=hashlib.sha256(p.read_bytes()).hexdigest()
(OUT/'reviewed-input-hashes.json').write_text(json.dumps(hashes,indent=2)+'\n')
print(json.dumps({'all_exact_identity_checks_pass':all(all(c[key] for key in ['T_inverse_both_orders','covariance_congruence','inverse_congruence','expanded_inverse','quadratic_identity','determinant_identity']) for c in results), 'input_hashes':hashes},indent=2))
