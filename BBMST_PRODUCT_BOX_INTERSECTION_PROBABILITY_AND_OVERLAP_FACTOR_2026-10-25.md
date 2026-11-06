# BBMST product-box intersections: normalized probability and overlap factor (2026-10-25)

## Scope

The Lean module `BBMSTProductBox.lean` now proves the exact geometry/counting split: compatible coordinate prescriptions merge, and incompatible prescriptions have intersection cardinality zero. The successful CI run for code commit `33a0d93708a9a2e160c1aa3b4081bbfd7d36b33c` checks this submodule. This note derives the next algebraic bridge from those finite counts to normalized uniform probability. It is a mathematical derivation and formalization target, not yet a compiled Lean theorem or the global BBMST sieve theorem.

## Finite product model

Let (I) be a finite coordinate set, each coordinate (i) have a nonempty finite state space (S_i), and let (X=prod_{iin I}S_i) with uniform probability. A coordinate-box event (E_A(a)) fixes coordinates in (Asubseteq I) to prescribed values (a_i), leaving coordinates outside (A) free.

Write (q_i=|S_i|) and (w(A)=prod_{iin A}q_i). Counting free assignments gives
[
|X|=prod_{iin I}q_i,qquad |E_A(a)|=prod_{i
otin A}q_i,
]
so
[
mathbb P(E_A(a))=rac1{w(A)}.
]
The nonempty-coordinate assumption matters if we want every fixed prescription to define a nonempty event; with an empty coordinate type, the ambient space itself is empty and the usual normalized uniform probability is not defined. In Lean, state this hypothesis explicitly or work in a finite probability space whose normalization has already been established.

For two events (E_A(a)) and (E_B(b)), there are exactly two cases.

* **Conflict:** some (iin Acap B) has (a_i
e b_i). Then the intersection is empty and its probability is zero.
* **Compatibility:** all values agree on (Acap B). The intersection fixes exactly (Acup B), hence
  [
  mathbb P(E_A(a)cap E_B(b))=rac1{w(Acup B)}.
  ]

Because (w(Acup B)w(Acap B)=w(A)w(B)), the compatible case gives the exact overlap identity
[
mathbb P(E_A(a)cap E_B(b))
=mathbb P(E_A(a)),mathbb P(E_B(b)),w(Acap B).
]
Thus the ratio to the product of marginal probabilities is precisely
[
rac{mathbb P(E_Acap E_B)}{mathbb P(E_A)mathbb P(E_B)}
=prod_{iin Acap B}q_i.
]
The dependence is not an unspecified covariance term: it is determined exactly by the shared fixed-coordinate support. For disjoint supports, (w(Acap B)=1), so compatible events are independent. For overlapping supports with compatible values, the ratio is greater than or equal to one.

## What this adds to the moment audit

For a finite family of hyperplane events (E_r), define (Z=sum_r 1_{E_r}). Then
[
mathbb E[Z^2]=sum_rmathbb P(E_r)+2sum_{r<s}mathbb P(E_rcap E_s).
]
Each pair term can be classified mechanically by its support and assignment:
- conflict pairs contribute exactly zero;
- compatible pairs contribute the reciprocal support weight (1/w(A_rcup A_s));
- equivalently, each compatible pair contributes its marginal product times the explicit overlap factor (w(A_rcap A_s)).

This is an exact identity for the finite product-box model. It is not yet the source-specific BBMST moment estimate: the nontrivial work is to bound the sum of compatible overlap factors under the paper's actual geometric/hyperplane hypotheses. A freely postulated global overlap bound would only relocate the missing theorem.

## Suggested formalization sequence

1. In Lean, prove the ambient product cardinality and event cardinality in terms of the free coordinates.
2. Introduce a finite uniform probability measure, with nonemptiness/positive-cardinality hypotheses explicit.
3. Prove the normalized single-event formula (mathbb P(E_A)=1/w(A)).
4. Derive the two-event intersection formula by the already checked compatibility/disjointness split.
5. Prove the finite sum identity for (Z^2) using `Finset.sum` and indicators, then substitute the exact pair formula.
6. Only after these lemmas are checked, connect the resulting sum to the exact moment inequalities and generating-function bounds of the chosen source version.

## Source-fidelity boundary

This product-box lemma is a primitive geometry and normalization result. It does not by itself prove the original BBMST uncovered-density theorem or the square-free-moduli follow-up. The exact paper, version, theorem number, and assumptions must remain pinned in the formalization target.
