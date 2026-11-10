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


## APW4 exact-head repair ledger — 10 November 2026 (append-only)

The established APW4 mathematical record above is retained. The exact energy decomposition, diagonal transport (DT), weighted-Hall/off-diagonal transport (HT), global upper energy estimate, strict lower-bound implication, and contradiction remain part of the author's completed mathematical proof at their stated hypotheses. The historical CRT/BIB reconstruction recorded in the APW4 dossier is preserved; no abstract replacement map is substituted for the historical indices, events, BIB slots, or capacities.

### Historical reconstruction checkpoint

Commit `9a3aec51cd7d4696d6220a548c8f711c45ca9d20` records the definition-completeness matrix and dependency order for the historical objects `A_q, A_r, W_{q,r}, a_{q,t}, D_{q,r}, U_q, F_q, C_h), elementary events, event map, BIB slots/incidence, and weighted Hall criterion. It records the block identity
`A_q W_{q,r} A_r^T = sum_{t mod D_{q,r}} a_{q,t} a_{r,t}^T`
and the marginal bound
`sum_h M_{q,r}(h,g) <= Gamma_{q,r}(g)`.
These are retained as reconstruction results with the source definitions and historical index sets controlling their formal instantiation; no residual term or incidence map is to be invented to fill a missing source definition.

### Prefix recursion repair — exact v15 candidate

The v14 integrated-paranoid log narrowed the remaining failure to the conditional reductions in `BBMSTPrefixMeasureRecursion.lean` at the local endpoint: the proof witnesses were stated for `y (Fin.last k)`, whereas `updatedWeight` was applied to the let-bound local term `x`. The current candidate derives the matching local witnesses
`hcovFx : x ∈ F.covered`,
`hnotFx : x ∉ F.covered`, and
`hpointFx : x ∈ F.points`
by simplifying the existing endpoint witnesses with `[x]`, and then uses those witnesses for the two conditional reductions. This changes only proof-term normalization; it does not change the theorem statement, definitions, hypotheses, or mathematical content.

Candidate branch: `repair/apw4-membership-witness-local-let-v15-2026-11-10`. Candidate head: `800d752e626951505d9dbcb312dfe09555ee6f2f`. PR: [#138](https://github.com/s4ztz4bnf6-maker/Lubuimi-/pull/138). **OFFEN – NICHT VERIFIZIERT** until the exact head completes the integrated Lean 4.35.0 paranoid workflow, the named `#print axioms` outputs are inspected, and the transitive dependency closure is confirmed free of `sorryAx`. No CI result is inherited from an earlier candidate.

The remaining historical formalization tasks are still tracked separately: the source-faithful `prefixFixedCoords` / initial profile family, historical `c(I)) including the empty profile, exact identification of the suffix factor with `nu(J)), the full historical Lemma 3.3 statement, and the Lemma 3.4 moment chain. The v15 proof-script candidate does not by itself close those bridges.

This entry does not modify or replace the author's independently finalized manuscript PDF. Any manuscript-source edit must preserve the existing mathematical exposition and be checked against the author's release copy before publication.


## Historical event-to-BIB reconstruction checkpoint — 10 November 2026

The source-reconstruction ledger is now included at [publication/APW4_HISTORICAL_EVENT_BIB_RECONSTRUCTION_LEDGER_2026-11-10.md](publication/APW4_HISTORICAL_EVENT_BIB_RECONSTRUCTION_LEDGER_2026-11-10.md). It records the recovered q-fibre working definitions

\[
B_q=N/q^{a_q},\quad V_q=\{z:z\bmod B_q\in U_q\},\quad
F_q(x)=\{z:z\equiv x\pmod{B_q}\},\quad P_{q,x,h}=F_q(x)\cap C_h,
\]

and the corresponding intersection-count quantities

\[
M_{q,r}((x,h),(y,g))=|P_{q,x,h}\cap P_{r,y,g}|,\qquad
\Gamma_{q,r}(g)=|C_g\cap V_q\cap V_r|.
\]

The ledger also preserves the block identity \(A_qW_{q,r}A_r^{\mathsf T}=\sum_{t\bmod D_{q,r}}a_{q,t}a_{r,t}^{\mathsf T}\), the fibre-count bound \(\sum_hM_{q,r}(h,g)\leq\Gamma_{q,r}(g)\), and the exact four-term residual expansion obtained from \(I_q=A_q+Z_q\). The four-term matrix expansion contains three Z-residual contributions; it is not a third term in the two-term APW4 energy decomposition.

