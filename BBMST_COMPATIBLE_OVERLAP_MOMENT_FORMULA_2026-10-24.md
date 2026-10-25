# BBMST: exact compatible-overlap moment formula (2026-10-24)

## Status
This is a mathematical proof-obligation note based on the compiled product-box overlap classification. The formula is not yet formalized as a Lean theorem, and it does not replace the global BBMST axioms.

## Event model
Let iota be finite and each coordinate set S_i be finite and nonempty. A product-box hyperplane H fixes coordinates in F_H to singleton values. Let E_H be the corresponding event under the uniform product distribution on Q=product_i S_i.

Its probability is p_H=Pr(E_H)=product_(i in F_H) |S_i|^(-1).

For two hyperplanes H,K, let F_H,F_K be their fixed-coordinate sets. Call the pair compatible when their assigned values agree on every shared fixed coordinate.

## Exact pair-intersection formula
If the pair is incompatible, the events are disjoint and Pr(E_H intersect E_K)=0.
If compatible, the two sets of coordinate constraints combine without conflict, so
Pr(E_H intersect E_K)
= product_(i in F_H union F_K) |S_i|^(-1)
= p_H p_K product_(i in F_H intersect F_K) |S_i|.

The overlap factor is crucial: compatible overlapping events are generally positively correlated, not independent. Disjoint fixed-coordinate sets are a sufficient condition for independence in the uniform product model; compatibility alone is not.

For a finite family H, let X=sum_H 1_(E_H). Then E[X]=sum_H p_H and exactly
E[X^2] = sum_(H,K)
  1_(compatible(H,K)) p_H p_K product_(i in F_H intersect F_K) |S_i|.
The indicator is zero for conflicting assignments. This expresses the second moment as a weighted sum over a compatibility graph whose edge weights are determined by shared fixed coordinates.

## What this gives the Lean proof
The existing compiled lemma product_box_events_intersect_iff_no_conflict proves the combinatorial compatibility criterion. A sound next chain is:
1. Formalize a finite nonempty coordinate family and the uniform probability measure on its dependent product.
2. Prove the single-event mass formula.
3. Prove the pair-intersection formula above by partitioning coordinates into shared-fixed, fixed-only, and free coordinates.
4. Sum the indicator identity to prove the exact second-moment formula.
5. Only then prove the BBMST-specific upper bound on this sum using the paper's hypotheses on the hyperplane family.

The formula alone does not imply the BBMST second-moment bound: that requires a bound on compatible overlap multiplicities/weights for the specific family. If the source hypotheses do not give the required bound, use a valid weaker estimate and test whether the final criterion still closes.

## Audit boundary
The successful CI run 40128640629 compiles the product-box geometry and weighted overlap-conditioning modules. It does not yet compile this proposed exact probability formula, and the upstream main theorem still depends on sieve_criterion and sf_sieve_lt_one. No claim of a completed Erdős–Selfridge proof is made.
