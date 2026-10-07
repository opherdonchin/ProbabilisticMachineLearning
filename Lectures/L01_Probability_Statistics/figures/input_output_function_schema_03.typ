// Functional view of a machine-learning task: input, learned function, output.
#import "../../themes/ruled-page/template.typ": palette

#let input_output_function_schema() = align(center)[
  #box(
    width: 100%,
    fill: palette.paper,
    stroke: 0.8pt + palette.rule-line,
    radius: 8pt,
    inset: 16pt,
  )[
    #grid(
      columns: (1fr, 0.32fr, 1.25fr, 0.32fr, 1fr),
      gutter: 0.25em,
      align: center + horizon,

      box(
        width: 100%,
        fill: palette.accent.lighten(86%),
        radius: 5pt,
        inset: (x: 12pt, y: 10pt),
      )[
        #align(center)[
          #stack(
            spacing: 0.18em,
            text(size: 1.15em, weight: "semibold", fill: palette.dark)[$x$],
            text(size: 0.72em, fill: palette.text)[input],
          )
        ]
      ],
      text(size: 1.4em, fill: palette.accent)[$arrow.r$],
      box(
        width: 100%,
        stroke: 1.3pt + palette.accent,
        radius: 5pt,
        inset: (x: 14pt, y: 12pt),
      )[
        #align(center)[
          #stack(
            spacing: 0.18em,
            text(size: 1.32em, weight: "semibold", fill: palette.dark)[$f$],
            text(size: 0.72em, fill: palette.text)[Function],
          )
        ]
      ],
      text(size: 1.4em, fill: palette.accent)[$arrow.r$],
      box(
        width: 100%,
        fill: palette.accent.lighten(86%),
        radius: 5pt,
        inset: (x: 12pt, y: 10pt),
      )[
        #align(center)[
          #stack(
            spacing: 0.18em,
            text(size: 1.15em, weight: "semibold", fill: palette.dark)[$y$],
            text(size: 0.72em, fill: palette.text)[output],
          )
        ]
      ],
    )
  ]
]
