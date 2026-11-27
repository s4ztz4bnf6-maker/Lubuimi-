// SPDX-License-Identifier: LicenseRef-DJO2-Proprietary
import test from "node:test";
import assert from "node:assert/strict";
import http from "node:http";
import {spawn} from "node:child_process";
import {once} from "node:events";
import postgres from "../../railway/Worker/node_modules/postgres/src/index.js";
import {seedLocalRoute} from "./seed-local-route.mjs";
const sleep=ms=>new Promise(r=>setTimeout(r,ms));
async function wait(fn,label,ms=90000){const end=Date.now()+ms;while(Date.now()<end){const v=await fn();if(v)return v;await sleep(150);}throw Error("Timeout: "+label);}
async function server(handler){const s=http.createServer(handler);s.listen(0,"127.0.0.1");await once(s,"listening");return {s,url:"http://127.0.0.1:"+s.address().port};}
async function body(req){let b="";for await(const c of req)b+=c;return JSON.parse(b);}
for(const mode of ["A","B"])test(mode+": real worker crash and recovery",{timeout:240000},async()=>{
 assert.equal(process.env.CI,"true");assert.equal(process.env.DJO2_E2E,"1");
 const db=new URL(process.env.DATABASE_URL);assert.ok(["127.0.0.1","localhost"].includes(db.hostname));assert.match(db.pathname,/e2e/);
 const sql=postgres(process.env.DATABASE_URL,{max:2});
 const applied=new Set(),requests=new Map();let lookups=0,held=false,blocked=false,taskId;
 const workers=[];
 const effect=await server(async(req,res)=>{
 res.setHeader("content-type","application/json");
 if(req.method==="GET"){lookups++;const n=Number(new URL(req.url,"http://x").searchParams.get("key").split("-step-")[1]);return res.end(JSON.stringify(applied.has(n)?{found:true,result:{step:n,ok:true}}:{found:false}));}
 const {step}=await body(req);requests.set(step,(requests.get(step)||0)+1);applied.add(step);
 if(mode==="B"&&step===2&&!held){held=true;return;}
 res.end(JSON.stringify({step,ok:true}));
 });
 const llm=await server(async(req,res)=>{
 const b=await body(req);
 if(!JSON.stringify(b.messages).includes("E2E_CRASH_TASK")){res.end(JSON.stringify({choices:[{message:{role:"assistant",content:"fixture"},finish_reason:"stop"}]}));return;}
 const history=b.messages.filter(m=>m.role==="tool").map(m=>String(m.content));
 let n=[1,2,3].find(i=>!history.some(h=>h.includes('"step":'+i)));
 if(mode==="A"&&n===2&&!blocked){blocked=true;return;}
 const message=n?{role:"assistant",content:"",tool_calls:[{id:"step-"+n,type:"function",function:{name:"e2e_external_effect",arguments:JSON.stringify({step:n})}}]}:{role:"assistant",content:"E2E_DONE"};
 res.setHeader("content-type","application/json");res.end(JSON.stringify({id:"fixture",object:"chat.completion",model:"e2e",choices:[{index:0,message,finish_reason:n?"tool_calls":"stop"}]}));
 });
 function start(env){const p=spawn("bun",["run","index.ts"],{cwd:new URL("../../railway/Worker/",import.meta.url),env,stdio:["ignore","pipe","pipe"]});const w={p,log:"",done:once(p,"exit")};p.stdout.on("data",d=>w.log+=d);p.stderr.on("data",d=>w.log+=d);workers.push(w);return w;}
 async function kill(w){if(w.p.exitCode===null&&w.p.signalCode===null)w.p.kill("SIGKILL");return w.done;}
 try{
 await sql`CREATE TABLE IF NOT EXISTS agent_tasks(id BIGSERIAL PRIMARY KEY,title text NOT NULL,prompt text NOT NULL,status text NOT NULL DEFAULT 'queued',result text,error text,attempt_count integer NOT NULL DEFAULT 0,max_attempts integer NOT NULL DEFAULT 3,next_retry_at timestamptz,last_attempt_at timestamptz,created_at timestamptz NOT NULL DEFAULT now(),started_at timestamptz,completed_at timestamptz)`;
 await sql`CREATE TABLE IF NOT EXISTS agent_audit(id BIGSERIAL PRIMARY KEY,event text NOT NULL,detail jsonb,created_at timestamptz NOT NULL DEFAULT now())`;
 const route=await seedLocalRoute(sql,llm.url+"/v1");
 const env={PATH:process.env.PATH,HOME:process.env.HOME,CI:"true",DJO2_E2E:"1",DATABASE_URL:process.env.DATABASE_URL,WORKER_LEASE_SECONDS:"2",E2E_EFFECT_URL:effect.url,...route};
 const [task]=await sql`INSERT INTO agent_tasks(title,prompt,max_attempts) VALUES('E2E_CRASH_TASK','Use e2e_external_effect for steps 1, 2, 3 in order and synthesize E2E_DONE.',5) RETURNING id`;taskId=task.id;
 const w1=start(env);
 await wait(()=>mode==="A"?blocked:held,"crash boundary");
 assert.equal((await kill(w1))[1],"SIGKILL");
 await sleep(3000);
 const w2=start(env);
 const row=await wait(async()=>{const [r]=await sql`SELECT status,result FROM agent_tasks WHERE id=${taskId}`;return r?.status==="completed"?r:null;},"completed");
 assert.match(row.result,/E2E_DONE/);
 for(const n of [1,2,3])assert.equal(requests.get(n),1,"step "+n);
 if(mode==="B")assert.ok(lookups>0,"reconciliation lookup required");
 await kill(w2);
 }catch(e){for(const w of workers)console.error(w.log.slice(-8000));throw e;}
 finally{for(const w of workers)await kill(w);for(const {s} of [effect,llm]){s.closeAllConnections();s.close();}await sql.end({timeout:2});}
});
