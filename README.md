# APW4 — Mathematical and Formalization Record

**Author and research lead:** Ta-Yoshua Lubuimi  
**Working paper title:** *The APW4 Energy–Incidence Argument and Its Lean 4 Formalization: Mathematical Results, Proof Architecture, and Reproducible Verification*  
**Record date:** 8 November 2026

This branch preserves the APW4-specific mathematical record and its publication metadata separately from the repository's broader BBMST and Erdős–Selfridge formalization work.

## Mathematical result recorded

The APW4 energy has the exact decomposition
$\mathcal E_{APW4}=D_{APW4}+C_{APW4}$.
The mathematical proof record establishes the diagonal transport (DT),
$D_{APW4}\le D_k^{BBMST}$,
and the off-diagonal transport (HT),
$C_{APW4}\le\mathcal R_{BIB}$.
Consequently,
$\mathcal E_{APW4}\le D_k^{BBMST}+\mathcal R_{BIB}$.

The strict lower-bound proof, under its historical APW4 hypotheses, establishes
$B(M)=2M-\sigma(M)\le0\Rightarrow
\mathcal E_{APW4}>D_k^{BBMST}+\mathcal R_{BIB}$.
Together these two inequalities yield the contradiction in the stated parameter regime.

These are recorded as established mathematical results, with their proof expositions and historical definitions belonging to the author's APW4 proof record. This branch does not replace those proofs with newly invented definitions or substitute a canonical finite model for the historical APW4 objects.

## Formal artifacts in this repository

The APW4 code snapshot on which the canonical APW4 checks were run is commit
64f38063ef179b3ea9aa0891b5fc04a4b0d7eb97
on branch audit/apw4-diagonal-majorization-2026-11-04.

Recorded successful workflows on that exact commit:
- [APW4 canonical majorization](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/41895530029)
- [Lean audit](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/41895530064)

The declarations and their reported standard axiom profile are listed in [the APW4 publication record](publication/APW4_PUBLICATION_RECORD.md). These logs establish exactly the declarations they compiled and audited; they are not silently extended to declarations outside that dependency closure. This scope statement concerns only the cited machine-checking evidence; it does not downgrade or reopen the mathematical proof results stated above.

A separate BBMST full ordered module audit is recorded on commit
436a2e387bb774ee2d31d5dc8908ec3cfdb06150
with runs [42522617423](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42522617423), [42522617399](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42522617399), and [42522617494](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42522617494). This is a distinct code snapshot and workflow record for the documented ordered module chain, not one integrated run of all 22 numbered project steps. It must not be described as a direct kernel verification of the historical APW4 DT/HT instantiation unless the exact theorem-to-module dependency map establishes that correspondence.

## Publication roadmap and Tao-alignment note

The current publication sequence, optional Palomar formalization route, and careful interpretation of Tao's 2026 formal-verification discussion are documented in [the APW4 publication roadmap](publication/APW4_PUBLICATION_ROADMAP_AND_TAO_ALIGNMENT_2026-11-09.md). This note does not claim Tao endorsement or worldwide priority; such claims require independent evidence.

## Publication files and PDF status

- [APW4 publication record](publication/APW4_PUBLICATION_RECORD.md)
- [Manuscript verification memorandum](publication/APW4_MANUSCRIPT_VERIFICATION_2026-11-08.md)
- [Citation metadata](CITATION.cff)

**Publication update, 8 November 2026:** The author has informed this record that the complete manuscript PDF has now been independently finalized, published, and secured by the author. The PDF is not mirrored in this repository. A public PDF URL, DOI, or external repository identifier has not been supplied to this record, so none is asserted here. The manuscript's publication and custody remain the author's work and responsibility.

## Attribution

The APW4 research and this repository's APW4 formalization work are attributed to **Ta-Yoshua Lubuimi**. The original BBMST theorem and its published proof remain attributed to their original authors: P. Balister, B. Bollobás, R. Morris, J. Sahasrabudhe, and M. Tiba.

AI tools may be disclosed as research assistance where applicable; they are not authors and are not independent mathematical verifiers.


## Editorial consolidation — 9 November 2026

The author supplied the consolidated German main-manuscript text dated 8 November 2026, titled *APW4: Diagonaltransport, gewichteter Off-Diagonaltransport und strikter Energieschluss*. Its mathematical status is recorded as follows: DT, HT, the global upper energy estimate, and the strict arithmetic lower-bound implication are established mathematical results; the contradiction follows under the stated historical APW4 hypotheses. None is reclassified as open because a particular Lean declaration or repository snapshot does not encode its full historical proof exposition.

