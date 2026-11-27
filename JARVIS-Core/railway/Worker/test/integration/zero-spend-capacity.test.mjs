// SPDX-License-Identifier: LicenseRef-DJO2-Proprietary
// Copyright (c) 2026 Ta-Yoshua Lubuimi. All rights reserved.
import test from "node:test";
import assert from "node:assert/strict";
import postgres from "postgres";
import {readFile} from "node:fs/promises";
test("capacity migration rollback, constraints and repeatability",async()=>{
 const sql=postgres(process.env.DATABASE_URL,{max:1});
 try{
 const [db]=await sql`SELECT current_database() AS name`;assert.equal(db.name,"djo2_test");
 await sql`CREATE SCHEMA djo2_capacity_test`;
 await sql`SET search_path TO djo2_capacity_test`;
 const base=await readFile(new URL("../../zero-spend-routes.sql",import.meta.url),"utf8");
 const migration=await readFile(new URL("../../zero-spend-capacity.sql",import.meta.url),"utf8");
 assert.match(migration,/ROLLBACK;\s*$/);
 await sql.unsafe(base.replace(/ROLLBACK;\s*$/,"COMMIT;"));
 await sql.unsafe(migration);
 const columns=async()=>await sql`SELECT column_name FROM information_schema.columns WHERE table_schema='djo2_capacity_test' AND table_name='djo2_zero_spend_routes' AND column_name='verified_context_window'`;
 assert.equal((await columns()).length,0);
 const applied=migration.replace(/ROLLBACK;\s*$/,"COMMIT;");
 await sql.unsafe(applied);await sql.unsafe(applied);
 assert.equal((await columns()).length,1);
 const [acl]=await sql`SELECT count(*)::int AS n FROM pg_class c CROSS JOIN LATERAL aclexplode(c.relacl) a WHERE c.oid='djo2_zero_spend_routes'::regclass AND a.grantee=0`;
 assert.equal(acl.n,0);
 await sql`INSERT INTO djo2_zero_spend_routes(provider,model,endpoint,proof_ref,expires_at,verified_context_window,verified_max_input_tokens,verified_max_output_tokens,capacity_proof_ref,capacity_expires_at) VALUES('test','model','endpoint','proof',now()+interval '1 hour',32768,26624,4096,'capacity',now()+interval '1 hour')`;
 for(const [column,value] of [["verified_context_window",2047],["verified_context_window",2000001],["verified_max_input_tokens",0],["verified_max_output_tokens",255],["capacity_proof_ref"," "]])await assert.rejects(sql`UPDATE djo2_zero_spend_routes SET ${sql(column)}=${value}`,e=>e.code==="23514");
 }finally{await sql.end();}
});
