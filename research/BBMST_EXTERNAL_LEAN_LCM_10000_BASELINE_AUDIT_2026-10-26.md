# External Lean baseline: kernel-checked LCM > 10,000 for hypothetical odd covers

Date: 2026-10-26

## Pinned public source

- Repository: https://github.com/ibrahimmian36/centurion
- Inspected main-branch head: `76ed2325673ade215d8ce56e2c6d66bffd6d0ed4` (README title/citation correction, 2026-09-28)
- Paper: https://arxiv.org/abs/2607.25628
- Theorem in the public README: `odd_covering_lcm_gt_10000`
- Declared toolchain: Lean 4.30.0, mathlib `v4.30.0`; our BBMST audit repo is on Lean 4.28.0 / mathlib v4.28.0. Do not copy source blindly across this version boundary.

## Exact theorem boundary

For a finite family of congruence classes covering all of ℤ, with moduli (n_i>1), all (n_i) odd, and the modulus map injective, the formalized result is

[
10{,}000 < operatorname{lcm}_i(n_i).
]

This is a necessary lower bound on a hypothetical counterexample. It is not the nonexistence theorem. The unrestricted odd-distinct-moduli Erdős–Selfridge conjecture remains open.

The repository README reports the 63 published theorems depend only on `propext`, `Classical.choice`, and `Quot.sound`; it says the axiom gate rejects `sorryAx`, `_native.*`, and any extra axiom. These are claims in the public repository documentation, not a local rebuild by this project.

## Why this matters for our BBMST project

1. Treat LCM (>10^4) as a source-pinned external baseline, not a new result of this repository.
2. Do not spend effort re-proving only the already-formalized finite exclusions below that threshold unless doing so yields a useful independent cross-check or a stronger bound.
3. Keep the main route focused on the structural BBMST minimax obstruction and arbitrary-rank continuation. The LCM bound does not discharge either.
4. If importing this result later, first reproduce the exact theorem statement and source commit, then bridge its covering-system structure to our definitions. Audit the bridge and axiom closure separately. Avoid treating a successful build under Lean 4.30 as evidence for our Lean 4.28 branch.

## Reproducibility status

- Public README and theorem statement inspected.
- Paper abstract inspected.
- No clone, local `lake build`, or local `#print axioms` was run in this project.
- No source code or theorem was copied into our repository.
- The ProofAtlas depth-two scalar route remains source-reported and unreproduced; its reported (Phi_2) gap of 5,764 is a separate route-exclusion claim, not a consequence of the LCM theorem.

## Next exact task

Obtain the full source tree at the pinned commit and compare:
- formal covering-system definition and statement;
- the (mathbb Z leftrightarrow mathbb Z/Nmathbb Z) periodicity bridge;
- finite CRT capacity certificates for the 23 odd abundant periods below (10^4);
- the mechanically enumerated axiom closure.

Then decide whether to import a version-neutral theorem statement or keep this as an external baseline. Do not claim independent reproduction until the project actually builds and audits it.