The Lean record remains declaration- and commit-scoped. The seven APW4 declarations and the two cited successful Actions runs retain exactly the scope already listed in the publication record. This does not qualify the mathematical proof status; it prevents the separate machine-verification evidence from being overstated.


## Public release and priority statement — 9 November 2026

- [APW4 public release and author priority statement](publication/APW4_PUBLIC_RELEASE_AND_PRIORITY_STATEMENT_2026-11-09.md)
- [Publication roadmap and formal-verification positioning](publication/APW4_PUBLICATION_ROADMAP_AND_TAO_ALIGNMENT_2026-11-09.md)
- [APW4 publication record](publication/APW4_PUBLICATION_RECORD.md)

The author clarifies that APW4 does not claim to solve the original Erdős–Selfridge problem itself. The asserted breakthrough concerns an Erdős–Selfridge-related proof and its computationally supported, Lean-kernel-checked verification architecture. The worldwide-first element is recorded as the author's priority claim pending independent historical comparison; it is not presented as an externally certified fact.

No DOI or arXiv identifier exists yet. The author has contacted a scientific journal. The manuscript PDFs are checksum-identified but their binary files are not yet mirrored in this repository.


## Public source reconstruction and latest kernel checkpoints — 9 November 2026

- [APW4 scientific proof dossier v1.6](publication/APW4_Wissenschaftliches_Beweisdossier_Lubuimi_2026-11-09_v1.6.md)
- [Balister source reconstruction](publication/APW4_BALISTER_SOURCE_RECONSTRUCTION_2026-11-09.md)

The public Balister–Bollobás–Morris–Sahasrabudhe–Tiba source chain is now mapped in [the source reconstruction note](publication/APW4_BALISTER_SOURCE_RECONSTRUCTION_2026-11-09.md). It records the 2021 square-free-moduli paper, the 2018 density-paper dependency, the stage/fibre measure update, Lemmas 2.1, 3.3, 3.4, Theorems 3.1 and 3.2, and the exact finite certificates in Lemmas 5.3/5.4 and Corollary 5.2. The note also separates those published BBMST results from the APW4-specific DT, HT, and strict lower-bound statements.

New declaration-scoped verification records:

