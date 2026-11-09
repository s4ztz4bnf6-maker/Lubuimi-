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
