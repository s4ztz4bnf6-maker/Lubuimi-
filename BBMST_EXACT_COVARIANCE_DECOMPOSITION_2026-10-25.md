# Exact covariance decomposition for the BBMST product-box model (2026-10-25)

## Status
This is a derived finite-probability identity and a proof-target specification. It is not the BBMST theorem and does not replace the outstanding source-dependent sieve estimate.

## Setup
Let I be finite, each coordinate set S_i finite and nonempty, and Omega = product_i S_i carry uniform counting measure. For each event E_H, a set F_H of coordinates is fixed to specified values. Write
p_H = P(E_H) = product_{i in F_H} |S_i|^{-1}.
Two events are compatible when their specified values agree on every shared fixed coordinate. Put
Q(H,K) = product_{i in F_H intersect F_K} |S_i|.

## Exact pair covariance
For all H,K,
Cov(1_EH,1_EK) =
  p_H p_K (Q(H,K)-1), if H,K are compatible;
  -p_H p_K, if H,K are incompatible.
In particular, if F_H intersect F_K is empty, the events are compatible and covariance is exactly zero. Therefore, for X = sum_H 1_EH,
Var(X) = sum_H p_H(1-p_H)
 + sum over ordered distinct compatible pairs p_H p_K(Q(H,K)-1)
 - sum over ordered distinct incompatible pairs p_H p_K.
This follows directly from Var(X) = sum_{H,K} Cov(1_EH,1_EK).

## Why this is a sharper audit interface
The raw second moment combines the independent baseline and all overlap corrections. The covariance form isolates the exact quantity a source-faithful BBMST estimate must control: positive inflation from compatible shared coordinates, offset by negative covariance from conflicting specifications. Disjoint supports contribute zero covariance.

A proposed formal interface must not accept an arbitrary scalar overlapBound. It should define compatible and incompatible pair families from the actual coordinate/hyperplane data, prove the displayed identity, and only then apply the paper's genuine hypotheses to bound the positive covariance sum. If the source estimate does not control that sum, the gap remains open.

## Adversarial cases
- Empty fixed support gives p_H = 1; the formulas still work.
- Shared-coordinate conflict gives zero intersection and covariance -p_H p_K.
- Shared-coordinate agreement multiplies product probability by Q(H,K), not by 1.
- Empty coordinate sets are excluded, so the uniform sample space is nonempty.
- This identity is not by itself a strict probability bound and cannot discharge the outstanding sieve assumptions.

## Formalization target
Add a small independent Lean module proving the covariance identity from the finite cardinality/intersection theorem, then audit its transitive axioms. Keep it independent of the source-specific BBMST estimate until the exact paper hypotheses are mapped.
