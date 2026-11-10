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


## Exact-head continuity update — 10 November 2026

PR #79's explicit status correction remains binding: later integration errors do not retroactively invalidate already-proved APW4 mathematics. The published valuation-word cylinder theorem in PR #36 is not reopened. Mathematical proof, historical reconstruction and Lean/CI verification remain separate evidence categories.

- APW4 PR #93 head `fbab49639954ae749d30a884a04032ee1d4d0f0e`: generic dyadic residue-cylinder source added; exact workflow [42754632105](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42754632105) has audit success, integrated-paranoid failure in the separate prefix recursion, and isolated Syracuse paranoid still running at last poll. No overall PASS.
- APW4 PR #101 head `f5aff142fcdf6c3893ef1c890f3be45a67da68aa`: explicit finite-universal membership added to the uncovered update branch. Exact workflow [42755782237](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42755782237) queued at this snapshot; no PASS.
- Collatz PR #48 head `5699182344be6a7950c6265551112a7a6d50e58d`: workflow [42755702331](https://github.com/s4ztz4bnf6-maker/Lubuimi/actions/runs/42755702331) queued. The preceding head's Lean 4.35.0 paranoid job and draft compile passed; Lean 4.34.1 failed because its Lake version does not recognize `lake check`, not because of a reported theorem failure.
- Kolaz PR #39 finite archive workflow [42739986917](https://github.com/s4ztz4bnf6-maker/Lubuimi/actions/runs/42739986917) passed exact finite-table reproducibility tests. This is not Lean verification or a global Collatz result.

All statuses are scoped to the exact source heads and runs stated. No pending workflow is represented as passed.


## Additional exact-head repair and explicit tail-residue candidate — 10 November 2026

- PR #101: the prior explicit Finset.univ proof failed because the rewrite witness did not match the dependent stage-fibre type. The new head 6bad5a25400aeae8e851a38c507141ec0e092a3a gives the witness the explicit type Finset (C.S (stageCoordinate hk)) and separates the two conditional rewrites. Exact workflow [42756335441](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42756335441) is queued; no PASS is claimed.
- PR #107: new source head ba96a24de4df64513dd1a3dd801020544cc71dd0 adds an explicit normalized tail coordinate -d * (3^(k+1))⁻¹ in ZMod (2^B). It proves the odd coefficient is a unit, the normalized tail congruence has a unique solution, and the generic residue-cylinder tail is instantiated as a singleton with the exact candidate mass. It also proves the affine factorization from the prefix lift under the explicit divisibility identity defining d.
- The divisibility identity for d is still an explicit hypothesis in PR #107. Deriving it from the full prefix-residue formula, proving the full exact-child sibling partition, and mapping the result to historical APW4/BIB events remain separate obligations.
- PR #107 exact workflow [42756257770](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42756257770) is queued. The new declarations are candidates, not verified PASS results.


## Superseding source-head record — 10 November 2026

PR #107 was advanced after its initial commit. Current exact source head: b5a7b83c1953927eef27b39962b044c746191066. The affine factorization proof was rewritten as an explicit three-step calc using the stated divisibility identity, avoiding a broad rewrite whose matching depended on distributivity. Exact workflow [42756547571](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42756547571) is queued; no PASS is claimed for this updated head. The earlier head ba96a24de4df64513dd1a3dd801020544cc71dd0 was superseded before verification completed.


## Verification queue snapshot — 10 November 2026 (latest)

