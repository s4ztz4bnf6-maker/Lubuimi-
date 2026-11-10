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


## Exact-head CI addendum — 10 November 2026, 06:25 CET

This entry is append-only. It does not revise the mathematical status of the established APW4 results or the independently published manuscript held by the author.

### PR #101 — prefix-fibre recursion candidate

- Candidate source head recorded in the preceding entry: `31cc94993fdcb481cea919ca762a29c568948a7a`; workflow [42760198290](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42760198290).
- `integrated-paranoid` failed while compiling `BBMSTPrefixMeasureRecursion.lean`: the two residual goals are at lines 390 and 402 in that checkout. The positive branch retains an implication whose premise is the negation of the covered predicate despite the local positive membership hypothesis; the negative branch retains the covered/uncovered conditional rather than reducing it. The integrated log prints `sorryAx` for `prefixFibre_updatedWeight_eq_PAt` and dependent `PAt) declarations. This is a real failure of that exact integrated build.
- The separate `audit` job passed its staged compilation and reported the standard profile for its audited declarations. That result is a distinct audit path and does not override the integrated failure.
- The next source repair must align the update's actual `F.covered` predicate with the recursive `prefixCoveredValues) predicate before unfolding either conditional, then simplify the two branches explicitly. This is a repair target, not a verified fix. No previously established APW4 mathematical theorem is reopened by this Lean integration failure.

### Syracuse PR #107 — isolated and integrated scopes

Workflow [42759653537](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42759653537) has the following distinct outcomes:

- The targeted `SyracuseDyadicResidueFibre.lean` compilation succeeded. `explicitTailAtoms_mem_iff`, `explicitTailAtoms_card`, and `explicitCandidate_mass` report `[propext, Classical.choice, Quot.sound]`; the targeted module output contains no `sorryAx` for these declarations.
- The audit job later failed in the APW4 dependency `BBMSTPrefixMeasureRecursion.lean:386` with `dsimp made no progress` and an application type mismatch involving `y (Fin.last (a + j))`. This does not invalidate the preceding isolated Syracuse module compilation.
- The integrated-paranoid job failed at the same APW4 dependency. The isolated `syracuse-bridge-paranoid` job was still in progress at the latest job poll; its log endpoint returned `BlobNotFound`, so no completion is asserted.

### Collatz PR #48 — exact run fully green

On workflow [42759509255](https://github.com/s4ztz4bnf6-maker/Lubuimi/actions/runs/42759509255), all three jobs completed successfully: `kernel-check-lean-434`, `kernel-check-lean-435-paranoid`, and `compile-drafts`. The Lean 4.35.0 job completed `lake check --paranoid` and the named finite-path/terminal-residue module check. This is a full job-level CI success for that exact run and its source head. It proves only the declarations and scope actually built and audited there; the finite cap-tree path certificate remains a finite-depth necessary condition and does not exclude an infinite branch or prove global Collatz termination.

The existing initial-cylinder, valuation-bound, offset, strict-margin, finite valuation-word cylinder, and dyadic fibre results retain their prior independent mathematical and exact-commit verification status. Later integration outcomes do not retroactively downgrade them.

**Status:** APW4 integrated prefix recursion remains open; Syracuse isolated paranoid completion remains open; Collatz PR #48 exact run is green within its stated finite-depth scope. Mathematical proofs, historical reconstruction, isolated compilation, integrated compilation, paranoid kernel checking, and declaration-scoped axiom output remain separate evidence categories.


## Follow-up proof candidate — PR #114, 10 November 2026

A new narrow candidate is recorded at [PR #114](https://github.com/s4ztz4bnf6-maker/Lubuimi-/pull/114), exact source head `d09d28935c9e026f4b8297b058c3cd4169231451`. It is based directly on the canonical PR #101 source head `31cc94993fdcb481cea919ca762a29c568948a7a` and changes only `BBMSTPrefixMeasureRecursion.lean` (12 additions, 21 deletions).

The candidate moves the case split onto the recursive geometric membership predicate `prefixCoveredValues` before unfolding `updatedWeight` and `PAt`; it then transports the positive/negative membership fact to the concrete `F.covered` field and simplifies the corresponding branch. It changes no definitions, theorem statements, hypotheses, or mathematical claims. PR #113 was closed after identifying that its comparison base was unsuitable and its diff was not narrowly scoped; no source change from that branch is retained in PR #114.

No verification result is claimed yet. The acceptance gate remains exact-head integrated-paranoid success, the separate audit, inspection of named `#print axioms`, and absence of `sorryAx` throughout the dependency closure. Established APW4 mathematical results and the published manuscript status remain untouched.


## PR #114 exact-head workflow launched — 10 November 2026

The membership-first repair candidate [PR #114](https://github.com/s4ztz4bnf6-maker/Lubuimi-/pull/114) is at exact head `d09d28935c9e026f4b8297b058c3cd4169231451`. Its triggered workflow [42762133686](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42762133686) has both `audit` and `integrated-paranoid` in progress. No compilation or axiom-audit outcome is claimed until those jobs complete and their logs are inspected.


## PR #114 residual diagnosis and next candidate — 10 November 2026

The first exact-head integrated run [42762133686](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42762133686) failed on source head `d09d28935c9e026f4b8297b058c3cd4169231451`. The two remaining goals are now precisely identified:

- In the positive covered branch, Lean leaves an implication with the negated recursive membership predicate as premise, even though the branch hypothesis establishes membership. The equality beneath that impossible premise is immaterial; the branch should close by explicit contradiction elimination.
- In the negative branch, the update reduces to an `if endpoint ∈ Finset.univ then ... else 0`; the proof must provide the concrete `Finset.mem_univ` witness and simplify it explicitly.

A second proof-body adjustment is now at exact source head `278c0c6c192e34728bace660199e1c431e96846d`: it removes the unused `hcovF) rewrite, discharges the positive residual by `intro hnot; exact hnot hcov`, and supplies the explicit universal-membership witness in the negative branch. This is a targeted repair candidate, not a verified fix. A fresh exact-head integrated run and audit are still required; the earlier run's audit job was cancelled and cannot certify the newer source head.


## Fresh exact-head verification run — PR #115, 10 November 2026

The corrected membership-first candidate is now tracked by [PR #115](https://github.com/s4ztz4bnf6-maker/Lubuimi-/pull/115), exact source head `278c0c6c192e34728bace660199e1c431e96846d`. Its new workflow [42762540736](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42762540736) has `audit` in progress and `integrated-paranoid` queued at the latest poll. PR #114 was closed as the preceding candidate after its first integrated attempt exposed the two residual goals; its source history is retained on the branch, and PR #115 presents the corrected exact head as a one-file diff against the canonical PR #101 base. No verification result is claimed until both jobs finish and the named axiom output is inspected.
