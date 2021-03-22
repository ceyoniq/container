# nscale Rendition Server

## Lizenzierung

Diese Komponente benötigt eine lokale Lizenzdatei.
Die Datei wird im Container hier erwartet: `/opt/ceyoniq/nscale-rendition-server/conf/license.xml`.

## Persistierung

Um zu gewährleisten, dass Sie nach dem Herunterfahren des Systems weiterhin Zugriff auf Ihre Daten haben, sorgen Sie für eine Persistierung Sie der Ordner
`/opt/ceyoniq/nscale-rendition-server/share`.

## Umgebungsvariablen

>Die hier aufgeführte Liste der Umgebungsvariablen ist **vollständig**.

|Umgebungsvariable | Effekt |
|---|---|
|RSX_APPENDER=Console | Wenn Sie diese Umgebungsvariable verwenden, werden die Logs auf die Console im Container ausgegeben. |
|RSX_PASSWORD=admin | Überschreibt das admin Passwort für den Rendition Server. |
|ENV_WORKDIR=<"path">|Sie können das Arbeitsverzeichnis ändern. Standard ist "<"InstallDir">/workspace".|
|SOCKET_PORT=8192| Sie können den HTTP-Port der Web-Anwendung festlegen.|
|SOCKET_TIMEOUT=120|Sie können die maximale Requestdauer in Sekunden festlegen. Wenn nscale Rendition Server nach Ablaufen der Zeit keine Antwort erhalten hat, wird der Request abgebrochen.|
|SSL_ACTIVE=true|Sie können SSL aktivieren bzw. deaktivieren.|
|SSL_PORT=8193|Sie können den HTTPS-Port für die Web-Anwendung festlegen.|
|RMI_ACTIVE=false|Sie können RMI aktivieren. Dadurch ermöglichen Sie den Remote-Zugriff auf die Java Monitoring Schnittstelle (JMX). **Aus Sicherheitsgründen raten wir von der Verwendung von RMI ab.**|
|RMI_PORT=8194|Sie können den RMI-Port festlegen. So erhalten Sie Remote-Zugriff über "service:jmx:rmi://hostname: 8194/jndi/rmi://hostname: 8194/jmxrmi". **Aus Sicherheitsgründen raten wir von der Verwendung von RMI ab.** |

## Ports

* 8192
* 8193

## Start

```bash
docker run \
  -e RSX_APPENDER=Console \
  -p 8192:8192 \
  -h democontainer \
  -v $(pwd)/share:/opt/ceyoniq/nscale-rendition-server/share \
  -v $(pwd)/license.xml:/opt/ceyoniq/nscale-rendition-server/conf/license.xml \
  nscale/rendition-server
```

## Passwörter

Das Passwörter für den administrativen Zugriff auf den Rendition Server ist in der Datei
`/opt/ceyoniq/nscale-rendition-server/conf/rendition-server.users` hinterlegt.
Zum Anlegen eines neuen Benutzers verwenden Sie folgendes Kommando:

```bash
echo PASSWORD=$( java -jar ./lib/rms-api-*.jar -e newpassword ) 
echo "admin=$PASSWORD" > conf/rendition-server.users
```
