# BBMST next-step: division-free fiber mass and the source-fidelity gate

Date: 2026-10-26

## Division-free identity

Let X,Y be finite sets, f : X → Y, and w : X → ℚ. Define
\[
M_y=\sum_{x\in X,\ f(x)=y}w(x),\qquad M=\sum_{x\in X}w(x).
\]
Then \(\sum_{y\in Y}M_y=M\). This is a finite partition/reindexing identity and remains valid for empty fibers and signed weights. It requires no division and no positivity hypothesis.

If a later definition conditions on a fiber by dividing by M_y, the call site must establish M_y ≠ 0; for nonnegative probability weights, M_y > 0 is the natural premise. The mass identity does not imply positivity of individual fiber masses.

## Formalization boundary

Keep these obligations separate:

1. Prove the finite partition identity.
2. Prove normalization of conditional weights under an explicit nonzero-mass premise.
3. Prove from the source-specific BBMST construction that each denominator used later satisfies that premise.
4. Only then connect the quantities to the source's incidence/probability lemmas and minimax certificate.

A successful proof of step 1 is bookkeeping, not the BBMST theorem. A solver output or a reported LP bound is also not a theorem until its finite primal/dual certificate is exported and checked exactly.

## Next certificate target

For the ProofAtlas depth-2 route, the next reproducible artifact should contain the exact rational/integer data for the primal model, dual vector, objective values, and all constraint residuals, together with a small checker that verifies feasibility and the claimed strict gap using integer arithmetic. Until that artifact is independently checked, the reported scalar gap remains a route-specific lead, not a proof of the unrestricted odd distinct covering conjecture.

## Audit status

This is a formal interface contract and a research plan. It does not claim that the source-specific positivity lemmas, the global minimax inequality, or the unrestricted conjecture have been proved in Lean.
