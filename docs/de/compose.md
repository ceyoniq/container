# nscale Standard Container mit Docker-Compose

In dieser Datei finden Sie Informationen dazu, wie Sie nscale im Docker-Container betreiben können. Dabei wird ausschließlich auf den Betrieb über Docker-Compose eingegangen.  
Informationen zum Betrieb in Kubernetes finden Sie unter [nscale Standard Container in Kubernetes](kubernetes.md).  

## Inhalt

- [nscale Standard Container mit Docker-Compose](#nscale-standard-container-mit-docker-compose)
  - [Inhalt](#inhalt)
  - [Kurz und knapp](#kurz-und-knapp)
  - [Voraussetzungen](#voraussetzungen)
  - [Ports](#ports)
  - [Konfiguration](#konfiguration)
  - [Herunterladen](#herunterladen)
  - [Starten](#starten)
  - [docker-compose Szenarien](#docker-compose-szenarien)
  - [Zugriff über nscale Administrator](#zugriff-über-nscale-administrator)
  - [nscale Pipeliner](#nscale-pipeliner)
  - [Application Cluster](#application-cluster)
  - [Externe Tools](#externe-tools)
  - [Log Aggregation](#log-aggregation)
    - [Logs exportieren](#logs-exportieren)
  - [Prometheus Anbindung](#prometheus-anbindung)

## Kurz und knapp

- Ihre Docker-Installation funktioniert
- Ihr docker-compose funktioniert
- Sie haben die Datei "nscale/docker-compose.example.env" nach "nscale/.env" kopiert

Führen Sie im Order "nscale" folgende Kommandos aus:

```bash
$ cp docker-compose.example.env .env
$ docker-compose up -d
$ docker-compose logs -f
...
nscale Server Application Layer_1  | Creating default document area scenario...
nscale Server Application Layer_1  | Done
```

Fertig! Sie können unter <http://localhost/> auf Ihr nscale zugreifen.

## Voraussetzungen

In der folgenden Anleitung wird davon ausgegangen, dass Ihr System die in [nscale Standard Container](release/README.md) aufgeführten Softwarevoraussetzungen erfüllt.

Außerdem haben Sie eine Lizenzdatei erworben und nach license.xml kopiert.

## Ports

Zur Kommunikation benötigt nscale mehrere Ports.
Beenden Sie zunächst alle laufenden nscale-Serverprozessse und geben Sie die in der Datei "docker-compose-default-pots.yaml" verwendeten Ports frei.
Diese sind:

- 5432 (postgres)
- 3005 (nscale Server Storage Layer)
- 8080 (nscale Server Application Layer - HTTP)
- 8443 (nscale Server Application Layer - HTTPS)
- 8090 (nscale Server Application Layer Web - HTTP)
- 8091 (nscale Server Application Layer Web - HTTPS)
- 8086 (nscale Console - HTTP)
- 8087 (nscale Console - HTTPS)
- 8387 (nscale Monitoring Console - HTTP)
- 8388 (nscale Monitoring Console - HTTPS)
- 8192 (nscale Rendition Server - HTTP)
- 8193 (nscale Rendition Server - HTTPS)
- 3120 (RMS)
- 2200 (RMS mit SSH)

>**Hinweis**  
In produktiven Szenarien können Sie die benötigten Ports durch Konfiguration verringern bzw. verändern.  
Zum Beispiel können Sie nur den jeweiligen Port für den nscale Server Application Layer Web auf das Host-System routen.
Zu diesem Zweck können Sie die "docker-compose-default-ports.yml"-Datei bzw. die "docker-compose.yml"-Datei anpassen.

## Konfiguration

In der Datei "docker-compose.example.env" sind diverse Einstellugen hinterlegt.
Zum Beispiel können Sie hier festlegen, welche Version eines Containers verwendet werden soll.
Damit Sie nscale starten können, müssen Sie daher eine .env-Datei anlegen. Verwenden Sie dazu einen der folgenden Kommandos:

Linux:  

```bash
cp docker-compose.example.env .env
```

Windows:  

```bash
copy docker-compose.example.env .env
```

## Herunterladen

Sie können jetzt die nscale-Container aus der Registry herunterladen. Verwenden Sie dazu das pull-Kommando.  

Nach Abschluss des Downloads sehen Sie die folgenden Meldungen im Ordner "nscale":

```bash
$ docker-compose pull
Pulling traefik               ... done
Pulling application-layer-web ... done
Pulling monitoring-console    ... done
Pulling postgresql            ... done
Pulling console               ... done
Pulling rendition-server      ... done
Pulling application-layer     ... done
Pulling storage-layer         ... done
Pulling rms                   ... done
```

## Starten

Mit dem Kommando `docker-compose up` können Sie nun den nscale-Stack hochfahren. Dabei sehen Sie folgende Meldungen:

```bash
$ docker-compose up
Creating network "nscale_nscale" with the default driver
Creating volume "nscale_postgresql_data" with default driver
Creating volume "nscale_storage-layer_arc" with default driver
...
Creating nscale_application-layer_1     ... done
...
...
application-layer-web_1      | INFO: Server startup in 34082 ms
application-layer_1          | ... - The start of nscale Server Application Layer is completed.
application-layer_1          | Creating default document area scenario...
application-layer_1          | Done
```

Sie können jetzt die URL <http://localhost/> aufrufen um sich mit dem nscale Server Application Layer Web zu verbinden.

Bei der ersten Anmeldung können Sie die Standard-Anmeldedaten verwenden, die beim Start eines neuen nscale Systems automatisch erstellt werden.
Ändern Sie diese Anmeldedaten für den Produktivbetrieb umgehend.
Die Standard-Anmeldedaten lauten:

```txt
User: admin
Password: admin
```

**Herzlichen Glückwunsch! Sie haben ein lauffähiges nscale!**

## docker-compose Szenarien

Im Ordner "nscale" befinden sich die Basis-Docker-Compose-Datei ("docker-compose.yml") und andere ergänzende Compose-Dateien.
Wenn diese Dateien kombiniert werden, führt der `docker-compose up`-Kommando diese zusammen und führt ein Deployment durch.
In der Datei "[docker-compose.example.env](./nscale/docker-compose.example.env)" finden Sie verschiedene Möglichkeit nscale zu betreiben.

**docker-compose.proxy.yml**  
Diese Konfiguration bietet eine Unterstützung von traefik (<https://docs.traefik.io/>) als Reverse Proxy.  
So können Sie nscale Server Application Layer Web, nscale Server Application Layer und nscale Console über den Port 80 erreichen.

**docker-compose.proxy-with-ssl.yml**  
Diese Konfiguration bietet eine Unterstützung von traefik (<https://docs.traefik.io/>) als Reverse Proxy und SSL mit Let's Encrypt.
So können Sie nscale Server Application Layer Web, nscale Server Application Layer und nscale Console über den Port 443 erreichen.
Beachten Sie, dass der Rechner, auf dem Sie nscale installieren wollen, aus dem Internet erreichbar sein muss, um ein Zertifikat bekommen zu können.

**docker-compose.default-ports.yml**  
Mit dieser Konfiguration werden alle nscale default Ports freigegeben. Diese Ports sind: 5432 (Postgres), 3005, 8080, 8443, 8090, 8091, 8086, 8087, 8387, 8388, 8192 und 8193.  

**docker-compose.pipeliner.yml**  
In dieser Konfiguration wird nscale Pipeliner wird verwendet.

**docker-compose.analytics.yml**  
Diese Konfiguration bietet Grafana, Prometheus und Loki  Unterstützung.  
Für Loki werden Treiber für Docker benötigt, eine Liste dieser Treiber finden Sie im Kapitel [Log Aggregation](##log-aggegation).

>**Weitere Compose-Szenarien**  
Außerdem haben Sie die Möglichkeit eigene `.yml`-Dateien zu erstellen und so eine Konfiguration zu erstellen, die auf Ihre Bedürfnisse abgestimmt ist.

## Zugriff über nscale Administrator

Um nscale Server Application Layer zu konfigurieren, Können Sie sich mit nscale Administrator an Ihrem nscale-System anmelden.  
Wenn Sie die Konfigurationsdatei "docker-compose.proxy.yml" verwenden, ist nscale Server Application Layer auf `localhost` zu erreichen.  
Wenn Sie die Konfigurationsdatei "docker-compose.default-ports.yml" verwenden, ist nscale Server Application Layer auf `localhost:8080` zu erreichen.  

Bei der ersten Anmeldung können Sie die Standard-Anmeldedaten verwenden, die beim Start eines neuen nscale Systems automatisch erstellt werden.
Ändern Sie diese Anmeldedaten für den Produktivbetrieb umgehend.
Die Standard-Anmeldedaten lauten:

```txt
User: admin
Password: admin
```

## nscale Pipeliner

Damit Sie nscale Pipeliner verwenden können, muss in der .env-Datei die Konfigurationsdatei "docker-compose.pipeliner.yml" verwendet werden.
In der dort hinterlegten Standardkonfiguration kann nscale Pipeliner nicht starten sondern muss zuerst konfiguriert werden.
Wenn nscale Pipeliner nicht startet, können Sie mit Hilfe von nscale Administrator die Konfiguration von nscale Pipeliner anpassen.
Nachdem Sie das Kommando `docker-compose up -d` ausgeführt haben, können Sie mit dem Kommando `docker-compose logs pipeliner` überprüfen, ob nscale Pipeliner erfolgreich gestartet wurde.
Wenn Sie `docker-compose up -d` ausführen, können Sie nscale Pipeliner nach einer Konfigurationsänderung neu starten.

Das Volume "pipeliner_data" wird auf "/opt/ceyoniq/nscale-pipeliner/workdir/data" gemapped.
Hier können Sie z.B. den Ordner "import" finden.

## Application Cluster

Sie können das Standard Application Layer Cluster Setup (UDP multicast) auch in compose verwenden.
Wählen Sie dazu die proxy Konfiguration und skalieren Sie nscale Server Application Layer über docker-compose.
Verwenden Sie dazu die folgenden Kommandos:

 ```bash
cat .env
  COMPOSE_FILE=docker-compose.yml:docker-compose.proxy.yml

# scale up and down with
docker-compose up -d --scale application-layer=2
 ```

## Externe Tools

## Log Aggregation

 Sie können den Loki-Protokollierungstreiber hinzufügen, um Log-Aggregation durch Loki und Grafana verwenden zu können.
 Verwenden Sie dazu die folgenden Kommandos:

 ```bash
docker plugin install grafana/loki-docker-driver:latest --alias loki --grant-all-permissions
```

Starten Sie anschließend den Docker-Daemon neu.

Weitere Informationen zu Loki und Grafana im Docker-Umfeld finden Sie unter: <https://github.com/grafana/loki/blob/master/docs/sources/clients/docker-driver/_index.md>.

### Logs exportieren

Die Log Dateien der einzelnen Komponenten können aus Loki exportiert werden.
Dazu ist es notwendig, das Kommandozeilentool [LogCLI](https://grafana.com/docs/loki/latest/getting-started/logcli/) nachzuinstallieren. Verwenden Sie die folgenden Kommandos:

```bash
# Tool installieren
wget https://github.com/grafana/loki/releases/download/v1.4.1/logcli-linux-amd64.zip
unzip logcli-linux-amd64.zip
sudo mv logcli-linux-amd64 /usr/local/bin/logcli
rm logcli-linux-amd64.zip
```

Mit diesem Tool können die Logs der Container abgefragt werden.

```bash
# loki Addresse
export LOKI_ADDR=http://localhost:3100/

# Labels anzeigen
logcli labels
logcli labels container_name
# application layer logs
logcli query '{container_name="nscale_application-layer_1"}'
# application layer web Warnungslogs
logcli query '{compose_service="application-layer-web"} |= "WARNING"'
# Logs von einem spezifischen Zeitraum exportieren
logcli query '{compose_service="application-layer"}' --from=2020-12-07T08:06:09Z --to=2020-12-07T12:06:26Z --quiet > /tmp/log.txt
```

Alternativ können Sie LogCLI mit dem Container "grafana/logcli" verwenden.
Verwenden Sie dazu die folgenden Kommandos:

```bash
# verbindet sich mit dem Loki Endpoint in der nscale Netzwerk 
# und zeigt die verfügbaren Labels
docker run --rm -it \
--network=nscale_nscale \
--env LOKI_ADDR=http://loki:3100 \
grafana/logcli:master-72b4c01-amd64 \
labels
```

## Prometheus Anbindung

Die nscale Komponenten werden weiterhin über die nscale Monitoring Console überwacht, die als Container im compose mit gestartet wird. Die Integration der nscale Komponenten als Resource wird wie bisher über den Administrator verwaltet.

Für [Prometheus](https://prometheus.io/) stehen zwei Endpunkte zur Verfügung. Beide sind über Basic-Auth geschützt und brauchen deshalb ein Password für die Monitoring Console. Die Benutzerverwaltung ist über den Administrator verfügbar.

Der erste Endpunkt liefert Informationen zur Monitoring Console selbst während der zweite Endpunkt Metriken der eingebundenen nscale Komponenten als Prometheus Sensoren zur Verfügung stellt.

- /nscalemc/rest/metrics
- /nscalemc/rest/metrics/nscale
