# BBMST incidence-to-moment bridge: finite exact obligation

Date: 2026-10-27

Status: research specification and elementary algebraic identity; not Lean-compiled. This is neither a proof of the published BBMST theorem nor a solution of the unrestricted odd-distinct-moduli problem.

## 1. Repeated audit bottleneck

The recurrent gap is not the syntax of the finite combinatorial layer. It is the passage from the source-defined product probability space and hyperplane incidences to the *quantitative* moment inequality used in the sieve conclusion. A hypothesis named `sieve_criterion`, `sf_sieve_lt_one`, or “moment bound” is not a proof if it simply assumes the conclusion.

## 2. A minimal exact finite probability interface

Let I be a finite index type, weights w_i be nonnegative rationals with sum_i w_i=1, and alpha_i be rational values. Define
\[
m=\sum_{i\in I}w_i\alpha_i,\qquad
s=\sum_{i\in I}w_i\alpha_i^2.
\]
Then expansion and normalization give the exact identity
\[
\sum_i w_i(\alpha_i-m)^2=s-m^2.
\]
Since each term on the left is nonnegative, s-m^2>=0.

This identity is a sound first Lean target because it is fully finite and exact. It is not the missing BBMST estimate: the theorem needs source-specific bounds on m and s derived from the actual incidence geometry. Variance nonnegativity alone cannot force the required strict sieve inequality.

## 3. The crucial provenance rule

Do not let weights, alpha-values, and a claimed moment estimate arrive as unrelated caller-supplied data. Construct them from one shared object:
1. the source-defined finite coordinate sets and product sample space;
2. the actual hyperplane equations and their admissibility/nontriviality conditions;
3. incidence indicators and the induced stage distribution;
4. normalization and nonnegativity proved from those definitions;
5. alpha_k and its first and second moments;
6. the source-matched quantitative inequalities, with all denominator positivity and endpoint conditions explicit.

Each estimate should carry a provenance record:
\[
(\text{claim},\text{source lemma/equation},\text{constructed data},
\text{side conditions},\text{Lean theorem},\text{transitive axioms}).
\]
A record remains open until every field is discharged. This prevents a formally valid theorem about arbitrary weights from being misrepresented as the geometric theorem.

## 4. The next falsifiable milestone

Build the smallest nontrivial finite example from the paper's actual definitions. Prove:
- the sample-space cardinality and probability normalization;
- the hyperplane incidence count by finite enumeration or a symbolic counting lemma;
- the induced mass identity;
- the finite variance identity above;
- the exact connection between those quantities and the paper's stated stage parameter.

Then compare each equation and hypothesis with the original source before scaling to general parameters. If the small case exposes a mismatch in conventions, fix the definition rather than adding a hypothesis to force the target.

## 5. Scope control

Keep separate (a) the published theorem under its stated square-free-moduli hypotheses and (b) the broader question about arbitrary odd distinct moduli. A proof of one must not be silently promoted to the other. Likewise, a kernel-checked Lean theorem only validates the formal statement actually encoded; it does not certify source fidelity by itself.

## 6. Acceptance status

This note records a precise, testable next step. It does not claim a successful Lean compilation, an empty axiom list, a completed source audit, or a solution to either number-theoretic problem.
