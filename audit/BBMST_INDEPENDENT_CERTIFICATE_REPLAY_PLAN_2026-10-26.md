# BBMST public certificate: independent replay plan — 2026-10-26

## Status boundary
The pinned checker source and the reconstruction's source card were directly inspected in this work session. The checker itself was not executed, the compressed payload was not replayed, and no independent PASS is claimed. The public reconstruction documents a full mathematical proof chain and the reduction to the 480-point model; our remaining task is to independently audit and reproduce that chain, not to imply that the source contains no reduction at all.

## Newly verified upstream source facts
At pinned upstream commit 05a6a79d5c64985d0e8a73697fd63a2731d6acc4:
- The checker path is `library/covering_systems/balister_2021_erdos_selfridge_problem_square_free_moduli/evidence/verify_bbmst_squarefree.py`.
- The canonical point space is `Q=(2,4,6,10)`, hence 480 points, with masks `(3,5,6,7,9,10,11,12,13,14,15)`.
- The certificate contains 9,283 primal weight vectors for the exhaustive pruned configuration tree. The checker regenerates that tree and checks each supplied certificate against the generated configuration.
- The checker uses Python 3.10+ standard-library arithmetic, exact `Fraction` values and integer cross-multiplication. It does not invoke or trust an LP optimizer at verification time.
- The checker has three components: finite measure certificates (Lemma 5.4), sixteen rational distortion parameters with two endpoint checks (Lemma 5.3), and a large-prime recurrence plus a finite prime sieve and rational logarithm lower bounds (Corollary 5.2).
- Its documented command is `uv run --no-sync python library/covering_systems/balister_2021_erdos_selfridge_problem_square_free_moduli/evidence/verify_bbmst_squarefree.py`; expected runtime is about thirty seconds.
- The checker describes itself as an ordinary computational certificate, not a Lean build. The reconstruction's source card identifies the published paper as Balister–Bollobás–Morris–Sahasrabudhe–Tiba, *Algebra & Number Theory* 15 (2021), 609–626, DOI 10.2140/ant.2021.15.609.

The source card also explicitly distinguishes the published 2021 article from the 2019 preprint and lists material version differences: the restriction excluding trivial hyperplanes/modulus one, the size hypothesis in Theorem 3.2, the corrected union-bound inequality and Lemma 5.3 sign, and Proposition 4.1's limit versus limit inferior. These are important statement-fidelity checkpoints for any independent formalization.

## Exact finite obligation
For each generated partial configuration, integer weights w_r≥0 are assigned to uncovered points, W=Σw_r>0, M_I is the hyperplane maximum, and U is the residual sum over unassigned fixed sets. The checker requires W>U and verifies by integer cross-multiplication:

    10^6 (Σ_I (4·3^|I|−3) M_I − U) < 9018071·4(W−U).

The rational statement behind this is

    (Σ_I (4·3^|I|−3)M_I−U)/(4(W−U)) < 9018071/10^6.

Since W>U, the denominator 4(W−U) is strictly positive. Multiplication by this positive denominator and by 10^6 preserves the strict inequality and gives exactly the integer check above. Conversely, the integer inequality implies the rational inequality by division by the same positive quantity. This bridge is elementary but should be a separate theorem in Lean, with denominator positivity explicit; it must not be folded into untrusted certificate parsing.

All quantities in the final check are integers, so no floating-point comparison is required. The tree and complete leaf coverage must be regenerated, not trusted from the payload alone.

## Direct source-code audit: what the checker does and does not trust
The inspected source constructs the 480 points directly with a Cartesian product, regenerates every hyperplane partition from the coordinate projection, regenerates the pruned configuration tree, reconstructs the active points and their capped-coordinate representatives, and recomputes each maximum, omitted mass, numerator, denominator and strict bound. It checks that all full-depth configurations receive certificates and that every supplied key lies in the regenerated tree. The parameter and tail components likewise use exact rational/integer recurrences and do not use floating-point logs.

