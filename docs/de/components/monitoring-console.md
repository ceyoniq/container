# nscale Monitoring Console

## Inhalt

- [nscale Monitoring Console](#nscale-monitoring-console)
  - [Inhalt](#inhalt)
  - [Lizenzierung](#lizenzierung)
  - [Persistierung](#persistierung)
  - [Konfiguration](#konfiguration)
  - [Umgebungsvariablen](#umgebungsvariablen)
  - [Ports](#ports)
  - [Start mit Docker](#start-mit-docker)
  - [Passwörter](#passwörter)

## Lizenzierung

Diese Komponente benötigt eine lokale Lizenzdatei.
Die Datei wird im Container hier erwartet: `/opt/ceyoniq/nscale-monitoring/workspace/license.xml`.

## Persistierung

Um zu gewährleisten, dass Sie nach dem Herunterfahren des Systems weiterhin Zugriff auf Ihre Daten haben, sorgen Sie für eine Persistierung des Ordners
`/opt/ceyoniq/nscale-monitoring/workspace`.

## Konfiguration

nscale Monitoring Console wird über nscale Administrator konfiguriert, indem neue Komponenten zur Überwachung eingebunden werden.
Diese Ressourcen müssen in nscale Administrator bereits bekannt sein, um aufgenommen zu werden.

Dabei ist zu beachten, dass nscale Administrator die nscale-Komponenten über das Hostnetzwerk erreicht, während nscale Monitoring Console im eigenen Compose Netzwerk bzw. Kubernetes Namespace mit den übrigen nscale Komponenten läuft.
Dadurch wird es notwendig, dass Sie in der Konfiguration der Komponenten den Hostname aus Sicht von nscale Monitoring Console nachträglich anpassen.
Diese Änderungen können Sie in nscale Administrator im Knoten `"Rechnername" > Monitoring Console > Konfiguration > Ressourcen` vornehmen.
Bearbeiten Sie dazu den Hostname aller Komponenten.

Erst nach dem Anpassen der Verbindung zu den nscale-Ressourcen werden alle Sensoren erkannt, die nscale Monitoring Console ansprechen kann.

## Umgebungsvariablen

>Die hier aufgeführte Liste der Umgebungsvariablen ist **vollständig**.

|Umgebungsvariable | Effekt |
|---|---|
|MC_APPENDER=Console | Wenn Sie diese Umgebungsvariable verwenden, werden die Logs auf die Konsole im Container ausgegeben. |
|MC_PASSWORD=admin | Überschreibt das admin Passwort für die Monitoring Console. |
|SOCKET_PORT=8387|Sie können den HTTP-Port der Web-Anwendung von nscale Monitoring Console festlegen.|
|SSL_ACTIVE=false|Sie können die Verwendung von HTTPS aktivieren bzw. deaktivieren.|
|SSL_PORT=8388|Sie können den HTTPS-Port der Web-Anwendung von nscale Monitoring Console festlegen.|
|SOCKET_TIMEOUT=60|Sie können die maximale Requestdauer in Sekunden festlegen. Wenn nscale Monitoring Console nach Ablauf der Zeit keine Antwort erhalten hat, wird der Request abgebrochen. |
|RMI_ACTIVE=false| Aus Sicherheitsgründen raten wir von der Verwendung von RMI ab. |
|RMI_PORT=8389| Aus Sicherheitsgründen raten wir von der Verwendung von RMI ab. |

## Logging in Kubernetes

Um das Log Level im Kubernetes Betrieb zu ändern kann eine ConfigMap verwendet werden. Diese ConfigMap sollte die Log4j 
Konfiguration ```log4j2.xml``` aus dem Originalimage enthalten. 
Diese ConfigMap muss auf ```/opt/ceyoniq/nscale-monitoring/workspace/log4j``` im Container gemappt werden.
Ändert sich die ConfigMap im Cluster wird diese automatisch verteilt und über log4j Mechanismen nach wenigen Minuten in den
Serverprozeß übernommen. Das gilt auch für mehrere Containerinstanzen in einem Deployment.

*Achtung:* Die ConfigMap muss auf ein Verzeichnis gemappt werden. Die Verwendung von subPath im Volume Mount verhindert eine automatische Aktualiserung bei Änderungen der ConfigMap!

## Ports

- 8387
- 8388

## Start mit Docker

```bash
docker run \
  -e MC_APPENDER=Console \
  -p 8387:8387 \
  -h democontainer \
  -v $(pwd)/workspace:/opt/ceyoniq/nscale-monitoring/workspace \
  -v $(pwd)/license.xml:/opt/ceyoniq/nscale-monitoring/workspace/license.xml \
  ceyoniq.azurecr.io/release/nscale/monitoring-console:8.1.1000.2021091318.133378200302
```

## Passwörter

Passwörter für den administrativen Zugriff auf nscale Monitoring Console werden verschlüsselt im Workspace hinterlegt.
Zur Zugangskontenverwaltung können Sie folgendes Kommando verwenden:

```bash
java -jar lib/mc-cmdclient.jar PASSWD --user admin --password <phrase> 
```
