# Source-faithful BBMST route: separate the square-free theorem from the open odd-covering problem

Date: 2026-10-25
Status: source audit / formalization roadmap; no new Lean theorem claimed.

## Critical scope distinction

The paper by Balister, Bollobás, Morris, Sahasrabudhe and Tiba, *The Erdős–Selfridge problem with square-free moduli*, Algebra & Number Theory 15 (2021), 609–626, proves that a distinct covering system whose moduli are all square-free must contain an even modulus. This is a theorem for the square-free case, not a resolution of the unrestricted Erdős–Selfridge question whether a distinct covering system with all moduli odd exists.

The unrestricted odd-covering problem remains open. Other published consequences include that any odd covering must contain a modulus divisible by 2 or 3 (so the all-odd case is forced into the 3-divisible branch), and if an odd covering exists then its least common multiple must be divisible by 9 or 15. Do not label these partial obstructions a full solution.

## Published proof chain to preserve

The square-free paper's relevant structure is not merely a generic second-moment calculation. The proof chain is:

1. Lemma 2.1: fiberwise distortion/sieve measure, including preservation of earlier measurable sets, a distortion bound, and the covered-set inequality.
2. Theorem 3.1: each newly removed mass is controlled by first and second moments of the fiber density alpha_k.
3. Lemma 3.3: propagation of the initial hyperplane weights through later sieve coordinates.
4. Lemma 3.4: positive-integer moment bounds by compatible hyperplane intersections.
5. Theorem 3.2: count unions of fixed-coordinate sets and improve the bound when the new singleton coordinate is absent.
6. Lemmas 5.4 and 5.3: finite configuration and rational-parameter certificates.
7. Corollary 5.2: exact integer recurrence and finite prime sieve to close the threshold.
8. Theorem 1.1: translate the geometric obstruction back to square-free arithmetic progressions through the Chinese remainder correspondence.

The published article matters: the 2019 preprint differs at several proof-critical points. The published version explicitly excludes trivial hyperplanes/modulus one, corrects the inequality in Theorem 3.1, corrects a sign in Lemma 5.3, states a limit rather than a liminf in Proposition 4.1, and adjusts a coordinate-size hypothesis in Theorem 3.2. A formalization must follow the published version and record these differences.

## How the current product-box audit fits

`BBMSTProductBox.lean` formalizes an exact compatible-pair intersection identity and an exact stratification of ordered-pair mass by overlap/union support. These are useful ingredients for Lemma 3.4, but they do not replace the distortion measure or the source-specific alpha_k estimates. The current generic fixed-rank bound is only a baseline and should not be presented as the BBMST quantitative conclusion.

The next formalization task is to map the source proof into explicit Lean interfaces, in order:

- finite coordinate spaces and nontrivial hyperplanes, with a source-faithful nonparallel condition;
- fibers, `alpha_k`, and zero-mass-fiber conventions;
- the distorted measures and the three inequalities of Lemma 2.1;
- the first/second moment bound of Theorem 3.1;
- compatible intersection/union counting for Lemmas 3.3–3.4 and Theorem 3.2;
- exact rational/integer certificates for Lemmas 5.3–5.4 and Corollary 5.2;
- Chinese-remainder equivalence and the final square-free theorem.

Each interface must carry its actual hypotheses. Do not introduce free assumptions named `sieve_criterion`, `sf_sieve_lt_one`, `noCodimOne`, `isNontrivial`, `isParallel`, or `codimOne` that simply assert the desired content. Definitions may be abstracted only when the theorem proving their source-specific properties is also included.

## Independent evidence and boundary

The public Erdős Problems library page describes a full published-proof reconstruction and exact finite certificate checks for the square-free theorem, including 9,283 primal certificates for one exhaustive configuration tree, a 16-rational-parameter certificate, and exact integer checks for the large-prime recurrence. It explicitly does not claim Lean verification, and it distinguishes the square-free result from the unrestricted odd-covering question. This is a useful independent audit target, not a substitute for our own kernel-checked proof.

Primary source: Balister et al., *The Erdős–Selfridge problem with square-free moduli*, DOI 10.2140/ant.2021.15.609, arXiv:1901.11465. Related primary source: Balister et al., *On the Erdős covering problem: the density of the uncovered set*, arXiv:1811.03547.

## Audit conclusion

The most promising near-term result is to obtain a complete Lean proof of the already-published square-free obstruction with source-fidelity checks and exact certificate replay. That is a meaningful theorem, but it must be reported as the square-free case. It does not settle the general odd-covering problem. The generic overlap polynomial remains a reusable auxiliary identity; the proof bottleneck is the published distortion/alpha_k chain and the finite quantitative certificates.
