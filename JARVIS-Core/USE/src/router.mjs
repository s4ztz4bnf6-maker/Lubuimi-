// SPDX-License-Identifier: LicenseRef-DJO2-Proprietary
export async function scrape({url,mode="auto",department,adapters,policy,audit,signal}) {
 const target=new URL(url);
 if(!["https:","http:"].includes(target.protocol)||target.username||target.password)throw new Error("invalid target");
 const modes=mode==="auto"?["static","article","browser","markdown"]:[mode];
 for(const name of modes){
  if(signal?.aborted)throw new Error("stopped");
  const adapter=adapters.get(name);
  if(!adapter)continue;
  const permit=await policy.authorize({url:target.href,department,mode:name});
  if(permit?.allowed!==true||permit.zeroSpend!==true||permit.networkIsolated!==true)return {state:"blocked"};
  try{
   const result=await adapter.fetch({url:target.href,permit,signal});
   await audit({department,mode:name,state:result.state});
   if(result.state==="access_denied"||result.state==="rate_limited")return {state:result.state};
   if(result.state==="ok"&&typeof result.text==="string"&&result.text.trim())return {state:"ok",mode:name,trust:"untrusted_external_data",text:result.text.slice(0,15000)};
  }catch(e){await audit({department,mode:name,state:"error"});throw e;}
 }
 return {state:"unavailable"};
}
