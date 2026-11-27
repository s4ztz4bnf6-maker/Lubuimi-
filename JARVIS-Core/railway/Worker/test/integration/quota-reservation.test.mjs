// SPDX-License-Identifier: LicenseRef-DJO2-Proprietary
// Copyright (c) 2026 Ta-Yoshua Lubuimi. All rights reserved.
import test from "node:test";
import assert from "node:assert/strict";
import postgres from "postgres";
import {readFile} from "node:fs/promises";
import {randomUUID} from "node:crypto";
import {spawn} from "node:child_process";
import {reserveQuota} from "../../quota-reservation-store.mjs";
test("shared quota concurrency, immutable journal and SIGKILL retention",async()=>{
 const sql=postgres(process.env.DATABASE_URL,{max:1});
 let workers,child;
 try{
 const [db]=await sql`SELECT current_database() AS name`;assert.equal(db.name,"djo2_test");
 await sql`CREATE SCHEMA djo2_quota_integration`;
 await sql`SET search_path TO djo2_quota_integration`;
 for(const file of ["zero-spend-routes.sql","zero-spend-quota-groups.sql","zero-spend-quota-ledger-guard.sql"]){
 const script=await readFile(new URL("../../"+file,import.meta.url),"utf8");
 assert.match(script,/ROLLBACK;\s*$/);
 await sql.unsafe(script.replace(/ROLLBACK;\s*$/,"COMMIT;"));
 }
 await sql`INSERT INTO djo2_zero_spend_quota_groups VALUES('shared',8000,200000,30,1000,'quota-proof',now()+interval '1 hour',null)`;
 for(const model of ["a","b"])await sql`INSERT INTO djo2_zero_spend_routes(provider,model,endpoint,zero_spend_verified,billing_disabled,proof_ref,expires_at,quota_group_key) VALUES('test',${model},'test-endpoint',true,true,'route-proof',now()+interval '1 hour','shared')`;
 workers=postgres(process.env.DATABASE_URL,{max:8,connection:{search_path:"djo2_quota_integration"}});
 const args={provider:"test",endpoint:"test-endpoint",proofRef:"route-proof",quotaProofRef:"quota-proof",inputTokens:3000,outputTokens:1000};
 const requests=Array.from({length:8},(_,i)=>({...args,model:i%2?"a":"b",reservationId:randomUUID()}));
 const results=await Promise.all(requests.map(r=>reserveQuota(workers,r)));
 assert.equal(results.filter(r=>r.granted).length,2);
 const winner=requests[results.findIndex(r=>r.granted)];
 assert.equal((await reserveQuota(workers,winner)).reason,"RESERVATION_ALREADY_USED");
 const [sum]=await sql`SELECT sum(reserved_tokens)::int AS tokens FROM djo2_zero_spend_quota_reservations`;assert.equal(sum.tokens,8000);
 for(const statement of ["UPDATE djo2_zero_spend_quota_reservations SET reserved_tokens=1","DELETE FROM djo2_zero_spend_quota_reservations","TRUNCATE djo2_zero_spend_quota_reservations"])await assert.rejects(sql.unsafe(statement),e=>e.code==="42501");
 await sql`UPDATE djo2_zero_spend_quota_groups SET tpm=12000 WHERE quota_group_key='shared'`;
 const childId=randomUUID();
 const code=`
 import postgres from "postgres";
 import {reserveQuota} from "./quota-reservation-store.mjs";
 const sql=postgres(process.env.DATABASE_URL,{connection:{search_path:"djo2_quota_integration"}});
 const result=await reserveQuota(sql,JSON.parse(process.argv[1]));
 if(!result.granted)throw Error("NOT_GRANTED");
 console.log("RESERVED");setInterval(()=>{},1000);
 `;
 child=spawn(process.execPath,["--input-type=module","-e",code,JSON.stringify({...args,model:"a",reservationId:childId})],{cwd:new URL("../../",import.meta.url),stdio:["ignore","pipe","pipe"]});
 await new Promise((resolve,reject)=>{const timer=setTimeout(()=>reject(Error("CHILD_TIMEOUT")),15000);child.stdout.on("data",d=>{if(String(d).includes("RESERVED")){clearTimeout(timer);resolve();}});child.once("exit",()=>{clearTimeout(timer);reject(Error("CHILD_EXIT"));});});
 await new Promise(resolve=>{child.once("exit",resolve);child.kill("SIGKILL");});
 assert.equal((await reserveQuota(workers,{...args,model:"b",reservationId:randomUUID()})).reason,"GROUP_QUOTA_EXHAUSTED");
 const [retained]=await sql`SELECT reserved_tokens::int AS tokens FROM djo2_zero_spend_quota_reservations WHERE reservation_id=${childId}::uuid`;assert.equal(retained.tokens,4000);
 const [stamp]=await sql`INSERT INTO djo2_zero_spend_quota_reservations(reservation_id,quota_group_key,provider,model,endpoint,reserved_tokens,created_at) VALUES(${randomUUID()}::uuid,'shared','test','a','test-endpoint',1,'2000-01-01') RETURNING created_at>now()-interval '1 minute' AS recent`;assert.equal(stamp.recent,true);
 }finally{if(child&&child.exitCode===null&&child.signalCode===null)child.kill("SIGKILL");if(workers)await workers.end();await sql.end();}
});
