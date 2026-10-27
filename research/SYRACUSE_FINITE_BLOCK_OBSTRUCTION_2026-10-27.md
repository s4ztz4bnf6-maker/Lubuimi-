# Finite-block obstruction: realizable all-one valuation words

Date: 2026-10-27

## Exact result

Let
\[
T(n)=\frac{3n+1}{2^{v_2(3n+1)}}
\]
be the accelerated odd Syracuse map. For every finite length \(N\ge1\), the positive odd integer
\[
n_0=2^{N+1}-1
\]
has first \(N\) valuations all equal to one.

Proof: if the first \(t\) valuations are one, the affine recurrence gives
\[
2^t n_t=3^t n_0+(3^t-2^t).
\]
The exact-prefix condition for the next valuation is
\[
3^t n_0+(3^t-2^t)\equiv 2^t\pmod {2^{t+1}}.
\]
This simplifies to \(3^t(n_0+1)\equiv0\pmod {2^{t+1}}\). Since \(3^t\) is invertible modulo \(2^{t+1}\), it is equivalent to
\[
n_0\equiv -1\pmod {2^{t+1}}.
\]
Hence \(n_0=2^{N+1}-1\) satisfies every prefix condition for \(t\le N\). The closed form is
\[
n_N=\frac{3^N(n_0+1)}{2^N}-1
=3^N\cdot 2-1,
\]
for this particular minimal start \(n_0=2^{N+1}-1\). So the orbit expands throughout this finite block.

## What this rules out

No argument can prove that *every* sufficiently long fixed-length block strictly descends for *every* positive start. For each proposed block length, an exceptional start realizes the all-one word and expands throughout the block. This does **not** produce one infinite divergent orbit: the start depends on \(N\), and the compatible nested residues may converge to a 2-adic point that is not a positive integer.

Consequently, a viable Lyapunov/carry theorem must instead establish at least one of the following:

1. a state-dependent block length or descent margin;
2. a uniform bound on how long a positive integer can shadow an expanding word as a function of its size;
3. a global constraint coupling admissible words across all prefixes, strong enough to exclude a single positive integer from realizing an infinite expanding itinerary.

A word-entropy heuristic alone is insufficient: finite admissibility permits maximally expanding valuation blocks. The target object should track both the valuation word and its *integer-size cost* (the least positive representative of its 2-adic cylinder). One candidate is the pair
\[
\bigl(c_N(w),\ \log_2(1+n_{\min}(w))\bigr),
\]
not the carry correction alone.

## Audit status

This is an exact finite-window obstruction/reduction, not a counterexample to Collatz and not a global theorem. The congruence calculation should be formalized prefix-by-prefix in Lean before being treated as machine-checked. In particular, do not replace the exact prefix conditions by a final divisibility condition.
