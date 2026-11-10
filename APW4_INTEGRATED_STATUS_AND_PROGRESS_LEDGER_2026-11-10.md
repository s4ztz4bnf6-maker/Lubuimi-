# APW4 / BBMST — integrierter Fortschritts- und Verpflichtungsstand

**Stichtag:** 10. November 2026, 22:54 CET. **Autor:** Ta-Yoshua Lubuimi.  
Append-only Statusledger; keine Änderung am veröffentlichten Manuskript oder an historischen Definitionen.

## 1. Verbindliche Integritätsregeln

- Mathematische Herleitung, historische Rekonstruktion, Lean-Elaboration und integrierte Kernel-/CI-Verifikation sind getrennte Nachweisebenen.
- Spätere fehlgeschlagene Builds stufen keine früheren mathematischen Resultate und keine exakt commitgebundenen Lean-Pässe zurück.
- Ein Modulbuild beweist nicht automatisch die transitive Hauptsatzabhängigkeit.
- Historische Objekte, Indizes, Gewichte, Ereignisse, BIB-Plätze und Kapazitäten werden nicht durch kanonische Modellobjekte ersetzt.
- Kein Beweis wird als geschlossen markiert, solange konkrete Verpflichtung und Quell-/CI-Nachweis fehlen.
- APW4-Forschung und Manuskript sind Ta-Yoshua Lubuimi zugeordnet. KI-Systeme sind Hilfsmittel, keine Autoren oder unabhängigen mathematischen Prüfer.

## 2. Mathematischer APW4-Kern — Status erhalten

Die dokumentierte Abschlussarchitektur lautet
\[
\mathcal E_{\mathrm{APW4}}=D_{\mathrm{APW4}}+C_{\mathrm{APW4}},
\quad
D_{\mathrm{APW4}}\le D_k^{\mathrm{BBMST}},
\quad
C_{\mathrm{APW4}}\le\mathcal R_{\mathrm{BIB}}.
\]
Damit
\[
\mathcal E_{\mathrm{APW4}}\le D_k^{\mathrm{BBMST}}+\mathcal R_{\mathrm{BIB}}.
\]
Die strikte Untergrenze im ursprünglichen APW4-Regime liefert unter den vollständigen historischen Voraussetzungen
\[
\mathcal E_{\mathrm{APW4}}>D_k^{\mathrm{BBMST}}+\mathcal R_{\mathrm{BIB}},
\]
also den Widerspruch.

**Status:** Mathematisch abgeschlossen gemäß dem veröffentlichten Manuskript- und Beweisstand des Autors. Dies behauptet nicht, dass die vollständige historische Konstruktion bereits in der aktuellen Lean-Hauptsatzabhängigkeit steckt.

## 3. Historische Rekonstruktion — dokumentierte Fortschritte

- Quellkoeffizient über alle initial-box Hyperflächen eines Profils:
  \[
  c(I)=\max\{P_a(H):H\text{ Hyperfläche in }Q_a,\ F(H)=I\}.
  \]
  Nicht nur über die Covering-Familie maximieren.
- Historische Suffixgewichtung:
  \[
  \nu(J)=\prod_{j\in J}\frac{1}{(1-\delta_j)|S_j|},
  \qquad c(\varnothing)=\nu(\varnothing)=1.
  \]
- H.FixedInsidePrefix (a+j) ist für die Q_k-Messbarkeit des ursprünglichen Ereignisses notwendig, nicht bloß für die Präfixprojektion.
- BBMSTPrefixCylinderMass.lean enthält die Ein-Koordinaten-Massendichotomie: freie Randkoordinate erhält die Zylindermasse; fixierte Randkoordinate trägt den Faktor 1/(|S_i|(1-delta_i)).
- prefixCylinderMass_le_initial_mul_hyperplaneSuffixFactor iteriert über genau die fixierten Suffixkoordinaten.
- Die endliche Profilfamilie aller initial-box Hyperflächen eines Profils und der normalisierte Leerprofilfall sind als mathematische Identifikation und Beweisdesign dokumentiert.
- q-fibre-Arbeit dokumentiert Blockidentität und Marginalinterface. Die Residual-Matrix-Expansion mit drei Z-Residuen bleibt von der Zweiterm-Energiezerlegung getrennt.

## 4. Noch offene historische/formale Verpflichtungen

1. Lean-Beweis des endlichen Maximums c(I) für alle Profile einschließlich Leerprofil.
2. Exakte Produkt-/Indexidentität hyperplaneSuffixFactor = nu(J).
3. Vollständiges source-facing Lemma 3.3 mit Q_k-FixedInsidePrefix-Bedingung.
4. Allgemeine geordnete Fin-t-Shadow-/Schnittmengenanwendung für Lemma 3.4.
5. Historische Identifikation von A_q, A_r, W_{q,r}, a_{q,t}, D_{q,r}, U_q, F_q, C_h und APW4-Faser-/Ereignisobjekten durch konkrete indexerhaltende Abbildung.
6. Erhaltung der Originalgewichte unter dieser Abbildung.
7. Ereignis-zu-BIB-Platz-Abbildung einschließlich Multiplizitäten und Inzidenzen.
8. Tatsächliche BIB-Kapazitäten und gewichtete Hall-/Max-Flow-Bedingung.
9. Einbindung der historischen Voraussetzungen in die transitive Lean-Hauptsatzabhängigkeit.

