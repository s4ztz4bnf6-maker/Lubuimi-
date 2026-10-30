# Ramsey-method audit and transfer to the Odd Distinct Covering project
**Date:** 2026-10-30  
**Purpose:** Audit the supplied diagonal-Ramsey note and record only mathematically defensible transfer ideas. This is a research note, not a proof of the Odd Distinct Covering-System Conjecture.

## 1. Corrected mathematical audit

### Diagonal Ramsey theorem
For $R(k)=R(k,k)$, the Erdős–Szekeres recurrence yields
$$R(k)\leq {2k-2\choose k-1}.$$
Stirling's formula gives
$$
{2k-2\choose k-1}\sim \frac{4^{k-1}}{\sqrt{\pi(k-1)}}
=\frac{4^k}{4\sqrt{\pi k}}(1+o(1)).
$$
Therefore the asymptotic expression $4^k/\sqrt{\pi k}$ in the supplied note is too large by a factor asymptotic to 4. The exact binomial upper bound itself is correct.

Campos–Griffiths–Morris–Sahasrabudhe prove that some fixed $\varepsilon>0$ satisfies
$$R(k)\leq (4-\varepsilon)^k$$
for all sufficiently large $k$. This is a peer-reviewed Annals of Mathematics result (volume 203, issue 3, 2026; accepted 2025). The supplied description “density increment and saturation components” is not substantiated by the primary source material inspected. A 2026 ICM exposition describes the original proof as technically long and calculation-heavy, and outlines a later, shorter proof using a reservoir, monochromatic cliques, colour-books, and a geometric lemma. Do not attribute a specific “saturation components” mechanism without a precise citation and definition.

### Small diagonal values
- $R(3,3)=6$: exact.
- $R(4,4)=18$: exact.
- $43\leq R(5,5)\leq46$: current published interval. The 2026 Journal of Graph Theory upper-bound proof uses linear programming and extensive computer case checking, independently implemented by both authors. The supplied “C++ certificates & SAT reduction (2024)” description is not an accurate account of that paper's stated method.
- $102\leq R(6,6)\leq160$: the upper bound is 160, not 161. The dynamic small-Ramsey survey attributes this computational bound to Angeltveit–McKay (2020-era result/personal communication); the lower bound is Kalbfleisch's construction.

### Complexity and SAT direction
For fixed $k$ and a given $N$, encode a red/blue colouring of $K_N$ with Boolean variables $x_{ij}$. For each $k$-vertex set, add clauses forbidding all its edges from being red and forbidding all its edges from being blue. Then:
- SAT gives an explicit colouring with no monochromatic $K_k$, hence $R(k,k)>N$ (a lower-bound witness).
- UNSAT proves every colouring contains a monochromatic $K_k$, hence $R(k,k)\leq N$ (an upper-bound certificate, if the UNSAT proof is independently checked).

This does **not** justify the blanket statement that “verification of the upper bound for fixed $k$ is NP-hard.” With $k$ fixed, $R(k,k)$ is a fixed integer and the language over $N$ is just a threshold language; the ordinary decision problem is trivial in the formal complexity-theoretic sense, despite the enormous practical constant. Related graph-arrowing problems with an arbitrary host graph and fixed target graphs can be NP-complete, but that is a different input problem. A 2026 Ramsey survey explicitly notes that the appropriate complexity class for computing classical complete-graph Ramsey numbers is not clear. ETH consequences therefore do not follow from the supplied paragraph; they require a precise reduction and input/parameter specification.

## 2. What transfers to odd distinct covering systems

