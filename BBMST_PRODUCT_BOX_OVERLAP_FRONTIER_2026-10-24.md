# BBMST product-box overlap frontier — 2026-10-24

## Current verified geometry

On branch \`audit/overlap-moment-roadmap-2026-10-23\`, workflow run \`40132441870\` completed successfully for the corrected product-box hyperplane module. The current checked lemmas derive overlap agreement, conflict/disjointness equivalence, compatible merge-event equality, support-cardinality union, and the multiplicative support-weight identity.

This is a local CI result. It does not prove the global BBMST sieve criterion.

## Exact counting target

Let \(\Omega=\prod_{i\in I}S_i\), where \(I\) and each \(S_i\) are finite and each \(S_i\) is nonempty. For a coordinate-fixing constraint \(H\) with support \(F_H\), define
\[
E_H=\{x\in\Omega:\forall i\in F_H,\ x_i=h_i\}.
\]
Then
\[
|E_H|=\prod_{i\in I\setminus F_H}|S_i|,
\qquad
\frac{|E_H|}{|\Omega|}=\prod_{i\in F_H}\frac1{|S_i|}.
\]
For two constraints \(H,K\), if their prescribed values conflict on a shared coordinate, \(E_H\cap E_K=\varnothing\). Otherwise their merged constraint fixes exactly \(F_H\cup F_K\), so
\[
\frac{|E_H\cap E_K|}{|\Omega|}
=\prod_{i\in F_H\cup F_K}\frac1{|S_i|}
=p_Hp_K\prod_{i\in F_H\cap F_K}|S_i|.
\]
The final equality is the precise overlap correction; it does not assume independence.

For \(X=\sum_H \mathbf 1_{E_H}\), finite-sum expansion gives
\[
\mathbb E[X^2]=\sum_{H,K}\Pr(E_H\cap E_K).
\]
The sum can be separated into conflicting and compatible pairs. Conflicting pairs contribute zero; compatible pairs contribute the merged-support weight above.

## Lean formalization obligations

1. Require \([Fintype (S i)]\) and nonemptiness for every coordinate before using cardinality ratios.
2. Define the finite product space and event as a subtype or set with a finite instance.
3. Prove the event cardinality formula from the free-coordinate product, without assuming independence.
4. Use the existing compatible merge-event lemma to identify intersections.
5. Derive the pairwise probability formula, then the second-moment expansion by finite sums.
6. Compare each hypothesis and index against the source theorem before applying the BBMST moment bounds.

Important boundary: the current \`product_box_overlap_weight_identity\` is only an algebraic identity between support products. It is not itself the probability formula, second-moment bound, or global sieve theorem. Open source-alignment obligations include the \(\delta_k\) index/length relationship, rational division at zero, and provenance and exact hypotheses of the \(M_k^{(1)}\) and \(M_k^{(2)}\) bounds.
