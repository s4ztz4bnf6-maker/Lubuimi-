# BBMST next theorem: cylinder mass and compatible intersections

Date: 2026-10-23

## Literature alignment

Balister–Bollobás–Morris–Sahasrabudhe–Tiba's distortion method models arithmetic progressions as coordinate hyperplanes in a finite product space. The source proof's leverage is not the bare finite product identity; it is the structural control of non-parallel hyperplanes and the quantitative distortion bounds that make a second-moment argument effective. See the published exposition: https://doi.org/10.1007/s10474-020-01048-z and the later uncovered-set paper: https://digitalcommons.memphis.edu/facpubs/5342.

## Exact cylinder-mass target

Let (X=prod_{iin mathrm{Fin} n} X_i), with finite nonempty coordinate sets, and let the point weight be
[
w(x)=prod_i w_i(x_i),qquad sum_{uin X_i}w_i(u)=1.
]
For a cylinder (H) fixing (Fsubseteq mathrm{Fin} n) to compatible values (v_i), the intended identity is
[
mu(H)=prod_{iin F} w_i(v_i).
]

Proof architecture: rewrite the event sum as a sum over assignments on fixed and free coordinates; factor the finite sum into coordinate sums; each free-coordinate factor becomes (1) by normalization. The generic dependent-Pi theorem previously attempted is not needed if the actual theorem is stated directly on (mathrm{Fin} n).

## Exact intersection target

For cylinders (H,K), let (F,G) be their fixed-coordinate sets.

- If a coordinate in (Fcap G) is assigned two distinct values, the intersection is empty and its mass is exactly (0).
- Otherwise, the combined prescription is well-defined on (Fcup G), so
  [
  mu(Hcap K)=prod_{iin Fcup G}w_i(v_i^{Hcup K}).
  ]
  Shared coordinates are included once, not twice.

The current `BBMSTIntersectionMass.lean` proves the zero-mass case and safe marginal upper bounds. It does not yet prove this compatible-intersection product identity. The current `factorizedPointWeight_split_on_cylinder` is only a pointwise factor split; summing it over all points in the cylinder is the remaining combinatorial step.

## Second moment: exact interface

For (Z(x)=sum_{jin J}1_{H_j}(x)), the finite identity is
[
mathbb E[Z^2]=sum_{jin J}mu(H_j)+sum_{j
e k}mu(H_jcap H_k).
]
This is algebraic and should be formalized separately from any probabilistic estimate. The BBMST-specific work then bounds the off-diagonal intersection sum using geometry and distortion. A product identity alone cannot substitute for that estimate.

## A crucial limitation of the proposed Collatz adaptive refinement

The rule “if a block does not prove descent, refine to (k+1)” is a search strategy, not yet a termination proof. A formal global argument needs a ranking/termination measure or a coverage theorem showing that every branch is eventually certified; otherwise an infinite branch of failed refinements remains possible. This distinction should remain explicit in any joint project report.
