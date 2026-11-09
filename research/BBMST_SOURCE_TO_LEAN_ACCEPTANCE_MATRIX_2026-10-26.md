# BBMST source-to-Lean acceptance matrix

Date: 2026-10-26
Status: research specification, not a proof of the Erdős–Selfridge conjecture.

## Scope guard

Balister–Bollobás–Morris–Sahasrabudhe–Tiba prove that a covering system with square-free moduli must contain an even modulus. Their paper does not settle the unrestricted Erdős–Selfridge question for distinct odd moduli. The Lean project must retain that scope distinction in the exported theorem statement.

Primary source: Balister et al., The Erdős–Selfridge problem with square-free moduli, Algebra & Number Theory 15 (2021), 609–626; arXiv:1901.11465; DOI 10.2140/ant.2021.15.609.

## The current trusted boundary

The finite-mass core proves only general finite-sum facts:
- additivity on disjoint finite subsets;
- partition of a finite carrier;
- if nonnegative rational weights on a finite set sum to zero, each point weight is zero.

These lemmas are valid and useful, but they imply no hyperplane-incidence estimate, no moment inequality, and no global sieve bound. The audited upstream theorem still depends on project-specific assumptions sieve_criterion and sf_sieve_lt_one. Passing CI does not remove those assumptions.

The empty-parameter test is an important negative witness: with an empty delta list the sum collapses to zero and the strict premise sieveSum < 1 becomes true, allowing the unproved interface to derive a contradiction conditionally on an all-odd covering system. This is an interface defect, not a counterexample to the mathematical conjecture.

## Source-to-Lean proof obligations

Each line below is an acceptance gate; no later stage may be accepted if an earlier gate is missing.

1. **Combinatorial input:** encode a finite covering system and its distinct moduli. State explicitly whether each modulus is square-free and odd.
2. **Finite probability space:** construct the actual finite product space used by the paper, with its coordinate sets and probability measure. Do not replace this by arbitrary weights without a theorem connecting them to the source construction.
3. **Hyperplanes/incidence:** define the source's hyperplanes from coordinates and prove the exact incidence/nondegeneracy conditions. Do not assume noCodimOne, isNontrivial, isParallel, or codimOne merely to obtain the desired bound.
4. **Fiber decomposition:** define the source projection and its finite fibers. Prove disjointness and exhaustive coverage. Use the division-free mass lemmas for zero-mass fibers.
5. **Moment inequalities:** formalize the exact hypotheses and conclusions of the paper's moment lemma(s), including the distinction between the general third-moment bound and any improved bound that requires an additional geometric condition.
6. **Parameter certificate:** encode each block and its δ parameter at the same Fin n index. Prove the source-derived range constraints (including the stated upper bound δ≤1/2 where applicable). A quotient branch must carry a proof of strictly positive denominator; δ=0 must take a separate branch rather than rely on Lean's totalized ℚ division.
7. **Global summation:** sum the local bounds over the source-defined fibers and prove the actual global sieve inequality.
8. **Arithmetic closure:** formalize the parameter construction, endpoint checks, prime-range split, and the final implication to the square-free-moduli theorem.
9. **Axiom and statement audit:** print axioms on the final theorem must expose no sieve_criterion, sf_sieve_lt_one, sorryAx, or equivalent unresolved project-specific dependency. Compare the theorem's quantifiers and hypotheses with the published square-free-moduli statement.

## Immediate research bottleneck

The project has reliable finite-mass bookkeeping but not yet the source-faithful geometric moment/incidence bounds or the complete parameter certificate. The next productive action is to translate one exact local lemma from the paper, including all hypotheses, and formalize its geometry before attempting the global theorem. Strengthening the generic finite-sum layer will not close the central gap.

## Formal reliability

Follow kernel checking with a statement-fidelity audit. For high-stakes claims, use an independently implemented checker where feasible, but do not treat multiple checkers as a substitute for correct theorem statements and a clean axiom dependency graph.
