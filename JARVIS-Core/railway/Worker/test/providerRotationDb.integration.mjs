import test from "node:test";
import assert from "node:assert/strict";
import postgres from "postgres";
import {initRotation,loadExcludedProviders,excludeProvider,clearExcluded,runToolOnce,setFlag} from "../providerRotationDb.mjs";
test("real PostgreSQL restart, concurrent effect, replay, ambiguous outcome and kill",async()=>{
 const url=process.env.DATABASE_URL;assert.ok(url);
 let sql=postgres(url,{max:4});await initRotation(sql);
 const id="ci-"+crypto.randomUUID();
 try{
 await excludeProvider(sql,id,"free:model","loop");await sql.end();
 sql=postgres(url,{max:4});assert.deepEqual([...await loadExcludedProviders(sql,id)],["free:model"]);
 let calls=0;const exec=async()=>{calls++;await new Promise(r=>setTimeout(r,100));return {receipt:"test"};};
 const pair=await Promise.all([runToolOnce(sql,id,"write",{a:1},exec),runToolOnce(sql,id,"write",{a:1},exec)]);
 assert.equal(calls,1);assert.ok(pair.some(x=>x.status==="done"));
 assert.equal((await runToolOnce(sql,id,"write",{a:1},exec)).status,"replayed");assert.equal(calls,1);
 assert.equal((await runToolOnce(sql,id,"uncertain",{},async()=>{throw Error("timeout");})).status,"unknown");
 assert.equal((await runToolOnce(sql,id,"uncertain",{},exec)).status,"unknown");assert.equal(calls,1);
 await setFlag(sql,"kill","1");await assert.rejects(runToolOnce(sql,id,"new",{},exec),/KILL_SWITCH/);assert.equal(calls,1);
 await clearExcluded(sql,id);assert.equal((await loadExcludedProviders(sql,id)).size,0);
 }finally{await setFlag(sql,"kill","0");await sql.end();}
});

import {productionSelftest} from "../productionSelftest.mjs";
test("production probe across fresh database clients",async()=>{const id=crypto.randomUUID();let sql=postgres(process.env.DATABASE_URL);try{await productionSelftest(sql,id);assert.equal((await loadExcludedProviders(sql,"selftest:"+id)).size,0);await sql.end();sql=postgres(process.env.DATABASE_URL);const [row]=await sql`SELECT count(*)::int AS n FROM djo2_selftest.djo2_provider_exclusions WHERE task_id=${"selftest:"+id}`;assert.equal(row.n,1);await productionSelftest(sql,id);const [after]=await sql`SELECT count(*)::int AS n FROM djo2_selftest.djo2_provider_exclusions WHERE task_id=${"selftest:"+id}`;assert.equal(after.n,0);await assert.rejects(productionSelftest(sql,id,"public"),/invalid isolated schema/);}finally{await sql.end();}});

test("isolated probe leaves public rows unchanged on success and failure",async()=>{const sql=postgres(process.env.DATABASE_URL);const id=crypto.randomUUID();const schema="djo2_selftest_"+id.replaceAll("-","").slice(0,16);const snapshot=async()=>{const out={};for(const name of ["djo2_provider_exclusions","djo2_task_effects","djo2_system_flags"]){const [r]=await sql`SELECT coalesce(jsonb_agg(to_jsonb(t) ORDER BY to_jsonb(t)::text),'[]'::jsonb) AS rows FROM ${sql("public."+name)} t`;out[name]=r.rows;}return out;};try{await initRotation(sql);const before=await snapshot();await productionSelftest(sql,id,schema);assert.deepEqual(await snapshot(),before);await productionSelftest(sql,id,schema);assert.deepEqual(await snapshot(),before);await assert.rejects(productionSelftest(sql,id,"public"),/invalid isolated schema/);assert.deepEqual(await snapshot(),before);await assert.rejects(productionSelftest(sql,"bad",schema),/invalid selftest ID/);assert.deepEqual(await snapshot(),before);}finally{await sql`DROP SCHEMA IF EXISTS ${sql(schema)} CASCADE`;await sql.end();}});

