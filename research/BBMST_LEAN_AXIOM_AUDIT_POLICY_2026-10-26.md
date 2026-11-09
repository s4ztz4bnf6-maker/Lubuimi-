# BBMST Lean axiom audit policy: foundations versus hidden assumptions

Date: 2026-10-26

## Audit correction
A theorem is not automatically invalid because `#print axioms` lists foundational Lean axioms such as `propext`, `Classical.choice`, or `Quot.sound`. Requiring an literally empty axiom list is usually the wrong criterion for a classical Lean theorem. The correct requirement is to identify and classify every dependency and reject unintended theorem-specific assumptions or unsound escape hatches.

## Three-way classification
1. **Foundational dependencies:** the standard logical/classical axioms accepted by the chosen Lean/Mathlib foundation. Report them explicitly and pin the Lean and Mathlib versions.
2. **Declared mathematical assumptions:** hypotheses in the theorem statement or imported parameter structures. These are acceptable only if the source theorem really assumes them and the final claim is worded conditionally when necessary.
3. **Unintended or unsafe dependencies:** theorem-specific axioms standing in for the result (e.g. `sieve_criterion`), `sorryAx`, unsafe escape hatches, unreviewed external axioms, or assumptions that weaken the source statement. These must be eliminated or separately justified.

## Required report
For each central theorem, store:
- the exact `#print axioms` output;
- a transitive dependency report and import/version pin;
- classification of each listed axiom or constant;
- an explicit allowlist for foundational axioms;
- a fail condition for theorem-specific assumptions and `sorryAx`;
- the source-faithfulness audit of the theorem statement.

## Degenerate-case checks remain separate
A clean axiom report does not prevent a vacuous theorem caused by an empty list, totalized division by zero, excluded modulus 1, or an overstrong hypothesis. Those are mathematical statement-fidelity issues and require separate tests.

## Scope
This is an audit policy, not a formal verification result. It does not establish the BBMST theorem or unrestricted Erdős-Selfridge conjecture.