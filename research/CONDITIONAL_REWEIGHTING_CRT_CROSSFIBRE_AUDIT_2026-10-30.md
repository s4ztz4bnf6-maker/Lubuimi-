# Conditional reweighting, the $G_p$ cap factor, and a cross-fibre overlap inequality

**Date:** 2026-10-30  
**Scope:** Audit note for PR #50. Research note only; not a proof of Erdős Problem 7.

## 1. Executive result

Two developments must be distinguished.

1. Michael Schroeder's September 2026 rank-nine preprint claims that every finite covering system with pairwise distinct odd moduli greater than one has at least nine distinct prime divisors in its LCM. Its abstract describes completion, conditional reweighting retaining the joint geometry of the two smallest prime coordinates, two deletion budgets, convex interpolation, a mixed-modulus projection, exact geometric tails/first moments, and 28,001 integer inequalities.
2. ProofAtlas's Odd Distinct Covering-System route map reports a normalized per-block distortion factor G_p and a logarithmic non-expansion budget. Its visible snapshot is dated 28 August 2026, predates the rank-nine preprint, and marks the universal full-p depth-two minimax and arbitrary-rank continuation as open.

The accessible material supports an architecture-level audit, not a complete independent verification of the rank-nine proof or its Lean package. The version 1.0.1 companion explicitly says that this edition checks source identity and packaging and does not claim a new full Lean kernel replay.

A concrete additional inequality does emerge from our CRT-fibre setup: a cross-fibre pair-overlap bound that excludes same-fibre pairs. It is exact and formally approachable. Whether it is absent from or improves the rank-nine proof remains unestablished until a line-by-line comparison with the full paper and proof package.

## 2. Rank-nine conditional-reweighting audit

### 2.1 Claim and status

The version 1.0.1 companion states that every finite covering system with pairwise distinct odd moduli greater than one has at least nine distinct prime divisors in the LCM, with no restriction on prime-power exponents. It also advertises:
- LCM at least 9,704,539,845 for a hypothetical odd distinct cover;
- uncovered natural density at least 1/1,002,375 for every finite distinct odd family supported on at most eight primes;
- a Lean formalization and 28,001 integer inequalities.

This is a necessary condition, not a resolution of the unrestricted conjecture: rank nine or greater remains possible.

### 2.2 What the conditional reweighting must preserve

The abstract says the reweighting retains the joint geometry of the two smallest prime coordinates. This is essential. If the two coordinates are correlated, replacing their joint conditional distribution by a product of marginals is invalid without a separate independence theorem.

The advertised proof chain is:
1. controlled completion of the congruence family;
2. conditional reweighting retaining the joint two-coordinate data;
3. two separate deletion budgets;
4. explicit convex interpolation reducing the remaining extremal cases to finitely many vertices;
5. a prescribed mixed-modulus projection;
6. exact geometric sums and first moments controlling omitted prime-power exponents;
7. a finite certificate of 28,001 integer inequalities.

This is a coherent architecture, but the abstract does not verify each implication. The proof audit must check:
- completion preserves the required cover/noncover implication and pairwise distinctness;
- conditional measures are defined, normalized, and nonnegative;
- the joint two-coordinate distribution is retained without an illicit product factorization;
- both deletion budgets have correct signs and endpoint cases;
- convex interpolation covers the entire admissible region;
- the mixed-modulus projection preserves all constraints;
- geometric tails are uniform in every omitted exponent;
- all 28,001 inequalities replay from exact inputs;
- the headline Lean statement matches the paper, with transitive axioms and generated-source provenance inspected.

**Audit limitation:** the companion page exposes the abstract, package metadata, archive SHA-256, and reproduction instructions, but the archive was not extracted and rebuilt in this session. None of the 28,001 inequalities, conditional-reweighting lemmas, or advertised Lean declarations has been independently replayed here. This is not evidence that the proof is wrong; it is a strict limit on the audit performed.

## 3. ProofAtlas G_p cap-factor audit

ProofAtlas reports the normalized non-expansion budget
\[
\sum_h -\log(1-\delta_h)\leq\log\frac{p-1}{p-2}=O(1/p),
\]
unless another potential component supplies quantified compensation.

This logarithmic step is valid provided:
- \(0\leq\delta_h<1\);
- the preceding multiplicative estimate is
  \[
  \prod_h(1-\delta_h)\geq\frac{p-2}{p-1};
  \]
- all factors are positive and the same block indices occur on both sides.

