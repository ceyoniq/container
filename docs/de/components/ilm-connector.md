# nscale ERP Connector ILM

## Lizenzierung und Persistierung

Die Lizenzierung von nscale ERP Connector ILM erfolgt im nscale Server Application Layer. Für den Betrieb von nscale ERP Connector ILM ist es nicht nötig Dateien zu Persistieren.

## Umgebungsvariablen

>Die hier aufgeführte Liste der Umgebungsvariablen ist **vollständig**.

|Umgebungsvariable | Effekt |
|----|---|
|ILM_AL_HOST=localhost|Sie müssen den Namen oder die IP-Adresse des Containers angeben, über den der nscale Server Application Layer erreichbar ist, um eine Verbindung aufzubauen.|
|ILM_AL_PORT=8080|Sie können den Port angeben, der verwendet werden soll, um eine Verbindung zu nscale Server Application Layer aufzubauen. Der Standradwert ist "8080".|
|ILM_AL_SSL=false|Sie können festlegen, ob SSL verwendet werden soll, um eine Verbindung zu nscale Server Application Layer aufzubauen. Der Standardwert ist "false".|
|ILM_AL_DOMAIN=nscale|Sie können die Domäne  Domain für die Anmeldung an nscale Server Application Layer festlegen.|

## Ports

+ 8297
+ 8397

## Start

```bash
docker run -it \
--network nscale_nscale \
-p 8297:8297 \
-e ILM_AL_HOST=application-layer \
-e ILM_AL_PORT=8080 \
-e ILM_AL_SSL=false \
-e ILM_AL_DOMAIN=nscale \
ceyoniq.azurecr.io/nscale/ilm-connector:8.0
```

## Test Service

```bash
curl -v -X PROPFIND -u admin:admin http://localhost:8297/sap_ilm/nscalealinst1/DA/public

```
