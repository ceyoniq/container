# nscale Server Application Layer

## Inhalt

- [nscale Server Application Layer](#nscale-server-application-layer)
  - [Inhalt](#inhalt)
  - [Lizenzierung](#lizenzierung)
  - [Persistierung](#persistierung)
  - [Konfiguration](#konfiguration)
  - [Umgebungsvariablen](#umgebungsvariablen)
  - [Logging in Kubernetes](#logging-in-kubernetes)
  - [Ports](#ports)
  - [Start mit Docker](#start-mit-docker)
  - [Microsoft Windows Schriftarten](#microsoft-windows-schriftarten)
    - [Nachinstallation über ein eigenes Container-Image](#nachinstallation-über-ein-eigenes-container-image)
    - [Bereitstellung über Volumes und Bind-Mounts](#bereitstellung-über-volumes-und-bind-mounts)
  - [Cluster-Konfiguration in Kubernetes](#cluster-konfiguration-in-kubernetes)
  - [Volltext-Cache](#volltext-cache)
  - [Inkludieren und Exkludieren von Job-Typen](#inkludieren-und-exkludieren-von-job-typen)
  - [SAP Anbindung](#sap-anbindung)
  - [Log Level](#log-level)
  - [Erweiterte Konfigurationen](#erweiterte-konfigurationen)
    - [LDAP](#ldap)
    - [SMTP](#smtp)

## Lizenzierung

Diese Komponente benötigt eine lokale Lizenzdatei.
Die Datei wird im Container hier erwartet: `/opt/ceyoniq/nscale-server/application-layer/conf/license.xml`.

## Persistierung

Diese Komponente benötigt keine Persistierung.

> Sie können weiterhin mit der Datei `/opt/ceyoniq/nscale-server/application-layer/conf/instance1.conf` oder mit einer beliebigen anderen Konfigurationsdatei arbeiten.
> Bitte beachten Sie aber, dass Sie diese Konfigurationsdatei persistieren müssen.

## Konfiguration

Sie können Umgebungsvariablen verwenden, um nscale Server Application Layer zu konfigurieren.  
Allerdings können Sie auch weiterhin die Datei `instance1.conf` verwenden, um nscale Server Application Layer zu konfigurieren.  
Beachten Sie dabei, dass Umgebungsvariablen eine höhere Priorität haben als Konfigurationseinstellungen in der Datei `instance1.conf`,
somit überlagern Werte von Umgebungsvariablen die Einstellungen aus der Datei `instance1.conf`.

## Umgebungsvariablen

>Die hier aufgeführte Liste der Umgebungsvariablen ist **nicht vollständig**.
Sie bildet lediglich die in unseren Beispielkonfigurationen verwendeten Umgebungsvariablen ab.

Die Benennung der Umgebungsvariablen von nscale Server Application Layer kann in mehreren Formaten erfolgen, die wir für Sie im nscale Server Application Layer Administrationshandbuch zusammengefasst haben.

Die gesamte nscale-Dokumentation finden Sie in unserem Serviceportal unter <https://serviceportal.ceyoniq.com>.

|Umgebungsvariable | Effekt |
|---|---|
|INSTANCE1_INSTANCE_LOGGER_CONF=instance1-log-console.conf | Wenn Sie diese Umgebungsvariable verwenden, werden alle Logging-Ausgaben von nscale Server Application Layer auf die Konsole statt in eine Logging-Datei geschrieben. Das ist im Containerbetrieb sinnvoll, da die Images ggf. verworfen werden und die Logdateien nicht mehr einsehbar sind. Ausgaben auf die Konsole werden vom Container-System gesammelt.|
|INSTANCE1_CORE_DB_DIALECT=PostgreSQL |Mit dieser Umgebungsvariable können Sie den Datenbankdialekt Ihrer Datenbank festlegen. Hier wurde PostgreSQL ausgewählt. |
|INSTANCE1_CORE_DB_DRIVERCLASS=org.postgresql.Driver | Mit dieser Umgebungsvariable können Sie den Treiber Ihrer Datenbank hinterlegen. Hier wurde der Treiber org.postgresql.Driver gewählt. |
|INSTANCE1_CORE_DB_URL=jdbc:postgresql://postgresql:5432/nscale?loggerLevel=OFF | Mit dieser Umgebungsvariable können Sie die URL Ihrer Datenbank hinterlegen. Passen Sie diesen Pfad ggf. an. |
|INSTANCE1_CORE_DB_USERNAME=nscale | Mit dieser Umgebungsvariable können Sie den Usernamen hinterlegen, mit dem der Application Layer auf die Datenbank zugreift. Hier wurde der Name "nscale" gewählt. |
|INSTANCE1_CORE_DB_PASSWORD=password | In dieser Umgebungsvariable können Sie das Passwort hinterlegen, mit dem der Application Layer auf die Datenbank zugreift. Ändern Sie das in diesem Beispiel verwendete Passwort unbedingt. |
|INSTANCE1_CORE_DB_SCHEMA=public | In dieser Umgebungsvariable können Sie das Datenbankschema hinterlegen. Hier wurde das Schema public gewählt. |
|INSTANCE1_CORE_WORK_DIRECTORY=/mnt/fulltextcache | In dieser Umgebungsvariable können Sie den Ordner für den lokalen Volltext-Cache definieren.|
|INITIALIZE_DOCUMENT_AREA=DA | Mit dieser Umgebungsvariable können Sie einen Dokumentenbereich mit dem Namen "DA" erstellen. |
|INITIALIZE_DOCUMENT_AREA_DISPLAYNAME=DA | Mit dieser Umgebungsvariable können Sie den Displayname des neu erstellten Dokumentenbereichs überschreiben. |
|KUBERNETES_NAMESPACE | Diese Umgebungsvariable ist für die Konfiguration des Clusters in Kubernetes notwendig. Weitere Details finden Sie unter [Cluster-Konfiguration in Kubernetes](#cluster-konfiguration-in-kubernetes). |

## Logging in Kubernetes

Um das Log Level im Kubernetes Betrieb zu ändern kann eine ConfigMap verwendet werden. Diese ConfigMap sollte die Log4j-Konfiguration aus dem Originalimage enthalten. Wird diese ConfigMap als Volume auf ein Verzeichnis gemappt
muss über die oben beschriebene Umgebungsvariable ```INSTANCE1_INSTANCE_LOGGER_CONF``` die neue Datei referenziert werden.
Ändert sich die ConfigMap im Cluster wird diese automatisch verteilt und über log4j Mechanismen nach wenigen Minuten in den
Serverprozess übernommen. Das gilt auch für mehrere Containerinstanzen in einem Deployment.

*Achtung:* Die ConfigMap muss auf ein Verzeichnis gemappt werden. Die Verwendung von subPath im Volume Mount verhindert eine automatische Aktualisierung bei Änderungen der ConfigMap!

## Ports

- 8080
- 8443

## Start mit Docker

```bash
 docker run \
   -e INSTANCE1_INSTANCE_LOGGER_CONF=instance1-log-console.conf \
   -e INSTANCE1_CORE_DB_DIALECT=PostgreSQL \
   -e INSTANCE1_CORE_DB_DRIVERCLASS=org.postgresql.Driver \
   -e INSTANCE1_CORE_DB_URL=jdbc:postgresql://postgresql:5432/nscale?loggerLevel=OFF \
   -e INSTANCE1_CORE_DB_USERNAME=nscale \
   -e INSTANCE1_CORE_DB_PASSWORD=password \
   -e  INSTANCE1_CORE_DB_SCHEMA=public \
   -h democontainer \
   -v $(pwd)/license.xml:/opt/ceyoniq/nscale-server/application-layer/conf/license.xml \
   -p 8080:8080 \
   ceyoniq.azurecr.io/release/nscale/application-layer:8.3.1300.2022062021.0
```

## Microsoft Windows Schriftarten

nscale Application Layer Server benötigt TrueType Schriftarten für die Konvertierung von
Dokumenten.  
Die Microsoft Windows Schriftarten sind nicht installiert, können aber nachinstalliert werden.
Sind keine Microsoft Windows Schriftarten installiert, so werden Ersatzschriftarten verwendet.

nscale Application Layer Server erwartet die Schriftarten im folgenden Ordner:  

```/usr/share/fonts/truetype/msttcorefonts```

### Nachinstallation über ein eigenes Container-Image

Sie können die Microsoft Windows Schriftarten nachinstallieren, indem Sie eigene Container-Images bauen.
Mit dem folgenden Kommando werden die Schriftarten nachinstalliert:

```bash
apt install ttf-mscorefonts-installer
```

### Bereitstellung über Volumes und Bind-Mounts

Sie können die Microsoft Windows Schriftarten auch durch ein Bind-Mount oder durch ein Volume bereitstellen.

nscale Application Layer Server erwartet die Schriftarten im folgenden Ordner:

```/usr/share/fonts/truetype/msttcorefonts```

Entsprechend können auch andere proprietäre Fonts nachinstalliert werden.

**Beispiel Docker:**

```bash
docker run ... -v ${PWD}/fonts:/usr/share/fonts/truetype/msttcorefont:ro ceyoniq.azurecr.io/release/nscale/application-layer:8.3.1300.2022062021.0
```

**Beispiel Docker-Compose:**

```yaml
volumes:
    - ./fonts:/usr/share/fonts/truetype/msttcorefonts:ro
```

## Cluster-Konfiguration in Kubernetes

nscale Server Application Layer kann skaliert werden und einen Cluster bilden.
Bei der Cluster-Bildung greifen mehrere nscale Server Application Layer auf dieselbe Datenbank zu.
So wird die Verteilung der Last eines größeren nscale Systems auf mehrere Server bzw. Rechner ermöglicht.
Dafür ist es notwendig, dass Sie die folgenden Konfigurationen ausführen:

- Berechtigungen zum Listen und Finden anderer Pods und Application Layer Instanzen in Kubernetes: ServiceAccount, Role und RoleBinding;
- Kubernetes Namespace: nscale Server Application Layer kann nur Pods in dem Namespace suchen, in dem er ausgeführt wird (Umgebungsvariable "KUBERNETES_NAMESPACE");
- Label für den Cluster: nscale Server Application Layer sucht nur Pods mit dem Label `ceyoniq.com/application-layer-cluster-name=[cluster name]`.

Wenn Sie die Clusterbildung für ein containerisiertes System aktiviert haben, wird automatisch der Protokollstapel "tcp Kubernetes" verwendet.
Diese Konfiguration kann in nscale Administrator nicht bearbeitet werden.

Eine Beispiel-Konfiguration finden Sie in [application-layer.yaml](../../../kubernetes/kustomize/nscale/base/application-layer.yaml)

## Volltext-Cache

Wenn Sie nscale Server Application Layer Standard Container starten, ist der Volltext-Cache aktiviert.  
Der Volltext-Cache kann unter Umständen viel Speicher benötigen.  
In den Docker-Compose- und Kubernetes-Beispielen wurde der Volltext-Cache explizit deaktiviert.

Docker-Compose:  

```bash
INSTANCE1_CORE_FULLTEST_INDEX_MIRROR_LOCALCACHE=off
```

Kubernetes:  

```yaml
- name: INSTANCE1_CORE_FULLTEST_INDEX_MIRROR_LOCALCACHE
  value: "off" 
```

Wenn Sie den Volltext-Cache verwenden wollen, beachten Sie, dass der Ordner `/opt/ceyoniq/nscale-server/application-layer/temp`
sehr groß werden kann.  
Wir empfehlen Ihnen, hierfür ein geeignetes Volume anzulegen.

## Inkludieren und Exkludieren von Job-Typen

Sie können nscale Server Application Layer so konfigurieren, dass nur spezielle Jobs auf einer Instanz ausgeführt werden.  
Die Inklusion bzw. Exklusion eines Jobs kann durch Setzen einer Umgebungsvariable erfolgen.

Exkludieren von Jobs:  

```bash
INSTANCE1_CLUSTER_CORE_JOB_COORDINATOR_EXCLUDEJOBNAMES=ArchiveJob,AuditLogJob
```

Inkludieren von Jobs:  

```bash
INSTANCE1_CLUSTER_CORE_JOB_COORDINATOR_JOBNAMES=ArchiveJob,AuditLogJob
```

Weitere Informationen dazu finden Sie in der Dokumentation von nscale Server Application Layer.

## SAP Anbindung

Für den SAP Java Connector für die RFC-Kommunikation im Application Layer werden zusätzliche Bibliotheken benötigt,
die nicht im Standard Container ausgeliefert werden (siehe "SAP Java Connector" im ERP Manual).
Wird die ERP Installation im Container durchgeführt sollte eine Ableitung des Application Layer Standard Containers benutzt werden.

Bisher wurde die erweiterte SAP Funktion insbesondere auch Application Layer Cluster noch nicht getestet.

## Log Level

Zur Fehleranalyse ist es unter Umständen notwendig, das Loglevel des Servers anzupassen.
Das Loglevel des Servers können Sie in der log4j-Konfiguration in der Datei `conf/instance1-log-console.conf` anpassen.
Kopieren Sie diese Datei zuerst aus dem Container heraus, bearbeiten Sie sie dann offline wie unten beschrieben und transferieren Sie die bearbeitete Datei anschließend wieder zurück in den Container.
Alternativ können Sie auch die Konfigurationsdatei mit dem `vi` im Container bearbeiten.
Beachten Sie bei diesem Vorgehen, dass Änderungen an Dateien im Container nicht persistiert werden.

Im Cluster muss die Datei in allen Instanzen ausgetauscht werden.

**Beispiel Docker-Compose:**

```bash
docker-compose exec application-layer bash
> vi /opt/ceyoniq/nscale-server/application-layer/conf/instance1-log-console.conf 
```

**Beispiel Kubernetes:**

```bash
# copy file to host
kubectl cp application-layer-0:/opt/ceyoniq/nscale-server/application-layer/conf/instance1-log-console.conf instance1-log-console.conf -n <namespace> -c application-layer

# edit locally

# copy file to nappl container
kubectl cp instance1-log-console.conf application-layer-0:/opt/ceyoniq/nscale-server/application-layer/conf/instance1-log-console.conf -n <namespace> -c application-layer
```

## Erweiterte Konfigurationen

Im Container von nscale Server Application Layer befindet sich ein Konfigurations-Skript unter `/opt/ceyoniq/nscale-server/application-layer/bin/application-layer-setup.sh`.
Dieses Skript wird beim Start des Containers aufgerufen.
Es kann um die LDAP-Konfiguration und die SMTP-Konfiguration erweitert werden.
Die dafür benötigten Konfigurationsdateien werden über Befehle in der Application Layer Command Line (`al`) im Container erzeugt.

>Beachten Sie, dass einige JSON-Konfigurationsdateien sensible Daten enthalten. Verwenden Sie daher [secrets](https://kubernetes.io/docs/concepts/configuration/secret/) oder andere Sicherheitsmaßnahmen, die besser zu Ihrem Szenario passen.

### LDAP

Um automatisiert ein LDAP Settings anzulegen gehen Sie wie folgt vor:

1. Erstellen Sie ein vollständige LDAP Konfiguration im Administrator das Sie als Template verwenden möchten.
2. Exportieren Sie dieses Konfiguration in eine Template Datei innerhalb des Containers  
 `al cfg-get -type LdapSetting -name <name> -dialect JSON > ldap.tpl`
3. Ersetzen Sie im Template das Passwort und den Benutzernamen durch Variablen:  
  `"baseDN" : "%basename%"`
  `"encodedPassword" : "%encodedPassword%"`
4. Nutzen Sie eine Skriptsequenz wie diese in `application-layer-setup.sh`, um die Settings aus dem Template zu importieren. Die Template Datei muss im abgeleiteten Image vorhanden sein (oder in den Container gemappt werden).

```bash
# encode password
pwd=$(al dbpass ${LDAP_PASSWORD})
# generate file from template
sed "s/%encodedPassword%/${pwd}/;s/%basename%/${LDAP_BASENAME}/" ldap.tpl > ldap.json
# import setttings
al cfg-add -type LdapSetting -file ldap.json
# remove temporary configuration
rm ldap.json
```

Unten sehen Sie ein Beispiel einer Template Datei.

```json
{
"ldapServiceName" : "CT",
"serverAddress" : { "host" : "001ctads2.CT.com", "port" : 636 },
"ssl" : true,
"baseDN" : "%basename%",
"managerDN" : "print",
"encodedPassword" : "%my-econcoded-pass%",
"userBaseDN" : "ou=Benutzer",
"groupBaseDN" : "ou=Gruppen",
"ldapDialect" : "ActiveDirectory2012",
"loginSuffix" : null,
"userSearchFilter" : "(&(objectClass=top)(objectClass=person)(objectClass=organizationalPerson)(objectClass=user))",
"groupSearchFilter" : "(&(objectClass=top)(objectClass=group))",
"uuidAttributeName" : "objectGUID",
"uuidAttributeBinaryType" : true,
"uuidOverlayAttributeName" : null,
"uuidOverlayAttributeBinaryType" : true,
"loginAttributeName" : "userPrincipalName",
"groupNameAttributeName" : "name",
"memberAttributeName" : "member",
"commonNameAttributeName" : "cn",
"descriptionAttributeName" : "description",
"emailAttributeName" : "mail",
"lastModifiedAttributeName" : "modifyTimeStamp",
"accountNameAttributeName" : null,
"managerAttributeName" : "manager",
"hashAlgorithm" : null,
"usePaging" : true,
"pageSize" : 2000,
"timeout" : 2001,
"firstNameAttributeName" : "givenName",
"lastNameAttributeName" : "sn",
"organizationAttributeName" : "company",
"roleAttributeName" : "department",
"titleAttributeName" : "title",
"officeAttributeName" : "physicalDeliveryOfficeName",
"urlAttributeName" : "wWWHomePage",
"photoAttributeName" : "ThumbnailPhoto",
"noteAttributeName" : "info",
"languageAttributeName" : "preferredLanguage",
"initialsAttributeName" : "initials",
"personnelNumberAttributeName" : "employeeID",
"publicKeyAttributeName" : null,
"departmentAttributeName" : null,
"addressLabelAttributeName" : "cn",
"addressPOBoxAttributeName" : "postofficebox",
"addressStreetAttributeName" : "streetAddress",
"addressPostalCodeAttributeName" : "postalCode",
"addressLocalityAttributeName" : "l",
"addressRegionAttributeName" : "st",
"addressCountryAttributeName" : "co",
"homePhoneAttributeName" : "homePhone",
"workPhoneAttributeName" : "telephoneNumber",
"faxAttributeName" : "facsimileTelephoneNumber",
"mobileAttributeName" : "mobile",
"pagerAttributeName" : "pager",
"synchronizePrincipalInfo" : true,
"enableExtendedUserAttributes" : true,
"enableExtendedGroupAttributes" : true,
"overwriteMultiValues" : false,
"synchronizeCompetences" : true,
"multiValueUpdatePolicies" : { }
}
```

### SMTP

Um automatisiert ein SMTP Settings anzulegen gehen Sie wie folgt vor:

1. Erstellen Sie ein vollständige Email Server Konfiguration im Administrator das Sie als Template verwenden möchten.
2. Exportieren Sie dieses Konfiguration in eine Template Datei innerhalb des Containers  
 `al cfg-get -type EmailServer -name <name> -dialect JSON > email.tpl`
3. Ersetzen Sie im Template das Passwort und den Benutzernamen durch Variablen:  
  `"userName" : "%username%"`
  `"userPassword" : "%encodedPassword%"`
4. Nutzen Sie eine Skriptsequenz wie diese in `application-layer-setup.sh`, um die Settings aus dem Template zu importieren. Die Template Datei muss im abgeleiteten Image vorhanden sein (oder in den Container gemappt werden).

```bash
# encode password
pwd=$(al dbpass ${EMAIL_PASSWORD})
# generate file from template
sed "s/%encodedPassword%/${pwd}/;s/%username%/${EMAIL_BASENAME}/" email.tpl > email.json
# import setttings
al cfg-add -type EmailServer -file email.json
# remove temporary configuration
rm email.json
```

Hier sehen Sie ein Beispiel, wie die Datei `email.json` aussehen könnte.

```json
{
"name" : "default",
"serverAddress" :{ "host" : "localhost", "port" : 465 },
"userName" : "admin",
"userPassword" : "28f64920fc",
"defaultSenderMailAddress" : "ncloud@ceyoniq.com",
"defaultSenderName" : null,
"defaultReplyToAddress" : "ncloud@ceyoniq.com",
"sslMode" : "SSL",
"calendarRequests" : false,
"default_" : true,
"active" : true,
"exchangeServerSetting" : {
  "version" : null, "ewsEnabled" : false, "domainName" : null, "synchronizePrincipalInfoToContactFolders" : false },
"encoding" : null,
"sign" : false,
"keyStore" : null,
"keyStorePassword" : null,
"keyStoreAlias" : null
}
```