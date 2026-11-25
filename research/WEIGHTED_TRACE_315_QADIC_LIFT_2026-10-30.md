# Weighted trace bound for the 315 base and prime-power lifts

Date: 30 October 2026

## Result

Let q be any prime q >= 11 and A >= 1. There is no covering system of the integers by pairwise-distinct moduli greater than one if every modulus divides

    N = 315 * q^A.

This is a finite-support exclusion, not the unrestricted Erdős–Selfridge conjecture. It is included because the proof gives a clean weighted-trace inequality at the exact q-adic capacity threshold.

## 1. Old layer and its uncovered set

Write

    D = {d : d | 315, d > 1}
      = {3, 5, 7, 9, 15, 21, 35, 45, 63, 105, 315}.

Complete any proposed covering whose moduli divide N to one residue class for every nontrivial divisor of N. In particular, there is one old class modulo each d in D. Let U be the residues modulo 315 missed by all these old classes, and put n = |U|.

A class modulo d covers exactly 315/d residues modulo 315. Hence the union bound gives

    n >= 315 - sum_{d in D} 315/d
      = 315 * (1 - 103/105)
      = 6.

Thus n >= 6.

## 2. Weighted trace lemma

For every divisor d of 315, define

    c_d(U) = max_{a mod d} |{x in U : x = a (mod d)}|.

For d = 1 this means c_1(U) = n.

**Lemma.** If U is any subset of Z/315Z with n = |U| >= 5, then

    sum_{d | 315} c_d(U) <= 10 n.                 (WT)

### Proof

There are ten proper divisors d with 1 < d < 315. For each such d, let

    delta_d = n - c_d(U),

and let P_d be the number of unordered pairs {x,y} in U that are separated modulo d.

For any partition of an n-element set whose largest block has size n-delta_d, every separated pair has at least one endpoint outside a largest block. Therefore

    P_d <= n * delta_d.                            (1)

Every nonzero difference t modulo 315 is separated by at least three of the ten proper divisors. This follows by the exhaustive cases:

- If 3 does not divide t, then 3, 9, and 15 do not divide t.
- If 3 divides t but 9 does not, then 9, 45, and 63 do not divide t.
- If 9 divides t but 5 does not, then 5, 15, and 35 do not divide t.
- If 9 and 5 divide t, then 7 does not divide t (as 315 does not divide t), so 7, 21, and 35 do not divide t.

Consequently every pair of distinct elements of U is separated by at least three proper divisors, and

    sum_{1 < d < 315, d | 315} P_d >= 3 * binom(n,2).

Combining with (1),

    sum_{1 < d < 315, d | 315} delta_d >= 3(n-1)/2. (2)

Modulo 315 itself all n residues are distinct, so c_315(U)=1 and delta_315=n-1. Thus the total deficit over all eleven nontrivial divisors satisfies

    sum_{d | 315, d > 1} delta_d
      >= (n-1) + 3(n-1)/2
      = 5(n-1)/2
      >= 2n,                                      (3)

where the last inequality uses n >= 5.

Since there are eleven nontrivial divisors,

    sum_{d | 315, d > 1} c_d(U)
      = 11n - sum_{d | 315, d > 1} delta_d
      <= 9n.

Adding c_1(U)=n proves (WT). QED.

## 3. q-adic fibre count

By CRT, residues modulo N correspond to pairs

    (x,z) in (Z/315Z) x (Z/q^A Z).

All fibres above x in U must be covered by classes whose moduli have positive q-adic exponent. For every d | 315 and every j in {1,...,A}, the completed divisor family has exactly one class modulo d q^j.

Such a class can meet at most c_d(U) base fibres above U. In each fibre it covers exactly q^(A-j) of the q^A q-coordinates. Therefore the total number of points in U x Z/q^A covered by all new classes, counted with multiplicity, is at most

    sum_{j=1}^A sum_{d | 315} c_d(U) q^(A-j)
      <= 10n * sum_{j=1}^A q^(A-j)
      = 10n * (q^A - 1)/(q - 1)
      <= n * (q^A - 1)
      < n q^A,

