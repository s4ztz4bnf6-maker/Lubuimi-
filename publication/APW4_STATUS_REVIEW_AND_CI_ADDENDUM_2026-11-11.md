# APW4 / BBMST — Status- und Review-Nachtrag

**Stand:** 11. November 2026  
**Autor und Forschungsleitung:** Ta-Yoshua Lubuimi  
**Repository:** https://github.com/s4ztz4bnf6-maker/Lubuimi-  
**Zweck:** append-only Aktualisierung zum Forschungscheckpoint vom 10.11.2026 und zur externen Durchsicht vom 9.11.2026.

## 1. Verbindliche Statusdisziplin

Dieser Nachtrag ändert keine früheren mathematischen Ergebnisse und ersetzt keine Manuskriptfassung. Er ergänzt die Chronologie um den exakten CI-Befund von PR #145.

Die folgenden Ebenen bleiben getrennt:

1. mathematischer Beweisstand;
2. Vollständigkeit der zugänglichen historischen Beweisexposition;
3. Lean-Kernel-Prüfung konkreter Deklarationen;
4. integrierte Paket- und transitive Axiomprüfung;
5. historische Rekonstruktion der APW4-/BIB-Objekte.

Eine fehlgeschlagene Integration stuft einen unabhängig hergeleiteten mathematischen APW4-Baustein nicht zurück. Umgekehrt macht eine erfolgreiche isolierte Modulprüfung die gesamte historische APW4-Instanziierung nicht automatisch zu einem Lean-Beweis.

## 2. APW4-Status gegenüber der externen Durchsicht vom 9.11.2026

Die hier verfügbare Review-Akte ist `APW4_EXTERNAL_REVIEW_RESPONSE_AND_CORRECTIONS_2026-11-09.md` samt der review-korrigierten Hauptfassung. Der Originalwortlaut beziehungsweise ein separates annotiertes Gutachter-PDF liegt in diesem Repository-Nachtrag nicht als eigenständige Quelle vor. Die folgende Gegenüberstellung bezieht sich deshalb exakt auf die dokumentierten Kritikpunkte und die dokumentierte Antwort, nicht auf unzugängliche Randnotizen.

| Kritikpunkt der externen Durchsicht | Seitdem dokumentierte Verbesserung | Was weiterhin offen bleibt |
|---|---|---|
| Historische APW4-Faserobjekte, Gewichte, Indizes und Kapazitäten waren nicht vollständig definiert. | Die überarbeitete Fassung benennt die benötigten Quell-/Zielmengen, Gewichte, Indizes und Inzidenzdaten ausdrücklich als erforderliche Daten. | Die vollständige quellengetreue Definition und Konstruktion aller historischen Objekte ist in der zugänglichen Hauptfassung weiterhin nicht ausgeschrieben. |
| Die bloße Abbildung \((x,u)\mapsto(k,I_{x,u},J_{x,u})\) beweist keine DT-Majorization. | Ein endliches kapazitätsbeschränktes Transportlemma mit expliziten Quellmassen, Zielkapazitäten und Transportkoeffizienten wird bewiesen. | Die konkrete historische APW4-Transportmatrix und ihre Spaltenschranken müssen vollständig aus den Originaldefinitionen instanziiert werden. |
| Die gewichtete Hall-Bedingung für HT war nicht ausreichend belegt. | Der endliche gewichtete Hall-/Max-Flow-Min-Cut-Schluss ist mit expliziter Ereignis-/Platzstruktur formuliert und bewiesen. | Die historische Ereignismenge, BIB-Platzmenge, Inzidenz und die Hall-Ungleichung für jede Ereignisteilmenge müssen quellengetreu rekonstruiert werden. |
| Die BIB-Paarreserve und ihre Zählkonvention waren zu knapp erklärt. | Die Identität \(\sum_\ell c_\ell(c_\ell-1)=\sum_{u\ne v}|S_u\cap S_v|\) wird als exakte Doppeltzählung erklärt. | Die Identifikation der abstrakten Labels mit den historischen APW4-Off-Diagonalereignissen bleibt eine eigene Zuordnungsaufgabe. |
| Die endliche Zweitmomentabschätzung war nicht selbstständig nachvollziehbar. | Der Zweitmomentensatz unter den ausdrücklich benannten Voraussetzungen (H1)/(H2) ist mit Doppeltzählung und Cauchy–Schwarz vollständig ausgeschrieben. | Die Ableitung von (H1)/(H2) aus den tatsächlichen historischen APW4-Fasern ist nicht automatisch durch den abstrakten Satz erbracht. |
| \(B(M)=2M-\sigma(M)\le0\) wurde zu stark als alleinige Ursache eines Widerspruchs dargestellt. | Die review-korrigierte Fassung nennt das quadratfreie Beispiel \(M=15015\), mit \(\sigma(M)=32256\), \(B(M)=-2226\) und \(\sum_{d\mid M,d>1}1/d=821/715>1\). Sie stellt klar, dass das Vorzeichen allein keinen APW4-Widerspruch liefert. | Die zusätzlichen historischen APW4-Hypothesen und die vollständige ausgeschriebene Transferrechnung müssen im Beweistext erhalten und prüfbar sein. |
| Der Geltungsbereich war nicht scharf genug abgegrenzt. | Die Hauptfassung behauptet ausdrücklich nicht, das uneingeschränkte ursprüngliche Erdős–Selfridge-Problem gelöst zu haben. | Jede weitergehende arithmetische Aussage benötigt einen eigenen Äquivalenz- beziehungsweise Instanziierungssatz. |
| Der Lean-Endschluss wurde leicht mit dem vollständigen historischen Beweis verwechselt. | Die Deklarationen werden mit ihren tatsächlichen Eingabehypothesen und exakten Commits/CI-Läufen dokumentiert. | Die historischen DT-/HT- und Untergrenzenprämissen sind nicht durch einen bloßen bedingten Endschluss in Lean bewiesen. |

