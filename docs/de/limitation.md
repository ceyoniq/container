# Limitierungen

In dieser Datei finden Sie eine Auflistung von Limitierungen und Einschränkungen bezüglich dem Einsatz von nscale Standard Container.
Die Grundfunktionalität von nscale unterscheidet sich nicht von einer klassischen Installation ohne Container.
Es besteht allerdings ein Unterschied bei dem Zugriff auf Konfigurationseigenschaften.
Weitere Informationen finden Sie in diesem Dokument.

## Inhalt

- [Limitierungen](#limitierungen)
  - [Inhalt](#inhalt)
  - [RMS](#rms)
  - [nscale Server Application Layer](#nscale-server-application-layer)
  - [nscale Server Application Layer Web](#nscale-server-application-layer-web)
  - [nscale Server Storage Layer](#nscale-server-storage-layer)
  - [nscale Rendition Server](#nscale-rendition-server)
  - [nscale Monitoring Console](#nscale-monitoring-console)
  - [nscale Console](#nscale-console)
    - [Plug-ins](#plug-ins)
    - [Kennwortänderung](#kennwortänderung)
  - [nscale Pipeliner](#nscale-pipeliner)

## RMS

Der nscale RMS (Remote Management Service) steht für die nscale Standard Container nicht zur Verfügung.
Verwenden Sie im nscale Administrator die Funktion "New component group" um nscale Standard Container zu konfigurieren.

![New nscale computer or component group](../images/nscaleAdministratorNewComponentGroup.png)

## nscale Server Application Layer

- Die Offline-Konfiguration (z.B. alle Konfigurationsmerkmale die über die `instance1.conf` gesetzt werden können), ist im nscale Administrator nicht verfügbar.

Weitere Informationen zur nscale Server Application Layer: [components/application-layer.md](components/application-layer.md)

## nscale Server Application Layer Web

- Der nscale Server Application Layer Web kann nicht im nscale Administrator konfiguriert werden.  

Weitere Informationen zur nscale Server Application Layer Web: [components/application-layer-web.md](components/application-layer-web.md)

## nscale Server Storage Layer

- Die Offline-Konfiguration (alle Konfigurationsmerkmale die über die `storagelayer.conf` gesetzt werden können), ist im nscale Administrator nicht  verfügbar.

Weitere Informationen zum nscale Server Storage Layer: [components/storage-layer.md](components/storage-layer.md)

## nscale Rendition Server

- Die Offline-Konfiguration, ist im nscale Administrator nicht verfügbar.
- Das Password kann nicht über den nscale Administrator gesetzt werden
- Der Port kann nicht über den nscale Administrator gesetzt werden

Weitere Informationen zum nscale Rendition Server: [components/rendition-server.md](components/rendition-server.md)

## nscale Monitoring Console

- Die Offline-Konfiguration, ist im nscale Administrator nicht verfügbar.
- Das Password kann nicht über den nscale Administrator gesetzt werden
- Im nscale Administrator sind die nscale-Komponenten über das Hostnetzwerk erreichbar, während die nscale Monitoring Console im eigenen Compose Netzwerk bzw. Kubernetes Namespace mit den übrigen nscale Komponenten nicht über das Hostnetzwerk kommunizieren.
Dadurch wird es notwendig, dass Sie in der Konfiguration der Komponenten den Hostname aus Sicht von nscale Monitoring Console nachträglich anpassen.
Diese Änderungen können Sie in nscale Administrator im Knoten *Rechnername*>Monitoring Console>Konfiguration>Ressourcen vornehmen.
Bearbeiten Sie dazu den Hostname aller Komponenten.

Weitere Informationen zur nscale Console: [components/monitoring-console.md](components/monitoring-console.md)

## nscale Console

- Die Offline-Konfiguration, ist im nscale Administrator nicht verfügbar.

Weitere Informationen zur nscale Console: [components/console.md](components/console.md)

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

### Kennwortänderung

Es steht die Funktion "Kennwortänderung" zur Verfügung.
Mit dieser Funktion können Sie das Passwort des angemeldeten Benutzers bzw. der Benutzerin ändern.
Beachten Sie dabei, dass sich lediglich das Passwort für nscale Console ändert.
Die anderen Komponenten sind nicht von dieser Kennwortänderung betroffen.

## nscale Pipeliner

Die Offline-Konfiguration (alle Konfigurationsmerkmale die über die `cold.xml` gesetzt werden können),
ist im nscale Administrator nicht mehr verfügbar.

Weiter Information zum nscale Pipeliner: [components/pipeliner.md](components/pipeliner.md)
