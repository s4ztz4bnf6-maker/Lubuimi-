# Research note: division-free overlap-moment ledger for the BBMST bridge
Date: 2026-10-27
Status: combinatorial research specification only; not a Lean-compiled theorem and not an Erdős–Selfridge proof.

## 1. Isolate the exact finite problem

Let \(\Omega\) be a finite nonempty sample space and let \(E_1,\ldots,E_s\subseteq\Omega\) be the source-defined covering events (for a BBMST application these must be instantiated from the paper's actual finite model, not invented geometric predicates). Define the multiplicity
\[
m(\omega)=\#\{i: \omega\in E_i\}
\]
and the uncovered set \(U=\{\omega:m(\omega)=0\}\).

For each integer \(j\ge0\), define the binomial overlap moment
\[
M_j=\sum_{\omega\in\Omega}\binom{m(\omega)}{j}.
\]
Then \(M_0=|\Omega|\), and for \(j\ge1\), \(M_j=\sum_{|I|=j}|\bigcap_{i\in I}E_i|\). This is a division-free integer formulation: no probability ratio or denominator is needed to state the counting identities.

## 2. Exact inclusion-exclusion and certified truncation

For each \(\omega\), the identity
\[
\mathbf 1_{m(\omega)=0}=\sum_{j=0}^{m(\omega)}(-1)^j\binom{m(\omega)}j
\]
implies the exact finite identity
\[
|U|=\sum_{j=0}^{s}(-1)^jM_j.
\]
Bonferroni truncations give, for every \(r\ge0\),
\[
\sum_{j=0}^{2r+1}(-1)^jM_j\le |U|
\le\sum_{j=0}^{2r}(-1)^jM_j,
\]
where moments beyond the number of events are zero. Consequently, a strictly positive certified lower bound for an odd truncation proves that the events do not cover \(\Omega\).

This does not itself yield such a bound. The BBMST-specific work is to estimate the appropriate intersections/moments from the paper's geometry, with all indexing, degeneracies, and hypotheses preserved.

## 3. Proposed new interface: an overlap-moment certificate

Replace an opaque assumed conclusion such as a sieve criterion with a structured certificate containing:
- the exact finite space and event family;
- the integer moments \(M_j\) or proven upper/lower bounds for them;
- the chosen odd truncation order;
- a kernel-checkable inequality showing the resulting lower bound is positive;
- a source-fidelity record identifying which BBMST lemma supplies each geometric estimate.

The combinatorial layer can be proved generically in Lean. The geometric estimates must remain explicit theorem obligations; they must not be smuggled in as axioms or replaced by a predicate that simply asserts the desired non-covering conclusion.

## 4. Audit gates

1. **Finite identity:** prove the multiplicity/binomial identity and the finite sum rearrangement.
2. **Moment bounds:** derive them from the paper's definitions of the incidence sets, dimensions/codimensions, and parameter restrictions.
3. **Endpoint/degeneracy checks:** establish nonemptiness, typed index domains, positivity, and all denominator conditions before any division.
4. **Axiom audit:** inspect the transitive axioms of the final theorem, not only the helper lemma. A generic finite counting theorem is allowed to use the standard foundations of Lean/Mathlib; it must not depend on custom axioms such as sieve_criterion or sf_sieve_lt_one.
5. **Statement fidelity:** prove that the final theorem's hypotheses and conclusion match the cited BBMST result and the intended Erdős–Selfridge statement.

## 5. Stop condition

If the source-specific estimates do not yield a positive odd-truncation bound, this route has not closed the gap. Record the failed bound and its exact obstruction; do not claim the global theorem from mass conservation alone.
