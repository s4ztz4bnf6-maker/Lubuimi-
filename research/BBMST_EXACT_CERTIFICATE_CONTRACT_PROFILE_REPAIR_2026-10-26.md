# BBMST continuation: exact certificate contract and profile-state repair

Date: 2026-10-26

## Purpose

The current ProofAtlas route reports that the fixed scalar depth-two boundary functional fails: its required lower bound is 50,213, whereas the interface permits at most 44,449, a gap of 5,764. This is a route-specific obstruction, not a counterexample to the Odd Distinct Covering-System Conjecture. The route must not continue by merely tuning coefficients of that same scalar functional.

Source: https://www.proofatlas.ai/collaboration/odd-distinct-covering-system-conjecture/

## A stronger finite proof contract

Any proposed replacement for the scalar route should be delivered as a certificate bundle, not a plot, floating-point optimum, or unexplained solver log. Each leaf in the finite search tree must carry:

1. A canonical encoding of the prime set, shallow type placement, root residue, exponent padding, and every correlated-measure/root constraint.
2. An exact rational primal feasible point and objective value, or an exact rational dual feasible point with its objective bound. All coefficients and bounds are serialized as integers or reduced fractions.
3. A verifier that checks every constraint using integer cross-multiplication only; no floating-point tolerance is permitted.
4. A parent/child coverage proof: each branch partitions the parent's admissible placements, and every pruned box is excluded by a stated exact inequality.
5. A dependency record proving that no assumption of independence/product measure, omitted exponent padding, or implicit relabelling of distinct moduli has entered.
6. A completeness certificate for the root search: all legal root residues and all twenty mixed shallow types are either covered by children or excluded by a verified cut.

A single local certificate proves only its own placement. The universal H=2 minimax theorem requires a finite coverage argument over every admissible placement, and the arbitrary-rank theorem remains a separate obligation.

## Exact dual checking

For a rational LP in standard form, a dual certificate is independently checkable by exact arithmetic. If the primal is a maximization problem
\[
\max c^T x\quad\text{subject to }Ax\le b,\;x\ge0,
\]
then a dual vector \(y\ge0\) with \(A^T y\ge c\) gives the upper bound \(c^T x\le b^T y\) for every primal-feasible \(x\), provided the signs and any equality/free-variable conventions are encoded correctly. In a real project, the verifier must match the actual model's mixed constraints and variable bounds; this textbook form must not be imposed if the source LP uses a different convention.

This exact check separates two logically distinct questions:
- certificate validity: does the supplied vector prove the stated bound for this encoded LP?
- model fidelity/completeness: does this LP exactly represent the mathematical placement problem, and have all placements been covered?

Both are necessary. Neither alone proves the conjecture.

## Proposed repair: enrich the boundary state, do not hide the failure

The next candidate should retain a vector-valued boundary profile rather than compressing all information into one scalar. A profile might record, for each relevant prime block, the mass split among (i) live roots, (ii) tight-cover roots, and (iii) deferred roots, together with an explicit padding/correlation tag. This is a design proposal, not an established sufficient statistic. It becomes mathematically useful only if:

- the profile is provably lossless for the boundary inequalities used in the proof, or a quantified error term is carried;
- every transition between prime blocks has an exact update rule;
- the potential decreases or its increase is paid for by a proved compensation term;
- the same adversarial placement that defeats the scalar functional is included as a mandatory regression test.

A multi-component state may avoid the known scalar obstruction, but it may also simply move the contradiction into one component. It must be tested against the retained dual failure before any claim of improvement.

## Two independent closure obligations

Finite full-p H=2: enumerate or prune all legal placements of the twenty mixed shallow depth types and export a rational certificate for every leaf. One inherited placement's positive DDA margin is not universal evidence.

Arbitrary rank: prove a rank-independent normalized potential or a quantified per-block distortion/compensation inequality. No finite H=2 certificate automatically establishes this extension.

## Integrity and evidence labels

Every generated artifact should be labeled as one of:
- EXACT-CERTIFICATE-VERIFIED: rational feasibility/bound checked by an independent verifier;
- MODEL-REPLAYED: source model and constraints reconstructed from primary data;
- PLACEMENT-COVERAGE-COMPLETE: all legal placements covered with a checked branch/pruning proof;
- THEOREM-PROVED: a mathematical argument proves the universal statement;
- CONJECTURE-OPEN: any missing obligation remains open.

Do not upgrade a status based on solver success, a positive margin in one case, or a successful Lean build of a weaker helper lemma.

## Immediate next experiment

1. Retrieve the original BBMST supplement's relevant C/Gurobi instance and exact d_k bounds.
2. Reconstruct one small placement end-to-end and compare its exact LP against the reported result.
3. Export a reduced rational certificate and write a verifier independent of the optimization library.
4. Encode the scalar failure as a regression fixture.
5. Only then add one profile coordinate at a time and measure whether it removes the failure without violating model fidelity.

## Status boundary

This note advances the reproducibility and proof architecture. It does not claim to have retrieved/replayed the original LP, verified the reported DDA certificate, closed the finite minimax inequality, or proved the Odd Distinct Covering-System Conjecture. The unrestricted conjecture remains open in the cited route.
