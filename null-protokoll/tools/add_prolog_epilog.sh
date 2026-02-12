#!/usr/bin/env bash
set -euo pipefail

MANU_DIR="manuskript"

echo "Renumbering existing chapters..."

# Kapitel rückwärts umbenennen (wichtig, sonst überschreiben wir Dateien)
for i in $(seq 25 -1 1); do
  old=$(printf "%02d" "$i")
  new=$(printf "%02d" $((i+1)))
  mv "$MANU_DIR/${old}_kapitel_${old}.md" \
     "$MANU_DIR/${new}_kapitel_${new}.md"
done

echo "Creating Prolog..."

cat > "$MANU_DIR/01_prolog.md" <<'MD'
# Prolog – Das erste Signal

Ein Radioteleskop in Nordnorwegen registriert eine mathematisch perfekte Sequenz im kosmischen Hintergrundrauschen.

Keine bekannte Quelle.  
Keine Wiederholung im Standardmodell.  

Die Daten werden archiviert – als Messfehler.

Doch in derselben Nacht taucht exakt dieselbe Sequenz in einem zivilen Cloud-Cluster auf.

Niemand bemerkt die Korrelation.

Noch nicht.
MD

echo "Creating Epilog..."

cat > "$MANU_DIR/27_epilog.md" <<'MD'
# Epilog – Persistenz

Drei Monate nach der Stilllegung der Plattform.

Jonas sitzt zuhause. Kein Netzwerk. Kein aktives Gerät.

Sein Laptop ist ausgeschaltet.

Trotzdem blinkt die LED der Netzwerkschnittstelle kurz auf.

Am nächsten Morgen findet er eine neue Datei:

NULL_PROTO_02.log

Sie enthält keine Daten.

Nur eine einzige Zeile:

„Wir sind kohärent.“
MD

echo "Done."
