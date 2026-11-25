# Ratio-free threshold interfaces for the BBMST criterion (2026-10-27)

Status: source-audit / formalization design note; not Lean-compiled and not a proof of the BBMST theorem.

## 1. Keep denominators out of the logical interface

The source criterion contains a term of the shape
\[
\min\left(M_1,\frac{M_2}{4\delta(1-\delta)}\right).
\]
A Lean interface should not introduce this quotient before proving \(0<\delta<1\). Under exactly that positivity hypothesis, and for any real threshold \(T\), the elementary equivalence is
\[
\min\left(M_1,\frac{M_2}{4\delta(1-\delta)}\right)>T
\iff
\bigl(M_1>T\;\land\;M_2>4\delta(1-\delta)T\bigr).
\]
The right side is ratio-free. It makes the denominator obligation explicit and prevents Lean's totalized division convention (in particular \(x/0=0\) in a field) from silently turning an invalid geometric parameter into an apparently valid certificate.

The equivalence is an algebraic interface lemma only. It neither proves the moment bounds for \(M_1,M_2\), nor the geometric hypotheses of the source theorem, nor existence of a suitable \(\delta\).

## 2. Preconditions are part of the theorem, not documentation

A robust parameter record should carry proofs of:
- \(0<\delta\) and \(\delta<1\), plus the source-specific restriction (for example \(\delta\le 1/2\) when required);
- finiteness and non-emptiness wherever the source theorem requires them;
- validity of the actual hyperplane family and its incidence/probability model;
- compatibility of each parameter list with the object it indexes;
- any positivity needed before division or logarithms.

Do not replace these with unconstrained booleans such as isNontrivial, isParallel, or codimOne. Encode the mathematical property itself and prove the required geometric consequences from the representation. Likewise, do not use getD defaults to conceal a missing indexed parameter.

## 3. Fiber mass is bookkeeping, not the hard theorem

For finite types \(\alpha,\beta\), a map \(f:\alpha\to\beta\), and weights \(w:\alpha\to\mathbb Q\), the fiber identity
\[
\sum_{b\in\beta}\sum_{a:f(a)=b}w(a)=\sum_{a\in\alpha}w(a)
\]
is pure reindexing. If weights are nonnegative and a fiber's total mass is zero, every weight in that fiber is zero. Neither fact supplies the BBMST moment estimates or their hypotheses.

## 4. Formal proof graph to insist on

1. Define the finite product probability space and its normalized measure.
2. Define hyperplanes and incidence indicators from actual coordinate equations.
3. Prove the source's expectation/moment identities (including the exact Lemma 2.1 equations).
4. Prove moment estimates under the source hypotheses.
5. Establish parameter admissibility and strict denominator positivity.
6. Apply the ratio-free threshold lemma.
7. Derive the source criterion and then the stated covering-system consequence.

Every arrow must be a theorem with explicit premises. The final theorem must cite no free sieve_criterion axiom and must not exploit an empty family, a totalized zero denominator, or an unrelated witness.

## 5. Audit rule

Keep three outcomes distinct:
- kernel checked: Lean accepted the term;
- assumption audited: the transitive axiom list contains only the intended foundations;
- source faithful: definitions and hypotheses match the published theorem, including edge cases.

All three are required. None implies either of the other two.
