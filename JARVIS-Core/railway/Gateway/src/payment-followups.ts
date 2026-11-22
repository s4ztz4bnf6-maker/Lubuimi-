/** Deterministic, side-effect-free payment follow-up planner. No network, mail or bank access. */
export type Invoice = {id:string; number:string; amountMinor:number; currency:"EUR"|"USD"|"BTC"; dueAt:string; status:"open"|"paid"|"disputed"|"cancelled"; customerContactVerified:boolean; lastNoticeAt?:string; reminderCount:number};
export type Notice = {invoiceId:string; kind:"reminder"|"final_reminder"; earliestSendAt:string; requiresApproval:boolean};
const DAY=86400000;
export function planPaymentFollowups(invoices:Invoice[],now=new Date()):Notice[] {
 const today=now.getTime();
 if(!Number.isFinite(today)) throw new Error("Invalid time");
 return invoices.flatMap(i=>{
  if(i.status!=="open" || !i.customerContactVerified || !Number.isSafeInteger(i.amountMinor) || i.amountMinor<=0 || i.reminderCount<0 || !Number.isInteger(i.reminderCount)) return [];
  const due=Date.parse(i.dueAt), last=i.lastNoticeAt?Date.parse(i.lastNoticeAt):null;
  if(!Number.isFinite(due) || (last!==null&&!Number.isFinite(last)) || today<due+3*DAY || i.reminderCount>=2) return [];
  if(last!==null && today<last+7*DAY) return [];
  return [{invoiceId:i.id,kind:i.reminderCount===0?"reminder":"final_reminder",earliestSendAt:new Date(today).toISOString(),requiresApproval:true}];
 });
}
