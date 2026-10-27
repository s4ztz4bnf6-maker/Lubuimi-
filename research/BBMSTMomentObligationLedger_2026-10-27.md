# BBMST next-step ledger: turn the moment gap into a source-derived obligation (2026-10-27)

Status: research specification; not Lean-compiled. This is a proof-plan refinement, not a proof of the BBMST theorem or the unrestricted Erdős–Selfridge problem.

## 1. Repeated bottleneck from the audits

The finite combinatorial layer is not the present mathematical obstruction. Exact finite partition identities and typed nonempty parameter interfaces can be proved independently. The recurring gap is the bridge from the actual hyperplane/product-space geometry to the quantitative moment inequality needed for the sieve criterion. A free proposition such as sieve_criterion or sf_sieve_lt_one hides that entire bridge and cannot count as a completed formalization.

## 2. Separate the proof into three interfaces

### A. Incidence and probability interface

Define the finite product sample space and its probability measure from the coordinate sets. Define each hyperplane from the source's coordinate equation, with its nontriviality conditions. Derive the relevant stage distributions and the functions alpha_k from the incidence data. Normalization and nonnegativity must be theorems, not Boolean fields supplied by a caller.

### B. Moment interface

For each stage, define
\[
m_k=\mathbb E_{P_{k-1}}[\alpha_k],\qquad
s_k=\mathbb E_{P_{k-1}}[\alpha_k^2].
\]
Then formalize the exact identity
\[
s_k-m_k^2=\mathbb E_{P_{k-1}}[(\alpha_k-m_k)^2]\ge 0
\]
under the source's probability and measurability assumptions. This identity alone is not enough: the proof needs the source-specific quantitative lower/upper bounds on the moments that force the final strict inequality.

### C. Sieve conclusion interface

Only after A and B are proved from the same underlying geometric data should the finite-stage estimates be composed into the precise BBMST conclusion. Keep every denominator positivity condition explicit. Handle endpoints and degenerate configurations at the definition boundary, not by silently assuming the desired conclusion.

## 3. New audit device: a proof-obligation ledger

Track each claimed inequality as a record
\[
(\text{statement},\text{source equation/lemma},\text{data dependencies},
\text{side conditions},\text{Lean theorem},\text{axiom closure}).
\]
A row is accepted only if the source statement is matched, all inputs are constructed from the same parameter and incidence data, side conditions are proved, and the resulting theorem has a transitive axiom audit. This ledger is designed to expose “free theorem-shaped inputs” before they can masquerade as progress.

## 4. Finite computation: use it where it actually applies

The source's finite parameter/configuration checks can be represented as exact rational or integer computations and verified separately. They may certify finite cases or table bounds; they do not, by themselves, imply the geometric moment inequality for all admissible parameters. Every computational claim needs its input range, exact output, and proof that the finite range covers the claimed cases.

## 5. Next falsifiable Lean milestone

Do not attempt to replace sieve_criterion immediately with another name for the same assumption. First define one actual finite product space and one actual nontrivial hyperplane, derive the associated incidence indicator and normalized mass, and prove the elementary incidence-to-mass identity with no sieve axiom. Then extend to the stage distribution and moment definitions. The next milestone is accepted only if the theorem's type contains the constructed data, not a free hypothesis asserting the desired moment bound.

## 6. Scope and acceptance

The BBMST square-free-moduli theorem must remain distinct from the unrestricted odd-distinct-moduli question. Passing a Lean build and an axiom scan validates the formal object only after statement fidelity is checked against the published theorem. This note itself is not Lean-compiled and claims no completed axiom elimination.
