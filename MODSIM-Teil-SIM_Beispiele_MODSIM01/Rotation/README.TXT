TU-Dresden, Institut für Automatisierungstechnik
9.12.1997-T. Boge /  4.10.2002-K.Janschek


Arbeiten mit der Simulation der Lagedynamik eines festen Körpers
----------------------------------------------------------------

1. Installation und Bedienung
-----------------------------

Dateien befinden sich in folgendem Verzeichnis:
..\So1\Rotation\..

Kopieren dieses Verzeichnis in das Matlab-Arbeitsverzeichnis.

In den Dateien

	para_mod.m
	para_ablauf.m
	para_numint.m 

können alle notwendigen Parameter zur Lageberechnung vorgegeben werden.

Start der Simulation:

	Aufruf im Matlab-Command-Window: > sim_ablauf

	Anzeige der Simulationsergebnisse im Plot-Window


2. Übersicht über das Simulationspaket
--------------------------------------

In der Datei "sysmodel.m" erfolgt die Simulation der Lagedynamik
(Eulergleichung) und der Lagekinematik (vereinfachte 
Quaternionendifferentialgleichung). Die gesammte Lageberechnung für einen 
Schritt erfolgt in der Datei "numint.m".

In "plotxyz.m" erfolgt die Anzeige der Lage in 3D-Darstellung (bewegter Body-Frame).

Die Simulation wird in "sim_ablauf.m" ausgeführt.

Die Parameter können wie oben beschrieben in den Parameterdateien eingestellt werden.


Viel Erfolg 
Boge