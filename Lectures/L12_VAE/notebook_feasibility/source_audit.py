"""Recover exact public source-cell provenance without committing source assets."""
import hashlib,json,pathlib,urllib.request
COMMIT='049cb033a9814c0ec3df99ece5144d07688aa648'
BASE=f'https://raw.githubusercontent.com/narslab/mobile-emissions-typology/{COMMIT}/'
cache=pathlib.Path('/tmp/pml-l12-public-source');cache.mkdir(exist_ok=True)
patterns={'msa-modeshare-income-employment-2020-dataprocessing.ipynb':
          ["combined_df['Employment Rate']", "combined_df['Unemployment Rate']"],
          'exploratory-factor-analysis.ipynb':
          ['row_sum_1/row_sum*100',"'Employment Rate':'Employment Rate (%)'", "'Proportion of Built-Up Area': 'Built-Up Area Proportion'", "'proportion of openland area':'Proportion of Built-Up Area'"]}
expected={'msa-modeshare-income-employment-2020-dataprocessing.ipynb':'ef3dac3493fad7fa9ffa54a49f788493a0e94176f2f37b1ffc6410952b4d0be8',
          'exploratory-factor-analysis.ipynb':'8b3929662119f2c5e236dd1d8ebc6cffb664be3627bd2bfa9cda295f5d093b5f'}
result={}
for name,pats in patterns.items():
    source='bin/jupyter/preprocessing/'+name
    b=urllib.request.urlopen(BASE+source).read()
    assert hashlib.sha256(b).hexdigest()==expected[name]
    (cache/name).write_bytes(b);matches=[]
    for i,c in enumerate(json.loads(b)['cells']):
        s=''.join(c['source']); lines=[line for line in s.splitlines() if any(p in line for p in pats)]
        if lines:matches.append(dict(cell_index_zero_based=i,cell_source_sha256=hashlib.sha256(s.encode()).hexdigest(),exact_relevant_lines=lines))
    result[name]=dict(url=f'https://github.com/narslab/mobile-emissions-typology/blob/{COMMIT}/'+source,
                      sha256=expected[name],matches=matches)
pathlib.Path(__file__).with_name('source_units.json').write_text(json.dumps(result,indent=2)+'\n')
print('Verified two pinned preprocessing sources; recorded exact unit-transformation cells.')
