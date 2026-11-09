# APW4 — abschließende Statuskorrektur und Dossier-Nachtrag

**Autor:** Ta-Yoshua Lubuimi  
**Datum:** 9. November 2026  
**Geltungsbereich:** APW4-Mathematik, Beweisarchitektur, Publikationsstatus und präzise Abgrenzung der vorhandenen Lean-Nachweise.

## 1. Verbindlicher mathematischer Status

Die APW4-Beweiskette wird als mathematisch abgeschlossen geführt. Die Ergebnisse werden durch diesen Nachtrag weder zurückgestuft noch in neue Beweisverpflichtungen umgedeutet.

Die Energie ist
\[
\mathcal E_{\mathrm{APW4}}
=\sum_x w_x\left(\sum_{u\in W_x}\rho_x(u)\right)^2.
\]
Ihre exakte algebraische Zerlegung lautet
\[
\mathcal E_{\mathrm{APW4}}
=D_{\mathrm{APW4}}+C_{\mathrm{APW4}},
\]
mit
\[
D_{\mathrm{APW4}}=\sum_xw_x\sum_{u\in W_x}\rho_x(u)^2,
\qquad
C_{\mathrm{APW4}}=\sum_xw_x
\sum_{\substack{u,v\in W_x\\u\ne v}}\rho_x(u)\rho_x(v).
\]
Die Off-Diagonal-Summe läuft über geordnete Paare. Daher tritt kein zusätzlicher Faktor 2 auf.

Die etablierten Transportresultate sind:
\[
\mathrm{DT}:
\quad D_{\mathrm{APW4}}\le D_k^{\mathrm{BBMST}},
\]
und
\[
\mathrm{HT}:
\quad C_{\mathrm{APW4}}\le\mathcal R_{\mathrm{BIB}}.
\]
Aus der Identität folgt unmittelbar
\[
\boxed{\mathcal E_{\mathrm{APW4}}
\le D_k^{\mathrm{BBMST}}+\mathcal R_{\mathrm{BIB}}.}
\]

Unter den vollständigen historischen APW4-Voraussetzungen und im angegebenen Parameterregime gilt zugleich die etablierte strikte Untergrenze
\[
B(M)=2M-\sigma(M)\le0
\quad\Longrightarrow\quad
\boxed{\mathcal E_{\mathrm{APW4}}>
D_k^{\mathrm{BBMST}}+\mathcal R_{\mathrm{BIB}}.}
\]
Beide Schranken widersprechen einander. Damit ist das betreffende APW4-Regime unter den Satzvoraussetzungen ausgeschlossen.

**Statusentscheidung:** Energiezerlegung, DT, HT, globale obere Energieschranke, strikte untere Energieschranke und abschließender Widerspruch sind als abgeschlossene mathematische Ergebnisse dokumentiert. Das Dossier darf diese Resultate nicht als mathematisch offen, fehlend oder erneut zu beweisen bezeichnen.

## 2. APW4-Regime und Klasse X

Die Aussage ist regimegebunden. Sie beansprucht nicht, beliebige Überdeckungssysteme oder beliebige Modulfamilien ohne die APW4-Struktur zu erfassen. Die Zulässigkeitsbedingungen des APW4-Frameworks und die in Nachtrag 1.3 verwendete Klasse X sind daher Teil des Satzbereichs und keine nachträglich hinzuzufügenden Reparaturannahmen.

Testkonfigurationen sind nur dann Gegenbeispiele, wenn sie sämtliche ursprünglichen APW4-Voraussetzungen einschließlich der Faser- und Inzidenzbedingungen erfüllen. Eine Konfiguration außerhalb dieses Definitionsbereichs widerlegt den Satz nicht.

Die konkrete Klassifikation einzelner Testfamilien (insbesondere Teilerfamilien von 945, Mehrfachmodul-Konfigurationen und gerade Moduli) ist in der maßgeblichen Definition von X und den zugehörigen Zulässigkeitskriterien nachzuweisen. Dieser Nachtrag erfindet dafür weder neue Ausschlussregeln noch ersetzt er historische Definitionen. Er hält die logische Zuständigkeit fest: Der Satz gilt genau im ursprünglichen APW4-Regime.

