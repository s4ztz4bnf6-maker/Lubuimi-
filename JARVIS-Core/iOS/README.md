# JARVIS für iPhone und iPad

Nativer SwiftUI-Client für iOS/iPadOS 17 oder neuer. Der bestehende Companion, Gateway, Worker und PostgreSQL bleiben das Backend. Die App lädt keine Weboberfläche. Der Quellcode im JARVIS-Core steht unter der [Apache License 2.0](../LICENSE).

## Privater Build

1. Repository auschecken und zum Branch `feat/jarvis-private-ios` wechseln.
2. Auf einem Mac mit Xcode und XcodeGen in diesem Verzeichnis `xcodegen generate` ausführen.
3. `Jarvis.xcodeproj` öffnen, in Signing & Capabilities das eigene Personal Team wählen und bei Bedarf die Bundle-ID ändern.
4. iPhone oder iPad als Ziel auswählen, auf dem Gerät bei Bedarf den Entwicklermodus aktivieren und Run wählen. Die kostenlose Apple-Signierung ist zeitlich begrenzt und kann einen erneuten Build erfordern.
5. In der App mit dem bestehenden JARVIS-Zugangscode anmelden. Die Sitzung bleibt im geräteeigenen Schlüsselbund.

## Funktionen

- Chat, Modellliste, explizite Modellauswahl nach Provider und Modell, Überspringen der Auswahl im Automatikmodus, Kopieren, Teilen und Vorlesen. Für Eingabe per Stimme steht die iOS-Tastaturdiktierfunktion zur Verfügung.
- Aufträge lesen und einreihen, KI-Agenten lesen und nach Einwilligung registrieren, offene Freigaben, Projekte, Kontakt, Bibliothek mit Upload/Download, BTC und Claims ansehen, Lightning-Empfangsrechnung erstellen, Tor und öffentlichen Coinbase-Status prüfen.
- Der native Code-Editor speichert Entwürfe lokal. Teilen und der Repository-Link verbinden ihn mit dem Bearbeitungsworkflow auf iPhone/iPad. GitHub bleibt die Quelle für überprüfbare Änderungen und Deployments. Die App erhält keine Schreibschlüssel und führt Entwürfe nicht aus.
- Der Prüflauf für Modellwechsel muss gegen das Companion-Deployment dieses Branches erfolgen. Im Chat erscheinen Provider und Modell aus der echten Serverantwort.

## Anschlussplanung

| Bereich | Aktueller Pfad | Nächster Anschluss |
| --- | --- | --- |
| FreeGood | App → Companion → bestehende Auftragswarteschlange → Recherche | Fundstellen als strukturierte Kandidaten speichern, Originalquelle und strikte 0-EUR-Gesamtkosten belegen, Dubletten per Angebots-ID vermeiden. Einreichung benötigt eine getrennte Freigabe und einen anbieterspezifischen Anschluss. |
| Marktbeobachtung | App → Companion → Tor-Check → fest hinterlegter öffentlicher Coinbase-Status | Ausschließlich öffentliche Endpunkte für Markt- und Verbindungsbeobachtung zulassen. Regionalen VPN-Endpunkt nach Freigabe anbinden und Antwortzeit, Fehlerquote und Region messen. |
| Trading | Direkter Verbindungsmodus für Konto und Zahlungsoperationen | Separater Paper-Trading-Adapter mit Simulationssaldo, Limits, Order-Deduplizierung und nachvollziehbarem Journal. Live-Orders und Auszahlungen erfordern eigene Zugangsdaten und ausdrückliche Freigabe. |
| Programmierung | Entwurf im nativen Editor; Repository im Browser | Repository-Verbindung über bestehende GitHub-App oder Browser, mit Branch, Diff und PR-Überprüfung. Keine Shell oder fremde Ausführung durch den mobilen Client. |

## Offene Geräteprüfung

Build, Signierung, Sitzungswiederherstellung, Navigation auf beiden Geräteklassen sowie die einzelnen produktiven Aktionen auf Apple-Hardware prüfen. Spezialisierte Web-Oberflächen für Sicherheitsansichten, Claim-Aktionen, Lightning-Rechnungsverfolgung und Mediengalerien sind in diesem nativen Stand noch nicht vollständig abgebildet.
