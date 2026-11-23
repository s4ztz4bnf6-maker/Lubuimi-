/** Read-only public discovery. Feed URLs must be administrator-approved HTTPS sources. */
export type PublicLead={kind:"gift"|"demand";sourceUrl:string;title:string;description:string;publishedAt:string|null;productKey:string|null;source:"rss"|"github";verified:false};
function clean(s:string){return s.replace(/<[^>]*>/g," ").replace(/&amp;/g,"&").replace(/&lt;/g,"<").replace(/&gt;/g,">").replace(/\s+/g," ").trim().slice(0,500)}
function field(xml:string,name:string){const m=xml.match(new RegExp("<(?:[\\w-]+:)?"+name+"(?:\\s[^>]*)?>([\\s\\S]*?)<\\/(?:[\\w-]+:)?"+name+">","i"));return m?clean(m[1].replace(/<!\[CDATA\[([\s\S]*?)\]\]>/g,"$1")):""}
function safeUrl(u:string){try{const x=new URL(u);return x.protocol==="https:"&&!x.username&&!x.password&&!["localhost","127.0.0.1","::1"].includes(x.hostname)&&!x.hostname.endsWith(".local")}catch{return false}}
/** No hidden service or Tor support unless an independently audited, approved connector is configured. */
export async function searchPublicGiftFeeds(feedUrls:string[],query:string,fetcher:typeof fetch=fetch):Promise<PublicLead[]>{
 const result:PublicLead[]=[];const q=query.toLowerCase().trim();if(!q||q.length<2)return result;
 const discoveryQueries=[`(${query} OR gratis OR kostenlos OR freebie OR giveaway)`, `("${query}" "free sample")`];
 const publicSearchFeeds=discoveryQueries.map(q=>"https://news.google.com/rss/search?"+new URLSearchParams({q,hl:"en",gl:"US",ceid:"US:en"}).toString());
 const publicSourceSearches=["site:kostenlos.de/gratisartikel-uebersicht gratisproben","site:mein-deal.com/gratisproben kostenlose produktproben","site:proben-kostenlos.de gratisproben","site:gratiswunder.de gratisproben"];const curatedFeeds=publicSourceSearches.map(q=>"https://news.google.com/rss/search?"+new URLSearchParams({q,hl:"de",gl:"DE",ceid:"DE:de"}).toString());
 const sources=[...new Set([...feedUrls,...publicSearchFeeds,...curatedFeeds])].slice(0,12);
 for(const feed of sources){
  if(!safeUrl(feed))continue;
  try{const r=await fetcher(feed,{headers:{accept:"application/rss+xml, application/atom+xml, application/xml, text/xml"},signal:AbortSignal.timeout(9000),redirect:"error"});
   if(!r.ok||Number(r.headers.get("content-length")||0)>1_000_000)continue;
   const xml=(await r.text()).slice(0,1_000_000);
   for(const item of [...xml.matchAll(/<(item|entry)(?:\s[^>]*)?>([\s\S]*?)<\/\1>/gi)].slice(0,100)){
    const body=item[2],title=field(body,"title"),description=field(body,"description")||field(body,"summary")||field(body,"content");
    const atomLink=body.match(/<link\s+[^>]*href=["']([^"']+)["']/i)?.[1];
    const link=field(body,"link")||atomLink||"";
    const words=q.split(/\s+/).filter(w=>w.length>=4);const haystack=(title+" "+description).toLowerCase();const relevant=haystack.includes(q)||words.some(w=>haystack.includes(w))&&/gratis|kostenlos|free|sample|giveaway|gift|probe|product|gewinnspiel/i.test(haystack);if(!safeUrl(link)||!relevant)continue;
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
