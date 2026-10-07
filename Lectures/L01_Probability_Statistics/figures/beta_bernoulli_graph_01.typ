// Beta-Bernoulli graphical model used in the introductory modelling slide.
#import "../../course_01.typ": course-diagram, graph-node, graph-edge
#import "../../themes/ruled-page/template.typ": palette

#let beta_bernoulli_graph() = align(center + horizon)[
  #course-diagram(
    spacing: (4.2em, 3em),
    node-stroke: 1.2pt + palette.dark,
    node-fill: palette.paper,
    edge-stroke: 1.4pt + palette.accent,
    mark-scale: 70%,

    graph-node(
      (0, 0),
      name: <hyperparameters>,
      stroke: none,
      fill: none,
    )[
      #stack(
        spacing: 0.3em,
        text(size: 1.2em)[$alpha, beta$],
      )
    ],

    graph-node(
      (0, 1),
      name: <theta-node>,
      shape: circle,
      width: 2em,
      height: 2em,
    )[$theta$],

    graph-node(
      (0, 2),
      name: <data-node>,
      shape: circle,
      width: 2em,
      height: 2em,
      fill: palette.accent.lighten(78%),
    )[$y_i$],

    graph-edge(<hyperparameters>, <theta-node>, "-|>"),
    graph-edge(<theta-node>, <data-node>, "-|>"),

    graph-node(
      (0.1, 1.5),
      stroke: none,
      fill: none,
    )[$i$],
  )
]
