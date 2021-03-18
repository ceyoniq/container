# nscale CMIS-Connector

## Lizenzierung und Persistierung

Die Lizenzierung von nscale CMIS-Connector erfolgt im nscale Server Application Layer. Für den Betrieb von nscale CMIS-Connector ist es nicht nötig Dateien zu Persistieren.

## Umgebungsvariablen

>Die hier aufgeführte Liste der Umgebungsvariablen ist **vollständig**.

|Umgebungsvariable | Effekt |
|----|---|
|CMIS_AL_HOST=localhost|Sie müssen den Namen oder die IP-Adresse des Containers angeben, über den der nscale Server Application Layer erreichbar ist, um eine Verbindung aufzubauen.|
|CMIS_AL_PORT=8080 |Sie können den Port angeben, der verwendet werden soll, um eine Verbindung zu nscale Server Application Layer aufzubauen. Der Standradwert ist "8080".|
|CMIS_AL_SSL=false |Sie können festlegen, ob SSL verwendet werden soll, um eine Verbindung zu nscale Server Application Layer  aufzubauen. Der Standardwert ist "false".|
|CMIS_AL_INSTANCE=nscalealinst1 |Sie können die Instanz für den Anmeldeversuch am nscale Server Application Layer auswählen. Dies ist nur nötig, wenn Sie mehrere nscale Server Application Layer Instanzen konfiguriert haben.|

## Ports

* 8096
* 8196

## Start

```bash
docker run -it \
-p 8096:8096 \
-e CMIS_AL_HOST=application-layer \
-e CMIS_AL_PORT=8080 \
-e CMIS_AL_SSL=false \
-e CMIS_AL_INSTANCE=nscalealinst1 \
nscale/cmis-connector:8.0
```

## Test Service

For ATOM-pub:

```bash
curl -v -u admin:admin http://localhost:8096/cmis/atom11
```

For JSON:

```bash
curl -v -u admin:admin http://localhost:8096/cmis/browser
```
