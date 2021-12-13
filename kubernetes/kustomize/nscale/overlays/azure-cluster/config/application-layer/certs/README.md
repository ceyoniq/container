# Zertifikate Importieren

Beim Start des Application Layers wird im Default der Keystore
`/opt/ceyoniq/nscale-server/application-layer/conf/certificates.store`
aus dem Template
`/opt/ceyoniq/nscale-server/application-layer/conf/templates/certificates.store.template` kopiert
und um ein self-signed Zertifikat erweitert.
Ist der Keystore schon vorhanden wird dieser verwendet.

Die folgenden Hinweise erläutern, wie der Standard Keystore um weitere Zertifikate (z.B. LDAP Server)
erweitert werden kann. Dazu muss eine Shell im Container geöffnet werden.

```bash
cd /opt/ceyoniq/nscale-server/application-layer/conf

# show all current certificates
keytool -list -rfc -keystore certificates.store -storepass password
# note the self-signed private key 'applicationlayer'
keytool -list -rfc -keystore certificates.store -alias applicationlayer -storepass password

# Get SSL certificate from external server (google.com) via openssl
openssl s_client -showcerts -connect google.com:443 </dev/null 2>/dev/null | openssl x509 -outform PEM > google.com.cer

# check the extracted certificate
openssl x509 -in google.com.cer -noout -text

# import the certificate into the keystore
keytool -importcert -alias google.com -file google.com.cer -keystore certificates.store -storepass password -noprompt

# check the keystore again
keytool -list -keystore certificates.store -storepass password
keytool -list -rfc -keystore certificates.store -alias google.com -storepass password
```

Letztlich muss der adaptierte Keystore gesichert werden, um ihn im Deployment als Volume in den Container zu mappen.