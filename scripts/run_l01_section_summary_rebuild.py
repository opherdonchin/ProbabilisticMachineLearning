from pathlib import Path
import subprocess

patch = Path('scripts/rebuild_l01_section_summaries.py')
s = patch.read_text()
needle = "replace_once(\n'''    #stack(\n      spacing: 0.35em,\n      [- Start at the prior mean"
start = s.index(needle)
marker = "\n\n\n# ---------------------------------------------------------------------------\n# Section summaries."
end = s.index(marker, start)
patch.write_text(s[:start] + s[end:])

subprocess.run(['python', str(patch)], check=True)

deck = Path('Lectures/L01_Probability_Statistics/slide_deck.typ')
text = deck.read_text()
old = '''      #stack(
        spacing: 0.35em,
        [- Start at the prior mean $mu_1$],
        uncover("2-")[- Respond to the innovation $x_2-mu_2$],
        uncover("4-")[- Cross-covariance and observed variance determine the response],
      )'''
new = '''      #stack(
        spacing: 0.35em,
        [- Conditioning shifts the mean according to the observed deviation $x_2-mu_2$, cross-covariance, and observed variance],
      )'''
if text.count(old) != 1:
    raise RuntimeError(f'conditional-mean key point: expected one match, found {text.count(old)}')
deck.write_text(text.replace(old, new, 1))
print('Applied section-summary rebuild against current Lecture 1 source')