Taking negative logarithms gives the displayed sum. Moreover,
\[
\log\frac{p-1}{p-2}
=\log\left(1+\frac1{p-2}\right)\sim\frac1p.
\]

The public route map does not expose the definitions of G_p or \(\delta_h\), the underlying measure, or the lemma proving the product estimate. It labels this route statement as source-reported with dependencies incomplete. Thus the logarithmic transformation is checked conditionally; the derivation of the product inequality is not auditable from the route page alone.

The page also reports a raw scalar depth-two obstruction: an exact integer dual certificate gives 50,213 above the allowed 44,449. It leaves two independent bridges open:
- the universal full-p depth-two minimax inequality for all placements of twenty mixed shallow depth types;
- a rank-stable arbitrary-rank continuation satisfying the O(1/p) budget or supplying quantified compensation.

The page describes itself as a research map, not proof evidence. Its 28 August snapshot predates the September rank-nine result.

## 4. New exact inequality: cross-fibre pair overlap

Let:
- \(X=\mathbb Z/M\mathbb Z\) be the base period;
- \(T=\mathbb Z/q\mathbb Z\), with \(q\) coprime to \(M\);
- \(U\subseteq X\) be the residues missed by all old classes;
- \(J\) index the new congruence classes;
- \(C_j\subseteq X\) be the projected base class of new class \(j\);
- \(\tau:J\to T\) assign its q-fibre label.

Assume complete coverage of every q-fibre above every old-uncovered base point:
\[
\forall x\in U,\ \forall t\in T,\ \exists j\in J:
\quad x\in C_j\ \land\ \tau(j)=t.
\tag{F}
\]
Write \(J_t=\{j\in J:\tau(j)=t\}\).

### Theorem (cross-fibre pair-overlap lower bound)

For every two distinct labels \(s,t\in T\),
\[
\boxed{|U|\leq\sum_{j\in J_s}\sum_{k\in J_t}|U\cap C_j\cap C_k|.}
\tag{CF}_{s,t}
\]
Consequently,
\[
\boxed{
\binom q2|U|
\leq\sum_{s<t}\sum_{j\in J_s}\sum_{k\in J_t}
|U\cap C_j\cap C_k|.
}
\tag{CF}
\]

**Proof.** Fix \(s\ne t\). For each \(x\in U\), (F) supplies a class \(j\in J_s\) and a class \(k\in J_t\) both containing \(x\). Since the fibre labels differ, \(j\ne k\). Thus every \(x\in U\) contributes at least one incidence to the right side of (CF)_{s,t}. Count these incidences. Summing over the \(\binom q2\) unordered label pairs proves (CF). \(\square\)

The existing uncoloured inequality is
\[
\sum_{j<k}|U\cap C_j\cap C_k|\geq\binom q2|U|.
\]
The new inequality counts only pairs from different fibre labels. Same-fibre pairs are excluded because they do not witness coverage of two distinct q-fibres. This is a more structured necessary condition, although it need not be numerically stronger in every individual instance.

### Arithmetic CRT upper bound

Suppose \(C_j\) is one residue class modulo \(d_j\mid M\), with residue \(a_j\pmod{d_j}\). Put
\[
\chi_{jk}=1
\quad\Longleftrightarrow\quad
a_j\equiv a_k\pmod{\gcd(d_j,d_k)}.
\]
The generalized CRT gives
\[
|C_j\cap C_k|
=\chi_{jk}\frac{M}{\operatorname{lcm}(d_j,d_k)}.
\]
Since \(U\cap C_j\cap C_k\subseteq C_j\cap C_k\), (CF) yields
\[
\boxed{
\binom q2\frac{|U|}{M}
\leq
\sum_{s<t}\sum_{j\in J_s}\sum_{k\in J_t}
\frac{\chi_{jk}}{\operatorname{lcm}(d_j,d_k)}.
}
\tag{CRT-CF}
\]

