# BBMST audit update: separate scalar weight gap from global sieve progress (2026-10-25)

## Exact pointwise identity already available

On the active fiber branch α>δ, the scalar reweighting multipliers are
w_cov=(α−δ)/(α(1−δ)), w_uncov=1/(1−δ).
Their difference is exactly w_uncov−w_cov=δ/(α(1−δ)). After multiplying by the covered fraction, the α-dependence cancels: α(w_uncov−w_cov)=δ/(1−δ), which is at least δ for 0≤δ≤1/2.

These identities are already represented in BBMSTFiberSieve.lean as scalar Lean declarations, including the multiplier gap, its positivity criterion, and the covered-mass-weighted gap. They should not be misread as a loss of total mass: the fiber update preserves total mass exactly. The gap measures a relative reweighting contrast between covered and uncovered points.

## Proof-architecture consequence

The scalar update can contribute to a global sieve estimate only after it is coupled to a geometric statement controlling how the same points are covered across successive stages. The required bridge has three separate layers:

1. Fiber algebra: exact normalization and multiplier contrast (formalized).
2. Geometric overlap: for actual affine hyperplane events, compatible intersections have computable fiber size; incompatible affine constraints give empty intersections. Linear dependence of forms yields necessary offset consistency (parts of this geometry are formalized).
3. Global iteration: a source-faithful BBMST hypothesis must bound the accumulated positive overlap contribution and justify the threshold/strictness conclusion.

The overlap-graph decomposition isolates exactly where the second layer enters: disjoint coordinate supports contribute zero covariance, compatible overlaps contribute positive covariance, and inconsistent overlaps contribute negative covariance. An arbitrary degree bound or a free sieve_criterion would simply assume the difficult third layer and is not an acceptable closure.

## Immediate audit target

For each stage of the original BBMST construction, derive a finite identity expressing updated event mass in terms of actual affine-fiber cardinalities and the preceding stage's weights. Then prove that the source hypotheses imply the needed aggregate overlap bound. Explicitly cover α=0, α=δ, α=1, empty coordinate support, and incompatible offsets; active-branch quotient formulas alone do not cover those cases.

## Evidence boundary

This is an audit roadmap, not a new Lean theorem. Existing CI checks scalar fiber-mass normalization, finite weighted overlap identities, and product-box affine geometry, but does not establish the global BBMST sieve criterion or final theorem.
