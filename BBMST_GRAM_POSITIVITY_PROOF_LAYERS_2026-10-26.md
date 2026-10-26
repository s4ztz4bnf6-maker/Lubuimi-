# BBMST research note: Gram positivity separated from geometric input
Date: 2026-10-26
Branch: `audit/bbmst-fiber-incidence-2026-10-26`

## Why this decomposition is useful

The explicit singleton-fiber lemma is only local geometry. The next mathematically honest boundary is the intersection matrix of the actual source-defined events, before any optimized sieve estimate is asserted.

Let Omega be a finite probability space with weights w(x) >= 0 and sum_x w(x)=1. For events H_1,...,H_m, define
`G_ij = mu(H_i intersect H_j)`.
For any real vector c,
`c^T G c = sum_{x in Omega} w(x) (sum_i c_i 1_{H_i}(x))^2 >= 0`.
Hence G is positive semidefinite. Also `G_ii=mu(H_i)`, and
`E[X]=sum_i mu(H_i)`,
`E[X^2]=sum_i mu(H_i)+2 sum_{i<j} mu(H_i intersect H_j)`,
where `X=sum_i 1_{H_i}`.

These identities and PSD property are generic finite-probability facts. They do not use BBMST geometry and therefore cannot, by themselves, imply the paper's strict sieve bound.

## Proposed Lean layering

A. Define a finite sample type, nonnegative weights, and a separately proved normalization theorem. Do not encode invalid total mass through default values or division by zero.

B. Define each event as a predicate on the sample type; define its indicator in a field with nonnegative weights.

C. Prove the Gram identity by finite-sum rearrangement and PSD by pointwise square nonnegativity.

D. Add a source-mapped hyperplane representation: every coordinate domain, measure, and parameter must match the paper's definitions exactly. Prove pair-intersection estimates only from explicit source hypotheses.

E. Prove the precise source-specific strengthened second-moment estimate only after its geometric side condition is available. Otherwise retain the weaker inequality whose hypotheses have actually been proved.

F. Prove parameter existence, positivity of all denominators, strict sieve bound, and final covering-system contradiction. Remove project-specific axioms from this chain and run a transitive axiom audit on the final theorem.

## Source-fidelity constraint

The repository's former `sieve_criterion` and `sf_sieve_lt_one` placeholders carry substantive mathematical burden if used as assumptions. Replacing them requires proving the corresponding claims from the original paper, not renaming them or wrapping them in a structure.

The source paper remains the controlling reference:
https://doi.org/10.2140/ant.2021.15.609

The general reliability warning in Hales/Tao's October 2026 article is relevant: a successful kernel check proves the exact formal proposition, so theorem-to-paper alignment and independent checking remain separate tasks:
https://terrytao.wordpress.com/2026/10/09/what-mathematicians-should-know-about-the-lean-theorem-proverquestions-of-reliability-and-ai/

## Status

This is a proof architecture and a list of explicit obligations, not a claim that the BBMST global theorem has been proved or that the proposed Lean declarations have compiled.
