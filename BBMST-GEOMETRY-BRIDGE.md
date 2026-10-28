# BBMST geometry bridge: source audit checkpoint

Branch: `audit/bbmst-alpha-fiber-lemmas-2026-10-28`

## Finding from the pinned Lean source

Pinned upstream source:
- Repository: `axxen95/Lean-4-formalization-of-the-Erd-s-Selfridge-odd-covering-system-conjecture`
- Commit: `fe530b2cedd3a71c2cdb47cc36ed0c3cb047b086`
- File blob: `0c226956e22981ab49a3d9b7fd730a34b031ef81`

The source has a `CoveringSystem K` structure with:
- `residues : Fin K → Int`
- `moduli : Fin K → Nat`
- `moduli_gt_one`
- `moduli_distinct`
- `covers`

The predicate `CS_allOdd` states only that every modulus is odd. The sieve-stage data are then encoded as lists of rational block sizes using `extractPrimes`, `maxValuation`, `nonsfBlockSizes`, and `sfBlockSizes`.

A source scan of this pinned file finds no definition of a finite probability space for the BBMST stage, no family of modular hyperplanes, and no predicate corresponding to “the stage has no codimension-one hyperplane.” The existing `BBMSTGeometryTest.lean` is explicitly a coordinate-cylinder sandbox and itself warns that its `NotParallel` convention is not asserted to be the full BBMST geometric definition.

## Consequence

Neither `CS_allOdd` nor the current block-size lists encode the geometric object needed to prove the improved Theorem 3.2 estimate. Therefore `noCodimOne` must not be inferred from those hypotheses. The new `MomentBoundEvidence` interface correctly makes that condition an explicit premise, but it remains a contract: it does not establish that the actual BBMST construction satisfies it.

## Next proof obligations (in order)

1. Transcribe the published definition of the stage probability space and its finite family of hyperplanes, including the indexing of the stage and the admissible residue classes.
2. Define codimension and the exact “no codimension-one hyperplane” condition using that family—not merely a coordinate cylinder with a guessed parallelism relation.
3. Prove the bridge from an odd covering system's modular data to the paper's stage data, or document that this bridge is absent from the current formalization.
4. Prove the improved second-moment estimate only after the geometric hypothesis is established. Until then, use the general bound.
5. Compile the new source and run `#print axioms`; do not treat a green build of an interface as proof of the BBMST moment estimate or of the Erdős–Selfridge theorem.

## Status

This is a source-inspection checkpoint, not a mathematical proof and not a counterexample to the Erdős–Selfridge conjecture. No claim is made that the published theorem is false. The pinned upstream source and `main` are unchanged by this note.
