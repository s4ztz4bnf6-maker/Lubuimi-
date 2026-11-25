# BBMST source bridge: removing codimension-one hyperplanes without changing the target theorem
Date: 2026-10-27
Status: source-derived formalization target; not yet Lean-checked

## The concrete obstruction in the source proof

In Balister–Bollobás–Morris–Sahasrabudhe–Tiba, Theorem 3.2 gives the stronger second-moment estimate
\[
M_k^{(2)}\le |S_k|^{-2}\big(c_{k-1}(3)-2c_{k-1}(1)+1\big)
\]
only under two extra hypotheses: every \(|S_k|\ge3\), and no newly exposed hyperplane at stage k has codimension one. The original geometric theorem does not assume away codimension-one hyperplanes. Thus importing this strengthened estimate as a global lemma with a free predicate would silently strengthen the hypotheses and break source fidelity.

The paper itself gives the required reduction in the paragraph following Theorem 3.2: remove each codimension-one hyperplane, and for every coordinate i whose singleton value s is excluded, replace \(S_i\) by \(S_i'=S_i\setminus\{s\}\). The remaining hyperplanes are then interpreted in \(Q'=S_1'\times\cdots\times S_n'\), and each has at least two fixed coordinates. For the target box \(S_i=[p_{i+1}]\), the original size is at least 3, so \(|S_i'|\ge2\).

## Formalization target: a restriction-and-cover transport theorem

Encode a finite box as dependent finite coordinates and a hyperplane by its fixed-coordinate set plus values. Prove one source-faithful transport theorem with the following data and conclusions:

1. Given a finite cover of Q by pairwise nonparallel hyperplanes, identify all codimension-one hyperplanes and their excluded coordinate values.
2. Define each restricted coordinate set \(S_i'\) by deleting the excluded singleton value when present, and leave it unchanged otherwise.
3. Prove \(|S_i'|\ge2\), \(Q'\ne\varnothing\), and that every point of Q' avoids every removed codimension-one hyperplane.
4. Restrict every remaining hyperplane to Q'; prove that the restricted family still covers Q' and that each surviving hyperplane has codimension at least two relative to the remaining coordinate sets.
5. Prove nonparallelism is preserved: the fixed-coordinate set is unchanged by restriction, so equality of fixed-coordinate sets after restriction would imply equality before restriction.
6. Apply the strengthened Theorem 3.2 only to this restricted box, with its actual changed cardinalities. Do not reuse the original \(|S_i|\) values in the moment bounds after restriction.

This is a genuinely structural bridge: it turns the paper's codimension-one exception into a verified transformation of the geometric problem, rather than an axiom that the exception never occurs.

## Exact arithmetic and zero cases

The sieve update (paper equation (3)) is piecewise. In a fibre with removed fraction \(\alpha=0\), the removed part is empty; the branch for points in \(B_k\) is unreachable. The Lean development must prove that branch guard before relying on the rational expression with denominator \(\alpha\). Lean's totalized rational division at zero must never be treated as the intended mathematical quotient. Similarly, each normalizing factor \(1-\delta_k\) is positive only after the source condition \(0\le\delta_k\le1/2\) is carried into the local context.

## Why this is a better next step than another moment-gap abstraction

The interior-mass identity \(\Gamma=\sum p_i\alpha_i(1-\alpha_i)\) is valid, but by itself it does not derive the source's uniform parameter bound. The source already tells us exactly where the geometry enters: codimension-one hyperplanes must be removed before the stronger second-moment estimate is available. Formalizing this transport closes a real statement-fidelity gap and exposes the precise finite moment expressions that must then be bounded.

## Acceptance criteria

- The transport theorem has no assumptions asserting “no codimension-one hyperplanes” for the original cover.
- All finite sets and probability weights are explicit; no project-local axiom or oracle predicate encodes coverage, parallelism, or the desired contradiction.
- The theorem's transitive axiom report contains only the approved foundational axioms.
- A clean build is recorded before the theorem is described as Lean-verified.

Source: Balister et al., *The Erdős–Selfridge problem with square-free moduli*, especially Theorem 3.2 and the immediately following codimension-one reduction, arXiv:1901.11465. This note identifies a precise next proof obligation; it does not claim the transport theorem or the main theorem has already been formalized.
