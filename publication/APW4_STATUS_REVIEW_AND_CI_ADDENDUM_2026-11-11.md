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


## 10. Artifact-level proof-exposition audit — 11 November 2026

A direct review of the author-held PDF titled “Erdős Lean 4 Beweis.pdf” (17 pages) identifies an evidentiary limitation that must be kept separate from the project-level mathematical status ledger.

### 10.1 Section 5: strict lower-bound statement is not proved in this PDF

Pages 10–11 state Satz 5.1:
\(B(M)=2M-\sigma(M)\leq0 \Longrightarrow
\mathcal E_{\mathrm{APW4}}>D_k^{\mathrm{BBMST}}+\mathcal R_{\mathrm{BIB}}\).
However, after stating the implication, the text says that the “complete arithmetic proof” is used in its historical APW4 form and refers generally to historical definitions, profile weights, incidences, and arithmetic assumptions. It does not supply the derivation, the intermediate inequalities, or a traceable reference to a separate proof in this PDF. Section 6 then invokes Satz 5.1 to obtain the contradiction; it does not fill that proof gap.

Accordingly, this PDF **does not itself establish or reproduce the strict lower-bound proof**. The previous project-level label “mathematically proved under A1–A3” must not be attributed to this PDF as its supporting proof. Unless a separate, complete derivation under explicitly stated A1–A3 is attached or precisely referenced, the artifact-level status of Satz 5.1 is:

**OPEN — PROOF NOT EXHIBITED IN THIS PDF.**

This is an evidentiary correction to the manuscript/PDF claim, not a mathematical disproof of Satz 5.1 and not a retroactive alteration of independently proved upper-bound or finite transport lemmas. The global contradiction in §6 is conditional on Satz 5.1 and cannot be presented as established by this PDF alone.

### 10.2 Section 8: presentation and verification-scope qualification

Pages 14–15 list the exact repository commit, CI runs, and selected Lean declarations. Those are useful provenance data, but the mathematical notation around the axiom profile is poorly typeset (including visibly nested square-bracket markup), and the section does not provide a complete readable proof transcript or an integrated historical APW4 verification. The named declarations and their reported profile apply only to the listed declarations and commit; they do not verify Satz 5.1 or the full historical DT/HT instantiation.

The section should therefore be treated as a provenance summary requiring editorial correction, not as a self-sufficient formal proof certificate. Any revised publication copy should typeset the axiom profile as a single clear list, separate declaration names from output, and state the exact scope of the successful CI runs.

### 10.3 Corrected status wording

For this PDF, use the following distinctions:

- Energy decomposition and the displayed upper-bound argument: stated in the text; the validity of each transport input remains subject to the exact hypotheses and historical instantiation recorded elsewhere.
- Abstract finite DT/HT transport principles: may be reported as proved only with their complete standalone hypotheses and proof sources cited; the PDF's historical labels alone do not replace those proofs.
- Strict arithmetic lower bound Satz 5.1: **OPEN — proof not exhibited in this PDF**.
- Contradiction in §6: conditional on Satz 5.1; not established by the PDF alone.
- Section 8: selected Lean/CI provenance only; not an integrated verification of the preceding mathematical theorem.

This addendum supersedes only the earlier wording that could be read as saying this PDF itself contains a complete proof of the strict lower bound. It is append-only and does not alter the 10 November checkpoint, theorem statements, author-held PDF, or any licensing notice.


## 11. Evidence-boundary correction — 11 November 2026, 14:49 CET

This entry is an append-only clarification of §§2–3 and §10 above. It does not delete or rewrite the historical status statements in the earlier sections.

### 11.1 What the accessible manuscript actually proves

The 17-page author-held PDF “Erdős Lean 4 Beweis.pdf” states the strict lower-bound implication in §5 (pp. 10–11), but does not exhibit its arithmetic derivation. Section 6 uses that implication without supplying the missing derivation. Therefore:

- **Energy identity** \(E=D+C\): proved by the finite algebraic expansion in the accessible review-corrected manuscript.
- **Abstract finite DT transport lemma**: proved as a general finite capacity-transport statement.
- **Historical DT instantiation**: open in the accessible source record; the actual historical source masses, target capacities, and index-preserving transport assignment are not fully constructed there.
- **Abstract weighted Hall / max-flow-min-cut theorem**: proved as a finite theorem.
- **Historical HT instantiation**: open in the accessible source record; the actual historical event set, BIB slots, incidence relation, demands, capacities, and Hall inequality for every event subset are not fully reconstructed there.
- **Conditional upper energy inequality**: follows if the historical DT and HT instantiations are supplied. The abstract lemmas alone do not establish those historical hypotheses.
- **Strict lower-bound implication** \(B(M)\leq0\Rightarrow E>D_k+R_{\rm BIB}\): stated in the PDF, but its proof is not exhibited there. The accessible repository material refers to an earlier author proof dossier; that reference is not itself a reproducible derivation in this PDF.
- **Contradiction**: formally follows from the upper and strict lower inequalities if both are independently established under the same historical hypotheses. The accessible PDF does not establish the lower inequality, so its §6 contradiction is not fully proved by that PDF.

