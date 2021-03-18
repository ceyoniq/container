# nscale Console

## Lizenzierung

nscale Console benötigt keine lokale Lizenzdatei.

## Persistierung

Um zu gewährleisten, dass Sie nach dem Herunterfahren des Systems weiterhin Zugriff auf Ihre Daten haben, sorgen Sie für eine Persistierung Sie des Ordners "/opt/ceyoniq/nscale-server/console/conf".

## Umgebungsvariablen

>Die hier aufgeführte Liste der Umgebungsvariablen ist **vollständig**.

|Umgebungsvariable | Effekt |
|---|---|
|HostName=application-layer |Sie müssen den Namen oder die IP-Adresse des Containers angeben, über den der nscale Server Application Layer erreichtbar ist, um eine Verbindung aufzubauen.|
|Port=8080 | Sie können den Port des Application Layers angeben, um eine Verbindung aufzubauen. Der Standardwert ist "8080".|
|NAPPL_SSL=false | Sie können festelgen, ob SSL verwendet werden soll, um eine Verbindung aufzubauen. Der Standardwert ist "false". |
|ALInstance=nscalealinst1 |Sie können die Application Layer Instanz für den Anmeldeversuch auswählen. Dies ist nur nötig, wenn Sie mehrere nscale Server Application Layer Instanzen installiert haben.|
|AlName=ApplicationLayer |Sie können den Application Layer für den Anmeldeversuch auswählen. Dies ist nur nötig, wenn Sie mehrere nscale Server Application Layer installiert haben.|
|defaultAlInstance=nscalealinst1 |Sie können eine Default-Instanz für die Anmeldung auswählen. Dies ist nur nötig, wenn Sie mehrere nscale Server Application Layer Instanzen installiert haben.|
|defaultAlName=ApplicationLayer|Sie können einen Defalut-Application Layer für die Anmeldung auswählen. Dies ist nur nötig, wenn Sie mehrere nscale Server Application Layer installiert haben.|

## Limitierungen im Containerumfeld

### Plug-ins

|Plug-in | Verfügbarkeit|
|---|---|
|Benutzerverwaltung |verfügbar|
|Konfiguration|nicht verfügbar|
|Mail|nicht verfügbar|
|Navigator|verfügbar|
|nstore|verfügbar|
|Partitionen|nicht verfügbar|
|Willkommen & Information|verfügbar|
|eGov Administration |verfügbar|
|AdminType|verfügbar|

### Funktionen

Es steht die Funktion "Kennwortänderung zur Verfügung.
Mit dieser Funktion können Sie das Passwort des angemeldeten Benutzers ändern.
Beachten Sie dabei, dass sich lediglich das Passwort für nscale Console ändert.
Die anderen Komponenten sind nicht von dieser Kennwortänderung betroffen.