If the old classes have moduli \(e_i\mid M\), the union bound gives
\[
\frac{|U|}{M}\geq
\left(1-\sum_i\frac1{e_i}\right)_+.
\]
Therefore
\[
\boxed{
\binom q2\left(1-\sum_i\frac1{e_i}\right)_+
\leq
\sum_{s<t}\sum_{j\in J_s}\sum_{k\in J_t}
\frac{\chi_{jk}}{\operatorname{lcm}(d_j,d_k)}.
}
\tag{CRT-CF'}
\]

The compatibility indicators are determined by the actual residues. Dropping them gives a coarser shift-independent upper envelope.

### Weighted version

For arbitrary nonnegative weights \(\lambda_{st}\) on unordered distinct fibre-label pairs,
\[
|U|\sum_{s<t}\lambda_{st}
\leq
\sum_{s<t}\lambda_{st}
\sum_{j\in J_s,k\in J_t}|U\cap C_j\cap C_k|.
\]
CRT gives the corresponding weighted arithmetic inequality. Optimizing the weights is an open computational/analytic task; no choice has yet been shown to improve the rank-nine bound.

### Private-witness consequence

If every new actual class is irredundant, it has a private point. Such a point must lie above \(U\), since otherwise an old class covers it. For each new class \(j\), choose a private pair \((x_j,\tau(j))\in U\times T\). Two different classes cannot have the same private pair, since both would cover that point. Thus
\[
\boxed{|J|\leq q|U|.}
\tag{PW}
\]
This is another exact necessary condition using irredundancy.

## 5. Relation to conditional reweighting

The cross-fibre inequality retains a discrete correlation: it records which new class covers which q-coordinate. It does not replace the two-prime conditional measure in the rank-nine proof and does not yet give a universal upper bound on its right-hand side.

A possible bridge is to use the q-labelled cross-pair matrix as a finite boundary profile in conditional reweighting. To matter, it must control one of the two deletion budgets or provide a quantified compensation term in the G_p distortion inequality.

Current status:
- proved here on paper: (CF), (CRT-CF), (CRT-CF'), and (PW), under the stated hypotheses;
- not proved: a uniform arithmetic upper bound on the cross-fibre CRT sum that contradicts (CRT-CF');
- not established: that these inequalities are absent from the full rank-nine manuscript;
- not established: any improvement of the rank-nine theorem or a proof of Erdős Problem 7.

## 6. Lean formalization target for PR #50

Add a separate abstract finite module before the arithmetic CRT layer:
1. finite types X, T, J;
2. a fibre map J → T;
3. projected finite sets C_j ⊆ X and an old-uncovered finite set U;
4. hypothesis: every x in U is contained in at least one C_j in every fibre t;
5. prove each pairwise bound (CF)_{s,t} by counting triples;
6. sum over unordered distinct fibre labels;
7. prove the private-witness injection J ↪ U × T;
8. instantiate X = ZMod M and T = ZMod q, then prove the CRT upper bound.

Do not identify projected moduli as distinct unless actual-modulus hypotheses imply it. Do not assume projections from different fibre labels are disjoint: they should overlap on the base because they cover different fibres.

## 7. Five-source discipline

- Quanta (3 August 2026): methodological context for AI-assisted Erdős research; its unit-distance example is a different problem.
- Tao/Hales (9 October 2026): formal checking, statement fidelity, kernel trust, and dependency auditing are distinct obligations. A green CI badge alone is not a mathematical audit.
- ProofAtlas: useful map of the G_p route and its open obligations, but the visible 28 August snapshot is dated and explicitly not proof evidence.
- MAA (1 June 2026): discusses the planar unit-distance problem, not Erdős Problem 7; methodological context only.
- OpenAI mathematical-paper release (6 October 2026, updated 15 October): a transparency/provenance model, not evidence for this theorem.

## 8. Repository evidence snapshot

PR #50 was open/draft at head e7fe37cfd81c11252cdc25fda5491ea4939adc66 when this note was prepared. The two associated runs were queued:
- 41052318264: Lean degenerate-witness audit (patched toolchain);
- 41052318250: BBMST indicator lemma check.

The commit status had no completed checks. This note adds no Lean code and claims no compilation, kernel verification, or axiom-audit result.

## Sources

- Schroeder, Nine Prime Divisors in Odd Distinct Covering Systems, version 1.0.1: https://michaelschroeder.ai/research/NinePrimeSupport/companion
- ProofAtlas, Odd Distinct Covering-System Conjecture: https://www.proofatlas.ai/collaboration/odd-distinct-covering-system-conjecture/
- Mian–Siddique, Kernel-Checked Exclusions for the Erdős–Selfridge Odd Covering Problem: https://arxiv.org/abs/2607.25628
- Tao/Hales, What mathematicians should know about the Lean Theorem Prover: https://terrytao.wordpress.com/2026/10/09/what-mathematicians-should-know-about-the-lean-theorem-proverquestions-of-reliability-and-ai/
