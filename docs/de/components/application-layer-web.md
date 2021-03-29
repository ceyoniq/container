# nscale Server Application Layer Web

## Lizenzierung

Diese Komponente benötigt keine lokale Lizenzdatei.

## Persistierung

Diese Komponente benötigt keine Persistierung.

## Umgebungsvariablen

>Die hier aufgeführte Liste der Umgebungsvariablen ist **nicht vollständig**.
Sie bildet lediglich die in unseren Beispielkonfigurationen verwendeten Umgebungsvariablen ab.

Die Bennennung der Umgebungsvariablen von nscale Server Application Layer Web folgt einem Schema, das wir für Sie im nscale Server Application Layer Web Administrationshandbuch zusammengefasst haben.
So können Sie auch alle anderen in der Dokumentation beschriebenen Einstellungen vornehmen.
Die gesamte nscale-Dokumentation finden Sie in unserem Serviceportal unter <https://serviceportal.ceyoniq.com>.

|Umgebungsvariable | Effekt |
|---|---|
|nscale-host=application-layer | Hier können Sie den logischen Hostname des Applications Server aus der Sicht des Application Layer Web angeben. |
|nscale-port=8080 | In dieser Umgebungsvariable können Sie den Port angeben, über den auf den nscale Server Application Layer Web zugegriffen werden kann. Der Standardwert ist "8080". |
|nscale-instance=nscalealinst1 | In dieser Umgebungsvariable können Sie eine nscale Instanz benennen. Der Standard ist "nscalealinst1". |
|nscale-ssl=false |Sie können festlegen ob SSL verwendet werden soll. Der Standardwert ist "false". |
|log4jConfigLocation=../conf/nscale_stdout_log_conf.xml | In dieser Umgebungsvariable können Sie den Pfad zur Konfigurationsdatei angeben. |

## Ports

* 8090
* 8453

## Start

```bash
 docker run \
   -e nscale-host=application-layer \
   -e log4jConfigLocation=../conf/nscale_stdout_log_conf.xml \
   -e nscale-port=8080 \
   -p 8090:8090 \
   nscale/application-layer-web
```

## Information für Entwickler

Wenn Sie z.B. eigene Plug-ins für nscale Server Application Layer Web entwickeln wollen,  
können Sie das mit nscale Standard Container umsetzen.  

In diesem Beispiel wird ein Plug-in, eine Änderung am Kontextmenü und Anpassungen an den Icons demonstriert.  
Es wird davon ausgegangen, dass Sie bereits die Datei `myplugin.jar` und die Datei `myicons.jar` erstellt haben.

>Weitere Informationen zu den jeweiligen SDKs entnehmen Sie bitte den entsprechenden Dokumentationen.

### Vorbereitung

Um Anpassungen vornehmen zu können, benötigen Sie auf Ihrem Entwicklungssystem diverse Dateien.  
Diese Dateien können Sie dem Image `nscale/application-layer-web` entnehmen.

Kopieren Sie die Datei `nscale_web.xml` lokal auf Ihr System:  

```bash
# Erzeugen eines temporären containers
$ docker create nscale/application-layer-web:[version]  # Passen Sie bitte diese Version an
a0123456789                                             # Diese ID wird auf Ihrem System eine andere sein

# Kopieren der Datei nscale_web.xml auf Ihr Entwicklungssystem
docker cp a0123456789:/opt/ceyoniq/nscale-server/application-layer-web/conf/nscale_web.xml ./

# Löschen des temporären Containers
docker rm a0123456789
```

### Erstellen einer eignen `nscale_web_plugins.xml`

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

In diesem Beispiel ist nun eine `myplugin.jar` und eine `myicons.jar` als Plug-in konfiguriert.  
Außerdem wurde konfiguriert, dass das Icon `myicon.svg` verwendet werden soll.  
Zusätzlich wurde das Kontextmenü geändert.

### Anpassen des Kontextmenü

```xml
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE menu-specification SYSTEM "menuconfig.dtd">
<menu-specification>
</menu-specification>
```

Erstellen Sie die Datei `menuconfig.xml` und ergänzen Sie Ihre Kontextmenüeinträge.  
> Weitere Informationen zur Konfiguration von nscale Server Application Layer Web finden Sie im Administrationshandbuch vom nscale Server Application Layer Web.

### Anpassung an der `nscale_web.xml`

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

Damit nscale Server Application Layer Web Ihre Konfiguration verabeiten kann, müssen die zuvor erstellten Dateien im nscale Server Application Layer Web-Container verwendet werden.

Alle Dateien müssen im Container in dem Ordner `/opt/ceyoniq/nscale-server/application-layer-web/conf/` verfügbar gemacht werden.
Dies kann abhängig von der gewählten Technologie durch ein `bind-mount`, ein `volume` oder ein zuvor erstelltes Custom Container-Image erfolgen.

#### Beispiel Docker-Compose

Wenn Sie Docker-Compose verwenden, können Sie zum Beispiel die Dateien als `bind-mount` konfigurieren.  

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
