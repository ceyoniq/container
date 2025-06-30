# nscale WebDAV-Connector

## Inhalt

- [nscale WebDAV-Connector](#nscale-webdav-connector)
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
|WEBDAV_AL_HOST=localhost |Sie müssen den Namen oder die IP-Adresse des Containers angeben, über den nscale Server Application Layer erreichbar ist, um eine Verbindung aufzubauen.|
|WEBDAV_AL_PORT=8080|Sie können den Port angeben, der verwendet werden soll, um eine Verbindung zu nscale Server Application Layer aufzubauen. Der Standardwert ist "8080".|
|WEBDAV_AL_SSL=false|Sie können festlegen, ob SSL verwendet werden soll, um eine Verbindung zu nscale Server Application Layer aufzubauen. Der Standardwert ist "false".|
|WEBDAV_AL_DOMAIN=nscale|Sie können die Domäne für die Anmeldung an nscale Server Application Layer festlegen.|

## Logging in Kubernetes

Um das Log Level im Kubernetes Betrieb zu ändern kann eine ConfigMap verwendet werden. Diese ConfigMap sollte die Log4j 
Konfiguration ```log4j.properties``` aus dem Originalimage enthalten. 
Diese ConfigMap muss auf ```/opt/ceyoniq/nscale-webdav/conf/log4j``` im Container gemappt werden.
Ändert sich die ConfigMap im Cluster wird diese automatisch verteilt und über log4j Mechanismen nach wenigen Minuten in den
Serverprozeß übernommen. Das gilt auch für mehrere Containerinstanzen in einem Deployment.

*Achtung:* Die ConfigMap muss auf ein Verzeichnis gemappt werden. Die Verwendung von subPath im Volume Mount verhindert eine automatische Aktualiserung bei Änderungen der ConfigMap!

## Ports

- 8088
- 8488

## Start mit Docker

```bash
docker run --rm \
  --network=host \
  -e WEBDAV_AL_HOST=application-layer \
  -e WEBDAV_AL_PORT=8080 \
  -e WEBDAV_AL_SSL=false \
  -e WEBDAV_AL_DOMAIN=nscale \
  ceyoniq.azurecr.io/release/nscale/webdav-connector:ubi.10.0.1300.2025062316
```
