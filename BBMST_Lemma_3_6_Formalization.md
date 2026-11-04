# BBMST Lemma 3.6 — source-faithful formalization record

**Status:** source reconstructed; no Lean theorem claimed in this document.

## Primary source

Paul Balister, Béla Bollobás, Robert Morris, Julian Sahasrabudhe, Marius Tiba,
*The structure and number of Erdős covering systems*,
Journal of the European Mathematical Society 26 (2024), no. 1, 75–109,
DOI: [10.4171/JEMS/1357](https://doi.org/10.4171/JEMS/1357).
The publisher's version is open access under CC BY 4.0. Lemma 3.6 is on printed
page 83 (PDF page 9); its proof continues on the same page.

## Exact statement of Lemma 3.6

Let \(I\) be a nonempty finite index set. For each \(j\in I\), let \(S_j\)
be a finite set with \(|S_j|\ge 2\), and let \(R_j\subseteq S_j\) satisfy
\[
 |R_j|\ge \varepsilon(|S_j|-1)+1.
\]
Let \(0<\lambda,\varepsilon<1\), let \(R_I=\prod_{j\in I}R_j\), and let
\(\widetilde\mu\) be the uniform probability measure on \(R_I\).
For a hyperplane \(H\subseteq S_I=\prod_{j\in I}S_j\), write
\(F(H)=\{j\in I: H_j\text{ is a singleton}\}\).
If \(i\in F(H)\) and
\[
 \mu_{I\setminus\{i\}}(H)
 \le \delta_0
 :=2^{-9}\lambda^2
 \varepsilon^{\,2\log_2(1/(\lambda\varepsilon))+11},
\]
then
\[
 \widetilde\mu(H\cap R_I)
 \le \frac{\lambda}{2^{|F(H)|/2+4}|S_i|}.
 \tag{12}
\]

Here \(\mu_J(H)=|H_J|/|S_J|\) is the uniform density of the
coordinate-restriction of \(H\) to \(S_J\). In particular, because
\(i\in F(H)\), the \(i\)-coordinate of \(H\) is a singleton.

## Source-faithful proof skeleton

Put \(\ell=|F(H)|\). The proof first obtains
\[
 \widetilde\mu(H\cap R_I)\,|R_i|
 \le \mu_{I\setminus\{i\}}(H)
       \prod_{j\in F(H),\,j\ne i}\frac{|S_j|}{|R_j|}
 \le \delta_0\varepsilon^{-(\ell-1)}.
 \tag{A}
\]
The last step uses
\(|R_j|\ge\varepsilon|S_j|\), which follows from the stated
cardinality condition and \(|S_j|\ge2\).

Assume, for contradiction, that (12) fails. Since \(|R_j|\ge2\),
\[
 2^{-(\ell-1)}
 \ge \prod_{j\in F(H),\,j\ne i}\frac1{|R_j|}
 =\widetilde\mu(H\cap R_I)|R_i|
 >\frac{\lambda}{2^{\ell/2+4}}\frac{|R_i|}{|S_i|}
 \ge\frac{\lambda\varepsilon}{2^{\ell/2+4}}.
\]
Consequently
\[
 \ell\le 2\log_2(1/(\lambda\varepsilon))+10.
 \tag{B}
\]
Combining (A) and (B),
\[
 \begin{aligned}
 2^{\ell/2+4}\widetilde\mu(H\cap R_I)
 &\le \frac{2^{9/2}\delta_0}{|R_i|}
       \left(\frac{\sqrt2}{\varepsilon}\right)^{\ell-1}\\
 &\le \frac{2^{9/2}\delta_0}{|R_i|}
       \left(\frac{\sqrt2}{\varepsilon}\right)^{
          2\log_2(1/(\lambda\varepsilon))+9}\\
 &=\frac{\lambda\varepsilon}{|R_i|}
 \le\frac{\lambda}{|S_i|},
 \end{aligned}
\]
which is (12).

## Formalization boundary

A faithful Lean development must define, rather than assume away:

1. finite coordinate products and their cardinalities;
2. hyperplanes as products whose coordinates are either the full \(S_j\)
   or a singleton;
3. the fixed-coordinate set \(F(H)\);
4. restricted density \(\mu_{I\setminus\{i\}}(H)\);
5. the uniform measure of \(H\cap R_I\);
6. the cardinality-to-density estimate (A);
7. the logarithmic/exponential estimate (B) and the final scalar inequality.

A useful staged implementation is to prove (A) and the contradiction step as
separate finite-cardinality lemmas, then isolate the real-analysis identity
involving \(\varepsilon^{2\log_2(1/(\lambda\varepsilon))+11}\).
The theorem must not be weakened into an assumption that already contains
the desired conclusion.

## Verification status

- **Source:** checked against the publisher's JEMS PDF, Lemma 3.6, printed p. 83.
- **Mathematical reconstruction:** proof skeleton above follows the published proof.
- **Lean:** not yet formalized or kernel-checked.
- **APW4 coupling:** not part of Lemma 3.6 and not established by this record.