- PR #93, source head fbab49639954ae749d30a884a04032ee1d4d0f0e: syracuse-bridge-paranoid remains in progress; integrated-paranoid failed at BBMSTPrefixMeasureRecursion.lean:407 with unsolved goals and downstream sorryAx; audit succeeded. This is a failure of that integration snapshot, not a retroactive change to the separately established APW4 theorem results.
- PR #101, source head 6bad5a25400aeae8e851a38c507141ec0e092a3a: the revised dependent-stage/uncovered-branch proof is being compiled by integrated-paranoid; the audit job is queued. No result yet.
- PR #107, source head 33ff0b894391e6845a81fe1a5f472671086021ef: its prior full jobs were cancelled on the earlier source snapshot. The audit-only retry is queued; a full exact-head paranoid run is still required. The explicit residue/factorization statements remain formalization candidates until that run and the axiom audit finish.
- PR #105 documentation audit succeeded. This verifies its documentation workflow only, not Lean mathematics.
- Previously published valuation-word cylinder theorem (PR #36) and all previously proved APW4 results remain retained at their established status. No result in this queue changes those proofs.


## Latest exact-head reconciliation — 10 November 2026

- PR #101 current head remains 6bad5a25400aeae8e851a38c507141ec0e092a3a. Workflow [42756335441](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42756335441): integrated-paranoid is in progress and audit is queued. No PASS yet.
- PR #107 current head is now 3534d47fcb9857109b71d1397f3976b5de35dcf1. In addition to the explicit unique tail coordinate, it now defines the prefix-tail numerator and its canonical quotient, proves the quotient multiplication identity under the exact divisibility hypothesis, and packages the lift factorization with that canonical quotient. The earlier workflow [42756547571](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42756547571) was cancelled when the branch advanced; no completed verification has been returned for the current head.
- PR #105 documentation branch current head is cf918706cf242d04e70e2b4edd41750c33bf94ed. Its exact-head workflow [42756718300](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42756718300) is queued. Earlier docs-only head bbfe91e33a09a3f1325a5d6e0952c615e6c40c52 passed its audit in run 42756393394; that PASS is scoped to that earlier head.


## Dependent uncovered-branch repair — 10 November 2026

The integrated-paranoid attempt for PR #101 at prior head 6bad5a25400aeae8e851a38c507141ec0e092a3a failed at BBMSTPrefixMeasureRecursion.lean:414. The failure was a dependent-type mismatch in the universe-membership witness: the goal expected Finset.univ over C.S (prefixIndex hj (Fin.last (a+j))), while the witness was typed over C.S (stageCoordinate hk). The source has now been corrected on PR #101 at head 30dac5cf32445326aaad1b717e125c0688bea5a0 to state the exact goal type. This is a targeted repair, not a verified result; an exact-head integrated-paranoid run remains pending.

PR #93's older integrated snapshot also failed in the same recursion theorem at line 407, leaving sorryAx in downstream PAt_nonneg and PAt_sum_eq_one. PR #101 is the explicit repair line; neither failure changes the separately proved APW4 results or the published PR #36 valuation-word cylinder theorem.

PR #107's previous attempt remains cancelled at its full Lean jobs; its exact current source head is 33ff0b894391e6845a81fe1a5f472671086021ef. The explicit residue candidate is still awaiting a full exact-head run and clean named axiom audit.


## Exact-head verification mirrors started — 10 November 2026

- Draft PR #108 is a verification-only mirror of PR #101's latest source head 30dac5cf32445326aaad1b717e125c0688bea5a0. It has two queued integrated-paranoid/audit workflow attempts (42757020571 and 42756928257). Canonical mathematical repair remains PR #101; do not merge the mirror.
- Draft PR #109 is a verification-only mirror of PR #107's latest source head 33ff0b894391e6845a81fe1a5f472671086021ef. Its initial workflow attempt 42756751052 was cancelled; an audit-only retry has been queued. The Syracuse bridge paranoid job still needs a completed exact-head run. Canonical mathematical development remains PR #107; do not merge the mirror.
- These mirrors exist solely to obtain fresh exact-head CI after the original branch attempts were cancelled or completed on preceding snapshots. They add no theorem claims and do not alter the mathematical status ledger.


## APW4 dependent-stage normalization repair — latest source candidate

PR #101 has advanced to head f87657c8f02f41266a43bae1fe44f43267f0c985. The preceding exact-head run 42756335441 failed again at the uncovered branch: even with an explicit universal-membership witness, the dependent Finset membership rewrite did not match the update expression. The new repair changes the proof order instead: it identifies the proof witnesses and eliminates the dependent stage-coordinate equality before constructing and unfolding the FibreData object. The covered/uncovered split is then made only after the fibre's point type is normalized. This targets the source of the type mismatch rather than adding another local rewrite witness.

The new commit is a proof candidate. No exact-head CI run or Lean PASS has yet been returned for f87657c8f02f41266a43bae1fe44f43267f0c985. The previous failed run and its sorryAx propagation remain recorded against their own exact heads.


## Latest mathematical-source deltas and verification mirrors — 10 November 2026

- Canonical PR #101 advanced to f87657c8f02f41266a43bae1fe44f43267f0c985. The dependent stage-index normalization (proof-witness equalities and stageCoordinate = prefixIndex) is now performed before constructing/unfolding the prefix fibre. The covered/uncovered split is reduced to simp [hcov] in each branch. This is a new proof candidate; exact-head integrated-paranoid and audit runs are queued, not passed.
- Canonical PR #107 advanced to 3534d47fcb9857109b71d1397f3976b5de35dcf1. It now defines the numerator N = 3^(k+1) r₀ + 3 Cₖ + 2^A and the canonical quotient d = N / 2^(A+1), proves the quotient multiplication identity from divisibility, and derives the affine prefix-tail factorization with that canonical d. The divisibility N mod 2^(A+1) = 0 remains an explicit hypothesis; it has not yet been derived from the full valuation-prefix residue theorem. This is a substantive narrowing of the formalization gap, not a completed APW4 bridge.
- Stale verification mirrors #108 and #109 were closed after their source heads moved. Current verification-only draft mirrors are #110 (exact PR #101 head) and #112 (PR #107 plus one comment-only trigger commit). Their integrated/audit/paranoid jobs are queued. Canonical mathematical branches remain PR #101 and PR #107; do not merge the mirrors.
- PR #105 documentation audit remains queued at the latest documentation head. No new PASS is claimed for any of these queued runs.


## Exact child-cylinder extension — current PR #107 head

Canonical PR #107 now stands at cad354967759a89c02df1b42369898dec3406445. It adds the exact child-b coordinate modulo 2^b, proves its congruence and uniqueness, and identifies each child as a residue cylinder with exactly 2^(B-b) lifts in the common refinement. The exact-head workflow [42757204609](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42757204609) is queued. The prefix divisibility derivation and complete child-plus-tail partition remain open formal steps; no Lean PASS is claimed.


## PR #107 namespace and child-residue consolidation — latest source head

PR #107 now stands at exact source head 44d00ad20c352471795358dde2aaf24152281649. The canonical quotient and exact child-coordinate declarations are now kept inside the SyracuseDyadicResidueFibre namespace, alongside the generic tail-cylinder construction. The provenance note was also corrected to describe the actual source extension rather than calling the code commit comment-only. This head includes the unique tail coordinate, quotient/factorization under the explicit divisibility condition, unique exact child-b residues modulo 2^b, and 2^(B-b) child lift counts. The exact prefix-divisibility derivation and complete child-plus-tail partition remain open.

No completed exact-head CI result has yet been returned for 44d00ad20c352471795358dde2aaf24152281649. No Lean PASS is claimed.


## Latest workflow queue snapshot — 10 November 2026

- PR #101 current source head f87657c8f02f41266a43bae1fe44f43267f0c985: exact workflow [42757161402](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42757161402), integrated-paranoid and audit both queued.
- PR #107 current source head 44d00ad20c352471795358dde2aaf24152281649: exact workflow [42757388002](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42757388002), isolated Syracuse paranoid, integrated-paranoid and audit all queued.
- PR #105 current documentation head 850bff36256ca81a125c43038ce605550d5f3eea: exact workflow [42757417421](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42757417421), audit queued.
- Collatz PR #48 current head 7920b26f8a230c6f9fdc144be40fb2070eba5f00: exact workflow [42756479069](https://github.com/s4ztz4bnf6-maker/Lubuimi/actions/runs/42756479069), Lean 4.34.1 build, compile-drafts and Lean 4.35.0 paranoid jobs queued.

These are queued states, not PASS results. The previously verified Collatz Lean 4.35.0 finite-cap source result remains scoped to exact commit e1fb06eaa07190d8abfb3fc7368f3dc0663a5a66 and workflow 42754461228.


## Workflow status refresh — 10 November 2026

- PR #101 head f87657c8f02f41266a43bae1fe44f43267f0c985: run [42757161402](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42757161402); audit is in progress, integrated-paranoid queued.
- PR #107 head 44d00ad20c352471795358dde2aaf24152281649: run [42757388002](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42757388002); audit, isolated Syracuse paranoid and integrated-paranoid queued.
- PR #105 documentation head 8866fa2600c0de9bd41becefda77d157fc8f6465: run [42757470737](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42757470737), audit queued.
- Collatz PR #48 documentation/workflow head cbe9f19b9ba1bd4bad290b1cbc56da2881c238b8: run [42757504798](https://github.com/s4ztz4bnf6-maker/Lubuimi/actions/runs/42757504798), all three jobs queued.

No queued or in-progress job is a PASS. The previously recorded Collatz Lean 4.35.0 paranoid PASS remains scoped to its exact source head and run.


### 10 November 2026 — exact-head CI reconciliation

- APW4 PR #101 current source head: `f87657c8f02f41266a43bae1fe44f43267f0c985`. Run [42757047779](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42757047779): audit passed; integrated-paranoid was still running at the latest check. Run [42757161402](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42757161402): audit and integrated-paranoid were running. No integrated PASS claimed.
- Earlier PR #101 head `f5aff142fcdf6c3893ef1c890f3be45a67da68aa`, run [42755782237](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42755782237), failed at `BBMSTPrefixMeasureRecursion.lean:411:23`; `sorryAx` appeared in dependent recursion theorems. This failure remains scoped to that exact head.
- APW4 PR #107 current head: `44d00ad20c352471795358dde2aaf24152281649`; run [42757388002](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42757388002) was queued. No PASS claimed.
- Collatz PR #48 run [42756479069](https://github.com/s4ztz4bnf6-maker/Lubuimi/actions/runs/42756479069): Lean 4.34 kernel check, draft compilation, and Lean 4.35 paranoid kernel check were all queued at the latest check.

The detailed run-by-run ledger is in `publication/APW4_CI_STATUS_SNAPSHOT_2026-11-10.md`. Documentation commit `cc7612b0530f4abf857a4b5dc49d9100dc5413cd` records the APW4 exact-head reconciliation. Previously established mathematical results, including the PR #36 valuation-word cylinder theorem, are not downgraded by these integration statuses.


### 10 November 2026 — exact-head follow-up (04:50 UTC)

The current exact-head results supersede the earlier queue status above:

- APW4 PR #101 head `f87657c8f02f41266a43bae1fe44f43267f0c985`, run [42757161402](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42757161402): audit passed; integrated-paranoid failed at the two dependent membership branches in `BBMSTPrefixMeasureRecursion.lean:393–394`. The recursion identity and dependent `PAt) results still carry `sorryAx` in that run. No formal PASS is claimed.
- APW4/Syracuse PR #107 head `44d00ad20c352471795358dde2aaf24152281649`, run [42757388002](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42757388002): both bridge-paranoid and integrated-paranoid failed on the dependent `ZMod.val`/Fin representative and one reverse-implication goal; downstream atom/cardinality declarations carry `sorryAx`. The normalized residue uniqueness/factorization results have separate positive axiom output, but this does not clear the failed declarations.
- Collatz PR #48 head `cbe9f19b9ba1bd4bad290b1cbc56da2881c238b8`, run [42757504798](https://github.com/s4ztz4bnf6-maker/Lubuimi/actions/runs/42757504798): all three jobs were queued at the last poll.

The detailed exact-head evidence is in [the CI status snapshot](publication/APW4_CI_STATUS_SNAPSHOT_2026-11-10.md) and [the scientific proof dossier, Section VI](publication/APW4_Wissenschaftliches_Beweisdossier_Lubuimi_2026-11-09_v1.6.md). These are formalization updates only. Established APW4 mathematics and the finalized author-controlled manuscript are not changed or downgraded.


### 10 November 2026 — PR #101 targeted contradiction branch (04:55 UTC)

A narrow proof candidate was committed to PR #101 at exact head `dbbeaf7a14ebcceb8abf97b6a9113d84a024c54c`. The positive branch now eliminates the residual implication `¬hcov → …` directly from the branch hypothesis `hcov`; the uncovered branch remains `simp [hcov]`. Runs [42758799252](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42758799252) and [42758803063](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42758803063) were queued at the latest poll. This is a proof candidate only: no Lean PASS, no axiom-profile clearance, and no change to established APW4 mathematics are claimed.


### Syracuse residue-coordinate repair candidate — 2026-11-10

On branch `bridge/syracuse-explicit-tail-residue-2026-11-10`, commit `bd8a7857a07f4fb32bbcfe9e2b446bd5b7403028` replaces invalid projections of `.isLt` from `ZMod` values in `explicitTailCoordinateFin` and `explicitChildCoordinateFin` with the Mathlib theorem `ZMod.val_lt`. The theorem was checked against Mathlib `v4.35.0` (`Mathlib/Data/ZMod/Basic.lean`, declaration `ZMod.val_lt`). This is a source-level repair candidate only; the new CI run `42759029006` was queued at the time of this entry. It does not certify the remaining membership proof or any Syracuse theorem.

### 10 November 2026 — PR #101 equality-branch correction and exact-head workflow

The complete integrated log for run [42758803063](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42758803063) corrects the earlier diagnosis: the positive branch goal was already an equality, not an implication, so `intro hnot` had no binder to introduce. Exact source head `0be00b2161ad8f2676779b90582f30b34083c008` now uses `simp [hcov]` in both membership branches. The exact-head workflow [42759210844](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42759210844) has been created, but its audit and integrated-paranoid jobs are still QUEUED at this observation. No compile, axiom, or paranoid PASS is claimed.

Syracuse run [42759029006](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42759029006) has advanced: the integrated job is compiling the full integrated package; the audit job has started its setup; the dedicated Syracuse-paranoid job remains QUEUED. The ZMod.val_lt source repair remains unverified pending all jobs and named declaration audits.

Collatz PR #48 exact head `cbe9f19b9ba1bd4bad290b1cbc56da2881c238b8` remains under run [42757504798](https://github.com/s4ztz4bnf6-maker/Lubuimi/actions/runs/42757504798); its three jobs remain QUEUED. No result is inferred.

A concrete next formalization target is now isolated for the Collatz minimal-counterexample bridge: from the actual accelerated Syracuse step equation `2^(a j) * n(j+1) = 3*n(j)+1` and positivity of `a j`, derive oddness of `n j`. Since the next odd iterate is also odd, the displayed quotient is odd and `a j` is the exact 2-adic valuation. Then prove the shifted tail is the deterministic Syracuse orbit from `n j`; minimality among odd nonterminating starts can then supply the currently assumed suffix-return premise. This is a proof plan, not yet a Lean theorem or a verified result.


### Syracuse #107 — first integrated CI diagnosis and membership follow-up (10 Nov 2026)

Run 42759029006 completed with failures in all three verification paths: integrated-paranoid, audit, and the dedicated Syracuse bridge. The exact compiler failures were isolated:

- SyracuseDyadicResidueFibre.lean:290: the reverse direction of explicitTailAtoms_mem_iff left the representative bound coord.val % 2^B = coord.val open. The resulting declaration printed sorryAx and must not be accepted.
- BBMSTPrefixMeasureRecursion.lean:386 on the PR #107 integration branch: the endpoint y (Fin.last ...) was not transported from prefixIndex hj ... to stageCoordinate hk; Lean reported an explicit dependent-coordinate type mismatch. This is separate from the PR #101 exact-head candidate, which contains additional proof-witness/index normalization and is being checked in its own workflow.

A targeted follow-up was committed to PR #107: 5139df8b55279011862084c453105a13926b03cc. In the reverse membership direction it now rewrites by the representative equality and proves the remaining modulo identity using the actual bound (explicitTailCoordinateFin B k d).isLt. New exact-head run 42759653537 is QUEUED at the latest poll. This is only a candidate; no sorryAx clearance is claimed until the exact new log and axiom output confirm it.

The APW4 integration mismatch in the PR #107 branch is not silently patched by this Syracuse-only change. PR #101 head 0be00b2161ad8f2676779b90582f30b34083c008 has its own exact-head run 42759210844, with audit and integrated-paranoid still running at the latest poll. The established APW4 mathematical results remain unchanged.


### 10 November 2026 — PR #101 reached the decisive recursion compile stage

Exact-head run 42759210844 for 0be00b2161ad8f2676779b90582f30b34083c008 has progressed past the upstream source, focused degenerate-witness tests, zero-safe sieve parameter core, zero-safe fibre measure core, finite weighted fibre update, uniform-coordinate instantiation, finite-stage moment bounds, finite-coordinate geometry, and uniform-stage source moment instantiation. The audit is now compiling the source-indexed BBMST prefix measure recursion itself. In parallel, integrated-paranoid has completed package assembly, sandbox setup, and Mathlib cache restoration and is compiling the full integrated BBMST/APW4 package including the Theorem 1.2 reduction. Both jobs remain IN_PROGRESS. This is meaningful progress to the exact target, but neither is a PASS; no `sorryAx` clearance or axiom-profile claim is made until all named checks complete.


### 10 November 2026 — integrated failure and exact membership-transport candidate

The two jobs of exact-head run 42759210844 now give a non-uniform result and must be reported separately. The audit job completed SUCCESS and its direct `lake env lean -o ... BBMSTPrefixMeasureRecursion.olean` log printed the target declarations `prefixFibre_updatedWeight_eq_PAt`, `PAt_nonneg`, `PAt_le_initial_mul_distortionProduct`, `PAt_succ_le_prev_div_card_mul_one_sub_delta`, and `PAt_sum_eq_one` with the profile `[propext, Classical.choice, Quot.sound]`. However, the integrated-paranoid job completed FAILURE on the same reported PR head, with unsolved goals at lines 393–394 in the same theorem; its failure recovery output printed `sorryAx` for that theorem and dependent declarations. Therefore the integrated source proof is not accepted as closed. The discrepancy between the audit and integrated job outputs is itself an open CI reproducibility/integration issue; do not merge their evidence or claim a clean integrated proof.

The integrated failure is specific: after the existing `simp only` expansion, the positive and negative branches still contain a mismatch between the membership predicate used by `updatedWeight`'s `F.covered` field and the recursive `PAt` covered predicate. The residual goal includes the fibre's `if y ∈ Finset.univ then ...` test and opposite covered/uncovered multipliers. This is not resolved merely by writing `simp [hcov]` against the recursive predicate.

A follow-up candidate is committed on PR #101: `31cc94993fdcb481cea919ca762a29c568948a7a`. It chooses the case split on the actual `F.covered` membership, then explicitly transports that fact to the recursive `prefixCoveredValues` predicate before simplifying the two sides. Exact-head workflow [42760198290](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42760198290) has been created and is QUEUED at this observation. This is a targeted experiment, not a verified repair.


### 10 November 2026 — Syracuse audit isolates APW4 dependency failure

Run 42759653537 (PR #107, exact head `5139df8b55279011862084c453105a13926b03cc`) has now exposed a useful separation. Its audit directly compiled `SyracuseDyadicResidueFibre.lean`; the log printed `explicitTailAtoms_mem_iff`, `explicitTailAtoms_card`, and `explicitCandidate_mass` with `[propext, Classical.choice, Quot.sound]`, and the focused module output contained no `sorryAx`. The overall audit job nevertheless failed later when its `AuditCheck.lean` dependency compilation reached the APW4 source `BBMSTPrefixMeasureRecursion.lean:386:2` and reported `error: dsimp made no progress`; the downstream APW4 declarations then showed `sorryAx` in that failed compilation. Therefore this failure does not invalidate the isolated Syracuse module result and must not be reported as a Syracuse modulo proof failure. The separate `syracuse-bridge-paranoid` job was still in progress at the latest poll; integrated-paranoid was queued. No full PR #107 pass is claimed.


## Exact-head CI addendum — 10 November 2026, 06:25 CET

This entry is append-only. It does not revise the mathematical status of the established APW4 results or the independently published manuscript held by the author.

### PR #101 — prefix-fibre recursion candidate

- Candidate source head recorded in the preceding entry: `31cc94993fdcb481cea919ca762a29c568948a7a`; workflow [42760198290](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42760198290).
- `integrated-paranoid` failed while compiling `BBMSTPrefixMeasureRecursion.lean`: the two residual goals are at lines 390 and 402 in that checkout. The positive branch retains an implication whose premise is the negation of the covered predicate despite the local positive membership hypothesis; the negative branch retains the covered/uncovered conditional rather than reducing it. The integrated log prints `sorryAx` for `prefixFibre_updatedWeight_eq_PAt` and dependent `PAt) declarations. This is a real failure of that exact integrated build.
- The separate `audit` job passed its staged compilation and reported the standard profile for its audited declarations. That result is a distinct audit path and does not override the integrated failure.
- The next source repair must align the update's actual `F.covered` predicate with the recursive `prefixCoveredValues) predicate before unfolding either conditional, then simplify the two branches explicitly. This is a repair target, not a verified fix. No previously established APW4 mathematical theorem is reopened by this Lean integration failure.

### Syracuse PR #107 — isolated and integrated scopes

Workflow [42759653537](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42759653537) has the following distinct outcomes:

- The targeted `SyracuseDyadicResidueFibre.lean` compilation succeeded. `explicitTailAtoms_mem_iff`, `explicitTailAtoms_card`, and `explicitCandidate_mass` report `[propext, Classical.choice, Quot.sound]`; the targeted module output contains no `sorryAx` for these declarations.
- The audit job later failed in the APW4 dependency `BBMSTPrefixMeasureRecursion.lean:386` with `dsimp made no progress` and an application type mismatch involving `y (Fin.last (a + j))`. This does not invalidate the preceding isolated Syracuse module compilation.
- The integrated-paranoid job failed at the same APW4 dependency. The isolated `syracuse-bridge-paranoid` job was still in progress at the latest job poll; its log endpoint returned `BlobNotFound`, so no completion is asserted.

### Collatz PR #48 — exact run fully green

On workflow [42759509255](https://github.com/s4ztz4bnf6-maker/Lubuimi/actions/runs/42759509255), all three jobs completed successfully: `kernel-check-lean-434`, `kernel-check-lean-435-paranoid`, and `compile-drafts`. The Lean 4.35.0 job completed `lake check --paranoid` and the named finite-path/terminal-residue module check. This is a full job-level CI success for that exact run and its source head. It proves only the declarations and scope actually built and audited there; the finite cap-tree path certificate remains a finite-depth necessary condition and does not exclude an infinite branch or prove global Collatz termination.

The existing initial-cylinder, valuation-bound, offset, strict-margin, finite valuation-word cylinder, and dyadic fibre results retain their prior independent mathematical and exact-commit verification status. Later integration outcomes do not retroactively downgrade them.

**Status:** APW4 integrated prefix recursion remains open; Syracuse isolated paranoid completion remains open; Collatz PR #48 exact run is green within its stated finite-depth scope. Mathematical proofs, historical reconstruction, isolated compilation, integrated compilation, paranoid kernel checking, and declaration-scoped axiom output remain separate evidence categories.


## Follow-up proof candidate — PR #114, 10 November 2026

A new narrow candidate is recorded at [PR #114](https://github.com/s4ztz4bnf6-maker/Lubuimi-/pull/114), exact source head `d09d28935c9e026f4b8297b058c3cd4169231451`. It is based directly on the canonical PR #101 source head `31cc94993fdcb481cea919ca762a29c568948a7a` and changes only `BBMSTPrefixMeasureRecursion.lean` (12 additions, 21 deletions).

The candidate moves the case split onto the recursive geometric membership predicate `prefixCoveredValues` before unfolding `updatedWeight` and `PAt`; it then transports the positive/negative membership fact to the concrete `F.covered` field and simplifies the corresponding branch. It changes no definitions, theorem statements, hypotheses, or mathematical claims. PR #113 was closed after identifying that its comparison base was unsuitable and its diff was not narrowly scoped; no source change from that branch is retained in PR #114.

No verification result is claimed yet. The acceptance gate remains exact-head integrated-paranoid success, the separate audit, inspection of named `#print axioms`, and absence of `sorryAx` throughout the dependency closure. Established APW4 mathematical results and the published manuscript status remain untouched.


## PR #114 exact-head workflow launched — 10 November 2026

The membership-first repair candidate [PR #114](https://github.com/s4ztz4bnf6-maker/Lubuimi-/pull/114) is at exact head `d09d28935c9e026f4b8297b058c3cd4169231451`. Its triggered workflow [42762133686](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42762133686) has both `audit` and `integrated-paranoid` in progress. No compilation or axiom-audit outcome is claimed until those jobs complete and their logs are inspected.
