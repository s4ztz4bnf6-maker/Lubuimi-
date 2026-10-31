# Private-witness divisibility relaxation and the exact 315-support boundary

Date: 2026-10-30  
Branch: research/rank9-crt-fiber-audit-2026-10-30

## 1. Private-witness implication

Let the eleven distinct moduli be
D = {3,5,7,9,15,21,35,45,63,105,315},
partitioned into two fibres J_1,J_2 of sizes 5 and 6. Let A_d be the selected residue class modulo d, with compatibility indicator
chi_de = 1 iff a_d = a_e (mod gcd(d,e)).

Assume every one of these eleven actual classes is essential in the full covering system. Since different fibre labels are disjoint in the added coprime fibre coordinate, a private witness for a class in fibre t must avoid all other projected classes in that same fibre. In particular, if d,e are in the same fibre, d|e, and f is in the opposite fibre with d|f, then
                         not (chi_df = 1 and chi_ef = 1).       (PW-div)

Proof: If both compatibilities held, then a_d = a_f (mod d), and a_e = a_f (mod gcd(e,f)). Since d|e and d|f, d divides gcd(e,f), so a_e = a_f (mod d). Hence a_e = a_d (mod d), and therefore A_e is contained in A_d. The class A_e then has no private witness against the other classes in its own fibre, contradiction.

This is only a necessary consequence of private witnesses. It does not encode all private-witness conditions.

## 2. Exact finite relaxation

Make a weighted bipartite graph whose 30 vertices are the cross-fibre pairs (d,f), d in J_1, f in J_2, with integer weight
                         w(d,f) = 315/lcm(d,f).
For every instance of (PW-div), join the two cross-pair vertices (d,f) and (e,f) by a conflict edge. Any actual compatibility pattern of an irredundant 11-class configuration is an independent set in this conflict graph.

Exhausting all 462 choices of J_1 of size 5 and solving the maximum-weight independent-set problem exactly by a memoized bitmask recurrence gives
                         max weight = 172.
The unique maximizing partition is
J_1 = {3,5,7,105,315},
J_2 = {9,15,21,35,45,63}.
The maximizing independent set consists of all 18 cross pairs from {3,5,7} to J_2; its integer weight is 172. Thus every actual irredundant two-fibre configuration in this 5+6 setting satisfies
                         sum_cross chi_df/lcm(d,f) <= 172/315.  (1)
This is a rigorous upper bound from a relaxation; equality has not been shown attainable by actual residue assignments satisfying every private-witness and coverage condition.

For each x in U, complete coverage in both fibres supplies at least one cross pair containing x. Therefore
|U|/P <= sum_cross |U intersect A_d intersect A_f|/P
       <= sum_cross chi_df/lcm(d,f)
       <= 172/315.
If the historical classes have distinct moduli e_i, the union bound gives
|U|/P >= 1 - sum_i 1/e_i.
Consequently
                         sum_i 1/e_i >= 143/315.                (2)
This improves the earlier 25/63 = 125/315 threshold by 18/315 = 2/35.

Hypothesis warning: all eleven listed classes must be essential and retained in the two-fibre cover. If some are redundant and are removed when passing to a minimal subcover, the 5+6 conflict-graph bound does not automatically apply to the reduced family.

## 3. Exact checker

The following code uses only integer weights and an exact maximum-weight-independent-set recurrence. It checks all 462 partitions. It is an executable finite certificate, not a Lean kernel proof.

