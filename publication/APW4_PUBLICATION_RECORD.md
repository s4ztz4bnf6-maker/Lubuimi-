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


## 14. Integrated 33-module audit and full Theorem 1.2 reduction

The updated PR #56 Theorem 1.2 reduction passed CI run 42601107408. The new canonicalReduction_result_full and its helper declarations report only [propext, Classical.choice, Quot.sound], with no sorryAx.

PR #69 consolidates 33 BBMST/APW4 modules from the prefix-mass, rank-nine CRT/fibre, codimension-one geometry, and APW4 branches into an isolated Lean 4.35.0 package. Every module is explicitly listed as a library root; the aggregator is the default target; CI executes lake build ResearchKernelAudit followed by lake check --paranoid. The current integrated workflow is [42601494591](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42601494591), still in progress at the time of this update. The previous run 42600825252 was cancelled after source updates and is not counted.

The separate APW4-only Lean 4.35.0 all-roots check is [42600819647](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42600819647), also still in progress. Earlier checks that reported zero declarations or failed because imported module roots were not listed are excluded.

No integrated paranoid success or complete APW4 main-theorem kernel verification is claimed yet. The PR #67 conditional APW4 endgame still takes the historical DT, HT, and strict lower-bound premises as inputs. The mathematical APW4 status from Dossier v1.5 §25 is unchanged.


## 15. Original BBMST computational supplements and current integrated check

The original authors' supplementary page is now included in the source reconstruction: https://people.maths.ox.ac.uk/balister/Erdos-Selfridge.html. It documents the Gurobi-backed initial-distribution LP search, its output configurations, a portable C program optimizing δ₆,…,δ₂₁, and a large-prime program for the f₂₁ bound and the 2018 density-paper table. The C source bodies were not line-audited because the server served text/x-csrc; the recorded descriptions are limited to the authors' index page. These supplements support the historical BBMST proof chain but do not supply the APW4-specific historical event/BIB map or the omitted arithmetic intermediate proof.

The integrated Lean 4.35.0 run [42601494591](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42601494591) failed in the integrated-paranoid job, with exact errors in BBMSTMomentRecurrence.lean and BBMSTGeometryStageCore.lean. The source fixes are committed as b2d8c43002772d442c8f4b82f0b1877312acd558 and c713aa4bd483d541df43aea36fda15e3fb1467c1. The replacement workflows [42602474355](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42602474355) and [42602465766](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42602465766) were still in progress at the last check. The APW4-only all-roots run [42600819647](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42600819647) was likewise still in progress. No integrated Lean 4.35.0 paranoid success is claimed.

The uploaded 17-page PDF was reviewed in full. The key strict comparison symbol on page 11 is missing in the accessible rendering/extraction, and the complete intermediate arithmetic proof is not printed. It is therefore not reissued as a publication-ready self-contained proof. This does not change the mathematical APW4 status in Dossier v1.5 §25. A companion report may publish the verifiable energy algebra, finite second-moment elimination, source reconstruction and CI record, but must keep the historical APW4 lower-bound proof and DT/HT source identifications explicitly distinguished from what is actually reproduced.


## 16. New companion manuscript

The new companion report is available at [APW4_Energy_Incidence_Companion_Manuscript_2026-11-09.md](APW4_Energy_Incidence_Companion_Manuscript_2026-11-09.md). It includes the complete finite second-moment elimination proof, exact APW4 energy algebra, the conditional max-flow implication, BBMST source reconstruction and supplements, and commit-scoped Lean evidence. It expressly preserves the mathematical status of the APW4 strict lower-bound theorem in dossier v1.5 §25 while disclosing that its full historical intermediate derivation is not reproduced in the accessible manuscript artifact. This companion report is not advertised as a self-contained replacement for the full historical APW4 proof.
