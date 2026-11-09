# Dependent finite product-sum: compiler failure and proof alternatives

Status: diagnostic note. The latest CI attempt fails before proving the identity, so no product-sum theorem is certified by that run.

## Observed failure

The focused CI job reports that Lean cannot synthesize `Fintype ((i : I) → X i)` while elaborating the theorem statement. Adding `DecidableEq I` alone did not resolve the failure. Therefore the earlier description that a single index-equality instance had fixed the issue was premature.

## Robust alternatives

1. Make the finite function-space instance an explicit theorem parameter, rather than expecting typeclass synthesis to derive it at the binder where the sum is elaborated. Then verify whether the desired `Fintype.prod_sum` rewrite applies with that instance.
2. Avoid the full dependent Pi sum if this abstraction is not essential to the mathematical goal. First prove the finite product-sum identity for a fixed finite index type and explicitly finite coordinate types, or for `Fin n` and a family of finite subtypes, where the instance is easier to expose.
3. For the cylinder-mass theorem, partition coordinates into fixed and free sets and use a finite-sum bijection between points satisfying the cylinder and assignments on free coordinates. This is more work but keeps the probability theorem independent of fragile implicit inference.

## Mathematical guardrail

A generic identity over a finite product is only a summation lemma. It does not establish the BBMST distortion inequality or the main covering theorem. The exact cylinder-mass identity and the source-specific overlap estimate remain separate obligations.
