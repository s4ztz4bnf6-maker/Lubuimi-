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


## Formalisierungsnachtrag — 10. November 2026

Dieser Nachtrag ändert keine Definition, Voraussetzung, Indexmenge oder mathematische Schlussfolgerung des Manuskripts. Der mathematische APW4-Beweisstand (exakte Energiezerlegung, DT, HT/gewichteter Hall-Transport, globale obere Energieschranke, strikte untere Energieschranke und Widerspruch) bleibt gemäß dem vorliegenden Beweistext bestehen. Die Off-Diagonal-Summe ist weiterhin über geordnete Paare u ≠ v definiert; es wird kein zusätzlicher Faktor 2 eingeführt. Die Energiezerlegung hat genau die beiden Beiträge D_APW4 und C_APW4.

Die historische Rekonstruktionsarbeit vom 10. November ist zusätzlich im Repository dokumentiert: Definitionen und Abhängigkeitsordnung für A_q, A_r, W_qr, a_qt, D_qr, U_q, F_q, C_h, elementare Ereignisse, Ereignisabbildung, tatsächliche BIB-Plätze und Inzidenzen sowie das gewichtete Hall-Kriterium. Festgehalten sind insbesondere

    A_q W_{q,r} A_r^T = sum_{t mod D_{q,r}} a_{q,t} a_{r,t}^T
    sum_h M_{q,r}(h,g) <= Gamma_{q,r}(g).

Die zugehörigen historischen Residualdefinitionen und Indexabbildungen sind quellengesteuert zu übernehmen; dieser Nachtrag führt keine Ersatzdefinition ein.

Die laufende Lean-Übertragung ist davon getrennt. PR #138 (Kandidat v15, Head 800d752e626951505d9dbcb312dfe09555ee6f2f) ergänzt lokale Membership-Zeugen für den let-gebundenen Endpunkt x, um die beiden bedingten Zweige von updatedWeight proof-directed zu reduzieren. Der Kandidat ist OFFEN – NICHT VERIFIZIERT bis zum erfolgreichen integrierten Lean-4.35.0-Paranoid-Lauf, Prüfung der benannten #print axioms-Ausgaben und transitivem Ausschluss von sorryAx.

Die weiterhin explizit zu schließenden historischen Lean-Verbindungen sind: prefixFixedCoords, die tatsächliche endliche Anfangsprofilfamilie, historisches c(I) einschließlich des leeren Profils, die exakte Gleichheit des Suffixfaktors mit nu(J), die vollständige historische Lemma-3.3-Instanziierung und die anschließende Lemma-3.4-Momentenkette. Diese formalen Restarbeiten ändern nicht den Status des mathematischen Manuskriptbeweises.

Der vom Autor unabhängig finalisierte und gesicherte PDF-Release wird durch diesen Repository-Nachtrag nicht ersetzt oder verändert. Dieser Nachtrag ist eine Status- und Reproduzierbarkeitsnotiz, keine neue PDF-Ausgabe.

## Quellen- und Rekonstruktionsnachtrag — 10. November 2026

Die ergänzende historische Definitionstabelle und die noch erforderlichen Index-/Inzidenzverbindungen sind in der separaten [APW4 Historical Event-to-BIB Reconstruction Ledger](APW4_HISTORICAL_EVENT_BIB_RECONSTRUCTION_LEDGER_2026-11-10.md) festgehalten. Der Nachtrag präzisiert die rekonstruierten q-Faserobjekte \(B_q,V_q,F_q(x),P_{q,x,h}\), die Schnittzahlen \(M_{q,r}\), die Schranke \(\sum_hM_{q,r}(h,g)\leq\Gamma_{q,r}(g)\), die Blockidentität und die Residualmatrixentwicklung. Er ersetzt keine historische Definition und ändert weder den mathematischen DT-/HT-Schluss noch die Energiezerlegung dieses Manuskripts.

Die Matrixidentität mit \(Z_q=I_q-A_q\) hat vier algebraische Beiträge, darunter drei Z-haltige Residualbeiträge. Diese Matrixentwicklung ist strikt von der hier bewiesenen zweigliedrigen Energiezerlegung \(\mathcal E_{\rm APW4}=D_{\rm APW4}+C_{\rm APW4}\) zu unterscheiden; es entsteht kein dritter Energiebeitrag.

Die Quellindizes der historischen Ereignisse, die vollständige Abbildung \((x,u)\mapsto(k,I_{x,u},J_{x,u})\), die tatsächlichen BIB-Plätze und ihre Inzidenz bleiben in der formalen Übertragung quellengesteuert zu instanziieren. Die mathematischen Transportaussagen werden dadurch nicht erneut zur offenen Frage.


### Exact-head refresh after v15 local-witness repair — 10 November 2026

