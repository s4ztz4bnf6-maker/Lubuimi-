/** Public paid-task discovery: untrusted candidates, never automatic acceptance or payment claims. */
export type PublicBounty={url:string;title:string;reward:number|null;currency:string;source:string;status:'candidate';checkedAt:string};
export function normalizeBountyFeed(payload:unknown,now=new Date()):PublicBounty[]{
 const rows=Array.isArray(payload)?payload:(payload&&typeof payload==='object'&&Array.isArray((payload as any).bounties)?(payload as any).bounties:[]);
 const seen=new Set<string>();const result:PublicBounty[]=[];
 for(const row of rows.slice(0,500)){
  if(!row||typeof row!=='object')continue;
  const r=row as Record<string,unknown>;
  const rawUrl=[r.url,r.issue_url,r.html_url].find(v=>typeof v==='string') as string|undefined;
  const title=[r.title,r.name].find(v=>typeof v==='string') as string|undefined;
  if(!rawUrl||!title||title.length>300)continue;
  let url:URL;try{url=new URL(rawUrl)}catch{continue}
  if(url.protocol!=='https:'||url.username||url.password||seen.has(url.toString()))continue;
  seen.add(url.toString());
  const rawAmount=r.reward??r.amount??r.payout;
  const amount=typeof rawAmount==='number'?rawAmount:typeof rawAmount==='string'?Number(rawAmount.replace(/[^0-9.]/g,'')):null;
  if(amount===null||!Number.isFinite(amount)||amount<=0)continue;\n  if(r.state==='closed'||r.status==='closed'||r.is_open===false||r.closed===true)continue;\n  result.push({url:url.toString(),title,reward:amount,currency:typeof r.currency==='string'?r.currency.slice(0,12):'USD',source:typeof r.source==='string'?r.source.slice(0,80):'public_feed',status:'candidate',checkedAt:now.toISOString()});
 }
 return result;
}
export async function discoverPublicBounties(feedUrl:string,signal?:AbortSignal):Promise<PublicBounty[]>{
 const u=new URL(feedUrl);
 if(u.protocol!=='https:'||u.hostname!=='raw.githubusercontent.com'||u.pathname!=='/krishi-shah/dailybugbounties/main/data/bounties.json')throw Error('feed_not_allowlisted');
 const response=await fetch(u,{signal,headers:{accept:'application/json'}});
 if(!response.ok)throw Error('feed_http_'+response.status);
 const data=await response.json();return normalizeBountyFeed(data);
}
