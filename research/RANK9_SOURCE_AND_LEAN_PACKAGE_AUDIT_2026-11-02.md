# Source-level audit of the September 2026 rank-nine result and its Lean package

Date: 2026-11-02

## Executive status

Michael Schroeder's September 2026 preprint, version 1.0.1, states:

\[
\text{every finite covering by pairwise-distinct odd moduli }>1
\text{ has }\omega(\operatorname{lcm})\ge9.
\]

It also states the quantitative LCM bound
\[
\operatorname{lcm}\ge9,704,539,845
\]
and the density bound \(1/1,002,375\) for every finite distinct odd family supported on at most eight primes.

This is a major necessary-condition result, not a solution of Erdős–Selfridge. The companion explicitly says that the unrestricted existence question remains open.

**Audit outcome:** the paper-level reductions and the quantitative arithmetic were inspected. No elementary contradiction was found in the written prime-replacement, countable-completion, or final measure-contradiction steps. The decisive 28,001-entry certificate and the Lean source archive were not downloaded or rebuilt in this run. Thus this is a source-level audit, not an independent reproduction or kernel verification.

Primary source:
- [Rank-nine paper and proof materials, v1.0.1](https://michaelschroeder.ai/research/NinePrimeSupport/companion)
- [Paper PDF](https://michaelschroeder.ai/research/NinePrimeSupport/nine_prime_support_zenodo_v1.0.1.pdf)
- [Zenodo DOI 10.5281/zenodo.22759614](https://doi.org/10.5281/zenodo.22759614)

## 1. Statement identity and exact consequences

The paper defines a covering as a finite family of congruence classes whose union is \(\mathbb Z\), distinct when moduli are pairwise different, and odd when every modulus is odd; all moduli exceed one. This matches the mathematical content of Erdős Problem 7 and the official strict-covering formulation.

The public formal theorem names advertised by the companion are:
- Rank9.nine_prime_support_of_integer_cover;
- Rank9.strengthened_lcm_lower_bound_of_integer_cover;
- Rank9.uncovered_density_of_integer_family.

The formalization is stated to cover the rank theorem and the two quantitative corollaries, not the unrestricted conjecture.

The rank-nine theorem says that every hypothetical counterexample must have at least nine distinct prime divisors in its LCM. It does not say that a nine-prime cover exists, and it does not exclude rank nine or higher.

### Independent arithmetic check of the LCM corollary

Let
\[
P_9=3\cdot5\cdot7\cdot11\cdot13\cdot17\cdot19\cdot23\cdot29
=3,234,846,615.
\]
The square-free rank-nine case is bounded by the exact product-measure union bound
\[
\prod_{p\mid P_9}\left(1+\frac1{p-1}\right)
-1-\sum_{p\mid P_9}\frac1{p-1}
=\frac{295112669}{340623360}<1.
\]
So a square-free rank-nine LCM cannot cover. A rank-nine LCM must therefore have a repeated prime factor, and hence is at least \(3P_9\). If the rank is at least ten, it is at least \(31P_9>3P_9\). Thus the claimed strengthened bound is
\[
3P_9=9,704,539,845.
\]
The rational expression and all integer products above were independently recomputed exactly.

The density corollary is stronger in a different direction: it states that every finite distinct odd family supported on at most eight primes leaves natural density at least \(1/1,002,375\) uncovered, without assuming the family is a cover.

## 2. Audit of the written proof architecture

The written proof reduces rank at most eight to the first eight odd primes
\[
P=\{3,5,7,11,13,17,19,23\}.
\]
The key steps in the paper were checked at the level of their stated hypotheses and logical direction.

### 2.1 Prime replacement

For ordered prime supports \(p_i\le q_i\), the paper embeds base-\(p_i\) digit strings into base-\(q_i\) digit strings coordinatewise. The inverse image of a \(q_i\)-adic prefix cylinder is either empty or a \(p_i\)-adic prefix cylinder of the same depth. Distinct complete exponent vectors remain distinct, and nonzero vectors remain nonzero.

This is a valid monotone reduction from arbitrary supports of size at most eight to the fixed first-eight-prime support. The direction is important: a cover on the larger primes would pull back to a cover on the smaller reference primes.

### 2.2 Countable completion

The paper completes the finite family by adding one class for every pure prime power and for the finite mixed list
\[
15,21,35,45,63,75,105,165.
\]
For each selected modulus \(m\), the sum of reciprocal proper selected divisors is strictly less than one. Therefore their classes occupy fewer than \(m\) residues modulo \(m\), leaving a free residue.

If an existing \(m\)-class meets a selected proper-divisor class, it is contained in that smaller class; moving it loses no previously covered point. Later selected multiples are made disjoint from the fixed class modulo \(m\). The paper explicitly checks preservation at the countable limit, not only at finite stages.

This completion preserves the original covered subset. The proof does not make the invalid inference that an arbitrary countable family automatically covers the full profinite product.

### 2.3 Conditional kernels and convex comparison

The later argument constructs normalized conditional densities, bounded by explicit constants, which avoid the completed pure classes and charge losses to mixed classes. The paper then compares the actual conditional losses to nested auxiliary runs using convexity and exact cylinder-mass bounds.

The written lemmas specify:
- the current-loss kernel and its feasibility condition;
- reverse-coordinate domination for later cylinders;
- first-hit accounting of absolute losses;
- ordered-increment convex comparison;
- a subprobability comparison for arbitrary prime-power depths;
- the finite geometry reduction for the two anchor coordinates and the prescribed mixed-modulus projection.

These are the mathematically substantive non-computational steps. The paper's proof uses them to build a positive submeasure outside the completed family.

### 2.4 Finite certificate and final contradiction

The decisive proposition reduces the remaining parameter space to a finite list of integer inequalities. The paper reports 28,001 inequalities, with minimum surplus four in units of \(1/135000\). The four terminal states share the explicit positive margin
\[
\frac{5310-5299}{1000}=\frac{11}{1000}>0.
\]
The final proof combines the certificate with the measure-loss ledger to obtain
\[
\nu_{\rm final}(X)\ge\frac1{33750}>0,
\]
contradicting support outside a family that covers all of \(X\).

The proof architecture is logically coherent as written. The numerical certificate is decisive, however, and was not independently regenerated here. Therefore the source-level inspection must not be described as an independent proof of the rank-nine theorem.

## 3. Lean package and reproducibility audit

The v1.0.1 companion states that:
- all 24,918 project Lean proof sources, including generated certificate proofs, are included in the compact archive;
- the extracted project pins Lean to leanprover/lean4:v4.32.0-rc1;
- Mathlib is pinned to revision 360da6fa66c1273b76b6b2d8c5666fd5ac2e3b56;
- the public source modules include Rank9/RankNine.lean and Rank9/Corollaries.lean;
- the accepted axiom set is exactly {propext, Classical.choice, Quot.sound};
- the documented verification command rebuilds the proof, checks public statements and axiom dependencies, and performs an additional kernel replay from an empty environment;
- the formal development reuses the proved rank-eight theorem for smaller prime supports.

The paper describes a standalone Python checker, a C++17 integer-geometry routine, the integer certificate, and 28 rational closing records. It says a fresh reconstruction recovered all 28,001 inequalities, and that the Lean development proves the geometry inequalities, their consequences for actual losses, and the exhaustive case assembly. The external numerical programs are described as checkers, not trusted oracles.

### Version and verification distinction

Version 1.0.1 adds the DOI, ORCID, archived references, and updated package instructions. The companion explicitly says that the mathematical argument, Lean sources, and exact certificate inputs are unchanged, and that this edition does **not** claim a new full kernel replay. The paper describes the earlier verification procedure; the v1.0.1 packaging update is not itself a new replay receipt.

The companion exposes a compact 13.6 MB archive and separately preserves a 132 MB original archive. The expanded archive manifest lists 132,377,867 bytes and SHA-256
c7aafd219c89979379ca4541e2c1f527ae90f70e68ed9eede8b133391c1e9af5.
The public downloader verifies each of six parts and the combined archive hash.

**What was independently checked here:** the PDF, companion text, downloader source, manifest, public theorem names, Lean/Mathlib pins, and stated verification boundary.

**What was not independently checked here:** neither ZIP was materialized in the working environment; no source-file hashes were recomputed; no clean Lake build, axiom audit, or kernel replay was run; the 28,001-entry certificate was not regenerated. The archive links are visible, but the current environment could not retrieve the binary ZIP payload. The package's verification claims therefore remain author-reported in this audit.

## 4. Complementary primary results (not solutions)

### Schroeder: at most three prime factors per modulus

The companion for *Noncoverage for Distinct Odd Moduli with at Most Three Prime Divisors* (v1.0, 9 September 2026; revised 15 September) states that no finite distinct odd cover exists if every modulus has at most three distinct prime factors. Prime powers, residues, and the total prime support are unrestricted. The public Lean theorem is Erdos7.noncoverage_at_most_three_prime_factors.

The paper also gives a separate largest-prime-cutoff extension: a hypothetical cover must contain a modulus with at least four distinct prime divisors, all at most \(10^9\). The companion explicitly places this separate extension outside the Lean formalization. This result complements rank nine: one constrains the number of primes in each modulus; the other constrains the total prime support.

Source: [Three-prime-divisor companion](https://michaelschroeder.ai/research/ThreePrimeDivisors/companion).

### Filaseta–Kalogirou–Klein, 25 October 2026

Their preprint states that if the smallest modulus of a distinct covering system is a prime \(q\ge11\), then the reciprocal-modulus sum is at least \(1+10^{-28}\). It also rules out a covering made entirely of distinct multiples of \(q\). This is conditional on the smallest modulus being such a prime, so it does not handle every odd distinct covering.

Source: [arXiv:2610.34541](https://arxiv.org/abs/2610.34541).

### Hackmon, April 2026

The preprint states noncoverage for LCMs supported on at most four distinct odd primes, with arbitrary exponents, and an unconditional five-prime result for 98.2% of exponent configurations. The remaining 1.8% is tied to a separate CRT coverage-maximality conjecture. This is useful local weight/Bonferroni machinery, but it is not an unrestricted five-prime theorem.

Source: [On Odd Covering Systems with Few Prime Factors](https://rxiv.org/pdf/2604.0035v1.pdf).

### Öztürk, August 2026

The preprint claims closed-form exact-rational certificates excluding LCM below \(11,486,475\), together with infinite families and a finite \(u(M)\) formulation. It is not peer reviewed and was not independently verified in this audit. Its LCM bound is much weaker than Schroeder's claimed bound, but its survivor-grid and matching certificates are methodologically complementary.

Source: [Closed-form nonexistence certificates](https://www.researchgate.net/publication/412442828_Closed-form_nonexistence_certificates_for_odd_covering_systems).

### Mian–Siddique, July 2026

Their Lean repository advertises a sorry-free, kernel-checked exclusion \(\operatorname{lcm}>10000\), with the axiom set {propext, Classical.choice, Quot.sound}. This is a smaller numerical exclusion than the later rank-nine theorem, but it is an accessible independent formalization and a useful baseline.

Source: [Centurion Lean repository](https://github.com/ibrahimmian36/centurion), [arXiv:2607.25628](https://arxiv.org/abs/2607.25628).

## 5. The five standing sources: correct role and limits

1. **Quanta, 3 August 2026:** its article is about AI-assisted Erdős work, prominently the unit-distance problem. It is a methodological warning about literature search and human improvement of AI-generated proofs, not evidence for Erdős #7.  
   https://www.quantamagazine.org/why-the-legendary-erdos-problems-are-falling-to-ai-20260803/

2. **Tao / Hales, 9 October 2026:** emphasizes kernel checking and a separate human audit of statement fidelity, definitions, and axioms. This is directly relevant to our verification discipline.  
   https://terrytao.wordpress.com/2026/10/09/what-mathematicians-should-know-about-the-lean-theorem-proverquestions-of-reliability-and-ai/

3. **ProofAtlas:** its 28 August 2026 snapshot predates the September rank-nine preprint. Its full-prime minimax and arbitrary-rank notes are research-map context, not an up-to-date status authority or proof source.  
   https://www.proofatlas.ai/collaboration/odd-distinct-covering-system-conjecture/

4. **MAA, 1 June 2026:** its “AI Solves an 80-Year-Old Erdős Problem” article concerns the unit-distance problem, not the odd covering conjecture.  
   https://maa.org/math-values/ai-solves-an-80-year-old-erdos-problem/

5. **OpenAI, 6 October 2026:** describes a broad release of AI-generated mathematical manuscripts and Lean formalizations. It provides a transparency/release methodology, not evidence for a result on Erdős #7.  
   https://openai.com/index/sharing-ai-progress-in-mathematics/

## 6. Global status and the remaining gap

Taken at face value, the rank-nine and three-prime-divisor preprints jointly force any hypothetical odd distinct cover to satisfy both:
- at least nine distinct primes in the global LCM;
- at least one modulus containing four or more distinct prime factors, with the separate \(10^9\) cutoff extension stated at paper level.

They do not rule out a cover satisfying both conditions. Our new CRT results exclude additional explicit rank-nine families but do not make the hypotheses uniform over all nine-prime supports, arbitrary exponent vectors, and arbitrary residue placements.

**Single most important remaining gap:** prove noncoverage uniformly for every admissible LCM with at least nine prime divisors, while retaining the joint residue/prime-coordinate geometry. The local fibre-capacity and moment criteria are not automatic for arbitrary bases; the rank-nine paper's current method also identifies a rank-ten obstruction for its particular comparison architecture, not an impossibility theorem for all methods.

The original Erdős–Selfridge conjecture remains open. No complete proof or explicit counterexample is known in this project.
