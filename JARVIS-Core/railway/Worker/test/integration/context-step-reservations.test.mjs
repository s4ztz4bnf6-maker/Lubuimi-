// SPDX-License-Identifier: LicenseRef-DJO2-Proprietary
// Copyright (c) 2026 Ta-Yoshua Lubuimi. All rights reserved.
import test from "node:test";
import assert from "node:assert/strict";
import postgres from "postgres";
import {readFileSync} from "node:fs";
import {acquireContextStep,completeContextStep} from "../../context-step-reservations.mjs";
test("context reservation concurrency, final gate, replay and expiry",async()=>{
 const url=process.env.DATABASE_URL;
 assert.ok(url,"DATABASE_URL required");
 const sql=postgres(url,{max:10,connection:{search_path:"djo2_reservation_test"}});
 try{
 const [db]=await sql`SELECT current_database() AS name`;
 assert.equal(db.name,"djo2_test");
 await sql`CREATE SCHEMA IF NOT EXISTS djo2_reservation_test`;
 await sql.unsafe(readFileSync(new URL("../../context-step-reservations.sql",import.meta.url),"utf8").replace(/^BEGIN;$/m,"").replace(/^ROLLBACK;$/m,""));
 const taskId=2168,stepHash="a".repeat(64);
 const claims=await Promise.all(Array.from({length:8},()=>acquireContextStep(sql,taskId,stepHash)));
 assert.equal(claims.filter(x=>x.status==="acquired").length,1);
 assert.equal(claims.filter(x=>x.status==="busy").length,7);
 const token=claims.find(x=>x.status==="acquired").token;
 const outcome={completed:true,hasPendingToolCalls:false,output:{answer:"ok"}};
 await assert.rejects(completeContextStep(sql,{taskId,stepHash,token,outcome:{...outcome,hasPendingToolCalls:true}}),/STEP_NOT_FINAL/);
 await assert.rejects(completeContextStep(sql,{taskId,stepHash,token:"00000000-0000-0000-0000-000000000000",outcome}),/STALE_TOKEN/);
 assert.deepEqual(await completeContextStep(sql,{taskId,stepHash,token,outcome}),outcome.output);
 assert.deepEqual(await acquireContextStep(sql,taskId,stepHash),{status:"completed",result:outcome.output});
 const other="b".repeat(64);
 const expired=await acquireContextStep(sql,taskId,other);
 await sql`UPDATE djo2_context_step_reservations SET lease_until=NOW()-INTERVAL '1 second' WHERE task_id=${taskId} AND step_hash=${other}`;
 await assert.rejects(completeContextStep(sql,{taskId,stepHash:other,token:expired.token,outcome}),/STALE_TOKEN/);
 assert.equal((await acquireContextStep(sql,taskId,other)).status,"reconcile_required");
 assert.equal((await acquireContextStep(sql,taskId,other)).status,"reconcile_required");
 }finally{await sql.end();}
});
