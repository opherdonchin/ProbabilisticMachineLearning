from pathlib import Path
import subprocess

patch = Path('scripts/rebuild_l01_section_summaries.py')
s = patch.read_text()

# The current source has slightly different indentation in the Gaussian
# conditional-mean key points than the historical patch expected. Remove that
# one strict replacement; we apply it directly against the current source below.
needle = "replace_once(\n'''    #stack(\n      spacing: 0.35em,\n      [- Start at the prior mean"
start = s.index(needle)
marker = "\n\n\n# ---------------------------------------------------------------------------\n# Section summaries."
end = s.index(marker, start)
s = s[:start] + s[end:]

# Probability for machine learning currently has no section-summary slide, so
# remove the replacement call and insert a new slide after the main patch runs.
prob = 'replace_summary(\n"== Summary: Probability for machine learning\\n",'
prob_start = s.index(prob)
next_summary = '\n\nreplace_summary(\n"== Summary: Joint Gaussian geometry\\n",'
prob_end = s.index(next_summary, prob_start)
s = s[:prob_start] + s[prob_end + 2:]
patch.write_text(s)

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
text = text.replace(old, new, 1)

# The graphical-model helper is intentionally large on its teaching slide and
# does not fit cleanly inside a compact summary card. On the section summary,
# use the already-taught model equations as the first visual anchor and retain
# the sensor-fusion figure as the second.
old_visual = '''    #section-summary-visual[
      #grid(
        columns: (0.72fr, 1.28fr),
        gutter: 0.75em,
        align: center + horizon,
        course-card(title: [State and measurement])[
          #stack(
            spacing: 0.35em,
            linear_gaussian_graph(),
            text(size: 0.6em)[$z tilde cal(N)(mu_z,Sigma_z), quad y|z tilde cal(N)(Wz+b,Omega)$],
          )
        ],
        course-figure(
          lecture-figure-path("generated/sensor_fusion_schematic.svg"),
          width: 100%,
          height: 4.55cm,
          show-source: false,
        ),
      )
    ]'''
new_visual = '''    #section-summary-visual[
      #grid(
        columns: (0.72fr, 1.28fr),
        gutter: 0.75em,
        align: center + horizon,
        course-card(title: [Linear Gaussian model])[
          #text(size: 0.75em)[
            #stack(
              spacing: 0.65em,
              [$z tilde cal(N)(mu_z,Sigma_z)$],
              [$y | z tilde cal(N)(W z+b,Omega)$],
              [$p(z,y)=p(z)p(y|z)$],
            )
          ]
        ],
        course-figure(
          lecture-figure-path("generated/sensor_fusion_schematic.svg"),
          width: 100%,
          height: 4.55cm,
          show-source: false,
        ),
      )
    ]'''
if text.count(old_visual) != 1:
    raise RuntimeError(f'Linear Gaussian summary visual: expected one match, found {text.count(old_visual)}')
text = text.replace(old_visual, new_visual, 1)

probability_summary = r'''== Summary: Probability for machine learning

#content-block(
  layout: "top",
  object-width: 98%,
  object: [
    #section-summary-visual[
      #align(center)[Joint distribution: $p_D(x_"obs",z,y_*)$]
      #v(0.45em)
      #grid(
        columns: (1fr, 1fr, 1fr),
        gutter: 0.55em,
        align: center + horizon,
        schema-node(
          [Summarize],
          [$E[g(X)] = integral g(x) p(x) dif x$],
          density: "prose",
        ),
        schema-node(
          [Marginalize],
          [$p(x) = integral p(x,y) dif y$],
          density: "prose",
          fill: palette.paper,
        ),
        schema-node(
          [Condition],
          [$p(x|y) = frac(p(x,y),p(y))$],
          density: "prose",
        ),
      )
    ]
    #v(0.35em)
    #section-summary-takeaways[
      #stack(
        spacing: 0.22em,
        [- The task determines which quantity we need from the joint distribution],
        [- A small set of recurring operations—summarize, marginalize, condition—answers many of those questions],
        [- Integrals are a central tool for answering these queries],
      )
    ]
  ],
)
'''
if '== Summary: Probability for machine learning' in text:
    raise RuntimeError('Probability summary unexpectedly already exists')
gaussian_marker = '''#section-metadata(
  short-title: [Gaussian geometry],
  subtitle: [Describe and transform joint uncertainty with a mean and covariance],
)'''
if text.count(gaussian_marker) != 1:
    raise RuntimeError(f'Gaussian section marker: expected one match, found {text.count(gaussian_marker)}')
text = text.replace(gaussian_marker, probability_summary + '\n\n\n' + gaussian_marker, 1)

deck.write_text(text)
print('Applied section-summary rebuild against current Lecture 1 source')
