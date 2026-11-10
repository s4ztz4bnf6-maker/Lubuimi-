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


## APW4 status update — 10 November 2026

APW4 research and authorship remain attributed to **Ta-Yoshua Lubuimi**. The mathematical results recorded in Dossier v1.6, Addendum 1.3 §25 and Addendum 1.5 §§41/46 — the strict lower bound, DT, HT, and the global energy conclusion under the historical APW4 hypotheses — remain the established mathematical status of the author's proof record. Later CI failures do not retroactively invalidate earlier successful commit-bound checks.

- Successful declaration-scoped APW4 checks: [42599116967](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42599116967) and [42599116987](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42599116987).
- Successful BBMST module audit: [42522617494](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42522617494).
- PR #69 integrated run [42716161232](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42716161232) reached the integrated build but failed at `BBMSTMomentRecurrence.lean:118` (`MulLeftMono ℚ`); its audit retry compiled the upstream source and several BBMST cores but failed in BBMSTPrefixMeasureRecursion.lean at lines 174, 333 and 356; dependent declarations showed sorryAx. A source cleanup was committed as candidate repair 263b9b53f6888d4a149d341653043b09d745eab6, not yet verified. No integrated paranoid pass is claimed.
- New candidate-fix run [42718994622](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42718994622) is currently running on commit 263b9b53f6888d4a149d341653043b09d745eab6. Both integrated-paranoid and audit completed setup/cache restoration and entered compilation; neither has a final result yet.
- The full status chronology is in [Dossier v1.6, Addendum 1.6](publication/APW4_Wissenschaftliches_Beweisdossier_Lubuimi_2026-11-09_v1.6.md).


### Second CI update — 10 November 2026

Run [42718994622](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42718994622) failed in both jobs: the integrated build reported MulLeftMono ℚ at BBMSTMomentRecurrence.lean:118, prefix recursion errors at lines 171/333/356, and hyperplane cardinality equalities at lines 347/454. The audit job passed its upstream and finite fibre/geometry stages but failed in the prefix recursion. No integrated lake check --paranoid pass is claimed.

Candidate fixes are now on PR #69 at commits f4f6fb5210d080a08fbf72682a29718d95af4a1e and 6c34cd1d4f7487c200a04a4f1cc90010ceb19643. New exact-head run [42720062719](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42720062719) is in progress. The APW4 mathematical proof status and earlier successful commit-bound checks remain unchanged.


### Third CI update — 10 November 2026

Run [42720062719](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42720062719) failed in integrated-paranoid at BBMSTMomentRecurrence.lean:136, BBMSTPrefixMeasureRecursion.lean:176/187/211/338/361, and BBMSTHyperplaneFibreIncidence.lean:347/454. The audit job had passed the upstream, degenerate-witness, zero-safe fibre, weighted-update, uniform-coordinate and finite-stage moment stages and was still compiling geometry.

The product-induction argument order and dependent prefix/stage-coordinate proofs were refined on current PR #69 head 5b645d776ebbf7a71b7370f1b0078c711f9af651. New exact-head run [42720690874](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42720690874) is pending. Earlier successful checks and the mathematical APW4 status remain unchanged.


### Fourth CI update — 10 November 2026

Audit run [42720062719](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42720062719) passed upstream, degenerate-witness, zero-safe fibre, weighted-update, uniform-coordinate, finite-stage moment, finite-coordinate geometry and uniform-stage source-moment stages, then failed only at BBMSTPrefixMeasureRecursion.lean:338/361. The integrated job also failed at the rational product argument order, prefix recursion and hyperplane stage-coordinate identities.

Candidate fixes are on PR #69 head 5b645d776ebbf7a71b7370f1b0078c711f9af651. Exact-head run [42720690874](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42720690874) is in progress. Earlier successful APW4 checks and the mathematical proof status remain unchanged.


### Third CI update — 10 November 2026

