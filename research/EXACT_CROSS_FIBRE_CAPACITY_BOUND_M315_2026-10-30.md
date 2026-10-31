# Exact cross-fibre capacity bound for the 11 divisors of 315

Date: 2026-10-30  
Scope: the two-fibre split of the 11 distinct moduli
D = {3,5,7,9,15,21,35,45,63,105,315}, with fibre sizes 5 and 6.

## Theorem

Let P be any positive integer divisible by 315. Let J_1,J_2 partition D, with |J_1|=5 and |J_2|=6. For each d in D choose a residue a_d modulo d and put
A_d = {x in Z/PZ : x = a_d (mod d)}.
Write
chi_de = 1 iff a_d = a_e (mod gcd(d,e)).
Define the cross-fibre capacity
S(J_1,J_2,a) = sum_{d in J_1} sum_{e in J_2}
                 |U intersect A_d intersect A_e| / P
for any U subset Z/PZ.

Then
S(J_1,J_2,a) <= sum_{d in J_1,e in J_2} chi_de/lcm(d,e)
              <= 38/63.

Both inequalities are exact and require no assumption on U, on the historical classes, or on irredundancy.

Moreover,
max_{|J_1|=5, |J_2|=6, a} sum_{d in J_1,e in J_2} chi_de/lcm(d,e) = 38/63.
The maximum is attained by taking all a_d=0 and, for example,
J_1={9,15,21,35,315},
J_2={3,5,7,45,63,105}.
There are 80 labelled 5+6 partitions attaining the maximum among the 462 possible choices of J_1.

## Proof

For every pair d,e, generalized CRT gives
|A_d intersect A_e|/P = chi_de/lcm(d,e).
Since U intersect A_d intersect A_e is a subset of A_d intersect A_e,
|U intersect A_d intersect A_e|/P <= chi_de/lcm(d,e) <= 1/lcm(d,e).

Summing over cross-fibre pairs gives
S <= sum_{d in J_1,e in J_2} 1/lcm(d,e).
It remains to maximize this rational sum over the 462 choices of J_1 of size 5. Exact exhaustive enumeration (code below, using Fraction throughout) gives maximum 38/63. The displayed partition attains it. For this partition, all residues zero make every pair CRT-compatible, so chi_de=1 for all 30 cross pairs. Thus the bound 38/63 is not merely an estimate for the unconstrained compatibility problem: it is its exact maximum.

## Consequence for complete two-fibre coverage

Assume the cross-fibre coverage condition:
for every x in U, x belongs to at least one A_d with d in J_1 and at least one A_e with e in J_2.
Each x in U then contributes at least one to the total cross-pair incidence count. Therefore
|U| <= sum_{d in J_1,e in J_2} |U intersect A_d intersect A_e|.
Combining with the theorem yields the exact necessary condition
                         |U|/P <= 38/63.                 (1)

This remains valid when P is larger than 315 because of historical moduli: only 315|P is needed, and every new class has modulus d|315. In particular it does not assume the historical classes themselves are classes modulo 315.

If the historical classes are A_i^hist with pairwise distinct moduli e_i, the elementary union bound gives
|U|/P >= 1 - sum_i 1/e_i.
Consequently any such complete two-fibre configuration must satisfy
                 sum_i 1/e_i >= 25/63,                 (2)
unless the sum already exceeds 1, in which case (2) is automatic.
This is a necessary condition, not a sufficient condition.

## What this does and does not prove

* Proved: a uniform, history-independent upper bound 38/63 for the normalized cross-fibre pair capacity in the 315-divisor, 5+6 setting.
* Proved: complete two-fibre coverage forces the historical reciprocal-modulus sum to be at least 25/63.
* Not proved: nonexistence of an odd distinct covering system. The historical sum can exceed 25/63, so (2) alone does not contradict admissibility.
* Not proved: the same bound for more than two fibre labels or for a different set of new moduli.
* The maximum uses a_d=0 and therefore certifies compatibility capacity, not the existence of private witnesses or a complete cover. Those are separate constraints.

## Exact exhaustive verifier (Python 3)

```python
from fractions import Fraction
from itertools import combinations
from math import lcm

D = (3, 5, 7, 9, 15, 21, 35, 45, 63, 105, 315)

best = Fraction(-1, 1)
maximizers = []
rows = []

for left in combinations(D, 5):
    L = set(left)
    right = tuple(d for d in D if d not in L)
    capacity = sum(
        (Fraction(1, lcm(d, e)) for d in left for e in right),
        Fraction(0, 1)
    )
    rows.append((capacity, left, right))
    if capacity > best:
        best = capacity
        maximizers = [(left, right)]
    elif capacity == best:
        maximizers.append((left, right))

assert len(rows) == 462
assert best == Fraction(38, 63)
assert len(maximizers) == 80

witness_left = (9, 15, 21, 35, 315)
witness_right = tuple(d for d in D if d not in witness_left)
assert witness_right == (3, 5, 7, 45, 63, 105)
assert (witness_left, witness_right) in maximizers

# Exact cross-pair incidence upper bound on Z/PZ:
# sum |U ∩ A_d ∩ A_e| <= P * 38/63.
# For P=315 this is 190.
assert 315 * best == 190

print("partitions checked:", len(rows))
print("exact maximum:", best)
print("maximizing labelled partitions:", len(maximizers))
print("witness partition:", witness_left, witness_right)
print("incidence bound for P=315:", 190)
print("historical reciprocal-sum threshold:", Fraction(25, 63))
```

## Research-source discipline

This finite calculation is independent of claims in the external research sources. Quanta and the MAA article concern AI-assisted progress on the planar unit-distance problem, not this covering-system theorem. Tao/Hales's Lean discussion motivates exact statement and axiom auditing, not the mathematical inequality itself. ProofAtlas explicitly labels its route map as not proof evidence and records open minimax/arbitrary-rank obligations. OpenAI's mathematics release describes its own result-sharing and Lean formalizations; it does not verify this project. The present result is established by the CRT argument and the finite rational enumeration above, not by analogy with those sources.
