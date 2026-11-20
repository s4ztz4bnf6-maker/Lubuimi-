# JARVIS – autonomer Selbstentwicklungszyklus

Status: Implementierter, isolierter Entwicklungsbaustein; noch nicht in den produktiven Worker integriert.

## Zweck
JARVIS soll selbständig recherchieren, aus Fehlern lernen, technische Verbesserungen vorschlagen und sichere Codeänderungen vorbereiten. Der Baustein ist eine ausführbare Policy-Grenze, kein Sprachmodell und kein autonomer Produktions-Deploy-Agent.

## Ablaufziel
1. Produktionszustand und Task-Queue beobachten.
2. Vorhandenes Wissen abrufen; neue Erkenntnisse mit Datum und Quellen speichern.
3. Erkenntnisse standardmäßig als `unverified` behandeln.
4. Bei Queue-Überlastung, Duplikaten oder wiederholten Fehlern keine weiteren Tasks erzeugen.
5. Verbesserungen ausschließlich auf isolierten Branches vorbereiten.
6. Tests, Secret-Scan und Rollback-Nachweis vor einem PR verlangen.
7. Einen reviewbaren Pull Request erstellen, nie direkt in geschützte Branches schreiben.
8. Merge, Produktionsdeployment, Geldbewegungen, Wallet-Änderungen, Verträge und rechtliche Einreichungen bleiben menschlich autorisiert.

## Implementierter Code
- `JARVIS-Core/tools/self-development-controller.mjs`: Queue-Begrenzung, Circuit Breaker, Branch-/Patch-Policy und Evidenzlabel.
- `JARVIS-Core/tests/self-development-controller.test.mjs`: Regressionstests der Sicherheitsregeln.
- `.github/workflows/jarvis-selfdev-guardrails.yml`: führt die Tests bei passenden Pushes, PRs und manuell aus.

## Betriebsgrenze
Dieser Commit wird nicht automatisch vom bestehenden Railway Worker geladen. Der produktive Worker hat eine separate, obfuskierte Startkonfiguration; der veröffentlichte Worker-Spiegel ist nicht ausreichend, um ihn sicher zu ersetzen. Für echte autonome Codegenerierung braucht JARVIS zusätzlich einen autorisierten Modell-/Agent-Endpunkt und einen eng begrenzten GitHub-Schreibweg. Diese Zugangsdaten dürfen nur als Secret im jeweiligen Laufzeitdienst liegen, niemals im Repository. Ohne diese Integration ist der neue Baustein ein getesteter Sicherheitskern, keine laufende Selbstprogrammierung.

## Governance
JARVIS handelt als KI-Agent für den behaupteten Rechtsträger, nicht als eigenständige juristische Person. Die LLC-Existenz, Registerdaten und Vollmachten müssen separat anhand aktueller Originalunterlagen geprüft werden. Der Code verleiht JARVIS keine Organstellung oder Vertretungsmacht.
