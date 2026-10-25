# External-method audit: blockwise Bonferroni is a candidate, not a plug-in theorem

Date: 2026-10-25

## Verified research signal

The public OpenAI mathematics repository currently describes 719 manuscripts grouped into 372 result families and says only about 42% of top-line results have Lean formalizations. It explicitly warns that unformalized results may contain issues. Therefore manuscript existence is a source for candidate techniques, not proof certification. See https://github.com/openai/math.

One potentially relevant technique appears in the repository's primitive-root manuscript, in its block-sieve section: divide local bad conditions into blocks; approximate the block-avoidance indicator by truncated inclusion-exclusion polynomials; bound the remainder by the next unsigned Bonferroni layer; telescope products of nonnegative block factors; then evaluate main terms under an auxiliary independent Bernoulli model and keep the arithmetic error as a separate sum.

## Potential connection to BBMST

This suggests a possible architecture for the BBMST audit only if its original hypotheses provide:

1. a finite or truncatable family of bad events indexed by local blocks;
2. a valid lower/upper Bonferroni sandwich for each block;
3. a uniform bound on block-local total mass or an equivalent factorial-tail estimate;
4. a multiplicative or controlled main-term evaluation for the truncated monomials;
5. an explicit arithmetic/discrepancy error bound.

These assumptions have not been established for our source-faithful product-box hyperplane model. The block-sieve lemma therefore cannot currently be transplanted into the BBMST proof, and it does not establish the needed bound on N_{O,U}. The proper next task is to compare each of these five requirements with the exact published BBMST hypotheses and either prove it or record the missing hypothesis.

## Formalization plan

Formalize the purely finite combinatorial Bonferroni sandwich independently of the BBMST theorem, then prove the block-product telescoping inequality. Keep probabilistic independence and arithmetic error estimates as separate interfaces. Only connect the result to BBMST after source fidelity is demonstrated. No `sieve_criterion` or `sf_sieve_lt_one` may be assumed.

## Integrity status

This note is a method-transfer hypothesis based on a public manuscript. It is not a new BBMST theorem, not a proof of a compatible-pair estimate, and not evidence that the external manuscript itself has been fully peer reviewed.
