# Source-fidelity and proof-gap audit — 2026-10-23

## Scope and target theorem
The target is the published result of Balister, Bollobás, Morris, Sahasrabudhe and Tiba, *The Erdős–Selfridge problem with square-free moduli*, Algebra & Number Theory 15(3) (2021), 609–626. It proves that a finite covering system with pairwise distinct square-free moduli must contain an even modulus. This note is a formalization plan, not a claim that the source proof has already been reproduced in Lean.

## Existing formal algebra
The current file BBMSTOverlapConditioning.lean contains finite rational sum identities, a pairwise-square-difference identity, finite Cauchy–Schwarz, and event-mass bounds. These are reusable algebraic infrastructure. They do not encode the source's coordinate spaces, hyperplanes, fiber measures, removed sets, or conditional distribution.

## Source-faithful milestone: normalize the model before proving inequalities
Use explicit finite coordinate types and explicit finite sets rather than fields that assert geometric facts as assumptions. Do not add arbitrary hypotheses such as isParallel, isNontrivial, or noCodimOne to force the intended conclusion.

The model should define, not assume: each coordinate space S_i, with nonemptiness established where required; product spaces Q_k and coordinate projection/fiber maps; the source's hyperplanes and the set F(A) of fixed coordinates; probability mass P_k, including normalization and zero-mass cases; removed set B_k and fiber fraction alpha_k.

## Lemma 3.3 proof obligations
For a <= k <= n, a Q_k-measurable hyperplane A, and F(A)=I union J, with I subset [a] and J subset [a+1,k], formalize P_k(A) <= c(I) nu(J). The induction must mirror the source:
1. Base k=a: use definition (9) of c and nu(empty)=1.
2. If coordinate k is not fixed by A, show A is measurable at the preceding level and use source equation (4) and induction.
3. If coordinate k is fixed, use source equation (5), including denominator and fiber cardinality, then apply induction to A^[k-1] and definition (10) of nu.

The implication “not fixed implies measurable at the preceding level” must follow from the actual hyperplane representation, not an unconstrained Boolean assumption.

## Lemma 3.4 / overlap moments
For nonempty S_k, define alpha_k(x)=|S_k|^(-1) sum over y in S_k of 1[(x,y) in B_k]. The moment bound must be derived by expanding powers into ordered tuples and applying actual hyperplane-intersection facts. A generic second-moment identity alone cannot supply the crucial geometric upper bound.

Keep separate: rational algebraic identities; nonnegative-mass inequalities; probability normalization; hyperplane geometry; final arithmetic covering-system argument.

## Degenerate cases
- Empty coordinate blocks and empty products.
- Zero weights or zero event mass.
- Denominators such as |S_k|: prove nonemptiness before division.
- Complement identities: normalization is enough for P(E)+P(E^c)=1; nonnegativity is separately needed for mass bounds.
- Repeated or dependent coordinate constraints: establish source hyperplane conditions from the chosen representation.

## References
- Oxford Research Archive, peer-reviewed published record and full-text access: https://ora.ox.ac.uk/objects/uuid:3c55267c-60be-4652-89a7-db3db5f62c25
- University of Memphis article record: https://digitalcommons.memphis.edu/facpubs/5868/
- DOI: https://doi.org/10.2140/ant.2021.15.609

## Verification gate
A milestone counts as completed only when definitions match the paper's indexing, degenerate cases are covered, target files compile in the pinned environment, #print axioms and dependencies are reviewed, and the lemma is compared statement-by-statement with the original source.
