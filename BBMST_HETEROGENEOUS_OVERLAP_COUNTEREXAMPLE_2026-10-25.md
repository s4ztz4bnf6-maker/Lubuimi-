# Heterogeneous-coordinate obstruction to cardinality-only pair bounds

Status: exact finite counterexample; this is a limitation theorem for the current second-moment strategy, not a global BBMST estimate.

## Counterexample

Take the coordinate set I = {1,2}, with finite coordinate spaces |S_1| = 2 and |S_2| = 3. Each product-box event below fixes exactly one coordinate.

- Pair (H_1,K_1): both events fix coordinate 1 to the same value. They are compatible, their shared-support cardinality is |F_{H_1} ∩ F_{K_1}| = 1, and their intersection has uniform mass 1/2.
- Pair (H_2,K_2): both events fix coordinate 2 to the same value. They are compatible, their shared-support cardinality is also 1, and their intersection has uniform mass 1/3.

Thus equal event codimension and equal overlap cardinality do not determine the pair-intersection mass when coordinate cardinalities are heterogeneous.

## Exact general formula

For compatible events H,K, with U = F_H ∪ F_K, the intersection mass is

P(H ∩ K) = (∏_{i∉U} |S_i|)/(∏_{i∈I}|S_i|).

The example differs only in which coordinate belongs to U. Therefore a bound based only on r = |F_H ∩ F_K| cannot recover the exact second-moment summand in this model. The support-indexed stratification in `BBMSTProductBox.lean` retains the information that is lost by cardinality-only stratification.

## When cardinality-only stratification is valid

If all coordinate spaces have the same cardinality q and each event fixes exactly k coordinates, then |U| = 2k-r, and the compatible intersection mass is q^{-(2k-r)}. This is a genuine special case, not a valid simplification for arbitrary finite product boxes.

## Consequence for the BBMST proof

The next quantitative estimate must either:
1. retain the actual support U (or a weighted statistic that determines its product weight), or
2. derive and state a symmetry/equal-cardinality hypothesis that makes the weight depend only on r.

No compatible-pair count bound follows from the exact identity alone. The published BBMST hypotheses must still be shown to imply the required weighted bound; this note does not establish that implication.
