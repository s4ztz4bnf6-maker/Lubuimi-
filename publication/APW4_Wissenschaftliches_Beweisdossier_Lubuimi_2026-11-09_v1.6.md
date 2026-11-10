# APW4 / BBMST / BIB
**Wissenschaftliches Beweisdossier v1.6 – konsolidierte Fassung vom 9. November 2026**
## Beweisstand, Quellenrekonstruktion und unabhängiger Formalisierungs-Audit
**Stichtag: 9. November 2026**

### Zweck und Statusdisziplin

Dieses Dossier konsolidiert den globalen APW4-Energieschluss und trennt ihn strikt von der noch nicht abgeschlossenen Lean-Formalisation sowie vom separaten Erdős–Selfridge-Siebbeweis. Es verlangt keine lokale Lean-Kompilierung durch den Nutzer.

**Statuskennzeichnungen**

- **MATHEMATISCHER AUSGANGSPUNKT:** DT, HT und der globale APW4-Energiesatz werden entsprechend dem ausdrücklich festgehaltenen späteren Arbeitsstand als hergeleitete mathematische Resultate behandelt.
- **REPOSITORY-/CI-BEFUND:** Nur Aussagen, die durch konkrete Dateien, Commits oder Actions-Läufe belegt sind.
- **NICHT VERIFIZIERT:** Eine historische Identifikation oder ein formaler Nachweis, der in den eingesehenen Artefakten nicht vorliegt.
- **GETRENNTER OFFENER STRANG:** Eine andere Beweisverpflichtung, die nicht aus dem APW4-Energiesatz folgt.

Das Fehlen eines Beweises in einem bestimmten Repository-Stand ist kein mathematischer Gegenbeweis und setzt einen später hergeleiteten Satz nicht zurück.

---

# I. Globaler APW4-Energiesatz

## 1. Satz

Für die APW4-Energie gilt

\[
\boxed{\mathcal E_{\mathrm{APW4}}
\leq D_k^{\mathrm{BBMST}}+\mathcal R_{\mathrm{BIB}}.}
\]

Dabei werden DT und HT als die bereits hergeleiteten mathematischen Bausteine des Arbeitsstands eingesetzt.

Die Energie ist

\[
\mathcal E_{\mathrm{APW4}}
=\sum_x w_x\left(\sum_{u\in W_x}\rho_x(u)\right)^2.
\]

Durch Ausmultiplizieren erhält man die exakte Zerlegung

\[
\mathcal E_{\mathrm{APW4}}
=D_{\mathrm{APW4}}+C_{\mathrm{APW4}},
\]

wobei

\[
D_{\mathrm{APW4}}
=\sum_xw_x\sum_{u\in W_x}\rho_x(u)^2
\]

und

\[
C_{\mathrm{APW4}}
=\sum_xw_x
\sum_{\substack{u,v\in W_x\\u\ne v}}
\rho_x(u)\rho_x(v).
\]

Die zweite Summe zählt geordnete Off-Diagonal-Paare. Daher entsteht bei dieser Zerlegung kein zusätzlicher Faktor \(2\).

## 2. Diagonaltransport DT

Der etablierte Diagonaltransportsatz lautet

\[
\boxed{D_{\mathrm{APW4}}\leq D_k^{\mathrm{BBMST}}.}
\]

Die historische Zuordnung wird durch

\[
(x,u)\longmapsto(k,I_{x,u},J_{x,u})
\]

bezeichnet. Der mathematische Inhalt ist die aggregierte Gewichtserhaltung unter dieser Zuordnung. Eine zusätzliche punktweise Dominanz wird für den globalen Schluss nicht benötigt.

Die im Arbeitsstand verwendete BBMST-Zielgröße ist

\[
D_k^{\mathrm{BBMST}}
=
\frac{1}{|S_k|^2}
\sum_{F\in\mathcal N_k}
c(F\cap[a])
\prod_{j\in F\cap[a+1,k-1]}
\frac{1}{(1-\delta_j)|S_j|}.
\]

Die historische Bedeutung sämtlicher Symbole muss im endgültigen Manuskript mit den Definitionen des zugrunde liegenden BBMST-Modells übereinstimmen. Diese Formel wird hier nicht durch neue Definitionen ersetzt.

## 3. Off-Diagonaltransport HT

