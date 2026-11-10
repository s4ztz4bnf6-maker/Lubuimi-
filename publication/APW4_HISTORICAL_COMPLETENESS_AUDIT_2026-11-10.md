# APW4 historical completeness and formalization audit

**Author and research lead:** Ta-Yoshua Lubuimi  
**Audit date:** 10 November 2026  
**Status:** proof-record continuity preserved; full source-to-Lean integration remains open.

## 1. Direct answer: is every historical ingredient already reconstructed and formally closed?

**No—not in the repository's current independently auditable Lean integration.** This is a statement about the current source-reconstruction and formalization boundary. It does not retract the author's established mathematical APW4 proof record or the independently finalized manuscript.

The APW4 dossier records the following mathematical chain as established under the stated historical APW4 hypotheses:

\[
\mathcal E_{APW4}=D_{APW4}+C_{APW4},\qquad
D_{APW4}\le D_k^{BBMST},\qquad
C_{APW4}\le\mathcal R_{BIB},
\]
together with the strict lower-bound implication
\[
B(M)=2M-\sigma(M)\le0
\Longrightarrow
\mathcal E_{APW4}>D_k^{BBMST}+\mathcal R_{BIB}.
\]
The contradiction follows in that stated regime. This mathematical status is preserved.

## 2. What the published BBMST source reconstruction supplies

The source reconstruction maps the published BBMST square-free-moduli proof chain, including its geometric reduction, sieve/fibre and moment machinery, and finite certificates. It distinguishes published BBMST objects and lemmas from APW4-specific claims.

It does **not**, by itself, reconstruct or prove the following APW4-specific interfaces:

1. The exact historical source and target domains of the index-preserving map
   \((x,u)\mapsto(k,I_{x,u},J_{x,u})\), including all admissibility and multiplicity conditions.
2. The full original event definitions and their relation to \(B_q,V_q,F_q,P_{q,x,h},M_{q,r},\Gamma_{q,r}\), and the historical \(W_{q,r}/a_{q,t}\) data.
3. The actual weighted Hall demand and BIB slot-capacity relation, with a proved allocation preserving the original indices and weights.
4. The construction of the APW4 diagonal and off-diagonal Lean terms from those historical objects, rather than passing the DT/HT inequalities as hypotheses.
5. The strict lower-bound proof wired to the same historical data and hypotheses in the final theorem's transitive dependency closure.

The source reconstruction explicitly warns that unweighted CRT incidence counts are not the weighted APW4 BIB reserve. They cannot be substituted for it.

## 3. Formal verification boundary

The successful APW4 declaration-scoped checks remain valid for their exact commits and dependency scopes. In particular, the canonical arithmetic contradiction declaration formalizes the final implication from the energy decomposition, diagonal estimate, Hall estimate and strict lower bound supplied as inputs. It does not construct those inputs from the full historical APW4 definitions.

The integrated BBMST/APW4 PR #69 remains a separate Lean 4.35 integration effort. Its prefix-dependent fibre recursion is not yet verified on the current recorded head. Error-recovery output containing `sorryAx` is not accepted as proof evidence. No successful integrated `lake check --paranoid` is claimed.

## 4. Required closure checklist

- [ ] Publish a line-by-line historical definition ledger with primary-source/page references for every APW4 object used.
- [ ] Give the exact domains, codomains, admissibility predicates and inverse/uniqueness facts for the historical diagonal index map.
- [ ] Prove diagonal weight preservation and the DT estimate from the original APW4 data.
- [ ] Define the historical off-diagonal event-to-BIB-slot relation without changing event indices.
- [ ] Prove weighted Hall demand is bounded by the actual BIB capacities; keep diagonal mass, off-diagonal mass and pair reserve distinct.
- [ ] Reconstruct the strict lower-bound derivation with every historical hypothesis explicit.
- [ ] Build one final Lean theorem whose arguments are instantiated from these historical definitions, not supplied as abstract assumptions.
- [ ] Run exact-head full build and `lake check --paranoid`; print transitive axioms for the final theorem and all critical intermediates; reject project axioms and `sorryAx`.
- [ ] Reconcile every Lean definition against the manuscript and primary sources; record any genuine discrepancy rather than silently changing either side.

## 5. No-regression and licensing policy

This audit is additive. It does not replace, weaken, or downgrade the APW4 mathematical proof record, manuscript, prior successful declaration-scoped CI results, or historical definitions. Failed integrated builds remain attached to their exact commits.

The existing proprietary and commercial-use notices remain in force. This audit creates no new license and does not alter third-party licenses. Original APW4 research and authorship remain attributed to Ta-Yoshua Lubuimi; AI tools are assistants only.

## 6. Next technical priority

First finish the source-indexed dependent prefix/fibre recursion on PR #69 without placeholders. Then formalize the historical APW4 index map and weighted BIB/Hall allocation as separate named interfaces. Only after those exact interfaces are constructed should the final energy contradiction be instantiated from historical APW4 data.

**Conclusion:** APW4's mathematical proof record is preserved as established by its author. The repository does not yet demonstrate that every historical definition, transport, weighted capacity statement and strict lower-bound premise is independently reconstructed and wired into one axiom-clean Lean theorem. That is the remaining formal/source-fidelity completion task.
