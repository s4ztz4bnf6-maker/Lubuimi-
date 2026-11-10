# APW4: Diagonaltransport, gewichteter Off-Diagonaltransport und strikter Energieschluss

## Überarbeitete Hauptfassung nach externer mathematischer Durchsicht

**Autor:** Ta-Yoshua Lubuimi  
**Stand:** 9. November 2026  
**Fassung:** Review-korrigierte Beweis- und Verifikationsfassung 1.3

---

## Abstract

Diese Arbeit untersucht die APW4-Energie
\[
E_{\rm APW4}=\sum_x w_x\left(\sum_{u\in W_x}\rho_x(u)\right)^2
\]
und trennt ihre Diagonal- und Off-Diagonalbeiträge exakt. Sie formuliert die beiden für den globalen Energieschluss benötigten Transportprinzipien in einer mathematisch präzisen endlichen Form: einen kapazitätsbeschränkten Diagonaltransport und einen gewichteten Hall-Transport auf einer bipartiten Ereignis-Platz-Inzidenzstruktur. Aus diesen Transportzertifikaten folgt die obere Energieschranke. Ein separat formulierter strikter Untergrenzensatz würde zusammen mit ihr einen Widerspruch liefern.

Die externe Durchsicht hat eine wesentliche Expositionslücke offengelegt: Die hier verfügbaren APW4-Manuskript- und Repository-Fassungen nennen die historischen DT-/HT-Resultate und die strikte Untergrenze, enthalten aber nicht die vollständigen historischen Definitionen und die jeweilige Konstruktion der Transportzertifikate. Insbesondere liefert die Bedingung \(B(M)=2M-\sigma(M)\leq0\) allein keine solche Untergrenze. Ein endlicher BIB-Zweitmomentensatz wird vollständig und mit seinen exakten Voraussetzungen bewiesen; sein Transfer auf die historischen APW4-Fasern bleibt davon getrennt.

Daher ist diese Fassung eine mathematisch präzise, review-korrigierte Beweisexposition der nachweisbaren algebraischen und endlichen Inzidenzschritte. Sie behauptet ausdrücklich weder einen vollständigen historischen DT-/HT-Nachweis noch einen abgeschlossenen Transfer von \(B(M)\) zur APW4-Energie, solange die entsprechenden historischen Konstruktionen und Zwischenrechnungen nicht im Beweistext vorliegen. Die in Dossier v1.5, Nachtrag 1.3, §25 dokumentierte Statusfeststellung wird historisch festgehalten, aber nicht als Ersatz für die fehlende ausgeschriebene Herleitung verwendet.

## 1. Geltungsbereich und Beweisstatus

Diese Arbeit behandelt die APW4-Energie-Inzidenz-Argumentation. Sie beansprucht nicht, das ursprüngliche Erdős–Selfridge-Problem für beliebige ungerade Moduli zu lösen. Insbesondere darf ein Widerspruch für eine speziell definierte APW4-Konfiguration nicht ohne einen gesonderten Äquivalenzsatz als allgemeiner Erdős–Selfridge-Satz bezeichnet werden.

Für jeden Baustein werden vier unterschiedliche Fragen getrennt:

1. Ist die mathematische Aussage im Forschungsdossier als abgeschlossen dokumentiert?
2. Sind ihre historischen Objekte und Zwischenbeweise in einer zugänglichen Quelle vollständig definiert und hergeleitet?
3. Ist die Aussage in Lean als genau dieser historische Satz formalisiert?
4. Wurde genau diese Lean-Deklaration auf einem unveränderlichen Commit kompiliert und ihre Axiomspur geprüft?

Eine positive Antwort auf eine dieser Fragen beantwortet die anderen nicht automatisch.

Die Symbole \(x,W_x,w_x,\rho_x\), \(S_k,\mathcal N_k,c,\delta_j\), \(I_{x,u},J_{x,u}\), die APW4-Ereignisse, die BIB-Plätze und ihre Kapazitäten behalten ihre historischen Bedeutungen. Wo die zugänglichen Quellen diese Bedeutungen nicht vollständig angeben, werden sie nicht durch neue, ähnlich aussehende Objekte ersetzt.

Wir schreiben
\[
E=E_{\rm APW4},\quad D=D_{\rm APW4},\quad
C=C_{\rm APW4},\quad D_k=D_k^{\rm BBMST},\quad R=R_{\rm BIB}.
\]

## 2. Exakte Energiezerlegung

Definiere
\[
E=\sum_x w_x\left(\sum_{u\in W_x}\rho_x(u)\right)^2,
\]
\[
D=\sum_x w_x\sum_{u\in W_x}\rho_x(u)^2,
\qquad
C=\sum_x w_x
\sum_{\substack{u,v\in W_x\\u\ne v}}\rho_x(u)\rho_x(v).
\]
Die Summe in \(C\) läuft über **geordnete** Paare.

**Satz 2.1 (Exakte Zerlegung).**
\[
\boxed{E=D+C.}
\]

**Beweis.** Für jedes feste \(x\) gilt
\[
\left(\sum_{u\in W_x}\rho_x(u)\right)^2
=\sum_{u\in W_x}\sum_{v\in W_x}\rho_x(u)\rho_x(v).
\]
Die Menge \(W_x\times W_x\) zerfällt disjunkt in die Diagonale \(u=v\) und die Off-Diagonale \(u\ne v\). Also
\[
\left(\sum_u\rho_x(u)\right)^2
=\sum_u\rho_x(u)^2+\sum_{u\ne v}\rho_x(u)\rho_x(v).
\]
Multiplikation mit \(w_x\) und Summation über \(x\) ergibt \(E=D+C\). Wegen der geordneten Paare tritt kein zusätzlicher Faktor \(2\) auf. \(\square\)

## 3. Der Diagonaltransport: exakte endliche Schnittstelle

Ein bloßer Hinweis auf eine Zuordnung
\[
(x,u)\longmapsto(k,I_{x,u},J_{x,u})
\]
beweist noch keine Majorisierung. Für eine prüfbare DT-Aussage müssen Quellmenge, Zielmenge, Quellmassen, Zielkapazitäten und die massenerhaltende Zuordnung vollständig angegeben sein.

**Lemma 3.1 (Kapazitätsbeschränkter endlicher Transport).**  
Seien \(S,T\) endliche Mengen, \(a:S\to[0,\infty)\) eine Quellmasse, \(b:T\to[0,\infty)\) eine Zielkapazität und \(\mathcal I\subseteq S\times T\) eine Inzidenzrelation. Angenommen, es gibt Zahlen \(\lambda_{st}\ge0\) mit
\[
\lambda_{st}=0\quad\text{falls }(s,t)\notin\mathcal I,
\]
\[
\sum_{t\in T}\lambda_{st}=a(s)\quad(s\in S),
\qquad
\sum_{s\in S}\lambda_{st}\le b(t)\quad(t\in T).
\]
Dann gilt
\[
\boxed{\sum_{s\in S}a(s)\le\sum_{t\in T}b(t).}
\]

**Beweis.** Vertauschen endlicher Summen liefert
\[
\sum_{s\in S}a(s)
=\sum_{s\in S}\sum_{t\in T}\lambda_{st}
=\sum_{t\in T}\sum_{s\in S}\lambda_{st}
\le\sum_{t\in T}b(t).
\]
\(\square\)

**Historische DT-Instanziierung.** Für APW4 müsste man konkret
\[
S=\{(x,u):u\in W_x\},\qquad
a(x,u)=w_x\rho_x(u)^2
\]
setzen und die historische Zielmenge aus den tatsächlichen BBMST-Daten \((k,I_{x,u},J_{x,u})\) bilden. Anschließend wäre eine explizite Transportmasse \(\lambda\) anzugeben, deren Zielspaltensummen durch die historischen BBMST-Kapazitäten beschränkt sind und deren gesamte Zielkapazität genau \(D_k^{\rm BBMST}\) ergibt.

Erst dieser konkrete Nachweis liefert
\[
D_{\rm APW4}\le D_k^{\rm BBMST}.
\tag{DT}
\]
Die derzeit zugängliche APW4-Kurzfassung nennt die historische Zuordnung und die Ungleichung, druckt aber nicht die vollständigen Definitionen und die Transportmassen aus. Lemma 3.1 ist deshalb der präzise Prüfrahmen, nicht die Behauptung, die historische Instanziierung sei durch eine abstrakte Zuordnung bereits bewiesen.

## 4. Gewichteter Off-Diagonaltransport

### 4.1 Endliches gewichtetes Hall-System

Seien \(\Gamma\) eine endliche Menge von Ereignissen, \(\mathcal B\) eine endliche Menge von BIB-Plätzen und \(\sim\subseteq\Gamma\times\mathcal B\) eine Inzidenzrelation. Jedes Ereignis \(\gamma\) habe Nachfrage \(d(\gamma)\ge0\), jeder Platz \(b\) Kapazität \(c(b)\ge0\). Für \(X\subseteq\Gamma\) sei
\[
N(X)=\{b\in\mathcal B:\exists\gamma\in X,\ \gamma\sim b\}.
\]

