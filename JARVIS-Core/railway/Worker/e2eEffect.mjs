// SPDX-License-Identifier: LicenseRef-DJO2-Proprietary
import { runToolOnce } from "./providerRotationDb.mjs";
export const maybeE2eTools = ({sql,taskId}) => {
 if(process.env.DJO2_E2E !== "1") return [];
 return [{type:"function",function:{name:"e2e_external_effect",description:"Test-only external effect",parameters:{type:"object",properties:{step:{type:"integer"}},required:["step"],additionalProperties:false}},run:async(args)=>{
 const base=new URL(process.env.E2E_EFFECT_URL);
 if(base.protocol!=="http:" || base.hostname!=="127.0.0.1") throw Error("E2E requires loopback");
 if(!Number.isSafeInteger(args.step)||args.step<1) throw Error("Invalid step");
 const key=`e2e-${taskId}-step-${args.step}`;
 const out=await runToolOnce(sql,taskId,"e2e_external_effect",args,async()=>{
 const r=await fetch(new URL("/effect",base),{method:"POST",headers:{"content-type":"application/json","idempotency-key":key},body:JSON.stringify({key,step:args.step})});
 if(!r.ok) throw Error("effect HTTP "+r.status);
 return r.json();
 },"public",async()=>{
 const u=new URL("/effect",base);u.searchParams.set("key",key);
 const r=await fetch(u);if(!r.ok) throw Error("lookup HTTP "+r.status);
 const j=await r.json();return j.found===true?{found:true,result:j.result}:null;
 });
 return out.status==="unknown"?out.message:JSON.stringify(out.result);
 }}];
};
