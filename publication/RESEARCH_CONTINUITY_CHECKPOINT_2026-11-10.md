# Forschungsfortschritt und Integrationsstatus — 10. November 2026, 22:58 CET

**Forschungsleitung und mathematische Urheberschaft:** Ta-Yoshua Lubuimi.  
**Zweck:** Append-only Kontinuitätsprotokoll für APW4/BBMST und die parallele Syracuse-/Collatz-Arbeit. Es ändert keine mathematische Aussage, Definition, Hypothese, Lean-Quelldatei oder veröffentlichte PDF.

## 1. Verbindliche Statussemantik

Jede Aussage wird auf drei voneinander unabhängigen Ebenen geführt:

1. **MATHEMATISCH BEWIESEN** — vollständige mathematische Herleitung im angegebenen Hypothesen- und Geltungsbereich.
2. **LEAN BEWIESEN** — der konkrete Lean-Quellstand wurde erfolgreich elaboriert und vom Kernel akzeptiert.
3. **INTEGRIERT VERIFIZIERT** — die vollständige transitive Abhängigkeit wurde auf dem exakten Commit mit den verlangten CI-Jobs, benannten `#print axioms`-Ausgaben und einer Prüfung auf `sorryAx` verifiziert.

Ein Resultat kann auf Ebene 1 abgeschlossen sein, während Ebene 2 oder 3 offen bleibt. Ein späterer Integrationsfehler ist kein mathematisches Gegenbeispiel und stuft ein bereits bewiesenes, unabhängiges Resultat nicht zurück. CI-Ergebnisse gelten ausschließlich für den jeweils genannten Commit und die tatsächlich geprüften Deklarationen.

## 2. APW4 — mathematischer Abschlusskern bleibt bestehen

Der mathematische APW4-Beweisstand bleibt unverändert:

- exakte Zweitermzerlegung `E_APW4 = D_APW4 + C_APW4`;
- Diagonaltransport (DT) und `D_APW4 ≤ D_k^BBMST`;
- gewichteter Off-Diagonal-/Hall-Transport (HT) und `C_APW4 ≤ R_BIB`;
- globale obere Energieschranke;
- strikte untere Schranke im ausdrücklich angegebenen historischen APW4-Hypothesenregime;
- daraus folgender Widerspruch innerhalb dieses Regimes.

Diese mathematischen Ergebnisse werden durch spätere Lean-Integrationsfehler nicht wieder geöffnet. Die historische Einbindung in die vollständige BBMST-/BIB-Datenstruktur bleibt davon getrennt und ist noch nicht abgeschlossen.

## 3. BBMST — exakte Integrationslage

### 3.1 PR #72: chirurgischer Kandidat, nicht als Erfolg verbuchen

