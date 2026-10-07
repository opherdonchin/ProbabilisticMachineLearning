// Compact visual and source reference for course slide authoring.
// This file is not a lecture. Its source is authoritative; any PDF used as a
// design reference should be freshly compiled from this file and course.typ.

#import "course.typ": *

#let lecture = (
  number: 0,
  title: [Authoring Reference],
  short-title: [Authoring reference],
  subtitle: [Representative course-level slide structures],
)

#show: course-theme.with(info: lecture)
#show: touying-set-config.with(config-common(handout: true))

#title-slide()

#section-metadata(
  short-title: [Ordinary slides],
  subtitle: [Object, interpretation, cards, and composition],
)

= Ordinary teaching slides

== Object and interpretation

#content-block(
  object-width: 72%,
  object: [
    #card[
      #align(center)[
        #stack(
          spacing: sp("l"),
          text(size: fs("xl"))[$p(theta | y) prop p(y | theta) p(theta)$],
          uncover("2-")[
            #text(size: fs("m"), fill: palette.muted)[
              data update a prior distribution into a posterior distribution
            ]
          ],
        )
      ]
    ]
  ],
  key-points: [
    - The object region carries the mathematical or visual object under discussion
    #uncover("2-")[
      - The key-points region carries interpretation, consequences, or framing
    ]
  ],
)


== Layout arranges semantic or visual groups

#content-block(
  object: [
    #twocol(
      columns: cols("left"),
      gutter: sp("l"),
      align: top,
    )[
      #bordered-card(title: [Model])[
        #stack(
          spacing: sp("m"),
          [$theta tilde "Beta"(alpha, beta)$],
          [$y_i tilde "Bernoulli"(theta)$],
        )
      ]
    ][
      #bordered-card(title: [Question])[
        #stack(
          spacing: sp("m"),
          [$p(theta | y)$],
          [What does observing data tell us about the unknown parameter?],
        )
      ]
    ]
  ],
  key-points: [
    - Cards identify what belongs together
    - `twocol` supplies geometry; it does not determine semantic role
  ],
)


== A schema can combine several representations

#content-block(
  object-width: 86%,
  object: [
    #schema-card[
      #twocol(
        columns: cols("equal"),
        gutter: sp("xl"),
        align: center + horizon,
      )[
        #align(center)[
          #stack(
            spacing: sp("m"),
            [$theta tilde p(theta)$],
            [$y tilde p(y | theta)$],
          )
        ]
      ][
        #grid(
          columns: (1fr, auto, 1fr),
          gutter: sp("m"),
          align: center + horizon,
          schema-node([Latent], [$theta$]),
          schema-arrow,
          schema-node([Observed], [$y$], fill: palette.paper),
        )
      ]
    ]
  ],
  key-points: [
    - The symbolic and graphical views form one conceptual schematic
    - Production mechanism does not determine card type
  ],
)


== A figure card owns figure-level provenance

#content-block(
  layout: "side-left",
  object-width: 58%,
  object: [
    #figure-card(
      from: [Course rendering used in Lecture 1; generated from `gaussian_geometry_figures.ipynb`],
    )[
      #course-image(
        "L01_Probability_Statistics/generated/gaussian_contours.svg",
        width: 100%,
        height: 5.2cm,
      )
    ]
  ],
  key-points: [
    - Figure chrome, caption, and provenance belong to the figure card
    - The image loader only handles the asset itself
  ],
)


== Width belongs to the parent composition

#content-block(
  object: [
    #align(left)[
      #block(width: 52%)[
        #recall-card(
          from: [Earlier in the lecture: the model definition],
        )[
          #stack(
            spacing: sp("xs"),
            [Model],
            [$theta tilde "Beta"(alpha,beta)$],
            [$y_i tilde "Bernoulli"(theta)$],
          )
        ]
      ]
    ]

    #v(sp("l"))

    #card[
      #align(center)[
        #text(size: fs("xl"))[
          $p(theta | y) prop p(y | theta) p(theta)$
        ]
      ]
    ]
  ],
  key-points: [
    - The recall card fills the space allocated by its parent
    - A narrow card does not imply a different card-density API
  ],
)


== Side composition is still one ordinary content block

#content-block(
  layout: "side-right",
  object-width: 42%,
  object: [
    #schema-card[
      #stack(
        spacing: sp("m"),
        schema-node([Input], [$x$]),
        schema-node([Model], [$f_D$], fill: palette.paper),
        schema-node([Output], [$hat(y)$]),
      )
    ]
  ],
  key-points: [
    - Side layouts are useful when interpretation deserves comparable visual weight
    - The object and key-points regions remain the same conceptual architecture
  ],
)


== Summary: ordinary slide architecture

#content-block(
  object: [
    #section-summary-visual[
      #twocol(
        gutter: sp("l"),
        align: center + horizon,
      )[
        #bordered-card(title: [Object])[
          #align(center)[equation, figure, schema, comparison, or construction]
        ]
      ][
        #bordered-card(title: [Interpretation])[
          #align(center)[meaning, consequence, or framing]
        ]
      ]
    ]

    #v(sp("s"))

    #section-summary-takeaways[
      #stack(
        spacing: sp("xs"),
        [Cards express semantic or visual grouping; layout expresses geometry.],
        [Ordinary teaching slides normally use one object + key-points composition.],
      )
    ]
  ],
)


#section-metadata(
  short-title: [Reveal structure],
  subtitle: [Cumulative construction and exceptional replacement],
)

= Reveal structure

== Cumulative reveal is the normal timing pattern

#content-block(
  object: [
    #triad(
      gutter: sp("l"),
      align: top,
    )[
      #bordered-card(title: [State 1])[
        context already visible when the slide opens
      ]
    ][
      #uncover("2-")[
        #bordered-card(title: [State 2])[
          one new teaching step
        ]
      ]
    ][
      #uncover("3-")[
        #bordered-card(title: [State 3])[
          another teaching step
        ]
      ]
    ]
  ],
  key-points: [
    - State 1 is implicit and unwrapped
    #uncover("2-")[
      - Matching state numbers can coordinate object and interpretation
    ]
    #uncover("3-")[
      - Earlier material remains visible when it supports the next step
    ]
  ],
)


== Replacement reveal reserves a stable region

#content-block(
  object-width: 78%,
  object: [
    #card[
      #block(width: 100%, height: 4.2cm)[
        #align(center + horizon)[
          #only("1")[
            #bordered-card(title: [Question])[
              Which representation is useful before the answer is known?
            ]
          ]
          #only("2")[
            #bordered-card(title: [Answer])[
              The replacement occupies the same reserved visual region.
            ]
          ]
        ]
      ]
    ]
  ],
  key-points: [
    #only("1")[
      - Replacement/focus is exceptional rather than the default timing model
    ]
    #only("2")[
      - Fixed surrounding geometry prevents a replacement reveal from shifting the slide
    ]
  ],
)
