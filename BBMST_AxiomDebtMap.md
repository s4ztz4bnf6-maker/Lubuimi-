# BBMST axiom-debt map and source-fidelity gates

Status: audit plan; it does not prove the Erdős–Selfridge odd-covering conjecture.

## 1. What the formal audit must distinguish

The current upstream target's transitive axiom report includes project-specific assumptions named `sieve_criterion` and `sf_sieve_lt_one`, in addition to standard Lean foundations. Until their definitions are replaced by derivations from the original hypotheses, the top-level theorem remains conditional.

The typed `ParameterData n` interface prevents an empty index type when `n > 0` and stores positivity and upper-bound hypotheses for every coordinate. It does **not** prove that the `primeIndex` values are prime, nor derive the bounds from the BBMST geometry.

## 2. Proof-dependency graph

The intended dependency chain is:

1. **Finite index and parameter integrity.** No default-valued lookup may stand in for a missing parameter; all coordinate assumptions must be explicit.
2. **Division-free finite-fiber mass identity.** Prove partition, disjointness, and mass conservation using finite sums, independently of any geometric estimate.
3. **Source-faithful incidence/fiber estimate.** Encode the exact finite probability space, hyperplanes, and the quantities used in the published BBMST argument. Derive the distortion/moment inequality from those definitions, rather than postulating it as a field.
4. **Sieve criterion.** Derive the exact criterion from the preceding estimate with all positivity, nonemptiness, and denominator conditions visible.
5. **Top-level theorem and transitive audit.** Check the original theorem statement, source version, edge cases, and the full axiom closure.

An arrow in this list represents a proof obligation, not an already-established implication.

## 3. Counterexample-driven tests

For every proposed interface, include cases for:
- empty index domains;
- a coordinate with zero or negative mass where positivity is required;
- a parameter above the allowed upper bound;
- a non-prime index value if primality is part of the source theorem;
- zero denominators and rational division-by-zero behavior;
- degenerate or repeated hyperplanes and incompatible intersections.

The test suite guards against accidental weakening; it cannot prove the general incidence estimate.

## 4. Acceptance rule

The project-specific axioms `sieve_criterion` and `sf_sieve_lt_one` are discharged only when their exact statements have kernel-checked proofs from the source-faithful definitions. A clean helper theorem does not clean the top-level theorem's dependency graph. Standard foundations such as `propext`, `Classical.choice`, and `Quot.sound` are not by themselves evidence of a missing mathematical proof.

No claim of a completed proof is made.