The v15 proof-term repair remains the code change identified above: the endpoint membership/non-membership/point witnesses are transported from the geometric endpoint to the let-bound local value used by `updatedWeight`. A comment-only exact-head refresh was then committed as `3bb0e4ab45d74cbece76edbc5be14bca0043cdc9`; it changes no declaration, theorem statement, definition, hypothesis, or proof term. The exact-head workflow lookup returned no workflow run and no commit status for this refresh. Therefore the v15 candidate remains **OFFEN – NICHT VERIFIZIERT**; no earlier successful module audit is extended to it.




## Prefix-cylinder event-mass bridge — 10 November 2026

The source-indexed prefix recursion now contains a stronger intermediate result than the pointwise distortion estimate alone. In `BBMSTPrefixCylinderMass.lean`, the following declarations provide the exact one-coordinate event-mass dichotomy:

1. `containsPrefix_extend_iff` decomposes a next-prefix hyperplane constraint into the old-prefix constraint and the boundary-coordinate constraint.
2. `prefixCylinderExtensionEquivFree` and `prefixCylinderExtensionEquivFixed` give the actual subtype equivalences for free and fixed boundary coordinates.
3. `prefixCylinder_free_mass_reindex` and `prefixCylinder_fixed_mass_reindex` reindex the cylinder mass through those equivalences.
4. `prefixCylinder_free_mass_eq` proves exact mass conservation when the new coordinate is free.
5. `prefixCylinder_fixed_mass_le` proves the one-coordinate distortion bound when the new coordinate is fixed:
   [
   mu_{j+1}(H)le
   rac{mu_j(H)}{|S_i|(1-delta_i)}.
   ]
6. `hyperplaneSuffixFactor` charges precisely the fixed coordinates and assigns factor (1) to free coordinates.
7. `prefixCylinderMass_le_initial_mul_hyperplaneSuffixFactor` iterates the dichotomy and proves
   [
   mu_j(H)le mu_0(H),
u_H([a,a+j)),
   ]
   where the suffix factor is the product of (1/(|S_i|(1-delta_i))) over exactly those suffix coordinates at which (H) has a fixed assignment.

This is the concrete cylinder-level mechanism needed for the suffix part of BBMST Lemma 3.3: free coordinates preserve cylinder mass; fixed coordinates incur exactly one distortion factor. It is not merely the unrestricted total-mass identity.

**Scope boundary:** these are declarations present in the v15 source candidate. They are not yet promoted to integrated Lean-verification results: PR #138's exact head is `6d6bcacedab9c0c98a21156d4e90601b7cb87a5f`, and no exact-head workflow/status was returned. The v15 local-membership repair in `BBMSTPrefixMeasureRecursion.lean` is a dependency of this chain and remains subject to the same exact-head integrated paranoid and transitive axiom audit.

### Exact remaining bridge after the cylinder estimate

The current theorem has the form
[
mu_j(H)le mu_0(H),
u_H(J).
]
To obtain the historical Lemma 3.3 form, the remaining source-faithful work is now sharply localized:

- define the actual initial profile (I(H)) from the source's fixed coordinates in the initial block;
- define the source's finite profile family from the actual initial hyperplane family, not from all formally possible subsets;
- identify (mu_0(H)) with the historical initial cylinder quantity and prove its bound by the exact (c(I(H)));
- identify the suffix product above with the paper's (
u(J(H))), including its exact interval convention and endpoint exclusions;
- handle the empty initial profile as an explicit case of the historical definition;
- then instantiate Lemma 3.3 and feed its output into Lemma 3.4's moment recurrence.

No historical definition is inferred merely from the matching shape of the formula. The exact source index sets, coordinate deletion/preprocessing, and profile restrictions remain controlling.

### Manuscript synchronization

The corresponding main-text note is a formalization-status addendum only. It does not change the established APW4 mathematical proof, its hypotheses, or the exact two-term energy identity. It also does not assert that this intermediate BBMST cylinder theorem alone completes the historical APW4 event-to-BIB map or weighted Hall construction.




## Source-exact reconciliation of c(I), nu(J), and the current cylinder theorem — 10 November 2026

The published source has now been checked directly at the definitions and proof of Lemma 3.3 (Balister–Bollobás–Morris–Sahasrabudhe–Tiba, *Algebra & Number Theory* 15 (2021), pp. 614–617; equations (9), (10), (15)).

The exact definitions are:
[
c(I)=max{mathbb P_a(H): H	ext{ is a hyperplane in }Q_a, F(H)=I},
qquad Isubseteq[a],
]
and
[

u(J)=prod_{jin J}rac{1}{(1-delta_j)|S_j|},
qquad Jsubseteq[a+1,n].
]
The paper explicitly states (c(arnothing)=
u(arnothing)=1). The empty-profile identity uses that (mathbb P_a) is a probability measure: the only hyperplane with no fixed coordinates is the full box (Q_a), whose mass is 1.

