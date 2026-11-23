/** Read-only public discovery. Feed URLs must be administrator-approved HTTPS sources. */
export type PublicLead={kind:"gift"|"demand";sourceUrl:string;title:string;description:string;publishedAt:string|null;productKey:string|null;source:"rss"|"github";verified:false};
function clean(s:string){return s.replace(/<[^>]*>/g," ").replace(/&amp;/g,"&").replace(/&lt;/g,"<").replace(/&gt;/g,">").replace(/\s+/g," ").trim().slice(0,500)}
function field(xml:string,name:string){const m=xml.match(new RegExp("<(?:[\\w-]+:)?"+name+"(?:\\s[^>]*)?>([\\s\\S]*?)<\\/(?:[\\w-]+:)?"+name+">","i"));return m?clean(m[1].replace(/<!\[CDATA\[([\s\S]*?)\]\]>/g,"$1")):""}
function safeUrl(u:string){try{const x=new URL(u);return x.protocol==="https:"&&!x.username&&!x.password&&!["localhost","127.0.0.1","::1"].includes(x.hostname)&&!x.hostname.endsWith(".local")}catch{return false}}
/** No hidden service or Tor support unless an independently audited, approved connector is configured. */
export async function searchPublicGiftFeeds(feedUrls:string[],query:string,fetcher:typeof fetch=fetch):Promise<PublicLead[]>{
 const result:PublicLead[]=[];const q=query.toLowerCase().trim();if(!q||q.length<2)return result;
 const discoveryQueries=[`(${query} OR gratis OR kostenlos OR freebie OR giveaway)`, `("${query}" "free sample")`, `"zu verschenken"`, `"kostenlos abzugeben"`, `"gratis abholen"`, `"free stuff"`, `"freecycle"`];
 const publicSearchFeeds=discoveryQueries.map(q=>"https://news.google.com/rss/search?"+new URLSearchParams({q,hl:"en",gl:"US",ceid:"US:en"}).toString());
 const publicSourceSearches=["site:kostenlos.de/gratisartikel-uebersicht gratisproben","site:mein-deal.com/gratisproben kostenlose produktproben","site:proben-kostenlos.de gratisproben","site:gratiswunder.de gratisproben"];const curatedFeeds=publicSourceSearches.map(q=>"https://news.google.com/rss/search?"+new URLSearchParams({q,hl:"de",gl:"DE",ceid:"DE:de"}).toString());
 const regions=[["US","en","free samples giveaway free products"],["CN","zh-CN","免费试用 免费样品"],["DE","de","gratisproben kostenlose produkte"],["GB","en","free samples giveaway"],["FR","fr","échantillons gratuits cadeaux"],["CA","en","free samples Canada"],["IT","it","campioni omaggio gratis"],["JP","ja","無料サンプル プレゼント"],["AU","en","free samples Australia"],["BR","pt-419","amostras grátis produtos"],["IN","en","free samples products India"],["ES","es","muestras gratis productos"]];
 const globalFeeds=regions.map(([gl,hl,term])=>"https://news.google.com/rss/search?"+new URLSearchParams({q:`${query} ${term}`,hl,gl,ceid:`${gl}:${hl}`}).toString());
 const sources=[...new Set([...feedUrls,...publicSearchFeeds,...curatedFeeds,...globalFeeds])].slice(0,24);
 for(const feed of sources){
  if(!safeUrl(feed))continue;
  try{const r=await fetcher(feed,{headers:{accept:"application/rss+xml, application/atom+xml, application/xml, text/xml"},signal:AbortSignal.timeout(9000),redirect:"error"});
   if(!r.ok||Number(r.headers.get("content-length")||0)>1_000_000)continue;
   const xml=(await r.text()).slice(0,1_000_000);
   for(const item of [...xml.matchAll(/<(item|entry)(?:\s[^>]*)?>([\s\S]*?)<\/\1>/gi)].slice(0,100)){
    const body=item[2],title=field(body,"title"),description=field(body,"description")||field(body,"summary")||field(body,"content");
    const atomLink=body.match(/<link\s+[^>]*href=["']([^"']+)["']/i)?.[1];
    const link=field(body,"link")||atomLink||"";
    const words=q.split(/\s+/).filter(w=>w.length>=4);const haystack=(title+" "+description).toLowerCase();const giftSignal=/gratis|kostenlos|zu verschenken|verschenke|free|sample|giveaway|gift|probe|product|gewinnspiel|abzugeben|freecycle/i.test(haystack);const relevant=giftSignal&&(haystack.includes(q)||words.some(w=>haystack.includes(w))||/zu verschenken|kostenlos abzugeben|gratis abholen|free stuff|freecycle/i.test(haystack));if(!safeUrl(link)||!relevant)continue;
    result.push({kind:"gift",sourceUrl:link,title,description,publishedAt:field(body,"pubDate")||field(body,"updated")||null,productKey:null,source:"rss",verified:false});
   }
  }catch{/* one feed must not interrupt other feeds */}
 }
 return [...new Map(result.map(x=>[x.sourceUrl,x])).values()].slice(0,100);
}
export async function searchPublicGithubDemand(query:string,token?:string,fetcher:typeof fetch=fetch):Promise<PublicLead[]>{
 if(!query.trim()||query.length>100)return[];
 const params=new URLSearchParams({q:'is:issue is:open '+query+' ("looking for" OR "want to buy" OR "WTB")',per_page:"30",sort:"updated",order:"desc"});
 const headers:Record<string,string>={accept:"application/vnd.github+json","user-agent":"JARVIS-FreeGoods-ReadOnly"};
 if(token)headers.authorization="Bearer "+token;
 try{const r=await fetcher("https://api.github.com/search/issues?"+params,{headers,signal:AbortSignal.timeout(10000)});
 if(!r.ok)return[];const data=await r.json() as {items?:Array<{html_url?:string;title?:string;body?:string;created_at?:string;pull_request?:unknown}>};
 return (data.items||[]).filter(x=>!x.pull_request&&!!x.html_url&&safeUrl(x.html_url!)).map(x=>({kind:"demand" as const,sourceUrl:x.html_url!,title:clean(x.title||""),description:clean(x.body||""),publishedAt:x.created_at||null,productKey:null,source:"github" as const,verified:false})).slice(0,30);
 }catch{return[]}
}
export async function discoverPublicLeads(query:string,feeds:string[],token?:string,fetcher:typeof fetch=fetch){
 const [gifts,demands]=await Promise.all([searchPublicGiftFeeds(feeds,query,fetcher),searchPublicGithubDemand(query,token,fetcher)]);
 return {gifts,demands,discoveredAt:new Date().toISOString(),warning:"Unverified public leads only. No ownership, buyer consent, resale rights or purchase intent verified."};
}