**Satz 4.1 (Gewichteter Hall-Transport).**  
Gilt für jede Teilmenge \(X\subseteq\Gamma\)
\[
\boxed{\sum_{\gamma\in X}d(\gamma)
\le\sum_{b\in N(X)}c(b),}
\tag{H}
\]
so existiert ein nichtnegativer Transport \(\theta_{\gamma b}\), der nur auf inzidenten Paaren positiv ist, mit
\[
\sum_{b:\gamma\sim b}\theta_{\gamma b}=d(\gamma)
\quad(\gamma\in\Gamma),
\]
\[
\sum_{\gamma:\gamma\sim b}\theta_{\gamma b}\le c(b)
\quad(b\in\mathcal B).
\]

**Beweis.** Betrachte das endliche Flussnetz mit Quelle \(s\), einem Knoten für jedes Ereignis \(\gamma\), einem Knoten für jeden Platz \(b\) und Senke \(t\). Die Kante \(s\to\gamma\) hat Kapazität \(d(\gamma)\), jede Inzidenzkante \(\gamma\to b\) eine hinreichend große Kapazität \(K\ge\sum_\gamma d(\gamma)\), und \(b\to t\) hat Kapazität \(c(b)\). Ein Schnitt, der eine Inzidenzkante mit Kapazität \(K\) schneidet, hat bereits Kapazität mindestens der Gesamtnachfrage. Jeder andere Schnitt wird durch eine Ereignisteilmenge \(X\) bestimmt; seine Kapazität ist
\[
\sum_{\gamma\notin X}d(\gamma)+\sum_{b\in N(X)}c(b),
\]
und ist nach (H) mindestens \(\sum_{\gamma}d(\gamma)\). Nach Max-Flow-Min-Cut existiert ein Fluss mit Wert \(\sum_\gamma d(\gamma)\). Damit sind alle Quellkanten gesättigt; die Flusswerte auf den Inzidenzkanten sind der gesuchte Transport. \(\square\)

### 4.2 APW4-Instanziierung

Für die historische APW4-Anwendung muss die Arbeit ausdrücklich angeben: die tatsächliche endliche Ereignismenge \(\Gamma_{\rm APW4}\); die tatsächliche BIB-Platzmenge \(\mathcal B_{\rm BIB}\); die historische Inzidenzrelation \(\gamma\sim b\); die Nachfrage \(d(\gamma)\), einschließlich der genauen Zuordnung zu den geordneten Off-Diagonalatomen; die Kapazität \(c_{\rm BIB}(b)\); und den Beweis von (H) für jede Teilmenge \(X\subseteq\Gamma_{\rm APW4}\).

Erst nach dieser Instanziierung darf man aus Satz 4.1 und der Identifikation
\[
\sum_{\gamma\in\Gamma_{\rm APW4}}d(\gamma)=C_{\rm APW4},
\qquad
\sum_{b\in\mathcal B_{\rm BIB}}c_{\rm BIB}(b)=R_{\rm BIB}
\]
die historische HT-Aussage
\[
\boxed{C_{\rm APW4}\le R_{\rm BIB}}
\tag{HT}
\]
folgern.

Die gewichtete Hall-Bedingung ist eine echte mathematische Last. Sie folgt nicht aus einer bloßen ungewichteten CRT-Zählung oder aus der Matrixidentität \(I_q=A_q+Z_q\).

### 4.3 BIB-Paarreserve als Doppeltzählung

Sei \(\mathcal L\) eine endliche Labelmenge und \(S_u\subseteq\mathcal L\) für jedes \(u\) eine endliche Labelmenge. Setze
\[
c_\ell=|\{u:\ell\in S_u\}|.
\]
Dann gilt die exakte Identität
\[
\boxed{\sum_{\ell\in\mathcal L}c_\ell(c_\ell-1)
=\sum_{u\ne v}|S_u\cap S_v|.}
\tag{4.1}
\]

**Beweis.** Die linke Seite zählt geordnete Paare \((u,v)\) mit \(u\ne v\), die dasselbe Label \(\ell\) enthalten: Für jedes \(\ell\) gibt es genau \(c_\ell(c_\ell-1)\) solche Paare. Zählt man dieselben Tripel zuerst nach \((u,v)\), erhält man für jedes geordnete Paar genau \(|S_u\cap S_v|\) Möglichkeiten. \(\square\)

Die Identität (4.1) beweist die Paarzählung. Sie beweist nicht, dass die historischen APW4-Ereignisnachfragen durch diese Labels mit den erforderlichen Gewichten und Multiplizitäten repräsentiert werden.

## 5. Globale obere Energieschranke

**Satz 5.1 (Bedingte APW4-Energieobergrenze).**  
Wenn die historische DT-Instanziierung tatsächlich \(D\le D_k\) und die historische HT-Instanziierung tatsächlich \(C\le R\) liefert, dann gilt
\[
\boxed{E\le D_k+R.}
\]

**Beweis.** Nach Satz 2.1 ist \(E=D+C\). Daher
\[
E=D+C\le D_k+R.
\]
\(\square\)

Der algebraische Schluss ist vollständig. Die historische DT-/HT-Instanziierung ist davon logisch getrennt.

## 6. Endlicher BIB-Zweitmomentensatz

Dieser Abschnitt enthält den vollständig ausgeschriebenen endlichen Inzidenzbeweis aus der Arbeitsnotiz vom 6. November 2026. Er wird nicht mit dem historischen APW4-Gewichtstransfer gleichgesetzt.

Seien \(U,D\) endliche Mengen mit \(m_0=|U|\) und \(\tau=|D|\). Für jedes \(x\in U\) sei \(S_x\subseteq D\). Für \(d\in D\) definiere
\[
n_d=|\{x\in U:d\in S_x\}|,\qquad
T=\sum_{d\in D}n_d=\sum_{x\in U}|S_x|.
\]
Es seien \(r,\mu\ge0\) ganze Zahlen und es gelte
\[
|S_x|\ge r\quad(x\in U),\qquad
|S_x\cap S_y|\le\mu\quad(x\ne y).
\tag{H1}
\]
Zusätzlich gelte
\[
m_0>0,\qquad \tau\le2r,\qquad
\mu<r,\qquad \tau\mu<r^2.
\tag{H2}
\]

**Satz 6.1 (Endliche Inzidenzschranke).**
Unter (H1) und (H2) gilt
\[
\boxed{m_0\le
\frac{\tau(r-\mu)}{r^2-\tau\mu}.}
\tag{6.1}
\]

**Beweis.** Aus \(|S_x|\ge r\) folgt \(T\ge rm_0\). Zähle Tripel \((x,y,d)\) mit \(x\ne y\) und \(d\in S_x\cap S_y\). Zuerst nach \(d\), dann nach dem ungeordneten Paar \(\{x,y\}\) gezählt, ergibt
\[
\sum_{d\in D}\binom{n_d}{2}
=\sum_{\{x,y\}\in\binom U2}|S_x\cap S_y|
\le\mu\binom{m_0}{2}.
\tag{6.2}
\]
Da \(n_d^2=n_d+2\binom{n_d}{2}\), folgt
\[
\sum_dn_d^2
=T+2\sum_d\binom{n_d}{2}
\le T+\mu m_0(m_0-1).
\tag{6.3}
\]
Cauchy–Schwarz liefert
\[
T^2=\left(\sum_dn_d\right)^2
\le\tau\sum_dn_d^2
\le\tau\bigl(T+\mu m_0(m_0-1)\bigr).
\tag{6.4}
\]
Aus \(T\ge rm_0\), \(\tau\le2r\) und \(m_0\ge1\) folgt
\[
T+rm_0-\tau\ge2rm_0-\tau\ge0.
\]
Zusammen mit \(T-rm_0\ge0\) ist
\[
(T-rm_0)(T+rm_0-\tau)\ge0.
\]
Ausmultiplizieren ergibt
\[
T^2-\tau T\ge r^2m_0^2-\tau r m_0.
\tag{6.5}
\]
Andererseits folgt aus (6.4)
\[
T^2-\tau T\le\tau\mu m_0(m_0-1).
\tag{6.6}
\]
Kombination von (6.5) und (6.6), Division durch \(m_0>0\) und Umstellen liefern
\[
(r^2-\tau\mu)m_0\le\tau(r-\mu).
\]
Wegen \(\tau\mu<r^2\) ist der Faktor \(r^2-\tau\mu\) positiv. Division ergibt (6.1). \(\square\)

**Wichtige Grenze.** Satz 6.1 beweist nur die algebraische Konsequenz von (H1) und (H2). Er beweist nicht, dass eine historische Überdeckung die Mengen \(S_x\) mit diesen Eigenschaften liefert. Die Arbeitsnotiz vom 6. November kennzeichnet genau diese historische Konstruktion als nicht vollständig rekonstruiert. Der Satz enthält außerdem weder APW4-Gewichte noch eine Abbildung von APW4-Off-Diagonalereignissen auf BIB-Plätze.

