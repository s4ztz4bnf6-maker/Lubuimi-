# BBMST global-bridge audit — 2026-10-27

## Status boundary

The weighted moment-gap identity and the interior-fibre lower bound are valid finite-sum facts. They do not prove that the original BBMST geometry supplies a positive-mass set of fibres uniformly bounded away from 0 and 1. The unrestricted Erdős–Selfridge conclusion remains conditional in the current project because `sieve_criterion` and `sf_sieve_lt_one` are axioms in its dependency chain.

## Exact quantitative obligation

For the source-defined finite product space and hyperplane family, define the original stage variables and fibre shares αₖ. The gap is
`Γ = Σₖ (Mₖ^(1) - Mₖ^(2)) = Σₖ E[αₖ(1-αₖ)]`.

The generic bound `0 ≤ α ≤ 1` gives nonnegativity only. To obtain a uniform positive gap, one needs source-derived constants ε>0 and m>0 and actual source-defined subsets Sₖ such that
`ε ≤ αₖ(x) ≤ 1-ε` on Sₖ and `Σₖ Pₖ(Sₖ) ≥ m`.
Then `Γ ≥ ε(1-ε)m`. The missing part is precisely the geometric/combinatorial derivation of ε, m, and Sₖ from the original hyperplane hypotheses. Treating them as free parameters merely assumes the hard step.

## Alternative route: boundary rigidity

Try to prove directly that the original geometric hypotheses forbid the boundary-only case
`αₖ(x) ∈ {0,1}` for every positive-weight fibre at every stage.
The existing lemma says Γ=0 iff every positive-weight share is boundary-valued. This suggests a falsifiable target: characterize all boundary-supported configurations in a small exact finite model, then determine which property of nontrivial, pairwise nonparallel hyperplanes rules them out. A finite computation can discover the invariant, but the unrestricted theorem requires a general proof.

## Scope and integrity

The 2021 Balister–Bollobás–Morris–Sahasrabudhe–Tiba paper proves the square-free-moduli case, not the unrestricted odd-moduli conjecture. Do not silently widen the source theorem's scope.

Current global theorem dependencies include `sf_sieve_lt_one` and `sieve_criterion`, which are axioms in this repository. CI success without an explicit transitive axiom gate is not a global proof certificate.

## Concrete next experiment

Construct exact finite product spaces and nontrivial pairwise nonparallel hyperplanes for the smallest dimensions, enumerate their stage fibre shares, and classify zero-gap/boundary-supported cases. Record the minimal geometric obstruction to a boundary configuration. Then prove that obstruction symbolically for arbitrary finite dimensions, or preserve a counterexample if the conjectured obstruction is false. Keep this experiment separate from the unrestricted number-theoretic theorem until the source-faithful reduction is proved.
