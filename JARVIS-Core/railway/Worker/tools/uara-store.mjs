// SPDX-License-Identifier: LicenseRef-DJO2-Proprietary
import {canResumeJob} from "./uara-policy.mjs";
export async function initUara(sql) {
 await sql`CREATE TABLE IF NOT EXISTS djo2_uara_jobs (
 id TEXT PRIMARY KEY, platform_id TEXT NOT NULL, subject_ref TEXT NOT NULL,
 task_id BIGINT NOT NULL, state TEXT NOT NULL DEFAULT 'pending',
 external_account_id TEXT, updated_at TIMESTAMPTZ NOT NULL DEFAULT now(),
 UNIQUE(task_id,platform_id,subject_ref))`;
}
export async function enqueueUara(sql, job) {
 if (!job.id || !job.platformId || !job.subjectRef || !Number.isSafeInteger(job.taskId) || job.taskId<=0) throw new Error("invalid job");
 return sql`INSERT INTO djo2_uara_jobs(id,platform_id,subject_ref,task_id)
 VALUES(${job.id},${job.platformId},${job.subjectRef},${job.taskId})
 ON CONFLICT DO NOTHING RETURNING id`;
}
// Call only with a receipt verified by a trusted platform adapter, never model output.
export async function recordVerifiedReceipt(sql, job, receipt) {
 if (!canResumeJob(receipt,job)) throw new Error("receipt mismatch");
 return sql`UPDATE djo2_uara_jobs SET state='account_verified',
 external_account_id=${receipt.externalAccountId},updated_at=now()
 WHERE id=${job.id} AND platform_id=${job.platformId} AND subject_ref=${job.subjectRef}
 AND state='pending' RETURNING task_id`;
}
