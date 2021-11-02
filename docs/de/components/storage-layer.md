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
  - [Beispiel Konfigurationen](#beispiel-konfigurationen)
    - [Verwenden eines HardDisk-Device](#verwenden-eines-harddisk-device)
    - [Verwendung eines S3-Speichers (Objektspeicher)](#verwendung-eines-s3-speichers-objektspeicher)
    - [Verwendung von Accounting und Monitoring](#verwendung-von-accounting-und-monitoring)
    - [Storage Layer Proxy in Kubernetes](#storage-layer-proxy-in-kubernetes)
      - [Persistent Volume](#persistent-volume)
      - [storagelayer.conf](#storagelayerconf)
      - [Server ID](#server-id)
      - [Azure Blob Container](#azure-blob-container)
      - [Kennwörter](#kennwörter)
      - [SSL Verschlüsselung](#ssl-verschlüsselung)

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
|NSTL_FILE | Dateipfad für die Konfigurationsdatei (Default etc/storagelayer.conf) |
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
  ceyoniq.azurecr.io/release/nscale/storage-layer:8.1.1100.2021102018.430262711479
```

## Skalierung

Bitte beachten Sie, dass nscale Server Storage Layer im Fall von Kubernetes **nicht** durch ein ReplicaSet skaliert werden kann.  
Informationen zur Skalierung von nscale Server Storage Layer finden Sie in der nscale Server Storage Layer Dokumentation in unserem [Serviceportal](<https://serviceportal.ceyoniq.com/>).

## Beispiel Konfigurationen

Weitere Informationen zur Konfiguration von nscale Server Storage Layer finden Sie in der nscale Server Storage Layer Dokumentation in unserem [Serviceportal](<https://serviceportal.ceyoniq.com/>).

### Verwenden eines HardDisk-Device

Mit einem HardDisk-Device haben Sie die Möglichkeit, in Docker-Compose ein `Volume` zu verwenden und in Kubernetes `PersistentVolumeClaim` und `PersistentVolume` einzusetzen.  
In diesem Beispiel werden Dateien für den neuen Archivtyp `DEMOARCHIVETYPE` in den Ordner `/mnt` migriert.
`/mnt` muss als `Volume` verfügbar sein.

> Bitte beachten Sie, dass hier der Ordner `/mnt` gewählt wurde, um dieses Beispiel möglichst einfach zu halten.

**Beispiel Docker-Compose:**

```yaml
volumes:
    environment:
      - NSTL_ARCHIVETYPE_900_NAME=DEMOARCHIVETYPE
      - NSTL_ARCHIVETYPE_900_ID=900
      - NSTL_ARCHIVETYPE_900_LOCALMIGRATION=0
      - NSTL_ARCHIVETYPE_900_LOCALMIGRATIONTYPE=HD
      - NSTL_ARCHIVETYPE_900_HARDDISK=1
      - NSTL_HarddiskDevice_0_ARCHIVETYPES=DEMOARCHIVETYPE
      - NSTL_HarddiskDevice_0_INDEX=1
      - NSTL_HarddiskDevice_0_NAME=HD
      - NSTL_HarddiskDevice_0_PATH=/mnt
      - NSTL_HarddiskDevice_0_PERMANENTMIGRATION=1
```

**Beispiel Kubernetes:**

```yaml
env:
    - name: NSTL_ARCHIVETYPE_900_NAME
      value: "DEMOARCHIVETYPE"
    - name: NSTL_ARCHIVETYPE_900_ID
      value: "900"
    - name: NSTL_ARCHIVETYPE_900_LOCALMIGRATION
      value: "0"
    - name: NSTL_ARCHIVETYPE_900_LOCALMIGRATIONTYPE
      value: "HD"
    - name: NSTL_ARCHIVETYPE_900_HARDDISK
      value: "1"
    - name: NSTL_HarddiskDevice_0_ARCHIVETYPES
      value: "DEMOARCHIVETYPE"
    - name: NSTL_HarddiskDevice_0_INDEX
      value: "1"
    - name: NSTL_HarddiskDevice_0_NAME
      value: "HD"
    - name: NSTL_HarddiskDevice_0_PATH
      value: "/mnt"
    - name: NSTL_HarddiskDevice_0_PERMANENTMIGRATION
      value: "1"
```

**Konfiguration über die `storagelayer.conf`:**

Wenn Sie nscale Server Storage Layer nicht über Umgebungsvariablen steuern möchten, können Sie weiterhin die `storagelayer.conf` verwenden. Kopieren Sie dazu die `storagelayer.conf` aus dem nscale Server Storage Layer Standard Container und verwenden Sie diese Datei als Kubernetes `ConfigMap` oder als Docker-Compose `Bind-Mount`.

Erweitern Sie Ihre Konfiguration in der `storagelayer.conf` um folgende Eigenschaften:

```ini
[ArchiveType]
  Name = DEMOARCHIVETYPE
  Id = 900
  LocalMigration = 0
  LocalMigrationType = HD
  Hardisk = 1

[HarddiskAdapter]
  Active = 1
  Index = 0
  Name = HD
  Path = /mnt
  ArchiveTypes = DEMOARCHIVETYPE
  PermanentMigration = 1
```

> Bitte beachten Sie, dass der neue Archivtyp in Ihrer Objektklassenkonfiguration verwendet werden muss, um einen Effekt zu erzielen.

### Verwendung eines S3-Speichers (Objektspeicher)

Objektspeicher ist eine hierarchiefreie Methode zum Speichern von Daten, die normalerweise in der Cloud verwendet wird.

**Beispiel Docker-Compose:**

```yaml
volumes:
    environment:
      - NSTL_ARCHIVETYPE_13_NAME=S3
      - NSTL_ARCHIVETYPE_13_ID=13
      - NSTL_ARCHIVETYPE_13_LOCALMIGRATION=0
      - NSTL_ARCHIVETYPE_13_LOCALMIGRATIONTYPE=NONE
      - NSTL_ARCHIVETYPE_13_S3Migration=1
      - NSTL_S3_0_CONFIGURED=1
      - NSTL_S3_0_INDEX=1
      - NSTL_S3_0_TYPE=AMAZON
      - NSTL_S3_0_NAME=AMAZON
      - NSTL_S3_0_InitiallyActive=1
      - NSTL_S3_0_BucketName=s3device1
      - NSTL_S3_0_Region=eu-central-1
      - NSTL_S3_0_AccessId=[ID]          # Tragen Sie hier Ihre Id ein
      - NSTL_S3_0_SecretKey=[SECRET]     # Tragen Sie hier Ihren Schlüssel ein
      - NSTL_S3_0_ArchiveTypes=S3
      - NSTL_S3_0_PermanentMigration=1
```

**Beispiel Kubernetes:**

```yaml
env:
      - name: NSTL_ARCHIVETYPE_13_NAME
        value: "S3"
      - name: NSTL_ARCHIVETYPE_13_ID
        value: "13"
      - name: NSTL_ARCHIVETYPE_13_LOCALMIGRATION
        value: "0"
      - name: NSTL_ARCHIVETYPE_13_LOCALMIGRATIONTYPE
        value: "NONE"
      - name: NSTL_ARCHIVETYPE_13_S3Migration
        value: "1"
      - name: NSTL_S3_0_CONFIGURED
        value: "1"
      - name: NSTL_S3_0_INDEX
        value: "1"
      - name: NSTL_S3_0_TYPE
        value: "AMAZON"
      - name: NSTL_S3_0_NAME
        value: "AMAZON"
      - name: NSTL_S3_0_InitiallyActive
        value: "1"
      - name: NSTL_S3_0_BucketName
        value: "s3device1"
      - name: NSTL_S3_0_Region
        value: "eu- name:central- name:1"
      - name: NSTL_S3_0_AccessId
        value: "[ID]              # Tragen Sie hier Ihre Id ein, oder verwenden Sie ein Kubernetes-Secret"
      - name: NSTL_S3_0_SecretKey
        value: "[SECRET]          # Tragen Sie hier Ihren Schlüssel ein, oder verwenden Sie ein Kubernetes-Secret"
      - name: NSTL_S3_0_ArchiveTypes
        value: "S3"
      - name: NSTL_S3_0_PermanentMigration
        value: "1"
```

> Bitte beachten Sie, dass der neue Archivtyp in Ihrer Objektklassenkonfiguration verwendet werden muss, um einen Effekt zu erzielen.

### Verwendung von Accounting und Monitoring

Weitere Informationen zu `ACCOUNTING` und `MONITORING` finden Sie in der nscale Server Storage Layer Dokumentation in unserem [Serviceportal](<https://serviceportal.ceyoniq.com/>).

**Beispiel Docker-Compose:**

```yaml
volumes:
    environment:
      - NSTL_ACCOUNTING_BasePath=/mnt/accounting
      - NSTL_ACCOUNTING_ACTIVE=1
      - NSTL_MONITORING_ACTIVE=1
      - NSTL_MONITORING_CSVACTIVE=1
      - NSTL_MONITORING_CSVBaseDir=/mnt/monitoring
```

**Beispiel Kubernetes:**

```yaml
env:
    - name: NSTL_ACCOUNTING_BasePath
      value: /mnt/accounting
    - name: NSTL_ACCOUNTING_ACTIVE
      value: 1
    - name: NSTL_MONITORING_ACTIVE
      value: 1
    - name: NSTL_MONITORING_CSVACTIVE
      value: 1
    - name: NSTL_MONITORING_CSVBaseDir
      value: /mnt/monitoring
```

### Storage Layer Proxy in Kubernetes

Zur Ausfallsicherheit werden üblicherweise zwei Instanzen vom Storage Layers betrieben, die ihre Daten auf demselben S3 Endgerät ablegen.
Die DA Verwaltungsdaten werden untereinander ausgetauscht (DA Forwarding).
Eine solche Architektur ist im Kustomize [''azure-cluster''](../../../kubernetes/kustomize/nscale/overlays/azure-cluster/) Overlay speziell für den Azure Kubernetes Service hinterlegt.

Das StatefulSet mit zwei Storage Layer Instanzen verwendet unterschiedliche storagelayer.conf Konfigurationsdateien, um die spezielle Proxy Konfiguration umzusetzen.

Dabei werden beide Instanzen auf verschiedenen Nodes des Clusters gestartet um maximal Ausfallsicherheit zu gewährleisten.

#### Persistent Volume

In Kubernetes wird die Persistent Volume Claim in einem StatefulSet *nicht* automatisch gelöscht wenn der Service deinstalliert wird
[Referenz](https://kubernetes.io/docs/tasks/run-application/delete-stateful-set/).
Das dient der Sicherheit um gegebenenfalls nachträglich Daten aus dem Volume zu sichern.

#### storagelayer.conf

Die klassischen Konfigurationsdateien werden über eine Secret in die Container gemapped.
Da es sich um ein StatefulSet handelt ist die Zuordnung von Container und Persistent Volume vordefiniert.
Über den eindeutigen Container Namen kann deshalb auch die Verknüpfung mit der individuellen ``storagelayer.conf`` hergestellt werden.

#### Server ID

Die Storage Layer Instanzen müssen unterschiedliche Server IDs verwenden.
In der Beispielkonfiguration werden diese nicht aus der Lizenz sondern aus der ``storagelayer.conf``  ausgelesen.
Dazu darf in der Lizenz keine Server ID festgelegt sein und zudem muss das Flag ``DomainOnly`` in der Lizenz vorhanden sein.

#### Azure Blob Container

In dem ``Azure`` Abschnitt der Konfigurationsdatei werden die Verbindungsdaten zum Azure Blob Container hinterlegt.
Bitte beachten Sie dass die Konfigurationsdatei aus einem Secret gelesen wird!

#### Kennwörter

Die Storage Layer eigene Kennwort Verwaltung in der ''GROUPS.DAT'' wird über ein Secret in den Container gemapped.

#### SSL Verschlüsselung

Es wird zunächst ein Root Zertifikat benötigt von dem das Zertifikat für die einzelnen Storage Layer Instanzen abgeleitet wird.
Diese Root Zertifikat wird später im Application Layer verwendet, um die Verbindung zum Storage Layer zu verifizieren.

Schritte zum Erstellen der Zertifikate:

```bash
# create self signed root certificate
openssl genrsa -out rootCA.key 4096
openssl req -x509 -new -nodes -key rootCA.key -sha256 -days 3650 -out rootCA.crt -subj "/C=US/ST=CA/O=MyOrg, Inc./CN=mydomain.com"
openssl x509 -text -noout -in rootCA.crt

# convert certificate to use in application layer
openssl x509 -in rootCA.crt -outform der -out rootCA.der

# create single certificate for all storage layer instances
openssl genrsa -out nstl.key 2048

# create a signing request first
openssl req -new -sha256 -key nstl.key -subj "/C=US/ST=CA/O=MyOrg, Inc./CN=mydomain.com" -out nstl.csr
openssl req -in nstl.csr -noout -text

# sign certificate with self-signed rootCA
openssl x509 -req -in nstl.csr -CA rootCA.crt -CAkey rootCA.key -CAcreateserial -out nstl.crt -days 3650 -sha256
openssl x509 -in nstl.crt -text -noout
```