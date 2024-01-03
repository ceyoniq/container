# Änderungshistorie

Die Releasenotes der Softwarekomponenten finden Sie in unserem [Downloadportal](https://downloadportal.ceyoniq.com/).  
Die aktuelle Liste der Container Images finden Sie [hier](https://github.com/ceyoniq/container/blob/main/docs/de/index.md#nscale-standard-container-images).

## 9.1.1300 (Januar 2024)

* Aktualisierung der Container Images.

## 9.1.1200 (Dezember 2023)

* Aktualisierung der Container Images.
* Einfache Prometheus Annotations für den Application Layer, Rendition Server und der Monitoring Console in der Kubernetes Konfiguration.
* Erweiterungen einiger NetworkPolicies für das Monitoring.
* Update des curl images für init Container.
* Änderung des Standard DB Namespaces und Passworts für die nscale Datenbank. 
* Löschen alter logging Konfigurationsdatei für den application layer.

## 9.1.1100 (November 2023)

* Aktualisierung der Container Images.
* Wechsel der freien True Type Fonts im Basis Image von den Google ([Croscore fonts](https://en.wikipedia.org/wiki/Croscore_fonts)) auf die erweiterten [Liberation Fonts](https://en.wikipedia.org/wiki/Liberation_fonts).
* Erweiterte Fehlerbehandlung im Setup Job zum Erstellen des initialen Dokumentenbereichs in Kubernetes.
* Die Probes im application-layer-web dürfen nicht auf den Root Knoten prüfen weil der ausgelöste Forward ein automatisches Login auslösen kann. Stattdessen muss der Pfade ``/nscale_web/systemConfiguration.xml`` verwendet werden. 

## 9.1.1000 (Oktober 2023)

* Aktualisierung der Container Images.
* Neue Konfiguration des Application Layer Clusters über die Umgebungsvariablen `INSTANCE1_CLUSTER_CORE_STACKTYPE` und `INSTANCE1_JGROUPS_DNS_QUERY`. Damit entfällt die Notwendigkeit eines Service Accounts zum Zugriff auf die Kubernetes API.  
* Fixes der Probes des nscale Process Automation Modelers.
* Fixes der Ports für die Verbindung des nscale Administrators auf die Monitoring Console, Rendition Server und Storage Layers.

## 9.0.1500 (September 2023)

* Aktualisierung der Container Images.
* Der Fulltext Job im Appication Layer ist im Default wieder eingeschaltet.
* Der Process Auomation Modeler verwendet als default Port 8092.
* Die Kubernetes Update Strategie im Application Layer StatefulSet ist im default 'OnDelete' anstatt 'RollingUpdate'. 
  Das Datenbank Update für die Migration auf eine aktuellere Version muss im Application Layer auf einer singulären Instanz durchgeführt werden. 
  Deshalb sollte ein Update unter manueller Kontrolle ausgeführt werden. 
* Hinweise zur Anbindung an eine Azure Postgresql Datenbank.

## 9.0.1400 (August 2023)

* Aktualisierung der Container Images.
* Im default Kubernetes Setup werden der Pipeliner sowie die Konnektoren mit replica=0 deployed. Zuvor müssten die Deployments manuell einkommentiert werden.
* Aktualisierung der kustomize Syntax (https://kubectl.docs.kubernetes.io/references/kustomize/).

## 9.0.1300 (Juli 2023)

* Aktualisierung der Container Images.
* Zusätzliche Umgebungsvariablen für JVM Language Einstellungen über JAVA_OPTS Umgebungsvariable.

## 9.0.1200 (Juni 2023)

Mit dem nscale 9 Release gibt es einige Änderungen in unseren nscale Standard Containern. Wir haben uns insbesondere auf den Aspekt der Sicherheit fokussiert.

Deshalb haben wir entschieden, bis auf Weiteres nur noch Images auf der Basis der 
[Red Hat Universal Base Image Distribution](https://catalog.redhat.com/software/base-images) bereitzustellen, weil diese Images aktiv von [Red Hat]( https://www.redhat.com/en/blog/introducing-red-hat-universal-base-image) für den produktiven Container Betrieb gepflegt und bereitgestellt werden.
Details zu den aktuellen Basisimages und installierten Tools finden Sie [hier](../../images/base/index.md).

Bisher wurden die nscale Standard Container sowohl auf der Basis von Ubuntu also auch UBI angeboten. **Die Ubuntu Images werden ab diesem Monatsrelease nicht mehr angeboten!**

Neben einigen kleineren Verbesserungen in der Kubernetes-Konfiguration haben wir zudem neben dem bereits vorhandenen [Security Context]( https://kubernetes.io/docs/tasks/configure-pod-container/security-context/)  auch [Network Policies]( https://kubernetes.io/docs/concepts/services-networking/network-policies/) für unsere Container in einer Beispiel-Konfiguration hinterlegt.
Bei unseren Kubernetes Beispielen konzentrieren wir uns weiterhin auf den Microsoft managed Azure Kubernetes Cluster (AKS). Da wir uns an den Standard halten funktioniert das Deployment aber auch auf allen anderen Kubernetes Clustern.

* Aktualisierung aller nscale Standard Container Images auf der Basis der [Red Hat Universal Base Image Distribution](./index.md#basisimage) Distribution.
* Postgresql Upgrade auf 15. **Wir unterstützen in der Beispielkonfiguration *KEINE* automatische Migration von 14 auf 15!**
* [Static Scanning Reports](./kubernetes.md##security-scan-report) unserer Kubernetes Konfiguration mit [kube score](https://kube-score.com/).
* Kubernetes Kustomize Overlay mit Network Policies.
* Umbenennung von postgres.yaml auf postgresql.yaml.
* Einführung von [Pod Disruption Budget](https://kubernetes.io/docs/tasks/run-application/configure-pdb/) für die Skalierung der Komponenten.
* Update der `docker compose` Version auf 3.9 (<https://docs.docker.com/compose/migrate/>); Die Konfiguration wird nur mit dem aktuellen `docker compose` getestet.
* Kubernetes Liveness Probes, die identisch zur Readiness Probe waren wurden gelöscht (<https://github.com/zegl/kube-score/blob/master/README_PROBES.md#livenessprobe>)
* Size Limits auf emptyDir Volumes <https://kubernetes.io/docs/concepts/storage/volumes/#emptydir>.
* ephemeral-storage limits https://kubernetes.io/docs/concepts/storage/ephemeral-volumes/#generic-ephemeral-volumes.
* Verwendung der Downward API im application layer um ein Cluster aufzubauen (https://kubernetes.io/docs/tasks/inject-data-application/downward-api-volume-expose-pod-information/).

## 9.0.1100 (Mai 2023)

* Aktualisierung der Container Images.
* Refactoring der application-layer kubernetes kustomize Konfiguration.
* Ersetzen von `docker-compose` durch `docker compose`.
* Fixierung der docker-compose version auf 3.9.

## 9.0.1000 (April 2023)

* Aktualisierung der Container Images.
* Neuer Container für den nscale Process Automation Modeler

## 8.4.1500 (März 2023)

* Aktualisierung der Container Images.

## 8.4.1400 (Februar 2023)

* Aktualisierung der Container Images.

## 8.4.1300 (Januar 2023)

* Aktualisierung der Container Images.

## 8.4.1200 (Dezember 2022)

* Aktualisierung der Container Images.
* Der initiale Dokumentenbereich wird jetzt explizit in einem weiteren Container (bzw. Kubernetes Job) nach dem Start des Application Layers angelegt.
  Bisher wurde diese Aktion innerhalb des Application Layer Containers ausgeführt.
* Umgebungsvariablen für die nscale Console in Grossbuchstaben und '_'.
* Änderung der Shutdown Grade Period für den application layer auf 100 Sekunden.
  
## 8.4.1100 (November 2022)

* Aktualisierung der Container Images.
* Umgebungsvariablen für den application layer web in Grossbuchstaben und '_'.
  
## 8.4.1000 (Oktober 2022)

* Aktualisierung der Container Images.
* Änderung der Liveness und Readiness Probes in Kubernetes und Compose.
* Verwendung einer gemeinsamen ConfigMap für die Lizenzdatei in allen nscale Kubernetes Pods.

## 8.3.1500 (September 2022)

* Aktualisierung der Container Images.

## 8.3.1400 (August 2022)

* Aktualisierung der Container Images.

## 8.3.1300 (Juli 2022)

* Aktualisierung der Container Images.

## 8.3.1200 (Juni 2022)

* Aktualisierung der Container Images.

## 8.3.1100 (Mai 2022)

* Aktualisierung der Container Images.
* Kleine Erweiterungen in der Dokumentation zum Pipeliner und Administrator.

## 8.3.1000 (April 2022)

* Aktualisierung der Container Images.
* Umstellung auf Log4j2 in allen nscale Komponenten.

## 8.2.1300 (März 2022)

* Aktualisierung der Container Images.
## 8.2.1200 (Februar 2022)

* Aktualisierung der Container Images.

## 8.2.1100 (Januar 2022)

* Aktualisierung der Container Images.

## Hotfix der Konfiguration (13 Dezember 2021)

[*Schwachstelle Log4Shell führt zu extrem kritischer Bedrohungslage*](https://www.bsi.bund.de/DE/Service-Navi/Presse/Pressemitteilungen/Presse2021/211211_log4Shell_WarnstufeRot.html)

* Aktualisierung der Umgebungsvariablen für Monitoring Console und Rendition Server.

## 8.2.1000 (Dezember 2021)

* Aktualisierung der Container Images.
* Integration des XTA Connectors.
* Fehlerbehebungen in der Dokumentation.

## 8.1.1100 (November 2021)

* Aktualisierung der Container Images.
* Fehlerbehebungen in der Dokumentation.

## 8.1.1000 (Oktober 2021)

* Aktualisierung der Container Images.
* Fehlerbehebungen in der Dokumentation.
* Beispielhafte Konfiguration des Administrators.

## 8.0.5500 (September 2021)

* Aktualisierung der Container Images.
* Fehlerbehebungen in der Dokumentation.
* Überarbeitung der Kubernetes Konfiguration zur Erhöhung der Sicherheit und Stabilität entsprechend den Vorschlägen von [Kubesec](https://kubesec.io/) und [Polaris](https://polaris.docs.fairwinds.com/).
* Beispielhafte Konfiguration des Storage Layers mit 2 Instanzen im Proxy Verbund.

## 8.0.5400 (August 2021)

* Aktualisierung der Container Images.
* Fehlerbehebungen in der Dokumentation.
  
## 8.0.5300 (Juli 2021)

* Aktualisierung der Container Images.
* Fehlerbehebungen in der Dokumentation.
* Erweiterung des Startup Skripts für den Pipeliner.

## 8.0.5200 (Juni 2021)

* Aktualisierung der Container Images.
* Fehlerbehebungen in der Dokumentation (Exportieren der Logs über Loki).

## 8.0.5100 (Mai 2021)

Initiales Release der nscale Container.
