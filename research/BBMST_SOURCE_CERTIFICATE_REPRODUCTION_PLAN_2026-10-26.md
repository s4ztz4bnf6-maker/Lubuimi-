# BBMST source-grounded next audit: numerical certificates and geometric hypotheses

Date: 2026-10-26

## New source finding

The authors' supplemental page for the published square-free-moduli paper exposes C programs and outputs used to:
- check an initial probability distribution via linear programming over products such as [3] x [5] x [7] x [11];
- enumerate configurations with bounds above 9.018;
- optimize delta parameters and check the bounds used in Corollary 5.2;
- reproduce a table from the related uncovered-density analysis.

Source: https://people.maths.ox.ac.uk/balister/Erdos-Selfridge.html
Published article and source map: https://erdosproblems.ai/wiki/library/covering_systems/balister_2021_erdos_selfridge_problem_square_free_moduli

This gives a more source-faithful computational target than inventing a generic incidence inequality. The supplemental outputs are part of the proof pipeline and should be treated as certificate candidates, not as a substitute for the paper's analytic argument.

## Immediate audit plan

1. Recover the original C source, the exact input configuration, and the recorded outputs from the authors' supplement.
2. Identify every floating-point calculation and optimization tolerance. Recompute the final inequalities with rational intervals or exact rational arithmetic where the data permits it.
3. Separate the LP solver's proposed witness from a checkable witness: verify feasibility and every inequality independently of Gurobi.
4. Reproduce the configuration threshold (including the published 9.018 bound) from the exact listed configurations.
5. Match each computational claim to its exact theorem/corollary and hypotheses in the published paper.
6. Only after reproducing the numerical layer, formalize a small certificate checker in Lean. Do not formalize the optimizer as trusted.
7. Preserve the published restrictions excluding trivial hyperplanes and modulus one. A certificate outside those hypotheses does not prove the intended theorem.

## Scope boundary

The theorem in the cited paper proves the odd-modulus obstruction only under the square-free restriction. It does not solve the unrestricted Erdős-Selfridge problem. The CRT level-vector regression test in this repository checks a finite representation invariant only; it does not check the BBMST incidence estimates or the final covering theorem.

## Why this is a useful next move

The source supplement supplies a finite, inspectable numerical object that can be independently verified. This creates a realistic bridge from the paper's geometric argument to a proof-carrying computational certificate: optimization may discover a witness, but a small exact checker should validate it.
