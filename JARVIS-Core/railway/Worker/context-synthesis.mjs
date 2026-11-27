// SPDX-License-Identifier: LicenseRef-DJO2-Proprietary
// Copyright (c) 2026 Ta-Yoshua Lubuimi. All rights reserved.
export async function synthesizeContext({outputs,synthesize,isOverflow,maxStages=5,maxCalls=80}){
 if(!Array.isArray(outputs)||!outputs.length||outputs.length>40||outputs.some(x=>typeof x!=="string"||!x.trim()))throw Error("INVALID_SYNTHESIS_INPUT");
 let calls=0;
 async function reduce(parts,depth){
  if(depth>maxStages||++calls>maxCalls)throw Error("SYNTHESIS_LIMIT_EXCEEDED");
  try{
   const result=await synthesize(parts.join("\n\n---\n\n"));
   if(typeof result!=="string"||!result.trim())throw Error("SYNTHESIS_INCOMPLETE");
   return result;
  }catch(error){
   if(!isOverflow(error))throw error;
   let left,right;
   if(parts.length>1){const mid=Math.ceil(parts.length/2);left=parts.slice(0,mid);right=parts.slice(mid);}
   else {const chars=Array.from(parts[0]);if(chars.length<2)throw error;const mid=Math.ceil(chars.length/2);left=[chars.slice(0,mid).join("")];right=[chars.slice(mid).join("")];}
   const a=await reduce(left,depth+1),b=await reduce(right,depth+1);
   if(a.length+b.length>=parts.join("").length)throw Error("SYNTHESIS_NO_PROGRESS");
   return reduce([a,b],depth+1);
  }
 }
 return reduce(outputs,1);
}
