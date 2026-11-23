/** JARVIS external AI model router. Provider adapters represent configured endpoints, not hypothetical access. */
export type ModelEndpoint={id:string;kind:'open_source'|'hosted';capabilities:string[];enabled:boolean;costPerAttempt:number;invoke:(request:{capability:string;input:string},signal:AbortSignal)=>Promise<{ok:boolean;output?:string;error?:'timeout'|'unavailable'|'rate_limit'|'unsupported'|'permission_denied'|'invalid_request'|'unknown'}>};
export type ModelRun={ok:boolean;output?:string;modelId?:string;attempted:string[];reason:string};
export async function runAcrossModels(capability:string,input:string,endpoints:ModelEndpoint[],opts:{maxAttempts?:number;budget?:number;timeoutMs?:number}={}):Promise<ModelRun>{
 const attempted:string[]=[];let spent=0;const max=Math.min(20,Math.max(1,opts.maxAttempts??endpoints.length));const budget=opts.budget??Number.POSITIVE_INFINITY;
 const models=endpoints.filter(e=>e.enabled&&e.capabilities.includes(capability)&&Number.isFinite(e.costPerAttempt)&&e.costPerAttempt>=0).sort((a,b)=>a.costPerAttempt-b.costPerAttempt);
 for(const m of models.slice(0,max)){
  if(spent+m.costPerAttempt>budget)return {ok:false,attempted,reason:'budget_exceeded'};
  spent+=m.costPerAttempt;attempted.push(m.id);const c=new AbortController();let timer:ReturnType<typeof setTimeout>|undefined;
  try{const res=await Promise.race([m.invoke({capability,input},c.signal),new Promise<{ok:boolean;error:'timeout'}>(resolve=>{timer=setTimeout(()=>{c.abort();resolve({ok:false,error:'timeout'})},Math.max(1000,Math.min(120000,opts.timeoutMs??30000)))})]);
   if(res.ok&&typeof res.output==='string')return {ok:true,output:res.output,modelId:m.id,attempted,reason:'completed'};
   if(res.error==='permission_denied'||res.error==='invalid_request')return {ok:false,attempted,reason:res.error};
  }catch{/* a failing endpoint may be replaced by another configured model */}
  finally{if(timer)clearTimeout(timer)}
 }
 return {ok:false,attempted,reason:models.length?'no_model_completed':'no_configured_model_with_capability'};
}
