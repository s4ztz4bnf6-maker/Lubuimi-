# BBMST theorem-to-Lean obligations: codimension and moments

## Exact source statement

Balister, Bollobás, Morris, Sahasrabudhe, and Tiba, “The Erdős–Selfridge problem with square-free moduli,” *Algebra & Number Theory* 15 (2021), 609–626, DOI https://doi.org/10.2140/ant.2021.15.609, defines a hyperplane in a finite product \(Q=S_1\times\cdots\times S_n\) by fixing a subset of coordinates and leaving the others free. The set \(F(A)\) is the fixed-coordinate set. Parallelism is exactly equality of these fixed-coordinate sets.

Theorem 3.2 gives the general bound
\[
M_k^{(2)}\le \frac{c_{k-1}(3)}{|S_k|^2}.
\]
In the published version, the improved bound applies under \(|S_k|\ge2\) and the condition that none of the newly exposed hyperplanes in \(\mathcal N_k\) has codimension one. The earlier preprint version stated the stronger \(|S_k|\ge3\) condition; the published theorem is the source of record. It gives the improved bound
\[
M_k^{(2)}\le
\frac{c_{k-1}(3)-2c_{k-1}(1)+1}{|S_k|^2}.
\]

In this discrete product geometry, codimension one means exactly one fixed coordinate, i.e. \(|F(A)|=1\). This is not a theorem that every configuration automatically satisfies. It is a separate hypothesis on the stage family \(\mathcal N_k\).

## Concrete Lean mapping

The geometry sandbox now defines:
- HasCodimensionOne H as H.fixed.card = 1;
- NoCodimensionOneAt stage as every hyperplane in the given stage family having fixed-coordinate cardinality different from one;
- intersects_iff_agree_on_overlap as the exact intersection criterion for coordinate cylinders.

These definitions remove the ambiguity in the former abstract predicate. They do not prove that the arithmetic configuration satisfies NoCodimensionOneAt; that must be shown at the application site from the actual family of square-free moduli / fixed-coordinate sets.

## Proof route and failure modes

1. Define a stage family \(\mathcal N_k\) from the same finite family of hyperplanes used to define \(B_k\).
2. Prove its membership and fixed-coordinate set agree with the source's definitions, not a parallel surrogate.
3. Prove the stage-specific fact \(\forall A\in\mathcal N_k,\ |F(A)|\ne1\) from the source's arithmetic restrictions. If singleton fixed sets are possible, the improved bound is not available for that stage; use the general bound instead or split off those cases as the source does.
4. Formalize the first and second moments from the finite probability distribution and the function \(\alpha_k(x)\), then prove the general and improved bounds from the corresponding combinatorial counting statements.
5. Only after this derivation should the theorem be connected to the sieve criterion and validated numerical parameters.

The source's supplementary page provides executable C code for the finite linear-programming distributions and for optimizing the parameters \(d_k\) for \(6\le k\le21\). This is a useful independent computational cross-check, but it is not a replacement for the proof of the geometric and moment inequalities.

## Sources

- Original paper: https://arxiv.org/abs/1901.11465
- Published version: https://doi.org/10.2140/ant.2021.15.609
- Supplemental code and outputs: https://people.maths.ox.ac.uk/balister/Erdos-Selfridge.html


## Source-level moment proof pattern to formalize

The published proof immediately preceding the improved second-moment estimate proceeds through two finite counting lemmas:

- Lemma 3.3 bounds the measure of a Q_k-measurable hyperplane A by P_k(A) ≤ c(I)ν(J), splitting its fixed-coordinate set as F(A)=I∪J, with I⊆[a] and J⊆[a+1,k]. The induction step uses the exact fibre extension rule for P_k, including the factor 1/(1−δ_k) when coordinate k is fixed.
- Lemma 3.4 expands E_{k−1}[α_k(x)^t] and applies the union bound to t-tuples F_1,…,F_t in N_k, reducing the problem to the union of their fixed-coordinate sets and the c,ν bounds from Lemma 3.3.

This suggests the correct Lean architecture: first formalize the finite product probability and fibre extension; then an indicator-function/union-bound lemma; then the general moment estimate; finally isolate the codimension-one exclusion as the additional hypothesis used only for the improved estimate. Do not encode the improved estimate as a field of ImprovedSecondMomentBound, because that would assume the target conclusion instead of deriving it.

Source text and theorem numbering: https://ora.ox.ac.uk/objects/uuid%3A3c55267c-60be-4652-89a7-db3db5f62c25/files/rdv13zt50s


## Independent certificate strategy found in the literature audit (2026-10-22)

The open Erdős research repository now documents an independent exact-arithmetic reconstruction of the published BBMST proof chain. Its finite evidence checker verifies 9,283 primal certificates for the reduced configuration tree and checks their rational weights over all 480 points; it explicitly states that this is not a Lean verification. This is useful as a second oracle for finite parameter/certificate data, but it does not replace the formal proof of the measure lemmas.

Adaptation plan:
1. Keep the Lean development responsible for the generic fibre and moment inequalities.
2. Represent each finite parameter certificate as exact naturals/rationals, never floating-point values.
3. Independently check each certificate by recomputing all finite sums and strict inequalities inside Lean.
4. Compare the resulting exact certificate against the published-source reconstruction, while keeping the general theorem and the finite numerical instance as separate obligations.

This route avoids trying to formalize an optimizer. An optimizer may discover a certificate; only the exact rational checker and the proven general inequalities certify it. Reference: https://erdosproblems.ai/wiki/library/covering_systems/balister_2021_erdos_selfridge_problem_square_free_moduli


## Source-level refinement from the published paper (checked 2026-10-22)

The current formalization must not treat “no codimension-one hyperplane” as a universal property of arbitrary coordinate-cylinder families. The published proof obtains its sharper estimate by counting unions of fixed-coordinate sets and using the absence of newly exposed singleton fixed sets at the relevant stage. The general bound remains the fallback when that condition cannot be established.

The adjacent published structural Lemma 3.4 is also a useful model: it starts with a minimal cover of a finite product, constructs coordinate-deletion maps and smaller minimal covers, and then forces one of two alternatives. In the second alternative, the selected hyperplanes have fixed-coordinate size at least two and a weighted sum of 2^{-|F(H)|/4} is large. This is a stronger proof pattern than simply postulating the needed codimension condition: derive a structural alternative from minimality, then use it to establish the relevant moment/interface estimate.

Lean adaptation:
- Add a finite MinimalCover predicate with explicit coverage and irredundancy.
- Prove coordinate projection/deletion preserves the required cover property for the selected subfamily.
- Formalize the two alternatives as a disjunction, keeping rational weights exact.
- Use the theorem only at the source stage where its minimal-cover hypotheses are present; do not assume it for arbitrary stages.
- Retain the generic moment bound as a fallback when the improved branch's hypotheses fail.

Source: published BBMST paper, especially the structural Lemma 3.4 and the proof chain leading to Theorem 3.2. Publisher record: https://ems.press/content/serial-article-files/42559
