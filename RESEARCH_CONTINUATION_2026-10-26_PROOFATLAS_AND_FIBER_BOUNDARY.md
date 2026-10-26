# Research continuation — 2026-10-26: external-result triage and finite-fiber boundary

## Literature triage

The Quanta/MAA reports concern an AI-assisted resolution of the Erdős unit-distance problem. They are evidence that AI can find useful constructions/counterexamples, not evidence that the distinct odd-covering / Erdős–Selfridge problem is resolved. The October 2026 bulk release of 722 manuscripts likewise requires per-result validation; manuscript count is not proof count.

ProofAtlas is useful as an evidence model: separate exact proposition, pinned source, build transcript, axiom profile, statement alignment, and editorial status. Reuse this audit architecture, not its theorem claims as assumptions.

## Current mathematical boundary

The low-level finite-fiber identity is an independent theorem. For a finite set F partitioned into disjoint R,S,U and a weight w : F → ℝ, the desired statement is

  ∑ x ∈ F, w x = (∑ x ∈ R, w x) + (∑ x ∈ S, w x) + (∑ x ∈ U, w x).

The proof obligations are exact coverage and pairwise disjointness. Nonnegativity is not needed for this additivity identity; it is needed for the separate inference that a zero total mass forces every point mass to vanish. This distinction should be reflected in Lean signatures, rather than bundled into one overly strong lemma.

A ratio-free contract should carry:
- the finite carrier and its exact partition;
- the point-mass function;
- the partition proof;
- nonnegativity only for zero-mass consequences;
- denominator positivity only for later ratio/conditional-probability statements.

This prevents a zero denominator from being silently treated as a probability. It does not supply the paper-specific hyperplane incidence, distortion, moment, or sieve estimates.

## Next falsifiable theorem

Formalize the partition sum identity without importing the sieve criterion or any source-specific geometric theorem. Then separately prove the zero-mass corollary using the appropriate finite-sum nonnegativity lemma, after checking the exact API against the pinned Mathlib version. Do not assert an API name until compiled against the pinned toolchain.

## Acceptance gate

No source-specific BBMST conclusion is accepted until the exact published definitions and hypotheses are transcribed, the geometric/moment bound is proved, and the exported final theorem passes a transitive axiom audit. This note records a research boundary, not a Lean build.
