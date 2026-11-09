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


### Public OpenAI mathematics release: catalogue check

OpenAI's 6 October 2026 release describes 721 manuscripts in 373 families, with approximately 42% of top-line results formalized at the time of the README snapshot. The public repository's CONTENTS.md has no entry matching "Erdos"; a direct search of the catalogue did not identify an Erdős–Selfridge family. This is a bounded catalogue check, not a claim that the internal model never investigated the problem or that no related technique appears elsewhere.

Sources: [OpenAI release](https://openai.com/index/sharing-ai-progress-in-mathematics/), [public mathematics repository](https://github.com/openai/math), [catalogue](https://github.com/openai/math/blob/main/CONTENTS.md).

The public Erdős Problem 7 history page still lists the square-free BBMST result and earlier restrictions, but does not yet incorporate the September 2026 rank-seven/eight/nine preprints. It should therefore be treated as a problem-definition and classical-history source, not as a complete current literature survey: https://www.erdosproblems.com/history/7.


---

## 2026-11-09 literature and source recheck

### The five standing sources

1. **Quanta, 3 August 2026.** “Why the Legendary Erdős Problems Are Falling to AI” discusses the unit-distance counterexample and subsequent human improvement of that proof. It is useful context on AI-assisted discovery, but it is not evidence for Erdős Problem 7.  
   https://www.quantamagazine.org/why-the-legendary-erdos-problems-are-falling-to-ai-20260803/

2. **Tao / Hales, 9 October 2026.** The guest post explicitly requires both kernel checking and a human audit of statement fidelity and definitions, and recommends inspecting unauthorized axioms. This is the relevant verification standard for our Lean work; it does not endorse any particular odd-covering result.  
   https://terrytao.wordpress.com/2026/10/09/what-mathematicians-should-know-about-the-lean-theorem-proverquestions-of-reliability-and-ai/

3. **ProofAtlas.** The live problem page still labels the universal full-p depth-two minimax and normalized arbitrary-rank continuation as open. Its displayed mathematical status is explicitly checked 28 August 2026, before the September rank-seven/eight/nine preprints. It remains a route map, not a current literature authority or proof source.  
   https://www.proofatlas.ai/collaboration/odd-distinct-covering-system-conjecture/

4. **MAA, 1 June 2026.** “AI solves an 80 year-old Erdős problem” concerns the unit-distance problem, not odd distinct covering systems.  
   https://maa.org/math-values/ai-solves-an-80-year-old-erdos-problem/

5. **OpenAI, 6 October 2026.** The release explains its manuscript, Lean-formalization, citation, and reasoning-summary process. I also searched the public openai/math CONTENTS.md directly: it advertises 721 manuscripts in 373 result families, but has no Erdős–Selfridge / odd-covering entry. This is only a bounded public-catalogue check; it says nothing about unpublished internal work.  
   https://openai.com/index/sharing-ai-progress-in-mathematics  
   https://github.com/openai/math/blob/main/CONTENTS.md

### New primary papers and their exact scope

- **Schroeder, rank seven (1 September), rank eight (6 September), rank nine (13 September; v1.0.1 revised 15 September 2026).** The rank-nine paper is the strongest total-prime-support result found in this review: every finite odd distinct cover would have at least nine distinct primes in its LCM, with arbitrary prime-power exponents. The stated LCM lower bound is 9,704,539,845. The v1.0.1 companion lists 24,918 Lean sources and says the package update checks source identity and packaging but does not claim a new full kernel replay. The PDF reports 28,001 exact integer inequalities and the public Lean theorem names; those claims remain author-reported here because the archive could not be materialized and rebuilt in this environment.  
  https://michaelschroeder.ai/research/SevenPrimeSupport/companion  
  https://michaelschroeder.ai/research/EightPrimeSupport/companion  
  https://michaelschroeder.ai/research/NinePrimeSupport/companion  
  DOI: 10.5281/zenodo.22759614

- **Schroeder, at most three prime divisors per modulus (9 September; revised 15 September 2026).** Theorem 1.1 rules out a cover if each individual modulus has at most three distinct prime factors; prime powers, residues, and the total prime support are unrestricted. Its companion says Theorem 1.1 is formalized end to end in Lean with axioms {propext, Classical.choice, Quot.sound}. The separate extension that every hypothetical cover has a modulus with at least four distinct prime factors, all at most 10^9, is a paper-level result outside that Lean formalization. Together with rank nine, this gives two independent necessary conditions, not a contradiction.  
  https://michaelschroeder.ai/research/ThreePrimeDivisors/companion  
  DOI: 10.5281/zenodo.22760638

- **Filaseta–Kalogirou–Klein, arXiv:2610.34541 (25 October 2026).** For a distinct covering whose minimum modulus is a prime q≥11, Theorem 2 gives reciprocal-modulus sum at least 1+10^-28. Theorem 3 rules out a cover consisting only of distinct multiples of q. The more general Theorem 4 assumes every modulus not divisible by q exceeds 10^28/q. These are useful distortion-method bounds but are conditional on the minimum-modulus branch; they do not apply to every odd distinct system.  
  https://arxiv.org/abs/2610.34541

- **Mian–Siddique, arXiv:2607.25628 (28 July 2026).** The formalized exclusion is lcm>10,000 for every odd distinct cover. The paper reports 63 theorems with axioms {propext, Classical.choice, Quot.sound} and no sorry, native_decide, or solver in the trusted base. This is a smaller but independent kernel-checked baseline; it is subsumed numerically by the rank-nine claim if the latter is correct.  
  https://arxiv.org/abs/2607.25628  
  https://github.com/ibrahimmian36/centurion

- **Öztürk, three August 2026 preprints.** The symmetry-reduced fixed-LCM procedure reports no cover through lcm 405,404 (and a direct-solver range through 10,394). “Closed-form nonexistence certificates” reports a no-cover range below 11,486,475. “Certified coverage bounds” reports machine-checked certificates for all 3,978 odd-abundant candidates through 2,000,000. These are distinct computational/certificate contributions, all labelled preprints and not peer-reviewed on their ResearchGate records. Their finite ranges are much smaller than the rank-nine LCM lower bound, but their exact survivor-grid and peeling methods may still be useful as local certificate machinery.  
  https://www.researchgate.net/publication/412316619_A_symmetry-reduced_decision_procedure_and_computational_results_for_odd_covering_systems_the_Erdos-Selfridge_problem_Erdos_Problem_7  
  https://www.researchgate.net/publication/412442828_Closed-form_nonexistence_certificates_for_odd_covering_systems  
  https://www.researchgate.net/publication/412318119_Certified_coverage_bounds_and_a_nonexistence_range_for_odd_covering_systems_the_Erdos-Selfridge_problem_Erdos_Problem_7

- **Hackmon, April 2026.** The preprint reports noncoverage for prime support at most four and an unconditional five-prime result for 98.2% of exponent configurations, leaving a separate CRT maximality condition for the remaining 1.8%. This is a partial exponent-profile result, not a uniform five-prime theorem.  
  https://rxiv.org/pdf/2604.0035v1.pdf

- **Bispels–Cohen–Harrington–Lowrance–Pontes–Schaumann–Wong, Discrete Mathematics 349 (July 2026), 115013.** This studies a variant allowing one odd modulus to repeat while all other moduli remain distinct. It is adjacent to, not a solution of, the all-distinct conjecture.  
  DOI: 10.1016/j.disc.2026.115013

### Newly surfaced full-solution claim: Esposito

Zenodo record 10.5281/zenodo.18440762, “Global Nonexistence of Odd Distinct Covering Systems,” by Giovanni Esposito, claims a complete proof from a finite obstruction modulo 11025 and a “Distinctness Allocation Lemma.” The record is a version-1.0 preprint dated 31 January 2026 and exposes one PDF, with no Lean package or checker listed in its metadata.

The PDF binary was not accessible in this environment, so the complete paper is **not audited**. The abstract-level allocation premise is nevertheless not accepted as stated: distinctness does not make a kernel divisor d single-use across q-adic heights. For example, with M=3 and q=7, the distinct moduli 21=7·3 and 147=7²·3 can carry the classes 1 mod 21 and 100 mod 147. Both project to 1 mod 3, but their q-adic first digits are 1 and 2. A valid allocation lemma must retain the height label b and control repeated d across different q^b d. The abstract also needs a relative-capacity statement for the particular old-uncovered set U; a whole-base noncoverage statement alone does not imply that a new projected family cannot cover U. The full paper may contain refinements not visible in the metadata. Do not call the preprint false, but do not treat its abstract as a proof.  
https://zenodo.org/records/18440762

### Independent rank-nine audit boundary, rechecked

The PDF's written chain was re-read at the source level: prime-digit replacement, countable completion, capped current-loss kernel, convex/nested comparison, subprobability tails, charged forbidden fibres at 7, the fixed 165-projection at 11, exact geometric remainders, vertex interpolation, and the 28,001-entry closing certificate. The elementary reductions and the directions of the stated comparison inequalities appear coherent on this inspection; the finite certificate is the decisive computational input.

The compact 13.6 MB archive and the original six-part 132,377,867-byte archive are advertised by the companion. The manifest publishes SHA-256 c7aafd219c89979379ca4541e2c1f527ae90f70e68ed9eede8b133391c1e9af5. The downloader source checks all six part hashes and the combined hash. The archive could not be downloaded into this working environment, so no source hashes were recomputed, no clean Lean 4.32.0-rc1 / Mathlib build was run, and no kernel replay or 28,001-entry certificate regeneration was performed. The v1.0.1 companion itself explicitly says it does not claim a new full kernel replay. The rank-nine result therefore remains a strong source-reported preprint theorem, not an independent verification by this project.

### Project consequence

The strongest current external constraints are: (i) global prime support at least nine, and (ii) at least one modulus with at least four distinct prime factors, with the separate paper-level cutoff that all four or more factors can be chosen at most 10^9. Neither condition excludes a candidate satisfying both.

Our one-prime CRT work now has an exact compatible-intersection tensor and a quantitative deficit target, but no uniform lower bound for that deficit. The single central gap remains a residue-sensitive, height-sensitive inequality uniform over all prime supports and all prime-power exponents. The conjecture remains open in this project.
