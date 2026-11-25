// No new license grant.
export async function reconcileSubmission(sql,eventId,adapter){
 if(typeof adapter?.verifySubmission!=="function")return {state:"review"};
 const [event]=await sql`SELECT * FROM djo2_events WHERE id=${eventId} AND kind='caos-task' AND state='review' AND payload->>'action'='submit'`;
 if(!event)return {state:"unavailable"};
 const receipt=await adapter.verifySubmission(event.event_key);
 if(receipt?.verified!==true||receipt.eventKey!==event.event_key||typeof receipt.externalRef!=="string"||!receipt.externalRef.trim())return {state:"review"};
 return sql.begin(async tx=>{
 const rows=await tx`UPDATE djo2_events SET state='done' WHERE id=${event.id} AND state='review' AND fence=${event.fence} RETURNING id`;
 if(!rows.length)return {state:"unchanged"};
 await tx`INSERT INTO djo2_agent_reports(task_id,department,status,evidence,idempotency_key) VALUES (${event.correlation_id},${event.department},'done',${tx.json({externalRef:receipt.externalRef,verified:true})},${event.event_key+":reconciled"}) ON CONFLICT DO NOTHING`;
 return {state:"done"};
 });
}
