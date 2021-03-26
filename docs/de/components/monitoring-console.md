# nscale Monitoring Console

## Lizenzierung

Diese Komponente benötigt eine lokale Lizenzdatei.
Die Datei wird im Container hier erwartet: `/opt/ceyoniq/nscale-monitoring/workspace/license.xml`.

## Persistierung

Um zu gewährleisten, dass Sie nach dem Herunterfahren des Systems weiterhin Zugriff auf Ihre Daten haben, sorgen Sie für eine Persistierung des Ordners
`/opt/ceyoniq/nscale-monitoring/workspace`.

## Konfiguration

nscale Monitoring Console wird über nscale Administrator konfiguriert indem neue Komponenten zur Überwachung eingebunden werden.
Diese Ressourcen müssen in nscale Administrator bereits bekannt sein, um aufgenommen zu werden.

Dabei ist zu beachten, dass nscale Administrator die nscale-Komponenten über das Hostnetzwerk erreicht, während nscale Monitoring Console im eigenen Compose Netzwerk bzw. Kubernetes Namespace mit den übrigen nscale Komponenten läuft.
Dadurch wird es notwendig, dass Sie in der Konfiguration der Komponenten den Hostname aus Sicht von nscale Monitoring Console nachträglich anpassen.
Diese Änderungen können Sie in nscale Administrator im Knoten `"Rechnername">Monitoring Console>Konfiguration>Ressourcen` vornehmen.
Bearbeiten Sie dazu den Hostname aller Komponenten.

Erst nach dem Anpassen der Verbindung zu den nscale-Ressourcen werden alle Sensoren erkannt, die nscale Monitoring Console ansprechen kann.

## Umgebungsvariablen

>Die hier aufgeführte Liste der Umgebungsvariablen ist **vollständig**.

|Umgebungsvariable | Effekt |
|---|---|
|MC_APPENDER=Console | Wenn Sie diese Umgebungsvariable verwenden, werden die Logs auf die Console im Container ausgegeben. |
|MC_PASSWORD=admin | Überschreibt das admin Passwort für die Monitoring Console. |
|SOCKET_PORT=8387|Sie können den HTTP-Port der Web-Anwendung von nscale Monitoring Console festlegen.|
|SSL_ACTIVE=false|Sie können die Verwendung von HTTPS aktivieren bzw. deaktivieren.|
|SSL_PORT=8388|Sie können den HTTPS-Port der Web-Anwendung von nscale Monitoring Console festlegen.|
|SOCKET_TIMEOUT=60|Sie können die maximale Requestdauer in Sekunden festlegen. Wenn  nscale Monitoring Console nach Ablaufen der Zeit keine Antwort erhalten hat, wird der Request abgebrochen. |
|RMI_ACTIVE=false|Sie können RMI aktivieren. Dadurch machen Sie die Java Monitoring Schnittstelle (JMX) auch remote verfügbar.  **Aus Sicherheitsgründen raten wir von der Verwendung von RMI ab.**|
|RMI_PORT=8386|Sie können den RMI Port festlegen. Dadurch erhalten Sie Remote-Zugriff über "service:jmx:rmi://hostname:8389/jndi/rmi://hostname:8389/jmxrmi".  **Aus Sicherheitsgründen raten wir von der Verwendung von RMI ab.**|

## Ports

* 8086
* 8087

## Start

```bash
docker run \
  -e MC_APPENDER=Console \
  -p 8387:8387 \
  -h democontainer \
  -v $(pwd)/workspace:/opt/ceyoniq/nscale-monitoring/workspace \
  -v $(pwd)/license.xml:/opt/ceyoniq/nscale-monitoring/workspace/license.xml \
  nscale/monitoring-console
```

## Passwörter

Passwörter für den administrativen Zugriff auf die Monitoring Console werden verschlüsselt im Workspace hinterlegt.
Zur Benutzerverwaltung können Sie folgendes Kommando verwenden:

```bash
java -jar lib/mc-cmdclient.jar PASSWD --user admin --password <phrase> 
```
