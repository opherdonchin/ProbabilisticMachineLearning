// Linear Gaussian graphical model: latent state above observed measurement.
#import "../../course_06.typ": course-diagram, graph-node, graph-edge
#import "../../themes/ruled-page/template.typ": palette

#let linear_gaussian_graph() = align(center + horizon)[
  #course-diagram(
    spacing: (3.3em, 3em),
    node-stroke: 1.2pt + palette.dark,
    node-fill: palette.paper,
    edge-stroke: 1.4pt + palette.accent,
    mark-scale: 70%,

    graph-node(
      (0, 0),
      name: <state>,
      shape: circle,
      width: 2em,
      height: 2em,
    )[$z$],

    graph-node(
      (0, 1),
      name: <measurement>,
      shape: circle,
      width: 2em,
      height: 2em,
      fill: palette.accent.lighten(78%),
    )[$y$],

    graph-edge(<state>, <measurement>, "-|>"),

    graph-node((0.95, 0), stroke: none, fill: none)[
      #text(size: 0.65em)[Latent state]
    ],
    graph-node((0.95, 1), stroke: none, fill: none)[
      #text(size: 0.65em)[Observed]
    ],
  )
]
