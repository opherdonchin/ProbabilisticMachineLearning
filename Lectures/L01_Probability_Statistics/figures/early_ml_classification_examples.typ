// Historical figures for early classification and pattern-recognition tasks.
#import "../../themes/ruled-page/template.typ": palette

#let _historical_example(year, title, figure-path, caption) = box(
  width: 100%,
  fill: palette.paper,
  stroke: 0.8pt + palette.rule-line,
  radius: 6pt,
  inset: 12pt,
)[
  #stack(
    spacing: 0.42em,

    box(
      fill: palette.accent,
      radius: 2pt,
      inset: (x: 5pt, y: 2pt),
    )[
      #text(size: 0.58em, weight: "bold", fill: white)[#year]
    ],

    text(size: 1.02em, weight: "semibold", fill: palette.dark)[#title],
    align(center)[#image(figure-path, width: 100%)],
    text(size: 0.59em, fill: palette.muted)[#caption],
  )
]

#let early_ml_classification_examples() = stack(
  spacing: 0.75em,

  align(center)[
    #stack(
      spacing: 0.15em,
      text(size: 0.72em, fill: palette.muted)[A recurring computational problem],
      text(size: 1.08em, weight: "semibold", fill: palette.dark)[
        complicated observations $arrow.r$ simpler, useful outputs or representations
      ],
    )
  ],

  grid(
    columns: (1fr, 1fr),
    gutter: 0.8em,
    align: top,

    _historical_example(
      [FISHER, 1936],
      [A discriminant function separates flower species],
      "fisher_1936__iris_discriminant_histograms.png",
      [Original Fig. 1: distributions of Fisher's discriminating linear function.],
    ),
    _historical_example(
      [ROSENBLATT, 1958],
      [A perceptron maps a sensory pattern to a response],
      "rosenblatt_1958__perceptron_organization.png",
      [Original Fig. 1: organization of a perceptron.],
    ),
  ),

  box(
    width: 100%,
    stroke: (left: 2.5pt + palette.accent),
    inset: (left: 10pt, y: 6pt, right: 8pt),
  )[
    #text(size: 0.74em, fill: palette.text)[
      *MacQueen (1967):* $x in bb(R)^d arrow.r z in {1, dots, K}$ -- discover
      useful groups from the inputs themselves, without supplied labels.
    ]
  ],
)
