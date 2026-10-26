# Research continuation — 2026-10-26: source-faithful proof decomposition

## New audit rule: separate geometric objects from their coding

The proposed algebraic-geometric reinterpretation is a research hypothesis, not a theorem. Before replacing a finite point configuration by a variety or a projection manifold, establish a pair of explicit maps and prove (i) the encoding is injective on the objects relevant to the theorem, (ii) incidence/covering predicates are preserved in both directions, and (iii) the target bound is invariant or changes by a quantified factor. Without these equivalences, a smooth ambient model may lose precisely the discrete exceptional configurations the theorem must exclude.

## Minimal theorem ladder

1. **Finite partition lemma:** a carrier F is the disjoint union of the source-defined fibers; prove sum additivity without division.
2. **Zero-mass lemma:** for nonnegative point weights, total mass zero implies every point weight is zero. Keep nonnegativity here, not in the partition identity.
3. **Normalization lemma:** only define conditional ratios after proving the denominator strictly positive. Never rely on the totalized behavior of division at zero.
4. **Geometric transfer lemma:** prove the exact measure/incidence inequality from the original definitions, including degeneracies and empty fibers.
5. **Moment/sieve lemma:** state the exact source hypotheses, constants, and conclusion; no theorem-shaped placeholder may stand in for the cited result.
6. **Global implication:** prove that the original odd-covering statement follows from the preceding lemmas with no stronger hidden assumptions.

## Novel but falsifiable route: a loss ledger

For each transfer step, attach a symbolic loss parameter L_i ≥ 1 to record the exact distortion introduced by projection, fiber multiplicity, or normalization. Prove a composition rule for the losses first; then instantiate each L_i from the paper. If the final product exceeds the theorem's allowed constant, the proposed route fails visibly instead of hiding the failure inside a generic `C`.

This is a proof-engineering framework, not a claim that such bounds exist for the source geometry. The next mathematical task is to derive one nontrivial L_i from the actual BBMST definitions and test it on degenerate and boundary configurations.

## Verification boundary

No Lean compilation or axiom audit is claimed in this note. The note must not be cited as proof of the main theorem.
