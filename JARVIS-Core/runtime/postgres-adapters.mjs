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
  lastError: r.last_error, result: r.result ?? null, verification: r.verification ?? null
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
      "UPDATE jarvis_runtime_tasks SET task_type=$2,payload=$3::jsonb,priority=$4,status=$5,attempts=$6,max_attempts=$7,updated_at=to_timestamp($8/1000.0),lease_until=CASE WHEN $9::bigint IS NULL THEN NULL ELSE to_timestamp($9/1000.0) END,last_error=$10,result=$11::jsonb,verification=$12::jsonb WHERE task_id=$1 AND status=$13 RETURNING *",
      [t.taskId,t.type,JSON.stringify(t.payload),t.priority,t.status,t.attempts,t.maxAttempts,t.updatedAt,t.leaseUntil,t.lastError,JSON.stringify(t.result ?? null),JSON.stringify(t.verification ?? null),t.expectedStatus ?? t.status]
    );
    if (!rows.length) throw new Error("task missing or concurrently changed during update");
    return taskFromRow(rows[0]);
  }
  async claimNext({ now, leaseUntil }) {
    const rows = await this.sql.unsafe(
      "WITH candidate AS (SELECT task_id FROM jarvis_runtime_tasks WHERE status='queued' AND (lease_until IS NULL OR lease_until <= to_timestamp($1/1000.0)) ORDER BY priority DESC,created_at ASC FOR UPDATE SKIP LOCKED LIMIT 1) UPDATE jarvis_runtime_tasks t SET status='running',attempts=t.attempts+1,lease_until=to_timestamp($2/1000.0),updated_at=to_timestamp($1/1000.0) FROM candidate c WHERE t.task_id=c.task_id RETURNING t.*",
      [now,leaseUntil]
    );
    return taskFromRow(rows[0]);
  }
  async extendLease({ taskId, now, leaseUntil }) {
    const rows = await this.sql.unsafe(
      "UPDATE jarvis_runtime_tasks SET lease_until=to_timestamp($3/1000.0),updated_at=to_timestamp($2/1000.0) WHERE task_id=$1 AND status='running' AND lease_until > to_timestamp($2/1000.0) RETURNING *",
      [taskId,now,leaseUntil]
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
  async get(approvalId) {
    const rows = await this.sql.unsafe("SELECT * FROM jarvis_runtime_approvals WHERE approval_id=$1 LIMIT 1",[approvalId]);
    return rows[0] ?? null;
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


const conversationFromRow = r => r && ({
  conversationId: r.conversation_id,
  taskId: r.task_id,
  participants: r.participants,
  status: r.status,
  activeAgent: r.active_agent,
  version: Number(r.version),
  entries: r.entries,
  createdAt: new Date(r.created_at).getTime(),
  updatedAt: new Date(r.updated_at).getTime()
});

/**
 * Durable conversation store. Every mutation is a single SQL compare-and-set.
 * A null return means the conversation was missing or its version changed.
 */
export class PostgresAgentConversationStore {
  constructor(sql) {
    if (typeof sql?.unsafe !== "function") throw new Error("postgres.js client required");
    this.sql = sql;
  }
  async create(row) {
    if (!row?.conversationId || !row?.taskId || !Array.isArray(row.participants) ||
        !row.participants.length || !Array.isArray(row.entries) ||
        !Number.isSafeInteger(row.version) || row.version !== 0) {
      throw new Error("invalid initial conversation");
    }
    const rows = await this.sql.unsafe(
      "INSERT INTO jarvis_runtime_conversations(conversation_id,task_id,participants,status,active_agent,version,entries,created_at,updated_at) VALUES($1,$2,$3::jsonb,$4,$5,$6,$7::jsonb,now(),now()) RETURNING *",
      [row.conversationId,row.taskId,JSON.stringify(row.participants),row.status,row.activeAgent,row.version,JSON.stringify(row.entries)]
    );
    return conversationFromRow(rows[0]);
  }
  async get(conversationId) {
    const rows = await this.sql.unsafe(
      "SELECT * FROM jarvis_runtime_conversations WHERE conversation_id=$1 LIMIT 1",
      [conversationId]
    );
    return conversationFromRow(rows[0] ?? null);
  }
  async append({ conversationId, expectedVersion, entry }) {
    if (!Number.isSafeInteger(expectedVersion) || expectedVersion < 0 || !entry || typeof entry !== "object") {
      throw new Error("invalid conversation append");
    }
    const rows = await this.sql.unsafe(
      "UPDATE jarvis_runtime_conversations SET entries=entries || jsonb_build_array($3::jsonb),version=version+1,updated_at=now() WHERE conversation_id=$1 AND version=$2 AND status IN ('active','awaiting_user') RETURNING *",
      [conversationId,expectedVersion,JSON.stringify(entry)]
    );
    return conversationFromRow(rows[0] ?? null);
  }
  async setStatus({ conversationId, expectedVersion, status, activeAgent }) {
    if (!Number.isSafeInteger(expectedVersion) || expectedVersion < 0 ||
        !["active","awaiting_user","completed","turn_limit","failed"].includes(status)) {
      throw new Error("invalid conversation status transition");
    }
    const rows = await this.sql.unsafe(
      "UPDATE jarvis_runtime_conversations SET status=$3,active_agent=$4,version=version+1,updated_at=now() WHERE conversation_id=$1 AND version=$2 AND status IN ('active','awaiting_user') RETURNING *",
      [conversationId,expectedVersion,status,activeAgent]
    );
    return conversationFromRow(rows[0] ?? null);
  }
}


const memoryFromRow = r => r && ({
  memoryId: Number(r.memory_id),
  namespace: r.namespace,
  key: r.memory_key,
  value: r.value,
  provenance: r.provenance,
  version: Number(r.version),
  createdBy: r.created_by,
  updatedBy: r.updated_by,
  createdAt: new Date(r.created_at).getTime(),
  updatedAt: new Date(r.updated_at).getTime()
});

const jsonValue = (value, label) => {
  let encoded;
  try { encoded = JSON.stringify(value); } catch { throw new Error(`invalid ${label} JSON value`); }
  if (encoded === undefined) throw new Error(`invalid ${label} JSON value`);
  return encoded;
};

/**
 * Shared namespaced memory with optimistic concurrency and immutable version snapshots.
 * Authorization for namespaces is deliberately delegated to the authenticated host.
 */
export class PostgresAgentMemoryStore {
  constructor(sql) {
    if (typeof sql?.unsafe !== "function") throw new Error("postgres.js client required");
    this.sql = sql;
  }

  async get(namespace, key) {
    if (typeof namespace !== "string" || !namespace || typeof key !== "string" || !key) {
      throw new Error("memory namespace and key required");
    }
    const rows = await this.sql.unsafe(
      "SELECT * FROM jarvis_runtime_memories WHERE namespace=$1 AND memory_key=$2 LIMIT 1",
      [namespace, key]
    );
    return memoryFromRow(rows[0] ?? null);
  }

  async list(namespace, limit = 100) {
    if (typeof namespace !== "string" || !namespace) throw new Error("memory namespace required");
    const boundedLimit = Math.max(1, Math.min(500, Number(limit) || 100));
    const rows = await this.sql.unsafe(
      "SELECT * FROM jarvis_runtime_memories WHERE namespace=$1 ORDER BY updated_at DESC,memory_key ASC LIMIT $2",
      [namespace, boundedLimit]
    );
    return rows.map(memoryFromRow);
  }

  /**
   * expectedVersion=0 creates a key; a positive value updates exactly that version.
   * Returns { ok:true, memory } or { ok:false, conflict:true, current }.
   * The current-row write and immutable snapshot are one SQL statement.
   */
  async put({ namespace, key, value, provenance = {}, actorId, expectedVersion }) {
    if (typeof namespace !== "string" || !namespace || namespace.length > 200 ||
        typeof key !== "string" || !key || key.length > 500 ||
        typeof actorId !== "string" || !actorId ||
        !Number.isSafeInteger(expectedVersion) || expectedVersion < 0 ||
        provenance === null || typeof provenance !== "object" || Array.isArray(provenance)) {
      throw new Error("invalid memory write; namespace, key, actor, provenance and expectedVersion are required");
    }
    const encodedValue = jsonValue(value, "memory");
    const encodedProvenance = jsonValue(provenance, "memory provenance");
    const rows = await this.sql.unsafe(
      "WITH written AS (INSERT INTO jarvis_runtime_memories(namespace,memory_key,value,provenance,version,created_by,updated_by,created_at,updated_at) SELECT $1,$2,$3::jsonb,$4::jsonb,1,$5,$5,now(),now() WHERE $6::bigint=0 ON CONFLICT(namespace,memory_key) DO UPDATE SET value=EXCLUDED.value,provenance=EXCLUDED.provenance,version=jarvis_runtime_memories.version+1,updated_by=EXCLUDED.updated_by,updated_at=now() WHERE jarvis_runtime_memories.version=$6 RETURNING *), snapshot AS (INSERT INTO jarvis_runtime_memory_versions(memory_id,version,value,provenance,actor_id,created_at) SELECT memory_id,version,value,provenance,updated_by,updated_at FROM written RETURNING memory_id) SELECT * FROM written",
      [namespace,key,encodedValue,encodedProvenance,actorId,expectedVersion]
    );
    if (rows.length) return { ok:true, memory:memoryFromRow(rows[0]) };

    const current = await this.get(namespace, key);
    await this.sql.unsafe(
      "INSERT INTO jarvis_runtime_memory_conflicts(namespace,memory_key,expected_version,actual_version,attempted_value,attempted_provenance,actor_id) VALUES($1,$2,$3,$4,$5::jsonb,$6::jsonb,$7)",
      [namespace,key,expectedVersion,current?.version ?? null,encodedValue,encodedProvenance,actorId]
    );
    return { ok:false, conflict:true, current };
  }

  async history(namespace, key, limit = 100) {
    if (typeof namespace !== "string" || !namespace || typeof key !== "string" || !key) {
      throw new Error("memory namespace and key required");
    }
    const boundedLimit = Math.max(1, Math.min(500, Number(limit) || 100));
    const rows = await this.sql.unsafe(
      "SELECT v.memory_id,v.version,v.value,v.provenance,v.actor_id,v.created_at FROM jarvis_runtime_memory_versions v JOIN jarvis_runtime_memories m ON m.memory_id=v.memory_id WHERE m.namespace=$1 AND m.memory_key=$2 ORDER BY v.version DESC LIMIT $3",
      [namespace,key,boundedLimit]
    );
    return rows.map(r => ({
      memoryId:Number(r.memory_id), version:Number(r.version), value:r.value,
      provenance:r.provenance, actorId:r.actor_id, createdAt:new Date(r.created_at).getTime()
    }));
  }
}
