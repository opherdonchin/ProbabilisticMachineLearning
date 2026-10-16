"""Author-only source-adapted Fashion-MNIST / character-RNN feasibility probe.

Fixed configurations, one split, validation checkpoint selection and one test
read per fitted model. No student notebook, architecture search, installation,
or full source notebook execution. Dataset caches are outside the repository.
"""
from __future__ import annotations
import argparse
import copy
import gzip
import hashlib
import json
import math
from pathlib import Path
import re
import struct
import sys
import time
import urllib.request
import numpy as np
import torch
from torch import nn
from torch.nn import functional as F

HERE = Path(__file__).resolve().parent
FASHION_COMMIT = '789103ddf3ef47449683debad30061320a3acddf'
FILES = {'train-images-idx3-ubyte.gz':'8d4fb7e6c68d591d4c3dfef9ec88bf0d',
         'train-labels-idx1-ubyte.gz':'25c81989df183df01b3e8a0aad5dffbe',
         't10k-images-idx3-ubyte.gz':'bef4ecab320f06d8554ea6380940ec79',
         't10k-labels-idx1-ubyte.gz':'bb300cfdad3c16e7a12a480ee83cd310'}
SOURCE = {'pyprobml_commit':'d1ea4122dcf3c2a2c02eb4e05343203b26440827',
 'lenet_notebook':'notebooks/book1/14/lenet_torch.ipynb',
 'lenet_sha256':'3679f030da4dfb7f350ee30d36341f9e7da475f322aa78f73b3c8eb55c5c377e',
 'rnn_notebook':'notebooks/book1/15/rnn_torch.ipynb',
 'rnn_sha256':'8177d1fc9d2d7169ff7c2486f0e68d11b14e2887ce8072b384ac796a80200613'}


def acquire(cache, name, url, md5=None, sha1=None):
    path = cache/name
    if path.exists():
        raw = path.read_bytes()
    else:
        with urllib.request.urlopen(url,timeout=60) as response:
            raw = response.read()
        path.write_bytes(raw)
    if md5 is not None: assert hashlib.md5(raw).hexdigest() == md5
    if sha1 is not None: assert hashlib.sha1(raw).hexdigest() == sha1
    return raw, {'url':url,'bytes':len(raw),'sha256':hashlib.sha256(raw).hexdigest(),
                 'md5':hashlib.md5(raw).hexdigest(),'sha1':hashlib.sha1(raw).hexdigest()}


def tensor_sha(tensor):
    return hashlib.sha256(tensor.detach().cpu().contiguous().numpy().tobytes()).hexdigest()


class CNN(nn.Sequential):
    """LeNet source cell6 topology; ReLU replaces sigmoid for bounded fitting."""
    def __init__(self):
        super().__init__(nn.Conv2d(1,6,5,padding=2), nn.ReLU(), nn.AvgPool2d(2,2),
            nn.Conv2d(6,16,5), nn.ReLU(), nn.AvgPool2d(2,2), nn.Flatten(),
            nn.Linear(16*5*5,120), nn.ReLU(), nn.Linear(120,84), nn.ReLU(), nn.Linear(84,10))


class CharacterRNN(nn.Module):
    """Native pyprobml cell36 forward map; batch-first inputs become time-first."""
    def __init__(self,vocabulary_size,hidden=64):
        super().__init__(); self.rnn=nn.RNN(vocabulary_size,hidden);self.linear=nn.Linear(hidden,vocabulary_size)
        self.vocabulary_size=vocabulary_size; self.hidden=hidden
    def forward(self,inputs,state=None):
        x=F.one_hot(inputs.T.long(),self.vocabulary_size).float()
        outputs,state=self.rnn(x,state)
        return self.linear(outputs.reshape(-1,outputs.shape[-1])),state


