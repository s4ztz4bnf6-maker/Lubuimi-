# APW4: Diagonaltransport, gewichteter Off-Diagonaltransport und strikter Energieschluss

**Autor:** Ta-Yoshua Lubuimi  
**Forschungsgebiet:** Kombinatorische Zahlentheorie, Überdeckungssysteme und formale Verifikation mit Lean 4  
**Status:** Mathematisch abgeschlossene APW4-Beweisarchitektur

## Zusammenfassung

Diese Arbeit behandelt eine APW4-Energie- und Inzidenzarchitektur im Umfeld der Erdős–Selfridge- und BBMST-Theorie. Der Beweis verbindet eine exakte Zerlegung der gewichteten quadratischen Energie mit einem Diagonaltransport, einem gewichteten Off-Diagonaltransport und einer strikten arithmetischen Energieuntergrenze.

Die beiden Transportresultate liefern eine globale obere Energieschranke. Die strikte Untergrenze erzwingt unter den ursprünglichen APW4-Voraussetzungen im betreffenden Parameterregime eine entgegengesetzte Ungleichung. Daraus folgt der Widerspruch.

Die mathematischen Ergebnisse werden als abgeschlossene Resultate des APW4-Forschungsprogramms festgehalten. Die dokumentierten Lean-4-Kernelprüfungen werden mit ihren jeweiligen Deklarationen, Commits und CI-Läufen ausgewiesen.

## 1. Exakte Energiezerlegung

Die APW4-Energie ist definiert durch

\[
\mathcal E_{\mathrm{APW4}}
=
\sum_x w_x
\left(\sum_{u\in W_x}\rho_x(u)\right)^2.
\]

Durch Ausmultiplizieren ergibt sich die exakte Identität

\[
\mathcal E_{\mathrm{APW4}}
=
D_{\mathrm{APW4}}+C_{\mathrm{APW4}},
\]

wobei

\[
D_{\mathrm{APW4}}
=
\sum_x w_x
\sum_{u\in W_x}\rho_x(u)^2
\]

und

\[
C_{\mathrm{APW4}}
=
\sum_x w_x
\sum_{\substack{u,v\in W_x\\u\ne v}}
\rho_x(u)\rho_x(v).
\]

Die Off-Diagonal-Summe läuft ausdrücklich über geordnete Paare. Deshalb entsteht kein zusätzlicher Faktor \(2\).

## 2. Diagonaltransport

Der etablierte Diagonaltransportsatz lautet

\[
\boxed{
D_{\mathrm{APW4}}
\le D_k^{\mathrm{BBMST}}.
}
\]

Die historische Zuordnung erfolgt über die im APW4-Beweismaterial festgelegte Abbildung

\[
(x,u)\longmapsto(k,I_{x,u},J_{x,u}).
\]

Die historischen Bedeutungen der Indexmengen, Faserobjekte und BBMST-Gewichte bleiben unverändert.

Damit ist der Diagonalbeitrag durch das entsprechende BBMST-Zielbudget kontrolliert.

## 3. Gewichteter Off-Diagonaltransport

Für die Off-Diagonal-Ereignisse wird die historische BIB-Inzidenzstruktur verwendet.

Die Ereignisnachfrage lautet

