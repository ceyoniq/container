# nscale Standard Container

## Inhalt

- [nscale Standard Container](#nscale-standard-container)
  - [Inhalt](#inhalt)
  - [Informationen zu diesem Dokument](#informationen-zu-diesem-dokument)
  - [Softwarevoraussetzungen](#softwarevoraussetzungen)
  - [Lizenzierung](#lizenzierung)
  - [Container-Registry](#container-registry)
  - [nscale Standard Container-Images](#nscale-standard-container-images)
  - [Basisimage](#basisimage)
    - [Add Microsoft Fonts](#add-microsoft-fonts)
  - [Produktmerkmale](#produktmerkmale)
  - [Betrieb](#betrieb)
  - [Betrieb mit Docker](#betrieb-mit-docker)
  - [Betrieb mit Docker Compose](#betrieb-mit-docker-compose)
  - [Betrieb mit Kubernetes](#betrieb-mit-kubernetes)
  - [Limitierungen](#limitierungen)
  - [FAQ](#faq)
  - [Versionshistorie](#versionshistorie)
  - [Externe Quellen](#externe-quellen)

## Informationen zu diesem Dokument

Bei diesem Dokument handelt es sich um die Dokumentation verschiedener nscale-Komponenten im Container-Betrieb.
Dieses Dokument richtet sich ausdrücklich an Personen, die sich mit dem Betrieb bzw. der Administration von nscale beschäftigen.
Sie sollten außerdem Erfahrungen im Umgang mit dem Betrieb von Software bzw. Applikationen in OCI-kompatiblen Containern sowie Grundwissen zum Aufbau und Zusammenspiel eines nscale-Systems haben.

> Weitere Informationen zum Betrieb von nscale finden Sie in unserem Serviceportal unter <https://serviceportal.ceyoniq.com>.

## Softwarevoraussetzungen

Für den Betrieb von nscale Standard Container muss Ihr System die folgenden Mindestvoraussetzungen erfüllen:

- min. 6 GB RAM
- weitere Software bzw. Hardwarevoraussetzungen finden Sie im Installationshandbuch der jeweiligen Komponenten.
Die gesamte nscale-Dokumentation finden Sie in unserem Serviceportal unter <https://serviceportal.ceyoniq.com/>.

Außerdem müssen Sie ggf. einige Programme von Drittanbietern installieren, um nscale Standard Container starten, betreiben und überwachen zu können. Diese sind:

- **Docker** ab Version 20.10
  - oder eine vergleichbare Container-Laufzeitumgebung für OCI-kompatible Container
- **Docker Compose** ab Version 2.10
- **Kubernetes** ab Version 1.25

Alle nscale Standard Container sind **Linux**-Container.  

Weitere Informationen zu Docker finden Sie unter <https://www.docker.com/>.  
Weitere Informationen zu Kubernetes finden Sie unter <https://kubernetes.io/>.

## Lizenzierung

Der Betrieb von nscale Standard Container benötigt eine nscale Standard Container-Lizenz. Diese Lizenz wird auf Anfrage vom [Ceyoniq Service](support.md) für Sie erstellt.

## Container-Registry

Um auf die nscale Standard Container zuzugreifen, benötigen Sie zudem einen Zugang für die Ceyoniq Container Registry **ceyoniq.azurecr.io**. Auch diese Zugangsdaten erhalten Sie über den [Ceyoniq Service](support.md).

## nscale Standard Container-Images

Folgende Komponenten stehen als nscale Standard Container zur Verfügung:

> Der Eintrag in der Spalte **nscale Komponente** führt Sie jeweils zu weiteren Informationen.

| Komponente | Image | Akutelles Release Tag | Basis Image |
|:---|:---|:---|:---|
| [nscale Server Application Layer](components/application-layer.md) | ceyoniq.azurecr.io/release/nscale/application-layer | <application-layer-tag>ubi.9.0.1501.2023082720</application-layer-tag> | [openjdk-fonts](https://raw.githubusercontent.com/ceyoniq/container/main/images/base/Dockerfile-openjdk-fonts) |
| [nscale Server Application Layer Web](components/application-layer-web.md) | ceyoniq.azurecr.io/release/nscale/application-layer-web | <application-layer-web-tag>ubi.9.0.1500.2023081820</application-layer-web-tag> | [openjdk](https://raw.githubusercontent.com/ceyoniq/container/main/images/base/Dockerfile-openjdk) |
| [nscale Pipeliner](components/pipeliner.md) | ceyoniq.azurecr.io/release/nscale/pipeliner | <pipeliner-tag>ubi.9.0.1501.2023082809</pipeliner-tag>  | [pipeliner](https://raw.githubusercontent.com/ceyoniq/container/main/images/base/Dockerfile-pipeliner) |
| [nscale Server Storage Layer](components/storage-layer.md) | ceyoniq.azurecr.io/release/nscale/storage-layer | <storage-layer-tag>ubi.9.0.1500.2023081714</storage-layer-tag> | [storage-layer](https://raw.githubusercontent.com/ceyoniq/container/main/images/base/Dockerfile-storage-layer) |
| [nscale Rendition Server](components/rendition-server.md) | ceyoniq.azurecr.io/release/nscale/rendition-server | <rendition-server-tag>ubi.9.0.1502.2023082818</rendition-server-tag> | [rendition-server](https://raw.githubusercontent.com/ceyoniq/container/main/images/base/Dockerfile-rendition-server) |
| [nscale Administrator](components/administrator.md) | ceyoniq.azurecr.io/release/nscale/administrator | <administrator-tag>ubi.9.0.1500.2023081509</administrator-tag> | [administrator](https://raw.githubusercontent.com/ceyoniq/container/main/images/base/Dockerfile-administrator) |
| [nscale Monitoring Console](components/monitoring-console.md) | ceyoniq.azurecr.io/release/nscale/monitoring-console | <monitoring-console-tag>ubi.9.0.1400.2023072110</monitoring-console-tag> | [openjdk](https://raw.githubusercontent.com/ceyoniq/container/main/images/base/Dockerfile-openjdk) |
| [nscale Console](components/console.md) | ceyoniq.azurecr.io/release/nscale/console | <console-tag>ubi.9.0.1401.13101</console-tag> | [openjdk](https://raw.githubusercontent.com/ceyoniq/container/main/images/base/Dockerfile-openjdk) |
| [nscale Process Automation Modeler](components/process-automation-modeler.md) | ceyoniq.azurecr.io/release/nscale/process-automation-modeler | <process-automation-modeler-tag>ubi.9.0.1500.6997</process-automation-modeler-tag> | [nodejs](https://raw.githubusercontent.com/ceyoniq/container/main/images/base/Dockerfile-nodejs) |
| [nscale CMIS-Connector](components/cmis-connector.md) | ceyoniq.azurecr.io/release/nscale/cmis-connector | <cmis-connector-tag>ubi.9.0.1202.2023052608</cmis-connector-tag> | [openjdk](https://raw.githubusercontent.com/ceyoniq/container/main/images/base/Dockerfile-openjdk) |
| [nscale WebDAV-Connector](components/webdav-connector.md)| ceyoniq.azurecr.io/release/nscale/webdav-connector | <webdav-connector-tag>ubi.9.0.1200.2023051702</webdav-connector-tag>  | [openjdk](https://raw.githubusercontent.com/ceyoniq/container/main/images/base/Dockerfile-openjdk) |
| [nscale ERP Connector ILM](components/ilm-connector.md) | ceyoniq.azurecr.io/release/nscale/ilm-connector | <ilm-connector-tag>ubi.9.0.1200.2023051702</ilm-connector-tag> | [openjdk](https://raw.githubusercontent.com/ceyoniq/container/main/images/base/Dockerfile-openjdk) |
| [nscale XTAConnector](components/xta-connector.md) | ceyoniq.azurecr.io/release/nscale/xta-connector | <xta-connector-tag>ubi.9.0.1200.2023051716</xta-connector-tag> | [openjdk](https://raw.githubusercontent.com/ceyoniq/container/main/images/base/Dockerfile-openjdk) |

> Die Ceyoniq Technology GmbH übernimmt keine Gewährleistung und Haftung für die Funktionsfähigkeit, Verfügbarkeit, Stabilität und Zuverlässigkeit von Software von Drittanbietern, die nicht Teil der oben aufgelisteten nscale Standard Container ist.

![Komponenten als Container](../images/nscaleStandardContainerOverview.png)

## Basisimage

Alle nscale Standard Images werden auf Basis der aktuellen [Red Hat UBI 9 minimal](https://www.redhat.com/en/blog/introducing-red-hat-universal-base-image) Images erstellt.  
Das Open Source Fedora-Projekt ist die Upstream Community-Distribution von "Red Hat® Enterprise Linux" auf dem unsere Images aufbauen.
Entsprechend können die Images abgeleitet und mit Enterprise Red Hat oder Fedora Tools erweitert werden.

Wir installieren in unseren Images zusätzliche Werkzeuge aus dem "Red Hat Universal Base Image" Upstream.
Im Speziellem gibt es Ausnahmen davon im Rendition Server und Application Layer Images,
in denen freie TrueType Google Fonts ([Croscore fonts](https://en.wikipedia.org/wiki/Croscore_fonts)) anstatt der default Dejavu Fonts installiert sind.

* [Google Arimo Font](https://fonts.google.com/specimen/Arimo)
* [Google Cousine Font](https://fonts.google.com/specimen/Cousine)
* [Google Tinos Font](https://fonts.google.com/specimen/Tinos)

Daneben sind im Rendition Server Image unter `/opt` [Tesseract-OCR](https://github.com/tesseract-ocr/tesseract)
und [ImageMagick](https://github.com/ImageMagick/ImageMagick) nachinstalliert.
Diese Binaries wurden aus den Quellen auf der Basis der UBI Images kompiliert.

Die Details zu den aktuell installierten Zusatzpaketen können Sie den entsprechend versionierten Dockerfiles in dem Ordner [images/base/](../../images/base/index.md) entnehmen.

Unsere Images können um weitere Tools etwa aus den
[Extra Packages for Enterprise Linux (EPEL) 9](https://docs.fedoraproject.org/en-US/epel/#_el9) ergänzt werden.

```bash
# install full package manager
microdnf install -y dnf dnf-plugins-core

# register standard fedora stream
cat > /etc/yum.repos.d/fedora.repo << EOF
[fedora]
name=Fedora $releasever - \$basearch
#baseurl=http://download.example/pub/fedora/linux/releases/\$releasever/Everything/\$basearch/os/
metalink=https://mirrors.fedoraproject.org/metalink?repo=fedora-\$releasever&arch=\$basearch
enabled=0
countme=1
metadata_expire=6h
repo_gpgcheck=0
type=rpm
gpgcheck=1
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-fedora-\$releasever-\$basearch
skip_if_unavailable=False
EOF
# add and enable source
dnf config-manager --add-repo /etc/yum.repos.d/fedora.repo
dnf config-manager --set-enabled fedora

# register epel source
dnf install -y https://dl.fedoraproject.org/pub/epel/epel-release-latest-9.noarch.rpm

# list available repositories
dnf repolist
dnf repository-packages fedora list
dnf repository-packages epel list
# enable Code Ready Builder
/usr/bin/crb enable

# install p7zip from EPEL
dnf --disablerepo=* --enablerepo=epel search p7zip
dnf --disablerepo=* --enablerepo=epel install -y p7zip
```

Wenn eine Red Hat Subscription vorhanden ist kann diese auch verwendet werden
um eine Reihe weiterer offiziell unterstützter Repositories einzubinden ([Get Started with Red Hat Subscription Management](https://access.redhat.com/articles/433903)).

```bash
# install subscription manager on ubi minimal image
microdnf install --assumeyes subscription-manager
export SMDEV_CONTAINER_OFF=1
# register account: This command will download the entitlement and consumer certificates in /etc/pki
# NOTE: Do no put the cleartext password into a dockerfile instruction file!
subscription-manager register --username=<username> --password=<password>

# list repositories
subscription-manager list --available --all
# list available repositories
microdnf repolist

# install leptonica / tesseract from RHEL repositories
microdnf install --assumeyes leptonica tesseract
# install tesseract language packages
export TESSDATA_PREFIX=/usr/share/tesseract/tessdata
curl -L https://github.com/tesseract-ocr/tessdata_fast/raw/main/deu.traineddata -o ${TESSDATA_PREFIX}/deu.traineddata
curl -L https://github.com/tesseract-ocr/tessdata_fast/raw/main/eng.traineddata -o ${TESSDATA_PREFIX}/eng.traineddata 

# install ImageMagick from EPEL (see https://access.redhat.com/solutions/4437561)
subscription-manager repos --enable codeready-builder-for-rhel-9-$(arch)-rpms
dnf install --assumeyes https://dl.fedoraproject.org/pub/epel/epel-release-latest-9.noarch.rpm
microdnf install --assumeyes ImageMagick

microdnf clean all
```

### Add Microsoft Fonts

Die Microsoft Fonts können aus lizenzrechtlichen Gründen nicht im Basisimage vorinstalliert werden.
Stattdessen können diese gegebenenfalls in einem abgeleiteten Image nachinstalliert werden.

```bash
# install full package manager
microdnf install --assumeyes dnf
# register epel source
dnf install --assumeyes https://dl.fedoraproject.org/pub/epel/epel-release-latest-9.noarch.rpm

# remove preinstalled Croscore fonts
rpm -e --nodeps google-cousine-fonts google-arimo-fonts google-tinos-fonts dejavu-sans-fonts
# install Microsoft Fonts instead
rpm --install --nodeps https://downloads.sourceforge.net/project/mscorefonts2/rpms/msttcore-fonts-installer-2.6-1.noarch.rpm

microdnf clean all
```

## Produktmerkmale

| Komponente | Lizenz benötigt | Steuerung über Umgebungsvariablen | Autoscaling* | Loadbalancing** |
|---|---|---|---|---|
|nscale Server Application Layer|Ja|Ja|Ja|Ja|
|nscale Server Application Layer Web|Ja|Ja|Ja|Ja|
|nscale Server Storage Layer|Ja|Ja|Nein|Nein|
|nscale Rendition Server|Ja|Ja|Ja|Ja|
|nscale Pipeliner|Ja|Nein|Nein|Nein|
|nscale Process Automation Modeler|Ja|Ja|Nein|Nein|
|nscale Console|Nein|Ja|Ja|Ja|
|nscale Monitoring Console|Ja|Ja|Nein|Nein|
|nscale CMIS-Connector|Ja|Ja|Nein|Nein|
|nscale WebDAV-Connector|Ja|Ja|Nein|Nein|
|nscale ERP Connector ILM|Ja|Ja|Nein|Nein|
|nscale XTA Connector|Ja|Ja|Nein|Nein|

(*) Die Komponente kann über ein [ReplicaSet](https://kubernetes.io/docs/concepts/workloads/controllers/replicaset/) in Kubernetes skaliert werden.  
(**) Die Komponente kann über einen [Service](https://kubernetes.io/docs/concepts/services-networking/service/) in Kubernetes Loadbalancing durchführen.

## Betrieb

![Beispiel-Architektur](../images/exampleKubernetes.png)

## Betrieb mit Docker

Sie können die jeweiligen nscale Standard Container mit Docker oder einer kompatiblen Laufzeitumgebung für OCI-Container betreiben.
Wir empfehlen den Einsatz von Docker Compose oder Kubernetes.  
Weitere Informationen zum Betrieb der nscale Standard Container mit Docker finden Sie in den jeweiligen Dokumentationen der Komponenten in diesem Repository.

[Liste aller nscale Server Standard Container](#nscale-standard-container-images)

## Betrieb mit Docker Compose

Der Betrieb mit Docker Compose ist eine Möglichkeit, nscale Standard Container zu betreiben.  
Bei Docker Compose handelt es sich um ein Tool, mit dem Sie aus mehreren Containern bestehende Applikationen definieren und betreiben können.

Weitere Informationen zu Docker Compose finden Sie  unter <https://docs.docker.com/compose>.  

Der Betrieb von nscale Standard Container mit Docker Compose hat folgende Vorteile:

- sehr einfache Installation im Single-Server-Betrieb
- ideal für die Entwicklung mit nscale
- schnelles Erzeugen eines Demo- und Test-Systems

Eine genaue Beschreibung der Konfiguration von nscale im Betrieb mit Docker Compose finden Sie unter:  

[nscale Standard Container in Docker Compose](compose.md)

## Betrieb mit Kubernetes

Bei Kubernetes handelt es sich um eine portable, erweiterbare Open-Source-Plattform zur Verwaltung von containerisierten Arbeitslasten und Services, die sowohl die deklarative Konfiguration als auch die Automatisierung erleichtert.
Kubernetes zeichnet sich durch ein großes, schnell wachsendes Ökosystem aus.
Dienstleistungen, Support und Tools für Kubernetes sind weit verbreitet.  

Weitere Informationen zu Kubernetes finden Sie unter <https://kubernetes.io>.

Der Betrieb von nscale Standard Container mit Kubernetes hat folgende Vorteile:

- Clusterbildung möglich
- Fehlertoleranz
- flexible Skalierbarkeit
- einfache Installation in Cloud-Umgebungen (z. B. in [Microsoft Azure Kubernetes Service - AKS](https://azure.microsoft.com/de-de/services/))

Eine genaue Beschreibung der Konfiguration von nscale Standard Container im Betrieb mit Kubernetes finden Sie unter:  

[nscale Standard Container mit Kubernetes](kubernetes.md)

## Limitierungen

Informationen zu Limitierungen finden Sie hier:  
[limitation.md](limitation.md)

## FAQ

Die FAQ finden Sie hier:  
[faq.md](faq.md)

## Versionshistorie

Die Änderungshistorie finden Sie hier:  
[changelog.md](changelog.md)

## Externe Quellen

- Kubernetes-Logo: <https://github.com/kubernetes/kubernetes/tree/master/logo>
- Docker-Logo: <https://commons.wikimedia.org/wiki/File:Docker_(container_engine)_logo.png>
