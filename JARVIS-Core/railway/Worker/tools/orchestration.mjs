// SPDX-License-Identifier: Apache-2.0
export async function initializeOrchestration(sql) {
 await sql`CREATE TABLE IF NOT EXISTS djo2_events (
 id BIGSERIAL PRIMARY KEY, event_key TEXT UNIQUE NOT NULL,
 correlation_id TEXT NOT NULL, department TEXT NOT NULL,
 kind TEXT NOT NULL, payload JSONB NOT NULL,
 state TEXT NOT NULL DEFAULT 'queued' CHECK(state IN ('queued','running','done','review')),
 fence BIGINT NOT NULL DEFAULT 0, lease_until TIMESTAMPTZ,
 created_at TIMESTAMPTZ NOT NULL DEFAULT now()
 )`;
 await sql`CREATE INDEX IF NOT EXISTS djo2_events_queue ON djo2_events(department,state,id)`;
}
export async function publishEvent(sql,e) {
 return sql`INSERT INTO djo2_events(event_key,correlation_id,department,kind,payload)
 VALUES (${e.key},${e.correlationId},${e.department},${e.kind},${sql.json(e.payload)})
 ON CONFLICT(event_key) DO NOTHING RETURNING id`;
}
export async function claimEvent(sql,department) {
 return sql`UPDATE djo2_events SET state='running', fence=fence+1, lease_until=now()+interval '5 minutes'
 WHERE id=(SELECT id FROM djo2_events WHERE department=${department} AND state='queued'
 ORDER BY id FOR UPDATE SKIP LOCKED LIMIT 1) RETURNING *`;
}
export async function finishEvent(sql,id,fence) {
 return sql`UPDATE djo2_events SET state='done',lease_until=NULL WHERE id=${id} AND fence=${fence}
 AND state='running' AND lease_until>now() RETURNING id`;
}
export async function reconcileExpired(sql) {
 return sql`UPDATE djo2_events SET state='review',lease_until=NULL WHERE state='running' AND lease_until<=now() RETURNING id`;
}