OldCompatible / mergeOldShadows und prefixPairReserve sind Paar-/t=2-Bausteine, kein allgemeines beliebiges-t-Lemma. Bei geordneten Tupeln bleiben Reihenfolge und Wiederholungen erhalten. Die Residual-Matrix-Expansion ist kein dritter APW4-Energieterm.

## 5. Aktuelle Reparaturkandidaten

### PR #138 — lokaler Membership-Witness-Fix

Branch repair/apw4-membership-witness-local-let-v15-2026-11-10; dokumentierter Head 94b89a2c5bda9a494c0c42e79ad054aabacabdd8; Draft/offen. Die letzte Workflow-Abfrage für diesen Head lieferte keine zugeordneten PR-Workflow-Runs.

Die Reparatur gewinnt lokale Witnesses x ∈ F.covered, x ∉ F.covered und x ∈ F.points aus den Endpoint-Witnesses, bevor Conditional-Ausdrücke reduziert werden. Keine Änderung an Theoremaussage, historischen Definitionen oder Voraussetzungen.

**OFFEN – NICHT VERIFIZIERT:** prefixFibre_updatedWeight_eq_PAt, PAt_nonneg und PAt_sum_eq_one erst nach vollständigem exaktem Build, benannten Axiomprofilen, vollständigem no-sorryAx-Scan und lake check --paranoid als integriert bewiesen führen.

### PR #84 — abhängiger Präfix-/Punktmassen-Transport

Branch fix/prefix-stage-proof-transport-v3-2026-11-10; dokumentierter kombinierter Kandidat 1980351a3002bef610107b810c8e726cc685b7b4; Draft/offen. Der Kandidat richtet rekursive PAt-/Covered-Finset-Witnesses über hk/hprev/xprev aus und transportiert die Stage-Koordinate explizit mittels Fin.ext. Workflow 42745653492 wurde für diesen Kandidaten als fehlgeschlagen zurückgegeben.

**Status:** fehlgeschlagener Reparaturkandidat; Diagnose erforderlich. Kein Merge, keine Beweisbehauptung. Frühere mathematische Faserresultate werden dadurch nicht zurückgestuft.

### PR #136 / PR #79

PR #136 ist ein offener Dokumentations-Draft für README, deutsches Manuskriptquellfile, historischen Event/BIB-Ledger und Proof-Obligation-Map. PR #79 ist eine separate Dokumentations-/Statusspur. Dokumentation ersetzt keine fehlende Lean-Hauptsatzintegration. Das vom Autor separat gesicherte veröffentlichte PDF wird nicht verändert oder als Repository-Artefakt ausgegeben.

## 6. Erdős–Selfridge / BBMST

Die Projektaxiome sieve_criterion und sf_sieve_lt_one bleiben explizite offene Beweisverpflichtungen. Sie dürfen nicht durch Signaturänderungen oder Definitionen beseitigt werden, die das gewünschte Resultat bereits voraussetzen. Formaler Abschluss erfordert echte Beweise, Quelltreue, korrekte Parameter-/Längenabstimmung, Ausschluss degenerierter Rationaldivision und vollständigen transitiven Axiom-Audit.

## 7. Statuslabels

- **MATHEMATISCH BEWIESEN:** vollständige Herleitung auf der angegebenen Hypothesenbasis.
- **LEAN BEWIESEN:** konkrete Deklaration erfolgreich elaboriert und vom Kernel akzeptiert, exakt commit-/toolchaingebunden.
- **INTEGRIERT VERIFIZIERT:** vollständige transitive Abhängigkeit auf exaktem Head, zulässiges Axiomprofil, kein tatsächliches sorryAx, vollständiger Build und geforderter Paranoid-Check.
- **DOKUMENTIERT:** Definition/Beweisidee/Abhängigkeit rekonstruiert, aber noch kein formaler Abschlussnachweis.
- **OFFEN – NICHT VERIFIZIERT:** Verpflichtung oder exakter Nachweis fehlt.

Frühere PASS-Ergebnisse bleiben für ihre exakten Commits und Deklarationen gültig. Spätere Fehler werden als neue Chronologie ergänzt und löschen diese Nachweise nicht.

## 8. Nächste Arbeitsreihenfolge

1. PR #138 exakt neu prüfen; lokalen Membership-Witness-Fix nur nach vollständiger CI akzeptieren.
2. PR #84: erste konkrete Fehlermeldung sichern und abhängige Präfix-/Fasertransporte isoliert reparieren.
3. c(I)-Maximum, Leerprofil und hyperplaneSuffixFactor = nu(J) source-faithful formalisieren.
4. Allgemeines geordnetes Fin-t-Merge-/Shadow-Lemma beweisen; Paarlemma nicht hochstufen.
5. Historische Ereignis-zu-BIB-Abbildung, Gewichtsidentität und Kapazitäts-/Hall-Beweis konstruieren.
6. APW4 DT/HT-Transport in der Hauptsatzabhängigkeit explizit instanziieren.
7. Danach transitiven Axiom-/sorryAx-/Paranoid-Audit als integrierten Abschluss ausführen.

## 9. Nicht-Regressionsregel

Keine historische Definition wird ersetzt. Keine abgeschlossene mathematische APW4-Aussage wird wegen fehlender Lean-Integration zurückgestuft. Kein fehlgeschlagener CI-Lauf wird als erfolgreicher Beweis ausgegeben. Die Syracuse-Finite-Fibre-Brücke bleibt ein endlicher Modell-/Schnittstellenbaustein, bis ein echter historischer APW4-Atom-, Index-, Gewichts- und BIB-Kapazitätstransport bewiesen ist.