import {spawn} from "node:child_process";
import {once} from "node:events";
const moduleUrl=new URL("../productionSelftest.mjs",import.meta.url).href;
function childProbe(id,schema){
 return spawn(process.execPath,["--input-type=module","-e",`import postgres from 'postgres';import {productionSelftest} from ${JSON.stringify(moduleUrl)};const sql=postgres(process.env.DATABASE_URL);try{console.log('PHASE='+await productionSelftest(sql,process.argv[1],process.argv[2]));}finally{await sql.end();}`,id,schema],{stdio:["ignore","pipe","pipe"]});
}
async function phase(id,schema){
 const child=childProbe(id,schema);let output="",errors="";child.stdout.on("data",x=>output+=x);child.stderr.on("data",x=>errors+=x);
 const [code]=await once(child,"close");assert.equal(code,0,errors);return output;
}
test("one-shot state survives three separate processes and new ID",async()=>{
 const id=crypto.randomUUID(),schema="djo2_selftest_"+id.replaceAll("-","").slice(0,16);
 const sql=postgres(process.env.DATABASE_URL);
 try{
 assert.match(await phase(id,schema),/PHASE=write/);
 assert.match(await phase(id,schema),/PHASE=persist/);
 assert.match(await phase(id,schema),/PHASE=completed/);
 assert.match(await phase(crypto.randomUUID(),schema),/PHASE=write/);
 const [row]=await sql`SELECT state FROM ${sql(schema+".selftest_runs")} WHERE run_id=${id}`;assert.equal(row.state,"COMPLETED");
 }finally{await sql.end();}
});
test("live lock is busy; killed session leaves unknown, never retries",async()=>{
 const id=crypto.randomUUID(),schema="djo2_selftest_"+id.replaceAll("-","").slice(0,16);
 const sql=postgres(process.env.DATABASE_URL);
 const child=spawn(process.execPath,["--input-type=module","-e",`import postgres from 'postgres';const sql=postgres(process.env.DATABASE_URL,{max:1});const [id,schema]=process.argv.slice(1);await sql\`SELECT pg_advisory_lock(hashtext('djo2-selftest'),hashtext(\${schema}))\`;await sql\`CREATE SCHEMA \${sql(schema)}\`;await sql\`CREATE TABLE \${sql(schema+'.selftest_runs')} (run_id text PRIMARY KEY,state text NOT NULL,updated_at timestamptz DEFAULT now())\`;await sql\`INSERT INTO \${sql(schema+'.selftest_runs')}(run_id,state) VALUES(\${id},'IN_PROGRESS')\`;console.log('READY');setInterval(()=>{},1000);`,id,schema],{stdio:["ignore","pipe","pipe"]});
 const closed=once(child,"close");
 try{
 await new Promise((resolve,reject)=>{let out="";const timer=setTimeout(()=>reject(Error("child readiness timeout")),10000);child.stdout.on("data",x=>{out+=x;if(out.includes("READY")){clearTimeout(timer);resolve();}});child.once("exit",()=>{clearTimeout(timer);reject(Error("child exited"));});});
 assert.match(await phase(id,schema),/PHASE=busy/);
 child.kill("SIGKILL");await closed;
 assert.match(await phase(id,schema),/PHASE=unknown/);
 assert.match(await phase(id,schema),/PHASE=unknown/);
 }finally{child.kill("SIGKILL");await sql.end();}
});

