# Ratio-free fiber contract for the BBMST formalization

Date: 2026-10-25  
Status: next-step specification for the existing overlap/fiber roadmap; no global Erdős–Selfridge theorem claimed.

## 1. The mathematical bottleneck

The current formalization has useful finite overlap identities, scalar algebra, and parameter-degeneracy tests. The remaining difficulty is not the generic identity
\[
\mathbb E[\alpha^2]-(\mathbb E[\alpha])^2
=\mathbb E[(\alpha-\mathbb E[\alpha])^2]\ge0.
\]
It is to define the *actual* fiber density from the source's incidence geometry and prove the source-specific distortion and moment bounds. A surrogate coefficient vector with unconstrained geometry would formalize a different theorem.

## 2. Proposed ratio-free fiber object

For a finite source-defined fiber \(F_y\), let \(w:F_y\to\mathbb Q_{\ge0}\) be its point weights and let \(R_y,S_y\subseteq F_y\) be the removed and surviving subsets. Require a proved partition:
\[
R_y\cap S_y=\varnothing,\qquad R_y\cup S_y=F_y.
\]
Define finite masses without division:
\[
M_y=\sum_{x\in F_y}w(x),\quad
m_R(y)=\sum_{x\in R_y}w(x),\quad
m_S(y)=\sum_{x\in S_y}w(x).
\]
The first kernel theorem should be
\[
M_y=m_R(y)+m_S(y).
\]
It must hold even when \(M_y=0\); no ratio is needed for this identity. A second lemma should prove that if all weights are nonnegative and \(M_y=0\), then every point weight on the fiber is zero. Only after proving \(M_y>0\) may the development introduce a normalized density \(\alpha_y=m_R(y)/M_y\).

This ordering removes the division-by-zero escape hatch structurally rather than relying on a convention for \(\mathbb Q\) division. It also cleanly separates a valid algebraic lemma from the genuinely difficult geometric estimate.

## 3. The next theorem must be source-specific

After mass conservation, the next target is not merely \(0\le\alpha_y\le1\). It is the precise local distortion inequality for the paper's projection, hyperplane family, and propagated weights. The Lean interface must derive—not accept as arbitrary Boolean fields—the following facts:

- coordinate/index correspondence and the projection map;
- the actual fiber and its partition by the source-defined exceptional/hyperplane conditions;
- nontriviality and intersection/parallelism facts required by the paper;
- positivity of every denominator before a normalized ratio is used;
- the exact geometric hypothesis under which the improved second-moment estimate applies.

Then prove the moment bridge and sum over the real projection image, preserving multiplicities and exceptional fibers. A finite toy configuration is valuable as a regression test, but it is not the general square-free-moduli theorem.

## 4. Negative tests that should remain permanent

The existing audit found that empty parameter lists, zero deltas, and length-mismatched lists can make the current sieve expression collapse through default values or rational division-by-zero conventions. Keep these as regression tests. A repaired interface should reject such witnesses before the theorem is invoked.

The formal target must also distinguish the published square-free-moduli result from the unrestricted odd-covering problem. The latter must not be inferred from a theorem whose hypotheses cover only the former.

## 5. Operational proof gates

For every candidate theorem record:
- the exact source proposition and page/equation mapping;
- the finite incidence data and parameter indexing;
- Lean and Mathlib versions, commit SHA, and CI run;
- `#print axioms` for the target and all exported dependencies;
- a separate source-fidelity review.

The October 2026 discussion of AI-assisted mathematics reinforces that proof generation, statement fidelity, and proof checking are separate tasks. A successful compile proves derivability of the formalized statement from its premises; it does not prove that those premises encode the intended published theorem.

References:
- Quanta, *Why the Legendary Erdős Problems Are Falling to AI* (3 Aug 2026): https://www.quantamagazine.org/why-the-legendary-erdos-problems-are-falling-to-ai-20260803/
- Tao / Hales, *What mathematicians should know about the Lean Theorem Prover: questions of reliability and AI* (9 Oct 2026): https://terrytao.wordpress.com/2026/10/09/what-mathematicians-should-know-about-the-lean-theorem-proverquestions-of-reliability-and-ai/
- Lean FRO, *Postmortem for the Kernel Soundness Bug Hunt*: https://leodemoura.github.io/blog/2026-8-24-postmortem-for-the-kernel-soundness-bug-hunt/
- ProofAtlas: https://proofatlas.ai/
- MAA, *AI solves an 80-year-old Erdős problem*: https://maa.org/math-values/ai-solves-an-80-year-old-erdos-problem/


## 6. Source-faithful equation map checked against the published 2021 paper

