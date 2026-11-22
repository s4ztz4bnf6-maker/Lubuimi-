import postgres from "postgres";
const env = Bun.env;
const sql = postgres(env.DATABASE_URL!, { max: 1, connect_timeout: 10 });
const owner = "s4ztz4bnf6-maker", repo = "Lubuimi-", issue = 184;
const ids = new Set([7071728993,7071925467,7071933887,7071951298,7071992510,7072129707,7072142806,7072159131,7072166920,7072216621,7072230194]);
async function main() {
 if (!env.DATABASE_URL || !env.GATEWAY_URL || !env.AGENT_API_KEY) throw Error("Missing DATABASE_URL, GATEWAY_URL or AGENT_API_KEY");
 await sql`CREATE TABLE IF NOT EXISTS jarvis_github_command_bridge (comment_id BIGINT PRIMARY KEY, task_id TEXT, state TEXT NOT NULL, last_error TEXT, updated_at TIMESTAMPTZ DEFAULT now())`;
 const u = `https://api.github.com/repos/${owner}/${repo}/issues/${issue}/comments?per_page=100`;
 const response = await fetch(u,{headers:{"Accept":"application/vnd.github+json","User-Agent":"jarvis-github-bridge"}});
 if (!response.ok) throw Error(`GitHub fetch HTTP ${response.status}`);
 const comments = await response.json() as Array<{id:number;body:string;html_url:string}>;
 let queued = 0;
 for (const c of comments.filter(x=>ids.has(x.id)).sort((a,b)=>a.id-b.id)) {
  const claim = await sql`INSERT INTO jarvis_github_command_bridge(comment_id,state) VALUES (${c.id},'CLAIMED') ON CONFLICT DO NOTHING RETURNING comment_id`;
  if (!claim.length) continue;
  try {
   const task = {title:`GitHub Eigentümerauftrag #${c.id}`,prompt:`Bearbeite den folgenden im GitHub PR #184 dokumentierten Auftrag. Prüfe erst den Istzustand, führe technisch mögliche Schritte aus und dokumentiere nur tatsächlich verifizierte Änderungen. GitHub-Quelle: ${c.html_url}\n\n${c.body.slice(0,10500)}`};
   const target = new URL("/v1/tasks",env.GATEWAY_URL);
   const res = await fetch(target,{method:"POST",headers:{"Content-Type":"application/json","Authorization":`Bearer ${env.AGENT_API_KEY}`,"x-api-key":env.AGENT_API_KEY},body:JSON.stringify(task),signal:AbortSignal.timeout(15000)});
   const data = await res.text();
   if (!res.ok) throw Error(`Gateway HTTP ${res.status}: ${data.slice(0,200)}`);
   let id = "";try{id=String(JSON.parse(data).id??"")}catch{}
   await sql`UPDATE jarvis_github_command_bridge SET state='QUEUED',task_id=${id},updated_at=now() WHERE comment_id=${c.id}`;
   queued++;
  } catch(e) {
   await sql`UPDATE jarvis_github_command_bridge SET state='ERROR',last_error=${String(e).slice(0,350)},updated_at=now() WHERE comment_id=${c.id}`;
   console.error("Bridge task error",c.id,String(e).slice(0,180));
  }
 }
 console.log(JSON.stringify({bridge:"github-to-gateway",matched:comments.filter(x=>ids.has(x.id)).length,queued}));
}
main().catch(e=>{console.error(String(e));process.exitCode=1}).finally(()=>sql.end());
