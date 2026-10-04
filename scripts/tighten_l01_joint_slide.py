from pathlib import Path

path = Path("Lectures/L01_Probability_Statistics/slide_deck.typ")
text = path.read_text(encoding="utf-8")
start = text.index("== A linear Gaussian model defines a joint Gaussian")
end = text.index("== Bayes' rule for Gaussians", start)
block = text[start:end]

# The complete reveal exceeded Touying's available content height by ~4.6 pt.
# Tighten only internal vertical spacing on this slide; leave typography and
# the surrounding course layout unchanged.
block = block.replace('#v(0.45em)', '#v(0.15em)', 1)
block = block.replace('spacing: 0.55em,', 'spacing: 0.42em,')

text = text[:start] + block + text[end:]
path.write_text(text, encoding="utf-8")
print("Tightened joint-Gaussian slide spacing")