def image_score(model,x,y):
    model.eval();nll=0.;correct=0;confusion=torch.zeros(10,10,dtype=torch.long)
    with torch.no_grad():
        for xx,yy in zip(x.split(256),y.split(256)):
            logits=model(xx);nll+=float(F.cross_entropy(logits,yy,reduction='sum'))
            predictions=logits.argmax(1);correct+=int((predictions==yy).sum())
            confusion+=torch.bincount(10*yy+predictions,minlength=100).reshape(10,10)
    return {'mean_nll':nll/len(y),'accuracy':correct/len(y),'confusion':confusion.tolist()}


def image_probe(cache):
    provenance={}; raw={}
    for name,md5 in FILES.items():
        url=f'https://raw.githubusercontent.com/zalandoresearch/fashion-mnist/{FASHION_COMMIT}/data/fashion/{name}'
        raw[name],provenance[name]=acquire(cache,name,url,md5=md5)
    def images(name):
        b=gzip.decompress(raw[name]);magic,n,rows,cols=struct.unpack('>IIII',b[:16]);assert (magic,rows,cols)==(2051,28,28)
        a=np.frombuffer(b,dtype=np.uint8,offset=16).reshape(n,1,28,28).copy()
        return torch.tensor(a,dtype=torch.float32)/255
    def labels(name):
        b=gzip.decompress(raw[name]);magic,n=struct.unpack('>II',b[:8]);assert magic==2049
        return torch.tensor(np.frombuffer(b,dtype=np.uint8,offset=8).copy(),dtype=torch.long)
    x=images('train-images-idx3-ubyte.gz');y=labels('train-labels-idx1-ubyte.gz')
    xt=images('t10k-images-idx3-ubyte.gz');yt=labels('t10k-labels-idx1-ubyte.gz')
    rng=np.random.default_rng(312);tr=[];va=[];te=[]
    for label in range(10):
        ids=rng.permutation(np.flatnonzero(y.numpy()==label));tr.extend(ids[:600]);va.extend(ids[600:700])
        ids=rng.permutation(np.flatnonzero(yt.numpy()==label));te.extend(ids[:200])
    tr=np.array(tr);va=np.array(va);te=np.array(te);assert not set(tr)&set(va)
    train_x,train_y=x[tr],y[tr];valid_x,valid_y=x[va],y[va];test_x,test_y=xt[te],yt[te]
    metrics={}; models={}
    for offset,name in enumerate(['affine','mlp','cnn']):
        torch.manual_seed(314+offset)
        model=nn.Sequential(nn.Flatten(),nn.Linear(784,10)) if name=='affine' else (
            nn.Sequential(nn.Flatten(),nn.Linear(784,64),nn.ReLU(),nn.Linear(64,10)) if name=='mlp' else CNN())
        optimizer=torch.optim.Adam(model.parameters(),lr=.001);generator=torch.Generator().manual_seed(717)
        best=math.inf;checkpoint=None;best_epoch=None;history=[];start=time.perf_counter()
        for epoch in range(1,26):
            model.train();perm=torch.randperm(len(train_y),generator=generator)
            for indices in perm.split(128):
                optimizer.zero_grad();loss=F.cross_entropy(model(train_x[indices]),train_y[indices]);loss.backward();optimizer.step()
            validation=image_score(model,valid_x,valid_y)
            history.append({'epoch':epoch,'validation':validation})
            if validation['mean_nll']<best:
                best=validation['mean_nll'];checkpoint=copy.deepcopy(model.state_dict());best_epoch=epoch
        seconds=time.perf_counter()-start;model.load_state_dict(checkpoint);model.eval()
        test=image_score(model,test_x,test_y) # test is inspected once, after fixed training/selection
        metrics[name]={'parameters':sum(p.numel() for p in model.parameters()),'training_seconds':seconds,
            'epochs':25,'batch_size':128,'optimizer':'Adam lr=.001','seed':314+offset,
            'best_validation_epoch':best_epoch,'best_validation_nll':best,'test':test,'history':history}
        models[name]=model
        torch.save({'state_dict':checkpoint,'model':name,'source':SOURCE,'config':metrics[name],
                    'train_index_sha256':hashlib.sha256(tr.tobytes()).hexdigest()},HERE/f'fashion_{name}.pt')
        print('FASHION',name,{k:metrics[name][k] for k in ['parameters','training_seconds','best_validation_epoch']},test['mean_nll'],test['accuracy'],flush=True)
    model=models['cnn'];image=test_x[:1];conv=model[0];pre=conv(image)
    manual=(image[0,0,0:5,0:5]*conv.weight[0,0]).sum()+conv.bias[0]
    scalar=pre[0,0,2,2];conv_error=float(abs(manual-scalar).detach())
    shifted=torch.zeros_like(image);shifted[:,:,:,1:]=image[:,:,:,:-1]
    shifted_map=conv(shifted)
    equivariance_error=float((shifted_map[:,:,:,3:-2]-pre[:,:,:,2:-3]).abs().max().detach())
    with torch.no_grad():
        logits=model(test_x[:32]);ce=F.cross_entropy(logits,test_y[:32]);manual_ce=-logits.log_softmax(-1)[torch.arange(32),test_y[:32]].mean()
        logit_error=float(abs(ce-manual_ce));prob_error=float(abs(logits.softmax(-1).sum(-1)-1).max())
        classifier_shift_difference=float(abs(model(image).softmax(-1)-model(shifted).softmax(-1)).max())
    assert conv_error<2e-6 and equivariance_error<2e-6 and logit_error<2e-6 and prob_error<2e-6
    return {'status':'actual Fashion-MNIST fixed subset; source-adapted teacher feasibility fit',
        'data':provenance,'split':{'train_n':len(tr),'validation_n':len(va),'test_n':len(te),'seed':312,
          'train_original_indices':tr.tolist(),'validation_original_indices':va.tolist(),'test_original_indices':te.tolist(),
          'train_tensor_sha256':tensor_sha(train_x),'validation_tensor_sha256':tensor_sha(valid_x),'test_tensor_sha256':tensor_sha(test_x)},
        'models':metrics,'checks':{'convolution_scalar_error':conv_error,'interior_equivariance_error':equivariance_error,
          'cross_entropy_log_probability_error':logit_error,'probability_row_error':prob_error,
          'whole_classifier_shift_max_probability_change':classifier_shift_difference},
        'source_adaptations':['source LeNet topology; ReLU replaces sigmoid','prepared Adam replaces source SGD',
          'stdlib IDX parsing replaces missing torchvision','fixed class-balanced subset and validation checkpoint selection']}


