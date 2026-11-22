/** Bounded orchestration policy: no imaginary agents, no spending, no transfers. */
export type WorkItem={id:string;customerAuthorized:boolean;paidTermsAgreed:boolean;estimatedCostCents:number;priority:number;state:"queued"|"running"|"done"|"failed";attempts:number};
export type DispatchDecision={accepted:string[];held:{id:string;reason:string}[]};
export function planDispatch(items:WorkItem[],options:{maxParallel:number;maxRetries:number;maxNewSpendCents:number}):DispatchDecision{
 const {maxParallel,maxRetries,maxNewSpendCents}=options;
 if(!Number.isSafeInteger(maxParallel)||maxParallel<0||maxParallel>1000||!Number.isSafeInteger(maxRetries)||maxRetries<0||!Number.isSafeInteger(maxNewSpendCents)||maxNewSpendCents<0)throw new Error("Invalid limits");
 const running=items.filter(i=>i.state==="running").length;
 const accepted:string[]=[],held:{id:string;reason:string}[]=[];
 const seen=new Set<string>();let budget=maxNewSpendCents;
 for(const i of [...items].filter(i=>i.state==="queued"||i.state==="failed").sort((a,b)=>b.priority-a.priority||a.id.localeCompare(b.id))){
  let reason="";
  if(!i.id||seen.has(i.id))reason="duplicate_or_missing_id";
  else if(!i.customerAuthorized||!i.paidTermsAgreed)reason="not_authorized_or_terms_missing";
  else if(!Number.isSafeInteger(i.estimatedCostCents)||i.estimatedCostCents<0)reason="invalid_cost";
  else if(!Number.isSafeInteger(i.attempts)||i.attempts<0||i.attempts>=maxRetries)reason="retry_limit";
  else if(accepted.length+running>=maxParallel)reason="parallel_limit";
  else if(i.estimatedCostCents>budget)reason="budget_limit";
  seen.add(i.id);
  if(reason)held.push({id:i.id,reason});else{accepted.push(i.id);budget-=i.estimatedCostCents}
 }
 return {accepted,held};
}
