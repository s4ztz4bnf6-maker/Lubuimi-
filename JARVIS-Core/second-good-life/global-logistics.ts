// SPDX-License-Identifier: Apache-2.0
// SGL-GLOA: minimum cost over eligible quoted routes, not a coverage guarantee.
export type Leg={from:string;to:string;provider:string;minor:number;currency:string;expiresAt:number;verified:boolean;eligible:boolean;shipmentId:string;departAt:number;arriveAt:number};
export function optimize(legs:Leg[],origin:string,destination:string,currency:string,shipmentId:string,now:number,deadline:number,maxLegs=5){
 const eligible=legs.filter(l=>l.verified&&l.eligible&&l.shipmentId===shipmentId&&l.currency===currency&&l.expiresAt>now&&Number.isSafeInteger(l.minor)&&l.minor>=0&&l.departAt>=now&&l.arriveAt>=l.departAt&&l.arriveAt<=deadline);
 let best:{legs:Leg[];cost:number}|null=null;
 function visit(node:string,time:number,cost:number,path:Leg[],seen:Set<string>){
 if(node===destination){if(!best||cost<best.cost)best={legs:path,cost};return;}
 if(path.length>=maxLegs||(best&&cost>=best.cost))return;
 for(const l of eligible){if(l.from!==node||seen.has(l.to)||l.departAt<time||!Number.isSafeInteger(cost+l.minor))continue;
 visit(l.to,l.arriveAt,cost+l.minor,[...path,l],new Set([...seen,l.to]));}
 }
 visit(origin,now,0,[],new Set([origin]));
 const result=best as {legs:Leg[];cost:number}|null;
 if(!result)return null;
 const fee=Math.max(currency === "EUR" ? 249 : 0, Math.round(result.cost*0.30));
 return {...result,fee,total:result.cost+fee,currency,bookable:false};
}
