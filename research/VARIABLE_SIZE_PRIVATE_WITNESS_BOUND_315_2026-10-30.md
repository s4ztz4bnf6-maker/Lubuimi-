# Variable-size two-fibre private-witness bound over the 315 divisor block

Date: 2026-10-30  
Branch: research/rank9-crt-fiber-audit-2026-10-30

## Result

Let
\[
D=\{3,5,7,9,15,21,35,45,63,105,315\}.
\]
Suppose a set \(U\) is covered by two labelled fibres of residue classes whose moduli are disjoint subfamilies \(J_1,J_2\subseteq D\). Assume each fibre separately covers \(U\). In each fibre, first discard redundant classes until the retained family is inclusion-minimal among subfamilies that still cover \(U\).

For a retained class modulo \(d\), write its residue as \(a_d\), and define
\[
\chi_{df}=1\quad\Longleftrightarrow\quad
a_d\equiv a_f\pmod{\gcd(d,f)}.
\]
Then the following exact finite relaxation holds, uniformly over every nonempty disjoint pair \(J_1,J_2\subseteq D\):
\[
\boxed{
\sum_{d\in J_1,\ f\in J_2}
\frac{\chi_{df}}{\operatorname{lcm}(d,f)}
\le \frac{184}{315}.
}
\tag{1}
\]
Consequently, if \(U\) is the set left uncovered by a historical family of congruence classes with pairwise distinct moduli \(e_i\), then
\[
\frac{|U|}{P}\le\frac{184}{315},
\qquad
\boxed{\sum_i\frac1{e_i}\ge\frac{131}{315}},
\tag{2}
\]
where \(P\) is a common period and the density statements are interpreted over that period.

This closes the earlier hypothesis gap for the 315-block model: the stronger \(172/315\) bound required all eleven classes to be retained and essential in a 5+6 split. After arbitrary pruning, the uniform bound is \(184/315\), and it applies to every nonempty two-fibre split of every retained subset of \(D\).

## Proof of the relaxation

If \(d,e\) lie in the same fibre, \(d<e\), and \(d\mid e\), then a private witness for the class modulo \(e\) must avoid the class modulo \(d\). If an opposite-fibre modulus \(f\) is also divisible by \(d\), the two compatibilities
\[
\chi_{df}=1,\qquad \chi_{ef}=1
\]
would imply
\[
a_d\equiv a_f\pmod d,
\qquad
a_e\equiv a_f\pmod{\gcd(e,f)}.
\]
Since \(d\mid e\) and \(d\mid f\), this gives \(a_e\equiv a_d\pmod d\). Thus the class modulo \(e\) is contained in the class modulo \(d\), contradicting its private witness. Hence
\[
\neg(\chi_{df}=1\land\chi_{ef}=1)
\tag{PW-div}
\]
for every such triple.

For a fixed split \((J_1,J_2)\), form a weighted graph with vertices the cross pairs \((d,f)\), \(d\in J_1,f\in J_2\), and integer vertex weight
\[
w(d,f)=\frac{315}{\operatorname{lcm}(d,f)}.
\]
Join \((d,f)\) and \((e,f)\) whenever (PW-div) forbids their simultaneous selection; do the symmetric construction when the divisible pair lies in \(J_2\). Every actual compatibility pattern is an independent set in this graph. Therefore its cross-weight is bounded by the graph's maximum-weight independent-set value divided by 315.

There are exactly \(3^{11}-2\cdot2^{11}+1=173052\) assignments of the eleven moduli to fibre 1, fibre 2, or omission, with both fibres nonempty. Exhaustive exact enumeration of all these assignments, using integer weights and a memoized maximum-weight-independent-set recurrence, gives maximum value 184. The only maximizing assignments are
\[
(J_1,J_2)=
(\{3,5,7\},\{9,15,21,35,45,63,105,315\})
\]
and its reversal. In this maximizing split the conflict graph has no edges, and the sum of all 24 cross weights is exactly 184. Thus the maximum is both attained by the relaxation and globally maximal over all splits.

For every \(x\in U\), coverage by each fibre supplies at least one class from each fibre containing \(x\). Therefore
\[
|U|\le\sum_{d\in J_1,f\in J_2}|U\cap A_d\cap A_f|.
\]
For compatible residue classes, their intersection has density \(1/\operatorname{lcm}(d,f)\); incompatible classes have empty intersection. Combining this with (1) gives the first inequality in (2). The historical union bound gives
\[
|U|/P\ge 1-\sum_i1/e_i,
\]
and hence the reciprocal-sum lower bound in (2).

