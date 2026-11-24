// SPDX-License-Identifier: Apache-2.0
export type Listing = { id:string; title:string; category:string; country:string; url:string; active:boolean; free:boolean; confirmed:boolean };
export type Wanted = { id:string; title:string; category:string; country:string; url:string; active:boolean };
export type Quote = { provider:string; cents:number; currency:string; expiresAt:number; suitable:boolean; verified:boolean };
const words=(s:string)=>new Set(s.toLowerCase().normalize("NFKC").split(/[^\p{L}\p{N}]+/u).filter(Boolean));
export function match(offers:Listing[], wants:Wanted[]) {
 return offers.filter(o=>o.active&&o.free&&o.url).flatMap(o=>wants.filter(w=>w.active&&w.url&&w.category===o.category).map(w=>{
 const a=words(o.title), b=words(w.title); const score=[...a].filter(x=>b.has(x)).length/Math.max(1,new Set([...a,...b]).size);
 return {offer:o,wanted:w,score,confirmed:false};
 })).filter(x=>x.score>=0.5).sort((a,b)=>b.score-a.score);
}
export function cheapest(quotes:Quote[],currency:string,now=Date.now()){
 const q=quotes.filter(q=>q.verified&&q.suitable&&q.currency===currency&&q.expiresAt>now&&Number.isSafeInteger(q.cents)&&q.cents>=0).sort((a,b)=>a.cents-b.cents)[0];
 if(!q)return null;
 const fee=Math.max(currency === "EUR" ? 249 : 0, Math.round(q.cents*0.30));
 return {...q,itemCents:0,feeCents:fee,totalCents:q.cents+fee};
}
export function mayBook(totalCents:number,settledCents:number,ownerApproved:boolean){
 return Number.isSafeInteger(totalCents)&&totalCents>=0&&settledCents>=totalCents&&ownerApproved;
}
