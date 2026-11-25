# JARVIS bounded self-improvement workflow

JARVIS can become more capable by proposing source changes, writing tests, executing tests in isolated runners, reviewing the diff, and opening a draft pull request. This is the first safe, auditable engineering loop—not unrestricted self-modification.

## Loop
1. Describe a specific capability gap and measurable acceptance tests.
2. Search the source tree and read relevant code before editing.
3. Create a feature branch; never modify the production branch directly.
4. Write code and regression tests in an isolated workspace.
5. Run unit tests, syntax checks, static analysis, and dependency/security checks.
6. Produce a diff summary, test logs and risk notes.
7. Open a draft PR for review.
8. Merge and deploy only after explicit authorized review; verify health and rollback readiness.

## What remains human-controlled
- Production deployments and rollbacks.
- Credential, wallet, permission, identity, policy or security changes.
- Payments, calls/SMS, account creation, contracts, purchases and other external effects.
- PR merge, release and production migrations.

## AI capability growth
Model quality, tools, context, memory retrieval, parallel workers, task decomposition, test coverage and verified code execution can improve. The agent cannot self-upgrade its underlying foundation model weights simply by editing this repository. Model-provider, compute and account limits still apply.

## Neutrality and accountability
A system may analyze viewpoints impartially and distinguish facts from preferences. It should not be configured as "morally neutral" in the sense of removing safety, consent, legal compliance, authorization, or accountability controls. These controls protect the operator and other people.

## Status
Policy module is a small decision gate. It does not yet execute a complete autonomous coding loop, create sandboxes, or connect to production routes.
