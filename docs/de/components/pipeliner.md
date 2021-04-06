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

## Lizenzierung

Diese Komponente benötigt eine lokale Lizenzdatei.
Die Datei wird im Container hier erwartet: `/opt/ceyoniq/nscale-pipeliner/workdir/license.xml`.

## Persistierung

Folgende Ordner müssen persistiert werden:

- `/opt/ceyoniq/nscale-pipeliner/workdir/data`
- `/opt/ceyoniq/nscale-pipeliner/workdir/config`

## Start mit Docker

```bash
docker run \
  -h democontainer \
  -v $(pwd)/cold.xml:/opt/ceyoniq/nscale-pipeliner/workdir/config/runtime/cold.xml \
  -v $(pwd)/data:/opt/ceyoniq/nscale-pipeliner/workdir/data \
  -v $(pwd)/license.xml:/opt/ceyoniq/nscale-pipeliner/workdir/license.xml \
  nscale/pipeliner:8.0
```

## Konfiguration

nscale Pipeliner kann als einzige nscale Standard Container-Komponente nicht über Umgebungsvariablen konfiguriert werden.
Stattdessen besteht die Möglichkeit, mit nscale Administrator eine Standard-Konfigurationsdatei für nscale Pipeliner zu generieren, ohne nscale Administrator vorher mit nscale Pipeliner verbinden zu müssen.

Das Vorgehen zum Erstellen und Bearbeiten einer solchen `cold.xml` ist im nscale Pipeliner Konfigurationshandbuch beschrieben.
Die gesamte nscale-Dokumentation finden Sie in unserem Serviceportal unter <https://serviceportal.ceyoniq.com>.

Die spezielle Konfiguration richtet sich nach der Umgebung, in der sie verwendet wird.
Beachten Sie dass unter Umständen auch Rechte in nscale für den Betrieb von nscale Pipeliner angepasst werden müssen.

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

| Volume | Herkunft | Beschreibung |
|---|---|---|
| `data` | RWX PersistenceVolumeClaim | Enthält das Spool-Verzeichnis und kann in mehrere Pods gemappt werden, um Daten abzulegen, die vom Pipeliner kontinuierlich importiert werden. |
| `conf`  | RWO PersistenceVolumeClaim  | Umfasst die Konfiguration von nscale Pipeliner. |
| `cold.xml` | `base/config/pipeliner/cold.xml` | Spezielle, offline erstellte Konfigurationsdatei. |
| `license.xml` | `base/license.xml` | Lizenzdatei |

Zur Aktivierung von nscale Pipeliner müssen Sie in der Datei `base/kustomization.xml` die Pipeliner Ressourcen einkommentieren.
