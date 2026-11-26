// SPDX-License-Identifier: LicenseRef-DJO2-Proprietary
import {createHash} from "node:crypto";
export const estimateRequest = value => Math.ceil(Buffer.byteLength(JSON.stringify(value),"utf8")/2.5);
export function planContextSteps({system,pinned=[],goal,sections,materialParts=[""],tools=[],model,limit,maxSteps=40}){
 if(!Array.isArray(sections)||!sections.length||!sections.every(x=>typeof x==="string"&&x.trim())||!Array.isArray(pinned)||!pinned.every(x=>typeof x==="string")||!Array.isArray(materialParts)||!materialParts.length||!materialParts.every(x=>typeof x==="string")||!Number.isSafeInteger(limit)||limit<=0)throw Error("INVALID_CONTEXT_PLAN");
 if(sections.length*materialParts.length>Math.min(40,maxSteps))throw Error("TASK_TOO_LARGE");
 const fixed=[...system,...(pinned.length?[{role:"system",content:pinned.join("\n")}]:[])];
 const steps=[];
 for(const part of materialParts)for(const section of sections){
  const messages=[...fixed,{role:"user",content:JSON.stringify({goal,section,material:part})}];
  const base=estimateRequest({model,messages,tools:[]});
  // Reserve space for the persisted handoff; never truncate rules or material.
  const remaining=limit-base-700;
  if(remaining<0)throw Error("INSTRUCTIONS_EXCEED_MODEL");
  const chosen=[];
  for(const tool of tools){
   const candidate=[...chosen,tool];
   if(estimateRequest(candidate)-estimateRequest([])<=Math.floor(remaining*.3)&&estimateRequest({model,messages,tools:candidate})+700<=limit)chosen.push(tool);
  }
  const id=createHash("sha256").update(JSON.stringify({model,messages,tools:chosen,index:steps.length})).digest("hex");
  steps.push({id,messages,tools:chosen});
 }
 return steps;
}
