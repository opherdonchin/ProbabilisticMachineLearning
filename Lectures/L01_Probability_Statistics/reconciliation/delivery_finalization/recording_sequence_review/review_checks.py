from pathlib import Path
from collections import Counter
import hashlib,json,re,subprocess,sys,xml.etree.ElementTree as ET
from PIL import Image,ImageDraw
out=Path('/tmp/l01-r01-sequence-review')
base=Path('/home/opher/Repositories/ProbabilisticMachineLearning/Lectures/L01_Probability_Statistics/recordings/quadratic_separation')
handout=Path(sys.argv[1]); presentation=Path(sys.argv[2])
files=[base/'slide_deck.typ',base/'slide_design.typ',base/'slide_organization.md',base/'section_design.md',base/'recording_brief.md',base/'math_derivation.md',handout,presentation,base.parents[2]/'course.typ']
hashes={str(p):hashlib.sha256(p.read_bytes()).hexdigest() for p in files}
for kind,pdf in [('handout',handout),('presentation',presentation)]:
 subprocess.run(['pdftotext','-layout',str(pdf),str(out/(kind+'.txt'))],check=True)
 subprocess.run(['pdftotext','-bbox-layout',str(pdf),str(out/(kind+'-bbox.html'))],check=True)
 subprocess.run(['pdftoppm','-scale-to','1200','-png',str(pdf),str(out/kind)],check=True,capture_output=True)
ns={'x':'http://www.w3.org/1999/xhtml'}
def pages(kind):
 root=ET.parse(out/(kind+'-bbox.html')).getroot()
 result=[]
 for page in root.findall('.//x:page',ns):
  words=page.findall('.//x:word',ns)
  height=float(page.attrib['height'])
  content=[w.text or '' for w in words if float(w.attrib['yMin'])<height-28]
  result.append(content)
 return result
hp,pp=pages('handout'),pages('presentation')
source=(base/'slide_deck.typ').read_text()
clusters=re.split(r'^== ',source,flags=re.M)[1:]
expected=[1]+[max([1]+[int(x) for x in re.findall(r'\bstep\((\d+)',c)]) for c in clusters]
assert sum(expected)==len(pp),(expected,len(pp))
assert len(expected)==len(hp),(len(expected),len(hp))
checks=[]
adjacent_losses=[]
offset=0
for i,count in enumerate(expected):
 final=Counter(pp[offset+count-1]); h=Counter(hp[i])
 for j in range(count-1):
  lost=Counter(pp[offset+j])-Counter(pp[offset+j+1])
  if lost: adjacent_losses.append({'from':offset+j+1,'to':offset+j+2,'lost':dict(lost)})
 states=[]
 for j in range(count):
  c=Counter(pp[offset+j])
  states.append({'presentation_page':offset+j+1,'words':len(pp[offset+j]),'unexpected_vs_final':dict(c-final)})
 checks.append({'slide':'P'+str(i),'handout_page':i+1,'states':states,'handout_missing_in_final':dict(h-final),'final_extra_vs_handout':dict(final-h)})
 offset+=count
for kind,n in [('handout',len(hp)),('presentation',len(pp))]:
 imgs=sorted(out.glob(kind+'-*.png'))
 for start in range(0,len(imgs),6):
  batch=imgs[start:start+6]
  sheet=Image.new('RGB',(1200,3*360),'white');draw=ImageDraw.Draw(sheet)
  for j,p in enumerate(batch):
   im=Image.open(p).convert('RGB'); im.thumbnail((595,330))
   x=(j%2)*600;y=(j//2)*360
   sheet.paste(im,(x,y+25));draw.text((x+8,y+4),p.name,fill='black')
  sheet.save(out/(kind+'-contact-'+str(start//6+1)+'.png'))
report={'hashes':hashes,'handout_pages':len(hp),'presentation_pages':len(pp),'expected_state_counts':expected,'checks':checks,'adjacent_state_losses':adjacent_losses}
(out/'checks.json').write_text(json.dumps(report,indent=2))
print(json.dumps({'handout':len(hp),'presentation':len(pp),'expected':expected,'differences':[c for c in checks if c['handout_missing_in_final'] or c['final_extra_vs_handout'] or any(s['unexpected_vs_final'] for s in c['states'])]},indent=2))
