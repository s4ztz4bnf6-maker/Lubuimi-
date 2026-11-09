# BBMST source-faithful audit and corrected proof map

Date: 2026-10-30

## Scope and source identity

The target in this repository is the square-free-modulus theorem of

P. Balister, B. Bollobás, R. Morris, J. Sahasrabudhe and M. Tiba,
"The Erdős–Selfridge problem with square-free moduli",
Algebra & Number Theory 15 (2021), no. 3, 609–626,
DOI: 10.2140/ant.2021.15.609.

The published Theorem 1.1 proves that a finite covering system with pairwise distinct square-free moduli greater than one contains an even modulus. It does **not** solve the unrestricted Erdős–Selfridge odd-covering problem.

Canonical source records:
- Published paper / Oxford repository: https://ora.ox.ac.uk/objects/uuid:3c55267c-60be-4652-89a7-db3db5f62c25
- Published PDF: https://ora.ox.ac.uk/objects/uuid:3c55267c-60be-4652-89a7-db3db5f62c25/files/rdv13zt50s
- arXiv preprint: https://arxiv.org/abs/1901.11465
- Authors' supplementary material: https://people.maths.ox.ac.uk/balister/Erdos-Selfridge.html

## Precise relation between the two BBMST papers

The square-free paper's **Theorem 3.1 does state** the first/second-moment noncoverage criterion:
\[
\sum_{k=a+1}^{n}
\min\left\{
M_k^{(1)},
\frac{M_k^{(2)}}{4\delta_k(1-\delta_k)}
\right\}<1
\quad\Longrightarrow\quad
\mathcal A\text{ does not cover }Q.
\]
Here \(M_k^{(1)}=\mathbb E_{k-1}[\alpha_k]\) and
\(M_k^{(2)}=\mathbb E_{k-1}[\alpha_k^2]\), with the measures and
\(\alpha_k\) defined by the square-free paper's equations (2) and (3).
The paper explicitly says this theorem essentially follows from Theorem 3.1
of the earlier density paper. Thus the statement is correctly attributed
to Theorem 3.1 of the 2021 square-free paper; its proof lineage is inherited
from the 2018 preprint / 2022 Inventiones density paper. Do not conflate
the two papers, but do not erase the theorem from the square-free paper either.

The square-free paper's **Theorem 3.2** supplies the source-specific moment
bounds. For a family of nontrivial, pairwise nonparallel hyperplanes:
\[
M_k^{(1)}\le \frac{c_{k-1}(1)}{|S_k|},
\qquad
M_k^{(2)}\le \frac{c_{k-1}(3)}{|S_k|^2}.
\]
The definitions used there are:
\[
c(I)=\max\{P_a(H): H\text{ a hyperplane in }Q_a,
\ F(H)=I\},
\qquad
\nu(J)=\prod_{j\in J}\frac1{(1-\delta_j)|S_j|},
\]
and
\[
c_k(x)=\sum_{I\subseteq[a]}c(I)x^{|I|}
\prod_{j=a+1}^{k}\left(1+\frac{x}{(1-\delta_j)|S_j|}\right).
\]
The paper then obtains a sharper second-moment estimate under its exact
geometric condition that the new singleton is absent. That condition must
be derived from the paper's setup, not supplied as a free hypothesis.

## Source proof chain

For the **square-free 2021 paper**, the relevant chain is:

1. Lemma 2.1: finite-fibre sieve / measure transition, including the zero-mass convention.
2. Theorem 3.1: convert first and second fibre moments into a noncoverage criterion.
3. Theorem 3.2: bound those moments through the fixed-coordinate geometry and the functions \(c_k\); derive the improved estimate when the new singleton is absent.
4. Lemmas 3.3–3.4: propagate initial hyperplane weights and bound positive integer moments by compatible hyperplane intersections.
5. Section 5: finite initial configuration and parameter certificates (Lemmas 5.3 and 5.4, Corollary 5.2).
6. Theorem 5.1: tail interface, with the termination proof imported from the earlier density paper (Lemma 6.2 and Theorem 6.1 there).
7. Theorem 1.2: combine the initial box result and tail estimate.
8. Theorem 1.1: transfer between integer covering systems and the geometric box problem by CRT.

The 2021 paper's own Section 3 introduces the moment criterion and then the new geometric moment bound; the criterion is not merely an unrelated theorem from the density paper.

## Geometric and arithmetic target

The initial geometric problem is a cover of a finite product box
\[
Q=S_1\times\cdots\times S_n
\]
by nontrivial hyperplanes. The paper reduces to nonparallel hyperplanes and tracks the set of fixed coordinates \(F(H)\). In the odd square-free application, the relevant coordinate sizes are consecutive odd primes after the paper's reduction and deletion of missing prime classes. The published proof also has a carefully handled extension to prime powers above 73; it does not say that arbitrary prime-power congruences are singleton hyperplanes.

