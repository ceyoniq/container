# nscale Process Automation Modeler

## Inhalt

- [nscale Process Automation Modeler](#nscale-process-automation-modeler)
  - [Inhalt](#inhalt)
  - [Lizenzierung](#lizenzierung)
  - [Persistierung](#persistierung)
  - [Umgebungsvariablen](#umgebungsvariablen)
  - [SSL Verschlüsselung](#ssl-verschlüsselung)
  - [Ports](#ports)
  - [Start mit Docker](#start-mit-docker)

## Lizenzierung

Diese Komponente benötigt keine lokale Lizenzdatei. Die nötigen Lizenz Optionen werden im nscale Application Layer ausgewertet.

## Persistierung

Diese Komponente benötigt keine Persistierung. Das BPMN Modell wird im nscale Application Layer gespeichert.

## Umgebungsvariablen

> Die hier aufgeführte Liste der Umgebungsvariablen ist nicht **vollständig**.

|Umgebungsvariable | Effekt |
|---|---|
|NSCALE_HOST=application-layer |Sie müssen den Namen oder die IP-Adresse des Containers angeben, über den der nscale Server Application Layer erreichbar ist, um eine Verbindung aufzubauen.|
|NSCALE_PORT=8080 | Sie können den Port des Application Layer Servers angeben, um eine Verbindung aufzubauen. Der Standardwert ist "8080".|
|NSCALE_INSTANCE=nscalealinst1 |Sie können die Application Layer Instanz für den Anmeldeversuch am nscale Server Application Layer auswählen. Dies ist nur nötig, wenn Sie mehrere nscale Server Application Layer Instanzen installiert haben.|
|NSCALE_SSL=false | Sie können festelgen, ob SSL verwendet werden soll, um eine Verbindung aufzubauen. Der Standardwert ist "false". |

## SSL Verschlüsselung

Diese Komponente unterstützt derzeit keine Verschlüsselung.

Um den Zugriff auf den nscale Process Automation Modeler zu schützen sollte ein Proxy Server verwendet werden.

## Ports

- 8092 (unverschlüsselt)

## Start mit Docker

```bash
docker run --rm \
  --network=host \
  -e NSCALE_HOST=application-layer \
  -e NSCALE_PORT=8080 \
  -e NSCALE_INSTANCE=nscalealinst1 \
  ceyoniq.azurecr.io/release/nscale/process-automation-modeler:ubi.9.2.1500.49636
```
