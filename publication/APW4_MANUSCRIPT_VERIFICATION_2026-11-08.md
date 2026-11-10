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

The successful full ordered audit is tied to a different source snapshot:

- Commit: `436a2e387bb774ee2d31d5dc8908ec3cfdb06150`
- Step 16: [42522617423](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42522617423)
- Foundation regression: [42522617399](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42522617399)
- Full ordered audit: [42522617494](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42522617494)

The full ordered audit compiled the documented dependency-ordered module sequence on that BBMST project snapshot. It is not a single integrated execution of all 22 numbered project steps: the records distinguish the ordered module chain from the separately checked historical isolated steps. It is not the APW4 canonical CI run and must not be cited as direct verification of the historical APW4 DT, HT, or strict lower-bound instantiation without a precise theorem-to-module dependency map.

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


## 10. Author's publication update and clarification of scope

**Update, 8 November 2026:** The author has subsequently informed this record that the complete manuscript PDF has been finalized, published, and secured independently by the author. The PDF is not mirrored in this repository; no external URL, DOI, or repository identifier was supplied for inclusion here.

The purpose of this memorandum is to keep the mathematical proof record, the manuscript text reviewed at the time, and the specific Lean CI evidence accurately distinguished. Its declaration-scoped description of the cited CI runs is not a claim that the mathematical DT, HT, or strict lower-bound proofs are missing, incomplete, or unproved. Those results remain recorded as established results in the author's APW4 proof record, with their complete proof expositions and historical definitions. Nothing in this memorandum withdraws or reopens them.

The earlier phrase “not safe to publish unchanged” refers only to the evidence attribution and presentation issues identified in the particular prose snapshot reviewed in this memorandum. It must not be read as a negative mathematical verdict on the author's completed proof work or as a statement about the subsequently published PDF.


## 11. Author-supplied consolidated manuscript — 9 November 2026

The author supplied a consolidated German main manuscript dated 8 November 2026. The manuscript records DT, HT, the global upper energy estimate, and the strict APW4 lower-bound implication as proved mathematical results. This memorandum adopts that mathematical status and does not reopen or downgrade any of those results.

The only scope distinction retained here concerns the machine-verification record: the cited APW4 CI runs and standard axiom profiles apply to the seven named Lean declarations on the specified commit. They are not to be generalized beyond those declarations without additional logs. This declaration-level limitation is not a statement that DT, HT, or the strict lower bound are mathematically open, missing, or unproved.

The current manuscript's equation (2.4), weighted Hall condition (3.1), and strict lower-bound theorem (5.4) are presented as established components of the author's proof record. Their complete proof provenance remains with the author's full APW4 proof materials and historical definitions; no replacement definitions are introduced by this memorandum.

**Editorial correction:** any prior wording that could be read as treating the strict lower bound as an open mathematical transfer problem is superseded by this clarification. The strict lower bound is established. Its mathematical status is not contingent on whether the cited Lean declarations formalize it.


## 12. Expanded source and kernel audit — 9 November 2026

### 12.1 Public BBMST source chain

The source reconstruction is recorded in [APW4_BALISTER_SOURCE_RECONSTRUCTION_2026-11-09.md](APW4_BALISTER_SOURCE_RECONSTRUCTION_2026-11-09.md). It follows the published 2021 Balister–Bollobás–Morris–Sahasrabudhe–Tiba paper and its 2018 density-paper dependency. The source chain includes the fibre measure update (Lemma 2.1), first/second moment criterion (Theorem 3.1), hyperplane mass and tuple-moment bounds (Lemmas 3.3 and 3.4), moment recursion (Theorem 3.2), exact finite initial certificate (Lemma 5.4), rational early-stage parameter certificate (Lemma 5.3), large-prime recurrence (Corollary 5.2), and imported termination criterion (Theorem 5.1).

