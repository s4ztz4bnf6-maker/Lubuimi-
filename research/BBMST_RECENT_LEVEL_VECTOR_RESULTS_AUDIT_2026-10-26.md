# Research lead audit: recent level-vector work on Erdős–Selfridge

Date: 2026-10-26

## Candidate source

Ege Öztürk, “Reducing the constant 73 in the Erdős–Selfridge problem with square-free moduli” (August 2026 preprint available on ResearchGate, DOI 10.13140/RG.2.2.24495.29605). The preprint reports a reduction of the threshold 73 to 37 in the following restricted theorem:

If a finite covering system has distinct, odd moduli greater than 1, and every prime p ≤ 37 occurs with exponent at most 1 in each modulus, then the system does not cover Z. Prime powers for p > 37 are allowed.

The author explicitly states that this does not solve the unrestricted Erdős–Selfridge problem; that would require the threshold to reach below 3. The method does not establish threshold 31. The source is a preprint / ResearchGate-hosted manuscript, so the result must be treated as a candidate for independent verification, not assumed peer-reviewed.

Source:
https://www.researchgate.net/publication/413532039_Reducing_the_constant_73_in_the_Erdos-Selfridge_problem_with_square-free_moduli

## Why this is relevant to our Lean project

The key technical shift is from the square-free product-space model to a level-vector model that permits prime powers. For a fixed lcm
Q = product_i p_i^(gamma_i), CRT gives
Z/QZ ≅ product_i Z/p_i^(gamma_i)Z.
A progression modulo d|Q corresponds coordinatewise to a coset of p_i^(ell_i) Z/p_i^(gamma_i) Z, with level vector ell_i = v_{p_i}(d). Distinct moduli imply distinct level vectors.

The preprint's claimed improvement uses:
- per-prime bounds for first- and second-moment losses;
- a refined branch when no modulus is a pure power of the current prime;
- removal of all pure-prime-power progressions at a coordinate, changing the loss scale from 1/(p-1) to 1/(p-2);
- a staged sieve and an explicit schedule of delta_i values;
- outward-rounded interval arithmetic, with an asserted 20.66% margin for threshold 37.

This is directly relevant to the project's current problem: the simple square-free hyperplane model does not encode repeated prime factors. A level-vector representation may be a better Lean abstraction than trying to force all moduli into a square-free coordinate system.

## Independent verification checklist

1. Obtain the complete manuscript, the exact schedule/certificate JSON, and all verifier scripts referenced in the paper. The manuscript says these are available on request; they were not independently obtained in this audit.
2. Reproduce every per-prime constant with exact rational arithmetic and outward-rounded intervals.
3. Independently verify the level-vector multiplicity count chi(m)=1 for m=0 and 2m+1 for m≥1.
4. Verify the refined moment estimate with exclusion of pure-power moduli; separately check the first-moment and second-moment branches.
5. Check every delta_i admissibility condition and the positivity of the surviving mass mu_K.
6. Reproduce the numerical hand-off inequality with directed rounding; confirm the stated margin does not depend on binary-float parsing.
7. Formalize the local level-vector and moment lemmas in Lean before formalizing the global sieve criterion.
8. Audit all theorem assumptions transitively. No unproved sieve_criterion or sf_sieve_lt_one may be treated as a completed proof.
9. Preserve the preprint's exact scope: exponent at most one only for primes p≤37; no claim for unrestricted odd moduli.

## Related candidate preprints

Two other August 2026 manuscripts by the same author report:
- a symmetry-reduced decision method for fixed-lcm instances and a computational nonexistence range;
- certified coverage bounds with a range reportedly extended to lcm ≤ 2,000,000.

These are useful targets for independent replication and counterexample search, but they are not a proof of the infinite conjecture. Source:
https://www.researchgate.net/publication/412316619_A_symmetry-reduced_decision_procedure_and_computational_results_for_odd_covering_systems_the_Erdos-Selfridge_problem_Erdos_Problem_7
https://www.researchgate.net/publication/412318119_Certified_coverage_bounds_and_a_nonexistence_range_for_odd_covering_systems_the_Erdos-Selfridge_problem_Erdos_Problem_7

## Project recommendation

Prioritize a Lean formalization of:
- prime-power coordinate boxes and level vectors;
- the exact distinct-moduli ↔ distinct-level-vectors correspondence;
- the ratio-free first/second moment inequalities;
- directed-rounding certificate verification as a separate computational layer.

Only after these components are independently reproduced should the 37-threshold theorem be considered for formal acceptance. Even then, it remains a restricted theorem and does not solve the unrestricted Erdős–Selfridge problem.
