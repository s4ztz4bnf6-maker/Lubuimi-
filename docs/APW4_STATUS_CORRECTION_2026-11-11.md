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




## 13 November 2026 — correction: comparison depth and exact BIB intersection saturation

This addendum corrects the scope of the preceding same-depth discussion. In the 31 October one-prime proof, the full-LCM comparison is made at the pair-dependent depth
\[
j=\min(k_x,k_y),
\]
not at every fixed depth j. Therefore the theorem does **not** imply that \(S_{x,1}\cap S_{y,1}\) has full LCM for arbitrary pairs whose two terminal depths exceed 1. The earlier wording that treated the full-LCM conclusion as a general fixed-depth obstruction was too broad.

The precise cases are:
- If \(k_x,k_y>1\), then \(|S_{x,1}|=|S_{y,1}|=q-1\). The BIB row-size condition is compatible with the candidate \(S_x=S_{x,1}\). The one-prime full-LCM argument compares at a later depth \(j=\min(k_x,k_y)\), so it does not by itself contradict proper LCM at depth one.
- If at least one of \(k_x,k_y\) equals 1, the comparison depth is 1 and the one-prime theorem forces full LCM for the full sets \(S_{x,1},S_{y,1}\). Also, a row with \(k_x=1\) has size q rather than q−1. Such a row cannot be used unchanged as a BIB row of size q−1; a source-defined deletion or different projection would be needed.
- There can be **at most one** base residue x with \(k_x=1\): two such residues would have depth-one sets of size q, whose intersection is larger than \(\mu(B)\), forcing full LCM B and then x=y modulo B, a contradiction.

### Exact arithmetic compatibility condition from BIB H1

There is a stronger necessary condition independent of the terminal-depth issue. Let \(D=\mathcal D(B)\), so \(|D|=\tau(B)\), and suppose BIB H1 uses \(|S_x|=q-1\) and \(|S_x\cap S_y|\leq\mu^*(B)\). For any two subsets of a \(\tau(B)\)-element set,
\[
|S_x\cap S_y|\geq |S_x|+|S_y|-\tau(B)
=2q-2-\tau(B).
\]
The one-prime theorem's numerical hypothesis
\[
\tau(B)+\mu(B)<2q-1
\]
and integrality imply
\[
\mu(B)\leq2q-2-\tau(B).
\]
The PR #57 auxiliary parameter \(\mu^*(B)\) and the one-prime \(\mu(B)\) have the same displayed arithmetic formula when both are defined by the proper-divisor/proper-LCM envelope. Therefore, **if the BIB parameter is this same numerical quantity**, H1 and the one-prime numerical hypothesis force
\[
\boxed{\mu^*(B)=\mu(B)=2q-2-\tau(B)}
\]
and every BIB pair must saturate
\[
\boxed{|S_x\cap S_y|=\mu(B).}
\]
This is a necessary arithmetic compatibility condition, not a proof that the historical BIB rows exist or that their proper-LCM property holds.

### Refined row-extraction alternatives

1. **No depth-one terminal fibres:** if every \(k_x>1\), the natural candidate \(S_x=S_{x,1}\) has the required size q−1. It remains to prove the pairwise proper-LCM property and exact intersection saturation \(|S_x\cap S_y|=\mu(B)\).
2. **One exceptional depth-one terminal fibre:** at most one x₀ can have \(k_{x_0}=1\). Its full set \(S_{x_0,1}\) has size q, so a BIB row of size q−1 would require a canonical deleted label or another explicit projection. For every y≠x₀, the full depth-one intersection has LCM B. A puncture can reconcile this only if it preserves exact BIB saturation and removes all maximal p-adic witnesses for at least one prime coordinate. The deleted label must be source-defined; no such rule has yet been recovered.

**Corrected status:** the general identification \(S_x=S_{x,1}\) is **not ruled out** when all terminal depths exceed 1. The exceptional \(k_x=1\) case requires a separate row extraction. The exact numerical saturation condition above is **BELEGT as a necessary consequence** of the displayed finite-set and parameter inequalities. Historical identification, canonical deletion, proper-LCM verification, and APW4 energy transport remain **OFFEN / NICHT REPRODUZIERT**.




### Square-free specialization of the exact saturation condition

If B is square-free with \(s=\omega(B)\), then \(\tau(B)=2^s\) and \(\mu^*(B)=2^{s-1}\). The necessary equality
\[
\mu^*(B)=2q-2-\tau(B)
\]
therefore becomes
\[
2^{s-1}=2q-2-2^s,
\qquad
\boxed{q=1+3\cdot2^{s-2}}.
\]
For prime q this excludes \(s=1,2\) (which give no integral prime q; \(s=2\) gives q=4), so \(s\geq3\), and q must be congruent to 1 modulo 3. This is a **BELEGT necessary arithmetic restriction** for the square-free BIB specialization, conditional on the BIB parameter being the displayed \(\mu^*(B)\) and on the one-prime numerical hypothesis. It is not evidence that the historical B is square-free.




