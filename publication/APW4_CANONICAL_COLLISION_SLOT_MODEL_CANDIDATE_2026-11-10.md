# APW4 canonical collision-slot model candidate — 10 November 2026

**Status: OPEN / NOT KERNEL-VERIFIED. Not part of the historical APW4 proof chain.**

## Candidate construction

For a finite ambient residue group G = Z/NZ, a finite index set I, and original congruence sets S_i ⊆ G, put

\[ S(x)=\{i\in I:x\in S_i\}. \]

The proposed canonical collision slots are triples

\[ \mathscr B_{\rm can}=\{(x,i,j):i,j\in S(x),\ i\ne j\}. \]

Their expected cardinality is

\[ |\mathscr B_{\rm can}|=\sum_{x\in G}|S(x)|(|S(x)|-1)=\sum_{i\ne j}|S_i\cap S_j|. \]

This is a new canonical set-level realization of the scalar ordered-collision count. It is **not** a reconstruction of the paper's historically named BIB places. No historical APW4 elementary event has yet been mapped to a triple (x,i,j), and no weight-preserving injection or weighted Hall allocation has been established.

## Exact Lean diagnostic and disposition

At the failed Lean 4.28.0 candidate head, the dependent sigma-type representation failed to synthesize its Fintype instance, and the inner subtype cardinality did not reduce to the erased support cardinality. The resulting cardinality declarations had transitive sorryAx and were not accepted.

The candidate has been removed from APW4HistoricalCRTCore.lean so it cannot contaminate the q-fibre preimage audit. It remains recorded here, explicitly as a new candidate rather than a historical definition.

## Next obligations

1. Choose a finite representation with an explicit Fintype instance (for example a subtype of G × I × I, or a Finset of such triples).
2. Prove a bijection with the disjoint union over x ∈ G and i ∈ S(x) of S(x) \ {i}.
3. Derive the ordered-collision cardinality identity without sorryAx.
4. Keep the construction separate until a source-grounded map from the actual APW4 events to these slots is proved.

The historical event set, historical BIB-place set, historical incidence relation, and weighted Hall demand/capacity inequality remain open independently of this candidate.