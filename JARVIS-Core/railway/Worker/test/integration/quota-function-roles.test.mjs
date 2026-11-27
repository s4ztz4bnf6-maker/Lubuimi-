// SPDX-License-Identifier: LicenseRef-DJO2-Proprietary
// Copyright (c) 2026 Ta-Yoshua Lubuimi. All rights reserved.
import test from "node:test";
import assert from "node:assert/strict";
import postgres from "postgres";
import {readFile} from "node:fs/promises";
import {randomUUID} from "node:crypto";
import {spawn} from "node:child_process";
test("quota runtime can execute reservation but cannot access base tables",async()=>{
 const sql=postgres(process.env.DATABASE_URL,{max:1});
 try{
 const [db]=await sql`SELECT current_database() AS name`;assert.equal(db.name,"djo2_test");
 await sql`CREATE SCHEMA djo2_quota_role_test`;
 await sql`SET search_path TO djo2_quota_role_test`;
 for(const file of ["zero-spend-routes.sql","zero-spend-quota-groups.sql","zero-spend-quota-ledger-guard.sql","zero-spend-quota-reserve-function.sql","zero-spend-quota-function-roles.sql"]){
 const script=await readFile(new URL("../../"+file,import.meta.url),"utf8");
 assert.match(script,/ROLLBACK;\s*$/);
 await sql.unsafe(script.replace(/ROLLBACK;\s*$/,"COMMIT;"));
 }
 await sql`INSERT INTO djo2_zero_spend_quota_groups VALUES('shared',8000,200000,30,1000,'quota-proof',now()+interval '1 hour',null)`;
 await sql`INSERT INTO djo2_zero_spend_routes(provider,model,endpoint,zero_spend_verified,billing_disabled,proof_ref,expires_at,quota_group_key) VALUES('test','a','endpoint',true,true,'route-proof',now()+interval '1 hour','shared')`;
 const roles=await sql`SELECT rolname,rolcanlogin,rolsuper FROM pg_roles WHERE rolname IN ('djo2_quota_owner','djo2_quota_runtime')`;
 assert.equal(roles.length,2);assert.ok(roles.every(r=>!r.rolcanlogin&&!r.rolsuper));
 await sql`SET ROLE djo2_quota_runtime`;
 const rejectedIds=[];
 for(const isolation of ["repeatable read","serializable","read uncommitted"]){
  const rejectedId=randomUUID();rejectedIds.push(rejectedId);
  await sql.begin("isolation level "+isolation,async tx=>{
   const [denied]=await tx`SELECT * FROM djo2_reserve_quota_group(${rejectedId}::uuid,'test','a','endpoint','route-proof','quota-proof',3000::bigint,1000::bigint)`;
   assert.equal(denied.granted,false);assert.equal(denied.reason,"UNSUPPORTED_TRANSACTION_ISOLATION");
  });
 }
 await sql`RESET ROLE`;
 for(const rejectedId of rejectedIds){
  const [row]=await sql`SELECT count(*)::int AS n FROM djo2_zero_spend_quota_reservations WHERE reservation_id=${rejectedId}::uuid`;
  assert.equal(row.n,0);
 }
 await sql`SET ROLE djo2_quota_runtime`;
 const id=randomUUID();
 const [result]=await sql`SELECT * FROM djo2_reserve_quota_group(${id}::uuid,'test','a','endpoint','route-proof','quota-proof',3000::bigint,1000::bigint)`;
 assert.equal(result.granted,true);
 const [replay]=await sql`SELECT * FROM djo2_reserve_quota_group(${id}::uuid,'test','a','endpoint','route-proof','quota-proof',3000::bigint,1000::bigint)`;assert.equal(replay.reason,"RESERVATION_ALREADY_USED");
 for(const stmt of ["SELECT * FROM djo2_zero_spend_quota_reservations","UPDATE djo2_zero_spend_quota_groups SET tpm=999999","DELETE FROM djo2_zero_spend_quota_reservations","TRUNCATE djo2_zero_spend_quota_reservations","ALTER TABLE djo2_zero_spend_quota_reservations DISABLE TRIGGER ALL","INSERT INTO djo2_zero_spend_quota_reservations DEFAULT VALUES"])await assert.rejects(sql.unsafe(stmt),e=>e.code==="42501");
 const audit=await readFile(new URL("../../zero-spend-quota-role-audit.sql",import.meta.url),"utf8");
 await sql.unsafe(audit);
 await sql`RESET ROLE`;
 const childId=randomUUID();
 const code=`
 import postgres from "postgres";
 import {readFile} from "node:fs/promises";
 const sql=postgres(process.env.DATABASE_URL,{max:1,connection:{search_path:"djo2_quota_role_test"}});
 await sql\`SET ROLE djo2_quota_runtime\`;
 const source=await readFile("index.ts","utf8");
 const start=source.indexOf("      const quotaRecords=");
 const end=source.indexOf("      const responseText=",start);
 if(start<0||end<=start)throw Error("MISSING_WORKER_GUARD");
 const run=new (Object.getPrototypeOf(async function(){}).constructor)("env","provider","bounded","liveBudget","crypto","sql","fetch","ContextSplitRequiredError",source.slice(start,end));
 const provider={name:"test",model:"a",baseUrl:"endpoint"};
 const env={DJO2_VERIFIED_ZERO_SPEND_ROUTES:JSON.stringify([{provider:"test",model:"a",baseUrl:"endpoint",evidence:"route-proof",quotaProofRef:"quota-proof"}])};
 await run(env,provider,{messages:[],tools:[],output:512},{input:20000},{randomUUID:()=>process.argv[1]},sql,async()=>{console.log("FETCH_BOUNDARY");await new Promise(()=>{setInterval(()=>{},1000)});},Error);
 `;
 const child=spawn(process.execPath,["--input-type=module","-e",code,childId],{cwd:new URL("../../",import.meta.url),stdio:["ignore","pipe","pipe"]});
 try{
 await new Promise((resolve,reject)=>{const timer=setTimeout(()=>reject(Error("CHILD_TIMEOUT")),15000);child.stdout.on("data",d=>{if(String(d).includes("FETCH_BOUNDARY")){clearTimeout(timer);resolve();}});child.once("exit",()=>{clearTimeout(timer);reject(Error("CHILD_EXIT"));});});
 await new Promise(resolve=>{child.once("exit",resolve);child.kill("SIGKILL");});
 const [charge]=await sql`SELECT reserved_tokens::int AS tokens FROM djo2_zero_spend_quota_reservations WHERE reservation_id=${childId}::uuid`;
 assert.ok(charge.tokens>512);
 await sql`SET ROLE djo2_quota_runtime`;
 const [next]=await sql`SELECT * FROM djo2_reserve_quota_group(${randomUUID()}::uuid,'test','a','endpoint','route-proof','quota-proof',3000::bigint,1000::bigint)`;
 assert.equal(next.reason,"GROUP_QUOTA_EXHAUSTED");
 }finally{if(child.exitCode===null&&child.signalCode===null)child.kill("SIGKILL");await sql`RESET ROLE`;}

 const [row]=await sql`SELECT reserved_tokens::int AS tokens FROM djo2_zero_spend_quota_reservations WHERE reservation_id=${id}::uuid`;assert.equal(row.tokens,4000);
 }finally{await sql.end();}
});
