# nscale Standard Container in Kubernetes

In dieser Dokumentation finden Sie Informationen dazu, wie Sie nscale mit Kubernetes betreiben können.  
Weitere Information zu Kubernetes finden Sie unter <https://kubernetes.io>.

Der Betrieb von nscale Standard Container mit Kubernetes hat folgende Vorteile:

- Clusterbildung möglich
- Fehlertoleranz
- flexible Skalierbarkeit
- einfache Installation in Cloud-Umgebungen (z. B. in [Microsoft Azure Kubernetes Service - AKS](https://azure.microsoft.com/de-de/services/kubernetes-service/))

> Bitte beachen Sie, dass es sich bei den Konfigurationen in diesem Repository um **Beispielkonfigurationen** handelt.  
> Für Produktivsysteme müssen Sie ggf. Anpassungen an den vorliegenden Konfigurationen vornehmen.

## Inhalt

- [nscale Standard Container in Kubernetes](#nscale-standard-container-in-kubernetes)
  - [Inhalt](#inhalt)
  - [Quick Start Guide](#quick-start-guide)
  - [Grundlagen](#grundlagen)
  - [Ingress](#ingress)
  - [Persistierung](#persistierung)
    - [emptyDir](#emptydir)
    - [HostPath](#hostpath)
    - [Azure](#azure)
  - [Zugriff mit nscale Administrator](#konfiguration-mit-nscale-administrator)
  - [Logging](#logging)
  - [Metriken](#metriken)
  - [Limitierungen](#limitierungen)
  - [FAQ](#faq)

## Quick Start Guide

> Dieses Beispiel berücksichtigt den Betrieb mit **Linux**.  
> Wenn Sie mit Windows arbeiten, müssen Sie unter Umständen die Dateipfade ändern.  
> Die Ceyoniq Technology GmbH übernimmt keine Gewährleistung und Haftung für die Funktionsfähigkeit, Verfügbarkeit, Stabilität und Zuverlässigkeit von Software von Drittanbietern, die nicht Teil der nscale Standard Container ist.

Stellen Sie vor dem Start der nscale Standard Container mit kubernetes sicher, dass Sie die folgenden Voraussetzungen erfüllt haben:

- Sie haben einen Kubernetes-Cluster (ab Version 1.19.3), den Sie mit `kubectl` erreichen können
- Sie haben einen [NGINX Ingress Controller](https://kubernetes.github.io/ingress-nginx/) eingerichtet
- Sie besitzen eine gültige **Lizenzdatei**

Starten Sie die nscale Standard Container:

1. Kopieren Sie Ihre Lizenzdatei `license.xml` in den Ordner `kubernetes/kustomize/nscale/base/`.  
2. Führen Sie nun folgende Kommandos im Ordner `kubernetes/kustomize/nscale/overlays/emptyDir/` aus:

```bash
kubectl create namespace nscale
kubectl apply --namespace nscale -k .
```

3. Sie können prüfen, ob die jeweiligen `Pods` erfolgreich gestartet werden konnten.

```bash
 kubectl get pods -n nscale -w
```

4. Warten Sie bis alle `Pods` den Status `Running` melden.  
5. Rufen Sie folgendes Kommando auf:

```bash
kubectl port-forward --address 0.0.0.0 deployment/application-layer-web 8090:8090 -n nscale
```

6. Fertig!  
Sie können nun unter <http://localhost:8090> auf Ihr nscale zugreifen.

Bei der ersten Anmeldung können Sie die Standard-Anmeldedaten verwenden, die beim Start eines neuen nscale Systems automatisch erstellt werden.
Ändern Sie diese Anmeldedaten für den Produktivbetrieb umgehend.
Die Standard-Anmeldedaten lauten:

```txt
User: admin
Password: admin
```

> Für den Produktiveinsatz wird ein Ingress-Controller empfohlen.
> Weitere Informationen dazu finden Sie in diesem Dokument.

## Grundlagen

>Dies ist eine **Beispielkonfiguration**. Für Produktivsysteme müssen Sie andere angepasste Varianten konfigurieren.

In diesem Beispiel wird Kustomize verwendet.
Durch Kustomize können Sie leicht Anpassungen von Kubernetes-Deployments zur Erzeugung mehrerer Varianten (z. B. für unterschiedliche Umgebungen) vornehmen.
Dabei werden die originalen YAML-Dateien nicht modifiziert, sondern mit Overlays überlagert.
Im Gegensatz zu Helm kommt Kustomize so ganz ohne Templates aus, was die Verwendung besonders einfach macht.

Weitere Informationen zu Kustomize finden Sie hier:  
<https://kubernetes.io/docs/tasks/manage-kubernetes-objects/kustomization>

Die nscale Basiskonfiguration ist im Verzeichnis `base` abgelegt.
Das Verzeichnis `overlay` enthält Ableitungen für unterschiedliche Umgebungen.
Jede konkrete nscale Installation wird in einem eigenen **Namespace** installiert.
Dazu werden mindestens eine Lizenzdatei sowie ein voll qualifizierter Hostname benötigt.

Die Web Schnittstellen der Komponente sind von außen über **Ingress** Regeln erreichbar.
Dazu wird ein eindeutiger voll qualifizierter Hostname für jede nscale Installation angegeben.

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

## Ingress

> Beachten Sie, dass die Ingress-Konfiguration keine Informationen zu Ihrem Hostname beinhaltet.
> Somit werden alle Anfragen an Ihren Cluster durch diesen Ingress verarbeitet.
> Passen Sie die Ingress-Konfiguration bei Bedarf an.

```bash
# Zugriff über den Cluster Hostname
kubectl apply -f ingress.yaml -n nscale
```

Weitere Informationen zur Ingress Konfiguration finden Sie in der Dokumentation Ihres Cloud-Betreibers.

Um auf die jeweiligen nscale-Komponenten zugreifen zu können, benötigen Sie einen [Ingress](https://kubernetes.io/docs/concepts/services-networking/ingress/).
In diesem Beispiel wird ein [NGINX Ingress Controller](https://kubernetes.github.io/ingress-nginx/) erwartet.
Passen Sie die Ingress-Regeln an, wenn Sie einen anderen Ingress-Controller verwenden wollen oder eine OpenShift-`Route` bevorzugen.  
Führen Sie zur Verwendung der Beispielkonfiguration folgendes Kommando im Ordner `kubernetes/kustomize/nscale/` aus:

```bash
kubectl apply --namespace nscale ingress.yaml
```

Informationen über die gesetzten Ingress-Regeln können Sie abrufen, indem Sie die folgenden Kommandos ausführen:  

```bash
# Übersicht über alle Ingress-Regeln in Ihrem Cluster
kubectl get ingress -A

# Informationen über die Ingress-Regeln Ihrer nscale-Installation 
kubectl describe ingress ingress-nscale -n nscale
```

## Persistierung

In diesem Beispiel wird Ihnen gezeigt, wie Sie Daten innerhalb Kubernetes speichern können. Je nach Kubernetes-Umgebung können sich die Persistierungsmöglichkeiten bei Ihnen unterscheiden.

Alle Beispiele müssen im Ordner `kubernetes/kustomize/nscale` ausgeführt werden.

### emptyDir

Alle Dokumente und Datenbankeinträge werden **gelöscht**, nachdem die nscale-Services wieder heruntergefahren wurden.

> **Achtung! Datenverlust!**  
> Da alle Dokumente und Datenbankeintäge beim Herunterfahren der nscale-Services gelöscht werden, ist diese Einstellung **nur für den Test- und Demobetrieb geeignet**.  

Weitere Informationen: <https://kubernetes.io/docs/concepts/storage/volumes/#emptydir>

Anlegen aller Ressourcen:

```bash
kubectl apply -k overlays/emptydir/ -n nscale
```

Löschen aller Ressourcen:

```bash
kubectl delete -k overlays/emptydir/ -n nscale
```

### HostPath

Alle Dateien werden auf der lokalen Festplatte eines `Nodes` gespeichert.  

Weitere Informationen: <https://kubernetes.io/docs/concepts/storage/volumes/#hostpath>

Anlegen aller Ressourcen:

```bash
kubectl apply -k overlays/hostPath/ -n nscale
```

Löschen aller Ressourcen (außer PVs und PVCs):

```bash
kubectl delete -k base/ -n nscale
```

Löschen aller Ressourcen (PVs und PVCs werden **gelöscht**)
> **Achtung! Datenverlust!**  
> Wenn die PVs und PVCs gelöscht werden, können die darin gespeicherten Daten nicht wiederhergestellt werden.

```bash
kubectl delete -k overlays/hostPath/ -n nscale
```

### Azure

Alle Dateien werden auf AzureDisk oder AzureFiles gespeichert.

Weitere Informationen:  

- <https://kubernetes.io/docs/concepts/storage/volumes/#azurefile>
- <https://kubernetes.io/docs/concepts/storage/volumes/#azuredisk>

Anlegen aller Ressourcen:

```bash
kubectl apply -k overlays/azure/ -n nscale
```

Löschen aller Ressourcen (außer PVs und PVCs):

```bash
kubectl delete -k base/ -n nscale
```

Löschen aller Ressourcen (PVs und PVCs werden **gelöscht**)
> **Achtung! Datenverlust!**  
> Wenn die PVs und PVCs gelöscht werden, können die darin gespeicherten Daten nicht wiederhergestellt werden.

```bash
kubectl delete -k overlays/azure/ -n nscale
```

## Zugriff mit nscale Administrator

> Sie benötigen nscale Administrator ab Version 8.0.5000.

Für den Zugriff mit nscale Administrator auf Ihre nscale-Installation innerhalb Kubernetes steht Ihnen der **kein RMS**-Modus (RMS = nscale Remote Management Service) zur Verfügung. Erzeugen Sie eine neue Komponenten-Gruppe in nscale Administrator, um den **kein RMS**-Modus zu verwenden und auf die jeweiligen nscale-Komponenten zugreifen zu können.

Weitere Informationen finden Sie hier: [limitation.md](limitation.md)

Damit Sie von außerhalb Ihres Kubernetes-Cluster auf die jeweiligen nscale-Komponenten zugreifen können, müssen die Ports der nscale-Komponenten durch ein `kubectl port-forward` auf Ihr lokales System weiterleitet werden.

```bash

# stateful set
kubectl port-forward --address 0.0.0.0 pod/application-layer-0 080:8080 8443:8443 -n nscale
kubectl port-forward --address 0.0.0.0 pod/storage-layer-0 3005:3005 -n nscale

# deployment
kubectl port-forward --address 0.0.0.0 deployment/application-layer-web 8090:8090 -n nscale
kubectl port-forward --address 0.0.0.0 deployment/rendition-server 8192:8192 -n nscale
kubectl port-forward --address 0.0.0.0 deployment/monitoring-console 8387:8387 -n nscale
kubectl port-forward --address 0.0.0.0 deployment/pipeliner 3125:3120 -n nscale
```

## Logging

Alle nscale Standard Container schreiben ihre Logging-Informationen auf StdOut.
Mit etablierten Tools, wie zum Beispiel [Loki](https://grafana.com/oss/loki/), können Sie deshalb Logs aggregieren.
Sie können die jeweiligen Logging-Ausgaben wie folgt abrufen:  

```bash
# Alle Log-Ausgabe des ersten application-layer
kubectl logs application-layer-0 -n nscale
```

Weitere Informationen zum Thema Logging in Kubernetes finden Sie hier:  
<https://kubernetes.io/docs/concepts/cluster-administration/logging>

## Metriken

Die nscale-Komponenten werden weiterhin über nscale Monitoring Console überwacht, die als Deployment im Cluster verfügbar ist. Die Integration der nscale-Komponenten als Ressource wird wie bisher über nscale Administrator verwaltet.

Für [Prometheus](https://prometheus.io/) stehen zwei Endpunkte zur Verfügung. Beide sind über Basic-Auth geschützt und brauchen deshalb ein Passwort für nscale Monitoring Console. Die Benutzerverwaltung ist über nscale Administrator verfügbar.

Der erste Endpunkt liefert Informationen zu nscale Monitoring Console, während der zweite Endpunkt Metriken der eingebundenen nscale-Komponenten als Prometheus Sensoren zur Verfügung stellt.

- /nscalemc/rest/metrics
- /nscalemc/rest/metrics/nscale

## Limitierungen

Informationen zu Limitierungen finden Sie hier:  
[limitation.md](limitation.md)

## FAQ

Das FAQ finden Sie hier:  
[faq.md](faq.md)