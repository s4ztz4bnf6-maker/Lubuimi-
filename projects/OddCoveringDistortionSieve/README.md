# Odd Covering Systems and Distortion Sieve Research

**Research author:** Ta-Yoshua Lubuimi  
**Status:** Active research record. Finite CRT identities and examples are exact; the universal private-mass and global spectral bounds remain open.

This project studies distinct odd covering systems through exact CRT fibres, compatibility graphs, collision moments, and private residue mass.

## Established finite facts

- For L=15, the divisor-density sum is 1/3+1/5+1/15=3/5.
- On Ω=Z/30Z, the classes A1={x:x=0 mod 3}, A2={x:x=0 mod 5}, A3={x:x=1 mod 15} have a private set for A3 of exactly {1,16}, hence size 2.
- For L=945=3^3·5·7, the divisor set D={3,5,7,9,15,21,27,35,45,63,105,135,189,315,945} has exact density sum 65/63. The sum over coprime unordered pairs is exactly 74/315. The pairwise-coprime triple contribution is exactly 13/945, from three triples.
- For a modulus m_i added to an existing LCM L_T, the growth ratio is R(i|T)=m_i/gcd(m_i,L_T). If all moduli are odd and R>1, then R≥3.

## Main open target

The quantitative private-mass lower bound g(L)>0 and a universal Ψ/discrepancy estimate remain open. Pairwise intersection estimates alone do not control all higher intersections. The project does not claim the odd distinct covering conjecture is solved.

A standalone Lean project in `lean/` is being audited for these exact finite L945 moments; it is not yet marked verified. See MANUSCRIPT.md for the exact definitions, finite examples, structural leads and open proof obligations; WRITTEN_REVIEW.md separates exact results from conditional or unreconstructed claims.
