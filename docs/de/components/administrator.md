# nscale Console

## Inhalt

- [nscale Console](#nscale-console)
  - [Inhalt](#inhalt)
  - [Lizenzierung](#lizenzierung)
  - [Persistierung](#persistierung)
  - [Umgebungsvariablen](#umgebungsvariablen)
  - [SSL Verschlüsselung](#ssl-verschlüsselung)
    - [Zertifikat mit openssl und keytool erstellen](#zertifikat-mit-openssl-und-keytool-erstellen)
  - [Ports](#ports)
  - [Start mit Docker](#start-mit-docker)

## Lizenzierung

Diese Komponente benötigt keine lokale Lizenzdatei.

## Persistierung

Diese Komponente benötigt keine Persistierung.

## Umgebungsvariablen

>Die hier aufgeführte Liste der Umgebungsvariablen ist nicht **vollständig**.

|Umgebungsvariable | Effekt |
|---|---|
|APPLICATION_LAYER_HOST=application-layer |Sie müssen den Namen oder die IP-Adresse des Containers angeben, über den der nscale Server Application Layer erreichbar ist, um eine Verbindung aufzubauen.|
|APPLICATION_LAYER_PORT=8080 | Sie können den Port des Application Layer Servers angeben, um eine Verbindung aufzubauen. Der Standardwert ist "8080".|
|APPLICATION_LAYER_INSTANCE=nscalealinst1 |Sie können die Application Layer Instanz für den Anmeldeversuch am nscale Server Application Layer auswählen. Dies ist nur nötig, wenn Sie mehrere nscale Server Application Layer Instanzen installiert haben.|

## SSL Verschlüsselung

Dieser Container enthält ein self-signed SSL Zertifikat mit dem die Kommunikation über 
den SSL Port 8443 verschlüsselt wird. In Produktionsumgebungen wird  üblicherweise vor
dem Container ein Reverse Proxy konfigurieren, der die SSL Verschlüsselung übernimmt.

Es ist allerdings auch möglich ein eigenes Zertifikat in den Container zu mappen.

### Zertifikat mit openssl und keytool erstellen

Die folgende Kommandosequenz wird verwendet, um das Zertifikat zu erstellen, das mit dem Container ausgeliefert wird.

```bash
# Anlegen eines self-signed Zertifikats
openssl req -nodes -new -x509 -subj "/C=CN/ST=GD/L=SZ/O=Ceyoniq, Inc./CN=localhost" -keyout jetty.key -out jetty.cert
# Erstellen des Java keystores für jetty
keytool -keystore keystore -storepass changeit -noprompt -import -alias jetty -file jetty.cert -trustcacerts
# Transformation in PKCS12
openssl pkcs12 -inkey jetty.key -in jetty.cert -export -out jetty.pkcs12 -password pass:transfer
# Import des Zertifikats in den Java keystore
keytool -storepass changeit -importkeystore -srckeystore jetty.pkcs12 -srcstoretype PKCS12 -destkeystore keystore -srcstorepass transfer
```

Der `keystore` wird auf den Pfad `/var/lib/jetty/etc/keystore` im Container gemappt. 
Registriert wird das Zertifikat in `/var/lib/jetty/start.d/https.ini`. Dort steht auch das
verschlüsselte Passwort des Keystores. Die Verschlüsselung dieses Passworts wird von einer
Jetty Bibliothek übernommen (`java -cp /usr/local/jetty/lib/jetty-util-*.jar org.eclipse.jetty.util.security.Password <password>`)

## Ports

- 8080 (unverschlüsselt)
- 8443 (verschlüsselt)

## Start mit Docker

```bash
docker run \
   -e HostName=application-layer \
   -e Port=8080 \
   -e ALInstance=nscalealinst1 \
   -e JAVA_OPTIONS=-Dorg.eclipse.rap.rwt.settingStoreFactory=settings-per-user -Duser.language=de\
   -p 8181:8080 \
   -p 8182:8443 \
   ceyoniq.azurecr.io/release/nscale/administrator:8.3.1100.2022042515
```
