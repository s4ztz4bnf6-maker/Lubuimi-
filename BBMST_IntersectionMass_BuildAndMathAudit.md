# BBMST intersection-mass audit: build diagnosis and mathematical scope

Status: build dependency corrected; the next CI run must verify it. This note does not claim the second-moment theorem is complete.

## Build diagnosis

Workflow run 39908203447 compiled the geometry module and then failed at BBMSTIntersectionMass.lean:1 with `unknown module prefix 'FiniteProductSumAudit'`. The identity file was a separate workflow target, but its compiled module was not available at the dependent module's compile point in that run. The intersection-mass module does not use declarations from that identity file yet, so its import was removed instead of retaining a false dependency. The product-sum identity remains a separate audit target.

## What the current intersection layer establishes

- If two coordinate cylinders prescribe unequal values at a shared fixed coordinate, their intersection is empty and has mass zero.
- For arbitrary events, intersection mass is at most either marginal. This requires no independence assumption.
- These facts are not yet the compatible-cylinder product formula and do not by themselves imply a useful BBMST second-moment bound.

## Exact next theorem

For a finite coordinate product with normalized weights w_i, a cylinder fixing F to values v_i should satisfy

  μ(H) = product_{i in F} w_i(v_i).

For compatible cylinders with fixed sets F and G, their intersection fixes F union G. The product must range over the union, not multiply the two cylinder masses, which would double-count overlap coordinates. If a shared coordinate has contradictory prescriptions, the mass is zero. Prove the formula from finite product-sum factorization and normalization of each free coordinate.

Only after this formula is checked can the second moment be decomposed by pair type:

  E[Z²] = sum_i μ(H_i) + sum_{i ≠ j} μ(H_i ∩ H_j).

The source-specific BBMST distortion estimates remain a separate obligation. A compile of the generic factorization is a local formal result, not proof of the BBMST theorem. Exported claims must be checked for `sorryAx`, and source-specific assumptions must remain explicit.