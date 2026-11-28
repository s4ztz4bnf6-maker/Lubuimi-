<!-- SPDX-License-Identifier: LicenseRef-DJO2-Proprietary -->
# DJO² IA — verbindlicher Entwicklungscheckpoint 2026-11-28

Eigentümeranspruch: Ta-Yoshua Lubuimi, soweit eigene bzw. wirksam erworbene Rechte vorliegen. Eigener DJO² IA Code: LicenseRef-DJO2-Proprietary Rev. 2; keine Apache-2.0-Neulizenzierung. Fremdrechte und erforderliche Lizenzhinweise bleiben erhalten.

Produktionsbasis: f5ece2a96ef377013b03ed4c05ef7c294e71664f; PR #262; Railway deployment fbb7c2e0-f0bb-44c7-8b30-07818c54ce7f SUCCESS. Entwicklungs-CI 10/10, Produktions-CI 6/6. PR #260 crash/resume E2E und #261 read-only maintenance bleiben erhalten. 

## Verifizierter Live-Befund
4826 Aufgaben: 2065 completed, 1847 queued, 568 failed, 341 candidate, 5 retry_wait. 1851 erfüllen den Diagnosefilter, 240 attempts_exhausted (überlappende Kategorie), 1 waiting, 0 running. Worker meldet trotzdem no queued tasks. Aufgabe 2115 failed, 3/3 attempts. Keine Rücksetzung oder Triage freigegeben. SGL discovery: zwei Timeouts, keine verifizierten Leads.

## Erhaltungsregeln
- Bestehende Funktionen, Companion/PWA/Voice, Worker, Gateway, Peer Worker, SGL, Agent-Auth, Zero-Spend, Provider-Rotation, Kontextbudget, Aufgabenzerlegung, persistente Checkpoints, Idempotenz, Netzwerkisolation und Tests nicht entfernen.
- PostgreSQL einschließlich agent_memory, conversations, messages, voice_transcripts, task contexts, checkpoints, step results, audit and financial records schützen; keine Löschung, Reset oder destruktive Migration. Existenz einzelner Tabellen und vollständiges Backup separat verifizieren.
- Originale maintenance.mjs und queueTriage.mjs unverändert erhalten; Schreibmodi nicht freigegeben.
- Keine zusätzlichen Ressourcen, Ausgaben, Vorkasse oder unautorisierte externe Aktionen. Keine Forschungsdateien verändern.
- Nächster Schritt: claimDbTransaction, Admission-Trigger und UPDATE RETURNING prüfen; read-only Diagnose vor Reparatur, isolierte PostgreSQL-Regression, CI, Deployment, Live-Abnahme.
- Dieser Git-Checkpoint sichert den Quellcode und dokumentierten Zustand, nicht den vollständigen Inhalt der laufenden Datenbank oder ChatGPT-Gedächtnis. Datenbankbackup separat nachweisen; keine Secrets ins Repo.