Run [42720062719](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42720062719) completed with failure in both jobs on PR #69 head `6c34cd1d4f7487c200a04a4f1cc90010ceb19643` (integrated merge commit `ac80e32831b12aaeb117242d62395bd421aaf713`). The integrated build reports a factor-positivity type mismatch at `BBMSTMomentRecurrence.lean:136:32`, dependent-prefix errors at `BBMSTPrefixMeasureRecursion.lean:176/187/211/338/361`, and finite-coordinate cardinality equalities at `BBMSTHyperplaneFibreIncidence.lean:347/454`. The audit job passed upstream and several finite fibre/geometry stages, then failed in the prefix recursion. The build failure means no successful `lake check --paranoid` result is available for this run. Earlier successful commit-bound checks and the mathematical APW4 proof record remain unchanged. Full diagnosis and repair targets are in Dossier v1.6, Addendum 1.7.


### Fifth CI update — 10 November 2026

New exact-head run [42721579786](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42721579786) is running on PR #69 head 4ecac363ca6a06b5a41c750edac8eba2303b64cf after the latest product, prefix, updated-weight and hyperplane-cardinality proof refinements. Both integrated-paranoid and audit jobs are active; no final result is available yet.


### Cross-project APW4–Syracuse research interface — 10 November 2026

The separate Collatz/Syracuse project now records Lubuimi's finite valuation-word cylinder partition: every exact finite positive valuation word of total exponent A is one odd residue class modulo 2^(A+1), with relative odd-start mass 2^-A. Finite cutoff B gives exact children of weights 2^-1,...,2^-B plus one tail cylinder of weight 2^-B, preserving total mass. This is a concrete candidate source-mass structure for APW4-inspired work, not yet a transport theorem. The required index-preserving map to historical APW4 event/BIB objects, original-weight preservation, and Hall/capacity proof remain open. No APW4 result or status is changed. Details are in Dossier v1.6, Addendum 1.8.


### Sixth CI update — 10 November 2026

Run [42721579786](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42721579786) passed upstream, degenerate-witness, zero-safe fibre, weighted-update, uniform-coordinate, finite-stage moment, finite-coordinate geometry and uniform-stage source-moment stages, then failed at prefix recursion lines 171/184/209/337/360. The integrated job also failed at the prefix recursion and hyperplane moment denominators; the rational product error has been cleared.

Candidate head 95669afac00d8913c1fc2a91b6bb3b5740ce6d92 contains the next proof refinements. Exact-head CI is pending; no integrated paranoid pass is claimed.


### Seventh CI update — 10 November 2026

New exact-head run [42722133436](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42722133436) is running on PR #69 head 95669afac00d8913c1fc2a91b6bb3b5740ce6d92. Integrated-paranoid has completed setup/cache restoration and entered compilation. Audit has fetched the upstream source and is restoring Mathlib cache; compilation has not yet produced a final result.


### Latest APW4 integration status — 10 November 2026

Run [42721579786](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42721579786) failed in both jobs on PR #69 head `4ecac363ca6a06b5a41c750edac8eba2303b64cf`. The rational finite-product error is no longer present. The remaining errors are in `BBMSTPrefixMeasureRecursion.lean:171/184/209/337/360` and `BBMSTHyperplaneFibreIncidence.lean:347/450`; dependent error-recovery declarations showed `sorryAx`. No successful integrated build or paranoid pass is claimed. New candidate head `95669afac00d8913c1fc2a91b6bb3b5740ce6d92` is being checked in run [42722133436](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42722133436), which was in progress at the latest retrieval. Earlier positive checks and APW4 mathematical results remain unchanged. See Dossier v1.6, Addendum 1.9.


### New APW4 bridge candidate — terminal-residue collision energy

The Collatz/Syracuse project now defines a finite-place incidence map from each length-k valuation word to a terminal unit residue modulo 3^k. Its weighted second moment has an exact diagonal/off-diagonal split, with diagonal 3^-k and off-diagonal collision mass at least 1/(2·3^k). This is a concrete APW4-style structure, but its collision term is not identified with the historical BIB reserve. An index-preserving map to original APW4 event/place objects and a capacity/Hall proof remain necessary. See Dossier v1.6, Addendum 1.10.


### Finite Markov matrix — next APW4 bridge layer

