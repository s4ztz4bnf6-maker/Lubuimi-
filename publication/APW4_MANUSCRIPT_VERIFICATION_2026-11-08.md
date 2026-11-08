# APW4 manuscript verification memorandum

**Research lead and manuscript author:** Ta-Yoshua Lubuimi  
**Verification date:** 8 November 2026  
**Scope:** editorial and evidence audit of the proposed APW4 manuscript text; no mathematical re-proof and no modification of Lean source.

## 1. Executive finding

The manuscript's mathematical narrative is consistent with the APW4 research dossier at the level of the recorded result statements:

- the exact decomposition \(\mathcal E_{\mathrm{APW4}}=D_{\mathrm{APW4}}+C_{\mathrm{APW4}}\);
- the established diagonal transport conclusion \(D_{\mathrm{APW4}}\leq D_k^{\mathrm{BBMST}}\);
- the established off-diagonal transport conclusion \(C_{\mathrm{APW4}}\leq\mathcal R_{\mathrm{BIB}}\);
- the resulting upper energy estimate;
- the strict lower-bound implication recorded in Dossier v1.5, Addendum 1.3, Section 25, and the resulting contradiction in the stated parameter regime.

This memorandum does not reopen those mathematical results. It records the dossier's stated status and distinguishes that status from the narrower scope of the available machine-verification logs.

**Publication decision:** the supplied prose is not safe to publish unchanged because some claims about the scope of Lean verification exceed the declarations and workflows identified below. These are evidence-attribution corrections, not a reopening of DT, HT, or the strict lower-bound result.

## 2. Mathematical statements and notation

The energy expansion is exact provided the off-diagonal sum is explicitly over ordered pairs \((u,v)\) with \(u\ne v\). In that convention no additional factor of two is introduced.

The manuscript should print the actual displayed equations for Sections 2–6. In the text submitted for this audit, several equation positions appear blank after phrases such as “The APW4 energy is defined as” and “Expanding the square yields”. If this is only a chat-rendering loss, no change is needed; if the LaTeX source is also blank at those positions, the manuscript is not yet typeset-complete.

The historical symbols \(S_k,\mathcal N_k,c,\delta_j,I_{x,u},J_{x,u}\), and the BIB incidence/slot/capacity data must retain their source definitions. This memorandum introduces no replacement definitions.

## 3. Required correction to the BBMST attribution

The phrase “Bárány–Boros–Makai–Pach–Szegedy (BBMST)” is incorrect.

In this manuscript, BBMST refers to **Balister, Bollobás, Morris, Sahasrabudhe, and Tiba**, the authors of:

P. Balister, B. Bollobás, R. Morris, J. Sahasrabudhe, and M. Tiba, “The Erdős–Selfridge problem with square-free moduli,” *Algebra & Number Theory* 15 (2021), 609–626. DOI: https://doi.org/10.2140/ant.2021.15.609.

Use “the Balister–Bollobás–Morris–Sahasrabudhe–Tiba (BBMST) framework” or simply “the BBMST framework”.

## 4. Exact scope of the APW4 Lean evidence

The APW4 canonical code snapshot is:

- Branch: `audit/apw4-diagonal-majorization-2026-11-04`
- Commit: `64f38063ef179b3ea9aa0891b5fc04a4b0d7eb97`
- CI runs: [41895530029](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/41895530029) and [41895530064](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/41895530064).

The recorded declaration-level standard axiom profile
`[propext, Classical.choice, Quot.sound]`
applies to the following declarations named in the APW4 audit record:

- `APW4CanonicalMajorization.local_profile_mass_identity`
- `APW4CanonicalMajorization.local_profile_mass_le_one`
- `APW4CanonicalMajorization.global_bib_majorization`
- `APW4CanonicalMajorization.bib_collision_identity`
- `APW4HistoricalCRT.mem_congruenceSet_iff`
- `APW4HistoricalCRT.mem_supportAt_iff`
- `APW4HistoricalCRT.historical_bib_collision_identity`

These are genuine Lean/kernel audit records for those declarations. They do **not**, by themselves, establish that the full historical DT proof, the full historical HT proof, and the strict APW4 lower-bound proof have each been formalized in Lean or occur in the transitive dependency closure of these declarations.

