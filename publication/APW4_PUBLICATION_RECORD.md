# APW4 publication record

**Author:** Ta-Yoshua Lubuimi  
**Working title:** *The APW4 Energy–Incidence Argument and Its Lean 4 Formalization: Mathematical Results, Proof Architecture, and Reproducible Verification*  
**Version:** publication record, 8 November 2026

## 1. Mathematical statement

Let the APW4 energy be
\[
\mathcal E_{\mathrm{APW4}}
=\sum_x w_x\left(\sum_{u\in W_x}\rho_x(u)\right)^2.
\]
Its exact expansion is
\[
\mathcal E_{\mathrm{APW4}}=D_{\mathrm{APW4}}+C_{\mathrm{APW4}},
\]
where
\[
D_{\mathrm{APW4}}=\sum_xw_x\sum_{u\in W_x}\rho_x(u)^2
\]
and
\[
C_{\mathrm{APW4}}=\sum_xw_x
\sum_{\substack{u,v\in W_x\\u\ne v}}
\rho_x(u)\rho_x(v).
\]
The off-diagonal sum is over ordered pairs; no extra factor of two is inserted.

## 2. Established diagonal transport (DT)

The mathematical proof record establishes the diagonal transport theorem
\[
\boxed{D_{\mathrm{APW4}}\le D_k^{\mathrm{BBMST}}.}
\]
The historical indexing correspondence is
\[
(x,u)\longmapsto(k,I_{x,u},J_{x,u}).
\]
The target expression recorded in the proof record is
\[
D_k^{\mathrm{BBMST}}
=\frac{1}{|S_k|^2}
\sum_{F\in\mathcal N_k}
c(F\cap[a])
\prod_{j\in F\cap[a+1,k-1]}
\frac{1}{(1-\delta_j)|S_j|}.
\]
All symbols retain their historical meanings from the underlying BBMST/APW4 construction. This record does not redefine them. The complete DT proof exposition belongs to the author's established proof record; the theorem is not presented here as an open task.

## 3. Established off-diagonal transport (HT)

