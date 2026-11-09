# APW4 — public release and priority statement

**Author:** Ta-Yoshua Lubuimi  
**Date:** 9 November 2026  
**Status:** Author's research and priority statement; not an independent priority certification.

## 1. What the contribution claims — and what it does not claim

The author expressly does **not** claim to have solved the original Erdős–Selfridge problem itself.

The contribution is the APW4 energy–incidence argument in the square-free-moduli / BBMST setting: exact energy decomposition, diagonal transport (DT), weighted off-diagonal transport (HT), the resulting global upper energy estimate, the strict arithmetic lower-bound implication under the stated historical APW4 hypotheses, and the resulting contradiction.

The author's stated breakthrough and priority claim is narrower and methodological: to the author's knowledge, this is the first instance worldwide of an Erdős–Selfridge-related mathematical proof developed with this kind of computationally supported, Lean-kernel-checked verification architecture, pursued in the spirit of the high-rigor formal-verification standards discussed by Terence Tao. The author asserts priority for this achievement.

That worldwide-first claim is recorded as the **author's priority claim**, not as an independently established historical fact. Establishing priority requires an exact novelty statement and a systematic comparison with prior formalized Erdős-related results and independent expert assessment. This reservation does not reopen or downgrade the mathematical results in the APW4 manuscript.

## 2. Mathematical status

The APW4 manuscript records as established mathematical results:

- exact decomposition E_APW4 = D_APW4 + C_APW4;
- diagonal transport (DT);
- weighted off-diagonal transport (HT);
- the global upper energy estimate;
- the strict arithmetic lower-bound implication under the historical APW4 hypotheses;
- the resulting contradiction in the stated parameter regime.

The mathematical proofs and the scope of a particular Lean CI run are distinct evidence levels. The mathematical results above remain attributed to Ta-Yoshua Lubuimi.

## 3. Exact scope of the currently recorded Lean evidence

The APW4 canonical CI record is tied to commit 64f38063ef179b3ea9aa0891b5fc04a4b0d7eb97 and runs 41895530029 and 41895530064. The documented standard axiom profile applies to the seven named declarations listed in APW4_PUBLICATION_RECORD.md.

These are genuine declaration-level Lean kernel/axiom records. They must not be represented as a complete Lean formalization of every historical DT, HT, and strict-lower-bound proof unless the exact theorem statements and their complete dependency closures are separately formalized and audited. This is a boundary on the current CI evidence, not a qualification of the mathematical proof status.

## 4. Relation to Terence Tao

“Tao standards” is used here only as a methodological comparison: precise formal statements, kernel checking, transparent axiom/dependency audits, reproducibility, and consistency between informal and formal claims. It is not an official certification label. No endorsement, review, approval, or verification by Terence Tao is claimed.

## 5. Publication identifiers and file custody

As of this record:

- no DOI has been assigned;
- no arXiv identifier exists;
- the author has contacted a scientific journal; no acceptance or publication decision is asserted here;
- the GitHub repository is public, and this record is available on the branch docs/apw4-publication-package-2026-11-08;
- the manuscript PDFs are not yet mirrored as binary assets in this repository or deposited on Zenodo.

Checksums of the two supplied PDFs, for file-identification and release-integrity purposes:

- "Erdös Lean 4 Beweis.pdf" (17-page consolidated APW4 manuscript): SHA-256 b9cbb70a8c879fe9a5dca4cda60990b23d9d1b7ad61ad3bbf4343175c425fc66.
- "Erdös Lean Deutsch.pdf" (3-page German version): SHA-256 5660b740fa1762271aa2748dc54627b59e87b773b42431ff5b2fb0bedb6e9f13.

These checksums identify the files received for this publication workflow; they do not imply that the files have already been uploaded to GitHub, Zenodo, or arXiv. The binary repository mirror and DOI deposit remain outstanding.

## 6. Attribution

APW4 research, mathematical results, and authorship are attributed to **Ta-Yoshua Lubuimi**. AI systems may be acknowledged as assistance only; they are not authors and are not independent mathematical verifiers.
