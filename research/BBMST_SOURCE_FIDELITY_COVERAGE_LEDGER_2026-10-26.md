# BBMST source-fidelity and certificate-completeness audit
Date: 2026-10-26

## Source of the target theorem
Balister, Bollobás, Morris, Sahasrabudhe, Tiba, "The Erdős-Selfridge problem with square-free moduli", arXiv:1901.11465; published in Algebra & Number Theory 15 (2021), 609–626.
- arXiv: https://arxiv.org/abs/1901.11465
- Source-version-aware entry: https://erdosproblems.ai/wiki/library/covering_systems/balister_2021_erdos_selfridge_problem_square_free_moduli

The result is conditional on square-free moduli. It is not the unrestricted Erdős–Selfridge conjecture.

## Source-fidelity rules
The published statement's restrictions matter: exclude modulus one and trivial hyperplanes where the paper does so. A formal model must encode the published hypotheses, not quietly weaken them or exploit degenerate objects. The theorem target must be stated separately from any finite LP lemma.

For each formalized definition, record:
- source definition and page/equation;
- Lean definition and coercion path;
- nondegeneracy assumptions;
- finite universe and variable ordering;
- whether a sum is empty and how strict inequalities behave in that case;
- the exact theorem statement proved by the code.

## Proof-carrying optimization: two independent obligations
(1) **Witness validity.** Every primal/dual or Farkas witness must be checked over exact rationals for the exact frozen matrix, vector, and variable ordering.
(2) **Coverage/completeness.** The proof must establish that the finite LPs and branch tree cover every admissible case of the source theorem. Valid leaves cannot compensate for a missing branch.

For max cᵀx subject to Ax≤b, x≥0, a primal/dual pair is optimal only after checking primal feasibility, dual feasibility, and exact equality cᵀx=bᵀy. For infeasibility, a Farkas vector y must satisfy y≥0, Aᵀy≥0, bᵀy<0. These certificate forms must not be conflated.

## Exact arithmetic and strict margins
Use rational/integer arithmetic throughout the certificate checker. If a published solver output is rounded, first derive a rational interval containing the exact value; rounded decimals alone cannot certify a strict inequality unless the interval is provably separated from the threshold.

## New operational artifact: coverage ledger
Each branch node should carry:
- node identifier and parent;
- the exact proposition defining its admissible region;
- the exhaustive partition rule and a proof of disjointness/exhaustiveness;
- its children;
- the pruning certificate or terminal witness;
- the rational bound and strict margin;
- the source theorem clause represented by this node.

The ledger is itself not a proof until encoded and checked, but it makes the principal failure mode—an omitted admissible branch—auditable.

## Transfer theorem still required
To convert a finite certificate into a BBMST proof, prove a source-faithful encoding theorem, an exhaustive coverage theorem, and a rank/block composition bound with exact error. Without those, a checked LP certificate proves only a fact about its finite LP instance.

## Status
No complete branch tree, arbitrary-rank continuation, or Lean kernel check is claimed. The unrestricted Erdős–Selfridge conjecture remains distinct from the square-free-modulus theorem.
