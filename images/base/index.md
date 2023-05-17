# Base Dockerfiles

Über der Git Historie kann das konkrete Basis Image zum Zeitpunkt der Erstellung des speziellen nscale Standard Containers bestimmt werden.

| Dockerfile |  Beschreibung |
|--  |:--|
| [Dockerfile-openjdk](./Dockerfile-openjdk) |  Basis Image für Java 11 und 17 Runtime Images |
| [Dockerfile](./Dockerfile) |  Basis Image für nscale Images ohne Java Runtime (nscale Storage Layer) |
| [Dockerfile-nodejs](./Dockerfile-nodejs) |  Basis Image für den nscale Process Modeler |
| [Dockerfile-openjdk-fonts](./Dockerfile-openjdk-fonts) | Basis Image für den nscale Application Layer und nscale Rendition Server |
| [Dockerfile-administrator](./Dockerfile-administrator) |  Basis Image für den nscale Administrator |
| [Dockerfile-installer](./Dockerfile-installer) |  Basis Image für nscale Installer Images |
| [Dockerfile-pipeliner](./Dockerfile-pipeliner) | Basis Image für den nscale Pipeliner |
| [Dockerfile-storage-layer](./Dockerfile-storage-layer) | Basis Image für den nscale Storage Layer |
