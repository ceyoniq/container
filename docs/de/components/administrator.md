# nscale Console

## Inhalt

- [nscale Console](#nscale-console)
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

>Die hier aufgeführte Liste der Umgebungsvariablen ist nicht **vollständig**.

|Umgebungsvariable | Effekt |
|---|---|
|APPLICATION_LAYER_HOST=application-layer |Sie müssen den Namen oder die IP-Adresse des Containers angeben, über den der nscale Server Application Layer erreichbar ist, um eine Verbindung aufzubauen.|
|APPLICATION_LAYER_PORT=8080 | Sie können den Port des Application Layer Servers angeben, um eine Verbindung aufzubauen. Der Standardwert ist "8080".|
|APPLICATION_LAYER_INSTANCE=nscalealinst1 |Sie können die Application Layer Instanz für den Anmeldeversuch am nscale Server Application Layer auswählen. Dies ist nur nötig, wenn Sie mehrere nscale Server Application Layer Instanzen installiert haben.|

## Ports

- 8080

## Start mit Docker

```bash
docker run \
   -e HostName=application-layer \
   -e Port=8080 \
   -e ALInstance=nscalealinst1 \
   -e JAVA_OPTIONS=-Dorg.eclipse.rap.rwt.settingStoreFactory=settings-per-user -Duser.language=de\
   -p 8181:8080 \
   cceyoniq.azurecr.io/release/nscale/administrator:8.1.1101.2021102719.31692038141
```
