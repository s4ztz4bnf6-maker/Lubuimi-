# BBMST finite-moment cone and source-fidelity gate
Date: 2026-10-27
Status: research note; elementary lemmas are mathematical targets, not a compiled Lean artifact.

## 1. Audit conclusion: the recurring obstruction

The recurring failure mode is that a threshold or moment criterion is formalized independently of the probability distribution and geometric hypotheses that make it true in the paper. A valid formalization must construct one normalized finite measure, derive both moments from the same alpha, and carry the hyperplane/incidence assumptions into the theorem. A free criterion predicate cannot replace this chain.

Reference target: Balister–Bollobás–Morris–Sahasrabudhe–Tiba, “The Erdős–Selfridge problem with square-free moduli,” Algebra & Number Theory 15 (2021), 609–626, DOI 10.2140/ant.2021.15.609. Its square-free-moduli result should not be presented as solving the unrestricted distinct-odd-moduli problem.

## 2. A finite moment cone (ratio-free formulation)

Let Q be a finite nonempty type, p : Q → ℝ with p(x)≥0 and sum p(x)=1, and alpha : Q → [0,1]. Define moments from these same inputs:
\[
m=\sum_x p(x)\alpha(x),\qquad s=\sum_x p(x)\alpha(x)^2.
\]
Then
\[
s-m^2=\sum_xp(x)(\alpha(x)-m)^2\ge0,
\qquad m-s=\sum_xp(x)\alpha(x)(1-\alpha(x))\ge0,
\]
so m²≤s≤m. This describes a necessary moment cone. It is not, by itself, the BBMST lower bound: that still depends on the recursively defined distributions and the source's geometric conditions.

A formal API should use a structure whose fields include the finite type, nonnegative weights, normalization proof, alpha range, and definitions of m and s. Do not accept m and s as independent arbitrary numbers.

## 3. Eliminate division from the threshold interface

For d>0 and any real T, min(m,s/d)>T iff m>T and s>dT. Proof: since d>0, s/d>T iff s>dT; the minimum exceeds T iff both arguments do. This avoids division in the core theorem and makes d>0 an explicit hypothesis. It does not license setting d=0 or using totalized division in Lean.

If a published criterion has d=4δ(1−δ), prove 0<δ<1 before applying the interface; if the source requires a stricter interval, preserve that exact interval rather than weakening it. Reject empty parameter lists and missing parameters instead of supplying defaults.

## 4. Source-fidelity checklist

- Model the actual finite probability spaces and recursive laws P_k.
- Define alpha_k from the source construction, not as an unconstrained function chosen to satisfy the desired inequality.
- Encode hyperplanes and their incidence/nontriviality/parallelism as mathematical structures with proved properties, not free booleans.
- Prove the source's intermediate identities (including the stated Lemma 2.1 equations) from those definitions.
- Derive moments from the same P_k and alpha_k; prove moment bounds separately from the geometric lemma.
- Carry exact nondegeneracy conditions and parameter ranges into every division/ratio lemma.
- Audit transitive axioms and forbidden escape hatches (sorry, opaque theorem assumptions, getD defaults, free sieve_criterion).
- Compare the final Lean theorem statement line-by-line against the published theorem and distinguish the square-free theorem from the unrestricted open problem.

## 5. Next formalization milestones

A. Prove finite moment identities in a small Lean file over Finset sums.
B. Prove the ratio-free min equivalence under d>0.
C. Define a normalized finite distribution object and derive moments only through its fields.
D. Add source-specific geometric definitions and intermediate identities.
E. Run pinned Lean build, print axioms on the final theorem and every dependency, and inspect the actual theorem statement. Record results only after running them.

## 6. What this new structure contributes—and does not

The “moment cone” is a project-specific interface that separates universal convexity facts from the hard BBMST geometry. Its value is diagnostic: if a proof jumps from m²≤s≤m to the published threshold, the missing argument is visible. It is not claimed as a new theorem in the literature, nor as a solution to Erdős–Selfridge.
