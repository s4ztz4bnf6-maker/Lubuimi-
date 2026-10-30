# Exact threshold profile for CRT divisor-index collisions (2026-10-30)

## Scope

This note sharpens the multi-prime CRT collision argument by allowing a different threshold K_b at each nonzero exponent vector b. It proves that, for the existing lcm-by-intersection mechanism, the variable profile collapses to one exact uniform lower threshold. It does **not** prove Erdős–Selfridge for arbitrary odd L.

## Setup

Let M>1 be odd and let tau = tau(M), the number of positive divisors of M. Write
p^a || M for each exact prime power and put
c_p = tau/(a+1), the number of divisors d|M divisible by p^a.

Let q_1,...,q_t be distinct primes not dividing M, with A_i >= 1. Set
Q = product_i q_i^{A_i},
N = product_i (A_i+1) - 1.
For a nonzero exponent vector b=(b_i), 0<=b_i<=A_i, write Q_b=product_i q_i^{b_i}.

Suppose a pairwise-distinct-modulus covering uses only divisors of M Q. The old moduli d|M, d>1 leave a set U of residues modulo M uncovered. The elementary union bound gives
|U| >= M(1 - sum_{d|M,d>1} 1/d).
For each x in U, its CRT fibre above x has Q points.

For each nonzero b, let S_{x,b} be the set of divisor labels d|M for which the covering contains the class with modulus d Q_b that matches x in the M-coordinate and the corresponding q_i-adic coordinates. Pairwise distinctness gives at most one such class per d, so |S_{x,b}|<=tau. Each such class covers Q/Q_b points of the fibre.

## Variable-profile capacity lemma

Choose integers K_b in [1,tau], one for every nonzero b. If
  sum_{b != 0} (K_b-1)/Q_b < 1,
then every x in U has at least one nonzero b with |S_{x,b}| >= K_b.

Proof: If a fixed x had |S_{x,b}|<=K_b-1 for every b, the total number of fibre points covered by all non-old classes matching x would be at most
  sum_{b != 0} (K_b-1) Q/Q_b < Q,
which cannot cover its Q-point fibre.

If |U|>N, there are N nonzero exponent vectors and therefore two distinct residues x,y in U sharing one vector b for which both |S_{x,b}| and |S_{y,b}| are at least K_b.

## Exact lcm-intersection threshold

For any such shared b,
  |S_{x,b} intersect S_{y,b}| >= 2K_b - tau.
The complement of this intersection in the tau-element divisor set has size at most 2(tau-K_b).

For a fixed exact prime power p^a||M, precisely c_p=tau/(a+1) divisors d|M are divisible by p^a. Thus the intersection is guaranteed to contain at least one divisor divisible by p^a whenever
  c_p >= 2(tau-K_b)+1.
If this holds for every p^a||M, the common labels have lcm M. Since x and y agree modulo every common label d (the q-coordinate is the same shared b), they agree modulo M, contradicting x != y.

Solving the displayed inequality for K_b gives the exact threshold
  K_b >= K_crit(M)
where
  K_crit(M) = max_{p^a||M} [ tau - floor((c_p-1)/2) ].

Consequently, under this specific intersection proof, allowing a nonuniform profile K_b gives no improvement over the uniform choice K_b=K_crit: every vector must meet the same lower threshold, and the weighted capacity condition is minimized by taking every K_b as small as permitted.

## Combined theorem

If all of the following hold:
1. M(1 - sum_{d|M,d>1} 1/d) > N;
2. K_crit(M) <= tau;
3. (K_crit(M)-1) * ( product_i sum_{j=0}^{A_i} q_i^{-j} - 1 ) < 1,

then no pairwise-distinct-modulus covering can have all moduli dividing M Q.

The identity
  sum_{b != 0} 1/Q_b = product_i(sum_{j=0}^{A_i} q_i^{-j}) - 1
shows that condition 3 is exactly the uniform-profile capacity condition.

## Example M=1155

M=3*5*7*11, tau=16, and each c_p=8. Hence
  K_crit = 16 - floor(7/2) = 13.

For q_1=23, q_2=29 and A_1=A_2=1:
  N=3,
  H=(1+1/23)(1+1/29)-1=53/667,
  (K_crit-1)H=12*53/667=636/667<1.
Also
  M(1-sum_{d|M,d>1}1/d)=6>3.
Thus this recovers the exclusion of all distinct-modulus coverings whose moduli divide 1155*23*29.

## Limitation and next mathematical obstruction

This result closes the variable-threshold optimization only for the existing proof architecture. It does not yield a bound for arbitrary M: the capacity inequality can fail, the old-layer deficit can be too small, and even when the capacity step succeeds, the divisor-intersection condition is only a sufficient criterion for forcing lcm M.

A genuinely stronger global bridge would need information discarded here:
- which divisor labels can actually occur together at a fixed exponent vector;
- compatibility constraints between different exponent vectors;
- residue-dependent structure of U, rather than only its cardinality;
- a stronger hitting/intersection theorem for the family of exact prime-power divisor sets.

No Lean formalization or kernel verification is claimed in this note.
