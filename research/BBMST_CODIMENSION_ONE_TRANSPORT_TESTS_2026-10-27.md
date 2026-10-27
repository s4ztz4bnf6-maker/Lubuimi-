# BBMST codimension-one transport: finite proof obligations and counterchecks

Date: 2026-10-27  
Status: source-faithful formalization plan; not Lean-checked and not a proof of the main theorem.

## 1. Exact geometric setup

Let \(Q=S_1\times\cdots\times S_d\), with finite coordinate sets and \(|S_i|\ge3\). Represent a combinatorial hyperplane by its set of fixed coordinates and their assigned values. Its codimension is the number of fixed coordinates. Two hyperplanes are parallel when their fixed-coordinate sets agree. Assume the original family is pairwise nonparallel and covers \(Q\).

The source issue is that the strengthened second-moment estimate is only available after codimension-one hyperplanes have been removed. It is not valid to add “there are no codimension-one hyperplanes” as an assumption about the original cover.

## 2. Restrict the coordinate sets

Every codimension-one hyperplane fixes exactly one coordinate, say coordinate \(i\), to a singleton value \(s_i\). Pairwise nonparallelism implies there is at most one codimension-one hyperplane for each fixed coordinate \(i\): two such hyperplanes would have the same fixed-coordinate set and hence be parallel.

For each coordinate define
\[
S_i'=\begin{cases}
S_i\setminus\{s_i\},&\text{if a codimension-one hyperplane fixes coordinate }i\text{ to }s_i,\\
S_i,&\text{otherwise.}
\end{cases}
\]
Then \(|S_i'|\ge |S_i|-1\ge2\), so every \(S_i'\) is nonempty and \(Q'=\prod_i S_i'\) is nonempty.

Every point of \(Q'\) avoids each removed codimension-one hyperplane: its omitted coordinate is not the excluded singleton value. Since the original family covered \(Q\), the surviving hyperplanes therefore cover \(Q'\).

A surviving hyperplane has the same fixed-coordinate set after restriction, and its assigned values remain in the corresponding restricted coordinate sets. Its codimension is unchanged. Since all codimension-one hyperplanes were removed, every surviving hyperplane has codimension at least two relative to the restricted box. Equality of fixed-coordinate sets after restriction would imply equality before restriction, so pairwise nonparallelism is preserved.

**Scope guard:** the transport argument assumes the source's exact hyperplane representation and pairwise-nonparallel hypothesis. Lean must encode and prove those facts; it must not replace them with an oracle predicate.

## 3. Why the moment gap cannot be abstracted away

For weights \(p_i\ge0\) and shares \(0\le\alpha_i\le1\), the exact identity is
\[
\sum_i p_i\alpha_i-\sum_i p_i\alpha_i^2
=\sum_i p_i\alpha_i(1-\alpha_i).
\]
But it has no universal positive lower bound from these conditions alone. For \(p_i=1/d\) and \(\alpha_i=1/d\),
\[
\Gamma_d=\frac1d\left(1-\frac1d\right)\to0.
\]
This is a counterexample to the proposed abstract lower-bound step, not to the original geometric theorem. The geometric structure must produce whatever quantitative estimate the source uses.

## 4. Lean theorem decomposition

Avoid one monolithic theorem. Prove these independent statements:

1. codim_one_unique_per_coordinate: two codimension-one hyperplanes omitting the same coordinate are parallel.
2. restricted_coordinate_card: \(|S_i'|\ge2\).
3. restricted_box_nonempty: construct a point of \(Q'\) from nonemptiness of every \(S_i'\).
4. removed_hyperplane_avoided: every point of \(Q'\) avoids every removed hyperplane.
5. surviving_family_covers: coverage of \(Q\) plus avoidance of removed hyperplanes implies coverage of \(Q'\) by survivors.
6. codim_preserved: restriction does not change a survivor's fixed-coordinate set or codimension.
7. nonparallel_preserved: pairwise nonparallelism survives restriction.
8. apply_second_moment_after_restriction: only now invoke the source's strengthened estimate, using the actual cardinalities \(|S_i'|\), never the original sizes by silent substitution.

Use finite sets and explicit membership predicates. The restriction operation should be a definition, not a premise saying the desired conclusion already holds.

## 5. Boundary and denominator gates

At each sieve stage, branch conditions must be proved before using rational expressions. In particular:

- If a fibre share \(\alpha=0\), prove the branch requiring a point in the removed portion is unreachable before using division by \(\alpha\).
- Carry \(0\le\delta\le1/2\) into the context before asserting \(1-\delta>0\).
- Audit every normalization factor and every totalized rational division at zero.
- Keep sf_sieve_lt_one and sieve_criterion forbidden in the transitive axiom list of the final target theorem until their source-faithful proofs exist.

## 6. Acceptance criteria

The bridge is ready only when:

- the restriction and coverage theorems compile on the pinned toolchain;
- the main target is compared against the exact theorem in the source paper;
- no hypothesis excludes codimension-one hyperplanes from the original cover;
- the strengthened estimate is used only on the restricted box;
- all parameter/cardinality changes are propagated through the moment formulas;
- the target theorem's transitive axiom report contains only explicitly approved foundational axioms.

This transport closes a statement-fidelity gap, not automatically the entire BBMST proof. The subsequent moment bounds and the connection to the precise Erdős–Selfridge statement remain separate proof obligations.
