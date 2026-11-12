# APW4 / BBMST — Prefixrekursion und historische Abbildung: Statusnachtrag

**Stand:** 11. November 2026  
**Autor und Forschungsleitung:** Ta-Yoshua Lubuimi  
**Repository:** https://github.com/s4ztz4bnf6-maker/Lubuimi-  
**Zweck:** append-only Dokumentation der nächsten isolierten Rekursionsnormalisierung und der weiterhin offenen historischen Rekonstruktion.

## 1. PR #154 — exakter integrierter Status

PR [#154 — Share canonical dependent witnesses in BBMST prefix recursion](https://github.com/s4ztz4bnf6-maker/Lubuimi-/pull/154) steht auf Head

`9397d0b0cbd139e3c431a02fff21b8c9c77a4061`.

Der exakte Workflow [43086198224](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/43086198224) ist abgeschlossen mit:

- `audit`: **SUCCESS** (Job `130751120783`);
- `integrated-paranoid`: **FAILURE** (Job `130751120273`).

Der integrierte Lean-4.35.0-Log lokalisiert die zwei offenen bedingten Gleichheitsziele in `BBMSTPrefixMeasureRecursion.lean` bei Zeile **405** (`case pos`) und Zeile **406** (`case neg`). Der frühere `stageCoordinate`-gegen-`PAt._proof_1`-Konflikt ist damit nicht mehr der aktuell protokollierte Fehlerort; die bedingten Aktualisierungsziele bleiben aber offen.

Die Axiom-Ausgabe des fehlgeschlagenen integrierten Laufs enthält `sorryAx` in:
- `prefixFibre_updatedWeight_eq_PAt`;
- `PAt_nonneg`;
- `PAt_le_initial_mul_distortionProduct`;
- `PAt_succ_le_prev_div_card_mul_one_sub_delta`;
- `PAt_sum_eq_one`.

Das ist Compiler-Fehler-Recovery-Ausgabe und **kein** akzeptierter Beweis. Der unabhängige Audit-PASS ersetzt den fehlgeschlagenen integrierten Lauf nicht. PR #154 bleibt ein fehlgeschlagener Reparaturkandidat; kein Merge oder Status-Promotion wird daraus abgeleitet.

## 2. Nächste isolierte Reparatur — strukturelle Normalisierung

Kein weiterer pauschaler `simp`-Patch. Die nächste Änderung ist auf die lokale Definition und die beiden konkreten Fälle zu beschränken:

1. Den lokalen Ausdruck `values` explizit und sichtbar isolieren.
2. Das `Covered`-Prädikat kanonisch identifizieren, **bevor** `PAt` entfaltet wird.
3. Die lokale und rekursive Bedingung über dieselbe kanonische Definition ausdrücken; keine unabhängig erzeugten abhängigen Beweiszeugen verwenden.
4. Den positiven und negativen Fall getrennt beweisen und jeweils die tatsächlich vorliegende bedingte Gleichheit als Ziel beibehalten.
5. Erst nach erfolgreichem isoliertem Nachweis die abhängige Rekursion erneut integrieren.

Die Normalisierung darf weder Definitionen, Voraussetzungen noch Schlussfolgerungen des mathematischen Satzes ändern. Ein erfolgreicher isolierter Teilbeweis ist noch keine integrierte Verifikation. Vor einer Promotion sind der exakte integrierte Lean-4.35.0-Lauf, die benannten transitiven `#print axioms` und der explizite Ausschluss von `sorryAx` erforderlich.

## 3. Historische Rekonstruktion bleibt unabhängig offen

Die historischen Objekte `ρ_x` und `W_x` sowie eine quellentreue, indexerhaltende Abbildung

The source-faithful map under investigation is (x,u) ↦ (k,I,J). Its definition and required index-preservation properties remain open.

sind in diesem Statusnachtrag **nicht** als historische Definitionen rekonstruiert. Ohne konkrete Fundstelle in der Balister-/BBMST-Quelle oder in einer belegten APW4-Originaldefinition darf keine dieser Größen aus dem aktuellen Lean-Modell rückprojiziert oder frei ergänzt werden.

Weiterhin offen sind insbesondere:
- die genaue historische Definition und Domäne von `ρ_x` und `W_x`;
- die Bedeutung und zulässigen Werte von `k,I,J` in der Originalquelle;
- die konkrete Abbildung `(x,u) ↦ (k,I,J)` samt Injektivität/Surjektivität bzw. der tatsächlich benötigten Indexerhaltung;
- die Übertragung der ursprünglichen Gewichte/Massen und Kapazitäten;
- die Verbindung zu BIB-Inzidenzen und zur gewichteten Hall-Bedingung.

Bis diese Quellen und Beweise vorliegen, bleibt der historische BBMST-Abgleich **OFFEN – NICHT VERIFIZIERT**.

## 4. Manuskript- und Lizenzgrenze

Dieser Nachtrag ergänzt die Forschungs- und Verifikationsdokumentation. Er ändert nicht die vom Autor separat finalisierte und veröffentlichte PDF-Fassung, nicht den Wortlaut des Hauptsatzes und nicht die mathematische Beweislage der zuvor dokumentierten APW4-Ergebnisse. Frühere mathematische Resultate werden nicht wegen eines späteren Lean-Integrationsfehlers zurückgestuft.

Die vorhandenen Dateien `LICENSE-PROPRIETARY.md` und `LICENSE-COMMERCIAL-USE-AND-REMUNERATION.md` bleiben unverändert. Dieser Nachtrag gewährt keine zusätzliche Lizenz. Lean, Mathlib, BBMST-Quellen und sonstige Drittmaterialien bleiben ihren jeweiligen Lizenzbedingungen unterworfen.

**Integritätsregel:** mathematische Herleitung, historische Rekonstruktion und Lean-/CI-Verifikation bleiben drei getrennte Evidenzebenen.


## 12 November 2026 — PR #157 hhk-Elaboration und Update-Diagnose

PR [#157](https://github.com/s4ztz4bnf6-maker/Lubuimi-/pull/157), exakter Head `3e0503ea51c492f7a5f738584136bf198a6a945c`, Workflow [43139603300](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/43139603300): isolierter Audit-Job 130923109320 **SUCCESS**, integrierter Job 130923109573 **FAILURE**. Die offenen Ziele liegen nun bei Zeile 423 (`pos`) und 424 (`neg`). Die integrierte Fehler-Recovery-Ausgabe enthält weiterhin `sorryAx` in der Zieldeklaration und abhängigen PAt-Deklarationen.

Der lokale Schrankenzeugen-Schritt `hhk : hk = hj := Subsingleton.elim _ _; cases hhk; have hk : k + 1 ≤ n := hj` und die anschließende Elaborierung von `extendPrefix_restrictPrefix` sind geschlossen. Der punktuelle Lean-4.28.0-Nachweis hat das Profil `[propext, Classical.choice, Quot.sound]` ohne `sorryAx`; die integrierte 4.35-Verifikation bleibt davon getrennt.

Der vollständige Theoremquelltext wurde am exakten PR-Head aus `BBMSTPrefixMeasureRecursion.lean` abgerufen. Die Quelltextfälle sind zwei Zweige eines `by_cases hcov`, keine ausdrücklich benannten `case pos`-/`case neg`-Blöcke. Die konkrete Stelle und der Minimalrepro-Plan sind in [APW4_MINIMAL_REPRO_SPEC_2026-11-12.md](APW4_MINIMAL_REPRO_SPEC_2026-11-12.md) gesichert.

Die Log-Diagnose trennt (i) lokale `prefixIndex hj (Fin.last (a+j))`-Koordinate gegen rekursive `stageCoordinate (nextPrefixBound a j hj)` und (ii) abhängige Beweiszeugen `hk` gegen `nextPrefixBound a j hj` in `prefixCoveredValues`/`restrictPrefix`. Die Gleichheitslemmata für Koordinaten beweisen noch nicht die Gleichheit der vollständigen abhängigen Ausdrücke.

Nächster gewählter Schritt: quelltextgetreuer Lean-4.35-Minimalrepro. **Noch nicht erstellt oder ausgeführt.** Keine Quellcodeänderung, kein CI-Neustart, kein Merge. Historische APW4-Rekonstruktion und BIB-/Gewichtstransport bleiben unabhängig offen.
