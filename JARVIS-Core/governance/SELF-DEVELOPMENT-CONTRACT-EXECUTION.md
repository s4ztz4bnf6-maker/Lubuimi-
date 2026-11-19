# JARVIS self-development and delegated contract execution

This workstream adds two separate capabilities:

1. Bounded self-development: JARVIS may inspect, plan, edit in an isolated workspace, run tests/static analysis, and open PRs without per-step permission.
2. Delegated contract execution: JARVIS may execute a contract only as an authorized software agent acting for a verified real legal person, within a verified and current mandate.

## What this does not do

- It does not make JARVIS a legal person or company.
- It does not establish that any claimed company exists.
- It does not appoint a manager, director, representative, or agent.
- It does not issue a signature credential or qualified electronic seal.
- It does not connect the policy functions to the production Companion/Worker dispatch path.
- It does not merge or deploy anything.

## Contract execution prerequisites

The evaluator fails closed unless the evidence contains:
- authoritative proof of the contracting legal person's identity and current status;
- proof of the natural-person representative's authority;
- a valid delegation instrument expressly authorizing JARVIS/software agents to perform the requested action;
- legal review that the delegation is valid for the governing law and contract type;
- exact permitted actions and counterparty types;
- a commitment cap and matching currency;
- an unexpired mandate;
- verified counterparty checks;
- a verified execution credential bound to the authorized signer;
- transaction approval if required by the mandate or applicable law.

An electronic seal is an integrity/origin mechanism for a legal person; it does not by itself express consent, supply representative authority, or replace a valid signature/acceptance. The module models a seal with separate valid acceptance accordingly.

## Self-development boundary

Autonomous code work is limited to an isolated development workspace and approved paths. Secret/credential access and changes to owner access are blocked. Merge and production deployment require a separate explicit approval.

## Integration work still required

The module is deliberately standalone. Before it can govern actual actions, integrate it into the Companion and Worker task-dispatch/action-execution paths, source the evidence from authenticated registry/mandate/provider records, add tamper-evident audit events, and test every route. Do not populate verification flags from user text or agent assertions alone.
