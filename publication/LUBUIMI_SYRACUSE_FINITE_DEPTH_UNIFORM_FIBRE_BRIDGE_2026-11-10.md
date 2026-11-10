# Finite-Depth Uniform-Fibre Bridge from Syracuse Valuation Cylinders

**Author:** Ta-Yoshua Lubuimi  
**Date:** 10 November 2026  
**Status:** Mathematical proposition derived from the finite-word cylinder partition and the Lean-verified local margin cap. This note is not yet Lean-formalized and does not identify the construction with the historical APW4 event system.

## Abstract

The exact valuation-cylinder partition and the state-dependent signed-margin cap together produce a finite, prefix-dependent partition of all next-step possibilities into finitely many non-descent-compatible children and one descending tail cylinder. At every fixed depth, the surviving prefix tree is finite. Taking the maximum local cap over that finite level allows every local dyadic partition to be refined to a common number (2^{B_k^*}) of equal-mass atoms. Consequently, each prefix at that depth admits a uniform finite fibre whose distinguished subset has exact proportion (1-2^{-B_\alpha}) and whose complement has proportion (2^{-B_\alpha}). This is a concrete APW4-style finite uniform-fibre model. It is not yet the historical APW4 incidence map, and it does not exclude an infinite surviving path.

## 1. Prefix data and the local cap

Let (alpha=(a_0,\ldots,a_{k-1})) be a realized exact Syracuse valuation word, with
[
A_\alpha=\sum_{i<k}a_i,qquad
C_0=0,quad C_{i+1}=3C_i+2^{A_i},
]
and signed margin
[
D_\alpha=2^{A_\alpha}-C_k-3^k.
]
For a proposed next exponent (b\geq1), the margin recurrence gives
[
D_{\alpha b}=3D_\alpha+(2^b-4)2^{A_\alpha}.
]
The exact non-descent cap is
[
D_{\alpha b}\leq0
\quad\Longleftrightarrow\quad
2^{A_\alpha+b}+3D_\alpha\leq4\cdot2^{A_\alpha}.
\tag{1}
]
For a positive odd initial value (n_0>1), a positive next margin forces the next odd endpoint below (n_0). Thus any next step that does not yet descend below (n_0) must satisfy (1).

Define
[
B_\alpha=\max\{b\geq1:
2^{A_\alpha+b}+3D_\alpha\leq4\cdot2^{A_\alpha}\},
\]
with (B_\alpha=0) if the set is empty. Since the left side is strictly increasing in (b), the admissible exponents are exactly (1,\ldots,B_\alpha). The cap is finite because the right side of (1) is fixed while (2^{A_\alpha+b}\to\infty).

The local cap core is Lean-verified in Syracuse PR #9, run 42728049650, exact source commit ca48ec7fdad5e8d6f8aeb82fed8586a1b57c12bc. The arbitrary-word cylinder and tail partition are mathematically proved in the companion manuscript but remain separate Lean formalization targets.

## 2. Exact local child/tail partition

Let \(\mathcal C_\alpha\) be the parent cylinder for \(\alpha\). The finite-word cylinder theorem gives, for each exact next exponent (b\geq1), a unique child cylinder \(\mathcal C_{\alpha b}\) with conditional mass
[
\frac{\mu(\mathcal C_{\alpha b})}{\mu(\mathcal C_\alpha)}=2^{-b}.
]
For every cutoff (B\geq0), the children (b=1,\ldots,B), together with the tail event (a_k\geq B+1), partition the parent cylinder. The tail is one exact residue cylinder and has conditional mass (2^{-B}). Thus
[
\sum_{b=1}^{B}2^{-b}+2^{-B}=1,
\tag{2}
]
where the sum is empty and the tail mass is one when (B=0).

Taking (B=B_\alpha), all exact children with (b\leq B_\alpha) are precisely the next steps not excluded by the local cap. Every point of the tail (a_k\geq B_\alpha+1) violates (1), has positive next margin, and therefore descends below (n_0).

## 3. Uniformization at a fixed depth

Let (S_0=\{\emptyset\}). Recursively, let
[
S_{k+1}=\{\alpha b:\alpha\in S_k, 1\leq b\leq B_\alpha\}.
]
Each node has finitely many children, so induction on (k) proves that every level (S_k) is finite. Define
[
B_k^*=\max(\{B_\alpha:\alpha\in S_k\}\cup\{0\}),
\qquad M_k=2^{B_k^*}.
]
Then (B_\alpha\leq B_k^*) for every \(\alpha\in S_k\).

