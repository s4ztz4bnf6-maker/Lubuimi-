# BBMST independent prime-tail replay: acceptance record
Date: 2026-10-26

## Confirmed computation

Workflow run 40412287064 completed successfully. Its job replay-three-components has conclusion success, including:
- finite measure certificate replay;
- independent second implementation of the finite measure certificate;
- rational distortion parameter replay;
- original large-prime recurrence and logarithmic termination replay;
- independent exact-rational parameter replay;
- independent prime-tail and logarithmic-termination replay.

The independent tail implementation is audit/independent_bbmst_tail.py. It uses an odd-only segmented sieve, integer fixed-point recurrence updates, and rational atanh-series lower bounds. The recorded terminal state is index 14,000,000, prime 256,203,161.

This confirms that the implemented arithmetic pipeline can be reproduced independently. It does not yet prove the published theorem, and does not prove by itself that the sieve, recurrence, enclosure propagation, and theorem reduction satisfy their mathematical specifications.

## Closure order and proof obligations

### 1. Prime enumeration
Prove each odd segment invariant: each unmarked entry is prime, every composite in the segment is marked by a prime divisor no larger than its square root, and each integer is emitted exactly once. Separately prove the base sieve invariant.

### 2. Recurrence enclosure
For each update, state the exact real/rational recurrence and the direction of every rounding operation. Prove by induction that the stored fixed-point integer is an upper enclosure. In particular, prove the integer square-root estimate encloses the intended radical in the required direction, and prove ceiling division preserves the upper bound.

### 3. Logarithmic lower bounds
For z >= 1, the identity
log z = 2 sum_{j=0}^{m-1} t^(2j+1)/(2j+1) + R_m, with t=(z-1)/(z+1) and R_m >= 0,
gives a rational lower bound when 0 <= t < 1. The code first reduces the input by powers of two; prove that reduction and additivity of log preserve the lower enclosure. Then prove the second application at the rational lower bound remains a lower bound for log log k, using positivity and monotonicity.

### 4. Terminal implication
Prove the computed rational lower bounds imply the exact analytical terminal inequality, retaining strictness. The checker must compare the same recurrence state and index as the published corollary.

### 5. Source-to-theorem mapping
Match every recurrence constant, initial condition, prime-index convention, and terminal inequality against the final published statement. Then link the recurrence, parameter and finite-configuration components to the published lemmas with all hypotheses proved. Finish with an explicit theorem-level axiom audit in the intended formal system, or state precisely which part remains an externally checked certificate.

## Current status

- Independent arithmetic replay: PASSED (run 40412287064).
- Mathematical proof of sieve completeness and recurrence enclosure: OPEN.
- Published-source correspondence for the complete chain: OPEN.
- Final theorem-level proof/axiom audit: OPEN.

No conclusion stronger than “independent computational replay succeeded” is justified until the open proof obligations are discharged.
