import http from "node:http";
import pg from "pg";
const { Pool } = pg;
const interval = Math.max(60000, Number(process.env.DISCOVERY_INTERVAL_MS || 60000));
const pool = process.env.DATABASE_URL ? new Pool({connectionString:process.env.DATABASE_URL,max:2,connectionTimeoutMillis:12000}) : null;
const queries = ['is:issue is:open label:bounty archived:false','is:issue is:open "bounty" "USD" archived:false','is:issue is:open "bounty" "sats" archived:false','is:issue is:open "reward" "USDC" archived:false'];
const status = {started:new Date().toISOString(),lastRun:null,lastSuccess:null,checked:0,candidates:0,saved:0,lastError:null};
const sleep = ms => new Promise(r=>setTimeout(r,ms));
async function setup(){
 if(!pool) throw Error("DATABASE_URL is required for durable discovery");
 await pool.query(`CREATE TABLE IF NOT EXISTS bounty_jobs (id BIGSERIAL PRIMARY KEY,source TEXT NOT NULL,url TEXT NOT NULL,title TEXT,description TEXT,reward NUMERIC,deadline TIMESTAMPTZ,fetched_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),score INTEGER NOT NULL DEFAULT 0,status TEXT NOT NULL DEFAULT 'candidate',UNIQUE(source,url))`);
 await pool.query("CREATE INDEX IF NOT EXISTS bounty_jobs_status_score_idx ON bounty_jobs(status,score DESC)");
}
function score(x){const s=((x.title||"")+" "+(x.body||"").slice(0,4000)).toLowerCase();return (/bounty|reward|paid/.test(s)?2:0)+(/\\$\\s*\\d|\\d+\\s*(?:usd|usdc|sats|btc)/.test(s)?3:0)+(/bug|fix|feature|documentation|api|test/.test(s)?1:0)-(x.assignee?1:0);}
async function fetchQuery(q){
 const u=new URL("https://api.github.com/search/issues");u.searchParams.set("q",q);u.searchParams.set("sort","updated");u.searchParams.set("per_page","40");
 const headers={"User-Agent":"JARVIS-Bounty-Discovery/1.0",Accept:"application/vnd.github+json","X-GitHub-Api-Version":"2022-11-28"};
 if(process.env.GITHUB_TOKEN)headers.Authorization="Bearer "+process.env.GITHUB_TOKEN;
 for(let i=0;i<3;i++){
  const r=await fetch(u,{headers,signal:AbortSignal.timeout(20000)});
  if(r.ok)return (await r.json()).items||[];
  if(![429,502,503,504].includes(r.status))throw Error("GitHub search HTTP "+r.status);
  await sleep(Math.min(30000,3000*2**i));
 }
 throw Error("GitHub search retry exhausted");
}
async function fetchPublicFeed(){
 const url="https://raw.githubusercontent.com/krishi-shah/dailybugbounties/main/data/bounties.json";
 const r=await fetch(url,{headers:{"User-Agent":"JARVIS-Bounty-Discovery/1.0",Accept:"application/json"},signal:AbortSignal.timeout(20000)});
 if(!r.ok)throw Error("Public feed HTTP "+r.status);
 const data=await r.json();
 const rows=Array.isArray(data)?data:Array.isArray(data?.bounties)?data.bounties:[];
 return rows.slice(0,500).flatMap(x=>{
  if(!x||typeof x!=="object")return [];
  const url=x.url||x.issue_url||x.html_url;
  const title=x.title||x.name;
  if(typeof url!=="string"||typeof title!=="string")return [];
  try{const u=new URL(url);if(u.protocol!=="https:")return [];}catch{return [];}
  const reward=Number(String(x.reward??x.amount??x.payout??"").replace(/[^0-9.]/g,""));
  if(!Number.isFinite(reward)||reward<=0||x.closed===true||x.status==="closed")return [];
  return [{source:"public_bounty_feed",url,title,description:"Public bounty feed candidate; payout and eligibility not independently verified",score:4}];
 });
}
async function run(){
 status.lastRun=new Date().toISOString();status.lastError=null;
 const found=new Map();
 for(const q of queries){
  try{const issues=await fetchQuery(q);status.checked+=issues.length;for(const x of issues){if(x.pull_request||x.state!=="open")continue;const points=score(x);if(points<3)continue;found.set(x.html_url,{source:"github",url:x.html_url,title:x.title,description:(x.body||"").slice(0,8000),score:points});}}
  catch(e){console.error(JSON.stringify({event:"query_error",query:q,error:String(e)}));status.lastError=String(e);}
 }
 try{for(const item of await fetchPublicFeed())found.set(item.url,item);}catch(e){console.error(JSON.stringify({event:"public_feed_error",error:String(e)}));status.lastError=String(e);}
 status.candidates=found.size;
 for(const x of found.values()){
  await pool.query(`INSERT INTO bounty_jobs(source,url,title,description,score) VALUES($1,$2,$3,$4,$5) ON CONFLICT(source,url) DO UPDATE SET title=EXCLUDED.title,description=EXCLUDED.description,score=EXCLUDED.score,fetched_at=NOW()`,[x.source,x.url,x.title,x.description,x.score]);
  status.saved++;
 }
 if(found.size||!status.lastError)status.lastSuccess=new Date().toISOString();
 console.log(JSON.stringify({event:"discovery_run",...status}));
}
http.createServer((req,res)=>{res.setHeader("Content-Type","application/json");res.statusCode=req.url==="/health"?(pool&&status.lastSuccess?200:503):200;res.end(JSON.stringify(status));}).listen(Number(process.env.PORT||3000),"0.0.0.0");
await setup();
console.log(JSON.stringify({event:"worker_started",interval}));
for(;;){try{await run();}catch(e){status.lastError=String(e);console.error(JSON.stringify({event:"run_failed",error:String(e)}));}await sleep(interval);}
