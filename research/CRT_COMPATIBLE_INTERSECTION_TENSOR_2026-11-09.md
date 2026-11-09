# Exact compatible-intersection tensor for the one-prime CRT moment

Date: 2026-11-09

Status: proved finite CRT identity and exact deficit formula. The identity is a structural bridge, not a new noncoverage theorem. The CRT-specific identity is not yet Lean-formalized.

## 1. Setup and actual-modulus indexing

Let \(M>1\), let \(q\nmid M\) be prime, and let \(A\geq1\). Consider a hypothetical distinct odd-modulus cover whose moduli all divide \(Mq^A\). Every new-layer modulus has a unique representation
\[
m_\lambda=q^b d,\qquad
\lambda=(b,d)\in\mathcal I_A
:=\{1,\ldots,A\}\times\{d:d\mid M\}.
\]
Uniqueness follows from \(q\nmid M\). Pairwise distinctness of the actual moduli therefore gives at most one actual congruence class in each slot \(\lambda\).

For each slot, let \(C_\lambda\subseteq\mathbb Z/M\mathbb Z\) be its projected base class modulo \(d\), or the empty set if the actual modulus \(q^bd\) is absent. If present, write its residue as \(a_\lambda\pmod d\). Different slots are retained even when their projected sets coincide.

Put
\[
\alpha_\lambda=q^{-b},\qquad
g(x)=\sum_{\lambda\in\mathcal I_A}
\alpha_\lambda\,\mathbf1_{C_\lambda}(x).
\]
Let \(U\) be the set of residues missed by every old class \(d\mid M,\ d>1\). As in the arbitrary-exponent fibre argument,
\[
|U|\geq B(M):=
M-\sum_{\substack{d\mid M\\d>1}}\frac Md.
\]
For every \(x\in U\), the \(q^A\)-point fibre above \(x\) must be covered by the new classes. A class in slot \((b,d)\) whose base projection contains \(x\) covers exactly \(q^{A-b}\) points of that fibre. Counting with multiplicity gives
\[
q^A\leq\sum_{b=1}^A m_b(x)q^{A-b},
\qquad
g(x)=\sum_{b=1}^A q^{-b}m_b(x)\geq1.
\]
Thus, for every integer \(k\geq1\),
\[
B(M)\leq |U|\leq\sum_{x\bmod M}g(x)^k.
\tag{1}
\]

## 2. Generalized CRT compatibility

For a tuple of present projected classes
\[
a_j\pmod{d_j}\qquad(1\leq j\leq k),
\]
write
\[
L=\operatorname{lcm}(d_1,\ldots,d_k).
\]
The generalized Chinese remainder theorem gives the exact intersection formula
\[
\left|\bigcap_{j=1}^k C_j\right|
=
\begin{cases}
M/L,&
a_i\equiv a_j\pmod{\gcd(d_i,d_j)}
\text{ for every }i,j,\\[2mm]
0,&\text{otherwise}.
\end{cases}
\tag{2}
\]
Here every \(d_j\mid M\), so \(L\mid M\).

For completeness, pairwise compatibility is sufficient, not merely necessary. Inductively combine the first \(r\) congruences into one class modulo \(L_r=\operatorname{lcm}(d_1,\ldots,d_r)\). To add \(a_{r+1}\pmod{d_{r+1}}\), the two-modulus CRT requires compatibility modulo \(\gcd(L_r,d_{r+1})\). The identity
\[
\gcd(L_r,d_{r+1})
=\operatorname{lcm}_{1\leq j\leq r}\gcd(d_j,d_{r+1})
\]
shows that the original pairwise conditions imply this compatibility. The resulting solutions form one class modulo \(L\), which has exactly \(M/L\) representatives modulo \(M\).

## 3. Exact moment tensor

For an ordered tuple
\[
\boldsymbol\lambda=(\lambda_1,\ldots,\lambda_k),
\qquad \lambda_j=(b_j,d_j),
\]
define \(\kappa(\boldsymbol\lambda)\in\{0,1\}\) to be \(1\) precisely when:

1. every slot \(\lambda_j\) is present; and
2. the corresponding projected residues satisfy all pairwise generalized-CRT compatibility conditions.

Otherwise set \(\kappa(\boldsymbol\lambda)=0\). Repeated labels are allowed and are not deduplicated.

Expanding the \(k\)-th power, interchanging finite sums, and applying (2) gives the exact identity
\[
\boxed{
\sum_{x\bmod M}g(x)^k
=
\sum_{\lambda_1,\ldots,\lambda_k\in\mathcal I_A}
\frac{M\,q^{-(b_1+\cdots+b_k)}}
{\operatorname{lcm}(d_1,\ldots,d_k)}
\,\kappa(\lambda_1,\ldots,\lambda_k).
}
\tag{3}
\]
This is the placement-dependent compatible-intersection tensor. It retains both the actual residue data and the provenance of each actual modulus.

