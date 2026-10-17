import collections
import hashlib
import json
from pathlib import Path
import re
import subprocess
import xml.etree.ElementTree as ET

OUT=Path('/tmp/l01-recording-math-review/rendered/final-review')
ns={'x':'http://www.w3.org/1999/xhtml'}
def pages(name):
    return ET.parse(OUT/name).findall('.//x:page',ns)
def words(page):
    return [(w.text, *(round(float(w.attrib[k]),3) for k in ['xMin','yMin','xMax','yMax'])) for w in page.findall('.//x:word',ns)]
def index(page):
    text=' '.join(w[0] or '' for w in words(page))
    match=re.search(r'Slide\s*(\d+)/20',text)
    if match: return int(match[1])
    if 'Section 1' in text: return 2
    if 'Section 2' in text: return 13
    return 1
h=pages('handout-bbox.html'); p=pages('presentation-bbox.html')
mapping=collections.defaultdict(list)
for i,page in enumerate(p,1): mapping[index(page)].append(i)
checks=[]
for i,page in enumerate(h,1):
    states=mapping[i]; final=p[states[-1]-1]
    c1=collections.Counter(words(page)); c2=collections.Counter(words(final))
    checks.append({'handout':i,'states':states,'handout_words':len(words(page)),'state_word_counts':[len(words(p[s-1])) for s in states], 'final_content_geometry_equal':c1==c2, 'final_only_words':list((c2-c1).elements()),'handout_only_words':list((c1-c2).elements()), 'all_final_bbox_in_page':all(w[1]>=0 and w[2]>=0 and w[3]<=float(final.attrib['width']) and w[4]<=float(final.attrib['height']) for w in words(final))})
(OUT/'reveal-analysis.json').write_text(json.dumps({'handout_pages':len(h),'presentation_states':len(p),'checks':checks},indent=2)+'\n')
for start in range(1,48,12):
    paths=[str(OUT/f'p-{n:02d}.png') for n in range(start,min(start+12,48))]
    subprocess.run(['montage', '-font','DejaVu-Sans','-label','%f',*paths,'-thumbnail','480x270','-tile','3x4','-geometry','+5+20',str(OUT/f'states-{start:02d}.png')],check=True)
print(json.dumps(checks,indent=2))
