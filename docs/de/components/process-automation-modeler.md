# nscale Process Automation Modeler

## Inhalt

- [nscale Process Automation Modeler](#nscale-process-automation-modeler)
  - [Inhalt](#inhalt)
  - [Lizenzierung](#lizenzierung)
  - [Persistierung](#persistierung)
  - [Umgebungsvariablen](#umgebungsvariablen)
  - [SSL Verschlüsselung](#ssl-verschlüsselung)
  - [Logging](#logging)
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
|NAPPL_HOST=application-layer |Sie müssen den Namen oder die IP-Adresse des Containers angeben, über den der nscale Server Application Layer erreichbar ist, um eine Verbindung aufzubauen.|
|NAPPL_PORT=8080 | Sie können den Port des Application Layer Servers angeben, um eine Verbindung aufzubauen. Der Standardwert ist "8080".|
|NAPPL_INSTANCE=nscalealinst1 |Sie können die Application Layer Instanz für den Anmeldeversuch am nscale Server Application Layer auswählen. Dies ist nur nötig, wenn Sie mehrere nscale Server Application Layer Instanzen installiert haben.|
|NAPPL_SSL=false | Sie können festelgen, ob SSL verwendet werden soll, um eine Verbindung aufzubauen. Der Standardwert ist "false". |
|DEBUG=false | Zusätzliche logging Ausgaben auf der Console. Der Standardwert ist "false". |

## SSL Verschlüsselung

Diese Komponente unterstützt derzeit keine Verschlüsselung.

Um den Zugriff auf den nscale Process Automation Modeler zu schützen sollte ein Proxy Server verwendet werden.

## Logging

Das Log Level wird
Das Logging wird in der Datei `/var/lib/jetty/webapps/rapadm/WEB-INF/log4j2.xml` konfiguriert und kann an dieser Stelle in den Container gemountet werden.

## Ports

- 8082 (unverschlüsselt)

## Start mit Docker

```bash
docker run \
   -e NAPPL_HOST=application-layer \
   -e NAPPL_PORT=8080 \
   -e NAPPL_INSTANCE=nscalealinst1 \
   -p 8082:8082 \
   ceyoniq.azurecr.io/release/nscale/process-automation-modeler:9.0.1000.2022032811.0
```