// SPDX-License-Identifier: LicenseRef-DJO2-Proprietary
// Database-only reservation; never authorizes or executes delivery.
export async function reserveDelivery(sql, {idempotencyKey,bountyId,repo,issueNumber}) {
 if (![idempotencyKey,bountyId,repo].every(x=>typeof x==="string"&&x.trim()) || !Number.isSafeInteger(issueNumber)||issueNumber<1) throw Error("INVALID_DELIVERY_RESERVATION");
 return sql.begin(async tx=>{
  const [created]=await tx`INSERT INTO bounty_deliveries(idempotency_key,bounty_id,upstream_repo,issue_number) VALUES(${idempotencyKey},${bountyId},${repo},${issueNumber}) ON CONFLICT (idempotency_key) DO NOTHING RETURNING *`;
  if(created)return {status:"registered",record:created};
  const [existing]=await tx`SELECT * FROM bounty_deliveries WHERE idempotency_key=${idempotencyKey}`;
  if(!existing||existing.bounty_id!==bountyId||existing.upstream_repo!==repo||existing.issue_number!==issueNumber)throw Error("DELIVERY_IDEMPOTENCY_MISMATCH");
  return {status:"existing",record:existing};
 });
}

// Resolve only a current server-side authorization. Model input is never an identity source.
export async function resolveAuthorizedDeliveryIdentity(sql,taskId,repo,issueNumber,action,payloadSha256) {
 if(!Number.isSafeInteger(Number(taskId))||Number(taskId)<1||!/^[-\w.]+\/[-\w.]+$/.test(repo)||!Number.isSafeInteger(issueNumber)||issueNumber<1||!["claim","deliver"].includes(action)||! /^[a-f0-9]{64}$/.test(payloadSha256))throw Error("INVALID_DELIVERY_IDENTITY");
 const [row]=await sql`SELECT repo,issue_number,eligibility_evidence FROM djo2_delivery_authorizations WHERE task_id=${taskId} AND repo=${repo} AND issue_number=${issueNumber} AND action=${action} AND payload_sha256=${payloadSha256} AND revoked_at IS NULL AND expires_at>NOW()`;
 if(!row||typeof row.eligibility_evidence?.bounty_id!=="string"||!row.eligibility_evidence.bounty_id.trim())throw Error("VERIFIED_BOUNTY_IDENTITY_REQUIRED");
 return {bountyId:row.eligibility_evidence.bounty_id,repo:row.repo,issueNumber:row.issue_number};
}
