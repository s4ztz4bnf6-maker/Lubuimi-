# Erdős–Selfridge / Lean-Audit — Arbeitsstand 2026-10-14

## Status
Dieser Bericht friert den Arbeitsstand zum Zeitpunkt der Speicherung ein. Er trennt nachgewiesene Compiler-Ausgaben, konkrete Tests und noch offene Schlussfolgerungen.

## Repository und relevante Artefakte
- Audit-Repository: https://github.com/s4ztz4bnf6-maker/Lubuimi-
- Branch: `audit/nonempty-delta-contrast`
- Audit-Datei: https://github.com/s4ztz4bnf6-maker/Lubuimi-/blob/audit/nonempty-delta-contrast/AuditCheck.lean
- Ursprüngliche formalisierte Quelle (separates Repository): https://github.com/s4ztz4bnf6-maker/Lubuimi/blob/audit/lean4-erdos-selfridge/ErdosSelfridge_v17_fixed.lean
- Neuester gespeicherter Audit-Commit zum Zeitpunkt dieses Berichts: `e9fca28445e1d726db81a2202500d17d57f1d790`
- Commit-URL: https://github.com/s4ztz4bnf6-maker/Lubuimi-/commit/e9fca28445e1d726db81a2202500d17d57f1d790

## Mathematischer/formaler Verdacht
Die Definitionen in der Quelle enthalten:
- `sieveProd`: Ergebnis `1`, wenn eine der Listen leer ist.
- `sieveTerm`: Minimum aus `M1bound` und `M2bound / (4 * δk * (1 - δk))`.
- `sieveSum`: Summe der Siebterme über `List.range ss.length`.

Das Axiom `sieve_criterion` verlangt nur `1 ≤ ca1` und `sieveSum ... < 1`, aber keine expliziten Bedingungen wie `0 < δ < 1` für die Delta-Parameter und keine ausdrückliche Nichtleerheitsbedingung.

### Degenerationsfälle im Audit
1. **Leere Delta-Liste** `δs = []`: Die vorhandenen Audit-Lemmas zeigen für positive Blockgrößen, dass `sieveTerm` und `sieveSum` null werden. Daraus wird mit `sieve_criterion` ein `False` abgeleitet.
2. **Nichtleere Liste mit Null**: Ein zusätzlich gespeicherter konkreter Test lautet `sieveSum 1 1 [1] [0] = 0`. Der Nenner `4 * δ * (1 - δ)` ist null; Leans rationale Division durch null macht diesen Quotienten null. Damit reicht Nichtleerheit allein nicht.
3. **Nichtdegenerierter Kontrasttest**: Gespeichert ist `sieveSum 1 2 [1] [1 / 2] = 1`. Dieser einzelne Kontrast illustriert, dass ein nichtdegenerierter Parameterfall nicht automatisch denselben Null-Fallback zeigt; er ist keine allgemeine Aussage über alle nichtleeren Delta-Listen.

## Tatsächliche CI-Evidenz
- Lauf `38483634612`: https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/38483634612
  - Originalquelle kompilierte erfolgreich.
  - Der nachfolgende Schritt für `AuditCheck.lean` scheiterte beim damaligen Kontrasttest in Zeile 102 mit `unsolved goals: ⊢ False`.
  - Die Ausgabe der `#print axioms`-Befehle erschien dennoch in den Logs. Unter anderem zeigte `degenerate_axiom_acceptance` die Abhängigkeit von `sieve_criterion`; `erdos_selfridge` hängt von `sf_sieve_lt_one` und `sieve_criterion` ab.
- Lauf `38484642307`: https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/38484642307
  - Bei letzter Abfrage noch `in_progress`; kein Erfolg bestätigt.
- Lauf `38484876322` für Commit `e9fca284...`: https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/38484876322
  - Bei letzter Abfrage noch `in_progress`; die Schritte waren noch bei der Einrichtung/Manifest-Erzeugung. Die neuen Tests waren zu diesem Zeitpunkt nicht kompiliert. Kein Erfolg bestätigt.

## Interpretation und offene Punkte
- **Vorläufiger Befund:** Die Axiom-Spezifikation scheint durch zulässige degenerierte Parameterwerte angreifbar. Der Fall `δs = []` ist durch die bestehenden Audit-Lemmas ausgearbeitet; der Fall `δs = [0]` wurde als konkreter zusätzlicher Lean-Test gespeichert, dessen CI-Bestätigung zum Zeitpunkt dieses Berichts noch ausstand.
- Das ist ein möglicher Mangel der Formalisierung/Axiom-Spezifikation, **kein Gegenbeweis zur Erdős–Selfridge-Vermutung selbst**.
- Der erfolgreiche Compilerlauf der Originalquelle bestätigt nur, dass die Datei kompiliert; er bestätigt nicht die mathematische Korrektheit der Axiome oder des Gesamtbeweises.
- Nicht behaupten, dass die neuesten Tests erfolgreich waren, bis der passende Actions-Lauf abgeschlossen und seine Logs geprüft sind.

## Nächste Schritte
1. Lauf `38484876322` und zugehörige Logs prüfen.
2. Falls der Test fehlschlägt: exakte Fehlermeldung sichern und nur den betreffenden Test minimal korrigieren; Degenerationstests unverändert lassen, solange sie nicht selbst fehlerhaft sind.
3. Zulässige mathematische Domäne für `δs` aus dem zugrunde liegenden BBMST-Siebargument herleiten und explizit im Axiom oder in den Voraussetzungen absichern.
4. Axiom-Abhängigkeiten und mögliche andere degenerierte Werte von `ca1`, `ca3`, Blockgrößen und Delta-Listen untersuchen.
5. Erst nach reproduzierbaren, erfolgreichen Tests den Befund als bestätigt kennzeichnen.

## Arbeitsstandard
Keine Erfolgsmeldung ohne abgeschlossene CI-Läufe und geprüfte Logs. Keine Schlussfolgerung über die mathematische Vermutung allein aus einem Defekt in der Formalisierung ableiten. Keine unbefugten Zugriffe.
