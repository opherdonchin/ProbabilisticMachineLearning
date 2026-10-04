# /// script
# requires-python = ">=3.12"
# dependencies = ["typst==0.15.0", "pymupdf==1.28.2"]
# ///
"""Compile both deck modes and render only selected slides, without editing source.

Run with uv run scripts/review_slides.py ENTRY --slide "Exact slide title".
Outputs live in build/slide-review/<lecture>/<entry>/; report.json lists only
the current run's previews. Compilation is not a substitute for visual review.
"""

import argparse
import hashlib
import json
import re
import tempfile
from pathlib import Path

import pymupdf
import typst

from check_typst_math_attachments import check


ROOT = Path(__file__).resolve().parents[1]
MODE = re.compile(r"config-common\(handout:\s*(?:true|false)\)")


def normalized(text):
    return " ".join(text.split())


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("entry", type=Path)
    parser.add_argument("--slide", action="append", required=True,
                        help="Exact plain-text level-2 heading; repeat as needed")
    args = parser.parse_args()
    entry = args.entry.resolve()
    entry.relative_to(ROOT)
    raw = entry.read_bytes()
    source = raw.decode("utf-8")
    headings = re.findall(r"^==\s+(.+)$", source, re.MULTILINE)
    for title in args.slide:
        if sum(normalized(h) == normalized(title) for h in headings) != 1:
            parser.error(f"Expected one exact source heading: {title!r}")
    if len(MODE.findall(source)) != 1:
        parser.error("Expected one explicit config-common(handout: true/false)")
    if check(entry):
        return 1

    out = ROOT / "build" / "slide-review" / entry.parent.name / entry.stem
    out.mkdir(parents=True, exist_ok=True)
    report_path = out / "report.json"
    report_path.write_text('{"status": "incomplete"}\n', encoding="utf-8")
    report = {"source": str(entry.relative_to(ROOT)),
              "sha256": hashlib.sha256(raw).hexdigest(),
              "warnings": [], "pages": {}, "previews": [],
              "visual_review": "pending"}
    documents = {}
    # A temporary sibling preserves ALL source-relative imports and image paths.
    # Never change the real entry, including during concurrent authoring.
    with tempfile.NamedTemporaryFile(dir=entry.parent, suffix=".typ",
                                     prefix=".slide-review-", delete=False) as f:
        temporary = Path(f.name)
    try:
        for mode, flag in [("handout", "true"), ("presentation", "false")]:
            temporary.write_text(MODE.sub(f"config-common(handout: {flag})", source),
                                 encoding="utf-8")
            pdf, warnings = typst.compile_with_warnings(str(temporary), root=str(ROOT))
            report["warnings"].extend(str(w) for w in warnings)
            documents[mode] = pymupdf.open(stream=pdf, filetype="pdf")
            report["pages"][mode] = len(documents[mode])
            (out / f"{mode}.pdf").write_bytes(pdf)
    finally:
        temporary.unlink(missing_ok=True)

    for title in dict.fromkeys(args.slide):
        slug = re.sub(r"[^a-z0-9]+", "-", title.lower()).strip("-")[:75]
        slug += "-" + hashlib.sha256(title.encode()).hexdigest()[:8]
        matches = {}
        for mode, doc in documents.items():
            # Restrict matching to the header region, avoiding notes/body mentions.
            pages = [p.number for p in doc if normalized(title) in normalized(
                p.get_text(clip=pymupdf.Rect(0, 0, p.rect.width, p.rect.height * .16)))]
            if not pages or (mode == "handout" and len(pages) != 1):
                raise ValueError(f"Cannot uniquely locate {title!r} in {mode}")
            matches[mode] = pages
            selected = pymupdf.open()
            for i, number in enumerate(pages, 1):
                selected.insert_pdf(doc, from_page=number, to_page=number)
                name = f"{slug}-{mode}-{i}.png"
                doc[number].get_pixmap(matrix=pymupdf.Matrix(1.5, 1.5)).save(out / name)
                report["previews"].append(name)
            selected.save(out / f"{slug}-{mode}.pdf")
            selected.close()
        final = documents["presentation"][matches["presentation"][-1]].get_pixmap()
        handout = documents["handout"][matches["handout"][0]].get_pixmap()
        if (final.width, final.height, final.samples) != (handout.width, handout.height, handout.samples):
            report["warnings"].append(f"Final reveal differs from handout: {title}")
        print(f"{title}: {len(matches['presentation'])} reveal states + handout")

    if entry.read_bytes() != raw:
        raise RuntimeError("Entry changed during review; rerun on the latest source")
    report["status"] = "review-warnings" if report["warnings"] else "mechanical-pass"
    report_path.write_text(json.dumps(report, indent=2) + "\n", encoding="utf-8")
    print(f"{report['status']}: {report['pages']}; {len(report['warnings'])} warnings")
    for warning in report["warnings"]:
        print(warning)
    print(f"Review manifest: {report_path}")
    for doc in documents.values():
        doc.close()
    return int(bool(report["warnings"]))


if __name__ == "__main__":
    raise SystemExit(main())
