#!/usr/bin/env bash
set -euo pipefail

OUT_DIR="export"
mkdir -p "$OUT_DIR"

META_FILE="manuskript/00_meta.md"
CONTENT_INPUTS=(manuskript/[0-9][0-9]_*.md)
INPUTS=("${CONTENT_INPUTS[@]}")
META_ARGS=()

if [ -f "$META_FILE" ]; then
  mapfile -t META_LINES < <(sed -n '1,3p' "$META_FILE")
  if [[ "${META_LINES[0]:-}" == %* ]]; then
    META_ARGS+=(--metadata "title=${META_LINES[0]#% }")
  fi
  if [[ "${META_LINES[1]:-}" == %* ]]; then
    META_ARGS+=(--metadata "author=${META_LINES[1]#% }")
  fi
  if [[ "${META_LINES[2]:-}" == %* ]]; then
    META_ARGS+=(--metadata "date=${META_LINES[2]#% }")
  fi
fi

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
  local top_level_division="${4:-section}"

  if command -v xelatex >/dev/null 2>&1; then
    echo "$label…"
    pandoc "${INPUTS[@]}" \
      "${META_ARGS[@]}" \
      --pdf-engine=xelatex \
      --top-level-division="$top_level_division" \
      --template="$template" \
      -o "$OUT_DIR/$output"
    echo "✓ $output"
  else
    echo "✗ xelatex fehlt → $output übersprungen"
  fi
}

build_docx() {
  echo "DOCX…"
  pandoc "${INPUTS[@]}" "${META_ARGS[@]}" -o "$OUT_DIR/null-protokoll.docx"
  echo "✓ null-protokoll.docx"
}

build_epub() {
  echo "EPUB…"
  pandoc "${INPUTS[@]}" "${META_ARGS[@]}" -o "$OUT_DIR/null-protokoll.epub"
  echo "✓ null-protokoll.epub"
}

run_wordcount() {
  if command -v python3 >/dev/null 2>&1; then
    echo "Wordcount…"
    python3 tools/wordcount.py
  else
    echo "✗ python3 fehlt → wordcount übersprungen"
  fi
}

run_target() {
  case "$1" in
    all)
      build_docx
      build_epub
      build_pdf "PDF Standard A5" "tools/templates/book.tex" "null-protokoll_standard.pdf" "chapter"
      build_pdf "PDF KDP 6x9" "tools/templates/kdp_6x9.tex" "null-protokoll_kdp.pdf" "chapter"
      build_pdf "PDF Normseite (Verlag)" "tools/templates/normseite_a4.tex" "null-protokoll_normseite.pdf"
      build_pdf "PDF Horror A5" "tools/templates/horror_a5.tex" "null-protokoll_horror.pdf" "chapter"
      ;;
    docx)
      build_docx
      ;;
    epub)
      build_epub
      ;;
    standard)
      build_pdf "PDF Standard A5" "tools/templates/book.tex" "null-protokoll_standard.pdf" "chapter"
      ;;
    kdp)
      build_pdf "PDF KDP 6x9" "tools/templates/kdp_6x9.tex" "null-protokoll_kdp.pdf" "chapter"
      ;;
    normseite)
      build_pdf "PDF Normseite (Verlag)" "tools/templates/normseite_a4.tex" "null-protokoll_normseite.pdf"
      ;;
    horror)
      build_pdf "PDF Horror A5" "tools/templates/horror_a5.tex" "null-protokoll_horror.pdf" "chapter"
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

if ! { [ "$#" -eq 1 ] && [[ "$1" =~ ^(-h|--help|help)$ ]]; }; then
  run_wordcount
fi

echo "=== Building: $* ==="
for target in "$@"; do
  run_target "$target"
done

echo "=== Done → $OUT_DIR/ ==="