The ledger deliberately marks the exact row/column domains, quotient maps, event universe, full event map, BIB slot universe, incidence predicate, and weight-preserving weighted-Hall verification as remaining source-reconstruction obligations. The historical DT map \((x,u)\mapsto(k,I_{x,u},J_{x,u})\) must be expanded componentwise. APW off-diagonal atoms \((\ell,\ell')\) must not be identified with within-fibre pairs \((u,v)\) without an explicit proved projection/quotient map. These distinctions guide the remaining Lean instantiation; they do not reopen the established APW4 mathematical proof.


### Exact run/commit attribution correction — 10 November 2026

The conditional-reduction diagnostics at lines 397 and 410 belong specifically to workflow [42815999557](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42815999557) on source commit `dee13d1ada1c440b7e9fe3f9cb7fbd87fcdf3330` (the preceding dependent-coordinate candidate). That commit uses `cases hstage`; its source shows `updatedWeight F ... x` but supplies `hcovF), `hnotF), and `hpointF) at `y (Fin.last k)`. The compiler reports `simp made no progress` at both conditional reductions and downstream `sorryAx). The local-witness transport in PR #138 addresses precisely this mismatch.

PR [#137](https://github.com/s4ztz4bnf6-maker/Lubuimi-/pull/137) is a separate v14 source head `175c50c75d537ef32687c63cb1219e8ff1ace257`; no associated exact-head run was returned in this check. Do not attribute run 42815999557 to PR #137. PR #138's current head is separately tracked and remains unverified until its own CI and axiom gates complete.


### Exact-head refresh after v15 local-witness repair — 10 November 2026

The v15 proof-term repair remains the code change identified above: the endpoint membership/non-membership/point witnesses are transported from the geometric endpoint to the let-bound local value used by `updatedWeight`. A comment-only exact-head refresh was then committed as `3bb0e4ab45d74cbece76edbc5be14bca0043cdc9`; it changes no declaration, theorem statement, definition, hypothesis, or proof term. The exact-head workflow lookup returned no workflow run and no commit status for this refresh. Therefore the v15 candidate remains **OFFEN – NICHT VERIFIZIERT**; no earlier successful module audit is extended to it.




## Prefix-cylinder event-mass bridge — 10 November 2026

The source-indexed prefix recursion now contains a stronger intermediate result than the pointwise distortion estimate alone. In `BBMSTPrefixCylinderMass.lean`, the following declarations provide the exact one-coordinate event-mass dichotomy:

1. `containsPrefix_extend_iff` decomposes a next-prefix hyperplane constraint into the old-prefix constraint and the boundary-coordinate constraint.
2. `prefixCylinderExtensionEquivFree` and `prefixCylinderExtensionEquivFixed` give the actual subtype equivalences for free and fixed boundary coordinates.
3. `prefixCylinder_free_mass_reindex` and `prefixCylinder_fixed_mass_reindex` reindex the cylinder mass through those equivalences.
4. `prefixCylinder_free_mass_eq` proves exact mass conservation when the new coordinate is free.
5. `prefixCylinder_fixed_mass_le` proves the one-coordinate distortion bound when the new coordinate is fixed:
   [
   mu_{j+1}(H)le
   rac{mu_j(H)}{|S_i|(1-delta_i)}.
   ]
6. `hyperplaneSuffixFactor` charges precisely the fixed coordinates and assigns factor (1) to free coordinates.
7. `prefixCylinderMass_le_initial_mul_hyperplaneSuffixFactor` iterates the dichotomy and proves
   [
   mu_j(H)le mu_0(H),
u_H([a,a+j)),
   ]
   where the suffix factor is the product of (1/(|S_i|(1-delta_i))) over exactly those suffix coordinates at which (H) has a fixed assignment.

This is the concrete cylinder-level mechanism needed for the suffix part of BBMST Lemma 3.3: free coordinates preserve cylinder mass; fixed coordinates incur exactly one distortion factor. It is not merely the unrestricted total-mass identity.

**Scope boundary:** these are declarations present in the v15 source candidate. They are not yet promoted to integrated Lean-verification results: PR #138's exact head is `6d6bcacedab9c0c98a21156d4e90601b7cb87a5f`, and no exact-head workflow/status was returned. The v15 local-membership repair in `BBMSTPrefixMeasureRecursion.lean` is a dependency of this chain and remains subject to the same exact-head integrated paranoid and transitive axiom audit.

### Exact remaining bridge after the cylinder estimate

The current theorem has the form
[
mu_j(H)le mu_0(H),
u_H(J).
]
To obtain the historical Lemma 3.3 form, the remaining source-faithful work is now sharply localized:

- define the actual initial profile (I(H)) from the source's fixed coordinates in the initial block;
- define the source's finite profile family from the actual initial hyperplane family, not from all formally possible subsets;
- identify (mu_0(H)) with the historical initial cylinder quantity and prove its bound by the exact (c(I(H)));
- identify the suffix product above with the paper's (
u(J(H))), including its exact interval convention and endpoint exclusions;
- handle the empty initial profile as an explicit case of the historical definition;
- then instantiate Lemma 3.3 and feed its output into Lemma 3.4's moment recurrence.