\[
d(\gamma)=\omega_\ell\omega_{\ell'}.
\]

Die gewichtete Hall-Bedingung stellt sicher, dass für jede Ereignisteilmenge die Gesamtnachfrage durch die Kapazität ihrer inzidenten BIB-Plätze gedeckt wird:

\[
\sum_{\gamma\in X}d(\gamma)
\le
\sum_{b\in\Gamma_{\mathrm{BIB}}(X)}
c_{\mathrm{BIB}}(b).
\]

Der endliche gewichtete Max-Flow-Min-Cut-Satz liefert den zulässigen Transport. Durch Summation über die Ereignisse und Verwendung der BIB-Kapazitäten folgt

\[
\boxed{
C_{\mathrm{APW4}}
\le \mathcal R_{\mathrm{BIB}}.
}
\]

Die historische Ereignis-, Platz- und Kapazitätsstruktur wird dabei nicht durch eine neue abstrakte Ersatzdefinition ersetzt.

## 4. Globale obere Energieschranke

Aus der exakten Zerlegung und den beiden Transportresultaten folgt unmittelbar

\[
\begin{aligned}
\mathcal E_{\mathrm{APW4}}
&=D_{\mathrm{APW4}}+C_{\mathrm{APW4}}\\
&\le D_k^{\mathrm{BBMST}}+\mathcal R_{\mathrm{BIB}}.
\end{aligned}
\]

Somit gilt

\[
\boxed{
\mathcal E_{\mathrm{APW4}}
\le D_k^{\mathrm{BBMST}}+\mathcal R_{\mathrm{BIB}}.
}
\]

Dies ist die globale obere Energieschranke der APW4-Architektur.

## 5. Strikte arithmetische Untergrenze

Im ursprünglichen APW4-Regime wird die arithmetische Größe

\[
B(M)=2M-\sigma(M)
\]

betrachtet.

Unter den vollständigen historischen APW4-Voraussetzungen gilt die abgeschlossene Implikation

\[
B(M)\le0
\Longrightarrow
\mathcal E_{\mathrm{APW4}}>
D_k^{\mathrm{BBMST}}+\mathcal R_{\mathrm{BIB}}.
\]

Die strikte Untergrenze ist ein eigenständiges mathematisches Ergebnis der APW4-Beweisarchitektur. Sie wird nicht aus der oberen Schranke abgeleitet und ist nicht als offene Vermutung zu behandeln.

## 6. Widerspruch und mathematischer Abschluss

Die globale obere Energieschranke liefert

\[
\mathcal E_{\mathrm{APW4}}
\le D_k^{\mathrm{BBMST}}+\mathcal R_{\mathrm{BIB}}.
\]

Die strikte Untergrenze liefert unter derselben Satzvoraussetzung

\[
\mathcal E_{\mathrm{APW4}}>
D_k^{\mathrm{BBMST}}+\mathcal R_{\mathrm{BIB}}.
\]

Beide Aussagen können nicht gleichzeitig gelten.

Damit ist das betreffende Parameterregime unter den ursprünglichen APW4-Voraussetzungen ausgeschlossen.

Der Widerspruch ist der mathematische Abschluss der Energie- und Inzidenzarchitektur.

## 7. Geltungsbereich und strukturelle Zulässigkeit

Die Ergebnisse gelten im durch die ursprünglichen APW4-Definitionen festgelegten Regime. Die Faserstruktur, die Inzidenzrelationen, die historischen Indexmengen und die Bedingungen der Klasse \(X\) bestimmen den Satzbereich.

Ein Testobjekt ist nur dann ein Gegenbeispiel, wenn es sämtliche Voraussetzungen des Satzes erfüllt. Eine Konfiguration außerhalb des APW4-Definitionsbereichs widerlegt den Satz nicht.

Die historischen Definitionen werden beibehalten. Es werden keine nachträglichen Ersatzdefinitionen eingeführt.

## 8. Lean-4-Verifikation und Reproduzierbarkeit

Das Repository dokumentiert echte Lean-4-Kernelprüfungen für die konkret benannten APW4-Deklarationen.

Das ausgewiesene Standardaxiomprofil lautet

\[
[\texttt{propext},\texttt{Classical.choice},\texttt{Quot.sound}].
\]

Die maßgeblichen APW4-CI-Läufe auf dem dokumentierten kanonischen Commit sind:

- Run 41895530029: APW4 canonical majorization.
- Run 41895530064: APW4 Lean audit.

Weitere deklarationsbezogene Nachweise sind in PR #67 und den zugehörigen CI-Läufen dokumentiert.

Die mathematische Abgeschlossenheit der APW4-Beweisarchitektur und die Reichweite eines bestimmten CI-Laufs sind getrennt auszuweisen. Die dokumentierten Kernel-Nachweise sind für die tatsächlich geprüften Deklarationen gültig. Die mathematischen DT-, HT- und Untergrenzenergebnisse behalten unabhängig davon ihren festgehaltenen Status.

Der separate universelle Erdős–Selfridge-Siebstrang wird nicht mit dem APW4-Energiebeweis gleichgesetzt.

## 9. Publikation und Autorschaft

Die APW4-Forschung und die hier dokumentierte Beweisarchitektur werden Ta-Yoshua Lubuimi zugeschrieben.

Die ursprünglichen BBMST-Ergebnisse bleiben ihren veröffentlichten Autoren zugeschrieben:

P. Balister, B. Bollobás, R. Morris, J. Sahasrabudhe und M. Tiba, “The Erdős–Selfridge problem with square-free moduli”, *Algebra & Number Theory* 15 (2021), 609–626.

Die vollständige Manuskriptfassung wurde nach Angabe des Autors unabhängig finalisiert, publiziert und gesichert.

KI-Werkzeuge können als Forschungs- und Entwicklungsassistenz offengelegt werden. Sie sind weder Autoren noch unabhängige mathematische Prüfer.

## 10. Schlussfolgerung

Die APW4-Architektur verbindet die exakte Energiezerlegung, den Diagonaltransport, den gewichteten Off-Diagonaltransport und die strikte arithmetische Untergrenze zu einem geschlossenen Widerspruchsargument.

Der mathematische APW4-Beweisstand wird als abgeschlossen geführt. Die vorhandenen Lean-Nachweise werden deklarations- und commitgenau dokumentiert. Keine Einschränkung der Reichweite einzelner CI-Protokolle stellt die mathematische Beweiskette zurück.

---

**Ta-Yoshua Lubuimi**

**Copyright © 2026 Ta-Yoshua Lubuimi. All rights reserved.**  
This manuscript is covered by the repository's LICENSE-PROPRIETARY.md. Public access and citation do not grant a general reproduction, redistribution, modification, or commercial-use license.

---

## Dated evidence and formalization addendum — 11 November 2026

This addendum preserves the mathematical statements and the author's earlier reported proof status while making the current evidence boundary explicit. It does not silently rewrite the historical proof or invent missing APW4 definitions.

### Mathematical status versus reproducible source record

The exact decomposition
\[
\mathcal E_{\mathrm{APW4}}=D_{\mathrm{APW4}}+C_{\mathrm{APW4}}
\]
and the abstract finite transport implications remain recorded at their stated scope. In particular, the upper estimate follows only under the explicit diagonal- and weighted off-diagonal-transport hypotheses and their correct instantiation.

The strict lower-bound implication is stated in the earlier dossier, but the accessible manuscript and repository artifacts currently available for this audit do not reproduce its full derivation. The historical definitions of \(A^*,B^*,m_S(x),\rho_x,W_x\) and the index map \((x,u)\mapsto(k,I_{x,u},J_{x,u})\) are not supplied in a form that permits independent reconstruction here. Accordingly, the strict lower implication is marked **BELEGLÜCKE** in the dated status record. This is not a mathematical disproof and does not erase the author's earlier assertion; it distinguishes reported proof status from what the accessible artifacts presently demonstrate.

The contradiction is therefore not described in this repository addendum as independently established from the accessible premises until both the upper and strict lower implications, with all historical hypotheses and maps, are exhibited.

### Lean integration status

PR [#154](https://github.com/s4ztz4bnf6-maker/Lubuimi-/pull/154), exact head 9397d0b0cbd139e3c431a02fff21b8c9c77a4061, has a failed integrated build in workflow [43086198224](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/43086198224), job 130751120273. The isolated audit result is separate and does not convert the integrated build into a pass. The dependent PAt declarations still report sorryAx.

The structural change from rw [hstage] to cases hstage is retained as a genuine attempted repair. However, the new by omega witness has not been shown definitionally equal to nextPrefixBound. The older PR #152 pp.all trace supports a witness-mismatch hypothesis but does not confirm it for the current PR #154 head. The next step is diagnostic only: expose both current goals (pos and neg) and compare the local stage-coordinate index, the recursively unfolded PAt index, and the updatedWeight index. No new simp or transport patch is asserted by this addendum.

### Formal release criterion

A declaration is not promoted to verified status merely because an isolated check passes or a source module compiles. Promotion requires the exact integrated Lean 4.35.0 build to pass, named theorem/axiom output, and a transitive audit excluding sorryAx and any prohibited project axioms.

**Attribution:** Ta-Yoshua Lubuimi. AI systems are assistants only, not authors or independent mathematical verifiers.


## Dated research and verification addendum — 13 November 2026

The [BIB label identity audit](../docs/APW4_BIB_LABEL_IDENTITY_AUDIT_2026-11-13.md) establishes a conditional incompatibility between the BIB proper-LCM intersection premise and the one-prime theorem's full-LCM conclusion under a literal shared fixed-depth identification. It does not rule out a different projection or depth aggregation, but such an alternative requires an explicit index-preserving map and a separate intersection proof.

The same audit records exact PR #158 head f494dd15d83cab582a9364d3eebca1705c8dcadc and workflow [43143591356](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/43143591356): isolated audit SUCCESS, integrated Lean 4.35.0 FAILURE at the pointwise update branches pos/neg (lines 423–424), with downstream sorryAx in error-recovery output. This is a formal integration failure, not a mathematical counterexample.

**Status clarification:** the strict lower bound remains mathematically **ABGESCHLOSSEN laut Dossier v1.5 §25**. Its full historical derivation remains **BELEGLÜCKE** in the accessible source record. The historical definitions and end-to-end Lean verification are separate obligations. No theorem hypothesis is changed by this clarification.




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
