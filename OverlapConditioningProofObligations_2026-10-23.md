# Overlap conditioning: exact finite-product proof obligations

Status: proof specification only. This note does not claim that the BBMST
second-moment estimate or the Erdős–Selfridge theorem has been proved.

## Finite-product identity to formalize

Let I be a finite coordinate set, let each coordinate i have a finite
state space Ω i with a probability mass p i, and use the corresponding
independent product mass on assignments. Let S and T be supports of two
cylinder events, whose predicates depend only on coordinates in S and T.
Set U = S ∩ T, S' = S \\ U, and T' = T \\ U.

The safe identity is obtained by conditioning on the shared assignment
z on U:

  mass(E_S ∩ E_T) = Σ_z mass_U(z)
      * mass_{S'}(E_S restricted at z)
      * mass_{T'}(E_T restricted at z).

The summands are valid because S' and T' are disjoint and disjoint from
U; after fixing z, the two residual predicates live on disjoint
coordinate blocks. The formula must be instantiated using the actual
finite product mass and cylinder predicates, rather than postulated as an
independence rule for arbitrary events.

## Required Lean proof sequence

1. Define restriction of a cylinder predicate to a shared-coordinate
   assignment, keeping dependent coordinate types explicit.
2. Prove the assignment equivalence between a full assignment on S ∪ T
   and a compatible triple consisting of an assignment on U, one on S',
   and one on T'.
3. Prove the corresponding finite sum reindexing lemma, including the
   empty-support cases.
4. Factor each product weight under that equivalence using the appropriate
   finite-product identity.
5. Derive the displayed identity by a finite-sum equivalence, not by
   assuming independence of overlapping events.
6. As a corollary, recover mass(E_S ∩ E_T) = mass(E_S) * mass(E_T)
   when S ∩ T = ∅.
7. Only then connect the identity to the actual BBMST hyperplane events
   and dependency relation. The source-specific moment bounds in
   Theorem 3.2 remain separate obligations.

## Audit guardrails

- No sorry, admit, or new axiom is permitted.
- Do not infer the BBMST moment estimate from the disjoint case alone.
- Test empty S, empty T, and S = T explicitly.
- Include #print axioms for the final identity and the disjoint-support
  corollary in the executable Lean test module.
- A successful build would certify only these finite-product identities;
  it would not certify the source-specific geometric or arithmetic estimates.
