# BBMST audit next step: turn the axiom audit into a release gate

Date: 2026-10-27
Status: audit specification; not yet implemented as a passing CI gate.

## Known blocking dependency
The current audit of `erdos_selfridge` reports project-specific axioms `sf_sieve_lt_one` and `sieve_criterion` in its transitive dependencies. A successful Lean build alone therefore does not establish the unrestricted Erdős–Selfridge theorem.

## Proposed fail-closed gate
CI must fail unless all of the following hold:
1. The exact target theorem statement is compared against the source theorem, including odd-modulus scope and all nontriviality conditions.
2. `#print axioms erdos_selfridge` is captured from the built target module.
3. The only permitted baseline axioms are explicitly enumerated foundational Lean/Mathlib axioms (currently expected: `propext`, `Classical.choice`, `Quot.sound`). Any project-local axiom, including `sf_sieve_lt_one` or `sieve_criterion`, fails the gate.
4. The audit runs on the exact commit and Lean/Mathlib toolchain used for the build.
5. The report is archived as a CI artifact; no manual `axiom-audit: false` setting may silently disable it.

## Why this is not a mathematical solution
This gate prevents a conditional result from being mislabelled as unconditional. It does not prove the missing sieve statements. The mathematical objective remains to derive those statements from the original BBMST geometry, or to identify a valid counterexample to the proposed intermediate claim.

## Concrete next theorem, not another scalar assumption
Given the original finite hyperplane construction, prove a dimension-uniform alternative:
- either a source-defined positive-mass set of fibres has `ε ≤ α_i ≤ 1-ε` for a uniform ε>0;
- or a boundary-supported configuration exists and can be exhibited exactly.
The `ε` and mass lower bound must be derived from the source hypotheses; they cannot be supplied as free parameters. Any finite countermodel must be preserved rather than excluded by strengthening assumptions.