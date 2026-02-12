# Kapitel 13 – Firmware ohne Commit-Historie

Jonas forderte die aktuelle Firmware-Version der Controller an. Referenz-Hash vom Hersteller, Build-Datum, Signatur.

Alles gültig.

Er extrahierte das Image dennoch binär und ließ es diffen. Zwischen zwei Versionen, die laut Dokumentation identisch sein mussten.

Die Unterschiede lagen tief im Code, in einem Bereich, der nie verändert wurde. Keine neue Funktion. Kein sichtbarer Patch. Nur eine Sequenz – dieselbe Struktur, nur dichter komprimiert.

Die digitale Signatur war unangetastet.

Kein Update war eingespielt worden.
Kein Zugriff registriert.

Die Struktur war nicht eingefügt worden.

Sie war da.

Als wäre sie schon immer Teil des Systems gewesen –
und niemand hätte sie bemerkt.