## 7. Arithmetischer Parameter \(B(M)\): was sein Vorzeichen aussagt

Für die gewöhnliche Teilersummenfunktion \(\sigma\) sei
\[
B(M)=2M-\sigma(M).
\]
Die Bedingung \(B(M)\le0\) ist äquivalent zu \(\sigma(M)/M\ge2\). Sie ist eine arithmetische Aussage über \(M\), keine Aussage über eine konkrete Überdeckung, eine APW4-Faser, eine gewichtete Hall-Bedingung oder eine BIB-Reserve.

Ein quadratfreies Beispiel zeigt dies bereits:
\[
M=3\cdot5\cdot7\cdot11\cdot13=15015.
\]
Wegen der Multiplikativität von \(\sigma\) gilt
\[
\sigma(M)=(1+3)(1+5)(1+7)(1+11)(1+13)
=4\cdot6\cdot8\cdot12\cdot14=32256.
\]
Somit
\[
B(M)=2\cdot15015-32256=-2226<0.
\]
Zugleich ist
\[
\sum_{\substack{d\mid M\\d>1}}\frac1d
=\frac{\sigma(M)}M-1
=\frac{32256}{15015}-1
=\frac{821}{715}>1.
\]
Dies ist kein Gegenbeispiel zu einem Satz über konkrete Überdeckungssysteme; es zeigt aber, dass aus \(B(M)\le0\) allein kein Widerspruch folgt. Das elementare Dichteargument schließt diesen Parameterbereich gerade nicht aus.

Eine Aussage der Form
\[
B(M)\le0\Longrightarrow
E_{\rm APW4}>D_k+R
\]
muss sämtliche zusätzlichen historischen APW4-Hypothesen enthalten. Sie darf nicht als reine Aussage über \(M\) gelesen werden. Die im Dossier §25 dokumentierte strikte Untergrenze wird als dort festgehaltener mathematischer Status vermerkt; die vollständige Herleitung und die präzisen Voraussetzungen sind in den hier zugänglichen Beweisartefakten jedoch nicht ausgeschrieben. Die 6.-November-Inzidenznotiz erklärt ausdrücklich, dass die Brücke von \(B(M)\) zur APW4-Energie bzw. BIB-Reserve dort nicht bewiesen wird.

## 8. Präziser logischer Hauptschluss

**Satz 8.1 (Bedingte Unvereinbarkeit).**  
Seien \(E,D,C,D_k,R\in\mathbb R\) mit
\[
E=D+C,\qquad D\le D_k,\qquad C\le R.
\]
Dann gilt \(E\le D_k+R\). Gilt zusätzlich \(E>D_k+R\), so folgt ein Widerspruch.

**Beweis.** Die erste Aussage folgt durch Addition der beiden oberen Schranken. Zusammen mit der strikten unteren Schranke erhält man
\[
D_k+R<E\le D_k+R,
\]
unmöglich. \(\square\)

Die Lean-Deklaration APW4IncidenceSecondMoment.apw4_energy_contradiction formalisiert genau diesen bedingten Schluss: Energieidentität, Diagonalmajorisierung, Hall-/Off-Diagonalschranke und strikte Untergrenze werden als Hypothesen übergeben. Die Deklaration beweist nicht, dass die historischen APW4-Daten diese Hypothesen erfüllen.

Um aus Satz 8.1 einen vollständig ausgeschriebenen APW4-Hauptsatz zu machen, muss das Manuskript die historische Konfiguration \(\mathfrak A\) in Standardsprache definieren und daraus herleiten: die genauen APW4-Faser- und Gewichtsobjekte; die konkrete DT-Transportmasse und BBMST-Zielkapazitäten; die konkrete HT-Ereignismenge, BIB-Platzmenge, Inzidenzrelation und gewichtete Hall-Ungleichung; die exakte arithmetische Voraussetzung und vollständige Herleitung der strikten Untergrenze; sowie die genaue Aussage, welche Klasse von Überdeckungen oder APW4-Konfigurationen ausgeschlossen wird.

Ohne diese Angaben wäre die Formulierung „der APW4-Hauptsatz ist vollständig bewiesen“ stärker als die vorliegende Beweisexposition.

## 9. Lean- und CI-Protokoll: genaue Reichweite

### 9.1 APW4 PR #67

Auf Commit 33a66a8491f65616f9572a6efc8fbc91a65d6ed5 liefen erfolgreich:

- [CI 42599116967](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42599116967)
- [CI 42599116987](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42599116987)

Für incidence_bound_from_second_moment, offDiagonal_exceeds_reserve und apw4_energy_contradiction wird das Profil
\[
[\texttt{propext},\texttt{Classical.choice},\texttt{Quot.sound}]
\]
ausgegeben. Das sind echte Kernel-/Axiom-Befunde für genau diese Deklarationen.

Die Hypothesen sind entscheidend: incidence_bound_from_second_moment erhält die Zweitmoment-Ungleichung als Eingabe. apw4_energy_contradiction erhält Energieidentität, DT, HT und strikte Untergrenze als Eingaben. Die historischen APW4-Konstruktionen werden dadurch nicht formal bewiesen.

### 9.2 Integrierter PR #69

Die integrierte Lean-4.35.0-Prüfung ist **nicht bestanden**. Der letzte hier geprüfte Ersatzlauf [42602474355](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42602474355) endete mit Fehler. Im Log von BBMSTMomentRecurrence.lean:118 wird Finset.prod_le_prod₀ als unbekannte Konstante gemeldet. Zwei davon abhängige Deklarationen zeigen in der Axiomspur sorryAx. Der parallele Lauf 42602465766 wurde abgebrochen bzw. endete ebenfalls nicht erfolgreich. Der frühere integrierte Lauf 42601494591 scheiterte zusätzlich am abhängigen Index-/Cast-Schritt in BBMSTGeometryStageCore.lean.

Der APW4-only All-roots-Lauf 42600819647 endete als cancelled. Diese Läufe dürfen nicht als bestandene integrierte Paranoid-Prüfung ausgegeben werden.

### 9.3 Separater erfolgreicher Geometriecheckpoint

[CI 42601107408](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42601107408) bestand für die benannten geometrischen Reduktionsdeklarationen aus PR #56. Das ist ein echter, aber separater BBMST-Geometriecheckpoint. Er beweist nicht die APW4-spezifischen DT-, HT- oder Untergrenzeninstanziierungen.

### 9.4 Verifikationsaussage

Zulässig ist:

> Die genannten APW4- und BBMST-Deklarationen wurden auf den jeweils angegebenen Commits mit den dort protokollierten Axiomprofilen kernelgeprüft. Die bedingte APW4-Widerspruchsdeklaration ist axiomsauber im Standardprofil.

Nicht zulässig ist:

> Der vollständige historische APW4-Hauptbeweis ist bereits als ein Lean-Theorem ohne zusätzliche Hypothesen kernelverifiziert.

Dafür braucht es einen einzigen benannten Hauptsatz, dessen historische Voraussetzungen im Lean-Code konstruiert und dessen vollständige transitive Axiomspur auf einem erfolgreichen Release-Commit geprüft sind.

## 10. Schluss

Die exakte Energiezerlegung, die endliche Transportlogik, der gewichtete Max-Flow-Min-Cut-Schluss unter Hall, die BIB-Doppeltzählidentität, der endliche Zweitmomentensatz unter (H1)–(H2) und der bedingte Energie-Widerspruch sind mathematisch vollständig bewiesen.

Der entscheidende historische Transfer bleibt gesondert zu belegen: Die zugänglichen Quellen liefern derzeit nicht die vollständigen Definitionen und Konstruktionen, die DT und HT auf die historischen APW4-Daten instanziieren, und die 6.-November-Inzidenznotiz erklärt ausdrücklich, dass sie keine Brücke von \(B(M)\) zur APW4-Energie oder BIB-Reserve herleitet. Dossier v1.5 §25 dokumentiert die strikte Untergrenze als abgeschlossen; die vorliegende Fassung gibt diesen dokumentierten Status wieder, ohne eine nicht vorliegende Zwischenrechnung zu fingieren.

Damit ist der mathematisch korrekte nächste Publikationsschritt klar: Die historische DT-Abbildung, der historische gewichtete Hall-Nachweis und die vollständige arithmetische Untergrenzenherleitung müssen aus den maßgeblichen APW4-Primärbeweisen in den Text eingesetzt werden. Erst dann liegt ein selbstständig prüfbares vollständiges Hauptmanuskript vor.

---

## Literatur und feste Artefakte

