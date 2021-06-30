# nscale Rendition Server

## Inhalt

- [nscale Rendition Server](#nscale-rendition-server)
  - [Inhalt](#inhalt)
  - [Lizenzierung](#lizenzierung)
  - [Persistierung](#persistierung)
  - [Umgebungsvariablen](#umgebungsvariablen)
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
`/opt/ceyoniq/nscale-rendition-server/share`.

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

## Ports

- 8192
- 8193

## Start mit Docker

```bash
docker run \
  -e RSX_APPENDER=Console \
  -p 8192:8192 \
  -h democontainer \
  -v $(pwd)/share:/opt/ceyoniq/nscale-rendition-server/share \
  -v $(pwd)/license.xml:/opt/ceyoniq/nscale-rendition-server/conf/license.xml \
  ceyoniq.azurecr.io/release/nscale/rendition-server:8.0.5300.2021062118.898632778901
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

**Beispiel Docker:**

```bash
docker run ... -v ${PWD}/fonts:/usr/share/fonts/truetype/msttcorefont ceyoniq.azurecr.io/release/nscale/application-layer:8.0.5301.2021062421.129368058850
```

**Beispiel Docker-Compose:**

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
