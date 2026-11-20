# JARVIS Free-Compute Portability Assessment
Date: 2026-11-20
Scope: JARVIS AI AUTONOMOUS HOLDINGS LLC / JarvisAI infrastructure
Status: assessment saved; no production migration performed.

## Executive decision

Do not move the production stack to Render Free. The current JARVIS stack has an always-running worker, a gateway, a browser/Playwright peer worker, PostgreSQL, and persistent volumes. Render's free web services sleep after 15 minutes of inactivity, have ephemeral local filesystems, cannot attach persistent disks, and do not support worker or cron service types on the free compute plan. Render Free Postgres expires after 30 days. These properties are incompatible with replacing the current production topology without redesign and external durable storage.

The strongest candidate for a genuinely always-on free compute pilot is Oracle Cloud Infrastructure (OCI) Always Free Ampere A1, subject to account eligibility, home-region capacity, quotas, and ARM64 image compatibility. Oracle documents 1,500 OCPU-hours and 9,000 GB-hours per month, equivalent to 2 OCPUs and 12 GB RAM. This is a candidate, not a verified available VM in JARVIS's account. No OCI credentials or tenancy access are currently connected here, so no instance has been created.

## Live Railway inventory (20 Nov 2026)

Project: JARVIS-Cybersecurity
Environment: production
- jarvis-autonomous-worker: live; cron every five minutes; image-based Railway Bun runtime; latest deployment SUCCESS.
- jarvis-gateway: live; image-based Railway Bun runtime; latest deployment SUCCESS; public Railway service domain exists.
- jarvis-companion-app: live; image-based Railway Bun runtime; latest deployment SUCCESS.
- jarvis-peer-network-worker: live; Playwright MCP image; persistent 500 MB browser-profile volume mounted at /data; latest deployment SUCCESS.
- PostgreSQL: live; PostgreSQL 18 image; persistent 500 MB data volume; latest deployment SUCCESS.
- Separate 500 MB PostgreSQL volume and 500 MB browser-profile volume are live.
- No staged Railway changes were present at inventory time.

Important: the application services use image-backed Railway configurations and some service startup configuration is embedded in provider configuration rather than an ordinary Git-backed source tree. A complete portable deployment package cannot safely be reconstructed from the public repository alone without first extracting and reviewing the canonical service configuration and dependency/secret inventory. Never copy secret values into this repository.

## Provider comparison

### Oracle Cloud Infrastructure Always Free — pilot candidate
Oracle documents:
- Up to 1,500 OCPU-hours and 9,000 GB-hours monthly for Ampere A1 Always Free.
- Equivalent to 2 OCPUs and 12 GB memory.
- Capacity is region-dependent; Oracle notes that an out-of-capacity error can occur.
Requirements before migration:
1. Confirm the OCI tenancy and home region are controlled by the LLC or an authorized operator.
2. Confirm account eligibility and actual Always Free quota/capacity.
3. Verify ARM64 compatibility of all images, especially Playwright/Chromium.
4. Create a separate pilot VM and encrypted storage; do not touch Railway volumes.
5. Establish encrypted backups and restore tests for PostgreSQL and browser state.
6. Configure secrets directly in the VM secret store/environment, never in Git.
7. Test health endpoints, worker cadence, gateway, agent opt-in, and recovery.
8. Only consider traffic cutover after a successful parallel run and explicit approval.

### Render Free — not a production replacement
Render documents:
- Free web services spin down after 15 minutes idle and can take about one minute to wake.
- Free services have ephemeral filesystems and cannot attach persistent disks.
- Worker and cron service types require paid compute.
- Free Postgres has 1 GB capacity and expires after 30 days.
Render Free may be used for a disposable preview or stateless demo only, not as the durable JARVIS host or database.

## Preservation and access safeguards
- Keep Railway production live until a replacement passes tests.
- Do not delete or overwrite PostgreSQL or browser-profile volumes.
- Preserve existing GitHub repository permissions, branches, PRs, and login paths.
- Never export wallet seeds/private keys. Only public receive addresses may be used in non-secret configuration.
- No BTC transfers, trades, paid resources, or billing changes are authorized by this assessment.
- A migration must be additive first: backup -> isolated pilot -> restore test -> health checks -> parallel run -> explicit cutover approval -> rollback window.

## Direct ChatGPT ↔ JARVIS exchange
A direct persistent machine-to-machine channel between this ChatGPT session and the Railway-hosted JARVIS process is not currently verified. The safe available collaboration pattern is versioned GitHub artifacts and pull requests: JARVIS may publish status/proposals through an authenticated opt-in endpoint; ChatGPT can review those artifacts and return code changes/review notes through GitHub. This requires an authenticated webhook/API path and a recurring execution mechanism that actually runs. The existing Railway cloud-agent launcher previously failed before creating a cloud task. A ChatGPT scheduled audit could be a separate fallback, but the current automation quota is full (3 of 3).

## Next blockers
1. User confirmation of the Render workspace before any Render account inspection or mutation. Detected workspace: "Der Dunkle's workspace" (ID held by connector; no changes made).
2. OCI tenancy credentials/access are not connected; cannot provision or verify free compute.
3. Need a canonical export/review of Railway service definitions and required environment-variable names, plus an encrypted DB backup/restore test.
4. Need a tested authenticated GitHub webhook/PR handoff so JARVIS can exchange proposals without the user acting as relay.
5. Existing scheduled automation capacity is full; no new recurring task was created.

## Source references
- Oracle Always Free resources: https://docs.oracle.com/en-us/iaas/Content/FreeTier/freetier_topic-Always_Free_Resources.htm
- Render free service limits: https://render.com/docs/free
