# nscale Pipeliner

## Lizenzierung

nscale Pipeliner benötigt eine lokale Lizenzdatei.
Hinterlegen Sie diese im Ordner "/opt/ceyoniq/nscale-pipeliner/workdir/license.xml".

## Persistierung

Um zu gewährleisten, dass Sie nach dem Herunterfahren des Systems weiterhin Zugriff auf Ihre Daten haben, sorgen Sie für eine Persistierung Sie der Ordner
 "/opt/ceyoniq/nscale-pipeliner/workdir/data" und
 "/opt/ceyoniq/nscale-pipeliner/workdir/config".

## Umgebungsvariablen

nscale Pipeliner kann als einzige nscale Standard Container-Komponente nicht über Umgebungsvariablen konfiguriert werden.
Stattdessen besteht die Möglichkeit mit nscale Administrator eine Standard Konfigurationsdatei für nscale Pipeliner zu generieren, ohne nscale Administrator vorher mit nscale Pipeliner verbinden zu müssen.
Diese Datei hat den Namen Cold.xml.
Die Standard-Cold.xml können Sie anschließend nach Ihren Bedürfnissen verändern.
Wenn Sie eine Cold.xml nach Ihren Bedürfnissen erstellt haben, können Sie diese händisch in den Pod des nscale Pipeliner einbringen.
Anschließend können Sie Ihr System mit nscale Pipeliner starten.

Das Vorgehen zum Erstellen und Bearbeiten einer Cold.xml ist im nscale Pipeliner Konfigurationshandbuch beschrieben.
Die gesamte nscale-Dokumentation finden Sie in unserem Serviceportal unter <https://serviceportal.ceyoniq.com/>.
