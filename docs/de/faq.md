# FAQ

## Inhalt

- [FAQ](#faq)
  - [Inhalt](#inhalt)
  - [Was kann ich tun, wenn ein nscale Standard Container nicht startet?](#was-kann-ich-tun-wenn-ein-nscale-standard-container-nicht-startet)
    - [Im Fall von docker](#im-fall-von-docker)
    - [Im Fall von docker-compose](#im-fall-von-docker-compose)
    - [Im Fall von Kubernetes](#im-fall-von-kubernetes)
  - [Wie kann ich die Zeitzone ändern?](#wie-kann-ich-die-zeitzone-ändern)
  - [Wie kann ich die Java Heap Size anpassen?](#wie-kann-ich-die-java-heap-size-anpassen)

## Was kann ich tun, wenn ein nscale Standard Container nicht startet?

Wenn ein nscale Standard Container nicht startet, dann kann es dafür viele Gründe geben.
Um den Start eines nscale Standard Containers genauer zu untersuchen, können Sie wie folgt vorgehen:

1. Starten Sie den jeweiligen nscale Standard Container, ohne dabei die eigentliche Applikation zu starten.
Jeder nscale Standard Container verwendet ein `ENTRYPOINT` und eine `CMD`.
Die `CMD`-Eigenschaft kann leicht übersteuert werden, sodass der Start der eigentlichen Applikation verhindert werden kann.

Weitere Informationen zu `CMD` und `ENTRYPOINT`:  

- <https://docs.docker.com/engine/reference/builder/#cmd>
- <https://docs.docker.com/engine/reference/builder/#entrypoint>

2. Nun können Sie den Start der Applikation durch eine direkten Aufruf in der `bash` untersuchen.
Die jeweilige nscale Standard Container Applikation wird über ein `run.sh`-Script in dem jeweiligen `WORKDIR` gestartet.

### Im Fall von docker

```bash
docker run -it nscale/[container-image]:[container-version] [optionen] bash
```

### Im Fall von docker-compose

Ändern Sie Ihre `docker-compose.yaml` so ab, dass ein `sleep infinity` ausgeführt wird.  
Anschließend haben Sie die Möglichkeit sich mit `docker-compose exec [service name] bash` auf den Container aufzuschalten.

```yaml
command: ["sleep", "infinity"]
```

Weitere Informationen: <https://docs.docker.com/compose/compose-file/compose-file-v3/#command>

### Im Fall von Kubernetes

Ändern Sie Ihre `[container].yaml` so ab, dass ein `sleep infinity` ausgeführt wird.  
Anschließend haben Sie die Möglichkeit sich mit `kubectl exec -it [pod-name] -n [namespace] -- bash` auf den Container aufzuschalten.

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

Beispiel für Kubernetes und die Zeitzone `Europe/Berlin`:

```yaml
env:
   - name: TZ
     value: Europe/Berlin
```

## Wie kann ich die Java Heap Size anpassen?

Einige nscale Komponenten sind in Java implementiert.
Je nach Installation und Anwendungsszenario kann es sein, dass die Java Heap Size vergrößert werden muss.
Alle nscale Standard Container die eine Java-Applikation beinhalten, können über die Umgebungsvariable `JAVA_OPTS` angepasst werden.

Folgende nscale Standard Container beinhalten Java-Applikationen:

- nscale/application-layer
- nscale/application-layer-web
- nscale/cmis-connector
- nscale/console
- nscale/ilm-connector
- nscale/monitoring-console
- nscale/rendition-server
- nscale/webdav-connector

Beispiel Kubernetes:

```yaml
- name: JAVA_OPTS
  value: "-XX:MaxRAMPercentage=85.0"
```

In diesem Beispiel wurde die Java Heap Size so gewählt, dass 85% des im Container verfügbaren Speichers verwendet wird.
Beachten Sie, dass die Eigenschaft `resources.requests` in der Container-Definition Auswirkungen auf die Berechnung hat.  
Weitere Informationen: <https://kubernetes.io/docs/concepts/configuration/manage-resources-containers>

Beispiel Docker-Compose:

```yaml
environment:
    - JAVA_OPTS=-Xmx3g
```

In diesem Beispiel wurde die Java Heap Size so gewählt, dass 3 GigaByte im Container verwendet werden.
