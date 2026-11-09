# BBMST multi-kernel and statement-fidelity gate

Date: 2026-10-26

## Motivation from formal-verification reliability discussions
A kernel-checked proof establishes the encoded proposition relative to the trust assumptions of the prover. It does not by itself establish that the encoded proposition matches the intended theorem. Independent kernels reduce some implementation risk but do not replace source-level mathematical review; independent checkers can share defects or rely on the same malformed statement.

## Required gates for a BBMST formalization

### Gate A — source statement
Record the exact theorem and assumptions from Balister–Bollobás–Morris–Sahasrabudhe–Tiba, *The Erdős–Selfridge problem with square-free moduli* (arXiv:1901.11465; published in Algebra & Number Theory 15 (2021), 609–626). Explicitly preserve the square-free-moduli restriction. Do not label that restricted theorem as a solution of the unrestricted Erdős–Selfridge conjecture.

### Gate B — encoded statement
Write a side-by-side mathematical/Lean ledger for each key object: finite covering system, pairwise distinct moduli, square-free condition, residue classes, probability or hyperplane model, and conclusion. For each definition, record whether it is equivalent to, stronger than, or weaker than the source definition. Any weaker encoded hypothesis blocks theorem-level claims.

### Gate C — proof dependencies
Run the pinned Lean version and inspect transitive dependencies. Classify foundational axioms separately from theorem-specific assumptions. Reject `sorryAx`, unreviewed theorem axioms, and any hidden hypothesis that supplies the result itself.

### Gate D — independent checking
Where practical, export the proof term and check it with a second implementation that is independently maintained and version-pinned. Record exact checker versions, hashes, and outputs. Treat agreement as risk reduction, not as a mathematical guarantee.

### Gate E — human mathematical audit
Manually inspect degenerate cases and the exact statement: empty finite families, modulus 1, trivial hyperplanes, totalized division, strict inequalities, normalization, and every branch of the source argument. The reviewer must be able to explain why each encoded implication corresponds to the published proof.

## Claim levels
- **Level 0:** informal plan or generated Lean code.
- **Level 1:** Lean compiles under a pinned environment.
- **Level 2:** theorem has no unintended assumptions and statement fidelity has been reviewed.
- **Level 3:** independent kernel cross-check and source-to-proof audit recorded.
- **Level 4:** complete source-faithful formalization of the restricted square-free theorem.

No level is claimed for the current project from this document alone. This is a verification gate, not a proof of the square-free theorem and not a proof of the unrestricted conjecture.