Two hardening opportunities for a separately maintained verifier remain:
1. Python's standard `json.loads` accepts duplicate object keys by keeping the last value, and the current checker does not explicitly reject unknown top-level fields. These behaviors do not by themselves falsify the arithmetic theorem, because the selected values are still rechecked, but strict parsing would make malformed-certificate handling clearer and mutation tests stronger.
2. The checker reports the SHA-256 of the certificate and script, but the inspected code does not compare those hashes against pinned expected constants internally. Reproducibility should therefore pin the source commit and record the raw hashes in an external manifest. Hash pinning is provenance protection, not a substitute for recomputing the theorem's arithmetic.

The independent verifier should not copy the upstream helper functions or simply call the upstream checker. It should use a separately written point/configuration representation and compare a deterministic leaf trace with the upstream output. Since both implementations may still share the mathematical model, this only independently checks implementation and arithmetic; the source-to-model reduction remains a separate proof obligation.

## Additional exact lemma: monotonicity of the completion bound
The source's pruning argument uses f(p)=(C−p/4)/(1−p), for 0≤p≤u<1 and C≥1/4. The required monotonicity has an exact algebraic certificate:

    f(u)−f(p) = (u−p)(C−1/4)/((1−u)(1−p)) ≥ 0.

Both denominator factors are positive; u−p≥0 and C−1/4≥0. Thus f(p)≤f(u), without relying on numerical differentiation or a floating-point argument. This is a good small Lean lemma to prove before formalizing the finite checker. The assumptions matter: if C≥1/4 or p≤u are omitted, monotonicity is not automatic.

The source normalization wording must be read carefully: after deleting mass p, the unnormalized surviving measure has total mass 1−p, so its empty-fixed-set contribution decreases by p/4; normalization then divides the entire expression by 1−p. The resulting expression is (C−p/4)/(1−p). This is consistent with the displayed formula and should be encoded explicitly in the formal proof, rather than summarized as if the normalized total mass itself were 1−p.

## Three verification layers
The replay must distinguish:
- **Payload integrity:** exact bytes and expected version/digest.
- **Finite arithmetic truth:** every generated configuration and strict inequality is verified.
- **Mathematical reduction:** the finite model is a valid realization of the published probabilistic/geometric theorem, including every normalization and zero-mass case.

Passing layer 1 does not imply layer 2; passing layers 1–2 does not imply layer 3.

## Independent trace schema
The second checker must not import upstream Python, tree generation, or incidence helpers. It should define its own canonical objects:
- A point is an integer tuple in Q₅ = [2]×[4]×[6]×[10], encoded as four bounded coordinates.
- A hyperplane/configuration key is a sorted tuple of coordinate choices with a fixed, documented ordering.
- A leaf is a canonical tuple of (configuration key, assigned point IDs, integer weights, residual data), with all integers encoded as integers, never floats.
- For every leaf, independently recompute incidence from the defining relation, not from a supplied incidence list; recompute M_I by a maximum over the relevant finite set; recompute W and U by integer summation; compute signed slack
  S = 9018071·4(W−U) − 10^6(Σ_I(4·3^|I|−3)M_I−U).
  Acceptance requires W>U and S>0 for every leaf.

The independent checker should emit a deterministic record for every leaf: canonical key, counts of points/configurations, W, U, each M_I, S, and a digest of the canonical record. Compare these records leaf-by-leaf with a separately exported upstream trace. Comparing only the largest bound is inadequate because a missing leaf can make the maximum look better.

### Strict trace schema and determinism
- Each integer is represented as a JSON integer; reject booleans, floats, decimal strings, and implicit coercions.
- Each finite set is serialized in sorted canonical order; duplicates are errors, not silently deduplicated.
- Every leaf has an explicit unique identifier derived from its canonical configuration, not its traversal position.
- Every computed field is recomputed by the verifier. Supplied W, U, maxima, slack, counts, and hashes are comparison fields only.
- Reject unknown keys and missing required keys. Version the schema and include the source commit and raw compressed-file SHA-256 in the run manifest.
- Hash canonical records after deterministic UTF-8 serialization with a specified key order. Record both raw payload hash and canonical semantic-trace hash.
- A successful run reports expected leaves, actual unique leaves, missing IDs, duplicate IDs, first mismatching record, and minimum positive slack. A zero or negative minimum slack is failure.