The secondary plasma-ai/erdos proof archive is pinned to commit 17c86a0d4ebe1487a087ceb8c14952a10ec2f2bd. It is useful for a source-faithful reconstruction and its exact finite certificates, but it is not a Lean proof and is not a substitute for the original paper. Its scope is the square-free-moduli theorem. It does not provide the APW4-specific event-to-BIB-slot map or the APW4 strict energy transfer.

### 12.2 New APW4 compile and axiom evidence

On PR #67, corrected commit 33a66a8491f65616f9572a6efc8fbc91a65d6ed5, the following runs passed:
- [42599116967 — APW4 canonical kernel check](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42599116967)
- [42599116987 — upstream and degenerate-witness audit](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42599116987)

The canonical run compiled the three APW4 source files and printed the axiom profiles for the four canonical majorization declarations, the three historical CRT declarations, and the three new declarations in APW4IncidenceSecondMoment.lean. The three new declarations have exactly the standard profile [propext, Classical.choice, Quot.sound], with no sorryAx reported.

The scope remains conditional and declaration-specific:
- incidence_bound_from_second_moment proves the algebraic consequence of its explicit moment and size hypotheses; it does not prove those hypotheses for historical APW4 fibres.
- offDiagonal_exceeds_reserve proves the stated inequality from the energy identity, diagonal estimate, and strict lower bound supplied as hypotheses.
- apw4_energy_contradiction proves the final contradiction from the energy identity, diagonal estimate, Hall estimate, and strict lower bound supplied as hypotheses.

Thus the corrected PR #67 compile is a real kernel result, but it is not yet the historical APW4 main theorem.

The companion audit also compiled the separate upstream Erdős–Selfridge source, AuditCheck, APW4DiagonalAudit, and APW4CanonicalMajorization. Its output still lists sf_sieve_lt_one and sieve_criterion in the separate erdos_selfridge theorem. Those are project axioms of that separate sieve chain; they are not part of the standard axiom profile of the three new APW4 declarations.

### 12.3 Further successful BBMST checks

The following independent branch checkpoints passed:
- PR #56 geometry branch, commit a77f67540719a29e3e45a684e310dc4d753a2a50, run [42364359726](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42364359726).
- Prefix-mass Step 16 branch, commit ca9d245aa1851a54b65850ddb1130d1ca12e850e: [foundation 42522812092](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42522812092), [Step 16 42522812150](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42522812150), and [focused diagnostic 42522812223](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42522812223).
- Rank-nine CRT/fibre branch, commit 098699f663a144fae5da013a425d0d32147ae1ae: the indicator and dependency-ordered audit job in [run 42595925001](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42595925001) passed. The separate fiber-paranoid job in that run ultimately ended as cancelled and is not counted as passed; only the dependency-ordered audit job passed.

These are separate source snapshots. They do not collectively constitute one integrated build of the entire repository or one named APW4 main theorem.

### 12.4 Manuscript-copy integrity check

The Library contains a 17-page PDF named “Erdös Lean 4 Beweis.pdf”. The actual rendered page 11 was inspected, not just its extracted text. It displays raw LaTeX commands such as the boxed equation commands and literal command names in place of rendered mathematics. The same copy's extracted pages also leave relation signs absent in several display equations. Therefore this particular Library copy is not a publication-ready typeset PDF and is not reissued as the final manuscript.

This is a finding about the specific Library copy available in this conversation. It does not establish that a separate PDF independently finalized and held by the author is defective, and it does not alter the mathematical status of the APW4 results. No file in the author's independent publication custody is modified by this memorandum.

### 12.5 Release gate

The final APW4 kernel release still requires a single named theorem whose transitive dependencies construct the historical APW4 definitions and maps for DT and HT, the actual BIB event/slot incidence and capacity data, and the strict lower-bound proof from the historical APW4 objects. The final theorem must then be compiled on one immutable commit and audited with #print axioms, with no project axioms and no sorryAx in its dependency closure.

The dossier's mathematical status remains unchanged. The distinction here is solely between the established mathematical proof record and the exact scope of the kernel evidence currently available.


