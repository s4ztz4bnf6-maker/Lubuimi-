/** Open-bounty router: only explicitly open, authorized submissions may be worked speculatively. */
export type Bounty={id:string;sourceUrl:string;title:string;description:string;reward:number;currency:string;deadline:string;submissionPolicy:'open'|'approval_required'|'unknown';aiAllowed:boolean;authorizationConfirmed:boolean;skills:string[];estimatedHours:number;estimatedExternalCost:number;};
export type Agent={id:string;skills:string[];available:boolean;estimatedHourlyCost:number;};
export type Decision={bountyId:string;eligible:boolean;reason:string;agentIds:string[];estimatedMargin:number;requiresApproval:boolean};
export function planOpenBounty(b:Bounty,agents:Agent[],now=new Date()):Decision{
 const reject=(reason:string):Decision=>({bountyId:b.id,eligible:false,reason,agentIds:[],estimatedMargin:0,requiresApproval:true});
 if(!/^https:\/\//.test(b.sourceUrl))return reject('unverified_source');
 if(b.submissionPolicy!=='open'||!b.authorizationConfirmed)return reject('no_open_submission_authorization');
 if(!b.aiAllowed)return reject('ai_use_not_permitted');
 if(!Number.isFinite(b.reward)||b.reward<=0||!Number.isFinite(b.estimatedHours)||b.estimatedHours<=0||!Number.isFinite(b.estimatedExternalCost)||b.estimatedExternalCost<0)return reject('invalid_economics');
 if(!Number.isFinite(Date.parse(b.deadline))||Date.parse(b.deadline)<=now.getTime())return reject('deadline_passed');
 const qualified=agents.filter(a=>a.available&&b.skills.every(s=>a.skills.includes(s))&&Number.isFinite(a.estimatedHourlyCost)&&a.estimatedHourlyCost>=0).sort((a,c)=>a.estimatedHourlyCost-c.estimatedHourlyCost);
 if(!qualified.length)return reject('no_qualified_agent');
 const agent=qualified[0];const margin=b.reward-b.estimatedExternalCost-agent.estimatedHourlyCost*b.estimatedHours;
 if(margin<=0)return reject('nonpositive_estimated_margin');
 return {bountyId:b.id,eligible:true,reason:'eligible_for_work_not_guaranteed_payment',agentIds:[agent.id],estimatedMargin:margin,requiresApproval:false};
}
