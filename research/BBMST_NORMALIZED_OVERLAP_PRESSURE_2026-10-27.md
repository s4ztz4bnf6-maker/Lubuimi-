# BBMST research note: normalized overlap pressure

Date: 2026-10-27

## Scope

This is an exact normalization of the generic second-moment bound in the existing BBMST second-moment overlap-budget note. It creates a compact quantity to optimize or falsify. It does not assert that the original BBMST theorem follows.

## Setup

Let \(V=\mathbb F_q^d\) with uniform measure, and let \(H_1,\ldots,H_m\) be affine hyperplanes defined by nonzero linear forms. Let \(S(x)=\sum_i\mathbf 1_{H_i}(x)\) and \(U=\{x:S(x)>0\}\). Let \(R_2\) count unordered rank-two pairs and \(C_1\) count unordered compatible rank-one pairs; incompatible rank-one pairs have empty intersection.

The exact second moment is
\[
\mathbb E S^2=\frac m q+\frac{2R_2}{q^2}+\frac{2C_1}{q}.
\]
Cauchy--Schwarz gives
\[
\mathbb P(U)\ge
\frac{m^2}{mq+2R_2+2qC_1}.
\]

## Definition: normalized overlap pressure

Define the dimensionless quantity
\[
\Omega_q(H_1,\ldots,H_m)
=\frac{mq+2R_2+2qC_1}{m^2}
=\underbrace{\frac qm}_{\text{diagonal}}+
\underbrace{\frac{2R_2}{m^2}}_{\text{transverse pairs}}+
\underbrace{\frac{2qC_1}{m^2}}_{\text{coincident/compatible pairs}}.
\]
Then
\[
\mathbb P(U)\ge \frac{1}{\Omega_q}.
\]
Consequently, a target \(\mathbb P(U)>\theta\) is certified by the explicit inequality \(\Omega_q<1/\theta\). This isolates the exact work left to the rank-counting argument: bound the normalized transverse and compatible-pair contributions under the original BBMST definitions.

## Why this normalization helps

- It separates the unavoidable diagonal term from geometric and degeneracy terms.
- It makes candidate bounds dimensionless, allowing comparisons across q, m, and dimensions.
- It exposes the dangerous case: a large \(C_1\) can dominate even when most pairs are transverse.
- It yields a clean falsification test for proposed rank-count estimates: compute \(\Omega_q\) on finite examples and reject any claimed upper bound that fails.

## Formal obligations

1. Derive the pair classification from the actual affine equations, not a free predicate for parallelism.
2. Check duplicate indexing and repeated hyperplanes; compatible rank-one pairs must be counted with multiplicity if the source model does so.
3. Prove the finite second-moment inequality independently of BBMST.
4. Compare \(1/\Omega_q\) with the precise threshold in the source theorem. A valid bound may be too weak.
5. Do not identify a normalized overlap estimate with the full Erdős--Selfridge conclusion until the source-specific bridge is complete.
