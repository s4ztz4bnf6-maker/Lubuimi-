/** Public bounty triage: no bid, customer contact, spending or contract acceptance. */
export type Lead={id:string;title:string;body:string;url:string;labels:string[];isOpen:boolean;isPullRequest:boolean;isPrivate:boolean};
export type LeadAssessment={id:string;status:"review"|"reject";reasons:string[];advertisedRewardUsd:number|null;aiPermission:"explicit"|"unknown"|"prohibited";payoutVerified:false;acceptanceVerified:false;score:number};
export function assessLead(lead:Lead):LeadAssessment{
 const text=(lead.title+"\n"+lead.body).slice(0,12000);
 const reasons:string[]=[];
 if(!lead.isOpen||lead.isPrivate||lead.isPullRequest)reasons.push("not_public_open_issue");
 if(!/^https:\/\/github\.com\/[\w.-]+\/[\w.-]+\/issues\/\d+(?:[?#].*)?$/.test(lead.url))reasons.push("untrusted_url");
 if(/(?:upfront|registration|application|processing)\s+fee|deposit\s+(?:first|required)|pay\s+to\s+(?:apply|start)|seed phrase|private key|wallet connect/i.test(text))reasons.push("payment_or_secret_risk");
 const prohibited=/(?:no|without|prohibit(?:ed)?)\s+(?:ai|bots?|automated|llm)\s+(?:assistance|agents?|submissions?|content|tools?)/i.test(text);
 const explicit=/(?:ai|llm|automated)\s+(?:assistance|agents?|tools?)\s+(?:is\s+)?(?:allowed|permitted|welcome)/i.test(text);
 const aiPermission=prohibited?"prohibited":explicit?"explicit":"unknown";
 if(prohibited)reasons.push("ai_prohibited");
 const money=text.match(/(?:USD\s*|\$\s*)(\d{1,6}(?:,\d{3})*(?:\.\d{1,2})?)(?!\d)/i);
 const reward=money?Number(money[1].replace(/,/g,"")):null;
 if(reward===null||!Number.isFinite(reward)||reward<=0)reasons.push("reward_unverified");
 const status=reasons.length?"reject":"review";
 return {id:lead.id,status,reasons,advertisedRewardUsd:reward,aiPermission,payoutVerified:false,acceptanceVerified:false,score:status==="review"?Math.min(100,Math.round((reward||0)/20)+(explicit?20:0)):0};
}
