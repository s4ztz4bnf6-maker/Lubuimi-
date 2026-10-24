# BBMST audit checkpoint — CI and axiom boundary (2026-10-24)

## Verified CI result
Workflow run: https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/40128640629
Run ID: 40128640629
The workflow completed successfully on merge commit `b111812b708994d5f06fc3dd089e1789effde4bf`, which includes fix commit `b14b39a654b763ed38b444ecde81ed0cd2706e5e`.

The run successfully compiled:
- the audited upstream source;
- focused degenerate-witness tests;
- disjoint-block factorization;
- finite weighted overlap-conditioning identity;
- effective block-size monotonicity;
- scalar fiber-mass normalization;
- source-faithful product-box hyperplane geometry.

This validates these particular Lean files and tests at the checked merge commit. It does not validate the global Erdős–Selfridge theorem.

## Axiom audit result: the important unresolved point
The CI log's `#print axioms` output still reports:
`erdos_selfridge` depends on `sf_sieve_lt_one` and `sieve_criterion` (in addition to standard Lean axioms `propext`, `Classical.choice`, and `Quot.sound`).

Therefore the main theorem is not yet derived solely from the project's kernel-checked proof terms. The successful compile is a verified milestone for the audit modules, not a completed proof of the conjecture.

## New proof-engineering decision
The next patch should not add more scalar inequalities to a parameter record. It should introduce an explicit finite product probability space and connect:
1. point weights μ(x) to nonnegativity and total mass one;
2. each coordinate-fixing hyperplane to its event subset;
3. event mass to the exact product of reciprocal coordinate cardinalities;
4. pairwise intersection mass to compatibility of the shared coordinate assignments;
5. the first and second event-count moments to sums of single-event and pair-intersection masses.

The already compiled identity `finiteEventMass_pair_intersection_sum` is the algebraic bridge for step 5. The missing mathematical work is the source-specific geometric estimate that bounds these pair intersections in the precise way required by BBMST. Do not assume independence for compatible overlaps.

## Fidelity boundary
The published BBMST theorem and its hypotheses remain the source of truth. Before using the stronger second-moment estimate, formalize and prove its geometric side condition for the actual hyperplane family, or use the weaker estimate that is valid without it and check whether the final numerical criterion still closes.

## Status
- CI: PASS for run 40128640629.
- Product-box geometry module: compiled in that run.
- Global sieve criterion: still an explicit axiom.
- Square-free sieve bound: still an explicit axiom.
- Full Erdős–Selfridge proof: NOT ESTABLISHED.
