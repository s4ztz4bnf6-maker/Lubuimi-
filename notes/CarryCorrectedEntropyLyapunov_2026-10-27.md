# Carry entropy is a hypothesis generator, not yet a Lyapunov proof

Date: 2026-10-27  
Status: research specification; no global Collatz claim.

## Exact block identity

For the accelerated odd map (T(n)=(3n+1)/2^{v_2(3n+1)}), fix a realized valuation word (w=(a_0,ldots,a_{m-1})). Let (A=sum_j a_j), and let (C) be its affine offset. Then
[
2^A T^m(n)=3^m n+C.
]
For positive (n), this gives the exact logarithmic drift
[
lograc{T^m(n)}{n}
=mlog 3-Alog 2+
logleft(1+rac{C}{3^m n}ight).
]
Thus strict descent is equivalent to
[
(Alog 2-mlog 3)>
logleft(1+rac{C}{3^m n}ight).
]
The correction term is positive. Consequently, (2^A>3^m) alone is necessary for descent but is not sufficient: the affine offset must also be controlled relative to (n).

## Proposed project-specific object: carry-corrected block potential

The proposed candidate is not raw bit entropy. It is an exact block defect
[
Delta(w,n)=Alog 2-mlog 3-
logleft(1+rac{C(w)}{3^m n}ight).
]
Then (Delta(w,n)>0) iff (T^m(n)<n). The integer/carry data (C(w)) is retained instead of discarded by a pseudo-randomness approximation. A second layer may record a finite residue state (s) and try a corrected potential
[
V(n,s)=log n+phi(s),
]
but a proof must exhibit a rigorously bounded (phi) and prove that every nonterminal orbit has a realized block with (V) decreasing. The existence of such a (phi) is an open proof obligation, not an assumption.

## Why entropy alone does not close the gap

1. The parity/valuation word of a fixed integer is deterministic, not an independent random sample.
2. Typical or natural-density-one behavior does not imply a bound for every admissible word.
3. Binary multiplication by 3 has exact carry dependencies. “Mixing” or “pseudo-randomness” must be replaced by a proved discrepancy/forbidden-word theorem strong enough to control every relevant orbit.
4. A finite-state model at a fixed modulus sees only a finite prefix of 2-adic information. It cannot, without a uniform extension argument, exclude an exceptional integer whose valuation itinerary avoids the sampled patterns forever.

A rigorous entropy route would therefore need a theorem of the form: every integer-realizable valuation word of sufficiently large length satisfies an explicit lower bound on (Alog 2-mlog 3), together with a matching upper bound on the offset term. No such bound is proved here.

## A falsifiable research protocol

- Enumerate realized words at small lengths and calculate (A), (C), (D=2^A-3^m), and (Delta(w,n)) exactly/rationally where possible.
- Search for words with (D>0) but (Deltale0); these are direct counterexamples to the proposed “(2^A>3^m) implies descent” shortcut.
- Separate all words from integer-realizable words using exact congruence/valuation constraints.
- If proposing a finite-state correction (phi), solve the corresponding inequalities on the graph, then test whether every transition and every relevant word is covered. A finite graph result is only as strong as its proved correspondence to all integers.
- Formalize the exact affine identity and the implication (Delta>0Rightarrow T^m(n)<n) in Lean before claiming a Lyapunov theorem.

## Novelty and status

The logarithmic drift identity is a direct consequence of the established affine formula; it is not a new theorem. The project-specific research direction is to preserve the exact carry offset inside a block potential and treat entropy only as a candidate for bounding the offset/valuation deficit. This avoids turning a random-walk heuristic into a universal claim. The key unresolved step is a deterministic bound valid for every integer-realizable itinerary.
