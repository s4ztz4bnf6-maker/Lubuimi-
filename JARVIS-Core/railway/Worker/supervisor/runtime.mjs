// No new license grant; see JARVIS-Core/LICENSE-CORRECTION.md.
import {departments,evaluate} from "./central-supervisor.mjs";
export async function initializeCaos(sql){
 await sql`CREATE TABLE IF NOT EXISTS djo2_agent_reports (
 id BIGSERIAL PRIMARY KEY, task_id TEXT NOT NULL, department TEXT NOT NULL,
 status TEXT NOT NULL, evidence JSONB NOT NULL DEFAULT '{}',
 idempotency_key TEXT UNIQUE NOT NULL, created_at TIMESTAMPTZ NOT NULL DEFAULT now())`;
}
export async function recoverCaosEvents(sql){
 return sql`UPDATE djo2_events SET state=CASE
 WHEN payload->>'action' IN ('discover','evaluate','research') THEN 'queued'
 ELSE 'review' END, lease_until=NULL
 WHERE kind='caos-task' AND state='running' AND lease_until<=now()
 RETURNING id,state,fence`;
}
export async function runCaosCycle(sql,handlers){
 await recoverCaosEvents(sql);
 const results=[];
 for(const department of departments){
  const handler=handlers[department];
  if(typeof handler!=="function")continue;
  const rows=await sql`UPDATE djo2_events SET state='running',fence=fence+1,lease_until=now()+interval '5 minutes'
   WHERE id=(SELECT id FROM djo2_events WHERE department=${department} AND kind='caos-task' AND state='queued' ORDER BY id FOR UPDATE SKIP LOCKED LIMIT 1) RETURNING *`;
  for(const event of rows){
   let status="review", evidence={reason:"policy_or_handler_failure"};
   try{
    // Only read-only actions are enabled until trusted execution adapters exist.
    if(["discover","evaluate","research"].includes(event.payload.action)&&evaluate(event.payload.action).allowed){
     evidence=await handler(event.payload.action);status="done";
    }
   }catch{evidence={reason:"handler_error"};}
   const committed=await sql.begin(async tx=>{
    const locked=await tx`SELECT id FROM djo2_events WHERE id=${event.id} AND fence=${event.fence} AND state='running' AND lease_until>now() FOR UPDATE`;
    if(!locked.length)return false;
    await tx`INSERT INTO djo2_agent_reports(task_id,department,status,evidence,idempotency_key) VALUES (${event.correlation_id},${department},${status},${tx.json(evidence)},${event.event_key+":"+event.fence}) ON CONFLICT DO NOTHING`;
    await tx`UPDATE djo2_events SET state=${status},lease_until=NULL WHERE id=${event.id} AND fence=${event.fence}`;
    return true;
   });
   if(committed)results.push({department,status});
  }
 }
 return results;
}
