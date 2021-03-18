# nscale Rendition Server

## Lizenzierung

nscale Rendition Server benötigt eine lokale Lizenzdatei.
Hinterlegen Sie diese im Ordner "/opt/ceyoniq/nscale-rendition-server/conf/license.xml".

## Persistierung

Um zu gewährleisten, dass Sie nach dem Herunterfahren des Systems weiterhin Zugriff auf Ihre Daten haben, sorgen Sie für eine Persistierung Sie der Ordner
"/opt/ceyoniq/nscale-rendition-server/share" und
"/opt/ceyoniq/nscale-rendition-server/conf".

## Passwörter

Passwörter für den administrativen Zugriff auf den Rendition Server werden verschlüsselt in der Datei
``/opt/ceyoniq/nscale-rendition-server/conf/rendition-server.users`` hinterlegt.
Zur Verschlüsselung/Entschlüsselung können Sie folgendes Kommando verwenden:

```bash
java -jar ./lib/rms-api-*.jar [-e|-d] <phrase>
```

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
