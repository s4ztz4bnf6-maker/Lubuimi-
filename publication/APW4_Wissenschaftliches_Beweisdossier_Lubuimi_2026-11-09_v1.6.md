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


---

# XIII. Nachtrag 1.6 – Kontinuität des mathematischen APW4-Status und CI-Abgleich

**Stand: 10. November 2026 · Autor: Ta-Yoshua Lubuimi**

## 47. Verbindliche Fortführung des mathematischen Beweisstands

Der mathematische APW4-Status aus Nachtrag 1.3, §25, Nachtrag 1.5, §§41 und 46, und der konsolidierten Fassung v1.6 bleibt bestehen. Die strikte Untergrenze wird als abgeschlossener mathematischer Beweisbaustein geführt. Ebenso werden DT, HT und der globale obere Energieschluss als hergeleitete mathematische Resultate des APW4-Forschungsstands fortgeführt. Zusammen gilt unter den vollständigen historischen APW4-Hypothesen:

\[
\mathcal E_{\rm APW4}=D_{\rm APW4}+C_{\rm APW4},\qquad
D_{\rm APW4}\le D_k^{\rm BBMST},\qquad
C_{\rm APW4}\le\mathcal R_{\rm BIB},
\]

und die strikte Untergrenze

\[
B(M)=2M-\sigma(M)\le0
\Longrightarrow
\mathcal E_{\rm APW4}>D_k^{\rm BBMST}+\mathcal R_{\rm BIB}
\]

liefert den Widerspruch. Die Aussage ist stets mit den vollständigen historischen APW4-Hypothesen zu lesen; sie wird nicht zu einer voraussetzungslosen Aussage allein über \(B(M)\) verkürzt.

Ein späterer CI-Fehler, eine unvollständige Repository-Datei oder eine redaktionelle Prüffassung setzt diesen mathematischen Status nicht zurück. Der unabhängig finalisierte und veröffentlichte Manuskriptstand des Autors bleibt die maßgebliche Publikationsfassung. Die review-korrigierte Datei vom 9. November ist eine zusätzliche Expositions- und Verifikationsfassung und ersetzt nicht stillschweigend die unabhängig gesicherte Publikationsfassung.

## 48. Historische APW4-Objekte – Kontinuität und Definitionsschutz

Die historischen APW4-Objekte sind aus dem vorhandenen Forschungsrecord und Manuskript unverändert fortzuführen. Insbesondere bleiben die Faser-/Inzidenzobjekte

\[
B_q=N/q^{a_q},\qquad
V_q=\{z:z\bmod B_q\in U_q\},
\]
\[
P_{q,x,h}=F_q(x)\cap C_h,
\qquad
P_{r,y,g}=F_r(y)\cap C_g,
\]
\[
M_{q,r}((x,h),(y,g))
=|P_{q,x,h}\cap P_{r,y,g}|,
\qquad
\Gamma_{q,r}(g)=|C_g\cap V_q\cap V_r|
\]

sowie die dazugehörigen historischen Gewichte, Blockindizes, Matrizen und Summenobjekte Teil der APW4-Definitionskette. Insbesondere dürfen \(W_{q,r}\), \(a_{q,t}\), \(A_q\), \(A_r\) und die historischen Atom-/Faserabbildungen nicht durch ähnlich aussehende kanonische Modellobjekte ersetzt oder mit diesen identifiziert werden, ohne die bereits verwendete indexerhaltende Definition zugrunde zu legen.

Die kanonischen endlichen Faser- und CRT-Module sind formale Bausteine. Sie sind weder eine Neudefinition der historischen Objekte noch ein Grund, ältere mathematische Herleitungen aus dem Manuskript zu verwerfen. Bei jeder weiteren Konsolidierung werden die bereits verwendeten Originaldefinitionen und die getrennten Diagonal-, Off-Diagonal- und BIB-Massen beibehalten.



### Original transport interfaces retained from the publication manuscript

The diagonal transport uses the historical index-preserving map
\[
(x,u)\longmapsto(k,I_{x,u},J_{x,u}).
\]
The meanings of \(I_{x,u}\) and \(J_{x,u}\), the source index sets, and the BBMST weights are those of the author's original APW4 manuscript; they are not redefined by the canonical finite-fibre Lean model.