The pruning step is legitimate because each fibre covers \(U\) independently: remove redundant classes separately in each fibre until an inclusion-minimal cover of \(U\) remains. Every retained class then has a private witness relative to its own fibre. The retained moduli remain disjoint subsets of \(D\), so the uniform enumeration applies.

## Exact finite checker

The following standalone Python checker uses only integer weights and exact bitmask recursion. It checks all 173,052 nonempty two-fibre assignments and asserts the maximum and the two maximizers.

\`\`\`python
from itertools import product
from functools import lru_cache
from math import lcm

D = (3, 5, 7, 9, 15, 21, 35, 45, 63, 105, 315)

@lru_cache(None)
def mwis(edges, conflicts):
    n = len(edges)
    adj = [0] * n
    for i, j in conflicts:
        adj[i] |= 1 << j
        adj[j] |= 1 << i
    weights = tuple(315 // lcm(d, f) for d, f in edges)

    @lru_cache(None)
    def solve(mask):
        if mask == 0:
            return 0
        v, best_degree = -1, -1
        rest = mask
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

best = -1
maximizers = []
checked = 0

for assignment in product(range(3), repeat=len(D)):
    J1 = tuple(D[i] for i, x in enumerate(assignment) if x == 1)
    J2 = tuple(D[i] for i, x in enumerate(assignment) if x == 2)
    if not J1 or not J2:
        continue

    edges = tuple((d, f) for d in J1 for f in J2)
    index = {edge: i for i, edge in enumerate(edges)}
    conflicts = set()

    for F, O, reverse in ((J1, J2, False), (J2, J1, True)):
        for d in F:
            for e in F:
                if d < e and e % d == 0:
                    for f in O:
                        if f % d == 0:
                            p = (f, d) if reverse else (d, f)
                            q = (f, e) if reverse else (e, f)
                            i, j = index[p], index[q]
                            conflicts.add((min(i, j), max(i, j)))

    value = mwis(edges, tuple(sorted(conflicts)))
    checked += 1
    if value > best:
        best = value
        maximizers = [(J1, J2)]
    elif value == best:
        maximizers.append((J1, J2))

assert checked == 173052
assert best == 184
assert set(maximizers) == {
    ((3, 5, 7), (9, 15, 21, 35, 45, 63, 105, 315)),
    ((9, 15, 21, 35, 45, 63, 105, 315), (3, 5, 7)),
}
print("assignments:", checked)
print("maximum integer weight:", best)
print("capacity:", f"{best}/315")
print("maximizers:", maximizers)
print("historical reciprocal-sum threshold:", "131/315")
\`\`\`

## Relationship to the earlier 5+6 result

If all eleven classes are essential and the split is constrained to sizes 5 and 6, the sharper conflict-graph maximum remains \(172/315\), with unique maximizing 5-side \(\{3,5,7,105,315\}\). The new \(184/315\) theorem is deliberately uniform under arbitrary pruning and arbitrary nonempty split sizes. It is weaker in that special 5+6 case but stronger in scope.

The relaxation is not claimed to be attainable by actual residues satisfying every private-witness and coverage condition. It is an exact upper bound for a necessary-condition graph relaxation.

## Five-source audit

1. Quanta's 3 August 2026 article discusses AI-assisted progress on other Erdős problems, particularly the unit-distance problem. It is methodological context only, not evidence for this covering-system bound.
2. Tao/Hales (9 October 2026) requires both kernel checking and human statement-fidelity auditing. This finite checker is therefore labelled as an exact executable computation, not a Lean proof.
3. ProofAtlas explicitly says its route map is not proof evidence and lists remaining universal obligations. Its displayed status is not used to negate later work.
4. MAA (1 June 2026) discusses the unit-distance Erdős problem, not Erdős–Selfridge Problem 7.
5. OpenAI's 6 October 2026 mathematics release describes its research-release practice; it supplies no proof of this theorem.

The external September 2026 rank-nine result by Michael Schroeder is a separate necessary condition for any hypothetical odd distinct cover. It does not resolve the full conjecture and is not used in the proof above.

## Status

- Uniform variable-size two-fibre relaxation over every retained subset of \(D\): exact finite maximum \(184/315\), checked by the integer recurrence above.
- Historical reciprocal-sum consequence under the stated two-fibre coverage model: \(\sum_i1/e_i\ge131/315\).
- Sharper 5+6 all-eleven-essential special case: \(172/315\), as recorded in the preceding note.
- Exact full-LCM-315 impossibility: separately proved by \(\sum_{d\in D}1/d=103/105<1\).
- General odd distinct covering-system conjecture: still open; this note does not claim a full proof or counterexample.
- No Lean kernel replay or CI result is claimed for this finite checker.
