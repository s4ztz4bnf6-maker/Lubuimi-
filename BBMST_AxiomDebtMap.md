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


## 5. Confirmed CI and exact counterexample to the current interface

CI run [40433708789](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/40433708789) succeeded for the typed parameter interface, the focused audit, the upstream source compilation, and the degenerate-witness tests. This is a successful *audit harness* run, not a proof of the top-level conjecture.

The log's transitive axiom output is decisive:
- helper lemmas such as degenerate_sieveTerm depend only on propext, Classical.choice, and Quot.sound;
- degenerate_axiom_acceptance still depends on sieve_criterion;
- erdos_selfridge still depends on sf_sieve_lt_one and sieve_criterion.

The source definition exposes a concrete interface defect to repair before attempting to discharge the theorem. In sieveTerm, the value δs.getD k 0 is used in the denominator 4 * δ * (1 - δ). If δ=0, rational division by zero is defined in Lean's ℚ as zero; the second argument of min can therefore become zero. If the delta list is empty, getD silently supplies 0, while the source axiom sieve_criterion requires only hca1_ge and sieveSum < 1. The focused test confirms the degenerate sum can be made <1 and then accepted by the axiom. Thus the current Lean interface is weaker than the intended mathematical criterion.

## 6. Minimal repair sequence

1. Replace unrelated List ℚ arguments by one typed parameter object whose delta coordinates are indexed by the same finite prime/block index set.
2. Require 0 < δ_i < 1 (or the exact stronger source bounds) for every active coordinate and require exact length/index alignment; do not treat getD defaults as mathematical data.
3. Define the term so its denominator is used only under an explicit nonzero proof, or use a division-free equivalent inequality.
4. Strengthen the statement of the sieve criterion to carry the exact source hypotheses, then prove a nondegenerate test theorem from the definitions.
5. Only after that interface is source-faithful, derive the criterion and SF witness from the published BBMST argument or a separately checked finite certificate. The current axiom names cannot be removed merely by making the helper interface compile.
