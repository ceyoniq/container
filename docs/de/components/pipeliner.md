# nscale Pipeliner

## Inhalt

- [nscale Pipeliner](#nscale-pipeliner)
  - [Inhalt](#inhalt)
  - [Lizenzierung](#lizenzierung)
  - [Persistierung](#persistierung)
  - [Start mit Docker](#start-mit-docker)
  - [Konfiguration](#konfiguration)
    - [Docker-Compose](#docker-compose)
    - [Kubernetes](#kubernetes)
    - [Anpassen der `doc_mime_suff.tsv`](#anpassen-der-doc_mime_sufftsv)
      - [Vorbereitung](#vorbereitung)
      - [Verwendung von externen Dateien (Bind-Mount und Volumes)](#verwendung-von-externen-dateien-bind-mount-und-volumes)

## Lizenzierung

Diese Komponente benötigt eine lokale Lizenzdatei.
Die Datei wird im Container hier erwartet: `/opt/ceyoniq/nscale-pipeliner/workdir/license.xml`.

## Persistierung

> **Achtung! Datenverlust!**  
> Wenn die hier aufgelisteten Ordner nicht persistiert werden, kommt es zum **Datenverlust**.

Je nach Konfiguration wird der Pipeliner Dateien lesen, schreiben und ändern.  
Diese Ordner müssen als Volume oder als Bind-Mount gesichert werden.

Zum Beispiel können folgende Ordner persistiert werden:

- `/opt/ceyoniq/nscale-pipeliner/workdir/data`
- `/opt/ceyoniq/nscale-pipeliner/workdir/config`

## Start mit Docker

```bash
docker run \
  -h democontainer \
  -v $(pwd)/cold.xml:/opt/ceyoniq/nscale-pipeliner/workdir/config/runtime/cold.xml \
  -v $(pwd)/data:/opt/ceyoniq/nscale-pipeliner/workdir/data \
  -v $(pwd)/license.xml:/opt/ceyoniq/nscale-pipeliner/workdir/license.xml \
  ceyoniq.azurecr.io/release/nscale/pipeliner:8.3.1004.2022032310.1054366939276
```

## Konfiguration

nscale Pipeliner kann als einzige nscale Standard Container-Komponente nicht über Umgebungsvariablen konfiguriert werden.
Stattdessen besteht die Möglichkeit, mit nscale Administrator eine Standard-Konfigurationsdatei für nscale Pipeliner zu generieren, ohne nscale Administrator vorher mit nscale Pipeliner verbinden zu müssen.

Das Vorgehen zum Erstellen und Bearbeiten einer solchen `cold.xml` ist im nscale Pipeliner Konfigurationshandbuch beschrieben.
Die gesamte nscale-Dokumentation finden Sie in unserem Serviceportal unter <https://serviceportal.ceyoniq.com>.

Die spezielle Konfiguration richtet sich nach der Umgebung, in der sie verwendet wird.
Beachten Sie, dass unter Umständen auch Rechte in nscale für den Betrieb von nscale Pipeliner angepasst werden müssen.

### Docker-Compose

Mit dem Start von nscale Pipeliner wird das Spool-Verzeichnis im aktuellen Ordner angelegt. nscale Pipeliner verwendet das Spool-Verzeichnis, um Dateien kontinuierlich zu importieren.
Unter `./workdir/data` werden später die Eingangsdaten abgeholt.
Die zuvor offline konfigurierte `cold.xml` kann ebenfalls in diesem Ordner abgelegt und anschließend in den Container gemappt werden.
Dazu muss die Kommentarzeile unten herausgenommen und der Container neu instanziiert werden.

```bash
> vi docker-compose.pipeliner.yml
    ...
    volumes:
      - ./workdir/data:/opt/ceyoniq/nscale-pipeliner/workdir/data:rw
      #- ./workdir/config/cold.xml:/opt/ceyoniq/nscale-pipeliner/workdir/config/runtime/cold.xml:ro
      - ${PIPELINER_LICENSE_FILE}:/opt/ceyoniq/nscale-pipeliner/workdir/license.xml:ro

# Der Container muss neu instanziiert werden
> docker-compose up -d pipeliner

# Logs prüfen
> docker-compose logs -f pipeliner
```

### Kubernetes

In Kubernetes ist nscale Pipeliner als StatefulSet definiert und verwendet vier Volumes:

| `data` | RWX PersistenceVolumeClaim | Enthält das Spool-Verzeichnis und kann in mehrere Pods gemappt werden, um Daten abzulegen, die vom Pipeliner kontinuierlich importiert werden. |
| `setup`  | config map  | Vorbereitung des Pipeliner starts. |
| `cold` | `base/config/pipeliner/cold.xml` | Spezielle, offline erstellte Konfigurationsdatei. |
| `license.xml` | `base/license.xml` | Lizenzdatei |

Zur Aktivierung von nscale Pipeliner müssen Sie in der Datei `base/kustomization.yaml` und `overlay/*/kustomization.yaml` die Pipeliner Ressourcen einkommentieren.

### Anpassen der `doc_mime_suff.tsv`

> Die Vorgehensweise kann auch auf andere Konfigurationsdateien angewendet werden.

Die Datei `doc_mime_suff.tsv` enthält Konfigurationen für MimeType, DocType und FileExtensions.
Diese Konfiguration kann angepasst werden.

#### Vorbereitung

Um Anpassungen an der `doc_mime_suff.tsv` vornehmen zu können, benötigen Sie diese Datei auf Ihrem Entwicklungssystem.
Diese Datei können Sie dem Image `ceyoniq.azurecr.io/release/nscale/pipeliner:8.3.1004.2022032310.1054366939276

Kopieren Sie die Datei `doc_mime_suff.tsv` lokal auf Ihr System:  

```bash
# Erzeugen eines temporären Containers
$ docker create ceyoniq.azurecr.io/release/nscale/pipeliner:8.3.1004.2022032310.1054366939276
a0123456789 

# Kopieren der Datei doc_mime_suff.tsv auf Ihr Entwicklungssystem
docker cp a0123456789:/opt/ceyoniq/nscale-pipeliner/workdir/config/common/doc_mime_suff.tsv ./

# Löschen des temporären Containers
docker rm a0123456789
```

#### Verwendung von externen Dateien (Bind-Mount und Volumes)

Um angepasste Dateien in dem jeweiligen Container verwenden zu können, müssen diese dem Container als Bind-Mount oder als Volume zur Verfügung gestellt werden. Je nach Betriebsumgebung unterscheidet sich die Vorgehensweise.

**Beispiel Docker:**

Um die angepasste `doc_mime_suff.tsv` verwenden zu können, muss diese Datei als Bind-Mount verfügbar gemacht werden.  

```bash
docker run -it ... -v ${PWD}/doc_mime_suff.tsv:/opt/ceyoniq/nscale-pipeliner/workdir/config/common/doc_mime_suff.tsv ceyoniq.azurecr.io/release/nscale/pipeliner:8.3.1004.2022032310.1054366939276
```

**Beispiel Docker-Compose:**

Um die angepasste `doc_mime_suff.tsv` verwenden zu können, muss diese Datei als Bind-Mount verfügbar gemacht werden.  

```yaml
volumes:
    - ./doc_mime_suff.tsv:/opt/ceyoniq/nscale-pipeliner/workdir/config/common/doc_mime_suff.tsv:ro
```

**Beispiel Kubernetes:**

Um die angepasste `doc_mime_suff.tsv` verwenden zu können, kann diese Datei als `ConfigMap` in Kubernetes konfiguriert werden.  

Weiter Informationen zu `ConfigMap` finden Sie hier:  
<https://kubernetes.io/docs/concepts/configuration/configmap/>