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

## Dated status correction — 11 November 2026

The latest evidence review is recorded in [the dated APW4 status correction](docs/APW4_STATUS_CORRECTION_2026-11-11.md) and proposed for review in [PR #155](https://github.com/s4ztz4bnf6-maker/Lubuimi-/pull/155). This entry supersedes earlier summaries only where they overstate what the accessible proof artifacts independently establish; it does not erase earlier author-reported provenance.

- The exact energy identity and abstract finite DT/HT transport results remain established within their stated hypotheses.
- The historical APW4 instantiation of DT/HT remains a separate source-reconstruction obligation.
- The strict lower-bound implication is **BELEGLÜCKE** in the accessible record: Dossier v1.6 §25 states it, but the accessible manuscript/repository artifacts do not reproduce the derivation and its historical definitions/map.
- Therefore the overall contradiction is **not currently independently established as a conditional theorem** from the accessible artifacts. This is an evidence-status correction, not a claim that the author's asserted proof is false.
- PR #154 remains open and its integrated Lean 4.35.0 build failed (workflow [43086198224](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/43086198224), integrated job 130751120273). The isolated audit PASS does not override the integrated failure. Dependent PAt declarations still carry sorryAx.
- The separate PR #152 witness-difference diagnosis motivates investigation but is not confirmed for PR #154's current head. The next diagnostic is to expose the full pos and neg goals and compare the three dependent indices; no speculative simp/transport patch is endorsed.

**Release gate:** no promotion to a verified integrated theorem without a passing integrated Lean 4.35.0 run, named declaration output, and transitive axiom audit excluding sorryAx and disallowed project axioms.




## BIB-label identity audit and current Lean integration — 13 November 2026

The new [BIB label identity audit](docs/APW4_BIB_LABEL_IDENTITY_AUDIT_2026-11-13.md) compares PR #57's BIB rows \(S_x\) with the one-prime-fibre labels \(S_{x,j}\) from the 31 October theorem. Under a shared fixed-depth interpretation, the two intersection claims are incompatible: the BIB route needs proper LCM, while the one-prime theorem forces full LCM at a common depth. A literal identification is therefore ruled out under those shared hypotheses; any different projection or depth aggregation requires an explicit index-preserving map.

The audit records exact PR #158 head f494dd15d83cab582a9364d3eebca1705c8dcadc and workflow [43143591356](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/43143591356): isolated audit PASS, integrated Lean 4.35.0 FAIL at the pos/neg update goals (lines 423–424), with downstream sorryAx in error recovery.

The strict lower bound remains mathematically completed according to Dossier v1.5 §25; the reproducible historical derivation remains BELEGLÜCKE in the accessible source record. These statuses are distinct.




## 13 November 2026 — PR #159 update-branch candidate

PR [#159](https://github.com/s4ztz4bnf6-maker/Lubuimi-/pull/159), head 336fd7a3f2b274f705c184a9bbfddbf6854c3f8c, aligns the update-branch split with the exact successor-bound and prefix expressions shown in PR #158's failure trace. Workflow [43410655372](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/43410655372) remains in progress (audit job 131835937905; integrated-paranoid job 131835938270). No proof success or axiom result is claimed yet.




## 13 November 2026 — PR #159 exact-head correction and retry

The first PR #159 candidate head 336fd7a3f2b274f705c184a9bbfddbf6854c3f8c failed both audit and integrated-paranoid workflow 43410655372. The error at BBMSTPrefixMeasureRecursion.lean:421 was an elaboration mismatch: prefixCoveredValues takes its prefix index implicitly, so passing a+j positionally supplied a Nat where the proof bound was expected.

The correction now passes the index explicitly as (k := a + j). Current PR #159 head: 0ee3144ddbc1927563e03a752dd472c391d5cc61. Exact workflow [43411234880](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/43411234880):
- audit job 131837877076: **IN PROGRESS**;
- integrated-paranoid job 131837876454: **IN PROGRESS**.

The failed first candidate remains a preserved diagnostic. No theorem success, axiom profile, or sorryAx rejection is claimed for the corrected head until both jobs finish and the complete logs are checked.




### F. Refined reconciliation candidate: punctured depth-one rows

The literal identity \(S_x=S_{x,1}\) is incompatible with the proper-LCM premise, but the one-prime spine gives a more precise possible extraction that has not yet been tested historically.

Let \(T_x:=S_{x,1}\). The spine formula gives
\[
|T_x|=\begin{cases}
q,&k_x=1,\\
q-1,&k_x>1.
\end{cases}
\]
Define a candidate BIB row \(S_x\subseteq T_x\) of size \(q-1\) by keeping \(T_x\) unchanged when \(k_x>1\), and deleting one selected label \(d_x\in T_x\) when \(k_x=1\). This is only a candidate extraction rule; the deleted label \(d_x\) is not specified by the historical source.

For distinct \(x,y\), the elementary intersection bound for the full depth-one sets is
\[
|T_x\cap T_y|\geq |T_x|+|T_y|-\tau(B).
\]
The construction deletes at most one label from each row, and deletes one precisely when the corresponding terminal depth is 1. Since \(|T_x|=q-1+\mathbf 1_{k_x=1}\), it follows that
\[
|S_x\cap S_y|\geq 2q-2-\tau(B).
\]
The one-prime hypothesis \(\tau(B)+\mu(B)<2q-1\), with integer parameters, implies
\[
2q-2-\tau(B)\geq\mu(B).
\]
Therefore, if these punctured rows also satisfy the BIB proper-LCM premise \(|S_x\cap S_y|\leq\mu(B)\), then every pair must **saturate exactly**
\[
|S_x\cap S_y|=\mu(B).
\]

This is compatible with the full-LCM theorem for \(T_x,T_y\): the deleted terminal label(s) may be exactly the prime-power witness(es) that make the full intersection have LCM B. It gives a concrete new target: find a canonical source-defined deleted label \(d_x\), then prove that after the deletion every pairwise intersection has cardinality exactly \(\mu(B)\) and proper LCM. No such canonical deletion rule or saturation proof has yet been found.

**Status:** the lower bound \( |S_x\cap S_y|\geq2q-2-\tau(B)\) for this puncturing rule is **BELEGT conditionally** by the spine counts and finite-set cardinality. The identification of these punctured rows with the historical BIB \(S_x\), the choice of \(d_x\), and the proper-LCM saturation are **OFFEN / NICHT REPRODUZIERT**. This refines, but does not close, the historical label-extraction obligation.




## 13 November 2026 — exact PR #159 split result and coordinate-transport follow-up

Corrected PR #159 source head 0ee3144ddbc1927563e03a752dd472c391d5cc61 produced a split exact-head result in workflow [43411234880](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/43411234880):
- audit job 131837877076: **SUCCESS**; it compiled the pointwise update theorem and downstream PAt_nonneg / PAt_sum_eq_one with standard transitive profiles [propext, Classical.choice, Quot.sound], and the completed audit log contains no actual sorryAx for these declarations;
- integrated-paranoid job 131837876454 (Lean 4.35.0): **FAILURE**; it still reports unsolved pos/neg goals at lines 423–424 and downstream sorryAx in error recovery.

The 4.35 goal trace now isolates a dependent-coordinate mismatch: the value y(Fin.last (a+j)) is indexed by prefixIndex, while the covered-value Finset is indexed by stageCoordinate. The source contains the named equality prefixIndex_last_eq_stageCoordinate for exactly this transport. The next candidate, PR #159 head a49ce83ca5db434f8a479a545d09c580e6b24d6e, applies that equality before the update split. Its exact-head CI result has not yet been retrieved; no pass is claimed.

This is a split toolchain verification snapshot, not a mathematical counterexample and not an integrated proof completion. The Lean 4.28 audit PASS is commit-bound and does not substitute for the Lean 4.35.0 integrated-paranoid gate.




## 13 November 2026 — explicit prefixIndex/stageCoordinate transport candidate

The next PR #159 source head is a49ce83ca5db434f8a479a545d09c580e6b24d6e. It adds the named equality prefixIndex_last_eq_stageCoordinate before the pointwise update branch split, to align the last coordinate of the extended prefix with the stageCoordinate used by prefixCoveredValues.

Exact workflow [43411925347](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/43411925347) is **IN PROGRESS**:
- audit job 131840194635: IN PROGRESS;
- integrated-paranoid job 131840194925: IN PROGRESS.

The preceding exact head 0ee3144 has audit PASS with standard profiles for prefixFibre_updatedWeight_eq_PAt, PAt_nonneg, and PAt_sum_eq_one, but integrated Lean 4.35.0 FAIL. No result is claimed for the new coordinate-transport candidate until both jobs complete.
