# FAQ

## Inhalt

- [FAQ](#faq)
  - [Inhalt](#inhalt)
  - [Was kann ich tun, wenn ein nscale Standard Container nicht startet?](#was-kann-ich-tun-wenn-ein-nscale-standard-container-nicht-startet)
    - [Im Fall von `docker`](#im-fall-von-docker)
    - [Im Fall von `docker-compose`](#im-fall-von-docker-compose)
    - [Im Fall von `Kubernetes`](#im-fall-von-kubernetes)

## Was kann ich tun, wenn ein nscale Standard Container nicht startet?

Wenn ein nscale Standard Container nicht startet, dann kann es dafür viele Gründe geben.
Um den Start eines nscale Standard Containers genauer zu untersuchen, können Sie wie folgt vorgehen.

Starten Sie den jeweiligen nscale Standard Container ohne dabei die eigentliche Applikation zu starten.
Jeder nscale Standard Container verwendet ein `ENTRYPOINT` und eine `CMD`.
Die `CMD`-Eigenschaft kann leicht übersteuert werden, sodass der Start der eigentlichen Applikation verhindert werden kann.

Weitere Informationen zu `CMD` und `ENTRYPOINT`:  

- <https://docs.docker.com/engine/reference/builder/#cmd>
- <https://docs.docker.com/engine/reference/builder/#entrypoint>

Nun können Sie den Start der Applikation durch eine direkten Aufruf in der `bash` untersuchen.
Die jeweilige nscale Standard Container Applikation wird über ein `run.sh`-Script in dem jeweiligen `WORKDIR` gestartet.

### Im Fall von `docker`

```bash
docker run -it nscale/[container-image]:[container-version] [optionen] bash
```

### Im Fall von `docker-compose`

Ändern sie Ihre `docker-compose.yaml` so ab, dass ein `sleep infinity` ausgeführt wird.  
Somit habe Sie die Möglichkeit sich im Anschluss mit `docker-compose exec [service name] bash` auf den Container aufzuschalten.

```yaml
command: ["sleep", "infinity"]
```

Weitere Informationen: <https://docs.docker.com/compose/compose-file/compose-file-v3/#command>

### Im Fall von `Kubernetes`

Ändern sie Ihre `[container].yaml` so ab, dass ein `sleep infinity` ausgeführt wird.  
Somit habe Sie die Möglichkeit sich im Anschluss mit `kubectl exec -it [pod-name] -n [namespace] -- bash` auf den Container aufzuschalten.

```yaml
containers:
    ...
    command:
        - "sleep"
        - "infinity"
```
