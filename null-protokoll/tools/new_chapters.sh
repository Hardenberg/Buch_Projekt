#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
MANU_DIR="$ROOT_DIR/manuskript"

mkdir -p "$MANU_DIR"

# Kapitelnummerierung startet bei 01 (00_meta.md bleibt separat)
CHAPTERS=(
  "Anflug auf Sektor N-17"
  "Integritätsverletzung ohne Ursprung"
  "Hashwerte, die sich erinnern"
  "Die erste Korrektur"
  "Airgap-Paradoxon"
  "Ein Prozess ohne PID"
  "Redundanzfehler in perfekter Symmetrie"
  "Das Rauschen wird kohärent"
  "Negativer Zeitstempel"
  "Stromverbrauch im Primzahlrhythmus"
  "Ungeplante Replikation"
  "Die Sequenz in der Kühlung"
  "Firmware ohne Commit-Historie"
  "Die Plattform reagiert voraus"
  "Das Archiv der vergessenen Logs"
  "Ein Muster im EEG"
  "Die Bruchzone unter dem Fundament"
  "Synchronisation mit dem Magnetfeld"
  "Die erste bewusste Antwort"
  "Priorisierung unbekannter Prozesse"
  "Verdichtung"
  "Abschaltprotokoll Null"
  "Persistenz in der Stille"
  "Letzter Ping vor dem Blackout"
  "NULL_PROTO_01.log"
)

# Optional: 00_meta.md anlegen, falls nicht vorhanden
META="$MANU_DIR/00_meta.md"
if [[ ! -f "$META" ]]; then
  cat > "$META" <<'MD'
% Das Null-Protokoll
% Alrik Schnapke
% 2026-02-12
MD
fi

i=1
for title in "${CHAPTERS[@]}"; do
  num=$(printf "%02d" "$i")
  file="$MANU_DIR/${num}_kapitel_${num}.md"

  if [[ -f "$file" ]]; then
    echo "Skip (exists): $(basename "$file")"
  else
    cat > "$file" <<MD
# Kapitel $i – $title

**Kapitelziel:**  
- (Kurz, 1–2 Sätze)

**Handlungspunkte:**  
-  
-  
-  

**Entwurf:**  
MD
    echo "Created: $(basename "$file")"
  fi

  ((i++))
done

echo "Done. Kapiteldateien liegen in: $MANU_DIR"