The integer/geometric equivalence is via the Chinese remainder theorem. For a square-free modulus, a progression fixes one residue in each prime coordinate dividing its modulus and leaves the other coordinates free. Pairwise distinct integer moduli correspond to distinct fixed-coordinate patterns with their actual coordinate residues; this must be represented without quotienting away distinct provenance.

## Formalization architecture and status

Existing modules on the PR #50 head:

- `BBMSTPrimeExtension.lean`: finite product/fibre cover equivalence.
- `BBMSTArithmeticCRT.lean`: Mathlib CRT equivalence for coprime `ZMod` factors.
- `BBMSTCongruenceCRT.lean`: indexed old/new congruence classes, one-prime fibre allocation and incidence double count.
- `BBMSTFiniteSieveStage.lean`: abstract finite transition, fibre mass conservation and second-moment identity.
- `BBMSTSieveStage.lean`: abstract dependent stage-space interface.
- `BBMSTMomentBridge.lean`: finite pair-indicator and fibre second-moment identity, plus guarded rational moment contribution.

These modules establish useful finite bookkeeping interfaces. They do **not** yet encode the paper's actual hyperplane family, the canonical \(P_k\) transition, its exact zero-mass convention, the source-specific distortion bounds, the initial rational certificate, or the complete tail induction.

The abstract `SieveStage` is not itself a proof that the paper's geometric stage is a dependent product. The caller must construct the concrete equivalence and prove its admissibility relation from the actual source definitions.

## Required source-faithful formal milestones

### A. Concrete finite box and hyperplanes

Define the finite coordinate box, its coordinate restriction maps, hyperplanes, fixed-coordinate set, and nontriviality exactly as in the paper. Prove the fibre decomposition from these definitions. Do not introduce free predicates such as `isNontrivial`, `isParallel`, or `codimOne` without proving their equivalence to the source notions.

### B. Lemma 2.1: exact stage measure

Represent each stage measure by exact rational point weights on the finite state space. Define the paper's \(P_k\) recursively from the actual fibre covered proportions and the parameter \(\delta_k\). Prove:
- normalization and nonnegativity;
- preservation of the previous-stage marginal on the designated measurable sets;
- the source's pointwise / setwise distortion bound;
- the bound on mass of the newly removed fibre set;
- the zero-mass fibre branch separately, so no division by zero is used.

A generic probability record with a freely supplied normalized weight function is only a data interface, not the construction of \(P_k\).

### C. Theorem 3.1 and Theorem 3.2

Define the actual \(\alpha_k\) function from the new hyperplanes and the actual fibres. Prove Theorem 3.1 with its exact \(\min\) of first- and second-moment terms and all hypotheses. Then define \(c(I)\), \(\nu(J)\), and \(c_k(x)\) from the source and prove Theorem 3.2's first- and second-moment bounds. Preserve the improved second-moment condition exactly.

### D. Lemmas 3.3–3.4

Encode the fixed-coordinate geometry and compatibility of hyperplanes. Derive moment bounds by counting compatible intersections. Keep ordered-pair multiplicities and all residue choices explicit.

### E. Initial finite certificate

Reproduce the exact rational initial measure and the finite configuration verification. The authors' supplementary page contains optimizer-generated source and outputs; the Lean proof must either formalize the exact finite certificate or independently prove the same rational inequalities. Floating-point output is not proof. A checker or external program is evidence only unless its complete computation is itself verified or its output is imported as a checked certificate with a proved checker.

### F. Tail and final arithmetic conclusion

Formalize the exact interface of Theorem 5.1 and its imported density-paper termination argument. Formalize the rational parameter recurrence, endpoint inequalities, prime lower bound input, and integer/rational comparisons. Explicitly mark the imported external theorem(s) if their proofs are not included. Then prove Theorem 1.2 and the CRT transfer Theorem 1.1.

## Audit rules

- No `sorry`, `admit`, unproved axiom, or user-defined axiom in any claimed final theorem.
- Keep `#print axioms` output for every milestone.
- A green CI run is not interchangeable with a kernel axiom audit; report both separately.
- A formal theorem about an abstract interface is not the source theorem until the source model and its hypotheses are connected by proved equivalences.
- Keep the one-prime CRT allocation work as a separate exploratory branch; its support-budget obstruction is not the main proof of the square-free theorem.
- Counterexamples to a relaxed support-budget inequality are not counterexamples to the BBMST theorem.

## Current verification status at the time of this note

