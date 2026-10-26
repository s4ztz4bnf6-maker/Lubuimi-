# Research continuation: exact measures, then source-derived distortion

Date: 2026-10-23

## Exact finite measure layer

For finite coordinate spaces X_i with normalized weights w_i, and a cylinder fixing coordinates F to values v_i,

  mu(H)=sum_{x in product_i X_i} (product_i w_i(x_i)) * 1_H(x) = product_{i in F} w_i(v_i).

This follows by factoring the finite sum coordinatewise: fixed-coordinate factors collapse to w_i(v_i), and free-coordinate factors are sum_{x_i in X_i} w_i(x_i)=1. This statement applies to the product measure only.

## Improvement: every later bound must carry provenance

A scalar pair (C, eta) is not sufficient evidence for a BBMST distortion estimate. Introduce a proof-carrying stage record with:
- the exact finite state space and measure at stage k;
- the exposed-coordinate set and normalization theorem;
- the source-defined hyperplane predicate;
- a proof of the one-step pointwise density bound on the stated good set;
- a proof of the bad-set mass bound;
- a theorem deriving the resulting (C_k, eta_k), not freely supplied constants.

The transfer composition (C, eta) o (D, theta)=(CD, C theta+eta) can then combine only records whose bounds have been proved. This makes error-budget provenance machine-checkable.

## Source-faithful path to the main theorem

1. Prove the finite product cylinder/event-mass identity.
2. Separately define the stage measures P_k and Q_k and the source's measurable hyperplanes.
3. Formalize the induction in BBMST Lemma 3.3, including the case split according to whether the newly exposed coordinate belongs to F(A).
4. Formalize Lemma 3.4's actual minimal-cover dichotomy independently; a generic good/bad inequality does not imply it.
5. Derive the moment and covering conclusion only after the exact hypotheses and constants have been proved.

The relevant source is Balister, Bollobas, Morris, Sahasrabudhe and Tiba, The Erdős–Selfridge problem with square-free moduli, Algebra & Number Theory 15 (2021), 609–650, DOI: 10.2140/ant.2021.15.609.

## Exact arithmetic alternative

Where the proof requires finite rational inequalities, prefer a certificate consisting of rational numerators/denominators and a kernel-checked verification over floating-point numerics. If the argument requires an LP-produced distribution, separate discovery from verification: an external solver may propose a rational witness, but Lean must check normalization, support, and every required inequality exactly.

## Boundary

The product-cylinder identity is not the geometric distortion theorem, and a generic good/bad transfer does not prove Lemmas 3.3 or 3.4. The project-specific axioms identified in BBMST_ProofObligations.md remain blockers until replaced by source-faithful proofs.
