// Public-source discovery: candidates are not accepted external contracts.
export function validateCandidate(c) {
  if (!c || typeof c.url !== "string" || !/^https:\/\//i.test(c.url)) return {ok:false,reason:"invalid_url"};
  if (!Number.isFinite(c.rewardAmount) || c.rewardAmount <= 0) return {ok:false,reason:"reward_unverified"};
  if (!["USD","BTC","ETH","USDC","SATS"].includes(c.rewardCurrency)) return {ok:false,reason:"unsupported_currency"};
  if (c.termsVerified !== true) return {ok:false,reason:"terms_unverified"};
  return {ok:true};
}
export async function discoverCandidates(sql, fetcher=fetch) {
  await sql`CREATE TABLE IF NOT EXISTS jarvis_discovery_sources (source_id TEXT PRIMARY KEY, task_id BIGINT REFERENCES agent_tasks(id), first_seen TIMESTAMPTZ DEFAULT NOW(), last_seen TIMESTAMPTZ DEFAULT NOW(), validation TEXT NOT NULL)`;
  const endpoint="https://api.github.com/search/issues?q=is%3Aissue+is%3Aopen+label%3Abounty+archived%3Afalse&per_page=20";
  let response;
  try {response=await fetcher(endpoint,{headers:{"User-Agent":"JARVIS-Discovery/1.0",Accept:"application/vnd.github+json"},signal:AbortSignal.timeout(12000)});}
  catch(e){console.error(JSON.stringify({event:"discovery_fetch_failed",error:String(e)}));return;}
  if(!response.ok){console.error(JSON.stringify({event:"discovery_http_error",status:response.status}));return;}
  const data=await response.json();
  let added=0,queued=0,duplicates=0;
  for(const item of (Array.isArray(data.items)?data.items:[])) {
    if(item.pull_request||item.state!=="open"||!/^https:\/\/github\.com\//.test(item.html_url||""))continue;
    const sourceId="github:"+item.id;
    const body=String(item.body||"").slice(0,6000);
    // Amounts inferred from text are not evidence of an actual payout or eligibility.
    const match=body.match(/(?:\$\s*(\d+(?:\.\d+)?)|(\d+(?:\.\d+)?)\s*(USD|USDC|BTC|ETH|sats)\b)/i);
    const amount=match?Number(match[1]||match[2]):null;
    const currency=match?(match[1]?"USD":match[3].toUpperCase()):null;
    const c={url:item.html_url,rewardAmount:amount,rewardCurrency:currency,termsVerified:false};
    const validation=validateCandidate(c);
    const prompt=JSON.stringify({sourceId,url:c.url,description:body,rewardAmount:amount,rewardCurrency:currency,validation:validation.reason||"verified",externalAcceptance:false});
    // Atomic deduplication; no unverified external work is queued.
    const result=await sql.begin(async tx=>{
      const claim=await tx`INSERT INTO jarvis_discovery_sources(source_id,validation) VALUES(${sourceId},${validation.reason||"verified"}) ON CONFLICT DO NOTHING RETURNING source_id`;
      if(!claim.length)return false;
      const [task]=await tx`INSERT INTO agent_tasks(title,prompt,status) VALUES(${"DISCOVERY CANDIDATE · "+String(item.title||"Untitled").slice(0,150)},${prompt},'candidate') RETURNING id`;
      await tx`UPDATE jarvis_discovery_sources SET task_id=${task.id} WHERE source_id=${sourceId}`;
      return task.id;
    });
    if(!result){duplicates++;continue;}
    added++;
    console.log(JSON.stringify({event:"discovery_candidate_saved",taskId:result,sourceId,validation:validation.reason||"ok"}));
    if(validation.ok){
      await sql`UPDATE agent_tasks SET status='queued' WHERE id=${result} AND status='candidate'`;
      queued++;
      console.log(JSON.stringify({event:"discovery_candidate_queued",taskId:result,sourceId}));
    }
  }
  console.log(JSON.stringify({event:"discovery_run_completed",added,queued,duplicates}));
}
