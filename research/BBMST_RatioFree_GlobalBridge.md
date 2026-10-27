# BBMST: ratio-free fiber deficit and the missing global bridge

Status: proof-obligation ledger; not a proof of the global Erdős–Selfridge assertion.

## Keep finite mass conservation separate from the sieve theorem

For a finite probability space Ω and an event U ⊆ Ω, the uncovered mass is exactly μ(Ω \\ U) = 1 - μ(U). For a finite family of events E_i, the union mass is controlled by overlap data; intersections sharing coordinates must be conditioned on the shared assignment before factoring the remaining independent coordinates. Independence must not be asserted for overlapping events.

These finite identities are algebraic bookkeeping. They do not imply a uniform positive uncovered mass.

## Ratio-free formulation

Where a proof currently divides by a parameter-dependent quantity, retain the undivided inequality. For example, instead of asserting a ratio bound D/Q when Q may vanish, state the target as D ≤ c Q and split Q = 0 from Q > 0. In the zero branch, prove the needed conclusion directly from the original definitions; do not use field or rational division conventions to silently dispose of the case.

Likewise, require a nonempty, indexed parameter domain and explicit positivity assumptions at the interface. Typing guards prevent malformed data, but do not prove the geometric or probabilistic estimate.

## Exact missing bridge

The critical obligation remains a source-faithful estimate linking the BBMST geometric incidence / fiber distortion hypotheses to a second-moment bound strong enough to force a strict uncovered fraction. This must be proved from the paper's actual hypotheses and constants, not introduced as sieve_criterion, sf_sieve_lt_one, or an equivalent opaque premise.

## Audit gates

1. Statement fidelity: map every formal hypothesis to the source theorem and handle degenerate endpoints.
2. Kernel build: no sorry, admit, or hidden placeholder.
3. Transitive axiom audit: inspect the complete dependency closure, not just the theorem file.
4. Semantic audit: verify that the target conclusion is the intended unrestricted odd-covering statement and not a weakened finite or conditional version.

The finite-fiber identities are useful infrastructure; they do not close the global BBMST gap by themselves.
