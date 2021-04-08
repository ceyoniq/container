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

>Die hier aufgeführte Liste der Umgebungsvariablen ist **vollständig**.

|Umgebungsvariable | Effekt |
|---|---|
|HostName=application-layer |Sie müssen den Namen oder die IP-Adresse des Containers angeben, über den der nscale Server Application Layer erreichbar ist, um eine Verbindung aufzubauen.|
|Port=8080 | Sie können den Port des Application Layer Servers angeben, um eine Verbindung aufzubauen. Der Standardwert ist "8080".|
|NAPPL_SSL=false | Sie können festelgen, ob SSL verwendet werden soll, um eine Verbindung aufzubauen. Der Standardwert ist "false". |
|ALInstance=nscalealinst1 |Sie können die Application Layer Instanz für den Anmeldeversuch am nscale Server Application Layer auswählen. Dies ist nur nötig, wenn Sie mehrere nscale Server Application Layer Instanzen installiert haben.|
|AlName=ApplicationLayer |Sie können den Application Layer für den Anmeldeversuch auswählen. Dies ist nur nötig, wenn Sie mehrere nscale Server Application Layer installiert haben.|
|defaultAlInstance=nscalealinst1 |Sie können eine Instanz als Standard für die Anmeldung auswählen. Dies ist nur nötig, wenn Sie mehrere nscale Server Application Layer Instanzen installiert haben.|
|defaultAlName=ApplicationLayer|Sie können einen Application Layer als Standard für die Anmeldung auswählen. Dies ist nur nötig, wenn Sie mehrere nscale Server Application Layer installiert haben.|

## Ports

- 8086
- 8087

## Start mit Docker

```bash
docker run \
   -e HostName=application-layer \
   -e Port=8080 \
   -e ALInstance=nscalealinst1 \
   -p 8086:8086 \
   -e LOG_APPENDER=Console \
   nscale/console:8.0
```
