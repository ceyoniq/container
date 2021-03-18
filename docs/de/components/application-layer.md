# nscale Server Application Layer

## Lizenzierung

nscale Server Application Layer benötigt eine lokale Lizenzdatei.
Hinterlegen Sie diese im Ordner "/opt/ceyoniq/nscale-server/application-layer/conf/license.xml".

## Persistierung

Um zu gewährleisten, dass Sie nach dem Herunterfahren des Systems weiterhin Zugriff auf Ihre Daten haben, sorgen Sie für eine Persistierung Sie des Ordners "/opt/ceyoniq/nscale-server/application-layer/conf".

## Umgebungsvariablen

>Die hier aufgeführte Liste der Umgebungsvariablen ist **nicht vollständig**.
Sie bildet lediglich die in unseren Beispielkonfigurationen verwendeten Umgebungsvariablen ab.

Die Bennennung der Umgebungsvariablen von nscale Server Application Layer kann in mehreren Formaten erfolgen, die wir für Sie im nscale Server Application Layer Administrationshandbuch zusammengefasst haben.
So können Sie auch alle anderen in den folgenden Konfigurationsdateien hinterlegten Änderungen vornehmen:

* service.conf
* engine.conf
* instance1.conf

Die gesamte nscale-Dokumentation finden Sie in unserem Serviceportal unter <https://serviceportal.ceyoniq.com/>.

|Umgebungsvariable | Effekt |
|---|---|
|INSTANCE1_INSTANCE_LOGGER_CONF=instance1-log-console.conf | Wenn Sie diese Umgebungsvariable verwenden, werden alle Logging-Ausgaben von nscale Server Application Layer in nscale Console statt einer Logging-Datei ausgegeben. Das ist im Containerbetrieb sinnvoll, da die Images ggf. verworfen werden und die Logdateien nicht mehr einsehbar sind. Console Ausgaben werden vom Container-System gesammelt.|
|INSTANCE1_CORE_DB_DIALECT=PostgreSQL |Mit dieser Umgebungsvariable können Sie den Datenbankdialekt Ihrer Datenbank festlegen. Hier wurde PostgreSQL ausgewählt. |
|INSTANCE1_CORE_DB_DRIVERCLASS=org.postgresql.Driver | Mit dieser Umgebungsvariable können Sie den Treiber Ihrer Datenbank hinterlegen. Hier wurde der Treiber org.potgresql gewählt. |
|INSTANCE1_CORE_DB_URLjdbc:postgresql://postgresql:5432/nscale?loggerLevel=OFF | Mit dieser Umgebungsvariable können Sie die URL Ihrer Datenbank hinterlegen. Passen Sie diesen Pfad ggf. an. |
|INSTANCE1_CORE_DB_USERNAME=nscale | Mit dieser Umgebungsvariable können Sie den Usernamen hinterlegen, mit dem der Application Layer auf die Datenbank zugreift. Hier wurde der Benutzername "nscale" gewählt. |
|INSTANCE1_CORE_DB_PASSWORD=password | In dieser Umgebungsvariable können Sie das Passwort hinterlegen, mit dem der Application Layer auf die Datenbank zugreift. Ändern Sie das in diesem Beispiel verwendete Passwort unbedingt. |
|INSTANCE1_CORE_DB_SCHEMA=public | In dieser Umgebungsvariable können Sie das Datenbankschema hinterlegen. Hier wurde das Schema public gewählt. |
|INITIALIZE_DOCUMENT_AREA=DA | Mit dieser Umgebungsvariable können Sie einen Dokumentenbereich mit dem Namen "DA" erstellen. |
|KUBERNETES_NAMESPACE | Diese Umgebungsvariable ist für die Konfiguration des Clusters in Kubernetes notwendig und hat eine spezielle Konfiguration. Lesen Sie bitte die [Cluster Konfiguration in Kubernetes](#cluster-konfiguration-in-kubernetes) für weitere Details |

## Cluster Konfiguration in Kubernetes

nscale Server Application Layer kann skaliert werden und ein Cluster bilden.
Bei der Cluster-Bildung greifen mehrere nscale Server Application Layer auf dieselbe Datenbank zu.
So wird die Verteilung der Last eines größeren nscale Systems auf mehrere Server bzw. Rechner ermöglicht.
Dafür ist es notwendig, dass Sie die folgenden Konfigurationen ausführen:

* Berechtigungen zum Listen und Finden anderer Pods und Application Layer Instanzen in Kubernetes: ServiceAccount, Role und RoleBinding;
* Kubernetes Namespace: nscale Server Application Layer kann nur Pods im dem Namespace suchen, in dem er ausgeführt wird;
* Label für den Cluster: nscale Server Application Layer sucht nur Pods mit der Label `ceyoniq.com/application-layer-cluster-name=[cluster name]`.

Eine Beispiel-Konfigurationen finden Sie in [application-layer.yaml](../kubernetes/kustomize/nscale/base/application-layer.yaml)

## Log Level

Zur Fehleranalyse ist es unter Umständen notwendig, das Log Level des Servers anzupassen.
Das Log Level des Servers können Sie in der log4j Konfiguration in der Datei `conf/instance1-log.conf` anpassen.
Kopieren Sie diese Datei zuerst aus dem Container heraus, bearbeiten Sie sie dann offline wie unten beschrieben und transferieren Sie die bearbeitet Datei anschließend wieder zurück in den Container.
Alternativ können Sie auch die Konfigurationsdatei mit dem `vi` im Container bearbeiten.
Dateien im `conf`-Ordner bleiben persistent, d.h. Änderungen im Logging bleiben auch nach einem Neustart des Containers erhalten.

Im Cluster muss die Datei in allen Instanzen ausgetauscht werden.

### Docker-Compose

Wenn Sie nscale Standard Container mit Docker-compose betreiben, verwenden Sie die folgenden Befehle um das Log Level des Servers anzupassen:

```bash
# a. edit config file in container
docker-compose exec application-layer bash
> vi /opt/ceyoniq/nscale-server/application-layer/conf/instance1-log.conf 

# b.1 copy file from nappl container
docker cp "$(docker-compose ps -q application-layer)":/opt/ceyoniq/nscale-server/application-layer/conf/instance1-log.conf instance1-log.conf
# b.2. edit locally

# b.3. copy file to nappl container
docker cp instance1-log.conf "$(docker-compose ps -q application-layer)":/opt/ceyoniq/nscale-server/application-layer/conf/instance1-log.conf
```

### Kubernetes

Wenn Sie nscale Standard Container mit Kubernetes betreiben, verwenden Sie die folgenden Befehle um das Log Level des Servers anzupassen:

```bash
# a. edit config file in container
kubectl exec -it application-layer-0 bash
> vi /opt/ceyoniq/nscale-server/application-layer/conf/instance1-log.conf 

# b.1. copy file from nappl container
kubectl cp application-layer-0:/opt/ceyoniq/nscale-server/application-layer/conf/instance1-log.conf instance1-log.conf -n <namespace> -c application-layer
# b.2. edit locally

# b.3. copy file to nappl container
kubectl cp instance1-log.conf application-layer-0:/opt/ceyoniq/nscale-server/application-layer/conf/instance1-log.conf -n <namespace> -c application-layer
```
