# Syracuse next experiment: first-descent spectrum and exact witness

Date: 2026-10-27

Status: bounded exact-integer computation and research target; not Lean-checked and not a Collatz proof.

## 1. Question tested

For each odd start n > 1, let k(n) be the least positive k such that the accelerated Syracuse iterate T^k(n) < n, if such a k is found. The global induction strategy would need existence of this k for every odd n > 1. A finite computation cannot establish that universal statement, but it can identify hard finite cases and provide exact regression witnesses.

Use
T(n) = (3n+1) / 2^v2(3n+1)
for positive odd n.

## 2. Bounded scan

A direct exact-integer scan over every odd n with 3 <= n <= 200000 found a first descent for every tested start within 5000 accelerated steps. The maximum first-descent time in this finite range was 85, uniquely at n = 35655, where T^85(n) = 29405.

The exact valuation word for this witness has length 85. Its cumulative exponent and affine offset at the first descent are

- A_85 = 135
- C_85 = 128297408958579634095795478197521347382875
- D_85 = 2^135 - 3^85 = 7638597418194063957503729671115189749325
- T^85(35655) = 29405 < 35655.

These values satisfy the exact margin condition C_85 < D_85 * 35655. This is a regression witness for the affine formula and descent inequality, not evidence that all starts descend.

## 3. What the scan does and does not establish

It checks a finite range of starts, not all positive odd integers. It neither excludes a nontrivial cycle nor excludes a divergent orbit. Do not turn “all tested starts descend” into a global stopping-time theorem.

The important test harness should preserve, for each start, the least k and exact values (A_k, C_k, D_k, n_k). Any future Lean statement about the first descent can be compared to these concrete witnesses.

## 4. Next proof target

Formalize a prefix-level statement independent of the global Collatz conjecture:

For a fixed valuation word w of length k, define A_k, C_k by the existing recurrence and D_k = 2^A_k - 3^k. Prove the exact equivalence
n_k < n iff C_k < D_k * n
for a positive odd n whose first k valuations realize w.

Then isolate the genuinely global claim as a separate theorem:

For every odd n > 1, some prefix of its realized valuation word satisfies D_k > 0 and C_k < D_k*n.

Do not assume the second statement while proving the first. If the universal prefix claim fails, the counterexample must be an actual start and its actual valuation prefix, not merely an arbitrary symbolic word.

## 5. Acceptance gate

- Exact integer recurrence and witness tests pass.
- Lean formalization compiles under the pinned toolchain.
- The target theorem's transitive axiom report is inspected.
- No claim of global proof unless the universal prefix theorem is proved without unapproved axioms.