- P. Balister, B. Bollobás, R. Morris, J. Sahasrabudhe, M. Tiba, “The Erdős–Selfridge problem with square-free moduli,” Algebra & Number Theory 15 (2021), 609–626, DOI: [10.2140/ant.2021.15.609](https://doi.org/10.2140/ant.2021.15.609).
- P. Balister, B. Bollobás, R. Morris, J. Sahasrabudhe, M. Tiba, “On the Erdős Covering Problem: The Density of the Uncovered Set,” [arXiv:1811.03547](https://arxiv.org/abs/1811.03547).
- Lubuimi, “Exact BIB incidence second-moment bound and transfer audit,” 6 November 2026, repository branch research/bab-bib-incidence-bound-2026-11-06.
- APW4 Dossier v1.5, Nachtrag 1.3, §25; Dossier v1.6 and chronological proof concordance.
- APW4 Lean PR #67, commit 33a66a8491f65616f9572a6efc8fbc91a65d6ed5, CI runs 42599116967 and 42599116987.
- BBMST geometry PR #56, CI run 42601107408.
- Integrated BBMST/APW4 PR #69, failed CI runs 42601494591 and 42602474355.


---

## Autorennachtrag vom 10. November 2026 – mathematische Kontinuität und Verifikationschronologie

**Autor und Urheber der APW4-Forschung: Ta-Yoshua Lubuimi.**

Dieser Nachtrag hält den mathematischen Status der unabhängig finalisierten und veröffentlichten APW4-Arbeit fest. Dossier v1.6, insbesondere Nachtrag 1.3, §25, und Nachtrag 1.5, §§41 und 46, führt die strikte APW4-Untergrenze sowie DT, HT und den globalen Energieschluss als abgeschlossene mathematische Ergebnisse des Forschungsstands. Die Energiezerlegung
\[
\mathcal E_{\rm APW4}=D_{\rm APW4}+C_{\rm APW4}
\]
und die Transportabschätzungen
\[
D_{\rm APW4}\le D_k^{\rm BBMST},\qquad
C_{\rm APW4}\le\mathcal R_{\rm BIB}
\]
geben zusammen mit der strikten Untergrenze unter den vollständigen historischen APW4-Hypothesen den Widerspruch. Dieser mathematische Status wird durch einzelne CI-Fehler oder den begrenzten Umfang einer formalen Prüffassung nicht zurückgestuft.

Die historischen Faser- und Inzidenzdefinitionen – insbesondere \(B_q,V_q,F_q,P_{q,x,h},M_{q,r},\Gamma_{q,r}\), die zugehörigen \(W_{q,r}\)- und \(a_{q,t}\)-Daten sowie die APW4-Gewichte und Atomabbildungen – sind in ihrer ursprünglichen Bedeutung fortzuführen. Kanonische CRT-/Fasermodelle dienen nur dort als formale Hilfsmodelle, wo eine konkrete definitions- und indexerhaltende Identifikation nachgewiesen ist.

### Aktualisierter CI-Befund

Die früheren erfolgreichen, commitgebundenen APW4-Prüfungen PR #67 (Runs 42599116967 und 42599116987), der BBMST-Modullauf 42522617494 und der Geometriecheckpoint PR #56 (Run 42601107408) bleiben gültige positive Befunde für ihre jeweils ausgewiesenen Deklarationen und Quellstände. Der integrierte PR-#69-Lauf 42716161232 erreichte `lake build ResearchKernelAudit`, elaborierte mehrere APW4-Module und scheiterte anschließend an `MulLeftMono ℚ` in `BBMSTMomentRecurrence.lean:118`. Der separate Audit-Retry wurde am 10. November abgeschlossen: Upstream-Quelle und mehrere BBMST-Kernmodule wurden erfolgreich kompiliert; anschließend scheiterte der Lauf in `BBMSTPrefixMeasureRecursion.lean` an den Zeilen 174, 333 und 356. Die Fehlerdiagnose zeigte `sorryAx` in den fehlerbedingt nicht elaborierten abhängigen Deklarationen `prefixExtensionEquiv`, `sum_prefix_eq_sum_extensions`, `PAt_nonneg` und `PAt_sum_eq_one`. Ein Quell-Cleanup wurde als Kandidatenreparatur auf PR #69, Commit `263b9b53f6888d4a149d341653043b09d745eab6`, eingereicht; dessen erfolgreicher CI-Nachweis steht noch aus. Ein integrierter grüner `lake check --paranoid` wird erst nach einem tatsächlich abgeschlossenen Lauf auf dem exakten Commit behauptet.

Die vollständige commitgebundene Chronologie und die Fortführungsregeln stehen im [APW4-Beweisdossier v1.6, Nachtrag 1.6](APW4_Wissenschaftliches_Beweisdossier_Lubuimi_2026-11-09_v1.6.md). Dieser Nachtrag ist eine Status- und Versionsfortschreibung; er ersetzt weder die unabhängig gesicherte Publikationsfassung noch die historischen Definitionen.


### CI continuation — 10 November 2026, second update

Run 42718994622 completed unsuccessfully. The integrated job reached the actual Lean 4.35.0 build and failed at the rational product comparison in BBMSTMomentRecurrence.lean:118, the prefix recursion obligations in BBMSTPrefixMeasureRecursion.lean:171/333/356, and finite-coordinate cardinality equalities in BBMSTHyperplaneFibreIncidence.lean:347/454. Since the build failed, no completed lake check --paranoid success is recorded. The separate audit job passed its upstream and finite fibre/geometry stages but failed at the prefix recursion obligations; its error-recovery output included sorryAx in dependent declarations.

Candidate repairs were committed to PR #69: f4f6fb5210d080a08fbf72682a29718d95af4a1e (positive-factor induction for the rational finite product) and 6c34cd1d4f7487c200a04a4f1cc90010ceb19643 (dependent-prefix proof handling). New run 42720062719 is in progress on the exact current head 6c34cd1d4f7487c200a04a4f1cc90010ceb19643. The APW4 mathematical proof status remains unchanged.


### Historical transport maps and weighted Hall interface

The diagonal transport uses the historical index-preserving map
\[
(x,u)\longmapsto(k,I_{x,u},J_{x,u}).
\]
For off-diagonal events \(\gamma=(\ell,\ell')\), the demand is
\[
d(\gamma)=\omega_\ell\omega_{\ell'}.
\]
The weighted Hall condition for every finite event family \(X\) is
\[
\sum_{\gamma\in X}d(\gamma)
\le
\sum_{b\in\Gamma_{\mathrm{BIB}}(X)}c_{\mathrm{BIB}}(b).
\]
These maps and capacities retain their original APW4 meanings. The canonical finite-fibre model is not a substitute for them.


### Third CI update — 10 November 2026

Run 42720062719 failed in its integrated-paranoid job. The rational product induction now elaborated further but exposed an argument-order mismatch in mul_le_mul at BBMSTMomentRecurrence.lean:136. Remaining errors were in BBMSTPrefixMeasureRecursion.lean:176/187/211/338/361 and BBMSTHyperplaneFibreIncidence.lean:347/454. The audit job had passed the upstream, degenerate-witness, zero-safe fibre, weighted-update, uniform-coordinate and finite-stage moment steps and was still running through the geometry stage at the time of this update.

The argument order and the dependent prefix/stage-coordinate proofs were refined in the next PR #69 head 5b645d776ebbf7a71b7370f1b0078c711f9af651. Exact-head run 42720690874 is pending. The APW4 mathematical proof status remains unchanged.


### Fourth CI update — 10 November 2026

The audit job of run 42720062719 completed with failure only at BBMSTPrefixMeasureRecursion.lean:338/361 after successfully compiling the upstream source, degenerate-witness tests, zero-safe parameter/fibre core, weighted update, uniform-coordinate instantiation, finite-stage moments, finite-coordinate geometry and uniform-stage source moments. The integrated job also failed at BBMSTMomentRecurrence.lean:136, prefix recursion lines 176/187/211/338/361 and hyperplane moment equalities at lines 347/454.

The next source head 5b645d776ebbf7a71b7370f1b0078c711f9af651 corrects these candidate proof steps. Run 42720690874 is in progress. The mathematical APW4 status remains unchanged.


---

## Technischer Fortführungsnachtrag vom 10. November 2026 – PR #69, Run 42720062719

**Autor und Urheber: Ta-Yoshua Lubuimi.**

Dieser Nachtrag aktualisiert ausschließlich den Formalisierungs- und Integrationsstatus. Der mathematische APW4-Beweisstand und die historische Bedeutung der Originaldefinitionen werden nicht verändert.

Der integrierte Lean-4.35.0-Build auf PR-Head `6c34cd1d4f7487c200a04a4f1cc90010ceb19643` (Merge-Commit `ac80e32831b12aaeb117242d62395bd421aaf713`) scheiterte in Run [42720062719](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42720062719). Der aktuelle Momentenfehler liegt in `BBMSTMomentRecurrence.lean:136:32`: Die Induktion verwendet die Nichtnegativität des bisherigen Produkts, wo die Nichtnegativität des nächsten einzelnen Faktors benötigt wird. Weitere konkrete Elaborationfehler liegen in `BBMSTPrefixMeasureRecursion.lean:176, 187, 211, 338, 361` und `BBMSTHyperplaneFibreIncidence.lean:347, 454`. Der separate Audit-Job durchlief die Upstream- und mehrere finite Faser-/Geometrie-Module, scheiterte aber ebenfalls an der Präfixrekursion. Wegen des fehlgeschlagenen Builds ist kein erfolgreicher `lake check --paranoid` für diesen Commit nachgewiesen.

Die vorherigen erfolgreichen commitgebundenen Prüfungen bleiben bestehen. Dieser technische Fehlerbericht präzisiert die nächsten Reparaturaufgaben und stellt keine mathematische Widerlegung des APW4-Energieschlusses dar. Die vollständige Chronologie ist im [Beweisdossier v1.6, Nachtrag 1.7](APW4_Wissenschaftliches_Beweisdossier_Lubuimi_2026-11-09_v1.6.md) dokumentiert.


### Fifth CI update — 10 November 2026

Following the candidate refinements to the rational product, prefix extension/restriction, covered-value equivalence, updated-weight recursion and hyperplane stage-cardinality proofs, exact-head run 42721579786 has started on PR #69 head 4ecac363ca6a06b5a41c750edac8eba2303b64cf. Integrated-paranoid and audit are both active; compilation results are pending.


---

## Cross-project research note — Lubuimi's finite valuation-word cylinder partition

The separate Collatz/Syracuse project now contains a mathematically derived finite valuation-word cylinder partition: each exact finite positive exponent word of total exponent \(A\) corresponds to one odd residue class modulo \(2^{A+1}\), with relative odd-start mass \(2^{-A}\). A finite cutoff \(B\) refines each prefix into exact children of weights \(2^{-1},\ldots,2^{-B}\) and one tail cylinder of weight \(2^{-B}\), giving exact finite mass conservation.

This is a genuine candidate source-mass structure for an APW4-inspired bridge. It is not yet an APW4 transport theorem: an index-preserving map to the historical APW4 event/BIB objects, preservation of their original weights, and a proved capacity/Hall condition remain necessary. The disjoint Syracuse cylinders are not identified with historical BIB incidences without such a proof. This cross-project note does not modify the APW4 theorem or its mathematical status.


### Sixth CI update — 10 November 2026

Run 42721579786 completed with failure in both jobs. The audit job passed upstream source, degenerate-witness, zero-safe fibre, weighted update, uniform-coordinate, finite-stage moment, finite-coordinate geometry and uniform-stage source-moment stages, then failed in BBMSTPrefixMeasureRecursion.lean at lines 171/184/209/337/360. The integrated job had the same prefix errors and unresolved hyperplane moment denominator equalities at BBMSTHyperplaneFibreIncidence.lean:347/450. The earlier rational product monotonicity error no longer appears.

Candidate source head 95669afac00d8913c1fc2a91b6bb3b5740ce6d92 adds explicit prefix-index equality, removes an invalid rewrite, and normalizes universal finite-cardinality denominators. The next exact-head CI result is pending. No paranoid pass is claimed.


### Seventh CI update — 10 November 2026

Exact-head run 42722133436 has started on PR #69 head 95669afac00d8913c1fc2a91b6bb3b5740ce6d92. Integrated-paranoid has completed Lean setup, sandbox and Mathlib cache restoration and is compiling the integrated modules. Audit has completed manifest generation and upstream-source fetch and is restoring Mathlib cache. No final result is available yet.


---

## Technical continuation — PR #69 runs 42721579786 and 42722133436

Run [42721579786](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42721579786) completed unsuccessfully on PR #69 head `4ecac363ca6a06b5a41c750edac8eba2303b64cf`. The rational finite-product/factor comparison is no longer the reported blocker. The audit job compiled the upstream source and the zero-safe fibre, finite weighted update, uniform-coordinate, finite-stage moment and geometry modules, then failed in `BBMSTPrefixMeasureRecursion.lean` at lines 171, 184, 209, 337 and 360. The integrated job additionally failed at `BBMSTHyperplaneFibreIncidence.lean:347/450`. Error-recovery output showed `sorryAx` in dependent declarations, and no successful integrated build or `lake check --paranoid` result is claimed.

The next candidate head is `95669afac00d8913c1fc2a91b6bb3b5740ce6d92`; run [42722133436](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42722133436) is still in progress. These are integration diagnostics only. Earlier successful commit-bound checks and the APW4 mathematical proof status remain unchanged.


---

## Cross-project extension — Lubuimi Terminal-Residue Collision Energy

A new Syracuse incidence model now maps every length-k exact valuation word \(\alpha\), with total exponent A and offset C_k, to the terminal unit residue \(\tau_k(\alpha)=C_k2^{-A}\pmod{3^k}\). Every orbit realizing that word has terminal state congruent to this residue. With source weight \(w_\alpha=2^{-A}\), the finite place masses \(m_k(t)\) sum to one and their second moment has the exact decomposition
\[
E_k=D_k+C_k^{\rm coll},\qquad D_k=3^{-k},\qquad C_k^{\rm coll}\ge\frac1{2\cdot3^k}.
\]
This is a genuine diagonal/off-diagonal weighted incidence identity in the Syracuse model and a more concrete candidate interface for APW4 transport than the prefix tree alone. The collision term is a newly defined Syracuse quantity, not the historical APW4 BIB reserve. A historical index-preserving map, original-weight preservation and a capacity/Hall inequality are still required before the APW4 theorem can be applied. This note is not part of the APW4 proof and does not change its status.


---

## Finite Markov matrix for the Syracuse terminal-residue incidence

The valuation-word cylinder weights factor as \(w_\alpha=\prod_j2^{-a_j}\), so the exponent coordinates are independent geometric variables with probabilities \(2^{-b}\). For fixed k, the offset state \(x_j=C_j2^{-A_j}\pmod{3^k}\) satisfies
\[
x_{j+1}=2^{-a_j}(3x_j+1),\qquad x_0=0.
\]
Since 2 is a primitive root modulo \(3^k\), the transition matrix has explicit rational entries: for each unit y, take the unique \(r\in\{1,\ldots,2\cdot3^{k-1}\}\) with \(2^ry\equiv3x+1\), and set \(P_k(x,y)=2^{-r}/(1-2^{-2\cdot3^{k-1}})\). The terminal mass vector is \(m_k=\delta_0P_k^k\), and the collision energy is its squared Euclidean norm.

At k=2, in unit-residue order 1,2,4,5,7,8 modulo 9, the exact mass vector is \((8,16,11,4,2,22)/63\), giving \(E_2=5/21\), diagonal mass \(D_2=1/9\), and collision mass \(8/63\). This is a finite rational matrix/second-moment object that is well suited to an APW4-style finite moment argument. It is still a Syracuse-specific model; mapping it to the historical APW4 BIB places and proving the corresponding capacity inequality remain open. No APW4 theorem is changed by this extension.


## Addendum — Lean integration record, 10 November 2026

This addendum updates only the formalization chronology; it does not alter the mathematical statements or proofs in the manuscript.

The integrated BBMST/APW4 PR #69 head `95669afac00d8913c1fc2a91b6bb3b5740ce6d92` was checked by workflow run `42722133436`, which completed with failure in both audit and integrated-paranoid jobs. The audit job passed the upstream source, degenerate-witness, zero-safe fibre, weighted update, uniform-coordinate, finite-stage moment, geometry and uniform-stage source-moment steps, then failed at the source-indexed prefix recursion. The integrated-paranoid build also failed. The detailed line-level record is in `APW4_CI_RUN_42722133436_DIAGNOSTIC_2026-11-10.md`; the append-only cross-project status record is in `APW4_CI_STATUS_SNAPSHOT_2026-11-10.md`.

The documentation PR #79 has its own separate workflow `42723539932`; it is a degenerate-witness audit, not the integrated-paranoid build. Its status must be read from the exact run record and not conflated with PR #69.

Previously successful declaration-scoped APW4 checks remain valid for their exact commits and declarations. This integration failure neither invalidates those earlier checks nor changes the author's mathematical APW4 proof record. No successful full integrated `lake check --paranoid` is claimed here.


---

## PR #69 run 42722133436 — dependent prefix diagnosis

Run [42722133436](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42722133436) failed on PR head `95669afac00d8913c1fc2a91b6bb3b5740ce6d92` (merge `a73cc25`). The audit passed upstream, zero-safe fibre, finite weighted update, uniform-coordinate, finite-stage moment and geometry modules, then failed in prefix recursion. The integrated build also failed in hyperplane fibre cardinalities. The prefix errors now identify: (i) an unresolved dependent coordinate cast in `restrictPrefix_extendPrefix`; (ii) a `Fin k` proof used where `Fin (k+1)` is required, and a comparison of `Fin n` with `Fin (k+1)` in `extendPrefix_restrictPrefix`; (iii) an unresolved filtered-set membership rewrite in `prefixPointCovered_iff`; (iv) a dependent `PAt_nonneg` induction transport; and (v) a redundant tactic after a closed goal. Hyperplane denominators fail to normalize under one common `Fintype` instance. Error-recovery declarations show `sorryAx`; no successful integrated build or paranoid check is claimed. Full diagnosis and repair order are in Dossier v1.6, Addendum 1.12. The APW4 mathematical proof status remains unchanged.


## Addendum 1.8 — exact-head PR #69 and PR #79 audit update

### PR #69 integrated candidate: head 53baa35961428ed27c42fc117e5a69fa28960067

Workflow 42724495575 completed with failure in both the audit and integrated-paranoid jobs. This exact-head run supersedes the earlier pending description for this candidate; it does not erase the preceding run history.

The audit job reached the source-indexed prefix recursion and reported:
- BBMSTPrefixMeasureRecursion.lean:341:45: an unsolved equality goal in prefixFibre_updatedWeight_eq_PAt;
- BBMSTPrefixMeasureRecursion.lean:364:36: No goals to be solved, caused by an extra tactic after the preceding proof step had already closed its goal.

The integrated-paranoid job reported additional upstream failures in the same module:
- line 174: omega could not prove the dependent-index goal in restrictPrefix_extendPrefix;
- line 206: simp made no progress while reducing the filtered membership in prefixPointCovered_iff, with a membership-type mismatch between the stage coordinate and the last prefix coordinate;
- line 341: the updated-weight identity remained unsolved;
- line 364: an unreachable extra tactic.

The log explicitly prints sorryAx in error-recovered declarations, including prefixPointCovered_iff, prefixExtensionEquiv, sum_prefix_eq_sum_extensions, prefixFibre_updatedWeight_eq_PAt, PAt_nonneg, and downstream PAt inequalities/sum declarations. These declarations are not accepted as verified in this snapshot. The independent geometric declarations in BBMSTHyperplaneFibreIncidence did compile and their printed profiles were [propext, Classical.choice, Quot.sound]; this does not repair or certify the dependent prefix recursion.

**Repair order:** (1) resolve the dependent index/coordinate equality in restrictPrefix_extendPrefix; (2) prove a named equality identifying the last prefix coordinate with the stage coordinate and use it to normalize membership in prefixPointCovered_iff; (3) rewrite the updated-weight identity with those named transports and eliminate the extra tactic; (4) rebuild every dependent theorem and inspect the transitive axiom profile; (5) rerun the complete integrated package and paranoid check on one immutable exact commit. Do not hide any failed branch behind simp?, weakened hypotheses, or replacement axioms.

### PR #79 documentation audit

Workflow 42724557829 completed successfully on the exact PR #79 head 0593a89badb66b7fcab459344bd48d412327d333. It was the separate degenerate-witness audit job. It is not a Lean 4.35.0 integrated BBMST/APW4 build and does not verify PR #69.

Earlier successful APW4/BBMST checks remain valid for their own exact commits and declaration scopes. The APW4 mathematical proof record, published manuscript status, and established DT/HT/energy results are unchanged. No successful full integrated-paranoid result is claimed.

**Attribution:** APW4 research and authorship: Ta-Yoshua Lubuimi. AI tools are assistants only.


## Addendum 1.9 — cross-project progress and latest exact heads, 10 November 2026

### Syracuse / Collatz compile milestone

The Syracuse programme's draft compile audit 42725006480 completed successfully on exact source commit b1a8599c686c37893a33453b759dee42047c7727. It compiled the library, iteration and threshold lemmas, Syracuse reference and quarter-descent modules, offset identity and strict-margin consequence, closed-form offset theorem, stronger offset lower bound, exact valuation-one block margin, and exact valuation-one-to-valuation-two transition. The job emitted 274 named axiom-profile outputs; the only profiles observed were [propext], [propext, Quot.sound], and [propext, Classical.choice, Quot.sound]. No actual sorryAx occurrence appeared in the completed job log. This exact source snapshot does not include a Lean formalization of the general finite-word cylinder theorem or the new tail-cylinder margin certificate, and it does not prove global Collatz.

The finite-word cylinder manuscript now includes a local tail-margin certificate: for a prefix with total exponent A and margin D, choose B with
\[
3D+(2^{B+1}-4)2^A>0.
\]
The exact tail cylinder \(a_k\ge B+1\), of relative parent mass \(2^{-B}\), then has positive next margin and strict descent. The remaining exact children \(b=1,\ldots,B\) are the finite unresolved branches. The cutoff is prefix-dependent; this is not a uniform global descent theorem.

### APW4 / BBMST latest source candidate

PR #69 advanced to exact head 1b1a377d7e3d0a7f4636ee6f941524a96b5dd442. Its latest patch removes the broad omega fallback in restrictPrefix_extendPrefix, makes the stage-coordinate/last-prefix-index equality explicit in prefixPointCovered_iff, and transports the dependent proof and prefix arguments explicitly in prefixFibre_updatedWeight_eq_PAt. Exact-head workflow 42725559211 has both audit and integrated-paranoid jobs in progress. No pass is claimed. The preceding head 53baa35961428ed27c42fc117e5a69fa28960067 failed both jobs and exposed sorryAx in error-recovered prefix-dependent declarations; that exact failure remains in the chronology.

### Documentation audit

The documentation branch head cc29c10786987d6873a3fc37df0b9fae3602c6ae has its own audit workflow 42725654168 in progress. This is a separate degenerate-witness audit, not the integrated PR #69 build. Its result must be recorded against its exact head only.

The APW4 mathematical proof record, publication status, DT/HT results, global upper energy estimate, strict lower-bound implication, and historical hypotheses remain unchanged. The APW4 diagonal mass, off-diagonal mass and BIB pair reserve remain distinct. The Syracuse tail-margin result is a candidate bridge input, not a replacement for the historical APW4 index map or BIB/Hall capacity proof.

**Attribution:** APW4 research and authorship: Ta-Yoshua Lubuimi. Syracuse/Collatz research and theorem authorship: Ta-Yoshua Lubuimi. AI tools are assistants only.


## 11. Exact-head result for PR #69 candidate 1b1a377 — run 42725559211

Both jobs completed with failure. The new candidate did not resolve the prefix recursion:
- line 174: the final rfl tactic is applied after simplification to a goal that is not a reflexive relation;
- line 206: rewriting stageCoordinate hk fails because that expression is not present in the target;
- line 343: the updated-weight identity remains unsolved after unfolding the fibre update;
- line 357: rw [hhk] is redundant because dsimp [xprev] has already closed that local equality.

The audit job prints sorryAx in the error-recovered declarations prefixPointCovered_iff, prefixExtensionEquiv, sum_prefix_eq_sum_extensions, prefixFibre_updatedWeight_eq_PAt, PAt_nonneg, PAt_le_initial_mul_distortionProduct, PAt_succ_le_prev_div_card_mul_one_sub_delta, and PAt_sum_eq_one. The integrated-paranoid job independently reproduces the same core failure. No clean transitive axiom audit is available for those dependent declarations on this head.

This candidate is not accepted as a repair. The successful extendPrefix_restrictPrefix inverse remains a separately verified declaration on this snapshot with profile [propext, Classical.choice, Quot.sound]; it does not certify the failed recursion chain. The next repair should be split into small checkpoints: (i) prove both prefix inverse lemmas without trailing tactic fallbacks, (ii) prove prefixPointCovered_iff by unfolding its actual membership definition without the non-occurring rewrite, (iii) prove the pointwise updated-weight identity independently of the recursive normalization, and only then (iv) rebuild nonnegativity and total-mass results. Do not weaken hypotheses or introduce placeholders.


## Addendum 1.10 — PR #69 retry and exact-head repair, 10 November 2026

### Failed candidate 1b1a377 — workflow 42725559211

The candidate at head 1b1a377d7e3d0a7f4636ee6f941524a96b5dd442 completed with failure in both audit and integrated-paranoid jobs. It cleared the previous omega failure but exposed the following exact issues in BBMSTPrefixMeasureRecursion.lean:

- line 174: the final rfl failed because the lifted-prefix coordinate contains a non-definitional dependent cast;
- line 206: the explicit stageCoordinate rewrite was attempted before unfolding prefixPointCovered/prefixCoveredValues, so the pattern did not yet occur;
- line 357: an additional rewrite was attempted after dsimp had already closed the goal;
- line 343: the updated-weight identity remained unsolved.

Error recovery printed sorryAx in prefixPointCovered_iff, prefixExtensionEquiv, sum_prefix_eq_sum_extensions, prefixFibre_updatedWeight_eq_PAt, PAt_nonneg and downstream PAt inequalities/sums. Those declarations remain unverified on this head. Hyperplane and other upstream modules passing do not change this.

### New targeted retry — head d40e937

A new source commit d40e93763258a6f04978a87d99d1f700b577c2b0 makes four narrow changes:
1. supplies the explicit inequality i.val ≠ k to simplify the Function.update branch in restrictPrefix_extendPrefix and removes the unsuccessful trailing rfl;
2. unfolds prefixPointCovered and prefixCoveredValues before rewriting stageCoordinate in prefixPointCovered_iff;
3. removes the redundant rewrite after dsimp in the dependent restricted-prefix equality;
4. uses simp only with the named covered-membership, stage-coordinate and PAt transport equalities to close the updated-weight identity.

Exact-head workflow 42726230371 was queued for d40e937 at the latest inspection. No success is claimed yet. The retry is accepted only if both audit and integrated-paranoid jobs complete successfully, all downstream modules compile, and the transitive axiom output is free of sorryAx. The mathematical APW4 manuscript status remains unchanged.


## Addendum 1.10 — exact PR #69 and documentation audit status, 10 November 2026

### PR #69 candidate 1b1a377: completed failure

The exact-head workflow 42725559211 completed with failure in both audit and integrated-paranoid jobs. The attempted repair at head 1b1a377d7e3d0a7f4636ee6f941524a96b5dd442 did not resolve prefix recursion. The audit reported: line 174, an rfl tactic applied to a non-equality goal after simplification; line 206, a rewrite for stageCoordinate hk with no matching occurrence; line 343, an unsolved updated-weight identity; and line 357, a redundant rw after dsimp had closed the local equality. Error recovery printed sorryAx in prefixPointCovered_iff, prefixExtensionEquiv, sum_prefix_eq_sum_extensions, prefixFibre_updatedWeight_eq_PAt, PAt_nonneg and downstream PAt inequalities/sum. The integrated-paranoid job reproduced the same issues. This candidate is not verified.

The PR #69 source branch has since advanced to head d40e93763258a6f04978a87d99d1f700b577c2b0. Its current exact-head workflow 42726230371 has both audit and integrated-paranoid jobs in progress at the latest check. No outcome is claimed yet. The new source revision already changes the prefix inverse proof and removes the redundant local rewrite; the non-occurring stageCoordinate rewrite and updated-weight identity still require exact verification. The next report must be bound to d40e937 and run 42726230371, not to the earlier failed head.

### Documentation branch audit

Documentation audit 42725654168 completed successfully, but it checked only the then-current documentation head cc29c10786987d6873a3fc37df0b9fae3602c6ae. The documentation branch has subsequently advanced to 8efcad9d5aba7b457b1adc501201836ead9019e6 with the appended Addenda 1.9 and 1.10 material. Therefore 42725654168 is a valid successful audit of its exact older snapshot, not a verification of the latest documentation head. A new exact-head audit is required.

The APW4 mathematical proof record, DT, HT, global upper energy estimate, strict lower-bound implication and historical definitions remain unchanged. CI failures are confined to the stated Lean integration snapshot. No global theorem or prerequisite is weakened, and no APW4 result is silently downgraded.


## Addendum 1.11 — PR #69 exact-head diagnostic and next candidate, 10 November 2026

Workflow 42726230371 completed with failure on PR #69 source head d40e93763258a6f04978a87d99d1f700b577c2b0. The audit and integrated-paranoid jobs both failed. The new diagnostic is narrower and explicit:
- the inverse lemma restrictPrefix_extendPrefix still has a dependent Fin/cast equality goal after simplification;
- prefixPointCovered_iff still attempts an invalid rewrite across the dependent Finset membership type; the target's membership type is indexed by stageCoordinate hk, while the rewrite motive is ill-typed;
- prefixFibre_updatedWeight_eq_PAt has unresolved implicit A parameters in two prefixCoveredValues occurrences, in addition to the residual updated-weight identity goal;
- error recovery again prints sorryAx in the affected covered predicate, fibre update, nonnegativity and downstream mass inequalities.

A new source candidate has now been committed to PR #69 at exact head 4d5186564006439b48fe95b060a1cfd1c279238a. It removes the non-occurring stageCoordinate rewrite and makes the hyperplane-family parameter A explicit in both covered-value terms. Exact-head workflow 42726991713 was queued for this commit at the latest check. No result is claimed until both audit and integrated-paranoid jobs complete. The inverse lemma remains an independent open proof obligation; no hypotheses have been weakened and no placeholders are accepted.

The mathematical APW4 dossier, DT, HT, upper energy estimate and strict lower-bound implication remain unchanged. The current work is solely Lean integration.


## Addendum 1.11 — separate terminal-residue collision-energy project

A third Syracuse-side theorem project has been separated from the initial all-one cylinder and general finite-word cylinder projects: Lubuimi's Terminal-Residue Collision Energy, standalone project PR #38 in the Lubuimi repository. Its manuscript proves the terminal-residue map
\[
\tau_k(\alpha)=C_k(\alpha)2^{-A(\alpha)}\pmod{3^k},
\]
the exact moment split
\[
E_k=D_k+C_k^{\rm coll},\qquad D_k=3^{-k},
\]
and the forced collision lower bound
\[
C_k^{\rm coll}\ge\frac{1}{2\cdot3^k}.
\]
It also proves explicit finite truncation error bounds and gives a finite rational Markov transition matrix with terminal distribution \(m_k=\delta_0P_k^k\). The exact \(k=2\) distribution is \((8,16,11,4,2,22)/63\), with \(E_2=5/21\).

This is a mathematically distinct Syracuse finite-place second-moment result. It is not the historical APW4 BIB reserve. The APW4 bridge still requires the explicit index-preserving historical event/place map, preservation or domination of historical weights, separate diagonal and off-diagonal transport inequalities, and a proved BIB capacity/Hall condition. The collision-energy manuscript has not yet been Lean-compiled or axiom-audited.

The combined Syracuse research inputs now include: (i) exact finite-word cylinders and tail partitions; (ii) the local state-dependent finite cap on non-descending next valuations; and (iii) terminal-residue collision energy and the Markov representation. These are separate mathematical inputs. None alone establishes the missing APW4 transport or global Collatz descent.

**Attribution:** all APW4 and Syracuse/Collatz research and theorem authorship: Ta-Yoshua Lubuimi. AI tools are assistants only.


## Addendum 1.12 — PR #69 partial repair outcome and next exact head

### Run 42726230371 on d40e937 — both jobs failed

The exact-head retry on d40e93763258a6f04978a87d99d1f700b577c2b0 completed with failure in both audit and integrated-paranoid jobs. It nevertheless made a measurable partial improvement: extendPrefix_restrictPrefix, prefixExtensionEquiv, and sum_prefix_eq_sum_extensions printed only the standard profile [propext, Classical.choice, Quot.sound] in the audit log. These declarations no longer inherit sorryAx on this snapshot.

Remaining exact errors:
- restrictPrefix_extendPrefix still has a dependent-coordinate equality goal in the integrated build (line 171/174);
- prefixPointCovered_iff still fails because the rewrite motive is not type-correct after unfolding the filtered set; error recovery prints sorryAx;
- prefixFibre_updatedWeight_eq_PAt still has an unsolved equality goal at line 344;
- explicit A arguments were not yet supplied consistently in the covered-membership expressions;
- PAt_nonneg and downstream PAt inequalities/sum declarations still inherit sorryAx from the failed updated-weight/covered chain.

The audit job reports the rewrite-motive error in prefixPointCovered_iff, missing implicit A in the covered-membership proof, and the unsolved updated-weight identity. The integrated-paranoid job independently reports the dependent cast in restrictPrefix_extendPrefix and the same membership/updated-weight chain. The full error log is retained in workflow 42726230371.

### New candidate head 4d518656

Commit 4d5186564006439b48fe95b060a1cfd1c279238a removes the premature coordinate rewrite in prefixPointCovered_iff and makes the implicit family A explicit in both sides of hcovered. Exact-head workflow 42726991713 was queued at the latest inspection. No success is claimed yet. The next acceptance condition remains both audit and integrated-paranoid success, clean downstream transitive axiom profiles, and no sorryAx.


## Addendum 1.12 — latest exact-head workflows queued, 10 November 2026

- PR #69 source head `4d5186564006439b48fe95b060a1cfd1c279238a` has exact-head workflow [42726991713](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42726991713). At the latest status check both `audit` and `integrated-paranoid` jobs were still queued. No compile or kernel-verification result is claimed for this candidate.
- Documentation PR #79 head `f1a48b7353961177e1b6e3f34b074ac78155e424` has workflow [42727094672](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42727094672), also queued at the latest check. Earlier successful docs workflow 42725654168 remains tied only to its older head, not this current head.

This status supersedes any implication that the latest candidate has already completed. APW4 mathematical statements and manuscript results remain untouched; these are pending CI checks of source/documentation snapshots only.


## Addendum 1.13 — documentation head advanced after queued audit

The documentation branch advanced after workflow 42727094672 was queued. That workflow was triggered for the then-current documentation head `f1a48b7353961177e1b6e3f34b074ac78155e424`; the latest PR #79 head is now `579bf0b23aef2909d860abd1e0ff4c970fc433ab` after Addendum 1.12 and the PR-body chronology correction. A commit-specific workflow lookup for `579bf0b23aef2909d860abd1e0ff4c970fc433ab` returned no run at the latest check. Therefore 42727094672 is not evidence for the latest documentation head; a new exact-head run is still required.

PR #69 workflow 42726991713 has progressed since the prior check: `integrated-paranoid` is now in progress and `audit` remains queued. No outcome is claimed until both finish on exact head `4d5186564006439b48fe95b060a1cfd1c279238a`.


## Addendum 1.13 — finite-branching Syracuse cap as a bridge input

The finite-word manuscript now states the local margin result in an exact necessary-cap form. For a prefix with total exponent \(A\), margin \(D\), and next valuation \(b\),
\[
D'=3D+(2^b-4)2^A.
\]
If the next odd iterate has not descended below the initial odd start, then \(D'\le0\) is necessary, so
\[
2^{A+b}+3D\le4\cdot2^A.
\]
Only finitely many positive \(b\) satisfy this for each fixed prefix. A least hypothetical nonterminating start would therefore determine an infinite path in a state-dependent finitely branching tree. Every larger next valuation lies in the exact tail cylinder and forces strict descent.

This is a new local arithmetic reduction and a candidate input to the APW4 incidence/energy programme. It does not provide a uniform branching bound or exclude an infinite path. It is not Lean-compiled yet. The APW4 historical transport, diagonal/off-diagonal inequalities, and BIB/Hall capacity remain separate open obligations.


## Addendum 1.14 — completed run 42726991713 and new exact-head repair

PR #69 run 42726991713 completed with failure in both audit and integrated-paranoid jobs on exact head 4d5186564006439b48fe95b060a1cfd1c279238a. The audit job reached and compiled the upstream source, focused degenerate-witness tests, zero-safe fibre/update chain, uniform-coordinate instantiation, finite-stage moments, finite-coordinate geometry, and uniform-stage source moment; it then failed in the source-indexed prefix recursion. Downstream prefix cylinder, moment bridge, hyperplane incidence, old-shadow, finite union and moment-recurrence steps were skipped because the prefix module failed.

The integrated-paranoid job reports:
- BBMSTPrefixMeasureRecursion.lean:171:55 — unresolved nested dependent-coordinate casts in restrictPrefix_extendPrefix;
- line 207 — membership type mismatch between C.S (prefixIndex hk (Fin.last k)) and Finset (C.S (stageCoordinate hk)) in prefixPointCovered_iff;
- line 342:45 — unresolved equality in prefixFibre_updatedWeight_eq_PAt.

The audit log confirms sorryAx in prefixPointCovered_iff, prefixExtensionEquiv, sum_prefix_eq_sum_extensions, prefixFibre_updatedWeight_eq_PAt, PAt_nonneg and downstream PAt inequalities/sums. The independent declaration extendPrefix_restrictPrefix and the prefix-extension sum identity print only [propext, Classical.choice, Quot.sound] on this snapshot. This is partial proof progress, not an integrated success.

A new source candidate is at head 8e7cd3ca5b3440ee25eb6241f2aa799103b56830. It adds explicit Fin-index equalities to the restriction proof, unfolds stageCoordinate in the covered-predicate reduction, and splits the covered/uncovered cases using the named membership equivalence. Two duplicate exact-head workflows, 42728164530 and 42728171781, were queued on this same commit. No pass is claimed pending both audit and integrated-paranoid completion and a clean transitive axiom audit.

The current documentation branch itself is at head fc9625629cabed0a5f009023e4626dc77a641dae, with exact-head documentation audit 42727462725 queued. Earlier successful documentation audits checked older heads only.


## Addendum 1.15 — dual-toolchain result on PR #69 head 8e7cd3

The duplicate exact-head workflows 42728164530 and 42728171781 checked the same PR merge commit 65febae (head 8e7cd3ca5b3440ee25eb6241f2aa799103b56830), but their two jobs use different Lean toolchains by design:

- The audit job uses the repository-root toolchain Lean 4.28.0 and root Mathlib v4.28.0. In run 42728171781 it completed successfully, compiled BBMSTPrefixMeasureRecursion.lean, printed standard profiles [propext, Classical.choice, Quot.sound] for prefixPointCovered_iff, prefixFibre_updatedWeight_eq_PAt and PAt_nonneg, and had no actual sorryAx occurrence in that audit log.
- The integrated-paranoid job uses kernel-audit/lean-toolchain Lean 4.35.0 and Mathlib v4.35.0. In both runs 42728164530 and 42728171781 it failed on the same merge commit. This is the target integration toolchain and remains the release blocker.

The two results are not contradictory: the source module compiles under the legacy 4.28 audit environment, but the integrated 4.35.0 environment exposes dependent-type failures. The 4.28 audit pass must not be reported as a 4.35.0 integration pass.

The 4.35.0 integrated job reports:
- line 171: unresolved nested dependent-coordinate casts in restrictPrefix_extendPrefix;
- line 220: rcases cannot destruct the remaining Quot.lift membership term in prefixPointCovered_iff;
- line 223: the resulting constructor notation is invalid for that non-inductive target;
- lines 396 and 398: the covered and uncovered branches of prefixFibre_updatedWeight_eq_PAt remain unsolved; the uncovered branch retains an unnecessary Finset.univ conditional.

Error recovery prints sorryAx in prefixPointCovered_iff, prefixExtensionEquiv, sum_prefix_eq_sum_extensions, prefixFibre_updatedWeight_eq_PAt, PAt_nonneg and downstream PAt inequalities/sums in the 4.35.0 integrated log. These declarations are not verified for the target toolchain on this commit.

**Next repair sequence:** (1) replace the opaque rcases path with an explicit Finset membership normalization (including the exact filter/set representation) before destructuring the existential; (2) prove the prefix-coordinate cast identity with named Fin.ext lemmas rather than relying on broad simp; (3) simplify the uncovered branch explicitly using Finset.mem_univ; (4) rerun both toolchains and require the 4.35.0 integrated-paranoid build and axiom audit to pass on one exact commit. The legacy 4.28 audit remains useful compatibility evidence but cannot substitute for the 4.35.0 result.


## Addendum 1.16 — Lean-verified Syracuse cap core

The Syracuse programme now has a genuine Lean-verified finite non-descent cap core. Workflow 42728049650 passed on exact source commit ca48ec7fdad5e8d6f8aeb82fed8586a1b57c12bc using Lean 4.34.1. The declarations signedOffsetMargin_nonpos_succ_iff_exponent_cap, signedOffsetMargin_nonpos_of_nondecreasing_orbit, and nondecreasing_orbit_next_exponent_cap each printed [propext, Classical.choice, Quot.sound]; the complete job log contained no actual sorryAx occurrence and the build completed 8,930 jobs.

This proves in Lean the exact margin equivalence and the necessary next-exponent cap for a nondecreasing exact affine endpoint. It does not yet formalize the maximum cap B_alpha, the exact tail-cylinder partition, or the general finite-word cylinder theorem. The Syracuse cap's Lean 4.34.1 verification is separate from the APW4 integrated Lean 4.35.0 audit. The APW4 historical index-preserving transport, diagonal/off-diagonal bounds, and BIB/Hall capacity remain open.


## 10 November 2026 — historical event-to-BIB reconstruction ledger

See publication/APW4_HISTORICAL_EVENT_BIB_RECONSTRUCTION_LEDGER_2026-11-10.md for the append-only definition-completeness matrix and the exact event-to-BIB proof obligations. The ledger preserves the identities A_q W_{q,r} A_r^T = sum_{t mod D_{q,r}} a_{q,t} a_{r,t}^T and sum_h M_{q,r}(h,g) <= Gamma_{q,r}(g), while requiring all source index spaces, entries, suppressed indices, elementary events, the original map (x,u) -> (k,I_{x,u},J_{x,u}), BIB slots/capacities, pointwise incidence, weight preservation and weighted Hall inequality to be explicit before formal transfer. It does not replace historical definitions by canonical model fibres.

The latest exact PR #69 workflow 42739454140 failed on source head 17eb308d106c770ab559d254bcee2bdfd2ead6c4. The two branches of prefixFibre_updatedWeight_eq_PAt expose a cross-toolchain tactic sequencing issue: simp closes the branch under Lean 4.28, making a following ring invalid; Lean 4.35 leaves algebraic residue that ring does not close and recommends ring_nf. Error-recovered sorryAx in PAt_nonneg/PAt_sum_eq_one is downstream. No integrated pass is claimed on this head. The proposed simp ... <;> ring_nf sequencing is a next experiment, not yet a verified repair.

This technical failure does not alter the separately recorded APW4 mathematical status under its historical hypotheses or earlier successful declaration-scoped audits. The event-to-BIB transport and source reconstruction remain explicit open obligations.
