# APW4 canonical collision-slot model candidate — 10 November 2026

**Status: OPEN / NOT KERNEL-VERIFIED. Not part of the historical APW4 proof chain.**

## Candidate construction

For a finite ambient residue group G = Z/NZ, a finite index set I, and original congruence sets S_i ⊆ G, put

\[ S(x)=\{i\in I:x\in S_i\}. \]

The proposed canonical collision slots are triples

\[ \mathscr B_{\rm can}=\{(x,i,j):i,j\in S(x),\ i\ne j\}. \]

Their expected cardinality is

\[ |\mathscr B_{\rm can}|=\sum_{x\in G}|S(x)|(|S(x)|-1)=\sum_{i\ne j}|S_i\cap S_j|. \]

The right-hand side is the ordered-pair form of the CRT BIB reserve.

## What this does and does not establish

This is a new canonical set-level realization of the scalar ordered-collision count. It is **not** a reconstruction of the paper's historically named BIB places. In particular, no historical APW4 elementary event has yet been mapped to a triple (x,i,j), and no weight-preserving injection or weighted Hall allocation has been established.

The candidate must therefore remain separate from the historical event-to-BIB problem. Its intended Lean namespace is APW4CanonicalBIBSlotModel, not APW4HistoricalBIBSlotModel.

## Exact Lean diagnostic

At commit f8e89fdac9c95eb0ff35e364b1c11cbdb54b7296, Lean 4.28.0 reported:

- failure to synthesize Fintype (canonicalBIBSlots N m a) at the dependent sigma-type instance;
- an unsolved cardinality goal comparing the inner subtype of indices distinct from a fixed index with (supportAt ...).erase i;
- #print axioms consequently reported sorryAx for the two dependent cardinality theorems.

This is a genuine failed formalization attempt. The two cardinality declarations are **not** accepted as results and have been removed from the APW4 core module so that they cannot contaminate the q-fibre preimage audit.

## Exact next obligations for this candidate

1. Choose a finite representation whose Fintype instance is explicit (for example, a subtype of the finite product G × I × I, or a Finset of such triples).
2. Prove a bijection with the disjoint union over x ∈ G and i ∈ S(x) of S(x) \ {i}.
3. Derive the ordered-collision cardinality identity with no sorryAx.
4. Keep this canonical construction separate until a source-grounded map from the actual APW4 events to these slots is proved.

The historical event set, the historical BIB-place set, the historical incidence relation, and the weighted Hall demand/capacity inequality remain open independently of this candidate.