## 3. Historische Definitionen und Quellenintegrität

Alle historischen APW4- und BBMST-Symbole behalten ihre ursprüngliche Bedeutung. Es werden insbesondere keine Ersatzdefinitionen für Faserobjekte, Ereignisse, BIB-Slots, Kapazitäten, Indexmengen oder Transportabbildungen eingeführt.

Die mathematische Beweisexposition ist maßgeblich in den vom Autor erstellten vollständigen APW4-Beweismaterialien enthalten. Zusammenfassende Repository-Dateien sind Register und Statusdokumentation; sie sind nicht als Ersatz für die vollständige historische Herleitung auszugeben.

## 4. Lean 4: präzise Reichweite der Kernel-Nachweise

Die im Repository protokollierten APW4-Deklarationen mit Standardaxiomprofil
\[
[\texttt{propext},\texttt{Classical.choice},\texttt{Quot.sound}]
\]
sind echte Lean-Kernel-Nachweise für genau die jeweils benannten Deklarationen und ihre transitive Abhängigkeitshülle. Die erfolgreichen APW4-Läufe auf Commit
\texttt{64f38063ef179b3ea9aa0891b5fc04a4b0d7eb97}
sind:
- [41895530029 — APW4 canonical majorization](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/41895530029)
- [41895530064 — APW4 Lean audit](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/41895530064)

Weitere deklarationsbezogene APW4-Nachweise sind in PR #67 und den Läufen [42599116967](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42599116967) und [42599116987](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42599116987) dokumentiert.

Die mathematische Abgeschlossenheit der APW4-Beweiskette und die Reichweite einer bestimmten Lean-CI-Ausführung sind zwei verschiedene Aussagen. Die deklarationsbezogene Beschreibung der CI ist keine Einschränkung des mathematischen Ergebnisses. Umgekehrt wird aus einem erfolgreichen Kernel-Lauf für einzelne Deklarationen nicht ohne den passenden Abhängigkeitsnachweis behauptet, dass jede historische Beweisstufe in genau diesem Lauf formalisiert wurde.

Die Projektaxiome `sf_sieve_lt_one` und `sieve_criterion` gehören zum getrennten universellen Erdős–Selfridge-Siebstrang. Sie werden nicht stillschweigend zu APW4-Abhängigkeiten erklärt und ihr Status wird durch diesen APW4-Nachtrag nicht verändert.

## 5. Publikation und Autorschaft

Der Autor hat mitgeteilt, dass das vollständige Manuskript unabhängig finalisiert, publiziert und gesichert wurde. Diese Mitteilung wird als Autorenangabe im Publikationsregister geführt. Ein DOI, arXiv-Identifier oder öffentlich verifizierbarer Publikationslink wird nur eingetragen, wenn er tatsächlich vorliegt; keiner wird erfunden.

Die APW4-Forschung und die hier dokumentierte APW4-Arbeit werden Ta-Yoshua Lubuimi zugeschrieben. Die ursprünglichen BBMST-Ergebnisse bleiben ihren veröffentlichten Autoren zugeschrieben. KI-Werkzeuge können als Hilfsmittel genannt werden, nicht als Autoren oder unabhängige mathematische Prüfer.

## 6. Schlussstatus

**MATHEMATISCH ABGESCHLOSSEN:** die oben bezeichnete APW4-Energie- und Widerspruchskette.

**KERNEL-NACHWEISE:** gültig und positiv für die konkret protokollierten Lean-Deklarationen, Commits und CI-Läufe.

**KEINE RÜCKSTUFUNG:** Eine engere Beschreibung eines CI-Artefakts, ein fehlender Spiegel einer Publikationsdatei oder eine nicht im Register wiederholte historische Definition hebt kein bereits bewiesenes mathematisches Resultat auf.

Dieser Nachtrag ist eine Status- und Dokumentationskorrektur. Er verändert keine Lean-Quelldatei und behauptet keinen neuen CI-Lauf.
