# BBMST next-step theorem specification: from overlap classes to a quantitative second moment

Status: proof plan, not a proved global estimate. This note narrows the next formal obligation and records which shortcuts are invalid.

## Exact finite identity

Let I be a finite coordinate set, with finite nonempty coordinate spaces S_i. A product-box event H fixes the coordinates in F_H and leaves the other coordinates free. For a pair (H,K), put
- U(H,K) = F_H ∪ F_K,
- O(H,K) = F_H ∩ F_K,
- Compat(H,K) iff H and K assign equal values on every coordinate in O(H,K).

Under the uniform product measure,
P(H ∩ K) = 0 if not Compat(H,K), and otherwise
P(H ∩ K) = ∏_{i ∉ U(H,K)} |S_i| / ∏_{i ∈ I} |S_i|.

Therefore the exact ordered-pair second moment is
E[X²] = Σ_{(H,K)∈H×H, Compat(H,K)}
              ∏_{i ∉ U(H,K)} |S_i| / ∏_{i∈I}|S_i|.

This expression preserves diagonal pairs. It does not assume independence.

## Cardinality refinement

If every coordinate space has the same cardinality q and every event fixes exactly k coordinates, then
|U(H,K)| = 2k - |O(H,K)|,
so every compatible pair with overlap size r has mass q^{-(2k-r)}.

This simplification is not valid for heterogeneous coordinate sizes: the mass depends on which coordinates lie in U(H,K), not just on |U(H,K)| or |O(H,K)|. Thus the exact support-stratification is the primary identity; cardinality-only stratification is useful only under the additional uniform-size assumptions.

## Quantitative theorem that is actually needed

For each overlap support J ⊆ I, define
N_J = #{(H,K) ∈ H×H : F_H ∩ F_K = J and Compat(H,K)}.
Then
E[X²] = Σ_{J ⊆ I} N_J · (∏_{i ∉ U} |S_i|)/(∏_i |S_i|),
where the product factor must remain inside the sum unless U is fixed by the stratum or additional symmetry makes it constant.

The next theorem must bound these compatible-pair counts or their weighted sum from the original BBMST hypotheses. A bound depending only on |J| is not justified in the heterogeneous model. A bound that assumes the desired sieve conclusion is circular.

## Lean proof sequence

1. Prove the set-theoretic support identity |F_H ∪ F_K| + |F_H ∩ F_K| = |F_H| + |F_K|.
2. In the equal-cardinality special case, derive q^{-(2k-r)} from the exact intersection-mass formula.
3. State the published BBMST combinatorial hypotheses explicitly and prove a compatible-pair count bound under precisely those hypotheses.
4. Only then combine the weighted bound with the finite second-moment inequality and the exact source theorem.
5. Audit the transitive axioms of the final theorem. In particular, `sieve_criterion` and `sf_sieve_lt_one` remain open obligations, not assumptions that can be silently imported as proved.

No global Erdős–Selfridge/BBMST result is claimed by this note.
