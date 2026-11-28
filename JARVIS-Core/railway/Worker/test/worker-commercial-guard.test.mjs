import test from "node:test";
import assert from "node:assert/strict";
import {verifyCommercialSchema} from "../worker-commercial-guard.mjs";
import {executeCommercialOrder} from "../commercial-order-idempotency.mjs";
const rows=Object.entries({agent_tasks:["id","title","prompt","status","attempt_count"],djo2_task_checkpoints:["id","task_id","attempt","step","phase","note"]}).flatMap(([table_name,cols])=>cols.map(column_name=>({table_name,column_name,data_type:"text"})));
const mock=records=>Object.assign(async()=>records,{begin:()=>assert.fail("unexpected transaction")});
test("commercial schema requires a SQL transaction interface",async()=>{
 for(const sql of [undefined,null,{},async()=>rows])await assert.rejects(verifyCommercialSchema(sql),/COMMERCIAL_DATABASE_UNAVAILABLE/);
});
test("commercial schema rejects each missing required column",async()=>{
 for(let i=0;i<rows.length;i++)await assert.rejects(verifyCommercialSchema(mock(rows.filter((_,j)=>i!==j))),/COMMERCIAL_SCHEMA_MISMATCH/);
 assert.equal(await verifyCommercialSchema(mock(rows)),true);
});
test("commercial schema requires exact text note",async()=>{
 for(const data_type of ["jsonb","character varying","integer"])await assert.rejects(verifyCommercialSchema(mock(rows.map(r=>r.column_name==="note"?{...r,data_type}:r))),/COMMERCIAL_SCHEMA_NOTE_NOT_TEXT/);
});
test("commercial execution blocks invalid schema before reservation or submission",async()=>{
 await assert.rejects(executeCommercialOrder({sql:mock([]),taskId:1,taskHash:"hash",limit:100,reserved:10,identity:{namespace:"test",externalOrderId:"1",operation:"submit"},verifyRoute:async()=>true,submit:()=>assert.fail("external submission")}),/COMMERCIAL_SCHEMA_MISMATCH/);
});