For an off-diagonal event \(\gamma=(\ell,\ell')\), the recorded demand is
\[
d(\gamma)=\omega_\ell\omega_{\ell'}.
\]
The weighted Hall condition established in the mathematical work is
\[
\sum_{\gamma\in X}d(\gamma)
\le
\sum_{b\in\Gamma_{\mathrm{BIB}}(X)}c_{\mathrm{BIB}}(b)
\]
for every subset \(X\) of off-diagonal events. Here \(b\) denotes an actual BIB slot, \(\gamma\sim b\) is the historical incidence relation, and \(c_{\mathrm{BIB}}(b)\) is its capacity.

Finite weighted max-flow/min-cut gives a nonnegative transport \(\theta_{\gamma b}\) satisfying
\[
\sum_{b:\gamma\sim b}\theta_{\gamma b}=d(\gamma),
\qquad
\sum_{\gamma:\gamma\sim b}\theta_{\gamma b}
\le c_{\mathrm{BIB}}(b).
\]
Summation yields
\[
\boxed{C_{\mathrm{APW4}}\le\mathcal R_{\mathrm{BIB}}.}
\]
The recorded BIB reserve identity is
\[
\mathcal R_{\mathrm{BIB}}
=\sum_\ell c_\ell(c_\ell-1)
=\sum_{u\ne v}|S_u\cap S_v|.
\]
The complete HT proof exposition belongs to the author's established proof record; the theorem is not presented here as an open task.

## 4. Upper energy estimate

Combining the exact decomposition with DT and HT gives
\[
\boxed{
\mathcal E_{\mathrm{APW4}}
\le D_k^{\mathrm{BBMST}}+\mathcal R_{\mathrm{BIB}}.
}
\]

## 5. Established strict lower bound and contradiction

The APW4 dossier explicitly records the strict lower-bound result as an established mathematical proof component:
\[
B(M)=2M-\sigma(M)\le0
\quad\Longrightarrow\quad
\mathcal E_{\mathrm{APW4}}>
D_k^{\mathrm{BBMST}}+\mathcal R_{\mathrm{BIB}}.
\]
This statement is retained with its original historical APW4 hypotheses and definitions. Its complete proof exposition is part of the author's established proof record; it is not reconstructed here from the upper estimate and is not an open conjecture.

The contradiction is immediate: in the stated parameter regime the same energy is both at most and strictly greater than
\(D_k^{\mathrm{BBMST}}+\mathcal R_{\mathrm{BIB}}\). Hence that regime is impossible under the hypotheses of the established APW4 results.

## 6. Formal verification record

The APW4 canonical formalization branch is
audit/apw4-diagonal-majorization-2026-11-04, at commit
64f38063ef179b3ea9aa0891b5fc04a4b0d7eb97.

Successful Actions runs on that exact commit:
- Run 41895530029: canonical APW4 majorization.
- Run 41895530064: combined Lean audit.

The logs report the standard profile
\[
[\texttt{propext},\texttt{Classical.choice},\texttt{Quot.sound}]
\]
for the following declarations:
- APW4CanonicalMajorization.local_profile_mass_identity
- APW4CanonicalMajorization.local_profile_mass_le_one
- APW4CanonicalMajorization.global_bib_majorization
- APW4CanonicalMajorization.bib_collision_identity
- APW4HistoricalCRT.mem_congruenceSet_iff
- APW4HistoricalCRT.mem_supportAt_iff
- APW4HistoricalCRT.historical_bib_collision_identity

These are exact declaration-level CI/kernel records. The mathematical DT, HT, and strict lower-bound results are established in the author's APW4 proof record. The above list is not an assertion that every historical APW4 object or every theorem in the mathematical proof record is represented by those particular Lean declarations. This is a boundary on what these specific CI logs certify, not a qualification or reopening of the mathematical proofs.

A separate BBMST full ordered module audit was successful on commit
436a2e387bb774ee2d31d5dc8908ec3cfdb06150:
- Step 16 focused run 42522617423, job 128859206391.
- Foundation regression 42522617399, job 128859206286.
- Full ordered audit 42522617494, job 128859206766.

This record concerns the documented dependency-ordered module chain on its own commit. It is not a single integrated run of all 22 numbered project steps; the historical isolated checks for later numbered steps are separate records. It must remain separate from the APW4 canonical verification record.

## 7. Source and attribution

The original BBMST result is:
P. Balister, B. Bollobás, R. Morris, J. Sahasrabudhe, and M. Tiba,
“The Erdős–Selfridge problem with square-free moduli,”
*Algebra & Number Theory* 15 (2021), 609–626.
DOI: https://doi.org/10.2140/ant.2021.15.609.

The APW4 research record and the APW4 formalization work documented here are attributed to **Ta-Yoshua Lubuimi**. This attribution does not transfer authorship of the original BBMST theorem.

## 8. Publication and manuscript custody

**Publication update, 8 November 2026:** The author has informed this record that the complete manuscript PDF has been independently finalized, published, and secured by the author. The PDF is not mirrored in this repository. A public PDF URL, DOI, or external repository identifier has not been supplied to this record, so none is asserted here. The manuscript's final form, publication, and custody remain the author's work and responsibility.

The historical definitions and complete DT, HT, and strict lower-bound proof expositions are retained in the author's authoritative proof record. This index summarizes the results and identifies verification artifacts; it is not a substitute for those full proof texts.


## 9. Consolidated German main manuscript — 8 November 2026

The author supplied the consolidated main manuscript *APW4: Diagonaltransport, gewichteter Off-Diagonaltransport und strikter Energieschluss*, dated 8 November 2026. It records the exact energy decomposition, the historical DT map, the established weighted Hall transport, the global upper bound, the strict arithmetic lower-bound implication, the contradiction, the matrix/fiber identities, and the declaration-scoped Lean/CI record.

The mathematical status is explicit and unchanged: DT is proved; HT is proved; the global upper energy estimate is proved; the strict lower-bound implication is proved under the historical APW4 hypotheses; and the contradiction follows. The Lean/CI section describes only the named declarations, commit, and runs actually listed. A distinction between mathematical proof status and the scope of a particular Lean audit is not a downgrade of the mathematical results.

This entry records the supplied manuscript as the current editorial baseline. It does not silently replace historical definitions, alter the source indexing, or claim that the listed seven Lean declarations alone encode every mathematical proof exposition.


## 10. Publication roadmap and external formalization standards — 9 November 2026

The current publication sequence and optional Palomar formalization route are recorded in [APW4_PUBLICATION_ROADMAP_AND_TAO_ALIGNMENT_2026-11-09.md](APW4_PUBLICATION_ROADMAP_AND_TAO_ALIGNMENT_2026-11-09.md).

The roadmap distinguishes mathematical proof status from the scope of the seven named Lean declarations and their cited CI runs. It also records that Terence Tao's discussion of Palomar and formal verification is a useful methodological reference, not a personal endorsement or a universal certification standard. No claim of Tao approval or worldwide priority is made. Any priority claim requires a precise novelty statement, literature comparison, and independent expert assessment.

The manuscript's mathematical results remain as stated in Sections 2–5 above. This editorial addition does not reopen, downgrade, or redefine DT, HT, the global upper estimate, the strict lower-bound implication, or the resulting contradiction.


## 11. Erdős–Selfridge-related priority claim and public-release status — 9 November 2026

The author expressly clarifies that APW4 is **not** a claim to have solved the original Erdős–Selfridge problem itself. The claimed breakthrough is methodological: the author asserts that APW4 is, to the author's knowledge, the first Erdős–Selfridge-related mathematical proof developed with this kind of computationally supported, Lean-kernel-checked verification architecture, pursued in the spirit of the high-rigor formal-verification standards discussed by Terence Tao.

This is the author's stated worldwide-priority claim. It is not represented here as an independently established historical fact; that requires a precise novelty statement, systematic comparison with prior formalized Erdős-related results, and independent expert assessment. This qualification does not reopen, downgrade, or redefine the mathematical APW4 results in Sections 2–5.

The current Lean record remains exactly declaration-scoped: the seven declarations, commit, and CI runs in Section 6. The manuscript's mathematical proof status is distinct from the reach of those specific kernel/CI artifacts. No Tao endorsement, review, approval, or certification is claimed.

As of 9 November 2026:
- no DOI has been assigned;
- no arXiv identifier exists;
- the author has contacted a scientific journal, but no acceptance or publication decision is asserted;
- the publication record, roadmap, and priority statement are publicly available on the branch \`docs/apw4-publication-package-2026-11-08\`;
- the two supplied manuscript PDFs have been checksum-identified, but their binary files are not yet mirrored in this repository or deposited on Zenodo.

See [APW4 public release and priority statement](APW4_PUBLIC_RELEASE_AND_PRIORITY_STATEMENT_2026-11-09.md) for the exact claim, file checksums, and evidence boundaries.


## 12. Balister source reconstruction and 9 November kernel update

The source-faithful public BBMST reconstruction is recorded separately in [APW4_BALISTER_SOURCE_RECONSTRUCTION_2026-11-09.md](APW4_BALISTER_SOURCE_RECONSTRUCTION_2026-11-09.md). The primary sources are Balister–Bollobás–Morris–Sahasrabudhe–Tiba, *The Erdős–Selfridge problem with square-free moduli* (2021), DOI 10.2140/ant.2021.15.609, and their 2018 density paper, arXiv:1811.03547. A secondary proof archive at plasma-ai/erdos, immutable commit 17c86a0d4ebe1487a087ceb8c14952a10ec2f2bd, provides explicit reconstructions of the published stage/fibre measure chain and exact finite certificates.

The 2021 BBMST chain is now mapped through Lemma 2.1, Theorem 3.1, Lemmas 3.3 and 3.4, Theorem 3.2, Lemmas 5.3 and 5.4, Corollary 5.2, and the imported large-prime termination criterion in Theorem 5.1. This is source reconstruction of the square-free-moduli BBMST theorem. It is not, by itself, the APW4-specific proof of DT, HT, or the strict energy lower bound.

### 12.1 New APW4 declaration-level kernel run

PR #67, corrected commit 33a66a8491f65616f9572a6efc8fbc91a65d6ed5:
- [APW4 canonical kernel run 42599116967](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42599116967)
- [Upstream and degenerate-witness audit 42599116987](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42599116987)

The canonical run compiled APW4CanonicalMajorization.lean, APW4HistoricalCRTCore.lean, and APW4IncidenceSecondMoment.lean. The new declarations incidence_bound_from_second_moment, offDiagonal_exceeds_reserve, and apw4_energy_contradiction each report exactly [propext, Classical.choice, Quot.sound], with no sorryAx in their reported dependency lists.

The final contradiction declaration is conditional: it receives the energy decomposition, diagonal transport, Hall transport, and strict lower bound as hypotheses. The finite incidence bound likewise receives the stated moment inequalities and numerical conditions. Neither declaration proves that the historical APW4 constructions satisfy those premises. The companion audit still reports sf_sieve_lt_one and sieve_criterion as project axioms in the separate erdos_selfridge chain.

### 12.2 Additional BBMST kernel checkpoints

- PR #56, commit a77f67540719a29e3e45a684e310dc4d753a2a50, passed [geometry run 42364359726](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42364359726). The run covers the named codimension-one restriction, family-selection, augmentation, and prime-coordinate declarations.
- Prefix-mass Step 16 on commit ca9d245aa1851a54b65850ddb1130d1ca12e850e passed [foundation run 42522812092](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42522812092), [Step 16 run 42522812150](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42522812150), and [focused diagnostic 42522812223](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42522812223).
- The rank-nine CRT/fibre audit on commit 098699f663a144fae5da013a425d0d32147ae1ae passed its indicator and dependency-ordered audit job in [run 42595925001](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42595925001). Its separate fiber-paranoid job had not yet completed at the time of this update.

These are genuine positive checks for their named source files and declarations. They are separate branches, commits, and workflows, not a single integrated build of all project sources. No full historical APW4 main-theorem kernel verification is asserted.

### 12.3 Mathematical status and formal release criterion

The mathematical status from Dossier v1.5, Addendum 1.3, Section 25 remains unchanged: the strict APW4 lower-bound implication is retained as an established mathematical result. This documentation update does not reopen or downgrade it.

A complete APW4 kernel release still requires one named theorem whose dependency closure constructs the historical APW4 DT map, the historical BIB event/slot incidence and weighted Hall transport, and the strict lower-bound proof from the historical APW4 data. The named theorem must then be compiled and audited with #print axioms on one immutable release commit, with no project axioms and no sorryAx in its transitive dependency closure. The existing abstract final-step theorem does not satisfy that integration requirement.

The separate universal erdos_selfridge theorem remains a distinct formalization obligation because its current dependency profile still contains sf_sieve_lt_one and sieve_criterion. These project axioms are not silently reclassified as APW4 dependencies.

### 12.4 Manuscript artifact handling

The accessible Library copy named “Erdös Lean 4 Beweis.pdf” was visually inspected on 9 November. Page 11 renders literal LaTeX commands (including the displayed equation environment and command names) instead of typeset mathematics. This finding applies only to that accessible copy, not to any separate publication file independently held by the author. The inspected copy is not reissued or described as the final typeset manuscript. No manuscript binary is changed by this record.


## 13. Current consolidated dossier

The consolidated dossier is now version 1.6, dated 9 November 2026: [APW4_Wissenschaftliches_Beweisdossier_Lubuimi_2026-11-09_v1.6.md](APW4_Wissenschaftliches_Beweisdossier_Lubuimi_2026-11-09_v1.6.md). It preserves the mathematical status of the strict lower bound from v1.5, Addendum 1.3, Section 25, and appends the public Balister source reconstruction, the new PR #67 kernel results, the BBMST geometry and prefix-mass checkpoints, and the exact remaining integrated-kernel release criteria.


## 14. Public repository release — 9 November 2026

The consolidated public documentation package was merged into `main` through [PR #70](https://github.com/s4ztz4bnf6-maker/Lubuimi-/pull/70), merge commit `73dc02f4ec9899ad08f12239d0cfdbbf2cec6523`. It includes Dossier v1.6, the Balister source reconstruction, publication metadata, manuscript verification memorandum, roadmap, and author priority statement. The package is indexed from the repository README.

The earlier documentation PR #68 was closed as superseded. This does not delete its branch history or change the mathematical record.

## 15. Integrated 34-module audit — current run

PR #69 integrates 34 BBMST/APW4 modules in an isolated Lean 4.35.0 package. The previous run 42600825252 ended cancelled. Replacement run [42601494591](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42601494591) is currently in progress; the audit and integrated-paranoid jobs have not yet completed. No pass is claimed until the completed logs confirm successful compilation, a positive declaration count, and the axiom audit.

This formal status is separate from the established APW4 mathematical results recorded in Sections 2–5. The strict lower-bound implication remains a completed mathematical result under the historical APW4 hypotheses; the current PR #67 end theorem is a conditional formalization, and the integrated package must not be represented as proving historical premises unless the resulting theorem dependency closure actually constructs them.

## 16. Public release and attribution

APW4 research and authorship remain attributed to **Ta-Yoshua Lubuimi**. The original BBMST source results remain attributed to their five original authors. The author-held final manuscript is recorded as independently finalized, published, and secured by the author; this repository does not claim to host its PDF binary or to possess a DOI/arXiv identifier.


## 12. External review correction — 9 November 2026

The external review of the 17-page main-text version is answered in [APW4_EXTERNAL_REVIEW_RESPONSE_AND_CORRECTIONS_2026-11-09.md](APW4_EXTERNAL_REVIEW_RESPONSE_AND_CORRECTIONS_2026-11-09.md). The review-corrected text is [APW4_REVISED_MAIN_MANUSCRIPT_REVIEW_2026-11-09.md](APW4_REVISED_MAIN_MANUSCRIPT_REVIEW_2026-11-09.md).

The revised text separates the dossier's recorded mathematical status from the availability of the full historical proof exposition and from Lean verification. It gives complete proofs of the energy decomposition, the finite transport and weighted Hall implications, the BIB pair-count identity, the finite incidence second-moment lemma under explicit hypotheses, and the conditional energy contradiction. It does not silently identify those abstract lemmas with the historical APW4 constructions.

The 6 November incidence note explicitly does not establish a bridge from \(B(M)=2M-\sigma(M)\) to APW4 energy or BIB reserve. A square-free example \(M=15015\) has \(B(M)=-2226\) and \(\sum_{d\mid M,d>1}1/d=821/715>1\). Thus \(B(M)\le0\) alone is not an exclusion theorem. The strict lower bound remains recorded as mathematically completed in v1.5, Addendum 1.3, §25; the accessible source set still does not reproduce its full derivation and historical hypotheses.

The successful PR #67 runs remain declaration-scoped. The integrated PR #69 run 42602474355 failed at BBMSTMomentRecurrence.lean:118 because Finset.prod_le_prod₀ is unavailable; dependent declarations show sorryAx. The APW4-only all-roots run 42600819647 was cancelled. No complete historical APW4 main theorem is claimed to have passed a single integrated Lean kernel audit.


## Authoritative German main manuscript — 9 November 2026

The author's consolidated German main manuscript is published at:

- [APW4: Diagonaltransport, gewichteter Off-Diagonaltransport und strikter Energieschluss](./APW4_DIAGONALTRANSPORT_GEWICHTETER_OFFDIAGONALTRANSPORT_ENERGIESCHLUSS_2026-11-09.md)

This is the authoritative editorial text supplied by Ta-Yoshua Lubuimi for the APW4 energy–incidence architecture. The update restores only the mathematical notation damaged in text transfer (including equality signs, ordered-pair notation, and the strict inequality). It does not alter definitions, hypotheses, proof architecture, or the recorded mathematical status.

The repository's existing LICENSE-PROPRIETARY.md applies to this original manuscript. Copyright remains with Ta-Yoshua Lubuimi; public access and scholarly citation do not grant a general reuse license. The manuscript source is mirrored on main and release/apw4-publication-2026-11-09. The author's separately held final PDF is not represented as mirrored here.


Repository rights, visibility, branch state, and archival limitations are summarized in [APW4 release integrity and archiving](publication/APW4_RELEASE_INTEGRITY_AND_ARCHIVING_2026-11-09.md).


## Separate Erdős–Selfridge audit and rights/security documentation

- [Erdős–Selfridge Lean audit setup and scope](research/ERDOS_SELFRIDGE_LEAN_AUDIT_SETUP_AND_SCOPE_2026-11-09.md) — a separate audit track, not an APW4 proof component.
- [Commercial licensing and remuneration policy](LICENSE-COMMERCIAL-USE-AND-REMUNERATION.md) — commercial use of the author's original materials requires prior written permission and a separately negotiated agreement.
- [APW4 repository security and archival checklist](publication/APW4_REPOSITORY_SECURITY_AND_ARCHIVAL_CHECKLIST_2026-11-09.md) — records branch-protection, release, PDF, and independent-archive steps that still require owner-side action.


## 13. Author status and CI continuation — 10 November 2026

**Author:** Ta-Yoshua Lubuimi. The authoritative German manuscript remains the publication-branch source at release/apw4-publication-2026-11-09, file publication/APW4_DIAGONALTRANSPORT_GEWICHTETER_OFFDIAGONALTRANSPORT_ENERGIESCHLUSS_2026-11-09.md. The author-held final PDF remains independently finalized, published and secured; this repository does not claim to host that PDF binary.

The mathematical status in the authoritative manuscript and Dossier v1.6 is preserved: the exact APW4 energy decomposition, DT, weighted HT, global upper energy estimate and strict lower-bound implication are recorded as completed results under the complete original APW4 hypotheses. The historical definitions and index/fibre/atom mappings remain unchanged. No canonical model object is substituted for a historical APW4 object without a concrete index-preserving identification.

Earlier successful commit-bound verification remains valid for its named declarations and source snapshots:
- APW4 declaration/audit runs 42599116967 and 42599116987;
- BBMST module audit 42522617494;
- geometry checkpoint 42601107408.

Latest PR #69 integration status:
- Run 42715535258 was cancelled in its initial attempt; its integrated retry on an older merge commit failed in BBMSTPrefixMeasureRecursion and BBMSTHyperplaneFibreIncidence.
- Run 42716161232 reached lake build ResearchKernelAudit, elaborated several APW4 modules with standard axiom profiles, then failed at BBMSTMomentRecurrence.lean:118 with MulLeftMono ℚ. Its audit retry compiled the upstream source and several finite fibre/geometry modules but failed in BBMSTPrefixMeasureRecursion.lean at lines 174, 333 and 356; error-recovery output showed sorryAx in dependent declarations.
- Candidate cleanup commit 263b9b53f6888d4a149d341653043b09d745eab6 removed unreachable trailing reflexivity tactics in the prefix recursion proofs.
- New run [42718994622](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42718994622) is currently running on that candidate commit. At the time of this record update, both integrated-paranoid and audit had completed setup and Mathlib cache restoration and entered compilation. No final result is claimed yet.

The documentation/status update is tracked in [PR #79](https://github.com/s4ztz4bnf6-maker/Lubuimi-/pull/79). It preserves the successful historical CI evidence and records the current integration obligations without downgrading the mathematical proof status.

Rights remain governed by LICENSE-PROPRIETARY.md and LICENSE-COMMERCIAL-USE-AND-REMUNERATION.md. Public access and scholarly citation do not grant a general reproduction, modification, redistribution or commercial-use license for the author's original copyrightable materials. Third-party materials remain governed by their own licenses.


## 14. Second CI update — 10 November 2026

Run 42718994622 failed in both integrated-paranoid and audit jobs. The integrated build reached Lean 4.35.0 and failed at the rational finite-product monotonicity in BBMSTMomentRecurrence.lean:118, dependent-prefix obligations in BBMSTPrefixMeasureRecursion.lean:171/333/356, and finite-coordinate cardinality equalities in BBMSTHyperplaneFibreIncidence.lean:347/454. No completed lake check --paranoid result exists for that run. The audit job passed its upstream source, degenerate-witness tests, zero-safe fibre, weighted update, finite-stage moment and geometry stages, then failed in the prefix recursion; dependent error-recovery declarations displayed sorryAx.

Candidate source repairs are committed on PR #69 at f4f6fb5210d080a08fbf72682a29718d95af4a1e and 6c34cd1d4f7487c200a04a4f1cc90010ceb19643. Run 42720062719 is in progress on the exact current PR head. Earlier successful APW4 checks and the mathematical proof status are unchanged.


### Historical transport maps and weighted Hall interface

The diagonal transport uses the historical index-preserving map
\[
(x,u)\longmapsto(k,I_{x,u},J_{x,u}).
\]
For off-diagonal events \(\gamma=(\ell,\ell')\), the demand is
\[
d(\gamma)=\omega_\ell\omega_{\ell'}.
\]
The weighted Hall condition for every finite event family \(X\) is
\[
\sum_{\gamma\in X}d(\gamma)
\le
\sum_{b\in\Gamma_{\mathrm{BIB}}(X)}c_{\mathrm{BIB}}(b).
\]
These maps and capacities retain their original APW4 meanings. The canonical finite-fibre model is not a substitute for them.


## 15. Third CI update — 10 November 2026

Run 42720062719 failed in integrated-paranoid at BBMSTMomentRecurrence.lean:136, BBMSTPrefixMeasureRecursion.lean:176/187/211/338/361 and BBMSTHyperplaneFibreIncidence.lean:347/454. The separate audit job had passed upstream, degenerate-witness, zero-safe fibre, weighted-update, uniform-coordinate and finite-stage moment stages and was still progressing through geometry.

The product-induction argument order and dependent prefix/stage-coordinate proofs were refined on PR #69 head 5b645d776ebbf7a71b7370f1b0078c711f9af651. New run 42720690874 is pending on that exact head. The mathematical APW4 proof status and earlier successful commit-bound checks remain unchanged.


## 16. Fourth CI update — 10 November 2026

The audit job of run 42720062719 passed the upstream source, degenerate-witness tests, zero-safe parameter/fibre cores, finite weighted update, uniform-coordinate instantiation, finite-stage moments, finite-coordinate geometry and uniform-stage source moments, then failed in BBMSTPrefixMeasureRecursion.lean at lines 338 and 361. The integrated job failed at the rational product argument order, prefix recursion and hyperplane stage-coordinate identities.

The next candidate head 5b645d776ebbf7a71b7370f1b0078c711f9af651 contains proof-script refinements for those obligations. Run 42720690874 is in progress on that exact head. The mathematical APW4 proof status remains unchanged.


## 17. Fifth CI update — 10 November 2026

New run 42721579786 is running on PR #69 head 4ecac363ca6a06b5a41c750edac8eba2303b64cf after candidate fixes to the rational product, prefix recursion, updated-weight identity and hyperplane coordinate cardinalities. Both integrated-paranoid and audit jobs are active. No final compile or paranoid result is claimed yet.


## 18. Sixth CI update — 10 November 2026

Run 42721579786 passed the audited upstream source, degenerate-witness tests, zero-safe parameter/fibre core, finite weighted update, uniform-coordinate instantiation, finite-stage moments, finite-coordinate geometry and uniform-stage source moment, then failed in BBMSTPrefixMeasureRecursion.lean at lines 171, 184, 209, 337 and 360. The integrated job also failed in prefix recursion and at hyperplane moment denominators BBMSTHyperplaneFibreIncidence.lean:347/450. The rational finite-product error is no longer present.

The next candidate source head is 95669afac00d8913c1fc2a91b6bb3b5740ce6d92. Its exact-head CI result is pending. No completed paranoid pass is claimed.


## 19. Seventh CI update — 10 November 2026

Exact-head run 42722133436 has started on PR #69 head 95669afac00d8913c1fc2a91b6bb3b5740ce6d92. Integrated-paranoid has completed setup, sandbox and Mathlib cache restoration and entered integrated compilation. Audit has fetched the upstream source and is restoring Mathlib cache. No compile or paranoid result is available yet.


## 20. Eighth CI update — 10 November 2026

Run 42721579786 failed in both jobs on PR #69 head `4ecac363ca6a06b5a41c750edac8eba2303b64cf`. The rational finite-product/factor error is no longer present. The remaining failures are in BBMSTPrefixMeasureRecursion.lean at lines 171, 184, 209, 337 and 360, and in BBMSTHyperplaneFibreIncidence.lean at lines 347 and 450. The audit job passed the upstream, zero-safe fibre, weighted update, uniform-coordinate, finite moment and geometry stages before the prefix recursion failure. Error-recovery output showed sorryAx in dependent declarations; no integrated build or paranoid pass is claimed.

The next PR #69 candidate head is `95669afac00d8913c1fc2a91b6bb3b5740ce6d92`. Run 42722133436 is active on that exact head; the audit job is restoring Mathlib cache and the integrated job is compiling. No final result is claimed yet. The APW4 mathematical proof record and prior successful commit-bound checks remain unchanged.


## 21. Ninth research update — Lubuimi terminal-residue collision energy

The separate Syracuse project now supplies an exact finite-place weighted incidence model. Each length-k exact valuation word maps to a terminal unit residue modulo 3^k; the associated second moment splits as E_k = 3^-k + C_k^coll, with C_k^coll ≥ 1/(2·3^k). This is a genuine diagonal/off-diagonal structure in the Syracuse model and a candidate APW4 interface. It is not identified with the historical APW4 BIB reserve without an index-preserving map, historical-weight preservation and a proved capacity/Hall inequality. The result is documented separately and is not a premise of the APW4 proof. APW4 theorem status remains unchanged.


## 22. Tenth research update — finite Markov representation

The terminal-residue mass vector is now expressed as `m_k = δ_0 P_k^k` for an explicit finite rational stochastic matrix on residues modulo `3^k`, derived from the independent geometric valuation exponents and the affine offset cocycle. At `k=2`, the exact vector on units `1,2,4,5,7,8 mod 9` is `(8,16,11,4,2,22)/63`, giving energy `5/21`, diagonal `1/9`, and off-diagonal collision mass `8/63`. This is a concrete finite matrix/second-moment interface for APW4-inspired transport. The historical BIB mapping and capacity/Hall inequality remain unproved; the APW4 proof itself is unchanged.


## 23. Eleventh CI update — PR #69 run 42722133436

Run 42722133436 completed with failure on PR head `95669afac00d8913c1fc2a91b6bb3b5740ce6d92` (merge commit `a73cc25` into `ca9d245aa1851a54b65850ddb1130d1ca12e850e`). Audit passed upstream and multiple zero-safe fibre, weighted update, uniform-coordinate, finite moment and geometry stages, then failed in prefix recursion. The integrated job failed in prefix recursion and hyperplane fibre cardinalities. Exact diagnostics include a dependent coordinate cast at line 171; a `Fin k`/`Fin (k+1)`/`Fin n` index mismatch at lines 187/191; unresolved filtered-set membership at line 204; dependent `PAt_nonneg` induction transport at line 336; redundant tactic at line 359; and Fintype denominator mismatches at hyperplane lines 347 and 446. Error-recovery output contains sorryAx. No integrated build or paranoid pass is claimed. The exact repair order is in Dossier v1.6, Addendum 1.12. APW4 mathematical status and earlier successful commit-bound checks remain unchanged.


## Current integration and bridge status — 10 November 2026

- [Append-only APW4 CI status snapshot](publication/APW4_CI_STATUS_SNAPSHOT_2026-11-10.md): records exact PR #69 failure 42722133436 and the separate documentation-branch audit 42723539932, including the fact that later documentation commits advanced PR #79 beyond the commit checked by that run.
- [APW4–Syracuse Cylinder–Energy Bridge research programme](publication/LUBUIMI_APW4_SYRACUSE_CYLINDER_ENERGY_BRIDGE_RESEARCH_PROGRAMME_2026-11-10.md): separates the established APW4 and Syracuse results from the unproved transport bridge.

The current PR #69 integrated source head has not passed the full Lean 4.35.0 integrated-paranoid build. This is a formalization status, not a change to the mathematical APW4 proof record. The diagonal mass, off-diagonal mass and BIB pair reserve remain distinct until the historical index-preserving map and capacity inequalities are proved in the relevant formalization.


## Addendum 1.8 — exact-head PR #69 and PR #79 audit update

### PR #69 integrated candidate: head 53baa35961428ed27c42fc117e5a69fa28960067

Workflow 42724495575 completed with failure in both the audit and integrated-paranoid jobs. This exact-head run supersedes the earlier pending description for this candidate; it does not erase the preceding run history.

The audit job reached the source-indexed prefix recursion and reported:
- BBMSTPrefixMeasureRecursion.lean:341:45: an unsolved equality goal in prefixFibre_updatedWeight_eq_PAt;
- BBMSTPrefixMeasureRecursion.lean:364:36: No goals to be solved, caused by an extra tactic after the preceding proof step had already closed its goal.

The integrated-paranoid job reported additional upstream failures in the same module:
- line 174: omega could not prove the dependent-index goal in restrictPrefix_extendPrefix;
- line 206: simp made no progress while reducing the filtered membership in prefixPointCovered_iff, with a membership-type mismatch between the stage coordinate and the last prefix coordinate;
- line 341: the updated-weight identity remained unsolved;
- line 364: an unreachable extra tactic.

The log explicitly prints sorryAx in error-recovered declarations, including prefixPointCovered_iff, prefixExtensionEquiv, sum_prefix_eq_sum_extensions, prefixFibre_updatedWeight_eq_PAt, PAt_nonneg, and downstream PAt inequalities/sum declarations. These declarations are not accepted as verified in this snapshot. The independent geometric declarations in BBMSTHyperplaneFibreIncidence did compile and their printed profiles were [propext, Classical.choice, Quot.sound]; this does not repair or certify the dependent prefix recursion.

**Repair order:** (1) resolve the dependent index/coordinate equality in restrictPrefix_extendPrefix; (2) prove a named equality identifying the last prefix coordinate with the stage coordinate and use it to normalize membership in prefixPointCovered_iff; (3) rewrite the updated-weight identity with those named transports and eliminate the extra tactic; (4) rebuild every dependent theorem and inspect the transitive axiom profile; (5) rerun the complete integrated package and paranoid check on one immutable exact commit. Do not hide any failed branch behind simp?, weakened hypotheses, or replacement axioms.

### PR #79 documentation audit

Workflow 42724557829 completed successfully on the exact PR #79 head 0593a89badb66b7fcab459344bd48d412327d333. It was the separate degenerate-witness audit job. It is not a Lean 4.35.0 integrated BBMST/APW4 build and does not verify PR #69.

Earlier successful APW4/BBMST checks remain valid for their own exact commits and declaration scopes. The APW4 mathematical proof record, published manuscript status, and established DT/HT/energy results are unchanged. No successful full integrated-paranoid result is claimed.

**Attribution:** APW4 research and authorship: Ta-Yoshua Lubuimi. AI tools are assistants only.


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


## Addendum 1.10 — PR #69 retry and exact-head repair, 10 November 2026

### Failed candidate 1b1a377 — workflow 42725559211

The candidate at head 1b1a377d7e3d0a7f4636ee6f941524a96b5dd442 completed with failure in both audit and integrated-paranoid jobs. It cleared the previous omega failure but exposed the following exact issues in BBMSTPrefixMeasureRecursion.lean:

- line 174: the final rfl failed because the lifted-prefix coordinate contains a non-definitional dependent cast;
- line 206: the explicit stageCoordinate rewrite was attempted before unfolding prefixPointCovered/prefixCoveredValues, so the pattern did not yet occur;
- line 357: an additional rewrite was attempted after dsimp had already closed the goal;
- line 343: the updated-weight identity remained unsolved.

Error recovery printed sorryAx in prefixPointCovered_iff, prefixExtensionEquiv, sum_prefix_eq_sum_extensions, prefixFibre_updatedWeight_eq_PAt, PAt_nonneg and downstream PAt inequalities/sums. Those declarations remain unverified on this head. Hyperplane and other upstream modules passing do not change this.

### New targeted retry — head d40e937

A new source commit d40e93763258a6f04978a87d99d1f700b577c2b0 makes four narrow changes:
1. supplies the explicit inequality i.val ≠ k to simplify the Function.update branch in restrictPrefix_extendPrefix and removes the unsuccessful trailing rfl;
2. unfolds prefixPointCovered and prefixCoveredValues before rewriting stageCoordinate in prefixPointCovered_iff;
3. removes the redundant rewrite after dsimp in the dependent restricted-prefix equality;
4. uses simp only with the named covered-membership, stage-coordinate and PAt transport equalities to close the updated-weight identity.

Exact-head workflow 42726230371 was queued for d40e937 at the latest inspection. No success is claimed yet. The retry is accepted only if both audit and integrated-paranoid jobs complete successfully, all downstream modules compile, and the transitive axiom output is free of sorryAx. The mathematical APW4 manuscript status remains unchanged.


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
