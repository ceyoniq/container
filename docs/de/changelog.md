# Änderungshistorie

Die Releasenotes der Softwarekomponenten finden Sie in unserem [Serviceportal](<https://serviceportal.ceyoniq.com/>).  
Die aktuelle Liste der Container Image finden Sie [hier](https://github.com/ceyoniq/container/blob/main/docs/de/index.md#nscale-standard-container-images).

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
