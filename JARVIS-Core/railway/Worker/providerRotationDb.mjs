// SPDX-License-Identifier: LicenseRef-DJO2-Proprietary
import { createHash } from "node:crypto";
export async function initRotation(sql) {
 await sql`CREATE TABLE IF NOT EXISTS djo2_provider_exclusions (task_id text NOT NULL, tag text NOT NULL, reason text, created_at timestamptz NOT NULL DEFAULT now(), PRIMARY KEY(task_id,tag))`;
 await sql`CREATE TABLE IF NOT EXISTS djo2_task_effects (task_id text NOT NULL,effect_key text NOT NULL,tool text NOT NULL,status text NOT NULL CHECK(status IN ('started','done','failed')),result jsonb,created_at timestamptz NOT NULL DEFAULT now(),updated_at timestamptz NOT NULL DEFAULT now(),PRIMARY KEY(task_id,effect_key))`;
 await sql`CREATE TABLE IF NOT EXISTS djo2_system_flags (key text PRIMARY KEY,value text NOT NULL,updated_at timestamptz NOT NULL DEFAULT now())`;
}
export async function loadExcludedProviders(sql,id,ttl=120){const rows=await sql`SELECT tag FROM djo2_provider_exclusions WHERE task_id=${String(id)} AND created_at > now()-make_interval(mins=>${ttl})`;return new Set(rows.map(r=>r.tag));}
export async function excludeProvider(sql,id,tag,reason){await sql`INSERT INTO djo2_provider_exclusions(task_id,tag,reason) VALUES(${String(id)},${tag},${reason??null}) ON CONFLICT(task_id,tag) DO UPDATE SET created_at=now(),reason=EXCLUDED.reason`;}
export async function clearExcluded(sql,id){await sql`DELETE FROM djo2_provider_exclusions WHERE task_id=${String(id)}`;}
function stable(v){if(Array.isArray(v))return "["+v.map(stable).join(",")+"]";if(v&&typeof v==="object")return "{"+Object.keys(v).sort().map(k=>JSON.stringify(k)+":"+stable(v[k])).join(",")+"}";return JSON.stringify(v??null);}
export function effectKey(tool,args){return createHash("sha256").update(tool+"\n"+stable(args)).digest("hex");}
export async function isKilled(sql){const [r]=await sql`SELECT value FROM djo2_system_flags WHERE key='kill'`;return r?.value==="1";}
export async function setFlag(sql,key,value){await sql`INSERT INTO djo2_system_flags(key,value) VALUES(${key},${value}) ON CONFLICT(key) DO UPDATE SET value=EXCLUDED.value,updated_at=now()`;}
export async function runToolOnce(sql,id,tool,args,exec){
 if(await isKilled(sql))throw new Error("KILL_SWITCH");
 const tid=String(id),key=effectKey(tool,args);
 const ins=await sql`INSERT INTO djo2_task_effects(task_id,effect_key,tool,status) VALUES(${tid},${key},${tool},'started') ON CONFLICT DO NOTHING RETURNING effect_key`;
 if(!ins.length){const [row]=await sql`SELECT status,result FROM djo2_task_effects WHERE task_id=${tid} AND effect_key=${key}`;if(row?.status==="done")return {status:"replayed",result:row.result};return {status:"unknown",message:"UNKNOWN_OUTCOME: reconcile before retry"};}
 try{if(await isKilled(sql))throw new Error("KILL_SWITCH");const result=await exec();await sql`UPDATE djo2_task_effects SET status='done',result=${sql.json(result??null)},updated_at=now() WHERE task_id=${tid} AND effect_key=${key}`;return {status:"done",result};}
 catch(e){return {status:"unknown",message:"UNKNOWN_OUTCOME: reconcile before retry"};}
}
