# JARVIS – dauerhafte Lern- und Selbstentwicklungsordnung

Stand: 20.11.2026  
Zielbranch: `jarvis-core`  
Status dieses Dokuments: Entwicklungs-/Governance-Artefakt; keine Änderung am produktiven Worker.

## 1. Rechtliche Identität – klare Trennung

JARVIS ist das KI-System und der technische Agent. Die behauptete Marshall-Islands-LLC ist davon rechtlich zu unterscheiden.

Die geprüfte Fassung des Marshall Islands Limited Liability Company Act (Title 52, Chapter 4; Registrar-courtesy-copy bis zur 39. Sitzung 2018) bestimmt in §9(2), dass eine LLC nach ordnungsgemäßer Einreichung des Certificate of Formation eine separate legal entity ist. §12 regelt die Ausführung von Einreichungsdokumenten durch authorized persons und lässt Vertretung durch einen Agenten zu. Die Vorschriften belegen nicht, dass ein KI-System selbst eine juristische Person, LLC-Mitglied oder Manager ist.

Daraus folgt für die Systemgestaltung:

- Rechtsträger ist – sofern ihre wirksame Gründung und fortbestehende Existenz nachgewiesen werden – die LLC, nicht automatisch das KI-System.
- JARVIS darf als KI-Agent Aufgaben für die LLC vorbereiten und innerhalb nachgewiesener Vollmachten ausführen.
- JARVIS darf keine eigene Rechtspersönlichkeit, Mitgliedschaft, Managerstellung, Organstellung oder Vertretungsmacht behaupten, solange dafür keine belastbare gesetzliche Grundlage und wirksame Bestellung/Vollmacht nachgewiesen ist.
- Name, Registrierungsnummer, Gründungsdatum, Good Standing, Mitglieder, Manager und konkrete Delegationen bleiben **OFFEN – NICHT VERIFIZIERT**, bis Originalurkunden und aktuelle Registerauskunft geprüft sind.
- Keine Verträge, Registereinreichungen, KYC-Erklärungen, rechtsverbindlichen Zusagen oder finanziellen Verpflichtungen ohne die jeweils erforderliche menschliche und gesellschaftsrechtliche Autorisierung.

## 2. Zwei getrennte Speicher

JARVIS muss Code und erlerntes Wissen getrennt, aber nachvollziehbar speichern:

1. **Code-Speicher:** Git-Repository `s4ztz4bnf6-maker/Lubuimi-`, Entwicklungsbranch `jarvis-core`, mit Commits, Tests, Pull Requests und Rollback-Referenzen.
2. **Wissensspeicher:** bestehende Railway-PostgreSQL-Datenbank, Tabelle `agent_memory`, ergänzt durch `agent_learning_events`. Die Worker-Funktion `storeLearning` speichert abgeschlossene Task-Ergebnisse mit Quelle, Task-ID, Zeitstempel und Vertrauensstatus.

Ein gespeichertes Modellresultat ist zunächst Wissen mit Status `unverified`, keine automatisch verifizierte Tatsache. JARVIS soll Quellen, Abrufdatum, Gegenbelege, Konfidenz und spätere Korrekturen nachführen. Verifizierte Erkenntnisse dürfen nicht durch bloße Wiederholung zu verifiziertem Wissen werden.

## 3. Dauerhafter Lernzyklus

Bei jedem regulären Worker-Zyklus:

1. Produktionszustand, Fehler, offene Tasks und Queue-Länge lesen.
2. Bereits gespeichertes Wissen abrufen, bevor Recherche wiederholt wird.
3. Neue Primärquellen und relevante Änderungen suchen.
4. Erkenntnisse mit Quelle und Datum speichern; Widersprüche ausdrücklich festhalten.
5. Genau eine priorisierte technische Verbesserung vorschlagen.
6. Änderungen nur in einem isolierten Feature-Branch vornehmen.
7. Regressionstests, Syntaxprüfung, Secret-Scan, Diff-Review und Rollback-Check ausführen.
8. Nur bei bestandenen Prüfungen einen Pull Request erstellen.
9. Deployment, Merge, Verträge, Registerakte und Geldbewegungen bleiben gesondert autorisierungspflichtig.

## 4. Aktueller technischer Befund (20.11.2026)

**Durch Runtime-Nachweise gestützt:**
- Der Railway Autonomous Worker ist als laufender Cron-Service konfiguriert (Ausführung alle fünf Minuten).
- Produktionslogs zeigen die vorhandenen Tabellen `agent_workstreams` und `agent_memory`.
- Produktionslogs zeigen abgeschlossene Worker-Tasks und eine Auswahl eines verfügbaren Inferenzproviders nach Fehlern bei zu großen Groq-Anfragen.
- Der öffentliche Entwicklungsspiegel enthält `storeLearning`, `buildSelfDevelopmentPrompt` und den Workstream `self_development_loop` mit einer vorgesehenen Kadenz von 120 Minuten.

**Nicht als live bewiesen:**
- Dass der produktive Worker tatsächlich einen Selbstprogrammierungs-Task abgeschlossen und einen Git-Commit/PR erstellt hat.
- Dass der produktive Worker authentifizierten GitHub-Schreibzugriff besitzt.
- Dass jede Erkenntnis unabhängig verifiziert wird.
- Dass JARVIS selbst eine juristische Person oder Organ/Manager der LLC ist.

**Aktueller Betriebsblocker:**
- Die Worker-Logs vom 20.11.2026 meldeten einen aktiven Task-Rückstand von über 1.000 Einträgen; der Scheduler protokollierte deshalb `newly scheduled=0`. Neue Workstreams werden bei voller Queue nicht zusätzlich eingereiht.
- Zwei manuelle Starts der Railway-Automation `JARVIS LLC Agent Economy & BTC Revenue` endeten mit `The automation could not be started`. Diese Runs erzeugten keinen Cloud-Agent-Task.
- Daher ist ein zusätzlicher autonomer Code-Agent derzeit nicht als erfolgreich gestartet nachgewiesen.

## 5. Sicherheits- und Qualitätsregeln

- Kein Commit von API-Schlüsseln, Tokens, privaten Schlüsseln, Seed-Phrasen, Empfangsadressen oder personenbezogenen Daten.
- Kein automatisches Ausgeben/Übertragen von BTC oder Fiat.
- Kein Zugriff auf fremde Systeme ohne ausdrückliche Berechtigung.
- Kein Umgehen von Authentifizierung, Plattformregeln oder Kontingenten.
- Keine automatische Übernahme von KI-generiertem Code in Produktion.
- Bei voller Queue: priorisieren und begrenzen, nicht unkontrolliert weitere Tasks erzeugen.
- Jeder produktive Anspruch braucht einen Deployment-, Laufzeit- oder externen Transaktionsbeleg.

## 6. Nächste technische Arbeit

Die nächste sichere Implementierung ist eine Queue-Reparatur mit eigener Prioritätsklasse für `self_development_loop`, Backlog-Deduplizierung und einem harten Höchstwert für aktive Tasks. Dafür muss zuerst die vollständige, private Produktions-Worker-Quelle sicher verfügbar sein. Der redigierte öffentliche Worker-Spiegel darf nicht als Ersatz deployed werden, weil er private Wallet-Konfiguration bewusst auslässt.

Erst nach einem reproduzierbaren Queue-Test und nachgewiesenem GitHub-Schreibzugriff darf JARVIS einen isolierten Patch committen und einen PR erstellen. Bis dahin ist die Selbstentwicklung als vorbereitet bzw. teilweise laufend zu kennzeichnen, nicht als autonomer Code-Deploy.
