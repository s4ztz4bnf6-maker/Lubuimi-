# Next formal targets: threshold certificate and cylinder event mass
Date: 2026-10-23

This note records the exact next obligations for the parallel Syracuse and BBMST tracks. It is a proof plan, not a claim that the obligations have been discharged.

## Syracuse: separate the local threshold from global termination

For a realized valuation word of length k, write A_k for the sum of exact exponents, C_0 = 0 and C_{j+1} = 3 C_j + 2^{A_j}, and D_k = 2^{A_k} - 3^k when this difference is positive.

The existing affine identity gives 2^{A_k} n_k = 3^k n_0 + C_k. If D_k > 0, strict descent is equivalent to D_k*n_0 > C_k. This is a local arithmetic certificate. It does not prove that every orbit realizes such a block at a useful size.

A valid global argument must supply a theorem with actual universal quantifiers, such as a proved finite cover of every state by certified transitions, or a well-founded ranking whose decrease is proved for every nonterminal state. A finite residue graph is insufficient unless its abstraction relation is proved to cover all exact valuations, including unbounded valuations. A density-one or almost-all result is not a universal termination theorem.

Research boundary: Tao's almost-all result uses probabilistic/3-adic distributional structure and first-passage estimates. It is inspiration for transport and stopping-time ideas, but cannot be upgraded to all integers by simply replacing probability estimates with deterministic language.

## BBMST: exact event-mass identity

Let X_i be each finite coordinate domain, w_i normalized nonnegative weights, X = product_i X_i, and W(x) = product_i w_i(x_i). For a cylinder H fixing coordinates F to v_i, the desired theorem is:

    eventMass (toProductDistribution w) H.Contains = product_{i in F} w_i(v_i).

The proof should be decomposed into three separately checked lemmas:

1. Indicator conversion: the filtered finite sum defining eventMass equals the sum over all x : X of W(x) multiplied by the indicator of H.Contains x. This step must be proved from the actual eventMass definition, not asserted by naming the cylinder.
2. Finite product sum factorization on the concrete dependent product of coordinate subtypes. Split each coordinate's summand into a fixed-coordinate indicator factor and a free-coordinate factor; use finite-sum/product interchange. Every free coordinate collapses by coordinate_sum_one.
3. Simplification of fixed-coordinate factors to the prescribed coordinate weights, with each index in F occurring once.

For cylinders H and K, define compatibility on F intersect G. If incompatible, the intersection event has mass zero. If compatible, the intersection fixes F union G, and the formula is the product over that union; shared coordinates are included once. Do not claim product of marginal masses unless F and G are disjoint (or an equivalent independence condition has been proved).

The second-moment identity for Z = sum_j 1_{H_j} is algebraic: E[Z^2] = sum_j mu(H_j) + sum_{j != l} mu(H_j intersect H_l). It should be proved after the event-mass bridge, while source-specific BBMST distortion bounds remain a separate layer.

## CI status snapshot

At the last inspection on 2026-10-23, workflow runs 39910296949 (Syracuse) and 39910394240 (BBMST) were still installing/restoring dependencies. No result from the new source compilation steps was yet available. Do not describe either new commit as kernel-verified until the run completes and the relevant axiom output is checked.
