# BBMST finite-fiber bridge: research note (2026-10-27)

Status: proof architecture and audit checklist, not a proof of the Erdős–Selfridge/BBMST result.

## 1. The recurring bottleneck

The risk is a gap between a finite combinatorial/probability model and the paper's global sieve criterion. Proving a helper inequality or compiling a test file does not establish that bridge. The theorem statement, parameter conditions, finite sample space, incidence quantities, and every imported hypothesis must match the source.

## 2. Candidate structure: ratio-free defect ledger

Represent each stage of the argument as a ledger of nonnegative quantities and conservation/defect identities. Delay normalization and division until positivity has been established. For example, if a proof needs to compare a/b and c/d, establish b>0 and d>0, and prove the equivalent cross-multiplied inequality ad≤cb (or the correct direction) before introducing ratios. This avoids accidentally using Lean's totalized field division at zero.

The ledger should track:
- exact finite sets and fibers;
- disjointness and coverage of the partition;
- cardinalities or source-defined probability masses;
- nonnegative defect terms;
- each source equation/lemma and its parameter hypotheses;
- the remaining unproved bridge to the sieve criterion.

This is a design proposal, not a claim that the paper's main inequality follows automatically from mass conservation.

## 3. Three-layer formalization

1. FiberMass: define each fiber using the source's actual finite probability space and measure.
2. PartitionMass: prove disjointness, coverage, and exact sum of fiber masses, including empty fibers.
3. SieveBridge: derive the paper-specific incidence/moment inequalities from the cited assumptions. No free hypothesis equivalent to sieve_criterion or sf_sieve_lt_one may be hidden in this layer.

Parameter strata such as δ=0, 0<δ≤1/2, and boundary values must be handled explicitly. A disjunction like δ=0 or 4δ(1−δ)>0 is a guard, not a replacement for proving the target at the zero branch.

## 4. Audit gates

- Statement fidelity: cite the exact source equation and range beside each formal lemma.
- Degeneracy: test empty fibers, zero denominators, and endpoint parameters explicitly.
- Dependency closure: inspect the final theorem's transitive axiom list.
- Assumption audit: any imported sieve criterion must be marked conditional, not presented as a proof.
- Formal status: a successful CI run establishes only that the checked code compiles under that workflow; it does not validate source fidelity or eliminate mathematical assumptions.

## Next mathematically meaningful target

Prove a self-contained finite-fiber mass-conservation lemma in Lean using explicit hypotheses (finite sample space, normalized measure, partition coverage and pairwise disjointness), then make SieveBridge depend only on that lemma and explicit source-derived inequalities. This creates a verifiable seam where the real global gap is visible rather than concealed.
