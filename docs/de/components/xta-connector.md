# nscale XTA-Connector

## Inhalt

- [nscale XTA-Connector](#nscale-xta-connector)
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
|XTA_AL_HOST=localhost |Sie müssen den Namen oder die IP-Adresse des Containers angeben, über den nscale Server Application Layer erreichbar ist, um eine Verbindung aufzubauen.|
|XTA_AL_PORT=8080|Sie können den Port angeben, der verwendet werden soll, um eine Verbindung zu nscale Server Application Layer aufzubauen. Der Standardwert ist "8080".|
|XTA_AL_SSL=false|Sie können festlegen, ob SSL verwendet werden soll, um eine Verbindung zu nscale Server Application Layer aufzubauen. Der Standardwert ist "false".|
|XTA_AL_DOMAIN=nscale|Sie können die Domäne für die Anmeldung an nscale Server Application Layer festlegen.|
|XTA_AL_DOCAREA=DA|Application Layer Document Area.|
|XTA_AL_INSTANCE=nscalealinst1|Application Layer Instance.|
|XTA_AL_USER=|Application Layer Account name.|
|XTA_AL_PASSWORD=|Application Layer Account password.|
|XTA_AL_FOLDERQUERY=|Zielordner in nscale.|

## Logging in Kubernetes

Um das Log Level im Kubernetes Betrieb zu ändern kann eine ConfigMap verwendet werden. Diese ConfigMap sollte die Log4j 
Konfiguration ```log4j.properties``` aus dem Originalimage enthalten. 
Diese ConfigMap muss auf ```/opt/ceyoniq/nscale-xta-connector/conf/log4j``` im Container gemappt werden.
Ändert sich die ConfigMap im Cluster wird diese automatisch verteilt und über log4j Mechanismen nach wenigen Minuten in den
Serverprozeß übernommen. Das gilt auch für mehrere Containerinstanzen in einem Deployment.

*Achtung:* Die ConfigMap muss auf ein Verzeichnis gemappt werden. Die Verwendung von subPath im Volume Mount verhindert eine automatische Aktualiserung bei Änderungen der ConfigMap!

## Ports

- 8099
- 8199

## Start mit Docker

```bash
docker run -it \
--network nscale_nscale \
-p 8099:8099 \
-e XTA_AL_HOST=application-layer \
-e XTA_AL_PORT=8080 \
-e XTA_AL_SSL=false \
-e XTA_AL_DOMAIN=nscale \
ceyoniq.azurecr.io/release/nscale/xta-connector:8.4.1001.2022091517
```
