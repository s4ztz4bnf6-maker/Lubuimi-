# Written Review — Syracuse Escape-Return Spectrum and Finite-Return Lemma

**Author:** Ta-Yoshua Lubuimi  
**Review date:** 10 November 2026  
**Review type:** Internal mathematical and formalization review; not independent peer review.

## 1. Conceptual distinction

For an accelerated odd Syracuse orbit, unboundedness and divergence are different:
- unboundedness means the orbit reaches arbitrarily large values;
- divergence to infinity means every fixed bounded set is visited only finitely often.

The escape-return spectrum records the last or arbitrarily late visits below each threshold. It is a bookkeeping structure, not by itself a descent or convergence theorem.

## 2. Deterministic finite-return theorem

For any deterministic map on a state space and any finite subset B, infinitely many visits to B force a repeated state. Determinism then makes the orbit eventually periodic. The proof is independent of Syracuse arithmetic.

Lean declaration:
DeterministicReturnTest.repeated_state_of_infinite_returns.

Exact verification: workflow 40602488631 on commit 798e427a9d71233e81c096d6d2329163a5626273. The declaration prints [propext, Classical.choice, Quot.sound]. The same run verifies the affine identity and margin-equivalence declarations in SyracuseAudit with the standard profile.

## 3. Correct Collatz target

The accelerated odd Collatz map has the fixed point 1. Thus the conjecture is eventual hitting of 1, not divergence of every orbit to infinity. A proof that all orbits diverge would contradict the conjecture. The escape-return spectrum instead distinguishes:
- trajectories with infinitely many returns below a fixed threshold, which are eventually periodic;
- trajectories with only finitely many returns below every threshold, which diverge.

To prove Collatz, one must rule out every nontrivial eventual cycle and every nonperiodic orbit that avoids 1. The finite-return theorem does not do this.

## 4. Relation to exact valuation cylinders and margin caps

The affine valuation-word identity and exact residue cylinders give finite arithmetic constraints on realized prefixes. The initial all-one cylinder theorem is Lean-audited separately. The general finite-word cylinder theorem and exact tail partition are mathematically proved in their own manuscript but remain unformalized in Lean.

The state-dependent non-descent margin cap has a separate Lean-verified core on exact commit ca48ec7fdad5e8d6f8aeb82fed8586a1b57c12bc (run 42728049650, Lean 4.34.1). It constrains the next valuation along a nondecreasing exact affine endpoint but does not exclude an infinite surviving path.

## 5. Separation from Erdős–Selfridge

The same branch's upstream Erdős–Selfridge audit prints named dependencies sf_sieve_lt_one and sieve_criterion for the main theorem. Those explicit assumptions belong to the sieve formalization, not to the deterministic finite-return lemma. The latter has the standard profile independently.

**Verdict:** The deterministic finite-return theorem is proved and Lean-audited. The escape-return spectrum is a useful classification framework. No classification of nontrivial Syracuse cycles and no global Collatz proof is claimed.

**Attribution:** Ta-Yoshua Lubuimi. AI tools are assistants only, not authors or independent mathematical verifiers.