Primary source: Balister, Bollobás, Morris, Sahasrabudhe, Tiba, *The Erdős–Selfridge problem with square-free moduli*, Algebra & Number Theory 15 (2021), 609–626, DOI [10.2140/ant.2021.15.609](https://doi.org/10.2140/ant.2021.15.609). The publisher-version PDF is also available at https://par.nsf.gov/servlets/purl/10300177.

### Geometry and stage definitions (pp. 610–612)

- The ambient box is \(Q=S_1\times\cdots\times S_n\), with each finite \(S_i\) having at least two elements.
- A hyperplane is a product whose coordinate factor is either the whole \(S_i\) or a singleton. Its fixed-coordinate set \(F(A)\subseteq[n]\) records exactly the singleton factors.
- “Nontrivial” is the predicate \(F(A)\ne\varnothing\); “parallel” means equality of fixed-coordinate sets. These are definitions derived from the hyperplane representation, not independent booleans that a caller may assign arbitrarily.
- \(F_k=\{F\in\mathcal F:F\subseteq[k]\}\), \(N_k=F_k\setminus F_{k-1}\), \(B_k=\bigcup_{F\in N_k}A_F\), and \(R_k=Q\setminus\bigcup_{F\in F_k}A_F\). In particular, \(R_k=R_{k-1}\setminus B_k\).

### Measure update and Lemma 2.1 (pp. 612–613, equations (2)–(6))

For \(x\in Q_{k-1}\), the removed fiber fraction is
\[
\alpha_k(x)=\frac{|\{y\in S_k:(x,y)\in B_k\}|}{|S_k|}.
\]
The next measure \(P_k\) is the paper's piecewise update (equation (3)), with separate covered/uncovered multipliers involving \(\alpha_k(x)\) and \(\delta_k\). The proof interface must retain the source range \(0\le\delta_k\le1/2\), positivity/nonzero-denominator conditions for each active branch, and the probability-mass normalization.

Lemma 2.1 requires three distinct facts, not one generic “preserves mass” claim:
1. \(P_k(S)=P_{k-1}(S)\) for every \(Q_{k-1}\)-measurable \(S\) (equation (4));
2. \(P_k(S)\le P_{k-1}(S)/(1-\delta_k)\) for every \(S\subseteq Q\) (equation (5));
3. \(P_k(S)\le P_{k-1}(S)\) whenever \(S\subseteq B_k\) (equation (6)).

The scalar theorem fiber_update_preserves_mass proves only the normalization calculation for one fiber; it does not by itself establish these measure-theoretic statements for the product box.

### The exact moment bridge (pp. 614–616, Theorems 3.1–3.2)

Write \(M_k^{(1)}=\mathbb E_{k-1}[\alpha_k]\) and \(M_k^{(2)}=\mathbb E_{k-1}[\alpha_k^2]\). Theorem 3.1's sieve criterion is
\[
\sum_{k=a+1}^{n}\min\left\{M_k^{(1)},\frac{M_k^{(2)}}{4\delta_k(1-\delta_k)}\right\}<1,
\]
which forces the uncovered set to be nonempty. This is the theorem-level bridge the current sieve_criterion / sf_sieve_lt_one interface must actually prove from the staged measure and union-bound argument, not assume.

Theorem 3.2 bounds the first and second moments using the paper's coefficient function \(c\) and distortion function \(\nu\), specifically \(M_k^{(1)}\le c_{k-1}(1)/|S_k|\) and \(M_k^{(2)}\le c_{k-1}(3)/|S_k|^2\). Under the additional source condition that no new-stage hyperplane has codimension one, it sharpens the second-moment bound to
\[
M_k^{(2)}\le\frac{c_{k-1}(3)-2c_{k-1}(1)+1}{|S_k|^2}.
\]
In the representation above, codimension one means exactly one fixed coordinate; at stage \(k\), this is the singleton fixed set \(\{k\}\). The condition must be proved from the actual \(N_k\) family and fixed-coordinate sets, not supplied as an unconstrained field such as noCodimOne.

**Zero-threshold edge case:** the published theorem's displayed fraction contains \(\delta_k\) in the denominator, while the measure construction permits \(\delta_k=0\) in its stated interval. The formalization must resolve this carefully by matching the exact theorem's intended hypotheses or a justified limiting/branch definition. Lean's rational convention \(x/0=0\) is not a valid automatic interpretation of the displayed real inequality. Keep the \(\delta=0\) regression tests and do not silently identify this ambiguity with a proof.

### Scope boundary

Theorem 1.1 proves nonexistence only for distinct square-free moduli: every such covering has an even modulus. It does not settle the unrestricted Erdős–Selfridge odd-covering conjecture. The geometric theorem 1.2 and its Chinese-remainder correspondence are required to preserve this exact scope.

Source lines checked from the publisher-version PDF: definition of hyperplanes and Theorems 1.1–1.2 (pp. 610–611); staged sieve and Lemma 2.1 (pp. 612–613); Theorems 3.1–3.2 and their proof (pp. 614–616).
