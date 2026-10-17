# Formula spacing: current production check

The instructor identified recurring vertical crowding in the recording's
supplied-model box on 2026-10-17. The earlier render pass established no clipping;
it did not establish comfortable spacing for reading mathematics.

## Cause and repair

The supplied-model box joined separate inline equations with a forced line
break. Tall inline matrices extended beyond their ordinary text-line bounds.
Other proof groups relied on paragraph leading or weak vertical padding inside
blocks. These are unreliable ways to separate independent displayed formulas:
prose leading does not control distinct stacked blocks, and weak edge spacing
can disappear. The old local helper therefore treated recall and proof formulas
inconsistently.

`Lectures/course.typ` now supplies `math-rows([$...$], [$...$])`. Every argument
must be a single equation. It lays out that equation in display mode, reserves
its full height, and adds an explicit default 0.8em gap between rows. It rejects
prose containing inline math; that prose belongs in ordinary paragraphs or
stacks. This guard prevents inline variables in a sentence from accidentally
becoming separate displays. `gap:` and `alignment:` remain explicit production
choices. Do not reduce the default clearance to fit an overloaded slide.

The helper is the authoring default for separate formula rows, including recall
boxes. Existing live-deck mathematics is not globally restyled; the recording
uses the new helper. The production conventions record the rule, and the design
conventions require room for full formula heights before layout is chosen.

## Evidence

The isolated comparison in ignored `build/math-spacing/probe.typ` uses the same
supplied-model formulas at the same ambient 20pt size and the same recall-card
font size. The probe also contains three tall block-matrix proof rows. It
compiles without warnings and was inspected at full size. PDF text bounds give:

| Comparison | Vertical clearance between formula text bounds |
|---|---:|
| Original supplied-model inline rows | −1.05pt (vertical intervals overlap) |
| Display rows with the new default | 10.71pt |
| Three tall proof rows with the new default | 18.84pt, 19.50pt |

These text bounds are a diagnostic, not a substitute for visual judgment or a
universal readability threshold. Display layout also gives matrices their
normal display proportions. The complete recording must separately be inspected
with its actual labels, local warrants, key points and reveals.

The initial production lowering exposed a separate misuse: applying the formula
helper to prose broke sentences around their inline variables and inflated
height. Equation-only validation now makes this error visible. Removing repeated
box padding and keeping operation labels close to the mathematics addresses
layout overhead without tightening formulas or dropping proof steps.

The relevant Typst behavior was checked against the official
[stack](https://typst.app/docs/reference/layout/stack/),
[vertical spacing](https://typst.app/docs/reference/layout/v/) and
[paragraph](https://typst.app/docs/reference/model/par/) references and tested
in the actual course environment. The current recording production report owns
the final artifact versions and complete render validation.
