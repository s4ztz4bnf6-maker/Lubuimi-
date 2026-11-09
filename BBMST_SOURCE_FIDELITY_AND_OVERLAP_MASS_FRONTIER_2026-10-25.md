# BBMST source fidelity and exact overlap-mass frontier (2026-10-25)

## Published target

The target theorem is Balister, Bollobás, Morris, Sahasrabudhe and Tiba, *The Erdős–Selfridge problem with square-free moduli*, Algebra & Number Theory 15 (2021), 609–626, DOI 10.2140/ant.2021.15.609. The conclusion is restricted to distinct square-free moduli greater than one: such a covering system must contain an even modulus. This is not the unrestricted Erdős–Selfridge conjecture for arbitrary distinct odd moduli.

Published article and version comparisons: https://erdosproblems.ai/wiki/library/covering_systems/balister_2021_erdos_selfridge_problem_square_free_moduli
Publisher-supported PDF: https://par.nsf.gov/servlets/purl/10300177
Companion paper on uncovered-set density: https://digitalcommons.memphis.edu/facpubs/5342/
Supplementary optimization/code material: https://people.maths.ox.ac.uk/balister/Erdos-Selfridge.html

## Version-sensitive corrections that must survive formalization

The published version, rather than the 2019 preprint, is the specification:

- The published main statements explicitly exclude trivial hyperplanes and modulus one.
- Published Theorem 3.2 permits coordinate-set sizes at least two; the earlier preprint required at least three.
- The published proof of Theorem 3.1 uses a union-bound inequality, not an equality.
- Published Lemma 5.3 has the inequality mu-hat_k <= mu_k; the preprint printed the reverse direction.
- Published Proposition 4.1 states a limit, not merely a limit inferior.

These are mathematical statement-fidelity requirements, not cosmetic editorial differences.

## Local exact progress

The Lean module BBMSTProductBox.lean defines product-box events by fixed coordinate supports and proves their intersection classification directly from coordinate assignments. It now contains the normalized uniform-mass interface for individual events and pairwise intersections. For a pair H,K:

- if a coordinate fixed by both receives conflicting values, the intersection cardinality and normalized mass are zero;
- otherwise the intersection is the merged constraint system, and its mass is the product of cardinalities on coordinates free in both constraints, divided by the ambient product cardinality.

The new combined theorem is named product_box_intersection_uniform_mass_compatible_or_zero. Its commit is a257de2e7665a0b96ce60636aa07cb79fb3ffc24. At the time of writing, the CI run for this exact commit is in progress, so the theorem must not yet be described as CI-confirmed.

## The second-moment bridge

The finite identity

sum over samples of (number of satisfied events)^2 = sum over ordered event pairs of their intersection counts

has already been formalized. The new intersection-mass theorem provides the exact geometric kernel needed to replace each pairwise intersection count by a normalized product-box mass. This avoids an unjustified independence assumption: overlapping supports contribute an explicit overlap correction, while incompatible assignments contribute zero.

The next substantial proof task is to integrate this kernel into the source-faithful second-moment and filtration argument, then separately discharge the global overlap/tail estimates. A local exact counting identity does not prove the global density bound by itself.

## Open global obligations

1. Replace project-specific placeholders such as sieve_criterion and sf_sieve_lt_one with complete proofs or isolate them as unproved dependencies, never as part of a claimed final theorem.
2. Formalize the published filtration, conditional distributions, R_k/N_k/B_k and alpha_k quantities with exact hypotheses and edge cases.
3. Prove the second-moment estimate with all overlap classes represented correctly.
4. Import or reprove the companion density theorem and document every dependency of the final square-free-moduli result.
5. Run CI on the exact commit and perform a transitive axiom audit; additionally check statement fidelity against the published article.

## Integrity bar

A theorem is only promoted to a verified milestone after successful CI on the relevant commit, no project-specific sorryAx or unproved theorem in its transitive dependency graph, and a source-level audit of its definitions and hypotheses. Foundational axioms such as propext, Classical.choice and Quot.sound should be reported accurately rather than conflated with project-specific gaps.
