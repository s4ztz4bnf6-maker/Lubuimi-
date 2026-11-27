// SPDX-License-Identifier: LicenseRef-DJO2-Proprietary
import {createHash} from "node:crypto";
export const estimateRequest = value => Math.ceil(Buffer.byteLength(JSON.stringify(value),"utf8")/2.5);
export function planContextSteps({taskId,system,pinned=[],goal,sections,materialParts=[""],tools=[],model,limit,maxSteps=40}){
 if(taskId===undefined||taskId===null||!Array.isArray(sections)||!sections.length||!sections.every(x=>typeof x==="string"&&x.trim())||!Array.isArray(pinned)||!pinned.every(x=>typeof x==="string")||!Array.isArray(materialParts)||!materialParts.length||!materialParts.every(x=>typeof x==="string")||!Number.isSafeInteger(limit)||limit<=0)throw Error("INVALID_CONTEXT_PLAN");
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
  const id=createHash("sha256").update(JSON.stringify({taskId,limit,model,messages,tools:chosen,index:steps.length})).digest("hex");
  steps.push({id,messages,tools:chosen});
 }
 return steps;
}

const MUST = /\b(muss|müssen|darf nicht|dürfen nicht|niemals|nie|verbindlich|zero-spend|ohne freigabe|verboten|must|shall|never|prohibited|do not|only)\b/iu;
export function autoSectionize(text,budget){
 if(typeof text!=="string"||!text.trim()||!Number.isSafeInteger(budget)||budget<100)throw Error("INVALID_CONTEXT_PLAN");
 const pinned=[],instructions=[],warnings=[];
 const max=Math.floor(budget*.15),cap=Math.floor(budget*.25);
 for(const piece of text.split(/\n{2,}|\n(?=\s*(?:\d+[.)]\s|[-*•]\s|#{1,4}\s))/u).filter(x=>x.trim())){
  if(MUST.test(piece)){
   pinned.push(piece);
   if(estimateRequest(pinned)>cap)throw Error("PINNED_OVERFLOW");
   continue;
  }
  if(estimateRequest(piece)<=max){instructions.push(piece);continue;}
  for(const sentence of piece.split(/(?<=[.!?])\s+/u)){
   if(estimateRequest(sentence)>max)throw Error("INSTRUCTIONS_EXCEED_MODEL");
   instructions.push(sentence);
  }
 }
 if(!instructions.length)instructions.push("Complete the task subject to all pinned rules.");
 return {pinned,instructions,warnings};
}

 // Candidates must originate from the server-side verified tariff registry.
export function planWithEscalation(base,raw,candidates){
 const failures=[];
 for(const candidate of candidates.filter(c=>c.zeroSpendVerified===true&&Number.isSafeInteger(c.limit)&&c.limit>=100).sort((a,b)=>a.limit-b.limit)){
  try{
   const section=autoSectionize(raw,candidate.limit);
   const pinned=[...new Set([...(base.pinned??[]),...section.pinned])];
   if(estimateRequest(pinned)>Math.floor(candidate.limit*.25))throw Error("PINNED_OVERFLOW");
   const steps=planContextSteps({...base,pinned,sections:section.instructions,model:candidate.model,limit:candidate.limit});
   return {candidate,steps,warnings:section.warnings};
  }catch(e){
   if(!["PINNED_OVERFLOW","INSTRUCTIONS_EXCEED_MODEL","TASK_TOO_LARGE"].includes(e.message))throw e;
   failures.push(e.message);
  }
 }
 throw Error("NO_MODEL_AVAILABLE: "+(failures.join(",")||"NO_VERIFIED_ZERO_SPEND_MODEL"));
}
