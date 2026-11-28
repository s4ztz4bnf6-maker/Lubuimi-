// Altbestand der Warteschlange bereinigen, ohne etwas zu löschen: jede Änderung wird protokolliert und ist umkehrbar. Standard: Trockenlauf.
const RETRYABLE = new Set(["rate_limit", "overloaded", "timeout", "context_budget", "no_result", "providers_exhausted", "bad_output", "unknown"]);

/**
 * rows: [{ id, status, created_at, department, dedupe_key, has_evidence, attempts, failure_class }]  (per SELECT mit Aliasen aus Ihrer Tabelle)
 * activeDepartments: Set der aktivierten Abteilungen. Rückgabe: Plan [{ id, from, action, reason, delayMinutes? }]
 * Schutz: Aufgaben mit Nachweis oder laufende werden nie angefasst.
 */
export function planTriage(rows, { now = Date.now(), activeDepartments, staleDays = 14, maxAttempts = 3, perHour = 20 } = {}) {
  const plan = [], done = new Set();
  const push = (r, action, reason, extra = {}) => { plan.push({ id: r.id, from: r.status, action, reason, ...extra }); done.add(r.id); };
  const isProtected = (r) => r.has_evidence || r.status === "running";

  const groups = new Map();
  for (const r of rows) if (r.dedupe_key) { if (!groups.has(r.dedupe_key)) groups.set(r.dedupe_key, []); groups.get(r.dedupe_key).push(r); }
  for (const g of groups.values()) {
    if (g.length < 2) continue;
    const keep = [...g].sort((a, b) => (Number(b.has_evidence) - Number(a.has_evidence)) || (Date.parse(b.created_at) - Date.parse(a.created_at)))[0];
    for (const r of g) if (r !== keep && !isProtected(r)) push(r, "archive", "Duplikat");
  }

  let retryIndex = 0;
  for (const r of rows) {
    if (done.has(r.id) || isProtected(r)) continue;
    if (r.department && !activeDepartments.has(r.department)) { push(r, "park", "Abteilung nicht aktiviert"); continue; }
    if (r.status === "failed") {
      if ((r.attempts ?? 0) < maxAttempts && RETRYABLE.has(r.failure_class ?? "unknown")) push(r, "requeue", "kontrollierte Wiederholung", { delayMinutes: Math.floor(retryIndex++ / perHour) * 60 });
      else if (["auth", "unknown_outcome"].includes(r.failure_class)) push(r, "owner", `Eigentümer prüfen (${r.failure_class})`);
      else push(r, "archive", "zu oft gescheitert");
      continue;
    }
    if (r.status === "queued" && (r.attempts ?? 0) === 0 && now - Date.parse(r.created_at) > staleDays * 86_400_000) push(r, "archive", `älter als ${staleDays} Tage, nie gestartet`);
  }
  return plan;
}

export const summarize = (plan) => plan.reduce((o, p) => ((o[p.action] = (o[p.action] ?? 0) + 1), o), {});

/**
 * applyTriage(sql, { table, statusCol, idCol, nextRunCol?, protectedStatuses?: ["running"], statuses: { archive, park, requeue, owner } }, plan, { dryRun = true })
 * Sicherheiten: eine Transaktion je Block, Advisory-Lock gegen parallele Bereinigung, Zeilen werden mit FOR UPDATE SKIP LOCKED gesperrt,
 * der Status wird UNTER der Sperre erneut geprüft (nur wenn er noch dem Plan entspricht und nicht geschützt ist, wird geändert).
 * Jede Änderung steht mit altem Status in djo2_triage_log. Nichts wird gelöscht.
 */
export async function applyTriage(sql, cfg, plan, { dryRun = true, batch = 200 } = {}) {
  const summary = summarize(plan);
  if (dryRun) return { dryRun: true, summary };
  const protectedStatuses = cfg.protectedStatuses ?? ["running"];
  await sql`CREATE TABLE IF NOT EXISTS djo2_triage_log (batch_id text, task_id text, old_status text, new_status text, action text, reason text, at timestamptz DEFAULT now(), rolled_back boolean DEFAULT false)`;
  const batchId = String(Date.now()), buckets = new Map();
  for (const p of plan) { const k = JSON.stringify([p.action, p.delayMinutes ?? 0, p.reason]); if (!buckets.has(k)) buckets.set(k, []); buckets.get(k).push(p); }
  let applied = 0, skipped = 0;
  for (const [k, items] of buckets) {
    const [action, delay, reason] = JSON.parse(k); const newStatus = cfg.statuses[action];
    for (let i = 0; i < items.length; i += batch) {
      const chunk = items.slice(i, i + batch), expected = new Map(chunk.map((x) => [String(x.id), x.from]));
      const res = await sql.begin(async (tx) => {
        await tx`SELECT pg_advisory_xact_lock(hashtext('djo2_triage'))`;
        const locked = await tx`SELECT ${tx(cfg.idCol)} AS id, ${tx(cfg.statusCol)} AS status FROM ${tx(cfg.table)}
                                WHERE ${tx(cfg.idCol)} = ANY(${tx.array(chunk.map((x) => x.id))}) FOR UPDATE SKIP LOCKED`;
        const ok = locked.filter((r) => expected.get(String(r.id)) === r.status && !protectedStatuses.includes(r.status)).map((r) => r.id);
        if (!ok.length) return { done: 0, skipped: chunk.length };
        await tx`INSERT INTO djo2_triage_log (batch_id, task_id, old_status, new_status, action, reason)
                 SELECT ${batchId}, ${tx(cfg.idCol)}::text, ${tx(cfg.statusCol)}::text, ${newStatus}, ${action}, ${reason}
                 FROM ${tx(cfg.table)} WHERE ${tx(cfg.idCol)} = ANY(${tx.array(ok)})`;
        if (action === "requeue" && cfg.nextRunCol)
          await tx`UPDATE ${tx(cfg.table)} SET ${tx(cfg.statusCol)} = ${newStatus}, ${tx(cfg.nextRunCol)} = now() + make_interval(mins => ${Number(delay)}) WHERE ${tx(cfg.idCol)} = ANY(${tx.array(ok)})`;
        else
          await tx`UPDATE ${tx(cfg.table)} SET ${tx(cfg.statusCol)} = ${newStatus} WHERE ${tx(cfg.idCol)} = ANY(${tx.array(ok)})`;
        return { done: ok.length, skipped: chunk.length - ok.length };
      });
      applied += res.done; skipped += res.skipped;
    }
  }
  return { dryRun: false, batchId, summary, applied, skipped };
}

export async function rollbackTriage(sql, cfg, batchId) {
  await sql.begin(async (tx) => {
    await tx`UPDATE ${tx(cfg.table)} t SET ${tx(cfg.statusCol)} = l.old_status FROM djo2_triage_log l
             WHERE l.batch_id = ${batchId} AND NOT l.rolled_back AND l.task_id = t.${tx(cfg.idCol)}::text AND t.${tx(cfg.statusCol)}::text = l.new_status`;   // nur zurück, wenn seither unverändert
    await tx`UPDATE djo2_triage_log SET rolled_back = true WHERE batch_id = ${batchId}`;
  });
}
