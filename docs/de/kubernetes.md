# nscale Standard Container in Kubernetes

In dieser Dokumentation finden Sie Informationen dazu, wie Sie nscale mit Kubernetes betreiben können.  
Weitere Information zu Kubernetes findet Sieh unter [https://kubernetes.io/](https://kubernetes.io/).

Der Betrieb von nscale Standard Container mit Kubernetes hat folgende Vorteile:

- Clusterbildung möglich
- Fehlertoleranz
- flexible Skalierbarkeit
- einfache Installation in Cloud-Umgebungen (z.B in [Microsoft Azure Kubernetes Service - AKS](https://azure.microsoft.com/de-de/services/kubernetes-service/))

> Bitte beachen Sie, dass es sich hierbei um **Beispielkonfigurationen** handelt.  
> Für Produktivsysteme müssen ggf. Anpassungen vornehmen.

## Inhalt

- [nscale Standard Container in Kubernetes](#nscale-standard-container-in-kubernetes)
  - [Inhalt](#inhalt)
  - [Quick Start Guide](#quick-start-guide)
  - [Grundlage](#grundlage)
  - [Ingress](#ingress)
  - [Persistierung](#persistierung)
    - [emptyDir](#emptydir)
    - [HostPath](#hostpath)
    - [Azure](#azure)
  - [Konfiguration mit dem nscale Administrator](#konfiguration-mit-dem-nscale-administrator)
  - [Logging](#logging)
  - [Zeitzone](#zeitzone)
  - [Metriken](#metriken)

## Quick Start Guide

> Dieses Beispiel berücksichtigt den Betrieb mit **Linux**.  
> Wenn sie mit Windows arbeiten, müssen sie unter umständen die Dateipfade ändern.  
> Wir übernehmen keine Gewährleistung und Haftung für die Funktionsfähigkeit, Verfügbarkeit, Stabilität und Zuverlässigkeit von Software von Drittanbietern die nicht Teil der nscale Standard Container sind.

- Sie haben einen Kubernetes-Cluster (ab Version 1.19.3) den Sie mit `kubectl` erreichen können
- Sie haben einen [NGINX Ingress Controller](https://kubernetes.github.io/ingress-nginx/) eingerichtet
- Sie besitzen eine gültige **Lizenzdatei**

Kopieren Sie ihre `license.xml` in den Ordner `kubernetes/kustomize/nscale/base/`.  
Führen Sie nun folgende Kommandos im Ordner `kubernetes/kustomize/nscale/overlays/emptyDir/` aus:

```bash
kubectl create namespace nscale
kubectl apply --namespace nscale -k .
```

Nun können Sie prüfen, ob die jeweiligen `Pods` erfolgreich gestartet werden konnten.

```bash
 kubectl get pods -n nscale -w
```

Warten Sie bis alle `Pods` den Status `Running` melden.  
Im Anschluss rufen Sie bitte folgendes Kommando auf:

```bash
kubectl port-forward --address 0.0.0.0 deployment/application-layer-web 8090:8090 -n nscale
```

Fertig!  

Sie können nun unter <http://localhost:8090> auf Ihr nscale zugreifen.

Bei der ersten Anmeldung können Sie die Standard-Anmeldedaten verwenden, die beim Start eines neuen nscale Systems automatisch erstellt werden.
Ändern Sie diese Anmeldedaten für den Produktivbetrieb umgehend.
Die Standard-Anmeldedaten lauten:

```txt
User: admin
Password: admin
```

> Für den Produktiveinsatz wird ein Ingress-Controller empfohlen.
> Weitere Informationen dazu befinden sich in diesem Dokument

## Grundlage

>Dies ist eine **Beispielkonfigurationen**. Für Produktivsysteme müssen Sie andere angepasste Varianten
konfigurieren.

In diesem Beispiel wird `kustomize` verwendet. Durch `kustomize` können Sie leicht Anpassung von Kubernetes-Deployments zur Erzeugung mehrerer Varianten (z. B. für unterschiedliche Umgebungen) vornehmen. Dabei werden die originalen YAML-Dateien nicht modifiziert, sondern mit Overlays überlagert. Im Gegensatz zu Helm kommt kustomize also ganz ohne Templates aus, was die Verwendung besonders einfach macht.

Weitere Informationen zu kustomize finden Sie hier:  
<https://kubernetes.io/docs/tasks/manage-kubernetes-objects/kustomization/>

Die nscale Basiskonfiguration ist im Verzeichnis `base` abgelegt.
Das Verzeichnis `overlay` enthält Ableitungen für unterschiedliche Umgebungen.
Jede konkrete nscale Installation wird in einem eigenen **Namespace** installiert.
Dazu wird mindestens eine Lizenzdatei, sowie ein voll qualifizierter Hostname benötigt.

Von außen erreichbar sind die Web Schnittstellen der Komponente über **Ingress** Regeln.
Dazu wird ein eindeutiger voll qualifizierter Hostname für jede nscale Installation angegeben.

Weitere Information zu den nscale Standard Containern finden Sie hier:

- [nscale/application-layer (nscale Server Application Layer)](components/application-layer.md)
- [nscale/application-laye-web (nscale Server Application Layer Web)](components/application-layer-web.md)
- [nscale/storage-layer (nscale Server Storage Layer)](components/storage-layer.md)
- [nscale/rendition-server (nscale Rendition Server)](components/rendition-server.md)
- [nscale/console (nscale Console)](components/console.md)
- [nscale/monitoring-console (nscale Monitoring Console)](components/monitoring-console.md)
- [nscale/pipeliner (nscale Pipeliner)](components/pipeliner.md)
- [nscale/cmis-connector (nscale CMIS-Connector)](components/cmis-connector.md)
- [nscale/webdav-connector (nscale WebDAV-Connector)](components/webdav-connector.md)
- [nscale/ilm-connector (nscale ERP Connector ILM)](components/ilm-connector.md)

> Wir übernehmen keine Gewährleistung und Haftung für die Funktionsfähigkeit, Verfügbarkeit, Stabilität und Zuverlässigkeit von Software von Drittanbietern die nicht Teil der nscale Standard Container sind.

## Ingress

> Bitte beachten Sie, dass die Ingress-Konfiguration keine Informationen zu ihrem Hostname beinhaltet.
> Somit werden alle Anfragen an Ihren Cluster durch diesen Ingress verarbeitet.
> Passen Sie die Ingress-Konfiguration bei Bedarf an.

```bash
# Zugriff über den Cluster Hostname
kubectl apply -f ingress.yaml -n nscale
```

Weitere Informationen zur Ingress Konfiguration finden Sie in der Dokumentation Ihres Cloud-Betreibers.

Um auf die jeweiligen nscale-Komponenten zugreifen zu können, benötigen Sie einen [Ingress](https://kubernetes.io/docs/concepts/services-networking/ingress/).
In diesem Beispiel wird ein [NGINX Ingress Controller](https://kubernetes.github.io/ingress-nginx/) erwartet.
Passen Sie die Ingress-Regeln an, wenn Sie eine anderen Ingress-Controller verwenden wollen, oder eine OpenShift-`Route` bevorzugen.  
Führen Sie folgendes Kommando im Ordner `kubernetes/kustomize/nscale/` aus:

```bash
kubectl apply --namespace nscale ingress.yaml
```

Informationen über die gesetzten Ingress-Regeln bekommen Sie über folgende Kommandos:  

```bash
# Übersicht über alle Ingress-Regeln in Ihrem Cluster
kubectl get ingress -A

# Informationen über die Ingress-Regeln Ihrer nscale-Installation 
kubectl describe ingress ingress-nscale -n nscale
```

## Persistierung

### emptyDir

Alle Dokumente und Datenbankeinträge werden **gelöscht**, nachdem die nscale-Services wieder heruntergefahren wurden.

> Diese Einstellungen sind nur für den Test- und Demobetrieb geeignet.  
> **Achtung Datenverlust!**

Weitere Informationen: <https://kubernetes.io/docs/concepts/storage/volumes/#emptydir>

```bash
# deployment
kubectl apply -k overlays/emptydir/ -n nscale

# delete installation
kubectl delete -k overlays/emptydir/ -n nscale
```

### HostPath

Alle Dateien werden auf der lokalen Festplatte eines `Nodes` gespeichert.  

Weitere Informationen: <https://kubernetes.io/docs/concepts/storage/volumes/#hostpath>

```bash
# deployment
kubectl apply -k overlays/hostPath/ -n nscale

# delete installation
kubectl delete -k overlays/hostPath/ -n nscale
```

### Azure

Alle Dateien werden auf AzureDisk oder AzureFiles gespeichert.

Weitere Informationen:  

- <https://kubernetes.io/docs/concepts/storage/volumes/#azurefile>
- <https://kubernetes.io/docs/concepts/storage/volumes/#azuredisk>

```bash
# deployment
kubectl apply -k overlays/azure/ -n nscale

# delete installation
kubectl delete -k overlays/azure/ -n nscale
```

## Konfiguration mit dem nscale Administrator

> Sie benötigen eine nscale Administrator in der Version >= 8.0.500.

Für den Zugriff mit dem nscale Administrator auf Ihre nscale-Installation innerhalb Kubernetes, steht Ihnen **kein RMS** (nscale Remote Management Service) zur Verfügung. Bitte erzeugen Sie eine neue Komponenten-Gruppe im nscale Administrator, um auf die jeweiligen nscale-Komponenten zugreifen zu können.

Weiter Informationen finden Sie hier: [limitation.md](limitation.md)

Damit Sie von außerhalb Ihres Kubernetes-Cluster auf die jeweiligen nscale-Komponenten zugreifen können, müssen die Ports der nscale-Komponenten durch ein `kubectl port-forward` auf Ihr lokal System weiterleitet werden.

```bash

# statefulset
kubectl port-forward --address 0.0.0.0 pod/application-layer-0 080:8080 8443:8443 -n nscale
kubectl port-forward --address 0.0.0.0 pod/storage-layer-0 3005:3005 -n nscale

# deployment
kubectl port-forward --address 0.0.0.0 deployment/application-layer-web 8090:8090 -n nscale
kubectl port-forward --address 0.0.0.0 deployment/rendition-server 8192:8192 -n nscale
kubectl port-forward --address 0.0.0.0 deployment/monitoring-console 8387:8387 -n nscale
kubectl port-forward --address 0.0.0.0 deployment/pipeliner 3125:3120 -n nscale
```

## Logging

Alle nscale Standard Container schreiben Ihre Logging-Informationen auf StdOut.
Somit können Sie mit etablierten Tools, wie zum Beispiel [loki](https://grafana.com/oss/loki/), Logs aggregieren.
Sie können die jeweiligen Logging-Ausgaben wie folgt abrufen:  

```bash
# Alle Log-Ausgabe des ersten application-layer
kubectl logs application-layer-0 -n nscale
```

Weitere Informationen zum Thema Logging in Kubernetes finden Sie hier:  
<https://kubernetes.io/docs/concepts/cluster-administration/logging/>

## Zeitzone

Die nscale Standard Container verwenden UTC als Zeitzone.  
Sie können die Zeitzone für den jeweiligen Container mit folgender Umgebungsvariable setzen:  

```yaml
env:
   - name: TZ
     value: Europe/Berlin
```

## Metriken

Die nscale Komponenten werden weiterhin über die nscale Monitoring Console überwacht, die als Deployment im Cluster verfügbar ist. Die Integration der nscale Komponenten als Resource wird wie bisher über den Administrator verwaltet.

Für [Prometheus](https://prometheus.io/) stehen zwei Endpunkte zur Verfügung. Beide sind über Basic-Auth geschützt und brauchen deshalb ein Password für die Monitoring Console. Die Benutzerverwaltung ist über den Administrator verfügbar.

Der erste Endpunkt liefert Informationen zur Monitoring Console selbst während der zweite Endpunkt Metriken der eingebundenen nscale Komponenten als Prometheus Sensoren zur Verfügung stellt.

- /nscalemc/rest/metrics
- /nscalemc/rest/metrics/nscale
