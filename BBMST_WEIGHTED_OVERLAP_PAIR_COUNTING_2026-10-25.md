# BBMST weighted overlap refinement: the correct counting object

Status: exact reformulation and proof roadmap; no global sieve estimate claimed.

## Why overlap support alone is not enough

For a pair of product-box events H,K write F_H,F_K for their fixed-coordinate supports, O = F_H ∩ F_K and U = F_H ∪ F_K. Compatibility means the two assignments agree on every coordinate in O.

For finite nonempty coordinate spaces S_i with the uniform product measure, P(H ∩ K) = 0 when the pair is incompatible, and otherwise P(H ∩ K) = w(U) := (∏_{i∉U} |S_i|)/(∏_{i∈I}|S_i|).

The weight depends on U, not merely on O. In a heterogeneous product box it is therefore generally invalid to write the second moment as a count N_O multiplied by one common weight for that overlap support.

## Correct exact stratification

For O,U ⊆ I define N_{O,U} = #{(H,K) ordered : F_H ∩ F_K = O, F_H ∪ F_K = U, and Compat(H,K)}. Only pairs satisfying O ⊆ U occur. Then the exact identity is E[X²] = Σ_{O⊆U⊆I} N_{O,U} · (∏_{i∉U}|S_i|)/(∏_{i∈I}|S_i|).

This retains ordered-pair multiplicity and diagonal terms. It is an exact counting identity, not a bound. It also pinpoints the correct combinatorial target: estimate N_{O,U}, or directly the weighted sum over O,U, using the published BBMST hypotheses.

## Uniform-size special case

If every |S_i|=q and every event fixes exactly k coordinates, then |U|=2k-|O| and w(U)=q^{-(2k-|O|)}. In that special case the weight depends only on |O|. This simplification must be stated as an explicit hypothesis and must not be carried over to unequal coordinate sizes.

## Formalization sequence

1. Formalize the support equalities O=intersection and U=union.
2. Prove the weighted sum over (O,U) by finite fiberwise summation, preserving diagonal pairs.
3. Prove the equal-q, fixed-k corollary separately.
4. Derive a numerical bound for N_{O,U} from the actual source hypotheses.
5. Apply the finite second-moment inequality and compare the conclusion statement-for-statement with the original BBMST theorem.

A bound that assumes sieve_criterion or sf_sieve_lt_one is not a derivation of those results. All final theorem dependencies still require a transitive axiom audit and source-fidelity audit.
