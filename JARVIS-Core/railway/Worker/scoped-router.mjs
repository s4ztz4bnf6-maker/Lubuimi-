import {actualTokens} from "./budgeted-model.mjs";
export function outputCap(reserved,input,maxOutput,safety=512){
 if(![reserved,input,maxOutput,safety].every(Number.isSafeInteger)||reserved<1||input<0||maxOutput<1||safety<0||reserved-input-safety<1)throw new Error("OUTPUT_BUDGET_EXCEEDED");
 return Math.min(maxOutput,reserved-input-safety);
}
export function createScopedRouter({approvedRoutes,transport,maxOutput=1024,safety=512}){
 return async ({provider,model,baseUrl,reserved,messages,tools=[],callId})=>{
  const key=JSON.stringify([provider,model,baseUrl]);
  if(!approvedRoutes.has(key))throw Object.assign(new Error("ZERO_SPEND_FALLBACK_BLOCKED"),{actualUsage:0});
  let maxTokens;
  try{maxTokens=outputCap(reserved,Buffer.byteLength(JSON.stringify({model,messages,tools}),"utf8"),maxOutput,safety);}
  catch(e){e.actualUsage=0;throw e;}
  const response=await transport({provider,model,baseUrl,messages,tools,callId,max_tokens:maxTokens,allowFallback:false,zeroSpend:true});
  const usage=response?.usage;
  const normalized={totalTokens:usage?.total_tokens??usage?.totalTokens,inputTokens:usage?.prompt_tokens??usage?.inputTokens,outputTokens:usage?.completion_tokens??usage?.outputTokens};
  const actual=actualTokens(normalized);
  if(response?.isPaid===true||Number(response?.costEur??0)>0)throw Object.assign(new Error("ZERO_SPEND_VIOLATION"),{actualUsage:actual});
  return {result:response?.choices?.[0]?.message,usage:normalized};
 };
}
