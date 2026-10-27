# BBMST / Erdős–Selfridge: parameter-integrity contract

Date: 2026-10-27  
Status: audit specification, not a proof of the theorem.

## 1. Reproduced specification defect

The current audit branch exhibits a degenerate witness with an empty
delta-list. The sieve product then terminates immediately, and the sieve term
can collapse to zero. A nonempty list alone is not enough:
a list containing delta=0 can still trigger division by zero in
4*delta*(1-delta). In Lean's rational arithmetic, division by zero is
defined, so it does not cause a type error; it can silently make an invalid
mathematical expression satisfy a numerical inequality.

This is a defect in the axiom interface, not a counterexample to the
published Erdős–Selfridge theorem.

## 2. Proposed type-level contract

For a finite stage list s, package parameters as data carrying proofs
of all of the following:
- deltas.length = s.length;
- for every in-range index i, 0 < delta_i < 1;
- every denominator used by a quotient is strictly positive;
- all stated constraints on c1,c3 are explicit;
- every index consumed by a product/sum is in range, so no getD default
  contributes to the theorem's mathematical meaning.

The existing ValidSieveParams prototype handles length equality and strict
range bounds. It is a useful start, but it does not itself prove that valid
parameters exist for the theorem's actual block-size list, nor does it
prove the sieve inequality.

## 3. Required repair of the theorem boundary

Do not keep sieve_criterion as an unconstrained axiom. Replace it only
after proving a theorem whose hypotheses include the complete parameter
contract and whose conclusion follows from the source-faithful BBMST
lemmas. Likewise, prove the existence of a valid parameter package from
the paper's actual parameter construction; do not introduce existence as a
new axiom.

## 4. Regression tests

The audit should retain tests for:
- empty delta list;
- a zero delta;
- too-short and too-long lists;
- valid, length-matched parameters;
- every denominator's positivity;
- the exact boundary values of all parameters;
- Lean #print axioms for the final theorem and every critical helper.

A regression test passing proves only that the test statement compiles. It
does not repair the axiom. The final acceptance criterion is a source-faithful
proof with no project-specific unproved axioms in the transitive dependency
closure, plus an independent statement-fidelity review.
