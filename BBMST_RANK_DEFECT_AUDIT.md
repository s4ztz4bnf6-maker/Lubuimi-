# BBMST affine rank-defect audit

Date: 2026-10-24
Branch: `audit/overlap-moment-roadmap-2026-10-23`

## Exact linear-algebra meaning of the defect

Let (V) be a finite-dimensional vector space over a finite field (K), and let
(T:V\to W_1), (U:V\to W_2) be linear maps. Write
(R_T=\operatorname{im}(T^*:W_1^*\to V^*)) and similarly (R_U).
The stacked map is (S=(T,U):V\to W_1\times W_2), and its dual image is
(R_S=R_T+R_U). Hence
[
d=\operatorname{rank}(T)+\operatorname{rank}(U)-\operatorname{rank}(S)
=\dim(R_T\cap R_U).
]
Thus the rank defect is exactly the dimension of the shared dual constraint space. This interpretation is more informative than treating (d) as an opaque scalar: a large defect means the two systems reuse many linearly dependent constraints.

For any consistent affine equations (T(x)=b) and (U(x)=c), the joint fiber has
(|K|^{\dim V-\operatorname{rank}(S)}) elements, while the separate fibers have
(|K|^{\dim V-\operatorname{rank}(T)}) and
(|K|^{\dim V-\operatorname{rank}(U)}) elements. Consequently,
[
\frac{|\{x:T(x)=b, U(x)=c\}|/|V|}
{(|\{x:T(x)=b\}|/|V|)(|\{x:U(x)=c\}|/|V|)}
=|K|^d
]
whenever the joint fiber is nonempty. If the joint equations are inconsistent, the intersection mass is zero instead. The factor (|K|^d) is therefore an exact correlation multiplier relative to the product of marginal fiber masses, not by itself an upper bound on the total second moment.

## What this does and does not imply

The formula proves that counting high-defect pairs is a natural route to controlling overlap. It does **not** prove that high-defect pairs are exponentially rare in the BBMST family. Such a rarity statement needs a source-faithful description of the actual family of linear constraints and a combinatorial or geometric counting argument. It cannot be assumed merely because the moduli are odd and square-free.

For events (E_i), the finite identity
[
(\sum_i 1_{E_i})^2=\sum_{i,j}1_{E_i\cap E_j}
]
reduces the second moment to pair intersections. The next genuine BBMST step is to classify the paper's actual hyperplane pairs by shared dual constraints, prove bounds for each class under the paper's hypotheses, and sum those bounds with the correct weights. Arbitrary affine maps are a useful formal test bed but are not a substitute for the BBMST hyperplane construction or its initial-distribution argument.

## Proof obligations

1. Identify the exact BBMST vector space, finite probability measure, hyperplanes, and dual constraint subspaces in Lean.
2. Prove the rank-defect/dual-intersection identity from the definitions used by the formalization.
3. Prove a quantitative count or weighted-mass bound for each defect class **for that family**, not for arbitrary maps.
4. Handle inconsistent pairs as zero contribution and avoid using a uniform-fiber formula without its nonemptiness witness.
5. Connect the resulting second-moment estimate to the exact published sieve inequality.
6. Eliminate or explicitly retain as open obligations the project-specific axioms `sieve_criterion` and `sf_sieve_lt_one`.

## Current CI status (snapshot)

Run: https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/40123117679

At last inspection, upstream source compilation, degenerate-witness tests, disjoint-block factorization, finite weighted overlap-conditioning, and effective block-size monotonicity had completed successfully. Scalar BBMST fiber-mass normalization was still running; this workflow was not yet complete. No claim of an axiom-free global Erdős–Selfridge proof follows from these steps.
