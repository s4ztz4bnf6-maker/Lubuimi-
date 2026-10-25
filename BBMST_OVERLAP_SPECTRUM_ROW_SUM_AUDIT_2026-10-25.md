# BBMST overlap spectrum: a bound that is exact but not yet useful

Date: 2026-10-25

## Kernel and a rigorous generic bound

For a finite family of positive-mass events \(H\) in a finite uniform product space, put
\[
K_{H,K}=\frac{\Pr(H\cap K)}{p_Hp_K},\qquad p_H=\Pr(H)>0.
\]
Writing \(f_H=\mathbf 1_H/p_H\) gives
\[
K_{H,K}=\mathbb E[f_Hf_K],\qquad
c^T Kc=\mathbb E\big[(\sum_H c_Hf_H)^2\big]\ge0.
\]
Thus \(K\) is positive semidefinite. For coordinate-fixing product-box events, the exact entry is zero for conflicting prescriptions and otherwise
\[
K_{H,K}=\prod_{i\in F_H\cap F_K}|S_i|.
\]

Let \(R=\max_H\sum_K K_{H,K}\). Since \(K\) is a real symmetric matrix with nonnegative entries, the standard row-sum/Gershgorin bound gives
\[
\lambda_{\max}(K)\le R.
\]
Consequently,
\[
\mathbb E[X^2]=p^TKp
\le R\sum_Hp_H^2,
\quad X=\sum_H\mathbf1_H.
\]
This is a valid generic spectral envelope, but it is not itself a BBMST breakthrough: \(R\) is precisely a weighted compatible-overlap sum, and may be too large to improve the elementary estimate.

## Important obstruction / negative result

The PSD fact and the row-sum bound do not by themselves prove that a family of events fails to cover the sample space. In particular, an upper bound \(\mathbb E[X^2]<1\) would imply \(\mathbb E[X]<1\) by Cauchy–Schwarz and hence non-covering, but this is already stronger than needed and cannot be credited as a new second-moment mechanism. More generally, a useful spectral proof must exploit structure specific to the square-free-modulus hyperplane family to control \(R\) or a sharper norm bound in a way that is not merely a restatement of the target sieve estimate.

A second danger is loss of source fidelity: the published theorem concerns pairwise distinct square-free moduli and its exact covering-system conclusion. Do not replace it by a theorem for arbitrary distinct odd moduli, and do not identify arbitrary coordinate-fixing boxes with the paper's full incidence structure without proving the correspondence.

## Concrete next step

For the actual finite family in the paper, derive a coordinate- and modulus-sensitive expression for each row sum:
\[
R_H=\sum_{K:\,\text{compatible with }H}
\prod_{i\in F_H\cap F_K}|S_i|.
\]
Then compare it term-by-term with the original proof's sieve/covering quantity. A spectral route is promising only if it produces a strict quantitative gain under the paper's hypotheses. If it does not, record that as a failed route rather than elevating PSD to a result.

## Status

This note is a mathematical reduction and an explicit diagnostic, not a Lean-checked theorem and not a proof of the BBMST theorem.


## Refined overlap target: a weighted row-sum identity (2026-10-25)

For a finite product box with coordinate sizes q_i=|S_i|, let H and K fix
coordinate sets F_H and F_K. If their assignments conflict on a shared
coordinate, their intersection is empty. If they are compatible, then
P(H)=prod_{i in F_H} q_i^{-1} and
P(H∩K)=prod_{i in F_H∪F_K} q_i^{-1}. Hence the normalized overlap inflation is
P(H∩K)/(P(H)P(K)) = prod_{i in F_H∩F_K} q_i.

Consequently the exact row sum of the normalized overlap kernel is
R_H = sum_{K compatible with H} prod_{i in F_H∩F_K} q_i.
This formula identifies the actual quantitative bottleneck: a useful
spectral/second-moment argument must upper-bound these row sums, or a
sharper weighted operator norm, using the square-free-modulus incidence
constraints of the source theorem. Generic positive semidefiniteness alone
does not bound R_H and cannot establish the BBMST union estimate.

Next formalization target: define the finite product probability exactly,
prove the normalized overlap identity for compatible/incompatible pairs,
then group the row sum by the intersection signature F_H∩F_K. Only after
this should one compare the grouped sum with the source paper's finite sieve
and tail estimates. This remains a reduction plan, not a proof of the
global BBMST estimate.


## Source-scope and proof-chain checkpoint (2026-10-25)

The audited upstream CI run for the first-moment identity and existing
product-box geometry completed successfully (run 40151190202). The newer
row-sum research-note commit has its own CI still running; do not conflate
these runs.

The target theorem remains the published square-free-moduli result. A proof
bridge must identify, for each original arithmetic object, the corresponding
fixed-coordinate event and prove that admissibility, distinctness, and
square-freeness are preserved. Only then can the generic identity
R_H = sum_{K compatible H} product_{i in F_H∩F_K}|S_i|
be compared to the source sieve bound. Without that bridge, a bound for
abstract product boxes is not yet a bound for the original covering-system
problem.

A formalization-ready intermediate statement is: for a finite family I of
admissible source configurations and each H∈I, partition the compatible K∈I
by the signature G=F_H∩F_K; show the row sum equals
sum_G (product_{i∈G}|S_i|)·N_H(G), where N_H(G) counts compatible K with
exact shared-support signature G. This is a finite reindexing identity.
Its utility depends on obtaining source-specific bounds on N_H(G); the
identity alone does not prove the required global estimate.
