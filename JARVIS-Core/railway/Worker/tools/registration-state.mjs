// SPDX-License-Identifier: Apache-2.0
export async function initializeRegistration(sql) {
 await sql`CREATE TABLE IF NOT EXISTS djo2_registration (
 request_key TEXT PRIMARY KEY, task_ref TEXT NOT NULL,
 platform TEXT NOT NULL, grant_ref TEXT NOT NULL,
 state TEXT NOT NULL DEFAULT 'policy_review',
 account_ref TEXT, evidence_ref TEXT,
 updated_at TIMESTAMPTZ NOT NULL DEFAULT now(),
 CHECK(state IN ('policy_review','authorized','submitted','email_pending','human_required','verified','blocked'))
 )`;
}
const transitions = {
 policy_review:['authorized','blocked'],
 authorized:['submitted','blocked'],
 submitted:['email_pending','human_required','verified','blocked'],
 email_pending:['verified','human_required','blocked'],
 human_required:['verified','blocked'],
 verified:[],blocked:[]
};
export async function advanceRegistration(sql,key,from,to,evidenceRef) {
 if (!transitions[from]?.includes(to)) throw new Error('invalid registration transition');
 if (typeof evidenceRef !== 'string' || !evidenceRef.trim()) throw new Error('evidence reference required');
 return sql`UPDATE djo2_registration SET state=${to}, evidence_ref=${evidenceRef},updated_at=now()
 WHERE request_key=${key} AND state=${from} RETURNING request_key,state`;
}
// Only approved platform adapters may submit registrations. Credentials belong
// in a restricted secret store, never in event payloads or this table.
// CAPTCHA, identity checks and mandatory human verification require handoff.
