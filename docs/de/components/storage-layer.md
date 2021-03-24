# nscale Server Storage Layer

## Lizenzierung

Diese Komponente benötigt eine lokale Lizenzdatei.
Die Datei wird im Container hier erwartet: `/opt/ceyoniq/nscale-server/storage-layer/etc/license.xml`.

## Persistierung

> **Achtung!**
> Bitte beachten Sie, dass wenn diese Ordner nicht persistiert werden, dass er zum **Datenverlust** kommt!

Folgende Ordner müssen persistiert werden:

* `/opt/ceyoniq/nscale-server/storage-layer/arc`
* `/opt/ceyoniq/nscale-server/storage-layer/da`
* `/opt/ceyoniq/nscale-server/storage-layer/etc`

Optional (Retrival Buffer)

* `/opt/ceyoniq/nscale-server/storage-layer/ret`

## Umgebungsvariablen

>Die hier aufgeführte Liste der Umgebungsvariablen ist **nicht vollständig**.
Sie bildet lediglich die in unseren Beispielkonfigurationen verwendeten Umgebungsvariablen ab.

Die Bennennung der Umgebungsvariablen von nscale Server Storage Layer folgt einem Schema, das wir für Sie im nscale Server Storage Layer Administrationshandbuch zusammengefasst haben.
So können Sie auch alle anderen in der Dokumentation beschriebenen Einstellungen vornehmen.
Die gesamte nscale-Dokumentation finden Sie in unserem Serviceportal unter <https://serviceportal.ceyoniq.com/>.

|Umgebungsvariable | Effekt |
|---|---|
|LOG_APPENDER=Console |In dieser Umgebungsvariable können Sie festlegen, wo das Logging des nscale Server Storage Layers stattfindet. Hier erfolgt das Logging statt in Dateien im Container auf der Console. |
|NSTL_STORAGE-LAYER_LOGLEVEL | In dieser Umgebungsvariable können Sie das Log-Level von nscale Server Storage Layer festlegen. |
|NSTL_ARCHIVETYPE_900_NAME=NSCALE_DEMO | Mit dieser Umgebungsvariable legen Sie den Namen eines Archivtyps (hier 900) fest. |
|NSTL_ARCHIVETYPE_900_ID=900 | In dieser Umgebungsvariable können Sie die ID des Archivtyps festlegen. Im Beispiel wird die ID des Archivtyp 900 auf 900 gesetzt. |
|NSTL_ARCHIVETYPE_900_LOCALMIGRATION=0 | Mit dieser Umgebungsvariable können Sie die lokale Migration für einen Archivtyp (hier 900) aktivieren. |
|NSTL_ARCHIVETYPE_900_LOCALMIGRATIONTYPE=HD | Mit dieser Umgebungsvariable können Sie den lokalen Migrationstyp auf Harddisk setzen. |
|NSTL_ARCHIVETYPE_900_HARDDISK=1 | Mit dieser Umgebungsvariable erlauben Sie die Speicherung von Dateien dieses Archivtyps auf Harddisks. |
|NSTL_HarddiskDevice_0_ARCHIVETYPES=NSCALE_DEMO | Mit dieser Umgebungsvariable erlauben Sie die Speicherung von Dateien des Archivtyps NSCALE_DEMO auf dem Harddiskdevice 0. |
|NSTL_HarddiskDevice_0_INDEX=1 | Sie können die Index Nummer einer Hard Disk (hier 0) festlegen. |
|NSTL_HarddiskDevice_0_NAME=HD | Sie können den Namen einer Hard Disk festlegen. |
|NSTL_HarddiskDevice_0_PATH | In dieser Umgebungsvariable können Sie den Pfad zu einem Harddiskdevice (hier Harddiskdevice 0) angeben. |
|NSTL_HarddiskDevice_0_PERMANENTMIGRATION=1 | Mit dieser Umgebungsvariable machen Sie die Migration auf ein Harddiskdevice permanent. |

## Ports

* 3005

## Start

```bash
docker run \
  -e LOG_APPENDER=Console \
  -p 3005:3005 \
  -v $(pwd)/arc:/opt/ceyoniq/nscale-server/storage-layer/arc \
  -v $(pwd)/da:/opt/ceyoniq/nscale-server/storage-layer/da \
  -v $(pwd)/etc:/opt/ceyoniq/nscale-server/storage-layer/etc \
  -v $(pwd)/license.xml:/opt/ceyoniq/nscale-server/storage-layer/etc/license.xml \
  nscale/storage-layer
```

## Skalierung

Bitte beachten Sie, dass der nscale Server Storage Layer im Fall von Kubernetes nicht durch ein ReplicaSet skaliert werden kann.  
Informationen zur Skalierung des nscale Server Storage Layer findet Sie in der nscale Server Storage Layer Dokumentation unter **Distributed Service**.
