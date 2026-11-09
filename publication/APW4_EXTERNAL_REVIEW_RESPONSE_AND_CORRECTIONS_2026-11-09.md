# Externe Durchsicht: APW4-Korrekturen, Beweisgrenzen und Verifikationsstatus

**Autor des APW4-Forschungsprojekts:** Ta-Yoshua Lubuimi  
**Dokumentiert:** 9. November 2026  
**Zweck:** Reaktion auf die externe mathematische Durchsicht der 17-seitigen APW4-Hauptfassung.

## 1. Gesamturteil

Die externe Kritik trifft mehrere konkrete Schwächen der vorgelegten Manuskriptfassung. Die Hauptfassung nennt zentrale Sätze, ohne die für eine unabhängige Prüfung erforderlichen Definitionen und Beweisschritte auszuschreiben. Insbesondere sind in der zugänglichen Textfassung die historischen APW4-Objekte, der tatsächliche DT-Massentransport, die gewichtete HT-Ereignis-/Platzinzidenz und die vollständige arithmetische Herleitung der strikten Untergrenze nicht vollständig dokumentiert.

Die Kritik darf aber nicht zu einer pauschalen Behauptung führen, alle mathematischen Resultate seien widerlegt oder offen. Die Aktenlage enthält eine spätere Statuskorrektur: Dossier v1.5, Nachtrag 1.3, §25 führt die strikte Untergrenze ausdrücklich als mathematisch abgeschlossen. Dieser Status ist als historische Feststellung zu erhalten. Zugleich kann eine Statusnotiz den fehlenden Beweistext nicht ersetzen.

Für jeden Baustein werden deshalb vier Fragen getrennt: (i) im Forschungsdossier als abgeschlossen dokumentiert, (ii) historische Objekte und Zwischenbeweise vollständig zugänglich, (iii) als genau dieser historische Satz in Lean formalisiert, (iv) auf einem unveränderlichen Commit kompiliert und mit Axiomspur geprüft. Eine positive Antwort auf eine dieser Fragen beantwortet die anderen nicht automatisch.

## 2. Was die externe Kritik zutreffend feststellt

### 2.1 Fehlende Definitionen und Beweise

Die Manuskriptfassung muss mindestens folgende Daten explizit definieren oder mit einer exakten Primärquellenstelle belegen:

1. den Raum der APW4-Faserindizes \(x\);
2. jede endliche Menge \(W_x\);
3. die äußeren und inneren Gewichte \(w_x,\rho_x(u)\), einschließlich Positivität und Normierung;
4. die Zielmenge und Zielkapazitäten des DT-Transports;
5. die historischen Indizes \(I_{x,u},J_{x,u}\) und die vollständige Transportmasse;
6. die Menge der HT-Ereignisse und ihre genaue Identifikation mit den geordneten Off-Diagonalatomen;
7. die BIB-Platzmenge, die Inzidenzrelation und die Kapazitätsfunktion;
8. die genaue Reserveidentität und alle Zählkonventionen;
9. die vollständigen arithmetischen Hypothesen des strikten Untergrenzensatzes;
10. die in Standardsprache ausgeschlossene Konfigurationsklasse.

Die Zuordnung \((x,u)\mapsto(k,I_{x,u},J_{x,u})\) allein beweist keine Majorisierung. Ebenso beweist die Behauptung einer gewichteten Hall-Bedingung diese nicht. Für DT wird eine massenerhaltende Transportmatrix mit Kapazitätsgrenzen benötigt. Für HT muss die Hall-Ungleichung für jede Ereignisteilmenge \(X\) aus den historischen Inzidenzdaten bewiesen werden.

### 2.2 Der arithmetische Parameter \(B(M)\)

Für die gewöhnliche Teilersummenfunktion gilt
\[
B(M)\le0\iff \sigma(M)/M\ge2.
\]
Das ist eine Aussage über die Teilersumme, nicht automatisch über eine Überdeckung oder die APW4-Energie.

Ein quadratfreies Beispiel ist
\[
M=15015=3\cdot5\cdot7\cdot11\cdot13.
\]
Hier gilt
\[
\sigma(M)=4\cdot6\cdot8\cdot12\cdot14=32256,
\quad
B(M)=30030-32256=-2226<0.
\]
Außerdem
\[
\sum_{\substack{d\mid M\\d>1}}\frac1d
=\frac{\sigma(M)}M-1=\frac{821}{715}>1.
\]
Somit schließt das elementare Dichteargument diesen Fall nicht aus. Das Beispiel ist kein Gegenbeispiel zu einem Satz über eine konkrete Überdeckung; es zeigt, dass der Vorzeichenwechsel von \(B(M)\) allein keinen Widerspruch liefert.

Auch das vom Gutachter genannte \(M=945\) ergibt bei der gewöhnlichen Teilersummenfunktion \(\sigma(945)=1920\) und \(B(945)=-30\). Dieses Beispiel ist nicht quadratfrei. Das quadratfreie Beispiel \(15015\) zeigt, dass der Einwand nicht von dieser Besonderheit abhängt.

