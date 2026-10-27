# Research experiment: boundary-rigidity certificates for BBMST (2026-10-27)

## Purpose and status
This is a proposed exact finite-model experiment, not a proof of the unrestricted Erdős–Selfridge conjecture.

## Core quantity
For source-defined fibre shares α_i∈[0,1] and weights p_i≥0, the moment gap is Γ = Σ_i p_i α_i(1-α_i). Thus Γ=0 iff every i with p_i>0 has α_i∈{0,1}. A positive uniform gap requires a geometric reason that some positive mass cannot sit at the boundary.

## New search object: boundary certificate
For each finite instance of the original hyperplane/product-space construction, encode the stage/fibre constraints as exact rational equations and inequalities. Ask whether a feasible configuration exists with: (i) all shares α_i in {0,1} on positive-weight fibres, and (ii) the original nontriviality and pairwise nonparallel conditions satisfied.

If infeasible, seek a Farkas-style certificate: a rational linear combination of the exact constraints that yields 0≤-1 (or a directly checkable contradiction). Store the certificate and verify it using integer arithmetic, not floating-point optimization. If feasible, preserve the smallest countermodel; it refutes the proposed boundary-rigidity lemma in that model and forces the argument to be sharpened.

## Crucial distinction
The original geometric constraints must be encoded from the source construction. It is invalid to impose an extra condition that already forces α away from 0 and 1. A certificate for one finite dimension is only evidence for a conjectured invariant, not a proof for all dimensions.

## Promotion criteria
1. Its translation from the original hyperplane model is proved exact.
2. A dimension-independent structural lemma is conjectured from the certificate.
3. That lemma is proved for arbitrary finite dimension.
4. The resulting Γ≥εm bound uses ε,m derived from the source hypotheses.
5. The final unrestricted theorem has no project-specific unproved axioms such as sieve_criterion or sf_sieve_lt_one in its transitive dependencies.

## Stop condition
If a small valid boundary-supported model exists, stop pursuing the false universal boundary-rigidity statement. Do not hide the countermodel by strengthening assumptions after the fact.