Fix a prefix \(\alpha\in S_k\), and write (B=B_\alpha), (B^*=B_k^*), and (M=2^{B^*}). On the common coordinate set
[
X_k=\{0,1,\ldots,M-1\},
]
define the child block for (1\leq b\leq B) by the half-open integer interval
[
I_{\alpha,b}
=
[,M-2^{B^*-b+1}, M-2^{B^*-b},),
\tag{3}
]
and define the tail block by
[
T_\alpha=[,M-2^{B^*-B}, M,).
\tag{4}
]
The blocks in (3) are pairwise disjoint consecutive intervals. Their union is ([0,M-2^{B^*-B})), so together with (4) they partition (X_k). Their cardinalities are
[
|I_{\alpha,b}|=2^{B^*-b},
\qquad
|T_\alpha|=2^{B^*-B}.
\tag{5}
]
This includes (B=0): there are no child blocks and the tail block is all of (X_k).

Equip (X_k) with uniform probability (1/M) per point. Equations (5) give
[
\frac{|I_{\alpha,b}|}{M}=2^{-b},
\qquad
\frac{|T_\alpha|}{M}=2^{-B}.
\tag{6}
]
Thus the uniform finite fibre reproduces exactly the conditional child and tail masses of the Syracuse cylinder partition.

Let
[
K_\alpha=\bigcup_{b=1}^{B_\alpha}I_{\alpha,b}
]
be the distinguished set of non-descent-compatible children. Then
[
|K_\alpha|=M_k-2^{B_k^*-B_\alpha},
\]
and its uniform proportion is
[
\boxed{
\frac{|K_\alpha|}{M_k}=1-2^{-B_\alpha}.
}
\tag{7}
]
Its complement has proportion (2^{-B_\alpha}), exactly the descending tail mass.

## 4. Interpretation as a finite-fibre datum

For each level (k), all surviving prefixes share the same finite coordinate set (X_k) of size (M_k). The covered/distinguished subset (K_\alpha\subseteq X_k) depends on the prefix, but the ambient fibre cardinality does not. With point weight (1/M_k), total mass one, and proportion (1-2^{-B_\alpha}), this is a valid uniform finite-fibre datum of the type used in the APW4 finite-fibre architecture.

The refinement has a residue-class interpretation, not merely a formal counting interpretation. Each exact child cylinder (\mathcal C_{\alpha b}) is a single residue class at modulus (2^{A_\alpha+b+1}). Refining it to the common modulus (2^{A_\alpha+B_k^*+1}) produces exactly (2^{B_k^*-b}) equal subcylinders. The tail cylinder at cutoff (B_\alpha), refined to the same modulus, produces (2^{B_k^*-B_\alpha}) equal subcylinders. These are the micro-atoms indexed by the intervals (3) and (4). A canonical increasing-residue ordering gives a prefix-dependent bijection from (X_k) to the refined residue atoms.

## 5. What this bridge proves — and what it does not

The construction establishes a concrete finite-depth bridge:
- exact Syracuse child/tail cylinders;
- a finite surviving prefix level;
- a common finite coordinate set at that level;
- an explicit prefix-dependent subset;
- exact uniform point weights and exact subset proportions;
- a canonical residue-atom refinement.

It therefore supplies an explicit candidate finite-fibre model that can be formalized against the generic APW4 finite-fibre data structures. It also gives a natural place to test the APW4 covered/uncovered update algebra on Syracuse-derived fibres.

It does **not** establish:
1. that the distinguished set (K_\alpha) is the same object as the historical APW4 hyperplane-covered set;
2. a map from these residue micro-atoms to the historical APW4 event indices, BIB places, or incidence matrix;
3. preservation of the historical APW4 weights;
4. the APW4 diagonal/off-diagonal majorizations or the BIB/Hall capacity inequality;
5. exclusion of an infinite path through the finite surviving prefix tree; or
6. the global Collatz conjecture.

Those require additional explicit maps and inequalities. In particular, finite branching at every node and finite uniformization at every fixed depth do not by themselves preclude an infinite path.

## 6. Formalization plan

The Lean development should be isolated from the historical APW4 proof until each bridge lemma is proved:
1. define the local cap (B_\alpha) as a finite maximum (with zero for the empty admissible set);
2. formalize monotonicity of the cap inequality in (b);
3. formalize the finite level (S_k) and the maximum (B_k^*);
4. define the intervals (I_{\alpha,b}) and tail interval (T_\alpha) in `Fin (2 ^ B_k^*)`;
5. prove disjointness, coverage, and the cardinality formulas (5);
6. prove the uniform proportions (6)–(7);
7. identify the interval atoms with the refined exact residue cylinders;
8. instantiate the generic finite-fibre structure and audit the named declarations.

The initial all-one cylinder theorem, the signed-margin cap core, and the finite (k=2) terminal-residue module have their own successful Lean audits. None of those audits is evidence that this new finite-depth uniformization note has already been compiled.

**Attribution:** Ta-Yoshua Lubuimi. AI systems are assistants only, not authors or independent mathematical verifiers.
