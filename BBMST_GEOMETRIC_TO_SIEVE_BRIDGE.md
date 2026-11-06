# BBMST geometric-to-sieve bridge: proof obligations

Branch: `audit/overlap-moment-roadmap-2026-10-23`

## Scope

This note specifies the missing bridge between finite affine-intersection counting and the BBMST sieve estimate. It is a proof plan with explicit obligations, not a claim that the global sieve theorem has been proved.

## Layer 1: affine fibers

For a finite-dimensional vector space (V) over a finite field (K), and linear maps (T_i : V \to W_i), an affine event is a fiber (T_i(x)=b_i). For two events, stack the maps into (S=(T_1,T_2)). If the affine system is consistent, the common fiber is a translate of \\(\ker S\\), hence has cardinality \\( |K|^{\dim V-\operatorname{rank}(S)} \\). If inconsistent, its cardinality is zero.

Formal obligations:
1. Check the exact theorem statement and ensure the cardinality instance for the subtype is available.
2. Keep consistency separate from rank; rank alone does not imply an affine system is consistent.
3. Ensure the dimension subtraction is justified by \\(\operatorname{rank}(S)\leq\dim V\\), rather than relying on truncated natural subtraction to conceal a missing inequality.

## Layer 2: probability of intersections

On a uniform finite space (V), an event with (r) independent affine constraints has probability \\( |K|^{-r} \\), provided the fiber is nonempty and the rank is exactly (r). For a pair, use the rank of the stacked map and a consistency proof. Do not infer independence from distinctness of the events or from distinct moduli alone.

Formal obligations:
1. Prove the uniform-space cardinality/probability conversion.
2. Prove the rank and consistency hypotheses from the actual BBMST hyperplane geometry.
3. Encode parallel/coincident and empty-intersection cases explicitly.

## Layer 3: second moment and conditioning

For a finite family of events and (X=\sum_i 1_{E_i}),
\[
\mathbb E[X^2]=\sum_{i,j}\mathbb P(E_i\cap E_j).
\]
This identity is elementary; the research bottleneck is the upper bound on the pair terms after conditioning/reweighting.

Formal obligations:
1. Prove the indicator expansion on the exact finite probability space.
2. Derive the pairwise bounds from the geometric layer, not as free hypotheses.
3. Track all weights as nonnegative and normalized at every update.
4. Prove the parameter range \\(0\leq\delta_k\leq1/2\\) and every list-length alignment used by the finite sum.

## Layer 4: theorem fidelity and axiom elimination

The target estimate is
\[
\sum_{k=a+1}^{n}\min\left\{M_k^{(1)},
\frac{M_k^{(2)}}{4\delta_k(1-\delta_k)}\right\}<1.
\]
A theorem deriving the contradiction from this estimate is not enough unless the estimate's geometric hypotheses are proved from the covering-system assumptions. The external declarations `sieve_criterion` and `sf_sieve_lt_one` must be replaced by proved results or transparently isolated as unproved assumptions.

## Degeneracy tests

Keep regression tests for:
- empty parameter lists;
- mismatched lengths between `δ` and moment arrays;
- `δ=0` and the boundary `δ=1/2`;
- inconsistent affine systems;
- zero denominators in rational expressions;
- empty families of hyperplanes.

Lean's total rational division means division by zero evaluates to a value; it does not automatically signal a mathematical domain error. Such cases must be excluded by hypotheses, not by informal intent.

## Completion criterion

The bridge is complete only when every transition above is a theorem, the top-level statement matches the published hypotheses, and the axiom audit contains no project-specific unproved sieve axiom.
