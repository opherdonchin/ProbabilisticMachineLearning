import collections
import hashlib
import json
from pathlib import Path
import xml.etree.ElementTree as ET

OUT=Path('/tmp/l01-recording-math-review/rendered/final-review')
SRC=Path('/tmp/pml-l01-recording/Lectures/L01_Probability_Statistics/recordings/quadratic_separation')
ns={'x':'http://www.w3.org/1999/xhtml'}
pages=ET.parse(OUT/'presentation-bbox.html').findall('.//x:page',ns)
def words(p):
    return collections.Counter((w.text,*(round(float(w.attrib[k]),3) for k in ('xMin','yMin','xMax','yMax'))) for w in p.findall('.//x:word',ns))
reveal=json.loads((OUT/'reveal-analysis.json').read_text())
transitions=[]
for slide in reveal['checks']:
    states=slide['states']
    for prev,nxt in zip(states,states[1:]):
        transitions.append({'previous_state':prev,'next_state':nxt,'existing_words_and_positions_persist':not(words(pages[prev-1])-words(pages[nxt-1]))})
bounds=[]
for n,p in enumerate(pages,1):
    outside=[w for w in words(p) if w[1]<0 or w[2]<0 or w[3]>float(p.attrib['width']) or w[4]>float(p.attrib['height'])]
    bounds.append({'state':n,'all_word_boxes_inside':not outside,'outside':outside})
sha=lambda p:hashlib.sha256(p.read_bytes()).hexdigest()
files={'slide_deck.typ':SRC/'slide_deck.typ','slide_design.typ':SRC/'slide_design.typ','slide_deck.pdf':SRC/'slide_deck.pdf','slide_deck_presentation.pdf':SRC/'production_validation/slide_deck_presentation.pdf'}
inputs={n:{'frozen_sha256':sha(OUT/'inputs'/n),'current_sha256':sha(p),'unchanged_during_review':sha(OUT/'inputs'/n)==sha(p)} for n,p in files.items()}
data={'all_existing_reveal_words_and_geometry_persist':all(t['existing_words_and_positions_persist'] for t in transitions),'all_47_states_inside_page':all(b['all_word_boxes_inside'] for b in bounds),'transitions':transitions,'state_bounds':bounds,'reviewed_inputs':inputs}
(OUT/'final-checks.json').write_text(json.dumps(data,indent=2)+'\n')
print(json.dumps({k:v for k,v in data.items() if k not in ['transitions','state_bounds']},indent=2))
