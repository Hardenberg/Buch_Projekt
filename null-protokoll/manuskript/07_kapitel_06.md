# Kapitel 6 – Ein Prozess ohne PID

Die CPU-Auslastung sprang um 02:03 Uhr auf dreiundachtzig Prozent.
Kein Nutzer angemeldet. Keine geplanten Jobs. Kein Wartungsfenster.

Jonas öffnete top.
Kein Prozess erklärte die Last. Die Summe aller sichtbaren Threads lag bei einundzwanzig Prozent.

Er prüfte die Kernel-Logs.

Um 02:02:58 meldete das System: idle state entered.
Um 02:03:01 begann laut Monitoring die Auslastung.

Drei Sekunden, in denen nichts lief.
Und dennoch etwas arbeitete.

Er aktivierte Debug-Level-Logging.
Die Zeitstempel widersprachen sich.

Der Kernel behauptete, inaktiv zu sein.
Die Hardware zeigte das Gegenteil.

Die Maschine verbrauchte Energie.

Aber nichts führte sie aus.
