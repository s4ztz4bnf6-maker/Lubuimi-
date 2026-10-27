# Collatz route selection after ProofAtlas natural-density result

Date: 2026-10-27  
Status: research triage; external result described here is not re-proved by this repository.

## External result to account for

ProofAtlas lists Lech Mazur's July 21, 2026 formalization, *Natural-Density Almost-Bounded Collatz Orbits in Logarithmic Time*, as Lean-checked and accepted in its review workflow. Its stated scope is:
- for growing thresholds along odd inputs, odd-relative-density-one many odd starts have a Syracuse iterate below the threshold within 145 log N odd-to-odd steps;
- for growing thresholds on all positive inputs, ordinary-natural-density-one many positive starts have a raw Collatz iterate below the threshold within 436 log N raw steps.

The page explicitly says this does not prove convergence for every start or arrival at 1; a density-zero exceptional set may remain. It distinguishes the two density domains and time clocks. Before citing this as a premise in a formal theorem, pin the exact source commit and independently inspect the exact Lean declaration and its axiom/dependency evidence.

Reference: https://www.proofatlas.ai/formalizations/natural-density-log-time-collatz/

## Consequence for our project

The global divergence target is stronger than a natural-density-one descent statement. The most relevant gap is now sharply phrased:

Can the exact affine valuation identity, block descent margin, or a new deterministic valuation constraint exclude an exceptional set of starts whose trajectories never hit arbitrarily low thresholds?

A density-one theorem alone cannot exclude even one exceptional divergent orbit. Do not infer the universal conjecture from density statements.

## Candidate new structure: carry-corrected block signature

For a realized block of length m, let A be the total valuation and C its affine offset, so
\[
2^A x_m=3^m x_0+C.
\]
Define the exact block signature
\[
\Sigma_w(x_0)=A-m\log_2 3+
\log_2\!\left(\frac{3^m x_0}{3^m x_0+C}\right).
\]
Then the block descends exactly when \(\Sigma_w(x_0)>0\). This is equivalent to the usual logarithmic margin, but packages the valuation surplus and carry correction in one additive-scale quantity.

For concatenated realized blocks u then v, the affine offset composition is
\[
C_{uv}=3^{|v|}C_u+2^{A_u}C_v,
\]
with total valuation \(A_{uv}=A_u+A_v\). The next formal goal is not to assert entropy decay, but to derive an explicit composition law or a subadditive/superadditive bound for \(\Sigma\) with a rigorously bounded correction term.

## Falsification-first experiment

For each finite length m, enumerate only genuinely realizable odd Syracuse valuation prefixes (not arbitrary words), compute exact \((A,C)\), and search for:
1. prefixes with positive valuation surplus but non-descending outcome;
2. blocks whose signatures violate proposed subadditivity;
3. repeated local bit/valuation motifs with sharply different carry corrections.

Any counterexample should refine or reject the candidate bound before Lean formalization. Finite search is diagnostic only; it cannot establish the universal theorem.
