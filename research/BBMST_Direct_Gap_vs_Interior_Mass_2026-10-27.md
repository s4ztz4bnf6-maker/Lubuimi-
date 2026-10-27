# BBMST: direct gap versus interior-fibre certificate

Date: 2026-10-27
Status: research decision note; no new theorem claimed.

## Audit diagnosis
The current moment identity
  Γ = Σᵢ pᵢ αᵢ(1−αᵢ)
and its zero criterion are exact. The obstruction is quantitative and geometric: these identities give no positive lower bound unless the source construction excludes configurations supported arbitrarily close to αᵢ∈{0,1}. The current interior-fibre lemma packages this missing fact as a sufficient condition; it does not derive it.

## Change of strategy
Do not make the interior-fibre lemma the only target. There are two logically distinct ways to close the gap:

A. Interior-mass route: derive from the original BBMST hyperplane/fibre construction constants ε,m>0, independent of the relevant dimension/stage, such that the total p-mass of fibres with ε≤αᵢ≤1−ε is at least m.

B. Direct-gap route: derive from the original construction a uniform lower bound Γ≥δ>0 directly, without first selecting a subset of interior fibres. This could be easier if the geometric constraints couple many αᵢ values and rule out near-boundary configurations collectively.

Both routes must preserve the original hypotheses and quantify every constant. Neither ε,m nor δ may be introduced as a free assumption.

## Required falsification test
Before claiming either route, search for exact rational finite configurations satisfying all source-defined constraints but with Γ arbitrarily small. If such a family exists, the proposed uniform-gap lemma is false in that interface and must be weakened or the source constraints strengthened only where the original theorem permits. If the search finds no countermodel, that is evidence for a conjecture, not a proof.

## Release condition
The unrestricted Erdős–Selfridge theorem remains blocked while its transitive dependency list contains project-local axioms `sf_sieve_lt_one` or `sieve_criterion`. A green build without an enforced axiom gate does not clear this blocker.