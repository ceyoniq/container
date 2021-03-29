# nscale Standard Container mit Docker-Compose

In dieser Dokumentation finden Sie Informationen dazu, wie Sie nscale mit Docker-Compose betreiben können.  
Weitere Information zu Docker-Compose finden Sie unter <https://docs.docker.com/compose>.

Der Betrieb von nscale Standard Container mit Docker-Compose hat folgende Vorteile:

- sehr einfache Installation im Single-Server-Betrieb
- ideal für die Entwicklung mit nscale
- schnelles Erzeugen eines Demo- und Test-Systems

> Bitte beachen Sie, dass es sich bei den Konfigurationen in diesem Repository um **Beispielkonfigurationen** handelt.  
> Für Produktivsysteme müssen Sie ggf. Anpassungen an den vorliegenden Konfigurationen vornehmen.

## Inhalt

- [nscale Standard Container mit Docker-Compose](#nscale-standard-container-mit-docker-compose)
  - [Inhalt](#inhalt)
  - [Quick Start Guide](#quick-start-guide)
  - [Grundlagen](#grundlagen)
  - [docker-compose Beispielszenarien](#docker-compose-beispielszenarien)
  - [Zugriff über nscale Administrator](#zugriff-über-nscale-administrator)
  - [nscale Pipeliner](#nscale-pipeliner)
  - [Log Aggregation mit Loki](#log-aggregation-mit-loki)
    - [Logs exportieren](#logs-exportieren)
  - [Prometheus Anbindung](#prometheus-anbindung)
  - [Limitierungen](#limitierungen)
  - [FAQ](#faq)

## Quick Start Guide

> Dieses Beispiel berücksichtigt den Betrieb mit **Linux**.  
> Wenn Sie mit Windows arbeiten, müssen Sie unter umständen die Dateipfade aus diesem Beispiel ändern.  
> Die Ceyoniq Technology GmbH übernimmt keine Gewährleistung und Haftung für die Funktionsfähigkeit, Verfügbarkeit, Stabilität und Zuverlässigkeit von Software von Drittanbietern, die nicht Teil der nscale Standard Container ist.

Stellen Sie vor dem Start der nscale Standard Container mit Docker-Compose sicher, dass Sie die folgenden Voraussetzungen erfüllt haben:

- Sie haben eine lauffähige Docker-Installation (ab Version 20.10.2)
- Sie haben Docker-Compose (ab Version 1.27.4) installiert
- Sie besitzen eine gültige **Lizenzdatei**

Starten Sie die nscale Standard Container:

1. Kopieren Sie Ihre Lizenzdatei `license.xml` in den Ordner `compose/nscale`.  
2. Im Order `compose/nscale` kopieren Sie die Datei `docker-compose.example.env` nach `.env`.
3. Führen Sie im Order `compose/nscale` folgende Kommandos aus:

```bash
docker-compose up -d
```

4. Fertig!  
Sie können nun unter <http://localhost> auf Ihr nscale zugreifen.

Bei der ersten Anmeldung können Sie die Standard-Anmeldedaten verwenden, die beim Start eines neuen nscale Systems automatisch erstellt werden.
Ändern Sie diese Anmeldedaten für den Produktivbetrieb umgehend.
Die Standard-Anmeldedaten lauten:

```txt
User: admin
Password: admin
```

## Grundlagen

>Dies ist eine **Beispielkonfigurationen**. Für Produktivsysteme müssen Sie andere angepasste Varianten konfigurieren.

Compose ist ein Werkzeug zur Definition und Ausführung von Multi-Container-Docker-Anwendungen.
Mit Compose verwenden Sie eine YAML-Datei, um die Dienste Ihrer Anwendung zu konfigurieren.
Sie können dann mit einem einzigen Befehl alle Dienste aus Ihrer Konfiguration starten.

Weitere Informationen zu Docker-Compose finden Sie hier:
<https://docs.docker.com/compose>

Weitere Information zu den nscale Standard Containern finden Sie hier:

- [nscale/application-layer (nscale Server Application Layer)](components/application-layer.md)
- [nscale/application-layer-web (nscale Server Application Layer Web)](components/application-layer-web.md)
- [nscale/storage-layer (nscale Server Storage Layer)](components/storage-layer.md)
- [nscale/rendition-server (nscale Rendition Server)](components/rendition-server.md)
- [nscale/console (nscale Console)](components/console.md)
- [nscale/monitoring-console (nscale Monitoring Console)](components/monitoring-console.md)
- [nscale/pipeliner (nscale Pipeliner)](components/pipeliner.md)
- [nscale/cmis-connector (nscale CMIS-Connector)](components/cmis-connector.md)
- [nscale/webdav-connector (nscale WebDAV-Connector)](components/webdav-connector.md)
- [nscale/ilm-connector (nscale ERP Connector ILM)](components/ilm-connector.md)

> Die Ceyoniq Technology GmbH übernimmt keine Gewährleistung und Haftung für die Funktionsfähigkeit, Verfügbarkeit, Stabilität und Zuverlässigkeit von Software von Drittanbietern, die nicht Teil der oben aufgelisteten nscale Standard Container ist.
> Weiter erfolgt der Einsatz von Software von Drittanbietern wie Loki, Grafana, Prometheus, etc. hier zum Zweck der Darstellung innerhalb einer Beispielkonfiguration.

## docker-compose Beispielszenarien

Im Ordner `nscale` befinden sich die Basis-Docker-Compose-Datei (`docker-compose.yml`) und andere ergänzende Compose-Dateien.
Wenn diese Dateien kombiniert werden, führt das `docker-compose up`-Kommando diese zusammen und führt ein Deployment durch.
In der Datei `docker-compose.example.env` finden Sie verschiedene Möglichkeit nscale zu betreiben.

**docker-compose.proxy.yml**  
Diese Konfiguration bietet eine Unterstützung von Traefik (<https://docs.traefik.io>) als Reverse Proxy.  
So können Sie nscale Server Application Layer Web, nscale Server Application Layer und nscale Console über den Port 80 erreichen.

**docker-compose.proxy-with-ssl.yml**  
Diese Konfiguration bietet eine Unterstützung von Traefik (<https://docs.traefik.io>) als Reverse Proxy und SSL mit Let's Encrypt.
So können Sie nscale Server Application Layer Web, nscale Server Application Layer und nscale Console über den Port 443 erreichen.
Beachten Sie, dass der Rechner, auf dem Sie nscale installieren wollen, aus dem Internet erreichbar sein muss, um ein Zertifikat bekommen zu können.

**docker-compose.default-ports.yml**  
Mit dieser Konfiguration werden alle nscale default Ports freigegeben. Diese Ports sind: 5432 (Postgres), 3005, 8080, 8443, 8090, 8091, 8086, 8087, 8387, 8388, 8192 und 8193.  

**docker-compose.pipeliner.yml**  
In dieser Konfiguration wird nscale Pipeliner verwendet.

**docker-compose.analytics.yml**  
Diese Konfiguration bietet Grafana, Prometheus und Loki  Unterstützung.  
Für Loki werden Treiber für Docker benötigt, eine Liste dieser Treiber finden Sie unter [Log Aggregation](##log-aggegation).

>**Weitere Compose-Szenarien**  
Außerdem haben Sie die Möglichkeit eigene YAML-Dateien zu erstellen und so eine Konfiguration zu erstellen, die auf Ihre Bedürfnisse abgestimmt ist.

## Zugriff über nscale Administrator

> Sie benötigen nscale Administrator ab Version 8.0.500.

Für den Zugriff mit nscale Administrator auf Ihre nscale-Installation innerhalb Docker-Compose, steht Ihnen der **kein RMS**-Modus (nscale Remote Management Service) zur Verfügung.
Erzeugen Sie eine neue Komponenten-Gruppe im nscale Administrator, um den **kein RMS**-Modus zu verwenden und auf die jeweiligen nscale-Komponenten zugreifen zu können.

Um nscale Server Application Layer zu konfigurieren, Können Sie sich mit nscale Administrator an Ihrem nscale-System anmelden.  
Wenn Sie die Konfigurationsdatei `docker-compose.proxy.yml` verwenden, ist nscale Server Application Layer auf `localhost` zu erreichen.  
Wenn Sie die Konfigurationsdatei `docker-compose.default-ports.yml` verwenden, ist nscale Server Application Layer zusätzlich auf `localhost:8080` zu erreichen.  

## nscale Pipeliner

Damit Sie nscale Pipeliner verwenden können, muss in der .env-Datei die Konfigurationsdatei `docker-compose.pipeliner.yml` verwendet werden.
In der dort hinterlegten Standardkonfiguration kann nscale Pipeliner nicht starten sondern muss zuerst konfiguriert werden.
Wenn nscale Pipeliner nicht startet, können Sie mit Hilfe von nscale Administrator die Konfiguration von nscale Pipeliner anpassen.
Die verschiedenen Möglichkeiten zur Konfiguration von nscale Pipeliner finden Sie in der Dokumentation in unserem [Serviceportal](<https://serviceportal.ceyoniq.com/>).
Wenn Sie das Kommando `docker-compose up -d` ausführen, können Sie nscale Pipeliner nach einer Konfigurationsänderung neu starten.
Anschließend können Sie mit dem Kommando `docker-compose logs pipeliner` überprüfen, ob nscale Pipeliner erfolgreich gestartet wurde.

Weitere Informationen zum Pipeliner: <pipeliner.md>

## Log Aggregation mit Loki

 Sie können den Loki-Protokollierungstreiber hinzufügen, um Log-Aggregation durch Loki und Grafana verwenden zu können.
 Verwenden Sie dazu die folgenden Kommandos:

 ```bash
docker plugin install grafana/loki-docker-driver:latest --alias loki --grant-all-permissions
```

Starten Sie anschließend den Docker-Daemon neu.

Weitere Informationen zu Loki und Grafana im Docker-Umfeld finden Sie unter: <https://github.com/grafana/loki/blob/master/docs/sources/clients/docker-driver/_index.md>.

### Logs exportieren

Die Log-Dateien der einzelnen Komponenten können aus Loki exportiert werden.
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
# loki Adresse
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

Alternativ können Sie LogCLI mit dem Container `grafana/logcli` verwenden.
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

Die nscale-Komponenten werden auch im Container-Betrieb über nscale Monitoring Console überwacht, die als Container in Compose mit gestartet wird. Die Integration der nscale-Komponenten als Resource wird wie bisher über nscale Administrator verwaltet.

Für [Prometheus](https://prometheus.io/) stehen zwei Endpunkte zur Verfügung. Beide sind über Basic-Auth geschützt und brauchen deshalb ein Password für nscale Monitoring Console. Die Benutzerverwaltung ist über nscale Administrator verfügbar.

Der erste Endpunkt liefert Informationen zu nscale Monitoring Console, während der zweite Endpunkt Metriken der eingebundenen nscale-Komponenten als Prometheus Sensoren zur Verfügung stellt.

- /nscalemc/rest/metrics
- /nscalemc/rest/metrics/nscale

## Limitierungen

Informationen zu Limitierungen finden Sie hier:  
[limitation.md](limitation.md)

## FAQ

Das FAQ finden Sie hier:  
[faq.md](faq.md)
