// SPDX-License-Identifier: LicenseRef-DJO2-Proprietary
import { test } from 'node:test';
import assert from 'node:assert/strict';
import { readFile } from 'node:fs/promises';
import postgres from 'postgres';
import { reserveDelivery, resolveAuthorizedDeliveryIdentity } from '../../delivery-ledger-store.mjs';

test('real admission trigger: parallel overflow and recovery', async () => {
  const url = new URL(process.env.DATABASE_URL ?? 'postgres://postgres:postgres@localhost:5432/djo2_test');
  assert.equal(url.pathname, '/djo2_test');
  assert.ok(['localhost','127.0.0.1'].includes(url.hostname));
  const sql = postgres(url.toString(), {max: 12});
  const schema = 'admission_test_' + process.pid + '_' + Date.now();
  try {
    await sql.unsafe('CREATE SCHEMA ' + schema);
    const migration = await readFile(new URL('../../003_admission.sql', import.meta.url), 'utf8');
    const source = await readFile(new URL('../../index.ts', import.meta.url), 'utf8');
    const trigger = source.match(/await sql\.unsafe\(`(CREATE OR REPLACE FUNCTION djo2_guard_task_admission\(\)[\s\S]*?END \$djo2\$;)`\)/)?.[1];
    assert.ok(trigger, 'production trigger must be extracted');
    await sql.begin(async tx => {
      await tx.unsafe('SET LOCAL search_path TO ' + schema + ', public');
      await tx.unsafe(migration.replace(/^\s*BEGIN\s*;/i,'').replace(/COMMIT\s*;\s*$/i,''));
      await tx.unsafe(trigger);
      await tx.unsafe("CREATE TABLE agent_tasks(id BIGSERIAL PRIMARY KEY,title text NOT NULL,prompt text NOT NULL,status text NOT NULL DEFAULT 'queued',error text,attempt_count int NOT NULL DEFAULT 0,max_attempts int NOT NULL DEFAULT 3,next_retry_at timestamptz,started_at timestamptz)");
      await tx.unsafe('CREATE TRIGGER admission BEFORE INSERT OR UPDATE OF status ON agent_tasks FOR EACH ROW EXECUTE FUNCTION djo2_guard_task_admission()');
    });
    const run = fn => sql.begin(async tx => {
      await tx.unsafe('SET LOCAL search_path TO ' + schema + ', public');
      return fn(tx);
    });
    await run(tx => tx`INSERT INTO agent_tasks(title,prompt) SELECT 'fixture','fixture' FROM generate_series(1,50)`);
    const overflow = await Promise.all(Array.from({length:10}, () => run(async tx => {
      const [row] = await tx`INSERT INTO agent_tasks(title,prompt) VALUES ('overflow','fixture') RETURNING *`;
      return row;
    })));
    for (const row of overflow) {
      assert.equal(row.status,'retry_wait');
      assert.equal(row.attempt_count,0);
      assert.equal(row.started_at,null);
      assert.ok(row.next_retry_at);
    }
    const [count] = await run(tx => tx`SELECT count(*)::int AS n FROM agent_tasks WHERE status IN ('queued','running')`);
    assert.equal(count.n,50);
    const id = overflow[0].id;
    const [blocked] = await run(tx => tx`UPDATE agent_tasks SET status='running' WHERE id=${id} RETURNING *`);
    assert.equal(blocked.status,'retry_wait');
    assert.equal(blocked.attempt_count,0);
    await run(tx => tx`UPDATE agent_tasks SET status='completed' WHERE id=(SELECT min(id) FROM agent_tasks WHERE status='queued')`);
    const [promoted] = await run(tx => tx`UPDATE agent_tasks SET status='running' WHERE id=${id} RETURNING *`);
    assert.equal(promoted.status,'running');
    assert.equal(promoted.attempt_count,0);
    const ledger = await readFile(new URL('../../delivery-ledger.sql', import.meta.url), 'utf8');
    await run(tx => tx.unsafe(ledger));
    const insertDelivery = () => run(tx => tx`INSERT INTO bounty_deliveries(idempotency_key,bounty_id,upstream_repo,issue_number) VALUES ('fixture-key','fixture','fixture/repo',1)`);
    const deliveries = await Promise.allSettled([insertDelivery(),insertDelivery()]);
    assert.equal(deliveries.filter(x => x.status === 'fulfilled').length,1);
    assert.equal(deliveries.find(x => x.status === 'rejected').reason.code,'23505');
    const duplicate = await run(tx => tx`INSERT INTO bounty_deliveries(idempotency_key,bounty_id,upstream_repo,issue_number) VALUES ('fixture-key','fixture','fixture/repo',1) ON CONFLICT (idempotency_key) DO NOTHING RETURNING id`);
    assert.equal(duplicate.length,0);
    const [existing] = await run(tx => tx`SELECT bounty_id,upstream_repo,issue_number,delivery_status FROM bounty_deliveries WHERE idempotency_key='fixture-key'`);
    assert.equal(existing.bounty_id,'fixture');
    assert.equal(existing.upstream_repo,'fixture/repo');
    assert.equal(existing.issue_number,1);
    assert.equal(existing.delivery_status,'pending');
    const resolverSql = (strings,...values) => run(tx=>tx(strings,...values));
    const hash='a'.repeat(64);
    await run(tx=>tx`INSERT INTO djo2_delivery_authorizations(task_id,repo,issue_number,action,payload_sha256,eligibility_evidence,expires_at,revoked_at) VALUES
      (101,'fixture/repo',2,'claim',${hash},'{"bounty_id":"verified-fixture"}'::jsonb,NOW()+INTERVAL '1 hour',NULL),
      (102,'fixture/repo',2,'claim',${hash},'{"bounty_id":"expired"}'::jsonb,NOW()-INTERVAL '1 hour',NULL),
      (103,'fixture/repo',2,'claim',${hash},'{"bounty_id":"revoked"}'::jsonb,NOW()+INTERVAL '1 hour',NOW()),
      (104,'fixture/repo',2,'claim',${hash},'{}'::jsonb,NOW()+INTERVAL '1 hour',NULL)`);
    const resolve=(...args)=>resolveAuthorizedDeliveryIdentity(resolverSql,...args);
    assert.deepEqual(await resolve(101,'fixture/repo',2,'claim',hash),{bountyId:'verified-fixture',repo:'fixture/repo',issueNumber:2});
    for(const args of [[102,'fixture/repo',2,'claim',hash],[103,'fixture/repo',2,'claim',hash],[104,'fixture/repo',2,'claim',hash],[999,'fixture/repo',2,'claim',hash],[101,'other/repo',2,'claim',hash],[101,'fixture/repo',3,'claim',hash],[101,'fixture/repo',2,'deliver',hash],[101,'fixture/repo',2,'claim','b'.repeat(64)]]) {
      await assert.rejects(resolve(...args),/VERIFIED_BOUNTY_IDENTITY_REQUIRED/);
    }
    const scoped = {begin: run};
    const input = {idempotencyKey:'adapter-key',bountyId:'fixture',repo:'fixture/repo',issueNumber:2};
    const reservations = await Promise.all([reserveDelivery(scoped,input),reserveDelivery(scoped,input)]);
    assert.deepEqual(reservations.map(x=>x.status).sort(),['existing','registered']);
    assert.equal(reservations[0].record.id,reservations[1].record.id);
    assert.equal(reservations[0].record.delivery_status,'pending');
    assert.equal(reservations[0].record.claim_entitled,false);
    for (const change of [{bountyId:'other'},{repo:'other/repo'},{issueNumber:3}]) {
      await assert.rejects(reserveDelivery(scoped,{...input,...change}),/DELIVERY_IDEMPOTENCY_MISMATCH/);
    }
    await assert.rejects(reserveDelivery(scoped,{...input,idempotencyKey:''}),/INVALID_DELIVERY_RESERVATION/);
    await assert.rejects(reserveDelivery(scoped,{...input,issueNumber:0}),/INVALID_DELIVERY_RESERVATION/);


    await assert.rejects(run(tx => tx`UPDATE bounty_deliveries SET delivery_status='delivered' WHERE idempotency_key='fixture-key'`), e => e.code === '23514');
    let ready;
    const readDone = new Promise(resolve => { ready = resolve; });
    let release;
    const committed = new Promise(resolve => { release = resolve; });
    const conflicting = sql.begin('isolation level serializable', async tx => {
      await tx.unsafe('SET LOCAL search_path TO ' + schema + ', public');
      await tx`SELECT attempt_count FROM agent_tasks WHERE id=${id}`;
      ready();
      await committed;
      await tx`UPDATE agent_tasks SET attempt_count=attempt_count+1 WHERE id=${id}`;
    });
    const conflictCheck = assert.rejects(conflicting, e => e.code === '40001');
    await readDone;
    try {
      await run(tx => tx`UPDATE agent_tasks SET title='changed' WHERE id=${id}`);
    } finally { release(); }
    await conflictCheck;
    const [unchanged] = await run(tx => tx`SELECT attempt_count FROM agent_tasks WHERE id=${id}`);
    assert.equal(unchanged.attempt_count,0);
    const error = '[DJO2_POLICY:queue_full:owner] Admission deferred; queue capacity reached';
    await run(tx => tx`INSERT INTO agent_tasks(title,prompt,status,attempt_count,started_at,error) VALUES
      ('recover-yes','fixture','failed',0,NULL,${error}),
      ('recover-attempt','fixture','failed',1,NULL,${error}),
      ('recover-started','fixture','failed',0,NOW(),${error}),
      ('recover-other','fixture','failed',0,NULL,'other error')`);
    const recovery = await readFile(new URL('../../004_rehydrate_queue_full.sql',import.meta.url),'utf8');
    await run(tx => tx.unsafe(recovery));
    const recovered = await run(tx => tx`SELECT title,status,next_retry_at,attempt_count FROM agent_tasks WHERE title LIKE 'recover-%'`);
    assert.equal(recovered.length,4);
    for (const row of recovered) {
      assert.equal(row.status,row.title==='recover-yes'?'retry_wait':'failed');
      if (row.title==='recover-yes') { assert.ok(row.next_retry_at); assert.equal(row.attempt_count,0); }
    }
    const again = await run(tx => tx.unsafe(recovery));
    assert.equal(again.count,0);


  } finally {
    try { await sql.unsafe('DROP SCHEMA IF EXISTS ' + schema + ' CASCADE'); }
    finally { await sql.end(); }
  }
});