/** Public demand discovery is separate from product discovery; no personal-data harvesting or unsolicited outreach. */
export async function searchGlobalPublicDemand(query:string,fetcher:typeof fetch=fetch):Promise<PublicLead[]>{
 const regions=[["US","en","want to buy"],["CN","zh-CN","求购"],["DE","de","suche kaufen"],["GB","en","looking to buy"],["FR","fr","cherche acheter"],["CA","en","wanted to buy"],["IT","it","cerco acquisto"],["JP","ja","購入希望"],["AU","en","wanted to buy"],["BR","pt-419","procuro comprar"],["IN","en","bulk buyer"],["ES","es","busco comprar"]];
 const results:PublicLead[]=[];
 for(const [gl,hl,term] of regions){
  const url="https://news.google.com/rss/search?"+new URLSearchParams({q:`${query} ${term}`,hl,gl,ceid:`${gl}:${hl}`}).toString();
  try{const response=await fetcher(url,{headers:{accept:"application/rss+xml, application/atom+xml, application/xml, text/xml"},signal:AbortSignal.timeout(9000),redirect:"error"});if(!response.ok||Number(response.headers.get("content-length")||0)>1_000_000)continue;
   const xml=(await response.text()).slice(0,1_000_000);
   for(const item of [...xml.matchAll(/<(item|entry)(?:\s[^>]*)?>([\s\S]*?)<\/\1>/gi)].slice(0,60)){
    const body=item[2],title=field(body,"title"),description=field(body,"description")||field(body,"summary"),link=field(body,"link")||body.match(/<link\s+[^>]*href=["\x27]([^"\x27]+)["\x27]/i)?.[1]||"";
    if(!safeUrl(link)||!(title+" "+description).toLowerCase().includes(query.toLowerCase()))continue;
    results.push({kind:"demand",sourceUrl:link,title,description,publishedAt:field(body,"pubDate")||null,productKey:null,source:"rss",verified:false});
   }
  }catch{/* keep other regions operational */}
 }
 return [...new Map(results.map(x=>[x.sourceUrl,x])).values()].slice(0,100);
}
/** Conservative matching: lead overlap is not proof of buyer intent, resale rights or profit. */
export function matchPublicLeads(gifts:PublicLead[],demands:PublicLead[]){
 const stop=new Set(["free","gratis","sample","product","products","kostenlos","geschenk","gift","giveaway","buy","want","looking","suche","kaufen"]);
 const tokens=(s:string)=>new Set((s.toLowerCase().match(/[\p{L}\p{N}]{4,}/gu)||[]).filter(x=>!stop.has(x)));
 return gifts.flatMap(g=>demands.flatMap(d=>{const a=tokens(g.title),b=tokens(d.title);const overlap=[...a].filter(x=>b.has(x));return overlap.length>=2?[{gift:g,demand:d,matchingTerms:overlap.slice(0,8),verified:false as const,requires:["resale rights","availability","buyer intent","pricing","delivery capability"]}]:[]})).slice(0,100);
}

/** Evidence-based participant and resale triage. Unknown terms never imply permission. */
export type FreeGoodsAudience="business"|"private"|"women"|"men"|"all"|"unknown";
export type ResaleStatus="allowed"|"prohibited"|"unregulated"|"review";
export type Participant="llc"|"owner"|"mother";
export type OfferAssessment={
 audience:FreeGoodsAudience;resale:ResaleStatus;participants:Participant[];
 decision:"excluded"|"review"|"eligible_for_further_checks";
 reasons:string[];
};
export function assessFreeGoodsOffer(input:{
 title:string;description?:string;terms?:string;audience?:FreeGoodsAudience;
 ownerEligible?:boolean;motherEligible?:boolean;llcEligible?:boolean;
}):OfferAssessment{
 const terms=(input.terms||"").normalize("NFKC").toLowerCase();
 const audience=input.audience||"unknown";
 const prohibited=/\b(?:not for resale|no resale|resale prohibited|not for commercial (?:use|purposes)|personal use only|non-commercial use only|may not (?:resell|sell)|nicht zum weiterverkauf|weiterverkauf (?:untersagt|verboten)|nur für den privaten gebrauch|revente interdite|interdit à la revente|prohibida su reventa|proibida a revenda)\b/i.test(terms);
 const allowed=/\b(?:resale permitted|resale allowed|commercial use permitted|commercial use allowed|weiterverkauf erlaubt|gewerbliche nutzung erlaubt|revente autorisée)\b/i.test(terms);
 const conflicting=prohibited&&allowed;
 const resale:ResaleStatus=conflicting?"review":prohibited?"prohibited":allowed?"allowed":terms?"unregulated":"review";
 const participants:Participant[]=[];
 if((audience==="business"||audience==="all"||audience==="unknown")&&input.llcEligible!==false)participants.push("llc");
 if((audience==="private"||audience==="men"||audience==="all"||audience==="unknown")&&input.ownerEligible!==false)participants.push("owner");
 if((audience==="private"||audience==="women"||audience==="all"||audience==="unknown")&&input.motherEligible!==false)participants.push("mother");
 const reasons:string[]=[];
 if(!input.terms)reasons.push("Full promotion terms not provided");
 if(audience==="unknown")reasons.push("Audience must be verified from original offer");
 if(resale==="unregulated")reasons.push("No explicit resale clause detected; this is not proof of permission");
 if(conflicting)reasons.push("Conflicting resale terms require review");
 if(!participants.length)reasons.push("No eligible participant");
 reasons.push("Verify actual eligibility, household limits, transferable ownership and delivery before acquisition");
 const decision=prohibited&&!conflicting||!participants.length?"excluded":resale!=="allowed"||audience==="unknown"?"review":"eligible_for_further_checks";
 return {audience,resale,participants,decision,reasons};
}
