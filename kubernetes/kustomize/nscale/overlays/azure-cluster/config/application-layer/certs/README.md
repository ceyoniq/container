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

# check current certificates
../jre/bin/keytool -v -list -keystore certificates.store
# note the self-signed private key 'applicationlayer'

# Get SSL certificate from external server via openssl
openssl s_client -showcerts -connect google.com:443
^C

# extract the first certificate between -----BEGIN CERTIFICATE----- and -----END CERTIFICATE----- (including these lines)
# into the file google.com.cer

# check the extracted certificate
openssl x509 -in google.com.cer -noout -text

# import the certificate into the keystore
../jre/bin/keytool -importcert -alias google.com -file google.com.cer -keystore certificates.store

# check the keystore again
../jre/bin/keytool  -list -keystore certificates.store

```

Letztlich muss der adaptierte Keystore gesichert werden, um ihn im Deployment als Volume in den Container zu mappen.