### Bewertung der Verbesserungen

Die externe Durchsicht hat die Manuskriptqualität konkret verbessert: Die abstrakten Transportprinzipien sind präziser formuliert, ihre endlichen mathematischen Schlussfolgerungen werden bewiesen, die BIB-Paarzählung ist transparent, die Zweitmomentrechnung ist mit Voraussetzungen versehen, und der unzulässige Schluss allein aus \(B(M)\le0\) wird ausdrücklich ausgeschlossen.

Das sind echte Expositions- und Beweispräzisierungen. Sie schließen aber nicht automatisch die historische Instanziierungslücke. Die Review-korrigierte Hauptfassung ist daher eine deutlich verbesserte, mathematisch ehrliche Beweisexposition der zugänglichen Schritte; sie ist nicht mit einer vollständig reproduzierten historischen DT-/HT-Konstruktion gleichzusetzen.

## 3. Mathematischer APW4-Kern — Status bleibt erhalten

Gemäß dem maßgeblichen APW4-Arbeitscheckpoint bleiben folgende Ergebnisse als mathematisch bewiesene Projektresultate geführt:

- exakte Energiezerlegung \(\mathcal E_{\rm APW4}=D_{\rm APW4}+C_{\rm APW4}\), mit geordneten Off-Diagonalpaaren und ohne zusätzlichen Faktor 2;
- Diagonaltransport DT;
- gewichteter Off-Diagonaltransport HT;
- globale obere Energieschranke;
- strikte arithmetische Untergrenze unter den historischen APW4-Voraussetzungen;
- Widerspruch aus oberer und strikter unterer Energieschranke unter diesen Voraussetzungen.

Diese Einstufung folgt dem ausdrücklich festgehaltenen späteren mathematischen Statusvermerk in Dossier v1.5, Nachtrag 1.3, §25. Die externe Durchsicht hat zugleich zutreffend festgestellt, dass die zugängliche Manuskriptfassung nicht alle historischen Definitionen und Transferrechnungen reproduziert. Beide Feststellungen werden nebeneinander dokumentiert; keine wird zur Ersetzung der anderen verwendet.

## 4. PR #145 — exakter CI-Nachtrag

