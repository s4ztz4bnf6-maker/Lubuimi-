# BBMST fiber-incidence audit: next source-faithful lemma

Status: research specification and proof obligations, not a formalized BBMST theorem.

## Objective

Replace generic finite-mass bookkeeping with one lemma whose hypotheses and conclusion correspond to a specific displayed inequality in the original BBMST argument. A successful Lean build of generic sum identities is infrastructure only; it does not establish the geometric or probabilistic estimate required for the Erdős–Selfridge theorem.

## Required source-to-formal map

Before implementing the target inequality, record for every symbol:

- source paper and exact equation/lemma number;
- underlying finite probability space and its measure;
- event / hyperplane family and the map assigning each point to a fiber;
- the exact finite index set for stages, blocks, and parameters;
- normalization hypotheses, including whether the carrier or a fiber may be empty;
- the denominator's positivity proof, before any conditional probability or ratio is formed;
- the source-derived admissibility and bounds on every delta_k;
- whether the inequality is pointwise, averaged, or conditional on a nonzero fiber.

No getD, empty-list shortcut, or rational division-by-zero convention may discharge a source hypothesis. A zero-mass fiber should be handled in a separate branch using a ratio-free statement. If a geometric condition such as codimension one, nontriviality, or parallelism is needed, it must be derived from the actual construction, not supplied as a free predicate.

## Immediate target: ratio-free fiber decomposition

For a finite carrier Omega, a map pi: Omega -> I, and nonnegative point weights w, first prove the exact disjoint partition
sum over x in Omega of w(x) = sum over i in pi(Omega) of the sum over x in Omega with pi(x)=i of w(x).
Prove it by a finite partition / reindexing argument, with no division. For every fiber of positive mass, only then define its normalized conditional weights and prove their sum is one. For a zero-mass fiber, nonnegativity implies every point weight in that fiber is zero; use a ratio-free lemma instead.

This is a useful reusable bridge, but it is not yet the BBMST estimate. The next source-specific step must connect the fiber masses to the paper's actual geometric incidence or moment bound.

## Acceptance gates

1. Statement fidelity: each Lean hypothesis has a source citation and a mathematical justification.
2. Degeneracy: empty parameter sets, empty fibers, zero denominators, and boundary values are handled explicitly.
3. No hidden theorem assumption: sieve_criterion and sf_sieve_lt_one cannot remain axioms in a claimed final proof.
4. Geometric provenance: any hyperplane, projection, parallelism, codimension, and nontriviality property is proved from the construction.
5. Kernel / axioms: compile with the pinned toolchain, inspect the full transitive #print axioms closure, and record the exact commit and logs.
6. Independent mathematical audit: compare the formal statement line-by-line with the original paper and independently check the finite combinatorial argument.

## Negative tests

- Empty parameter input must not make the target theorem succeed vacuously.
- Zero-mass fibers must not trigger a normalized ratio.
- A missing source hypothesis must produce a failing test or an explicit unproved obligation, not an implicit default.
- The final Erdős–Selfridge theorem must fail the acceptance gate while either project-specific sieve axiom remains in its transitive dependencies.

## Scope

The finite partition and zero-mass lemmas are elementary infrastructure. They are not the paper's moment/incidence inequality, and they do not prove the unrestricted odd-moduli Erdős–Selfridge conjecture. The square-free-moduli result in the related literature must not be silently substituted for the unrestricted theorem.