No historical definition is inferred merely from the matching shape of the formula. The exact source index sets, coordinate deletion/preprocessing, and profile restrictions remain controlling.

### Manuscript synchronization

The corresponding main-text note is a formalization-status addendum only. It does not change the established APW4 mathematical proof, its hypotheses, or the exact two-term energy identity. It also does not assert that this intermediate BBMST cylinder theorem alone completes the historical APW4 event-to-BIB map or weighted Hall construction.




## Source-exact reconciliation of c(I), nu(J), and the current cylinder theorem — 10 November 2026

The published source has now been checked directly at the definitions and proof of Lemma 3.3 (Balister–Bollobás–Morris–Sahasrabudhe–Tiba, *Algebra & Number Theory* 15 (2021), pp. 614–617; equations (9), (10), (15)).

The exact definitions are:
[
c(I)=max{mathbb P_a(H): H	ext{ is a hyperplane in }Q_a, F(H)=I},
qquad Isubseteq[a],
]
and
[

u(J)=prod_{jin J}rac{1}{(1-delta_j)|S_j|},
qquad Jsubseteq[a+1,n].
]
The paper explicitly states (c(arnothing)=
u(arnothing)=1). The empty-profile identity uses that (mathbb P_a) is a probability measure: the only hyperplane with no fixed coordinates is the full box (Q_a), whose mass is 1.

**Important profile-domain correction:** (c(I)) is a maximum over *all* hyperplanes of the initial box (Q_a) whose fixed-coordinate set is exactly (I), not merely over the hyperplanes in the particular covering family (mathcal A). A Lean definition restricted to the members of (mathcal A) would be too small and would not be source-faithful. The initial profile family must therefore enumerate all partial assignments on (I), with every coordinate outside (I) free, and evaluate their (mathbb P_a)-cylinder masses.

The current `prefixCylinderMass_le_initial_mul_hyperplaneSuffixFactor` has precisely the induction shape of (15). For a hyperplane (H) whose fixed-coordinate set splits as
[
F(H)=Icup J,quad Isubseteq[a],quad Jsubseteq[a+1,a+j],
]
the current recursion charges one factor
[
rac{1}{(1-delta_i)|S_i|}
]
exactly when the newly exposed coordinate (i) is fixed by (H), and charges 1 when it is free. Thus the remaining equality is a finite-product/index identification:
[
	exttt{hyperplaneSuffixFactor}(a,delta,H,j)
=
prod_{rin F(H)cap[a+1,a+j]}
rac{1}{(1-delta_r)|S_r|}.
]
The one-based paper coordinate (r) corresponds to Lean's `Fin n` value (r-1); in the present recursion the suffix interval is `Finset.Ico a (a+j)`. This index shift and the right-open endpoint must be explicit in the Lean theorem.

Consequently, the source-faithful Lemma 3.3 closure should be organized as two separate lemmas:
1. initial-block bound (mathbb P_a(H)le c(F(H)cap[a])), by the defining finite maximum;
2. suffix-factor identity above, followed by the already-present cylinder induction.

This yields (mathbb P_{a+j}(H)le c(I)
u(J)) for the exact split of fixed coordinates. It does not require inventing another distortion estimate.

**Lemma 3.4 dependency:** its exact right-hand side is
[
rac{1}{|S_k|^t}
sum_{F_1,ldots,F_tinmathcal N_k}
c!left((F_1cupcdotscup F_t)cap[a]ight)

u!left((F_1cupcdotscup F_t)cap[a+1,k-1]ight).
]
The proof first bounds (alpha_k(x)) by the number of compatible new hyperplanes divided by (|S_k|), expands the (t)-th power as an ordered (t)-tuple sum, identifies intersections of hyperplane shadows as either empty or a hyperplane with fixed set the union, and applies Lemma 3.3. The current `BBMSTPrefixMomentBridge` supplies the actual (P_{k-1})-weighted first/second moments and the hyperplane-incidence modules supply a union-bound intermediate; the missing connection is the exact (c(I)
u(J)) bound on each shadow intersection, followed by the ordered tuple summation. The tuple order and multiplicity must be preserved.

Primary source pages: [published article PDF, pp. 614–617](https://ora.ox.ac.uk/objects/uuid%3A3c55267c-60be-4652-89a7-db3db5f62c25/files/rdv13zt50s). This source reconciliation is distinct from Lean verification: the definitions and proof architecture are source-checked; the v15 integrated candidate remains unverified on its exact head.
