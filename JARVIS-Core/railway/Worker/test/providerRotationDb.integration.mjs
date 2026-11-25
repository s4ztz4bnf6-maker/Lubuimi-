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