### Transferable, with conditions
1. **Finite obstruction search plus independently checkable certificates.** SAT/SMT/ILP can search finite bounded subproblems. A positive SAT model can exhibit a finite covering candidate or counterexample; an UNSAT certificate can close a finite search region. This becomes a theorem about all odd distinct covering systems only after a mathematically proved finite reduction bounds the relevant moduli/rank/valuation structure.
2. **Exact arithmetic and independently replayed computation.** The Ramsey $R(5,5)$ work's useful methodological lesson is that computational case analysis should be independently implemented and tied to explicit mathematical reductions. For our project, use rational/integer certificates and a small checker; then formalize the checker and the reduction in Lean.
3. **Structural state enrichment rather than a failed scalar potential.** The later Ramsey proof uses structured objects (reservoirs and books) and a geometric lemma, rather than relying only on a one-dimensional global count. The analogy suggests testing a richer state for residue-fibre allocation, but it supplies no covering-system inequality by itself.
4. **Density concentration as a diagnostic, not a theorem.** In our CRT setting, let $U$ be the residues missed by old classes and $C_j$ the projections of new classes. Complete coverage of all $q$-fibres above every $x\in U$ forces
$$q|U|\leq \sum_j |U\cap C_j|.$$
A useful next search is to partition $U$ into strata by the incidence multiplicity $m(x)=|\{j:x\in C_j\}|$, and ask whether a high-multiplicity stratum forces a stronger overlap cost. This is a candidate route only; no universal reverse inequality has been proved.

### Non-transferable without a new theorem
- The Ramsey density/book arguments are graph-specific. No direct substitution turns a red/blue edge-colouring argument into a congruence-cover argument.
- A SAT proof for finitely many moduli or bounded rank cannot settle arbitrary odd moduli unless a finite-reduction theorem is first proved.
- NP-hardness or ETH rhetoric is not a substitute for a covering-system reduction.

## 3. Five-source discipline

1. **Quanta (2026-08-03):** useful context for AI-assisted Erdős research and the importance of human review; it is not evidence for this covering conjecture.
2. **Tao/Hales (2026-10-09):** kernel checking and statement-fidelity audit are separate requirements. For our Lean work, record the exact theorem statement, inspect definitions, run kernel checking, and audit axioms/dependencies; never infer these from a green workflow badge alone.
3. **ProofAtlas Odd Distinct Covering-System page:** the visible route map is explicitly dated 2026-08-28 and itself says its route map is not proof evidence. It reports the full-prime depth-two minimax and arbitrary-rank continuation as open at that snapshot. Treat it as a dated research map, not a current exhaustive literature review or proof.
4. **MAA (2026-06-01):** discusses the planar unit-distance problem, not diagonal Ramsey numbers and not odd covering systems. Its relevance is methodological only.
5. **OpenAI (2026-10-06, updated 2026-10-15):** describes a release process with repository materials, Lean formalizations for many proofs, and disclosure protocols. It is a model for provenance/transparency, not mathematical evidence for our theorem.

## 4. Project decision
The Ramsey note does not close any open obligation in the covering-system proof. Retain only the finite-certificate methodology and the idea of enriching the CRT-fibre state. Keep the already formalized incidence inequality as a necessary condition, and prioritize finding a universal arithmetic/overlap bound or an explicit counterexample. No claim of Lean compilation, kernel verification, axiom audit, or conjecture resolution is made by this note.

## Primary references
- Campos et al., *An exponential improvement for diagonal Ramsey*, Annals of Mathematics 203 (2026), 869–932, DOI 10.4007/annals.2026.203.3.4; arXiv:2303.09521.
- Angeltveit–McKay, *R(5,5) ≤ 46*, Journal of Graph Theory (first published 2026-03-20), DOI 10.1002/jgt.70029.
- Radziszowski, *Small Ramsey Numbers*, dynamic survey (2024 revision cited for the $R(6,6)\leq160$ bound).
- Burr, *On the Computational Complexity of Ramsey-Type Problems*, for the distinction between arbitrary-host non-arrowing and complete-graph Ramsey-number computation.
- Balister et al., *Upper bounds for multicolour Ramsey numbers*, JAMS 39 (2026), 765–780, DOI 10.1090/jams/1069.
