# BBMST Lemmas 3.3–3.4: source-faithful profile interface

**Research lead:** Ta-Yoshua Lubuimi  
**Date:** 10 November 2026  
**Status:** Historical source definitions recovered; Lean interface design specified; integrated formalization remains open.

## 1. Controlling source

P. Balister, B. Bollobás, R. Morris, J. Sahasrabudhe and M. Tiba, *The Erdős–Selfridge problem with square-free moduli*, Algebra & Number Theory 15 (2021), 609–626, DOI 10.2140/ant.2021.15.609. The controlling definitions are equations (9)–(11), and the proofs of Lemmas 3.3 and 3.4, in the published version (journal pages 615–617).

## 2. Exact historical definitions

Fix the initial coordinate block [a], its product Q_a, and the probability distribution P_a supported on R_a.

For every I ⊆ [a], the paper defines

c(I) = max { P_a(H) : H is a hyperplane in Q_a and F(H) = I }.  (9)

This is a maximum over **all hyperplanes in Q_a with exactly the fixed-coordinate set I**. It is not a maximum over the selected covering family A, nor over only the profiles that happen to occur in A. Thus the profile index family is the full power set P([a]); the admissible hyperplane assignments in each fibre of the profile map supply the maximization domain.

For every J ⊆ [a+1,n], the paper defines

ν(J) = product over j∈J of 1 / ((1−δ_j)|S_j|).  (10)

The empty products are 1. Since P_a is a probability distribution, the unique hyperplane with no fixed coordinates is all of Q_a, so c(∅)=P_a(Q_a)=1. Also ν(∅)=1.

For k≥a, the generating polynomial is

c_k(x) = Σ_{I⊆[a]} Σ_{J⊆[a+1,k]} c(I)ν(J)x^{|I|+|J|}
       = (Σ_{I⊆[a]} c(I)x^{|I|}) product_{j=a+1}^k (1+x/((1−δ_j)|S_j|)).  (11)

## 3. Exact Lemma 3.3 target

If A is a Q_k-measurable hyperplane and F(A)=I∪J with I⊆[a] and J⊆[a+1,k], then P_k(A) ≤ c(I)ν(J).  (15)

The induction has exactly two branches at stage k:
- If k∉F(A), A is already Q_(k−1)-measurable and Lemma 2.1(4) preserves its measure.
- If k∈F(A), Lemma 2.1(5) gives the factor 1/(1−δ_k), and uniform extension on the new coordinate gives the additional 1/|S_k|. The projected hyperplane A^[k−1] has suffix profile J\{k}; the induction hypothesis supplies c(I)ν(J\{k}).

The current Lean hyperplaneSuffixFactor has the correct local charging rule: it multiplies by distortionFactor C δ i exactly when H.assignment i is some _, and by 1 otherwise. This is the finite-prefix form of ν on the fixed suffix coordinates. The current cylinder theorem, however, is not yet Lemma 3.3: its right-hand initial mass is the actual initial cylinder mass, not the historical profile maximum c(I).

## 4. Exact Lemma 3.4 target

For each a<k≤n and t∈ℕ,

E_(k−1)[α_k(x)^t] ≤ (1/|S_k|^t) Σ_{F_1,...,F_t∈N_k} c(((F_1∪...∪F_t)∩[a])) ν(((F_1∪...∪F_t)∩[a+1,k−1])).

The source proof is:
1. Apply the union bound to α_k(x), then use uniqueness of the new-coordinate value for each hyperplane F∈N_k.
2. Raise the nonnegative sum to the t-th power and expand over ordered t-tuples (F_1,...,F_t)∈N_k^t.
3. The intersection of the projected hyperplanes is either empty or a hyperplane whose fixed-coordinate set is the union F_1∪...∪F_t, restricted to [k−1].
4. Apply Lemma 3.3 to each such intersection and sum.

