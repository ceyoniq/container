# nscale Server Application Layer Web

## Inhalt

- [nscale Server Application Layer Web](#nscale-server-application-layer-web)
  - [Inhalt](#inhalt)
  - [Lizenzierung](#lizenzierung)
  - [Persistierung](#persistierung)
  - [Umgebungsvariablen](#umgebungsvariablen)
  - [Logging in Kubernetes](#logging-in-kubernetes)
  - [Ports](#ports)
  - [Start mit Docker](#start-mit-docker)
  - [Information für Entwickler](#information-für-entwickler)
    - [Vorbereitung](#vorbereitung)
    - [Die Datei `nscale_web_plugins.xml` erstellen](#die-datei-nscale_web_pluginsxml-erstellen)
    - [Das Kontextmenü anpassen](#das-kontextmenü-anpassen)
    - [Die Datei `nscale_web.xml` anpassen](#die-datei-nscale_webxml-anpassen)
    - [Inbetriebnahme](#inbetriebnahme)
      - [Beispiel Docker Compose](#beispiel-docker-compose)

## Lizenzierung

Diese Komponente benötigt keine lokale Lizenzdatei.

## Persistierung

Diese Komponente benötigt keine Persistierung.

## Umgebungsvariablen

>Die hier aufgeführte Liste der Umgebungsvariablen ist **nicht vollständig**.
Sie bildet lediglich die in unseren Beispielkonfigurationen verwendeten Umgebungsvariablen ab.

Die Benennung der Umgebungsvariablen von nscale Server Application Layer Web folgt einem Schema, das wir für Sie im nscale Server Application Layer Web Administrationshandbuch zusammengefasst haben.
So können Sie auch alle anderen in der Dokumentation beschriebenen Einstellungen vornehmen.
Die gesamte nscale-Dokumentation finden Sie in unserem Serviceportal unter <https://serviceportal.ceyoniq.com>.

|Umgebungsvariable | Effekt |
|---|---|
|NSCALE_HOST=application-layer | Hier können Sie den logischen Hostname des Application Layer Servers aus der Sicht des Application Layer Web angeben. |
|NSCALE_PORT=8080 | In dieser Umgebungsvariable können Sie den Port angeben, über den auf den nscale Server Application Layer zugegriffen werden kann. Der Standardwert ist "8080". |
|NSCALE_INSTANCE=nscalealinst1 | In dieser Umgebungsvariable können Sie eine nscale Instanz benennen. Der Standard ist "nscalealinst1". |
|NSCALE_SSL=false |Sie können festlegen, ob SSL verwendet werden soll. Der Standardwert ist "false". |
|LOG4JCONFIGLOCATION=../conf/nscale_stdout_log_conf.xml | In dieser Umgebungsvariable können Sie den Pfad zur Konfigurationsdatei für das Logging angeben. |
## Logging in Kubernetes

Um das Log Level im Kubernetes Betrieb zu ändern kann eine ConfigMap verwendet werden. Diese ConfigMap sollte die Log4j 
Konfiguration aus dem Originalimage enthalten. Wird diese ConfigMap als Volume auf ein Verzeichnis gemappt
muss über die oben beschriebene Umgebungsvariable ```LOG4JCONFIGLOCATION``` die neue Datei referenziert werden.
Ändert sich die ConfigMap im Cluster wird diese automatisch verteilt und über log4j Mechanismen nach wenigen Minuten in den
Serverprozeß übernommen. Das gilt auch für mehrere Containerinstanzen in einem Deployment.

*Achtung:* Die ConfigMap muss auf ein Verzeichnis gemappt werden. Die Verwendung von subPath im Volume Mount verhindert eine automatische Aktualiserung bei Änderungen der ConfigMap!

## Ports

- 8090
- 8453

## Start mit Docker

```bash
docker run --rm \
  --network=host \
  -e NSCALE_HOST=application-layer \
  -e LOG4JCONFIGLOCATION=../conf/nscale_stdout_log_conf.xml \
  -e NSCALE_PORT=8080 \
  ceyoniq.azurecr.io/release/nscale/application-layer-web:ubi.9.3.1300.2024121620
```

## Information für Entwickler

Wenn Sie z. B. eigene Plug-ins für nscale Server Application Layer Web entwickeln wollen,  
können Sie das mit nscale Standard Container umsetzen.  

In diesem Beispiel werden ein Plug-in, eine Änderung am Kontextmenü und Anpassungen an den Icons demonstriert.  
Es wird davon ausgegangen, dass Sie bereits die Datei `myplugin.jar` und die Datei `myicons.jar` erstellt haben.

>Weitere Informationen zu den jeweiligen SDKs entnehmen Sie bitte den entsprechenden Dokumentationen.

### Vorbereitung

Um Anpassungen vornehmen zu können, benötigen Sie auf Ihrem Entwicklungssystem diverse Dateien.  
Diese Dateien können Sie dem Image `nscale/application-layer-web` entnehmen.

Kopieren Sie die Datei `nscale_web.xml` lokal auf Ihr System:  

```bash
# Erzeugen eines temporären Containers
$ docker create ceyoniq.azurecr.io/release/nscale/application-layer-web:ubi.9.3.1300.2024121620[version]  # Passen Sie bitte diese Version an
a0123456789                                             # Diese ID wird auf Ihrem System eine andere sein

# Kopieren der Datei nscale_web.xml auf Ihr Entwicklungssystem
docker cp a0123456789:/opt/ceyoniq/nscale-server/application-layer-web/conf/nscale_web.xml ./

# Löschen des temporären Containers
docker rm a0123456789
```

### Die Datei `nscale_web_plugins.xml` erstellen

Damit Ihre Plug-ins geladen werden können, benötigen Sie die Datei `nscale_web_plugins.xml`.
Erstellen Sie eine Datei mit folgendem Inhalt:  

```xml
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plugins SYSTEM "plugins.dtd">

<plugins classpath="myicons.jar, myplugin.jar">
 <OemContributions>
  <IconLibrary>
   <Icon id="collection_s" enabled="META-INF/assets/nscale/icons/svg/myicon.svg" />
  </IconLibrary>
 </OemContributions>
 <MenuConfigurator configLocation="menuconfig.xml" />
</plugins>
```

In diesem Beispiel sind nun eine `myplugin.jar` und eine `myicons.jar` als Plug-in konfiguriert.  
Außerdem wurde konfiguriert, dass das Icon `myicon.svg` verwendet werden soll.  
Zusätzlich wurde das Kontextmenü geändert.

### Das Kontextmenü anpassen

```xml
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE menu-specification SYSTEM "menuconfig.dtd">
<menu-specification>
</menu-specification>
```

Erstellen Sie die Datei `menuconfig.xml` und ergänzen Sie Ihre Kontextmenüeinträge.  
> Weitere Informationen zur Konfiguration von nscale Server Application Layer Web finden Sie im Administrationshandbuch von nscale Server Application Layer Web.

### Die Datei `nscale_web.xml` anpassen

Damit die zuvor erstellte Datei  `nscale_web_plugins.xml` verwendet werden kann, müssen Sie die Datei `nscale_web.xml` ändern.  

Führen Sie die folgenden Änderungen innerhalb des `Context`-Tag aus:

```xml
<Loader className="com.ceyoniq.nscale.tomcat.NscalePluginsLoader" pluginsConfigLocation="/opt/ceyoniq/nscale-server/application-layer-web/conf/nscale_web_plugins.xml" />

<Environment
    description="Plugins config location"
    name="pluginsConfigLocation"
    type="java.lang.String"
    value="/opt/ceyoniq/nscale-server/application-layer-web/conf/nscale_web_plugins.xml" />
```

Nun ist die Datei `nscale_web.xml` soweit vorbereitet, dass die Plug-ins geladen werden können.

### Inbetriebnahme

Damit nscale Server Application Layer Web Ihre Konfiguration verarbeiten kann, müssen die zuvor erstellten Dateien im nscale Server Application Layer Web-Container verwendet werden.

Alle Dateien müssen im Container in dem Ordner `/opt/ceyoniq/nscale-server/application-layer-web/conf/` verfügbar gemacht werden.
Dies kann abhängig von der gewählten Technologie durch ein `bind-mount`, ein `volume` oder ein zuvor erstelltes Custom Container-Image erfolgen.

#### Beispiel Docker Compose

Wenn Sie Docker Compose verwenden, können Sie zum Beispiel die Dateien als `bind-mount` konfigurieren.  

```yaml
  application-layer-web:
    ...
    volumes:
      - ./plugin/icons.jar:/opt/ceyoniq/nscale-server/application-layer-web/conf/icons.jar
      - ./plugin/menuconfig.xml:/opt/ceyoniq/nscale-server/application-layer-web/conf/menuconfig.xml
      - ./plugin/myplugin.jar:/opt/ceyoniq/nscale-server/application-layer-web/conf/myplugin.jar
      - ./plugin/nscale_web_plugins.xml:/opt/ceyoniq/nscale-server/application-layer-web/conf/nscale_web_plugins.xml
      - ./plugin/nscale_web.xml:/opt/ceyoniq/nscale-server/application-layer-web/conf/nscale_web.xml
    ...
```