The Syracuse terminal-residue collision energy is now represented by an explicit finite rational Markov matrix `P_k`: the terminal mass vector is `δ₀ P_k^k`, and the collision energy is its squared ℓ² norm. At k=2 the exact distribution is `(8,16,11,4,2,22)/63`, with energy `5/21`, diagonal `1/9`, and off-diagonal collision mass `8/63`. This gives a concrete finite-moment interface for APW4-style techniques. The matrix remains a Syracuse-specific construction; historical BIB identification and capacity/Hall transfer remain open. See Dossier v1.6, Addendum 1.11.


### PR #69 latest run — 42722133436

Run [42722133436](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42722133436) failed on head `95669afac00d8913c1fc2a91b6bb3b5740ce6d92`. Audit passed upstream and several zero-safe fibre, weighted update, uniform-coordinate, moment and geometry modules before failing in prefix recursion; integrated-paranoid also failed in hyperplane fibre cardinalities. The current concrete issues are dependent Fin-index/cast transport, filtered-set membership rewriting, `PAt_nonneg` induction transport, redundant tactic, and mismatched local Fintype denominator normalization. Error recovery includes `sorryAx`; no paranoid pass. Earlier positive checks and APW4 mathematical results remain preserved. See Dossier v1.6, Addendum 1.12.


## Current integration and bridge status — 10 November 2026

- [Append-only APW4 CI status snapshot](publication/APW4_CI_STATUS_SNAPSHOT_2026-11-10.md): records exact PR #69 failure 42722133436 and the separate documentation-branch audit 42723539932, including the fact that later documentation commits advanced PR #79 beyond the commit checked by that run.
- [APW4–Syracuse Cylinder–Energy Bridge research programme](publication/LUBUIMI_APW4_SYRACUSE_CYLINDER_ENERGY_BRIDGE_RESEARCH_PROGRAMME_2026-11-10.md): separates the established APW4 and Syracuse results from the unproved transport bridge.

The current PR #69 integrated source head has not passed the full Lean 4.35.0 integrated-paranoid build. This is a formalization status, not a change to the mathematical APW4 proof record. The diagonal mass, off-diagonal mass and BIB pair reserve remain distinct until the historical index-preserving map and capacity inequalities are proved in the relevant formalization.


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


## Addendum 1.12 — latest exact-head workflows queued, 10 November 2026

- PR #69 source head `4d5186564006439b48fe95b060a1cfd1c279238a` has exact-head workflow [42726991713](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42726991713). At the latest status check both `audit` and `integrated-paranoid` jobs were still queued. No compile or kernel-verification result is claimed for this candidate.
- Documentation PR #79 head `f1a48b7353961177e1b6e3f34b074ac78155e424` has workflow [42727094672](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42727094672), also queued at the latest check. Earlier successful docs workflow 42725654168 remains tied only to its older head, not this current head.

This status supersedes any implication that the latest candidate has already completed. APW4 mathematical statements and manuscript results remain untouched; these are pending CI checks of source/documentation snapshots only.


## Addendum 1.13 — documentation head advanced after queued audit

The documentation branch advanced after workflow 42727094672 was queued. That workflow was triggered for the then-current documentation head `f1a48b7353961177e1b6e3f34b074ac78155e424`; the latest PR #79 head is now `579bf0b23aef2909d860abd1e0ff4c970fc433ab` after Addendum 1.12 and the PR-body chronology correction. A commit-specific workflow lookup for `579bf0b23aef2909d860abd1e0ff4c970fc433ab` returned no run at the latest check. Therefore 42727094672 is not evidence for the latest documentation head; a new exact-head run is still required.

PR #69 workflow 42726991713 has progressed since the prior check: `integrated-paranoid` is now in progress and `audit` remains queued. No outcome is claimed until both finish on exact head `4d5186564006439b48fe95b060a1cfd1c279238a`.


## Addendum 1.14 — exact integration failure and next source candidate, 10 November 2026

The latest integrated Lean 4.35.0 candidate at source commit `2843f40fd5c04fc68014ee8fe59a87d26520b285` was checked by workflows [42738930763](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42738930763) and [42738923964](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42738923964). Both completed with failure in `BBMSTPrefixMeasureRecursion.lean`. The decisive errors are confined to the source-indexed update identity:

- an extra tactic remains after a preceding tactic has already closed its goal;
- rewriting the covered-membership proposition across a dependent `Finset (C.S (stageCoordinate ...))` index produces an ill-typed motive;
- the resulting declaration `prefixFibre_updatedWeight_eq_PAt` and dependent mass theorems report `sorryAx` in error recovery and therefore are not accepted as verified.

