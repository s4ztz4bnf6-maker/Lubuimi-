# Syracuse drift spectrum: an exact Fourier encoding and its proof obligation

Date: 2026-10-27

## Motivation

The requested acoustic/musical analogy is made precise here as a finite signal on the valuation word. The Fourier transform is only a change of coordinates; it is not assumed to create randomness or a descent theorem. The point is to expose exactly which spectral statement would be sufficient and which familiar spectral facts are insufficient.

## Exact log-drift signal

For an accelerated odd trajectory
\[
x_{j+1}=\frac{3x_j+1}{2^{a_j}},\qquad a_j=v_2(3x_j+1),
\]
define the real increment
\[
d_j=a_j-\log_2 3-\log_2\!\left(1+\frac{1}{3x_j}\right).
\]
Then the identity is exact:
\[
\log_2\frac{x_N}{x_0}=-\sum_{j=0}^{N-1}d_j.
\]
Consequently, ordinary-size divergence \(x_N\to\infty\) requires
\[
\sum_{j<N}d_j\longrightarrow-\infty.
\]
This is a necessary condition, not a contradiction.

## Finite acoustic encoding

For a block of length L, let \(d=(d_0,\ldots,d_{L-1})\) and define its discrete Fourier coefficients
\[
\widehat d(r)=\sum_{j=0}^{L-1}d_j e^{-2\pi i rj/L},
\qquad r=0,\ldots,L-1.
\]
The zero-frequency coefficient is exactly
\[
\widehat d(0)=\sum_{j<L}d_j.
\]
Parseval's identity measures total squared signal energy, but it does not control the sign of \(\widehat d(0)\). A large high-frequency energy or a visually noise-like spectrum therefore cannot exclude a growing orbit.

## Proposed certificate: a one-sided low-frequency barrier

A rigorous anti-divergence route would need a uniform theorem about every realized valuation/carry block, such as
\[
\sum_{j=i}^{i+L-1}d_j\ge -B
\]
for all i and all L, with a constant B independent of the trajectory; this would prevent the cumulative sum from tending to negative infinity. A stronger positive block bound would imply descent. The key challenge is to derive such a bound from exact arithmetic constraints on realizable valuation words, not from a random-bit model or observed spectral statistics.

A more flexible state-dependent target is
\[
\sum_{j=i}^{i+L-1}d_j\ge -\Psi(\mathcal S_{i,L}),
\]
where \(\mathcal S_{i,L}\) is a finite-horizon carry/valuation state. To be useful, \(\Psi\) must be composable across adjacent blocks and bounded in the way required to rule out cumulative negative drift.

## Falsification protocol

1. Enumerate exact starting residues for increasing finite horizons and compute the valuation word and d-signal with interval arithmetic for logarithms.
2. Search for candidate lower bounds on the zero-frequency coefficient, stratified by carry-state.
3. Reject any candidate violated by one realizable finite orbit segment.
4. Only after a candidate survives, formulate a universal finite-state inequality and prove it in Lean with exact rational/logarithmic bounds or certified intervals.
5. Do not use Parseval, spectral smoothness, entropy, or density-one results as a substitute for the universal one-sided barrier.

## Status

This is a research proposal, not a claimed new theorem and not a proof of Collatz. It converts the acoustic analogy into a precise certificate-search problem while ruling out the invalid inference that a noise-like spectrum forces descent.