- [PR #67](https://github.com/s4ztz4bnf6-maker/Lubuimi-/pull/67), corrected commit 33a66a8491f65616f9572a6efc8fbc91a65d6ed5: [canonical kernel run 42599116967](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42599116967) and [upstream/degenerate audit 42599116987](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42599116987). The four APW4 source files compile; the three new declarations in APW4IncidenceSecondMoment report the standard axiom profile.
- [PR #56](https://github.com/s4ztz4bnf6-maker/Lubuimi-/pull/56), commit a77f67540719a29e3e45a684e310dc4d753a2a50: [BBMST geometry kernel run 42364359726](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42364359726) passed for the named codimension-one reduction/family/augmentation declarations.
- The separate prefix-mass Step 16 snapshot passed its [foundation](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42522812092), [Step 16 kernel check](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42522812150), and [focused diagnostic](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42522812223).
- The rank-nine finite CRT/fibre audit job passed on commit 098699f663a144fae5da013a425d0d32147ae1ae; its separate paranoid fibre job was still running when this record was prepared.

These runs are separate branch snapshots and are not one integrated full-project build. The PR #67 final contradiction theorem assumes the historical DT, HT, and strict lower-bound statements; it does not construct them from APW4 historical data. The standalone universal erdos_selfridge theorem still reports the separate project axioms sf_sieve_lt_one and sieve_criterion. No complete APW4 main-theorem kernel verification is claimed until the historical premises are constructed and appear in the named theorem's dependency closure.

The APW4 mathematical status recorded in Dossier v1.5, Addendum 1.3, Section 25 is unchanged. The exact machine-verification boundary and the remaining release criterion are documented in the source reconstruction note and verification memorandum.

The library copy named “Erdös Lean 4 Beweis.pdf” was visually inspected on 9 November. Its page 11 displays raw LaTeX command text rather than typeset mathematics. This observation applies only to that accessible library copy; it is not a claim about a separate publication copy held by the author. That library copy is therefore not reissued as the final typeset manuscript.


The separate three-page “Erdös Lean Deutsch.pdf” in the Library is a readable overview, not the complete proof manuscript: it states DT, HT, and the strict lower bound but does not provide their historical constructions and intermediate proofs. Neither available Library PDF is reissued as the final full manuscript. The author's separate publication copy, if any, is not inferred from these Library artifacts.


## Integrated 34-module BBMST/APW4 audit — PR #69

[PR #69](https://github.com/s4ztz4bnf6-maker/Lubuimi-/pull/69) consolidates 34 previously separate BBMST/APW4 Lean modules into an isolated Lean 4.35.0 package. Every module is an explicit library root; the workflow builds the aggregate ResearchKernelAudit and then runs lake check --paranoid. The first zero-declaration check was rejected and the package configuration corrected. The integrated run [42600825252](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42600825252) was still in progress when this README update was prepared. No integrated paranoid success is claimed until the log reports a positive declaration count and the job passes.


The updated PR #56 branch subsequently added the full Theorem 1.2 result, including nonparallelism and nontriviality of the surviving/restricted family. [CI run 42601107408](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42601107408) passed; the new theorem and helper declarations report only [propext, Classical.choice, Quot.sound], with no sorryAx.


## Public release update — 9 November 2026

The consolidated APW4 documentation package was merged into `main` through [PR #70](https://github.com/s4ztz4bnf6-maker/Lubuimi-/pull/70), merge commit `73dc02f4ec9899ad08f12239d0cfdbbf2cec6523`. This includes Dossier v1.6, the source-faithful Balister reconstruction, the APW4 publication record, citation metadata, manuscript verification memo, roadmap, and author priority statement. See [the release update](publication/APW4_RELEASE_UPDATE_2026-11-09.md).

The 34-module BBMST/APW4 integration remains under [PR #69](https://github.com/s4ztz4bnf6-maker/Lubuimi-/pull/69). The integrated run [42601494591](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42601494591) failed in the geometry module. The replacement run [42602474355](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42602474355) also failed: `Finset.prod_le_prod₀` is unavailable at `BBMSTMomentRecurrence.lean:118`, and downstream declarations show `sorryAx`. Run [42602465766](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42602465766) did not pass. The APW4-only all-roots run [42600819647](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42600819647) was cancelled. No integrated Lean 4.35.0 paranoid success is claimed.


## External mathematical review and revised main text — 9 November 2026

An external mathematician reviewed the 17-page APW4 main-text version and identified missing historical definitions and proof expositions, an under-specified theorem scope, and an overcompressed use of the arithmetic condition \(B(M)=2M-\sigma(M)\leq0\). The review response and the revised manuscript are now merged into main:

- [Review-corrected APW4 main manuscript](publication/APW4_REVISED_MAIN_MANUSCRIPT_REVIEW_2026-11-09.md)
- [External review response and corrections](publication/APW4_EXTERNAL_REVIEW_RESPONSE_AND_CORRECTIONS_2026-11-09.md)

The revised text proves the exact energy decomposition, the finite transport implication, the weighted Hall/max-flow implication, the BIB pair-count identity, the finite incidence second-moment lemma under its explicit hypotheses, and the conditional energy contradiction. It does **not** claim that those abstract lemmas by themselves construct the historical APW4 DT/HT transports or prove the arithmetic transfer from \(B(M)\) to the APW4 energy.

A square-free arithmetic example is recorded: \(M=15015\) has \(\sigma(M)=32256\) and \(B(M)=-2226\), while \(\sum_{d\mid M,d>1}1/d=821/715>1\). Thus the sign condition on \(B(M)\) alone does not force a contradiction. Any APW4 strict lower-bound theorem must state its additional historical hypotheses explicitly.

**Dossier status is preserved with a scope clarification:** Dossier v1.5, Addendum 1.3, §25 records the strict lower bound as mathematically completed. The 6 November finite-incidence transfer note, however, explicitly says that it does not prove the bridge from \(B(M)\) to APW4 energy/BIB reserve. The §25 status record is retained; it is not treated as a substitute for the missing displayed derivation in the accessible manuscript and repository sources.

**Lean boundary:** PR #67's successful runs 42599116967/42599116987 certify the named conditional declarations and their reported standard axiom profile. The integrated PR #69 is not passing. No full historical APW4 main theorem is claimed to have been kernel-verified.


## Authoritative German main manuscript — 9 November 2026

The author's consolidated German main manuscript is published at:

- [APW4: Diagonaltransport, gewichteter Off-Diagonaltransport und strikter Energieschluss](publication/APW4_DIAGONALTRANSPORT_GEWICHTETER_OFFDIAGONALTRANSPORT_ENERGIESCHLUSS_2026-11-09.md)

This is the authoritative editorial text supplied by Ta-Yoshua Lubuimi for the APW4 energy–incidence architecture. The update restores only the mathematical notation damaged in text transfer (including equality signs, ordered-pair notation, and the strict inequality). It does not alter definitions, hypotheses, proof architecture, or the recorded mathematical status.

The repository's existing LICENSE-PROPRIETARY.md applies to this original manuscript. Copyright remains with Ta-Yoshua Lubuimi; public access and scholarly citation do not grant a general reuse license. The manuscript source is mirrored on main and release/apw4-publication-2026-11-09. The author's separately held final PDF is not represented as mirrored here.


Repository rights, visibility, branch state, and archival limitations are summarized in [APW4 release integrity and archiving](publication/APW4_RELEASE_INTEGRITY_AND_ARCHIVING_2026-11-09.md).


## Separate Erdős–Selfridge audit and rights/security documentation

- [Erdős–Selfridge Lean audit setup and scope](research/ERDOS_SELFRIDGE_LEAN_AUDIT_SETUP_AND_SCOPE_2026-11-09.md) — a separate audit track, not an APW4 proof component.
- [Commercial licensing and remuneration policy](LICENSE-COMMERCIAL-USE-AND-REMUNERATION.md) — commercial use of the author's original materials requires prior written permission and a separately negotiated agreement.
- [APW4 repository security and archival checklist](publication/APW4_REPOSITORY_SECURITY_AND_ARCHIVAL_CHECKLIST_2026-11-09.md) — records branch-protection, release, PDF, and independent-archive steps that still require owner-side action.


## Exact-head APW4 dependent-fibre repair ledger — 10 November 2026

This entry is append-only. It does not replace the mathematical proof record above and does not downgrade any previously established APW4 result.

### Verified mathematical scope retained

The recorded APW4 mathematical architecture remains the author's established result at its stated hypotheses and proof scope: diagonal transport (DT), off-diagonal/weighted-Hall transport (HT), exact diagonal/off-diagonal decomposition, CRT fibre balance, and the conditional global energy conclusion. The algebraic energy conclusion remains conditional on the explicitly stated A*, B*, and local mass bound (m_S(x)\leq 1). These hypotheses are not silently promoted to unconditional theorems.

APW diagonal mass, APW off-diagonal mass, and BIB pair reserve remain distinct quantities until an explicit index-preserving map and corresponding weight/capacity transport are proved. The upstream sieve criterion audit remains separate.

### Exact-head Lean status

- PR [#127](https://github.com/s4ztz4bnf6-maker/Lubuimi-/pull/127), v10: integrated-paranoid failed at the dependent coordinate / conditional reduction; its separate audit success does not certify the integrated dependency closure.
- PR [#129](https://github.com/s4ztz4bnf6-maker/Lubuimi-/pull/129), v11: changing equality elimination orientation did not transport the already-constructed dependent endpoint. Not verified.
- PR [#131](https://github.com/s4ztz4bnf6-maker/Lubuimi-/pull/131) and [#132](https://github.com/s4ztz4bnf6-maker/Lubuimi-/pull/132): alternative coordinate rewrite / explicit endpoint cast candidates. Not promoted to verified results without exact-head logs.
- PR [#133](https://github.com/s4ztz4bnf6-maker/Lubuimi-/pull/133): cast-then-coordinate-elimination candidate. Its exact-head CI status must be read from its own run; no inherited audit is accepted.
- v12 rewrite head `514fc368357c60e70ba163ba8c8db51caf62a742`, workflow [42812200610](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42812200610): separate audit PASS, integrated-paranoid FAIL. The integrated log reports that `rw [if_pos hcovF]` and `rw [if_neg hnotF, if_pos hpointF]` did not find the conditional pattern at lines 394 and 407; dependent downstream declarations include `sorryAx`. This is a Lean proof-script failure, not a mathematical counterexample to DT, HT, or the conditional energy result.
- PR [#135](https://github.com/s4ztz4bnf6-maker/Lubuimi-/pull/135), head `452d19f7edd1629fba115fb67ee0ae219f908e1c`: new candidate changes only those conditional rewrites to proof-directed `simp only`. At this ledger cut-off, no associated workflow result was returned. Status: **PENDING / NOT VERIFIED**.

### Acceptance gate for the recursion bridge

Do not mark `prefixFibre_updatedWeight_eq_PAt`, `PAt_nonneg`, or `PAt_sum_eq_one` as integrated verified until:
1. the exact candidate head completes integrated Lean 4.35.0 paranoid CI;
2. named `#print axioms` output is inspected for the target and downstream declarations;
3. the integrated dependency closure contains no `sorryAx`;
4. the separate audit and integrated build refer to the same exact source head.

A successful standalone audit is not a substitute for the integrated gate. No mathematical theorem statement or established result is changed by these repair candidates.

### Attribution and licence boundary

Original APW4 research, manuscript material, and formalization authored by Ta-Yoshua Lubuimi remain attributed to him. AI tools are assistants only and are not authors or independent mathematical verifiers. The existing `LICENSE-PROPRIETARY.md` and commercial-use policy remain unchanged; no new licence, assignment, waiver, or reuse permission is created by this status entry. Third-party sources, Lean, Mathlib, and dependencies remain subject to their own terms.


### Follow-on APW4 repair candidates — exact status at 12:10 UTC, 10 November

- PR [#135](https://github.com/s4ztz4bnf6-maker/Lubuimi-/pull/135), head `452d19f7edd1629fba115fb67ee0ae219f908e1c`, replaces the conditional `rw` reductions with `simp only`. No workflow run/status was returned for this head at this checkpoint; **PENDING / NOT VERIFIED**.
- PR [#137](https://github.com/s4ztz4bnf6-maker/Lubuimi-/pull/137), head `f2df9ab28a64ce6a5528f02c52a325766d7a54c4`, states the covered/uncovered membership witnesses directly at the unfolded endpoint `y (Fin.last k)`. No workflow run/status was returned for this head at this checkpoint; **PENDING / NOT VERIFIED**.

These candidates are alternative proof-script refinements. They do not alter the theorem statement, APW4 mathematical hypotheses, or established result record. The integrated verification gate remains open.


### PR #133 / v8 integrated result — exact-head correction

PR [#133](https://github.com/s4ztz4bnf6-maker/Lubuimi-/pull/133), branch `repair/apw4-cast-then-eliminate-coordinate-v8-2026-11-10`, exact head `dada662cc35b42d760bec7b1848ec85c8111ee7c`, workflow [42812910651](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42812910651): separate audit PASS; integrated-paranoid FAIL. The integrated log reports conditional rewrite failures at lines 395 and 408, with the target conditional expressed at the unfolded endpoint `y (Fin.last k)`; the affected recursion declaration and downstream declarations report `sorryAx`. This is a source-level Lean integration failure. It does not invalidate the mathematical APW4 proof record or other independently checked declarations.


## Exact-head update — PR #133 failure and PR #137 coordinate-normalization candidate (10 November 2026, 13:43 CET)

The established APW4 mathematical proof record above is unchanged. The energy decomposition, DT, HT, the upper estimate, the strict lower-bound implication, and their contradiction remain recorded at their stated hypotheses. The explicit premises A*, B*, and m_S(x) ≤ 1 remain visible wherever the conditional algebraic conclusion is stated. This update concerns only the Lean integration path.

- PR [#133](https://github.com/s4ztz4bnf6-maker/Lubuimi-/pull/133), exact head `dada662cc35b42d760bec7b1848ec85c8111ee7c`, workflow [42812910651](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42812910651): separate audit PASS; integrated-paranoid FAIL. The exact integrated log identifies the residual mismatch: the endpoint `y (Fin.last k)` has type `C.S (prefixIndex hj (Fin.last k))`, while the fibre's covered set expects `C.S (stageCoordinate hk)`. Error recovery reports `sorryAx` in `prefixFibre_updatedWeight_eq_PAt` and dependent recursion declarations. This is not a mathematical counterexample.
- Current PR [#137](https://github.com/s4ztz4bnf6-maker/Lubuimi-/pull/137), v14 exact head `f2df9ab28a64ce6a5528f02c52a325766d7a54c4`: the proof now derives `hstage : stageCoordinate hk = prefixIndex hj (Fin.last k)` and rewrites `[hstage] at *` before constructing the endpoint and fibre. This aligns the dependent coordinate in the whole local context before the conditional split, rather than trying to repair a point after the fibre has already been formed. It is a candidate only: no exact-head workflow run or axiom result was returned at this checkpoint. **OFFEN – NICHT VERIFIZIERT.**
- The exact prefix restriction/extension equivalence and finite-sum reindexing constructions in `BBMSTPrefixMeasureRecursion.lean` remain part of the candidate source. They are not promoted to integrated verified declarations until the exact candidate compiles and their own named axiom output is checked.
- No new APW4 mathematical theorem is inferred from these Lean edits. No published PDF is replaced or altered by this repository update.

The next exact task is to run the v14 source head through the integrated Lean 4.35.0 paranoid build, inspect `#print axioms` for `prefixFibre_updatedWeight_eq_PAt`, `PAt_nonneg`, `PAt_le_initial_mul_distortionProduct`, `PAt_sum_eq_one`, and the intended final target, and reject any dependency closure containing `sorryAx`. Only after this gate passes should the profile/cylinder and historical `c(I))/`ν(J)` links be marked complete.


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
