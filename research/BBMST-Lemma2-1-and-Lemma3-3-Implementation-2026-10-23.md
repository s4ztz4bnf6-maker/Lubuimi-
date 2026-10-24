# BBMST source-faithful implementation checklist: Lemma 2.1 and Lemma 3.3

The published paper's measure recursion is more specific than a generic event-mass API.
At stage k, points in the removed set B_k are reweighted by
max(0, (α_k(x)-δ_k)/(α_k(x)(1-δ_k))) when α_k(x)>0, while points outside B_k
are reweighted by min(1/(1-α_k(x)), 1/(1-δ_k)). The zero-mass fiber case must be
handled explicitly rather than dividing by α_k(x)=0.

Lemma 2.1 establishes three separate facts:
(4) preservation of mass on Q_{k-1}-measurable sets;
(5) the global distortion bound P_k(S) ≤ P_{k-1}(S)/(1-δ_k);
(6) contraction P_k(S) ≤ P_{k-1}(S) when S ⊆ B_k.

Lemma 3.3 then inductively propagates the initial hyperplane weight to a bound
P_k(A) ≤ c(I) ν(J), where F(A)=I∪J splits the support between the initial
coordinates and the later sieve coordinates.

Recommended Lean dependency order:
1. Define finite coordinate spaces Q_k and the removed set B_k.
2. Define α_k on each fiber, with an explicit zero-fiber branch.
3. Define P_k by the source's piecewise reweighting formula.
4. Prove nonnegativity and total mass one.
5. Prove the three statements of Lemma 2.1 independently.
6. Define support and prove the induction for Lemma 3.3.
7. Only then encode Lemma 3.4 and the higher-moment bound.

Do not axiomatize the desired hyperplane inequality or a generic “hyperplane”
predicate with a field that directly assumes the conclusion. The point of the
formalization is to derive the inequality from the concrete geometry and
recursive measure.

Source: Balister, Bollobás, Morris, Sahasrabudhe, Tiba, The Erdős–Selfridge
problem with square-free moduli, Algebra & Number Theory 15 (2021), 609–626.
The publisher-typeset article is available from the NSF public-access repository.
