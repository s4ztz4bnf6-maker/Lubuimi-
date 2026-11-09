# BBMST finite-mass audit: next mathematical bridge (2026-10-26)

## Status boundary

The checked source file `BBMSTMassAuditCore.lean` contains generic finite-sum identities only. It does not prove the BBMST incidence estimate or the odd distinct covering-system conjecture. Keep this distinction in all downstream statements.

## Proposed source-faithful structure

Let (S) be a finite sample space with nonnegative weights (w:S\to\mathbb Q_{\ge 0}), and let (\pi:S\to I) be a finite-valued projection. For each (i\in I), define the fiber
\[
F_i=\{x\in S:\pi(x)=i\}.
\]
Given a removed region (R\subseteq S), define (R_i=R\cap F_i) and (U_i=F_i\setminus R_i). The first formal obligations are set-theoretic, not probabilistic:
1. (R_i\cap U_i=\varnothing).
2. (R_i\cup U_i=F_i).
3. (\sum_{x\in F_i}w(x)=\sum_{x\in R_i}w(x)+\sum_{x\in U_i}w(x)).

Prove (3) by finite-sum additivity and avoid conditional probabilities or division. Only after this identity is established should a normalized ratio be introduced, and then only with a separately proved positive denominator.

## Edge cases that must be explicit

- Empty index set (I) must not make a universal stage condition vacuous in a way that satisfies the intended global criterion.
- Zero-mass fibers must remain legal; they cannot be normalized by division.
- If a later denominator has form (4\delta(1-\delta)), establish (0<\delta<1) before dividing. A branch with (\delta=0) needs a separate argument, not Lean's totalized rational division.
- A finite mass identity does not imply the geometric incidence bound. The hyperplane family, dimension, nontriviality and parallelism hypotheses must be derived from the paper's definitions, not introduced as unconstrained assumptions.

## Next theorem target

Define a finite fiber partition with explicit predicates, then prove a theorem that every fiber's total weight is the sum of the removed and retained weights. Add an axiom audit for that theorem. This is a sound reusable lemma; the genuinely difficult open bridge remains the source-specific moment/minimax inequality and its extension to arbitrary rank.

## Source boundary

The BBMST 2021 result is for square-free moduli. It must not be silently generalized to all distinct odd moduli. A proof of the general conjecture requires a further argument that is not contained in finite-sum algebra.
