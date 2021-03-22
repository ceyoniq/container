# nscale WebDAV-Connector

## Lizenzierung

Diese Komponente benötigt keine lokale Lizenzdatei.

## Persistierung

Diese Komponente benötigt keine Persistierung.

## Umgebungsvariablen

>Die hier aufgeführte Liste der Umgebungsvariablen ist **vollständig**.

|Umgebungsvariable | Effekt |
|----|---|
|WEBDAV_AL_HOST=localhost |Sie müssen den Namen oder die IP-Adresse des Containers angeben, über den der nscale Server Application Layer erreichbar ist, um eine Verbindung aufzubauen.|
|WEBDAV_AL_PORT=8080|Sie können den Port angeben, der verwendet werden soll, um eine Verbindung zu nscale Server Application Layer aufzubauen. Der Standradwert ist "8080".|
|WEBDAV_AL_SSL=false|Sie können festlegen, ob SSL verwendet werden soll, um eine Verbindung zu nscale Server Application Layer aufzubauen. Der Standardwert ist "false".|
|WEBDAV_AL_DOMAIN=nscale|Sie können die Domäne für die Anmeldung an nscale Server Application Layer festlegen.|

## Ports

- 8088
- 8488

## Start

```bash
docker run -it \
--network nscale_nscale \
-p 8088:8088 \
-e WEBDAV_AL_HOST=application-layer \
-e WEBDAV_AL_PORT=8080 \
-e WEBDAV_AL_SSL=false \
-e WEBDAV_AL_DOMAIN=nscale \
ceyoniq.azurecr.io/nscale/webdav-connector:8.0
```
