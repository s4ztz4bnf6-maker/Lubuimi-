# External rank-nine frontier audit and project reprioritization

Date: 2026-10-30

## Executive finding

A current literature check materially changes the best next step for this repository. Michael Schroeder's version 1.0.1 preprint, dated 13 September 2026 and revised 15 September 2026, claims that every finite covering system with pairwise distinct odd moduli greater than one has at least nine distinct prime divisors in the LCM, with no restriction on prime-power exponents. Its companion advertises a Lean formalization of the rank theorem and two quantitative corollaries, supported by 28,001 integer inequalities and a reproducibility package.

This is a preprint claim and accompanying author-supplied formalization, not a peer-reviewed result in the evidence reviewed here. It is nevertheless the strongest statement-aligned current route located in this audit and should be treated as a high-priority independent reproduction target.

## Exact mathematical consequences claimed by the rank-nine source

If the theorem is correct as stated, then:
- no odd distinct covering can be supported on eight or fewer distinct primes;
- the LCM of any hypothetical odd distinct cover is at least 9,704,539,845;
- every finite distinct odd family with moduli > 1 supported on at most eight primes leaves natural density at least 1/1,002,375 uncovered.

These are necessary conditions and quantitative noncoverage results. They do not rule out a cover whose prime support has at least nine elements, so Erdős Problem 7 remains open.

The earlier rank-seven and rank-eight companions are useful historical cross-checks. The rank-eight paper reports a method-specific scalar architecture obstruction; that obstruction is explicitly not an impossibility theorem for other proof architectures. The rank-nine paper states that its proof combines completion, conditional reweighting retaining joint geometry of the two smallest prime coordinates, convex interpolation to finitely many vertices, mixed-modulus projection, exact geometric tails, and 28,001 integer inequalities.

## Consequence for our CRT / second-moment branch

The one-prime CRT fibre model and the pair-overlap lower bound
`Σ_{j<k}|U∩C_j∩C_k| ≥ binom(q,2)|U|`
remain exact necessary conditions under their stated finite hypotheses. However, no uniform arithmetic upper bound has been established here, and no implication from this inequality to the rank-nine theorem has been proved.

Therefore, the pair-overlap/compatibility-graph route should be retained as a separate exploratory lemma family, not presented as the current best closing route. The immediate high-value task is an independent source-level and Lean-level audit of the rank-nine package:
1. obtain the exact version 1.0.1 companion archive and verify its published SHA-256;
2. check the paper's definitions against the official Erdős #7 / StrictCoveringSystem statement, including finite-cover and LCM conventions;
3. reconstruct all generated Lean sources and verify every recorded hash;
4. build with the exact pinned Lean and Mathlib revisions from a clean environment;
5. run `#print axioms` / the supplied axiom gate for the headline rank theorem and both quantitative corollaries;
6. independently replay the 28,001 integer inequalities and geometric-tail certificates;
7. inspect whether the Lean theorem is fully closed under the advertised axiom set and whether the proof imports any unverified assumptions.

Do not copy a theorem statement or a certificate summary into this repository as if that were a proof. Prefer either a source-faithful dependency on a pinned upstream package (if licensing and project architecture permit) or a separate clean reproduction target.

## Current repository status

The active PR #50 contains the CRT fibre/allocation work and the second-moment bridge registration. The PR remains draft/open. Its current head at the time of inspection is `0572bc8477602fa04dc1d0fcaaa6bb1db50428df`. The two associated GitHub Actions runs are queued:
- `41051518215`: Lean degenerate-witness audit (patched toolchain);
- `41051518239`: BBMST indicator lemma check.

The commit status reports zero completed checks. No build, kernel verification, or axiom-free result is claimed for this head. The PR base is `audit/bbmst-lean435-security-baseline-2026-10-30`; this branch therefore also contains the earlier BBMST audit history. Do not merge solely because the new research note is complete.

## Five-source research discipline

1. Quanta Magazine, 3 August 2026: documents AI-assisted Erdős work, including a prominent example where initial literature checking failed and later human mathematicians substantially improved the proof. Lesson: establish novelty and exact statement identity before claiming a result.
2. Tao / Thomas Hales, 9 October 2026: discusses Lean kernel reliability, foundational metatheory, and the need for human auditing even when proofs are formally checked. Lesson: kernel checking is strong evidence, not a substitute for auditing the kernel, imported axioms, theorem statement, and source identity.
3. ProofAtlas, Odd Distinct Covering-System Conjecture: its displayed snapshot (checked 28 August 2026) still describes the full-p H=2 minimax and arbitrary-rank continuation as open. That snapshot predates the September rank-nine preprint and is therefore stale for the latest rank frontier. Its internal route-map computations are not independently verified by this repository.
4. MAA Math Values, 1 June 2026: discusses the AI-assisted unit-distance counterexample and human cleanup. This is a different Erdős problem; it is a methodological example, not evidence for Erdős #7.
5. OpenAI, 6 October 2026, updated 15 October: describes publication of mathematical results, Lean formalizations for many proofs, reasoning summaries, and attempt statistics. It supplies a transparency model, not evidence for any theorem in this repository.

## Primary sources

- Rank-nine companion, version 1.0.1: https://michaelschroeder.ai/research/NinePrimeSupport/companion
- Rank-eight companion, version 1.0.1: https://michaelschroeder.ai/research/EightPrimeSupport/companion
- Rank-seven companion, version 1.0.1: https://michaelschroeder.ai/research/SevenPrimeSupport/companion
- Erdős Problem 7 status: https://www.erdosproblems.com/7
- ProofAtlas route map: https://www.proofatlas.ai/collaboration/odd-distinct-covering-system-conjecture/
- Quanta: https://www.quantamagazine.org/why-the-legendary-erdos-problems-are-falling-to-ai-20260803/
- Tao / Hales: https://terrytao.wordpress.com/2026/10/09/what-mathematicians-should-know-about-the-lean-theorem-proverquestions-of-reliability-and-ai/
- MAA: https://maa.org/math-values/ai-solves-an-80-year-old-erdos-problem/
- OpenAI: https://openai.com/index/sharing-ai-progress-in-mathematics/

## Final status statement

The external rank-nine result, if its published proof package withstands independent reproduction, excludes all prime supports of size at most eight. It does not solve the unrestricted odd distinct covering conjecture. Our CRT pair-overlap result remains a necessary condition only. The repository has not yet reproduced the external theorem and its current CI checks are queued.
