# Global inclusion–exclusion audit for the one-prime CRT extension

Date: 2026-10-30

## Status and scope

This is a research note, not a proof of Erdős Problem 7. It adds an exact higher-moment formulation to the first-moment incidence inequality already present in `BBMSTCongruenceCRT.lean`. No Lean compilation or kernel verification is claimed for the new formulation below.

The five guiding sources are used with distinct roles:
1. Quanta Magazine (3 August 2026): AI-assisted Erdős research, literature-checking failures, and the need to distinguish discovery from validation.
2. Terence Tao's blog / Thomas Hales guest post (9 October 2026): formal proof reliability, theorem-statement fidelity, and human audit of definitions.
3. ProofAtlas: its Odd Distinct Covering-System Conjecture page explicitly marks the full conjecture as open and identifies the full-p depth-two minimax inequality over twenty mixed shallow depth types as an open bridge.
4. MAA Math Values (1 June 2026): an example of AI-assisted mathematical discovery followed by substantial human cleanup; it concerns the unit-distance problem, not Erdős Problem 7.
5. Wikipedia / OpenAI's public mathematics releases: broad orientation only; neither substitutes for a source-level proof audit. OpenAI's 6 October release describes manuscripts as research results and provides Lean formalizations for many, not all, results.

## 1. Exact finite inclusion–exclusion identity

Let M be a positive integer and let C_i be congruence classes modulo d_i, where each d_i divides M. Write A_i for the corresponding subsets of ZMod M. For any finite index set I and any subset U of ZMod M,

```
|U ∩ ⋃_{i∈I} A_i|
 = Σ_{∅≠S⊆I} (-1)^(|S|+1)
       |U ∩ ⋂_{i∈S} A_i|.
```

This identity is exact and does not require pairwise coprimality or distinct projected moduli. For a nonempty S, the intersection is empty unless the residue conditions are pairwise compatible modulo gcd(d_i,d_j). If compatible, its size in ZMod M is M / lcm_{i∈S}(d_i); after intersection with U, the exact term is the number of U-residues in that CRT class.

Thus the arithmetic data needed by a Lean formalization are:
- a finite indexed family (d_i,a_i), retaining indices even when projected divisors collide;
- a compatibility predicate equivalent to pairwise congruence modulo gcds;
- the generalized CRT intersection-cardinality theorem;
- a finite-set inclusion–exclusion theorem relative to U.

## 2. The current first-moment obstruction

In the one-prime split Mq, old classes have moduli d|M and new classes have moduli qd with d|M and gcd(M,q)=1. Let U be the residues modulo M missed by every old class. Let C_j be the base projection of new class j, and let
`m(x)=|{j : x∈C_j}|`.

If every q-fibre above every x∈U is covered, then each new class supplies only one q-coordinate, so necessarily
`m(x) ≥ q` for every x∈U. Summing gives the already formalized inequality
`q |U| ≤ Σ_j |U∩C_j|`.

This is exact. The unresolved step is an arithmetic upper bound that contradicts it uniformly for all admissible systems. The crude estimates `|U| ≥ M-Σ_old M/d_i` and `|U∩C_j| ≤ M/d_j` do not currently supply that bound.

## 3. New higher-moment consequence

The same pointwise condition `m(x)≥q` gives a second exact inequality:
```
|U| ≤ Σ_{S⊆N, |S|=q} |U ∩ ⋂_{j∈S} C_j|.
```
Indeed, for each x∈U the number of q-element subsets of new classes containing x is `binom(m(x),q)≥1`; summing over x gives the displayed inequality.

More generally, for every r≤q,
```
Σ_{S⊆N, |S|=r} |U ∩ ⋂_{j∈S} C_j|
  = Σ_{x∈U} binom(m(x),r)
  ≥ |U| binom(q,r).
```
This is a hierarchy of exact higher-moment lower bounds. Each intersection term is controlled by generalized CRT: it is zero when the projected congruences are incompatible, and otherwise it is at most M/lcm(d_j : j∈S). Unlike the first-moment bound, this exposes pairwise and higher-order incompatibility between projected classes.

Important limitation: these inequalities are necessary conditions, not yet a contradiction. A useful proof must upper-bound the weighted sum of compatible q-subsets (or an appropriate lower moment) using the pairwise-distinct actual odd moduli and the prime-power structure. Merely expanding inclusion–exclusion without such a uniform upper bound does not prove noncoverage.

## 4. Relationship to the open depth-two route

ProofAtlas currently describes the full odd-distinct covering conjecture as open and names a universal full-p H=2 minimax inequality over twenty mixed shallow depth types as the priority bridge. The current one-prime CRT module is a correct finite fibre/allocation interface, but it does not establish that minimax inequality and does not replace the prime-power tree analysis. These are complementary routes:
- CRT incidence moments retain exact arithmetic congruence compatibility;
- the depth-two minimax route controls local configurations uniformly across prime-power placements.

A future integration must show explicitly how the CRT moment bounds imply the relevant local capacity inequality, or else formalize the minimax inequality independently and use the CRT interface only as an interpretation layer. No such implication is currently established.

## 5. Literature and claim-status guardrail

The unrestricted question remains listed as open by the Erdős-problem database, and ProofAtlas also labels it open. Recent rank-bound papers claim increasingly strong necessary lower bounds on the number of prime divisors of the LCM of a hypothetical odd distinct cover. Such lower bounds do not settle nonexistence: “at least nine prime divisors” is compatible with the existence of a cover using nine or more primes. Any use of such a paper in this project must separately verify the exact theorem statement, source package, pinned dependencies, generated-source hashes, full Lean build, and transitive axiom output.

## Sources

- Quanta Magazine, “Why the Legendary Erdős Problems Are Falling to AI” (3 Aug 2026): https://www.quantamagazine.org/why-the-legendary-erdos-problems-are-falling-to-ai-20260803/
- Terence Tao, “What mathematicians should know about the Lean Theorem Prover: questions of reliability and AI” (9 Oct 2026): https://terrytao.wordpress.com/2026/10/09/what-mathematicians-should-know-about-the-lean-theorem-proverquestions-of-reliability-and-ai/
- ProofAtlas, “Odd Distinct Covering-System Conjecture”: https://www.proofatlas.ai/collaboration/odd-distinct-covering-system-conjecture/
- MAA Math Values, “AI solves an 80 year-old Erdős problem” (1 Jun 2026): https://maa.org/math-values/ai-solves-an-80-year-old-erdos-problem/
- Wikipedia, “Covering system”: https://en.wikipedia.org/wiki/Covering_system
- OpenAI, “Sharing AI progress in mathematics” (6 Oct 2026): https://openai.com/index/sharing-ai-progress-in-mathematics/
- Erdős Problem 7 statement/status: https://www.erdosproblems.com/7
