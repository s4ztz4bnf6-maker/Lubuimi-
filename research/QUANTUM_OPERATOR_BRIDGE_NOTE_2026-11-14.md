# Research note: quantum-operator reformulations and arithmetic proof obligations

**Date:** 14 November 2026  
**Research author:** Ta-Yoshua Lubuimi  
**Status:** exploratory parallel direction; not a theorem and not part of the established proof chain.

## 1. Working conclusion

A quantum-mechanical or Hilbert-space reformulation is not, by itself, a route through the open arithmetic bridge in either project. The useful standard is stronger than an analogy: define the space, operator(s), domain, norm or topology, and observable precisely, then prove an equivalence between the target arithmetic statement and a verifiable operator-theoretic property. Without that equivalence and a new estimate that is not merely a restatement, the reformulation changes language but not the proof obligation.

This is a bounded literature statement, not a claim that no such paper could exist. The targeted search below found explicit Collatz analogies and a quantum-inspired algorithmic thesis. It did not locate a quantum-mechanical treatment of the Erdős–Selfridge odd-covering problem. Absence from this search is not proof of nonexistence.

## 2. Collatz: what the existing operator analogy does

Castro Perelman and Carbó-Dorca, “The Collatz conjecture and the quantum mechanical harmonic oscillator,” *Journal of Mathematical Chemistry* 60 (2022), DOI [10.1007/s10910-021-01296-6](https://doi.org/10.1007/s10910-021-01296-6), encode binary expansions as oscillator basis-state combinations and express the even and odd Collatz steps using state-dependent operators built from creation and annihilation operators. The paper itself says that the conjecture is equivalent to a chain-of-operators condition for all starting integers. It also notes that its state-dependent “collapsors” are not projectors in the usual mathematical sense.

The paper therefore supplies an operator dictionary, not an independently established spectral criterion that proves all trajectories reach the ground state. The universal operator identity is equivalent to the original Collatz assertion; verifying it for all inputs remains the hard part.

Inho Choi’s 2025 HKUST master’s thesis, “Quantum-inspired Algorithm for the Collatz Conjecture,” maps finite binary seeds and the (3n+1) iteration to a quantum-circuit representation, with classical matrix-product-state emulation. This is an algorithmic representation and exploration framework, not a proof of global termination.

## 3. A concrete operator test for our Syracuse work

A first exact but deliberately modest model is the standard Collatz map (C:mathbb N_{>0}	omathbb N_{>0}) on the Hilbert space (ell^2(mathbb N_{>0})), with basis (e_n), and the composition operator
[
V e_n=e_{C(n)}.
]
The standard map has at most two immediate preimages per integer, so this basis map is bounded (with (|V|lesqrt 2)). Let
[
H_{mathrm{cyc}}=operatorname{span}{e_1,e_2,e_4}.
]
Then global Collatz termination is exactly the statement
[
orall nge1 exists kge0:quad V^k e_nin H_{mathrm{cyc}}.
]
This is a faithful encoding, but it is currently only a reformulation of the orbit statement. It yields no proof until one establishes a genuinely new operator estimate, invariant, or spectral property forcing every basis vector into (H_{mathrm{cyc}}).

For the accelerated odd Syracuse map, an unweighted basis composition operator needs additional care: a fixed odd target can have infinitely many odd predecessors corresponding to different powers of two. Thus the naive counting-measure operator need not be bounded. A weighted transfer operator, a finite-depth cylinder space, or a probability-space Koopman/transfer construction would need its measure, domain, boundedness, and exact arithmetic correspondence proved first.

### Required success criterion

A useful new construction must do more than encode each orbit. It must prove a statement such as a coercive estimate, a strict Lyapunov decrease, a resolvent/spectral exclusion, or a uniform finite-depth bound, and then show that this estimate implies pointwise entry into (H_{mathrm{cyc}}) for every integer. An average or almost-everywhere statement is insufficient.

## 4. Erdős–Selfridge: a finite exact Hilbert-space encoding

For a proposed finite odd covering system with common period (L=operatorname{lcm}(m_1,ldots,m_r)), work in (mathcal H_L=ell^2(mathbb Z/Lmathbb Z)). Let (A_isubseteqmathbb Z/Lmathbb Z) be the residue class modulo (m_i), lifted to the common period. The diagonal projection onto uncovered residues is
[
P_{mathrm{uncovered}}e_x
=mathbf 1_{{x
otincup_i A_i}}e_x.
]
Then the proposed classes cover all integers exactly when (P_{mathrm{uncovered}}=0); they fail to cover exactly when (P_{mathrm{uncovered}}
e0). Equivalently,
[
|P_{mathrm{uncovered}}mathbf 1|^2
=#igl((mathbb Z/Lmathbb Z)setminuscup_i A_iigr).
]
This is an exact finite encoding, but it is tautological unless one proves a uniform lower bound or a structural spectral/trace inequality forcing the right-hand side to be positive for every admissible odd system.

The relevant odd-covering question remains distinct from the stronger odd-squarefree-modulus theorem proved by Balister–Bollobás–Morris–Sahasrabudhe–Tiba. The Erdős Problems record also lists the general distinct odd-moduli question as open and records the known restrictions that an odd cover, if one exists, must have an LCM divisible by (9) or (15). A targeted search did not locate a quantum-mechanical proof strategy for this problem; do not state this as an exhaustive nonexistence theorem.

### Required success criterion

A useful operator construction must produce a nontrivial lower bound on (operatorname{rank}P_{mathrm{uncovered}}), its trace, or an equivalent quantity that is uniform over all admissible prime-power exponents and residue assignments. Merely representing the finite residue system as a vector space does not handle arbitrary prime powers.

## 5. Parallel research judgement

- **Collatz/Syracuse:** the operator encoding is possible, but the central task remains a pointwise descent or a uniform arithmetic bound on the orbit. The existing oscillator paper makes the target operator identity equivalent to Collatz rather than proving it.
- **Erdős–Selfridge:** finite Hilbert-space encoding is immediate, but the hard part is a uniform positive-uncovered-residue theorem for arbitrary odd moduli and prime-power structure. A trace formula would matter only if it gave a new uniform lower bound.
- **Shared criterion:** do not call a reformulation a proof bridge until the operator statement is (i) precisely defined, (ii) proved equivalent to the target arithmetic statement, and (iii) accompanied by a new estimate that discharges the hard direction.

## 6. Relation to the established projects

This note is parallel and exploratory. It does not modify, replace, weaken, or become a premise of:
- the established APW4 energy argument under its historical hypotheses;
- the existing BBMST/Lean declaration-level results and their exact CI boundaries;
- the established finite Syracuse affine, quotient, and terminal-congruence results.

No new Lean verification or mathematical theorem is claimed here.

## 7. Sources checked

1. C. Castro Perelman and R. Carbó-Dorca, “The Collatz conjecture and the quantum mechanical harmonic oscillator,” *Journal of Mathematical Chemistry* 60 (2022), 145–160. DOI: [10.1007/s10910-021-01296-6](https://doi.org/10.1007/s10910-021-01296-6). Preprint PDF: https://www.rxiv.org/pdf/2103.0158v3.pdf
2. Inho Choi, “Quantum-inspired Algorithm for the Collatz Conjecture,” HKUST master’s thesis (2025). DOI: [10.14711/thesis-hdl152459](https://doi.org/10.14711/thesis-hdl152459).
3. Erdős Problems, “Is there a distinct covering system all of whose moduli are odd?” https://www.erdosproblems.com/7
4. Neel Somani, GPT-Erdos entry for odd covering systems, summarizing Hough–Nielsen and BBMST results: https://www.ocf.berkeley.edu/~neel/erdos.html

---
*Exploratory research note. No claim of a Collatz or Erdős–Selfridge solution.*
