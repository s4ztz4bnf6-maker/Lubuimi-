# Second-moment bridge audit and Lean registration

Date: 2026-10-30

## Executive result

The repository already contained a generic exact second-moment identity in `BBMSTMomentBridge.lean`. The previous research note's description of higher moments as a wholly new addition was imprecise: the new contribution here is the explicit translation of the CRT fibre-covering condition into a pair-overlap lower bound, plus registering the existing bridge as a Lean library root.

The file was present on the active branch but was not listed in `lakefile.lean`'s `lean_lib ErdosSelfridgeAudit.roots`. This meant that a plain library build could omit it unless another root imported it. The lakefile now lists `BBMSTMomentBridge`. This is a build-coverage correction, not evidence that the module compiles. A CI run must decide that.

## Exact combinatorial reduction

Let U be the finite set of base residues missed by all old classes. For each new class j, let C_j be the set of base residues hit by its projection. Define
```
m(x) = #{j : x ∈ C_j}, for x ∈ U.
```

If all q fibres above every x in U are covered, the distinct q-coordinate argument gives m(x) >= q.

Count ordered pairs (j,k) with j != k and x ∈ C_j ∩ C_k. For each x, there are m(x)(m(x)-1) such ordered pairs. Hence
```
Σ_{j != k} |U ∩ C_j ∩ C_k|
  = Σ_{x ∈ U} m(x)(m(x)-1)
  >= q(q-1)|U|.
```
Equivalently, counting unordered pairs,
```
Σ_{j < k} |U ∩ C_j ∩ C_k|
  >= binom(q,2) |U|.
```

This is stronger than the first-moment incidence lower bound when q >= 2. It converts the local allocation requirement into a lower bound on total pairwise overlap. The existing `fiber_second_moment` theorem is the abstract equality-fibre identity needed for a weighted/indicator implementation: a sum of squared fibre loads equals the sum over pairs with equal images. A direct covering-specific theorem should instantiate its domain with the incidence pairs (x,j) satisfying x∈U and x∈C_j, then project to x.

The arithmetic upper-bound problem is now sharper: bound the total pair overlap
`Σ_{j<k}|U∩C_j∩C_k|`
using the actual moduli, residue compatibility, and pairwise distinctness. For two projected classes modulo d_j and d_k, the intersection is empty unless their residues agree modulo gcd(d_j,d_k); when compatible, the full base intersection is one class modulo lcm(d_j,d_k), hence has size M/lcm(d_j,d_k) in ZMod M. Intersecting with U can only reduce it.

Crucially, this upper bound alone may still be too weak if many pairs are compatible. The required next result is a global estimate on the number/weight of compatible pairs, not merely the individual CRT cardinality.

## Exact second-moment identity already in the repository

For a finite map f : X → Y and weights w : X → ℚ, the existing theorem states
```
Σ_y (Σ_{x:f(x)=y} w(x))²
 = Σ_{x,x': f(x)=f(x')} w(x)w(x').
```
This identity is mathematically exact. The file also contains a guarded expression
`safeStageContribution m1 m2 δ = if 0 < δ then min m1 (m2/(4δ(1-δ))) else m1`.
Its positivity and elementary bounds are proved, but the file itself does not establish that a source-faithful BBMST stage theorem supplies the inputs m1, m2, δ with the required inequality. The name and algebraic shape of this expression must not be treated as a proved BBMST sieve estimate until that bridge is supplied from the paper's definitions and hypotheses.

## Lean build coverage correction

Updated `lakefile.lean` so the library roots include `BBMSTMomentBridge`. The edit is committed but not yet CI-verified. No `lake build`, kernel result, or axiom audit is claimed in this note.

## Five-source evidence discipline

1. Quanta Magazine (3 Aug 2026) reports AI-assisted Erdős discoveries and describes substantial human improvement/cleanup after an initial model result. It is evidence for collaborative discovery, not for this covering-system theorem.
2. Tao / Hales (9 Oct 2026) explicitly says Lean proofs should not be believed before kernel checking and requires human statement-fidelity review; the post also discusses soundness bugs and cross-kernel checking. This governs our verification claims.
3. ProofAtlas labels the Odd Distinct Covering-System Conjecture open and identifies the universal full-p H=2 minimax inequality across twenty mixed shallow depth types as the priority open bridge. Its route-map statements are research claims with incomplete dependencies, not proof evidence.
4. MAA Math Values (1 Jun 2026) discusses the AI-produced unit-distance counterexample and notes the human work needed to make the proof accessible. It concerns a different Erdős problem.
5. OpenAI's mathematics release (6 Oct 2026; update 15 Oct) says it is publishing research results, formalizations for many proofs, reasoning summaries, and attempt statistics. It does not imply that any result in this repository has been verified.

## Status boundary

The unrestricted Erdős Problem 7 remains listed as open by the Erdős Problems database. The odd squarefree subcase is ruled out by BBMST22; that is not the unrestricted odd-distinct problem. The present one-prime CRT and pair-overlap inequalities are necessary conditions only. No proof or counterexample for the unrestricted conjecture is claimed.

## Sources

- Quanta Magazine: https://www.quantamagazine.org/why-the-legendary-erdos-problems-are-falling-to-ai-20260803/
- Tao / Hales: https://terrytao.wordpress.com/2026/10/09/what-mathematicians-should-know-about-the-lean-theorem-proverquestions-of-reliability-and-ai/
- ProofAtlas: https://www.proofatlas.ai/collaboration/odd-distinct-covering-system-conjecture/
- MAA Math Values: https://maa.org/math-values/ai-solves-an-80-year-old-erdos-problem/
- OpenAI: https://openai.com/index/sharing-ai-progress-in-mathematics/
- Erdős Problem 7: https://www.erdosproblems.com/7
