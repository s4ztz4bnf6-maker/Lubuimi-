export type AgentStatus="offered"|"accepted"|"running"|"delivered"|"submitted"|"customer_accepted"|"invoiced"|"payment_verified"|"failed";
export interface AgentMessage {version:1;taskId:string;sender:string;recipient:string;status:AgentStatus;artifactUrls:string[];evidenceUrls:string[];correlationId:string}
export function validateAgentMessage(x:unknown):x is AgentMessage {
 if(!x||typeof x!=="object")return false;
 const m=x as Partial<AgentMessage>;
 const states=["offered","accepted","running","delivered","submitted","customer_accepted","invoiced","payment_verified","failed"];
 return m.version===1&&states.includes(m.status||"")&&
 [m.taskId,m.sender,m.recipient,m.correlationId].every(v=>typeof v==="string"&&v.length>0&&v.length<=256)&&
 Array.isArray(m.artifactUrls)&&Array.isArray(m.evidenceUrls)&&
 m.artifactUrls.length<=20&&m.evidenceUrls.length<=20&&
 [...m.artifactUrls,...m.evidenceUrls].every(v=>typeof v==="string"&&v.length<=2048&&v.startsWith("https://"));
}
/* Before transport: authenticate peers, verify signatures, authorize capabilities,
 validate URLs against SSRF, scan files, persist receipts. Never treat an agent's
 assertion as proof of contract, delivery, invoice payment or bank settlement. */
