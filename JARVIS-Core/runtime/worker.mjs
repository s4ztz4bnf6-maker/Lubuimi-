/**
 * Minimal autonomous worker loop. Host supplies durable queue, agents, handlers,
 * verifier and audit adapters. Handler output is never trusted until verified.
 */
export class RuntimeWorker {
  constructor({ queue, agents, handlers, verifier, audit = async () => {}, resolveAgent,
    leaseMs = 60_000, timeoutMs = 45_000 }) {
    if (!queue || !agents || !handlers || typeof verifier !== "function" ||
        typeof resolveAgent !== "function") throw new Error("worker dependencies incomplete");
    this.queue=queue; this.agents=agents; this.handlers=handlers; this.verifier=verifier;
    this.audit=audit; this.resolveAgent=resolveAgent; this.leaseMs=leaseMs; this.timeoutMs=timeoutMs;
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
    const timer=setTimeout(()=>controller.abort(new Error("task execution timed out")),this.timeoutMs);
    try {
      const handler=this.handlers[task.type];
      if(typeof handler!=="function") throw new Error("no handler registered for task type: "+task.type);
      await this.audit({event:"task.started",taskId:task.taskId,actorId:agentId,attempt:task.attempts});
      const result=await handler({task:structuredClone(task),signal:controller.signal,agentId});
      if(controller.signal.aborted) throw controller.signal.reason ?? new Error("task aborted");
      const verdict=await this.verifier({task:structuredClone(task),result:structuredClone(result),agentId});
      if(!verdict || verdict.verified!==true) {
        const error=new Error("independent verification rejected task result");
        error.verification=verdict ?? null;
        throw error;
      }
      await this.queue.transition(task.taskId,"completed",{result:structuredClone(result),verification:structuredClone(verdict),leaseUntil:null});
      await this.audit({event:"task.verified",taskId:task.taskId,actorId:agentId,verification:verdict});
      return {worked:true,taskId:task.taskId,status:"completed",result,verification:verdict};
    } catch(error) {
      await this.audit({event:"task.execution_failed",taskId:task.taskId,actorId:agentId,error:String(error?.message??error)});
      const updated=await this.queue.retry(task.taskId,error);
      return {worked:true,taskId:task.taskId,status:updated.status,error:String(error?.message??error)};
    } finally {
      clearTimeout(timer);
      this.agents.release(agentId);
    }
  }
}
