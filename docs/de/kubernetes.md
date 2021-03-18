# nscale Standard Container in Kubernetes

If you run a Kubernetes environment, chances are you’ve customized a Kubernetes configuration — you've copied some API object YAML files and edited them to suit your needs.

But there are drawbacks to this approach — it can be hard to go back to the source material and incorporate any improvements that were made to it. Today Google is announcing kustomize, a command-line tool contributed as a subproject of SIG-CLI. The tool provides a new, purely declarative approach to configuration customization that adheres to and leverages the familiar and carefully designed Kubernetes API.

Here’s a common scenario. Somewhere on the internet you find someone’s Kubernetes configuration for a content management system. It's a set of files containing YAML specifications of Kubernetes API objects. Then, in some corner of your own company you find a configuration for a database to back that CMS — a database you prefer because you know it well.

## Inhalt

- [Kubernetes Deployment mit [Kustomize]](#kubernetes-deployment-mit-kustomize)
  - [Inhalt](#inhalt)
  - [Kurz und knapp](#kurz-und-knapp)
  - [Grundlagen](#grundlagen)
  - [Persistierung](#betrieb-und-persistierung)
    - [emptyDir](#emptydir)
    - [HostPath](#hostpath)
    - [Azure](#azure)
  - [Ingress Regeln](#ingress-regeln)
  - [Konfiguration mit nscale Administrator](#konfiguration-mit-nscale-administrator)
  - [Logs exportieren](#logs-exportieren)
  - [Prometheus Anbindung](#prometheus-anbindung)

## Kurz und knapp

- Sie haben einen Kubernetes-Cluster den Sie mit `kubectl` erreichen können
- Sie haben einen Ingress-Controller eingerichtet

Dieses Beispiel berücksichtigt den Betrieb mit Linux. Wenn sie mit Windows arbeiten, müssen sie unter umständen die Dateipfade ändern.

Führen Sie folgende Kommandos im Ordner `kubernetes/kustomize/nscale/overlays/emptyDir/` aus:

```bash
kubectl create namespace nscale
kubectl apply --namespace nscale -k .
```

Sie benötigen einen [Ingress](https://kubernetes.io/docs/concepts/services-networking/ingress/) um auf die jeweiligen nscale-Komponenten zugreifen zu können.
Führen Sie folgendes Kommando im Ordner `kubernetes/kustomize/nscale/` aus:

```bash
kubectl apply --namespace nscale ingress.yaml
```

Fertig! Sie können jetzt unter <http://localhost/> auf Ihr nscale zugreifen.

## Grundlage

>Diese Architektur ist eine **Demo Konfigruation**. Für Produktivsysteme müssen Sie andere angepasste Varianten
konfigurieren, die u.a. keinen RMS verwenden und das horizontale Skalieren unterstützen sowie die Volumes sichern.

Die nscale Basiskonfiguration ist im Verzeichnis "base" abgelegt.
Das Verzeichnis "overlay" enthält Ableitungen für unterschiedliche Umgebungen.
Jede konkrete nscale Installation wird in einem eigenen *Namespace* installiert.
Dazu wird mindestens eine Lizenzdatei, sowie ein voll qualifizierter Hostname benötigt.

Die Basiskonfiguration berücksichtigt den RMS als *Sidecar* Container um auf die Konfiguration des Server zuzugreifen.
Deshalb muss jede Instanz der nscale Container (nscale Server Application Layer, nscale Server Application Layer Web, nscale Rendition Server, nscale Monitoring Console) einen eigenen RMS Server verwenden.
Angesprochen wird der RMS sowie die individuelle nscale Komponente über *Port Forwarding* auf dem lokalen Rechner (siehe unten).

Änderungen über den RMS müssen persistent gemacht werden.
In dem einfachen nscale Deployment werden *keine* persistenten Volumes verwendet.
Deshalb ist der RMS in dieser Konfiguration nur für den lesenden Zugriff.
In weiteren Ableitung werden unterschiedliche Volumes eingebunden, die einem Restart der *Pods* überdauern.

Von außen erreichbar sind die Web Schnittstellen der Komponente über *Ingress* Regeln.
Dazu wird ein eindeutiger voll qualifizierter Hostname für jede nscale Installation angegeben. (siehe unten)

## Persistierung

### emptyDir

Alle Dateien werden gelöscht, nachdem die nscale-Services wieder herunter gefahren werden.
Siehe dazu: <https://kubernetes.io/docs/concepts/storage/volumes/#emptydir>

```bash
# deployment
kubectl apply -k overlays/emptydir/ --namespace=nscale

# delete installation
kubectl delete -k overlays/emptydir/ --namespace=nscale
```

### HostPath

Alle Dateien werden auf der lokalen Festplatte gespeichert.  
Siehe dazu: <https://kubernetes.io/docs/concepts/storage/volumes/#hostpath>

```bash
# deployment
kubectl apply -k overlays/hostPath/ --namespace=nscale

# delete installation
kubectl delete -k overlays/hostPath/ --namespace=nscale
```

### Azure

Alle Dateien werden auf AzureDisk oder AzureFiles gespeichert.

Siehe dazu:  

- <https://kubernetes.io/docs/concepts/storage/volumes/#azurefile>
- <https://kubernetes.io/docs/concepts/storage/volumes/#azuredisk>

```bash
# deployment
kubectl apply -k overlays/azure/ --namespace=nscale

# delete installation
kubectl delete -k overlays/azure/ --namespace=nscale
```

## Ingress Regeln

Die Definition der Ingress Regeln für den öffentlichen HTTP(s) Zugriff auf die nscale Komponenten hängt von der Cloud Umgebung ab.

Der Domain Name muss im Netzwerk bekannt sein. Im einfachsten Fall können Sie auf einen logischen Hostname verzichten und die Anwendung direkt über den Rechnernamen des Clusters ansprechen.

```bash
# Zugriff über den Cluster Hostname
kubectl apply -f ingress.yaml --namespace=nscale
```

Weitere Informationen zur Ingress Konfiguration finden Sie in der Dokumentation Ihres Cloud Betreibers.

## Konfiguration mit nscale Administrator

Für den Zugriff mit nscale Administrator auf ein über localhost laufendes und die standrad Ports verwendendes nscale ist es notwendig, dass Sie einige Kommandos ausführen.  
Um an die standard nscale Ports im Cluster zu gelangen können Sie mit kubectl ein *Port Forwarding* auf den lokalen Rechner installieren.
Dabei hat jeder nscale Pod einen Sidecar RMS Container, der Zugriff auf die Konfigurationsdateien des Anwendungsservers hat.

```bash
# Zugriff auf individuelle Server im StatefulSet
kubectl port-forward --address 0.0.0.0 pod/application-layer-0 3120:3120 8080:8080 8443:8443 -n nscale
kubectl port-forward --address 0.0.0.0 pod/storage-layer-0 3121:3120 3005:3005 -n nscale

# Zugriff über das Deployment: wird das Deployment skaliert werden Anfragen aus alle backend Server verteilt.
kubectl port-forward --address 0.0.0.0 deployment/application-layer-web 3122:3120 8090:8090 8091:8091 -n nscale
kubectl port-forward --address 0.0.0.0 deployment/rendition-server 3123:3120 8192:8192 8193:8193 -n nscale
kubectl port-forward --address 0.0.0.0 deployment/monitoring-console 3124:3120 8387:8387 8388:8388 -n nscale
kubectl port-forward --address 0.0.0.0 deployment/pipeliner 3125:3120 -n nscale
```

## Logs exportieren

Die Log-Dateien der einzelnen Komponenten können z.B. aus Loki exportiert werden.

Dazu können Sie z.B. das Kommandozeilentool [LogCLI](https://grafana.com/docs/loki/latest/getting-started/logcli/) mit der Image `grafana/logcli` verwenden.

Beispiel:

```bash
kubectl run logcli --rm -it \
--image=grafana/logcli:master-72b4c01-amd64 \
--namespace=loki-stack \
--env=LOKI_ADDR=http://loki:3100  \
--restart=Never \
-- query '{namespace="nscale", app="application-layer"}' --quiet --from=2020-12-06T08:06:09Z --to=2020-12-07T12:06:26Z --limit=10000 > /c/tmp/log.txt
```

## Prometheus Anbindung

Die nscale Komponenten werden weiterhin über die nscale Monitoring Console überwacht, die als Deployment im Cluster mit läuft. Die Integration der nscale Komponenten als Resource wird wie bisher über den Administrator verwaltet.

Für [Prometheus](https://prometheus.io/) stehen zwei Endpunkte zur Verfügung. Beide sind über Basic-Auth geschützt und brauchen deshalb ein Password für die Monitoring Console. Die Benutzerverwaltung ist über den Administrator verfügbar.

Der erste Endpunkt liefert Informationen zur Monitoring Console selbst während der zweite Endpunkt Metriken der eingebundenen nscale Komponenten als Prometheus Sensoren zur Verfügung stellt.

- /nscalemc/rest/metrics
- /nscalemc/rest/metrics/nscale