Accordingly, replace the manuscript's phrase “the entire architecture has been fully compiled and verified in Lean 4” with a declaration-scoped statement. For example:

> “The repository contains a Lean 4 formalization of specified APW4 canonical majorization and historical CRT declarations. The declarations listed in the verification record were compiled and their reported axiom profiles were audited on the cited APW4 code snapshot. The mathematical DT, HT, and strict lower-bound results are recorded in the research dossier as established results; the cited APW4 CI records are not asserted to be a complete Lean formalization of every historical proof.”

## 5. The separate 22-module BBMST workflow

The successful ordered workflow is tied to a different source snapshot:

- Commit: `436a2e387bb774ee2d31d5dc8908ec3cfdb06150`
- Step 16: [42522617423](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42522617423)
- Foundation regression: [42522617399](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42522617399)
- Full ordered audit: [42522617494](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42522617494)

This workflow establishes the successful ordered module-build chain recorded for that BBMST project snapshot. It is not the APW4 canonical CI run and must not be cited as direct verification of the historical APW4 DT, HT, or strict lower-bound instantiation without a precise theorem-to-module dependency map.

The full ordered audit also records four explicit upstream exceptions: `degenerate_axiom_acceptance`, `erdos_selfridge`, `sieve_criterion`, and `sf_sieve_lt_one`. The standard profile applies to the listed APW4 declarations and the specified Step 16/foundation declarations, not indiscriminately to every declaration in the full upstream-integrated audit.

## 6. “Zero sorryAx” wording

Use a scoped statement:

> “The cited APW4 declaration audit reports the standard axiom profile for the seven declarations listed above. The inspected CI logs contain no accepted `sorryAx` dependency for those audited declarations.”

Do not state “the entire architecture has exactly zero sorryAx instances” unless a complete source-tree scan and a final named-theorem transitive dependency audit on the exact release commit are separately archived. A failed elaboration trace, if any, must not be confused with an accepted kernel theorem.

## 7. Abstract replacement: evidence-aligned wording

The following version preserves the mathematical result status while avoiding an overclaim about the scope of formalization:

> This work develops the APW4 energy–incidence framework associated with the square-free-moduli setting studied by Balister, Bollobás, Morris, Sahasrabudhe, and Tiba. The mathematical research dossier records the diagonal transport theorem, the off-diagonal transport theorem, and the strict APW4 energy lower bound as established results. Together with the exact decomposition of APW4 energy into diagonal and off-diagonal contributions, these estimates yield the stated upper/lower-bound contradiction under the framework's arithmetic hypotheses. The repository provides Lean 4 verification artifacts for specified APW4 canonical majorization and historical CRT declarations, together with a separately identified ordered BBMST module-build record. The source commits, CI runs, declaration names, and axiom profiles are recorded individually so that mathematical results and machine-checked artifacts are not conflated.

## 8. AI and authorship disclosure

The author may state that AI tools were used as assistants, but the exact roles should reflect the actual project history. “All conceptual architecture ... exclusively designed” is an authorship assertion that this CI record cannot independently verify. A safer disclosure is:

> “AI language-model tools were used as research and engineering assistants for exploration, Lean syntax and tactic suggestions, diagnostics, and documentation. The author is responsible for the mathematical content, source selection, final proof review, and publication claims. Machine verification is attributed only to the cited Lean kernel builds and declaration-level audits.”

The original BBMST theorem remains attributed to its five published authors. The APW4 research contribution and this repository's APW4 documentation are attributed to Ta-Yoshua Lubuimi.

## 9. Final status

- **Mathematical status in the dossier:** DT, HT, the global upper estimate, and the strict lower-bound implication are recorded as established.
- **APW4 Lean status:** the exact declarations listed in Section 4 have the recorded kernel/axiom evidence.
- **Separate BBMST build status:** the ordered module chain passed on its own immutable commit and CI runs.
- **Scope limitation:** the available records do not justify describing the cited CI runs as a full Lean formalization and audit of every historical APW4 proof.
- **PDF:** prepared and released by the author; this repository documentation change does not create or upload a PDF.

This memorandum is an evidence and attribution audit. It does not withdraw or reopen the mathematical results recorded in the APW4 dossier.