APW4-Repository: [PR #72](https://github.com/s4ztz4bnf6-maker/Lubuimi-/pull/72).

Der PR-Datensatz führt den Kandidaten als geschlossen. Sein beschriebener Umfang war eng begrenzt:
- expliziter Transport der abhängigen Koordinatenfamilie in `containsPrefix_iff_full`, statt des problematischen `congrArg`-Transports;
- Vereinheitlichung des Rekursionsindex auf die Produktentwicklung `a + 1 + m`.

Der PR-Text bezeichnete dies ausdrücklich als Reparaturkandidaten, der erst nach vollständiger Modulkompilierung und Lean-4.35.0-Paranoid-Prüfung akzeptiert werden dürfte. Aus dem verfügbaren PR-Datensatz wird kein positiver exakter CI-Nachweis abgeleitet. Der Kandidat wird daher nicht als integrierter Erfolg gezählt.

### 3.2 PR #69: aktueller integrierter BBMST/APW4-Prüfstrang

[PR #69](https://github.com/s4ztz4bnf6-maker/Lubuimi-/pull/69) konsolidiert 34 BBMST-/APW4-Module. Der dokumentierte aktuelle Quellkopf ist:

`17eb308d106c770ab559d254bcee2bdfd2ead6c4`

Der exakte Workflow [42739454140](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42739454140) ist fehlgeschlagen:

- **Audit-Job:** Die Kompilierung von `BBMSTPrefixMeasureRecursion.lean` scheitert bei Zeile 391 und 393 jeweils mit `No goals to be solved`. Die vorhergehende Vereinfachung hatte die Ziele bereits geschlossen; nachfolgende Taktiken liefen ins Leere.
- **Integrierter Lean-4.35.0-Paranoid-Job:** ebenfalls fehlgeschlagen. Die Fehlerwiederherstellung gibt `sorryAx` für `prefixFibre_updatedWeight_eq_PAt` und davon abhängige Deklarationen aus, unter anderem `PAt_nonneg`, `PAt_le_initial_mul_distortionProduct`, `PAt_succ_le_prev_div_card_mul_one_sub_delta` und `PAt_sum_eq_one`.
- **Hyperplane-Faser/Inzidenz:** `BBMSTHyperplaneFibreIncidence.lean` wurde im integrierten Job erreicht und zeigte in diesem Lauf keinen entsprechenden direkten Kompilierungsfehler. Das ist kein vollständiger isolierter oder integrierter Audit-PASS und schließt eine spätere Abhängigkeitsprüfung nicht aus.

Damit ist der aktuelle unmittelbare Blocker in diesem Lauf konkret in `BBMSTPrefixMeasureRecursion.lean` lokalisiert. Die Hyperplane-Faser/Inzidenzdatei wird nicht ohne Diagnose als zweite fehlgeschlagene Datei etikettiert.

**Nächster Reparaturschritt:** ausschließlich die überflüssigen Taktiken nach den bereits geschlossenen Zielen entfernen bzw. die betroffenen Beweise gezielt neu strukturieren; danach denselben exakten Modulpfad erneut kompilieren. Erst nach erfolgreicher Präfixrekursion die nachgelagerten Faserrestriktionen, Inzidenzen und Momentenrekursionen erneut prüfen. Keine neue abstrakte Präfixarchitektur ist dafür erforderlich.

### 3.3 PR #138 v15 — weiterhin nicht verifiziert

[PR #138](https://github.com/s4ztz4bnf6-maker/Lubuimi-/pull/138), exakter Head:

`94b89a2c5bda9a494c0c42e79ad054aabacabdd8`

Der v15-Beweisskript-Kandidat leitet lokale Membership-Zeugen am let-gebundenen Faserpunkt aus den Endpoint-Zeugen her. Die Theorem-Aussage, Hypothesen und mathematischen Inhalte wurden laut PR-Beschreibung nicht geändert.

Für diesen exakten Head wurde kein zugehöriger Workflow-/Statuslauf zurückgegeben. Daher gilt weiterhin:

**OFFEN – NICHT VERIFIZIERT.**

Weder ein früherer v14/v15-Kandidat noch ein separater Audit-Job darf auf diesen Head übertragen werden. Erforderlich bleiben vollständige Lean-4.35.0-Integration, `lake check --paranoid`, benannte Axiom-Ausgaben und transitive `sorryAx`-Prüfung.

## 4. BBMST — dokumentierte mathematische und historische Fortschritte

Die folgenden Fortschritte sind als Rekonstruktions- bzw. Beweisdesign-Ergebnisse zu bewahren, nicht pauschal als Lean-verifiziert zu bezeichnen:

1. **Quellgetreue Profile:** `c(I)` ist das Maximum der tatsächlichen Anfangsmaßwerte über alle Hyperflächen des Anfangsprodukts mit Profil (I), nicht nur über die Hyperflächen der konkreten Überdeckungsfamilie. Die normierten Leerprofilwerte `c(∅)=1` und `ν(∅)=1` sind ausdrücklich zu behandeln.
2. **Suffixfaktor:** `ν(J)` ist das Produkt der lokalen Faktoren (1/((1-δ_j)|S_j|)) genau über die im Suffix fixierten Koordinaten. Der dokumentierte Indexbereich `Finset.Ico a (a+j)` entspricht den exponierten nullbasierten Koordinaten; die Übersetzung zur papierseitigen Einsbasierung ist explizit festzuhalten.
3. **Präfixzylinder:** Die freie Randkoordinate erhält die Ereignismasse exakt; eine festgelegte Randkoordinate kostet genau den lokalen Faktor. Die mehrstufige Zylinderabschätzung belastet nur die tatsächlich fixierten Suffixkoordinaten.
4. **Messbarkeit:** Die quellseitige Lemma-3.3-Schnittstelle muss `H.FixedInsidePrefix (a+j)` tragen, damit das Präfixzylinderereignis mit dem ursprünglichen (Q_k)-messbaren Ereignis identifiziert werden kann.
5. **Arbitrary-(t)-Schatten:** Die vorhandenen `OldCompatible`-/Merge- und `prefixPairReserve`-Aussagen sind paarweise ((t=2)). Der allgemeine Fall muss über geordnete Tupel `Fin t → N_k` laufen, Wiederholungen erhalten und in Konflikt/Leer-Schnitt bzw. kompatiblen iterierten Merge zerlegt werden. Das ist bislang eine dokumentierte Architektur, kein Lean-Theorem.
6. **Historische q-Fasern:** Die rekonstruierten Arbeitsdefinitionen, Blockidentität, Faserzählung und Residualmatrix-Entwicklung sind in der Event-to-BIB-Ledgerdatei festgehalten. Die drei Z-Residualbeiträge der Matrixentwicklung sind keine zusätzliche Energiekomponente; die APW4-Energie bleibt eine Zweitermzerlegung.

### Weiterhin offen

- exakte historische Definitions- und Indexbereiche für alle Ereignisräume und Quotientenabbildungen;
- vollständige historische Event-to-BIB-Abbildung;
- indexerhaltende Zuordnung zu BIB-Slots und Inzidenzrelation;
- Erhaltung der historischen Gewichte;
- Kapazitätsidentität bzw. Kapazitätsungleichung und gewichteter Hall-Nachweis;
- exakte Identifikation mit der bereits etablierten HT-Masse;
- allgemeines geordnetes (t)-Tuple-Shadow-Lemma und dessen endliche Summen-/Indikatorentwicklung.

APW-Diagonalmasse, APW-Off-Diagonalmasse und BIB-Paarreserve bleiben bis zum Nachweis der jeweiligen Abbildungen und Transportgleichungen getrennt. Keine kanonische Ersatzfaser darf als historische Abbildung ausgegeben werden.

## 5. Syracuse/Collatz — paralleler Arbeitsstrang

Die Syracuse-Arbeit bleibt parallel aktiv; sie wird durch die APW4-Abschlusspriorität nicht stillgelegt.

Die affine Identität

`2^{A_k} n_k = 3^k n_0 + C_k`

und die Offsetrekursion bleiben die zentrale Schnittstelle. Die offene Abstiegsfrage ist, welche tatsächlich realisierbaren Bewertungsfolgen eine positive Abstiegs-/Schwellenwertmarge erzwingen. Bewertungszylinder, Carry-Rekursion, lokale Restklassenübergänge und Schwellenwertmargen müssen gemeinsam betrachtet werden. Eine lokale Viertelabstiegsstruktur ist kein universeller Abstiegsbeweis.

Wichtig zur PR-Nummerierung: Die Syracuse-Arbeit hat ebenfalls eine PR #72, aber in einem anderen Repository: [`Lubuimi` PR #72](https://github.com/s4ztz4bnf6-maker/Lubuimi/pull/72). Sie betrifft die rückwärtsgerichtete Exaktheit des affinen Akkumulators, nicht die BBMST-Präfixreparatur.

### Aktualisierter Verifikationsstand der Syracuse-PR #72

Der frühere PR-Text, der `terminalExact_backward_step` noch als reine Zielsignatur beschrieb, ist durch die späteren Commits und erfolgreichen Workflow-Ergebnisse überholt.

Auf dem isolierten Branch `collatz/terminal-exact-backward-step-2026-11-10` sind inzwischen beide Deklarationen implementiert und kernel-geprüft:

- `SyracuseAudit.terminalExact_backward_step`: aus (a_k\geq1) und terminaler Exaktheit folgt (C_k\equiv2^{A_k}\pmod{2^{A_k+1}}).
- `SyracuseAudit.terminalExact_backward_prefix`: die Ein-Schritt-Implikation iteriert über einen endlichen Suffix, sofern alle dortigen Bewertungen positiv sind.

Exakter Lean-Quellcommit: `e44eb4331cc1481e10d6f60780d695412c47a726`. Der spätere Dokumentationscommit ist `f36fdcc157e2f40dffd96485898f4ad35136550b`; er ändert nur die Dokumentation der Toolchain-Grenze. Workflow [42845962042](https://github.com/s4ztz4bnf6-maker/Lubuimi/actions/runs/42845962042) auf diesem Dokumentationskopf hat den vollständigen deklarierten Lean-Library-Build, die Zusatzmodule, den expliziten Axiom-Report und den `sorryAx`-Guard erfolgreich abgeschlossen. Die frühere exakte Quellprüfung [42844423707](https://github.com/s4ztz4bnf6-maker/Lubuimi/actions/runs/42844423707) war ebenfalls erfolgreich.

Beide neuen Deklarationen haben das transitive Profil `[propext, Classical.choice, Quot.sound]`; `sorryAx` wurde im geprüften Report nicht gefunden. Damit ist die endliche rückwärtsgerichtete Akkumulator-Exaktheit auf diesem isolierten Branch **LEAN BEWIESEN**.

**Toolchain-Grenze:** Der Branch verwendet Lean 4.34.1 / Mathlib 4.34.1. Diese Toolchain stellt `lake check` nicht bereit. Der Workflow prüft deshalb den vollständigen deklarierten Library-Build, die benannten Axiom-Ausgaben und das Fehlen von `sorryAx`; ein `lake check --paranoid`-PASS wird ausdrücklich nicht behauptet. Ebenso ist dies kein integrierter APW4-/BBMST-Nachweis.

### Weiterhin offene Syracuse-Verpflichtungen

Der endliche Rückwärts-Transport beweist weder die Realisierbarkeit beliebiger Bewertungswörter noch die allgemeine Tail-Partition, eine 2-adische Haarmaß-/Dichte-zu-Punkt-Aussage oder globale Orbitabsenkung. Die zentrale offene Collatz-Verpflichtung bleibt ein gültiger globaler Abstieg bzw. der Ausschluss einer unendlichen nichtterminierenden Bahn. Bereits unabhängig verifizierte Initialzylinder, Bewertungsgrenzen, Offset- und lokale Margenergebnisse behalten ihren jeweiligen exakten Commit-/CI-Geltungsbereich.

## 6. Erdős–Selfridge-Audit bleibt separat

Die projektbezogenen Axiome `sieve_criterion` und `sf_sieve_lt_one`, ihre Hypothesen-/Parameter-Schnittstellen und der `getD`-/Leerlisten-Degenerationspfad bleiben ein eigenständiger Auditstrang. Ein APW4- oder Syracuse-Ergebnis ersetzt diese Verpflichtungen nicht. Der uneingeschränkte Erdős–Selfridge-Satz darf nicht als bewiesen bezeichnet werden.

## 7. Priorisierte nächste Schritte

1. **BBMSTPrefixMeasureRecursion:** den exakten Taktik-/Zielabschlussfehler auf dem aktuellen Integrationszweig beheben und den vollständigen exakten Head neu prüfen.
2. **BBMSTHyperplaneFibreIncidence:** nach erfolgreicher Präfixkompilierung die Faserrestriktionen und Inzidenzlemmata gegen genau denselben integrierten Head prüfen.
3. **BBMST-Momentenrekursion:** erst auf den reparierten Faser- und Inzidenzlemmata aufbauen.
4. **Syracuse:** rückwärtsgerichtete Akkumulator-Exaktheit formal implementieren und exakt verifizieren; parallel Bewertungszylinder, Carry-Cocycle und Schwellenwertbrücke verbinden.
5. **APW4:** historische Event-to-BIB-, Gewichts- und Kapazitätstransporte rekonstruieren; die mathematische DT/HT-Abschlussaussage bleibt unangetastet.
6. **Erdős–Selfridge:** Projektaxiome und degenerierte Schnittstellen unabhängig eliminieren.
7. **Abschluss:** vollständiger transitiver Axiom- und `sorryAx`-Audit auf dem exakten integrierten Commit.

## 8. Änderungsgrenze und Nicht-Regressionsregel

Dieser Statuscheckpoint ist Dokumentation. Er ändert keine Lean-Deklaration, keinen mathematischen Satz, keine Hypothese und keine veröffentlichte PDF. Alle historischen PASS-/FAIL-Ergebnisse bleiben mit ihrem jeweiligen exakten Commit verbunden. Ein neuer PASS wird erst nach tatsächlichem Workflowabschluss und Einsicht in die benannten Axiom- und `sorryAx`-Ausgaben eingetragen.
