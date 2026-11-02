# Five-prime CRT maximality: exact coupling frontier

Date: 2026-10-31
Status: proof-obligation specification with exact local identities; no global five-prime theorem claimed.

## 1. Why this is the next global target

The multi-prime survivor product bound is the arbitrary-exponent form of the four-prime weight-region argument. It proves noncoverage whenever
\[
R(\mathbf t):=\prod_{i=1}^k(1+t_i)-1-\sum_i t_i<1,
\qquad
t_i=\frac{\sum_{e=1}^{a_i}p_i^{-e}}{1-\varepsilon_i},
\]
where \(\varepsilon_i\) is the actual mass of the pure \(p_i\)-power classes.

For five prime directions this scalar product bound can exceed one. In Hackmon's April 2026 preprint, the first five odd primes with large exponents give a residual set of exponent configurations (reported as 1.8%) not closed by the first two levels of the weight/Bonferroni argument. Those cases are reduced to the CRT Coverage Maximality inequality below. This is a preprint-level research frontier, not an established theorem.

## 2. Exact inclusion-exclusion split

Let \(L=\prod_{i=1}^5p_i^{a_i}\), and let \(D\) be all divisors \(d>1\) of \(L\). For each d choose one residue class \(C_d\pmod d\). Write
\[
U=\bigcup_{d\in D}C_d.
\]
Let
\[
S=\sum_{d\in D}\frac Ld,\qquad
P_c=\sum_{\substack{d<e\\(d,e)=1}}\frac{L}{de},\qquad
T_c=\sum_{\substack{d<e<f\\\text{pairwise coprime}}}\frac{L}{def},
\]
and \(CB(L)=S-P_c+T_c\). The third Bonferroni inequality gives
\[
|U|\le S-P_c+T_c+NC(L),
\]
where \(NC(L)\) is the signed inclusion-exclusion contribution from subfamilies that contain at least one pair of non-coprime moduli, with incompatible intersections contributing zero.

The desired five-prime maximality statement is
\[
\boxed{NC(L)\le0\quad\text{for every residue assignment}.}
\tag{CM5}
\]
If (CM5) is proved, then the coprime Bonferroni bound is a universal coverage upper bound. In the exceptional exponent patterns where \(CB(L)<L\), this closes the remaining noncoverage argument.

## 3. Pointwise non-coprime correction is not always nonpositive

For a CRT point x, let \(D_x=\{d\in D:x\in C_d\}\). Its pointwise non-coprime correction is
\[
nc(D_x)=
\sum_{\substack{\varnothing\ne T\subseteq D_x\\
T\text{ contains a non-coprime pair}}}
(-1)^{|T|+1}.
\]
Equivalently, if \(G_x\) is the intersection graph on \(D_x\), where two vertices are adjacent when their moduli share a prime, then
\[
nc(D_x)=I(G_x,-1),
\]
where \(I(G,z)\) is the independence polynomial of \(G\).

A five-prime local configuration shows that \(nc(D_x)\le0\) cannot be proved pointwise. Choose five distinct moduli with supports
\[
A=\{p_1,p_2\},\quad E=\{p_2,p_3\},\quad
B=C=D=\{p_4,p_5\},
\]
where B,C,D are made distinct by different exponent vectors, for example
\[
m_A=p_1p_2,\quad m_E=p_2p_3,\quad
m_B=p_4p_5,\quad m_C=p_4^2p_5,\quad m_D=p_4p_5^2.
\]
Choose all five residue classes to contain one common CRT point x. The intersection graph is a disjoint union of one edge and one triangle. Its independence polynomial at -1 is
\[
I(K_2\sqcup K_3,-1)=I(K_2,-1)I(K_3,-1)=(-1)(-2)=2.
\]
Thus
\[
nc(D_x)=2>0.
\]
This is a local obstruction to a pointwise-sign proof. It is not a counterexample to (CM5): the global \(NC(L)\) sums over every CRT point, and the local positive cell can be outweighed by the other cells.