PR #50 head: `3d3b9c92acd114aec2938fd41ff20bab1ff36cf9`.
The GitHub combined commit status returned an empty status list. No Lean compilation, successful CI run, or axiom-audit success is asserted for that head. This note itself is a research map, not a formal proof.

## Immediate implementation order

1. Pin the exact published definitions/equations (2) and (3), Lemma 2.1, Theorems 3.1–3.2.
2. Replace the abstract-only stage interface with a concrete finite box/hyperplane stage and prove its fibre equivalence.
3. Implement \(P_k\) with explicit zero-mass handling and prove Lemma 2.1.
4. Prove Theorem 3.1 from the exact stage transition and the pointwise inequality used in the paper.
5. Prove Theorem 3.2 and then Lemmas 3.3–3.4.
6. Only then connect the finite initial certificates and tail theorem.

No conclusion about the unrestricted Erdős–Selfridge problem follows until the published square-free theorem is formalized and, separately, the non-square-free cases are addressed.


## Exact published stage formulas (equations (2)–(6), pp. 612–613)

Let (Q_k=Q_{k-1}\times S_k), and let (F_x=\{(x,y):y\in S_k\}) be the fibre over (x\in Q_{k-1}). The measure (P_{k-1}) is extended uniformly over each fibre. With (B_k) the set removed at stage (k), the source defines
\[
\alpha_k(x)=\frac{P_{k-1}(F_x\cap B_k)}{P_{k-1}(x)}
=\frac{|\{y\in S_k:(x,y)\in B_k\}|}{|S_k|}.
\tag{2}
\]
For zero-mass fibres, the rightmost finite counting ratio is the canonical definition; the left quotient is used only when (P_{k-1}(x)>0). This convention prevents an artificial (0/0) definition.

The point weights are changed by
\[
P_k(x,y)=
\begin{cases}
\displaystyle
\max\left\{0,\frac{\alpha_k(x)-\delta_k}
{\alpha_k(x)(1-\delta_k)}\right\}P_{k-1}(x,y),
&(x,y)\in B_k,\\[1.1em]
\displaystyle
\min\left\{\frac1{1-\alpha_k(x)},\frac1{1-\delta_k}\right\}
P_{k-1}(x,y),
&(x,y)\notin B_k.
\end{cases}
\tag{3}
\]
The source assumes (0\le\delta_k\le1/2). The formula must be represented with its branch conditions intact; do not silently replace the max/min by one selected branch.

Lemma 2.1 states, for every (Q_{k-1})-measurable set (S),
\[
P_k(S)=P_{k-1}(S),
\tag{4}
\]
for every set (S\subseteq Q),
\[
P_k(S)\le\frac1{1-\delta_k}P_{k-1}(S),
\tag{5}
\]
and for (S\subseteq B_k),
\[
P_k(S)\le P_{k-1}(S).
\tag{6}
\]
Consequently, if \(\sum_{k=a+1}^nP_k(B_k)<1\), the cover is impossible.

### Scalar identity behind (4)

For (0\le a\le1), (0\le d\le1/2), define
\[
u(a,d)=\max\left(0,\frac{a-d}{a(1-d)}\right),\qquad
v(a,d)=\min\left(\frac1{1-a},\frac1{1-d}\right).
\]
With rational division's totalized convention, the endpoint values are (u(0,d)=0), (v(0,d)=1), and (u(1,d)=1); the value of (v(1,d)) is irrelevant because the uncovered part of a fibre is empty when (a=1). For (0<a<1), a two-case split (a\le d) / (d<a) gives
\[
a\,u(a,d)+(1-a)\,v(a,d)=1.
\]
At (a=0) and (a=1), the same weighted normalization holds with the empty branch omitted. This is the exact finite-fibre calculation needed for marginal preservation.

The two pointwise bounds needed for (5)–(6) are
\[
0\le u(a,d)\le1,\qquad
0\le v(a,d)\le\frac1{1-d}.
\]
The first is used only on (B_k); the second applies off (B_k). Combined with uniform extension (P_{k-1}(x,y)=P_{k-1}(x)/|S_k|), these yield the three setwise conclusions of Lemma 2.1 by finite summation.

### Implementation warning

A Lean definition should use the finite counting ratio for \(\alpha_k(x)\), not divide by the marginal mass (P_{k-1}(x)\). The proof that it equals the quotient is a separate theorem under positive marginal mass. This makes zero-mass fibres well-defined from the start. The scalar normalization lemma should explicitly split (a=0), (a=1), (0<a<1\), and then (a\le d) versus (d<a). Only after this scalar lemma is kernel-checked should it be lifted to finite point weights and set masses.
