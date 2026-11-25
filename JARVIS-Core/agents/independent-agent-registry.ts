import { randomUUID } from "node:crypto";
export type Capability = "read:opportunities" | "read:status" | "write:reports";
export interface RegisteredAgent { id: string; name: string; capabilities: Capability[]; enabled: boolean; createdAt: string }
export class IndependentAgentRegistry {
  private agents = new Map<string, RegisteredAgent>();
  register(name: string, capabilities: Capability[]): RegisteredAgent {
    if (!name.trim()) throw new Error("Agent name required");
    const allowed = new Set<Capability>(["read:opportunities","read:status","write:reports"]);
    if (capabilities.some(c => !allowed.has(c))) throw new Error("Unknown capability");
    const agent: RegisteredAgent = { id: randomUUID(), name: name.trim(), capabilities: [...new Set(capabilities)], enabled: false, createdAt: new Date().toISOString() };
    this.agents.set(agent.id, agent);
    return { ...agent, capabilities: [...agent.capabilities] };
  }
  enable(id: string, approvedByHuman: boolean): boolean {
    if (!approvedByHuman) throw new Error("Human approval required");
    const agent = this.agents.get(id);
    if (!agent) return false;
    agent.enabled = true;
    return true;
  }
  revoke(id: string): boolean { return this.agents.delete(id); }
  can(id: string, capability: Capability): boolean {
    const agent = this.agents.get(id);
    return !!agent?.enabled && agent.capabilities.includes(capability);
  }
  list(): RegisteredAgent[] { return [...this.agents.values()].map(a => ({...a, capabilities:[...a.capabilities]})); }
}