## 13. Consolidated dossier pointer

The complete updated source and verification record is consolidated in [APW4_Wissenschaftliches_Beweisdossier_Lubuimi_2026-11-09_v1.6.md](APW4_Wissenschaftliches_Beweisdossier_Lubuimi_2026-11-09_v1.6.md). Its Addendum 1.4 preserves the mathematical APW4 status from v1.5, Section 25, and records the new source reconstruction and CI evidence without treating the conditional Lean end-step as a proof of its historical premises.


## 14. Second PDF copy: summary versus complete manuscript

The Library also contains a three-page PDF named “Erdös Lean Deutsch.pdf”. Its typesetting is readable, but its content is an executive summary: it states the energy decomposition, DT, HT, and the strict lower bound without reproducing the historical fibre map, the weighted Hall incidence construction, or the intermediate arithmetic derivation. It also gives a compressed BIB-reserve expression whose identification with the reserve used in Dossier v1.5 is not established by that summary.

Accordingly, neither available Library PDF is reissued as the complete final manuscript: the three-page file is a summary, while the accessible 17-page file has raw LaTeX commands visible on its rendered page 11. This concerns only these two Library copies and does not make any claim about a separate author-held publication copy. The mathematical APW4 status remains the one recorded in Dossier v1.5 §25.


## 15. Integrated 34-module BBMST/APW4 audit

PR #69 consolidates 34 BBMST/APW4 source modules from the prior prefix-mass, rank-nine CRT/fibre, codimension-one geometry, and APW4 branches into one isolated Lean 4.35.0 package. Every module is an explicit library root, the ResearchKernelAudit aggregator imports all modules, and CI explicitly runs lake build ResearchKernelAudit followed by lake check --paranoid. This corrects the earlier empty-check configuration.

The current integrated workflow is [run 42600825252](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42600825252). At the time of this memorandum, the integrated paranoid job was still restoring the Mathlib cache and the separate audit job was compiling the BBMST source chain. No integrated paranoid success is claimed yet.

Even if the integrated module package passes, it will establish compilation and kernel checking of those 34 modules, not the historical APW4 main theorem: the current APW4 contradiction still receives DT, HT, and the strict lower bound as hypotheses. The separate universal erdos_selfridge chain remains audited separately with its project axioms visible.


## 16. Full BBMST Theorem 1.2 reduction: successful kernel check

The updated PR #56 branch now contains the full source-level reduction output:
- survivingFamily_preserves_noParallel;
- survivingFamily_nontrivial;
- survivingRestricted_nontrivial;
- augmentedFamily_nontrivial;
- canonicalReduction_result_full.

The successful [CI run 42601107408](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42601107408) compiled the updated family and augmentation modules. Its axiom output for canonicalReduction_result_full and the new helper declarations is exactly [propext, Classical.choice, Quot.sound], with no sorryAx. This is the formalized geometric reduction of Balister et al. Theorem 1.2 under the explicit product-coordinate and nonparallel-cover hypotheses.

This result does not by itself integrate the geometric reduction with every prefix/fibre-moment/tail module, and it does not construct APW4's historical DT/HT or strict energy transfer.


## Addendum — exact-head formalization status, 10 November 2026 (13:43 CET)

This memorandum's mathematical verification scope is unchanged. The established APW4 mathematical proof and the repository's declaration-scoped Lean evidence remain separate evidence records.

PR #133's integrated Lean 4.35.0 run (42812910651) failed at the concrete prefix-fibre update because the endpoint coordinate family and the fibre coordinate family were not definitionally aligned. The exact diagnostic is recorded in the current status ledger. PR #137 / v14 now attempts to normalize the equality `stageCoordinate hk = prefixIndex hj (Fin.last k)` throughout the proof context before constructing the fibre. This candidate has not yet passed an exact-head integrated run; no new machine-verification claim is made.

No statement in the finalized manuscript PDF is changed by this repository addendum. The PDF remains the separately secured author-held publication artifact.


