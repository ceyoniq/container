# nscale Server Application Layer

## Inhalt

- [nscale Server Application Layer](#nscale-server-application-layer)
  - [Inhalt](#inhalt)
  - [Lizenzierung](#lizenzierung)
  - [Persistierung](#persistierung)
  - [Konfiguration](#konfiguration)
  - [Umgebungsvariablen](#umgebungsvariablen)
  - [Ports](#ports)
  - [Start mit Docker](#start-mit-docker)
  - [Microsoft Windows Schriftarten](#microsoft-windows-schriftarten)
    - [Nachinstallation über ein eigenes Container-Image](#nachinstallation-über-ein-eigenes-container-image)
    - [Bereitstellung über Volumes und Bind-Mounts](#bereitstellung-über-volumes-und-bind-mounts)
  - [Cluster-Konfiguration in Kubernetes](#cluster-konfiguration-in-kubernetes)
  - [Volltext-Cache](#volltext-cache)
  - [Inkludieren und Exkludieren von Job-Typen](#inkludieren-und-exkludieren-von-job-typen)
  - [Log Level](#log-level)
    - [Docker-Compose](#docker-compose)
    - [Kubernetes](#kubernetes)

## Lizenzierung

Diese Komponente benötigt eine lokale Lizenzdatei.
Die Datei wird im Container hier erwartet: `/opt/ceyoniq/nscale-server/application-layer/conf/license.xml`.

## Persistierung

Diese Komponente benötigt keine Persistierung.

> Sie können weiterhin mit der Datei `/opt/ceyoniq/nscale-server/application-layer/conf/instance1.conf` oder mit einer beliebigen anderen Konfigurationsdatei arbeiten.
> Bitte beachten Sie aber, dass Sie diese Konfigurationsdatei persistieren müssen.

## Konfiguration

Sie können Umgebungsvariablen verwenden, um nscale Server Application Layer zu konfigurieren.  
Allerdings können Sie auch weiterhin die Datei `instance1.conf` verwenden, um nscale Server Application Layer zu konfigurieren.  
Beachten Sie dabei, dass Umgebungsvariablen eine höhere Priorität haben als Konfigurationseinstellungen in der Datei `instance1.conf`,
somit überlagern Werte von Umgebungsvariablen die Einstellungen aus der Datei `instance1.conf`.

## Umgebungsvariablen

>Die hier aufgeführte Liste der Umgebungsvariablen ist **nicht vollständig**.
Sie bildet lediglich die in unseren Beispielkonfigurationen verwendeten Umgebungsvariablen ab.

Die Benennung der Umgebungsvariablen von nscale Server Application Layer kann in mehreren Formaten erfolgen, die wir für Sie im nscale Server Application Layer Administrationshandbuch zusammengefasst haben.

Die gesamte nscale-Dokumentation finden Sie in unserem Serviceportal unter <https://serviceportal.ceyoniq.com>.

|Umgebungsvariable | Effekt |
|---|---|
|INSTANCE1_INSTANCE_LOGGER_CONF=instance1-log-console.conf | Wenn Sie diese Umgebungsvariable verwenden, werden alle Logging-Ausgaben von nscale Server Application Layer auf die Konsole statt in eine Logging-Datei geschrieben. Das ist im Containerbetrieb sinnvoll, da die Images ggf. verworfen werden und die Logdateien nicht mehr einsehbar sind. Ausgaben auf die Konsole werden vom Container-System gesammelt.|
|INSTANCE1_CORE_DB_DIALECT=PostgreSQL |Mit dieser Umgebungsvariable können Sie den Datenbankdialekt Ihrer Datenbank festlegen. Hier wurde PostgreSQL ausgewählt. |
|INSTANCE1_CORE_DB_DRIVERCLASS=org.postgresql.Driver | Mit dieser Umgebungsvariable können Sie den Treiber Ihrer Datenbank hinterlegen. Hier wurde der Treiber org.postgresql.Driver gewählt. |
|INSTANCE1_CORE_DB_URL=jdbc:postgresql://postgresql:5432/nscale?loggerLevel=OFF | Mit dieser Umgebungsvariable können Sie die URL Ihrer Datenbank hinterlegen. Passen Sie diesen Pfad ggf. an. |
|INSTANCE1_CORE_DB_USERNAME=nscale | Mit dieser Umgebungsvariable können Sie den Usernamen hinterlegen, mit dem der Application Layer auf die Datenbank zugreift. Hier wurde der Benutzername "nscale" gewählt. |
|INSTANCE1_CORE_DB_PASSWORD=password | In dieser Umgebungsvariable können Sie das Passwort hinterlegen, mit dem der Application Layer auf die Datenbank zugreift. Ändern Sie das in diesem Beispiel verwendete Passwort unbedingt. |
|INSTANCE1_CORE_DB_SCHEMA=public | In dieser Umgebungsvariable können Sie das Datenbankschema hinterlegen. Hier wurde das Schema public gewählt. |
|INSTANCE1_CORE_WORK_DIRECTORY=/mnt/fulltextcache | In dieser Umgebungsvariable können Sie den Ordner für den lokalen Volltext-Cache definieren.|
|INITIALIZE_DOCUMENT_AREA=DA | Mit dieser Umgebungsvariable können Sie einen Dokumentenbereich mit dem Namen "DA" erstellen. |
|KUBERNETES_NAMESPACE | Diese Umgebungsvariable ist für die Konfiguration des Clusters in Kubernetes notwendig, sie hat eine spezielle Konfiguration. Für weitere Details lesen Sie die [Cluster-Konfiguration in Kubernetes](#cluster-konfiguration-in-kubernetes). |

## Ports

- 8080
- 8443

## Start mit Docker

```bash
 docker run \
   -e INSTANCE1_INSTANCE_LOGGER_CONF=instance1-log-console.conf \
   -e INSTANCE1_CORE_DB_DIALECT=PostgreSQL \
   -e INSTANCE1_CORE_DB_DRIVERCLASS=org.postgresql.Driver \
   -e INSTANCE1_CORE_DB_URL=jdbc:postgresql://postgresql:5432/nscale?loggerLevel=OFF \
   -e INSTANCE1_CORE_DB_USERNAME=nscale \
   -e INSTANCE1_CORE_DB_PASSWORD=password \
   -e  INSTANCE1_CORE_DB_SCHEMA=public \
   -h democontainer \
   -v $(pwd)/license.xml:/opt/ceyoniq/nscale-server/application-layer/conf/license.xml \
   -p 8080:8080 \
   nscale/application-layer:8.0.5003.2021033114.659339082154
```

## Microsoft Windows Schriftarten

Der nscale Application Layer Server benötigt True-Type Schriftarten für die Konvertierung von
Dokumenten.  
Die Microsoft Windows Schriftarten sind nicht installiert und müssen durch den Benutzer nachinstalliert werden.
Sind keine Microsoft Windows Schriftarten installiert, so werden Ersatzschriftarten verwendet.

Der nscale Application Layer Server erwartet die Schriftarten im folgendem Ordner:  

```/usr/share/fonts/truetype/msttcorefonts```

### Nachinstallation über ein eigenes Container-Image

Sie können die Microsoft Windows Schriftarten nachinstallieren, indem Sie eigene Container-Images bauen.
Mit dem folgenden Kommando werden die Schriftarten nachinstalliert:

```bash
apt install ttf-mscorefonts-installer
```

### Bereitstellung über Volumes und Bind-Mounts

Sie können die Microsoft Windows Schriftarten auch durch ein Bind-Mount oder durch ein Volume bereitstellen.

Der nscale Application Layer Server erwartet die Schriftarten im folgendem Ordner:

```/usr/share/fonts/truetype/msttcorefonts```

**Beispiel Docker:**

```bash
docker run ... -v ${PWD}/fonts:/usr/share/fonts/truetype/msttcorefont nscale/application-layer:8.0.5003.2021033114.659339082154
```

**Beispiel Docker-Compose:**

```yaml
volumes:
    - ./fonts:/usr/share/fonts/truetype/msttcorefonts:ro
```

## Cluster-Konfiguration in Kubernetes

nscale Server Application Layer kann skaliert werden und einen Cluster bilden.
Bei der Cluster-Bildung greifen mehrere nscale Server Application Layer auf dieselbe Datenbank zu.
So wird die Verteilung der Last eines größeren nscale Systems auf mehrere Server bzw. Rechner ermöglicht.
Dafür ist es notwendig, dass Sie die folgenden Konfigurationen ausführen:

- Berechtigungen zum Listen und Finden anderer Pods und Application Layer Instanzen in Kubernetes: ServiceAccount, Role und RoleBinding;
- Kubernetes Namespace: nscale Server Application Layer kann nur Pods in dem Namespace suchen, in dem er ausgeführt wird;
- Label für den Cluster: nscale Server Application Layer sucht nur Pods mit dem Label `ceyoniq.com/application-layer-cluster-name=[cluster name]`.

Eine Beispiel-Konfiguration finden Sie in [application-layer.yaml](../../../kubernetes/kustomize/nscale/base/application-layer.yaml)

## Volltext-Cache

Wenn Sie nscale Server Application Layer Standard Container starten, ist der Volltext-Cache aktiviert.  
Der Volltext-Cache kann unter Umständen viel Speicher benötigen.  
In den Docker-Compose- und Kubernetes-Beispielen wurde der Volltext-Cache explizit deaktiviert.

Docker-Compose:  

```bash
INSTANCE1_CORE_FULLTEST_INDEX_MIRROR_LOCALCACHE=off
```

Kubernetes:  

```yaml
- name: INSTANCE1_CORE_FULLTEST_INDEX_MIRROR_LOCALCACHE
  value: "off" 
```

Wenn Sie den Volltext-Cache verwenden wollen, beachten Sie, dass der Ordner `/opt/ceyoniq/nscale-server/application-layer/temp`
sehr groß werden kann.  
Wir empfehlen Ihnen, hierfür ein geeignetes Volume anzulegen.

## Inkludieren und Exkludieren von Job-Typen

Sie können nscale Server Application Layer so konfigurieren, dass nur spezielle Jobs auf einer Instanz ausgeführt werden.  
Die Inklusion bzw. Exklusion eines Jobs kann durch Setzen einer Umgebungsvariable erfolgen.

Exkludieren von Jobs:  

```bash
INSTANCE1_CLUSTER_CORE_JOB_COORDINATOR_EXCLUDEJOBNAMES=ArchiveJob,AuditLogJob
```

Inkludieren von Jobs:  

```bash
INSTANCE1_CLUSTER_CORE_JOB_COORDINATOR_JOBNAMES=ArchiveJob,AuditLogJob
```

Weitere Informationen dazu finden Sie in der Dokumentation von nscale Server Application Layer.

## Log Level

Zur Fehleranalyse ist es unter Umständen notwendig, das Loglevel des Servers anzupassen.
Das Loglevel des Servers können Sie in der log4j-Konfiguration in der Datei `conf/instance1-log.conf` anpassen.
Kopieren Sie diese Datei zuerst aus dem Container heraus, bearbeiten Sie sie dann offline wie unten beschrieben und transferieren Sie die bearbeitete Datei anschließend wieder zurück in den Container.
Alternativ können Sie auch die Konfigurationsdatei mit dem `vi` im Container bearbeiten.
Beachten Sie bei diesem Vorgehen, dass Änderungen an Dateien im Container nicht persistiert werden.

Im Cluster muss die Datei in allen Instanzen ausgetauscht werden.

### Docker-Compose

Wenn Sie nscale Standard Container mit Docker-Compose betreiben, verwenden Sie die folgenden Befehle, um das Loglevel des Servers anzupassen.

```bash
docker-compose exec application-layer bash
> vi /opt/ceyoniq/nscale-server/application-layer/conf/instance1-log.conf 
```

### Kubernetes

Wenn Sie nscale Standard Container mit Kubernetes betreiben, verwenden Sie die folgenden Befehle, um das Loglevel des Servers anzupassen.

```bash
# copy file to host
kubectl cp application-layer-0:/opt/ceyoniq/nscale-server/application-layer/conf/instance1-log.conf instance1-log.conf -n <namespace> -c application-layer

# edit locally

# copy file to nappl container
kubectl cp instance1-log.conf application-layer-0:/opt/ceyoniq/nscale-server/application-layer/conf/instance1-log.conf -n <namespace> -c application-layer
```
