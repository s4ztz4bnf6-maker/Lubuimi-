# External audit: Erdős–Selfridge monotonicity formalization

Date: 2026-10-24

## Finding

The public repository
`axxen95/Lean-4-formalization-of-the-Erd-s-Selfridge-odd-covering-system-conjecture`
claims a formal proof of the full odd-moduli Erdős–Selfridge conjecture from two axioms identified with published BBMST results. The Lean monotonicity lemmas may be useful, but the axiom interfaces in `ErdosSelfridge_v17_fixed.lean` are not faithful enough to those published results as currently stated.

This is a **statement-fidelity defect**, not a claim that the monotonicity lemmas themselves are false.

## Concrete degeneracy: empty delta list

The source defines

- `sieveTerm ... k` using `δs.getD k 0`;
- `sieveSum ... ss δs` as a sum over `List.range ss.length`.

Therefore, if `δs = []`, every index has `δk = 0`. In Lean's rational arithmetic, division by zero is defined as zero. Thus the second branch of
`min (M1bound ...) (M2bound ... / (4 * δk * (1 - δk)))`
has denominator zero and evaluates to zero. Since `min x 0 ≤ 0`, and for the intended nonnegative M1 branch the term is zero, the entire sieve sum is zero. More generally, the missing alignment permits an arbitrarily short `δs` list to force the default `δk = 0` for later indices.

Consequences:

1. `sf_sieve_lt_one` as declared does not require `δs.length = primes.length`, nor `δ_k ≤ 1/2`; with `δs = []`, its claimed strict inequality can become vacuous.
2. `sieve_criterion` likewise accepts an arbitrary `δs` with no length or admissibility conditions. The empty-list choice can make its premise artificially easy, so the axiom no longer expresses the published BBMST criterion.
3. Consequently, `erdos_selfridge` is **not currently established by the two stated published results**. A kernel can correctly check a proof from axioms whose statements are too strong or malformed; this is exactly why statement fidelity must be audited separately.

## Required repair before relying on the claimed theorem

The imported BBMST interfaces must encode the actual hypotheses, including at minimum:

- exact alignment of the parameter list with the block indices used in the sieve sum;
- the original admissible interval for each `δ_k` (the BBMST setup uses `δ_k ∈ [0, 1/2]`);
- all validity conditions on `ca1`, `ca3`, and the base moment expressions required by the original theorem;
- the precise original block-size and nontrivial-hyperplane hypotheses.

Then the main theorem must be recompiled with the repaired interfaces. The monotonicity argument should be preserved only if it still proves the correctly typed result under these strengthened assumptions.

## Source trail

- Public Lean source: https://github.com/axxen95/Lean-4-formalization-of-the-Erd-s-Selfridge-odd-covering-system-conjecture
- BBMST square-free-moduli paper and theorem chain: https://erdosproblems.ai/wiki/library/covering_systems/balister_2021_erdos_selfridge_problem_square_free_moduli
- BBMST Theorem 3.1 / 3.2 statement as reproduced in the published-paper scan: https://scispace.com/pdf/the-erdos-selfridge-problem-with-square-free-moduli-3xh6gytk2u.pdf
- Lean reliability and statement-fidelity discussion by Thomas Hales, hosted on Terence Tao's blog (2026-10-09): https://terrytao.wordpress.com/2026/10/09/what-mathematicians-should-know-about-the-lean-theorem-proverquestions-of-reliability-and-ai/

## Classification

- Mathematical monotonicity lemmas: not adjudicated by this audit.
- Kernel compilation: does not repair a malformed imported theorem statement.
- Imported BBMST axioms: **require correction / source-level review**.
- Full Erdős–Selfridge conjecture: **not established by this external formalization as presently stated**.