The scalar moment constant is exactly the same sum with every compatibility/presence indicator replaced by \(1\):
\[
T_k(M)H_A(q)^k
=
\sum_{\lambda_1,\ldots,\lambda_k\in\mathcal I_A}
\frac{M\,q^{-(b_1+\cdots+b_k)}}
{\operatorname{lcm}(d_1,\ldots,d_k)},
\]
where
\[
T_k(M)=
\sum_{d_1,\ldots,d_k\mid M}
\frac{M}{\operatorname{lcm}(d_1,\ldots,d_k)},
\qquad
H_A(q)=\sum_{b=1}^Aq^{-b}.
\]

Consequently the scalar overcount has the following exact nonnegative deficit:
\[
\boxed{
\Delta_k
:=
T_k(M)H_A(q)^k-\sum_{x\bmod M}g(x)^k
=
\sum_{\lambda_1,\ldots,\lambda_k}
\frac{M\,q^{-(b_1+\cdots+b_k)}}
{\operatorname{lcm}(d_1,\ldots,d_k)}
\bigl(1-\kappa(\lambda_1,\ldots,\lambda_k)\bigr)
\geq0.
}
\tag{4}
\]

Combining (1) and (4), the exact moment route excludes the proposed cover whenever
\[
\boxed{\Delta_k>T_k(M)H_A(q)^k-B(M)}
\tag{5}
\]
for at least one \(k\geq1\). This is the precise missing estimate in the scalar argument: a lower bound for the mass of absent or CRT-incompatible ordered tuples.

## 4. Why projected distinctness cannot be inserted

Actual-modulus distinctness does not imply distinctness or incompatibility of projected classes. For example, with \(M=15\), \(q=7\), and \(A\geq2\), the distinct actual moduli \(21=7\cdot3\) and \(147=7^2\cdot3\) may both carry residue \(1\). Their projections are the same class \(1\pmod3\), so the corresponding two-slot compatibility indicator is \(1\). The tuple must remain in (3), with its multiplicity.

Thus (3) does not permit replacing the actual projected family by a set of distinct projected moduli. It also does not permit assuming that distinct actual moduli yield pairwise incompatible projections.

## 5. Quantitative target at the first possible nine-prime support

The rank-nine theorem makes the first nine odd primes the smallest possible global support. Isolate the \(q=3\) coordinate and put
\[
M=5\cdot7\cdot11\cdot13\cdot17\cdot19\cdot23\cdot29
=1,078,282,205.
\]
Exact multiplication gives
\[
\sigma(M)=2,090,188,800,\qquad
B(M)=2M-\sigma(M)=66,375,610,
\]
and
\[
\prod_{p\mid M}\frac{p+3}{p+1}=\frac{2288}{729}.
\]
For the scalar criterion, \(F_k=T_k(M)H_A(3)^k\). The monotonicity lemma in the project note
ONE_PRIME_MOMENT_MONOTONICITY_OBSTRUCTION_2026-11-09.md gives \(F_{k+1}>F_k\) for all \(k\geq1\), while
\[
F_1\geq\frac{\sigma(M)}3=696,729,600.
\]
Therefore, for every \(A\geq1\) and every \(k\geq1\),
\[
F_k-B(M)\geq630,353,990.
\]
On this support, a successful use of (5) must prove
\[
\Delta_k>630,353,990
\]
(and in fact the required margin is larger for \(A>1\) or \(k>1\)). This is a concrete quantitative target, not a proof that the target holds.

## 6. Lean boundary and next obligation

- The declaration BBMSTMomentBridge.fourth_incidence_moment has now been added. It expands the fourth moment of an arbitrary finite incidence family into the ordered fourfold intersection sum, retaining each incidence set separately.
- The theorem is an algebraic identity. It does not prove the generalized-CRT compatibility criterion (2), the exact \(M/L\) count, or a lower bound for \(\Delta_k\).
- The new Lean declaration has not yet been compiled or axiom-audited by CI.
- The earlier fiber_fourth_moment theorem remains a same-map fibre identity; it is not, by itself, the CRT compatibility theorem.
- The current BBMSTCongruenceCRT.lean correction is committed separately, but its post-correction CI status is pending. The preceding run failed at a duplicate doc-comment parse error and the consequent Fintype elaboration recovery; its output showed sorryAx only on declarations downstream of that failed parse. No clean post-fix result is claimed here.

**Next mathematical obligation:** obtain a uniform lower bound for the deficit \(\Delta_k\) from the actual residue placements and pairwise distinctness of the full moduli. Formula (4) identifies exactly what must be bounded; it supplies no such bound on its own.

This is not a counterexample to the Erdős–Selfridge conjecture and is not a proof of it.
