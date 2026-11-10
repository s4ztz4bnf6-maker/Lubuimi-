# Supplement: Lubuimi Terminal-Residue Collision Energy and the APW4 Incidence Interface

**Author:** Ta-Yoshua Lubuimi  
**Date:** 10 November 2026  
**Version:** 1.0  
**Status:** Mathematical derivation; Lean formalization of this supplement is not yet complete.

## Abstract

This supplement records a finite-place weighted incidence structure arising from exact Syracuse valuation-word cylinders. Every length-(k) valuation word determines a terminal residue modulo (3^k). Pushing the exact cylinder weights to the finite unit-residue space produces a second-moment energy with an exact diagonal/off-diagonal decomposition. The diagonal is (3^{-k}), and the off-diagonal collision mass is at least (1/(2cdot3^k)). The same distribution admits an explicit finite rational Markov-matrix representation. This is a concrete APW4-style incidence and moment structure. It is a separate Syracuse construction and is not silently identified with the historical APW4 BIB reserve.

## 1. Valuation-word source space

For an accelerated Syracuse orbit,
[
2^{a_j}n_{j+1}=3n_j+1,qquad a_jge1,
]
let (alpha=(a_0,ldots,a_{k-1})) be a finite exact valuation word. Define
[
A_0=0,quad A_{j+1}=A_j+a_j,
qquad
C_0=0,quad C_{j+1}=3C_j+2^{A_j}.
]
Then
[
2^{A_k}n_k=3^k n_0+C_k,
qquad
C_k=sum_{j=0}^{k-1}3^{k-1-j}2^{A_j}.
]

Lubuimi's finite valuation-word cylinder partition assigns each word (alpha) its exact odd-start density
[
w_alpha=2^{-A_k}=prod_{j<k}2^{-a_j}.
]
At fixed (k), the word cylinders partition the odd starting integers, hence
[
sum_alpha w_alpha=1.
]

## 2. Terminal-residue incidence map

Since (2) is invertible modulo (3^k), define
[
oxed{	au_k(alpha)=C_k,2^{-A_k}pmod{3^k}.}
]
The affine identity gives
[
n_kequiv	au_k(alpha)pmod{3^k}
]
for every orbit realizing (alpha).

The residue is a unit: the offset recurrence gives
[
C_kequiv2^{A_{k-1}}pmod3,
]
so (3
mid C_k), and (2) is also a unit modulo (3^k). Thus the finite place set is
[
U_k=(mathbb Z/3^kmathbb Z)^	imes,
qquad |U_k|=arphi(3^k)=2cdot3^{k-1}.
]

The map (	au_k) is an exact incidence map from valuation-word sources to terminal-residue places.

## 3. Aggregated masses and exact energy split

For (tin U_k), set
[
m_k(t)=sum_{	au_k(alpha)=t}w_alpha,
qquad
E_k=sum_{tin U_k}m_k(t)^2.
]
Then (sum_t m_k(t)=1). Expanding the square yields
[
E_k=D_k+C_k^{mathrm{coll}},
]
where
[
D_k=sum_alpha w_alpha^2
=left(sum_{age1}4^{-a}ight)^k
=oxed{3^{-k}},
]
and
[
C_k^{mathrm{coll}}
=sum_{substack{alpha
eeta\
	au_k(alpha)=	au_k(eta)}}w_alpha w_eta.
]
This is an exact diagonal/off-diagonal decomposition.

By Cauchy–Schwarz on the finite place set,
[
E_k=sum_{tin U_k}m_k(t)^2
gerac{(sum_t m_k(t))^2}{|U_k|}
=rac1{2cdot3^{k-1}}.
]
Subtracting the diagonal gives
[
oxed{C_k^{mathrm{coll}}gerac1{2cdot3^k}.}
]

For (k=1), the masses at residues (1,2pmod3) are (1/3,2/3), so
[
E_1=5/9,quad D_1=1/3,quad C_1^{mathrm{coll}}=2/9.
]

## 4. Finite rational Markov representation

Under the natural probability measure on odd starts, the valuation coordinates are independent with
[
mathbb P(a_j=b)=2^{-b},qquad bge1.
]
Fix (k) and work modulo (3^k). Define
[
x_j=C_j2^{-A_j}pmod{3^k},qquad x_0=0.
]
The offset recurrence gives
[
oxed{x_{j+1}=2^{-a_j}(3x_j+1)pmod{3^k}.}
]
Thus (m_k) is the distribution at time (k) of a finite-state Markov chain.

Let (phi_k=2cdot3^{k-1}). The integer (2) is a primitive root modulo (3^k), with
[
operatorname{ord}_{3^k}(2)=2cdot3^{k-1}.
]
For every state (xinmathbb Z/3^kmathbb Z) and unit (yin U_k), there is a unique (r_k(x,y)in{1,ldots,phi_k}) satisfying
[
2^{r_k(x,y)}yequiv3x+1pmod{3^k}.
]
The transition matrix is
[
oxed{
P_k(x,y)=
egin{cases}
dfrac{2^{-r_k(x,y)}}{1-2^{-phi_k}},&yin U_k,\[1ex]
0,&3mid y.
end{cases}}
]
The geometric denominator sums all exponent values in the same residue class modulo (phi_k). Each row sums to one. The primitive-root order follows from the LTE identity
[
v_3(2^{2cdot3^j}-1)=v_3(4^{3^j}-1)=j+1.
]

With (delta_0) the point mass at zero,
[
oxed{m_k=delta_0P_k^k,qquad E_k=|delta_0P_k^k|_2^2.}
]
This converts the countable valuation-word source family into a finite rational matrix computation.

For (k=2), in the unit-residue order (1,2,4,5,7,8pmod9),
[
m_2=rac1{63}(8,16,11,4,2,22).
]
Consequently
[
E_2=rac5{21},qquad D_2=rac19,qquad
C_2^{mathrm{coll}}=rac8{63}.
]

## 5. APW4 interface and transfer obligations

The Syracuse construction now has the same *type* of data needed for a finite incidence/moment argument:

- a countable source family of exact valuation words;
- explicit source weights (w_alpha);
- a finite place set (U_k);
- a concrete incidence map (	au_k);
- aggregated place masses (m_k(t));
- an exact diagonal/off-diagonal energy split;
- an explicit finite rational Markov matrix for the place distribution.

This is a concrete APW4-style incidence interface and a natural target for the APW4 finite-moment methods.

It is **not yet** the historical APW4 BIB reserve. To transfer the APW4 theorem, one must still prove:

1. an index-preserving map from the relevant word-pair collision events to the original APW4 off-diagonal/BIB events and places;
2. preservation of the original historical weights under that map;
3. the corresponding capacity/Hall inequality in the historical APW4 incidence system.

Until these are established, (C_k^{mathrm{coll}}) remains a separate Syracuse collision quantity. No historical APW4 object is renamed or silently identified with it.

## 6. Formalization status and mathematical scope

The initial valuation-one cylinder theorem is separately Lean-compiled and axiom-audited on five full exact-commit workflows. A first Lean lemma expressing the terminal-residue congruence from the affine offset identity has been added as a separate formalization step; its exact-head CI result is pending. The full finite-word partition, collision-energy identity, finite Markov matrix and (k=2) vector are not yet claimed as Lean-compiled.

This supplement does not prove the global Collatz conjecture and does not alter the established APW4 proof. It records a new, exact and independently useful incidence/moment structure for future work.

---

**Ta-Yoshua Lubuimi**  
Copyright © 2026 Ta-Yoshua Lubuimi. All rights reserved in the author's original expression and code, subject to applicable law, third-party rights and the repository's licensing notices.
