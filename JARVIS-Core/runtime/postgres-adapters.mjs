/**
 * PostgreSQL adapters for JARVIS Autonomous Agent Runtime.
 * Expects a postgres.js client (the same client used by the Worker).
 */
const taskFromRow = (r) => r && ({
  taskId: r.task_id, type: r.task_type, payload: r.payload, priority: r.priority,
  idempotencyKey: r.idempotency_key, status: r.status, attempts: r.attempts,
  maxAttempts: r.max_attempts, createdAt: new Date(r.created_at).getTime(),
  updatedAt: new Date(r.updated_at).getTime(),
  leaseUntil: r.lease_until ? new Date(r.lease_until).getTime() : null,
  lastError: r.last_error
});

export class PostgresTaskStore {
  constructor(sql) { if (typeof sql?.unsafe !== "function" || typeof sql?.begin !== "function") throw new Error("postgres.js client required"); this.sql = sql; }
  async insert(t) {
    await this.sql.unsafe(
      "INSERT INTO jarvis_runtime_tasks(task_id,task_type,payload,priority,idempotency_key,status,attempts,max_attempts,created_at,updated_at,lease_until,last_error) VALUES($1,$2,$3::jsonb,$4,$5,$6,$7,$8,to_timestamp($9/1000.0),to_timestamp($10/1000.0),NULL,NULL)",
      [t.taskId,t.type,JSON.stringify(t.payload),t.priority,t.idempotencyKey,t.status,t.attempts,t.maxAttempts,t.createdAt,t.updatedAt]
    );
  }
  async get(taskId) { const rows = await this.sql.unsafe("SELECT * FROM jarvis_runtime_tasks WHERE task_id=$1",[taskId]); return taskFromRow(rows[0]); }
  async findByIdempotencyKey(key) { const rows = await this.sql.unsafe("SELECT * FROM jarvis_runtime_tasks WHERE idempotency_key=$1",[key]); return taskFromRow(rows[0]); }
  async update(t) {
    const rows = await this.sql.unsafe(
      "UPDATE jarvis_runtime_tasks SET task_type=$2,payload=$3::jsonb,priority=$4,status=$5,attempts=$6,max_attempts=$7,updated_at=to_timestamp($8/1000.0),lease_until=CASE WHEN $9::bigint IS NULL THEN NULL ELSE to_timestamp($9/1000.0) END,last_error=$10 WHERE task_id=$1 RETURNING *",
      [t.taskId,t.type,JSON.stringify(t.payload),t.priority,t.status,t.attempts,t.maxAttempts,t.updatedAt,t.leaseUntil,t.lastError]
    );
    if (!rows.length) throw new Error("task not found during update");
    return taskFromRow(rows[0]);
  }
  async claimNext({ now, leaseUntil }) {
    const rows = await this.sql.unsafe(
      "WITH candidate AS (SELECT task_id FROM jarvis_runtime_tasks WHERE status='queued' AND (lease_until IS NULL OR lease_until <= to_timestamp($1/1000.0)) ORDER BY priority DESC,created_at ASC FOR UPDATE SKIP LOCKED LIMIT 1) UPDATE jarvis_runtime_tasks t SET status='running',attempts=t.attempts+1,lease_until=to_timestamp($2/1000.0),updated_at=to_timestamp($1/1000.0) FROM candidate c WHERE t.task_id=c.task_id RETURNING t.*",
      [now,leaseUntil]
    );
    return taskFromRow(rows[0]);
  }
  async recoverExpired(now) {
    const rows = await this.sql.unsafe(
      "UPDATE jarvis_runtime_tasks SET status=CASE WHEN attempts >= max_attempts THEN 'failed' ELSE 'queued' END,lease_until=NULL,last_error=COALESCE(last_error,'Worker lease expired; task recovered'),updated_at=to_timestamp($1/1000.0) WHERE status='running' AND lease_until <= to_timestamp($1/1000.0) RETURNING *",
      [now]
    );
    return rows.map(taskFromRow);
  }
}

