# Limitierungen

In dieser Datei finden Sie eine Auflistung aller Limitierungen und Einschränkungen bezüglich dem Einsatz von nscale Standard Container.

## Monitoring Console

nscale Monitoring Console erreicht über das interne Docker-Compose bzw. Kubernetes Netzwerk die anderen nscale Container zur Überwachung.
Die Konfiguration der Monitoring Ressourcen erfolgt über nscale Administrator ausserhalb dieses Netzwerk über den Host.
Deshalb sind nach der Aufnahme der Ressourcen über nscale Administrator die Hostnamen der zu überwachenden Komponenten anzupassen.
Nur so ist nscale Monitoring Console in der Lage die Komponenten zu erreichen und damit auch die Liste der bekannten Sensoren aufzulösen.

nscale Monitoring Console Ressourcen müssen in nscale Administrator in mehreren manuellen Schritten konfiguriert werden.

## Console

### Plug-ins

|Plug-in | Verfügbarkeit|
|---|---|
|Benutzerverwaltung |verfügbar|
|Konfiguration|nicht verfügbar|
|Mail|nicht verfügbar|
|Navigator|verfügbar|
|nstore|verfügbar|
|Partitionen|nicht verfügbar|
|Willkommen & Information|verfügbar|
|eGov Administration |verfügbar|
|AdminType|verfügbar|

### Funktionen

Es steht die Funktion "Kennwortänderung zur Verfügung.
Mit dieser Funktion können Sie das Passwort des angemeldeten Benutzers ändern.
Beachten Sie dabei, dass sich lediglich das Passwort für nscale Console ändert.
Die anderen Komponenten sind nicht von dieser Kennwortänderung betroffen.
