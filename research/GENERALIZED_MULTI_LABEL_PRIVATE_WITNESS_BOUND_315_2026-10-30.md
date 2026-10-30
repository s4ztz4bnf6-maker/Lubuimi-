# Multi-label private-witness obstruction: the exact 315 two-fibre bound

Date: 2026-10-30  
Branch: `research/rank9-crt-fiber-audit-2026-10-30`

## Result

Let
\[
D=\{3,5,7,9,15,21,35,45,63,105,315\}.
\]
Let \(J_1,J_2\subseteq D\) be nonempty and disjoint. In each fibre, take an inclusion-minimal family of residue classes whose union covers the same set \(U\). For \(d\in J_1,f\in J_2\), let
\[
\chi_{df}=1\quad\Longleftrightarrow\quad
a_d\equiv a_f\pmod{\gcd(d,f)}.
\]
Then the exact finite relaxation obtained from all multi-label private-witness obstructions is
\[
\boxed{
\sum_{d\in J_1,f\in J_2}
\chi_{df}\frac{315}{\operatorname{lcm}(d,f)}
\le 164.
}
\tag{1}
\]
Equivalently, the cross-fibre capacity is at most \(164/315\), uniformly over all 173,052 nonempty disjoint assignments of the eleven divisors to the two fibres or omission.

Consequently, if \(U\) is the set left uncovered by a historical family of pairwise-distinct residue classes with moduli \(e_i\), and both fibres cover \(U\), then
\[
\frac{|U|}{315}\le\frac{164}{315},
\qquad
\boxed{\sum_i\frac1{e_i}\ge\frac{151}{315}.}
\tag{2}
\]
The second inequality follows from the historical union bound
\( |U|/315\ge 1-\sum_i1/e_i\).

This improves the previous pairwise-only relaxation \(184/315\), and its reciprocal-sum consequence \(131/315\), to \(164/315\) and \(151/315\), respectively.

## The multi-label crossing lemma

Suppose \(d,e\) are distinct moduli in the same fibre, with \(d\mid e\). Let \(T\) be a nonempty set of moduli in the opposite fibre such that
\[
\operatorname{lcm}_{f\in T}\gcd(d,f)=d.
\tag{3}
\]
If every cross pair \((d,f)\) and \((e,f)\), for \(f\in T\), is compatible, then
\[
a_d\equiv a_f\pmod{\gcd(d,f)},\qquad
a_e\equiv a_f\pmod{\gcd(e,f)}.
\]
Since \(d\mid e\), the second congruence implies
\(a_e\equiv a_f\pmod{\gcd(d,f)}\). Thus
\(a_d\equiv a_e\pmod{\gcd(d,f)}\) for every \(f\in T\).
Condition (3) forces \(a_d\equiv a_e\pmod d\). The class modulo \(e\) is then contained in the class modulo \(d\), contradicting inclusion-minimality of the fibre cover of \(U\).

Therefore, for every such \((d,e,T)\), the full collection of \(2|T|\) cross-compatibilities cannot all hold. In binary notation, at least one of
\[
\{\chi_{df},\chi_{ef}:f\in T\}
\]
must be zero.

The earlier pairwise crossing rule is the special case \(|T|=1\), where (3) says \(d\mid f\). The genuinely new constraints occur when several opposite-fibre labels jointly supply all prime-power factors of \(d\). For example, with \(d=15\) and opposite labels \(3,5\),
\[
\operatorname{lcm}(\gcd(15,3),\gcd(15,5))
=\operatorname{lcm}(3,5)=15.
\]
Thus compatibility with both labels 3 and 5 forces equality modulo 15, even though neither opposite label is itself divisible by 15. This is precisely the interaction missed by a pairwise-only graph.

## Exact finite optimization

For each split \((J_1,J_2)\), make one vertex for each cross pair \((d,f)\), with integer weight
\[
w(d,f)=315/\operatorname{lcm}(d,f).
\]
Every actual compatibility pattern is a subset of these vertices. Each multi-label crossing lemma supplies a hyperedge which may not be fully selected. The maximum total weight under these constraints is computed exactly by a memoized deletion recurrence:

- If no forbidden hyperedge is fully contained in the current available vertex set, keep all remaining vertices; all weights are positive.
- Otherwise, every feasible subset must delete at least one vertex from a violated hyperedge. Branch over each possible deletion and take the maximum.

