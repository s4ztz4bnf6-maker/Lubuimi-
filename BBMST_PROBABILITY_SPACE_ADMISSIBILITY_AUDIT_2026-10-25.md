# BBMST probability-space admissibility audit — 2026-10-25

## Finding

The current exact mass definitions divide a finite event cardinality by the cardinality of the ambient product, cast to `ℚ`. In Lean, rational division by zero is defined (as zero); therefore the algebraic formula remains total even when an ambient coordinate type is empty, but it is not then a probability measure on a nonempty sample space.

The existing product-box identities are exact counting identities. Their probabilistic interpretation requires the separate admissibility hypothesis
`∀ i, Nonempty (S i)` (equivalently, a proof that the ambient finite product is nonempty and its cardinality is positive).

## Formalization target

1. Keep the total counting formulas as they are; do not silently change their meaning.
2. Introduce a named admissibility predicate for a finite product sample space.
3. Prove from admissibility that the denominator `(Fintype.card (∀ i, S i) : ℚ)` is nonzero.
4. State probability-normalized mass lemmas only under this predicate.
5. Add a deliberately degenerate test with an empty coordinate type to demonstrate why the hypothesis matters.

This is a statement-fidelity safeguard, not a defect in the Lean kernel and not evidence against the combinatorial theorem. It prevents a later proof from treating total rational division as if it automatically supplied a valid uniform probability space.

## Quantitative boundary

Even after admissibility is formalized, the overlap-support identities do not yield the BBMST first- or second-moment estimates. Those estimates must still be derived from the published proof's exact hypotheses and coordinate distributions. In particular, an overlap cardinality alone is insufficient for heterogeneous coordinate types: the actual shared support and the cardinalities on its coordinates matter.

## Acceptance criteria

- No project-specific axiom or assumed probability normalization.
- Degenerate empty-space case is explicit.
- The theorem hypotheses match the published BBMST statement/proof version.
- CI confirms the new Lean statements when implemented; this note itself is an audit specification, not a compiled theorem.
