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

[PR #69](https://github.com/s4ztz4bnf6-maker/Lubuimi-/pull/69) consolidates 34 previously separate BBMST/APW4 Lean modules into an isolated Lean 4.35.0 package. Every module is an explicit library root; the workflow builds the aggregate ResearchKernelAudit and then runs lake check --paranoid. The first zero-declaration check was rejected and the package configuration corrected. The earlier integrated run 42600825252 was cancelled after source updates. The current run [42601494591](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42601494591) includes the full Theorem 1.2 reduction and was still in progress when this README update was prepared. No integrated paranoid success is claimed until the log reports a positive declaration count and the job passes.


The updated PR #56 branch subsequently added the full Theorem 1.2 result, including nonparallelism and nontriviality of the surviving/restricted family. [CI run 42601107408](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42601107408) passed; the new theorem and helper declarations report only [propext, Classical.choice, Quot.sound], with no sorryAx.


Formalization boundary for the CRT source: the rank-nine branch proves the actual one-prime ZMod CRT/fibre equivalence and finite unweighted allocation lemmas. It does not yet contain one end-to-end Lean theorem encoding every square-free divisor class as a nonparallel hyperplane family via unique factorization. The source reconstruction note records this distinction explicitly; neither is identified with APW4's weighted Hall transport.


An APW4-only Lean 4.35.0 paranoid package now lists all four APW4 modules as explicit roots and runs an explicit build before the paranoid check. Its all-roots run [42600819647](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42600819647) was still in the final check step at the time of this update. The earlier zero-declaration check is rejected as vacuous.
