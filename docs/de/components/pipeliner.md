# nscale Pipeliner

## Inhalt

- [nscale Pipeliner](#nscale-pipeliner)
  - [Inhalt](#inhalt)
  - [Lizenzierung](#lizenzierung)
  - [Persistierung](#persistierung)
  - [Start mit Docker](#start-mit-docker)
  - [Konfiguration](#konfiguration)
    - [Docker-Compose](#docker-compose)
    - [Kubernetes](#kubernetes)
      - [Passwörter in der  `cold.xml` externalisieren](#passwörter-in-der--coldxml-externalisieren)
    - [Anpassen der `doc_mime_suff.tsv`](#anpassen-der-doc_mime_sufftsv)
      - [Vorbereitung](#vorbereitung)
      - [Verwendung von externen Dateien (Bind-Mount und Volumes)](#verwendung-von-externen-dateien-bind-mount-und-volumes)

## Lizenzierung

Diese Komponente benötigt eine lokale Lizenzdatei.
Die Datei wird im Container hier erwartet: `/opt/ceyoniq/nscale-pipeliner/workdir/license.xml`.

## Persistierung

> **Achtung! Datenverlust!**  
> Wenn die hier aufgelisteten Ordner nicht persistiert werden, kommt es zum **Datenverlust**.

Je nach Konfiguration wird der Pipeliner Dateien lesen, schreiben und ändern.  
Diese Ordner müssen als Volume oder als Bind-Mount gesichert werden.

Zum Beispiel können folgende Ordner persistiert werden:

- `/opt/ceyoniq/nscale-pipeliner/workdir/data`
- `/opt/ceyoniq/nscale-pipeliner/workdir/config`

## Start mit Docker

```bash
docker run \
  -h democontainer \
  -v $(pwd)/cold.xml:/opt/ceyoniq/nscale-pipeliner/workdir/config/runtime/cold.xml \
  -v $(pwd)/data:/opt/ceyoniq/nscale-pipeliner/workdir/data \
  -v $(pwd)/license.xml:/opt/ceyoniq/nscale-pipeliner/workdir/license.xml \
  ceyoniq.azurecr.io/release/nscale/pipeliner:8.3.1201.2022052510.0
```

## Konfiguration

nscale Pipeliner kann als einzige nscale Standard Container-Komponente nicht über Umgebungsvariablen konfiguriert werden.
Stattdessen besteht die Möglichkeit, mit nscale Administrator eine Standard-Konfigurationsdatei für nscale Pipeliner zu generieren, ohne nscale Administrator vorher mit nscale Pipeliner verbinden zu müssen.

Das Vorgehen zum Erstellen und Bearbeiten einer solchen `cold.xml` ist im nscale Pipeliner Konfigurationshandbuch beschrieben.
Die gesamte nscale-Dokumentation finden Sie in unserem Serviceportal unter <https://serviceportal.ceyoniq.com>.

Die spezielle Konfiguration richtet sich nach der Umgebung, in der sie verwendet wird.
Beachten Sie, dass unter Umständen auch Rechte in nscale für den Betrieb von nscale Pipeliner angepasst werden müssen.

### Docker-Compose

Mit dem Start von nscale Pipeliner wird das Spool-Verzeichnis im aktuellen Ordner angelegt. nscale Pipeliner verwendet das Spool-Verzeichnis, um Dateien kontinuierlich zu importieren.
Unter `./workdir/data` werden später die Eingangsdaten abgeholt.
Die zuvor offline konfigurierte `cold.xml` kann ebenfalls in diesem Ordner abgelegt und anschließend in den Container gemappt werden.
Dazu muss die Kommentarzeile unten herausgenommen und der Container neu instanziiert werden.

```bash
> vi docker-compose.pipeliner.yml
    ...
    volumes:
      - ./workdir/data:/opt/ceyoniq/nscale-pipeliner/workdir/data:rw
      #- ./workdir/config/cold.xml:/opt/ceyoniq/nscale-pipeliner/workdir/config/runtime/cold.xml:ro
      - ${PIPELINER_LICENSE_FILE}:/opt/ceyoniq/nscale-pipeliner/workdir/license.xml:ro

# Der Container muss neu instanziiert werden
> docker-compose up -d pipeliner

# Logs prüfen
> docker-compose logs -f pipeliner
```

### Kubernetes

In Kubernetes ist nscale Pipeliner als StatefulSet definiert und verwendet vier Volumes:

| Volume | Quelle | Beschreibung |
|-|-|-|
| `data` | RWX PersistenceVolumeClaim | Enthält das Spool-Verzeichnis und kann in mehrere Pods gemappt werden, um Daten abzulegen, die vom Pipeliner kontinuierlich importiert werden. |
| `setup`  | config map  | Vorbereitung des Pipeliner starts. |
| `cold` | `base/config/pipeliner/cold.xml` | Spezielle, offline erstellte Konfigurationsdatei. |
| `license.xml` | `base/license.xml` | Lizenzdatei |

Zur Aktivierung von nscale Pipeliner müssen Sie in der Datei `base/kustomization.yaml` und `overlay/*/kustomization.yaml` die Pipeliner Ressourcen einkommentieren.

Die `cold.xml` muss offline im nscale Administrator vorkonfiguriert werden damit sie über eine ConfigMap eingebunden werden kann. Da die Konfigurationsdatei Passwörter enthält kann es die Anforderung geben diese in Kubernetes Secrets auszulagern.
Im folgenden wird die Herangehensweise beschrieben, wie Passwörter aus Secrets in die `cold.xml` integriert werden bevor der nscale Pipeliner startet.

>**Achtung:** Die Passwörter in der vorkonfigurierten `cold.xml` sind *verschlüsselt*! Es handelt sich dabei um eine eigene Verschlüsselungsroutine im nscale Administrator. Wenn sich das Passwort ändert *muss* erneut nscale Administrator benutzt werden um das geänderte Passwort in die `cold.xml` einzutragen. Aus dieser neuen `cold.xml` muss dann das verschlüsselte Passwort extrahiert werden um es in Kubernetes Secrets zu hinterlegen.

#### Passwörter in der  `cold.xml` externalisieren

1. Erstellen Sie die `cold.xml` offline in nscale Administrator.

2. Ersetzen Sie die Passwörter in der `cold.xml` durch Platzhalter und bennen Sie die Datei um in `cold.tpl` als Vorlage für die anschliesende Transformation.  

3. Hinterlegen S die Passwörter selbst in Kubernetes Secrets.

```bash
kubectl create secret generic pipeliner-secret \
  --from-literal=database_user=<user> \
  --from-literal=database_pwd=<password> \
  --from-literal=appliation_user=<user> \
  --from-literal=appliation_pwd=<password> \
  --from-literal=storage_user=<user> \
  --from-literal=storage_pwd=<password>
```

4. Binden Sie die Passwörter aus dem Secret in den Pipeliner Container als Umgebungsvariablen ein.

```
   env:
      - name: DATABASE_USERNAME
        valueFrom:
          secretKeyRef:
            name: pipeliner-secret
            key: database_user
      - name: DATABASE_PASSWORD
        valueFrom:
          secretKeyRef:
            name: pipeliner-secret
            key: database_pwd
      - name: APPLICATION_LAYER_USERNAME
        valueFrom:
          secretKeyRef:
            name: pipeliner-secret
            key: application_user
      - name: APPLICATION_LAYER_PASSWORD
        valueFrom:
          secretKeyRef:
            name: pipeliner-secret
            key: application_pwd
      - name: STORAGE_LAYER_USERNAME
        valueFrom:
          secretKeyRef:
            name: pipeliner-secret
            key: storage_user
      - name: STORAGE_LAYER_PASSWORD
        valueFrom:
          secretKeyRef:
            name: pipeliner-secret
            key: storage_pwd
```

5. Rollen Sie die erweiterten Skripte in einer Kubernetes Configmap aus.

* `cold.tpl`: Die `cold.xml` Konfiguration ohne Passwörter.
* [`cold.xslt`](./pipeliner-cold.xslt): Style Sheet zur Transformation des `cold.tpl` Templates mit Umgebungsvariablen in die endgültige `cold.xml`.
* [`setup.sh`](./pipeliner-setup.sh): Erweitertes Setup Skript zur Generierung der `cold.xml` aus dem Template bevor der nscale Pipeliner startet.

```bash
kubectl create configmap pipeliner-config \
  --from-file=template=cold.tpl
  --from-file=stylesheet=cold.xslt
  --from-file=setup=setup.sh
```

6. Integrieren Sie die Skripte in das Pipeliner Deployment.

```
        volumeMounts:
        - name: config
          subPath: template
          mountPath: /opt/ceyoniq/nscale-pipeliner/workdir/config/runtime/cold.tpl
        - name: config
          subPath: stylesheet
          mountPath: /opt/ceyoniq/nscale-pipeliner/workdir/config/runtime/cold.xslt
        - name: config
          subPath: setup
          mountPath: /setup.sh
      volumes:
      - name: config
        configMap:
          name: pipeliner-conf
```

### Anpassen der `doc_mime_suff.tsv`

> Die Vorgehensweise kann auch auf andere Konfigurationsdateien angewendet werden.

Die Datei `doc_mime_suff.tsv` enthält Konfigurationen für MimeType, DocType und FileExtensions.
Diese Konfiguration kann angepasst werden.

#### Vorbereitung

Um Anpassungen an der `doc_mime_suff.tsv` vornehmen zu können, benötigen Sie diese Datei auf Ihrem Entwicklungssystem.
Diese Datei können Sie dem Image `ceyoniq.azurecr.io/release/nscale/pipeliner:8.3.1201.2022052510.0

Kopieren Sie die Datei `doc_mime_suff.tsv` lokal auf Ihr System:  

```bash
# Erzeugen eines temporären Containers
$ docker create ceyoniq.azurecr.io/release/nscale/pipeliner:8.3.1201.2022052510.0
a0123456789 

# Kopieren der Datei doc_mime_suff.tsv auf Ihr Entwicklungssystem
docker cp a0123456789:/opt/ceyoniq/nscale-pipeliner/workdir/config/common/doc_mime_suff.tsv ./

# Löschen des temporären Containers
docker rm a0123456789
```

#### Verwendung von externen Dateien (Bind-Mount und Volumes)

Um angepasste Dateien in dem jeweiligen Container verwenden zu können, müssen diese dem Container als Bind-Mount oder als Volume zur Verfügung gestellt werden. Je nach Betriebsumgebung unterscheidet sich die Vorgehensweise.

**Beispiel Docker:**

Um die angepasste `doc_mime_suff.tsv` verwenden zu können, muss diese Datei als Bind-Mount verfügbar gemacht werden.  

```bash
docker run -it ... -v ${PWD}/doc_mime_suff.tsv:/opt/ceyoniq/nscale-pipeliner/workdir/config/common/doc_mime_suff.tsv ceyoniq.azurecr.io/release/nscale/pipeliner:8.3.1201.2022052510.0
```

**Beispiel Docker-Compose:**

Um die angepasste `doc_mime_suff.tsv` verwenden zu können, muss diese Datei als Bind-Mount verfügbar gemacht werden.  

```yaml
volumes:
    - ./doc_mime_suff.tsv:/opt/ceyoniq/nscale-pipeliner/workdir/config/common/doc_mime_suff.tsv:ro
```

**Beispiel Kubernetes:**

Um die angepasste `doc_mime_suff.tsv` verwenden zu können, kann diese Datei als `ConfigMap` in Kubernetes konfiguriert werden.  

Weiter Informationen zu `ConfigMap` finden Sie hier:  
<https://kubernetes.io/docs/concepts/configuration/configmap/>