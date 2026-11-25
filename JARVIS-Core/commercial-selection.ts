// DJO² commercial selection policy — owner instruction 2026-11-25.
export type Offer = { reward:number; hours:number; probability:number; active:boolean; payerVerified:boolean; aiProhibited:boolean; aiRulesReviewed:boolean; payoutReady:boolean; acceptanceCriteria:boolean; licenseCompatible:boolean; assigned:boolean; escrowFunded:boolean; prepaid:boolean; competingPR:boolean; authorizedScope:boolean; upfrontCost:number };
export function evaluateOffer(o:Offer) {
 const blockers:string[]=[];
 if(!o.active) blockers.push("inactive");
 if(!o.payerVerified) blockers.push("payer unverified");
 if(o.aiRulesReviewed!==true) blockers.push("AI rules not reviewed");
 if(o.aiProhibited!==false) blockers.push("AI use prohibited or prohibition status unknown");
 if(!o.payoutReady) blockers.push("payout unavailable");
 if(!o.acceptanceCriteria) blockers.push("acceptance unclear");
 if(!o.licenseCompatible) blockers.push("license conflict");
 if(!o.authorizedScope) blockers.push("scope unauthorized");
 if(o.upfrontCost!==0) blockers.push("zero-spend");
 if(!o.assigned&&!o.prepaid) blockers.push("assignment missing");
 if(o.competingPR&&!o.assigned) blockers.push("competition");
 if(!Number.isFinite(o.reward)||o.reward<=0||!Number.isFinite(o.hours)||o.hours<=0||!Number.isFinite(o.probability)||o.probability<0||o.probability>1) blockers.push("invalid estimate");
 const eligible=blockers.length===0;
 const tier=o.prepaid?3:o.escrowFunded?2:o.assigned?1:0;
 return {eligible,blockers,tier,expectedHourly:eligible?o.reward*o.probability/o.hours:0};
}
export function rankOffers(offers:Offer[]) {return offers.map(offer=>({offer,...evaluateOffer(offer)})).filter(x=>x.eligible).sort((a,b)=>b.tier-a.tier||b.expectedHourly-a.expectedHourly);}
 // AI need not be expressly permitted: reviewed applicable rules must not prohibit the intended AI-assisted work. Honor disclosure, human review and other conditions. Unknown prohibition status blocks execution; other unknown positive evidence must be false. Reward must be normalized to a common currency.
 // Estimates are not observed probabilities. No payout is guaranteed.
 // Paid status requires independently reconciled receipt; never count leads as income.
