#set page(
  paper: "a4",
  flipped: false,
  margin: (x: 15mm, y: 13mm),
)
#set text(font: "Libertinus Serif", size: 11pt)
#set par(leading: 1em, spacing: 0.8em)

#let navy = rgb("#173A5E")
#let blue = rgb("#2F6690")
#let pale-blue = rgb("#EEF4F8")
#let rule = rgb("#D8DEE4")
#let muted = rgb("#59636E")

#show heading.where(level: 1): it => block(above: 1.1em, below: 1em)[
  #text(size: 16pt, weight: "bold", fill: navy)[#it.body]
]
#show heading.where(level: 2): it => block(above: 1.1em, below: 0.8em)[
  #text(size: 11.3pt, weight: "bold", fill: blue)[#it.body]
]

#let hdr(body) = table.cell(fill: navy, inset: 5pt)[
  #text(weight: "bold", fill: white)[#body]
]
#let note(body) = text(size: 7.3pt, fill: muted, body)

#let concept-card(title, body, tint: pale-blue) = rect(
  width: 100%,
  inset: 9pt,
  radius: 5pt,
  fill: tint,
  stroke: 0.65pt + rule,
)[
  #align(center)[
    #text(weight: "bold", fill: navy)[#title]
    #v(3pt)
    #text(size: 8.5pt, fill: black)[#body]
  ]
]

= Curriculum map — actual

#text(size: 9pt, fill: muted)[Advanced Statistics 2027-1 · Actual material reached in class and the student notebook]

This is the *actual-teaching counterpart* of the #link("curriculum_map.typ")[planned curriculum map]. Both use the same thirteen meetings and six-column lecture/source/notebook structure. The planned map records intended content and source coverage; this map records *only* what actually happens. A drafted deck, a solved notebook or an approved scope is preparation, not actual coverage. No meeting has been taught yet, so the table begins deliberately empty.

After each meeting, update the corresponding row with topics substantively taught (not merely mentioned), Murphy Book 2 and Book 1 sections *actually reached*, and what students were assigned to do or attempted in the notebook. Record incomplete work, omitted material, deviations from the plan, and planned carry-forward. Distinguish an assigned exercise from observed student completion. Do not automatically copy planned topics into this table.

#set page(flipped: true)
#set text(size: 8pt)
#set par(leading: 0.55em, spacing: 0.6em)

= Lecture-by-lecture actual coverage

#table(
  columns: (8mm, 31mm, 55mm, 46mm, 42mm, 71mm),
  inset: 4pt,
  stroke: 0.45pt + rule,
  align: (left, left, left, left, left, left),
  table.header(
    hdr[No.],
    hdr[Lecture / status],
    hdr[Actually taught / worked],
    hdr[Book 2 — reached],
    hdr[Book 1 — reached],
    hdr[Notebook assigned / attempted; omissions and follow-up],
  ),

  [1],
  [*Probabilistic ML and Gaussian systems* \
  #note[Not yet taught]],
  [—],
  [—],
  [—],
  [Not yet attempted],

  [2],
  [*Exponential families and learning from sufficient statistics* \
  #note[Not yet taught]],
  [—],
  [—],
  [—],
  [Not yet attempted],

  [3],
  [*Graphical models: factorization and conditional independence* \
  #note[Not yet taught]],
  [—],
  [—],
  [—],
  [Not yet attempted],

  [4],
  [*Information theory: distributional comparison and information preservation* \
  #note[Not yet taught]],
  [—],
  [—],
  [—],
  [Not yet attempted],

  [5],
  [*Generalized linear models, automatic differentiation and SGD* \
  #note[Not yet taught]],
  [—],
  [—],
  [—],
  [Not yet attempted],

  [6],
  [*Latent-variable learning and expectation-maximization* \
  #note[Not yet taught]],
  [—],
  [—],
  [—],
  [Not yet attempted],

  [7],
  [*Inference overview and Laplace approximation* \
  #note[Not yet taught]],
  [—],
  [—],
  [—],
  [Not yet attempted],

  [8],
  [*Exact inference in structured sequence models* \
  #note[Not yet taught]],
  [—],
  [—],
  [—],
  [Not yet attempted],

  [9],
  [*Variational and amortized inference* \
  #note[Not yet taught]],
  [—],
  [—],
  [—],
  [Not yet attempted],

  [10],
  [*Deep Neural Networks I: learned representations and images* \
  #note[Not yet taught]],
  [—],
  [—],
  [—],
  [Not yet attempted],

  [11],
  [*Deep Neural Networks II: representing sequence context* \
  #note[Not yet taught]],
  [—],
  [—],
  [—],
  [Not yet attempted],

  [12],
  [*Variational autoencoders: amortized inference and rate–distortion* \
  #note[Not yet taught]],
  [—],
  [—],
  [—],
  [Not yet attempted],

  [13],
  [*Project presentations and course synthesis* \
  #note[Not yet taught]],
  [—],
  [—],
  [—],
  [Not yet attempted],
)

#set page(flipped: false)
#set text(size: 11pt)
#set par(leading: 1em, spacing: 0.8em)