This recurrence is exact: it explores a partition of all feasible possibilities and uses no floating-point arithmetic or optimization solver.

To reduce the number of hypergraph instances, first compute the pairwise-conflict graph maximum. Every singleton hyperedge is one of the pairwise conflicts, so the generalized feasible set is contained in the pairwise-independent sets. The pairwise maximum is therefore a valid upper bound. Across all 173,052 splits, only 64 have pairwise upper bound at least 164; the remaining splits are already strictly below 164. The generalized exact recurrence on those 64 cases gives maximum 164, attained only by the split
\[
J_1=\{3,5,7\},\quad
J_2=\{9,15,21,35,45,63,105,315\},
\]
and its reversal.

### Reproducible exact checker

The following uses only the Python standard library (Python 3.9+):

```python
from itertools import product, combinations
from functools import lru_cache
from math import gcd, lcm

D = (3, 5, 7, 9, 15, 21, 35, 45, 63, 105, 315)
TARGET = 164

def pairwise_bound(J1, J2):
    edges = tuple((d, f) for d in J1 for f in J2)
    index = {edge: i for i, edge in enumerate(edges)}
    n = len(edges)
    weights = tuple(315 // lcm(d, f) for d, f in edges)
    adj = [0] * n

    for F, O, reverse in ((J1, J2, False), (J2, J1, True)):
        for d in F:
            for e in F:
                if d < e and e % d == 0:
                    for f in O:
                        if f % d == 0:
                            p = (f, d) if reverse else (d, f)
                            q = (f, e) if reverse else (e, f)
                            i, j = index[p], index[q]
                            adj[i] |= 1 << j
                            adj[j] |= 1 << i

    @lru_cache(None)
    def solve(mask):
        if mask == 0:
            return 0
        rest, v, best_degree = mask, -1, -1
        while rest:
            bit = rest & -rest
            i = bit.bit_length() - 1
            rest ^= bit
            degree = (adj[i] & mask).bit_count()
            if degree > best_degree:
                v, best_degree = i, degree
        bit = 1 << v
        return max(
            solve(mask & ~bit),
            weights[v] + solve(mask & ~bit & ~adj[v])
        )

    return solve((1 << n) - 1)

def hypergraph_bound(J1, J2):
    edges = [(d, f) for d in J1 for f in J2]
    index = {edge: i for i, edge in enumerate(edges)}
    n = len(edges)
    weights = tuple(315 // lcm(d, f) for d, f in edges)
    forbidden = set()

    for F, O, reverse in ((J1, J2, False), (J2, J1, True)):
        for d in F:
            for e in F:
                if d >= e or e % d != 0:
                    continue
                for r in range(1, len(O) + 1):
                    for T in combinations(O, r):
                        if lcm(*(gcd(d, f) for f in T)) != d:
                            continue
                        if reverse:
                            H = tuple(sorted(
                                [index[(f, d)] for f in T] +
                                [index[(f, e)] for f in T]
                            ))
                        else:
                            H = tuple(sorted(
                                [index[(d, f)] for f in T] +
                                [index[(e, f)] for f in T]
                            ))
                        forbidden.add(H)

    hmask = tuple(
        sum(1 << i for i in H)
        for H in sorted(forbidden, key=lambda H: (len(H), H))
    )

    @lru_cache(None)
    def solve(mask):
        violated = None
        for hm in hmask:
            if mask & hm == hm:
                violated = hm
                break
        if violated is None:
            return sum(
                weights[i] for i in range(n) if (mask >> i) & 1
            )

        best, bits = -1, violated
        while bits:
            bit = bits & -bits
            bits ^= bit
            best = max(best, solve(mask & ~bit))
        return best

    return solve((1 << n) - 1)

checked = candidates = 0
pair_max = hyper_max = -1
maximizers = []

for assignment in product(range(3), repeat=len(D)):
    J1 = tuple(D[i] for i, t in enumerate(assignment) if t == 1)
    J2 = tuple(D[i] for i, t in enumerate(assignment) if t == 2)
    if not J1 or not J2:
        continue

    checked += 1
    p = pairwise_bound(J1, J2)
    pair_max = max(pair_max, p)
    if p < TARGET:
        continue

    candidates += 1
    h = hypergraph_bound(J1, J2)
    if h > hyper_max:
        hyper_max, maximizers = h, [(J1, J2)]
    elif h == hyper_max:
        maximizers.append((J1, J2))

assert checked == 173052
assert candidates == 64
assert pair_max == 184
assert hyper_max == 164
assert set(maximizers) == {
    ((3, 5, 7), (9, 15, 21, 35, 45, 63, 105, 315)),
    ((9, 15, 21, 35, 45, 63, 105, 315), (3, 5, 7)),
}
print("assignments:", checked)
print("pairwise-filtered cases:", candidates)
print("pairwise maximum:", pair_max)
print("multi-label maximum:", hyper_max)
print("capacity:", f"{hyper_max}/315")
print("historical reciprocal-sum threshold:", "151/315")
print("maximizers:", maximizers)
```

