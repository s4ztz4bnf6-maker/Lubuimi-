# BBMST Module A checkpoint after CI success
Date: 2026-10-27
Branch: research/bbmst-interior-mass-certificate-2026-10-27
Status: the focused codimension-one restriction transport file compiles in CI; this is not the full BBMST theorem.

## CI result

Workflow run 40508881432 completed successfully:
https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/40508881432

Successful steps included the pinned upstream source, degenerate-witness tests, guarded stage-aligned parameter contract, finite moment inequalities, interior-fibre mass certificate, and `BBMSTRestrictionTransport.lean`.

This validates the code covered by those steps at the pinned toolchain. It does not remove the two deep project-local axioms from the audited upstream main theorem, nor prove the geometric reduction or the global sieve bound.

## What Module A now establishes

In `BBMSTRestrictionTransport.lean`:
- a generic finite-cover transport theorem: after restricting to points avoiding all removed cover members, the nonremoved members still cover the restricted domain;
- deleting one value from a coordinate set of size at least three leaves at least two values;
- membership in the dependent finite coordinate product with coordinate i changed to S_i.erase c is equivalent to original product membership and x_i != c;
- the coordinate-erased product is exactly the complement of the corresponding coordinate hyperplane inside the original product.

These are kernel-checked by the CI compile step. They formalize the product-level restriction mechanism.

## Remaining Module A obligations

The current file is not yet the full source-faithful geometric transport theorem. Still needed:
1. Encode each source hyperplane by a fixed-coordinate pattern, with codimension represented by the cardinality of its fixed-coordinate support.
2. Collect all codimension-one members and derive the actual per-coordinate deletion map from their fixed values.
3. Prove the deleted product is nonempty and all removed hyperplanes are avoided.
4. Restrict every surviving hyperplane and prove its support has at least two coordinates relative to the restricted box.
5. Prove nonparallelism is preserved from the source definition, not via an unconstrained Boolean field.
6. Carry the actual new coordinate cardinalities into the strengthened moment bound.

Only after these are formalized should Module B introduce affine hyperplanes over Q and prove geometric codimension facts. The fact that an intersection with a coordinate restriction need not itself be an affine subspace is a genuine modelling issue; the finite coordinate-cylinder model must be related to the paper's hyperplane definitions carefully.

## Axiom gate

No claim is made that `sf_sieve_lt_one` or `sieve_criterion` has been eliminated. Keep the axiom audit fail-closed: a green build of this module is a local result, not proof of the target theorem.
