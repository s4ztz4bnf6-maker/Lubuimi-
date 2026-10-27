# BBMST fiber-mass transport: exact bridge target
Date: 2026-10-27

Status: research specification. It is not a source-faithful proof of BBMST Lemma 2.1 and not a completed Lean result.

## 1. The repeated bottleneck

The scalar estimate
\[
g_\delta(\alpha)=\max\left(0,\frac{\alpha-\delta}{1-\delta}\right)
\]
is useful only after proving that this expression is the actual removed mass in the paper's finite-stage construction. The missing step is semantic, not algebraic: identify the real fiber, its point masses, the removed subset, and the update rule.

## 2. Proposed certificate: split before normalize

For a finite fiber \(F\), let \(w:F\to\mathbb Q_{\ge0}\) be the point-mass function and \(E\subseteq F\) the removed subset. Define the *unnormalized* quantities
\[
M_F=\sum_{x\in F}w(x),\qquad
M_E=\sum_{x\in E}w(x),\qquad
M_{F\setminus E}=\sum_{x\in F\setminus E}w(x).
\]
The first theorem should be the division-free mass split
\[
M_F=M_E+M_{F\setminus E}.
\]
Only after proving the source's positivity hypotheses should normalized quantities be introduced. This avoids encoding the degenerate case through totalized division, where a zero denominator can silently produce a misleading equality or inequality.

The certificate for one stage should carry:
- the finite fiber and its exact membership predicate;
- the weight function and proof of nonnegativity;
- the removed-set predicate;
- a proof of the mass split;
- the source-derived lower bound on the normalizing mass;
- the exact equality identifying the normalized removed mass with \(g_\delta(\alpha)\), if that equality is actually what the source definitions imply.

## 3. Moment transport theorem shape

Once the source equality has been established, the scalar inequalities can be lifted across fibers by summing with the correct nonnegative weights. The formal theorem should expose all assumptions explicitly:
1. a finite index type of fibers;
2. nonnegative fiber masses;
3. a proven correspondence between each fiber's alpha and delta and its removed mass;
4. positivity of every denominator used;
5. exact treatment of zero-mass and endpoint fibers.

A generic theorem about arbitrary alpha and delta is not a substitute for items 1–5. Nor can a geometric hypothesis be introduced as a free parameter if BBMST derives it from the arrangement.

## 4. Falsification checks

Before attempting the global sieve:
- construct the empty-parameter and zero-mass cases explicitly;
- test whether every claimed denominator is positive from upstream hypotheses;
- compare each definition with the cited BBMST equation, including indexing and endpoint conventions;
- inspect the transitive axiom list of the actual theorem being claimed, not only helper lemmas.

## 5. Proof boundary and next commit

The next proof-producing Lean step should formalize the division-free finite mass split from the actual source's finite type and weight definitions, then prove the normalization theorem under an explicit positive-mass hypothesis. Do not connect it to sieve_criterion until the degenerate parameter loophole is closed and the source's stage recursion has been reproduced.

This proposed interface is bookkeeping designed to make invalid normalization impossible to hide. Its value is measured by whether it lets the actual BBMST recursion compile without extra axioms, not by the terminology itself.
