# BBMST source-fidelity gate: theorem scope and geometric hypotheses (2026-10-27)

Status: source-based audit note; not Lean-compiled. Reference: Balister–Bollobás–Morris–Sahasrabudhe–Tiba, The Erdős–Selfridge problem with square-free moduli, Algebra & Number Theory 15 (2021), 609–626, DOI 10.2140/ant.2021.15.609; arXiv:1901.11465.

## 1. Scope lock

The published result proves that a covering system with distinct square-free moduli must contain an even modulus. It does not settle the unrestricted question whether a covering system with distinct moduli can have all moduli odd. These statements must not be conflated in the Lean theorem name, assumptions, or conclusion.

## 2. Theorem 3.1's objects are mathematical data

The proof uses a finite product space \(Q=S_1\times\cdots\times S_n\), a family of hyperplanes, distributions supported on restricted coordinate sets, and recursively defined distributions \(P_k\) and functions \(\alpha_k:Q_{k-1}\to[0,1]\). The moments
\[
M_k^{(1)}=\mathbb E_{k-1}[\alpha_k],\qquad
M_k^{(2)}=\mathbb E_{k-1}[\alpha_k^2]
\]
are defined relative to the actual preceding-stage distribution \(P_{k-1}\), not as arbitrary input numbers.

The formalization must therefore construct the sample space, hyperplane incidence, conditional distributions and \(\alpha_k\) from the same data. If these are replaced by unrelated variables plus a free proposition asserting the desired criterion, the source proof has not been formalized.

## 3. Edge cases to encode, not silently exclude

The published theorem's geometric statements explicitly exclude trivial hyperplanes and modulus one. The formal interface should represent and prove the relevant properties, rather than accept arbitrary Boolean tags. Parameter domains such as \(\delta_k\in[0,1/2]\), nonempty index ranges, and compatibility between a parameter and the coordinate it indexes must be explicit at the point of use.

The division-free threshold equivalence is only a downstream algebraic lemma. It does not establish any of these geometric hypotheses.

## 4. Computation is supporting evidence, not a replacement proof

The authors' supplemental materials include linear-programming and C-code checks for finite parameter/configuration bounds. These are useful audit targets: the formal development can reproduce finite outputs with exact rational arithmetic and check each claimed bound. But a Lean proof of a finite table is not automatically a proof of the analytic estimates or the theorem's infinite parameter argument. The proof graph should mark computationally certified finite lemmas separately from the general mathematical implications.

## 5. Acceptance gate

Before accepting a final theorem, check:
- its statement matches the square-free-moduli result and states all assumptions;
- each hyperplane is nontrivial and has the source's geometric meaning;
- distributions are normalized and the \(\alpha_k\) and moments are derived, not supplied as unconstrained witnesses;
- all divisions have proved-positive denominators;
- empty families and missing parameters cannot satisfy the theorem vacuously;
- no free sieve_criterion axiom occurs transitively;
- the theorem has been kernel-checked and its transitive axiom list reviewed.

A passing gate would be a real formalization milestone, but only after the source's moment estimates and final implication are proved.