## 4. Pair allocation identity and the actual target

For each non-coprime subset T, let \(e(T)\) be the number of non-coprime pairs inside T. Distribute its signed term equally among those pairs. Then
\[
NC(L)=\sum_{\{d,e\}:\ (d,e)>1}\operatorname{pairNC}(d,e).
\]
For a fixed pair, the summand is a weighted alternating sum over compatible extensions of that pair. The weights depend on the lcm of the full extension and on \(e(T)\). It is not enough to bound the number of overlapping pairs or the maximum degree of the overlap graph.

The local edge-plus-triangle example gives a positive pointwise allocation to its edge, so the useful inequality must be global and retain the exact CRT masses. The prior project notes BBMST_EXACT_COVARIANCE_DECOMPOSITION_2026-10-25.md, BBMST_ORDERED_PAIR_OVERLAP_FRONTIER_2026-10-25.md, and BBMST_OVERLAP_GRAPH_COVARIANCE_ROADMAP_2026-10-25.md provide the exact pair kernel and explain why cardinality-only overlap bounds are insufficient.

## 5. A candidate route for the missing five-prime estimate

For a fixed non-coprime pair P={d,e}, let \(V=\operatorname{supp}(d)\cup\operatorname{supp}(e)\). Since d and e share at least one prime and each is composite, \(|V|\ge3\), so at most two prime coordinates lie outside V.

Split every extension modulus f into:
1. f supported entirely inside V;
2. f with at least one coordinate outside V.

For the second group, the outside-coordinate reciprocal sums are controlled by at most two geometric factors. The first group is governed by compatibility with the common anchor assignment on V. A successful proof would need to show that the signed extension sum for each P, or an aggregate over P, is nonpositive after these two parts are combined.

The exact denominators \(e(T)\) must be retained. Replacing them by 1 is too crude for the alternating sum, and assuming every pair is incompatible is not allowed: pairs with disjoint supports are automatically CRT-compatible, while overlapping supports may be forced compatible by common residues.

A viable proof target is therefore a support-indexed inequality of the form
\[
\sum_{\substack{T\supseteq P\\T\text{ compatible}}}
\frac{(-1)^{|T|+1}}{e(T)\operatorname{lcm}(T)}
\le0
\]
after summing over the actual allowed exponent vectors and all relevant compatibility classes. This formula is a target, not a proved inequality.

## 6. Cross-check against the one-prime necessary condition

The one-prime condition
\[
\Delta(B_q)\le1
\quad\text{or}\quad
\tau(B_q)+\mu(B_q)\ge2q-1
\]
is not enough by itself. For
\[
N=3^4\cdot5^2\cdot7=14175
\]
all three prime directions satisfy the second alternative, and N is abundant:
\[
\sigma(N)=30008>2N=28350.
\]
Nevertheless the coupled survivor product bound gives at least 1988 uncovered residues. This confirms that the correct object is a global joint bound, not the conjunction of independent one-prime tests.

## 7. Literature and verification boundary

- Hackmon's April 2026 preprint proves the four-prime arbitrary-exponent theorem using the same \(R=41/45\) weight-region bound. It reports a five-prime proof for 98.2% of exponent configurations and leaves the remaining cases conditional on (CM5), supported by finite computations. The 9M+ and 28K+ checks are evidence for tested configurations, not a proof of all exponents.
- Balister–Bollobás–Morris–Sahasrabudhe–Tiba (2021) prove the square-free odd-moduli theorem and explain how their sieve handles higher prime powers above 73; the remaining obstruction in that source is repeated small prime factors.
- Schroeder's September 2026 preprint claims at least nine prime divisors for any odd distinct cover, uniformly in prime-power exponents, with a Lean companion. This is a stronger external preprint claim and should be treated as a benchmark until independently reproduced and audited.
- The Erdős Problems page still lists Problem 7 as open.

No complete proof of (CM5), no unrestricted Erdős–Selfridge proof, and no Lean kernel verification are claimed here.