import {transitionSelftest} from "../productionSelftest.mjs";
test("actual probe SIGKILL before commit releases lock and preserves unknown",async()=>{
 const id=crypto.randomUUID(),schema="djo2_selftest_"+id.replaceAll("-","").slice(0,16);
 const sql=postgres(process.env.DATABASE_URL);
 const child=spawn(process.execPath,["--input-type=module","-e",`import postgres from 'postgres';import {productionSelftest} from ${JSON.stringify(moduleUrl)};const sql=postgres(process.env.DATABASE_URL);await productionSelftest(sql,process.argv[1],process.argv[2],{beforeWriteCommit:async()=>{console.log('CRITICAL_READY');await new Promise(()=>{setInterval(()=>{},1000)});}});`,id,schema],{stdio:["ignore","pipe","pipe"]});
 const closed=once(child,"close");
 const read=async()=>{const [r]=await sql`SELECT state FROM ${sql(schema+".selftest_runs")} WHERE run_id=${id}`;return r.state;};
 try{
 await new Promise((resolve,reject)=>{let out="",err="";const timer=setTimeout(()=>reject(Error("critical window timeout: "+err)),15000);child.stderr.on("data",x=>err+=x);child.stdout.on("data",x=>{out+=x;if(out.includes("CRITICAL_READY")){clearTimeout(timer);resolve();}});child.once("exit",()=>{clearTimeout(timer);reject(Error("child exited: "+err));});});
 assert.equal(await read(),"IN_PROGRESS");
 assert.match(await phase(id,schema),/PHASE=busy/);
 assert.equal(await read(),"IN_PROGRESS");
 child.kill("SIGKILL");const [,signal]=await closed;assert.equal(signal,"SIGKILL");
 const session=await sql.reserve();
 try{
 let acquired=false;
 for(let i=0;i<100&&!acquired;i++){const [r]=await session`SELECT pg_try_advisory_lock(hashtext('djo2-selftest'),hashtext(${schema})) AS ok`;acquired=r.ok;if(!acquired)await new Promise(r=>setTimeout(r,50));}
 assert.ok(acquired,"session lock must be released after SIGKILL");
 assert.equal(await read(),"IN_PROGRESS");
 await session`SELECT pg_advisory_unlock(hashtext('djo2-selftest'),hashtext(${schema}))`;
 }finally{session.release();}
 assert.match(await phase(id,schema),/PHASE=unknown/);
 assert.equal(await read(),"UNKNOWN");
 assert.match(await phase(id,schema),/PHASE=unknown/);
 assert.equal(await read(),"UNKNOWN");
 const [markerTable]=await sql`SELECT to_regclass(${schema+".djo2_provider_exclusions"}) AS name`;assert.equal(markerTable.name,null);
 }finally{child.kill("SIGKILL");await sql.end();}
});
test("invalid state and missing ID cannot change durable state",async()=>{
 const id=crypto.randomUUID(),schema="djo2_selftest_"+id.replaceAll("-","").slice(0,16);
 const sql=postgres(process.env.DATABASE_URL);
 try{
 await productionSelftest(sql,id,schema);await productionSelftest(sql,id,schema);
 const snapshot=()=>sql`SELECT * FROM ${sql(schema+".selftest_runs")} ORDER BY run_id`;
 const before=await snapshot();
 await assert.rejects(transitionSelftest(sql,schema,id,"IN_PROGRESS","WRITTEN"),/exactly one row/);
 await assert.rejects(transitionSelftest(sql,schema,crypto.randomUUID(),"WRITTEN","COMPLETED"),/exactly one row/);
 await assert.rejects(transitionSelftest(sql,schema,id,"COMPLETED","WRITTEN"),/invalid transition/);
 assert.deepEqual(await snapshot(),before);
 }finally{await sql.end();}
});

test("reserved external effect is reconciled after reconnect without another execution", {timeout: 20000}, async()=>{
 const url=process.env.DATABASE_URL;
 assert.ok(url);
 assert.equal(new URL(url).pathname,"/testdb","isolated CI database required");
 const id=crypto.randomUUID(),schema="djo2_selftest_"+id.replaceAll("-","").slice(0,16);
 let sql=postgres(url);
 let calls=0,lookups=0,key;
 try{
  await sql`CREATE SCHEMA ${sql(schema)}`;
  await initRotation(sql,schema);
  const first=await runToolOnce(sql,id,"submit",{step:2},async ctx=>{calls++;key=ctx.effectKey;throw Error("response lost");},schema);
  assert.equal(first.status,"unknown");
  await sql.end();sql=postgres(url);
  const never=async()=>{calls++;throw Error("duplicate execution");};
  const absent=await runToolOnce(sql,id,"submit",{step:2},never,schema,async()=>({found:false}));
  assert.equal(absent.status,"unknown");
  const recovered=await runToolOnce(sql,id,"submit",{step:2},never,schema,async ctx=>{
   lookups++;assert.equal(ctx.taskId,id);assert.equal(ctx.effectKey,key);
   return {found:true,result:{receipt:"confirmed"}};
  });
  assert.deepEqual(recovered,{status:"replayed",result:{receipt:"confirmed"}});
  assert.equal(calls,1);assert.equal(lookups,1);
  await sql.end();sql=postgres(url);
  assert.deepEqual(await runToolOnce(sql,id,"submit",{step:2},never,schema),recovered);
  assert.equal(calls,1);
 }finally{await sql`DROP SCHEMA IF EXISTS ${sql(schema)} CASCADE`;await sql.end();}
});
