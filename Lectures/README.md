# First-pass shared Typst course layer

This package is meant to be copied into `Lectures/`.

Expected local theme path:

```text
Lectures/themes/ruled-page/template.typ
```

Files:

```text
Lectures/
├── course.typ
└── L01_Probability_Statistics/
    ├── slide_deck.typ
    ├── coin_model.ipynb
    └── figures/
        ├── coin_model__beta_distribution.svg
        ├── coin_model__bernoulli_likelihood.svg
        ├── coin_model__prior_likelihood_posterior.svg
        ├── coin_model__sequential_updating.svg
        ├── coin_model__posterior_predictive.svg
        └── coin_model__sampling_monte_carlo.svg
```

## Design intent

`course.typ` is deliberately a thin course-specific layer over SeaSlides Ruled Page.

It adds:

- lecture metadata and title-slide ordering;
- muted lecture identity in the ordinary-slide header;
- current section at footer left and slide X/Y at footer right;
- numbered section slides with full title, short footer title, and subtitle;
- `content-slide` with `top`, `bottom`, `side-left`, and `side-right` composition;
- semantic wrappers `key-points`, `note`, `definition`, and `method`;
- `course-figure` with path provenance and missing-file fallback;
- lightweight coordinate-based annotations.

It intentionally delegates palette, typography, spacing, list styling, and most component styling to Ruled Page.

## Likely debugging points

This first pass was produced without a Typst compiler in the current runtime. The most likely points for a VS Code/Tylina agent to check are:

1. Whether the later `config-common` / `config-store` arguments passed through `ruled-page-theme.with(...)` override the theme defaults exactly as intended.
2. Whether Typst resolves figure paths passed through `course-figure` relative to the lecture file or `course.typ`. If it resolves relative to `course.typ`, prefix paths with the lecture directory or add an asset-root parameter once.
3. The missing-image fallback uses the known `context`/`query` workaround and may depend on compiler behavior.
4. `annotated-object` currently uses a straight pointer line plus a target dot rather than a true arrowhead; keep or refine only if real slides need it.
5. The migrated Lecture 1 source preserves most of the previous draft rather than redesigning every slide. Use it to discover which shared helpers are actually worth keeping.

The intended workflow is to compile in Tylina/TinyMist, fix syntax/API details locally, and then update `course.typ` rather than patching each lecture independently.