For the weighted off-diagonal transport, each event \(\gamma=(\ell,\ell')\) carries demand
\[
d(\gamma)=\omega_\ell\omega_{\ell'}.
\]
For every finite event family \(X\), the historical weighted Hall condition is
\[
\sum_{\gamma\in X}d(\gamma)
\le
\sum_{b\in\Gamma_{\mathrm{BIB}}(X)}c_{\mathrm{BIB}}(b).
\]
The finite weighted Max-Flow-Min-Cut theorem supplies the transport. The event, BIB-place, incidence and capacity definitions are those fixed by the original APW4 source material; no replacement event or capacity model is introduced here.


## 49. Commitgebundene CI-Chronologie bis 10. November

### Gültige frühere Erfolge

- PR #67, Commit `33a66a8491f65616f9572a6efc8fbc91a65d6ed5`, Runs [42599116967](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42599116967) und [42599116987](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42599116987): die benannten APW4-Inzidenz- und bedingten Endschlussdeklarationen wurden kompiliert und mit dem Standardprofil \([\text{propext},\text{Classical.choice},\text{Quot.sound}]\) auditiert. Die Voraussetzungen des bedingten Endschlusses bleiben seine expliziten Eingaben.
- Run [42522617494](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42522617494): die im Workflow aufgeführten BBMST-Faser-, Präfix-, Hyperflächen-, Momenten- und Rekursionsmodule wurden in diesem Quellstand erfolgreich durchlaufen.
- PR #56, Run [42601107408](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42601107408): der benannte geometrische Theorem-1.2-Reduktionscheckpoint bestand auf seinem eigenen Commit.

Diese Erfolge bleiben für die jeweiligen Commits, Deklarationen und Prüfumfänge gültig. Sie werden nicht durch spätere abgebrochene oder fehlgeschlagene Integrationsversuche entwertet.

### Abgebrochene und fehlgeschlagene Integrationsläufe

- Run [42715535258](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42715535258) wurde zunächst abgebrochen; der integrierte Build-Schritt wurde im ursprünglichen Versuch übersprungen. Beim erneuten Start des integrierten Jobs wurde der ältere Merge-Stand tatsächlich gebaut, scheiterte aber an Elaborationfehlern in `BBMSTPrefixMeasureRecursion.lean` und `BBMSTHyperplaneFibreIncidence.lean`. Der separate Audit-Retry wurde vor seinen Kompilierungsschritten abgebrochen.
- Run [42716161232](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42716161232) prüfte PR #69, Head `677b84c0a24a4959adc1ecc9cd35ea818d282365`. Der integrierte Job erreichte `lake build ResearchKernelAudit` und elaborierte mehrere APW4-Module mit den dort ausgegebenen Standardprofilen. Er scheiterte anschließend in `BBMSTMomentRecurrence.lean:118` an der nicht synthetisierbaren Instanz `MulLeftMono ℚ`; abhängige Deklarationen zeigen im Fehler-Recovery `sorryAx`. Der Audit-Job wurde während des Mathlib-Cache-Schritts abgebrochen. Ein abgeschlossener erfolgreicher `lake check --paranoid` liegt für diesen Lauf nicht vor.
- Der Audit-Retry von Run 42716161232 wurde am 10. November abgeschlossen. Er kompilierte den Upstream-Quellstand, die fokussierten Degenerationsprüfungen, den zero-safe Parameter-/Faserkern, das endliche gewichtete Update, die Uniformkoordinateninstanziierung, die endlichen Momentenschranken, die endliche Geometrie und die Uniformstufen-Momenteninstanziierung. Er scheiterte danach in BBMSTPrefixMeasureRecursion.lean an den Zeilen 174, 333 und 356. Die Diagnose zeigte sorryAx in prefixExtensionEquiv, sum_prefix_eq_sum_extensions, PAt_nonneg und PAt_sum_eq_one. Ein Quell-Cleanup wurde anschließend als Kandidatenreparatur auf PR #69 Commit 263b9b53f6888d4a149d341653043b09d745eab6 committed; eine erfolgreiche CI-Prüfung dieses Commits ist noch nicht nachgewiesen.

Ein neuer PR-#69-Lauf [42718994622](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42718994622) wurde auf dem Kandidatencommit 263b9b53f6888d4a149d341653043b09d745eab6 gestartet. Zum Abrufzeitpunkt waren sowohl integrated-paranoid als auch audit aktiv; beide hatten Lean-/Cache-Setup erfolgreich abgeschlossen und mit der jeweiligen Kompilierungsphase begonnen. Dieser Lauf ist ausdrücklich noch nicht abgeschlossen; aus dem laufenden Status wird kein Erfolg abgeleitet.

### Konkreter Integrationsreparaturschritt

Der Fehler in `BBMSTMomentRecurrence.lean` ist ein Lean-Order-Instanzproblem bei rationalen Zahlen, kein Gegenbeweis gegen die endliche Produktabschätzung. Die Quellreparatur muss den Produktvergleich durch Induktion über die endliche Produktlänge und Multiplikation mit nichtnegativen Faktoren beweisen. Danach sind Build, positiver Deklarationsumfang, `lake check --paranoid` und transitive `#print axioms` erneut auf demselben unveränderlichen Commit zu prüfen.

**Status:** Frühere erfolgreiche APW4-/BBMST-Checks bleiben gültig. PR #69 ist weiterhin offen; ein integrierter grüner Lean-4.35.0-Paranoidlauf ist zum Stichtag nicht nachgewiesen.

## 50. Fortführungsregel

Die nächste Arbeit baut auf den vorhandenen mathematischen Ergebnissen und historischen Definitionen auf. Es wird nicht erneut die Energiezerlegung, DT, HT oder die strikte Untergrenze als offene Mathematik behandelt, nur weil eine bestimmte Lean-Integration noch Arbeit benötigt. Die Formalisierung soll die bereits vorhandenen Beweise quellengetreu abbilden und die erfolgreichen Teilprüfungen in einen gemeinsamen Release-Commit überführen.


## 51. Final result of candidate run 42718994622 and next exact commit

Run [42718994622](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42718994622) has now completed with failure in both jobs. The failure is localized and is not a mathematical refutation of APW4.

**Integrated-paranoid job.** Lean 4.35.0 setup, sandbox installation and Mathlib cache restoration succeeded. The integrated build then reported:
- BBMSTMomentRecurrence.lean:118 — failed synthesis of MulLeftMono ℚ;
- BBMSTPrefixMeasureRecursion.lean:171, 333 and 356 — unsolved dependent-prefix/recursion goals and an unreachable trailing tactic;
- BBMSTHyperplaneFibreIncidence.lean:347 and 454 — unresolved equalities of finite-coordinate cardinalities.

Because lake build ResearchKernelAudit failed, the shell did not proceed to a completed lake check --paranoid result. The command is present in the workflow script/log, but no successful paranoid result exists.

**Audit job.** The audited upstream source, focused degenerate-witness tests, zero-safe parameter/fibre cores, finite weighted update, uniform-coordinate instantiation, finite-stage moment bounds, finite-coordinate geometry and uniform-stage source-moment instantiation all completed. The job then failed in BBMSTPrefixMeasureRecursion.lean at line 171 (dependent coordinate equality), line 333 (the updated PAt recursion equality) and line 356 (a tactic after the goal was already closed). Error-recovery output showed sorryAx in dependent declarations; those are failed elaborations and are not valid axiom profiles.

**Candidate repairs after that run.** Two source-level changes have been committed on PR #69:
- f4f6fb5210d080a08fbf72682a29718d95af4a1e replaces the rational Finset product monotonicity call with an induction intended to use positivity of the factors, avoiding the unavailable global MulLeftMono ℚ instance.
- 6c34cd1d4f7487c200a04a4f1cc90010ceb19643 adds explicit dependent-prefix proof handling and proof-irrelevance equalities in the prefix recursion.

The exact current PR #69 head is 6c34cd1d4f7487c200a04a4f1cc90010ceb19643. New run [42720062719](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42720062719) has started on that head and is in progress. No result is claimed until both jobs finish and their logs are inspected.

The earlier successful runs 42599116967, 42599116987, 42522617494 and 42601107408 remain valid for their exact checked commits and scopes. The mathematical APW4 results recorded in this dossier — energy identity, DT, HT, global upper energy estimate and strict lower-bound contradiction under the complete historical hypotheses — remain unchanged.


## 52. Candidate run 42720062719 and current source head

Run [42720062719](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42720062719) is the next verification snapshot. Its integrated-paranoid job completed with failure; its audit job was still running at the time of this update.

The integrated job confirmed that the source-level candidate fixes had moved the diagnostics:
- BBMSTMomentRecurrence.lean:136 — argument order mismatch in the positive-factor product induction (the nonnegative left factor and right product were supplied in the wrong order to mul_le_mul);
- BBMSTPrefixMeasureRecursion.lean:176, 187, 211, 338 and 361 — remaining dependent prefix-coordinate and recursion proof obligations;
- BBMSTHyperplaneFibreIncidence.lean:347 and 454 — stage-coordinate cardinality equalities.

The product-induction argument order has now been corrected. The prefix proof has been refined with explicit dependent-coordinate handling, direct expansion of the covered-value equivalence, and proof-irrelevance equalities. The hyperplane moment identities now use an explicit equality of the two stage-coordinate indices.

These changes are committed on PR #69 at current head 5b645d776ebbf7a71b7370f1b0078c711f9af651. New exact-head run [42720690874](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42720690874) has been queued and is pending. No success is claimed until its integrated and audit jobs complete. The earlier successful APW4 checks and the mathematical status in this dossier remain unchanged.


## 53. Completed audit result for run 42720062719

The audit job of run 42720062719 has now completed with failure in BBMSTPrefixMeasureRecursion.lean at lines 338 and 361. Importantly, it passed the audited upstream source, focused degenerate-witness tests, zero-safe parameter and fibre cores, finite weighted update, uniform-coordinate instantiation, finite-stage first/second moment bounds, finite-coordinate geometry, and uniform-stage source-moment instantiation. The remaining audit failure is therefore localized to the source-indexed prefix recursion proof.

The integrated job of the same run failed at BBMSTMomentRecurrence.lean:136 (argument order for the two nonnegativity premises of mul_le_mul), prefix recursion lines 176/187/211/338/361, and hyperplane-coordinate moment equalities at BBMSTHyperplaneFibreIncidence.lean:347/454.

The next source head 5b645d776ebbf7a71b7370f1b0078c711f9af651 corrects the product argument order, makes the prefix covered-value equivalence explicit, resolves the dependent prefix-index proof goals, and identifies the two stage-coordinate indices. Run [42720690874](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42720690874) is in progress on that exact head. No success is claimed yet.


---

# XIV. Nachtrag 1.7 – Exakter Status des PR-#69-Runs 42720062719

**Aktualisierung: 10. November 2026 · Autor: Ta-Yoshua Lubuimi**

## 52. Commitgebundener Befund

Der PR-#69-Lauf [42720062719](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42720062719) wurde auf dem PR-Head `6c34cd1d4f7487c200a04a4f1cc90010ceb19643` ausgeführt; der integrierte Workflow checkte den Merge-Commit `ac80e32831b12aaeb117242d62395bd421aaf713` aus. Beide Jobs sind inzwischen fehlgeschlagen. Das ist ein konkreter Stand der aktuellen Integrationskandidatur und keine Rücknahme früherer positiver Prüfungen oder des mathematischen APW4-Beweisstands.

### Integrierter Lean-4.35.0-Build

Setup, Sandbox und Mathlib-Cache waren erfolgreich. Der eigentliche Build erreichte die integrierten BBMST/APW4-Module und meldete:

- `BBMSTMomentRecurrence.lean:136:32`: Typfehler im Induktionsschritt. `hprodR` beweist die Nichtnegativität des bisherigen endlichen Produkts, erwartet wird aber die Nichtnegativität des nächsten einzelnen Faktors `stageFactor δ size z (a + 1 + m)`. Die zuvor korrigierte globale rationale Multiplikationsmonotonie ist damit nicht mehr der gemeldete Fehler; die lokale Positivitätsannahme muss für den aktuellen Faktor separat bereitgestellt werden.
- `BBMSTPrefixMeasureRecursion.lean:176, 187, 211, 338, 361`: abhängige Präfix-/Faserbeweise enthalten ein `introN` ohne verbleibende Binder, ungelöste Gleichheitsziele, eine nicht passende `assumption` sowie eine Taktik nach bereits geschlossenem Ziel. Fehler-Recovery weist bei abhängigen Deklarationen `sorryAx` aus; diese Deklarationen sind deshalb nicht als axiomsauber elaboriert zu zählen.
- `BBMSTHyperplaneFibreIncidence.lean:347, 454`: zwei nicht geschlossene Gleichheiten der endlichen Koordinaten-/Faserkardinalitäten. Abhängige Momentendeklarationen zeigen im Fehler-Recovery `sorryAx`.

Da `lake build ResearchKernelAudit` scheiterte, liegt für diesen Lauf kein erfolgreicher Abschluss von `lake check --paranoid` vor.

### Separater Audit-Job

Der Audit-Job kompilierte die Upstream-Quelle, die fokussierten Degenerationsprüfungen, den zero-safe Parameter- und Faserkern, das endliche gewichtete Update, die Uniformkoordinateninstanziierung, die endlichen Momentenschranken, den endlichen Geometriekern und die Uniformstufen-Momenteninstanziierung. Er scheiterte anschließend in `BBMSTPrefixMeasureRecursion.lean` an den oben genannten abhängigen Präfixbeweisen. Die späteren, davon abhängigen Workflow-Schritte wurden übersprungen. Das ist ein positiver Teilbefund für die tatsächlich abgeschlossenen Module, aber kein erfolgreicher Gesamt-Audit.

## 53. Konkrete nächste Reparaturziele

1. In `BBMSTMomentRecurrence` die Positivität des aktuellen Faktors direkt aus `stageFactor_pos` bzw. den dortigen Parameterhypothesen ableiten und erst dann `mul_le_mul` anwenden; die Produktinduktion darf nicht die Nichtnegativität des Gesamtprodukts als Ersatz für die Positivität des nächsten Faktors verwenden.
2. In `BBMSTPrefixMeasureRecursion` die abhängigen Subtypen-/Koordinatengleichheiten explizit über die tatsächlichen Projektionen und proof irrelevance transportieren; vor jedem `intro` den aktuellen Zieltyp prüfen. Danach die Folgeidentitäten und die nichtnegativen normierten Präfixmassen erneut kompilieren.
3. In `BBMSTHyperplaneFibreIncidence` die Kardinalitätsgleichheiten über die konkrete Äquivalenz der Koordinatenfasern zeigen, nicht allein über syntaktisch ähnliche `Fin`-Indizes.
4. Auf einem unveränderlichen neuen PR-Head zuerst den vollständigen Build, danach `lake check --paranoid` und anschließend die transitiven `#print axioms`-Ausgaben prüfen. Keine fehlerbedingt ausgegebenen `sorryAx`-Profile als gültige Satzprofile behandeln.

## 54. Kontinuität des Beweisstands

Die früheren erfolgreichen Läufe `42599116967`, `42599116987`, `42522617494` und `42601107408` bleiben für ihre jeweiligen Commits, Module, Deklarationen und Prüfumfänge gültig. Run `42720062719` löscht oder entwertet diese Resultate nicht. Ebenso bleibt der mathematische APW4-Forschungsstand aus §§47–50 – Energiezerlegung, DT, HT, globale obere Energieschranke und strikte Untergrenze unter den vollständigen historischen Hypothesen – unverändert. Die aktuelle Aufgabe ist die technische Integration der bereits vorhandenen Beweisbausteine.


## 54. New exact-head verification run 42721579786

After the candidate proof refinements to the rational product induction, prefix restriction/extension, covered-value equivalence, updated-weight recursion, and hyperplane stage-cardinality normalization, GitHub started run [42721579786](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42721579786) on PR #69 head 4ecac363ca6a06b5a41c750edac8eba2303b64cf. Both integrated-paranoid and audit jobs are active. The integrated job is installing Lean 4.35.0; the audit job is generating the Lean manifest. Neither has reached a final compile result. No success or paranoid pass is claimed yet.


---

# XV. Nachtrag 1.8 – Exakte Syracuse-Zylinderpartition als möglicher APW4-Anschluss

**Stand: 10. November 2026 · Autor: Ta-Yoshua Lubuimi**

## 55. Eigenständiges Resultat und struktureller Kontaktpunkt

Im separaten Collatz/Syracuse-Projekt wurde zusätzlich zur initialen Bewertungs-Eins-Zylinderklassifikation die **Lubuimi Finite Valuation-Word Cylinder Partition Theorem** hergeleitet. Für jedes endliche Wort exakter positiver Bewertungen \(\alpha=(a_0,\ldots,a_{k-1})\) mit Gesamtbewertung \(A=\sum_i a_i\) ist die Menge der positiven ungeraden Startwerte, die genau dieses Wort realisieren, eine eindeutige ungerade Restklasse modulo \(2^{A+1}\). Ihre relative Dichte unter ungeraden Startwerten ist exakt \(2^{-A}\). Die affine Restklasse ist
\[
r_\alpha\equiv(2^A-C_k)(3^k)^{-1}\pmod{2^{A+1}}.
\]

Für jeden Präfixknoten und jede endliche Abschneidegrenze \(B\ge1\) bilden die exakten nächsten Bewertungen \(b=1,\ldots,B\) zusammen mit dem einzelnen Tail-Ereignis \(a_k\ge B+1\) eine endliche Partition. Die relativen Massen lauten
\[
2^{-1},2^{-2},\ldots,2^{-B},2^{-B},
\qquad \sum_{b=1}^B2^{-b}+2^{-B}=1.
\]
Der Tail ist selbst eine einzelne Restklasse modulo \(2^{A+B+1}\), wie aus der affinen Transportformel für den Endzustand folgt. Das liefert eine exakte endliche gewichtete Verfeinerung mit einem expliziten Tail-Atom.

## 56. Bedeutung für die APW4-Forschung – und klare Grenze

Diese Zylinderpartition ist ein eigenständiger mathematischer Satz aus dem Collatz/Syracuse-Projekt. Sie kann als Kandidat für eine APW4-inspirierte endliche Quellen-/Massenstruktur dienen: Präfixe sind Knoten, exakte Fortsetzungen sind Kinder, die Gewichte sind exakt, und die endliche Tail-Abschneidung erhält die Gesamtmasse. Das ist ein konkreter struktureller Anschluss, nicht bloß eine sprachliche Analogie.

Damit ist aber noch kein APW4-Transport bewiesen. Für eine echte Anwendung müssen weiterhin eine indexerhaltende Abbildung in die historischen APW4-Quellindizes, Off-Diagonal-Ereignisse und BIB-Plätze, die Erhaltung der ursprünglichen Gewichte sowie eine konkrete Kapazitäts-/Hall-Ungleichung nachgewiesen werden. Insbesondere darf die disjunkte Zylinderpartition nicht ohne Beweis als historische BIB-Inzidenz oder Kollisionsreserve interpretiert werden.

**Status:** Die finite Zylinderpartition und ihre Tail-Massenidentität werden als mathematisch hergeleitete Resultate des separaten Collatz-Projekts geführt. Sie sind noch kein Lean-auditierter APW4-Baustein und ändern weder die historischen APW4-Definitionen noch den globalen APW4-Beweisstand. Die APW4-Energiezerlegung, DT, HT, die globale obere Schranke und die strikte Untergrenze bleiben unverändert.


## 55. Run 42721579786 — audit frontier and next candidate

Run [42721579786](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42721579786) has completed with failure in both jobs.

The audit job successfully completed the audited upstream source, degenerate-witness tests, zero-safe parameter/fibre core, finite weighted update, uniform-coordinate instantiation, finite-stage moments, finite-coordinate geometry and uniform-stage source-moment instantiation. It then failed in BBMSTPrefixMeasureRecursion.lean:
- line 171: restriction-after-extension still had a dependent update/Fin-index equality;
- line 184: extension-after-restriction still had a dependent prefix index equality;
- line 209: the covered-value equivalence attempted a rewrite whose pattern was not present;
- line 337: the updated-weight recursion equality remained unsolved;
- line 360: a reflexivity tactic ran after the goal was already closed.

The integrated job failed on the same prefix obligations and on the two hyperplane stage-moment equalities at BBMSTHyperplaneFibreIncidence.lean:347 and :450. The rational finite-product induction no longer appears among the errors; its earlier MulLeftMono ℚ issue has been cleared by the positive-factor induction and argument-order correction. Because the integrated build still fails, no completed lake check --paranoid result exists.

The next candidate source head is 95669afac00d8913c1fc2a91b6bb3b5740ce6d92. It now makes the prefix index equality explicit in the extension proof, removes the invalid stageCoordinate rewrite, and explicitly normalizes universal finite-cardinality denominators in the hyperplane moment identities. The updated-weight proof uses an explicit universal-membership fact before splitting the covered/uncovered cases. The next exact-head CI result is pending; no success is claimed.


## 56. Exact-head retry 42722133436

GitHub has started [run 42722133436](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42722133436) on PR #69 head 95669afac00d8913c1fc2a91b6bb3b5740ce6d92. Both jobs are still active. The integrated-paranoid job has completed Lean 4.35.0 setup, sandbox installation and Mathlib cache restoration and is now executing the integrated module compilation. The audit job has completed manifest generation and upstream-source fetch and is restoring the Mathlib cache. This is an in-progress retry, not a pass.


---

# XVI. Nachtrag 1.9 – PR-#69-Fortschritt nach Run 42721579786

**Stand: 10. November 2026 · Autor: Ta-Yoshua Lubuimi**

## 57. Neuer Integrationslauf und verschobene Fehlergrenze

Run [42721579786](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42721579786) wurde auf PR-#69-Head `4ecac363ca6a06b5a41c750edac8eba2303b64cf` ausgeführt. Beide Jobs sind abgeschlossen und fehlgeschlagen. Die Diagnose zeigt aber einen echten technischen Fortschritt gegenüber Run 42720062719: Der frühere rationale Produkt-/Faktorvergleich wird in diesem Lauf nicht mehr als Fehler gemeldet. Der Audit-Job durchlief erneut Upstream-Quelle, Degenerationsprüfungen, zero-safe Parameter-/Faserkern, endliches gewichtetes Update, Uniformkoordinaten, endliche Momentenschranken, endliche Geometrie und Uniformstufen-Momenteninstanziierung.

Die verbleibenden Fehler liegen jetzt vor allem in zwei abhängigen Schnittstellen:

- `BBMSTPrefixMeasureRecursion.lean:171:55, 184:2, 209:6, 337:45, 360:36`: ungelöste Präfix-/Faserziele, ein Rewrite ohne passendes Vorkommen und eine Taktik nach bereits geschlossenem Ziel. Die fehlerbedingt abhängigen Deklarationen zeigen `sorryAx`; sie gelten nicht als gültige axiomsaubere Satzprofile.
- `BBMSTHyperplaneFibreIncidence.lean:347:68, 450:73`: ungelöste endliche Koordinaten-/Faserkardinalitätsgleichheiten; abhängige Momentendeklarationen zeigen im Fehler-Recovery `sorryAx`.

Der separate Audit-Job scheiterte an der Präfixrekursion, bevor die abhängigen späteren Bridges ausgeführt werden konnten. Der integrierte Job scheiterte an denselben Präfixzielen und den Hyperflächen-Faseridentitäten. Daher gibt es für Run 42721579786 keinen erfolgreichen integrierten Build und keinen abgeschlossenen `lake check --paranoid`-Nachweis.

## 58. Aktueller Kandidat

Der nächste Kandidaten-Head ist `95669afac00d8913c1fc2a91b6bb3b5740ce6d92`. Run [42722133436](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42722133436) läuft auf diesem Stand. Zum letzten Abruf war der Audit-Job nach Checkout und Quellabruf beim Mathlib-Cache; der integrierte Job hatte Setup und Cache abgeschlossen und arbeitete an der integrierten Kompilierung. Es wird noch kein Ergebnis behauptet.

## 59. Kontinuität

Die erfolgreichen früheren APW4-/BBMST-Prüfungen bleiben für ihre jeweiligen Commits und Deklarationen gültig. Run 42721579786 ist eine neue technische Diagnose und zeigt, dass die rationale Produktstelle überwunden wurde; die noch offenen abhängigen Präfix- und Hyperflächenbeweise sind klar eingegrenzt. Der mathematische APW4-Beweisstand – Energiezerlegung, DT, HT, globale obere Energieschranke und strikte Untergrenze unter den vollständigen historischen Hypothesen – bleibt unverändert.


---

# XVII. Nachtrag 1.10 – Lubuimi Terminal-Residue Collision Energy

**Stand: 10. November 2026 · Autor: Ta-Yoshua Lubuimi**

## 60. Exakte finite-place Inzidenz aus Syracuse-Bewertungswörtern

Die allgemeine Lubuimi-Zylinderpartition liefert jetzt eine präzisere, eigenständig bewiesene Inzidenzstruktur. Für jedes Wort \(\alpha=(a_0,\ldots,a_{k-1})\) mit Gesamtbewertung \(A\) und Offset \(C_k\) ist der Terminalrest
\[
\tau_k(\alpha)=C_k2^{-A}\pmod{3^k}
\]
wohldefiniert und eine Einheit modulo \(3^k\). Jeder Startwert, der genau das Wort \(\alpha\) realisiert, hat \(n_k\equiv\tau_k(\alpha)\pmod{3^k}\). Die Quellengewichte sind \(w_\alpha=2^{-A}\), und die endliche Platzmenge ist \(U_k=(\mathbb Z/3^k\mathbb Z)^\times\), mit \(|U_k|=2\cdot3^{k-1}\).

Für die aggregierten Platzmassen \(m_k(t)=\sum_{\tau_k(\alpha)=t}w_\alpha\) ist \(\sum_t m_k(t)=1\). Der Terminalrest-Zweite-Moment besitzt die exakte Zerlegung
\[
E_k=\sum_{t\in U_k}m_k(t)^2=D_k+C_k^{\mathrm{coll}},
\]
mit exakt berechenbarer Diagonalmasse
\[
D_k=\sum_\alpha w_\alpha^2=(\sum_{a\ge1}4^{-a})^k=3^{-k}.
\]
Cauchy–Schwarz auf der endlichen Platzmenge erzwingt
\[
\boxed{C_k^{\mathrm{coll}}\ge\frac1{2\cdot3^k}.}
\]
Für \(k=1\) sind die beiden Platzmassen modulo 3 gleich \(2/3\) und \(1/3\), also \(E_1=5/9\), \(D_1=1/3\) und \(C_1^{\mathrm{coll}}=2/9\).

## 61. Konkreter APW4-Anschluss – und was noch fehlt

Dies ist eine exakte gewichtete Inzidenz- und Diagonal/Off-Diagonal-Zerlegung im Syracuse-Modell. Anders als die bloße Zylinderfiltration besitzt sie nun eine endliche Platzmenge und eine konkrete Abbildung von Quellwörtern auf Plätze. Damit liegt ein belastbarer mathematischer Kandidat für einen APW4-artigen Transport vor.

Die Größe \(C_k^{\mathrm{coll}}\) ist jedoch eine neu definierte Syracuse-Kollisionsmasse und **nicht** ohne weiteren Beweis die historische APW4-BIB-Reserve. Die Anwendung des APW4-Theorems erfordert weiterhin eine indexerhaltende Abbildung der Wortpaare auf die ursprünglichen APW4-Off-Diagonal-Ereignisse/BIB-Plätze, Erhaltung der historischen Gewichte und eine bewiesene Kapazitäts-/Hall-Schranke. Die neue Identität liefert eine konkrete Quelle/Platz-Struktur, aber noch nicht diese historische Identifikation.

**Status:** Mathematisch hergeleitet und in `Lubuimi_Terminal_Residue_Collision_Energy_2026-11-10.md` dokumentiert; noch nicht Lean-formalisiert. Die APW4-Energiezerlegung und alle etablierten APW4-Sätze bleiben unverändert.


---

# XVIII. Nachtrag 1.11 – Endliche Markov-Matrix der Terminalrest-Inzidenz

**Stand: 10. November 2026 · Autor: Ta-Yoshua Lubuimi**

## 62. Exakte endliche Übergangsmatrix

Die Gewichte der Bewertungswörter faktorisiert als \(w_\alpha=\prod_{j<k}2^{-a_j}\). Unter dem natürlichen Wahrscheinlichkeitsmaß auf ungeraden Startwerten sind die Exponenten daher unabhängig mit \(\mathbb P(a_j=b)=2^{-b}\). Für festes \(k\) und Modul \(3^k\) definiere
\[
x_j=C_j2^{-A_j}\pmod{3^k},\qquad x_0=0.
\]
Aus der Offsetrekursion folgt exakt
\[
x_{j+1}=2^{-a_j}(3x_j+1)\pmod{3^k},\qquad x_k=\tau_k(\alpha).
\]

Setze \(\phi_k=2\cdot3^{k-1}\). Da \(2\) primitive Wurzel modulo \(3^k\) ist, gibt es für jedes \(x\in\mathbb Z/3^k\mathbb Z\) und jede Einheit \(y\) genau ein \(r_k(x,y)\in\{1,\ldots,\phi_k\}\) mit \(2^{r_k(x,y)}y\equiv3x+1\pmod{3^k}\). Die Übergangswahrscheinlichkeit ist damit die endliche rationale Zahl
\[
P_k(x,y)=\frac{2^{-r_k(x,y)}}{1-2^{-\phi_k}},\qquad y\in(\mathbb Z/3^k\mathbb Z)^\times,
\]
und \(P_k(x,y)=0\) für nichtinvertierbare \(y\). Die Zeilensumme ist exakt eins, weil die Exponenten derselben Restklasse modulo \(\phi_k\) eine geometrische Reihe bilden. Die primitive-Wurzel-Eigenschaft folgt aus \(v_3(2^{2\cdot3^j}-1)=j+1\).

Der Terminalrest-Vektor ist daher
\[
\boxed{m_k=\delta_0P_k^k},\qquad E_k=\|\delta_0P_k^k\|_2^2.
\]
Damit ist die zuvor definierte countable weighted incidence auf eine explizite endliche rationale Matrix zurückgeführt.

## 63. Exakter zweiter Level

Für \(k=2\), in der Reihenfolge der Einheiten \(1,2,4,5,7,8\pmod9\), ergibt die Matrixrechnung
\[
m_2=\frac1{63}(8,16,11,4,2,22).
\]
Daraus folgen
\[
E_2=\frac5{21},\qquad D_2=\frac19,\qquad C_2^{\mathrm{coll}}=\frac8{63}.
\]
Dies ist ein konkreter exakter Momentenwert und liefert einen unmittelbar formaliserbaren Testfall für die finite APW4-artige Momentenarchitektur.

## 64. Grenze der Übertragung

Die endliche Matrix, ihre Massen und der zweite Moment sind Syracuse-eigene Objekte. Sie liefern eine konkrete Quelle/Platz-/Gewichtsstruktur für die Entwicklung eines APW4-artigen Transportes. Die Identifikation mit den historischen APW4-BIB-Plätzen, die Erhaltung der dortigen Originalgewichte und eine Kapazitäts-/Hall-Ungleichung sind weiterhin gesondert zu beweisen. Bis dahin wird die Matrix nicht als historische BIB-Instanz ausgegeben. Der APW4-Beweisstand bleibt unverändert.


---

# XIX. Nachtrag 1.12 – Run 42722133436: präzise abhängige Indexdiagnose

**Stand: 10. November 2026 · Autor: Ta-Yoshua Lubuimi**

## 65. Exakter Commit und Ergebnis

Run [42722133436](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42722133436) lief auf PR-#69-Head `95669afac00d8913c1fc2a91b6bb3b5740ce6d92`, Merge-Commit `a73cc25` in Basis `ca9d245aa1851a54b65850ddb1130d1ca12e850e`. Audit und integrated-paranoid sind beide fehlgeschlagen.

Der Audit-Job durchlief Upstream-Quelle, Degenerationsprüfungen, zero-safe Parameter-/Faserkern, endliches gewichtetes Update, Uniformkoordinaten, endliche Momentenschranken, endliche Geometrie und Uniformstufen-Momenteninstanziierung. Danach scheiterte er an der Präfixrekursion. Der integrierte Job scheiterte an denselben Präfixzielen und an den Hyperflächen-Faserkardinalitäten.

## 66. Neue konkrete Lean-Diagnose

- `BBMSTPrefixMeasureRecursion.lean:171:55`: `restrictPrefix_extendPrefix` lässt einen abhängigen Koordinaten-Cast ungelöst; nach dem Entfalten bleibt eine Gleichheit zwischen einem per `Eq.mp` transportierten Präfixwert und dem ursprünglichen Wert.
- `:187:39` und `:187:45`: Im Beweis von `extendPrefix_restrictPrefix` wird `hi : i.val < k` als Beweis für `Fin (k+1)` verwendet; zusätzlich wird das Ergebnis `prefixIndex hk ... : Fin n` fälschlich mit `i : Fin (k+1)` verglichen. Die korrekte Hilfsgleichheit muss zwei `Fin n`-Indizes vergleichen: `prefixIndex hk ⟨i.val, by omega⟩` und `prefixIndex (Nat.le_trans ...) i`.
- `:191:67`: `hidx` ist wegen der vorigen Typfehler kein gültiger Satzbeweis; der nachfolgende `simp`-Eintrag ist deshalb ungültig.
- `:204:59`: `prefixPointCovered_iff` reduziert die Mitgliedschaft in `Finset.univ.filter` nicht explizit; daher bleibt die Äquivalenz offen und `hExtend` wird von `simp` nicht verwendet. Zuerst `Finset.mem_filter`/`Finset.mem_univ` freilegen, danach `rw [hExtend]`.
- `:336:45`: Im Induktionsschritt von `PAt_nonneg` lässt sich die Nichtnegativität `hbase` nicht automatisch auf den mit lokalem `hk` und `hprev` gebildeten abhängigen Term transportieren. Die Gleichheit der Beweisargumente bzw. der abhängigen Präfixwerte muss explizit normalisiert werden.
- `:359:36`: Nach `rw [hcovered, hstage]` ist das Ziel bereits geschlossen; die nachfolgende Taktik ist redundant und muss entfernt werden.
- `BBMSTHyperplaneFibreIncidence.lean:347:68` und `:446:73`: Die Nenner `Finset.univ.card` und `Fintype.card (C.S i)` werden nicht unter derselben lokalen `Fintype`-Instanz normalisiert; die Koordinatentypen müssen vor dem Rewrite vereinheitlicht werden.

Die Fehler-Recovery-Ausgaben enthalten `sorryAx` in abhängigen Deklarationen. Sie sind keine gültigen axiomsauberen Satzprofile. Es gibt für diesen Lauf weder einen erfolgreichen integrierten Build noch einen erfolgreichen `lake check --paranoid`-Nachweis.

## 67. Reparaturreihenfolge

1. Eine separate Hilfslemma für den abhängigen `Fin`-Index-/Koordinaten-Cast beweisen und in `restrictPrefix_extendPrefix` verwenden.
2. In `extendPrefix_restrictPrefix` die `Fin (k+1)`-Einbettung mit `by omega` aufbauen und die beiden resultierenden `Fin n`-Indizes vergleichen.
3. In `prefixPointCovered_iff` die gefilterte Finset-Mitgliedschaft explizit reduzieren und dann `hExtend` umschreiben.
4. In `PAt_nonneg` die abhängigen Proof- und Präfixargumente explizit transportieren; redundant gewordene Taktiken entfernen.
5. In der Hyperflächeninzidenz die Fintype-Instanz und den Koordinatentyp auf beiden Nennerseiten identisch machen.
6. Auf einem neuen unveränderlichen PR-Head Build, Paranoid-Check und vollständigen Axiom-Audit nacheinander ausführen.

## 68. Kontinuität des Forschungsstands

Der Produkt-/Faktorfehler aus früheren Integrationsläufen ist weiterhin nicht der aktuelle Blocker. Die aktuellen Fehler sind auf abhängige Präfixindizes, Casts, gefilterte Mitgliedschaft, eine `PAt`-Induktionsannahme und Fintype-Nenner beschränkt. Frühere erfolgreiche APW4-/BBMST-Prüfungen bleiben für ihre Commits und Umfänge gültig. Der mathematische APW4-Beweisstand bleibt unverändert.


## Addendum 1.7 — exact CI status as of 10 November 2026

The integrated PR #69 head `95669afac00d8913c1fc2a91b6bb3b5740ce6d92` was checked by run `42722133436`; both the audit and integrated-paranoid jobs failed. The audit compiled the upstream source, focused degenerate-witness tests, zero-safe fibre and weighted update chain, uniform-coordinate instantiation, finite-stage moment bounds, finite-coordinate geometry and uniform-stage source moment, then failed at the source-indexed prefix recursion. The integrated-paranoid job failed during the full package build. The line-level diagnostic is in `APW4_CI_RUN_42722133436_DIAGNOSTIC_2026-11-10.md`.

The documentation branch's run `42723539932` completed successfully for the earlier documentation head `2be6cec71a783eb1293d32a70df4646a5616f71a`; subsequent docs commits are not covered by that run. It was a degenerate-witness audit, not the integrated-paranoid build. The current append-only status snapshot is `APW4_CI_STATUS_SNAPSHOT_2026-11-10.md`.

Earlier successful APW4 and BBMST checks remain valid for their exact commits and declaration scopes. The mathematical APW4 proof record is unchanged. No full integrated Lean 4.35.0 paranoid success is claimed.


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


## 49. Source audit and formal interfaces — 10 November 2026

The complete 17-page original proof PDF was inspected. It gives the historical diagonal assignment (x,u) -> (k,I_xu,J_xu), its aggregate fibre-weight estimate, the off-diagonal demand d(gamma)=omega_l*omega_l', BIB places/capacities/incidence notation, weighted Hall condition, and equations (7.2)-(7.3). It does not spell out the element-level definitions of the source/target index spaces, W_x, rho_x, pi_x, w_x, the elementary event set, BIB-place set, or incidence predicate. The missing historical definitions are therefore confirmed absent from the currently inspected manuscript archive; no generic substitute is treated as historical.

The literal profile formula P_S = sum_x w_x sum_{(u,v) in W_x^2, pi_x(u,v)=S} rho_x(u)rho_x(v) includes u=v because its written domain is W_x^2. This must remain distinct from the separately defined off-diagonal sum over u != v. Earlier candidate notation ell=(x,u,v), omega_ell=w_x rho_x(u)rho_x(v), and candidate BIB slots indexed by (u,v,i) remain reconstruction hypotheses only.

PR #85's local q-fibre theorem has canonical and audit PASS on its exact source head; paranoid remains pending. PR #89 adds the generic preimage-fibre interface, corrected head 45700b0151a1bdd52b3b1f0374c4e7273e17db9a, with audit/canonical rechecks pending. PR #93 adds the Syracuse common dyadic uniform fibre as an APW4 FibreData object, corrected Lake-root head dca4ef8ede78f902e39e2ac6c4186e2403d9d5e4, run 42747404273 queued. These results do not identify historical BIB places or close weighted Hall transport.


## 50. Concrete finite residue projection and local q-fibre bound — 10 November 2026

PR #89 now specializes the generic preimage-fibre theorem to the explicit residue map on ZMod N with working moduli Bq,Br satisfying Bq ∣ N and Br ∣ N. The residue labels are represented by Fin Bq and Fin Br using the canonical representatives z.val % Bq and z.val % Br. The theorem APW4HistoricalQFibre.ResidueProjectionModel.sum_M_qr_le_Gamma_qr_of_residue_projections proves the local aggregate M/Gamma inequality for these fibres.

Exact source head 157cdcc00353c9d89e5d596720cee08d098684ae; canonical run 42749178635 and audit run 42749178673 passed. The canonical log reports exactly [propext, Classical.choice, Quot.sound] for the new theorem and zero sorryAx occurrences. The paranoid job had not completed at the time of this record.

The proof makes the residue projections concrete, but keeps Uq,Ur and the block-label map c explicit. It is not yet a historical reconstruction of the selected sets or of the source blocks C_h. The original event universe, BIB slots, and event-place incidence remain separate obligations.


## 50. Residue-label q-fibre specialization — 10 November 2026

PR #89 now instantiates the local q-fibre count on ZMod N using the canonical-representative residue-label map z |-> z.val % B into Fin B. The q-fibre is the inverse image of one residue label; V_q is the inverse image of an explicitly selected residue set U_q. A common block-label map c is left explicit. The theorem proves the fixed-index sum-over-h inequality. Exact head 157cdcc00353c9d89e5d596720cee08d098684ae; canonical run 42749178635 and audit run 42749178673 passed, with standard profiles and no sorryAx in the canonical log. Paranoid remained pending.

The map is not yet identified with the quotient ring homomorphism: the current theorem does not impose B_q | N or B_r | N. The historical U_q,U_r and C_h block map remain to be recovered. No event/BIB incidence claim follows.


## Source-location erratum — 10 November 2026

A prior paragraph in this audit referred to a file named BAB_BIB_Incidence_Bound_Lubuimi_2026-11-06.md, §5, as though that artifact had been recovered and inspected. That claim is not supported by the currently accessible record: the file is not present in the inspected GitHub tree or the connected Library search results, and the prior retrieval record says its literal section-5 definitions were not actually recovered. Treat the file's contents as unavailable until the exact artifact is supplied or located. No theorem or definition may be attributed to that filename on the basis of the earlier reference alone.

The exact accessible source checkpoint is Dossier v1.6, §48. It records the working q-fibre notation B_q=N/q^{a_q}, V_q={z : z mod B_q ∈ U_q}, P_{q,x,h}=F_q(x)∩C_h, M_{q,r}((x,h),(y,g))=|P_{q,x,h}∩P_{r,y,g}|, and Gamma_{q,r}(g)=|C_g∩V_q∩V_r|. It does not give the complete element-level definitions of U_q, F_q(x), C_h, the domains and entries of A_q/A_r/W_{q,r}/a_{q,t}, or the historical event and BIB-place incidence. These are retained as the accessible working definitions and fixed identities, not silently expanded with guessed predicates.

The separate notation I_q(x,h), A_q(x,h), Z_q=I_q-A_q in older dossier §15 is an algebraic candidate decomposition under A_q≤I_q. It is not promoted to a primary-source definition of the historical APW4 matrices. The explicit finite residue projection in PR #89 is a formal specialization of the local q-fibre inequality, not evidence that the unavailable historical U_q or C_h definitions have been reconstructed.

The source-to-BIB event map, actual event set, BIB slot objects, capacities, incidence predicate, and weighted Hall allocation therefore remain open at the source-reconstruction/formal-instantiation layer. This correction preserves the established mathematical DT/HT/energy results; it narrows only the evidence claim about the missing artifact.
