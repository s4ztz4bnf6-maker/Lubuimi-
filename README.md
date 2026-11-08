# APW4 — Mathematical and Formalization Record

**Author and research lead:** Ta-Yoshua Lubuimi  
**Working paper title:** *The APW4 Energy–Incidence Argument and Its Lean 4 Formalization: Mathematical Results, Proof Architecture, and Reproducible Verification*  
**Record date:** 8 November 2026

This branch preserves the APW4-specific mathematical record and its publication metadata separately from the repository's broader BBMST and Erdős–Selfridge formalization work.

## Mathematical result recorded

The APW4 energy has the exact decomposition
`\mathcal E_{APW4}=D_{APW4}+C_{APW4}`.
The mathematical dossier records the diagonal transport (DT),
`D_{APW4}\le D_k^{BBMST}`,
and the off-diagonal transport (HT),
`C_{APW4}\le\mathcal R_{BIB}`.
Consequently,
`\mathcal E_{APW4}\le D_k^{BBMST}+\mathcal R_{BIB}`.

The dossier also records the strict lower-bound result, under its historical APW4 hypotheses,
`B(M)=2M-\sigma(M)\le0\Rightarrow
\mathcal E_{APW4}>D_k^{BBMST}+\mathcal R_{BIB}`.
Together these two inequalities yield the contradiction in the stated parameter regime.

These mathematical results are recorded as established in the research dossier. This branch does not replace the original proof records with newly invented definitions or substitute a canonical finite model for the historical APW4 objects.

## Formal artifacts in this repository

The APW4 code snapshot on which the canonical APW4 checks were run is commit
`64f38063ef179b3ea9aa0891b5fc04a4b0d7eb97`
on branch `audit/apw4-diagonal-majorization-2026-11-04`.

Recorded successful workflows on that exact commit:
- [APW4 canonical majorization](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/41895530029)
- [Lean audit](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/41895530064)

The declarations and their reported standard axiom profile are listed in [the APW4 publication record](publication/APW4_PUBLICATION_RECORD.md). These logs establish exactly the declarations they compiled and audited; they are not silently extended to declarations outside that dependency closure.

A separate integrated 22-module BBMST workflow is recorded on commit
`436a2e387bb774ee2d31d5dc8908ec3cfdb06150`
with runs [42522617423](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42522617423), [42522617399](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42522617399), and [42522617494](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42522617494). This is a distinct code snapshot and workflow record; it must not be described as a direct kernel verification of the historical APW4 DT/HT instantiation unless the exact theorem-to-module dependency map establishes that correspondence.

## Publication files

- [APW4 publication record](publication/APW4_PUBLICATION_RECORD.md)
- [Citation metadata](CITATION.cff)

The author prepares and publishes the paper PDF separately. No PDF is generated or committed by this branch at this stage.

## Attribution

The APW4 research and this repository's APW4 formalization work are attributed to **Ta-Yoshua Lubuimi**. The original BBMST theorem and its published proof remain attributed to their original authors: P. Balister, B. Bollobás, R. Morris, J. Sahasrabudhe, and M. Tiba.

AI tools may be disclosed as research assistance where applicable; they are not authors and are not independent mathematical verifiers.
