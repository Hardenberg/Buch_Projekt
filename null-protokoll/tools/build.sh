#!/usr/bin/env bash
set -euo pipefail

OUT_DIR="export"
mkdir -p "$OUT_DIR"

INPUTS=(manuskript/*.md)

build_pdf () {
  local template="$1"
  local output="$2"

  if command -v xelatex >/dev/null 2>&1; then
    pandoc "${INPUTS[@]}" \
      --pdf-engine=xelatex \
      --template="$template" \
      -o "$OUT_DIR/$output"
    echo "✓ $output"
  else
    echo "✗ xelatex fehlt → $output übersprungen"
  fi
}

echo "=== Building All Formats ==="

echo "DOCX…"
pandoc "${INPUTS[@]}" -o "$OUT_DIR/null-protokoll.docx"
echo "✓ null-protokoll.docx"

echo "EPUB…"
pandoc "${INPUTS[@]}" -o "$OUT_DIR/null-protokoll.epub"
echo "✓ null-protokoll.epub"

echo "PDF Standard A5…"
build_pdf "tools/templates/book.tex" "null-protokoll_standard.pdf"

echo "PDF KDP 6x9…"
build_pdf "tools/templates/kdp_6x9.tex" "null-protokoll_kdp.pdf"

echo "PDF Normseite (Verlag)…"
build_pdf "tools/templates/normseite_a4.tex" "null-protokoll_normseite.pdf"

echo "PDF Horror A5…"
build_pdf "tools/templates/horror_a5.tex" "null-protokoll_horror.pdf"

echo "=== Done → $OUT_DIR/ ==="
