# BBMST continuation: prime-power level vectors, source alignment, and independent acceptance

Date: 2026-10-26

## Status

Research and formalization plan. No new theorem about unrestricted Erdős–Selfridge has been proved in this note. The main actionable improvement is to stop treating the square-free hyperplane model as the only representation and to build an explicit bridge between the published theorem, the existing local Lean audit, and the recent prime-power level-vector approach.

## 1. Source boundary

Balister–Bollobás–Morris–Sahasrabudhe–Tiba, The Erdős–Selfridge problem with square-free moduli, Algebra & Number Theory 15 (2021), arXiv:1901.11465, proves the square-free-moduli case. The geometric theorem uses the special coordinate sets S_k=[p_k+1], where p_k is the k-th prime. Do not silently generalize the parallel-hyperplane conclusion to arbitrary finite coordinate sizes.

Primary references:
- https://arxiv.org/abs/1901.11465
- https://par.nsf.gov/servlets/purl/10300177
- https://ora.ox.ac.uk/objects/uuid:3c55267c-60be-4652-89a7-db3db5f62c25/files/rdv13zt50s

The public Erdős Problems library page for this paper reports formalized fiber-sieve and moment lemmas, including explicit handling of zero-mass fibers and exact rational certificates: https://erdosproblems.ai/wiki/library/covering_systems/balister_2021_erdos_selfridge_problem_square_free_moduli. This is a valuable independent comparison point. It is not evidence that our current branch proves the same theorem; compare exact declarations, source commit, assumptions, and dependencies before reusing any result.

## 2. Prime-power coordinate model

Let D be a finite set of distinct odd moduli greater than 1 and Q=lcm(D)=product_i p_i^(gamma_i). By CRT,

  Z/QZ ≅ product_i Z/p_i^(gamma_i)Z.

For each d|Q, define its level vector L(d)=(v_{p_i}(d))_i. The progression a mod d corresponds in coordinate i to a coset of p_i^(L(d)_i) Z/p_i^(gamma_i) Z. Since the moduli are distinct, the map d ↦ L(d) is injective.

This is the right candidate abstraction for non-square-free moduli. It preserves the arithmetic information that the square-free hyperplane abstraction discards. However, the image is a restricted family of product boxes: arbitrary boxes in the product need not correspond to a single arithmetic progression. Prove both directions of the exact correspondence that is actually true; never assert surjectivity onto all boxes.

## 3. New formalization architecture

Separate the development into four interfaces:

### Layer A — arithmetic/CRT interface
- ModulusData: finite prime support, exponents gamma_i, and positive Q.
- LevelVector d: exponent vector with d | Q.
- Prove d = product p_i^(L(d)_i) and injectivity of d ↦ L(d).
- Prove the progression-to-box membership equivalence using CRT.
- Explicitly handle primes absent from Q and coordinates with exponent zero.

### Layer B — box geometry
- Define each coordinate coset as {x : p^ell divides x - a} in ZMod (p^gamma).
- Prove its relative size/measure exactly, including ell=0 and ell=gamma.
- Define intersection and fiber operations on the restricted box family.
- State precisely which fibers remain in the restricted family; do not assume closure without proof.

### Layer C — source-specific moments
- Reproduce the first- and second-moment inequalities from the published proof with exact rational weights.
- Treat zero mass as a separate branch, not as division by zero or a totalized rational quotient.
- Formalize the codimension-one removal only with the source's exact hypotheses.
- Keep all sieve parameters and stages indexed by the same finite prime set; invalid states should be unrepresentable.
- Keep the sieve_criterion / sf_sieve_lt_one assumptions out of the accepted theorem until their proofs are supplied.

### Layer D — certificate checker
- Store schedules and numerical certificates as data, not as trusted conclusions.
- Recompute all rational recurrences exactly; for interval bounds, use directed/outward rounding and independently check the enclosure.
- Make the Lean theorem prove that the certificate satisfies every inequality and admissibility condition.
- Treat a finite fixed-lcm search as a counterexample search only; it cannot prove the infinite conjecture.

## 4. Recent preprint lead: threshold 73 to 37

Ege Öztürk's August 2026 preprint claims to reduce the square-freeness threshold 73 to 37 by using a level-vector form of BBMST's Theorem 3.2 and a prime-power analogue of codimension-one removal. The stated scope is restricted: each prime p≤37 must occur with exponent at most one in every modulus; larger primes may occur to higher powers. It explicitly does not solve unrestricted Erdős–Selfridge and does not establish threshold 31.

Source: https://www.researchgate.net/publication/413532039_Reducing_the_constant_73_in_the_Erdos-Selfridge_problem_with_square-free_moduli

Acceptance gate before treating this as a theorem:
1. Obtain the exact manuscript version, complete schedule/certificate data, and verifier scripts.
2. Reproduce the prime-by-prime constants with exact rational arithmetic.
3. Independently derive the claimed multiplicity function and each moment inequality.
4. Verify the p-1 to p-2 loss change for all boundary cases, especially pure prime powers and zero-mass fibers.
5. Recompute the hand-off margin without trusting binary floating-point output.
6. Only then formalize the restricted result, with the theorem statement explicitly encoding the p≤37 square-freeness condition.

## 5. Audit of current project status

The existing BBMSTMassAuditCore and BBMSTFiberAuditCore are generic finite-sum infrastructure. They are useful and should remain division-free, but they are not the BBMST incidence theorem. The current PR's finite-fiber partition correction is a bookkeeping repair, not a source-specific geometric bound.

The latest observed CI run for the branch was still in progress at the time of this note; it must be checked again against the latest PR head SHA before claiming success. An older successful run does not validate later commits.

## 6. Concrete next milestones

1. Add PrimePowerLevelVector.lean containing only CRT/level-vector definitions and injectivity lemmas.
2. Add a finite test that enumerates small odd moduli, constructs the exact level vectors, and checks progression/box membership equivalence over every residue class modulo Q.
3. Prove a small exact first-moment lemma over rational weights before importing any sieve schedule.
4. Compare the result with the published Erdős Problems library's fiber-sieve lemmas, declaration by declaration, while retaining our independent axiom audit.
5. Only after the restricted local lemmas are proved, connect them to the 37-threshold certificate. Do not change the final theorem's scope.

## Integrity protocol

The theorem is accepted only if (i) exact source statement alignment is reviewed, (ii) all transitive assumptions are printed, (iii) no sorry/sorryAx remains, (iv) all arithmetic certificates are independently recomputed, and (v) current Lean exports are rechecked by current independent checkers/comparator when available. The 2026 soundness incidents show that #print axioms and a green build alone are not sufficient evidence against adversarial kernel/runtime behavior.
