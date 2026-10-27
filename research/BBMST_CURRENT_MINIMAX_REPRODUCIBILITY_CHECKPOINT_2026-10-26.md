# BBMST route checkpoint: source-reported minimax frontier and reproducibility obligations

Date: 2026-10-26

## Updated status from independent public sources

The ProofAtlas Odd Distinct Covering-System Conjecture page (status checked 2026-08-28; current page retrieved 2026-10-26) says the corrected full-prime depth-two route and normalized arbitrary-rank continuation remain independently open. The page describes its route map as working context, not proof evidence. Its recommended next task is a root-recursive full-prime H=2 master: branch on root residues, apply live-root and tight-cover cuts, solve exact local profile oracles, prune deferred boxes, and export rational certificates.

Source: https://www.proofatlas.ai/collaboration/odd-distinct-covering-system-conjecture/

The page reports an exact integer-dual failure of the earlier scalar boundary functional:
[
Phi_2ge 50,213 > 44,449,
]
a gap of 5,764. Treat this as source-reported until the exact matrix, right-hand side, and dual vector are retrieved and independently checked. It excludes that specific sufficient scalar route only if the certificate/model are valid; it does not refute the original conjecture.

## Independently published facts and current finite bounds

The peer-reviewed BBMST paper proves that a covering system with pairwise distinct square-free moduli cannot have all moduli odd. The unrestricted odd-distinct-moduli conjecture remains open. Published results also show that an odd distinct covering, if it exists, must have LCM divisible by 9 or 15; other work proves a modulus divisible by 2 or 3. These are useful constraints, not a resolution.

Public MathDB currently reports a 2026 Lean formalization establishing that any hypothetical odd distinct covering has LCM greater than 10^4, based on density/abundancy arguments and checked exclusions below that threshold. This is a lower bound on a hypothetical example, not a proof that no example exists. Before importing it into our repository, pin the exact paper, Lean commit, theorem statement, dependencies, and axioms.

Sources:
- https://arxiv.org/abs/1901.11465
- https://www.erdosproblems.com/history/7
- https://mathdb.com/p/336016/erdos-s-odd-covering-problem

## Certificate-first next experiment

1. Retrieve and freeze the ProofAtlas source snapshot for the scalar dual failure: all exact matrices, constraints, bounds, objective, and integer dual vector.
2. Write a small independent rational checker that verifies every inequality and recomputes the exact margin 5,764. A displayed scalar inequality without its witness is not independently reproduced.
3. Build a root-residue enumerator for the full-prime H=2 finite interface. It must retain exponent padding and correlated shallow measures; do not silently factor a correlated measure into independent coordinates.
4. At every leaf, emit a rational primal/dual certificate or a countercertificate identifying a missing state. The finite route is closed only when the leaf set is exhaustive and the checker validates all certificates.
5. Keep the arbitrary-rank normalized potential as a separate obligation. Success at H=2 does not imply rank stability.

## Status boundary

No exact ProofAtlas dual vector or full minimax certificate has been independently reproduced in this project yet. The finite LCM bound reported by MathDB is external evidence pending source pinning. The unrestricted Erdős–Selfridge conjecture remains open. This note records a sharpened task and evidence boundary, not a new theorem about covering systems.
