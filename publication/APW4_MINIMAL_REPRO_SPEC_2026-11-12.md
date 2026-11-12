# APW4 / BBMST — Minimalrepro-Spezifikation für die Lean-4.35-Update-Zweige

**Datum:** 12. November 2026  
**Autor und Forschungsleitung:** Ta-Yoshua Lubuimi  
**Typ:** Dokumentations-/Diagnosenotiz; kein Lean-Patch und kein ausgeführter Repro.

## 1. Gesicherte Quelle

- Repository: `s4ztz4bnf6-maker/Lubuimi-`
- PR: [#157](https://github.com/s4ztz4bnf6-maker/Lubuimi-/pull/157), Draft/offen/nicht gemergt.
- Branch: `test/apw4-hhk-elaboration-2026-11-12`
- Exakter Commit: `3e0503ea51c492f7a5f738584136bf198a6a945c`
- Datei: [`BBMSTPrefixMeasureRecursion.lean`](https://github.com/s4ztz4bnf6-maker/Lubuimi-/blob/3e0503ea51c492f7a5f738584136bf198a6a945c/BBMSTPrefixMeasureRecursion.lean)
- Abgerufener Blob-SHA: `2501d6f24f5c222c71832612e45492820d9156ed)
- Imports:
  ```lean
  import Mathlib
  import BBMSTGeometryStageCore
  import BBMSTFiberMeasureCore
  import BBMSTUniformFibreInstantiation
  ```
- Namespace/Context: `BBMSTPrefixMeasure`, `open BBMSTGeometry`, `open BBMSTFiberMeasureCore`, `variable {n : ℕ} (C : CoordinateSystem n)`.

## 2. Exakter Originalabschnitt

Die Originaldeklaration `prefixFibre_updatedWeight_eq_PAt` enthält nach `hroundtrip` diese unveränderte Vereinfachung:

```lean
  simp only [F, prefixFibreData, prefixUniformFibre,
    BBMSTUniformFibreInstantiation.toFibreData,
    BBMSTUniformFibreInstantiation.uniformWeight,
    BBMSTUniformFibreInstantiation.coveredProportion,
    BBMSTFiniteFibreUpdate.updatedWeight, PAt,
    Finset.card_univ, k, xprev]
  by_cases hcov :
      y (Fin.last (a + j)) ∈
        prefixCoveredValues C (A := A) hk
          (restrictPrefix C hk y)
  · simp only [if_pos hcov, Finset.mem_univ, ite_true]
  · simp only [if_neg hcov, Finset.mem_univ, ite_true]
```

Im Quelltext existieren keine eigenständigen `case pos`-/`case neg`-Blöcke. Die Lean-Fallnamen entstehen aus `by_cases hcov`. Im integrierten Log werden die nicht geschlossenen Zweige als `case pos` und `case neg` ausgegeben.

## 3. Tatsächlich dokumentierte Fehlerstelle

Workflow [43139603300](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/43139603300), PR-Head wie oben:
- `audit` Job 130923109320: **SUCCESS**.
- `integrated-paranoid` Job 130923109573: **FAILURE**.
- offene Ziele: Zeile 423 (`pos`) und Zeile 424 (`neg`).
- Fehler-Recovery-Axiom-Ausgabe enthält `sorryAx` für `prefixFibre_updatedWeight_eq_PAt` und abhängige Deklarationen.

Der isolierte Audit gibt für das Zieltheorem `[propext, Classical.choice, Quot.sound]` und für `prefixIndex_last_eq_stageCoordinate` `[propext, Quot.sound]` aus. Das ist nicht mit dem integrierten Lean-4.35-Fehler zu vermischen.

## 4. Zwei getrennte Transportfragen

### Koordinaten
- lokale Darstellung im vollständigen Log: `prefixIndex hj (Fin.last (a + j))`;
- rekursive Darstellung: `stageCoordinate (nextPrefixBound a j hj)`;
- vorhandene Hilfslemmata: `prefixIndex_last_eq_stageCoordinate`, `stageCoordinate_eq_of_bound`.

### Abhängige Schrankenzeugen
- lokaler Aufruf verwendet `hk`;
- rekursive `PAt)-Auswertung erzeugt `nextPrefixBound a j hj);
- betroffene abhängige Anwendungen: `prefixCoveredValues` und `restrictPrefix`.

Die Gleichheit der Koordinaten beweist nicht automatisch die Gleichheit der abhängigen Prefix- und Finset-Ausdrücke. Die Proof-Witness-Gleichheit (Proof Irrelevance) und der Transport in abhängigen Typen sind gesondert zu prüfen.

## 5. Minimalrepro-Plan (noch nicht ausgeführt)

1. Exakte ursprüngliche Definitionen und Typen für `stageCoordinate`, `nextPrefixBound`, `restrictPrefix`, `prefixCoveredValues`, `PAt` sowie den Fibre-Update-Ausdruck übernehmen.
2. Originale `simp only`-Liste und `by_cases hcov`-Zweige unverändert lassen.
3. `pos` und `neg` getrennt protokollieren.
4. Kontrollfall A: Koordinatentransport explizit vor der Vereinfachung.
5. Kontrollfall B: Schrankenzeugen-/Proof-Irrelevance-Transport explizit vor der Vereinfachung.
6. Kontrollfall C: beide Transporte zusammen.
7. Wenn der isolierte Repro scheitert, ist die branch-strukturelle Abweichung reproduziert. Wenn er besteht, ist der ausgelassene Kontext als Ursache weiter einzugrenzen. Eine Versions-Diff ist erst danach sinnvoll.

**Wichtig:** Kein Testmodul wurde durch diese Notiz erstellt oder ausgeführt. Kein Patch ist autorisiert oder enthalten. Der Minimalrepro ist eine nächste Diagnoseaufgabe, keine Reparatur und kein Beweis des APW4-Hauptsatzes.

## 6. Integritäts- und Abnahmebedingungen

- Lean 4.35.0 und die exakt vorgesehene Mathlib-Version müssen verwendet werden.
- Exakter Commit, Build-Job, Log und vollständige Zielausgabe dokumentieren.
- Ein erfolgreicher Repro ist nicht die integrierte Paketverifikation.
- Für die spätere Integration müssen Zieltheorem und abhängige Deklarationen transitiv auditiert werden; kein `sorryAx`.
- Die Lean-4.28.0-Punktverifikation bleibt als eigener historischer Befund erhalten.
- Keine Änderung mathematischer Sätze, Lean-Signaturen, historischer Definitionen oder Manuskript-PDFs.

**Attribution:** Ta-Yoshua Lubuimi. KI-Systeme sind Assistenzwerkzeuge, keine Autoren oder unabhängigen mathematischen Verifizierer.