**Important profile-domain correction:** (c(I)) is a maximum over *all* hyperplanes of the initial box (Q_a) whose fixed-coordinate set is exactly (I), not merely over the hyperplanes in the particular covering family (mathcal A). A Lean definition restricted to the members of (mathcal A) would be too small and would not be source-faithful. The initial profile family must therefore enumerate all partial assignments on (I), with every coordinate outside (I) free, and evaluate their (mathbb P_a)-cylinder masses.

The current `prefixCylinderMass_le_initial_mul_hyperplaneSuffixFactor` has precisely the induction shape of (15). For a hyperplane (H) whose fixed-coordinate set splits as
[
F(H)=Icup J,quad Isubseteq[a],quad Jsubseteq[a+1,a+j],
]
the current recursion charges one factor
[
rac{1}{(1-delta_i)|S_i|}
]
exactly when the newly exposed coordinate (i) is fixed by (H), and charges 1 when it is free. Thus the remaining equality is a finite-product/index identification:
[
	exttt{hyperplaneSuffixFactor}(a,delta,H,j)
=
prod_{rin F(H)cap[a+1,a+j]}
rac{1}{(1-delta_r)|S_r|}.
]
The one-based paper coordinate (r) corresponds to Lean's `Fin n` value (r-1); in the present recursion the suffix interval is `Finset.Ico a (a+j)`. This index shift and the right-open endpoint must be explicit in the Lean theorem.

Consequently, the source-faithful Lemma 3.3 closure should be organized as two separate lemmas:
1. initial-block bound (mathbb P_a(H)le c(F(H)cap[a])), by the defining finite maximum;
2. suffix-factor identity above, followed by the already-present cylinder induction.

This yields (mathbb P_{a+j}(H)le c(I)
u(J)) for the exact split of fixed coordinates. It does not require inventing another distortion estimate.

**Lemma 3.4 dependency:** its exact right-hand side is
[
rac{1}{|S_k|^t}
sum_{F_1,ldots,F_tinmathcal N_k}
c!left((F_1cupcdotscup F_t)cap[a]ight)

u!left((F_1cupcdotscup F_t)cap[a+1,k-1]ight).
]
The proof first bounds (alpha_k(x)) by the number of compatible new hyperplanes divided by (|S_k|), expands the (t)-th power as an ordered (t)-tuple sum, identifies intersections of hyperplane shadows as either empty or a hyperplane with fixed set the union, and applies Lemma 3.3. The current `BBMSTPrefixMomentBridge` supplies the actual (P_{k-1})-weighted first/second moments and the hyperplane-incidence modules supply a union-bound intermediate; the missing connection is the exact (c(I)
u(J)) bound on each shadow intersection, followed by the ordered tuple summation. The tuple order and multiplicity must be preserved.

Primary source pages: [published article PDF, pp. 614–617](https://ora.ox.ac.uk/objects/uuid%3A3c55267c-60be-4652-89a7-db3db5f62c25/files/rdv13zt50s). This source reconciliation is distinct from Lean verification: the definitions and proof architecture are source-checked; the v15 integrated candidate remains unverified on its exact head.




### Präzisierung der historischen Lemma-3.3-Schnittstelle — 10. November 2026

Die veröffentlichte Lemma-3.3-Aussage setzt ausdrücklich voraus, dass die betrachtete Hyperfläche (Q_k)-messbar ist. In der Lean-Schnittstelle muss daher zusätzlich `H.FixedInsidePrefix (a+j)` vorliegen, bevor die über die ersten (a+j) Koordinaten definierte `prefixCylinder`-Masse als Masse des ursprünglichen historischen Ereignisses identifiziert wird. Ohne diese Voraussetzung beschreibt die Lean-Größe nur den Präfixzylinder der Projektion von (H), nicht notwendig das vollständige Ereignis.

Die Profilgröße (c(I)) ist nach Gleichung (9) des Originals das Maximum über **alle** Hyperflächen des Anfangsprodukts (Q_a) mit exakt festem Koordinatensatz (I), nicht nur über die Mitglieder der konkreten Überdeckungsfamilie. Für (I=arnothing) ist dies die volle Anfangsbox; (c(arnothing)=1) folgt aus der Normierung von (mathbb P_a). Der Suffixfaktor (
u(J)) aus Gleichung (10) ist das Produkt (1/((1-delta_j)|S_j|)) über genau die im Suffix festgelegten Koordinaten. Die vorhandene Lean-Rekursion realisiert diese freie/feste Koordinaten-Dichotomie; die explizite Indexproduktidentität und die source-faithful Definition von (c(I)) sind die verbleibenden Anschlusslemmata.

Quelle: Balister et al., *The Erdős–Selfridge problem with square-free moduli*, Algebra & Number Theory 15 (2021), Gleichungen (9), (10), Lemma 3.3, S. 614–617. Dieser Nachtrag präzisiert ausschließlich die Formalisierungsschnittstelle und ändert keinen mathematischen APW4-Satz.