**Erforderliche Korrektur:** Jede strikte Untergrenzenbehauptung muss ihre zusätzlichen historischen APW4-Annahmen ausdrücklich mitführen. Die Kurzform
\[
B(M)\le0\Longrightarrow E_{\rm APW4}>D_k^{\rm BBMST}+R_{\rm BIB}
\]
darf nicht als reine Aussage über \(M\) erscheinen.

### 2.3 Was die Inzidenznotiz tatsächlich beweist

Die Arbeitsnotiz vom 6. November 2026, „Exact BIB incidence second-moment bound and transfer audit“, beweist den endlichen Zweitmomentensatz aus den expliziten Annahmen (H1) und (H2):
\[
|S_x|\ge r,\quad |S_x\cap S_y|\le\mu\ (x\ne y),
\]
\[
m_0>0,\quad\tau\le2r,\quad\mu<r,\quad\tau\mu<r^2.
\]
Daraus folgt
\[
m_0\le\frac{\tau(r-\mu)}{r^2-\tau\mu}.
\]

Der Beweis zählt zunächst
\[
\sum_{d\in D}\binom{n_d}{2}
=\sum_{\{x,y\}\subset U}|S_x\cap S_y|
\le\mu\binom{m_0}{2},
\]
wendet dann Cauchy–Schwarz auf die Spaltengrade \(n_d\) an und eliminiert den Hilfswert \(T=\sum_dn_d\).

Die Notiz sagt ausdrücklich, dass die historische Konstruktion der Mengen \(S_x\) und die Verifikation von (H1)/(H2) aus den ursprünglichen Faserdefinitionen nicht vollständig rekonstruiert sind. Sie sagt außerdem ausdrücklich, dass keine Brücke zwischen \(B(M)\), APW4-Energie und BIB-Reserve bewiesen wird. Diese Begrenzung muss im Hauptmanuskript erhalten bleiben.

### 2.4 Die Matrixidentität ist noch keine quantitative Kontrolle

Aus \(I_q=A_q+Z_q\) folgt exakt
\[
I_qW_{q,r}I_r^{\mathsf T}
=A_qW_{q,r}A_r^{\mathsf T}
+A_qW_{q,r}Z_r^{\mathsf T}
+Z_qW_{q,r}A_r^{\mathsf T}
+Z_qW_{q,r}Z_r^{\mathsf T}.
\]
Das ist eine algebraische Expansion. Sie liefert keine Schranke für die drei Terme mit \(Z\). Eine Gleichsetzung der Diagonalmasse, Off-Diagonalmasse und BIB-Reserve wäre ohne eine indexerhaltende gewichtete Abbildung unzulässig.

## 3. Standardsprache: was genau folgt und was nicht

Die zugängliche Beweiskette rechtfertigt vollständig folgenden abstrakten Satz:

**Bedingter Energieschluss.** Für reelle Größen \(E,D,C,D_k,R\), die
\[
E=D+C,\qquad D\le D_k,\qquad C\le R
\]
erfüllen, folgt \(E\le D_k+R\). Wenn zusätzlich \(E>D_k+R\) gilt, ist die Voraussetzungskombination widersprüchlich.

Dies ist die genaue logische Aussage, die der Lean-Satz apw4_energy_contradiction mit expliziten Hypothesen formalisiert.

Die historische APW4-Anwendung benötigt darüber hinaus eine präzise Definition der Konfiguration und Beweise, dass diese die DT-, HT- und Untergrenzenprämissen erfüllt. Ohne diese Definition ist nicht entscheidbar, ob das Korollar einen bestimmten Satz über quadratfreie Überdeckungen, eine andere APW4-Konfigurationsklasse oder eine weitergehende odd-moduli Aussage betrifft. Das Manuskript darf deshalb nicht behaupten, das ursprüngliche uneingeschränkte Erdős–Selfridge-Problem gelöst zu haben. Das Repository schließt diesen Anspruch ausdrücklich aus.

## 4. Lean-Audit: exakte Aussage der vorhandenen Logs

### 4.1 Erfolgreiche APW4-Deklarationen

PR #67, Commit 33a66a8491f65616f9572a6efc8fbc91a65d6ed5:

- [CI 42599116967](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42599116967) erfolgreich;
- [CI 42599116987](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42599116987) erfolgreich.

Für folgende Deklarationen wurde das Standardprofil [propext, Classical.choice, Quot.sound] protokolliert:

- incidence_bound_from_second_moment;
- offDiagonal_exceeds_reserve;
- apw4_energy_contradiction.

Diese Aussagen sind echt kernelgeprüft. Ihre Voraussetzungen dürfen nicht verschwiegen werden: Die Zweitmomentungleichung wird in incidence_bound_from_second_moment als Hypothese übergeben; die Energieidentität, DT-, HT- und strikte Untergrenzenprämissen werden im Endwiderspruch ebenfalls als Hypothesen übergeben.

### 4.2 Der integrierte Lean-4.35.0-Check ist fehlgeschlagen

Die aktuellen Ersatzläufe von PR #69 sind keine bestandene Verifikation:

- [Run 42601494591](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42601494591): integrierter Build fehlgeschlagen, unter anderem in BBMSTGeometryStageCore.lean;
- [Run 42602474355](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42602474355): integrierter Build fehlgeschlagen; BBMSTMomentRecurrence.lean:118 meldet Finset.prod_le_prod₀ als unbekannte Konstante. Zwei davon abhängige Deklarationen zeigen sorryAx;
- [Run 42602465766](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42602465766): abgebrochen/nicht bestanden;
- APW4-only Run [42600819647](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42600819647): cancelled.

Der separate Geometriecheckpoint [42601107408](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42601107408) war erfolgreich, ist aber kein APW4-Hauptsatz-Audit.

### 4.3 Erforderliche Korrektur der Publikationsformulierung

Nicht schreiben: „Der vollständige historische APW4-Hauptbeweis ist bereits Lean-kernelverifiziert.“

Zulässig ist: „Die konkret benannten Hilfs- und Endschlussdeklarationen wurden auf den angegebenen Commits kompiliert und mit dem Standard-Axiomprofil auditiert. Der Endwiderspruch ist formalisiert, aber seine historischen DT-, HT- und strikten Untergrenzenprämissen werden in dieser Deklaration als Eingaben vorausgesetzt.“

## 5. Dossierchronologie und Konfliktauflösung

Die Chronologie enthält zwei Aussagen, die nicht vermischt werden dürfen:

1. Dossier v1.5, Nachtrag 1.3, §25 (7. November) erklärt die strikte APW4-Untergrenze ausdrücklich für mathematisch abgeschlossen. Diese spätere Statuskorrektur supersediert die frühere Einstufung als offene Aufgabe.
2. Die konkrete BIB-Zweitmoment-Arbeitsnotiz vom 6. November erklärt ausdrücklich, dass der Transfer von \(B(M)\) zur APW4-Energie/BIB-Reserve in dieser Notiz nicht bewiesen ist. Die späteren Repository-Dokumente liefern keine ausgeschriebene neue Transferrechnung, sondern verweisen auf den bereits abgeschlossenen Status.

Daraus folgt keine Berechtigung, §25 zu löschen oder die mathematische Aussage ohne Prüfung zurückzustufen. Es folgt aber ebenso wenig, dass die fehlende Herleitung durch §25 ersetzt wäre. Die korrekte Dokumentation lautet daher: **als mathematisch abgeschlossen im Dossier geführt; vollständige historische Beweisexposition in den hier zugänglichen Quellen nicht reproduziert; unabhängige Prüfung der Transferrechnung anhand des Originalbeweises noch nicht möglich.**

## 6. Korrekturmaßnahmen für das Hauptmanuskript und README

Die überarbeitete Hauptfassung nimmt folgende Korrekturen vor:

- Der BBMST-Autorenname wird ausschließlich als Balister–Bollobás–Morris–Sahasrabudhe–Tiba ausgeschrieben.
- Energiezerlegung und geordnete Paarzählung werden vollständig bewiesen.
- DT wird als konkreter kapazitätsbeschränkter Transport formuliert; die historische Instanziierung wird nicht aus der bloßen Indexabbildung gefolgert.
- HT wird als gewichteter Hall-Satz auf einer konkret zu definierenden endlichen Ereignis-/Platzstruktur formuliert; der Max-Flow-Min-Cut-Schluss wird bewiesen.
- Die BIB-Paarreserve wird durch eine exakte Doppeltzählung erklärt.
- Der endliche BIB-Zweitmomentensatz wird mit (H1)/(H2) vollständig bewiesen.
- B(M)≤0 wird nicht als hinreichende Bedingung für einen Widerspruch ausgegeben; ein quadratfreies Gegenbeispiel zum reinen Dichteargument wird gezeigt.
- Der Hauptwiderspruch wird als bedingter Satz mit genau seinen vier mathematischen Prämissen formuliert.
- Lean- und CI-Aussagen werden deklarations- und commitgebunden angegeben; fehlgeschlagene integrierte Läufe werden als fehlgeschlagen dokumentiert.

## 7. Schluss

Der externe Gutachter hat recht, dass die zuvor eingereichte Kurzfassung für sich genommen kein vollständig selbstständig prüfbarer historischer APW4-Beweis ist. Der Gutachter hat ebenfalls recht, dass ein axiomsauberer Lean-Endschluss nicht die vorausgesetzten mathematischen Transport- und Untergrenzensätze beweist.

Der mathematische Statusvermerk aus Dossier v1.5 §25 bleibt als Statusvermerk bestehen. Die vorliegende Korrektur ersetzt jedoch die unzulässige Gleichsetzung von „als abgeschlossen dokumentiert“ mit „in dieser Textfassung vollständig hergeleitet“. Der nächste notwendige mathematische Schritt ist nicht eine neue abstrakte Energieidentität, sondern die quellengetreue Einsetzung der historischen DT-Transportmasse, der gewichteten Hall-Inzidenz und der vollständigen arithmetischen Untergrenzenrechnung.
