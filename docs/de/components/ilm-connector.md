# nscale ERP Connector ILM

## Inhalt

- [nscale ERP Connector ILM](#nscale-erp-connector-ilm)
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
|ILM_AL_HOST=localhost|Sie müssen den Namen oder die IP-Adresse des Containers angeben, über den der nscale Server Application Layer erreichbar ist, um eine Verbindung aufzubauen.|
|ILM_AL_PORT=8080|Sie können den Port angeben, der verwendet werden soll, um eine Verbindung zu nscale Server Application Layer aufzubauen. Der Standardwert ist "8080".|
|ILM_AL_SSL=false|Sie können festlegen, ob SSL verwendet werden soll, um eine Verbindung zu nscale Server Application Layer aufzubauen. Der Standardwert ist "false".|
|ILM_AL_DOMAIN=nscale|Sie können die Domäne für die Anmeldung an nscale Server Application Layer festlegen.|

## Ports

- 8297
- 8397

## Start mit Docker

```bash
docker run -it \
--network nscale_nscale \
-p 8297:8297 \
-e ILM_AL_HOST=application-layer \
-e ILM_AL_PORT=8080 \
-e ILM_AL_SSL=false \
-e ILM_AL_DOMAIN=nscale \
nscale/ilm-connector:8.0.5000.2021032309.87912327506
```
