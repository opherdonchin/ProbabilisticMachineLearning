"""Create a self-contained local slide browser from the frozen candidate PDFs."""

import base64
import hashlib
import html
import json
import re
from pathlib import Path

import pymupdf


HERE = Path(__file__).resolve().parent
CANDIDATE = HERE / "candidate"
source = (CANDIDATE / "slide_deck.typ").read_text()
titles = ["Gaussian conditioning by block elimination"] + re.findall(
    r"^==\s+(.+)$", source, re.MULTILINE)


def normalized(text):
    return " ".join(text.replace("’", "'").replace("‘", "'").split())


presentation = pymupdf.open(CANDIDATE / "slide_deck_presentation.pdf")
handout = pymupdf.open(CANDIDATE / "slide_deck.pdf")
groups = [[] for _ in titles]
for page in presentation:
    header = normalized(page.get_text(clip=pymupdf.Rect(
        0, 0, page.rect.width, page.rect.height * .16)))
    matches = [i for i, title in enumerate(titles[1:], 1)
               if normalized(title) in header]
    index = matches[0] if len(matches) == 1 else 0
    if index == 0 and page.number != 0:
        raise ValueError(f"Unidentified presentation page {page.number+1}: {header}")
    pixmap = page.get_pixmap(matrix=pymupdf.Matrix(1.5, 1.5))
    groups[index].append({"page": page.number + 1,
                          "image": base64.b64encode(pixmap.tobytes("png")).decode()})

assert len(handout) == len(groups)
assert all(groups)
cards = []
for i, (title, states) in enumerate(zip(titles, groups)):
    cards.append(f'''<article id="slide-{i+1}">
<h2>{i+1}. {html.escape(title)}</h2>
<img id="image-{i}" alt="Slide {i+1}, final state" loading="lazy"
 src="data:image/png;base64,{states[-1]['image']}">
<div class="controls"><button onclick="show({i},0)">First state</button>
<button onclick="move({i},-1)" aria-label="Previous reveal">←</button>
<span id="label-{i}"></span>
<button onclick="move({i},1)" aria-label="Next reveal">→</button>
<button onclick="show({i},{len(states)-1})">Completed slide</button>
<a href="slide_deck_presentation.pdf#page={states[0]['page']}">PDF</a></div></article>''')

document = '''<!doctype html><html lang="en"><meta charset="utf-8">
<meta name="viewport" content="width=device-width,initial-scale=1">
<title>L01-R01 — rule-guided experimental baseline</title>
<style>
body{margin:0;background:#f2f2ec;color:#252525;font:17px system-ui,sans-serif}
header,main{max-width:1100px;margin:auto;padding:24px}
header{padding-bottom:0}h1{font-size:27px}h2{font-size:18px;font-weight:600}
p{line-height:1.5}a{color:#9e420e}article{margin:20px 0 36px;scroll-margin-top:20px}
img{display:block;width:100%;height:auto;background:#fffff9;border:1px solid #ddd}
.controls{display:flex;align-items:center;flex-wrap:wrap;gap:10px;padding:10px 0}
button{font:inherit;background:#fff;border:1px solid #bbb;border-radius:4px;padding:5px 9px;cursor:pointer}
button:hover{background:#f8e7da}nav a{margin-right:18px}small{color:#555}
@media(min-width:1500px){main{max-width:1263px}}
</style><header><h1>Gaussian conditioning by block elimination</h1>
<p>L01-R01 · autonomous rule-guided first candidate · awaiting instructor evaluation.</p>
<nav><a href="slide_deck.pdf">Handout PDF</a>
<a href="slide_deck_presentation.pdf">Presentation PDF</a>
<a href="rule_application_ledger.md">Rule-application ledger</a></nav>
<p>Each image starts at its completed state. Use the controls below it to inspect
the reveal sequence. This page is self-contained and works offline.</p>
<button onclick="positions.forEach((_,i)=>show(i,0))">Start every slide at its first state</button>
<button onclick="positions.forEach((_,i)=>show(i,slides[i].length-1))">Show completed slides</button>
</header><main>''' + "\n".join(cards) + '''</main><script>
const slides=SLIDE_DATA;
const positions=slides.map(x=>x.length-1);
function show(i,k){k=Math.max(0,Math.min(slides[i].length-1,k));positions[i]=k;
 const image=document.getElementById('image-'+i);
 image.src='data:image/png;base64,'+slides[i][k].image;
 image.alt='Slide '+(i+1)+', state '+(k+1);
 document.getElementById('label-'+i).textContent='State '+(k+1)+' / '+slides[i].length+
 ' · presentation p.'+slides[i][k].page;}
function move(i,d){show(i,positions[i]+d)}
positions.forEach((_,i)=>show(i,positions[i]));
</script></html>'''
document = document.replace("SLIDE_DATA", json.dumps(groups, separators=(",", ":")))
(CANDIDATE / "preview.html").write_text(document)
mapping = {"slides": [{"number": i+1, "title": title,
                        "handout_page": i+1,
                        "presentation_pages": [s["page"] for s in states]}
                       for i, (title, states) in enumerate(zip(titles, groups))],
           "pdf_hashes": {name: hashlib.sha256((CANDIDATE / name).read_bytes()).hexdigest()
                          for name in ["slide_deck.pdf", "slide_deck_presentation.pdf"]}}
(CANDIDATE / "preview_mapping.json").write_text(json.dumps(mapping, indent=2)+"\n")
print(f"Created offline browser: {len(groups)} slides / {len(presentation)} states")
