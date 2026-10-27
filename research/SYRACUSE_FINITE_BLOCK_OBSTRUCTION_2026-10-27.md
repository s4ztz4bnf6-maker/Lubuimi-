# Finite-block obstruction: realizable all-one valuation words

Date: 2026-10-27

## Result (elementary, exact)

Let
\[
T(n)=\frac{3n+1}{2^{v_2(3n+1)}}
\]
be the accelerated odd Syracuse map. For every finite length \(N\ge 1\), there exists a positive odd integer \(n_0\) whose first \(N\) valuations are all one:
\[
v_2(3n_j+1)=1\quad(0\le j<N),\qquad n_{j+1}=T(n_j).
\]

Reason: prescribe \(a_j=1\) for \(0\le j<N\). The exact prefix condition at time \(t\) is
\[
3^t n_0+(3^t-2^t)\equiv 2^t\pmod {2^{t+1}},
\]
equivalently \(3^t(n_0+1)\equiv 2^{t+1}\pmod {2^{t+1}}\), which reduces to
\[
n_0\equiv -1\pmod {2^{t+1}}
\]
for this displayed offset convention only if the affine expression is handled consistently. More directly, use the recurrence
\[
n_{j+1}=\frac{3n_j+1}{2}
\]
and recursively solve the exact congruences \(3n_j+1\equiv2\pmod4\). At each prefix the coefficient of \(n_0\) is an odd power \(3^t\), hence invertible modulo \(2^{t+1}\); the prefix cylinders are nested and determine one residue class modulo \(2^{N+1}\). Its odd positive representative realizes the word.

For this word,
\[
n_N=\frac{3^N(n_0+1)}{2^N}-1.
\]
Thus \(n_N\) grows like \((3/2)^N n_0\) over that finite block.

## What this rules out

No argument can prove that *every* sufficiently long fixed-length block strictly descends for *every* positive start. For each proposed block length, an exceptional start realizes the all-one word and expands throughout the block. This does **not** produce one infinite divergent orbit: the start depends on \(N\), and the compatible nested residues may converge to a 2-adic point that is not a positive integer.

Consequently, a viable Lyapunov/carry theorem must be one of the following:

1. a state-dependent block length or margin;
2. a uniform bound on how long a positive integer can shadow an expanding word as a function of its size;
3. a global constraint coupling admissible words across all prefixes, strong enough to exclude a single positive integer from realizing an infinite expanding itinerary.

A word-entropy heuristic alone is insufficient: finite admissibility permits maximally expanding valuation blocks. The target object should track both the valuation word and its *integer-size cost* (the least positive representative of its 2-adic cylinder). This is a sharper version of the realizable carry envelope, and a potential candidate is the pair
\[
\bigl(c_N(w),\ \log_2(1+n_{\min}(w))\bigr),
\]
not the carry correction alone.

## Audit status

This is an exact finite-window obstruction/reduction, not a counterexample to Collatz and not a global theorem. The congruence calculation should be formalized prefix-by-prefix in Lean before being treated as machine-checked. In particular, do not replace the exact prefix conditions by a final divisibility condition.
