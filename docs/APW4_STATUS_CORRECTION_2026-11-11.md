# APW4 / BBMST – datierte Statuskorrektur

**Datum:** 11. November 2026  
**Typ:** Append-only Statuskorrektur; keine mathematische Hochstufung und keine Rückstufung bereits bewiesener Teilresultate.

## 1. Bedingter Widerspruch: logische Beweisverpflichtung

Die korrekte Zielgestalt ist

\[
\bigl(H_{\mathrm{DT/HT}} \land A^* \land B^*
\land (\forall x\;m_S(x)\le 1) \land B(M)\le 0\bigr)
\Longrightarrow \bot.
\]

Dabei muss jede Teilimplikation separat hergeleitet sein:

1. Aus \(H_{\mathrm{DT/HT}}\) muss tatsächlich
   \[
   \mathcal E_{\mathrm{APW4}}\le
   D_k^{\mathrm{BBMST}}+\mathcal R_{\mathrm{BIB}}
   \]
   folgen. Der abstrakte DT/HT-Transport ist unter seinen Voraussetzungen bewiesen; die korrekte historische APW4-Instanziierung ist damit nicht automatisch bewiesen.
2. Aus
   \(A^*\land B^*\land(\forall x\;m_S(x)\le1)\land B(M)\le0\)
   muss tatsächlich die strikte Gegenungleichung folgen.

**Status der zweiten Implikation: BELEGLÜCKE.** Dossier v1.6 §25 behauptet die strikte Untergrenze, enthält in der zugänglichen Passage aber keine reproduzierbare Herleitung. Die fehlenden Definitionen von \(A^*,B^*,m_S,\rho_x,W_x\) sowie der Abbildung \((x,u)\mapsto(k,I_{x,u},J_{x,u})\) werden nicht rekonstruiert oder erfunden.

**Gesamtstatus:** bedingt formulierbar, aber derzeit **NICHT BEDINGT BEWIESEN**, weil die untere Teilimplikation nicht reproduzierbar belegt ist. Die abstrakte obere Schranke darf nur unter explizitem \(H_{\mathrm{DT/HT}}\) geführt werden.

## 2. Lean-Diagnose – PR #154

- PR: https://github.com/s4ztz4bnf6-maker/Lubuimi-/pull/154
- Exakter Head: `9397d0b0cbd139e3c431a02fff21b8c9c77a4061`
- Integrierter Workflow: https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/43086198224
- Fehlgeschlagener integrierter Build-Job: `130751120273`
- Isolierter Audit: PASS; integrierter Lean-4.35.0-Build: FAIL.
- Die abhängigen `PAt`-Deklarationen führen weiterhin `sorryAx`.

PR #154 hat die strukturelle Änderung `rw [hstage]` → `cases hstage` vorgenommen. Im aktuellen Kandidaten wird `hstage` jedoch mit einem separat erzeugten `by omega`-Zeugen aufgebaut. Ob dieser Zeuge definitional mit `nextPrefixBound` identisch ist, ist nicht nachgewiesen.

Die ältere PR-#152-`pp.all`-Diagnose stützte die Hypothese eines abweichenden rekursiven Beweiszeugen (damals wurde rechts `PAt._proof_1` sichtbar). Sie bestätigt diese Herkunft **nicht** für den neuen PR-#154-Head. Der aktuelle integrierte Log enthält keinen vollständigen `pp.all`-Ausdruck für beide aktuellen Ziele.

**Nächster Schritt, ohne Patch:** vollständige aktuelle Zielausdrücke der Fälle `pos` und `neg` sichern und die drei Indizes nebeneinander offenlegen:
1. lokales `stageCoordinate hk`,
2. Index im entfalteten rekursiven `PAt`-Zweig,
3. Index im `updatedWeight`-Ausdruck.

Erst danach prüfen, ob Gleichheit auf den gesamten abhängigen Fasertyp transportiert werden muss. Kein neuer `simp`- oder Transportpatch vor dieser Diagnose.

## 3. Ebenentrennung

- Mathematische Energieidentität und abstrakte DT/HT-Transportresultate bleiben auf ihrem jeweils bewiesenen Geltungsbereich bestehen.
- Historische DT/HT-Instanziierung und strikte untere APW4-Schranke bleiben getrennte Verpflichtungen.
- Lean-Integration und Axiom-Audit bleiben ein separates formales Problem.
- Keine Aussage, APW4 widerlege eine aktuelle Odd-Covering-Rangschranke, solange die Abbildung auf die passende Moduli-/Restklassenklasse nicht nachgewiesen ist.

**Keine** mathematische Definition ergänzt, kein Lean-Quelltext geändert und kein PR gemergt. Nach den Dokumentations-Commits startete GitHub automatisch den PR-getriggerten Workflow „Lean degenerate-witness audit“ auf diesem Dokumentations-Head: Lauf 43112448259, Job 130831735116. Dieser isolierte Audit war bei der letzten Abfrage noch in Bearbeitung und ist kein integrierter Lean-4.35.0-Build. Sein Ergebnis wird nicht vorweggenommen.