Für ein Off-Diagonal-Ereignis \(\gamma=(\ell,\ell')\) sei seine Nachfrage

\[
d(\gamma)=\omega_\ell\omega_{\ell'}.
\]

Die bereits hergeleitete gewichtete Hall-Bedingung lautet für jede Teilmenge \(X\) der Off-Diagonal-Ereignisse

\[
\boxed{
\sum_{\gamma\in X}d(\gamma)
\leq
\sum_{b\in\Gamma_{\mathrm{BIB}}(X)}
c_{\mathrm{BIB}}(b).
}
\]

Hier bezeichnet \(b\) einen tatsächlichen BIB-Platz, \(\gamma\sim b\) die historische Inzidenz und \(c_{\mathrm{BIB}}(b)\) dessen Kapazität.

Da die Ereignis- und Platzmengen endlich sind, liefert der gewichtete Max-Flow-Min-Cut-Satz einen nichtnegativen Transport \(\theta_{\gamma b}\) mit

\[
\sum_{b:\gamma\sim b}\theta_{\gamma b}=d(\gamma)
\]

und

\[
\sum_{\gamma:\gamma\sim b}\theta_{\gamma b}
\leq c_{\mathrm{BIB}}(b).
\]

Summieren über alle Ereignisse und anschließend über alle BIB-Plätze ergibt

\[
C_{\mathrm{APW4}}
=\sum_\gamma d(\gamma)
\leq\sum_b c_{\mathrm{BIB}}(b)
=\mathcal R_{\mathrm{BIB}}.
\]

Die BIB-Kollisionsreserve besitzt die überlieferte Identität

\[
\mathcal R_{\mathrm{BIB}}
=\sum_\ell c_\ell(c_\ell-1)
=\sum_{u\ne v}|S_u\cap S_v|.
\]

## 4. Schluss

Aus der exakten Energiezerlegung und den beiden etablierten Transportaussagen folgt unmittelbar

\[
\begin{aligned}
\mathcal E_{\mathrm{APW4}}
&=D_{\mathrm{APW4}}+C_{\mathrm{APW4}}\\
&\leq D_k^{\mathrm{BBMST}}+\mathcal R_{\mathrm{BIB}}.
\end{aligned}
\]

Damit ist der globale APW4-Energieschluss auf der mathematischen Ebene geschlossen, sofern DT und HT in ihrer bereits hergeleiteten historischen Bedeutung eingesetzt werden. Dieser Schluss ist keine Behauptung, dass die derzeit sichtbaren Lean-Dateien bereits genau diese historische Instanziierung formalisieren.

---

# II. Unabhängiger Lean- und CI-Audit

## 5. APW4-Kernmodule: was tatsächlich formal geprüft wurde

Repository: `s4ztz4bnf6-maker/Lubuimi-`

Branch: `audit/apw4-diagonal-majorization-2026-11-04`

Commit: `64f38063ef179b3ea9aa0891b5fc04a4b0d7eb97`

Erfolgreiche Actions-Läufe:

- `41895530029` – kanonische APW4-Majorization
- `41895530064` – kombinierter Lean-Audit

Die Actions-Ausgaben melden für folgende kanonische Sätze ausschließlich

`[propext, Classical.choice, Quot.sound]`:

- `APW4CanonicalMajorization.local_profile_mass_identity`
- `APW4CanonicalMajorization.local_profile_mass_le_one`
- `APW4CanonicalMajorization.global_bib_majorization`
- `APW4CanonicalMajorization.bib_collision_identity`

Für den tatsächlichen CRT-Kern wurden ebenfalls mit diesem Standardprofil ausgegeben:

- `APW4HistoricalCRT.mem_congruenceSet_iff`
- `APW4HistoricalCRT.mem_supportAt_iff`
- `APW4HistoricalCRT.historical_bib_collision_identity`

Das ist ein echter positiver Kernel-/CI-Befund für genau diese deklarierten Sätze.

## 6. Formale Reichweite und Grenze

Die PR-Beschreibung von PR #53 sagt ausdrücklich, dass die kanonische Majorization nicht behauptet, die historische APW4-Konstruktion erfülle bereits die verwendeten Normalisierungs- und Kopplungshypothesen.

Konkret:

- `global_bib_majorization` ist ein Satz über das kanonische endliche Faser-/Profilmodell.
- `diagonal_majorization` in `APW4DiagonalAudit.lean` setzt `hCoupling`, `hMass` und `hGeom` voraus.
- `APW4HistoricalCRTCore.lean` formalisiert reale Kongruenzmengen in `ZMod N` und die geordnete BIB-Kollisionsidentität.
- Die vollständige historische Identifikation der APW-Atome, DT-Indizes und HT-Inzidenz wird durch diese drei Module nicht automatisch bewiesen.

**Audit-Urteil:** Die geprüften Module bestehen ihren eigenen Axiom-Audit. Sie sind aber kein vollständiger Lean-Beweis des historischen globalen APW4-Energiesatzes. Diese präzise Abgrenzung ist keine Herabstufung des mathematischen DT-/HT-Arbeitsstands.

---

# III. Separater Erdős–Selfridge-Siebstrang

## 7. Zwei Projekt-Axiome

Der Lean-Hauptsatz `erdos_selfridge` im separaten Erdős–Selfridge-Projekt hängt laut CI-Ausgabe weiterhin von

- `sf_sieve_lt_one`
- `sieve_criterion`

ab. Die protokollierte Axiomliste lautet

`[propext, sf_sieve_lt_one, sieve_criterion, Classical.choice, Quot.sound]`.

Das ist von APW4-DT/HT und dem globalen APW4-Energiesatz zu unterscheiden. Ein APW4-Energiesatz beseitigt diese beiden Axiome nicht automatisch.

## 8. Bereits reproduzierter Defekt der Axiomschnittstelle

Der Audit-Zweig hat einen konkreten degenerierten Parameterfall nachgewiesen:

- leere Parameterliste \(\delta_s=[]\),
- \(ca_1=ca_3=1\),
- der Fallback `getD` liefert für fehlende Parameter \(0\),
- der zweite Momentterm trifft auf einen Nenner \(4\delta(1-\delta)=0\),
- Lean verwendet die totalisierte rationale Division,
- die implementierte Siebsumme wird dadurch \(0<1\).

Damit akzeptiert die aktuelle Axiomsignatur `sieve_criterion` einen formal degenerierten Fall. Die CI-Ausgabe zeigt für `degenerate_actual_sieveSum_lt_one` nur das Standardaxiom-Trio, für `degenerate_axiom_acceptance` dagegen zusätzlich `sieve_criterion`.

Das ist ein Spezifikationsdefekt der aktuellen Axiomschnittstelle, kein Gegenbeispiel zum mathematischen Erdős–Selfridge-Satz.

Eine bloße Ergänzung von \(ca_1\leq ca_3\) oder \(0\leq ca_3-2ca_1+1\) beseitigt den Zeugen nicht: \(ca_1=ca_3=1\) erfüllt beides weiterhin.

Die Reparatur muss die Datenstruktur und Theoremsignaturen absichern:

1. Stufenparameter müssen exakt zu den Stufen passen, vorzugsweise durch längenindizierte Vektoren.
2. Für jeden verwendeten Parameter muss die erforderliche strikte Positivität des Nenners bewiesen sein.
3. Der \(\delta=0\)-Fall muss über den ersten Momentterm behandelt werden, nicht durch Division durch null.
4. Die stärkere zweite Momentenschranke darf nur unter ihrer geometrischen Zusatzvoraussetzung verwendet werden.
5. Die Existenzbehauptung für die Parameter muss dieselbe Stufenlänge und dieselben Positivitätsbedingungen garantieren.
6. Erst danach dürfen `sieve_criterion` und `sf_sieve_lt_one` durch echte Theoreme ersetzt werden.

Die vorhandenen Notizen `SAFE_SIEVE_REPAIR_PLAN.md` und `BBMST_ProofObligations.md` dokumentieren diese Richtung. Sie sind Spezifikations- und Arbeitsnotizen, keine bereits ausgeführte Reparatur.

---

# IV. BBMST-Geometrie-CI vom 6. November

## 9. Neuester beobachteter Lauf

Commit: `e90aa262b07de149d82b98855e065156493ae446`

Branch: `audit/bbmst-geometry-core-2026-11-05`

Run: `42264982566`

Der Lauf scheitert in `BBMSTGeometryStageCore.lean`. Die protokollierten Fehler betreffen unter anderem:

- einen abhängigen Typfehler beim Umschreiben von `H.assignment`,
- einen nachfolgenden „No goals to be solved“-Fehler,
- eine nicht ausführbare `DecidableEq`-Instanz in der Definition von `newAtStage`.

Wegen des fehlgeschlagenen Beweisschritts meldet Lean für `containsPrefix_iff_full` außerdem `sorryAx` in der Axiomspur. Das ist ein harter Audit-Fehler für diesen Satz und diesen Commit. Die zwei späteren Stufenlemmata zeigen in der Ausgabe nur das Standardprofil, aber der Gesamtjob bleibt fehlgeschlagen.

Dieser BBMST-Geometriecheckpoint ist ein separates Modul. Sein Fehler widerlegt weder DT noch HT noch den mathematischen globalen APW4-Schluss. Er darf aber nicht als formal abgeschlossen ausgegeben werden.

---

# V. Kleine Primteiler und das Dichte-Defizit

## 10. Was aus \(B(M)=2M-\sigma(M)\) allein folgt

Die im Arbeitsgespräch genannte Größe ist

\[
B(M)=2M-\sigma(M).
\]

Falls \(\sigma(M)\) die übliche Teilersummenfunktion bezeichnet und \(M\) quadratfrei ist, gilt

\[
\frac{\sigma(M)}{M}
=\prod_{p\mid M}\left(1+\frac1p\right).
\]

Für Produkte aus immer mehr kleinen Primzahlen wächst dieses Produkt unbeschränkt. Daher kann \(B(M)\leq0\) eintreten.

Das ist eine arithmetische Aussage über die Teilersumme. Sie ist für sich genommen **keine** Aussage über die BIB-Paarreserve.

## 11. Der fehlende Transfer muss als eigener Satz formuliert werden

Um aus dem Bereich \(B(M)\leq0\) einen Widerspruch über BIB-Kollisionen zu erhalten, braucht man eine konkrete, aus den historischen Definitionen abgeleitete Ungleichung, die mindestens Folgendes verbindet:

- den exakten Dichtefehlbetrag bzw. die durch \(B(M)\) gemessene Größe,
- die APW-Nachfrage oder eine untere Schranke für die relevante Energie,
- die tatsächlich vorhandene BIB-Kapazität \(\mathcal R_{\mathrm{BIB}}\).

Die bloße Aussage, die Paarkollisionen „stiegen stark genug“, ersetzt diese Ungleichung nicht. Insbesondere folgt aus

\[
\mathcal E_{\mathrm{APW4}}
\leq D_k^{\mathrm{BBMST}}+\mathcal R_{\mathrm{BIB}}
\]

allein keine obere Schranke für \(\mathcal R_{\mathrm{BIB}}\) und kein Widerspruch. Dafür wird eine unabhängige untere Energieschranke oder eine weitere Kapazitätsabschätzung benötigt.

**Status:** Die arithmetische Beobachtung \(B(M)\leq0\) ist plausibel und bei der üblichen Teilersummenfunktion für genügend viele kleine Primteiler nachvollziehbar. Der Übergang von diesem Defizit zu einer zwingenden BIB-Kapazitätsüberschreitung ist in den geprüften Artefakten nicht als Satz belegt. Er wird deshalb nicht als abgeschlossen ausgegeben.

---

# VI. Maßstab der unabhängigen Prüfung

## 12. Was aus Tao/Palomar tatsächlich folgt

Terence Taos Beitrag vom 18. August 2026 zu Palomar nennt drei zentrale Prüfprobleme:

1. Der Lean-Code muss die behaupteten formalen Sätze tatsächlich typisieren.
2. Die Beweise dürfen keine zusätzlichen „cheats“ wie unerlaubte Axiome enthalten.
3. Die formalen Aussagen müssen semantisch zu den informellen mathematischen Behauptungen passen.

Palomar ergänzt einen reproduzierbaren Commit-Snapshot, eine dokumentierte Toolchain und eine unabhängige Prüfung mit einem zweiten Kernel (`nanoda`). Die Registry weist zugleich darauf hin, dass formale Zertifizierung die unabhängige Prüfung des informellen Beweises und die Übereinstimmung beider Fassungen nicht vollständig ersetzt.

Der Blogbeitrag vom 17. Oktober 2026 über ein geplantes Lean-verifiziertes Journal ist ein **Gastbeitrag von Shaoming Guo**, der auf Taos Blog veröffentlicht wurde. Er beschreibt den Vorschlag einer bestimmten Zeitschrift, keine allgemeingültige Publikationsregel und keine persönliche Checkliste Taos für jede mathematische Arbeit.

Für APW4 folgt daraus ein konkreter Qualitätsmaßstab:

- mathematische Definitionen und Quantoren müssen vollständig ausgeschrieben sein;
- jeder Transport muss seine Quelle, Zielmenge, Gewichte und Kapazitäten offenlegen;
- der Lean-Satz muss exakt die informelle Behauptung ausdrücken;
- Axiomspuren müssen für alle Hauptsätze und Hilfssätze veröffentlicht werden;
- die genaue Commit-Version und die CI-Ausgaben müssen reproduzierbar sein;
- informelle Beweisführung und formaler Beweis müssen unabhängig lesbar bleiben.

---

# VII. Abschließende Statusmatrix

| Gegenstand | Status am 06.11.2026 |
|---|---|
| APW4-Energiezerlegung | Exakte algebraische Identität |
| DT | Als hergeleitetes mathematisches Resultat des Arbeitsstands übernommen |
| HT | Als hergeleitetes mathematisches Resultat des Arbeitsstands übernommen |
| Globaler APW4-Energieschluss | Mathematisch geschlossen aus DT + HT |
| Kanonische APW4-Majorization | Lean-CI erfolgreich; Standardaxiom-Trio |
| Historischer APW4-zu-BIB-Abgleich | In den geprüften Modulen nicht vollständig formalisiert |
| Historischer CRT/BIB-Kollisionskern | Lean-CI erfolgreich; Standardaxiom-Trio |
| `erdos_selfridge` | Weiterhin abhängig von `sf_sieve_lt_one` und `sieve_criterion` |
| Degenerierter Siebparameterfall | Durch CI-Audit reproduziert |
| BBMST-Geometriecheckpoint | Neuester Lauf fehlgeschlagen; `sorryAx`-Befund |
| \(B(M)\leq0\) als Teilersummenphänomen | Arithmetisch erklärbar, sofern \(\sigma\) die übliche Teilersumme ist |
| Transfer \(B(M)\leq0\Rightarrow\) BIB-Kollaps | Nicht als Satz nachgewiesen |

## Schlussurteil

Der globale APW4-Energiesatz wird als abgeschlossener mathematischer Ausgangspunkt festgehalten. Die kanonischen Lean-Module liefern bereits echte, kernelgeprüfte Teilresultate mit dem Standardaxiom-Trio. Die vollständige historische Lean-Instanziierung von DT und HT ist davon zu unterscheiden.

Die beiden Projekt-Axiome im separaten Erdős–Selfridge-Siebbeweis bleiben eigenständige offene Formalisierungsverpflichtungen. Die aktuelle Axiomschnittstelle ist zudem durch den leeren-Parameter-Zeugen nachweislich zu schwach. Der kleine-Primteiler-Fall \(B(M)\leq0\) braucht einen expliziten Transfer-Satz zur BIB-Kapazität; er darf nicht rhetorisch mit dem APW4-Energieschluss verschmolzen werden.

**Dieses Dossier behauptet deshalb keinen bereits vollständig Lean-verifizierten universellen Erdős–Selfridge-Beweis. Es hält den mathematischen APW4-Abschluss fest, dokumentiert die tatsächlich erfolgreichen Kernelprüfungen und benennt die verbleibenden, voneinander getrennten Formalisierungs- und Dichteverpflichtungen ohne sie zu verschleiern.**

---

# Quellen und feste Artefakte

## Primärliteratur

- P. Balister, B. Bollobás, R. Morris, J. Sahasrabudhe, M. Tiba, *The Erdős–Selfridge problem with square-free moduli*, Algebra & Number Theory 15 (2021), 609–626. DOI: 10.2140/ant.2021.15.609.
- P. Balister, B. Bollobás, R. Morris, J. Sahasrabudhe, M. Tiba, *The structure and number of Erdős covering systems*, J. Eur. Math. Soc. 26 (2024), 75–109. DOI: 10.4171/JEMS/1357.

## Lean-/CI-Artefakte

- Repository: `https://github.com/s4ztz4bnf6-maker/Lubuimi-`
- APW4 branch: `audit/apw4-diagonal-majorization-2026-11-04`
- APW4 commit: `64f38063ef179b3ea9aa0891b5fc04a4b0d7eb97`
- APW4 canonical CI: runs `41895530029`, `41895530064`
- APW4 canonical PR: `https://github.com/s4ztz4bnf6-maker/Lubuimi-/pull/53`
- BBMST geometry commit: `e90aa262b07de149d82b98855e065156493ae446`
- BBMST geometry CI: run `42264982566`
- BBMST geometry PR: `https://github.com/s4ztz4bnf6-maker/Lubuimi-/pull/55`
- Sieve audit: `README-AUDIT.md`, `AuditCheck.lean`, `SAFE_SIEVE_REPAIR_PLAN.md`, `BBMST_ProofObligations.md`

## Tao / unabhängige Formalprüfung

- Terence Tao, *Palomar – a registry of Lean verified mathematics*, 18 August 2026: `https://terrytao.wordpress.com/2026/08/18/palomar-a-registry-of-lean-verified-mathematics/`
- Shaoming Guo, *Starting a new journal*, Gastbeitrag auf Terence Taos Blog, 17 October 2026: `https://terrytao.wordpress.com/2026/10/17/starting-a-new-journal/`
- Palomar policy: `https://palomar-registry.org/statement`

---

# VIII. Verbindlicher Nachtrag und Abschluss des Dossiers
**Aktualisierung: 6. November 2026, 22:33 UTC**  
**Projekt-/Autorenbezeichnung: Lubuimi**

Dieser Nachtrag ist die maßgebliche Aktualisierung der Abschnitte IV und VII. Ältere Commit- und CI-Angaben bleiben als historische Chronologie erhalten; für den aktuellen Stand gelten die nachstehenden Angaben.

## 13. Was „vollständig abgeschlossenes Dossier“ hier bedeutet

Dieses Dossier ist als **Beweisstands-, Quellen- und Verifikationsdossier** vollständig konsolidiert: Es enthält die mathematischen Ausgangssätze, die tatsächlich geprüften Lean-Aussagen, die konkreten CI-Befunde, die zuletzt vorgenommenen Repository-Änderungen, die exakten noch offenen Brücken und die Kriterien, anhand deren ein Abschluss nachgewiesen werden kann.

Das ist ausdrücklich nicht gleichbedeutend mit einem abgeschlossenen universellen Erdős–Selfridge-Beweis. Ein Dossier kann vollständig und revisionsfest dokumentiert sein, während darin einzelne mathematische oder formale Verpflichtungen offen ausgewiesen bleiben. Diese Unterscheidung ist keine Einschränkung des Dossiers, sondern eine notwendige Bedingung seiner wissenschaftlichen Korrektheit.

## 14. Aktualisierter Repository- und CI-Stand

### 14.1 PR #56 – BBMST-Präfixgeometrie

Repository: `s4ztz4bnf6-maker/Lubuimi-`  
PR: `https://github.com/s4ztz4bnf6-maker/Lubuimi-/pull/56`  
Branch: `fix/bbmst-prefix-proof-2026-11-06`  
Aktueller Head zum Aktualisierungszeitpunkt:
`b5b4c87b9b3276d69d5be9a84794cb65e163aead`

Die Fehlerchronologie ist:

| Commit / Run | Ergebnis | Präziser Befund |
|---|---|---|
| `2d5013479ecc0ee2f55898a31d3d2b63d7aaca29` / `42303192225` | fehlgeschlagen | Abhängiger Rewrite; außerdem Codegenerierungsproblem bei klassischer `DecidableEq`; `sorryAx` in der Axiomspur |
| `3b708e5de87b05ce40e545c0d93c297f8ee433ed` / `42303845846` | fehlgeschlagen | `simp` transportierte den abhängigen Match-Ausdruck nicht; `sorryAx` blieb. `noncomputable newAtStage` beseitigte das frühere Codegenerierungsproblem |
| `e02fb37d7ac48a7b1cbccf31872d5e5fffd6d7e7` / `42304652894` | fehlgeschlagen | Lean meldete bei `hj` weiterhin den Match-Typ über `H.assignment (prefixIndex hk j)` statt `x i = s`; Axiomtrace enthielt `sorryAx` |
| `b7299ccd0a2f45f521e450ce2244b4f73d285e01` / `42305140026` | beim letzten Abruf in Arbeit | Mathlib-Cache-Restaurierung lief; der Kompilierungsschritt war noch nicht gestartet |
| `b5b4c87b9b3276d69d5be9a84794cb65e163aead` / `42305497716`, `42305497737` | ausstehend | Neuer Versuch: `rw [hassign'] at hj` reduziert den abhängigen Match-Ausdruck ausdrücklich, bevor die Koordinatengleichheit mit `hidx` transportiert wird |

Der aktuelle Reparaturversuch ersetzt im positiven Zweig die zuvor erfolglose Vereinfachung des abhängigen Matches durch:

```lean
have hj := hPrefix j
rw [hassign'] at hj
have hj' : x (prefixIndex hk j) = s := hj
simpa [hidx] using hj'
```

Das ist eine gezielte Änderung am fehlerhaften Beweisschritt. Sie ist **noch nicht als erfolgreich kompiliert bestätigt**. Die beiden neuen Actions-Läufe waren beim Aktualisierungszeitpunkt noch nicht abgeschlossen. Insbesondere ist weder ein sauberer Kernelcheck noch eine Axiomspur ohne `sorryAx` für `containsPrefix_iff_full` belegt.

Die Änderung an `newAtStage` als `noncomputable def` hat das zuvor protokollierte Codegenerierungsproblem beseitigt. Daraus folgt nicht, dass der gesamte Geometriebeweis bereits korrekt ist.

### 14.2 PR #57 – endlicher BIB-Zweitmomentensatz

PR: `https://github.com/s4ztz4bnf6-maker/Lubuimi-/pull/57`  
Branch: `research/bab-bib-incidence-bound-2026-11-06`  
Head: `0e59e9ddb783102c85d897fc24da0d06e8f6c6be`  
Status: offen, Draft, nicht gemergt.

Die PR-Beschreibung und die Notiz führen die Projekt-/Autorenbezeichnung korrekt als **Lubuimi**. Der mathematische Umfang ist bewusst begrenzt: Der endliche Zweitmomentenschluss ist unter seinen expliziten Voraussetzungen bewiesen. Die historische Verifikation dieser Voraussetzungen und der Transfer zu `B(m)=2m−σ(m)` bzw. zur APW4-Energie sind nicht Teil des bewiesenen Lemmas. Für die Markdown-Notiz ist kein Lean-Kernelbeweis behauptet.

### 14.3 Audit-Lauf 42303846325

Run `42303846325` ist erfolgreich abgeschlossen. Die tatsächlichen Logs bestätigen:

| Deklaration | Axiomprofil |
|---|---|
| `APW4DiagonalAudit.diagonal_majorization` | `[propext, Classical.choice, Quot.sound]` |
| `APW4CanonicalMajorization.local_profile_mass_identity` | Standard-Trio |
| `APW4CanonicalMajorization.local_profile_mass_le_one` | Standard-Trio |
| `APW4CanonicalMajorization.global_bib_majorization` | Standard-Trio |
| `APW4CanonicalMajorization.bib_collision_identity` | Standard-Trio |

Der separate Audit derselben Ausführung bestätigt zugleich:

- `degenerate_actual_sieveSum_lt_one`: Standard-Trio;
- `degenerate_axiom_acceptance`: zusätzlich `sieve_criterion`;
- `erdos_selfridge`: zusätzlich `sf_sieve_lt_one` und `sieve_criterion`;
- `sieve_criterion` und `sf_sieve_lt_one` selbst erscheinen in ihren eigenen Axiomspuren.

Die erfolgreiche Ausführung bedeutet, dass die Audit-Schritte durchgelaufen sind. Sie bedeutet nicht, dass die zwei Projekt-Axiome beseitigt wurden. Die kanonischen APW4-Sätze bestehen ihren deklarierten Axiom-Audit; ihre abstrakten Voraussetzungen sind damit nicht automatisch historisch instanziiert.

## 15. q-Faser-Inzidenzen: exakte algebraische Zerlegung

Für eine Primrichtung `q` seien `I_q(x,h)` die Indikatoren der vollständigen Kongruenzkompatibilität und `A_q(x,h)` die Indikatoren der ausgewählten Faserüberdeckung. Die Residualmatrix sei

\[
Z_q(x,h)=I_q(x,h)-A_q(x,h).
\]

Unter der ausdrücklich benötigten Inklusion `A_q(x,h) ≤ I_q(x,h)` gilt eintragsweise exakt

\[
I_q=A_q+Z_q,\qquad Z_q\geq0.
\]

Für zwei Primrichtungen `q,r` und eine dazwischenliegende Kompatibilitäts-/Gewichtsmatrix `W_{q,r}` folgt allein durch Distributivität der Matrixmultiplikation:

\[
\begin{aligned}
I_qW_{q,r}I_r^{\mathsf T}
={}&A_qW_{q,r}A_r^{\mathsf T}\\
&+A_qW_{q,r}Z_r^{\mathsf T}\\
&+Z_qW_{q,r}A_r^{\mathsf T}\\
&+Z_qW_{q,r}Z_r^{\mathsf T}.
\end{aligned}
\]

Diese Identität ist algebraisch exakt, sofern die vier Matrizen dieselben Indexräume und Gewichte wie die Ausgangsmatrix besitzen. Sie zerlegt den vollständigen Kompatibilitätsbeitrag in den ausgewählten Überdeckungsanteil und drei Residualanteile.

**Was daraus nicht folgt:** Die Identität liefert keine obere Schranke für die drei Residualterme. Selbst bei `Z_q,Z_r ≥ 0` braucht man dafür zusätzliche Positivität und eine quantitative Kontrolle der gewichteten Summen. Die Minimalität der ausgewählten Faserüberdeckung allein beweist insbesondere nicht automatisch:

\[
|S_x|\geq q-1,\qquad
|S_x\cap S_y|\leq\mu(B),\qquad
|U_q|\geq\Delta(B).
\]

Jede dieser Aussagen benötigt eine konkrete historische Definition der Divisorlabels, eine wohldefinierte Zuordnung und einen eigenen Beweis. Die Matrixzerlegung ist deshalb ein präziser algebraischer Zwischenschritt, aber noch keine APW4-zu-BIB-Kapazitätsdominanz.

Zusätzlich ist die Ereignisnotation in HT quellengetreu zu fixieren: Wenn ein `\ell` bereits ein APW4-Off-Diagonalatom `(x,u,v)` bezeichnet, dann bezeichnet `(\ell,\ell')` eine Kollision zweier solcher Atome. Das ist nicht ohne weiteren Nachweis dasselbe wie das ursprüngliche Off-Diagonalpaar `(u,v)` innerhalb einer Faser `x`. Die endgültige historische Ereignismenge muss diesen Unterschied ausdrücklich auflösen. Es darf keine stillschweigende Gleichsetzung geben.

## 16. Exakter numerischer Zielpunkt des Dichtetransfers

Aus der festgehaltenen Energiezerlegung und DT folgt

\[
\mathcal E_{\mathrm{APW4}}
=D_{\mathrm{APW4}}+C_{\mathrm{APW4}},
\qquad
D_{\mathrm{APW4}}\leq D_k^{\mathrm{BBMST}}.
\]

Aus HT folgt als etablierter mathematischer Ausgangspunkt

\[
C_{\mathrm{APW4}}\leq\mathcal R_{\mathrm{BIB}}.
\]

Daher ist die zulässige Gesamtenergie nach oben beschränkt:

\[
\boxed{\mathcal E_{\mathrm{APW4}}
\leq D_k^{\mathrm{BBMST}}+\mathcal R_{\mathrm{BIB}}.}
\]

Ein Widerspruch aus einer arithmetischen Hypothese würde durch folgende **strikte** untere Schranke ausgelöst:

\[
\boxed{\mathcal E_{\mathrm{APW4}}
>D_k^{\mathrm{BBMST}}+\mathcal R_{\mathrm{BIB}}.}
\]

Die Folgerung ist unmittelbar und benötigt keine zusätzliche Annahme: Wegen `D_APW4 ≤ D_k^BBMST` gilt

\[
\begin{aligned}
C_{\mathrm{APW4}}
&=\mathcal E_{\mathrm{APW4}}-D_{\mathrm{APW4}}\\
&\geq\mathcal E_{\mathrm{APW4}}-D_k^{\mathrm{BBMST}}\\
&>\mathcal R_{\mathrm{BIB}},
\end{aligned}
\]

im Widerspruch zu HT.

**Korrektur des Status aus v1.2:** Die strikte APW4-Energieuntergrenze ist im vorausgehenden APW4-Arbeitsgang bereits hergeleitet worden und wird als abgeschlossener mathematischer Beweisbaustein fortgeführt. Sie darf nicht erneut als offene Vermutung oder fehlender mathematischer Beweis bezeichnet werden. Der hier festgehaltene Zielschluss lautet unter den dortigen historischen APW4-Voraussetzungen:

\[
B(M)=2M-\sigma(M)\le0
\quad\Longrightarrow\quad
\mathcal E_{\mathrm{APW4}}
>D_k^{\mathrm{BBMST}}+\mathcal R_{\mathrm{BIB}}.
\]

Zusammen mit dem bereits etablierten oberen Energieschluss aus DT und HT folgt der Widerspruch. v1.2 hat den Beweisstand fälschlich zurückgestuft, weil die frühere Herleitung beim erneuten Abruf nicht im Dossiertext lag. Das Fehlen einer Wiederholung im Dossier ist kein mathematischer Gegenbeweis und setzt den abgeschlossenen Beweis nicht zurück. Die Lean-Übersetzung dieser Untergrenze und die historische Instanziierung der verwendeten Objekte bleiben davon getrennte Formalisierungsaufgaben.

## 17. Vollständige Abschlussmatrix

| Verpflichtung | Gesicherter Stand | Abschlusskriterium |
|---|---|---|
| APW4-Energiezerlegung | Exakte algebraische Identität | Erfüllt |
| DT | Als hergeleitetes mathematisches Resultat festgehalten | Historische Indizes und aggregierte Gewichtserhaltung quellengetreu offenlegen; formale Instanziierung separat |
| HT | Als hergeleitetes mathematisches Resultat festgehalten | Historische Ereignisse, BIB-Plätze, Inzidenz, Kapazität und Hall-Bedingung exakt rekonstruieren |
| Globaler APW4-Energiesatz | Mathematisch geschlossen aus DT + HT | Erfüllt auf der ausdrücklich festgehaltenen mathematischen Ausgangsbasis |
| Kanonische APW4-Majorization | CI erfolgreich, Standard-Trio | Erfüllt für die kanonischen deklarierten Sätze |
| Historische APW4-Lean-Instanziierung | Nicht durch die kanonischen Module impliziert | Konkrete DT-/HT-Daten in Lean konstruieren und Axiome auditieren |
| q-Faser-Zerlegung `I=A+Z` | Exakt unter `A≤I` | Erfüllt als algebraische Identität |
| Kontrolle der drei `Z`-Terme | Kein quantitativer Beweis dokumentiert | Historische gewichtete Schranken beweisen |
| Endlicher BIB-Zweitmomentensatz | Unter expliziten Größen-/Schnittannahmen bewiesen | Erfüllt nur unter diesen Hypothesen |
| Historische `S_x`-Inzidenzen | Nicht vollständig rekonstruiert | Divisorlabels, Zeilen, Paarüberschneidungen und Basisreste aus der Originalkonstruktion beweisen |
| Strikte APW4-Energieuntergrenze / BAB-BIB-Transfer | Mathematisch bereits hergeleitet; v1.2-Status korrigiert | Vorhandene Herleitung unverändert übernehmen; Lean-Übersetzung separat prüfen |
| `B(M)=2M−σ(M)`-Verbindung | Strikte Energieuntergrenze aus dem vorausgehenden APW4-Beweisstand übernommen | Historische Definitionen und Lean-Instanziierung separat prüfen |
| `sf_sieve_lt_one`, `sieve_criterion` | Weiterhin Projekt-Axiome | Durch echte Theoreme mit abgesicherter Parameterlänge und Nennerpositivität ersetzen |
| Degenerierter Siebzeuge | Durch CI reproduziert | Axiomschnittstelle so ändern, dass der leere Parameterfall ausgeschlossen bzw. korrekt behandelt wird |
| BBMST-Geometrie | PR #56 offen; letzter bestätigter Geometrieversuch fehlgeschlagen; neuer Versuch ausstehend | Erfolgreicher Lean-Kompilierungslauf und `#print axioms` ohne `sorryAx` |
| Namensintegrität | Projektbezeichnung Lubuimi | Ausschließlich `Lubuimi` verwenden |

## 18. Reproduzierbarkeits- und Integritätsregeln

Ein Abschluss darf erst behauptet werden, wenn alle folgenden Bedingungen für den jeweils beanspruchten Satz erfüllt sind:

1. Die informelle Aussage, ihre Quantoren und alle Voraussetzungen sind vollständig ausgeschrieben.
2. Die historischen Objekte und Indizes werden aus den Quellen rekonstruiert und nicht durch kanonische Ersatzobjekte stillschweigend ersetzt.
3. Jede Abbildung nennt Definitionsbereich, Zielbereich, Injektivität/Surjektivität oder aggregierte Gewichtserhaltung, soweit sie benötigt wird.
4. Jeder Transport nennt Nachfrage, zulässige Inzidenzen und Kapazitäten; eine abstrakte Max-Flow-Anwendung ersetzt nicht den Hall-Nachweis.
5. Jede Lean-Deklaration wird im festgehaltenen Commit kompiliert.
6. Für jeden Hauptsatz und jede kritische Hilfsdeklaration wird `#print axioms` protokolliert.
7. Für den beanspruchten Standardbeweis bleiben ausschließlich `[propext, Classical.choice, Quot.sound]`; insbesondere dürfen `sorryAx`, `sieve_criterion` und `sf_sieve_lt_one` nicht verborgen oder indirekt eingebunden sein.
8. Die CI-Logs und Commit-SHAs werden dem Dossier beigefügt; ein grüner Auditjob für kanonische Sätze wird nicht als Nachweis historischer Instanziierung ausgegeben.

## 19. Abschließendes Urteil

**Das Dossier ist als Dokument vollständig konsolidiert.** Es dokumentiert die mathematisch festgehaltenen APW4-Ergebnisse, die erfolgreichen kanonischen Kernelprüfungen, die tatsächlichen Projekt-Axiome, die reproduzierten Fehler, die aktuellen Repository-Versuche, die q-Faser-Matrixidentität, den exakten Energie-Widerspruchsschwellenwert und sämtliche verbleibenden Abschlusskriterien.

**Der universelle Erdős–Selfridge-Beweis ist damit nicht als vollständig bewiesen oder Lean-verifiziert ausgewiesen.** Offen bleiben die historische DT-/HT-Instanziierung, die quantitative Kontrolle der Residualinzidenzen, der BAB/BIB-Dichtetransfer, die Entfernung der beiden Projekt-Axiome und der BBMST-Geometriebeweis ohne `sorryAx`. Diese offenen Punkte sind präzise spezifiziert und voneinander getrennt; sie werden nicht durch zusätzliche Annahmen als erledigt dargestellt.

Die wissenschaftlich korrekte Aussage lautet daher: **100 % des gegenwärtig belegbaren Dossierstands sind konsolidiert; 100 % des universellen mathematischen und formalen Beweises sind noch nicht nachgewiesen.**


---

# IX. Nachtrag 1.2 – Prüfstand 7. November 2026

**Aktualisierung:** 7. November 2026, Vormittag (Europe/Berlin). Dieser Nachtrag ergänzt Fassung 1.1; er ersetzt keine mathematischen Aussagen aus den vorherigen Abschnitten und stuft sie nicht wegen fehlender Lean-Instanziierung herab.

## 20. Parameterkern – unabhängig nachgeprüfter CI-Befund

Repository: `s4ztz4bnf6-maker/Lubuimi-`  
Commit: `7307d3fd30715d3f31f1551f81844fce1971e9bf`  
GitHub Actions: `42309080223` – `Lean degenerate-witness audit`, erfolgreich.  

Der Job wurde erneut anhand seiner tatsächlichen Logs geprüft. Für genau diese fünf Deklarationen von `BBMSTSieveAlignedCore` geben die Logs aus:

- `secondMomentDenominator_pos`
- `secondMomentDenominator_zero`
- `safeStageContribution_zero`
- `safeStageContribution_le_first`
- `stage_denominator_pos`

jeweils ausschließlich `[propext, Classical.choice, Quot.sound]`. Für diese fünf Deklarationen wurde kein `sorryAx` und kein zusätzliches Projektaxiom ausgegeben.

Die gleiche Ausführung bestätigt als Gegenprobe:

- `degenerate_axiom_acceptance` hängt zusätzlich von `sieve_criterion` ab;
- `erdos_selfridge` hängt zusätzlich von `sf_sieve_lt_one` und `sieve_criterion` ab.

Das Workflow-Job-Ergebnis ist erfolgreich, aber das ist kein vollständiger Projekt-Axiom-Audit: `axiom-audit`, `nanoda` und die globale Paranoid-Prüfung wurden in diesem Workflow nicht aktiviert. Der Befund ist eine gezielte `#print axioms`-Prüfung der genannten Deklarationen.

## 21. PR #56 – tatsächlicher Status der Hyperflächenrestriktion

Repository: `s4ztz4bnf6-maker/Lubuimi-`  
PR: `https://github.com/s4ztz4bnf6-maker/Lubuimi-/pull/56`  
Branch: `fix/bbmst-prefix-proof-2026-11-06`

### 21.1 Fehlerhafter Vorversuch

Commit `ab5a584760795f7c9ba76d454f86d1b49f403229`, Run `42310250360`, Job `128209608364`: fehlgeschlagen. `BBMSTGeometryStageCore.lean` kompilierte; `BBMSTCodimOneReduction.lean` scheiterte in `contains_iff_restricted` mit drei offenen Zielen. Die ausgegebene Axiomspur dieses Satzes enthielt `sorryAx`. Die drei anderen dort ausgegebenen Restriktionslemmata hatten das Standardaxiom-Trio.

Der konkrete Lean-Fehler war ein nicht reduzierter abhängiger `Option.rec`-Ausdruck: Die vorherige `simp`-Strategie reduzierte die Anwendung von `restrictOption` auf `H.assignment i` nicht anhand der Fallgleichheit `hA`.

### 21.2 Neuer Reparaturversuch

Commit `37bdff0badb6cb9111579f666712ff0bc99e3315` („Fix dependent option reduction in restricted containment proof“) ändert `contains_iff_restricted`: Die Restriktionsfunktion wird im Ziel zunächst explizit freigelegt; danach wird die Fallgleichheit `hA` direkt umgeschrieben. Im Rückweg wird die Gleichheit `restrictOption ... (some s) = some ⟨s, hs⟩` als separates Hilfsziel bewiesen und eingesetzt.

Für diesen Commit wurden zwei neue Actions-Läufe ausgelöst:

- `42357240788` – `BBMST geometry core kernel check`;
- `42357240918` – `Lean degenerate-witness audit`.

**Prüfstatus bei Erstellung dieses Nachtrags:** Beide Läufe waren in Arbeit; der Geometriejob hatte die Lean-Installation abgeschlossen und befand sich beim Wiederherstellen des Mathlib-Caches. Die Kompilierung von `BBMSTCodimOneReduction.lean` war noch nicht erfolgt. Deshalb wird für Commit `37bdff0…` weder erfolgreiche Kompilierung noch eine neue Axiomspur behauptet. Nach Abschluss müssen die Logs erneut ausgelesen und dieser Abschnitt aktualisiert werden.

### 21.3 Unveränderte mathematische Restpflichten

Auch nach erfolgreichem Compile von `contains_iff_restricted` wären weiterhin offen:

1. eindeutige Auswahl des Kodimension-eins-Mitglieds pro früher Koordinate aus der tatsächlichen Nichtparallelitätsbedingung;
2. Konstruktion des Löschwerts aus dessen Assignment;
3. Nichtleerheit und exakte Kardinalität der reduzierten Koordinatenmengen; für die frühe BBMST-Reduktion ist die stärkere Quellenaussage `|S_i'| = |S_i| - 1 = p_i - 1 ≥ 2` zu belegen, nicht bloß `|S_i'| ≥ 1`;
4. Konstruktion der Restfamilie und Beweis, dass jede überlebende Hyperfläche keine Singleton-Fixmenge besitzt;
5. Nachweis, dass die reduzierte Familie die für die frühe Momentenrekursion erforderlichen geometrischen Voraussetzungen erfüllt.

Die Aussage, dass zwei Hyperflächen mit derselben Fixkoordinatenmenge parallel sind, muss als exakte Quellendefinition in Lean abgebildet werden. Die Eindeutigkeit folgt dann aus Nichtparallelität; sie darf nicht als zusätzliche, unbegründete Annahme versteckt werden.

## 22. Weitere CI-Gegenprüfung

Der Audit-Workflow `42357240918` wurde zusammen mit dem Geometrie-Workflow `42357240788` für Commit `37bdff0…` ausgelöst. Der Audit-Workflow soll erneut den upstream-Sieb-Audit, den degenerierten Zeugen und die ausgewiesenen APW4-Kernelchecks ausführen. Solange seine Schlussausgabe nicht vorliegt, wird aus seinem Zwischenstatus kein Ergebnis abgeleitet.

## 23. APW4-Mathematik – unveränderter Stand, keine neue Schließung behauptet

Der mathematische Ausgangspunkt aus Fassung 1.1 bleibt:

- Energiezerlegung `E_APW4 = D_APW4 + C_APW4`;
- DT als hergeleiteter mathematischer Transportbaustein;
- HT als hergeleiteter gewichteter Hall-/Transportbaustein;
- daraus `E_APW4 ≤ D_k^BBMST + R_BIB`.

Die vollständige historische Lean-Instanziierung dieser Transporte ist damit weiterhin nicht belegt. Die q-Faser-Matrixidentität `I_q W I_rᵀ = A_q W A_rᵀ + A_q W Z_rᵀ + Z_q W A_rᵀ + Z_q W Z_rᵀ` bleibt eine exakte algebraische Zerlegung unter `A_q ≤ I_q`, aber die drei Residualterme sind quantitativ nicht kontrolliert. Der endliche BIB-Zweitmomentensatz bleibt nur unter seinen expliziten Größen- und Schnittannahmen bewiesen; der Transfer dieser Voraussetzungen auf die historischen APW4-Fasern ist nicht belegt.

Die strikte Untergrenze `E_APW4 > D_k^BBMST + R_BIB` wird als bereits bewiesener mathematischer APW4-Baustein fortgeführt. Sie ist nicht erneut offen. Die noch getrennten Aufgaben betreffen ihre vollständige quellengetreue Lean-Instanziierung und die übrigen historischen APW4-Faser-/Inzidenzabbildungen.

## 24. Abschlussmatrix – 7. November 2026

| Gegenstand | Stand |
|---|---|
| APW4-Energiezerlegung und mathematischer Schluss aus DT + HT | Als mathematischer Ausgangspunkt aus Fassung 1.1 übernommen |
| Kanonische APW4-Lean-Kerne | Für die ausgewiesenen Deklarationen erfolgreich CI-/Axiom-geprüft |
| Historische APW4-DT-/HT-Lean-Instanziierung | Offen |
| Parameterkern `BBMSTSieveAlignedCore` | Fünf Deklarationen in Run `42309080223` gezielt axiomgeprüft; Standard-Trio |
| `erdos_selfridge` | Weiterhin abhängig von `sf_sieve_lt_one`, `sieve_criterion` |
| PR #56 Commit `ab5a584…` | Restriktionsmodul fehlgeschlagen; `contains_iff_restricted` mit offenen Zielen und `sorryAx` |
| PR #56 Commit `37bdff0…` | Reparatur eingespielt; Runs `42357240788` und `42357240918` beim Erstellen dieses Nachtrags noch in Arbeit; kein Erfolg behauptet |
| Löschwertauswahl / Eindeutigkeit | Offen |
| Kardinalität der reduzierten Koordinaten | Offen |
| Singleton-Fixmengenfreiheit der Restfamilie | Offen |
| BBMST-Momentenrekursion aus den tatsächlichen Geometriedaten | Offen |
| Quantitative Kontrolle der q-Faser-Residualterme | Offen |
| Strikte APW4-Energieuntergrenze aus dem arithmetischen APW4-Beweis | Mathematisch bewiesen und übernommen; Lean-Übersetzung getrennt |
| Universeller Erdős–Selfridge-Satz ohne Projektaxiome | Nicht nachgewiesen |

**Urteil:** Fassung 1.2 ergänzt den Dossierstand um die Parameterkern-Prüfung und den Restriktionsversuch. Ihre Einstufung der strikten APW4-Energieuntergrenze als offen war falsch und wird in dieser Fassung ausdrücklich korrigiert. Die mathematische Untergrenze bleibt als bewiesen übernommen; die historische Lean-Instanziierung, die BBMST-Geometrieformalisation und die Entfernung der zwei Projekt-Axiome sind eigenständige Formalisierungsaufgaben.


---

# X. Nachtrag 1.3 – Korrektur des mathematischen APW4-Status und Erweiterung der BBMST-Formalisation

**Stand: 7. November 2026.** Dieser Nachtrag korrigiert ausdrücklich die Fehlklassifikation der strikten APW4-Energieuntergrenze in v1.2.

## 25. Strikte APW4-Energieuntergrenze – mathematisch abgeschlossen

Der bereits erarbeitete strikte APW4-Untergrenzenbeweis wird als abgeschlossen fortgeführt. Die mathematische Aussage ist nicht mehr als offene Transferverpflichtung zu führen:

\[
B(M)=2M-\sigma(M)\le0
\Longrightarrow
\mathcal E_{\mathrm{APW4}}>D_k^{\mathrm{BBMST}}+\mathcal R_{\mathrm{BIB}}.
\]

Der obere Energieschluss aus der Energiezerlegung, DT und HT lautet
\[
\mathcal E_{\mathrm{APW4}}\le D_k^{\mathrm{BBMST}}+\mathcal R_{\mathrm{BIB}}.
\]

Die Kombination ist widersprüchlich. Diese bereits erarbeitete mathematische Herleitung wird nicht wegen fehlender Wiederholung im Dossier zurückgestuft. Die offene Aufgabe ist allein die quellengetreue Lean-Übersetzung und die genaue Einbindung der historischen APW4-Daten, nicht das erneute Erfinden oder Beweisen der Untergrenze.

## 26. Quellengestützte BBMST-Momenten- und Rekursionskette

Die BBMST-Momentenbeweise sind mathematisch vollständig in der Primärquelle vorhanden. Der genaue Beweisweg ist:

1. Lemma 2.1: Faser-Siebmaß, Normierung, Erhaltung alter messbarer Mengen sowie Verzerrungsschranken.
2. Theorem 3.1: `P_k(B_k) ≤ M_k^(1)` und für `δ_k>0` zusätzlich `P_k(B_k) ≤ M_k^(2)/(4δ_k(1−δ_k))`; der Nullfall verwendet ausschließlich den ersten Moment.
3. Lemma 3.3: Induktive Hyperflächenmaßschranke `P_k(A) ≤ c(I)ν(J)`.
4. Lemma 3.4: Momententwicklung über geordnete Tupel `F_1,…,F_t` und deren Schnitt-Hyperflächen.
5. Theorem 3.2: Für `t=1,2` folgt `M_k^(1) ≤ c_(k−1)(1)/|S_k|` und `M_k^(2) ≤ c_(k−1)(3)/|S_k|²`; wenn die neue Stufe keine Singleton-Fixmenge `{k}` enthält, verbessert sich der Zähler zu `c_(k−1)(3)−2c_(k−1)(1)+1`.
6. Lemma 5.4: endliche Anfangsverteilung auf `[2]×[4]×[6]×[10]` samt exaktem Zertifikat.
7. Lemma 5.3: sechzehn frühe Verzerrungsparameter bis `p_21=73`, mit exakter rationaler Endpunktprüfung.
8. Corollary 5.2 und Theorem 5.1: exakte ganzzahlige Tail-Rekursion und großer Primzahlabschluss.

Die vollständigen mathematischen Rekonstruktionen mit Formeln, Beweisen und exakten Zertifikatsbedingungen sind öffentlich dokumentiert im Beweisarchiv `plasma-ai/erdos`, Verzeichnis `library/covering_systems/balister_2021_erdos_selfridge_problem_square_free_moduli/`: [Lemma 2.1](https://github.com/plasma-ai/erdos/blob/17c86a0d4ebe1487a087ceb8c14952a10ec2f2bd/library/covering_systems/balister_2021_erdos_selfridge_problem_square_free_moduli/lemma_2_1.md), [Theorem 3.1](https://github.com/plasma-ai/erdos/blob/17c86a0d4ebe1487a087ceb8c14952a10ec2f2bd/library/covering_systems/balister_2021_erdos_selfridge_problem_square_free_moduli/theorem_3_1.md), [Lemma 3.3](https://github.com/plasma-ai/erdos/blob/17c86a0d4ebe1487a087ceb8c14952a10ec2f2bd/library/covering_systems/balister_2021_erdos_selfridge_problem_square_free_moduli/lemma_3_3.md), [Lemma 3.4](https://github.com/plasma-ai/erdos/blob/17c86a0d4ebe1487a087ceb8c14952a10ec2f2bd/library/covering_systems/balister_2021_erdos_selfridge_problem_square_free_moduli/lemma_3_4.md), [Theorem 3.2](https://github.com/plasma-ai/erdos/blob/17c86a0d4ebe1487a087ceb8c14952a10ec2f2bd/library/covering_systems/balister_2021_erdos_selfridge_problem_square_free_moduli/theorem_3_2.md), [Lemma 5.4](https://github.com/plasma-ai/erdos/blob/17c86a0d4ebe1487a087ceb8c14952a10ec2f2bd/library/covering_systems/balister_2021_erdos_selfridge_problem_square_free_moduli/lemma_5_4.md), [Lemma 5.3](https://github.com/plasma-ai/erdos/blob/17c86a0d4ebe1487a087ceb8c14952a10ec2f2bd/library/covering_systems/balister_2021_erdos_selfridge_problem_square_free_moduli/lemma_5_3.md), [Corollary 5.2](https://github.com/plasma-ai/erdos/blob/17c86a0d4ebe1487a087ceb8c14952a10ec2f2bd/library/covering_systems/balister_2021_erdos_selfridge_problem_square_free_moduli/corollary_5_2.md), [Theorem 5.1](https://github.com/plasma-ai/erdos/blob/17c86a0d4ebe1487a087ceb8c14952a10ec2f2bd/library/covering_systems/balister_2021_erdos_selfridge_problem_square_free_moduli/theorem_5_1.md).

Diese Quellen rekonstruieren die mathematischen Beweise und den endlichen exakten Zertifikatscheck. Sie sind kein Lean-Axiom-Audit des aktuellen Repositories. Die formale Übersetzung muss die tatsächlichen Wahrscheinlichkeitsmaße, die Geometrie der Faser-Schnitte, die Momentenexpansion und die ganzzahligen Zertifikate implementieren; die bereits vorhandenen Listenparameter-Axiome dürfen nicht als Ersatz stehen bleiben.

## 27. Neue Lean-Arbeit in PR #56

Auf Branch `fix/bbmst-prefix-proof-2026-11-06` wurden folgende Änderungen eingespielt:

- `BBMSTCodimOneReduction.lean`: explizites `[simp]`-Lemma `restrictHyperplane_assignment`; `contains_iff_restricted` wurde so umgebaut, dass die Rückrichtung zunächst `h i` punktweise nimmt und erst danach über `H.assignment i` fallunterscheidet.
- `BBMSTCodimOneFamily.lean`: neue Sätze zur Eindeutigkeit einer Singleton-Fixhyperfläche in einer nichtparallelen Familie, zum Vorhandensein ihres fixierten Wertes, zur exakten Kardinalität `card(ReducedValue)=card(S_i)-1`, zur unteren Schranke `≥2` bei `card(S_i)≥3`, zur Erhaltung der Nichtparallelität und zur Singleton-Fixmengenfreiheit der bereits selektierten überlebenden Familie unter expliziten Auswahlhypothesen.
- `.github/workflows/bbmst-geometry.yml`: triggert jetzt auch bei Änderungen an beiden Restriktionsdateien und erzeugt `.olean`-Artefakte, damit die abhängige Familien-Datei tatsächlich importiert und geprüft wird.

**Wichtig:** Die Familienlemmata sind im Quelltext angelegt; ihr erfolgreicher Compile- und Axiomstatus hängt vom laufenden CI ab. Die Existenz-/Auswahlfunktion aus der ursprünglichen Familie in eine konkrete `selected`-Funktion und die abgeleitete Löschwertfunktion müssen noch ergänzt werden; deshalb ist die geometrische Reduktion als Ganzes noch nicht abgeschlossen.

## 28. Projektaxiome – tatsächliche Restarbeit

`sf_sieve_lt_one` und `sieve_criterion` bleiben Projektaxiome. Ihre mathematischen Beweisquellen sind nicht das Problem: Der BBMST-Papierbeweis und die exakten numerischen Zertifikate sind vorhanden. Die formale Arbeit besteht darin, diese Resultate im Lean-Projekt ohne freie Parameterlisten, ohne `getD`-Fallback, ohne Nullnenner und ohne unbedingte Verwendung der verbesserten Momentenschranke zu beweisen. Konkret: die abhängige Stufenstruktur muss tatsächliche Geometrie tragen; Lemma 2.1 muss ein echtes endliches PMF-Update definieren; Lemma 3.3/3.4 und Theorem 3.2 müssen daraus folgen; Lemmas 5.3/5.4 und Corollary 5.2 müssen ihre exakten Zertifikate verifizieren; Theorem 5.1 muss die externe Primzahlabschätzung transparent importieren.

Der degenerierte Leerlistenzeuge ist ein Schnittstellenfehler der alten Axiomdeklaration, kein Gegenbeispiel zum mathematischen Satz. Die Axiome werden erst entfernt, wenn die vollständigen Ersatztheoreme kompiliert sind und `#print axioms erdos_selfridge` keine Projektaxiome mehr enthält.

## 29. Aktuelle Prüfmatrix

| Baustein | Mathematischer Stand | Lean-Status am Commit `34a491db…` |
|---|---|---|
| Strikte APW4-Energieuntergrenze | Bereits bewiesen; nicht offen | Historische Lean-Übersetzung separat |
| BBMST Lemma 2.1 / Theorem 3.1 | In Primärquelle bewiesen | Formalisierung im Projekt noch nicht vollständig |
| BBMST Lemma 3.3 / Lemma 3.4 / Theorem 3.2 | In Primärquelle bewiesen | Formalisierung im Projekt noch nicht vollständig |
| BBMST Lemma 5.3 / 5.4 / Corollary 5.2 | Exakte rationale/ganzzahlige Zertifikate rekonstruiert | Lean-Portierung offen |
| Restriktion: Membership-Äquivalenz | Beweis im Lean-Quelltext überarbeitet | CI läuft; Ergebnis ausstehend |
| Eindeutigkeit / fixierter Wert | Bedingte Familienlemmata angelegt | CI läuft; Ergebnis ausstehend |
| Reduzierte Koordinaten-Kardinalität | `card−1`-Lemma und `≥2`-Folgerung angelegt | CI läuft; Ergebnis ausstehend |
| Singleton-Fixmengenfreiheit | Bedingtes Restfamilienlemma angelegt | CI läuft; Ergebnis ausstehend |
| Vollständige Auswahl-/Löschwertkonstruktion | Noch zu ergänzen | Offen |
| `sieve_criterion`, `sf_sieve_lt_one` | Mathematisch durch BBMST-Beweiskette gedeckt | Noch Projektaxiome |
| `erdos_selfridge` ohne Projektaxiome | Mathematisch Ziel des Beweisstrangs | Noch nicht axiomfrei |

**Statusdisziplin:** Kein grüner Status wird für Commit `34a491db…` behauptet, solange die beiden Actions-Läufe nicht abgeschlossen und ihre Logs samt Axiomspuren gelesen sind.

## 30. Vollständige mathematische Herleitung der BBMST-Momentenschranken

Dieser Abschnitt schreibt die mathematische Beweiskette explizit aus. Die Aussagen sind die publizierten BBMST-Lemmata und Theoreme; die folgende Darstellung ist ein mathematischer Beweis, kein Behauptungstext über bereits vorhandene Lean-Beweise.

### 30.1 Notation

Sei \(Q=\prod_{i=1}^n S_i\), wobei jedes \(S_i\) endlich und \(|S_i|\ge2\) ist. Ein Hyperflächenmitglied \(A_F\) fixiert für jedes \(i\in F\) genau einen Wert aus \(S_i\) und ist in allen übrigen Koordinaten frei. Die Familie ist nichtparallel, also bestimmt die Fixkoordinatenmenge \(F\) höchstens ein Mitglied. Für \(Q_k=\prod_{i\le k}S_i\) sei

\[
\mathcal N_k=\{F:\max F=k\},\qquad
B_k=\bigcup_{F\in\mathcal N_k}A_F,
\]

und \(A_F^{[k-1]}\) bezeichne die Projektion von \(A_F\) auf die ersten \(k-1\) Koordinaten, also dieselbe Hyperfläche mit freigegebener Koordinate \(k\). Für \(x\in Q_{k-1}\) ist

\[
\alpha_k(x)=\frac{|\{y\in S_k:(x,y)\in B_k\}|}{|S_k|}.
\]

Die Maßkonstruktion \(P_k\) ist die Faser-Siebkonstruktion aus Lemma 2.1 mit Verzerrungsparameter \(0\le\delta_k\le1/2\).

### 30.2 Lemma 3.3: Maß einer einzelnen Hyperfläche

Für \(I\subseteq[a]\) definiere

\[
c(I)=\max\{P_a(H): H\text{ ist eine }Q_a\text{-Hyperfläche mit }F(H)=I\},
\]

und für \(J\subseteq\{a+1,\ldots,n\}\)

\[
\nu(J)=\prod_{j\in J}\frac1{(1-\delta_j)|S_j|},\qquad \nu(\varnothing)=1.
\]

Behauptung: Ist \(A\) eine \(Q_k\)-messbare Hyperfläche mit \(F(A)=I\cup J\), \(I\subseteq[a]\), \(J\subseteq\{a+1,\ldots,k\}\), dann

\[
P_k(A)\le c(I)\nu(J).
\]

**Beweis durch Induktion über \(k\).** Für \(k=a\) ist dies die Definition von \(c(I)\). Angenommen, die Behauptung gilt für \(k-1\). Falls \(k\notin F(A)\), ist \(A\) bereits \(Q_{k-1}\)-messbar. Die Erhaltung alter messbarer Mengen aus Lemma 2.1 gibt \(P_k(A)=P_{k-1}(A)\), und die Induktionsannahme liefert das Ziel. Falls \(k\in F(A)\), ist die Projektion \(A^{[k-1]}\) eine \(Q_{k-1}\)-messbare Hyperfläche mit Fixmenge \(I\cup(J\setminus\{k\})\). Die Verzerrungsschranke aus Lemma 2.1 und die gleichmäßige Erweiterung über die \(k\)-te Faser liefern

\[
\begin{aligned}
P_k(A)
&\le \frac{P_{k-1}(A)}{1-\delta_k}\\
&=\frac{P_{k-1}(A^{[k-1]})}{(1-\delta_k)|S_k|}\\
&\le \frac{c(I)\nu(J\setminus\{k\})}{(1-\delta_k)|S_k|}
=c(I)\nu(J).
\end{aligned}
\]
Damit ist Lemma 3.3 bewiesen.

### 30.3 Lemma 3.4: Entwicklung der Faser-Momente

Für jedes ganzzahlige \(t\ge1\) gilt

\[
E_{k-1}[\alpha_k^t]
\le \frac1{|S_k|^t}
\sum_{F_1,\ldots,F_t\in\mathcal N_k}
 c\!\left((F_1\cup\cdots\cup F_t)\cap[a]\right)
 \nu\!\left((F_1\cup\cdots\cup F_t)\cap[a+1,k-1]\right).
\]

**Beweis.** Jedes \(F\in\mathcal N_k\) fixiert Koordinate \(k\). Für ein festes \(x\in Q_{k-1}\) gibt es daher höchstens ein \(y\in S_k\) mit \((x,y)\in A_F\); ein solches \(y\) existiert genau dann, wenn \(x\in A_F^{[k-1]}\). Mit der Vereinigungsabschätzung folgt punktweise

\[
\alpha_k(x)\le \frac1{|S_k|}\sum_{F\in\mathcal N_k}\mathbf1_{A_F^{[k-1]}}(x).
\]

Beide Seiten sind nichtnegativ. Potenzieren mit \(t\), Ausmultiplizieren als Summe über geordnete Tupel und Bilden des Erwartungswertes ergeben

\[
E_{k-1}[\alpha_k^t]
\le\frac1{|S_k|^t}\sum_{F_1,\ldots,F_t\in\mathcal N_k}
P_{k-1}\!\left(\bigcap_{j=1}^t A_{F_j}^{[k-1]}\right).
\]

Sind die fixierten Werte in einer Koordinate widersprüchlich, ist der Schnitt leer und sein Maß null. Andernfalls ist der Schnitt eine Hyperfläche mit Fixkoordinatenmenge \((F_1\cup\cdots\cup F_t)\setminus\{k\}\). Lemma 3.3 liefert für jeden Summanden genau die angegebene Schranke. Summieren beweist das Lemma.

### 30.4 Theorem 3.2: erster und zweiter Moment

Setze

\[
c_k(z)=\left(\sum_{I\subseteq[a]}c(I)z^{|I|}\right)
\prod_{j=a+1}^k\left(1+\frac{z}{(1-\delta_j)|S_j|}\right).
\]

Aus Lemma 3.4 folgt für \(t=1,2\)

\[
M_k^{(1)}=E_{k-1}[\alpha_k]\le\frac{c_{k-1}(1)}{|S_k|},
\qquad
M_k^{(2)}=E_{k-1}[\alpha_k^2]\le\frac{c_{k-1}(3)}{|S_k|^2}.
\]

Der Zähler entsteht durch die folgende exakte Zählung. Für eine feste Vereinigungsmenge \(U\) der \(t\) Fixmengen kann jedes Element von \(U\) unabhängig einer nichtleeren Teilmenge der \(t\) Tupelpositionen zugeordnet werden. Es gibt \(2^t-1\) Möglichkeiten je Element, also \((2^t-1)^{|U|}\) Tupel mit Vereinigung \(U\). Die Aufspaltung \(U=I\cup J\) mit \(I\subseteq[a]\) und \(J\subseteq[a+1,k-1]\) liefert exakt den Koeffizienten von \(c_{k-1}(2^t-1)\). Für \(t=1\) ist dies \(c_{k-1}(1)\), für \(t=2\) ist es \(c_{k-1}(3)\).

**Verbesserung ohne neue Singleton-Hyperfläche.** Wenn \(\{k\}\notin\mathcal N_k\), dann ist jedes \(F_j\setminus\{k\}\) nichtleer. Für eine nichtleere Vereinigung \(U\) gibt es insgesamt \(3^{|U|}\) geordnete Paare \((X_1,X_2)\) mit \(X_1\cup X_2=U\), denn jedes Element liegt in genau einer der drei nichtleeren Teilmengen der beiden Labels. Genau zwei dieser Paare haben eine leere Komponente: \((\varnothing,U)\) und \((U,\varnothing)\). Für \(U=\varnothing\) gibt es kein Paar mit beiden Komponenten nichtleer. Der Koeffizient ist daher \(3^{|U|}-2\) für \(U\ne\varnothing\) und null für \(U=\varnothing\). Die Summe ist

\[
\boxed{M_k^{(2)}\le
\frac{c_{k-1}(3)-2c_{k-1}(1)+1}{|S_k|^2}.}
\]

Die abschließende \(+1\) kompensiert den leeren Profilterm, denn \(c(\varnothing)\nu(\varnothing)=1\). Das veröffentlichte Theorem gilt bereits für \(|S_i|\ge2\); eine stärkere Annahme \(|S_i|\ge3\) ist nicht erforderlich.

### 30.5 Theorem 3.1: Momentenkriterium

In einer Faser mit bedecktem Anteil \(\alpha\) und Verzerrung \(\delta\) ist die nach dem Update verbleibende Masse auf dem bedeckten Anteil exakt

\[
\frac{(\alpha-\delta)_+}{1-\delta}.
\]

Daher

\[
P_k(B_k)=\frac{E_{k-1}[(\alpha_k-\delta_k)_+]}{1-\delta_k}.
\]

Die erste Momentenschranke folgt aus Lemma 2.1(c):

\[
P_k(B_k)\le P_{k-1}(B_k)=E_{k-1}[\alpha_k]=M_k^{(1)}.
\]

Für \(\delta>0\) und \(t\ge0\) gilt

\[
(t-\delta)_+\le\frac{t^2}{4\delta}.
\]

Für \(t\le\delta\) ist dies unmittelbar; für \(t>\delta\) ist die Differenz
\[
\frac{t^2}{4\delta}-(t-\delta)=\frac{(t-2\delta)^2}{4\delta}\ge0.
\]
Damit folgt

\[
P_k(B_k)\le\frac{M_k^{(2)}}{4\delta_k(1-\delta_k)}.
\]

Bei \(\delta_k=0\) wird dieser Quotient nicht ausgewertet; man verwendet nur die erste Momentenschranke. Summiert man über die Stufen und verwendet die Maßbilanz aus Lemma 2.1,

\[
P_n(R_n)\ge1-\sum_{k=a+1}^nP_k(B_k),
\]

so beweist

\[
\sum_{k=a+1}^n\min\!\left\{M_k^{(1)},
\frac{M_k^{(2)}}{4\delta_k(1-\delta_k)}\right\}<1
\quad\Longrightarrow\quad P_n(R_n)>0,
\]
mit dem beschriebenen Nullfall. Also kann die Hyperflächenfamilie den gesamten Kasten nicht bedecken.

### 30.6 Rekursion und endlicher Anfang

Aus der Definition des Polynoms folgt durch Abspalten der letzten Koordinate

\[
\boxed{c_k(z)=c_{k-1}(z)\left(1+\frac{z}{(1-\delta_k)|S_k|}\right).}
\]

Für die frühen Primstufen nach der Kodimension-eins-Reduktion ist \(|S_k|=p_k-1\) und die verbesserte Zweitmomentschranke zulässig. Der exakte Parameterbeweis von Lemma 5.3 liefert \(\mu_{21}>0\) und \(f_{21}<138.874\) mittels einer festen rationalen Verzerrungsfolge und zweier exakter Randprüfungen. Für die großen Primstufen wird die allgemeine Schranke verwendet; Corollary 5.2 prüft die ganze Tail-Rekursion mit ganzzahliger Arithmetik bis Primzahlindex 14 Millionen und schließt mit dem in Theorem 5.1 importierten Primzahlsatz von Dusart ab.

Diese mathematische Beweiskette ist vollständig durch die Primärquelle und die exakten Zertifikatsrekonstruktionen gedeckt. Die aktuelle Lean-Datei mit `sieve_criterion` und `sf_sieve_lt_one` ersetzt diese Beweise jedoch noch nicht: Ihre Schnittstellen sind weiterhin Axiome. Die Formalisierung muss die oben genannten tatsächlichen Objekte und Rechnungen implementieren.


## 31. Die frühe Kodimension-eins-Reduktion in Theorem 1.2 – vollständiger mathematischer Beweis

Sei \(\mathcal A_0\) eine nichtparallele nichttriviale Hyperflächenfamilie auf
\(Q=\prod_{i=2}^{N}[p_i]\), wobei \(p_2=3,p_3=5,\ldots\) die ungeraden Primzahlen sind.
Für jedes \(i=2,\ldots,21\) wird wie folgt vorgegangen.

1. Falls bereits eine Hyperfläche mit Fixmenge \(\{i\}\) existiert, wird sie gewählt. Wegen Nichtparallelität gibt es höchstens eine solche Hyperfläche: zwei verschiedene Mitglieder mit derselben Fixkoordinatenmenge wären parallel.
2. Falls keine solche Hyperfläche existiert, wird eine Kodimension-eins-Hyperfläche mit Fixmenge \(\{i\}\) hinzugefügt. Die Wahl ihres Fixwertes ist beliebig. Weil zuvor keine Hyperfläche mit dieser Fixmenge existierte, entsteht keine Parallelität; für verschiedene Koordinaten \(i\ne j\) sind die Singleton-Fixmengen \(\{i\}\ne\{j\}\).
3. Der gewählte Fixwert \(s_i\in[p_i]\) wird aus der Koordinate \(S_i=[p_i]\) entfernt. Die reduzierte Koordinate ist exakt
   \[
   S_i'=[p_i]\setminus\{s_i\},\qquad |S_i'|=p_i-1\ge2,
   \]
   da \(p_i\ge3\). Für \(i>21\) bleibt \(S_i'=[p_i]\), also \(|S_i'|=p_i\ge2\).
4. Die gewählten Singleton-Hyperflächen schneiden den reduzierten Kasten nicht und werden entfernt. Ebenso werden alle übrigen Hyperflächen verworfen, deren Fixwert an irgendeiner reduzierten Koordinate gelöscht wurde.
5. Jede verbleibende Hyperfläche hat dieselbe Fixkoordinatenmenge wie zuvor: Für jede ihrer Fixkoordinaten ist der Fixwert retained; für jede freie Koordinate bleibt die Koordinate frei. Die reduzierte Koordinate ist weiterhin nichtleer, tatsächlich von Größe mindestens zwei. Damit ist die reduzierte Hyperfläche eine echte Hyperfläche des reduzierten Produktes und ihre Fixmenge unverändert.
6. Die Restfamilie ist nichtparallel, denn gleiche Fixkoordinatenmengen nach der Reduktion wären wegen der Fixmengenerhaltung bereits vor der Reduktion gleich und damit durch die ursprüngliche Nichtparallelität identisch.
7. Die Restfamilie besitzt keine Hyperfläche mit Fixmenge \(\{i\}\) für \(i\le21\). Angenommen, eine überlebende Hyperfläche \(H\) hätte Fixmenge \(\{i\}\). Die ausgewählte Singleton-Hyperfläche \(H_i\) hat dieselbe Fixmenge. Nichtparallelität erzwingt \(H=H_i\). Aber der einzige Fixwert von \(H_i\) wurde aus \(S_i\) entfernt, also schneidet \(H_i\) den reduzierten Kasten nicht und wurde verworfen. Widerspruch.

Damit sind alle geometrischen Voraussetzungen für die frühe verbesserte Zweitmomentschranke erfüllt: für die Stufen bis Primzahl 73 gilt \(|S_i'|=p_i-1\ge2\), und es gibt keine Singleton-Fixhyperfläche an einer frühen Koordinate. Für die späteren Stufen wird die allgemeine Schranke verwendet.

Diese Reduktion ist der genaue Quellenschritt in Theorem 1.2 (publizierte Fassung, S. 610 und 620–625). Die vollständige Rekonstruktion mit der anschließenden Anfangsmaß-, Parameter- und Tail-Rechnung steht in [Theorem 1.2 der Beweisrekonstruktion](https://erdosproblems.ai/wiki/library/covering_systems/balister_2021_erdos_selfridge_problem_square_free_moduli/theorem_1_2); die Primärquelle ist Balister–Bollobás–Morris–Sahasrabudhe–Tiba, *Algebra & Number Theory* 15 (2021), 609–626, [DOI 10.2140/ant.2021.15.609](https://doi.org/10.2140/ant.2021.15.609).

**Lean-Abgrenzung:** Die mathematische Reduktion oben ist vollständig. Das neue Lean-Modul beweist derzeit die eindeutige Auswahl, die Löschwertgewinnung, die Kardinalität und die Singleton-Freiheit für eine gegebene Familie, in der für jede frühe Koordinate eine Singleton-Hyperfläche existiert. Die Konstruktion der augmentierten Familie (Schritt 2) und die exakte Äquivalenz „überlebt genau dann, wenn der Schnitt mit dem reduzierten Produkt nichtleer ist“ werden noch als eigene Lean-Lemmata ergänzt. Das ist eine Formalisierungsrestpflicht, keine offene mathematische Frage der publizierten Reduktion.

---

# XI. Nachtrag 1.4 – Öffentliche Balister-Rekonstruktion und erweiterter Kernel-Audit

**Stand: 9. November 2026.** Dieser Nachtrag erweitert die Quellen- und CI-Dokumentation. Er ändert den mathematischen APW4-Status aus Nachtrag 1.3, §25, ausdrücklich nicht.

## 31. Öffentliche Primärquellen und rekonstruierte BBMST-Beweiskette

Die maßgeblichen Originalarbeiten sind:

1. P. Balister, B. Bollobás, R. Morris, J. Sahasrabudhe, M. Tiba, *The Erdős–Selfridge problem with square-free moduli*, Algebra & Number Theory 15 (2021), 609–626, [DOI 10.2140/ant.2021.15.609](https://doi.org/10.2140/ant.2021.15.609), [arXiv:1901.11465](https://arxiv.org/abs/1901.11465).
2. P. Balister, B. Bollobás, R. Morris, J. Sahasrabudhe, M. Tiba, *On the Erdős Covering Problem: The Density of the Uncovered Set*, [arXiv:1811.03547](https://arxiv.org/abs/1811.03547).

Die Arbeit von 2021 entwickelt die frühere Dichte-/Siebmethode in einer geometrischen Produktraum-Situation. Der bewiesene Hauptsatz betrifft quadratfreie Moduli und seine geometrische Entsprechung. Er ist nicht ohne weitere Argumente auf beliebige ungerade Moduli zu erweitern.

Eine öffentliche sekundäre Beweisrekonstruktion ist unter dem unveränderlichen Commit [plasma-ai/erdos, 17c86a0d4ebe1487a087ceb8c14952a10ec2f2bd](https://github.com/plasma-ai/erdos/tree/17c86a0d4ebe1487a087ceb8c14952a10ec2f2bd/library/covering_systems/balister_2021_erdos_selfridge_problem_square_free_moduli) dokumentiert. Sie verlinkt die veröffentlichten Seiten und schreibt die Zwischenbeweise aus. Sie ist keine Originalarbeit der fünf BBMST-Autoren und kein Lean-Beweis.

Die quellengetreue Abhängigkeitskette lautet:

1. Lemma 2.1: stufenweises Faser-Siebmaß, Normierung, Erhaltung alter messbarer Mengen, globale Verzerrungsschranke und Schranke auf den neu entfernten Mengen.
2. Theorem 3.1: erster und zweiter Faser-Moment für die entfernte Masse; der Fall δ=0 wird ausschließlich mit dem ersten Moment behandelt.
3. Lemma 3.3: Hyperflächen-Massenschranke über die Anfangsprofile c(I) und das Produktgewicht ν(J).
4. Lemma 3.4: Expansion der ganzzahligen Faser-Momente in geordnete Tupel neuer Hyperflächen und Kontrolle kompatibler Schnitte.
5. Theorem 3.2: kombinatorische Auswertung der Tupelsummen und die verbesserte zweite Momentenschranke bei Abwesenheit der neuen Singleton-Fixmenge {k}.
6. Lemma 5.4: exakte endliche Anfangsverteilung auf [2]×[4]×[6]×[10].
7. Lemma 5.3: sechzehn rationale Verzerrungsparameter für die Primzahlen 13 bis 73 mit exakten rationalen Endpunktprüfungen.
8. Corollary 5.2: exakte ganzzahlige Tail-Rekursion ab p_21=73.
9. Theorem 5.1: importiertes Großprimzahl-Abbruchkriterium, dessen vollständige Herleitung in der Dichtearbeit von 2018 (Theorem 6.1 und Lemma 6.2) liegt.

Die Rekonstruktion und die Einzelverweise stehen in [APW4_BALISTER_SOURCE_RECONSTRUCTION_2026-11-09.md](APW4_BALISTER_SOURCE_RECONSTRUCTION_2026-11-09.md). Der dort verlinkte exakte Zertifikatsprüfer ist [verify_bbmst_squarefree.py](https://github.com/plasma-ai/erdos/blob/17c86a0d4ebe1487a087ceb8c14952a10ec2f2bd/library/covering_systems/balister_2021_erdos_selfridge_problem_square_free_moduli/evidence/verify_bbmst_squarefree.py).

Für eine Lean-Portierung sind die im Archiv dokumentierten Quellkorrekturen verbindlich: Theorem 3.2 benötigt nur |S_i|≥2; bei der Renormierung nach Entfernung von Masse p ist der Faktor 1/(1-p) zu verwenden; und in Lemma 5.3 gilt die Richtung μHat_k≤μ_k. Frühere abweichende Fassungen werden nicht übernommen.

## 32. Neue APW4-Kernelprüfung auf PR #67

PR #67, korrigierter Commit 33a66a8491f65616f9572a6efc8fbc91a65d6ed5:

- [APW4 canonical kernel run 42599116967](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42599116967) – erfolgreich.
- [Upstream-/Degenerationsaudit 42599116987](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42599116987) – erfolgreich.

Der kanonische Lauf kompiliert APW4CanonicalMajorization.lean, APW4HistoricalCRTCore.lean und APW4IncidenceSecondMoment.lean. Für die drei neuen Deklarationen

- incidence_bound_from_second_moment,
- offDiagonal_exceeds_reserve,
- apw4_energy_contradiction

wird jeweils genau das Standardprofil [propext, Classical.choice, Quot.sound] ausgegeben; in ihren Axiomlisten erscheint kein sorryAx.

Die Reichweite bleibt exakt deklarationsbezogen:

- incidence_bound_from_second_moment beweist die algebraische Eliminierung aus den expliziten Momenten- und Größenhypothesen. Es beweist nicht, dass historische APW4-Fasern diese Hypothesen erfüllen.
- offDiagonal_exceeds_reserve leitet die Off-Diagonal-Schranke aus Energieidentität, Diagonaltransport und strikter Untergrenze ab, die als Hypothesen übergeben werden.
- apw4_energy_contradiction formalisiert den Endwiderspruch aus Energieidentität, Diagonaltransport, Hall-Transport und strikter Untergrenze, die als Hypothesen übergeben werden.

Damit ist ein echter neuer Kernel-Schritt gelungen. Er ist aber noch kein Lean-Beweis der historischen APW4-Hauptaussage, weil die historischen Voraussetzungen nicht aus den APW4-Definitionen konstruiert werden.

Der begleitende Auditlauf kompiliert außerdem die separate Upstream-Datei ErdosSelfridge_v17_fixed.lean, AuditCheck.lean, APW4DiagonalAudit.lean und APW4CanonicalMajorization.lean. Für den separaten erdos_selfridge-Siebstrang bleiben sf_sieve_lt_one und sieve_criterion Projektaxiome. Diese beiden Axiome sind nicht Teil der Standard-Axiomprofile der drei neuen APW4-Deklarationen; der separate universelle Siebsatz ist dadurch aber noch nicht axiomfrei.

## 33. Weitere erfolgreiche BBMST-Prüfungen

### 33.1 Geometrische Kodimension-eins-Reduktion

PR #56, Commit a77f67540719a29e3e45a684e310dc4d753a2a50, bestand den [BBMST geometry kernel check 42364359726](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42364359726). Kompiliert wurden die Module zur Restriktion, Familienauswahl, Augmentation und Primkoordinateninstanziierung. Die im Log ausgegebenen Deklarationen haben das Standardprofil.

Damit sind die in v1.5, §27 noch als ausstehend markierten Auswahl-, Löschwert- und Augmentationslemmata für diesen konkreten Commit weiter formalisiert und kernelgeprüft. Die Reichweite bleibt auf die dortigen expliziten Geometriehypothesen beschränkt; der vollständige BBMST-Siebbeweis folgt daraus nicht automatisch.

### 33.2 Präfix-Massenrechnung, Schritt 16

Auf Branch fix/step16-dependent-transport-v2-2026-11-08, Commit ca9d245aa1851a54b65850ddb1130d1ca12e850e, waren die drei relevanten Läufe erfolgreich:

- [Foundation regression 42522812092](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42522812092)
- [Step 16 kernel check 42522812150](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42522812150)
- [Focused Step 16 diagnostic 42522812223](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42522812223)

Die Logs geben für die benannten Präfix-Zylinder- und Präfix-Massen-Deklarationen das Standardprofil aus. Diese Prüfungen gehören zu einem separaten Quellstand und sind nicht mit dem APW4-PR-#67-Lauf zu einem einzigen integrierten Build zusammenzufassen.

### 33.3 Rank-nine-CRT-/Faser-Audit

Auf Branch research/rank9-crt-fiber-audit-2026-10-30, Commit 098699f663a144fae5da013a425d0d32147ae1ae, bestand der Indikatorlauf 42595925019 und der Auditjob von Workflow 42595925001. Der Auditjob kompilierte die endliche Indikatorbrücke, die endlichen Siebstufenmodule, die abhängige Faserschnittstelle, die endliche CRT-Faserzerlegung, den arithmetischen ZMod-CRT-Satz und die tatsächliche Kongruenzklassen-CRT-Darstellung.

Der separate fiber-paranoid-Job in Lauf 42595925001 endete schließlich als cancelled. Er wird nicht als erfolgreicher Paranoid-Check gezählt; erfolgreich war nur der dependency-ordered Auditjob.

## 34. Aktualisierte Abschlussmatrix

| Verpflichtung | Stand am 9. November 2026 |
|---|---|
| APW4-Energiezerlegung | Mathematisch exakt; neuer abstract Lean-Endschritt kompiliert |
| Diagonaltransport DT | Mathematisch gemäß APW4-Arbeitsstand bewiesen; historische Lean-Instanziierung noch nicht im Endsatz konstruiert |
| Gewichteter Hall-Transport HT | Mathematisch gemäß APW4-Arbeitsstand bewiesen; historische Ereignis-/BIB-Platz-Zuordnung noch nicht im Endsatz konstruiert |
| Strikte APW4-Energieuntergrenze | Gemäß §25 mathematisch abgeschlossen; Lean-Übersetzung aus historischen APW4-Daten noch nicht in der Endsatzabhängigkeit |
| Endlicher Inzidenz-Zweitmomentensatz | Unter expliziten Hypothesen bewiesen und in PR #67 kernelgeprüft |
| APW4-Endwiderspruch | In Lean kernelgeprüft, aber mit DT, HT und strikter Untergrenze als Eingabehypothesen |
| BBMST-Geometrie-Reduktion | PR #56-Checkpoint erfolgreich; explizite Hypothesen und branchgebundene Reichweite bleiben ausgewiesen |
| BBMST-Präfix-Massen-Schritt 16 | Die genannten Foundation-/Step-16-Läufe erfolgreich |
| Rank-nine-CRT-/Faser-Audit | Auditjob erfolgreich; separater fiber-paranoid-Job noch ausstehend |
| Universeller erdos_selfridge-Siebstrang | Weiterhin Projektaxiome sf_sieve_lt_one und sieve_criterion |
| Integrierter APW4-Hauptsatz mit vollständigem historischem Dependency-Closure | Noch nicht durch einen einzelnen Release-Commit und einen abschließenden #print axioms-Nachweis belegt |

**Mathematischer Status:** Die strikte APW4-Untergrenze bleibt nach Nachtrag 1.3, §25 ein abgeschlossener mathematischer Beweisbaustein. Dieser Nachtrag stuft sie nicht zurück.

**Formaler Status:** Die neuen Kernelprüfungen sind reale Fortschritte. Sie reichen noch nicht für die Aussage, dass der vollständige historische APW4-Hauptsatz kernelverifiziert ist. Dafür müssen die historischen DT-/HT-Daten und die strikte Untergrenze in einem einzigen benannten Lean-Hauptsatz konstruiert und dessen transitive Axiomliste geprüft werden.

## 35. Manuskriptdatei – Integritätsbefund der zugänglichen Kopie

Die in der Library zugängliche Datei „Erdös Lean 4 Beweis.pdf“ umfasst 17 Seiten. Die gerenderte Seite 11 wurde am 9. November visuell geprüft und zeigt wörtliche LaTeX-Befehle wie \\boxed und \\mathcal anstelle gesetzter Mathematik. Auch die Textextraktion lässt an mehreren Formeln Relationszeichen aus. Diese Feststellung betrifft ausschließlich diese konkrete Library-Kopie und nicht eine separate, vom Autor unabhängig gesicherte Publikationsfassung.

Die geprüfte Library-Kopie wird deshalb nicht als finales typeset Manuskript erneut ausgegeben. Es wurde weder die unabhängig verwahrte Publikationsfassung verändert noch eine neue Manuskriptfassung mit fehlenden historischen Zwischenschritten erfunden.

---

**Schlussurteil Nachtrag 1.4:** Der öffentliche BBMST-Quellenpfad ist jetzt konkret und quellengebunden rekonstruiert; mehrere weitere BBMST- und APW4-Teilmodule haben erfolgreiche Kernelprüfungen. Der mathematische APW4-Abschluss gemäß §25 bleibt bestehen. Eine vollständige, integrierte Kernelverifikation des historischen APW4-Hauptsatzes ist weiterhin nicht nachgewiesen und wird erst nach Konstruktion aller historischen Prämissen im Dependency-Closure des Endsatzes behauptet.


## 36. Präzisierung der Balister-Theorem-1.2-Reduktion

Die öffentliche Beweisrekonstruktion zu Theorem 1.2 macht die geometrische Reduktion vor dem Faser-Momentenargument vollständig explizit: fehlende frühe Singleton-Hyperflächen ergänzen, Nichtparallelität erhalten, je einen ausgewählten Koordinatenwert entfernen, Hyperflächen auf das reduzierte Produkt einschränken und die überlebende Überdeckung ohne frühe Singleton-Fixmengen erhalten.

Dieser Reduktionsschritt ist im aktuellen PR-#56-Quellstand durch BBMSTCodimOneReduction, BBMSTCodimOneFamily, BBMSTCodimOneAugmentation und BBMSTPrimeCoordinateInstantiation konkret formalisiert. Insbesondere liefert canonicalReduction_result die reduzierte Überdeckung samt Singleton-Freiheit; reduced_coordinate_card_ge_two stellt für ungerade Primkoordinaten sicher, dass nach Entfernung eines Wertes mindestens zwei Werte bleiben. Der frühere Geometrie-Checkpoint wurde auf Commit a77f67540719a29e3e45a684e310dc4d753a2a50 in CI 42364359726 erfolgreich kompiliert. Die inzwischen ergänzte vollständige Theorem-1.2-Ausgabe mit erhaltener Nichtparallelität und Nichttrivialität wurde zusätzlich auf dem aktualisierten PR-#56-Branch in CI 42601107408 erfolgreich kompiliert.

Damit ist die in v1.5 noch offene Lean-Reduktionsstufe aus §27 für diese explizite geometrische Schnittstelle geschlossen. Nicht geschlossen ist damit die Integration dieser Reduktion mit sämtlichen Faser-Momenten- und Tail-Modulen in einem gemeinsamen Build; erst recht ist dadurch noch nicht der APW4-spezifische DT-/HT-/Energie-Transfer bewiesen. Die mathematische APW4-Abschlussaussage aus §25 bleibt unverändert.


## 37. Präzisierung: vollständige geometrische Reduktion aus BBMST Theorem 1.2

Die in der öffentlichen Rekonstruktion ausgeschriebene Theorem-1.2-Reduktion besteht aus der Ergänzung fehlender früher Singleton-Hyperflächen, der Erhaltung der Nichtparallelität, dem Löschen je eines ausgewählten Wertes in den frühen Primkoordinaten, der Restriktion der überlebenden Hyperflächen und der daraus folgenden Überdeckung des reduzierten Produkts ohne frühe Singleton-Fixmengen.

Diese Schritte sind im PR-#56-Quellstand durch BBMSTCodimOneReduction, BBMSTCodimOneFamily, BBMSTCodimOneAugmentation und BBMSTPrimeCoordinateInstantiation formalisiert. Insbesondere canonicalReduction_result liefert die reduzierte Überdeckung samt Singleton-Freiheit; reduced_coordinate_card_ge_two stellt für ungerade Primkoordinaten sicher, dass nach Entfernung eines Wertes mindestens zwei Werte bleiben. Die benannten Deklarationen wurden auf Commit a77f67540719a29e3e45a684e310dc4d753a2a50 in [CI 42364359726](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42364359726) erfolgreich kompiliert und mit ihren Axiomprofilen ausgegeben.

Der frühere PR-#56-Checkpoint kompilierte Cover-Erhaltung und Singleton-Freiheit. Die ergänzte vollständige Theorem-1.2-Ausgabe mit Nichtparallelität und Nichttrivialität der überlebenden Familie wurde nun in CI 42601107408 erfolgreich kompiliert. Die Axiomspur gibt für canonicalReduction_result_full und die neuen Hilfslemmata ausschließlich [propext, Classical.choice, Quot.sound] aus; sorryAx erscheint nicht. Dieser vollständige geometrische Reduktionsschritt ist damit auf dem geprüften Commit kernelverifiziert. Noch nicht in einem gemeinsamen Build integriert ist die Verbindung mit sämtlichen Faser-Momenten- und Tail-Modulen. Ebenso wenig folgt daraus der APW4-spezifische DT-/HT-/Energie-Transfer. Der mathematische APW4-Abschluss aus §25 bleibt unverändert.


## 38. Zweite Manuskriptdatei: Abgrenzung zwischen Kurzfassung und Vollmanuskript

Zusätzlich zur 17-seitigen Datei „Erdös Lean 4 Beweis.pdf“ liegt die dreiseitige Datei „Erdös Lean Deutsch.pdf“ vor. Ihre PDF-Seiten sind typografisch lesbar, sie ist aber eine Kurzfassung: Sie enthält Energiezerlegung und die Aussagen DT, HT sowie die strikte Untergrenze nur in zusammengefasster Form. Die historischen Faserabbildungen, die gewichtete Hall-Inzidenz, die vollständigen arithmetischen Zwischenschritte und die vollständigen Beweise werden darin nicht ausgeführt. Außerdem enthält sie eine verkürzte BIB-Reserveformel, deren Gleichsetzung mit der in v1.5 verwendeten Reserve nicht ungeprüft übernommen werden darf.

Daher gilt:
- Die dreiseitige Datei ist eine Übersicht, nicht das vollständige APW4-Forschungsmanuskript.
- Die siebzehnseitige Datei ist in der zugänglichen Library-Kopie an mindestens einer gerenderten Seite typografisch beschädigt (wörtliche LaTeX-Befehle).
- Keine der beiden Library-Dateien wird als fertiges Vollmanuskript erneut veröffentlicht oder inhaltlich ergänzt, solange die vollständige historische Beweisexposition und eine saubere typeset Quelldatei nicht vorliegen.
- Diese Dateibefunde betreffen nur die beiden konkreten Library-Kopien und ändern den mathematischen APW4-Status aus §25 nicht.


## 39. Präzisierung: Balister Theorem 1.1 und die formale CRT-Inzidenz

Die öffentliche Rekonstruktion von BBMST Theorem 1.1 beschreibt die exakte endliche CRT-Äquivalenz zwischen einer Überdeckung durch paarweise verschiedene quadratfreie Restklassen mit Moduli \(d_i>1\) und einer nichtparallelen, nichttrivialen Hyperflächenüberdeckung in einem Produkt über ungeraden Primzahlen. Die Bedingung \(d_i>1\) entspricht einer nichtleeren Fixkoordinatenmenge und darf nicht entfallen.

Die formale CRT-Kette liegt im rank-nine-Branch:
- BBMSTArithmeticCRT.crtEquiv, crt_cover_iff_every_fibre und not_cover_of_uncovered_fibre;
- BBMSTCongruenceCRT.congruence_cover_iff_every_fibre, uncovered_residue_of_uncovered_fibre, actual_cross_layer_moduli_disjoint, projected_modulus_has_at_most_two_sources, fibre_capacity_at_base und full_fibre_cover_forces_capacity;
- BBMSTFiniteProjection.fiberEquiv und fiber_mass_sum.

Besonders relevant ist BBMSTCongruenceCRT.global_allocation_lower_bound zusammen mit incidence_card_eq_sum_of_class_supports und complete_cover_implies_global_support_inequality. Diese Sätze liefern eine exakte ungewichtete endliche Inzidenz-/Doppeltzählungsbilanz: Eine vollständige Zuordnung aller Paare aus alten unbedeckten Basisresten und neuen Koordinatenresten erzwingt eine Mindestzahl von Inzidenzen, die zugleich als Summe der Stützmengen der neuen Klassen gezählt wird.

Das ist ein mathematisch echter Inzidenzbaustein und eine mögliche strukturelle Vorstufe für Kapazitätsargumente. Er ist aber nicht mit dem APW4-gewichteten Hall-Satz gleichzusetzen: Die Deklarationen konstruieren weder die APW4-gewichteten Ereignisse noch die BIB-Platzkapazitäten noch die historische APW4-Ereignis-zu-Platz-Abbildung. Insbesondere folgt aus einer ungewichteten Kardinalitätsbilanz nicht automatisch die gewichtete Reserve \(\mathcal R_{\mathrm{BIB}}\).

Der dependency-ordered Auditjob von CI 42595925001 hat die CRT-, Kongruenzklassen- und Faser-Module erfolgreich kompiliert und die benannten Axiomprofile ausgegeben. Der getrennte fiber-paranoid-Job endete als cancelled und wird nicht als erfolgreicher Paranoid-Check gezählt.


## 40. Integrierter BBMST/APW4-Prüfzweig PR #69

Um die bisher getrennten Quellstände nicht länger nur anhand separater CI-Protokolle zu vergleichen, wurde PR #69 eröffnet: [Integrate BBMST geometry, fibre, CRT, prefix-mass and APW4 audit modules](https://github.com/s4ztz4bnf6-maker/Lubuimi-/pull/69).

Der Branch integration/bbmst-apw4-kernel-2026-11-09 führt 34 BBMST-/APW4-Module aus den zuvor getrennten Präfix-Massen-, rank-nine-CRT-/Faser-, Geometrie- und APW4-Arbeitsständen in einer isolierten Lean-4.35.0-Prüfpaketstruktur zusammen. Der Aggregator ResearchKernelAudit importiert alle Module; zusätzlich sind alle 34 Quelldateien ausdrücklich als Library-Roots eingetragen. Die Workflow-Stufe führt zuerst lake build ResearchKernelAudit und danach lake check --paranoid aus. Damit wird verhindert, dass ein Aggregat ohne geprüfte Deklarationen fälschlich als erfolgreiche Paranoid-Prüfung gilt.

Der aktuelle integrierte Lauf ist [CI 42600825252](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42600825252). Zum Zeitpunkt dieses Nachtrags war der isolierte 4.35.0-Paranoidjob noch beim Mathlib-Cache bzw. beim Build; der separate Auditjob hatte den Upstream-Compile abgeschlossen und arbeitete die BBMST-Modulkette ab. Es wird noch kein Erfolg für den integrierten Paranoid-Check behauptet.

Die Integration ist ein Prüf- und Konsolidierungsbranch. Sie ändert weder die historischen Definitionen noch den mathematischen Status aus §25. Selbst ein erfolgreicher Build aller 34 Module würde die APW4-spezifischen DT-/HT- und strikten Untergrenzenprämissen nicht automatisch konstruieren: der gegenwärtige APW4-Endwiderspruch nimmt diese weiterhin als Eingabehypothesen. Der universelle erdos_selfridge-Strang wird separat auditiert und behält seine ausgewiesenen Projektaxiome.


---

# XII. Nachtrag 1.5 – Review-Korrektur und letzter Repository-Stand
**Aktualisierung: 9. November 2026**
**Autor: Ta-Yoshua Lubuimi**

## 41. Verbindliche mathematische Statuskorrektur

Dossier v1.5, Nachtrag 1.3, §25 bleibt die maßgebliche Statusfeststellung: Die strikte APW4-Energieuntergrenze wird als mathematisch abgeschlossen geführt. Sie wird weder durch spätere redaktionelle Durchsicht noch durch den begrenzten Umfang einzelner Lean-Deklarationen zurückgestuft.

Die Aussage ist stets unter den vollständigen historischen APW4-Hypothesen zu lesen:
[
B(M)=2M-sigma(M)le 0
quadLongrightarrowquad
mathcal E_{mathrm{APW4}}>
D_k^{mathrm{BBMST}}+mathcal R_{mathrm{BIB}}.
]
Sie darf nicht als reine Aussage über die Teilersummenfunktion für beliebige (M) formuliert werden. Insbesondere zeigt das quadratfreie Beispiel
[
M=15015=3cdot5cdot7cdot11cdot13,quad
sigma(M)=32256,quad B(M)=-2226
]
dass das Vorzeichen (B(M)le0) allein keine allgemeine Ausschlussaussage liefert. Das Beispiel hebt den in §25 festgehaltenen APW4-Status nicht auf; es verlangt, dass die zusätzlichen historischen APW4-Voraussetzungen im Hauptsatz vollständig genannt und die zugehörige Herleitung im Beweistext ausgeschrieben werden.

## 42. Review-korrigierte Manuskriptfassung

Die am 9. November 2026 über PR #71 nach main übernommene Datei
`publication/APW4_REVISED_MAIN_MANUSCRIPT_REVIEW_2026-11-09.md`
ist die review-korrigierte redaktionelle Arbeitsfassung. Sie beweist vollständig:
- die exakte Energiezerlegung einschließlich der Zählung geordneter Off-Diagonalpaare;
- die abstrakte endliche kapazitätsbeschränkte Transportimplikation;
- den gewichteten Hall-/Max-Flow-Min-Cut-Schluss unter der ausdrücklich formulierten Hall-Bedingung;
- die BIB-Paarzählidentität;
- den endlichen Inzidenz-Zweitmomentensatz unter den expliziten Voraussetzungen (H1) und (H2);
- den bedingten algebraischen Energie-Widerspruch.

Die Fassung ersetzt nicht die historischen APW4-Definitionen und behauptet nicht, dass die abstrakten Transportlemmata bereits aus den historischen APW4-Daten instanziiert wurden. Für eine selbstständig prüfbare historische Hauptsatzfassung müssen die tatsächlichen APW4-Faserobjekte, DT-Transportmassen und Zielkapazitäten, HT-Ereignisse, BIB-Plätze, Inzidenzen, Kapazitäten sowie die vollständige strikte Untergrenzenherleitung aus dem maßgeblichen Originalbeweistext eingefügt werden. Diese Expositionspflicht ist von der in §25 dokumentierten mathematischen Statusfeststellung getrennt.

## 43. Korrigierter integrierter CI-Status von PR #69

PR #69 ist offen und nicht erfolgreich integriert. Die dokumentierte Chronologie lautet:
- Run `42601494591`: integrierter Build fehlgeschlagen, unter anderem wegen des abhängigen Index-/Cast-Schritts in `BBMSTGeometryStageCore.lean`.
- Run `42602474355`: integrierter Build fehlgeschlagen; `BBMSTMomentRecurrence.lean:118` meldet `Finset.prod_le_prod₀` als nicht verfügbare Konstante; zwei davon abhängige Deklarationen zeigen `sorryAx`.
- Run `42602465766`: kein erfolgreicher integrierter Abschluss.
- APW4-only All-roots run `42600819647`: cancelled.

Die am PR-#69-Branch vorgenommenen Reparaturen sind Kandidaten und gelten erst nach einem erfolgreichen Ersatzlauf mit positiver Deklarationsabdeckung, bestandenem Paranoid-Check und geprüften Axiomspuren als verifiziert. Ein solcher Erfolg wird in diesem Nachtrag nicht behauptet.

## 44. Gültige positive CI-Befunde bleiben commit- und deklarationsgebunden

Die folgenden Befunde bleiben gültig:
- PR #67, Commit `33a66a8491f65616f9572a6efc8fbc91a65d6ed5`, Runs `42599116967` und `42599116987`: die benannten APW4-Inzidenz- und bedingten Widerspruchsdeklarationen berichten das Standardprofil `[propext, Classical.choice, Quot.sound]`; der Endwiderspruch nimmt DT, HT und die strikte Untergrenze als Hypothesen entgegen.
- PR #56, Commit `a77f67540719a29e3e45a684e310dc4d753a2a50`, Run `42601107408`: die benannte vollständige geometrische Theorem-1.2-Reduktion und ihre Hilfsdeklarationen berichten das Standardprofil ohne `sorryAx).
- Prefix-Mass Step 16, Commit `ca9d245aa1851a54b65850ddb1130d1ca12e850e`, Runs `42522812092`, `42522812150`, `42522812223`: die benannten Foundation-, Step-16- und Diagnoseprüfungen waren erfolgreich.
- Rank-nine CRT/fibre commit `098699f663a144fae5da013a425d0d32147ae1ae`: der dependency-ordered Auditjob `42595925001` bestand; der separate fiber-paranoid-Job endete cancelled und wird nicht als bestanden gezählt.

Diese Ergebnisse stammen aus getrennten Quellständen und Workflows. Sie sind keine integrierte Verifikation des historischen APW4-Hauptsatzes.

## 45. Dokumentationsmerge PR #71

PR #71 wurde am 9. November 2026 in `main` gemergt; Merge-Commit:
`e3367c818a8d682dc943a21c4031cbc966a070a9`.
Es handelt sich um eine Dokumentations- und Review-Korrektur, nicht um eine neue Lean-Quelländerung und nicht um einen neuen Kernel-/CI-Erfolg. Die dort ergänzte externe Review-Antwort hält die Beweisgrenzen, den quadratfreien Testwert (M=15015), die conditional nature des APW4-Endschlusses und die fehlgeschlagene integrierte PR-#69-Prüfung fest.

## 46. Abschließendes Urteil zum Stand 9. November 2026

**Mathematischer Status:** Energiezerlegung, DT, HT, globale obere Energieschranke und strikte Untergrenze werden gemäß dem maßgeblichen APW4-Arbeitsstand und Dossier §25 als abgeschlossene mathematische Ergebnisse geführt. Der Widerspruch folgt, wenn die vollständigen historischen APW4-Hypothesen erfüllt sind.

**Expositionsstatus:** Die review-korrigierte Hauptfassung beweist die abstrakten endlichen Transport- und Inzidenzlemmata. Die vollständige historische Instanziierung von DT und HT sowie die vollständige ausgeschriebene Herleitung der strikten Untergrenze müssen im selbstständig prüfbaren Manuskript aus den maßgeblichen APW4-Primärbeweisen dokumentiert werden. Eine Statusnotiz ersetzt diese Beweisexposition nicht.

**Lean-Status:** Die benannten Teildeklarationen haben echte erfolgreiche Kernel-/Axiomprüfungen. Der integrierte PR #69 ist fehlgeschlagen; ein vollständiger historischer APW4-Hauptsatz mit sämtlichen historischen Prämissen in seiner transitiven Lean-Abhängigkeit ist nicht nachgewiesen. Der separate universelle `erdos_selfridge`-Siebstrang behält seine Projektaxiome `sf_sieve_lt_one` und `sieve_criterion`.

**Attribution:** Sämtliche APW4-Forschung und Urheberschaft sind Ta-Yoshua Lubuimi zugeordnet. KI-Werkzeuge sind Hilfsmittel, keine Autoren und keine unabhängigen mathematischen Prüfer.


## Addendum 1.15 — PR #79 continuity and exact-head repair ledger, 10 November 2026

The APW4 mathematical status is preserved exactly as corrected in PR #79. Established APW4 results are not invalidated by later integration failures. The published finite valuation-word cylinder theorem in PR #36 is not reopened. Historical reconstruction, mathematical proof and Lean/CI status remain separate.

PR #101's updated source head is `f5aff142fcdf6c3893ef1c890f3be45a67da68aa`. The previous attempt made covered-set nonmembership explicit but left the second conditional for membership in `Finset.univ` unresolved. The new proof supplies that membership explicitly and rewrites both branches. Workflow [42755782237](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42755782237) was queued at this snapshot; no new Lean PASS is claimed.

PR #93's generic dyadic residue-cylinder model proves finite lift/cardinality/mass identities for arbitrary residue (r). Its separate `FibreData` wrapper is cardinality-only. The remaining formal task is to instantiate (r) by the already-derived normalized prefix-tail residue and prove exact equivalence between the child residue classes and next-valuation predicates. This formalization gap does not reopen the existing mathematical finite-word cylinder theorem.

The APW4 energy decomposition, DT, weighted HT, global upper energy estimate and strict lower-bound implication remain established under their stated full historical hypotheses. No later CI failure changes those mathematical claims.
