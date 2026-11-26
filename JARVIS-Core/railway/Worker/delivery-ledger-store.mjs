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
