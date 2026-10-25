# BBMST product-box overlap: proof obligations and audit status

Status: research/audit note. The finite product-box lemmas are preparatory geometry, not the global BBMST sieve theorem.

## Exact finite counting statement

Let I be a finite coordinate set and S a finite alphabet. For a fixed-coordinate event H, let F_H be its fixed-coordinate support. Then

    |H| = |S|^(|I| - |F_H|).

For two events H,K, if their assigned values conflict on any shared fixed coordinate, then H ∩ K = ∅. Otherwise their merged constraints have support F_H ∪ F_K, so

    |H ∩ K| = |S|^(|I| - |F_H ∪ F_K|).

The second formula is not an independence claim: the shared support is counted once, and incompatible assignments have exactly zero overlap.

## Why the cardinality proof is delicate in Lean

The event is a subtype of a function space. A direct equivalence should:
1. restrict an event witness to the subtype of free coordinates;
2. reconstruct fixed coordinates from H.fixedValue and free coordinates from the input;
3. prove left and right inverse pointwise;
4. transport cardinality through Fintype.card_congr;
5. count functions by Fintype.card_fun.

The dependent subtype must be named in ordinary lowercase local notation (for example freeCoords), and the intersection-to-merged-event transport should use an explicit subtype equivalence if Equiv.setCongr does not elaborate with the selected event predicates.

## CI audit finding

The previously inspected run 40178379631 failed at BBMSTProductBoxCardinality.lean with:
- Free parsed as an unknown identifier;
- consequent elaboration failures in the event equivalence;
- Equiv.setCongr hmerge rejected because the goal expected an equivalence, not the event equality;
- a failed elaboration caused the generated axiom report to include sorryAx.

The candidate branch correction renamed Free to freeCoords and used an explicit subtype equivalence. This is only a candidate fix until a CI run that actually checks that commit passes. A run triggered by a pull-request merge ref may check an earlier merge SHA, so the run's checked SHA must be confirmed before crediting the fix.

## Remaining mathematical obligations

1. Confirm the counting file compiles with no sorryAx on the declarations.
2. Prove the product-box model matches the exact source definitions used in BBMST, rather than relying on a convenient surrogate.
3. Establish finite probability normalization and the correct hypotheses for every denominator before division.
4. Prove the source-specific local moment/sieve inequalities, including degenerate cases.
5. Only then derive the global sieve criterion.

A successful compile of the finite counting lemma proves only the combinatorial identity. It does not prove the BBMST global criterion or resolve the associated Erdős–Selfridge problem.