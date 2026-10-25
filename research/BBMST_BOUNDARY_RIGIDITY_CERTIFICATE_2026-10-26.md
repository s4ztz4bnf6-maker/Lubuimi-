# BBMST: exact positivity criterion and boundary-rigidity frontier

Date: 2026-10-26

## Scope

This note records a mathematically exact reduction for the weighted variance identity. It is a research obligation, not a claim that the original BBMST theorem has been proved.

Let p_i ≥ 0, sum_i p_i = 1, and 0 ≤ α_i ≤ 1 on a finite index set. Put μ = sum_i p_i α_i, V = sum_i p_i (α_i - μ)^2, and Q = sum_i p_i α_i (1 - α_i).

Expanding the variance gives V = sum_i p_i α_i^2 - μ^2, hence Q = μ(1 - μ) - V = μ - sum_i p_i α_i^2. These are elementary finite-sum identities. Isolate them as a standalone Lean lemma and do not conflate them with strict positivity.

## Exact equality characterization

Because each summand p_i α_i(1-α_i) is nonnegative,

Q = 0 iff for every i with p_i > 0, α_i is either 0 or 1.

Indeed, a finite sum of nonnegative reals is zero only when every summand is zero; for p_i > 0 this forces α_i(1-α_i)=0. Conversely, endpoint-valued coordinates make every positive-weight summand vanish. Zero-weight coordinates are irrelevant.

Thus Q > 0 is equivalent to the existence of an index i with p_i > 0 and 0 < α_i < 1. This is the precise boundary-rigidity obligation: derive such an interior coordinate from the source-faithful BBMST geometric hypotheses, rather than assuming it.

## Proof architecture

1. Formalize the finite-sum identity over ℝ independently of geometry.
2. Formalize the nonnegative-sum zero criterion, including zero-weight indices.
3. Trace the definitions of α_i and the finite probability weights back to the pinned BBMST source.
4. Prove a geometric boundary lemma: if every positive-weight α_i is 0 or 1, then the original source hypotheses imply a forbidden degeneracy or contradiction.
5. Only then conclude Q > 0 and use the exact variance identity.

The critical open step is item 4. The algebraic identity alone does not establish it. Do not introduce a free isNontrivial, noCodimOne, or equivalent axiom to bridge the gap.

## Audit requirements

- Keep all source assumptions explicit and source-mapped.
- Avoid division until denominators are proved nonzero.
- Test the equality characterization on empty support, all-zero weights (excluded by normalization), and endpoint-only α configurations.
- Compile under the pinned Lean/Mathlib toolchain and run a transitive axiom audit. CI success is evidence about the artifact, not a substitute for statement fidelity.

## Falsification check

For arbitrary normalized weights and arbitrary endpoint-valued α_i, Q=0 is possible. Therefore no argument using only p_i ≥ 0, normalization, and α_i ∈ [0,1] can prove strict positivity. Any purported proof from those assumptions alone is invalid.
