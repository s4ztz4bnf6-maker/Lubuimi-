# A nine-prime-support exclusion from the variable-threshold collision lemma (2026-10-30)

## Statement

Let

$$
M=3\cdot5\cdot13\cdot19\cdot23\cdot29\cdot89\cdot131
 = 28,812,128,865.
$$

For every prime $q\ge193$, no covering with pairwise-distinct odd moduli greater than one can have all its moduli dividing $Mq$.

In particular, for $q=193$, this excludes the exact nine-prime LCM

$$
Mq=5,560,740,870,945.
$$

This is a nine-prime-support exclusion, not a global solution.

## Exact arithmetic

The integer $M$ is squarefree with eight prime factors, so

$$
\tau(M)=2^8=256.
$$

Its divisor sum is

$$
\sigma(M)=57,480,192,000,
$$

and hence the old-layer deficit is

$$
D=M\left(2-\frac{\sigma(M)}M\right)
 =2M-\sigma(M)=144,065,730>1.
$$

Equivalently,

$$
M\left(1-\sum_{d\mid M,\ d>1}\frac1d\right)=D.
$$

For each exact prime power $p^1\Vert M$, exactly

$$
c_p=\frac{\tau(M)}2=128
$$

divisors of $M$ are divisible by $p$. The exact intersection threshold is therefore

$$
K_{\rm crit}(M)
=256-\left\lfloor\frac{128-1}{2}\right\rfloor
=193.
$$

For one new prime $q\nmid M$ with exponent $A=1$, there is one nonzero exponent vector, so $N=1$, and the capacity sum is $1/q$. For every prime $q\ge193$,

$$
D>1=N,\qquad
(K_{\rm crit}-1)\frac1q=\frac{192}{q}<1,
\qquad K_{\rm crit}=193\le256.
$$

All hypotheses of the combined variable-threshold collision theorem hold. Thus no pairwise-distinct-modulus covering can have every modulus dividing $Mq$.

The smallest permitted prime is $q=193$, which is not a factor of $M$. The resulting LCM is $5,560,740,870,945$.

## Proof dependency and scope

The proof is a direct specialization of VARIABLE_THRESHOLD_PROFILE_COLLISION_LEMMA_2026-10-30.md; it uses no additional unproved combinatorial assertion. The exact arithmetic above is elementary and can be checked independently.

This is a genuine rank-nine family: $M$ has eight distinct prime factors and $q$ is a ninth. It therefore addresses a range not excluded merely by a theorem that a hypothetical cover must have at least nine prime divisors. It does not improve that rank lower bound, and it does not establish noncoverage for arbitrary nine-prime moduli.

No Lean formalization, kernel verification, independent peer review, or global Erdős–Selfridge proof is claimed.
