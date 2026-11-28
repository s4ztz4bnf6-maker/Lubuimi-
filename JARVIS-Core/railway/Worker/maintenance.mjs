// Lesende Diagnose und kontrollierte Bereinigung OHNE direkten SQL-Zugriff auf Produktion.
// Der Worker startet mit DJO2_MAINTENANCE=<modus>, schreibt das Ergebnis als JSON ins Railway-Log und BEENDET sich (verarbeitet keine Aufgaben).
// Modi: diagnose | triage-dry | triage-apply (braucht DJO2_TRIAGE_CONFIRM=<digest aus triage-dry>) | task:<id>
// Danach die Variablen wieder entfernen.
import { createHash } from "node:crypto";
import { planTriage, summarize, applyTriage } from "./queueTriage.mjs";

export const planDigest = (plan) => createHash("sha256").update(plan.map((p) => `${p.id}:${p.action}`).sort().join("\n")).digest("hex").slice(0, 16);

/** rows: [{ id, status, created_at, department, dedupe_key, has_evidence, attempts, failure_class, next_run_at, lease_active }] – per cfg.selectRows (ADAPT) */
export function diagnose(rows, { activeDepartments, now = Date.now(), claimableStatuses = ["queued"] }) {
  const byStatus = {}, byDept = new Map();
  let inactive = 0, waiting = 0, leased = 0, claimable = 0;
  for (const r of rows) {
    byStatus[r.status] = (byStatus[r.status] ?? 0) + 1;
    const active = !r.department || activeDepartments.has(r.department);
    const k = r.department ?? "(ohne)"; const d = byDept.get(k) ?? { department: k, active, count: 0 }; d.count++; byDept.set(k, d);
    const future = r.next_run_at && Date.parse(r.next_run_at) > now;
    if (!active) inactive++; if (future) waiting++; if (r.lease_active) leased++;
    if (claimableStatuses.includes(r.status) && active && !future && !r.lease_active) claimable++;
  }
  return { total: rows.length, claimableNow: claimable, inactiveDepartment: inactive, waitingForFutureRun: waiting, leasedNow: leased, byStatus,
    topDepartments: [...byDept.values()].sort((a, b) => b.count - a.count).slice(0, 10) };
}

export const parseMode = (env) => env.DJO2_MAINTENANCE?.trim() || null;

export async function runMaintenance({ sql, mode, confirm, cfg, activeDepartments, log = console.log, apply = applyTriage, now = Date.now() }) {
  if (!mode) return { ran: false };
  if (mode.startsWith("task:")) {
    const id = Number(mode.slice(5)); if (!Number.isInteger(id)) throw new Error("MAINTENANCE_BAD_TASK_ID");
    log(JSON.stringify({ maintenance: mode, task: await cfg.describeTask(sql, id) }));          // nur Status/Zähler, keine Inhalte
    return { ran: true };
  }
  const rows = await cfg.selectRows(sql);
  if (mode === "diagnose") { log(JSON.stringify({ maintenance: mode, ...diagnose(rows, { activeDepartments, now }) })); return { ran: true }; }
  if (mode === "triage-dry" || mode === "triage-apply") {
    const plan = planTriage(rows, { now, activeDepartments }); const digest = planDigest(plan);
    if (mode === "triage-dry") { log(JSON.stringify({ maintenance: mode, digest, summary: summarize(plan), sample: plan.slice(0, 15) })); return { ran: true, digest }; }
    if (!confirm || confirm !== digest) throw new Error(`MAINTENANCE_CONFIRM_MISMATCH: erwartet ${digest} (zuerst triage-dry ausführen und den Digest prüfen)`);
    const res = await apply(sql, cfg, plan, { dryRun: false });
    log(JSON.stringify({ maintenance: mode, digest, batchId: res.batchId, summary: res.summary, applied: res.applied, skipped: res.skipped }));
    return { ran: true, digest, batchId: res.batchId };
  }
  throw new Error(`MAINTENANCE_UNKNOWN_MODE: ${mode}`);
}
