# DJO² IA — Entwicklungsbaseline 2026-11-27

SPDX-License-Identifier: LicenseRef-DJO2-Proprietary

Angegebener Rechteinhaber eigener Projektbestandteile: Ta-Yoshua Lubuimi.
Alle Rechte vorbehalten. Keine neue Apache-2.0-Lizenzierung eigener Bestandteile.
Bestehende wirksam erteilte Lizenzen und Rechte Dritter bleiben unberührt.

## Referenzstand
- Branch: djo2/worker-context-budget-20261126
- Ausgangscommit: e251c6c55f537453ec837231ea14b5624a7da513
- Letzter bestätigter Funktionstest: a35a3ecb4da3b5795df9ba2f4a62c9f335390af1
- CI: 112 Unit-/Regressionstests und 15 PostgreSQL-Integrationstests bestanden; 0 Fehler, 0 übersprungen.
- Neuere Zustandsmodule noch nicht abgenommen.

## Quellcodebestand
context-step-plan.mjs, context-checkpoint-store.mjs, selfprogram-patch-policy.mjs,
selfprogram-patch-store.sql, selfprogram-patch-store.mjs,
selfprogram-cycle-state.mjs, selfprogram-cycle-store.sql.

## Fortsetzung
Atomarer PostgreSQL-Adapter, persistente Retry-Planung, externe Aktionsreservierung,
Companion-API, isolierter GitHub-Actions-Workflow, Worker-Integration, Live-Test 2166.
Produktivdeployment und Migration bleiben gesperrt bis zur Abnahme.
Zero-Spend: keine zusätzlichen Ausgaben ohne ausdrückliche Freigabe.
Forschungsdateien und bestehende Produktionsdaten bleiben unverändert.