## 13 November 2026 — second proof-witness alignment candidate

The first explicit prefixIndex_last_eq_stageCoordinate candidate (head a49ce83ca5db434f8a479a545d09c580e6b24d6e) still failed integrated Lean 4.35.0 at the update branches. The goal trace shows two occurrences of prefixCoveredValues: the finite-fibre update uses the local proof witness hj, while the unfolded recursive PAt branch uses nextPrefixBound a j hj.

The next candidate, PR #159 head 533e4f7c317bbb7ec606d6f6878b3aec2c054a30, explicitly identifies stageCoordinate hj with stageCoordinate (nextPrefixBound a j hj) using stageCoordinate_eq_of_bound before simplifying. Exact workflow [43412739208](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/43412739208) has audit job 131842924357 and integrated-paranoid job 131842924762 **IN PROGRESS**. No proof or axiom result is claimed for this head yet.




## 13 November 2026 — correction: BIB H1 uses a lower row-size bound

The PR #57 primary note states H1 as
\[
|S_x|\geq r,\qquad |S_x\cap S_y|\leq\mu\quad(x\ne y),
\]
not as the equality \(|S_x|=r\). The intended specialization sets \(r=q-1\). The preceding exact-saturation derivation remains valid, but its row-size premise must be stated in this inequality form.

Indeed, with \(|D|=\tau(B)\), inclusion-exclusion gives
\[
|S_x\cap S_y|\geq |S_x|+|S_y|-\tau(B)
\geq2q-2-\tau(B).
\]
The one-prime hypothesis gives \(\mu(B)\leq2q-2-\tau(B)\). If the BIB upper parameter \(\mu\) is the same displayed numerical envelope as \(\mu^*(B)\) and the one-prime \(\mu(B)\), H1 forces
\[
\mu=\mu^*(B)=\mu(B)=2q-2-\tau(B).
\]
Moreover, equality must hold throughout the inclusion-exclusion bound. Since each row has size at least q−1, for every pair x≠y we must have
\[
|S_x|=|S_y|=q-1,\qquad |S_x\cap S_y|=\mu(B).
\]
Thus, when \(|U|\geq2\), every row in a valid BIB specialization must in fact have **exactly** q−1 labels, even though H1 states only a lower bound.

Consequences for the depth-one candidate:
- If \(S_x=S_{x,1}\), then the one-prime spine gives \(|S_{x,1}|=q-1\) for \(k_x>1\), and q for \(k_x=1\). H1 plus the numerical hypotheses therefore forces \(k_x>1\) for every x.
- If one exceptional \(k_x=1\) exists, a q−1 puncture or another explicit projection is necessary. The punctured candidate must still prove exact pairwise intersection saturation and proper LCM.
- The one-prime full-LCM comparison is at \(j=\min(k_x,k_y)\); the earlier correction about fixed-depth scope remains in force.

This is **BELEGT as a necessary consequence** of the actual H1 inequality and the displayed parameter hypotheses. It does not verify that the historical BIB rows are the depth-one sets, nor that their proper-LCM property holds.




### Conditional square-free second-moment consequence

Under the square-free saturation relation, \(r=q-1=3\tau(B)/4\) and \(\mu^*(B)=\tau(B)/2\). Substitution into the PR #57 second-moment bound gives
\[
m_0=|U|\leq
\frac{\tau(B)(r-\mu^*(B))}{r^2-\tau(B)\mu^*(B)}
=
\frac{\tau(B)\cdot\tau(B)/4}{\tau(B)^2/16}
=4.
\]
The denominator is positive. Thus the square-free parameter-compatible BIB specialization conditionally forces \(|U|\leq4\). If a separate historical argument established \(|U|\geq\Delta(B)>4\), that would give a contradiction; however, the PR #57 note itself says the recovered \(|U|\geq\Delta(B)\) claim lacks a complete derivation, so that lower bound remains **NICHT REPRODUZIERT** and is not used here. The conclusion \(|U|\leq4\) is only the algebraic consequence of H1/H2 and the square-free parameter equality.




## 13 November 2026 — proof-witness alignment result and next normalization candidate

PR #159 head 533e4f7c317bbb7ec606d6f6878b3aec2c054a30 produced workflow [43412739208](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/43412739208):
- integrated-paranoid job 131842924762: **FAILURE**, still leaving the two update-branch goals open at lines 428–429 and downstream sorryAx in error recovery;
- audit job 131842924357: **CANCELLED** after it compiled the source-indexed prefix recursion and printed standard profiles for prefixFibre_updatedWeight_eq_PAt, PAt_nonneg, and PAt_sum_eq_one: [propext, Classical.choice, Quot.sound]. The audit was not completed end-to-end.

The next candidate, PR #159 head bcc51456cb7e91f622957ff0c1297880edc3cff5, adds stageCoordinate to the controlled simp set after aligning the two proof witnesses. Exact workflow [43413218772](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/43413218772) is **QUEUED**. No integrated Lean 4.35.0 pass is claimed.
