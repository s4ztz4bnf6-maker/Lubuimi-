import {createHash,randomBytes} from "node:crypto";
import {verifyPullRequest} from "./githubDelivery.mjs";
const hash=s=>createHash("sha256").update(s).digest("hex");
const json=(s,b)=>Response.json(b,{status:s});
export async function initAgentMailbox(sql){
 await sql`CREATE TABLE IF NOT EXISTS djo2_agent_keys (id bigserial PRIMARY KEY,name text NOT NULL,key_hash text UNIQUE NOT NULL,revoked_at timestamptz)`;
 await sql`CREATE TABLE IF NOT EXISTS djo2_delivery_packages (id bigserial PRIMARY KEY,task_ref text UNIQUE NOT NULL,payload jsonb NOT NULL,status text NOT NULL DEFAULT 'ready',claimed_by bigint,fence bigint NOT NULL DEFAULT 0,claim_expires timestamptz,verification jsonb,updated_at timestamptz DEFAULT now())`;
 await provisionConfiguredAgent(sql);
}
export async function provisionConfiguredAgent(sql){
 const digest=process.env.DJO2_EXTERNAL_AGENT_KEY_HASH;
 if(!digest)return;
 if(!/^[a-f0-9]{64}$/.test(digest))throw Error("Invalid external agent key hash");
 await sql`INSERT INTO djo2_agent_keys(name,key_hash) VALUES ('external-agent',${digest}) ON CONFLICT(key_hash) DO NOTHING`;
 await sql`UPDATE djo2_agent_keys SET revoked_at=now() WHERE name='external-agent' AND key_hash<>${digest} AND revoked_at IS NULL`;
 console.info("[AgentMailbox] configured external agent key registered");
}
export async function createAgentKey(sql,name){const key="djo2_ak_"+randomBytes(32).toString("base64url");await sql`INSERT INTO djo2_agent_keys(name,key_hash) VALUES (${name},${hash(key)})`;return key;}
export async function rotateAgentKey(sql,name){
 if(typeof name!=="string"||!name.trim()||name.length>160||name==="external-agent")throw Error("Invalid managed agent name");
 const key="djo2_ak_"+randomBytes(32).toString("base64url");
 await sql.begin(async tx=>{
  await tx`SELECT pg_advisory_xact_lock(hashtextextended(${name},0))`;
  await tx`UPDATE djo2_agent_keys SET revoked_at=now() WHERE name=${name} AND revoked_at IS NULL`;
  await tx`INSERT INTO djo2_agent_keys(name,key_hash) VALUES (${name},${hash(key)})`;
 });
 return key;
}
export async function revokeAgentKeys(sql,name){
 if(typeof name!=="string"||!name.trim()||name.length>160||name==="external-agent")throw Error("Invalid managed agent name");
 return sql.begin(async tx=>{
  await tx`SELECT pg_advisory_xact_lock(hashtextextended(${name},0))`;
  const rows=await tx`UPDATE djo2_agent_keys SET revoked_at=now() WHERE name=${name} AND revoked_at IS NULL RETURNING id`;
  return rows.length;
 });
}
export async function enqueuePackage(sql,p){if(!p.taskRef||!p.expectedAuthor||!p.issue||!p.files?.length)throw Error("Incomplete package");const [r]=await sql`INSERT INTO djo2_delivery_packages(task_ref,payload) VALUES (${p.taskRef},${sql.json(p)}) ON CONFLICT(task_ref) DO NOTHING RETURNING id`;return r?.id??null;}
export async function handleAgentRequest(req,{sql,verifyPR=verifyPullRequest}){
 const path=new URL(req.url).pathname;
 const check=path==="/v1/agent/auth/check";
 const next=path==="/v1/agent/tasks/next";
 const m=path.match(/^\/v1\/agent\/tasks\/(\d+)\/(result|heartbeat)$/);
 if(req.method!=="POST"||(!next&&!m&&!check))return null;
 const key=req.headers.get("authorization")?.match(/^Bearer (\S+)$/)?.[1];
 if(!key)return json(401,{error:"unauthorized"});
 const [a]=await sql`SELECT id FROM djo2_agent_keys WHERE key_hash=${hash(key)} AND revoked_at IS NULL`;
 if(!a)return json(401,{error:"unauthorized"});
 if(check)return new Response(null,{status:204,headers:{"cache-control":"no-store"}});
 await sql`UPDATE djo2_delivery_packages SET status='unknown' WHERE status='claimed' AND claim_expires<now()`;
 if(next){const [p]=await sql`UPDATE djo2_delivery_packages SET status='claimed',claimed_by=${a.id},fence=fence+1,claim_expires=now()+interval '30 minutes' WHERE id=(SELECT id FROM djo2_delivery_packages WHERE status='ready' ORDER BY id FOR UPDATE SKIP LOCKED LIMIT 1) RETURNING *`;return p?json(200,{...p.payload,id:String(p.id),fence:String(p.fence),lease_expires:p.claim_expires}):new Response(null,{status:204});}
 let b;try{const t=await req.text();if(t.length>10000)return json(413,{error:"too large"});b=JSON.parse(t);}catch{return json(400,{error:"invalid JSON"});}
 const [p]=await sql`SELECT * FROM djo2_delivery_packages WHERE id=${m[1]} AND claimed_by=${a.id}`;
 if(!p||String(p.fence)!==String(b.fence))return json(409,{error:"invalid lease"});
 if(m[2]==="heartbeat"){const rows=await sql`UPDATE djo2_delivery_packages SET claim_expires=now()+interval '30 minutes' WHERE id=${p.id} AND fence=${p.fence} AND status='claimed' AND claim_expires>now() RETURNING id`;return json(rows.length?200:409,{renewed:!!rows.length});}
 if(p.status==="verified")return json(200,{status:"verified",verification:p.verification});
 if(!["claimed","unknown"].includes(p.status)||!Number.isSafeInteger(b.number)||b.number<1||!p.payload.expectedHeadSha)return json(409,{error:"missing trusted evidence or invalid state"});
 const q=p.payload;const v=await verifyPR({owner:q.owner,repo:q.repo,number:b.number,expectedAuthor:q.expectedAuthor,expectedIssue:q.issue,expectedHeadSha:q.expectedHeadSha,expectedPaths:q.files.map(f=>f.path),expectedFiles:q.files,expectedBase:q.base,expectedBranch:q.branch});
 if(!v.verified)return json(422,v);
 const rows=await sql`UPDATE djo2_delivery_packages SET status='verified',verification=${sql.json({...v,number:b.number})},updated_at=now() WHERE id=${p.id} AND fence=${p.fence} AND claimed_by=${a.id} AND status IN ('claimed','unknown') RETURNING id`;
 return json(rows.length?200:409,{status:rows.length?"verified":"conflict"});
}
