# BBMST checkpoint: replace the failed scalar potential with an auditable profile certificate

Date: 2026-10-26

## Exact conclusion retained

The ProofAtlas route reports a scalar-functional contradiction
\(\Phi_2\ge 50{,}213\) and \(\Phi_2\le44{,}449\), gap \(5{,}764\).
Until the reported integer-dual witness and full model are independently
reproduced, treat this as a source-reported route exclusion, not an independently
verified computation. It excludes the specified scalar sufficient condition if
the source model is correct; it does not refute the conjecture.

## New next-step proposal: profile lifting with a falsifiable criterion

A richer potential should not be introduced merely because it sounds plausible.
Define a state profile indexed by the finite shallow-type set \(\mathcal T\):
\[
m=(m_t)_{t\in\mathcal T},\qquad m_t\ge0,
\]
where each coordinate is the exact mass assigned to type \(t\) by the frozen
finite model. A candidate potential is
\[
V(m)=\sum_{t\in\mathcal T}w_t m_t
\]
with rational weights \(w_t\), but unlike the failed route, the weights are
chosen only after the complete placement constraints and exact dual witness
are available. The profile is useful only if it distinguishes configurations
that the old scalar map collapsed.

This is a research specification, not yet a theorem. It has a sharp falsification
test: if two admissible configurations have the same proposed profile but
different feasibility status or different optimal boundary values, that profile
is too coarse and must be refined.

## Reproducible exact-certificate protocol

Freeze and version the following data before optimization:
- ordered prime set and the twenty shallow depth types;
- all type-to-placement incidence coefficients;
- rational right-hand sides, objective coefficients, lower/upper bounds;
- root constraints, live-root cuts, and tight-cover cuts;
- exponent-padding and normalization rules.

For every candidate primal vector \(x\) and dual vector \(y\), store integer
numerators and positive denominators. An independent checker should verify,
using exact rational arithmetic only:
1. every primal constraint and variable bound;
2. every dual constraint and sign restriction;
3. primal/dual objective values and weak duality;
4. the exact margin claimed by the certificate;
5. a hash of the frozen model and certificate files.

Floating-point solver output may suggest a candidate but is not proof evidence.
A locally verified certificate is not the universal depth-two theorem: the
remaining placements must be covered by a complete enumeration or a proved
symmetry/reduction argument.

## Formalization order

1. Formalize the finite model and the exact rational feasibility statements.
2. Prove the checker correct (certificate acceptance implies the claimed bound).
3. Import the checker output as explicit finite data, not as an unverified oracle.
4. Prove the universal placement coverage separately.
5. Only then address the rank-stable arbitrary-rank continuation.

No new BBMST theorem, complete certificate, Lean compilation, or global conjecture
resolution is claimed by this checkpoint.
