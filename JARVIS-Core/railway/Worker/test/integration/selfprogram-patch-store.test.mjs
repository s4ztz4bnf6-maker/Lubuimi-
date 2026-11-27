import test from "node:test";
import assert from "node:assert/strict";
import postgres from "postgres";
import {readFile} from "node:fs/promises";
import {patchStore} from "../../selfprogram-patch-store.mjs";
test("patch ledger persists and deduplicates concurrent proposals",async()=>{
 const url=process.env.DATABASE_URL;
 assert.equal(new URL(url).pathname,"/djo2_test");
 const sql=postgres(url,{max:4,connection:{search_path:"djo2_patch_store_test"}});
 try{
 await sql`CREATE SCHEMA IF NOT EXISTS djo2_patch_store_test`;
 const migration=await readFile(new URL("../../selfprogram-patch-store.sql",import.meta.url),"utf8");
 await sql.unsafe(migration.replace(/^BEGIN;$/m,"").replace(/^ROLLBACK;$/m,""));
 const store=patchStore(sql);
 const p={taskId:2166,baseCommit:"a".repeat(40),diff:"example patch"};
 const results=await Promise.all(Array.from({length:8},()=>store.add(p)));
 assert.equal(new Set(results.map(r=>String(r.id))).size,1);
 assert.ok(results.every(r=>r.status==="pending"));
 const other=await store.add({...p,baseCommit:"b".repeat(40)});
 assert.notEqual(other.id,results[0].id);
 const pending=await patchStore(sql).pending();
 assert.equal(pending.length,2);
 assert.equal(pending[0].diff,p.diff);
 for(const invalid of [{...p,taskId:0},{...p,baseCommit:"bad"},{...p,diff:" "},{...p,diff:"é".repeat(100001)}])await assert.rejects(()=>store.add(invalid),/INVALID_PATCH/);
 }finally{await sql.end();}
});
