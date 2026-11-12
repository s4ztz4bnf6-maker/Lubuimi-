# APW4 / BBMST — CI- und Forschungscheckpoint

**Datum:** 12. November 2026  
**Autor und Forschungsleitung:** Ta-Yoshua Lubuimi  
**Repository:** https://github.com/s4ztz4bnf6-maker/Lubuimi-  
**Dokumentationszweig:** `docs/apw4-status-review-and-ci-2026-11-11`  
**Zweck:** Append-only Sicherung des exakten Status von PR #156 und Workflow 43118336799. Keine Änderung mathematischer Sätze oder Lean-Quelldateien.

## 1. Exakter Patchstand

- PR [#156](https://github.com/s4ztz4bnf6-maker/Lubuimi-/pull/156), Draft, offen, nicht gemergt.
- Branch: `diagnostic/apw4-pp-all-pos-neg-2026-11-11`.
- Head: `1add382fec3375cb2a67822ae872c2bc5d3bb8a3`.
- Geänderte Datei: `BBMSTPrefixMeasureRecursion.lean`.
- Der Patch ergänzt das isolierte Lemma `prefixIndex_last_eq_stageCoordinate` mit `Fin.ext; rfl` und setzt `pp.all` lokal für die Diagnose von `prefixFibre_updatedWeight_eq_PAt`.
- Keine Änderung an `pos`, `neg`, `_proof_1`, Membership-Transport oder bestehenden Theorem-Aussagen.

## 2. Exakter Workflow 43118336799

Der Workflow ist abgeschlossen.

| Job | Job-ID | Ergebnis |
|---|---:|---|
| `audit` | 130852038555 | **SUCCESS** |
| `integrated-paranoid` | 130852038915 | **FAILURE** |

### 2.1 Isolierter Audit

Der Audit-Job hat alle 22 geordneten Schritte erfolgreich abgeschlossen. Insbesondere:

- audited upstream source;
- degenerate-witness tests;
- zero-safe sieve parameter core;
- zero-safe BBMST fibre measure core;
- finite weighted fibre update;
- uniform-coordinate fibre instantiation;
- finite-stage first/second moment bounds;
- finite-coordinate geometry;
- uniform-stage source moment instantiation;
- source-indexed BBMST prefix measure recursion;
- prefix cylinder event-mass identities;
- concrete prefix-to-stage moment bridge;
- hyperplane-induced finite fibre incidence bridge;
- exact old-shadow intersection geometry;
- prefix-to-hyperplane incidence bridge;
- finite weighted union/noncoverage bound;
- BBMST (c_k(z)) moment recurrence.

**Lemma-Bewertung:** Die Datei `BBMSTPrefixMeasureRecursion.lean`, in der `prefixIndex_last_eq_stageCoordinate` deklariert ist, wurde im Audit-Schritt „Compile source-indexed BBMST prefix measure recursion“ erfolgreich kompiliert. Damit ist das Lemma als Teil dieser Datei vom Lean-Compiler akzeptiert. Der Audit-Log weist das Lemma jedoch nicht mit einem eigenen theorembezogenen `#print axioms`-Eintrag aus. Es gibt keinen im Log dem Lemma selbst zugeordneten Fehler. Die im selben Modul sichtbaren Linter-Warnungen bei anderen Zeilen sind kein Lemmafehler.

Daher getrennt festhalten:
- **Datei-/Modulkompilierung einschließlich des Lemmas: PASS.**
- **Eigenständiger theorembezogener Axiom-Ausdruck für genau dieses Lemma: nicht separat ausgegeben.**
- **Vollständige Prefix-Rekursion: nicht durch diesen isolierten Audit-PASS bewiesen.**

### 2.2 Integrierte Prüfung

Der integrierte Lean-4.35.0-Job ist fehlgeschlagen. Die beiden offenen Ziele liegen bei:

- `BBMSTPrefixMeasureRecursion.lean:417` — `case pos`;
- `BBMSTPrefixMeasureRecursion.lean:418` — `case neg`.

Die Fehler-Recovery-Axiom-Ausgabe enthält weiterhin `sorryAx` für `prefixFibre_updatedWeight_eq_PAt` und abhängige Deklarationen. Dies ist kein akzeptierter Beweis.

Der integrierte Fehler ist **kein Gegenbeleg gegen das isolierte Koordinatenlemma**: Der Patch hat die beiden Branch-Ziele absichtlich nicht verändert. Umgekehrt ersetzt der Audit-PASS nicht den fehlgeschlagenen integrierten Beweis.

## 3. Mathematische und technische Einordnung

Das isolierte Koordinatenlemma vergleicht zwei `Fin n`-Koordinaten mit gleichem Wert (a+j). Die unterschiedlichen Beweise derselben Schranke sind nicht selbst ein mathematischer Widerspruch. Der erfolgreiche Modulcompile bestätigt die konkrete Lean-Deklaration.

Die abhängige Membership-Übertragung bleibt ein separater, nicht ausgeführter nächster Schritt. `_proof_1`/Proof-Irrelevanz ist weiterhin getrennt vom Koordinatentransport zu behandeln. Es wurde kein Membership-Transport-Patch vorgenommen.

## 4. Status und offene Pflichten

- PR #156 bleibt **OPEN / DRAFT / UNMERGED**.
- `audit`: **PASS**.
- `integrated-paranoid`: **FAIL**, `pos`/`neg` offen, `sorryAx` in Fehler-Recovery-Ausgabe.
- Historische APW4-Definitionen, Event-/BIB-Abbildung, Originalgewichts- und Kapazitätstransport bleiben unabhängig offen.
- Der strikte historische Lower-Bound-Nachweis bleibt **BELEGLÜCKE**, soweit er nicht aus den zugänglichen Originalartefakten reproduziert werden kann. A1–A3 bleiben **OFFEN – NICHT AUFFINDBAR – NICHT VERIFIZIERT**.

## 5. Integritätsgrenze

Dieser Checkpoint ändert keine Lean-Quelldatei, keinen mathematischen Satz, keine historische Definition, keine Lizenz und keine separat veröffentlichte Autor-PDF. Er dokumentiert nur den exakten Stand der beiden CI-Jobs. Kein Merge und keine Statuspromotion des integrierten Hauptbeweises.

**Attribution:** Ta-Yoshua Lubuimi. KI-Systeme sind Assistenzwerkzeuge, keine Autoren und keine unabhängigen mathematischen Verifizierer.


## 12 November 2026 — PR #157: hhk-Elaboration bestanden, integrierte Update-Zweige weiterhin offen

Exakter Source-/PR-Stand:
- PR [#157](https://github.com/s4ztz4bnf6-maker/Lubuimi-/pull/157), **OPEN / DRAFT / UNMERGED**.
- Branch `test/apw4-hhk-elaboration-2026-11-12`.
- Head `3e0503ea51c492f7a5f738584136bf198a6a945c`.
- Datei `BBMSTPrefixMeasureRecursion.lean`; Quelltext am exakten Commit: [GitHub-Blob](https://github.com/s4ztz4bnf6-maker/Lubuimi-/blob/3e0503ea51c492f7a5f738584136bf198a6a945c/BBMSTPrefixMeasureRecursion.lean).
- Blob-SHA des abgerufenen Quelltexts: `2501d6f24f5c222c71832612e45492820d9156ed`.

Exakter Workflow [43139603300](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/43139603300):
| Job | Job-ID | Ergebnis |
|---|---:|---|
| `audit` | 130923109320 | **SUCCESS** |
| `integrated-paranoid` | 130923109573 | **FAILURE** |

Der isolierte Audit-Log gibt für `BBMSTPrefixMeasure.prefixFibre_updatedWeight_eq_PAt` das Profil `[propext, Classical.choice, Quot.sound]` und für `prefixIndex_last_eq_stageCoordinate` `[propext, Quot.sound]` aus. Für diese isolierten Deklarationsausgaben erscheint kein `sorryAx`. Das ist ein eigenständiger Audit-Befund und kein integrierter Lean-4.35-Nachweis.

Der integrierte Lean-4.35.0-Lauf lässt die Ziele in `BBMSTPrefixMeasureRecursion.lean:423` (`case pos`) und `:424` (`case neg`) offen. Seine Fehler-Recovery-Axiom-Ausgabe enthält `sorryAx` für das Zieltheorem und abhängige Rekursionsdeklarationen, darunter `PAt_nonneg` und `PAt_sum_eq_one`. **Integrierte Verifikation: OFFEN – NICHT VERIFIZIERT.**

### Exakter Quelltextbefund

Der Quelltext enthält keine expliziten `case pos`-/`case neg`-Deklarationen. Die Fälle entstehen aus diesem `by_cases`:

```lean
  by_cases hcov :
      y (Fin.last (a + j)) ∈
        prefixCoveredValues C (A := A) hk
          (restrictPrefix C hk y)
  · simp only [if_pos hcov, Finset.mem_univ, ite_true]
  · simp only [if_neg hcov, Finset.mem_univ, ite_true]
```

Die beiden offenen Ziele sind somit die positiven und negativen Zweige der ursprünglichen Membership-Fallunterscheidung.

Die vollständige Theoremdeklaration wurde am obigen exakten Commit abgerufen. Die Log-Diagnose grenzt zwei Termunterschiede ein:
1. lokale Koordinatendarstellung `prefixIndex hj (Fin.last (a + j))` gegenüber rekursiver Darstellung `stageCoordinate (nextPrefixBound a j hj)`;
2. abhängige Schrankenzeugen `hk` gegenüber `nextPrefixBound a j hj` in den Anwendungen von `prefixCoveredValues` und `restrictPrefix`.

Die vorhandenen Lemmata `prefixIndex_last_eq_stageCoordinate` und `stageCoordinate_eq_of_bound` liefern Koordinatengleichheiten. Daraus folgt noch nicht automatisch die Gleichheit der gesamten abhängigen Ausdrücke. Koordinatentransport und Proof-/Typtransport sind getrennt zu prüfen.

### Bereits geschlossene lokale Schritte

- `hhk : hk = hj := Subsingleton.elim _ _`, gefolgt von `cases hhk` und der Neudefinition `have hk : k + 1 ≤ n := hj`, schließt den lokalen Schrankenzeugen-/Elaborationsengpass.
- `extendPrefix_restrictPrefix` wird in diesem abhängigen Kontext erfolgreich elaboriert.
- Der punktuelle Lean-4.28.0-Nachweis wurde mit dem Profil `[propext, Classical.choice, Quot.sound]` und ohne `sorryAx` gemeldet.
- Dieser 4.28-Nachweis ist nicht der integrierte Lean-4.35-Nachweis und ersetzt ihn nicht.

### Nächster diagnostischer Schritt, nicht ausgeführt

Die gewählte nächste Richtung ist ein quelltextgetreuer Minimalrepro für Lean 4.35.0, nicht zuerst eine Versions-Diff. Der Repro soll die originalen Definitionen/abhängigen Typen, die ursprüngliche `simp only`-Liste und beide Update-Zweige bewahren und Koordinaten- sowie Schrankenzeugentransport separat kontrollieren. Der wiedergefundene Quelltext ist in `publication/APW4_MINIMAL_REPRO_SPEC_2026-11-12.md` referenziert und die problematischen Zeilen sind dort wörtlich gesichert.

**Nicht ausgeführt:** kein Minimalrepro-Modul erstellt, keine Lean-Ausführung durch diesen Dokumentationsschritt, keine Quellcodeänderung, kein CI-Neustart, kein Merge. PR #157 bleibt Draft. Der separate Syracuse-Projektstatus wird nicht verändert.

**Integritätsregel:** mathematische APW4-Ergebnisse, historische Rekonstruktion, punktuelle Lean-4.28-Verifikation und integrierte Lean-4.35-Verifikation bleiben getrennte Evidenzebenen.
