# BBMST frontier update and route selection — 2026-10-26

## Scope and statement

The Erdős–Selfridge odd covering problem asks whether finitely many residue classes with pairwise distinct odd moduli greater than 1 can cover all integers. It remains open. The square-free-moduli case is known to be impossible (Balister–Bollobás–Morris–Sahasrabudhe–Tiba, 2021); this does not settle arbitrary odd moduli.

## Literature sweep: relevant recent frontier

A July 2026 Lean 4 preprint by Ibrahim Mian and Shayaan Siddique explicitly proves, kernel-checked, that any odd distinct covering has lcm greater than 10,000. It formalizes the density/abundancy reduction, the odd-abundant candidate floor, CRT-capacity certificates for 23 odd abundant numbers below 10,000, and a finite-to-infinite periodicity bridge. The paper says the contribution is epistemic/formal rather than new mathematics, and the conjecture remains open. This is a source-checked statement, not merely an unverified summary; the artifact itself has not yet been independently rebuilt in this repository.

A separate public preprint by Ege Öztürk reports a symmetry-reduced fixed-lcm decision procedure and recursive peeling certificates, with an exclusion up to lcm 405,404. Treat the numerical scope as a preprint claim until its exact certificate and Lean artifact are independently reproduced here. Michael Schroeder's project notes report a lower bound of eight distinct prime divisors for a hypothetical odd distinct covering; this also remains external until its source and formal artifact are audited.

## Consequence for this project

The next milestone is no longer to claim novelty from a generic exact cover checker or to repeat the already formalized lcm <= 10,000 exclusion. It is to reproduce and then extend the certificate pipeline beyond known limits.

Recommended route:

1. **Reproduce the reference theorem.** Pin the exact Lean/toolchain/mathlib versions and source commit of the Mian–Siddique development. Run its full build and transitive axiom gate after the relevant kernel fixes. Compare the theorem statement field-for-field with the official StrictCoveringSystem statement.
2. **Use abundancy as an outer filter.** A hypothetical odd covering with lcm N must satisfy the density/abundancy condition; candidate N are odd abundant numbers. This is necessary, not sufficient.
3. **Target the first surviving candidates.** The reference paper reports that its capacity certificates do not eliminate the first three unexcluded odd abundant numbers 10395, 12285, and 17325. Start with N=10395, produce an independent exact capacity/peeling certificate, and prove it cannot be covered by distinct proper divisors >1. A failure at N=10395 does not settle larger N.
4. **Symmetry quotient.** For fixed N, normalize residue choices under translations x -> x+t modulo N and any further automorphisms proved to preserve the covering property. Canonicalization must be accompanied by a completeness lemma, not merely heuristic pruning.
5. **Proof-carrying exclusion.** SAT/ILP may discover unsatisfiable instances or peeling traces, but the trusted result must be a compact certificate whose checker validates every branch and local inequality. The checker must reject truncated traces and must establish that all candidate moduli/residue branches were covered.
6. **Finite/infinite bridge.** Keep the bidirectional theorem explicit: a finite family covers Z iff it covers every residue modulo its lcm. Do not infer an exclusion of all odd coverings from a bounded lcm search unless a theorem bounds the lcm of every hypothetical covering.

## Exact arithmetic for the first surviving candidates

For a fixed LCM N, any covering with pairwise distinct moduli m satisfying 1<m<N and m|N must obey the necessary reciprocal-capacity inequality
sum_{m|N, 1<m<N} 1/m >= 1,
because the sum over the actual selected moduli must be at least 1 and is bounded above by the sum over all available proper divisors. The exact checker in research/tools/bbmst_divisor_capacity_certificate.py computes this bound using rational arithmetic and emits the full divisor list; tests are in research/tools/test_bbmst_divisor_capacity_certificate.py.

Exact results:
- N=10395: sigma_1(N)=23040, sigma_1(N)/N=512/231, available proper-divisor reciprocal capacity = 12644/10395, with 30 available proper divisors >1.
- N=12285: sigma_1(N)=26880, sigma_1(N)/N=256/117, capacity = 14594/12285, with 30 available proper divisors >1.
- N=17325: sigma_1(N)=38688, sigma_1(N)/N=12896/5775, capacity = 1942/1575, with 34 available proper divisors >1.

Independent exact arithmetic checked these three candidates and the identity capacity = sigma_1(N)/N - 1 - 1/N for every N from 2 through 149. All checks passed. These candidates pass this necessary condition, so it does not exclude them. This is a reproducible baseline for the next stronger local capacity or peeling certificate, not a solution of any candidate instance.

## Existing tools in this repository

- research/tools/bbmst_rational_dual_check.py: exact rational LP dual checker for a supplied matrix. It proves an upper bound for that LP instance only; it is not a covering-system proof checker.
- research/tools/bbmst_finite_cover_certificate_check.py: exact bitset checker for a proposed finite congruence cover. For period L and m|L, the mask (2^L-1)/(2^m-1) has bits at 0,m,...,L-m; shifting by residue r and OR-ing gives exact coverage of [0,L). It verifies a witness cover but does not prove no cover exists.
- research/tools/test_bbmst_finite_cover_certificate_check.py: regression suite for the finite checker.

A local differential check compared an independently reconstructed bitset implementation with direct scanning on 1,049 small systems and found agreement. This is useful testing, not a universal proof or a verified run of the current repository test suite. The current branch's newest CI status must be queried rather than inferred from an older run.

## Mathematical distinction: the square-free theorem is not the general theorem

The BBMST result translates square-free odd moduli to non-parallel hyperplanes in a product of finite sets. The proof's key mechanism is an exposed-coordinate sieve controlling the density of uncovered points. General odd moduli may contain repeated prime powers, so a faithful extension needs to preserve prime-power layers or a different encoding. One cannot simply drop square-freeness from the theorem's assumptions.

The most promising reusable formal target from BBMST is not an unrestricted “smooth geometric flow”, but a source-faithful finite incidence lemma: define the finite product space, hyperplanes by fixed coordinates, the uncovered sets R_k, newly exposed families N_k and unions B_k, then prove the exact recurrence R_k = R_(k-1) minus B_k and the measure/density inequalities under the paper's hypotheses. Only after this kernel-checked core is matched to the original theorem should it be connected to the arbitrary-moduli conjecture.

## Sources

- Erdős Problems, Problem 7: https://www.erdosproblems.com/7
- Mian–Siddique, kernel-checked lcm > 10,000 exclusion (July 2026): https://arxiv.org/abs/2607.25628
- Öztürk, “A symmetry-reduced decision procedure and computational results for odd covering systems”: https://www.researchgate.net/publication/412316619_A_symmetry-reduced_decision_procedure_and_computational_results_for_odd_covering_systems_the_Erdos-Selfridge_problem_Erdos_Problem_7
- Michael Schroeder's project notes: https://michaelschroeder.ai/
- Balister–Bollobás–Morris–Sahasrabudhe–Tiba, square-free case: https://doi.org/10.2140/ant.2021.15.609
- Formalized exclusion paper source: https://arxiv.org/abs/2607.25628

No global proof or counterexample is claimed.