because q >= 11.

But U x Z/q^A contains n q^A points and must be fully covered. Contradiction.

This proves the stated finite-support exclusion for every prime q >= 11 and every finite exponent A. QED.

## 4. Exact finite regression

WEIGHTED_TRACE_315_QADIC_CHECK.py checks:
- the complete divisor list of 315;
- all 314 nonzero differences modulo 315 and the minimum of three proper-divisor separations (attained at 105 and 210);
- the reciprocal sum 103/105 and old-layer union bound 309;
- the integer inequality used in (3);
- the finite geometric-series count for several q >= 11 and A values.

The script is a regression checker for finite arithmetic facts. The universal subset inequality (WT) is proved above by pair counting; the script is not a Lean proof.

## 5. Scope and next obstruction

This proof is a weighted-trace alternative for the fixed base 315. It does not establish the universal full-p minimax inequality for arbitrary prime placements, nor the normalized arbitrary-rank continuation. It therefore does not solve the unrestricted conjecture.

The general template is:

    if sum_{d | M} c_d(U) <= (q-1)|U|
    then no finite q-adic lift over M can cover all fibres above U.

The unresolved task is to prove a source-faithful analogue of this trace inequality for every admissible full-p placement (or produce an exact placement violating it). That is the precise bridge to the root-recursive full-p H=2 minimax problem.

## 6. General pair-separation bound and its limitation

The pair-count argument has a useful general form. Write M = product_i p_i^(a_i), let tau = number of divisors of M, and set

    lambda(M) = min_i (tau/(a_i+1) - 1).

For any nonzero difference t modulo M, choose i with p_i^(a_i) not dividing t. Every divisor d whose p_i-exponent is exactly a_i then fails to divide t. There are tau/(a_i+1) such divisors, including M, so at least lambda(M) proper divisors 1<d<M separate the pair. Equality in this minimum is attained by t=M/p_i for an index i attaining the minimum.

For U subset Z/MZ with n elements, define c_d(U) as above and delta_d=n-c_d(U). Pair counting gives

    sum_{d|M, 1<d<M} delta_d >= lambda(M)(n-1)/2,

while delta_M=n-1. Therefore

    sum_{d|M} c_d(U)
      <= tau*n - ((lambda(M)+2)/2)*(n-1).          (GT)

Consequently (GT) is sufficient for a q-adic lift exclusion whenever

    2*(tau-q+1)*n <= (lambda(M)+2)*(n-1).

For M=315, tau=12 and lambda=3, so this condition reduces to n>=5 when q=11, and the old-layer bound gives n>=6. For M the product of the first eight odd primes, tau=256 and lambda=127; with q=29 the condition fails badly. Thus pair separation alone does not close the high-rank full-p problem. A stronger multi-point/profile inequality, retaining the placement correlations, is still required.

## 7. Exact high-rank adversarial subset: cardinality alone is insufficient

Let M be the product of the first eight odd primes,

    M = 111546435 = 3*5*7*11*13*17*19*23,

and let g=M/(3*5*11)=676039. Take U to be one residue class modulo g inside Z/MZ. Then |U|=165, and every divisor d of g has c_d(U)=165. Since g has five distinct prime factors, it has 2^5=32 divisors. Therefore

    sum_{d|M} c_d(U) >= 32*165 = 5280
    > 28*165 = (29-1)|U|.

The density of this set is 1/676039, which is greater than 1/1002375, the density floor claimed in the rank-nine preprint for families supported on at most eight primes. Thus even that density floor, by itself, cannot force the desired q=29 trace inequality for arbitrary subsets U.

This U is an adversarial set-theoretic example, **not** a demonstrated old-uncovered set arising from one chosen class for every divisor d>1. It does not refute the covering conjecture or the full-p minimax theorem. It shows exactly why the next argument must use the geometry and correlations imposed by the old residue placements, not merely |U| or a density lower bound.
