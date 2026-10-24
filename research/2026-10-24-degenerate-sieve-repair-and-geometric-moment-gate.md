# Degenerate sieve repair and geometric moment gate — 2026-10-24

## Status
Audit and implementation plan, not a proof of the Erdős–Selfridge theorem. The pinned upstream file still contains unproved axioms `sieve_criterion` and `sf_sieve_lt_one`. A successful build does not discharge these axioms.

## Confirmed interface defect
The current `sieve_criterion` interface does not require its delta parameter list to align with the block-size list. With `δs = []`, the local bounds quantified over delta indices are vacuous, the product defaults are degenerate, and rational division by zero is totalized. The audit test derives the contradiction through the axiom for an actual block-size list under the odd-covering-system premise. This identifies an unsound axiom interface, not a counterexample to the published mathematical theorem.

The same length-alignment problem exists in `sf_sieve_lt_one`: the constraints only range over `i < δs.length`, with no requirement that all extracted primes be represented. A length condition is necessary, but it is not sufficient to prove the theorem.

## Repair sequence
1. Create a patched local theorem interface in a separate file; do not alter or mislabel the pinned upstream source.
2. Prove the required alignment from the definitions of `extractPrimes`, `sfBlockSizes`, and `nonsfBlockSizes`. Confirm whether exact equality or a one-sided length bound matches every `getD` and summation index.
3. Add regression examples demonstrating that the empty list fails the repaired preconditions whenever the indexed family is nonempty.
4. Replace each axiom with a proof derived from the paper's hypotheses. Do not rename an axiom as a theorem or encode the desired inequality as a structure field and call it proved.
5. Audit transitive dependencies of the final theorem after each replacement.

## Geometric second-moment bridge
For a finite sample space Ω, nonnegative normalized weights μ, and event family E_i, the formal identity
`E[(sum_i 1_Ei)^2] = sum_{i,j} μ(E_i ∩ E_j)`
is algebraic infrastructure only. The source-specific obligation is to bound intersections of the actual BBMST hyperplanes/fibers.

The implementation must define the coordinate sets S_i, product spaces, projections, fibers, hyperplanes, and removed sets. Nonemptiness must be proved before dividing by |S_i|. Any geometric condition used by the stronger second-moment estimate must be derived from the hyperplane representation rather than supplied as a free Boolean assumption. Independence must not be assumed.

## Mathematical limits
The published square-free-moduli theorem is the relevant target, with its precise hypotheses. The current formal project has not reproduced the source's geometric probability argument end-to-end. The next success criterion is not more generic rational algebra: it is the first source-faithful geometric lemma, proved in Lean, with no project-specific axiom in its dependency trace.
