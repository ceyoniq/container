# FAQ

## Inhalt

- [FAQ](#faq)
  - [Inhalt](#inhalt)
  - [Was kann ich tun, wenn ein nscale Standard Container nicht startet?](#was-kann-ich-tun-wenn-ein-nscale-standard-container-nicht-startet)
  - [Wie kann ich die Zeitzone ändern?](#wie-kann-ich-die-zeitzone-ändern)
  - [Wie kann ich Java Startoptionen (JAVA_OPTS) setzen?](#wie-kann-ich-java-startoptionen-java_opts-setzen)
  - [Wie kann ich die Java Heap Size anpassen?](#wie-kann-ich-die-java-heap-size-anpassen)
  - [Wie kann ich die Microsoft Windows Schriftarten (Microsoft TrueType Fonts) verwenden?](#wie-kann-ich-die-microsoft-windows-schriftarten-microsoft-truetype-fonts-verwenden)
  - [Wie kann ich mit Kustomize Änderungen an der Kubernetes-Konfiguration vornehmen?](#wie-kann-ich-mit-kustomize-änderungen-an-der-kubernetes-konfiguration-vornehmen)

## Was kann ich tun, wenn ein nscale Standard Container nicht startet?

Wenn ein nscale Standard Container nicht startet, kann es dafür viele Gründe geben.
Um den Start eines nscale Standard Containers genauer zu untersuchen, können Sie wie folgt vorgehen:

1. Starten Sie den jeweiligen nscale Standard Container, ohne dabei die eigentliche Applikation zu starten.
Jeder nscale Standard Container verwendet einen `ENTRYPOINT` und eine `CMD`.
Die `CMD`-Eigenschaft kann leicht übersteuert werden, sodass der Start der eigentlichen Applikation verhindert werden kann.

Weitere Informationen zu `CMD` und `ENTRYPOINT`:  

- <https://docs.docker.com/engine/reference/builder/#cmd>
- <https://docs.docker.com/engine/reference/builder/#entrypoint>

2. Nun können Sie den Start der Applikation durch einen direkten Aufruf in der `bash` untersuchen.
Die jeweilige nscale Standard Container Applikation wird über ein `run.sh`-Script in dem jeweiligen `WORKDIR` gestartet.

**Beispiel Docker:**

```bash
docker run -it nscale/[container-image]:[container-version] [optionen] bash
```

**Beispiel Docker-Compose:**

Ändern Sie Ihre `docker-compose.yaml` so ab, dass ein `sleep infinity` ausgeführt wird.  
Anschließend haben Sie die Möglichkeit, sich mit `docker-compose exec [service name] bash` auf den Container aufzuschalten.

```yaml
command: ["sleep", "infinity"]
```

Weitere Informationen: <https://docs.docker.com/compose/compose-file/compose-file-v3/#command>

**Beispiel Kubernetes:**

Ändern Sie die Datei `[container].yaml` so ab, dass ein `sleep infinity` ausgeführt wird.  
Anschließend haben Sie die Möglichkeit, sich mit `kubectl exec -it [pod-name] -n [namespace] -- bash` auf den Container aufzuschalten.

```yaml
containers:
    ...
    command:
        - "sleep"
        - "infinity"
```

## Wie kann ich die Zeitzone ändern?

Die nscale Standard Container verwenden `UTC` als Zeitzone.  
Sie können die Zeitzone für den jeweiligen Container mit der Umgebungsvariable `TZ` setzen.

**Beispiel Docker:**

```bash
docker run -e TZ=Europe/Berlin [image]
```

**Beispiel Docker-Compose:**

```yaml
environment:
    - TZ=Europe/Berlin
```

**Beispiel Kubernetes:**

```yaml
- name: TZ
  value: "Europe/Berlin"
```

Weitere Informationen: <https://www.gnu.org/software/libc/manual/html_node/TZ-Variable.html>

## Wie kann ich Java Startoptionen (JAVA_OPTS) setzen?

Einige nscale Komponenten sind in Java implementiert.
Je nach Installation und Anwendungsszenario kann es notwendig sein, Java Startoptionen anzupassen.
Alle nscale Standard Container, die eine Java-Applikation beinhalten, können über die Umgebungsvariable `JAVA_OPTS` angepasst werden.

Folgende nscale Standard Container beinhalten Java-Applikationen:

- nscale/application-layer
- nscale/application-layer-web
- nscale/cmis-connector
- nscale/console
- nscale/ilm-connector
- nscale/monitoring-console
- nscale/rendition-server
- nscale/webdav-connector

**Beispiel Docker:**

```bash
docker run -e JAVA_OPTS=-Dcom.sun.jndi.ldap.object.disableEndpointIdentification=true [image]
```

**Beispiel Docker-Compose:**

```yaml
environment:
    - JAVA_OPTS=-Dcom.sun.jndi.ldap.object.disableEndpointIdentification=true
```

**Beispiel Kubernetes:**

```yaml
- name: JAVA_OPTS
  value: "-Dcom.sun.jndi.ldap.object.disableEndpointIdentification=true"
```

## Wie kann ich die Java Heap Size anpassen?

Je nach Installation und Anwendungsszenario kann es notwendig sein, die Java Heap Size zu vergrößern.
Die Java Heap Size können Sie über die Umgebungsvariable `JAVA_OPTS` anpassen.

Weitere Informationen:  
<https://docs.oracle.com/javase/7/docs/technotes/tools/solaris/java.html>

**Beispiel Docker:**

```bash
docker run -e JAVA_OPTS=-Xmx3g [image]
```

In diesem Beispiel wurde die Java Heap Size so gewählt, dass 3 Gigabyte im Container verwendet werden.

**Beispiel Docker-Compose:**

```yaml
environment:
    - JAVA_OPTS=-Xmx3g
```

In diesem Beispiel wurde die Java Heap Size so gewählt, dass 3 Gigabyte im Container verwendet werden.

**Beispiel Kubernetes:**

```yaml
- name: JAVA_OPTS
  value: "-XX:MaxRAMPercentage=85.0"
```

In diesem Beispiel wurde die Java Heap Size so gewählt, dass 85% des im Container verfügbaren Speichers verwendet wird.
Beachten Sie, dass die Eigenschaft `resources.requests` in der Container-Definition Auswirkungen auf die Berechnung hat.  

Weitere Informationen: <https://kubernetes.io/docs/concepts/configuration/manage-resources-containers>

## Wie kann ich die Microsoft Windows Schriftarten (Microsoft TrueType Fonts) verwenden?

Die Microsoft Windows Schriftarten werden nicht mitgeliefert.  
Eine Installationsanleitung finden Sie hier:  

- [nscale Server Application Layer](components/application-layer.md#microsoft-windows-schriftarten)
- [nscale Rendition Server](components/rendition-server.md#microsoft-windows-schriftarten)

## Wie kann ich mit Kustomize Änderungen an der Kubernetes-Konfiguration vornehmen?

In diesem Beispiel wird gezeigt, wie sie mit Hilfe von `kustomize` die Konfiguration des nscale Server Storage Layer anpassen können.
Es werden neue Umgebungsvariablen hinzugefügt um ein neuen Archivtyp und ein HarddiskDevice zu definieren.
Außerdem soll die Konfiguration `default` verwendet werden, damit automatisch `PVC`und `PV` erzeugt werden.

Weitere Informationen zu Kustomize finden Sie hier:  
<https://kubernetes.io/docs/tasks/manage-kubernetes-objects/kustomization/>

1. Legen Sie im Ordner `kubernetes/kustomize/nscale/overlays` den Ordner `custom` an.

2. Wechseln Sie in den Order `kubernetes/kustomize/nscale/overlays/custom`

3. Erstellen Sie eine Datei `kustomization.yaml` mit folgenden Inhalt:

```yaml
bases:
- ../default

patchesStrategicMerge:
- storage-layer-env.yaml
```

4. Erzeugen Sie eine Datei `storage-layer-env.yaml` mit folgenden Inhalt:

```yaml
apiVersion: apps/v1
kind: StatefulSet
metadata:
  name: storage-layer
spec:
  template:
    spec:
      containers:
      - name: storage-layer    
        env:
            - name: NSTL_ARCHIVETYPE_900_NAME
              value: "DEMOARCHIVETYPE"
            - name: NSTL_ARCHIVETYPE_900_ID
              value: "900"
            - name: NSTL_ARCHIVETYPE_900_LOCALMIGRATION
              value: "0"
            - name: NSTL_ARCHIVETYPE_900_LOCALMIGRATIONTYPE
              value: "HD"
            - name: NSTL_ARCHIVETYPE_900_HARDDISK
              value: "1"
            - name: NSTL_HarddiskDevice_0_ARCHIVETYPES
              value: "DEMOARCHIVETYPE"
            - name: NSTL_HarddiskDevice_0_INDEX
              value: "1"
            - name: NSTL_HarddiskDevice_0_NAME
              value: "HD"
            - name: NSTL_HarddiskDevice_0_PATH
              value: "/mnt"
            - name: NSTL_HarddiskDevice_0_PERMANENTMIGRATION
              value: "1"
```

5. Starten Sie alle Komponenten mit folgenden Kommando:

```bash
kubectl apply -k . -n nscale
```

6. Prüfen Sie mit folgendem Kommando, ob die Umgebungsvariablen korrekt gesetzt wurden.  

```bash
kubectl describe pod/storage-layer-0 -n nscale
```
