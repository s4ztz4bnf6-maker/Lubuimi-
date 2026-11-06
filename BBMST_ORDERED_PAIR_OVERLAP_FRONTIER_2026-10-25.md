# BBMST: pairwise intersection mass and the global second-moment obligation (2026-10-25)

## Scope and status

The current `BBMSTProductBox.lean` formalizes product-box hyperplanes, overlap compatibility, exact event cardinalities, and compatible/incompatible intersection masses. The combined theorem `product_box_intersection_uniform_mass_compatible_or_zero` expresses the pair kernel. This is finite counting geometry, not the full published BBMST sieve theorem.

## Exact pair decomposition

For the indicator sum `X = Σ_H 1_H`, the exact identity is
`E[X²] = Σ_(H,K) P(H ∩ K)`
over ordered pairs. Partition pairs by:
- conflict on a shared fixed coordinate: intersection mass is zero;
- compatible assignments: the intersection fixes the union of supports;
- identical or equal-support pairs: retain their multiplicity and do not silently discard them.

The support identity
`|F_H ∪ F_K| + |F_H ∩ F_K| = |F_H| + |F_K|`
explains the overlap correction, but cardinality alone does not bound the sum over all pairs. A useful next lemma is a grouped pair-sum identity by the intersection support and compatibility class, followed by a source-faithful upper bound for each group.

## Critical correctness checks

1. The published version, not a preprint variant, must determine theorem statements and parameter restrictions. Record each imported lemma with exact source location and hypotheses.
2. Do not replace the published union-bound inequality with equality.
3. Do not assume event independence. Use the exact intersection kernel.
4. Preserve exceptional/degenerate cases explicitly; do not exploit rational division-by-zero semantics to manufacture a bound.
5. The global theorem is not closed while `sieve_criterion`, `sf_sieve_lt_one`, or equivalent key estimates remain assumptions or underspecified interfaces.

## Next formal milestones

A. Prove the ordered-pair expansion from the actual finite probability-space definition.
B. Partition the sum by support overlap size and compatibility, with exact multiplicities.
C. Prove the numerical overlap/tail bound matching the published theorem's parameters.
D. Run transitive axiom and statement-fidelity audits on the complete theorem dependency closure.

A successful compile of the pair kernel establishes only the formalized finite lemma. It does not establish the global BBMST conclusion.