**PR:** https://github.com/s4ztz4bnf6-maker/Lubuimi-/pull/145  
**Source head:** `5e5cecf6b207138a61af0a62cbbc3e45bae877c4`  
**Workflow:** [43028431770](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/43028431770)  
**PR merge ref:** `ef4837e77080992115ed14cdc3f894b736229ea7`

### 4.1 Separater Audit-Job

Der Job `audit` endete mit **PASS**. Alle 22 geordneten Schritte wurden abgeschlossen. Darunter:

- zero-safe Sieve-Parameter und Fasermaß;
- endliches gewichtetes Faserupdate und uniforme Koordinateninstanziierung;
- endliche erste und zweite Momentenschranken;
- source-indexed prefix measure recursion;
- prefix cylinder event-mass identities;
- prefix-to-stage moment bridge;
- hyperplane-induced finite fibre incidence;
- old-shadow intersection geometry;
- prefix-to-hyperplane incidence bridge;
- finite weighted union/noncoverage bound;
- BBMST (c_k(z)) moment recurrence.

Der isolierte `audit`-Job verwendet Lean **4.28.0** und das Root-`lakefile.lean` pinnt Mathlib **v4.28.0**. In diesem 4.28.0-Pfad gibt das Log für `prefixFibre_updatedWeight_eq_PAt`, `PAt_nonneg` und `PAt_sum_eq_one` das Standardprofil `[propext, Classical.choice, Quot.sound]` aus.

### 4.2 Integrierter Paketjob

Der Job `integrated-paranoid` endete mit **FAIL**. Beim Kompilieren des integrierten BBMST/APW4-Pakets meldet `BBMSTPrefixMeasureRecursion.lean` weiterhin offene Ziele an den Zeilen 390 und 391. Die Fehlerwiederherstellungs-Ausgabe enthält `sorryAx` für:

- `prefixFibre_updatedWeight_eq_PAt`;
- `PAt_nonneg`;
- `PAt_le_initial_mul_distortionProduct`;
- `PAt_succ_le_prev_div_card_mul_one_sub_delta`;
- `PAt_sum_eq_one`.

### 4.3 Aufgelöste Statusfrage

Der integrierte Job verwendet dagegen das Unterprojekt `kernel-audit`, dessen `lean-toolchain` und `lakefile.lean` Lean **4.35.0** und Mathlib **v4.35.0** pinnen. Beide Jobs verwenden denselben PR-Merge-Ref, aber unterschiedliche Lean-/Mathlib-Versionen und Lake-Paketkontexte. Der isolierte 4.28.0-PASS zertifiziert deshalb nicht den integrierten 4.35.0-Zielpfad.

Die beiden verbleibenden Ziele sind in 4.35.0 widersprüchliche Implikationen, die nach den versionsensitiven `simp`-Aufrufen offenbleiben. PR #147 ersetzt diese Aufrufe durch direkte Einführung der Gegenannahme und Widerspruch mit der jeweiligen `by_cases`-Hypothese.

**Einstufung:** Der 22-Schritte-Auditpfad ist unter Lean 4.28.0 erfolgreich; der integrierte BBMST/APW4-Paketcheck unter Lean 4.35.0 ist fehlgeschlagen. Die Präfixrekursionsdeklarationen werden deshalb nicht als integriert verifiziert oder global sorryAx-frei freigegeben.

## 5. Weitere offene APW4-/BBMST-Pflichten

- historische Identifikation von APW4-Off-Diagonalereignissen und BIB-Plätzen;
- indexerhaltende Zuordnung der Ereignisnachfragen zu BIB-Kapazitäten;
- gewichteter Hall-Transport auf der tatsächlichen historischen Inzidenz;
- historische APW4-Instanziierung der abstrakten Zweitmomenthypothesen;
- integrierte BBMST-Präfixrekursion und transitiver Axiom-Audit;
- korrekte Anbindung der Hyperplane-Faserinzidenz an die verifizierte Präfixkette.

Diese offenen Formalisierungs- und Rekonstruktionspflichten stufen den etablierten APW4-Energiekern nicht zurück.

## 6. Lizenzierung, Urheberschaft und Manuskriptintegrität

