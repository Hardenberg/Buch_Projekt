#!/usr/bin/env bash
set -euo pipefail

OUT_DIR="export"
mkdir -p "$OUT_DIR"

INPUTS=(manuskript/*.md)

usage() {
  cat <<'EOF'
Verwendung:
  tools/build.sh [target...]

Targets:
  all         Alle Formate (Standard)
  docx        DOCX exportieren
  epub        EPUB exportieren
  standard    PDF Standard A5
  kdp         PDF KDP 6x9
  normseite   PDF Normseite A4
  horror      PDF Horror A5
EOF
}

build_pdf() {
  local label="$1"
  local template="$2"
  local output="$3"

  if command -v xelatex >/dev/null 2>&1; then
    echo "$label…"
    pandoc "${INPUTS[@]}" \
      --pdf-engine=xelatex \
      --template="$template" \
      -o "$OUT_DIR/$output"
    echo "✓ $output"
  else
    echo "✗ xelatex fehlt → $output übersprungen"
  fi
}

build_docx() {
  echo "DOCX…"
  pandoc "${INPUTS[@]}" -o "$OUT_DIR/null-protokoll.docx"
  echo "✓ null-protokoll.docx"
}

build_epub() {
  echo "EPUB…"
  pandoc "${INPUTS[@]}" -o "$OUT_DIR/null-protokoll.epub"
  echo "✓ null-protokoll.epub"
}

run_target() {
  case "$1" in
    all)
      build_docx
      build_epub
      build_pdf "PDF Standard A5" "tools/templates/book.tex" "null-protokoll_standard.pdf"
      build_pdf "PDF KDP 6x9" "tools/templates/kdp_6x9.tex" "null-protokoll_kdp.pdf"
      build_pdf "PDF Normseite (Verlag)" "tools/templates/normseite_a4.tex" "null-protokoll_normseite.pdf"
      build_pdf "PDF Horror A5" "tools/templates/horror_a5.tex" "null-protokoll_horror.pdf"
      ;;
    docx)
      build_docx
      ;;
    epub)
      build_epub
      ;;
    standard)
      build_pdf "PDF Standard A5" "tools/templates/book.tex" "null-protokoll_standard.pdf"
      ;;
    kdp)
      build_pdf "PDF KDP 6x9" "tools/templates/kdp_6x9.tex" "null-protokoll_kdp.pdf"
      ;;
    normseite)
      build_pdf "PDF Normseite (Verlag)" "tools/templates/normseite_a4.tex" "null-protokoll_normseite.pdf"
      ;;
    horror)
      build_pdf "PDF Horror A5" "tools/templates/horror_a5.tex" "null-protokoll_horror.pdf"
      ;;
    -h|--help|help)
      usage
      ;;
    *)
      echo "Unbekanntes Target: $1" >&2
      usage
      exit 1
      ;;
  esac
}

if [ "$#" -eq 0 ]; then
  set -- all
fi

echo "=== Building: $* ==="
for target in "$@"; do
  run_target "$target"
done

echo "=== Done → $OUT_DIR/ ==="