export class PostgresApprovalStore {
  constructor(sql) { if (typeof sql?.unsafe !== "function" || typeof sql?.begin !== "function") throw new Error("postgres.js client required"); this.sql = sql; }
  async create(a) {
    const rows = await this.sql.unsafe(
      "INSERT INTO jarvis_runtime_approvals(approval_id,task_id,agent_id,action,reason,status,expires_at,created_at) VALUES($1,$2,$3,$4,$5,$6,$7,to_timestamp($8/1000.0)) RETURNING *",
      [a.approvalId,a.taskId,a.agentId,a.action,a.reason,a.status,a.expiresAt ? new Date(a.expiresAt) : null,a.createdAt]
    );
    return rows[0];
  }
  async resolve({ approvalId, decision, reviewerId, resolvedAt }) {
    const rows = await this.sql.unsafe(
      "UPDATE jarvis_runtime_approvals SET status=$2,reviewer_id=$3,resolved_at=to_timestamp($4/1000.0) WHERE approval_id=$1 AND status='pending' AND (expires_at IS NULL OR expires_at>now()) RETURNING *",
      [approvalId,decision,reviewerId,resolvedAt]
    );
    if (!rows.length) throw new Error("approval missing, expired, or already resolved");
    return rows[0];
  }
}

export class PostgresRuntimeAudit {
  constructor(sql) { if (typeof sql?.unsafe !== "function") throw new Error("postgres.js client required"); this.sql = sql; }
  async append({ event, actorId = null, taskId = null, ...details }) {
    await this.sql.unsafe(
      "INSERT INTO jarvis_runtime_audit(event_type,actor_id,task_id,details) VALUES($1,$2,$3,$4::jsonb)",
      [String(event),actorId,taskId,JSON.stringify(details)]
    );
  }
}

export class PostgresRuntimeMessageStore {
  constructor(sql) { if (typeof sql?.unsafe !== "function") throw new Error("postgres.js client required"); this.sql = sql; }
  async append(message) {
    const rows = await this.sql.unsafe(
      "INSERT INTO jarvis_runtime_messages(message_id,task_id,sender_agent_id,recipient_agent_id,message_type,payload,created_at) VALUES($1,$2,$3,$4,$5,$6::jsonb,to_timestamp($7/1000.0)) RETURNING message_id",
      [message.messageId,message.taskId,message.from,message.to,message.type,JSON.stringify(message.payload),message.createdAt]
    );
    return rows[0].message_id;
  }
  async listForTask(taskId, limit = 100) {
    const rows = await this.sql.unsafe(
      "SELECT message_id AS \"messageId\",task_id AS \"taskId\",sender_agent_id AS \"from\",recipient_agent_id AS \"to\",message_type AS type,payload,created_at AS \"createdAt\" FROM jarvis_runtime_messages WHERE task_id=$1 ORDER BY created_at ASC LIMIT $2",
      [taskId,Math.max(1,Math.min(500,Number(limit)||100))]
    );
    return rows;
  }
}

/** Atomic persistent token/cost accounting. Limits must be finite and explicit. */
export class PostgresAgentBudget {
  constructor(sql) { if (typeof sql?.unsafe !== "function") throw new Error("postgres.js client required"); this.sql = sql; }
  async consume(agentId, { tokens = 0, cost = 0 }, limits) {
    if (!agentId || !Number.isSafeInteger(tokens) || tokens < 0 || !Number.isFinite(cost) || cost < 0 ||
        !Number.isSafeInteger(limits?.tokens) || limits.tokens < 0 || !Number.isFinite(limits?.cost) || limits.cost < 0) {
      throw new Error("explicit finite agent budget and valid usage required");
    }
    const rows = await this.sql.unsafe(
      "INSERT INTO jarvis_runtime_agent_usage(agent_id,tokens_used,cost_used,updated_at) VALUES($1,$2,$3,now()) ON CONFLICT(agent_id) DO UPDATE SET tokens_used=jarvis_runtime_agent_usage.tokens_used+EXCLUDED.tokens_used,cost_used=jarvis_runtime_agent_usage.cost_used+EXCLUDED.cost_used,updated_at=now() WHERE jarvis_runtime_agent_usage.tokens_used+EXCLUDED.tokens_used <= $4 AND jarvis_runtime_agent_usage.cost_used+EXCLUDED.cost_used <= $5 RETURNING agent_id,tokens_used,cost_used",
      [agentId,tokens,String(cost),limits.tokens,String(limits.cost)]
    );
    if (!rows.length) {
      const current = await this.sql.unsafe("SELECT tokens_used,cost_used FROM jarvis_runtime_agent_usage WHERE agent_id=$1",[agentId]);
      return { allowed:false, usage:current[0] ?? {tokens_used:0,cost_used:"0"}, reason:"agent budget exceeded" };
    }
    return { allowed:true, usage:rows[0] };
  }
}
