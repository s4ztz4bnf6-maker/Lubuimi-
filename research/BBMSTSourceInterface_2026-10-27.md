# BBMST source check: theorem interface and source-faithfulness

Date: 2026-10-27
Status: source comparison note; not a formalization or proof.

## Primary source located

Balister, Bollobás, Morris, Sahasrabudhe and Tiba, “The Erdős–Selfridge problem with square-free moduli,” Algebra & Number Theory 15 (2021), no. 3, 609–626, DOI 10.2140/ant.2021.15.609. Full article PDF: https://par.nsf.gov/servlets/purl/10300177

The article states in Theorem 3.1 a hyperplane-covering criterion: for a collection of nontrivial hyperplanes in Q=S₁×…×Sₙ, with no two parallel, a sum of terms min{Mₖ⁽¹⁾, Mₖ⁽²⁾/[4δₖ(1−δₖ)]} below 1 implies that the hyperplanes do not cover Q. Theorem 3.2 then bounds the first and second moments. This is a concrete target for the formal dependency graph.

## Consequences for the Lean interface

1. Model the product probability space and hyperplanes from the source, rather than encode only the final numerical inequality.
2. The hypotheses “nontrivial” and “no two parallel” are source hypotheses, not optional decorations; they must be definitions derived from the geometry, not free booleans that let a caller assert the result.
3. The moment quantities Mₖ⁽¹⁾ and Mₖ⁽²⁾ must be actual expectations under the source distributions, with their normalizations proved.
4. Theorem 3.1 and Theorem 3.2 are separate obligations. A valid delta-list does not prove the moment bounds; moment bounds do not construct the source's actual parameter package.
5. Keep the empty-list/zero-denominator regressions, but do not silently strengthen or weaken the paper's boundary assumptions. Match the exact theorem statement, including the treatment of delta_k=0 and every quotient's domain.

## Literature boundary

This square-free-moduli theorem proves a strong result for the square-free setting; it should not be conflated with the full open question of whether a distinct covering system with all moduli odd exists. The project's target and theorem name must identify exactly which result is being formalized.

## Acceptance criteria

- A named Lean theorem for each source transition: definitions -> probability identities -> Theorem 3.1 criterion -> Theorem 3.2 moment bounds -> application.
- No project-specific unproved axiom may stand in for the criterion or moment bounds.
- #print axioms and statement-fidelity review for the final theorem.
- Pinned Lean/Mathlib build and CI evidence attached to the exact commit.