## Mutation and completeness tests
The checker must reject:
1. one removed leaf;
2. a duplicated leaf;
3. a changed coordinate or incidence bit;
4. a negative weight;
5. a zero or negative W−U;
6. a one-unit perturbation of a weight that flips S≤0;
7. a float replacing an integer;
8. an unknown JSON key or silently defaulted field;
9. a changed certificate byte that invalidates the pinned digest.

Each fixture should have a known expected failure stage. The tests do not prove correctness of the checker, but expose common implementation errors.

## Independent verification ladder
1. Run the upstream checker in a pinned clean environment with all components. Record repository commit, runtime versions, exact command, exit code, full output, and hashes of the compressed certificate and script.
2. Repeat each component separately (measures, parameters, tail) and archive the outputs.
3. Build the independent checker; regenerate Q₅, incidence, all M_I, W, U and exact slack. Compare leaf-by-leaf tuples, not just the maximum.
4. Canonicalize the certificate, publish hashes and a one-command reproduction script, and include corrupted fixtures.
5. Formalize the finite verifier in Lean 4 with explicit finite types; prove the integer inequality implies the corresponding rational strict inequality. Prove the monotonicity identity separately.
6. Independently audit the published source-to-model reduction: the original [3]×[5]×[7]×[11] distribution, the reduction to Q₅, nonparallel hyperplane conditions, zero-mass fibers, and the normalization recurrence. Compare every declaration to the published 2021 article, not just the 2019 preprint or a secondary summary.

## Critical distinction
The public reconstruction does provide a documented complete proof chain, including Lemma 5.4's finite certificate, Lemma 5.3's rational parameters, Corollary 5.2's large-prime recurrence, and the geometric/Chinese-remainder equivalence. Our task is to independently reproduce and source-audit that chain and to add a separate formal proof if desired. The checker pass, if reproduced, establishes the finite arithmetic claim within its checker assumptions; it does not alone establish the whole theorem in the paper.

## Sources
- Original preprint: https://arxiv.org/abs/1901.11465
- Published article: https://doi.org/10.2140/ant.2021.15.609
- Public reconstruction pinned commit: https://github.com/plasma-ai/erdos/tree/05a6a79d5c64985d0e8a73697fd63a2731d6acc4
- Checker: https://github.com/plasma-ai/erdos/blob/05a6a79d5c64985d0e8a73697fd63a2731d6acc4/library/covering_systems/balister_2021_erdos_selfridge_problem_square_free_moduli/evidence/verify_bbmst_squarefree.py
- Hales on Lean reliability and statement fidelity: https://terrytao.wordpress.com/2026/10/09/what-mathematicians-should-know-about-the-lean-theorem-proverquestions-of-reliability-and-ai/

## Acceptance criteria
- [ ] Upstream checker passes on pinned commit and output is archived.
- [ ] Independent checker agrees leaf-by-leaf.
- [ ] Certificate and checker hashes are published; corruption test fails.
- [ ] Lean proves arithmetic and finite-model result without new axioms.
- [ ] Published source-to-model reduction is independently audited line by line or formalized.
- [ ] The paper statement and exact formal theorem are independently compared and the comparison is published.


## Finite diagnostic test run on 2026-10-26 (not a certificate replay)
I independently checked the algebraic monotonicity identity over 30,780 rational-grid cases satisfying 0≤p≤u<1 and C≥1/4. For each case, exact `Fraction` arithmetic verified both
`f(u)-f(p) = (u-p)(C-1/4)/((1-u)(1-p))`
and `f(p)≤f(u)`. All 30,780 tests passed. This is a regression check of the algebraic formula, not a proof of Lemma 5.4 and not an execution of the public BBMST certificate checker.
