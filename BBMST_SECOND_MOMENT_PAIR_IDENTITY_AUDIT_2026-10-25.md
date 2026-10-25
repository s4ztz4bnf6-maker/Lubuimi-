# BBMST second-moment bridge: exact counting identity and audit boundary
Date: 2026-10-25

## New local formal target

Commit `75801bcae767a85a4256718141250172211cfcf3` adds `BBMSTAudit.finite_second_moment_ordered_pair_identity` to `BBMSTProductBox.lean`. It states that for finite sample set `samples`, finite index set `indices`, and events `E i ω`,
[
\sum_{\omega\in samples}\left(\sum_{i\in indices}1_{E_i}(\omega)\right)^2
=\sum_{i\in indices}\sum_{j\in indices}\sum_{\omega\in samples}1_{E_i\cap E_j}(\omega).
]
This is a finite counting identity: squaring an event count enumerates ordered pairs. It requires no independence assumption. The earlier pointwise lemma `indicator_sum_sq_eq_ordered_pair_sum` is the algebraic core.

## What it does and does not establish

It does establish the exact rearrangement from a second moment to pairwise intersections, if the Lean declaration compiles. It does not yet establish:
- a probability measure or normalized expectation;
- the source-specific BBMST hyperplane distribution;
- the compatible-pair intersection bound in the published theorem's exact hypotheses;
- the fiber moment inequalities and final covering-system obstruction;
- the full Erdős–Selfridge conjecture beyond the source theorem's square-free-moduli scope.

The product-box geometry already formalized locally gives the compatible/incompatible dichotomy: compatible coordinate prescriptions merge and count by the product over free coordinates; a conflicting shared coordinate forces the intersection cardinality to zero. The next theorem should instantiate the generic event identity with these actual product-box events, including nonempty coordinate spaces and normalization, rather than introducing abstract independence or unproved geometric predicates.

## Source-fidelity constraints

Use the published 2021 paper and the Erdős Problems library as the statement baseline, not the 2019 preprint alone. Preserve the known corrections:
- published Theorem 3.1 uses a union-bound inequality, not equality;
- published Theorem 3.2 allows coordinate sizes at least 2;
- published Lemma 5.3 has `μ̂_k ≤ μ_k`;
- Proposition 4.1 states a limit, not merely a liminf.
Theorem 5.1 depends on a tail result from the foundational density paper; record that dependency instead of pretending it has been reproved locally.

References:
- https://erdosproblems.ai/wiki/library/covering_systems/balister_2021_erdos_selfridge_problem_square_free_moduli
- https://erdosproblems.ai/wiki/library/covering_systems/balister_2018_erdos_covering_problem_density_uncovered_set
- Published paper: Balister, Bollobás, Morris, Sahasrabudhe, Tiba, Algebra & Number Theory 15 (2021), 609–626, DOI 10.2140/ant.2021.15.609.

## CI status and next check

The workflow run associated with the latest commit, `75801bcae767a85a4256718141250172211cfcf3`, is run 40142372631 and remained `in_progress` at the Mathlib dependency/cache step when checked on 2026-10-25. Therefore the theorem is committed but must not yet be reported as compiled. The earlier run 40142069689 succeeded for the preceding commit `c6e9bec63a8915d3006519c210ebf1295ad4b1a9`; that success does not certify this newer theorem.

Run: https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/40142372631
