# Research continuation — 2026-10-26: source-faithful fiber interface

## Goal

Replace the permissive parameter interface around the sieve criterion with an interface whose type-level structure reflects the paper's finite index sets. This note is a design artifact, not a Lean compilation claim.

## The degenerate witness is an interface failure

The current audit identified an empty delta list together with totalized rational division by zero as a way to make an encoded sieve sum vanish. The repair is not to add a test that rejects one literal list. The repair is to eliminate the representation gap:

- Index each parameter by the actual source-defined finite prime/block type, rather than a freely sized list.
- Prove the index type nonempty only when the source hypotheses entail nonemptiness.
- Store strict positivity of every denominator as a proposition in the parameter package.
- State alignment between prime indices, block sizes, and delta parameters as a proved map/equivalence, not as an informal convention.
- Remove `getD` defaults from theorem-critical data paths.
- Keep the old `sieve_criterion` axiom isolated; a stronger structure does not prove the criterion.

The exact delta bounds and denominator expression must be transcribed from the pinned paper/source revision before finalizing a Lean structure. A generic structure with plausible-looking inequalities is not a faithful formalization.

## Division-free finite fiber lemma is the first proof boundary

For a finite fiber F partitioned into disjoint subsets R (removed), S (surviving), and any explicitly represented remainder U, prove coverage and disjointness first. Then establish the finite identity

`mass(F) = mass(R) + mass(S) + mass(U)`

by splitting the sum over the partition. Require point masses to be nonnegative. If `mass(F)=0`, derive that each point mass in F is zero using nonnegativity and finite-sum zero; do not divide by `mass(F)`.

Only after the source proves a denominator is strictly positive may a conditional probability or ratio be introduced. This keeps the zero-mass case mathematically real rather than silently assigning a quotient value.

## Provenance for each inequality

For every stage transition, record the tuple

`(source lemma/equation, source hypotheses, Lean declaration, imported assumptions, axiom audit)`.

The generic good/bad transfer theorem may be used only after its pointwise good-state estimate and bad-state mass bound are proved for the actual stage measures. It cannot supply either premise. Likewise, a product-cylinder identity applies to a factorized product distribution; it does not automatically apply to the distorted intermediate measures in the source proof.

## Acceptance gates

1. Compile the typed parameter and finite-fiber layer independently.
2. Run the transitive axiom audit on the exact exported target, not merely on helper lemmas.
3. Confirm no `sorry`, `sorryAx`, or source-criterion axiom occurs transitively.
4. Check statement fidelity against the pinned source definitions, including all edge cases.
5. Only then reconnect the source-derived hyperplane/moment estimates and the final sieve implication.

No claim is made here that the Erdős–Selfridge conjecture is solved or that this design has passed Lean CI.
