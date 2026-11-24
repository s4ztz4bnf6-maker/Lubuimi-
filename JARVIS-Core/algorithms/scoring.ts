// SPDX-License-Identifier: Apache-2.0
// Deterministic, side-effect-free candidate scoring; no spending or orders.
export const version="0.1.0";
const finite=(x:number)=>{if(!Number.isFinite(x))throw new Error("non-finite input");return x};
export function net(revenue:number,cost:number){return finite(revenue)-finite(cost)}
export function sgl(costCents:number){if(!Number.isSafeInteger(costCents)||costCents<0)throw new Error("invalid cost");const fee=Math.max(249,Math.round(costCents*.3));return {fee,total:costCents+fee,bookable:false}}
export function sales(price:number,cost:number,probability:number){return net(price,cost)*prob(probability)}
function prob(p:number){if(!Number.isFinite(p)||p<0||p>1)throw new Error("invalid probability");return p}
export function bounty(reward:number,cost:number,p:number){return finite(reward)*prob(p)-finite(cost)}
export function exchange(received:number,paid:number,fees:number){return net(received,paid+fees)}
export function chat(quality:number,cost:number){return prob(quality)-finite(cost)}
export function cybersecurity(impact:number,p:number){return finite(impact)*prob(p)}
export function finance(revenues:number[],costs:number[]){return net(revenues.reduce((a,b)=>a+finite(b),0),costs.reduce((a,b)=>a+finite(b),0))}
export function tradingPaper(signal:number,vol:number){if(!Number.isFinite(vol)||vol<=0) return 0;return Math.max(-.25,Math.min(.25,Math.max(-1,Math.min(1,finite(signal)))*.01/(2*vol)))}
export function compareCandidate(incumbent:number[],candidate:number[]){if(incumbent.length!==candidate.length||candidate.length<30)throw new Error("paired holdout required");const delta=candidate.map((v,i)=>finite(v)-finite(incumbent[i]));return {meanDelta:delta.reduce((a,b)=>a+b,0)/delta.length,automaticPromotion:false}}
