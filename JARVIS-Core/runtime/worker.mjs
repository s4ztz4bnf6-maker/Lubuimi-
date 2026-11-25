/**
 * Minimal autonomous worker loop. Host supplies durable queue, agents, handlers,
 * verifier and audit adapters. Handler output is never trusted until verified.
 */
import { requireHumanApproval } from "./autonomous-agent-runtime.mjs";

export class RuntimeWorker {
  constructor({ queue, agents, handlers, verifier, audit = async () => {}, resolveAgent,
    authorizeAction = async ({ task }) =>
      !requireHumanApproval(task.payload?.action ?? task.action ?? task.type),
    requestApproval = null, leaseMs = 60_000, timeoutMs = 45_000 }) {
    if (!queue || !agents || !handlers || typeof verifier !== "function" ||
        typeof resolveAgent !== "function" || typeof authorizeAction !== "function") {
      throw new Error("worker dependencies incomplete");
    }
    if (!Number.isInteger(leaseMs) || leaseMs < 1000 ||
        !Number.isInteger(timeoutMs) || timeoutMs < 1) {
      throw new Error("invalid worker lease or timeout");
    }
    this.queue=queue; this.agents=agents; this.handlers=handlers; this.verifier=verifier;
    this.audit=audit; this.resolveAgent=resolveAgent; this.authorizeAction=authorizeAction;
    if (requestApproval !== null && typeof requestApproval !== "function") throw new Error("requestApproval must be a function");
    this.requestApproval=requestApproval;
    this.leaseMs=leaseMs; this.timeoutMs=timeoutMs;
  }
  async runOnce() {
    const task=await this.queue.claim({leaseMs:this.leaseMs});
    if (!task) return {worked:false};
    const agentId=this.resolveAgent(task);
    if (!agentId || !this.agents.acquire(agentId)) {
      await this.queue.retry(task.taskId,new Error("no eligible agent capacity"));
      return {worked:true,taskId:task.taskId,status:"requeued"};
    }
    const controller=new AbortController();
    let onAbort;
    const timeout = new Promise((_, reject) => {
      onAbort = () => reject(controller.signal.reason ?? new Error("task execution timed out"));
      controller.signal.addEventListener("abort", onAbort, { once: true });
    });
    const timer=setTimeout(() => controller.abort(new Error("task execution timed out")),this.timeoutMs);
    // Keep the durable lease alive while a handler or verifier is still working.
    // A failed renewal aborts this attempt so another worker can safely recover it.
    const heartbeatMs=Math.max(250,Math.floor(this.leaseMs/3));
    const heartbeat=setInterval(() => {
      this.queue.extendLease(task.taskId,this.leaseMs).catch(error => {
        if(!controller.signal.aborted) controller.abort(new Error("task lease lost: "+String(error?.message??error)));
      });
    },heartbeatMs);
    try {
      const action=task.payload?.action ?? task.action ?? task.type;
      const allowed=await Promise.race([this.authorizeAction({task:structuredClone(task),agentId,action}),timeout]);
      if (requireHumanApproval(action) && allowed !== true) {
        const request=this.requestApproval ? await Promise.race([this.requestApproval({task:structuredClone(task),agentId,action}),timeout]) : null;
        const approvalId=request?.approvalId ?? request?.approval_id ?? null;
        const payload=approvalId ? {...task.payload,approvalId} : task.payload;
        await this.queue.transition(task.taskId,"waiting_approval",{leaseUntil:null,payload});
        await this.audit({event:"task.waiting_approval",taskId:task.taskId,actorId:agentId,action,approvalId});
        return {worked:true,taskId:task.taskId,status:"waiting_approval"};
      }
      if (allowed !== true) throw new Error("task action authorization denied");
      const handler=this.handlers[task.type];
      if(typeof handler!=="function") throw new Error("no handler registered for task type: "+task.type);
      await this.audit({event:"task.started",taskId:task.taskId,actorId:agentId,attempt:task.attempts});
      const execution=(async()=>{
        const result=await handler({task:structuredClone(task),signal:controller.signal,agentId,
          idempotencyKey:task.idempotencyKey ?? task.taskId});
        if(controller.signal.aborted) throw controller.signal.reason ?? new Error("task aborted");
        const verdict=await this.verifier({task:structuredClone(task),result:structuredClone(result),
          agentId,signal:controller.signal});
        if (!verdict || verdict.verified!==true) {
          const error=new Error("independent verification rejected task result");
          error.verification=verdict ?? null;
          throw error;
        }
        return {result,verdict};
      })();
      const {result,verdict}=await Promise.race([execution,timeout]);
      if(controller.signal.aborted) throw controller.signal.reason ?? new Error("task aborted");
      await this.queue.transition(task.taskId,"completed",{result:structuredClone(result),
        verification:structuredClone(verdict),leaseUntil:null});
      await this.audit({event:"task.verified",taskId:task.taskId,actorId:agentId,verification:verdict});
      return {worked:true,taskId:task.taskId,status:"completed",result,verification:verdict};
    } catch(error) {
      await this.audit({event:"task.execution_failed",taskId:task.taskId,actorId:agentId,error:String(error?.message??error)});
      const updated=await this.queue.retry(task.taskId,error);
      return {worked:true,taskId:task.taskId,status:updated.status,error:String(error?.message??error)};
    } finally {
      clearTimeout(timer);
      clearInterval(heartbeat);
      controller.signal.removeEventListener("abort",onAbort);
      this.agents.release(agentId);
    }
  }
}
