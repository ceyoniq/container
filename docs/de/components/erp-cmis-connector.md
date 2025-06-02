# nscale ERP CMIS

## Inhalt

- [nscale ERP CMIS](#nscale-erp-cmis)
  - [Inhalt](#inhalt)
  - [Lizenzierung](#lizenzierung)
  - [Persistierung](#persistierung)
  - [Umgebungsvariablen](#umgebungsvariablen)
  - [Logging in Kubernetes](#logging-in-kubernetes)
  - [Ports](#ports)
  - [Start mit Docker](#start-mit-docker)

## Lizenzierung

Diese Komponente benötigt keine lokale Lizenzdatei.

## Persistierung

Diese Komponente benötigt keine Persistierung.

## Umgebungsvariablen

>Die hier aufgeführte Liste der Umgebungsvariablen ist **vollständig**.

|Umgebungsvariable | Effekt |
|----|---|
|CMIS_AL_HOST=localhost|Sie müssen den Namen oder die IP-Adresse des Containers angeben, über den der nscale Server Application Layer erreichbar ist, um eine Verbindung aufzubauen.|
|CMIS_AL_PORT=8080 |Sie können den Port angeben, der verwendet werden soll, um eine Verbindung zu nscale Server Application Layer aufzubauen. Der Standardwert ist "8080".|
|CMIS_AL_SSL=false |Sie können festlegen, ob SSL verwendet werden soll, um eine Verbindung zu nscale Server Application Layer aufzubauen. Der Standardwert ist "false".|
|CMIS_AL_INSTANCE=nscalealinst1 |Sie können die Instanz für den Anmeldeversuch am nscale Server Application Layer auswählen.|
|ERPCMIS_CONTEXT_PATH=/cmis|Es kann ein neuer Context und damit eine andere URL gesetzt werden (Standard: /cmis). Beispiel: ERPCMIS_CONTEXT_PATH = "/foobar" setzt die URL auf den Wert "http://server:port/foobar/browser".
|CONF_VIRUSSCAN_ACTIVE=false|Sie geben hier an, ob ein Virenscanner angeschlossen werden soll.
|CONF_VIRUSSCAN_UNIXSOCK=true|Der Virenscanner kann über Sockets oder Unix Domain Socket angesprochen werden (Standard).
|CONF_VIRUSSCAN_TEMP_FOLDER=/tmp|Für eine Zwischenspeicherung wird ein temporärer Ordner angegeben.
|CONF_VIRUSSCAN_SOCKPATH=/tmp/clamd.sock|Angabe des Unix Domain Socket.
|CONF_VIRUSSCAN_HOST=clamav|Wird kein Unix Domain Socket verwendet, erfolgt die Kommunikation mit dem Virenscanner über eine Socket-Verbindung: Host:Port.
|CONF_VIRUSSCAN_PORT=3310|Port für die Socket-Verbindung.


## Logging in Kubernetes

Um das Log Level im Kubernetes Betrieb zu ändern kann eine ConfigMap verwendet werden. Diese ConfigMap sollte die Log4j 
Konfiguration ```log4j.properties``` aus dem Originalimage enthalten. 
Diese ConfigMap muss auf ```/opt/ceyoniq/nscale-for-sap/erp-cmis/conf/log4j``` im Container gemappt werden.
Ändert sich die ConfigMap im Cluster wird diese automatisch verteilt und über log4j Mechanismen nach wenigen Minuten in den
Serverprozess übernommen. Das gilt auch für mehrere Containerinstanzen in einem Deployment.

*Achtung:* Die ConfigMap muss auf ein Verzeichnis gemappt werden. Die Verwendung von subPath im Volume Mount verhindert eine automatische Aktualisierung bei Änderungen der ConfigMap!

## Ports

- 8096
- 8196

## Start mit Docker

```bash
docker run -it \
  -p 8096:8096 \
  -e CMIS_AL_HOST=application-layer \
  -e CMIS_AL_PORT=8080 \
  -e CMIS_AL_SSL=false \
  -e CMIS_AL_INSTANCE=nscalealinst1 \
  ceyoniq.azurecr.io/release/nscale/erp-cmis-connector:ubi.10.0.1200.2025052810
```