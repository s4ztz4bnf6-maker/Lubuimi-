import test from "node:test";
import assert from "node:assert/strict";
import { PostgresTaskStore, PostgresApprovalStore, PostgresRuntimeAudit, PostgresRuntimeMessageStore, PostgresAgentBudget } from "../runtime/postgres-adapters.mjs";

function fakeSql(handler) {
  const calls=[];
  return { calls, unsafe: async (query, params=[]) => { calls.push({query,params}); return handler(query,params); }, begin: async fn => fn({unsafe: async (...args) => fakeSql.unsafe(...args)}) };
}

test("Postgres task claims are atomic, priority ordered and increment attempts", async () => {
  const sql=fakeSql(async (q) => q.includes("WITH candidate") ? [{
    task_id:"t1",task_type:"research",payload:{q:"x"},priority:9,idempotency_key:"once",status:"running",
    attempts:1,max_attempts:3,created_at:new Date(0),updated_at:new Date(1),lease_until:new Date(60000),last_error:null
  }] : []);
  const store=new PostgresTaskStore(sql);
  const claimed=await store.claimNext({now:1,leaseUntil:60000});
  assert.equal(claimed.taskId,"t1");
  assert.equal(claimed.attempts,1);
  assert.match(sql.calls[0].query,/FOR UPDATE SKIP LOCKED/);
  assert.match(sql.calls[0].query,/ORDER BY priority DESC/);
});

test("Postgres task recovery requeues expired tasks or exhausts their attempts in SQL", async () => {
  const sql=fakeSql(async q => q.startsWith("UPDATE jarvis_runtime_tasks SET status=CASE") ? [] : []);
  const store=new PostgresTaskStore(sql);
  await store.recoverExpired(1000);
  assert.match(sql.calls[0].query,/attempts >= max_attempts THEN 'failed' ELSE 'queued'/);
});

test("approval resolution is pending-only and rejects expired approvals", async () => {
  const sql=fakeSql(async q => q.startsWith("UPDATE jarvis_runtime_approvals") ? [{approval_id:"a1",status:"approved"}] : []);
  const store=new PostgresApprovalStore(sql);
  const result=await store.resolve({approvalId:"a1",decision:"approved",reviewerId:"human-1",resolvedAt:1000});
  assert.equal(result.status,"approved");
  assert.match(sql.calls[0].query,/status='pending'/);
  assert.match(sql.calls[0].query,/expires_at IS NULL OR expires_at>now()/);
});

test("audit and message adapters persist structured JSON payloads", async () => {
  const sql=fakeSql(async () => [{message_id:"m1"}]);
  const audit=new PostgresRuntimeAudit(sql);
  await audit.append({event:"task.started",taskId:"t1",actorId:"agent-a",attempt:1});
  const messages=new PostgresRuntimeMessageStore(sql);
  assert.equal(await messages.append({messageId:"m1",taskId:"t1",from:"a",to:"b",type:"result",payload:{ok:true},createdAt:1}),"m1");
  assert.equal(sql.calls.length,2);
  assert.match(sql.calls[0].query,/jarvis_runtime_audit/);
  assert.match(sql.calls[1].query,/jarvis_runtime_messages/);
});

test("persistent budget accounting uses a conditional atomic upsert", async () => {
  const sql=fakeSql(async q => q.startsWith("INSERT INTO jarvis_runtime_agent_usage") ? [{agent_id:"a",tokens_used:10,cost_used:"0.01"}] : []);
  const budget=new PostgresAgentBudget(sql);
  const result=await budget.consume("a",{tokens:10,cost:0.01},{tokens:100,cost:0.1});
  assert.equal(result.allowed,true);
  assert.match(sql.calls[0].query,/ON CONFLICT(agent_id) DO UPDATE/);
  assert.match(sql.calls[0].query,/tokens_used\+EXCLUDED.tokens_used <= \$4/);
  await assert.rejects(budget.consume("a",{tokens:1,cost:0},{tokens:Infinity,cost:0.1}),/explicit finite/);
});
