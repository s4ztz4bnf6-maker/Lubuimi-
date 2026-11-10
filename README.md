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