Expected output:
```text
assignments: 173052
pairwise-filtered cases: 64
pairwise maximum: 184
multi-label maximum: 164
capacity: 164/315
historical reciprocal-sum threshold: 151/315
maximizers: [((3, 5, 7), (9, 15, 21, 35, 45, 63, 105, 315)),
             ((9, 15, 21, 35, 45, 63, 105, 315), (3, 5, 7))]
```


### The restricted 5+6 split

Restricting to partitions with \(|J_1|=5\) and \(|J_2|=6\) gives 462 splits. The same exact recurrence has maximum 162, attained (up to reversal) by
\[
J_1=\{3,5,35,63,315\},\qquad
J_2=\{7,9,15,21,45,105\}.
\]
Thus the earlier pairwise-only 5+6 maximum 172/315 is reduced to 162/315 by the multi-label constraints. This restricted maximum is a corollary of the same exact finite checker; it is not a separate analytic inequality.

## Sharpness witness

The bound 164 is attained by actual residue classes with both fibre families inclusion-minimal on their common covered set.

Fibre A:
\[
0\pmod3,\quad0\pmod5,\quad0\pmod7.
\]

Fibre B:
\[
0\pmod9,\ 0\pmod{15},\ 0\pmod{21},\ 0\pmod{35},\
10\pmod{45},\ 7\pmod{63},\ 7\pmod{105},\ 14\pmod{315}.
\]

Let \(U\) be the intersection of the two fibre unions in \(\mathbb Z/315\mathbb Z\). Exact enumeration gives \(|U|=76\). Private witnesses, one for each class, are:

| Fibre A modulus | Private witness | Fibre B modulus | Private witness |
|---:|---:|---:|---:|
| 3 | 9 | 9 | 9 |
| 5 | 10 | 15 | 15 |
| 7 | 7 | 21 | 21 |
|  |  | 35 | 35 |
|  |  | 45 | 10 |
|  |  | 63 | 133 |
|  |  | 105 | 112 |
|  |  | 315 | 14 |

The compatible cross pairs are exactly
\[
\begin{aligned}
&9\leftrightarrow\{3,5,7\},\
&15\leftrightarrow\{3,5,7\},\
&21\leftrightarrow\{3,5,7\},\
&35\leftrightarrow\{3,5,7\},\
&45\leftrightarrow\{5,7\},\
&63\leftrightarrow\{5,7\},\
&105\leftrightarrow\{7\},\
&315\leftrightarrow\{7\}.
\end{aligned}
\]
Their integer weights sum to
\[
47+45+33+21+8+6+3+1=164.
\]
Thus the finite relaxation's maximum is attained by a genuine two-fibre private-witness configuration; it is not merely an unattainable graph bound.

## Scope and verification status

- The multi-label crossing lemma is an ordinary mathematical argument from CRT compatibility, divisibility, and private witnesses.
- The finite maximum 164 is an exact integer computation with a complete recursive search over all splits. The code is reproducible and uses no solver or floating-point arithmetic.
- The sharpness witness verifies that the finite maximum is attainable in the two-fibre model.
- The conditional reciprocal-sum consequence (2) is rigorous under the stated two-fibre hypotheses.
- This does **not** prove that every historical uncovered set in the full Erdős–Selfridge problem satisfies those hypotheses with a useful complementary upper bound on \(\sum_i1/e_i\). It therefore does not prove the conjecture.
- This note is not yet Lean-formalized or kernel-checked. No CI result is claimed for this note.
