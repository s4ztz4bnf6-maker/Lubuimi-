# BBMST hyperplane-mass formalization target (2026-10-23)

## Scope boundary

The Lean file `BBMSTOverlapConditioning.lean` currently proves finite algebraic
identities for first and second moments of event counts. These identities do
not yet model the source-specific measure `P_k`, the coordinate spaces
`Q_k`, or the geometry of hyperplanes. The distinction is substantive:
abstract event algebra alone cannot yield the BBMST theorem.

## Source-specific next target

In the published paper *The Erdős–Selfridge problem with square-free moduli*
(Balister, Bollobás, Morris, Sahasrabudhe, Tiba; Algebra & Number Theory 15
(2021), 609–626), Lemma 3.3 bounds the measure of a `Q_k`-measurable
hyperplane `A` in terms of its support split `F(A)=I ∪ J`, with
`I ⊆ [a]` and `J ⊆ [a+1,k]`:
`P_k(A) ≤ c(I) ν(J)`.

The proof is inductive in k and uses the paper's recursive measure relation,
including the factor `1/(1-δ_k)` when the new coordinate belongs to the
hyperplane support. A faithful Lean encoding therefore needs, in dependency
order:

1. finite coordinate types and the exact `Q_k` sample-space definition;
2. the paper's `P_k` and `ν` measures, including normalization and positivity;
3. a support predicate `F(A)` and a formal split into I and J;
4. the recursive measure inequality corresponding to the paper's equation (5);
5. the inductive hyperplane-mass estimate;
6. only then, the subsequent theorem-specific covering argument.

Avoid introducing uninterpreted predicates such as “is a hyperplane” with
free assumptions that already encode the desired estimate. That would
formalize the conclusion as an axiom rather than prove it from the geometry.

## Immediate implementation boundary

The current weighted fiber-expansion theorem is an algebraic tool for
rearranging finite sums over shared and residual coordinates. It may support
step 4, but only after the paper's actual sample space and weights are defined.
The finite event-mass domination lemma is a general measure sanity check, not
a replacement for Lemma 3.3.

## Verification status

This note is a formalization design target. It does not claim that Lemma 3.3
has been formalized or that the main Erdős–Selfridge theorem has been proved.