The earlier §3 wording “mathematically proved” records the project's prior asserted proof status. This addendum now distinguishes that author-reported status from what an independent reader can verify from the accessible manuscript and repository evidence. It does not claim the strict lower-bound theorem is false.

### 11.2 Exact remaining mathematical obligations

1. Publish or supply the complete strict lower-bound derivation, including every historical definition, parameter restriction, intermediate inequality, and the exact use of \(B(M)\).
2. Reconstruct the historical DT source set and target set, with the exact index-preserving map and a proof of every source-mass and target-capacity bound.
3. Reconstruct the historical HT event set and BIB slot set, including the exact incidence relation, event demands, slot capacities, and the weighted Hall inequality for every subset.
4. Prove that the DT and HT instantiations use the same APW4 objects and hypotheses as the strict lower-bound argument.
5. Only then combine the upper and strict lower inequalities into the claimed contradiction.

### 11.3 Lean boundary — current exact-head state

The canonical APW4 declarations recorded at commit `64f38063ef179b3ea9aa0891b5fc04a4b0d7eb97` and workflows `41895530029` / `41895530064` remain valid for their named declarations and their own canonical model. They do not formalize the complete historical DT/HT instantiation or the strict lower-bound theorem.

The newer BBMST integrated path is a separate issue. PR #145's isolated Lean 4.28.0 audit passed, but its integrated Lean 4.35.0 job failed. PR #147 also failed in both jobs. PR #148 exact head `3312aec030719bdb993b502fe3fd62d3b88b9900`, workflow `43030954016`, has `audit` PASS and `integrated-paranoid` FAIL. The latter leaves goals in `BBMSTPrefixMeasureRecursion.lean:390–391` and reports `sorryAx` in recovery output for the prefix recursion and dependent declarations. No integrated or transitive sorryAx-free status is claimed.

**Current evidence-based status:** the algebraic identity and abstract finite transport theorems are proved; historical DT/HT instantiation and the strict lower-bound derivation are not independently reproducible from the accessible manuscript/repository artifacts; the integrated Lean 4.35.0 BBMST prefix recursion remains unverified. The earlier mathematical proof-status record is preserved as historical provenance, not silently overwritten.


## 12. Append-only integrated prefix-recursion repair ledger — 11 November 2026

This section updates only the Lean/CI status of the prefix-recursion repair sequence. It does not alter the mathematical status of the APW4 energy identity, abstract transport lemmas, historical DT/HT obligations, or strict lower-bound evidence described above.

### 12.1 PR #149 — failed source diagnosis, retained

- Source head: `c1316c71c1187930ae767c875b9bc146f4fb29c7`.
- Workflow run: [#43033160378](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/43033160378).
- The integrated Lean 4.35.0 job reports open goals in `BBMSTPrefixMeasureRecursion.lean` and `sorryAx` in compiler error-recovery output for the affected declarations.
- The log's `introN` label is Lean's internal tactic diagnostic for the source command `intro hnot`; it is not a literal source token. The actual target at that location is a conditional equality, not an implication with a binder.

Status: **FAILED — proof-script error; no mathematical disproof**. The earlier source/log mismatch interpretation is corrected; the original observation and its correction remain in the append-only record.

### 12.2 PR #151 — conditional simplification candidate failed integrated verification

- Exact source head: `0628a302bd43ffc579208aee3b7afa4db3d1336d`.
- Workflow run: [#43041980404](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/43041980404).
- Isolated `audit`: **PASS**.
- Integrated Lean 4.35.0 `integrated-paranoid`: **FAIL**.
- Positive branch at line 390 and negative branch at line 391 remain unsolved. The negative-branch log marks `if_pos hmem` as an unused simp argument; the ordinary pretty-printed target is still a nested conditional equality.
- The compiler's recovery report includes `sorryAx` for `prefixFibre_updatedWeight_eq_PAt` and dependent declarations `PAt_nonneg`, `PAt_le_initial_mul_distortionProduct`, `PAt_succ_le_prev_div_card_mul_one_sub_delta`, and `PAt_sum_eq_one`.

Status: **FAILED REPAIR CANDIDATE — NOT VERIFIED**. This does not refute the mathematical statement. No merge or promotion follows from the isolated audit pass.

### 12.3 PR #152 — diagnostic-only full goal export

- Exact source head: `81af7be54dfe60b452fd35d1cea79a59622a3d44`.
- PR: [#152](https://github.com/s4ztz4bnf6-maker/Lubuimi-/pull/152).
- This diagnostic-only branch scopes `set_option pp.all true` to `prefixFibre_updatedWeight_eq_PAt` and emits `trace_state` before and after both existing branch tactics. It changes no theorem statement, definition, hypothesis, or mathematical content.
- Exact-head PR and push workflow runs were queued at the time of this entry; no CI conclusion or proof status is claimed yet.

The next permitted proof action is to inspect the complete pp.all traces from PR #152. No further tactic replacement is justified until the dependent conditional expressions, proof terms, and implicit arguments are visible in the exact Lean 4.35.0 goal states.

**Current integrated status:** no passing integrated Lean 4.35.0 prefix-recursion repair has yet been established. The 22-step isolated Lean 4.28.0 audit PASS remains a distinct result and must not be conflated with integrated verification.
