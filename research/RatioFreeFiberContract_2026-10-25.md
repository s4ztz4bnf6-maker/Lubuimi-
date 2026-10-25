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
