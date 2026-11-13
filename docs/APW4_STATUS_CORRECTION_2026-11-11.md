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


The dated correction below supersedes any wording in this file that could be read as downgrading the mathematical status recorded in Dossier v1.5 §25. The theorem remains mathematically completed according to §25; BELEGLÜCKE refers to independent reproduction from accessible source artifacts.




## 13 November 2026 — PR #159 proof-script candidate

PR [#159](https://github.com/s4ztz4bnf6-maker/Lubuimi-/pull/159), exact head 336fd7a3f2b274f705c184a9bbfddbf6854c3f8c, changes only the pointwise update branch split in BBMSTPrefixMeasureRecursion.lean and its isolated reproduction. The by_cases proposition is now stated with the original successor bound hj and explicit prefix a+j, matching the indices displayed in the PR #158 integrated failure trace; the previous candidate used the locally reconstructed hk and k expressions.

Exact workflow [43410655372](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/43410655372) is still **IN PROGRESS** at this record:
- audit job 131835937905: IN PROGRESS;
- integrated-paranoid job 131835938270: IN PROGRESS.

No branch closure, theorem success, axiom profile, or sorryAx rejection is claimed until both jobs complete and their logs are inspected. PR #159 remains a draft proof-script candidate. This candidate does not affect the separate historical BIB/APW4 energy obligations.




## 13 November 2026 — PR #159 exact-head correction and retry

The first PR #159 candidate head 336fd7a3f2b274f705c184a9bbfddbf6854c3f8c failed both audit and integrated-paranoid workflow 43410655372. The error at BBMSTPrefixMeasureRecursion.lean:421 was an elaboration mismatch: prefixCoveredValues takes its prefix index implicitly, so passing a+j positionally supplied a Nat where the proof bound was expected.

The correction now passes the index explicitly as (k := a + j). Current PR #159 head: 0ee3144ddbc1927563e03a752dd472c391d5cc61. Exact workflow [43411234880](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/43411234880):
- audit job 131837877076: **IN PROGRESS**;
- integrated-paranoid job 131837876454: **IN PROGRESS**.

The failed first candidate remains a preserved diagnostic. No theorem success, axiom profile, or sorryAx rejection is claimed for the corrected head until both jobs finish and the complete logs are checked.




### F. Refined reconciliation candidate: punctured depth-one rows

The literal identity \(S_x=S_{x,1}\) is incompatible with the proper-LCM premise, but the one-prime spine gives a more precise possible extraction that has not yet been tested historically.

Let \(T_x:=S_{x,1}\). The spine formula gives
\[
|T_x|=\begin{cases}
q,&k_x=1,\\
q-1,&k_x>1.
\end{cases}
\]
Define a candidate BIB row \(S_x\subseteq T_x\) of size \(q-1\) by keeping \(T_x\) unchanged when \(k_x>1\), and deleting one selected label \(d_x\in T_x\) when \(k_x=1\). This is only a candidate extraction rule; the deleted label \(d_x\) is not specified by the historical source.

For distinct \(x,y\), the elementary intersection bound for the full depth-one sets is
\[
|T_x\cap T_y|\geq |T_x|+|T_y|-\tau(B).
\]
The construction deletes at most one label from each row, and deletes one precisely when the corresponding terminal depth is 1. Since \(|T_x|=q-1+\mathbf 1_{k_x=1}\), it follows that
\[
|S_x\cap S_y|\geq 2q-2-\tau(B).
\]
The one-prime hypothesis \(\tau(B)+\mu(B)<2q-1\), with integer parameters, implies
\[
2q-2-\tau(B)\geq\mu(B).
\]
Therefore, if these punctured rows also satisfy the BIB proper-LCM premise \(|S_x\cap S_y|\leq\mu(B)\), then every pair must **saturate exactly**
\[
|S_x\cap S_y|=\mu(B).
\]

This is compatible with the full-LCM theorem for \(T_x,T_y\): the deleted terminal label(s) may be exactly the prime-power witness(es) that make the full intersection have LCM B. It gives a concrete new target: find a canonical source-defined deleted label \(d_x\), then prove that after the deletion every pairwise intersection has cardinality exactly \(\mu(B)\) and proper LCM. No such canonical deletion rule or saturation proof has yet been found.

**Status:** the lower bound \( |S_x\cap S_y|\geq2q-2-\tau(B)\) for this puncturing rule is **BELEGT conditionally** by the spine counts and finite-set cardinality. The identification of these punctured rows with the historical BIB \(S_x\), the choice of \(d_x\), and the proper-LCM saturation are **OFFEN / NICHT REPRODUZIERT**. This refines, but does not close, the historical label-extraction obligation.




## 13 November 2026 — exact PR #159 split result and coordinate-transport follow-up

Corrected PR #159 source head 0ee3144ddbc1927563e03a752dd472c391d5cc61 produced a split exact-head result in workflow [43411234880](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/43411234880):
- audit job 131837877076: **SUCCESS**; it compiled the pointwise update theorem and downstream PAt_nonneg / PAt_sum_eq_one with standard transitive profiles [propext, Classical.choice, Quot.sound], and the completed audit log contains no actual sorryAx for these declarations;
- integrated-paranoid job 131837876454 (Lean 4.35.0): **FAILURE**; it still reports unsolved pos/neg goals at lines 423–424 and downstream sorryAx in error recovery.

The 4.35 goal trace now isolates a dependent-coordinate mismatch: the value y(Fin.last (a+j)) is indexed by prefixIndex, while the covered-value Finset is indexed by stageCoordinate. The source contains the named equality prefixIndex_last_eq_stageCoordinate for exactly this transport. The next candidate, PR #159 head a49ce83ca5db434f8a479a545d09c580e6b24d6e, applies that equality before the update split. Its exact-head CI result has not yet been retrieved; no pass is claimed.

This is a split toolchain verification snapshot, not a mathematical counterexample and not an integrated proof completion. The Lean 4.28 audit PASS is commit-bound and does not substitute for the Lean 4.35.0 integrated-paranoid gate.




## 13 November 2026 — explicit prefixIndex/stageCoordinate transport candidate

The next PR #159 source head is a49ce83ca5db434f8a479a545d09c580e6b24d6e. It adds the named equality prefixIndex_last_eq_stageCoordinate before the pointwise update branch split, to align the last coordinate of the extended prefix with the stageCoordinate used by prefixCoveredValues.

Exact workflow [43411925347](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/43411925347) is **IN PROGRESS**:
- audit job 131840194635: IN PROGRESS;
- integrated-paranoid job 131840194925: IN PROGRESS.

The preceding exact head 0ee3144 has audit PASS with standard profiles for prefixFibre_updatedWeight_eq_PAt, PAt_nonneg, and PAt_sum_eq_one, but integrated Lean 4.35.0 FAIL. No result is claimed for the new coordinate-transport candidate until both jobs complete.
