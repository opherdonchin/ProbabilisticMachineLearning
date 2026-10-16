"""Pinned source records for city-transform feasibility; downloads stay in /tmp."""
import csv,hashlib,io,json,pathlib,urllib.request
HERE=pathlib.Path(__file__).resolve().parent
COMMIT='049cb033a9814c0ec3df99ece5144d07688aa648'
BASE=f'https://raw.githubusercontent.com/narslab/mobile-emissions-typology/{COMMIT}/'
CACHE=pathlib.Path('/tmp/pml-l12-city-transform-source');CACHE.mkdir(exist_ok=True)
paths={
'bin/jupyter/preprocessing/msa-modeshare-income-employment-2020-dataprocessing.ipynb':['ACSDT5Y2020.B08006','S1903','S2301','return (row / row.sum())','combined_df[\'Employment Rate\']','combined_df[\'Unemployment Rate\']','these two rates'],
'bin/jupyter/preprocessing/exploratory-factor-analysis.ipynb':['Population density','cols_to_sum','cols_to_normalize','row_sum_1/row_sum','Taxicab, motorcycle','Circuity average','GDP','Employment Rate','proportion of openland'],
'bin/jupyter/preprocessing/other-climate-data.ipynb':['average_temperature.csv','precipitation.csv','groupby','Average Temperature','Precipitation'],
'bin/jupyter/preprocessing/county-cooling-degree-days-MSA.ipynb':['cooling_degree_days.csv','groupby','Cooling Degree Days'],
'bin/jupyter/preprocessing/county-heating-degree-days-MSA.ipynb':['heating_degree_days.csv','groupby','Heating Degree Days'],
'bin/jupyter/preprocessing/raw-gdp-data-processing.ipynb':['Table.csv','All industry','Unnamed: 2','Unnamed: 4','GDP'],
'bin/jupyter/preprocessing/all-data-aggregation.ipynb':['msa-osm','Node','Intersection','1000','sq km'],
'README.md':[],
'data/raw/ACSDT5Y2020.B08006-2024-07-01T191933.csv':[],
'data/raw/msa-osm-stats.csv':[],
'data/raw/ACSST5Y2020.S2301-2024-07-02T122928.csv':[],
'data/raw/average_temperature.csv':[],
'data/raw/cooling_degree_days.csv':[],
'data/raw/heating_degree_days.csv':[],
'data/tidy/msa-modeshare-employment-salary.csv':[],
'data/tidy/msa-gdp.csv':[],
}
records={}
for path,patterns in paths.items():
 target=CACHE/path.split('/')[-1]
 if not target.exists():target.write_bytes(urllib.request.urlopen(BASE+path).read())
 b=target.read_bytes();record=dict(url=f'https://github.com/narslab/mobile-emissions-typology/blob/{COMMIT}/{path}',sha256=hashlib.sha256(b).hexdigest())
 if path.endswith('.ipynb'):
  record['matches']=[]
  for i,c in enumerate(json.loads(b)['cells']):
   s=''.join(c['source']);lines=[v for v in s.splitlines() if any(p in v for p in patterns)]
   if lines:record['matches'].append(dict(cell_index_zero_based=i,cell_sha256=hashlib.sha256(s.encode()).hexdigest(),exact_relevant_lines=lines))
 elif path.endswith('.csv') and b.startswith(b'#'):record['metadata_header']=b.decode('utf-8-sig').splitlines()[:4]
 records[path]=record
raw=list(csv.reader(io.StringIO((CACHE/'ACSDT5Y2020.B08006-2024-07-01T191933.csv').read_text(encoding='utf-8-sig'))))
zero=[]
for name in ['Anniston-Oxford, AL','East Stroudsburg, PA']:
 j=raw[0].index(name+' Metro Area!!Estimate')
 zero.append(dict(msa=name,raw_row_zero_based=14,label=raw[14][0].strip(),estimate=raw[14][j],margin_of_error=raw[14][j+1],total_workers=raw[1][j],total_margin_of_error=raw[1][j+1]))
# Verify reported selected proportions from six mutually exclusive raw count estimates.
tidy=[{k.strip():v for k,v in r.items()} for r in csv.DictReader(io.StringIO((CACHE/'msa-modeshare-employment-salary.csv').read_text(encoding='utf-8-sig')))]
for z in zero:
 r=next(r for r in tidy if r['MSA']==z['msa']);z['tidy_bicycle']=r['Bicycle'];assert float(r['Bicycle'])==0
cols=[2,8,16,14,15,17]  # Total car, transit, taxi/motorcycle/other, bike, walk, WFH.
# Actual raw zero-based rows from source's row selection (1:17 then drop indices 2,3,4,5,6,8,9,10,11,12).
assert [raw[i][0].strip() for i in cols]==['Car, truck, or van:','Public transportation (excluding taxicab):','Taxicab, motorcycle, or other means','Bicycle','Walked','Worked from home']
max_error=0.
for r in tidy:
 label=r['MSA']+' Metro Area!!Estimate'
 if label not in raw[0]:continue
 j=raw[0].index(label);v=[float(raw[i][j].replace(',','')) for i in cols]
 for k,i in enumerate(cols):max_error=max(max_error,abs(float(r[raw[i][0].strip()])-100*v[k]/sum(v)))
result=dict(commit=COMMIT,records=records,zero_records=zero,six_category_count_to_percentage_max_abs_error=max_error,
 primary_reading=dict(census_zero='https://www.census.gov/help/topics/faq.in-the-estimate-column-for-my-acs-table-value-of-0.html',
 osmnx='https://osmnx.readthedocs.io/en/stable/user-reference.html#osmnx.stats.circuity_avg',
 census_S2301='https://data.census.gov/table/ACSST5Y2020.S2301',
 census_definitions='https://www2.census.gov/programs-surveys/acs/tech_docs/subject_definitions/2020_ACSSubjectDefinitions.pdf',
 NOAA='https://www.cpc.ncep.noaa.gov/pacdir/DDdir/',
 NIST='https://www.nist.gov/si-redefinition/kelvin-introduction',
 change_of_variables='https://mc-stan.org/docs/stan-users-guide/reparameterization.html',
 simplex='https://mc-stan.org/docs/reference-manual/transforms.html#unit-simplex'),
 limitation='Pinned GDP preprocessing references missing data/raw/Table.csv. Exact price basis/year/multiplier of GDP ($) not established; keep as source GDP indicator, not verified dollar amount. An unrelated available lagdp1223.xlsx is not proof of this column provenance.')
assert max_error<1e-10
(HERE/'source_records.json').write_text(json.dumps(result,indent=2)+'\n')
print('Verified pinned records, zero estimates, and six-count normalization',max_error)
