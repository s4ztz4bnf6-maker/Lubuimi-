# Syracuse logarithmic drift identity and divergence audit

Date: 2026-10-27  
Status: exact derived identity; necessary condition only, not a Collatz proof.

## Definitions

Let \(x_0,x_1,\ldots\) be an odd accelerated Syracuse orbit, with
\[
x_{j+1}=\frac{3x_j+1}{2^{a_j}},\qquad
a_j=v_2(3x_j+1)\ge 1.
\]
Set \(A_N=\sum_{j=0}^{N-1}a_j\).

## Exact logarithmic identity

Since
\[
x_{j+1}=\frac{3x_j}{2^{a_j}}
\left(1+\frac{1}{3x_j}\right),
\]
taking base-2 logarithms and summing gives
\[
\log_2 x_N=\log_2 x_0+N\log_2 3-A_N+
E_N,
\qquad
E_N=\sum_{j=0}^{N-1}\log_2\left(1+\frac{1}{3x_j}\right).
\]
Equivalently,
\[
\frac{A_N}{N}=\log_2 3-
\frac{\log_2 x_N-\log_2 x_0}{N}+\frac{E_N}{N}.
\]

## Consequence under divergence to infinity

If \(x_j\to\infty\), then
\(\log_2(1+1/(3x_j))\to0\). By Cesàro convergence,
\(E_N/N\to0\). Hence
\[
\boxed{\frac{A_N}{N}=\log_2 3-
\frac{\log_2 x_N}{N}+o(1).}
\]
In particular, because \(x_N\to\infty\), eventually \(\log_2 x_N\ge0\), so
\[
\limsup_{N\to\infty}\frac{A_N}{N}\le\log_2 3.
\]
If the exponential growth rate \(\gamma=\lim_N (\log_2 x_N)/N\) exists, then
\[
\lim_N A_N/N=\log_2 3-\gamma.
\]

This is an exact bookkeeping identity plus a conditional asymptotic consequence. It does **not** rule out divergence: it only says that a diverging orbit's average valuation is linked to its logarithmic growth rate.

## Why this is useful and what it does not solve

1. It separates the valuation budget \(A_N\) from the small additive correction \(E_N\).
2. Under the specific hypothesis \(x_j\to\infty\), the correction is sublinear without any random-bit or entropy assumption.
3. The remaining obstacle is to prove a contradictory lower bound on \(A_N/N\), or another deterministic bound that conflicts with the identity, for every admissible orbit.
4. A probabilistic heuristic for typical valuation sequences cannot supply that universal lower bound. Any proposed block-entropy or acoustic/spectral statistic must be converted into a deterministic statement about all admissible valuation words.

## Formalization target

Formalize first the finite identity over positive rationals or reals, then the valuation recurrence and the conditional Cesàro limit. Keep this lemma separate from any conjectural global claim. The target is an auditable necessary condition for divergence, not a claimed resolution.
