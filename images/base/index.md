# Base Images

## Installierte Linux Pakete

| application-layer | Hinweise |
|:--|:--|
| Basis Image | registry.access.redhat.com/ubi9/openjdk-17-runtime |
| installierte Tools | tzdata, unzip |
| erweiterte Tools | fonts-filesystem, fontconfig, dejavu deinstalliert, Google Croscore Fonts in /usr/share/fonts/ |

| application-layer-web | Hinweise |
|:--|:--|
| Basis Image | registry.access.redhat.com/ubi9/openjdk-17-runtime |
| installierte Tools | tzdata, unzip |
| erweiterte Tools | |

| pipeliner | Hinweise |
|:--|:--|
| Basis Image | registry.access.redhat.com/ubi9/openjdk-17-runtime |
| installierte Tools | tzdata, unzip, libxslt, glibc-langpack-en, glibc-langpack-de, libnsl |
| erweiterte Tools | |

| storage-layer | Hinweise |
|:--|:--|
| Basis Image | registry.access.redhat.com/ubi9/ubi-minimal |
| installierte Tools | tzdata, procps-ng, shadow-utils |
| erweiterte Tools | |

| rendition-server | Hinweise |
|:--|:--|
| Basis Image | registry.access.redhat.com/ubi9/openjdk-17-runtime |
| installierte Tools | tzdata, unzip |
| erweiterte Tools | fonts-filesystem, fontconfig, dejavu deinstalliert, Google Croscore Fonts in /usr/share/fonts/ |

| administrator | Hinweise |
|:--|:--|
| Basis Image | registry.access.redhat.com/ubi9/openjdk-17-runtime |
| installierte Tools | tzdata, unzip, gzip, tar |
| erweiterte Tools |  |

| monitoring-console | Hinweise |
|:--|:--|
| Basis Image | registry.access.redhat.com/ubi9/openjdk-17-runtime |
| installierte Tools | tzdata, unzip |
| erweiterte Tools | |

| console | Hinweise |
|:--|:--|
| Basis Image | registry.access.redhat.com/ubi9/openjdk-11-runtime |
| installierte Tools | tzdata, unzip |
| erweiterte Tools | |

| process-automation-modeler | Hinweise |
|:--|:--|
| Basis Image | registry.access.redhat.com/ubi9/nodejs-16-minimal |
| installierte Tools | tzdata |
| erweiterte Tools | |

| cmis-connector | Hinweise |
|:--|:--|
| Basis Image | registry.access.redhat.com/ubi9/openjdk-17-runtime |
| installierte Tools | tzdata, unzip |
| erweiterte Tools | |

| erp-cmis-connector | Hinweise |
|:--|:--|
| Basis Image | registry.access.redhat.com/ubi9/openjdk-17-runtime |
| installierte Tools | tzdata, unzip |
| erweiterte Tools | |

| webdav-connector | Hinweise |
|:--|:--|
| Basis Image | registry.access.redhat.com/ubi9/openjdk-17-runtime |
| installierte Tools | tzdata, unzip |
| erweiterte Tools | |

| erp-ilm-connector | Hinweise |
|:--|:--|
| Basis Image | registry.access.redhat.com/ubi9/openjdk-17-runtime |
| installierte Tools | tzdata, unzip |
| erweiterte Tools | |

| xta-connector | Hinweise |
|:--|:--|
| Basis Image | registry.access.redhat.com/ubi9/openjdk-17-runtime |
| installierte Tools | tzdata, unzip |
| erweiterte Tools | |

## Dockerfile

Über der Git Historie kann das konkrete Basis Image zum Zeitpunkt der Erstellung des speziellen nscale Standard Containers bestimmt werden.

| Dockerfile |  Beschreibung |
|--|:--|
| [Dockerfile-openjdk](./Dockerfile-openjdk) |  Basis Image für Java 11 und 17 Runtime Images |
| [Dockerfile](./Dockerfile) |  Basis Image für nscale Images ohne Java Runtime (nscale Storage Layer) |
| [Dockerfile-openjdk-fonts](./Dockerfile-openjdk-fonts) | Basis Image für den nscale Application Layer und nscale Rendition Server |
| [Dockerfile-administrator](./Dockerfile-administrator) |  Basis Image für den nscale Administrator |
| [Dockerfile-installer](./Dockerfile-installer) |  Basis Image für nscale Installer Images |
| [Dockerfile-pipeliner](./Dockerfile-pipeliner) | Basis Image für den nscale Pipeliner |
| [Dockerfile-storage-layer](./Dockerfile-storage-layer) | Basis Image für den nscale Storage Layer |
| [Dockerfile-rendition-server](./Dockerfile-rendition-server) | Basis Image für den nscale Rendition Server |
| [Dockerfile-fedora](./Dockerfile-fedora) | Beispiel einer Basis Image Ableitung mit Fedora Paketen |
| [Dockerfile-rhel](./Dockerfile-rhel) | Beispiel einer Basis Image Ableitung mit Red Hat Subscription Manager |
