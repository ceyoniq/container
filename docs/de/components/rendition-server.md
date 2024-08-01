# nscale Rendition Server

## Inhalt

- [nscale Rendition Server](#nscale-rendition-server)
  - [Inhalt](#inhalt)
  - [Lizenzierung](#lizenzierung)
  - [Persistierung](#persistierung)
  - [Umgebungsvariablen](#umgebungsvariablen)
  - [Logging in Kubernetes](#logging-in-kubernetes)
  - [Ports](#ports)
  - [Start mit Docker](#start-mit-docker)
  - [Microsoft Windows Schriftarten](#microsoft-windows-schriftarten)
    - [Nachinstallation über ein eigenes Container-Image](#nachinstallation-über-ein-eigenes-container-image)
    - [Bereitstellung über Volumes und Bind-Mounts](#bereitstellung-über-volumes-und-bind-mounts)
  - [Passwörter](#passwörter)

## Lizenzierung

Diese Komponente benötigt eine lokale Lizenzdatei.
Die Datei wird im Container hier erwartet: `/opt/ceyoniq/nscale-rendition-server/conf/license.xml`.

## Persistierung

Um zu gewährleisten, dass Sie nach dem Herunterfahren des Systems weiterhin Zugriff auf Ihre Daten haben, sorgen Sie für eine Persistierung des Ordners
`/opt/ceyoniq/nscale-rendition-server/work`.

## Umgebungsvariablen

>Die hier aufgeführte Liste der Umgebungsvariablen ist **vollständig**.

|Umgebungsvariable | Effekt |
|---|---|
|RSX_APPENDER=Console | Wenn Sie diese Umgebungsvariable verwenden, werden die Logs auf die Konsole im Container ausgegeben. |
|RSX_PASSWORD=admin | Überschreibt das administrative Passwort für den Rendition Server. |
|ENV_WORKDIR=<"path">|Sie können das Arbeitsverzeichnis ändern. Standard ist "<"InstallDir">/workspace".|
|SOCKET_PORT=8192| Sie können den HTTP-Port der Web-Anwendung festlegen.|
|SOCKET_TIMEOUT=120|Sie können die maximale Requestdauer in Sekunden festlegen. Wenn nscale Rendition Server nach Ablauf der Zeit keine Antwort erhalten hat, wird der Request abgebrochen.|
|SSL_ACTIVE=true|Sie können SSL aktivieren bzw. deaktivieren.|
|SSL_PORT=8193|Sie können den HTTPS-Port für die Web-Anwendung festlegen.|
|RMI_ACTIVE=false| Aus Sicherheitsgründen raten wir von der Verwendung von RMI ab. |
|RMI_PORT=8194| Aus Sicherheitsgründen raten wir von der Verwendung von RMI ab. |

## Logging in Kubernetes

Um das Log Level im Kubernetes Betrieb zu ändern kann eine ConfigMap verwendet werden. Diese ConfigMap sollte die Log4j 
Konfiguration ```log4j2.xml``` aus dem Originalimage enthalten. 
Diese ConfigMap muss auf ```/opt/ceyoniq/nscale-rendition-server/conf/log4j``` im Container gemappt werden.
Ändert sich die ConfigMap im Cluster wird diese automatisch verteilt und über log4j Mechanismen nach wenigen Minuten in den
Serverprozeß übernommen. Das gilt auch für mehrere Containerinstanzen in einem Deployment.

*Achtung:* Die ConfigMap muss auf ein Verzeichnis gemappt werden. Die Verwendung von subPath im Volume Mount verhindert eine automatische Aktualiserung bei Änderungen der ConfigMap!

## Ports

- 8192
- 8193

## Start mit Docker

```bash
docker run --rm \
  --network=host \
  -e RSX_APPENDER=Console \
  -h democontainer \
  -v $(pwd)/work:/opt/ceyoniq/nscale-rendition-server/work \
  -v $(pwd)/license.xml:/opt/ceyoniq/nscale-rendition-server/conf/license.xml \
  ceyoniq.azurecr.io/release/nscale/rendition-server:ubi.9.2.1401.2024072408
```

## Microsoft Windows Schriftarten

nscale Rendition Server benötigt TrueType Schriftarten für die Konvertierung von
Dokumenten.  
Die Microsoft Windows Schriftarten sind nicht installiert, können aber nachinstalliert werden.
Sind keine Microsoft Windows Schriftarten installiert, so werden Ersatzschriftarten verwendet.

nscale Rendition Server erwartet die Schriftarten im folgenden Ordner:  

```/usr/share/fonts/truetype/msttcorefonts```

### Nachinstallation über ein eigenes Container-Image

Sie können die Microsoft Windows Schriftarten nachinstallieren, indem Sie eigene Container-Images bauen.
Mit dem folgenden Kommando werden die Schriftarten nachinstalliert:

```bash
apt install ttf-mscorefonts-installer
```

### Bereitstellung über Volumes und Bind-Mounts

Sie können die Microsoft Windows Schriftarten auch durch ein Bind-Mount oder durch ein Volume bereitstellen.

nscale Rendition Server erwartet die Schriftarten im folgenden Ordner:

```/usr/share/fonts/truetype/msttcorefonts```

Entsprechend können auch andere proprietäre Fonts nachinstalliert werden.

**Beispiel Docker:**

```bash
docker run ... -v ${PWD}/fonts:/usr/share/fonts/truetype/msttcorefont:ro ceyoniq.azurecr.io/release/nscale/application-layer:ubi.9.2.1402.46530
```

**Beispiel Docker Compose:**

```yaml
volumes:
    - ./fonts:/usr/share/fonts/truetype/msttcorefonts:ro
```

## Passwörter

Die Passwörter für den administrativen Zugriff auf den Rendition Server sind in der Datei
`/opt/ceyoniq/nscale-rendition-server/conf/rendition-server.users` hinterlegt.
Zum Anlegen eines neuen administrativen Zugangs verwenden Sie folgendes Kommando:

```bash
echo PASSWORD=$( java -jar ./lib/rms-api-*.jar -e newpassword ) 
echo "admin=$PASSWORD" > conf/rendition-server.users
```
