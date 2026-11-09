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
