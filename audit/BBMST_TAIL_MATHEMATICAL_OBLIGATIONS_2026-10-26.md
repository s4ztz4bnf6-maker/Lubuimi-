# BBMST: exact mathematical obligations behind the independent tail checker
Date: 2026-10-26

This note separates the arithmetic algorithm from the proof that its output entails the published result.

## Prime generator
For each odd segment [low, high] with step two, the sieve marks odd multiples of each odd base prime p starting at max(p^2, the first multiple >= low), adjusted to odd parity. Completeness requires: every odd composite x in the segment has a prime divisor p <= sqrt(x), so it is marked; soundness requires every marked number is composite. Segment boundaries must be disjoint and exhaustive, and the initial 2 must be emitted exactly once. These invariants are not presently proved in Lean by the replay script.

## Fixed-point recurrence
The implementation uses integer arithmetic and ceiling division. For every update, the formal proof must identify the real/rational quantity enclosed by f and h, prove the radicand and integer-square-root inequalities in the required direction, and show that each floor/ceiling preserves the stated upper/lower enclosure. The strict-survival denominator must be positive before cross multiplication.

## Logarithmic enclosures
For 1 <= z, set t=(z-1)/(z+1). Then 0 <= t < 1 and
log z = 2 atanh(t) = 2 sum_{j>=0} t^(2j+1)/(2j+1).
Every omitted term is nonnegative, so a finite partial sum is a lower bound. The implementation reduces x by powers of two to x in [1,2), adding an integer multiple of log 2. Formal closure must prove the reduction preserves the exact input and that the rational rounding-down step remains a lower bound. To enclose log(log k), first prove the lower bound for log k is positive, then use monotonicity of log on positive reals.

## Published theorem bridge
The final argument must match the checker’s recurrence, initialization, prime indexing, and strict terminal inequality to the exact published Corollary 5.2. Then the paper's preceding lemmas must be linked to the independently checked parameter and finite-measure components, with all hypotheses discharged. The final theorem's Lean axiom dependency report must be attached to the theorem constant itself.

## Status
Independent arithmetic replay: passed in CI run 40412287064.
Sieve completeness proof, recurrence-enclosure proof, complete source-to-theorem mapping, and final theorem-level axiom audit: still open. This is the acceptance boundary; do not label the theorem fully proved before these obligations are closed.