The tuple sum is over ordered t-tuples, including repetitions. It must not be silently replaced by unordered subsets.

## 5. Exact Lean interface still required

The current geometry layer has Hyperplane.assignment : ∀ i : Fin n, Option (C.S i), fixedCoords H : Finset (Fin n), Hyperplane.ContainsPrefix, prefixCylinderMass, and hyperplaneSuffixFactor.

The source-faithful formalization should now be built in this order:
1. Define the initial-coordinate profile of a hyperplane as the fixed-coordinate set restricted to the first a coordinates. Use the actual Fin a prefix index map; do not compare Fin a and Fin n indices by coercion without an explicit transport lemma.
2. Define the initial hyperplane domain as all partial assignments on Q_a, equivalently the full hyperplanes whose suffix coordinates are all none. This domain is independent of the selected cover A.
3. Define cProfile(I) as the finite maximum of the initial P0-mass of all initial hyperplanes with profile exactly I. Prove the maximizing fibre is nonempty for every I⊆[a], using nonemptiness of every S_i.
4. Assume and use the probability normalization Σ_x P0(x)=1. Then prove cProfile(∅)=1; without this normalization the correct value is the total initial mass, not automatically 1.
5. Define suffixFixedCoords(H,a,k) as the exact set of fixed coordinates in [a+1,k]. Prove the existing hyperplaneSuffixFactor equals the finite product in (10) over this set, with exact endpoint convention.
6. Prove the base case j=0 by the defining maximum c(I), then the induction step using the already established free/fixed cylinder mass dichotomy. This yields the actual Lemma 3.3 statement.
7. Define the source-indexed new profile family N_k from the selected cover's fixed-coordinate family, preserving no-parallel uniqueness. Prove the unique extension-value lemma and the ordered-tuple expansion.
8. Apply Lemma 3.3 to intersections of projected hyperplanes to prove Lemma 3.4.
9. Feed Lemma 3.4 into the c_(k−1)(1), c_(k−1)(3) estimates and the distinct improved branch (13), whose hypothesis is that no hyperplane in N_k has codimension one.

## 6. Important correction to earlier planning language

The phrase “actual finite family of initial profiles” is not the definition of c in equation (9). The profile index set is all subsets I⊆[a], and c(I) maximizes over all initial hyperplanes with that fixed-coordinate set. The selected cover family A enters later through N_k in Lemma 3.4, not in the definition of c(I).

Likewise, c(∅)=1 depends on P_a being a probability distribution. The current generic Lean interface only assumes P0≥0; its cylinder-mass estimate alone cannot establish this normalization or the value 1.

The source suffix set in Lemma 3.3 is J⊆[a+1,k], while the moment lemma uses the suffix restricted to [a+1,k−1]. The endpoint must be carried exactly.

## 7. Scope and verification

This note records source definitions and a formalization plan. It is not a new Lean theorem and does not claim Lemmas 3.3 or 3.4 have already been kernel-verified in the current integrated branch. The previously established APW4 mathematical DT/HT/energy proof is unchanged and is not reopened by this formalization task.

## 8. Arbitrary ordered t-tuples: finite shadow intersection

The current concrete incidence bridge has an implemented pair layer:
`prefixCompatiblePairs`, `prefixPairShadowMass`,
`prefixOldShadowIntersectionMass`,
`prefixMergedOldShadowMass`, and
`prefixPairReserve_eq_weightedPairCount`. The old-shadow geometry has
`OldCompatible`, `mergeOldShadows`,
`mergeOldShadows_contains_iff`, and
`fixedCoords_mergeOldShadows`. These are genuinely t=2 interfaces. They
must not be described as the full arbitrary-t Lemma 3.4.

