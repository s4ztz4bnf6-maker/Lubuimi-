# BBMST: proof-carrying exact rational certificates

Date: 2026-10-26

## Purpose and status

This note specifies a reproducible interface between finite optimization experiments and a formal mathematical proof. It does not claim to reproduce the published BBMST computation or prove the unrestricted odd distinct covering-system conjecture.

The design principle is: an optimizer may discover a candidate certificate, but the optimizer must not be part of the trusted proof checker.

## 1. Exact primal/dual certificate interface

For a rational linear program in standard form
\[
\max\; c^T x\quad\text{subject to }Ax\le b,\quad x\ge0,
\]
a dual-feasible vector \(y\ge0\) with \(A^T y\ge c\) gives the upper bound
\[
c^T x\le y^T A x\le y^T b
\]
for every primal-feasible \(x\), assuming \(b\) is handled with the corresponding sign convention. Thus a candidate certificate is only meaningful together with the exact primal constraints, variable domains, objective, and sign convention.

For a minimization problem, or equality constraints, the dual conditions must be transformed consistently; never reuse a certificate under a changed normalization.

**Certificate payload required for every finite instance:**
- immutable instance identifier and source revision;
- ordered variable and constraint names;
- exact integer/rational matrix entries and right-hand side;
- exact objective coefficients;
- all variable bounds and integrality declarations;
- exact primal witness, if claiming a feasible lower bound;
- exact dual witness and its sign convention, if claiming an upper bound;
- exact objective values and the exact rational gap;
- a small independent verifier that checks every constraint with integer cross-multiplication.

Decimal solver output is diagnostic only. It is not the certificate.

## 2. What an exact certificate proves—and what it does not

A valid primal witness proves feasibility and an attained objective value for that instance. A valid dual witness proves a bound for that instance. A positive margin for one placement does not prove a universal minimax inequality over all placements.

A finite family of certificates closes the universal finite problem only when there is also a proved coverage argument showing that every admissible placement is represented by a certified leaf, or is reduced to one by a sound pruning inequality. The coverage/pruning proof is a separate theorem and must be checked independently.

Similarly, a finite full-prime or depth-two result does not automatically imply the arbitrary-rank conjecture. The rank-extension argument needs a separately proved invariant/potential and an explicit distortion budget.

## 3. Adversarial regression suite

The reported scalar-functional conflict (\(\Phi_2\ge 50{,}213\) versus \(\Phi_2\le44{,}449\)) should be retained as a regression test against that specific scalar route, provided the original instance and dual witness are recovered and independently checked. Until then, label it **source-reported, not independently reproduced**.

Any proposed enriched profile must be tested on:
1. the same placement and exact dual obstruction;
2. boundary placements with tight-cover constraints active;
3. exponent-padding cases;
4. correlated shallow-measure cases;
5. every symmetry reduction used by the enumerator.

If an enriched state passes these tests, that is evidence for the model, not yet a universal theorem.

## 4. Exact verifier algorithm

Represent each rational as a normalized pair \((p,q)\) with \(p\in\mathbb Z\), \(q\in\mathbb Z_{>0}\). For every row, evaluate the linear form by exact integer/rational arithmetic and compare without floating point. Reject:
- missing or reordered rows/columns;
- implicit defaults for bounds;
- any nonpositive denominator;
- certificates using a different instance hash;
- rounded coefficients or rounded objective margins;
- a claimed universal result with no coverage proof.

The verifier should be substantially smaller than the optimizer and should accept only a serialized certificate plus the frozen instance. The final theorem can then formalize the same finite checks in Lean, or verify a generated certificate whose soundness theorem is proved in Lean.

## 5. Lean proof architecture

Keep three propositions separate:

1. `CertificateValid(instance, cert)`: all exact inequalities and bounds hold.
2. `InstanceBound(instance, B)`: every feasible point for this instance obeys the bound, derived by weak duality or a verified exhaustive certificate tree.
3. `UniversalFiniteBound(family, B)`: every admissible instance is covered by the finite family or a proved reduction.

The unrestricted conjecture is a fourth and strictly stronger obligation. It must not be identified with any of the first three.

Avoid a theorem whose hypotheses contain the desired minimax bound as an unconstrained field. Avoid hidden optimizer output, floating-point tolerances, or unverified claims about model coverage.

## 6. Next experiment and stop conditions

- Retrieve the original supplement's exact instance, scripts, and LP witness.
- Rebuild the model from the published definitions before using the reported values.
- Compare the independently computed matrix dimensions, constraint count, and exact primal/dual margins with the source.
- If the witness fails, publish the smallest violated constraint and preserve the failing input.
- If the witness passes, test whether the model's finite instances cover every placement; do not jump directly to arbitrary rank.
- Stop the scalar route if the recovered exact dual obstruction reproduces; invest instead in a richer state only if its additional coordinates have a mathematically justified invariant.

## Status

This is a proof-engineering specification. It is not a new theorem about covering systems, and no published LP instance has yet been independently replayed in this project. The unrestricted odd distinct covering-system conjecture remains open.
