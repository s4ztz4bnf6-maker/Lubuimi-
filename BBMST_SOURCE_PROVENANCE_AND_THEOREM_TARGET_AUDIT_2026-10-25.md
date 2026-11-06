# BBMST source provenance and theorem-target audit

Date: 2026-10-25
Branch: audit/overlap-moment-roadmap-2026-10-23

## Important source distinction

The project label BBMST refers to Balister, Bollobás, Morris, Sahasrabudhe and Tiba. The foundational distortion/sieve paper is *On the Erdős Covering Problem: the density of the uncovered set*, arXiv:1811.03547, published in Inventiones Mathematicae 228 (2022), 377–414: https://arxiv.org/abs/1811.03547 and https://doi.org/10.1007/s00222-021-01087-5.

The source used in the companion roadmap, *The Erdős–Selfridge problem with square-free moduli*, Algebra & Number Theory 15 (2021), 609–630, DOI 10.2140/ant.2021.15.609, is a related follow-up. Its own text says that its Theorem 3.1 essentially follows from the 2018 BBMST Theorem 3.1, while the follow-up's Theorem 3.2 supplies a geometrically motivated bound used in its square-free application. Source: https://par.nsf.gov/servlets/purl/10300177.

These papers share the distortion/fiber-sieve architecture, but they are not interchangeable statements. Formalizing a theorem in the square-free paper is not automatically a formalization of the full original BBMST theorem. The exact target must be named by paper version, theorem number, and full hypotheses.

## Formal progress now confirmed

The current `BBMSTProductBox.lean` geometry layer compiles in the audited workflow. It proves:

- agreement of values on shared fixed coordinates for any point in the intersection;
- equivalence between compatibility and nonempty intersection;
- disjointness when a shared fixed coordinate has conflicting values;
- equality of a compatible intersection with the merged coordinate constraints;
- an exact finite cardinality formula for compatible intersections and cardinality zero for incompatible intersections;
- the combined two-case intersection-cardinality theorem.

The successful audit workflow reports only standard axioms (`propext`, `Classical.choice`, `Quot.sound`) for these declarations and explicitly rejects `sorryAx` in its captured output. This is evidence for the compiled geometry module only, not for the global sieve theorem.

## Exact next proof obligations

1. Pin whether the target is original BBMST 2018 Theorem 3.1, the square-free follow-up's Theorem 3.1, or both. Record the statement verbatim in a source-mapping note.
2. Formalize the finite product spaces and coordinate filtration in the exact target paper.
3. Define the fiber removal fraction and adjusted measures with explicit nonzero-denominator hypotheses and zero-mass conventions.
4. Prove the measure-preservation and distortion inequalities before the first/second-moment estimate.
5. Prove the moment bounds from the fixed-coordinate combinatorics; do not replace them with a freely assumed overlap bound or an unproved `noCodimOne` predicate.
6. Only then assemble the global non-covering conclusion and audit the exact original statement.

## Status boundary

The current product-box result is a rigorously compiled geometric sublemma. It is not a new proof of the Erdős–Selfridge conjecture, the full BBMST density theorem, or the square-free application. The remaining central obligation is the source-faithful fiber/moment argument.