This is a formalization failure on that exact candidate, not a mathematical counterexample and not a reason to weaken the theorem. The next isolated candidate is branch `fix/prefix-fibre-update-case-split-2026-11-10`, source commit `086ad916f48270d984ebd3e4bcf86fc58cf60f2b`, which splits on the source-indexed covered predicate before simplifying the recursive branch. Its exact-head workflows [42739175075](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42739175075) were still running at this update. No pass is claimed until both the audit and integrated-paranoid jobs finish and the full axiom/log checks are clean.

The APW4 mathematical proof record remains unchanged: DT, HT, the global upper energy estimate and the strict lower-bound implication remain established mathematical results in the author's manuscript. The unresolved historical instantiation in Lean remains distinct from this integration issue. The Syracuse-derived finite fibre is still only a candidate model for cross-project testing; it is not substituted for APW4's historical event/place definitions.


## Addendum 1.15 — canonical dependent-witness normalization candidate, 10 November 2026

The integrated source branch has advanced to commit `17eb308d106c770ab559d254bcee2bdfd2ead6c4`. In `prefixFibre_updatedWeight_eq_PAt`, this candidate removes the failed `rw` over a dependent membership proposition. It introduces named proofs for the stage and previous-prefix bounds, identifies those proof witnesses by subsingleton equality, eliminates the witness equalities, and then splits on the concrete covered predicate before simplifying the two rational update branches.

Exact-head workflows [42739447621](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42739447621) and [42739454140](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42739454140) were still in progress at this update. No compile, axiom, or integrated-paranoid result is claimed yet. The next decisive check is whether the source-indexed update identity closes without `sorryAx`, followed by the dependent nonnegativity and total-mass recursion.


## Historical completeness audit — 10 November 2026

The additive [APW4 historical completeness and formalization audit](publication/APW4_HISTORICAL_COMPLETENESS_AUDIT_2026-11-10.md) answers the source-fidelity question directly. The mathematical APW4 proof record remains established as documented by the author. However, the repository's source reconstruction does not yet independently construct every historical APW4 index map, weighted BIB/Hall allocation, and strict lower-bound premise inside one axiom-clean Lean theorem. This is a formal/source-integration boundary, not a downgrade of the manuscript's mathematical result. Existing proprietary notices are unchanged.


## Addendum 1.16 — exact-head status refresh, 10 November 2026

The latest observed PR #69 source head remains `17eb308d106c770ab559d254bcee2bdfd2ead6c4`. Exact-head workflows [42739447621](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42739447621) and [42739454140](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42739454140) were still `in_progress` at the refresh; the integrated-paranoid job was compiling the integrated Lean 4.35.0 BBMST/APW4 modules and full Theorem 1.2 reduction. No result is claimed until both relevant jobs finish and their complete logs, declaration-level axiom reports, and sorryAx scans are inspected.

The latest observed documentation PR #79 head is `be6dfbcdc55b2603cc6901caaa32f8e4ed24a505`. Exact-head workflows [42739759284](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42739759284) and [42739763639](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42739763639) were also still `in_progress`. These are documentation/integration-candidate checks, not a substitute for the APW4 mathematical proof or a completed kernel audit.


## Addendum 1.17 — Lean 4.35 failure diagnosis and next source patch, 10 November 2026

The exact-head workflows [42739454140](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42739454140) and [42739447621](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42739447621) have now completed with failure on source head `17eb308d106c770ab559d254bcee2bdfd2ead6c4`. The legacy audit job reached the prefix recursion and emitted `No goals to be solved` after the branch simplifications; the Lean 4.35 integrated-paranoid job instead reported two unsolved goals at lines 390 and 392 in `BBMSTPrefixMeasureRecursion.lean`. Its displayed goals show that the source predicate uses `Fin.last k`, while the recursively unfolded expression uses `Fin.last (a + j)`; the local abbreviation `k := a + j` had not been included in the simplifier set. Error recovery propagated `sorryAx` into `prefixFibre_updatedWeight_eq_PAt`, `PAt_nonneg`, and `PAt_sum_eq_one`. These declarations are not verified on this candidate.

