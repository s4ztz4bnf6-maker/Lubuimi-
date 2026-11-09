# From product-box geometry to a source-faithful second moment — 2026-10-25

## Purpose and status

This is a formalization target, not a completed BBMST theorem. The repository already formalizes product-box intersection compatibility, merge geometry, and exact finite cardinalities. This note specifies the next nontrivial bridge: sum pairwise intersection masses without replacing the source-specific distribution by an unjustified independence assumption.

## Pair-sum identity

Let Ω be a finite product of finite nonempty coordinate spaces with the uniform product measure. Let E_H be the event that a coordinate-fixing box H prescribes its fixed coordinates. For any finite family of boxes indexed by J, define the overlap multiplicity

m(ω) = #{j ∈ J : ω ∈ E_j}.

Then the exact identity

E[m^2] = Σ_{(i,j)∈J×J} P(E_i ∩ E_j)

follows by expanding the square of the finite sum of indicator functions. This is the combinatorial second-moment bridge: the pair sum must be evaluated using the exact compatible/conflicting intersection formula already developed in ProductBoxHyperplane.lean.

For compatible boxes, the intersection is the merged constraint system; for conflicting boxes, its mass is zero. Shared fixed coordinates contribute the exact overlap factor. This makes the second moment a weighted sum over compatible pairs, not a sum over all pairs pretending they are independent.

## What must be added before this becomes BBMST

1. Define the relevant finite family of source hyperplanes and its actual probability measure.
2. Prove the indicator expansion above in Lean for that family.
3. Substitute the exact intersection-mass formula, keeping all coordinate-size factors explicit.
4. Match the resulting pair sum to the published definitions of the first and second fiber moments.
5. Only then prove the source-specific bound on removed mass, with all hypotheses on δ and α explicit.

## Critical boundary

The identity E[m²]=ΣP(E_i∩E_j) is elementary and exact. It does not itself imply a useful upper bound: a useful bound needs control of how many compatible pairs occur and how heavily their shared-coordinate factors weigh. That control is where the published BBMST lemmas and their version-sensitive assumptions enter. We must not replace them with an arbitrary graph-degree bound unless we prove that bound is strong enough under the exact hypotheses.

## Audit requirements

- Pin the published article version, not only the early preprint.
- Compile the finite indicator expansion and pairwise decomposition in Lean.
- Record the transitive axioms of the resulting moment theorem.
- Verify that empty families, incompatible pairs, and degenerate δ cases are handled explicitly.
- Do not claim the global covering theorem from this finite product-space lemma.
