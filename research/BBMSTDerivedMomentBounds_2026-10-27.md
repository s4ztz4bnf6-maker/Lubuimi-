# BBMST: moment geometry as a derived interface (2026-10-27)

Status: algebraic lemma and formalization plan. Not Lean-compiled. This does not prove the BBMST theorem or its moment estimates.

## 1. Do not treat moments as unrelated parameters

In the source proof, \(\alpha:Q\to[0,1]\) is measured under a probability distribution \(P\). Write
\[
m=\mathbb E_P[\alpha],\qquad s=\mathbb E_P[\alpha^2].
\]
Because \(0\leq\alpha\leq1\), the pointwise inequalities
\[
\alpha^2\leq\alpha
\]
and
\[
(\alpha-m)^2\geq0
\]
give, after taking expectations,
\[
m^2\leq s\leq m.
\]
The lower inequality uses that \(P\) is a normalized probability measure: expanding the square gives \(s-m^2=\mathbb E_P[(\alpha-m)^2]\geq0\). This dependency must be explicit; it is not valid for arbitrary unnormalized weights without changing the formula.

## 2. Consequence for the threshold expression

For \(0<\delta<1\), let \(d=4\delta(1-\delta)>0\). Then
\[
\min\{m,s/d\}\geq \min\{m,m^2/d\}.
\]
Hence the pair of derived conditions
\[
m>T\quad\text{and}\quad m^2>dT
\]
is sufficient to conclude
\[
\min\{m,s/d\}>T.
\]
This is a ratio-safe interface only after positivity of d is proved. It can be implemented without dividing by d by using the equivalent conjunction \(m>T\) and \(s>dT\).

This lemma is a bridge between source-derived moment data and the final minimum criterion. It does not establish the required lower bound on m, nor does it prove that the recursively defined BBMST distributions and functions satisfy the stronger condition.

## 3. Lean statement design

Use a finite type \(Q\), a genuine probability measure \(P\) on Q, and \(\alpha:Q\to\mathbb R\) with pointwise bounds \(0\leq\alpha(x)\leq1\). Define m and s by integration or finite weighted sums from those same objects. Prove, in order:

1. \(0\leq m\) and \(s\leq m\) from \(\alpha^2\leq\alpha\).
2. \(m^2\leq s\) from nonnegativity of the variance.
3. The denominator-free threshold equivalence, with \(d>0\) explicit.
4. The sufficient-condition lemma above.
5. Only after these generic facts are checked, instantiate them with the actual \(P_{k-1}\) and \(\alpha_k\) from the source proof.

Do not accept m and s as unconstrained fields in a structure if the theorem's purpose is to formalize their source meaning. A small abstract lemma is useful, but its instantiation is the source-fidelity obligation.

## 4. Why this is the right audit seam

Prior audits repeatedly hit the same boundary: algebraic inequalities compile easily, while the hard theorem lies in constructing the correct probability distribution, proving normalization, respecting hyperplane geometry, and deriving moment bounds. This lemma strengthens the interface without hiding that boundary. It also exposes exactly what is still missing: a source-faithful lower bound on the first moment m strong enough to force both inequalities.

## 5. Acceptance criteria

- Prove normalization of P before invoking variance identities.
- Prove \(0<\delta<1\), or use the source's more restrictive interval and derive positivity.
- Avoid division by zero and Lean's totalized rational division.
- Derive moments from P and α; no free criterion hypothesis.
- Keep the theorem scope restricted to the square-free-moduli result proved by BBMST.
- Run Lean, inspect transitive axioms, and separately audit the informal-to-formal statement.

