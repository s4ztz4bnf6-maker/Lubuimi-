# Carry-energy Lyapunov candidate for accelerated Syracuse blocks

Status: research note, not a proof of global Collatz termination.

## Exact block identity

Let x_0 be a positive odd integer and prescribe a realized valuation word a_0,...,a_{N-1}, where a_i = v_2(3 x_i + 1) and x_{i+1} = (3 x_i + 1)/2^{a_i}. Put A = sum_i a_i.

Repeated substitution gives an integer C >= 0, depending on the realized word, such that

    2^A x_N = 3^N x_0 + C.

Consequently

    log(x_N/x_0) = N log 3 - A log 2 + log(1 + C/(3^N x_0)).

This identity isolates three competing contributions: baseline drift N log 3 - A log 2; carry/offset correction C; and scale penalty 1/x_0. A block descends exactly when 3^N x_0 + C < 2^A x_0. Thus A log 2 > N log 3 alone is not sufficient unless the offset is also bounded.

## A carry-energy candidate

For a fixed realized word define normalized offset energy E(word,x_0) = log(1 + C/(3^N x_0)). Then the exact block log-drift is Delta = N log 3 - A log 2 + E.

This is a bookkeeping identity, not yet a Lyapunov theorem: E depends on the starting value and carry structure, and it is not known here to decrease along all trajectories. The promising falsifiable target is a uniform carry bound C/(3^N x_0) <= B(word) strong enough that A log 2 - N log 3 > log(1+B(word)). A mere entropy or pseudorandomness heuristic does not establish this deterministic inequality.

## Why entropy alone is insufficient

The number of 1s in x, a Shannon entropy of sampled blocks, or an assumed mixing property does not control the exact carry offset C for every admissible orbit. A valid global proof needs a deterministic carry bound, a rigorously justified exceptional-set argument plus separate treatment of exceptions, or a different invariant that excludes non-descending cycles and divergent orbits.

## Next formal milestones

1. Prove the affine identity by induction for an abstract valuation word.
2. Prove the exact equivalence between descent and the offset inequality.
3. Formalize valuation-word realizability separately from the affine identity.
4. Search for counterexamples to candidate uniform carry bounds by exhaustive finite enumeration; treat this only as falsification, not proof.
5. Only then test a proposed potential function on all transition cases and audit its axioms.

No claim is made that Collatz termination or exclusion of divergent trajectories has been proved.