```python
from functools import lru_cache
from itertools import combinations
from math import lcm

D = (3, 5, 7, 9, 15, 21, 35, 45, 63, 105, 315)

def solve_partition(J1):
    J1 = set(J1)
    J2 = set(D) - J1
    edges = [(d, f) for d in sorted(J1) for f in sorted(J2)]
    index = {edge: i for i, edge in enumerate(edges)}
    weights = [315 // lcm(d, f) for d, f in edges]
    adj = [0] * len(edges)

    # A conflict means these two cross compatibilities cannot
    # both hold if every same-fibre class has a private witness.
    for F, O in ((J1, J2), (J2, J1)):
        for d in F:
            for e in F:
                if d < e and e % d == 0:
                    for f in O:
                        if f % d == 0:
                            u = index[(d, f)] if (d, f) in index else index[(f, d)]
                            v = index[(e, f)] if (e, f) in index else index[(f, e)]
                            adj[u] |= 1 << v
                            adj[v] |= 1 << u

    @lru_cache(None)
    def mwis(mask):
        if mask == 0:
            return 0, 0
        vertices = [i for i in range(len(edges)) if (mask >> i) & 1]
        v = max(vertices, key=lambda i: (adj[i] & mask).bit_count())

        without = mwis(mask & ~(1 << v))
        rest = mask & ~(1 << v) & ~adj[v]
        value, chosen = mwis(rest)
        with_v = (value + weights[v], chosen | (1 << v))
        return with_v if with_v[0] > without[0] else without

    return mwis((1 << len(edges)) - 1)[0]

results = [(solve_partition(J1), J1) for J1 in combinations(D, 5)]
best = max(value for value, _ in results)
maximizers = [J1 for value, J1 in results if value == best]

assert len(results) == 462
assert best == 172
assert maximizers == [(3, 5, 7, 105, 315)]

print("partitions:", len(results))
print("maximum integer weight:", best)
print("capacity:", f"{best}/315")
print("unique maximizing J1:", maximizers[0])
print("historical reciprocal-sum threshold:", "143/315")
```

## 4. The genuinely complete 315-LCM case

If the *entire* odd distinct covering system has LCM exactly 315, every modulus must be one of the eleven divisors in D. Their total reciprocal sum is
                         sum_{d in D} 1/d = 103/105 < 1.
The union bound then says the density of the union of all its classes is at most 103/105, so it cannot cover the integers. This proves outright nonexistence for LCM exactly 315, without any private-witness assumption.

This is different from the enlarged-period model in which historical moduli introduce primes outside {3,5,7}. In that case the full LCM is not 315, and the preceding density argument alone does not prove nonexistence.

## 5. General frontier: theorem versus conjecture

The odd distinct covering-system conjecture itself asks whether any finite covering system can have pairwise distinct odd moduli greater than one. It remains open.

A September 2026 preprint by Michael Schroeder, version 1.0.1, claims and supplies a Lean formalization of the stronger necessary condition that every such cover has at least nine distinct prime divisors in its LCM. It also claims the quantitative lower bound LCM >= 9,704,539,845 and a positive uncovered-density bound for families supported on at most eight primes. Its proof package contains 24,918 Lean source files. The companion explicitly says version 1.0.1 verifies source identity and packaging and does not claim a new full Lean kernel replay. This is an external result; this repository note does not reproduce or independently verify its proof.

Consequences for the present 315 block:
* A full cover whose moduli all divide 315 is excluded by the elementary 103/105 density argument.
* Any hypothetical full odd distinct cover containing the three-prime support {3,5,7} must, by the external rank-nine theorem, introduce at least six further distinct primes somewhere among its moduli.
* The local private-witness relaxation (1) and historical density threshold (2) are new finite necessary conditions for the stated 5+6 block, not a proof of the full conjecture.

## 6. Five-source audit discipline

1. Quanta (3 Aug 2026) describes AI-assisted progress on other Erdős problems, especially the unit-distance problem; it is methodological context, not evidence for this covering result.
2. Tao/Hales (9 Oct 2026) stresses kernel checking and human statement-fidelity audits. Accordingly, this note labels the Python finite checker separately from a Lean proof.
3. ProofAtlas states that its route map is not proof evidence and lists outstanding minimax/arbitrary-rank obligations. Its snapshot predates the September rank-nine preprint and must not be used to erase that later result.
4. MAA (1 Jun 2026) discusses the unit-distance Erdős problem, not Erdős–Selfridge Problem 7.
5. OpenAI's 6 Oct 2026 mathematics release explains its release and formalization practices; it supplies no proof of the present covering-system claims.

## Status

* Exact 315-LCM impossibility: proved by reciprocal-density sum.
* 5+6 private-witness divisibility relaxation: exact finite maximum 172/315, checked by deterministic integer recurrence.
* Historical density consequence: sum 1/e_i >= 143/315 under the stated irredundancy and fibre hypotheses.
* Full enlarged-period 315-base configuration with arbitrary historical moduli: not excluded by these bounds alone.
* General odd distinct covering conjecture: not solved here; external rank-nine necessary condition is recorded separately.
* No Lean kernel or CI verification is claimed for this note.
