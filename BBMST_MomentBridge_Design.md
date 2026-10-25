# BBMST moment bridge: formalization checkpoint

Status: design artifact, not a Lean proof of Theorem 3.1 and not a proof of the unrestricted Erdős–Selfridge conjecture.

## Objective

Replace the project-specific axiom `sieve_criterion` only after formalizing the finite-stage measure argument in Balister–Bollobás–Morris–Sahasrabudhe–Tiba, *The Erdős–Selfridge problem with square-free moduli*, Algebra & Number Theory 15 (2021), Sections 2–3.

The source's scalar condition is

\[
\sum_{k=a+1}^{n}\min\left(M_k^{(1)},
\frac{M_k^{(2)}}{4\delta_k(1-\delta_k)}\right)<1,
\qquad
M_k^{(1)}=\mathbb E_{k-1}[\alpha_k],\quad
M_k^{(2)}=\mathbb E_{k-1}[\alpha_k^2].
\]

The scalar inequality is only the final interface. It cannot replace the construction of the finite product probability spaces or the source's stage-wise estimates.

## Typed proof obligations

1. **Finite base space.** Define the finite product \(Q=S_1\times\cdots\times S_n\), with explicit nonemptiness assumptions on the coordinate sets wherever uniform probability is used.
2. **Geometric data.** Represent each hyperplane as a predicate or affine equation over the relevant finite coordinate sets. Encode nontriviality and pairwise nonparallelism as hypotheses, not as unconstrained Boolean flags.
3. **Stage filtration.** Define the source's \(R_k\), \(B_k\), and \(Q_k\) with their actual dependencies. Prove the set recursion and the required preservation of earlier-stage measurable events.
4. **Fibre proportions.** Define \(\alpha_k\) from the finite fibres and prove \(0\leq\alpha_k\leq1\).
5. **Stage measures.** Define \(P_k\) as finite sums with explicit normalization. Prove total mass one and the source's earlier-stage preservation property.
6. **Moments.** Define \(M_k^{(1)}\) and \(M_k^{(2)}\) as finite expectations, then prove the source's moment-to-stage-cost inequality.
7. **Summation.** Prove Theorem 3.1 from the stage-cost inequality by induction and a finite-sum bound. Only then connect the result to the geometric theorem and its stated square-free scope.

## Boundary contract for delta

The displayed denominator \(4\delta_k(1-\delta_k)\) vanishes at \(\delta_k=0\). Since Lean's rational division is totalized, a direct quotient at zero can silently encode a mathematically unintended value.

For the quotient-bearing theorem use a type carrying \(0<\delta_k\leq1/2\), unless the source proof explicitly handles the zero boundary by a separate case. Do not claim that this strengthened parameter contract alone proves the source's parameter-existence lemma.

## Audit gates

- No project-specific axioms in the dependency closure of the claimed theorem.
- No `sorry` or `sorryAx` in the theorem's transitive dependencies.
- `#print axioms` output recorded for the theorem and its bridge lemmas.
- Source theorem scope preserved: square-free moduli only where the paper requires it.
- CI success is evidence of compilation, not evidence that the encoded statement matches the source; source fidelity is a separate audit.

## Next concrete lemma family

Implement finite-expectation lemmas over `Finset` before introducing the geometry:

- nonnegativity of expectation for nonnegative functions;
- \(\mathbb E[f^2]\geq(\mathbb E[f])^2\) under a normalized finite measure;
- preservation of expectation for a function depending only on earlier coordinates;
- the exact source-specific bound connecting the stage loss to \(\min(M_k^{(1)}, M_k^{(2)}/(4\delta_k(1-\delta_k)))\).

The first two are generic finite-sum algebra. The third and fourth are where the source construction, rather than a generic inequality, does the substantive work.
