# BBMST research update: incidence energy, fiber scope, and theorem boundary
Date: 2026-10-26
Branch: `audit/bbmst-fiber-incidence-2026-10-26`

## What the current fiber lemma does—and does not—establish

The explicit-coordinate representation is a sound local abstraction: if the last coordinate is fixed to one value, then for any fixed prefix there is at most one compatible last-coordinate value. This is the singleton-fiber fact.

It is not yet a general incidence bound. If the last coordinate is free, the fiber size is the size of its allowed coordinate domain; if the coordinate domain or measure is weighted, cardinality alone does not give a probability bound. To use the lemma in BBMST, each hyperplane must be mapped to the paper's exact product space, coordinate domain, probability weights, and geometric hypotheses.

## New structural proposal: formalize the incidence energy before the optimized inequality

Let \(\Omega\) be a finite probability space and \(H_i\subseteq\Omega\) the source-defined events/hyperplanes. Define the multiplicity
\[
X(\omega)=\sum_{i=1}^{m}\mathbf 1_{H_i}(\omega).
\]
Then, by finite-sum expansion,
\[
\mathbb E X=\sum_i\mu(H_i),\qquad
\mathbb E X^2=\sum_i\mu(H_i)+2\sum_{i<j}\mu(H_i\cap H_j).
\]
These are exact identities, independent of any special geometry. They give a clean Lean layer with no hidden analytic assumption. The difficult source-dependent step is then isolated as a bound on the pairwise intersections \(\mu(H_i\cap H_j)\), derived from the actual BBMST hyperplane geometry and distribution.

For \(\mathbb E X>0\), the elementary second-moment inequality
\[
\Pr(X>0)\ge\frac{(\mathbb E X)^2}{\mathbb E X^2}
\]
can then be considered where its hypotheses and the exact finite probability normalization have been proved. It is not a substitute for the paper's sieve theorem; it is a modular route for making every geometric input visible.

## Required source-fidelity obligations

Before using the strengthened second-moment estimate, the formalization must establish the precise geometric side condition under which the paper permits it. Otherwise the weaker estimate that follows under the actually proved hypotheses must be used, even if it does not close the numerical inequality.

The remaining chain is:
1. pin and map the source's definitions and notation to Lean;
2. define the finite product probability space and events without degenerate parameter defaults;
3. prove the exact first/second-moment identities;
4. derive pair-intersection estimates from the stated geometric assumptions;
5. prove existence/validity of the initial distribution and parameters, including list-length alignment and positive denominators;
6. derive the strict sieve bound;
7. replace the project-specific axioms with theorems and run a transitive axiom audit on the final target.

The existing finite mass partition is bookkeeping only; it does not prove incidence, moment bounds, or the strict sieve inequality. Likewise, a green CI run verifies only the explicit commands and targets actually executed, not the mathematical source correspondence.

## Sources to use as constraints, not as authority by association

- BBMST source paper: https://doi.org/10.2140/ant.2021.15.609
- Lean reliability and statement-fidelity discussion: https://terrytao.wordpress.com/2026/10/09/what-mathematicians-should-know-about-the-lean-theorem-proverquestions-of-reliability-and-ai/
- AI-assisted Erdős problem context: https://www.quantamagazine.org/why-the-legendary-erdos-problems-are-falling-to-ai-20260803/
- MAA discussion: https://maa.org/math-values/ai-solves-an-80-year-old-erdos-problem/

This is a more modular proof plan, not a claim that the global Erdős–Selfridge/BBMST theorem is now established.


## New audit layer: the incidence Gram matrix

A useful intermediate object is the matrix
\[
G_{ij}:=\mu(H_i\cap H_j).
\]
For every real vector \(c=(c_i)\),
\[
c^T Gc=\mathbb E\!\left[\left(\sum_i c_i\mathbf1_{H_i}\right)^2\right]\ge 0.
\]
Thus \(G\) is positive semidefinite, and this statement needs only a finite probability space and nonnegative weights summing to one. Its diagonal is \(G_{ii}=\mu(H_i)\), while off-diagonal entries are precisely the intersection data the BBMST geometry must control.

**Why this helps:** it cleanly separates (i) a formally elementary positivity theorem, (ii) the source-specific theorem restricting which Gram matrices can arise from the paper's hyperplanes, and (iii) the final numerical optimization. A generic PSD bound is not automatically strong enough to prove the BBMST sieve estimate; any stronger claim must be derived from the actual incidence hypotheses, not inserted as an axiom.

Suggested Lean boundary:
- define the indicator of each event as a real-valued function on a finite type;
- define expectation by a normalized nonnegative weight function with a separately proved positive total mass;
- prove the Gram identity by finite-sum rearrangement;
- prove nonnegativity from pointwise square nonnegativity;
- only then introduce the BBMST-specific intersection constraints.

This is an additional reusable lemma architecture, not yet a Lean-checked theorem in this repository.