Die vorhandenen Dateien `LICENSE-PROPRIETARY.md` und `LICENSE-COMMERCIAL-USE-AND-REMUNERATION.md` bleiben unverändert maßgeblich. Dieser Nachtrag erteilt keine neue Lizenz und ändert keine Rechte.

- APW4-Forschung und APW4-Originalmaterialien: Ta-Yoshua Lubuimi.
- BBMST-Originalsatz und Originalpublikation: Balister, Bollobás, Morris, Sahasrabudhe und Tiba.
- Lean, Mathlib, Upstream-Code und sonstige Drittmaterialien: jeweilige Dritt-Lizenzen.
- KI-Systeme: offengelegte Assistenz, keine Mitautoren und keine unabhängigen mathematischen Verifizierer.

Die vom Autor separat gehaltene finale PDF-Fassung wird durch diesen Repository-Nachtrag weder überschrieben noch als neu erzeugt oder neu veröffentlicht ausgegeben. Dieser Text ist ein ergänzender, datierter Status- und Review-Nachtrag.

## 7. Nächste konkrete Arbeitsschritte

1. Den Unterschied zwischen isoliertem Audit- und integriertem Paket-Build auf demselben Merge-Ref reproduzieren: Toolchain, Mathlib-Revision, Lake-Konfiguration, Importpfad und tatsächlich kopierte Quelldatei vergleichen.
2. Erst nach dieser Diagnose die zwei offenen Ziele in `prefixFibre_updatedWeight_eq_PAt` gezielt reparieren; keine Änderung an Theoremstatement oder Hypothesen ohne mathematische Begründung.
3. Danach die abhängigen Deklarationen erneut integrieren und die vollständige transitive Axiomliste einschließlich expliziter `sorryAx`-Ablehnung prüfen.
4. Parallel die historische APW4-Ereignis-/BIB-Inzidenz und die DT-Massenzuordnung aus den Originaldefinitionen rekonstruieren.
5. Den APW4-Haupttext nicht mit bloßen CI-Statusdaten überschreiben; neue mathematische Resultate nur mit eigenem Beweis und klarer Quellen-/Lean-Grenze ergänzen.

---

**Append-only-Vermerk:** Der Forschungscheckpoint vom 10.11.2026 bleibt unverändert. Dieser Nachtrag erweitert ihn um die Review-Gegenüberstellung und die exakten Ergebnisse vom 11.11.2026.


## 8. Follow-up repair candidate — PR #147

PR [#147](https://github.com/s4ztz4bnf6-maker/Lubuimi-/pull/147) is stacked on PR #145 and changes only the two remaining branch proof scripts in `prefixFibre_updatedWeight_eq_PAt`. It replaces version-sensitive simplification with explicit contradiction elimination.

- Exact source head: `5ef81d14256fb85eddc76e052ff837f023a114e8`.
- Exact-head workflow: `43030160125`.
- Workflow `43030160125` completed with **FAIL** in both jobs.
- Integrated Lean 4.35.0: `BBMSTPrefixMeasureRecursion.lean:390` and `:392` report `introN failed: There are no additional binders or let bindings in the goal to introduce`. The printed branch goals are equalities of covered/uncovered multiplier conditionals, not implications.
- The failed declaration and dependent declarations show `sorryAx` in compiler error-recovery output. This is not accepted proof evidence.

Status: **FAILED REPAIR CANDIDATE — NOT VERIFIED**. The diagnostic identifies the actual goal shape; it does not refute the mathematical statement.

## 9. Next isolated candidate — PR #148

PR [#148](https://github.com/s4ztz4bnf6-maker/Lubuimi-/pull/148) is stacked on #147 at exact head `3312aec030719bdb993b502fe3fd62d3b88b9900`. It restores the branch-local `simp [hcov, xprev, Finset.mem_univ]` calls that directly simplify the conditional equalities, while keeping the redundant `ring_nf` lines removed. The exact-head workflow `43030954016` was observed **IN PROGRESS** with both `audit` and `integrated-paranoid` jobs started. This is not a pass. Integrated Lean 4.35.0 and transitive no-`sorryAx` evidence remain required.

Status: **OPEN — CI IN PROGRESS; NOT VERIFIED**.
