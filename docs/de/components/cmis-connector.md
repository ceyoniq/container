# nscale CMIS-Connector

## Inhalt

- [nscale CMIS-Connector](#nscale-cmis-connector)
  - [Inhalt](#inhalt)
  - [Lizenzierung](#lizenzierung)
  - [Persistierung](#persistierung)
  - [Umgebungsvariablen](#umgebungsvariablen)
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

## Logging in Kubernetes

Um das Log Level im Kubernetes Betrieb zu ändern kann eine ConfigMap verwendet werden. Diese ConfigMap sollte die Log4j 
Konfiguration ```log4j.properties``` aus dem Originalimage enthalten. 
Diese ConfigMap muss auf ```/opt/ceyoniq/nscale-cmis-connector/conf/log4j``` im Container gemappt werden.
Ändert sich die ConfigMap im Cluster wird diese automatisch verteilt und über log4j Mechanismen nach wenigen Minuten in den
Serverprozeß übernommen. Das gilt auch für mehrere Containerinstanzen in einem Deployment.

*Achtung:* Die ConfigMap muss auf ein Verzeichnis gemappt werden. Die Verwendung von subPath im Volume Mount verhindert eine automatische Aktualiserung bei Änderungen der ConfigMap!

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
ceyoniq.azurecr.io/release/nscale/cmis-connector:8.1.1000.2021090820.133378200302
```
