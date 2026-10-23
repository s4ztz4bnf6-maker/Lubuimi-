# Parallel research continuation: descent certificates and cylinder mass

Date: 2026-10-23

This note records a research design for two independent projects. It is not a claim that either global conjecture is solved or that every Lean target has compiled.

## A. Syracuse: dual certificates for descent and failure

For an exact accelerated-Syracuse valuation word a_0,...,a_{k-1}, define A_k = sum_{i<k} a_i and C_0 = 0, C_{k+1} = 3 C_k + 2^{A_k}. The affine identity is
2^{A_k} n_k = 3^k n_0 + C_k.
Put D_k = 2^{A_k} - 3^k. Whenever D_k > 0,
n_k < n_0 iff D_k n_0 > C_k iff n_0 >= floor(C_k / D_k) + 1.

This yields a dual-certificate viewpoint:
- A descent certificate is a realized prefix with D_k > 0 and n_0 > floor(C_k/D_k).
- A non-descent prefix with D_k > 0 imposes the exact obstruction n_0 <= floor(C_k/D_k).
- Prefixes with D_k <= 0 cannot certify strict descent; they must not be treated as if merely extending k automatically fixes the issue.

For a fixed n_0, an exact prefix search can maintain either a witnessed descent or the upper bounds imposed by all positive-D prefixes that have failed to descend. A branch is inconsistent as soon as a failed-prefix bound falls below n_0. This provides checkable arithmetic reasons for pruning rather than a bare search heuristic.

The unresolved theorem is global coverage: prove every odd n_0>1 has a realizable prefix whose positive-D threshold is crossed, or prove an infinite non-descending path impossible by a well-founded invariant. Finite residue enumeration alone is insufficient unless its abstraction is proved to represent all exact valuation words, including arbitrarily large valuations. A formal certificate should carry the word, A_k, C_k, D_k, positivity proof, and threshold proof; its soundness theorem must be separate from a global coverage theorem.

Tao's theorem establishes that almost all Collatz orbits attain arbitrarily slowly growing bounds in logarithmic density, via first-passage stabilization, 3-adic distribution, and Fourier decay. It is not universal descent. The gap between local exact certificates and universal coverage remains substantive.

## B. BBMST: cylinder mass factorization

Let X_i be finite nonempty coordinate spaces with normalized nonnegative weights w_i, and W(x)=prod_i w_i(x_i). For a cylinder H fixing coordinates F to values v_i, define I_i(y)=1 when i is free, or when i is fixed and y=v_i; otherwise define I_i(y)=0. Then
1_H(x)=prod_i I_i(x_i),
and
sum_x W(x) 1_H(x) = prod_i sum_{y in X_i} w_i(y) I_i(y)
= prod_{i in F} w_i(v_i).
Fixed coordinates contribute their prescribed weights and free coordinates collapse to one by normalization.

Audit this in three lemmas:
1. Filter-to-indicator: the filtered sum defining eventMass equals the unrestricted sum of W(x) times the cylinder indicator.
2. Product-sum factorization over the concrete Fin n/coordinate-subtype product, avoiding the generic dependent-Pi formulation that previously failed to elaborate its finite instance.
3. Coordinate evaluation: fixed coordinate sums give w_i(v_i); free coordinate sums give 1.

For cylinders H and K, the intersection formula uses the union of their fixed-coordinate sets after compatibility on the overlap is proved. A disagreement on a shared coordinate yields empty intersection and zero mass. If they agree, a shared coordinate is counted once, not twice. Independence does not imply arbitrary overlapping cylinders have product intersection mass.

The Hough/BBMST distortion method goes beyond the product-measure identity: it builds stage-dependent measures concentrated on uncovered points and controls their distortion as progressions/hyperplanes are exposed. The next frontier after cylinder mass is a source-faithful bound on stage likelihood ratios or conditional coordinate weights, with constants strong enough to preserve positive surviving mass. Generic pointwise domination transfers a bound but does not create the needed distortion estimate.

## Status discipline

A green CI run certifies only completed steps. Compilation is not an axiom audit; local descent certificates and finite-product identities do not imply either global conjecture. Track source change, compile status, #print axioms, and mathematical scope separately.
