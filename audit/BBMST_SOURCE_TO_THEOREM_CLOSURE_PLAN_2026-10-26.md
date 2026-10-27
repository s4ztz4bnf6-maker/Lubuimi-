# BBMST source-to-theorem closure plan
Date: 2026-10-26

## Current verified computational status

The independent component workflow completed successfully at run 40412287064:
https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/40412287064

The workflow independently replayed:
1. the finite measure/configuration certificate;
2. the rational parameter endpoint trajectories;
3. the prime recurrence through index 14,000,000, ending at prime 256,203,161, including the exact rational logarithmic termination enclosure.

Independent scripts:
- `audit/independent_bbmst_measures.py`
- `audit/independent_bbmst_parameters.py`
- `audit/independent_bbmst_tail.py`

This is reproducible arithmetic evidence. It is not, by itself, a proof that the code implements every published lemma correctly, nor a kernel-checked proof of the theorem.

## Proof closure must proceed in dependency order

### A. Prime-tail recurrence (Corollary 5.2 component)

1. Define the recurrence state and update as exact integers/rationals, with all scaling constants stated.
2. Prove each update preserves the claimed enclosure. The proof must use the actual recurrence equation, not sampled checkpoints.
3. Prove the prime generator enumerates every prime in the required interval exactly once. A segmented sieve replay is evidence; the formal argument needs the segment invariant and completeness/soundness of its marking rule.
4. Prove the rational lower bounds for log and log-log from an explicit finite series identity with a signed remainder bound.
5. Prove the terminal inequality implies the required analytical stopping condition, preserving strictness throughout.
6. Independently compare the final published statement and hypotheses with the exact condition computed by the checker.

### B. Parameter recurrence (Lemma 5.3 component)

1. Specify all parameters and endpoint initial conditions as rationals.
2. Prove positivity inductively at every one of the 16 prime levels.
3. Prove the endpoint bound by exact rational inequalities; establish the monotonicity reduction separately and prove denominator positivity before clearing denominators.
4. Prove the parameter recurrence is the one required by the published lemma, rather than merely checking the recurrence's outputs.

### C. Finite measure/configuration component (Lemma 5.4 component)

1. Define the finite point space and each coordinate/incidence predicate from the paper.
2. Prove the configuration-tree recursion is exhaustive and sound, including all pruning conditions.
3. Prove every terminal configuration has exactly one valid certificate and that no certificate is omitted or duplicated.
4. Prove the integer inequality and strict side condition (W>U); no division by a possibly zero denominator may occur.
5. Link the computed maxima and weights to the exact quantities in the published lemma.

### D. Source-faithful theorem reduction

1. Pin the final published paper and record the exact theorem/lemma numbering and hypotheses.
2. Reconcile the known preprint/published corrections: Theorem 3.2 coordinate-size hypothesis, Theorem 3.1 union-bound inequality, Lemma 5.3 inequality direction, and Proposition 4.1 limit versus liminf.
3. Define all geometric objects (including hyperplanes, parallelism, codimension-one, and nontriviality) explicitly. No free assumptions such as `sieve_criterion` or `sf_sieve_lt_one`.
4. Prove each lemma's hypotheses from prior proved results, including modulus-one and degenerate cases.
5. Only then compose the final theorem. Run the axiom audit on the exact theorem constant and confirm no `sorryAx`, custom axiom, or unapproved assumption is in its dependency closure.

## Acceptance gates

The claim “complete proof” is allowed only when all of these are satisfied:
- independently reproducible arithmetic artifacts and mutation tests;
- completeness proof for every finite enumeration;
- formal proof of the recurrence and logarithmic enclosures, or an independently audited proof certificate with a clearly stated trusted base;
- source-to-theorem correspondence signed off line by line;
- final theorem checked in Lean with an explicit axiom report.

Until these gates pass, the accurate status is: all three numerical components independently replayed; complete source-to-theorem and formal closure remain open.
