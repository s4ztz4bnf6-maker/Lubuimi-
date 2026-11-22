/** Discovery triage only. Values are estimates, never proof of eligibility or revenue. */
import type {PublicLead} from "./freegoods-discovery";
export type RankedLead=PublicLead&{score:number;signals:string[];flags:string[]};
const luxury=/\b(apple|sony|samsung|dyson|bose|canon|nikon|lego|nintendo|garmin|gopro|dji|rolex|omega|playstation|xbox)\b/i;
const value=/\b(camera|laptop|phone|smartphone|headphones|console|watch|drone|tablet|computer|gpu|graphics card|luxury|limited edition|collector|rare|premium|high.end|sealed|new in box)\b/i;
const gift=/\b(free|giveaway|gift|sample|gratis|kostenlos|geschenk|verschenke|zu verschenken|donation|donate)\b/i;
const scam=/\b(activation fee|shipping deposit|crypto deposit|seed phrase|wallet connect|pay to claim|advance fee|processing fee)\b/i;
const restrictions=/\b(not for resale|no resale|personal use only|non.transferable|nicht zum weiterverkauf|nur für den eigenbedarf|nicht übertragbar)\b/i;
export function rankLead(lead:PublicLead):RankedLead{
 const body=lead.title+" "+lead.description,signals:string[]=[],flags:string[]=[];
 if(luxury.test(body))signals.push("recognized_brand");
 if(value.test(body))signals.push("potential_high_value");
 if(gift.test(body)&&lead.kind==="gift")signals.push("gift_language");
 if(scam.test(body))flags.push("potential_fee_scam");
 if(restrictions.test(body))flags.push("possible_resale_restriction");
 if(!lead.productKey)flags.push("exact_product_identity_unknown");
 flags.push("terms_and_entitlement_unverified");
 const score=Math.max(0,Math.min(100,20+(signals.includes("recognized_brand")?25:0)+(signals.includes("potential_high_value")?25:0)+(signals.includes("gift_language")?15:0)-(flags.includes("potential_fee_scam")?70:0)-(flags.includes("possible_resale_restriction")?50:0)));
 return {...lead,score,signals,flags};
}
export function rankLeads(leads:PublicLead[],max=100):RankedLead[]{
 return [...new Map(leads.map(l=>[l.sourceUrl,l])).values()].map(rankLead).sort((a,b)=>b.score-a.score||a.sourceUrl.localeCompare(b.sourceUrl)).slice(0,Math.max(0,Math.min(max,100)));
}
export function pairCandidates(gifts:RankedLead[],demands:RankedLead[]){
 const demandByProduct=new Map<string,RankedLead[]>();
 for(const d of demands){if(!d.productKey)continue;demandByProduct.set(d.productKey,[...(demandByProduct.get(d.productKey)||[]),d])}
 return gifts.flatMap(g=>g.productKey?(demandByProduct.get(g.productKey)||[]).map(d=>({gift:g,demand:d,verification:"manual_required" as const})):[]);
}
