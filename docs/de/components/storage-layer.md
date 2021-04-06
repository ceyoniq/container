# nscale Server Storage Layer

## Inhalt

- [nscale Server Storage Layer](#nscale-server-storage-layer)
  - [Inhalt](#inhalt)
  - [Lizenzierung](#lizenzierung)
  - [Persistierung](#persistierung)
  - [Konfiguration](#konfiguration)
  - [Umgebungsvariablen](#umgebungsvariablen)
  - [Ports](#ports)
  - [Start mit Docker](#start-mit-docker)
  - [Skalierung](#skalierung)

## Lizenzierung

Diese Komponente benötigt eine lokale Lizenzdatei.
Die Datei wird im Container hier erwartet: `/opt/ceyoniq/nscale-server/storage-layer/etc/license.xml`.

## Persistierung

> **Achtung! Datenverlust!**  
> Wenn die hier aufgelisteten Ordner nicht persistiert werden, kommt es zum **Datenverlust**.

Folgende Ordner müssen persistiert werden, um Datenverlust zu verhindern:

- `/opt/ceyoniq/nscale-server/storage-layer/arc`
- `/opt/ceyoniq/nscale-server/storage-layer/da`
- `/opt/ceyoniq/nscale-server/storage-layer/etc`

Optional (Retrieval Buffer)

- `/opt/ceyoniq/nscale-server/storage-layer/ret`

## Konfiguration

Sie können Umgebungsvariablen verwenden, um nscale Server Storage Layer zu konfigurieren.  
Allerdings können Sie auch weiterhin die Datei `storagelayer.conf` verwenden, um nscale Server Storage Layer zu konfigurieren.  
Beachten Sie dabei, dass Umgebungsvariablen eine höhere Priorität haben als Konfigurationseinstellungen in der Datei `storagelayer.conf`,
somit überlagern Werte von Umgebungsvariablen die Einstellungen aus der Datei `storagelayer.conf`.

## Umgebungsvariablen

>Die hier aufgeführte Liste der Umgebungsvariablen ist **nicht vollständig**.
Sie bildet lediglich die in unseren Beispielkonfigurationen verwendeten Umgebungsvariablen ab.

Die Benennung der Umgebungsvariablen von nscale Server Storage Layer folgt einem Schema, das wir für Sie im nscale Server Storage Layer Administrationshandbuch zusammengefasst haben.
So können Sie auch alle anderen in der Dokumentation beschriebenen Einstellungen vornehmen.
Die gesamte nscale-Dokumentation finden Sie in unserem Serviceportal unter <https://serviceportal.ceyoniq.com>.

|Umgebungsvariable | Effekt |
|---|---|
|LOG_APPENDER=Console |In dieser Umgebungsvariable können Sie festlegen, wo das Logging von nscale Server Storage Layer geschrieben wird. Hier erfolgt das Logging statt in Dateien im Container auf die Konsole. |
|NSTL_STORAGE-LAYER_LOGLEVEL | In dieser Umgebungsvariable können Sie das Log-Level von nscale Server Storage Layer festlegen. |
|NSTL_ARCHIVETYPE_900_NAME=NSCALE_DEMO | Mit dieser Umgebungsvariable legen Sie den Namen eines Archivtyps (hier Archivtyp 900) fest. |
|NSTL_ARCHIVETYPE_900_ID=900 | In dieser Umgebungsvariable können Sie die ID des Archivtyps festlegen. Im Beispiel wird die ID des Archivtyps 900 auf 900 gesetzt. |
|NSTL_ARCHIVETYPE_900_LOCALMIGRATION=0 | Mit dieser Umgebungsvariable können Sie die lokale Migration für einen Archivtyp (hier 900) aktivieren. |
|NSTL_ARCHIVETYPE_900_LOCALMIGRATIONTYPE=HD | Mit dieser Umgebungsvariable können Sie den lokalen Migrationstyp auf Harddisk setzen. |
|NSTL_ARCHIVETYPE_900_HARDDISK=1 | Mit dieser Umgebungsvariable erlauben Sie die Speicherung von Dateien dieses Archivtyps auf Harddisks. |
|NSTL_HarddiskDevice_0_ARCHIVETYPES=NSCALE_DEMO | Mit dieser Umgebungsvariable erlauben Sie die Speicherung von Dateien des Archivtyps NSCALE_DEMO auf dem Harddiskdevice 0. |
|NSTL_HarddiskDevice_0_INDEX=1 | Sie können die Indexnummer einer Hard Disk (hier für Harddisk 0) festlegen. |
|NSTL_HarddiskDevice_0_NAME=HD | Sie können den Namen einer Hard Disk festlegen. |
|NSTL_HarddiskDevice_0_PATH | In dieser Umgebungsvariable können Sie den Pfad zu einem Harddiskdevice (hier Harddiskdevice 0) angeben. |
|NSTL_HarddiskDevice_0_PERMANENTMIGRATION=1 | Mit dieser Umgebungsvariable machen Sie die Migration auf ein Harddiskdevice permanent. |

## Ports

- 3005

## Start mit Docker

```bash
docker run \
  -e LOG_APPENDER=Console \
  -p 3005:3005 \
  -v $(pwd)/arc:/opt/ceyoniq/nscale-server/storage-layer/arc \
  -v $(pwd)/da:/opt/ceyoniq/nscale-server/storage-layer/da \
  -v $(pwd)/etc:/opt/ceyoniq/nscale-server/storage-layer/etc \
  -v $(pwd)/license.xml:/opt/ceyoniq/nscale-server/storage-layer/etc/license.xml \
  nscale/storage-layer:8.0.5001.2021033108.551023531334
```

## Skalierung

Bitte beachten Sie, dass nscale Server Storage Layer im Fall von Kubernetes nicht durch ein ReplicaSet skaliert werden kann.  
Informationen zur Skalierung von nscale Server Storage Layer finden Sie in der nscale Server Storage Layer Dokumentation in unserem [Serviceportal](<https://serviceportal.ceyoniq.com/>).