The exact arbitrary-t construction should take an ordered tuple
(\mathbf H: \mathrm{Fin}(t)\to\mathrm{newAtStage}(A,k+1)). Define
pairwise old compatibility by
[
\forall r,s\in\mathrm{Fin}(t),\quad
\mathrm{OldCompatible}(b,H_r,H_s),
]
where (b) is the newly exposed boundary coordinate. Repeated entries are
allowed and cause no problem: compatibility of a hyperplane with itself
is automatic. The tuple remains indexed by `Fin t`; do not replace it by
a set or quotient by permutations.

There are exactly two cases.

**Conflict case.** If pairwise compatibility fails, there are indices
(r,s), an old coordinate (i<b), and two distinct assigned values at
(i). The corresponding two old shadows are disjoint by
`oldShadows_disjoint_of_conflict`. Hence the intersection of all (t)
shadows is empty and its (P_{k-1})-mass is zero. This argument needs no
measure estimate.

**Compatible case.** If every pair is compatible, recursively merge the
old shadows, preserving the first assigned value at each coordinate. Pairwise
compatibility makes the result independent of the fold order at the level
of its assignment predicate. Induction over the finite index type proves:
[
\mathrm{ContainsPrefix}(M_{\mathbf H},x)
\iff
\forall r:t,\ 
\mathrm{ContainsPrefix}(\mathrm{oldShadow}(b,H_r),x),
]
and
[
\mathrm{fixedCoords}(M_{\mathbf H})
=
\bigcup_{r:t}\mathrm{fixedCoords}(\mathrm{oldShadow}(b,H_r)).
]
The second identity is the t-fold extension of
`fixedCoords_mergeOldShadows`; the first is the t-fold extension of
`mergeOldShadows_containsPrefix_iff`. Since each (H_r\in N_k), its
old shadow is supported in the (k-1) prefix. Therefore the merged
hyperplane is also supported there and is a legitimate (Q_{k-1})-event.

Define the tuple-intersection mass by the finite sum over genuine
(Q_{k-1})-prefixes. In the compatible case, the predicate equivalence
identifies it exactly with the cylinder mass of (M_{\mathbf H}); in the
conflict case it is zero. Apply source-facing Lemma 3.3 to (M_{\mathbf H}).
Its initial profile is the union of the tuple's initial fixed profiles, and
its suffix profile is the union of the fixed suffix profiles in
([a+1,k-1]). Thus in both cases:
[
\mathbb P_{k-1}\!\left(\bigcap_{r:t}
  \mathrm{oldShadow}(b,H_r)\right)
\le
c\!\left(\bigcup_{r:t}F(H_r)\cap[a]\right)
\nu\!\left(\bigcup_{r:t}F(H_r)\cap[a+1,k-1]\right).
]
The zero case uses nonnegativity of the right-hand side, which follows
from (c(I),\nu(J)\ge0).

Finally, the finite-sum expansion is indexed by
`(Fin t → newAtStage A (k+1))`, equivalently the ordered product
(N_k^t). The pointwise identity
[
\left(\sum_{H\in N_k}
  1_{\mathrm{oldShadow}(b,H)}(x)\right)^t
=
\sum_{\mathbf H\in N_k^t}
  1_{\bigcap_{r:t}\mathrm{oldShadow}(b,H_r)}(x)
]
is the exact combinatorial bridge. Multiply by the nonnegative weight
(P_{k-1}(x)), sum over x, interchange the two finite sums, and insert
the preceding tuple-intersection bound. Division by (|S_k|^t) gives
the source Lemma 3.4 estimate.

**Lean boundary:** the repository currently has the pairwise merge and
pair-reserve identities, and the concrete first/second moment incidence
bridges. It does not yet have the Fin t merge, the arbitrary-t indicator
expansion, or the arbitrary-t source-profile mass bound. Those are the
next exact declarations; t=2 must be recovered as a specialization, not
mistaken for the general theorem. This is a proof architecture, not a
claim of compilation or CI verification.


## 9. Repository inspection and finite-fold proof obligations — 10 November 2026

A fresh source inspection of the current working branch confirms the precise implementation boundary:

- `BBMSTOldShadow.lean` defines a binary `mergeOldShadows`, binary `OldCompatible`, the binary predicate-intersection theorem, the binary conflict-disjointness theorem, and the binary fixed-coordinate-union theorem.
- `BBMSTPrefixIncidenceBridge.lean` identifies actual stage-compatible hyperplanes with old-shadow prefix membership and provides pair-indexed masses, pair reserve, and the exact ordered-pair count. It also contains the concrete first- and second-moment incidence bridges.
- There is no current declaration for a `Fin t)-indexed merge, an arbitrary-t tuple intersection mass bound, or the arbitrary-t indicator expansion. The pair reserve identity is not the general moment theorem.

### Required induction invariant

For a tuple (H : mathrm{Fin}(t)\to\mathrm{Hyperplane}(C)), define
[
\operatorname{PairwiseOldCompatible}(b,H)
:=
\forall r,s,\ \operatorname{OldCompatible}(b,H(r),H(s)).
]
A left fold of the tuple's old shadows is sound only after proving the invariant that the accumulated merge is compatible with every remaining tuple member. At a coordinate (i<b), if the accumulator has an assigned value, that value came from some earlier tuple member; pairwise compatibility with the next member forces equality. If the accumulator is free, the next assignment is simply adopted. This is the exact local argument needed to lift the binary merge theorem.

The induction must establish both properties together:
[
\operatorname{Contains}(M_t,x)
\iff \forall r:t,\ \operatorname{Contains}(\operatorname{oldShadow}(b,H_r),x),
]
and
[
\operatorname{fixedCoords}(M_t)
=\bigcup_{r:t}\operatorname{fixedCoords}(\operatorname{oldShadow}(b,H_r)).
]
The same prefix-support proof used by `mergeOldShadows_containsPrefix_iff` then transports the full-point predicate identity to genuine prefix points. The empty tuple requires the everywhere-free hyperplane as identity; the singleton tuple reduces to its old shadow.

If pairwise compatibility fails, extract (r,s,i) and distinct values. The existing `oldShadows_disjoint_of_conflict` gives disjointness of those two factors; the full tuple intersection is therefore empty. The mass-zero conclusion then uses only nonnegativity of the weight. This branch must not invoke Lemma 3.3.

### Ordered moment expansion

The exact tuple domain is `Fin t → N_k` (equivalently the finite product (N_k^t)); repetitions are retained. The pointwise expansion is the finite distributive identity
[
\left(\sum_{H\in N_k}1_{\operatorname{oldShadow}(H)}(x)\right)^t
=\sum_{\mathbf H\in (\mathrm{Fin}(t)\to N_k)}
1_{\bigcap_{r:t}\operatorname{oldShadow}(H_r)}(x).
]
After multiplying by (P_{k-1}(x)), sum over genuine prefix points, interchange the two finite sums, and apply the tuple-intersection profile bound. The normalization denominator is (|S_k|^t). Do not quotient by permutations or replace tuples by subsets.

### Source-boundary and status

The compatible tuple case invokes the source-facing Lemma 3.3 for the merged hyperplane, with the initial profile equal to the union of the tuple's initial fixed profiles and the suffix profile equal to the union in the exact interval ([a+1,k-1]). The conflict case uses (c(I)\ge0) and (\nu(J)\ge0). Thus arbitrary-t geometry is necessary but not sufficient: the already documented all-hyperplanes definition of (c(I)), initial probability normalization, suffix-product identity, and (Q_{k-1})-measurability condition remain prerequisites.

**No Lean declaration was added by this documentation checkpoint.** The exact-head CI and axiom audit have not been refreshed by source inspection. The established APW4 mathematical results (DT, HT/weighted Hall transport, exact two-term energy decomposition, upper and strict lower bounds, and contradiction under their stated hypotheses) are unchanged and are not reopened by this separate BBMST formalization task.