A narrow follow-up source patch was committed to the same PR #69 branch as `1725efe46fb2b953ae162eb46ef6ccab454d6e33`: the two case branches now simplify with `k` explicitly unfolded and remove the unnecessary trailing `ring_nf`. Exact-head workflow [42740073283](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42740073283) was queued at the time of this record; no outcome is claimed. The patch is a testable Lean tactic correction, not a verified mathematical result.


## Addendum 1.18 — Current prefix-recursion repair and historical completeness boundary, 10 November 2026

The follow-up repair is tracked separately in [PR #82](https://github.com/s4ztz4bnf6-maker/Lubuimi-/pull/82), branch `fix/prefix-fibre-scalar-transport-2026-11-10`, head `6c8899eec26f493c3a440c88114bed8e6a17fd53`. It removes an unnecessary dependent rewrite and transports the scalar nonnegativity statement along the exact update equality. The exact-head Actions run [42740116278](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42740116278) was still running at this record update. Therefore the patch is a repair candidate only: no Lean 4.35.0 compile or paranoid-audit success is claimed for PR #82, and no merge is implied.

The historical completeness audit remains separate from this integration repair. The source reconstruction establishes the square-free CRT/hyperplane correspondence and a finite unweighted incidence allocation result. It explicitly does not yet identify that unweighted count with the historical weighted BIB reserve, construct the APW4 historical event-to-slot map, or prove the APW4-specific weighted Hall transport. The external-review correction record also notes that the full historical DT/HT instantiation and the complete arithmetic lower-bound exposition are not reproduced in the accessible source record. The author's previously recorded mathematical proof status is preserved; the repository's independently inspectable source-level completeness is not overstated.

Accordingly, APW4 is **not yet repository-complete as a self-contained historical proof package**, even though the recorded mathematical results and separately verified declarations remain preserved. Remaining release obligations include a source-faithful historical definition concordance, explicit DT event-to-slot map and capacity proof, explicit HT weighted incidence/Hall proof, the complete lower-bound derivation from the primary APW4 manuscript, and one integrated release theorem whose hypotheses are constructed rather than supplied as unverified inputs.

No license file or license terms were changed by this addendum. Existing repository license notices remain authoritative.


## Addendum 1.18 — exact-head APW4 incidence and dependent-prefix repair queue, 10 November 2026

The APW4 finite-incidence module has a corrected source head after an import-order-only failure. Commit `e71b7a5eaa433b689aaa2963d89bdd4ae55c37f4` moves `import Mathlib` to the beginning of `APW4IncidenceSecondMoment.lean`. Exact-head workflows [42740305961](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42740305961) (Lean 4.28 canonical plus Lean 4.35 paranoid) and [42740306351](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42740306351) (APW4 paranoid) were running at this update. The earlier head `e8b61d2961dadbae2915dd6754807fc1b13daf6d` failed before theorem checking because the verification comment preceded the import; that source-layout failure is not mathematical evidence. The three declarations `incidence_bound_from_second_moment`, `offDiagonal_exceeds_reserve`, and `apw4_energy_contradiction` remain conditional on their displayed theorem arguments. They do not establish the historical H1/H2, weighted Hall allocation, or the strict APW4 lower-bound premise.

The integrated PR #69 is now at `2c2ec3472ae2de9bfc7dc90198f48c52f21f04dd`. Exact-head runs [42740134936](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42740134936) and [42740144142](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42740144142) were still running. The prior dependent rewrite failure is isolated to `rw [← hlocal]`: Lean cannot form a rewrite motive containing `prefixCoveredValues` at a different dependent `stageCoordinate` type.

A narrowly scoped alternative is proposed in draft [PR #83](https://github.com/s4ztz4bnf6-maker/Lubuimi-/pull/83), exact source commit `2656fe9fadac25b5c79a1f217ad40fb8472738d0`. It proves nonnegativity of the scalar update first and transports `0 ≤ updatedWeight` across the exact scalar equality by equality elimination, avoiding rewriting inside the dependent fibre expression. Exact-head workflows [42740315350](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42740315350) and [42740323488](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42740323488) are queued/running. This remains a proof candidate until both compile and integrated paranoid/audit checks pass with the required declaration-level axiom profile and no `sorryAx`.

Draft PR #82 was closed as superseded; its branch is retained, and no code from it was merged. No historical APW4 definitions, theorem statements, or prior successful results were replaced by these candidates.


### Addendum 1.19 — historical source audit and support-layer formalization

The historical completeness audit now includes a page-indexed review of the author's project PDF, a provenance warning for the proposed q-matrix notation, and the distinction between a single APW4 off-diagonal atom and a collision of two such atoms. The exact CRT support-layer relation is being formalized on APW4 PR #67; canonical CI has passed, while the Lean 4.35 paranoid run remains pending. See `publication/APW4_HISTORICAL_COMPLETENESS_AUDIT_2026-11-10.md` and the CI snapshot for exact heads and run IDs. No historical matrix or BIB incidence definition has been invented or merged.



## Addendum 1.20 — exact-head repair and historical source boundary

The latest integrated PR #69 exact-head run [42740835775](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42740835775) failed at a no-op `dsimp` in `BBMSTPrefixMeasureRecursion.lean:386`; error recovery emitted `sorryAx` for the affected declarations. Draft PR #84 at `f681650c102d011e0bc715c93b5d4a94ffb866ca` removes that no-op and uses pointwise scalar equality transport. Its exact-head workflow [42743406155](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42743406155) is still in progress. It is not merged or accepted.

The historical BIB source obligation remains unchanged and is still the critical mathematical reconstruction task: the recovered source records the identities involving `A_q W_{q,r} A_r^T), `a_{q,t}`, `M_{q,r}`, and `Gamma_{q,r}`, but does not yet provide all element-level index domains, summand definitions, event weights, the exact map `Phi`, or the APW-event-to-BIB-place incidence/capacity relation. No candidate q-matrix notation is promoted to historical definition without primary-source evidence. The finite support-layer identity on PR #67 is only an underlying CRT counting lemma, not the weighted Hall/BIB bridge.


### Addendum 1.20 — recovered q-fibre definitions

Dossier v1.6 §48 and the 6 November BIB incidence note §5 provide the recovered q-fibre interface (B_q,V_q,P_{q,x,h},M_{q,r},Gamma_{q,r}). The historical audit has been corrected accordingly. The next formal step is the local aggregate bound (sum_h MleGamma), with fibre containment and block disjointness derived from the original (U_q,F_q(x),C_h) definitions. This remains distinct from the global weighted Hall/BIB transport.


## 10 November 2026 — historical event-to-BIB reconstruction ledger

See publication/APW4_HISTORICAL_EVENT_BIB_RECONSTRUCTION_LEDGER_2026-11-10.md for the append-only definition-completeness matrix and the exact event-to-BIB proof obligations. The ledger preserves the identities A_q W_{q,r} A_r^T = sum_{t mod D_{q,r}} a_{q,t} a_{r,t}^T and sum_h M_{q,r}(h,g) <= Gamma_{q,r}(g), while requiring all source index spaces, entries, suppressed indices, elementary events, the original map (x,u) -> (k,I_{x,u},J_{x,u}), BIB slots/capacities, pointwise incidence, weight preservation and weighted Hall inequality to be explicit before formal transfer. It does not replace historical definitions by canonical model fibres.

The latest exact PR #69 workflow 42739454140 failed on source head 17eb308d106c770ab559d254bcee2bdfd2ead6c4. The two branches of prefixFibre_updatedWeight_eq_PAt expose a cross-toolchain tactic sequencing issue: simp closes the branch under Lean 4.28, making a following ring invalid; Lean 4.35 leaves algebraic residue that ring does not close and recommends ring_nf. Error-recovered sorryAx in PAt_nonneg/PAt_sum_eq_one is downstream. No integrated pass is claimed on this head. The proposed simp ... <;> ring_nf sequencing is a next experiment, not yet a verified repair.

This technical failure does not alter the separately recorded APW4 mathematical status under its historical hypotheses or earlier successful declaration-scoped audits. The event-to-BIB transport and source reconstruction remain explicit open obligations.


### Addendum 1.21 — local q-fibre M/Gamma Lean checkpoint

APW4 PR #85 formalizes the recovered finite-set definitions (P_q,P_r,M_{q,r},Gamma_{q,r}) from Dossier v1.6 §48 and proves the local aggregate count under explicit fibre-containment and pairwise-disjoint-block hypotheses. On exact head `d4c61399918c03715197cbe2de6356fd170463d3`, canonical workflow 42744980622 passed; `APW4HistoricalQFibre.sum_M_qr_le_Gamma_qr` printed [propext, Classical.choice, Quot.sound], and the complete canonical log had no `sorryAx`. Its separate audit run 42744980640 also passed. The Lean 4.35 paranoid job in 42744980622 was still in progress at the latest check, so no paranoid pass is claimed. The remaining task is to derive the structural hypotheses from the original (U_q,F_q(x),C_h) definitions and connect the local count to the actual weighted HT/BIB transport.

### Addendum 1.22 — exact dependent-prefix repair status

PR #69 head `b8d98215ed2d8d401c1e27805a193666e093f067` failed exact-head workflow 42740835775 in both audit and integrated-paranoid jobs. The first prefix-recursion error is a no-op `dsimp [k] at *` at line 386; the elaborator then exposes the dependent index mismatch between `stageCoordinate hk` and `prefixIndex hj (Fin.last (a+j))`. Error recovery includes `sorryAx` in the affected prefix-mass declarations. Stacked PR #86 (head `4e4b378887cc76382d9cd2e17807f96a2c277e23`) now introduces an explicit `Fin.ext` coordinate equality and goal-sensitive `simp ... <;> ring_nf`. Exact-head workflow 42745081023 is in progress in both jobs; no pass is claimed. PR #84's workflow 42745022363 was cancelled after branch advancement and is not counted as a proof failure or success.

The APW4 mathematical theorem record, previous exact-commit PASS results, and proprietary/commercial licensing notices remain unchanged.


### Addendum 1.23 — APW4 source audit and finite-fibre interfaces

The complete 17-page APW4 proof PDF was inspected. It records the DT assignment and aggregate fibre-weight bound, the HT demand d(gamma)=omega_l*omega_l', actual BIB places/capacities/incidence notation, and weighted Hall condition, but it does not expand the element-level source definitions of the event universe, BIB places, or incidence map. The historical source-to-BIB map remains open; generic finite-set or preimage definitions are not substituted for it.

PR #89 adds a generic preimage-fibre interface deriving fibre containment and block disjointness from explicit maps. Corrected head 45700b0151a1bdd52b3b1f0374c4e7273e17db9a; audit/canonical runs pending. PR #93 formalizes the Syracuse finite-depth common dyadic fibre as BBMSTFiniteFibreUpdate.FibreData; its corrected Lake-root head is dca4ef8ede78f902e39e2ac6c4186e2403d9d5e4, run 42747404273 queued. Neither is a historical event/BIB identification.

PR #90 is the latest prefix update repair candidate, head b2bd581ea79696c1d47b8b02a47a209e8a87fd10; it explicitly handles the impossible covered-branch implication and the uncovered Finset.univ test. Run 42747202778 is pending. No integrated PASS is claimed.


### Addendum 1.24 — concrete APW4 residue projection

PR #89 exact head 157cdcc00353c9d89e5d596720cee08d098684ae specializes the q-fibre M/Gamma bound to explicit finite residue-label maps on ZMod N. Canonical run 42749178635 and audit run 42749178673 passed; the new theorem reports the standard axiom profile and the canonical log contains no sorryAx. The paranoid job was still pending.

The selected residue sets and historical block-label map remain explicit parameters. The event-to-BIB historical reconstruction is still open; no substitute map is promoted to historical.


### Addendum 1.24 — APW4 residue-label q-fibre PASS

PR #89 exact head 157cdcc00353c9d89e5d596720cee08d098684ae proves the local q-fibre inequality for explicit residue-label fibres z |-> z.val % B into Fin B, selected residue sets Uq,Ur, and a common block-label map c. Canonical run 42749178635 and audit run 42749178673 passed; the canonical log contains no sorryAx and the declarations have standard profiles. The paranoid job is still pending. This is not yet the quotient homomorphism ZMod N -> ZMod B because B | N is not imposed; the historical selected sets and block map remain open.
