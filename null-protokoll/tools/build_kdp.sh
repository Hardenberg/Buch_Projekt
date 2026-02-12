#!/usr/bin/env bash
set -euo pipefail
OUT_DIR="export"
mkdir -p "$OUT_DIR"
INPUTS=(manuskript/*.md)

pandoc "${INPUTS[@]}" \
  --pdf-engine=xelatex \
  --template=tools/templates/kdp_6x9.tex \
  -o "$OUT_DIR/null-protokoll_kdp.pdf"

echo "OK → $OUT_DIR/null-protokoll_kdp.pdf"
