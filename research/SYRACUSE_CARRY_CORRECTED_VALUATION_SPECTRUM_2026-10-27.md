# Syracuse research note: carry-corrected valuation spectrum (2026-10-27)

## Purpose and status

This note defines a deterministic statistic for realized accelerated Syracuse blocks. It is a research device, not a proof of the Collatz conjecture and not a claim of novelty relative to the literature. Its value is that it separates exact arithmetic from probabilistic assumptions about bit mixing.

## Exact setup

For a positive odd integer trajectory, write
\[
x_{j+1}=\frac{3x_j+1}{2^{a_j}},\qquad
a_j=v_2(3x_j+1)\geq 1.
\]
Let \(A_N=\sum_{j=0}^{N-1}a_j\). Taking logarithms of the exact recurrence gives
\[
\log_2 x_N-\log_2 x_0
=N\log_2 3-A_N+E_N,
\qquad
E_N=\sum_{j=0}^{N-1}\log_2\!\left(1+\frac{1}{3x_j}\right).
\]
Every term in \(E_N\) is positive. This identity is exact, not an expectation.

## Carry-corrected block signature

For a realized block \(B=[i,j)\), define
\[
\mathcal S(B)=\sum_{t=i}^{j-1}a_t-(j-i)\log_2 3
-\sum_{t=i}^{j-1}\log_2\!\left(1+\frac{1}{3x_t}\right).
\]
Then
\[
\mathcal S([i,j))=\log_2(x_i/x_j).
\]
The signature is therefore an exact log-descent certificate for that realized block: positive means the endpoint is smaller; negative means it is larger. It is additive under concatenation of adjacent realized blocks.

This statistic is not an independent Lyapunov function yet: it equals the endpoint log-ratio by construction. The hard question is whether it can be bounded below using only finite, checkable properties of the realized valuation/carry word, strongly enough to exclude a trajectory with \(x_j\to\infty\).

## Falsification-first research program

1. Enumerate only valuation words realized by actual odd starting values, not arbitrary words.
2. For each word length and start range, compare the observed signature with candidate lower bounds based on valuation frequencies, carry runs, and block length.
3. Record the smallest counterexample to each candidate inequality. A finite search can refute a candidate, never prove the universal bound.
4. For a surviving candidate, state every hypothesis explicitly and formalize the finite combinatorial lemma in Lean.
5. Prove a separate realization/extension theorem before using the finite lemma to make a global orbit claim.

## Key obstacle

If \(x_j\to\infty\), then \(\log_2(1+1/(3x_j))\to0\), and its Cesàro mean also tends to zero. Consequently
\[
\frac{A_N}{N}=\log_2 3-\frac{\log_2(x_N/x_0)}{N}+o(1).
\]
This is a necessary asymptotic relation for a divergent orbit, not a contradiction. A proof must rule out the corresponding valuation profiles deterministically; invoking randomness or entropy alone does not do so.

## Formal verification checklist

- Compile the identity with the project's pinned Lean/Mathlib versions.
- Run transitive `#print axioms` on the theorem.
- Audit the definition of \(v_2\), positivity of all states, and the exact accelerated map.
- Do not infer global convergence from the identity alone.