## Exact-head update — v14 diagnosis and v15 repair (10 November 2026, 13:50 CET)

This is an append-only Lean-integration status update. It does not replace, reopen, or downgrade the established APW4 mathematical proof record. The mathematical energy decomposition, DT, HT, the upper energy estimate, the strict lower-bound implication, and the resulting contradiction remain retained at their stated hypotheses and exact definitions. The historical APW4 quantities and the separate CRT/BIB reconstruction remain distinct where the required index-preserving identifications have not yet been formalized. The published manuscript/PDF is not silently rewritten by a CI repair.

### Exact v14 finding

- PR [#137](https://github.com/s4ztz4bnf6-maker/Lubuimi-/pull/137), source head `175c50c75d537ef32687c63cb1219e8ff1ace257`, uses the equality `stageCoordinate hk = prefixIndex hj (Fin.last k)` and rewrites the dependent context before constructing the fibre. This removes the earlier coordinate-type mismatch.
- The exact integrated and standalone logs for this candidate now isolate a narrower proof-script defect at `BBMSTPrefixMeasureRecursion.lean:397` and `:410`: `simp only [if_pos hcovF]` / `simp only [if_neg hnotF, if_pos hpointF]` make no progress.
- The reason is syntactic but type-relevant: the witnesses `hcovF`, `hnotF`, and `hpointF` are stated at the unfolded endpoint `y (Fin.last k)`, while `updatedWeight` is still applied to the local let-bound argument `x := y (Fin.last k)`. The conditional matcher sees `x ∈ F.covered` and `x ∉ F.covered`; it is not supplied those exact propositions. The compiler's error recovery consequently reports `sorryAx` in `prefixFibre_updatedWeight_eq_PAt` and downstream recursion declarations. Those declarations are not integrated-verified at this source head.

### v15 exact repair candidate

- PR [#138](https://github.com/s4ztz4bnf6-maker/Lubuimi-/pull/138), source head `800d752e626951505d9dbcb312dfe09555ee6f2f`, transports the already-proved endpoint witnesses to the actual local argument before reducing the conditionals:
  - `hcovFx : x ∈ F.covered` from `hcovF`;
  - `hnotFx : x ∉ F.covered` from `hnotF`;
  - `hpointFx : x ∈ F.points` from `hpointF`.
  It then rewrites the exact conditional branches using those local-argument witnesses. This is a focused elaboration repair: theorem statements, assumptions, fibre definitions, and mathematical content are unchanged.
- PR #138 is **PENDING exact-head verification**. It must pass the integrated paranoid build and separate audit on the same head, print the named axiom profiles for `prefixFibre_updatedWeight_eq_PAt`, `PAt_nonneg`, `PAt_le_initial_mul_distortionProduct`, and `PAt_sum_eq_one`, and show no transitive `sorryAx`. No verification is claimed yet.

### Remaining APW4 formalization after this local repair

Once the recursion bridge passes the exact-head gate, continue with the historical identifications already tracked in the proof-obligation map: `prefixFixedCoords`, `initialProfileFamily`, the historical `c(I)) profile including the empty profile, the exact suffix-factor identification with `ν(J)), the full Lemma 3.3 cylinder inequality, and the Lemma 3.4 moment step. Then connect the resulting source-indexed prefix statements to the historical DT indices and actual BIB-place weighted-Hall transport without replacing those objects by arbitrary abstract maps. Preserve the two-term energy decomposition and ordered off-diagonal convention.

### Preservation and attribution

All established APW4 results and all earlier exact-head Lean passes remain valid for their stated scope; later integration failures do not retroactively invalidate them. Do not claim that the complete historical APW4 theorem is already fully Lean-verified until its own exact release-head build, paranoid check, named axiom output, and transitive no-`sorryAx` audit pass. Original APW4 research and formalization remain attributed to Ta-Yoshua Lubuimi; AI tools are assistants only.