def sequence_eval(model,segment):
    model.eval();loss=0.;count=0;state=None
    with torch.no_grad():
        for start in range(0,len(segment)-1,35):
            x=segment[start:min(start+35,len(segment)-1)].reshape(1,-1)
            y=segment[start+1:start+1+x.numel()]
            logits,state=model(x,state);loss+=float(F.cross_entropy(logits,y,reduction='sum'));count+=len(y)
    return {'transitions':count,'mean_nll':loss/count,'perplexity':math.exp(loss/count)}


def sequence_probe(cache):
    raw,provenance=acquire(cache,'timemachine.txt','https://d2l-data.s3-accelerate.amazonaws.com/timemachine.txt',sha1='090b5e7e70c295757f55df93cb0a180b9691891a')
    text=''.join(re.sub('[^A-Za-z]+',' ',line).strip().lower() for line in raw.decode().splitlines())
    # Known sample space, declared before split; no held-out vocabulary fitting.
    alphabet=['<unk>',' ']+list('abcdefghijklmnopqrstuvwxyz');stoi={s:i for i,s in enumerate(alphabet)}
    tokens=torch.tensor([stoi[c] for c in text[:30000]],dtype=torch.long);assert len(tokens)==30000
    train,valid,test=tokens[:20000],tokens[20000:25000],tokens[25000:30000]
    counts=torch.bincount(28*train[:-1]+train[1:],minlength=28*28).reshape(28,28).double()
    alpha=.1;prob=(counts+alpha)/(counts.sum(1,keepdim=True)+28*alpha)
    def baseline(segment):
        probabilities=prob[segment[:-1],segment[1:]]
        unknown=int((counts[segment[:-1],segment[1:]]==0).sum())
        return {'transitions':len(segment)-1,'mean_nll':float(-probabilities.log().mean()),
           'perplexity':float((-probabilities.log().mean()).exp()),'unsmoothed_zero_support_transitions':unknown,
           'raw_mle_mean_nll':None if unknown else float(-(counts[segment[:-1],segment[1:]]/counts.sum(1)[segment[:-1]]).log().mean()),
           'raw_mle_status':'infinite' if unknown else 'finite'}
    torch.manual_seed(919);model=CharacterRNN(28,64);optimizer=torch.optim.SGD(model.parameters(),lr=1.)
    best=math.inf;checkpoint=None;best_epoch=None;history=[];start=time.perf_counter();generator=torch.Generator().manual_seed(919)
    for epoch in range(1,201):
        model.train();offset=int(torch.randint(0,35,(1,),generator=generator));length=((len(train)-offset-1)//32)*32
        xx=train[offset:offset+length].reshape(32,-1);yy=train[offset+1:offset+1+length].reshape(32,-1);state=None
        for position in range(0,xx.shape[1]-34,35):
            x=xx[:,position:position+35];y=yy[:,position:position+35].T.reshape(-1)
            if state is not None:state=state.detach()
            optimizer.zero_grad();logits,state=model(x,state);loss=F.cross_entropy(logits,y);loss.backward()
            nn.utils.clip_grad_norm_(model.parameters(),1.);optimizer.step()
        if epoch%10==0:
            validation=sequence_eval(model,valid);history.append({'epoch':epoch,'validation':validation})
            if validation['mean_nll']<best:best=validation['mean_nll'];checkpoint=copy.deepcopy(model.state_dict());best_epoch=epoch
    seconds=time.perf_counter()-start;model.load_state_dict(checkpoint);model.eval();test_score=sequence_eval(model,test)
    torch.save({'state_dict':checkpoint,'source':SOURCE,'hidden':64,'alphabet':alphabet,'best_validation_epoch':best_epoch,
                'data_sha256':provenance['sha256'],'split':[20000,25000,30000]},HERE/'timemachine_rnn.pt')
    # Manual two-step trace agrees with the native cell, including its two biases.
    x=torch.tensor([[stoi['t'],stoi['h']],[stoi['a'],stoi[' ']]]);net=copy.deepcopy(model).double()
    hidden=torch.zeros(1,2,64,dtype=torch.float64);onehot=F.one_hot(x.T,28).double();outputs=[]
    for value in onehot:
        hidden_value=torch.tanh(F.linear(value,net.rnn.weight_ih_l0,net.rnn.bias_ih_l0)+F.linear(hidden[0],net.rnn.weight_hh_l0,net.rnn.bias_hh_l0));hidden=hidden_value.unsqueeze(0);outputs.append(net.linear(hidden_value))
    expected=torch.cat(outputs,0);native,_=net.rnn(onehot);native=net.linear(native.reshape(-1,64));recurrence_error=float((native-expected).abs().max().detach());assert recurrence_error<1e-12
    def distribution(prefix):
        x=torch.tensor([[stoi[c] for c in prefix]]);logits,_=model(x);return logits[-1].softmax(-1)
    with torch.no_grad():
        difference=float(abs(distribution('the time ')-distribution('a ')).max())
    # Greedy and sampled continuations use the same fitted prefix law.
    def generate(prefix,sampling):
        generator=torch.Generator().manual_seed(413);state=None;out=list(prefix)
        with torch.no_grad():
            for c in prefix[:-1]:_,state=model(torch.tensor([[stoi[c]]]),state)
            last=stoi[prefix[-1]]
            for _ in range(100):
                logits,state=model(torch.tensor([[last]]),state);p=logits[-1].softmax(-1)
                last=int(torch.multinomial(p,1,generator=generator)) if sampling else int(p.argmax());out.append(alphabet[last])
        return ''.join(out)
    print('RNN',seconds,'bestepoch',best_epoch,'test',test_score,'bigram',baseline(test),flush=True)
    return {'status':'actual TimeMachine; source native RNN with capacity/budget adaptation',
        'data':provenance,'processed_text_sha256':hashlib.sha256(text.encode()).hexdigest(),
        'alphabet':alphabet,'splits':{'training':[0,20000],'validation':[20000,25000],'test':[25000,30000],
          'sequence_reset_at_each_split':True,'training_state_detached_every':35,'test_context':'within test segment only, carried across evaluation chunks'},
        'bigram':{'alpha':alpha,'counts':counts.int().tolist(),'validation':baseline(valid),'test':baseline(test)},
        'rnn':{'hidden':64,'parameters':sum(p.numel() for p in model.parameters()),'epochs':200,'training_seconds':seconds,
          'optimizer':'SGD lr=1, gradient norm clipping1','batch_size':32,'unroll':35,'seed':919,
          'best_validation_epoch':best_epoch,'best_validation_nll':best,'history':history,'test':test_score,
          'sampled_continuation':generate('time traveller',True),'greedy_continuation':generate('time traveller',False)},
        'checks':{'manual_native_two_step_max_error':recurrence_error,'same_last_character_context_probability_difference':difference,
          'bigram_same_last_character_difference':0.},
        'source_adaptations':['native RNN wrapper from cell36; H64 replaces source H256','one native fit, not scratch plus native',
          'known alphabet and chronological held-out segments','200epochs and validation checkpoint, not training perplexity only',
          'actual categorical generation alongside explicitly labeled greedy decoding']}


def attention_check():
    generator=torch.Generator().manual_seed(10)
    q=torch.randn(1,1,4,3,generator=generator,dtype=torch.float64);k=torch.randn(1,1,4,3,generator=generator,dtype=torch.float64);v=torch.randn(1,1,4,2,generator=generator,dtype=torch.float64)
    mask=torch.tril(torch.ones(4,4,dtype=torch.bool));scores=(q@k.transpose(-2,-1))/math.sqrt(3);weights=scores.masked_fill(~mask,-torch.inf).softmax(-1)
    manual=weights@v;native=F.scaled_dot_product_attention(q,k,v,is_causal=True,dropout_p=0.)
    error=float(abs(manual-native).max());q2=q.clone();k2=k.clone();v2=v.clone();q2[:,:,2:]+=4;k2[:,:,2:]-=3;v2[:,:,2:]+=2
    changed=F.scaled_dot_product_attention(q2,k2,v2,is_causal=True,dropout_p=0.)
    causal_error=float(abs(native[:,:,:2]-changed[:,:,:2]).max());assert error<1e-12 and causal_error<1e-12
    return {'scope':'worked mechanism only; no trained transformer','native_manual_error':error,'future_perturbation_prefix_error':causal_error,'weights':weights.tolist()}


def main():
    parser=argparse.ArgumentParser();parser.add_argument('--cache',type=Path,default=Path('/tmp/pml-neural-probe-data'));args=parser.parse_args();args.cache.mkdir(exist_ok=True)
    torch.set_num_threads(1)
    result={'status':'bounded source-adapted actual-data author probe; no full notebook/Colab/learner-time claim',
        'python':sys.version,'torch':torch.__version__,'numpy':np.__version__,'cpu_threads':torch.get_num_threads(),
        'script_sha256':hashlib.sha256(Path(__file__).read_bytes()).hexdigest(),'sources':SOURCE,
        'fashion':image_probe(args.cache),'sequence':sequence_probe(args.cache),'attention':attention_check()}
    (HERE/'results.json').write_text(json.dumps(result,indent=2,allow_nan=False)+'\n')
    print('PASS actual-data fits and direct operator/math checks',flush=True)


if __name__=='__main__':main()
